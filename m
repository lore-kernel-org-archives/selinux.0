Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA08210
	for <selinux@tycho.nsa.gov>; Sun, 27 Oct 2002 14:44:58 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id TAA07402
	for <selinux@tycho.nsa.gov>; Sun, 27 Oct 2002 19:43:06 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id TAA07398
	for <selinux@tycho.nsa.gov>; Sun, 27 Oct 2002 19:43:04 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 63A2D92724
	for <selinux@tycho.nsa.gov>; Mon, 28 Oct 2002 06:44:42 +1100 (EST)
Received: from lyta (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 05F8F2D1
	for <selinux@tycho.nsa.gov>; Sun, 27 Oct 2002 20:44:35 +0100 (CET)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: expect
Date: Sun, 27 Oct 2002 21:44:34 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_A6ONHRRQC5QYPVYYAF1J"
Message-Id: <200210272044.34179.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_A6ONHRRQC5QYPVYYAF1J
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

I've attached a bug report I filed against expect.  This causes annoying avc 
messages about fd use if you have expect running a process in a different 
security context where it can't write to the controlling terminal.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--------------Boundary-00=_A6ONHRRQC5QYPVYYAF1J
Content-Type: text/x-diff;
  charset="us-ascii";
  name="bug"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="bug"

Subject: expect: leaves file handle 3 open when running programs
Package: expect
Version: 5.38.0-2
Severity: normal

When expect opens the new stdin/out/err handles from the pseudo tty it creates
it will first dup2 the stderr file handle to file handle 3 so it can report
errors directly to the controlling terminal.

However it does not set this file handle to close on exec (NB setting file
handle 3 to close on exec after doing dup2(2, 3) has no affect on file handle
2).  This means that the child process will have file handle 3 unexpectedly
open.  Among other things the child process could use this file handle to
detect the presence of expect and to send back data to the terminal directly
without expect controlling it.

Here is a patch to fix this.

diff -ru expect-orig/exp_clib.c expect-5.38.0/exp_clib.c
--- expect-orig/exp_clib.c	2002-03-23 05:55:04.000000000 +0100
+++ expect-5.38.0/exp_clib.c	2002-10-27 20:23:15.000000000 +0100
@@ -2500,6 +2500,7 @@
 
 	/* save error fd while we're setting up new one */
 	errorfd = fcntl(2,F_DUPFD,3);
+	fcntl(3, F_SETFD, FD_CLOEXEC);
 	/* and here is the macro to restore it */
 #define restore_error_fd {close(2);fcntl(errorfd,F_DUPFD,2);}
 
diff -ru expect-orig/exp_command.c expect-5.38.0/exp_command.c
--- expect-orig/exp_command.c	2002-10-27 19:52:06.000000000 +0100
+++ expect-5.38.0/exp_command.c	2002-10-27 20:36:55.000000000 +0100
@@ -1036,6 +1036,7 @@
 
 	/* save error fd while we're setting up new one */
 	errorfd = fcntl(2,F_DUPFD,3);
+	fcntl(3, F_SETFD, FD_CLOEXEC);
 	/* and here is the macro to restore it */
 #define restore_error_fd {close(2);fcntl(errorfd,F_DUPFD,2);}
 

-- System Information
Debian Release: testing/unstable
Kernel Version: Linux lyta 2.4.19lsm #1 Wed Sep 25 15:49:15 CEST 2002 i686 Pentium III (Coppermine) GenuineIntel GNU/Linux

Versions of the packages expect depends on:
ii  libc6          2.3.1-3        GNU C Library: Shared libraries and Timezone
ii  tcl8.3         8.3.3-8        The Tool Command Language (TCL) v8.3 - Run-T

--------------Boundary-00=_A6ONHRRQC5QYPVYYAF1J--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
