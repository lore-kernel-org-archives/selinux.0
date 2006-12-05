Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kB5CgcoI029326
	for <selinux@tycho.nsa.gov>; Tue, 5 Dec 2006 07:42:39 -0500
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kB5Cft8V024249
	for <selinux@tycho.nsa.gov>; Tue, 5 Dec 2006 12:41:57 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: targeted policy patch
Date: Tue, 5 Dec 2006 23:42:13 +1100
Cc: Manoj Srivastava <srivasta@debian.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_mkWdFyfd7xPztFo"
Message-Id: <200612052342.14538.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_mkWdFyfd7xPztFo
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch is needed to quiet mdadm (and programs that do similar 
things) for the case of unlabeled device nodes.  In Debian a typical install 
of etch with SE Linux will result in /dev/.static/dev containing a lot of 
unlabeled device nodes from the root filesystem (through a bind mount).

As for device_t, that's the default type upon creation and the type that new 
device nodes get before we assign a type to them.

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--Boundary-00=_mkWdFyfd7xPztFo
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- modules/kernel/devices.if.orig	2006-12-05 23:35:28.000000000 +1100
+++ modules/kernel/devices.if	2006-12-05 23:38:55.000000000 +1100
@@ -598,9 +598,11 @@
 interface(`dev_dontaudit_getattr_all_blk_files',`
 	gen_require(`
 		attribute device_node;
+		type file_t;
+		type device_t;
 	')
 
-	dontaudit $1 device_node:blk_file getattr;
+	dontaudit $1 { device_node file_t device_t }:blk_file getattr;
 ')
 
 ########################################
@@ -616,9 +618,11 @@
 interface(`dev_getattr_all_chr_files',`
 	gen_require(`
 		attribute device_node;
+		type file_t;
+		type device_t;
 	')
 
-	allow $1 device_node:chr_file getattr;
+	allow $1 { device_node file_t device_t }:chr_file getattr;
 ')
 
 ########################################

--Boundary-00=_mkWdFyfd7xPztFo--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
