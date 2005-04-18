Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3J0DF7C017967
	for <selinux@tycho.nsa.gov>; Mon, 18 Apr 2005 20:13:16 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3J05tcd024980
	for <selinux@tycho.nsa.gov>; Tue, 19 Apr 2005 00:05:57 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 6103D61AED
	for <selinux@tycho.nsa.gov>; Tue, 19 Apr 2005 08:36:15 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 00861-04 for <selinux@tycho.nsa.gov>;
	Tue, 19 Apr 2005 08:36:14 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id BDC2F61AF1
	for <selinux@tycho.nsa.gov>; Tue, 19 Apr 2005 08:36:12 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
Subject: named strict policy
Date: Mon, 18 Apr 2005 20:29:12 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_7v4YC+XfVH68m++"
Message-Id: <200504182029.15329.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_7v4YC+XfVH68m++
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch is needed to allow named to start correctly in the latest 
rahide.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_7v4YC+XfVH68m++
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- domains/program/named.te.old	2005-04-18 20:26:56.000000000 +1000
+++ domains/program/named.te	2005-04-18 20:27:09.000000000 +1000
@@ -119,6 +119,7 @@
 allow { ndc_t initrc_t } named_conf_t:dir search;
 # Allow init script to cp localtime to named_conf_t
 allow initrc_t named_conf_t:file { setattr write };
+allow initrc_t named_conf_t:dir create_dir_perms;
 ')
 allow { ndc_t initrc_t } named_conf_t:file { getattr read };
 

--Boundary-00=_7v4YC+XfVH68m++--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
