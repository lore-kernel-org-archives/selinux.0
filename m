Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0V1pg53005305
	for <selinux@tycho.nsa.gov>; Sun, 30 Jan 2005 20:51:42 -0500 (EST)
Received: from glaurung.internal.golden-gryphon.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0V1nUgm022053
	for <selinux@tycho.nsa.gov>; Mon, 31 Jan 2005 01:49:34 GMT
Received: from glaurung.internal.golden-gryphon.com (localhost [127.0.0.1])
	by glaurung.internal.golden-gryphon.com (8.13.3/8.13.3/Debian-3) with ESMTP id j0V1lXmk005143
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <selinux@tycho.nsa.gov>; Sun, 30 Jan 2005 19:47:43 -0600
From: Manoj Srivastava <manoj.srivastava@stdc.com>
To: selinux@tycho.nsa.gov
Subject: Updated version of open_init_pty
Date: Sun, 30 Jan 2005 19:47:20 -0600
Message-ID: <873bwil68n.fsf@glaurung.internal.golden-gryphon.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--=-=-=

Hi,

        This patch removes the unused functions tty_cbreak() and
 tty_raw(). I have also nailed down the cause of the error that caused
 truncated out put (I was able to reproduce the problem by running
 "open_init_pty ls" in  a small directory -- the problem was faulty
 handling of the SIG_CHLD signal, where I was not draining the last
 bits stuck in the pipe.

	Also fixed are partial writes (which could happen if the write
 was interrupted), now we resume the write from where we left off
 until all the bits are written. This could have resulted in lost
 characters as well.

	This is not perfect, since it does not work very well for
 interactive scripts that do not take full control f the screen -- but
 it works for init scripts, it works with dselect, aptitude, and the
 lot, so this is good enough for this iteration.

	I have also increased the time the program sits in select, as
 opposed to running around the loop; but even setting the last
 argument of select to NULL (and waiting forever) shows 
  "open_init_pty top" taking up a large chunk of CPU. I have made
 open_init_pty nice the parent process after executing the child
 process, but before moving any data around, to help with this
 situation.

	Ideally, open_init_pty should track the child process setting
 of the pseudo pty settings (like local echo settings, and so on) and
 transferring that to the controlling tty, so that local echo is only
 turned off when the child process wants it that way. More testing is
 needed for that.

	Anyway, a patch from the last version I sent in is
 attached. Please let me know if I should send in the current version
 of the file.

	manoj


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=policycoreutils.patch
Content-Description: Correct the truncation problems


* modified files

--- orig/run_init/open_init_pty.c
+++ mod/run_init/open_init_pty.c
@@ -46,74 +46,6 @@
 static enum { RESET, RAW, CBREAK } tty_state = RESET;
 
 static int
-tty_cbreak(int fd)
-{
-  struct termios buf;
-
-  if(tty_state == RESET)
-   {
-     if(tcgetattr(fd, &saved_termios) < 0)
-      {
-        return -1;
-      }
-   }
-
-  buf             = saved_termios;
-  buf.c_lflag    &= ~(ECHO | ICANON); /* echo off, canonical mode off */
-  buf.c_cc[VMIN]  = 1;             /* one byte at a time, no timer */
-  buf.c_cc[VTIME] = 0;
-  if(tcsetattr(fd, TCSANOW, &buf) < 0)
-   {
-     return -1;
-   } /* end of if(tcsetattr(fileno(stdin), TCSANOW, &buf) < 0) */
-  tty_state = CBREAK;
-  saved_fd = fd;
-  return 0;
-}
-
-static int
-tty_raw(int fd)
-{
-  struct termios buf;
-
-  if(tty_state == RESET)
-   {
-     if(tcgetattr(fd, &saved_termios) < 0)
-      {
-        return -1;
-      }
-   }
-
-  buf             = saved_termios;
-  /*
-   * echo off, canonical mode off, extended input processing off,
-   * signal chars off
-   */
-  buf.c_lflag    &= ~(ECHO | ICANON | IEXTEN | ISIG);
-  /*
-   * no SIGINT on break, CR-to-NL off, input parity check off, do not
-   * strip 8th bit on input,output flow control off
-   */
-  buf.c_iflag    &= ~(BRKINT | ICRNL | INPCK | ISTRIP | IXON);
-  /* Clear size bits, parity checking off */
-  buf.c_cflag    &= ~(CSIZE | PARENB);
-  /* set 8 bits/char */
-  buf.c_cflag    |= CS8;
-  /* Output processing off */
-  buf.c_oflag    &= ~(OPOST);
-
-  buf.c_cc[VMIN]  = 1;             /* one byte at a time, no timer */
-  buf.c_cc[VTIME] = 0;
-  if(tcsetattr(fd, TCSANOW, &buf) < 0)
-   {
-     return -1;
-   } /* end of if(tcsetattr(fileno(stdin), TCSANOW, &buf) < 0) */
-  tty_state = RAW;
-  saved_fd = fd;
-  return 0;
-}
-
-static int
 tty_semi_raw(int fd)
 {
   struct termios buf;
@@ -129,7 +61,7 @@
   buf             = saved_termios;
   /*
    * echo off, canonical mode off, extended input processing off,
-   * signal chars off
+   * signal chars off 
    */
   buf.c_lflag    &= ~(ECHO | ICANON | IEXTEN | ISIG);
   /*
@@ -310,15 +242,25 @@
       } /* end of if(atexit(tty_atexit) < 0) */
    }
 
+
+  /* ignore return from nice, but lower our priority */
+  nice(19);
+
   /* while no signal, we loop around */
-  while(1) {
+  int done = 0;
+  while(! done) {
     struct timeval interval;
     fd_set t_readfds;
     fd_set t_writefds;
     fd_set t_exceptfds;
-
+    /*
+     * We still use a blocked signal, and check for SIGCHLD every
+     * loop, since waiting infinitely did not really help the load
+     * when running, say, top. 
+     */
     interval.tv_sec  = 0;
-    interval.tv_usec = 100;
+    interval.tv_usec = 200000;    /* so, check for signals every 200 milli
+                                   seconds */
 
     t_readfds   = readfds;
     t_writefds  = writefds;
@@ -329,7 +271,8 @@
 
     if( retval == SIGCHLD ) {
       /* child terminated */
-      break;
+      done = 1;                 /* in case they do not close off their
+                                   file descriptors */
     }
     else
      {
@@ -365,6 +308,7 @@
            {                    /* Nothing left to read?  */
              fflush(stdout);
              fflush(stderr);
+             /* fprintf(stderr, "DEBUG: %d: Nothing left to read?\n", __LINE__);*/
              exit (EXIT_SUCCESS);
            } /* end of else */
         } /* end of if(retval < 0) */
@@ -376,12 +320,37 @@
               {                 /* child closed connection */
                 fflush(stdout);
                 fflush(stderr);
+                /*fprintf(stderr, "DEBUG: %d: child closed connection?\n", __LINE__);*/
                 exit (EXIT_SUCCESS);
               }
            } /* end of if(retval == 0) */
           else
            {
-             write(fileno(stdout), buf, (unsigned int)retval);
+             ssize_t  nleft    = retval;
+             ssize_t  nwritten = 0;
+             char *   ptr      = buf;
+             while(nleft > 0)
+              {
+                if((nwritten = write(fileno(stdout), ptr,
+                                     (unsigned int)nleft)) <= 0)
+                 {
+                   if(errno == EINTR)
+                    {
+                      nwritten = 0;
+                    } /* end of if(errno == EINTR) */
+                   else
+                    {
+                      perror("write");
+                      fflush(stdout);
+                      fflush(stderr);
+                      exit (EXIT_SUCCESS);
+                    } /* end of else */
+                 } /* end of if((nwritten = write(sockfd, ptr, nleft)) <= 0) */
+                nleft -= nwritten;
+                ptr += nwritten;
+              } /* end of while(nleft > 0) */
+
+             /* fprintf(stderr, "DEBUG: %d: wrote %d\n", __LINE__, retval);*/
              fflush(stdout);
            } /* end of else */
         } /* end of else */
@@ -413,7 +382,30 @@
               } /* end of if(retval == 0) */
              else
               {
-                write(pty_master, buf, (unsigned int)retval);
+                ssize_t  nleft    = retval;
+                ssize_t  nwritten = 0;
+                char *   ptr      = buf;
+                while(nleft > 0)
+                 {
+                   if((nwritten = write(pty_master, ptr,
+                                        (unsigned int)nleft)) <= 0)
+                    {
+                      if(errno == EINTR)
+                       {
+                         nwritten = 0;
+                       } /* end of if(errno == EINTR) */
+                      else
+                       {
+                         perror("write");
+                         fflush(stdout);
+                         fflush(stderr);
+                         exit (EXIT_SUCCESS);
+                       } /* end of else */
+                    } /* end of if((nwritten = write(sockfd, ptr, nleft)) <= 0) */
+                   nleft -= nwritten;
+                   ptr += nwritten;
+                 } /* end of while(nleft > 0) */
+
                 fflush(stdout);
               } /* end of else */
            } /* end of else */





--=-=-=


-- 
Operator, please trace this call and tell me where I am.
Manoj Srivastava   <manoj.srivastava@stdc.com>    <srivasta@acm.org> 
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C

--=-=-=--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
