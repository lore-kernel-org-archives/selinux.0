Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t2O8FiOh012789
 for <selinux@tycho.nsa.gov>; Tue, 24 Mar 2015 04:15:44 -0400
Received: by pdbni2 with SMTP id ni2so214201986pdb.1
 for <selinux@tycho.nsa.gov>; Tue, 24 Mar 2015 01:15:41 -0700 (PDT)
From: Jason Zaman <jason@perfinion.com>
To: selinux@tycho.nsa.gov, bigon@bigon.be
Subject: [PATCH v2] run_init: Use a ring buffer in open_init_pty
Date: Tue, 24 Mar 2015 16:15:29 +0800
Message-Id: <1427184929-31114-1-git-send-email-jason@perfinion.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

open_init_pty uses select() to handle all the file descriptors. There is
a very high CPU usage due to select() always returning immediately with
the fd is available for write. This uses a ring buffer and only calls
select on the read/write fds that have data that needs to be
read/written which eliminates the high CPU usage.

This also correctly returns the exit code from the child process.

This was originally from debian where they have been carrying it as a
patch for a long time. Then we got a bug report in gentoo which this
also happens to fix. The original debian patch had the ring buffer
written in C++ so I modified the class into a struct and some static
methods so it is C-only at the request of Steve Lawrence.

Debian bug: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=474956
Gentoo bug: https://bugs.gentoo.org/show_bug.cgi?id=532616

Signed-off-by: Jason Zaman <jason@perfinion.com>
Tested-by: Laurent Bigonville <bigon@bigon.be>
---
 policycoreutils/run_init/open_init_pty.c | 511 ++++++++++++++++---------------
 1 file changed, 265 insertions(+), 246 deletions(-)

diff --git a/policycoreutils/run_init/open_init_pty.c b/policycoreutils/run_init/open_init_pty.c
index 4f04e72..37805bf 100644
--- a/policycoreutils/run_init/open_init_pty.c
+++ b/policycoreutils/run_init/open_init_pty.c
@@ -28,18 +28,23 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <unistd.h>
 #include <signal.h>
 #include <errno.h>
 
 #include <sysexits.h>
 
-#include <pty.h>		/* for openpty and forkpty */
-#include <utmp.h>		/* for login_tty */
+#include <pty.h>		/* for forkpty */
 #include <termios.h>
 #include <fcntl.h>
 
 #include <sys/select.h>
+#include <sys/wait.h>
+
+
+#define MAXRETR 3		/* The max number of IO retries on a fd */
+#define BUFSIZE 2048		/* The ring buffer size */
 
 static struct termios saved_termios;
 static int saved_fd = -1;
@@ -83,7 +88,7 @@ static int tty_semi_raw(int fd)
 	return 0;
 }
 
-void tty_atexit(void)
+static void tty_atexit(void)
 {
 	if (tty_state != CBREAK && tty_state != RAW) {
 		return;
@@ -91,309 +96,323 @@ void tty_atexit(void)
 
 	if (tcsetattr(saved_fd, TCSANOW, &saved_termios) < 0) {
 		return;
-	}			/* end of if(tcsetattr(fileno(stdin), TCSANOW, &buf) < 0) */
+	}
 	tty_state = RESET;
 	return;
 }
 
