Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j636jIgA010358
	for <selinux@tycho.nsa.gov>; Sun, 3 Jul 2005 02:45:18 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j636hAfe023604
	for <selinux@tycho.nsa.gov>; Sun, 3 Jul 2005 06:43:10 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id j636hnbh027636
	for <selinux@tycho.nsa.gov>; Sun, 3 Jul 2005 02:43:49 -0400
Received: from aeon.coker.com.au (sebastian-int.corp.redhat.com [172.16.52.221])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j636hmu14147
	for <selinux@tycho.nsa.gov>; Sun, 3 Jul 2005 02:43:48 -0400
Received: from aeon (aeon [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id ADAC42710D
	for <selinux@tycho.nsa.gov>; Sun,  3 Jul 2005 16:43:46 +1000 (EST)
Subject: catman policy
From: Russell Coker <rcoker@redhat.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary="=-oZexBkFhDf1OU0OgYyTc"
Date: Sun, 03 Jul 2005 16:43:46 +1000
Message-Id: <1120373026.3305.26.camel@aeon>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-oZexBkFhDf1OU0OgYyTc
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Some time ago Paul Moore pointed out a minor weakness in policy to me.

Currently we allow every userdomain to create catman_t files and write
to catman_t directories.  This means that a hostile user who gets UID 0
and any SE Linux user role to write to catman and apropos files.  This
can result in man and apropos returning inappropriate results.  Also if
there is a bug in the man program then it could be exploited by the
corrupted catman files to take over the session of the other user.

This possible attack method has occurred to other people, the risk
(combined with the small benefit of catman on hardware manufactured
later than 1995) has led to Red Hat, Debian, and presumably most other
distributions not having a SUID or SGID man program (thus preventing the
use of catman).

This combination of factors leads me to the conclusion that the policy
regarding catman_t is not needed, and is a bad idea.

I have attached a patch to remove it.

Note that this does give system_crond_t marginally more access than it
had before (it can write to all man pages instead of just catman pages).
I don't think that this is a problem, writing bogus catman pages can be
used to prevent the access of the real man pages anyway.

--=-oZexBkFhDf1OU0OgYyTc
Content-Disposition: attachment; filename=diff
Content-Type: text/plain; name=diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- types/file.te.orig	2005-07-03 16:23:21.000000000 +1000
+++ types/file.te	2005-07-03 16:23:41.000000000 +1000
@@ -216,11 +216,6 @@
 type wtmp_t, file_type, sysadmfile, logfile;
 
 #
-# catman_t is the type for /var/catman.
-#
-type catman_t, file_type, sysadmfile, tmpfile;
-
-#
 # cron_spool_t is the type for /var/spool/cron.
 #
 type cron_spool_t, file_type, sysadmfile;
@@ -244,6 +239,7 @@
 # man_t is the type for the man directories.
 #
 type man_t, file_type, sysadmfile;
+typealias man_t alias catman_t;
 
 #
 # readable_t is a general type for
--- macros/base_user_macros.te.orig	2005-07-03 16:24:13.000000000 +1000
+++ macros/base_user_macros.te	2005-07-03 16:25:36.000000000 +1000
@@ -145,10 +145,6 @@
 allow $1_t cardmgr_var_run_t:file { getattr read };
 ')
 
-# Read and write /var/catman.
-allow $1_t catman_t:dir rw_dir_perms;
-allow $1_t catman_t:file create_file_perms;
-
 # Modify mail spool file.
 allow $1_t mail_spool_t:dir r_dir_perms;
 allow $1_t mail_spool_t:file rw_file_perms;
--- file_contexts/types.fc.orig	2005-07-03 16:27:26.000000000 +1000
+++ file_contexts/types.fc	2005-07-03 16:28:03.000000000 +1000
@@ -68,8 +68,7 @@
 # /var
 #
 /var(/.*)?			system_u:object_r:var_t
-/var/catman(/.*)?		system_u:object_r:catman_t
-/var/cache/man(/.*)?		system_u:object_r:catman_t
+/var/cache/man(/.*)?		system_u:object_r:man_t
 /var/yp(/.*)?			system_u:object_r:var_yp_t
 /var/lib(/.*)?			system_u:object_r:var_lib_t
 /var/lib/nfs(/.*)?		system_u:object_r:var_lib_nfs_t
--- domains/program/crond.te.orig	2005-07-03 16:28:33.000000000 +1000
+++ domains/program/crond.te	2005-07-03 16:28:56.000000000 +1000
@@ -128,9 +128,8 @@
 allow system_crond_t var_lib_t:file create_file_perms;
 
 # Update whatis files.
-allow system_crond_t catman_t:dir create_dir_perms;
-allow system_crond_t catman_t:file create_file_perms;
-allow system_crond_t man_t:file r_file_perms;
+allow system_crond_t man_t:dir create_dir_perms;
+allow system_crond_t man_t:file create_file_perms;
 allow system_crond_t man_t:lnk_file read;
 
 # Write /var/lock/makewhatis.lock.

--=-oZexBkFhDf1OU0OgYyTc--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
