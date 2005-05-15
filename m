Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4F6hwgA011986
	for <selinux@tycho.nsa.gov>; Sun, 15 May 2005 02:43:58 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j4F6eYsN000318
	for <selinux@tycho.nsa.gov>; Sun, 15 May 2005 06:40:36 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 70A4461AEC
	for <selinux@tycho.nsa.gov>; Sun, 15 May 2005 03:55:04 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 07162-03 for <selinux@tycho.nsa.gov>;
	Sun, 15 May 2005 03:55:03 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id AA2C761AEB
	for <selinux@tycho.nsa.gov>; Sun, 15 May 2005 03:55:03 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SELinux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
Subject: fixfiles and lost+found
Date: Sun, 15 May 2005 16:40:40 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_s7uhCHQZYSbHrQL"
Message-Id: <200505151640.44051.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_s7uhCHQZYSbHrQL
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The patch named "diff" makes /tmp/lost+found immutable on a "fixfiles relabel" 
operation to avoid removing it.  If /tmp is a mount point for an Ext3 file 
system then something equivalent to this is needed to avoid removing 
the /tmp/lost+found directory.  Another option might be to recreate the 
lost+found directory afterwards, not sure if we want to be recreating it in 
that manner though.

The patch named "types.diff" adds /var/tmp to the list of directories that are 
likely to be mount points.  Also it causes files/directories under the 
lost+found directory not to be relabeled.  I think that it's fairly important 
not to relabel such objects, in many cases objects under the lost+found 
directory lose their name and determining the correct security context will 
be unreasonably difficult.

If we assume that file system corruption is going to either leave the security 
context unchanged or remove it entirely (not change the security context) 
then it MIGHT be acceptable for the administrator to move files from 
lost+found to a directory that is accessable for users who are granted access 
by SE Linux to the files in question.  Then only files of type file_t would 
need to be manually sorted out.

In any case I'm quite sure that no benefit will be achieved by labelling 
objects under the lost+found directory.  As objects are placed there in 
single user mode (IE no program has an open file handle) and only the 
administrator can descend the directory tree the permissions on the top level 
directory should be enough to control access.

Neither of these patches should be immediately applied, we probably need a 
discussion on both.  Of course if no-one makes any comments then we can just 
assume that everyone agrees.  ;)

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_s7uhCHQZYSbHrQL
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- /sbin/fixfiles.orig	2005-05-15 15:45:48.000000000 +1000
+++ /sbin/fixfiles	2005-05-15 15:48:22.000000000 +1000
@@ -124,7 +124,9 @@
 
 fullrelabel() {
     logit "Cleaning out /tmp"
+    test -d /tmp/lost+found && chattr +i /tmp/lost+found
     rm -rf /tmp/.??* /tmp/*
+    test -d /tmp/lost+found && chattr -i /tmp/lost+found
     LogReadOnly
     restore
 }

--Boundary-00=_s7uhCHQZYSbHrQL
Content-Type: text/x-diff;
  charset="us-ascii";
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
+/HOME_ROOT/lost\+found	-d	system_u:object_r:lost_found_t
+/HOME_ROOT/lost\+found/.*	<<none>>
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

--Boundary-00=_s7uhCHQZYSbHrQL--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
