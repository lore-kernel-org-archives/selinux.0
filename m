Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v47B71HQ022944
 for <selinux@tycho.nsa.gov>; Sun, 7 May 2017 07:07:02 -0400
Received: by mail-wr0-f194.google.com with SMTP id 6so4758712wrb.1
 for <selinux@tycho.nsa.gov>; Sun, 07 May 2017 04:06:27 -0700 (PDT)
From: Alan Jenkins <alan.christopher.jenkins@gmail.com>
To: selinux@tycho.nsa.gov
Cc: Alan Jenkins <alan.christopher.jenkins@gmail.com>
Subject: [PATCH 01/10] policycoreutils: fixfiles: tidy up usage(),
 manpage synopsis
Date: Sun,  7 May 2017 12:05:47 +0100
Message-Id: <20170507110556.7740-1-alan.christopher.jenkins@gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Make sure usage() in fixfiles shows all the current options.
It's printed when there's a user error, so it needs to be
helpful!  (Excluding the deprecated option - see below).

manpage:

Remove the deprecated option `-l logfile`.

Add missing space in `restore|[-f] relabel`.

It's not clear why `-R rpmpackagename` was considered optional in the
second invocation.  (If the user omits it, they are just performing the
first invocation).  It desn't match usage() in fixfiles either.

Clean up bolding for `fixfiles onboot`.

Disable justification (troff "adjustment") in the synopsis.  We want the
common options in the different invocations to line up consistently.
---
 policycoreutils/scripts/fixfiles   |  2 +-
 policycoreutils/scripts/fixfiles.8 | 18 +++++++++---------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/fixfiles
index c876432..e416dfc 100755
--- a/policycoreutils/scripts/fixfiles
+++ b/policycoreutils/scripts/fixfiles
@@ -311,7 +311,7 @@ esac
 }
 usage() {
 	echo $"""
-Usage: $0 [-v] [-F] [-N time ] { check | restore| [-f] relabel | verify } [[dir/file] ... ]
+Usage: $0 [-v] [-F] [-B | -N time ] { check | restore | [-f] relabel | verify } [[dir/file] ... ]
 or
 Usage: $0 [-v] [-F] -R rpmpackage[,rpmpackage...] { check | restore | verify }
 or
diff --git a/policycoreutils/scripts/fixfiles.8 b/policycoreutils/scripts/fixfiles.8
index 0099b9b..c58cb7d 100644
--- a/policycoreutils/scripts/fixfiles.8
+++ b/policycoreutils/scripts/fixfiles.8
@@ -3,18 +3,21 @@
 fixfiles \- fix file SELinux security contexts.
 
 .SH "SYNOPSIS"
+.na
 
 .B fixfiles 
-.I [\-v] [\-F] [-B] [ -N time ] [\-l logfile ] { check | restore|[\-f] relabel | verify } [[dir/file] ... ]
+.I [\-v] [\-F] [\-B | \-N time ] { check | restore | [\-f] relabel | verify } [[dir/file] ... ]
 
 .B fixfiles 
-.I [\-v] [\-F] [ \-R rpmpackagename[,rpmpackagename...] ] [\-l logfile ] { check | restore | verify }
+.I [\-v] [\-F] \-R rpmpackagename[,rpmpackagename...] { check | restore | verify }
 
-.B fixfiles 
-.I [\-v] [\-F] \-C PREVIOUS_FILECONTEXT [\-l logfile ] { check | restore | verify }
+.B fixfiles
+.I [\-v] [\-F] \-C PREVIOUS_FILECONTEXT  { check | restore | verify }
+
+.B fixfiles
+.I [-F] [-B] onboot
 
-.B fixfiles [-F] [-B]
-.I onboot
+.ad
 
 .SH "DESCRIPTION"
 This manual page describes the
@@ -40,9 +43,6 @@ will setup the machine to relabel on the next reboot.
 .B \-B
 If specified with onboot, this fixfiles will record the current date in the /.autorelabel file, so that it can be used later to speed up labeling. If used with restore, the restore will only affect files that were modified today.
 .TP
-.B \-l logfile
-Save the output to the specified logfile
-.TP 
 .B \-F
 Force reset of context to match file_context for customizable files
 
-- 
2.9.3
