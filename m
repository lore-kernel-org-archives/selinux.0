Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0LIgGIi014236
	for <selinux@tycho.nsa.gov>; Fri, 21 Jan 2005 13:42:16 -0500 (EST)
Received: from glaurung.internal.golden-gryphon.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0LIeCeS000899
	for <selinux@tycho.nsa.gov>; Fri, 21 Jan 2005 18:40:12 GMT
Received: from glaurung.internal.golden-gryphon.com (localhost [127.0.0.1])
	by glaurung.internal.golden-gryphon.com (8.13.2/8.13.2/Debian-1) with ESMTP id j0LIdHBr010891
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <selinux@tycho.nsa.gov>; Fri, 21 Jan 2005 12:39:17 -0600
From: Manoj Srivastava <manoj.srivastava@stdc.com>
To: selinux@tycho.nsa.gov
Subject: Re: run_init and interactive scripts
References: <87acr4u57h.fsf@glaurung.internal.golden-gryphon.com>
	<1106246926.26753.196.camel@moss-spartans.epoch.ncsc.mil>
Date: Fri, 21 Jan 2005 12:39:15 -0600
In-Reply-To: <1106246926.26753.196.camel@moss-spartans.epoch.ncsc.mil>
	(Stephen Smalley's message of "Thu, 20 Jan 2005 13:48:46 -0500")
Message-ID: <87fz0ufwz0.fsf@glaurung.internal.golden-gryphon.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--=-=-=

Hi,

 [Sent to Stephen  directly in error; Stephen, I apologize for the
  duplicate]

On Thu, 20 Jan 2005 13:48:46 -0500, Stephen Smalley <sds@epoch.ncsc.mil> said: 

> It seems like this functionality (or something similar) could be
> useful in other situations, e.g. for su(1) and sudo(8).


        Hmm. I had been mostly testing open_init_pty  with full screen
 curses based applications like aptitude and dselect, and not things
 like restarting sshd. Looking at sshd restarts, I noticed ladder
 artifacts like:
======================================================================
Shutting down mimedefang: [  OK  ]
                                  Shutting down mimedefang-multiplexor:[  OK  ]
 ....
======================================================================

        This is because I was putting the users terminal into raw
 mode, and that also turns off output processing.  So, in the
 following patch I introduce a function called tty_semi_raw, which is
 just like raw mode, except we retain output processing. This is still
 fine for things like aptitude and dselect, and makes the non-curses
 applicationss look OK (like so)
======================================================================
Shutting down mimedefang: [  OK  ]
Shutting down mimedefang-multiplexor: [  OK  ]
 ....
======================================================================

        This is an incremental patch in addition to the one I sent 12
 hours or so ago, which had the fflush stderr fixes. Please apply.

        manoj


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=changes.patch
Content-Description: only set terminal to semi_raw state

--- orig/run_init/open_init_pty.c
+++ mod/run_init/open_init_pty.c
@@ -113,6 +113,48 @@
   return 0;
 }
 
+static int
+tty_semi_raw(int fd)
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
+  /* Output processing off 
+  buf.c_oflag    &= ~(OPOST); */
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
 void
 tty_atexit(void)
 {
@@ -254,7 +296,7 @@
   FD_SET(fileno(stdin), &readfds);
   if(isatty(fileno(stdin)))
    {
-     if(tty_raw(fileno(stdin)) < 0)
+     if(tty_semi_raw(fileno(stdin)) < 0)
       {
         perror("Error: settingraw mode:");
         fflush(stdout);




--=-=-=


-- 
Paradise is exactly like where you are right now ... only much, much
better. Laurie Anderson
Manoj Srivastava   <manoj.srivastava@stdc.com>    <srivasta@acm.org> 
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C

--=-=-=--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
