Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r4ACk4RL015878
	for <selinux@tycho.nsa.gov>; Fri, 10 May 2013 08:46:05 -0400
From: Laurent Bigonville <bigon@debian.org>
To: Daniel J Walsh <dwalsh@redhat.com>, Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov
Subject: [PATCH 10/16] checkpolicy: Fix cases where hyphen were used as minus sign in manpages
Date: Fri, 10 May 2013 14:45:18 +0200
Message-Id: <1368189924-8501-11-git-send-email-bigon@debian.org>
In-Reply-To: <1368189924-8501-1-git-send-email-bigon@debian.org>
References: <1368189924-8501-1-git-send-email-bigon@debian.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Laurent Bigonville <bigon@bigon.be>

---
 checkpolicy/checkmodule.8 | 6 +++---
 checkpolicy/checkpolicy.8 | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/checkpolicy/checkmodule.8 b/checkpolicy/checkmodule.8
index 40f73c5..2a7ab5c 100644
--- a/checkpolicy/checkmodule.8
+++ b/checkpolicy/checkmodule.8
@@ -3,7 +3,7 @@
 checkmodule \- SELinux policy module compiler
 .SH SYNOPSIS
 .B checkmodule
-.I "[-h] [-b] [-m] [-M] [-U handle_unknown ] [-V] [-o output_file] [input_file]"
+.I "[\-h] [\-b] [\-m] [\-M] [\-U handle_unknown ] [\-V] [\-o output_file] [input_file]"
 .SH "DESCRIPTION"
 This manual page describes the
 .BR checkmodule
@@ -12,7 +12,7 @@ command.
 .B checkmodule
 is a program that checks and compiles a SELinux security policy module
 into a binary representation.  It can generate either a base policy
-module (default) or a non-base policy module (-m option); typically,
+module (default) or a non-base policy module (\-m option); typically,
 you would build a non-base policy module to add to an existing module
 store that already has a base module provided by the base policy.  Use
 semodule_package to combine this module with its optional file
@@ -48,7 +48,7 @@ Specify how the kernel should handle unknown classes or permissions (deny, allow
 .SH EXAMPLE
 .nf
 # Build a MLS/MCS-enabled non-base policy module.
-$ checkmodule -M -m httpd.te -o httpd.mod
+$ checkmodule \-M \-m httpd.te \-o httpd.mod
 .fi
 
 .SH "SEE ALSO"
diff --git a/checkpolicy/checkpolicy.8 b/checkpolicy/checkpolicy.8
index 6826938..0086bdc 100644
--- a/checkpolicy/checkpolicy.8
+++ b/checkpolicy/checkpolicy.8
@@ -3,7 +3,7 @@
 checkpolicy \- SELinux policy compiler
 .SH SYNOPSIS
 .B checkpolicy
-.I "[-b] [-d] [-M] [-c policyvers] [-o output_file] [input_file]"
+.I "[\-b] [\-d] [\-M] [\-c policyvers] [\-o output_file] [input_file]"
 .br
 .SH "DESCRIPTION"
 This manual page describes the
@@ -14,7 +14,7 @@ command.
 is a program that checks and compiles a SELinux security policy configuration
 into a binary representation that can be loaded into the kernel.  If no 
 input file name is specified, checkpolicy will attempt to read from
-policy.conf or policy, depending on whether the -b flag is specified.
+policy.conf or policy, depending on whether the \-b flag is specified.
 
 .SH OPTIONS
 .TP
-- 
1.8.2.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
