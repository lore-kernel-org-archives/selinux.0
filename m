Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3P8OVgA029129
	for <selinux@tycho.nsa.gov>; Mon, 25 Apr 2005 04:24:31 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3P8G4Yj027111
	for <selinux@tycho.nsa.gov>; Mon, 25 Apr 2005 08:16:06 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id A652961AD8
	for <selinux@tycho.nsa.gov>; Mon, 25 Apr 2005 18:16:55 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 09658-01 for <selinux@tycho.nsa.gov>;
	Mon, 25 Apr 2005 18:16:55 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 23F6861AD7
	for <selinux@tycho.nsa.gov>; Mon, 25 Apr 2005 18:16:55 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>
Subject: fsadm_t policy patch
Date: Mon, 25 Apr 2005 18:17:25 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ZeKbCCSeVXukNHV"
Message-Id: <200504251817.29055.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_ZeKbCCSeVXukNHV
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch is needed by the latest version of fdisk.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_ZeKbCCSeVXukNHV
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- domains/program/fsadm.te.orig	2005-04-25 18:06:59.000000000 +1000
+++ domains/program/fsadm.te	2005-04-25 18:07:02.000000000 +1000
@@ -100,7 +100,7 @@
 allow fsadm_t kernel_t:system syslog_console;
 
 # Access terminals.
-allow fsadm_t { initrc_devpts_t admin_tty_type }:chr_file rw_file_perms;
+allow fsadm_t { initrc_devpts_t admin_tty_type devtty_t }:chr_file rw_file_perms;
 ifdef(`gnome-pty-helper.te', `allow fsadm_t sysadm_gph_t:fd use;')
 allow fsadm_t privfd:fd use;
 allow fsadm_t devpts_t:dir { getattr search };

--Boundary-00=_ZeKbCCSeVXukNHV--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
