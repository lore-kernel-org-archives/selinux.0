Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0K42JIi002772
	for <selinux@tycho.nsa.gov>; Wed, 19 Jan 2005 23:02:19 -0500 (EST)
Received: from glaurung.internal.golden-gryphon.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0K42JCf002613
	for <selinux@tycho.nsa.gov>; Thu, 20 Jan 2005 04:02:20 GMT
Received: from glaurung.internal.golden-gryphon.com (localhost [127.0.0.1])
	by glaurung.internal.golden-gryphon.com (8.13.2/8.13.2/Debian-1) with ESMTP id j0K3rEOu032689
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <selinux@tycho.nsa.gov>; Wed, 19 Jan 2005 21:53:19 -0600
From: Manoj Srivastava <manoj.srivastava@stdc.com>
To: selinux@tycho.nsa.gov
Subject: run_init and interactive scripts
Date: Wed, 19 Jan 2005 21:53:06 -0600
Message-ID: <87acr4u57h.fsf@glaurung.internal.golden-gryphon.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--=-=-=

Hi,

        run_init, as distributed, can run init scripts in the initrc
 domain. However, if the forked process is an interactive one, it
 inherits the controlling tty, which is would mean that the
 controlling tty is the controlling tty of a sysadm_t process -- and
 this can be a problem, since a process  that has a pty can insert
 characters and potentially take over a sysadm_t session. (If the
 process invokes a daemon that does not close file handles, then if
 exploited can be used to take over administrative sessions). (This
 also inhibits denials due to an initrc_exec_t process trying to write
 to a sysadm_devpts_t object).

	The following patch makes run_init execute
 /usr/sbin/open_init_pty (after using setexeccon to set the context
 appropriately). So, run_init does not execvp the command directly,
 Instead, it transitions the process into the initrc_t domain, execs
 open_init_tty. open_init_pty then spawns a new process, that gets a
 pty with context initrc_devpts_t (just execvp or using a exec(1) does
 not open a new pty; the process inherits the original controlling
 tty).

	open_init_pty then sets up the psuedo terminal properly based
 on the physical terminal attributes of the initial pty (temporarily
 setting the user's pty to RAW mode, taking care to reset it on exit),
 forks a child process that binds to the pseudo terminal. It then sits
 around and connects the physical terminal it was invoked upon with
 the pseudo terminal, passing keyboard input into to the child
 process, and passing the output of the child process to the physical
 terminal (using select).

	I have included a manual page, and the corresponding changes
 to the build system to build, install, and relabel the installed
 executables appropriately.

	This has been tested with dselect on a SELinux UML.

	manoj


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=changes.patch
Content-Description: Patch to implement open_init_pty


* modified files

--- orig/run_init/Makefile
+++ mod/run_init/Makefile
@@ -8,17 +8,23 @@
 
 CFLAGS = -Wall
 override CFLAGS += -DUSE_NLS -DUSE_PAM -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
-LDLIBS += -lselinux -ldl -lpam -lpam_misc
+LDLIBS += -lselinux -ldl -lpam -lpam_misc -lutil
 
 TARGETS=$(patsubst %.c,%,$(wildcard *.c))
 
 all: $(TARGETS)
 
+open_init_pty: open_init_pty.c
+	$(LINK.c) $^ -lutil -o $@
+
+
 install: all
 	test -d $(SBINDIR)      || install -m 755 -d $(SBINDIR)
 	test -d $(MANDIR)/man1 || install -m 755 -d $(MANDIR)/man1
 	install -m 555 run_init $(SBINDIR)
+	install -m 555 open_init_pty $(SBINDIR)
 	install -m 644 run_init.8 $(MANDIR)/man8/
+	install -m 644 open_init_pty.8 $(MANDIR)/man8/
 	install -m 644 run_init.pamd $(ETCDIR)/pam.d/run_init
 
 clean:
@@ -26,3 +32,4 @@
 
 relabel: install
 	setfilecon system_u:object_r:run_init_exec_t $(SBINDIR)/run_init
+	setfilecon system_u:object_r:initrc_exec_t $(SBINDIR)/open_init_pty


--- orig/run_init/run_init.c
+++ mod/run_init/run_init.c
@@ -376,7 +376,15 @@
        fprintf(stderr, _("Could not set exec context to %s.\n"), new_context);
        exit(-1);
   }
