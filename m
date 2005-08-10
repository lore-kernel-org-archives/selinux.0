Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7AB5KOb000483
	for <selinux@tycho.nsa.gov>; Wed, 10 Aug 2005 07:05:21 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j7AAuME7008906
	for <selinux@tycho.nsa.gov>; Wed, 10 Aug 2005 10:56:24 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 3B5B961B0E
	for <selinux@tycho.nsa.gov>; Wed, 10 Aug 2005 20:57:20 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 29597-02 for <selinux@tycho.nsa.gov>;
	Wed, 10 Aug 2005 20:57:20 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id D8EC361B0C
	for <selinux@tycho.nsa.gov>; Wed, 10 Aug 2005 20:57:19 +1000 (EST)
Received: from intranet.corp.redhat.com (intranet.corp.redhat.com [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id B8CA01B
	for <selinux@tycho.nsa.gov>; Wed, 10 Aug 2005 20:57:18 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: radvd.te
Date: Wed, 10 Aug 2005 20:57:15 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_O2d+CQqaYxORmll"
Message-Id: <200508102057.18407.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_O2d+CQqaYxORmll
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch corrects a typo.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_O2d+CQqaYxORmll
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- domains/program/radvd.te.orig	2005-08-10 20:15:34.000000000 +1000
+++ domains/program/radvd.te	2005-08-10 20:16:13.000000000 +1000
@@ -15,7 +15,7 @@
 
 allow radvd_t self:{ rawip_socket unix_dgram_socket } rw_socket_perms;
 
-allow radvd_t self:capability { setgid setuid net_raw setgid };
+allow radvd_t self:capability { setgid setuid net_raw };
 allow radvd_t self:{ unix_dgram_socket rawip_socket } create;
 allow radvd_t self:unix_stream_socket create_socket_perms;
 

--Boundary-00=_O2d+CQqaYxORmll--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
