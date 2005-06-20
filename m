Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5K6ZDgA022438
	for <selinux@tycho.nsa.gov>; Mon, 20 Jun 2005 02:35:14 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5K6PPs2018932
	for <selinux@tycho.nsa.gov>; Mon, 20 Jun 2005 06:25:26 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 2719F61B02
	for <selinux@tycho.nsa.gov>; Mon, 20 Jun 2005 16:25:58 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 02275-01 for <selinux@tycho.nsa.gov>;
	Mon, 20 Jun 2005 16:25:57 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id B70D061B01
	for <selinux@tycho.nsa.gov>; Mon, 20 Jun 2005 16:25:57 +1000 (EST)
Received: from aeon (aeon [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id 98C5438
	for <selinux@tycho.nsa.gov>; Mon, 20 Jun 2005 16:25:56 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: watchdog policy
Date: Mon, 20 Jun 2005 16:25:50 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_xFmtC1r46mOMMmI"
Message-Id: <200506201625.53660.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_xFmtC1r46mOMMmI
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch is needed to allow the watchdog daemon to set real-time 
priority.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_xFmtC1r46mOMMmI
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- ./domains/program/unused/watchdog.te.orig	2005-06-20 16:23:47.000000000 +1000
+++ ./domains/program/unused/watchdog.te	2005-06-20 16:24:32.000000000 +1000
@@ -12,6 +12,8 @@
 daemon_domain(watchdog, `, privmail')
 type watchdog_device_t, device_type, dev_fs;
 
+allow watchdog_t self:process setsched;
+
 log_domain(watchdog)
 
 allow watchdog_t etc_t:file r_file_perms;

--Boundary-00=_xFmtC1r46mOMMmI--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