+
+/* The simple ring buffer */
+struct ring_buffer {
+	char *buf; /* pointer to buffer memory */
+	char *wptr;
+	char *rptr;
+	size_t size; /* the number of bytes allocated for buf */
+	size_t count;
+};
+
+static void rb_init(struct ring_buffer *b, char *buf, size_t size)
+{
+	b->buf = b->wptr = b->rptr = buf;
+	b->size = size;
+	b->count = 0;
+}
+
+static int rb_isempty(struct ring_buffer *b)
+{
+	return b->count == 0;
+}
+
+/* return the unused space size in the buffer */
+static size_t rb_space(struct ring_buffer *b)
+{
+	if (b->rptr > b->wptr)
+		return b->rptr - b->wptr;
+
+	if (b->rptr < b->wptr || b->count == 0)
+		return b->buf + b->size - b->wptr;
+
+	return 0; /* should not hit this */
+}
+
+/* return the used space in the buffer */
+static size_t rb_chunk_size(struct ring_buffer *b)
+{
+	if (b->rptr < b->wptr)
+		return b->wptr - b->rptr;
+
+	if (b->rptr > b->wptr || b->count > 0)
+		return b->buf + b->size - b->rptr;
+
+	return 0; /* should not hit this */
+}
+
+/* read from fd and write to buffer memory */
+static ssize_t rb_read(struct ring_buffer *b, int fd)
+{
+	ssize_t n = read(fd, b->wptr, rb_space(b));
+	if (n <= 0)
+		return n;
+
+	b->wptr += n;
+	b->count += n;
+	if (b->buf + b->size <= b->wptr)
+		b->wptr = b->buf;
+
+	return n;
+}
+
+static ssize_t rb_write(struct ring_buffer *b, int fd)
+{
+	ssize_t n = write(fd, b->rptr, rb_chunk_size(b));
+	if (n <= 0)
+		return n;
+
+	b->rptr += n;
+	b->count -= n;
+	if (b->buf + b->size <= b->rptr)
+		b->rptr = b->buf;
+
+	return n;
+}
+
+static void setfd_nonblock(int fd)
+{
+	int fsflags = fcntl(fd, F_GETFL);
+
+	if (fsflags < 0) {
+		fprintf(stderr, "fcntl(%d, F_GETFL): %s\n", fd, strerror(errno));
+		exit(EX_IOERR);
+	}
+
+	if (fcntl(fd, F_SETFL, fsflags | O_NONBLOCK) < 0) {
+		fprintf(stderr, "fcntl(%d, F_SETFL, ... | O_NONBLOCK): %s\n", fd, strerror(errno));
+		exit(EX_IOERR);
+	}
+}
+
+static void sigchld_handler(int asig __attribute__ ((unused)))
+{
+}
+
 int main(int argc, char *argv[])
 {
 	pid_t child_pid;
+	int child_exit_status;
 	struct termios tty_attr;
 	struct winsize window_size;
 	int pty_master;
-	int retval = 0;
 
 	/* for select */
 	fd_set readfds;
 	fd_set writefds;
-	fd_set exceptfds;
 
-	int err_count = 0;
+	unsigned err_n_rpty = 0;
+	unsigned err_n_wpty = 0;
+	unsigned err_n_stdin = 0;
+	unsigned err_n_stdout = 0;
+
+	int done = 0;
 
-	/* for sigtimedwait() */
-	struct timespec timeout;
-	char buf[16384];
+	/* the ring buffers */
+	char inbuf_mem[BUFSIZE];
+	char outbuf_mem[BUFSIZE];
+	struct ring_buffer inbuf;
+	struct ring_buffer outbuf;
+	rb_init(&inbuf, inbuf_mem, sizeof(inbuf_mem));
+	rb_init(&outbuf, outbuf_mem, sizeof(outbuf_mem));
 
 	if (argc == 1) {
 		printf("usage: %s PROGRAM [ARGS]...\n", argv[0]);
 		exit(1);
 	}
 
-	sigset_t signal_set;
-	siginfo_t signalinfo;
-
-	/* set up SIGCHLD */
-	sigemptyset(&signal_set);	/* no signals */
-	sigaddset(&signal_set, SIGCHLD);	/* Add sig child  */
-	sigprocmask(SIG_BLOCK, &signal_set, NULL);	/* Block the signal */
-
-	/* Set both to 0, so sigtimed wait just does a poll */
-	timeout.tv_sec = 0;
-	timeout.tv_nsec = 0;
+	/* We need I/O calls to fail with EINTR on SIGCHLD... */
+	if (signal(SIGCHLD, sigchld_handler) == SIG_ERR) {
+		perror("signal(SIGCHLD,...)");
+		exit(EX_OSERR);
+	}
 
-	if (isatty(fileno(stdin))) {
+	if (isatty(STDIN_FILENO)) {
 		/* get terminal parameters associated with stdout */
-		if (tcgetattr(fileno(stdout), &tty_attr) < 0) {
-			perror("tcgetattr:");
+		if (tcgetattr(STDOUT_FILENO, &tty_attr) < 0) {
+			perror("tcgetattr(stdout,...)");
 			exit(EX_OSERR);
 		}
 
-		/* end of if(tcsetattr(&tty_attr)) */
 		/* get window size */
-		if (ioctl(fileno(stdout), TIOCGWINSZ, &window_size) < 0) {
-			perror("ioctl stdout:");
+		if (ioctl(STDOUT_FILENO, TIOCGWINSZ, &window_size) < 0) {
+			perror("ioctl(stdout,...)");
 			exit(1);
 		}
 
 		child_pid = forkpty(&pty_master, NULL, &tty_attr, &window_size);
-	} /* end of if(isatty(fileno(stdin))) */
-	else {			/* not interactive */
+	} else { /* not interactive */
 		child_pid = forkpty(&pty_master, NULL, NULL, NULL);
 	}
 
 	if (child_pid < 0) {
-		perror("forkpty():");
-		fflush(stdout);
-		fflush(stderr);
+		perror("forkpty()");
 		exit(EX_OSERR);
-	}			/* end of if(child_pid < 0) */
-	if (child_pid == 0) {
-		/* in the child */
+	}
+	if (child_pid == 0) { /* in the child */
 		struct termios s_tty_attr;
-		if (tcgetattr(fileno(stdin), &s_tty_attr)) {
-			perror("Child:");
-			fflush(stdout);
-			fflush(stderr);
+		if (tcgetattr(STDIN_FILENO, &s_tty_attr)) {
+			perror("tcgetattr(stdin,...)");
 			exit(EXIT_FAILURE);
 		}
 		/* Turn off echo */
 		s_tty_attr.c_lflag &= ~(ECHO | ECHOE | ECHOK | ECHONL);
 		/* Also turn of NL to CR?LF on output */
 		s_tty_attr.c_oflag &= ~(ONLCR);
-		if (tcsetattr(fileno(stdin), TCSANOW, &s_tty_attr)) {
-			perror("Child:");
+		if (tcsetattr(STDIN_FILENO, TCSANOW, &s_tty_attr)) {
+			perror("tcsetattr(stdin,...)");
 			exit(EXIT_FAILURE);
 		}
-		{		/* There is no reason to block sigchild for the process we
-				   shall exec here */
-			sigset_t chld_signal_set;
-			/* release SIGCHLD */
-			sigemptyset(&chld_signal_set);	/* no signals */
-			sigaddset(&chld_signal_set, SIGCHLD);	/* Add sig child  */
-			sigprocmask(SIG_UNBLOCK, &chld_signal_set, NULL);	/* Unblock the signal */
-		}
 
 		if (execvp(argv[1], argv + 1)) {
-			perror("Exec:");
-			fflush(stdout);
-			fflush(stderr);
+			perror("execvp()");
 			exit(EXIT_FAILURE);
 		}
 	}
 
-	/* end of if(child_pid == 0) */
-	/* 
-	 * OK. Prepare to handle IO from the child. We need to transfer
-	 * everything from the child's stdout to ours.
-	 */
-	FD_ZERO(&readfds);
-	FD_ZERO(&writefds);
-	FD_ZERO(&exceptfds);
+	/* Non blocking mode for all file descriptors. */
+	setfd_nonblock(pty_master);
+	setfd_nonblock(STDIN_FILENO);
+	setfd_nonblock(STDOUT_FILENO);
 
-	/*
-	 * Read current file descriptor flags, preparing to do non blocking reads
-	 */
-	retval = fcntl(pty_master, F_GETFL);
-	if (retval < 0) {
-		perror("fcntl_get");
-		fflush(stdout);
-		fflush(stderr);
-		exit(EX_IOERR);
+	if (isatty(STDIN_FILENO)) {
+		if (tty_semi_raw(STDIN_FILENO) < 0) {
+			perror("tty_semi_raw(stdin)");
+		}
+		if (atexit(tty_atexit) < 0) {
+			perror("atexit()");
+		}
 	}
 
-	/* Set the connection to be non-blocking */
-	if (fcntl(pty_master, F_SETFL, retval | O_NONBLOCK) < 0) {
-		perror("fcnt_setFlag_nonblock:");
-		fflush(stdout);
-		fflush(stderr);
-		exit(1);
-	}
+	do {
+		/* Accept events only on fds, that we can handle now. */
+		int do_select = 0;
+		FD_ZERO(&readfds);
+		FD_ZERO(&writefds);
 
-	FD_SET(pty_master, &readfds);
-	FD_SET(pty_master, &writefds);
-	FD_SET(fileno(stdin), &readfds);
-	if (isatty(fileno(stdin))) {
-		if (tty_semi_raw(fileno(stdin)) < 0) {
-			perror("Error: settingraw mode:");
-			fflush(stdout);
-			fflush(stderr);
-		}		/* end of if(tty_raw(fileno(stdin)) < 0) */
-		if (atexit(tty_atexit) < 0) {
-			perror("Atexit setup:");
-			fflush(stdout);
-			fflush(stderr);
-		}		/* end of if(atexit(tty_atexit) < 0) */
-	}
+		if (rb_space(&outbuf) > 0 && err_n_rpty < MAXRETR) {
+			FD_SET(pty_master, &readfds);
+			do_select = 1;
+		}
 
-	/* ignore return from nice, but lower our priority */
-	int ignore __attribute__ ((unused)) = nice(19);
+		if (!rb_isempty(&inbuf) && err_n_wpty < MAXRETR) {
+			FD_SET(pty_master, &writefds);
+			do_select = 1;
+		}
 
-	/* while no signal, we loop around */
-	int done = 0;
-	while (!done) {
-		struct timeval interval;
-		fd_set t_readfds;
-		fd_set t_writefds;
-		fd_set t_exceptfds;
-		/*
-		 * We still use a blocked signal, and check for SIGCHLD every
-		 * loop, since waiting infinitely did not really help the load
-		 * when running, say, top. 
-		 */
-		interval.tv_sec = 0;
-		interval.tv_usec = 200000;	/* so, check for signals every 200 milli
-						   seconds */
-
-		t_readfds = readfds;
-		t_writefds = writefds;
-		t_exceptfds = exceptfds;
-
-		/* check for the signal */
-		retval = sigtimedwait(&signal_set, &signalinfo, &timeout);
-
-		if (retval == SIGCHLD) {
-			/* child terminated */
-			done = 1;	/* in case they do not close off their
-					   file descriptors */
-		} else {
-			if (retval < 0) {
-				if (errno != EAGAIN) {
-					perror("sigtimedwait");
-					fflush(stdout);
-					fflush(stderr);
-					exit(EX_IOERR);
-				} else {
-					/* No signal in set was delivered within the timeout period specified */
-				}
+		if (rb_space(&inbuf) > 0 && err_n_stdin < MAXRETR) {
+			FD_SET(STDIN_FILENO, &readfds);
+			do_select = 1;
+		}
+
+		if (!rb_isempty(&outbuf) && err_n_stdout < MAXRETR) {
+			FD_SET(STDOUT_FILENO, &writefds);
+			do_select = 1;
+		}
+
+		if (!do_select) {
+#ifdef DEBUG
+			fprintf(stderr, "No I/O job for us, calling waitpid()...\n");
+#endif
+			while (waitpid(child_pid, &child_exit_status, 0) < 0)
+			{
+				/* nothing */
 			}
-		}		/* end of else */
-
-		if (select
-		    (pty_master + 1, &t_readfds, &t_writefds, &t_exceptfds,
-		     &interval) < 0) {
-			perror("Select:");
-			fflush(stdout);
-			fflush(stderr);
+			break;
+		}
+
+		int select_rc = select(pty_master + 1, &readfds, &writefds, NULL, NULL);
+		if (select_rc < 0) {
+			perror("select()");
 			exit(EX_IOERR);
 		}
+#ifdef DEBUG
+		fprintf(stderr, "select() returned %d\n", select_rc);
+#endif
+
+		if (FD_ISSET(STDOUT_FILENO, &writefds)) {
+#ifdef DEBUG
+			fprintf(stderr, "stdout can be written\n");
+#endif
+			ssize_t n = rb_write(&outbuf, STDOUT_FILENO);
+			if (n <= 0 && n != EINTR && n != EAGAIN)
+				err_n_stdout++;
+#ifdef DEBUG
+			if (n >= 0)
+				fprintf(stderr, "%d bytes written into stdout\n", n);
+			else
+				perror("write(stdout,...)");
+#endif
+		}
 
-		if (FD_ISSET(pty_master, &t_readfds)) {
-			retval = read(pty_master, buf, (unsigned int)16384);
-			if (retval < 0) {
-				if (errno != EINTR && errno != EAGAIN) {	/* Nothing left to read?  */
-					fflush(stdout);
-					fflush(stderr);
-					/* fprintf(stderr, "DEBUG: %d: Nothing left to read?\n", __LINE__); */
-					exit(EXIT_SUCCESS);
-				}	/* end of else */
-			} /* end of if(retval < 0) */
-			else {
-				if (retval == 0) {
-					if (++err_count > 5) {	/* child closed connection */
-						fflush(stdout);
-						fflush(stderr);
-						/*fprintf(stderr, "DEBUG: %d: child closed connection?\n", __LINE__); */
-						exit(EXIT_SUCCESS);
-					}
-				} /* end of if(retval == 0) */
-				else {
-					ssize_t nleft = retval;
-					ssize_t nwritten = 0;
-					char *ptr = buf;
-					while (nleft > 0) {
-						if ((nwritten =
-						     write(fileno(stdout), ptr,
-							   (unsigned int)nleft))
-						    <= 0) {
-							if (errno == EINTR) {
-								nwritten = 0;
-							} /* end of if(errno == EINTR) */
-							else {
-								perror("write");
-								fflush(stdout);
-								fflush(stderr);
-								exit(EXIT_SUCCESS);
-							}	/* end of else */
-						}	/* end of if((nwritten = write(sockfd, ptr, nleft)) <= 0) */
-						nleft -= nwritten;
-						ptr += nwritten;
-					}	/* end of while(nleft > 0) */
-
-					/* fprintf(stderr, "DEBUG: %d: wrote %d\n", __LINE__, retval); */
-					fflush(stdout);
-				}	/* end of else */
-			}	/* end of else */
+		if (FD_ISSET(pty_master, &writefds)) {
+#ifdef DEBUG
+			fprintf(stderr, "pty_master can be written\n");
+#endif
+			ssize_t n = rb_write(&inbuf, pty_master);
+			if (n <= 0 && n != EINTR && n != EAGAIN)
+				err_n_wpty++;
+#ifdef DEBUG
+			if (n >= 0)
+				fprintf(stderr, "%d bytes written into pty_master\n", n);
+			else
+				perror("write(pty_master,...)");
+#endif
 		}
-		if (FD_ISSET(fileno(stdin), &t_readfds)) {
-			if (FD_ISSET(pty_master, &t_writefds)) {
-				retval =
-				    read(fileno(stdin), buf,
-					 (unsigned int)16384);
-				if (retval < 0) {
-					if (errno != EINTR && errno != EAGAIN) {	/* Nothing left to read?  */
-						fflush(stdout);
-						fflush(stderr);
-						exit(EXIT_SUCCESS);
-					}	/* end of else */
-				} /* end of if(retval < 0) */
-				else {
-					if (retval == 0) {
-						if (++err_count > 5) {	/* lost controlling tty */
-							fflush(stdout);
-							fflush(stderr);
-							exit(EXIT_SUCCESS);
-						}
-					} /* end of if(retval == 0) */
-					else {
-						ssize_t nleft = retval;
-						ssize_t nwritten = 0;
-						char *ptr = buf;
-						while (nleft > 0) {
-							if ((nwritten =
-							     write(pty_master,
-								   ptr,
-								   (unsigned
-								    int)nleft))
-							    <= 0) {
-								if (errno ==
-								    EINTR) {
-									nwritten
-									    = 0;
-								} /* end of if(errno == EINTR) */
-								else {
-									perror
-									    ("write");
-									fflush
-									    (stdout);
-									fflush
-									    (stderr);
-									exit(EXIT_SUCCESS);
-								}	/* end of else */
-							}	/* end of if((nwritten = write(sockfd, ptr, nleft)) <= 0) */
-							nleft -= nwritten;
-							ptr += nwritten;
-						}	/* end of while(nleft > 0) */
-
-						fflush(stdout);
-					}	/* end of else */
-				}	/* end of else */
-			}	/* end of if(FD_ISSET(pty_master, &writefds)) */
-		}		/* something to read on stdin */
-	}			/* Loop */
-
-	fflush(stdout);
-	fflush(stderr);
-
-	exit(EXIT_SUCCESS);
-}				/* end of main() */
+
+		if (FD_ISSET(STDIN_FILENO, &readfds)) {
+#ifdef DEBUG
+			fprintf(stderr, "stdin can be read\n");
+#endif
+			ssize_t n = rb_read(&inbuf, STDIN_FILENO);
+			if (n <= 0 && n != EINTR && n != EAGAIN)
+				err_n_stdin++;
+#ifdef DEBUG
+			if (n >= 0)
+				fprintf(stderr, "%d bytes read from stdin\n", n);
+			else
+				perror("read(stdin,...)");
+#endif
+		}
+
+		if (FD_ISSET(pty_master, &readfds)) {
+#ifdef DEBUG
+			fprintf(stderr, "pty_master can be read\n");
+#endif
+			ssize_t n = rb_read(&outbuf, pty_master);
+			if (n <= 0 && n != EINTR && n != EAGAIN)
+				err_n_rpty++;
+#ifdef DEBUG
+			if (n >= 0)
+				fprintf(stderr, "%d bytes read from pty_master\n", n);
+			else
+				perror("read(pty_master,...)");
+#endif
+		}
+
+		if (!done && waitpid(child_pid, &child_exit_status, WNOHANG) > 0)
+			done = 1;
+
+	} while (!done
+		|| !(rb_isempty(&inbuf) || err_n_wpty >= MAXRETR)
+		|| !(rb_isempty(&outbuf) || err_n_stdout >= MAXRETR));
+
+#ifdef DEBUG
+	fprintf(stderr, "inbuf: %u bytes left, outbuf: %u bytes left\n", inbuf.count, outbuf.count);
+	fprintf(stderr, "err_n_rpty=%u, err_n_wpty=%u, err_n_stdin=%u, err_n_stdout=%u\n",
+		err_n_rpty, err_n_wpty, err_n_stdin, err_n_stdout);
+#endif
+
+	if (WIFEXITED(child_exit_status))
+		exit(WEXITSTATUS(child_exit_status));
+	else if (WIFSIGNALED(child_exit_status))
+		exit(128 + WTERMSIG(child_exit_status));
+
+	exit(EXIT_FAILURE);
+}
-- 
2.0.5
