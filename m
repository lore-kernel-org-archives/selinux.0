Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q91KU1sw032003
	for <selinux@tycho.nsa.gov>; Mon, 1 Oct 2012 16:30:01 -0400
Received: by mail-wi0-f171.google.com with SMTP id hj13so2661102wib.12
        for <selinux@tycho.nsa.gov>; Mon, 01 Oct 2012 13:29:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1349109117-593-5-git-send-email-bigon@debian.org>
References: <1349109117-593-1-git-send-email-bigon@debian.org>
	<1349109117-593-5-git-send-email-bigon@debian.org>
Date: Mon, 1 Oct 2012 16:29:46 -0400
Message-ID: <CACLa4psUxc-8crv8WgCJZs8gv6raPm=MaQw4Dgj0z9urnzbN1Q@mail.gmail.com>
Subject: Re: [PATCH 04/15] policycoreutils: Add new open_init_pty that doesn't
 waste CPU time
From: Eric Paris <eparis@parisplace.org>
To: Laurent Bigonville <bigon@debian.org>
Cc: selinux@tycho.nsa.gov, Russell Coker <russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell, can you review and sign off on this patch?  If it matches
your expectations I'll push it to the upstream policycoreutils.

-Eric

On Mon, Oct 1, 2012 at 12:31 PM, Laurent Bigonville <bigon@debian.org> wrote:
> From: Russell Coker <russell@coker.com.au>
>
> ---
>  policycoreutils/run_init/Makefile          |    7 +-
>  policycoreutils/run_init/open_init_pty.c   |  399 --------------------------
>  policycoreutils/run_init/open_init_pty.cpp |  423 ++++++++++++++++++++++++++++
>  3 files changed, 427 insertions(+), 402 deletions(-)
>  delete mode 100644 policycoreutils/run_init/open_init_pty.c
>  create mode 100644 policycoreutils/run_init/open_init_pty.cpp
>
> diff --git a/policycoreutils/run_init/Makefile b/policycoreutils/run_init/Makefile
> index 5815a08..e3c6e9d 100644
> --- a/policycoreutils/run_init/Makefile
> +++ b/policycoreutils/run_init/Makefile
> @@ -10,6 +10,7 @@ AUDITH = $(shell ls /usr/include/libaudit.h 2>/dev/null)
>
>  CFLAGS ?= -Werror -Wall -W
>  override CFLAGS += -I$(PREFIX)/include -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
> +CPPFLAGS ?= $(CFLAGS)
>  LDLIBS += -lselinux -L$(PREFIX)/lib
>  ifeq ($(PAMH), /usr/include/security/pam_appl.h)
>         override CFLAGS += -DUSE_PAM
> @@ -23,12 +24,12 @@ ifeq ($(AUDITH), /usr/include/libaudit.h)
>         LDLIBS += -laudit
>  endif
>
> -TARGETS=$(patsubst %.c,%,$(wildcard *.c))
> +TARGETS=open_init_pty run_init
>
>  all: $(TARGETS)
>
> -open_init_pty: open_init_pty.c
> -       $(LINK.c) $^ -ldl -lutil -o $@
> +open_init_pty: open_init_pty.cpp
> +       $(LINK.cpp) $^ -ldl -lutil -o $@
>
>
>  install: all
> diff --git a/policycoreutils/run_init/open_init_pty.c b/policycoreutils/run_init/open_init_pty.c
> deleted file mode 100644
> index 4f04e72..0000000
> --- a/policycoreutils/run_init/open_init_pty.c
> +++ /dev/null
> @@ -1,399 +0,0 @@
> -/*                               -*- Mode: C -*-
> - * open_init_pty.c ---
> - * Author           : Manoj Srivastava ( srivasta@glaurung.internal.golden-gryphon.com )
> - * Created On       : Fri Jan 14 10:48:28 2005
> - * Created On Node  : glaurung.internal.golden-gryphon.com
> - * Last Modified By : Manoj Srivastava
> - * Last Modified On : Thu Sep 15 00:57:00 2005
> - * Last Machine Used: glaurung.internal.golden-gryphon.com
> - * Update Count     : 92
> - * Status           : Unknown, Use with caution!
> - * HISTORY          :
> - * Description      :
> - *
> - * Distributed under the terms of the GNU General Public License v2
> - *
> - * open_init_pty
> - *
> - * SYNOPSIS:
> - *
> - * This program allows a systems administrator to execute daemons
> - * which need to work in the initrc domain, and which need to have
> - * pty's as system_u:system_r:initrc_t
> - *
> - * USAGE:
> - *
> - * * arch-tag: a5583d39-72b9-4cdf-ba1b-5678ea4cbe20
> - */
> -
> -#include <stdio.h>
> -#include <stdlib.h>
> -#include <unistd.h>
> -#include <signal.h>
> -#include <errno.h>
> -
> -#include <sysexits.h>
> -
> -#include <pty.h>               /* for openpty and forkpty */
> -#include <utmp.h>              /* for login_tty */
> -#include <termios.h>
> -#include <fcntl.h>
> -
> -#include <sys/select.h>
> -
> -static struct termios saved_termios;
> -static int saved_fd = -1;
> -static enum { RESET, RAW, CBREAK } tty_state = RESET;
> -
> -static int tty_semi_raw(int fd)
> -{
> -       struct termios buf;
> -
> -       if (tty_state == RESET) {
> -               if (tcgetattr(fd, &saved_termios) < 0) {
> -                       return -1;
> -               }
> -       }
> -
> -       buf = saved_termios;
> -       /*
> -        * echo off, canonical mode off, extended input processing off,
> -        * signal chars off
> -        */
> -       buf.c_lflag &= ~(ECHO | ICANON | IEXTEN | ISIG);
> -       /*
> -        * no SIGINT on break, CR-to-NL off, input parity check off, do not
> -        * strip 8th bit on input,output flow control off
> -        */
> -       buf.c_iflag &= ~(BRKINT | ICRNL | INPCK | ISTRIP | IXON);
> -       /* Clear size bits, parity checking off */
> -       buf.c_cflag &= ~(CSIZE | PARENB);
> -       /* set 8 bits/char */
> -       buf.c_cflag |= CS8;
> -       /* Output processing off
> -          buf.c_oflag    &= ~(OPOST); */
> -
> -       buf.c_cc[VMIN] = 1;     /* one byte at a time, no timer */
> -       buf.c_cc[VTIME] = 0;
> -       if (tcsetattr(fd, TCSANOW, &buf) < 0) {
> -               return -1;
> -       }                       /* end of if(tcsetattr(fileno(stdin), TCSANOW, &buf) < 0) */
> -       tty_state = RAW;
> -       saved_fd = fd;
> -       return 0;
> -}
> -
> -void tty_atexit(void)
> -{
> -       if (tty_state != CBREAK && tty_state != RAW) {
> -               return;
> -       }
> -
> -       if (tcsetattr(saved_fd, TCSANOW, &saved_termios) < 0) {
> -               return;
> -       }                       /* end of if(tcsetattr(fileno(stdin), TCSANOW, &buf) < 0) */
> -       tty_state = RESET;
> -       return;
> -}
> -
> -int main(int argc, char *argv[])
> -{
> -       pid_t child_pid;
> -       struct termios tty_attr;
> -       struct winsize window_size;
> -       int pty_master;
> -       int retval = 0;
> -
> -       /* for select */
> -       fd_set readfds;
> -       fd_set writefds;
> -       fd_set exceptfds;
> -
> -       int err_count = 0;
> -
> -       /* for sigtimedwait() */
> -       struct timespec timeout;
> -       char buf[16384];
> -
> -       if (argc == 1) {
> -               printf("usage: %s PROGRAM [ARGS]...\n", argv[0]);
> -               exit(1);
> -       }
> -
> -       sigset_t signal_set;
> -       siginfo_t signalinfo;
> -
> -       /* set up SIGCHLD */
> -       sigemptyset(&signal_set);       /* no signals */
> -       sigaddset(&signal_set, SIGCHLD);        /* Add sig child  */
> -       sigprocmask(SIG_BLOCK, &signal_set, NULL);      /* Block the signal */
> -
> -       /* Set both to 0, so sigtimed wait just does a poll */
> -       timeout.tv_sec = 0;
> -       timeout.tv_nsec = 0;
> -
> -       if (isatty(fileno(stdin))) {
> -               /* get terminal parameters associated with stdout */
> -               if (tcgetattr(fileno(stdout), &tty_attr) < 0) {
> -                       perror("tcgetattr:");
> -                       exit(EX_OSERR);
> -               }
> -
> -               /* end of if(tcsetattr(&tty_attr)) */
> -               /* get window size */
> -               if (ioctl(fileno(stdout), TIOCGWINSZ, &window_size) < 0) {
> -                       perror("ioctl stdout:");
> -                       exit(1);
> -               }
> -
> -               child_pid = forkpty(&pty_master, NULL, &tty_attr, &window_size);
> -       } /* end of if(isatty(fileno(stdin))) */
> -       else {                  /* not interactive */
> -               child_pid = forkpty(&pty_master, NULL, NULL, NULL);
> -       }
> -
> -       if (child_pid < 0) {
> -               perror("forkpty():");
> -               fflush(stdout);
> -               fflush(stderr);
> -               exit(EX_OSERR);
> -       }                       /* end of if(child_pid < 0) */
> -       if (child_pid == 0) {
> -               /* in the child */
> -               struct termios s_tty_attr;
> -               if (tcgetattr(fileno(stdin), &s_tty_attr)) {
> -                       perror("Child:");
> -                       fflush(stdout);
> -                       fflush(stderr);
> -                       exit(EXIT_FAILURE);
> -               }
> -               /* Turn off echo */
> -               s_tty_attr.c_lflag &= ~(ECHO | ECHOE | ECHOK | ECHONL);
> -               /* Also turn of NL to CR?LF on output */
> -               s_tty_attr.c_oflag &= ~(ONLCR);
> -               if (tcsetattr(fileno(stdin), TCSANOW, &s_tty_attr)) {
> -                       perror("Child:");
> -                       exit(EXIT_FAILURE);
> -               }
> -               {               /* There is no reason to block sigchild for the process we
> -                                  shall exec here */
> -                       sigset_t chld_signal_set;
> -                       /* release SIGCHLD */
> -                       sigemptyset(&chld_signal_set);  /* no signals */
> -                       sigaddset(&chld_signal_set, SIGCHLD);   /* Add sig child  */
> -                       sigprocmask(SIG_UNBLOCK, &chld_signal_set, NULL);       /* Unblock the signal */
> -               }
> -
> -               if (execvp(argv[1], argv + 1)) {
> -                       perror("Exec:");
> -                       fflush(stdout);
> -                       fflush(stderr);
> -                       exit(EXIT_FAILURE);
> -               }
> -       }
> -
> -       /* end of if(child_pid == 0) */
> -       /*
> -        * OK. Prepare to handle IO from the child. We need to transfer
> -        * everything from the child's stdout to ours.
> -        */
> -       FD_ZERO(&readfds);
> -       FD_ZERO(&writefds);
> -       FD_ZERO(&exceptfds);
> -
> -       /*
> -        * Read current file descriptor flags, preparing to do non blocking reads
> -        */
> -       retval = fcntl(pty_master, F_GETFL);
> -       if (retval < 0) {
> -               perror("fcntl_get");
> -               fflush(stdout);
> -               fflush(stderr);
> -               exit(EX_IOERR);
> -       }
> -
> -       /* Set the connection to be non-blocking */
> -       if (fcntl(pty_master, F_SETFL, retval | O_NONBLOCK) < 0) {
> -               perror("fcnt_setFlag_nonblock:");
> -               fflush(stdout);
> -               fflush(stderr);
> -               exit(1);
> -       }
> -
> -       FD_SET(pty_master, &readfds);
> -       FD_SET(pty_master, &writefds);
> -       FD_SET(fileno(stdin), &readfds);
> -       if (isatty(fileno(stdin))) {
> -               if (tty_semi_raw(fileno(stdin)) < 0) {
> -                       perror("Error: settingraw mode:");
> -                       fflush(stdout);
> -                       fflush(stderr);
> -               }               /* end of if(tty_raw(fileno(stdin)) < 0) */
> -               if (atexit(tty_atexit) < 0) {
> -                       perror("Atexit setup:");
> -                       fflush(stdout);
> -                       fflush(stderr);
> -               }               /* end of if(atexit(tty_atexit) < 0) */
> -       }
> -
> -       /* ignore return from nice, but lower our priority */
> -       int ignore __attribute__ ((unused)) = nice(19);
> -
> -       /* while no signal, we loop around */
> -       int done = 0;
> -       while (!done) {
> -               struct timeval interval;
> -               fd_set t_readfds;
> -               fd_set t_writefds;
> -               fd_set t_exceptfds;
> -               /*
> -                * We still use a blocked signal, and check for SIGCHLD every
> -                * loop, since waiting infinitely did not really help the load
> -                * when running, say, top.
> -                */
> -               interval.tv_sec = 0;
> -               interval.tv_usec = 200000;      /* so, check for signals every 200 milli
> -                                                  seconds */
> -
> -               t_readfds = readfds;
> -               t_writefds = writefds;
> -               t_exceptfds = exceptfds;
> -
> -               /* check for the signal */
> -               retval = sigtimedwait(&signal_set, &signalinfo, &timeout);
> -
> -               if (retval == SIGCHLD) {
> -                       /* child terminated */
> -                       done = 1;       /* in case they do not close off their
> -                                          file descriptors */
> -               } else {
> -                       if (retval < 0) {
> -                               if (errno != EAGAIN) {
> -                                       perror("sigtimedwait");
> -                                       fflush(stdout);
> -                                       fflush(stderr);
> -                                       exit(EX_IOERR);
> -                               } else {
> -                                       /* No signal in set was delivered within the timeout period specified */
> -                               }
> -                       }
> -               }               /* end of else */
> -
> -               if (select
> -                   (pty_master + 1, &t_readfds, &t_writefds, &t_exceptfds,
> -                    &interval) < 0) {
> -                       perror("Select:");
> -                       fflush(stdout);
> -                       fflush(stderr);
> -                       exit(EX_IOERR);
> -               }
> -
> -               if (FD_ISSET(pty_master, &t_readfds)) {
> -                       retval = read(pty_master, buf, (unsigned int)16384);
> -                       if (retval < 0) {
> -                               if (errno != EINTR && errno != EAGAIN) {        /* Nothing left to read?  */
> -                                       fflush(stdout);
> -                                       fflush(stderr);
> -                                       /* fprintf(stderr, "DEBUG: %d: Nothing left to read?\n", __LINE__); */
> -                                       exit(EXIT_SUCCESS);
> -                               }       /* end of else */
> -                       } /* end of if(retval < 0) */
> -                       else {
> -                               if (retval == 0) {
> -                                       if (++err_count > 5) {  /* child closed connection */
> -                                               fflush(stdout);
> -                                               fflush(stderr);
> -                                               /*fprintf(stderr, "DEBUG: %d: child closed connection?\n", __LINE__); */
> -                                               exit(EXIT_SUCCESS);
> -                                       }
> -                               } /* end of if(retval == 0) */
> -                               else {
> -                                       ssize_t nleft = retval;
> -                                       ssize_t nwritten = 0;
> -                                       char *ptr = buf;
> -                                       while (nleft > 0) {
> -                                               if ((nwritten =
> -                                                    write(fileno(stdout), ptr,
> -                                                          (unsigned int)nleft))
> -                                                   <= 0) {
> -                                                       if (errno == EINTR) {
> -                                                               nwritten = 0;
> -                                                       } /* end of if(errno == EINTR) */
> -                                                       else {
> -                                                               perror("write");
> -                                                               fflush(stdout);
> -                                                               fflush(stderr);
> -                                                               exit(EXIT_SUCCESS);
> -                                                       }       /* end of else */
> -                                               }       /* end of if((nwritten = write(sockfd, ptr, nleft)) <= 0) */
> -                                               nleft -= nwritten;
> -                                               ptr += nwritten;
> -                                       }       /* end of while(nleft > 0) */
> -
> -                                       /* fprintf(stderr, "DEBUG: %d: wrote %d\n", __LINE__, retval); */
> -                                       fflush(stdout);
> -                               }       /* end of else */
> -                       }       /* end of else */
> -               }
> -               if (FD_ISSET(fileno(stdin), &t_readfds)) {
> -                       if (FD_ISSET(pty_master, &t_writefds)) {
> -                               retval =
> -                                   read(fileno(stdin), buf,
> -                                        (unsigned int)16384);
> -                               if (retval < 0) {
> -                                       if (errno != EINTR && errno != EAGAIN) {        /* Nothing left to read?  */
> -                                               fflush(stdout);
> -                                               fflush(stderr);
> -                                               exit(EXIT_SUCCESS);
> -                                       }       /* end of else */
> -                               } /* end of if(retval < 0) */
> -                               else {
> -                                       if (retval == 0) {
> -                                               if (++err_count > 5) {  /* lost controlling tty */
> -                                                       fflush(stdout);
> -                                                       fflush(stderr);
> -                                                       exit(EXIT_SUCCESS);
> -                                               }
> -                                       } /* end of if(retval == 0) */
> -                                       else {
> -                                               ssize_t nleft = retval;
> -                                               ssize_t nwritten = 0;
> -                                               char *ptr = buf;
> -                                               while (nleft > 0) {
> -                                                       if ((nwritten =
> -                                                            write(pty_master,
> -                                                                  ptr,
> -                                                                  (unsigned
> -                                                                   int)nleft))
> -                                                           <= 0) {
> -                                                               if (errno ==
> -                                                                   EINTR) {
> -                                                                       nwritten
> -                                                                           = 0;
> -                                                               } /* end of if(errno == EINTR) */
> -                                                               else {
> -                                                                       perror
> -                                                                           ("write");
> -                                                                       fflush
> -                                                                           (stdout);
> -                                                                       fflush
> -                                                                           (stderr);
> -                                                                       exit(EXIT_SUCCESS);
> -                                                               }       /* end of else */
> -                                                       }       /* end of if((nwritten = write(sockfd, ptr, nleft)) <= 0) */
> -                                                       nleft -= nwritten;
> -                                                       ptr += nwritten;
> -                                               }       /* end of while(nleft > 0) */
> -
> -                                               fflush(stdout);
> -                                       }       /* end of else */
> -                               }       /* end of else */
> -                       }       /* end of if(FD_ISSET(pty_master, &writefds)) */
> -               }               /* something to read on stdin */
> -       }                       /* Loop */
> -
> -       fflush(stdout);
> -       fflush(stderr);
> -
> -       exit(EXIT_SUCCESS);
> -}                              /* end of main() */
> diff --git a/policycoreutils/run_init/open_init_pty.cpp b/policycoreutils/run_init/open_init_pty.cpp
> new file mode 100644
> index 0000000..b82f7f5
> --- /dev/null
> +++ b/policycoreutils/run_init/open_init_pty.cpp
> @@ -0,0 +1,423 @@
> +/*                               -*- Mode: C -*-
> + * open_init_pty.c ---
> + * Author           : Manoj Srivastava ( srivasta@glaurung.internal.golden-gryphon.com )
> + * Created On       : Fri Jan 14 10:48:28 2005
> + * Created On Node  : glaurung.internal.golden-gryphon.com
> + * Last Modified By : Manoj Srivastava
> + * Last Modified On : Thu Sep 15 00:57:00 2005
> + * Last Machine Used: glaurung.internal.golden-gryphon.com
> + * Update Count     : 92
> + * Status           : Unknown, Use with caution!
> + * HISTORY          :
> + * Description      :
> + *
> + * Distributed under the terms of the GNU General Public License v2
> + *
> + * open_init_pty
> + *
> + * SYNOPSIS:
> + *
> + * This program allows a systems administrator to execute daemons
> + * which need to work in the initrc domain, and which need to have
> + * pty's as system_u:system_r:initrc_t
> + *
> + * USAGE:
> + *
> + * * arch-tag: a5583d39-72b9-4cdf-ba1b-5678ea4cbe20
> + */
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <signal.h>
> +#include <errno.h>
> +
> +#include <sysexits.h>
> +
> +#include <pty.h>    /* for openpty and forkpty */
> +#include <utmp.h>    /* for login_tty */
> +#include <termios.h>
> +#include <fcntl.h>
> +
> +#include <sys/select.h>
> +#include <sys/wait.h>
> +
> +
> +#define MAXRETR 3    /* The max number of IO retries on a fd */
> +#define BUFSIZE 2048  /* The ring buffer size */
> +
> +static struct termios saved_termios;
> +static int saved_fd = -1;
> +static enum { RESET, RAW, CBREAK } tty_state = RESET;
> +
> +static int tty_semi_raw(int fd)
> +{
> +  struct termios buf;
> +
> +  if (tty_state == RESET) {
> +    if (tcgetattr(fd, &saved_termios) < 0) {
> +      return -1;
> +    }
> +  }
> +
> +  buf = saved_termios;
> +  /*
> +   * echo off, canonical mode off, extended input processing off,
> +   * signal chars off
> +   */
> +  buf.c_lflag &= ~(ECHO | ICANON | IEXTEN | ISIG);
> +  /*
> +   * no SIGINT on break, CR-to-NL off, input parity check off, do not
> +   * strip 8th bit on input,output flow control off
> +   */
> +  buf.c_iflag &= ~(BRKINT | ICRNL | INPCK | ISTRIP | IXON);
> +  /* Clear size bits, parity checking off */
> +  buf.c_cflag &= ~(CSIZE | PARENB);
> +  /* set 8 bits/char */
> +  buf.c_cflag |= CS8;
> +  /* Output processing off
> +     buf.c_oflag    &= ~(OPOST); */
> +
> +  buf.c_cc[VMIN] = 1;  /* one byte at a time, no timer */
> +  buf.c_cc[VTIME] = 0;
> +  if (tcsetattr(fd, TCSANOW, &buf) < 0) {
> +    return -1;
> +  }
> +  tty_state = RAW;
> +  saved_fd = fd;
> +  return 0;
> +}
> +
> +static void tty_atexit(void)
> +{
> +  if (tty_state != CBREAK && tty_state != RAW) {
> +    return;
> +  }
> +
> +  if (tcsetattr(saved_fd, TCSANOW, &saved_termios) < 0) {
> +    return;
> +  }
> +  tty_state = RESET;
> +  return;
> +}
> +
> +
> +/* The simple ring buffer */
> +class ring_buffer
> +{
> +public:
> +  ring_buffer(char *buf, size_t size)
> +  {
> +    m_buf = m_wptr = m_rptr = buf;
> +    m_size = size;
> +    m_count = 0;
> +  }
> +
> +  size_t get_count() { return m_count; }
> +  int isempty() { return m_count == 0; }
> +
> +  // return the unused space size in the buffer
> +  size_t space()
> +  {
> +    if(m_rptr > m_wptr)
> +      return m_rptr - m_wptr;
> +    if(m_rptr < m_wptr || m_count == 0)
> +      return m_buf + m_size - m_wptr;
> +    return 0; // should not hit this
> +  }
> +
> +  // return the used space in the buffer
> +  size_t chunk_size()
> +  {
> +    if(m_rptr < m_wptr)
> +      return m_wptr - m_rptr;
> +    if(m_rptr > m_wptr || m_count > 0)
> +      return m_buf + m_size - m_rptr;
> +    return 0; // should not hit this
> +  }
> +
> +  // read from fd and write to buffer memory
> +  ssize_t rb_read(int fd)
> +  {
> +    ssize_t n = read(fd, m_wptr, space());
> +    if(n <= 0)
> +      return n;
> +    m_wptr += n;
> +    m_count += n;
> +    if(m_buf + m_size <= m_wptr)
> +      m_wptr = m_buf;
> +    return n;
> +  }
> +
> +  ssize_t rb_write(int fd)
> +  {
> +    ssize_t n = write(fd, m_rptr, chunk_size());
> +    if(n <= 0)
> +      return n;
> +    m_rptr += n;
> +    m_count -= n;
> +    if(m_buf + m_size <= m_rptr)
> +      m_rptr = m_buf;
> +    return n;
> +  }
> +
> +private:
> +    char *m_buf; /* pointer to buffer memory */
> +    char *m_wptr;
> +    char *m_rptr;
> +    size_t m_size; /* the number of bytes allocated for buf */
> +    size_t m_count;
> +};
> +
> +static void setfd_nonblock(int fd)
> +{
> +  int fsflags = fcntl(fd, F_GETFL);
> +
> +  if (fsflags < 0) {
> +    fprintf(stderr, "fcntl(%d, F_GETFL): %s\n",
> +        fd, strerror(errno));
> +    exit(EX_IOERR);
> +  }
> +
> +  if (fcntl(STDIN_FILENO, F_SETFL, fsflags | O_NONBLOCK) < 0) {
> +    fprintf(stderr, "fcntl(%d, F_SETFL, ... | O_NONBLOCK): %s\n",
> +        fd, strerror(errno));
> +    exit(EX_IOERR);
> +  }
> +}
> +
> +static void sigchld_handler(int asig __attribute__ ((unused)))
> +{
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +  pid_t child_pid;
> +  int child_exit_status;
> +  struct termios tty_attr;
> +  struct winsize window_size;
> +  int pty_master;
> +  char inbuf_mem[BUFSIZE];
> +  char outbuf_mem[BUFSIZE];
> +  ring_buffer inbuf(inbuf_mem, sizeof(inbuf_mem));
> +  ring_buffer outbuf(outbuf_mem, sizeof(outbuf_mem));
> +
> +  if (argc == 1) {
> +    printf("usage: %s PROGRAM [ARGS]...\n", argv[0]);
> +    exit(1);
> +  }
> +
> +  /* Wee need I/O calls to fail with EINTR on SIGCHLD... */
> +  if ( signal(SIGCHLD, sigchld_handler) == SIG_ERR ) {
> +    perror("signal(SIGCHLD,...)");
> +    exit(EX_OSERR);
> +  }
> +
> +  if (isatty(STDIN_FILENO)) {
> +    /* get terminal parameters associated with stdout */
> +    if (tcgetattr(STDOUT_FILENO, &tty_attr) < 0) {
> +      perror("tcgetattr(stdout,...)");
> +      exit(EX_OSERR);
> +    }
> +
> +    /* end of if(tcsetattr(&tty_attr)) */
> +    /* get window size */
> +    if (ioctl(STDOUT_FILENO, TIOCGWINSZ, &window_size) < 0) {
> +      perror("ioctl(stdout,...)");
> +      exit(1);
> +    }
> +
> +    child_pid = forkpty(&pty_master, NULL, &tty_attr, &window_size);
> +  } /* end of if(isatty(STDIN_FILENO)) */
> +  else {      /* not interactive */
> +    child_pid = forkpty(&pty_master, NULL, NULL, NULL);
> +  }
> +
> +  if (child_pid < 0) {
> +    perror("forkpty()");
> +    fflush(stdout);
> +    fflush(stderr);
> +    exit(EX_OSERR);
> +  }      /* end of if(child_pid < 0) */
> +  if (child_pid == 0) {
> +    /* in the child */
> +    struct termios s_tty_attr;
> +    if (tcgetattr(STDIN_FILENO, &s_tty_attr)) {
> +      perror("tcgetattr(stdin,...)");
> +      exit(EXIT_FAILURE);
> +    }
> +    /* Turn off echo */
> +    s_tty_attr.c_lflag &= ~(ECHO | ECHOE | ECHOK | ECHONL);
> +    /* Also turn of NL to CR?LF on output */
> +    s_tty_attr.c_oflag &= ~(ONLCR);
> +    if (tcsetattr(STDIN_FILENO, TCSANOW, &s_tty_attr)) {
> +      perror("tcsetattr(stdin,...)");
> +      exit(EXIT_FAILURE);
> +    }
> +
> +    if (execvp(argv[1], argv + 1)) {
> +      perror("execvp()");
> +      exit(EXIT_FAILURE);
> +    }
> +  }
> +
> +  /*
> +   * Non blocking mode for all file descriptors.
> +   */
> +  setfd_nonblock(pty_master);
> +  setfd_nonblock(STDIN_FILENO);
> +  setfd_nonblock(STDOUT_FILENO);
> +
> +  if (isatty(STDIN_FILENO)) {
> +    if (tty_semi_raw(STDIN_FILENO) < 0) {
> +      perror("tty_semi_raw(stdin)");
> +    }
> +    if (atexit(tty_atexit) < 0) {
> +      perror("atexit()");
> +    }
> +  }
> +
> +  /* for select()... */
> +  fd_set readfds;
> +  fd_set writefds;
> +  fd_set exceptfds;
> +  FD_ZERO(&readfds);
> +  FD_ZERO(&writefds);
> +  FD_ZERO(&exceptfds);
> +
> +  unsigned err_n_rpty = 0;
> +  unsigned err_n_wpty = 0;
> +  unsigned err_n_stdin = 0;
> +  unsigned err_n_stdout = 0;
> +
> +  int done = 0;
> +
> +  do {
> +    /* Accept events only on fds, that we can handle now. */
> +    int do_select = 0;
> +
> +    if ( outbuf.space() > 0  &&  err_n_rpty < MAXRETR ) {
> +      FD_SET(pty_master, &readfds);
> +      do_select = 1;
> +    } else
> +      FD_CLR(pty_master, &readfds);
> +
> +    if ( ! inbuf.isempty()  &&  err_n_wpty < MAXRETR ) {
> +      FD_SET(pty_master, &writefds);
> +      do_select = 1;
> +    } else
> +      FD_CLR(pty_master, &writefds);
> +
> +    if ( inbuf.space() > 0  &&  err_n_stdin < MAXRETR ) {
> +      FD_SET(STDIN_FILENO, &readfds);
> +      do_select = 1;
> +    } else
> +      FD_CLR(STDIN_FILENO, &readfds);
> +
> +    if ( ! outbuf.isempty()  &&  err_n_stdout < MAXRETR ) {
> +      FD_SET(STDOUT_FILENO, &writefds);
> +      do_select = 1;
> +    } else
> +      FD_CLR(STDOUT_FILENO, &writefds);
> +
> +    if ( ! do_select )
> +    {
> +#ifdef DEBUG
> +      fprintf(stderr, "No I/O job for us, calling waitpid()...\n");
> +#endif
> +        while ( waitpid(child_pid, &child_exit_status, 0) < 0 )
> +        ;
> +      break;
> +    }
> +
> +    int select_rc = select(pty_master + 1,
> +        &readfds, &writefds, &exceptfds, NULL);
> +    if ( select_rc < 0 ) {
> +      perror("select()");
> +      exit(EX_IOERR);
> +    }
> +#ifdef DEBUG
> +    fprintf(stderr, "select() returned %d\n", select_rc);
> +#endif
> +
> +    if (FD_ISSET(STDOUT_FILENO, &writefds)) {
> +#ifdef DEBUG
> +        fprintf(stderr, "stdout can be written\n");
> +#endif
> +        ssize_t n = outbuf.rb_write(STDOUT_FILENO);
> +        if ( n <= 0 && n != EINTR && n != EAGAIN )
> +        err_n_stdout++;
> +#ifdef DEBUG
> +        if ( n >= 0 )
> +        fprintf(stderr, "%d bytes written into stdout\n", n);
> +        else
> +        perror("write(stdout,...)");
> +#endif
> +    }
> +    if (FD_ISSET(pty_master, &writefds)) {
> +#ifdef DEBUG
> +        fprintf(stderr, "pty_master can be written\n");
> +#endif
> +        ssize_t n = inbuf.rb_write(pty_master);
> +        if ( n <= 0 && n != EINTR && n != EAGAIN )
> +        err_n_wpty++;
> +#ifdef DEBUG
> +        if ( n >= 0 )
> +        fprintf(stderr, "%d bytes written into pty_master\n", n);
> +        else
> +        perror("write(pty_master,...)");
> +#endif
> +    }
> +    if (FD_ISSET(STDIN_FILENO, &readfds)) {
> +#ifdef DEBUG
> +        fprintf(stderr, "stdin can be read\n");
> +#endif
> +        ssize_t n = inbuf.rb_read(STDIN_FILENO);
> +        if ( n <= 0 && n != EINTR && n != EAGAIN )
> +        err_n_stdin++;
> +#ifdef DEBUG
> +        if ( n >= 0 )
> +        fprintf(stderr, "%d bytes read from stdin\n", n);
> +        else
> +        perror("read(stdin,...)");
> +#endif
> +    }
> +    if (FD_ISSET(pty_master, &readfds)) {
> +#ifdef DEBUG
> +        fprintf(stderr, "pty_master can be read\n");
> +#endif
> +        ssize_t n = outbuf.rb_read(pty_master);
> +        if ( n <= 0 && n != EINTR && n != EAGAIN )
> +        err_n_rpty++;
> +#ifdef DEBUG
> +        if ( n >= 0 )
> +        fprintf(stderr, "%d bytes read from pty_master\n", n);
> +        else
> +        perror("read(pty_master,...)");
> +#endif
> +    }
> +
> +    if ( ! done )
> +        if ( waitpid(child_pid, &child_exit_status, WNOHANG) > 0 )
> +        done = 1;
> +
> +  } while ( !done
> +      || !(inbuf.isempty() || err_n_wpty >= MAXRETR)
> +        || !(outbuf.isempty() || err_n_stdout >= MAXRETR) );
> +
> +#ifdef DEBUG
> +  fprintf(stderr, "inbuf: %u bytes left, outbuf: %u bytes left\n",
> +      inbuf.get_count(), outbuf.get_count());
> +  fprintf(stderr, "err_n_rpty=%u, err_n_wpty=%u, "
> +      "err_n_stdin=%u, err_n_stdout=%u\n",
> +      err_n_rpty, err_n_wpty, err_n_stdin, err_n_stdout);
> +#endif
> +  if ( WIFEXITED(child_exit_status) )
> +    exit(WEXITSTATUS(child_exit_status));
> +  exit(EXIT_FAILURE);
> +}        /* end of main() */
> +
> +/*
> + * vim:ts=4:
> + */
> --
> 1.7.10.4
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
