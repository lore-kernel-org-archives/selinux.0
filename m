Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h7R8X3La008738
	for <selinux@tycho.nsa.gov>; Wed, 27 Aug 2003 04:33:03 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h7R8VZ4F008892
	for <selinux@tycho.nsa.gov>; Wed, 27 Aug 2003 08:31:35 GMT
Received: from sat.sws.net.au (sat.sws.net.au [202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h7R8VWFC008889
	for <selinux@tycho.nsa.gov>; Wed, 27 Aug 2003 08:31:33 GMT
Received: from localhost (localhost [127.0.0.1])
	by sat.sws.net.au (Postfix) with ESMTP id 39A3FC1B4
	for <selinux@tycho.nsa.gov>; Wed, 27 Aug 2003 18:32:59 +1000 (EST)
Received: from sat.sws.net.au ([127.0.0.1])
 by localhost (sat [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 12160-09 for <selinux@tycho.nsa.gov>;
 Wed, 27 Aug 2003 18:32:27 +1000 (EST)
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
	by sat.sws.net.au (Postfix) with ESMTP id 96F68C1B7
	for <selinux@tycho.nsa.gov>; Wed, 27 Aug 2003 18:32:27 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 52D76926F8
	for <selinux@tycho.nsa.gov>; Wed, 27 Aug 2003 18:32:27 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 0CD0B7F0E4
	for <selinux@tycho.nsa.gov>; Wed, 27 Aug 2003 18:32:25 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: patch for is_selinux_enabled()
Date: Wed, 27 Aug 2003 18:32:24 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_YyGT/gaaflLSZ/T"
Message-Id: <200308271832.24542.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_YyGT/gaaflLSZ/T
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch makes getcon() (and therefore is_selinux_enabled()) fail 
when you boot a SE enabled kernel but don't load a policy.

This gives the same result as a change Steve made to the old SE kernel patch 
some time ago.  With this patch if you have installed the PAM module for SE 
Linux support (or a modified login/sshd) and a kernel but not the policy then 
you can still boot the machine and login.

Otherwise booting a SE kernel with patched applications but without a policy 
loaded gives you an unusable system that you can't login to.

Also as a side-affect of this patch programs such as ps and ls will operate as 
if they are on a non-SE system if you boot without policy loaded (which I 
consider to be desirable behavior).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_YyGT/gaaflLSZ/T
Content-Type: text/x-diff;
  charset="us-ascii";
  name="libse.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="libse.diff"

diff -ruN libselinux-1.1.orig/src/getcon.c libselinux-1.1/src/getcon.c
--- libselinux-1.1.orig/src/getcon.c	2003-07-18 00:38:06.000000000 +1000
+++ libselinux-1.1/src/getcon.c	2003-08-27 18:04:41.000000000 +1000
@@ -29,6 +29,11 @@
 	ret = read(fd, buf, size-1);
 	if (ret < 0)
 		goto out2;
+	if(!strcmp(buf, "kernel"))
+	{
+		ret = -1;
+		goto out2;
+	}
 
 	*context = strdup(buf);
 	if (!(*context)) {

--Boundary-00=_YyGT/gaaflLSZ/T--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
