Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBOHnxIi009098
	for <selinux@tycho.nsa.gov>; Fri, 24 Dec 2004 12:49:59 -0500 (EST)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBOHmBbn014456
	for <selinux@tycho.nsa.gov>; Fri, 24 Dec 2004 17:48:12 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 1BDC861AFD
	for <selinux@tycho.nsa.gov>; Sat, 25 Dec 2004 04:50:01 +1100 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 26389-10 for <selinux@tycho.nsa.gov>;
	Sat, 25 Dec 2004 04:50:00 +1100 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id B617361AF9
	for <selinux@tycho.nsa.gov>; Sat, 25 Dec 2004 04:50:00 +1100 (EST)
Received: from aeon (aeon [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id 5D287A4
	for <selinux@tycho.nsa.gov>; Sat, 25 Dec 2004 04:49:58 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: udev policy
Date: Sat, 25 Dec 2004 04:49:54 +1100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_FbFzBOltwB0GvKb"
Message-Id: <200412250449.57039.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_FbFzBOltwB0GvKb
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch allows pamconsole to run in it's own domain when executed 
by udev.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_FbFzBOltwB0GvKb
Content-Type: text/x-diff;
  charset="us-ascii";
  name="udev.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="udev.diff"

--- /tmp/u/etc/selinux/strict/src/policy/domains/program/udev.te	2004-12-25 04:27:33.000000000 +1100
+++ domains/program/udev.te	2004-12-25 04:48:15.704637931 +1100
@@ -98,6 +98,7 @@
 ifdef(`pamconsole.te', `
 allow udev_t pam_var_console_t:dir search;
 allow udev_t pam_var_console_t:file { getattr read };
+domain_auto_trans(udev_t, pam_console_exec_t, pam_console_t)
 ')
 allow udev_t var_lock_t:dir search;
 allow udev_t var_lock_t:file getattr;

--Boundary-00=_FbFzBOltwB0GvKb--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
