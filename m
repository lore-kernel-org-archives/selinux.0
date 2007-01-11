Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0B8QROB021351
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2007 03:26:28 -0500
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l0B8RFqX013982
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2007 08:27:16 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id BAEE661AFF
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2007 19:25:33 +1100 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp.sws.net.au [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id we0G7UCEJKcC for <selinux@tycho.nsa.gov>;
	Thu, 11 Jan 2007 19:25:33 +1100 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id C322F61AF7
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2007 19:25:31 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id 4190920CC3
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2007 19:26:24 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: patch for semanage.8
Date: Thu, 11 Jan 2007 17:42:12 +1100
MIME-Version: 1.0
Message-Id: <200701111742.14991.russell@coker.com.au>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_GxdpFA520xxL8ob"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_GxdpFA520xxL8ob
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch makes the man page more closely match semanage --help.  
This is against the latest version in Debian, I haven't checked whether it's 
needed in rawhide.

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--Boundary-00=_GxdpFA520xxL8ob
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- semanage.8.orig	2007-01-09 17:59:28.000000000 +1100
+++ semanage.8	2007-01-11 16:56:27.000000000 +1100
@@ -7,7 +7,7 @@
 .br
 .B semanage login \-{a|d|m} [\-sr] login_name
 .br
-.B semanage user \-{a|d|m} [\-LrR] selinux_name
+.B semanage user \-{a|d|m} [\-LrRP] selinux_name
 .br
 .B semanage port \-{a|d|m} [\-tr] [\-p protocol] port | port_range
 .br
@@ -45,7 +45,7 @@
 .TP
 .I                \-f, \-\-ftype
 File Type.   This is used with fcontext.
-Requires a file type as shown in the mode field by ls, e.g. use -d to match only directories or -- to match only regular files.
+Requires a file type as shown in the mode field by ls, use -d to match only directories -- for regular files, -c for character devices, -b for block devices, -s for sockets, -l for symbolic links, and -p for pipes.
 .TP
 .I                \-h, \-\-help       
 display this message
@@ -78,7 +78,10 @@
 SELinux Type for the object
 .TP
 .I                \-T, \-\-trans
-SELinux Translation
+SELinux level Translation
+.TP
+.I                \-P, \-\-prefix
+Labelling prefix for the user (sysadm, staff, or user)
 .TP
 .I                \-v, \-\-verbose    
 verbose output

--Boundary-00=_GxdpFA520xxL8ob--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