-  if ( execvp(argv[1], argv + 1) ) {
+  /*
+   * Do not execvp the command directly from run_init; since it would run
+   * under with a pty under sysadm_devpts_t. Instead, we call open_init_tty,
+   * which transitions us into initrc_t, which then spawns a new
+   * process, that gets a pty with context initrc_devpts_t. Just
+   * execvp or using a exec(1) recycles pty's, and does not open a new
+   * one. 
+   */
+  if ( execvp("/usr/sbin/open_init_pty", argv) ) {
     perror("execvp");
     exit(-1);
   }



--- /dev/null
+++ run_init/open_init_pty.8
@@ -0,0 +1,48 @@
+.\" Hey, Emacs! This is an -*- nroff -*- source file.
+.\" Copyright (c) 2005 Manoj Srivastava <srivasta@debian.org>
+.\"
+.\" This is free documentation; you can redistribute it and/or
+.\" modify it under the terms of the GNU General Public License as
+.\" published by the Free Software Foundation; either version 2 of
+.\" the License, or (at your option) any later version.
+.\"
+.\" The GNU General Public License's references to "object code"
+.\" and "executables" are to be interpreted as the output of any
+.\" document formatting or typesetting system, including
+.\" intermediate and printed output.
+.\"
+.\" This manual is distributed in the hope that it will be useful,
+.\" but WITHOUT ANY WARRANTY; without even the implied warranty of
+.\" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+.\" GNU General Public License for more details.
+.\"
+.\" You should have received a copy of the GNU General Public
+.\" License along with this manual; if not, write to the Free
+.\" Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139,
+.\" USA.
+.\"
+.\"
+.TH OPEN_INIT_PTY "8" "January 2005" "Security Enhanced Linux" NSA
+.SH NAME
+open_init_pty \- run an program under a psuedo terminal
+.SH SYNOPSIS
+.B open_init_pty
+\fISCRIPT\fR [[\fIARGS\fR]...] 
+.br
+.SH DESCRIPTION
+.PP
+Run a program under a psuedo terminal. This is used by 
+.B run_init
+to run actually run the program after setting up the proper
+context. This program acquires a new Psuedo terminal, forks a child
+process that binds to the psueado terminal, and then sits around and
+connects the physical terminal it was invoked upon with the pseudo
+terminal, passing keyboard input into to the child process, and passing the
+output of the child process to the physical terminal.
+.PP
+It sets up the pseudo terminal properly based on the physical terminal
+attributes, and then sets the user's terminal to RAW mode, taking care
+to reset it on exit.
+.SH AUTHOR
+This manual page was written by Manoj Srivastava <srivasta@debian.org>,
+for the Debian GNU/Linux system.
--- /dev/null
+++ run_init/open_init_pty.c
@@ -0,0 +1,361 @@
+/*                               -*- Mode: C -*- 
+ * open_init_pty.c --- 
+ * Author           : Manoj Srivastava ( srivasta@glaurung.internal.golden-gryphon.com ) 
+ * Created On       : Fri Jan 14 10:48:28 2005
+ * Created On Node  : glaurung.internal.golden-gryphon.com
+ * Last Modified By : Manoj Srivastava
+ * Last Modified On : Fri Jan 14 19:06:19 2005
+ * Last Machine Used: glaurung.internal.golden-gryphon.com
+ * Update Count     : 85
+ * Status           : Unknown, Use with caution!
+ * HISTORY          : 
+ * Description      : 
+ *
+ * Distributed under the terms of the GNU General Public License v2
+ *
+ * open_init_pty
+ *
+ * SYNOPSIS:
+ *
+ * This program allows a systems administrator to execute daemons
+ * which need to work in the initrc domain, and which need to have
+ * pty's as system_u:system_r:initrc_t
+ *
+ * USAGE:
+ *
+ * * arch-tag: a5583d39-72b9-4cdf-ba1b-5678ea4cbe20
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <signal.h>
+#include <errno.h>
+
+#include <sysexits.h>
+
+#include <pty.h>  /* for openpty and forkpty */
+#include <utmp.h> /* for login_tty */
+#include <termios.h>
+#include <fcntl.h>
+
+#include <sys/select.h>
+
+static struct termios saved_termios;
+static int            saved_fd = -1;
+static enum { RESET, RAW, CBREAK } tty_state = RESET;
+
+static int
+tty_cbreak(int fd)
+{
+  struct termios buf;
+
+  if(tty_state == RESET)
+   {
+     if(tcgetattr(fd, &saved_termios) < 0)
+      {
+        return -1;
+      }
+   }
+
+  buf             = saved_termios;
+  buf.c_lflag    &= ~(ECHO | ICANON); /* echo off, canonical mode off */
+  buf.c_cc[VMIN]  = 1;             /* one byte at a time, no timer */
+  buf.c_cc[VTIME] = 0;
+  if(tcsetattr(fd, TCSANOW, &buf) < 0)
+   {
+     return -1;
+   } /* end of if(tcsetattr(fileno(stdin), TCSANOW, &buf) < 0) */
+  tty_state = CBREAK;
+  saved_fd = fd;
+  return 0;
+}
+
+static int
+tty_raw(int fd)
+{
+  struct termios buf;
+
+  if(tty_state == RESET)
+   {
+     if(tcgetattr(fd, &saved_termios) < 0)
+      {
+        return -1;
+      }
+   }
+
+  buf             = saved_termios;
+  /*
+   * echo off, canonical mode off, extended input processing off,
+   * signal chars off
+   */
+  buf.c_lflag    &= ~(ECHO | ICANON | IEXTEN | ISIG);
+  /*
+   * no SIGINT on break, CR-to-NL off, input parity check off, do not
+   * strip 8th bit on input,output flow control off
+   */
+  buf.c_iflag    &= ~(BRKINT | ICRNL | INPCK | ISTRIP | IXON);
+  /* Clear size bits, parity checking off */
+  buf.c_cflag    &= ~(CSIZE | PARENB);
+  /* set 8 bits/char */
+  buf.c_cflag    |= CS8;
+  /* Output processing off */
+  buf.c_oflag    &= ~(OPOST);
+
+  buf.c_cc[VMIN]  = 1;             /* one byte at a time, no timer */
+  buf.c_cc[VTIME] = 0;
+  if(tcsetattr(fd, TCSANOW, &buf) < 0)
+   {
+     return -1;
+   } /* end of if(tcsetattr(fileno(stdin), TCSANOW, &buf) < 0) */
+  tty_state = RAW;
+  saved_fd = fd;
+  return 0;
+}
+
+void
+tty_atexit(void)
+{
+  if(tty_state != CBREAK && tty_state != RAW)
+   {
+     return;
+   }
+
+  if(tcsetattr(saved_fd, TCSANOW, &saved_termios) < 0)
+   {
+     return;
+   } /* end of if(tcsetattr(fileno(stdin), TCSANOW, &buf) < 0) */
+  tty_state = RESET;
+  return;
+}
+
+
+int
+main(int argc, char *argv[])
+{
+  pid_t child_pid;
+  struct termios tty_attr;
+  struct winsize window_size;
+  int pty_master;
+  int retval = 0;
+
+  /* for select */
+  fd_set readfds;
+  fd_set writefds;
+  fd_set exceptfds;
+
+
+  int err_count = 0;
+
+  /* for sigtimedwait() */
+  struct timespec timeout;
+  char buf[16384];
+
+  sigset_t  signal_set;
+  siginfo_t signalinfo;
+
+  /* set up SIGCHLD */
+  sigemptyset(&signal_set);      /* no signals */
+  sigaddset(&signal_set, SIGCHLD); /* Add sig child  */
+  sigprocmask(SIG_BLOCK, &signal_set, NULL); /* Block the signal */
+
+  /* Set both to 0, so sigtimed wait just does a poll */
+  timeout.tv_sec=0;
+  timeout.tv_nsec=0;
+
+  if(isatty(fileno(stdin)))
+   {
+     /* get terminal parameters associated with stdout */
+     if(tcgetattr(fileno(stdout), &tty_attr) < 0)
+      {
+        perror("Error determining terminal characteristics");
+        exit(EX_OSERR);
+      } /* end of if(tcsetattr(&tty_attr)) */
+
+     /* get window size */
+     if( ioctl(fileno(stdout), TIOCGWINSZ, &window_size) < 0 ) {
+       perror("Error determining window size: ioctl stdout TIOCGWINSZ");
+       exit(1);
+     }
+
+     child_pid = forkpty(&pty_master, NULL, &tty_attr, &window_size);
+   } /* end of if(isatty(fileno(stdin))) */
+  else
+   {                            /* not interactive */
+     child_pid = forkpty(&pty_master, NULL, NULL, NULL);
+   }
+
+  if(child_pid < 0)
+   {
+     perror("Error forking process");
+     exit(EX_OSERR);
+   } /* end of if(child_pid < 0) */
+  if(child_pid == 0)
+   {
+     /* in the child */
+     struct termios s_tty_attr;
+     if(tcgetattr(fileno(stdin), &s_tty_attr))
+      {
+        perror("Child:");
+        exit(EXIT_FAILURE);
+      }
+     /* Turn off echo */
+     s_tty_attr.c_lflag &= ~(ECHO | ECHOE | ECHOK | ECHONL);
+     /* Also turn of NL to CR?LF on output */
+     s_tty_attr.c_oflag &= ~(ONLCR);
+     if(tcsetattr(fileno(stdin), TCSANOW, &s_tty_attr))
+      {
+        perror("Child:");
+        exit(EXIT_FAILURE);
+      }
+
+     if ( execvp(argv[1], argv + 1) ) {
+       perror("Error executing child");
+       exit(EXIT_FAILURE);
+     }
+   } /* end of if(child_pid == 0) */
+
+  /* 
+   * OK. Prepare to handle IO from the child. We need to transfer
+   * everything from the shilds stdout to ours.
+   */
+
+  FD_ZERO(&readfds);
+  FD_ZERO(&writefds);
+  FD_ZERO(&exceptfds);
+
+  /*
+   * Read current file descriptor flags, preparing to do non blocking reads
+   */
+  retval=fcntl(pty_master,F_GETFL);
+  if(retval<0) {
+    perror("fcntl_get");
+    exit(EX_IOERR);
+  }
+
+  /* Set the connection to be non-blocking */
+  if(fcntl(pty_master,F_SETFL, retval | O_NONBLOCK) < 0) {
+    perror("fcnt_setFlag_nonblock:");
+    exit(1);
+  }
+
+  FD_SET(pty_master, &readfds);
+  FD_SET(pty_master, &writefds);
+  FD_SET(fileno(stdin), &readfds);
+  if(isatty(fileno(stdin)))
+   {
+     if(tty_raw(fileno(stdin)) < 0)
+      {
+        perror("Error: settingraw mode:");
+      } /* end of if(tty_raw(fileno(stdin)) < 0) */
+     if(atexit(tty_atexit) < 0)
+      {
+        perror("Atexit setup:");
+      } /* end of if(atexit(tty_atexit) < 0) */
+   }
+
+  /* while no signal, we loop around */
+  while(1) {
+    struct timeval interval;
+    fd_set t_readfds;
+    fd_set t_writefds;
+    fd_set t_exceptfds;
+
+    interval.tv_sec  = 0;
+    interval.tv_usec = 100;
+
+    t_readfds   = readfds;
+    t_writefds  = writefds;
+    t_exceptfds = exceptfds;
+
+    /* check for the signal */
+    retval = sigtimedwait(&signal_set, &signalinfo,&timeout);
+
+    if( retval == SIGCHLD ) {
+      /* child terminated */
+      break;
+    }
+    else
+     {
+       if( retval < 0 ) {
+         if(errno != EAGAIN) {
+           perror("sigtimedwait");
+           exit(EX_IOERR);
+         }
+         else
+          {
+            /* No signal in set was delivered within the timeout period specified */
+          }
+       }
+     } /* end of else */
+
+    if(select (pty_master + 1, &t_readfds, &t_writefds, &t_exceptfds, 
+               &interval) < 0)
+     {
+       perror("Select:");
+       exit (EX_IOERR);
+     }
+
+    if(FD_ISSET(pty_master, &t_readfds))
+     {
+       retval = read(pty_master, buf, (unsigned int)16384);
+       if(retval < 0)
+        {
+          if(errno != EINTR && errno != EAGAIN) 
+           {
+             perror("Done?");
+             exit (EX_IOERR);
+           } /* end of else */
+        } /* end of if(retval < 0) */
+       else
+        {
+          if(retval == 0)
+           {
+             if(++err_count > 5)
+              {                 /* child closed connection */
+                exit (EXIT_SUCCESS);
+              }
+           } /* end of if(retval == 0) */
+          else
+           {
+             write(fileno(stdout), buf, (unsigned int)retval);
+             fflush(stdout);
+           } /* end of else */
+        } /* end of else */
+     }
+    if(FD_ISSET(fileno(stdin), &t_readfds))
+     {
+       if(FD_ISSET(pty_master, &t_writefds))
+        {
+          retval = read(fileno(stdin), buf, (unsigned int)16384);
+          if(retval < 0)
+           {
+             if(errno != EINTR && errno != EAGAIN)
+              {
+                perror("Done?");
+                exit (EX_IOERR);
+              } /* end of else */
+           } /* end of if(retval < 0) */
+          else
+           {
+             if(retval == 0)
+              {
+                if(++err_count > 5)
+                 {              /* lost controlling tty */
+                   exit (EXIT_SUCCESS);
+                 }
+              } /* end of if(retval == 0) */
+             else
+              {
+                write(pty_master, buf, (unsigned int)retval);
+                fflush(stdout);
+              } /* end of else */
+           } /* end of else */
+        } /* end of if(FD_ISSET(pty_master, &writefds)) */
+     }    /* something to read on stdin */
+  } /* Loop */
+
+  fflush(stdout);
+
+  exit(EXIT_SUCCESS);
+} /* end of main() */

--=-=-=



-- 
When we understand knowledge-based systems, it will be as before --
except our fingertips will have been singed.  -- Epigrams in
Programming, ACM SIGPLAN Sept. 1982
Manoj Srivastava   <manoj.srivastava@stdc.com>    <srivasta@acm.org> 
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C

--=-=-=--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
