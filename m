Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i812clrT017690
	for <selinux@tycho.nsa.gov>; Tue, 31 Aug 2004 22:38:48 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i812btGh008885
	for <selinux@tycho.nsa.gov>; Wed, 1 Sep 2004 02:37:57 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: automount policy
Date: Wed, 1 Sep 2004 12:38:15 +1000
Cc: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_XYTNB7CNXlx/Arz"
Message-Id: <200409011238.15293.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_XYTNB7CNXlx/Arz
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch is needed for the latest rawhide automount.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_XYTNB7CNXlx/Arz
Content-Type: text/x-diff;
  charset="us-ascii";
  name="automount.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="automount.diff"

--- /usr/src/se/policy/domains/program/unused/automount.te	2004-08-28 12:05:01.000000000 +1000
+++ domains/program/unused/automount.te	2004-09-01 12:36:44.000000000 +1000
@@ -66,4 +66,4 @@
 allow automount_t home_root_t:dir { getattr };
 allow automount_t mnt_t:dir { getattr search };
 
-allow initrc_t automount_etc_t:file getattr;
+allow initrc_t automount_etc_t:file { getattr read };

--Boundary-00=_XYTNB7CNXlx/Arz--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
