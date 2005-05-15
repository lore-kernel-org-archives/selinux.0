Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4FDTSgA013314
	for <selinux@tycho.nsa.gov>; Sun, 15 May 2005 09:29:28 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j4FDQ2sN013772
	for <selinux@tycho.nsa.gov>; Sun, 15 May 2005 13:26:03 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id E22A561AEC
	for <selinux@tycho.nsa.gov>; Sun, 15 May 2005 10:36:44 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 17805-06 for <selinux@tycho.nsa.gov>;
	Sun, 15 May 2005 10:36:44 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 6CF6061AEB
	for <selinux@tycho.nsa.gov>; Sun, 15 May 2005 10:36:44 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SELinux <selinux@tycho.nsa.gov>
Subject: Re: fixfiles and lost+found
Date: Sun, 15 May 2005 23:26:09 +1000
Cc: Daniel J Walsh <dwalsh@redhat.com>
References: <200505151640.44051.russell@coker.com.au>
In-Reply-To: <200505151640.44051.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_130hCnO7kByw/G1"
Message-Id: <200505152326.13093.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_130hCnO7kByw/G1
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sunday 15 May 2005 16:40, Russell Coker <russell@coker.com.au> wrote:
> The patch named "types.diff" adds /var/tmp to the list of directories that
> are likely to be mount points.  Also it causes files/directories under the
> lost+found directory not to be relabeled.  I think that it's fairly
> important not to relabel such objects, in many cases objects under the
> lost+found directory lose their name and determining the correct security
> context will be unreasonably difficult.

I made a minor mistake in the first version of types.diff, I have attached a 
corrected version.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_130hCnO7kByw/G1
Content-Type: text/x-diff;
  charset="utf-8";
  name="types.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="types.diff"

--- types.fc.orig	2005-05-15 16:30:20.000000000 +1000
+++ types.fc	2005-05-15 16:33:26.000000000 +1000
@@ -439,13 +439,22 @@
 #
 # Lost and found directories.
 #
-/lost\+found(/.*)?		system_u:object_r:lost_found_t
-/usr/lost\+found(/.*)?		system_u:object_r:lost_found_t
-/boot/lost\+found(/.*)?		system_u:object_r:lost_found_t
-HOME_ROOT/lost\+found(/.*)?	system_u:object_r:lost_found_t
-/var/lost\+found(/.*)?		system_u:object_r:lost_found_t
-/tmp/lost\+found(/.*)?		system_u:object_r:lost_found_t
-/usr/local/lost\+found(/.*)?	system_u:object_r:lost_found_t
+/lost\+found		-d	system_u:object_r:lost_found_t
+/lost\+found/.*			<<none>>
+/usr/lost\+found	-d	system_u:object_r:lost_found_t
+/usr/lost\+found/.*		<<none>>
+/boot/lost\+found	-d	system_u:object_r:lost_found_t
+/boot/lost\+found/.*		<<none>>
+HOME_ROOT/lost\+found	-d	system_u:object_r:lost_found_t
+HOME_ROOT/lost\+found/.*	<<none>>
+/var/lost\+found	-d	system_u:object_r:lost_found_t
+/var/lost\+found/.*		<<none>>
+/tmp/lost\+found	-d	system_u:object_r:lost_found_t
+/tmp/lost\+found/.*		<<none>>
+/var/tmp/lost\+found	-d	system_u:object_r:lost_found_t
+/var/tmp/lost\+found/.*		<<none>>
+/usr/local/lost\+found	-d	system_u:object_r:lost_found_t
+/usr/local/lost\+found/.*	<<none>>
 
 #
 # system localization

--Boundary-00=_130hCnO7kByw/G1--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
