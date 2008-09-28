Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8SGpofj027056
	for <selinux@tycho.nsa.gov>; Sun, 28 Sep 2008 12:51:50 -0400
Received: from mail-gx0-f12.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m8SGpoMA011264
	for <selinux@tycho.nsa.gov>; Sun, 28 Sep 2008 16:51:50 GMT
Received: by gxk5 with SMTP id 5so9996220gxk.18
        for <selinux@tycho.nsa.gov>; Sun, 28 Sep 2008 09:51:50 -0700 (PDT)
Message-ID: <48DFB614.40405@gmail.com>
Date: Sun, 28 Sep 2008 12:51:32 -0400
From: Vikram Noel Ambrose <noel.ambrose@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Joshua Brindle <method@manicmethod.com>
Subject: [autotools][patch] AC_INIT macro fixes
Content-Type: multipart/mixed;
 boundary="------------090500030600030507070508"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090500030600030507070508
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

ChangeLog

1. This patch adds the missing information in the AC_INIT macros
2. Adds object files *.o, *.la, *.lo to .gitignore



--------------090500030600030507070508
Content-Type: text/x-patch;
 name="ac-init-info.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ac-init-info.patch"

Index: selinux-git/checkpolicy/configure.ac
===================================================================
--- selinux-git.orig/checkpolicy/configure.ac	2008-09-03 22:46:37.000000000 -0400
+++ selinux-git/checkpolicy/configure.ac	2008-09-28 12:43:53.000000000 -0400
@@ -2,7 +2,7 @@
 # Process this file with autoconf to produce a configure script.
 
 AC_PREREQ(2.61)
-AC_INIT([checkpolicy], VERSION, BUG-REPORT-ADDRESS)
+AC_INIT([checkpolicy], 2.0.16, selinux@tycho.nsa.gov)
 AM_INIT_AUTOMAKE
 AC_CONFIG_SRCDIR([module_compiler.h])
 AC_CONFIG_HEADER([config.h])
Index: selinux-git/libselinux/configure.ac
===================================================================
--- selinux-git.orig/libselinux/configure.ac	2008-09-26 18:18:16.000000000 -0400
+++ selinux-git/libselinux/configure.ac	2008-09-28 12:41:48.000000000 -0400
@@ -2,7 +2,7 @@
 # Process this file with autoconf to produce a configure script.
 
 AC_PREREQ(2.61)
-AC_INIT([libselinux], [VERSION], BUG-REPORT-ADDRESS)
+AC_INIT([libselinux], [2.0.71], selinux@tycho.nsa.gov)
 AM_INIT_AUTOMAKE
 AC_CONFIG_SRCDIR([utils/compute_create.c])
 AC_CONFIG_HEADER([config.h])
Index: selinux-git/libsemanage/configure.ac
===================================================================
--- selinux-git.orig/libsemanage/configure.ac	2008-09-03 22:46:37.000000000 -0400
+++ selinux-git/libsemanage/configure.ac	2008-09-28 12:44:27.000000000 -0400
@@ -2,7 +2,7 @@
 # Process this file with autoconf to produce a configure script.
 
 AC_PREREQ(2.61)
-AC_INIT(libsemanage, VERSION, BUG-REPORT-ADDRESS)
+AC_INIT(libsemanage, 2.0.28, selinux@tycho.nsa.gov)
 AM_INIT_AUTOMAKE
 AC_CONFIG_SRCDIR([src/modules.c])
 AC_CONFIG_HEADER([config.h])
Index: selinux-git/policycoreutils/configure.ac
===================================================================
--- selinux-git.orig/policycoreutils/configure.ac	2008-09-03 22:46:37.000000000 -0400
+++ selinux-git/policycoreutils/configure.ac	2008-09-28 12:44:51.000000000 -0400
@@ -2,7 +2,7 @@
 # Process this file with autoconf to produce a configure script.
 
 AC_PREREQ(2.61)
-AC_INIT(policycoreutils, VERSION, BUG-REPORT-ADDRESS)
+AC_INIT(policycoreutils, 2.0.57, selinux@tycho.nsa.gov)
 AM_INIT_AUTOMAKE
 AC_CONFIG_SRCDIR([run_init/run_init.c])
 AC_CONFIG_HEADER([config.h])
Index: selinux-git/.gitignore
===================================================================
--- selinux-git.orig/.gitignore	2008-09-28 12:39:17.000000000 -0400
+++ selinux-git/.gitignore	2008-09-28 12:45:14.000000000 -0400
@@ -14,3 +14,6 @@
 ylwrap
 INSTALL
 config.log
+*.o
+*.lo
+*.la
Index: selinux-git/libsepol/configure.ac
===================================================================
--- selinux-git.orig/libsepol/configure.ac	2008-09-03 22:46:37.000000000 -0400
+++ selinux-git/libsepol/configure.ac	2008-09-28 12:46:38.000000000 -0400
@@ -2,7 +2,7 @@
 # Process this file with autoconf to produce a configure script.
 
 AC_PREREQ(2.61)
-AC_INIT([libsepol], [1] BUG-REPORT-ADDRESS)
+AC_INIT([libsepol], 2.0.32, selinux@tycho.nsa.gov)
 AM_INIT_AUTOMAKE
 AC_CONFIG_SRCDIR([utils/chkcon.c])
 AC_CONFIG_HEADER([config.h])
Index: selinux-git/sepolgen/configure.ac
===================================================================
--- selinux-git.orig/sepolgen/configure.ac	2008-08-29 20:40:38.000000000 -0400
+++ selinux-git/sepolgen/configure.ac	2008-09-28 12:49:34.000000000 -0400
@@ -2,7 +2,7 @@
 # Process this file with autoconf to produce a configure script.
 
 AC_PREREQ(2.61)
-AC_INIT(sepolgen, VERSION, BUG-REPORT-ADDRESS)
+AC_INIT(sepolgen, 1.0.14, selinux@tycho.nsa.gov)
 AM_INIT_AUTOMAKE
 
 

--------------090500030600030507070508--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
