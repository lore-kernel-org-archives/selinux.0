Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u4A7LT4C015452
 for <selinux@tycho.nsa.gov>; Tue, 10 May 2016 03:21:29 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
 (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8E65DC03BD5F
 for <selinux@tycho.nsa.gov>; Tue, 10 May 2016 07:21:27 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] policycoreutils: update sandbox.8 man page
Date: Tue, 10 May 2016 09:21:21 +0200
Message-Id: <1462864881-8879-1-git-send-email-plautrba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

- Handling of cgroups was remove in de0795a12edfa8c1239c3165bc4d6c566b6875af but
  -c option was still documented in sandbox.8

- Minor formatting fix

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 policycoreutils/sandbox/sandbox.8 | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/policycoreutils/sandbox/sandbox.8 b/policycoreutils/sandbox/sandbox.8
index 0c8cd1e..81f497a 100644
--- a/policycoreutils/sandbox/sandbox.8
+++ b/policycoreutils/sandbox/sandbox.8
@@ -3,11 +3,11 @@
 sandbox \- Run cmd under an SELinux sandbox
 .SH SYNOPSIS
 .B sandbox
-[\-C] [\-c] [\-s] [ \-d DPI ] [\-l level ] [[\-M | \-X]  \-H homedir \-T tempdir ] [\-I includefile ] [ \-W windowmanager ] [ \-w windowsize ] [[\-i file ]...] [ \-t type ] cmd
+[\-C] [\-s] [ \-d DPI ] [\-l level ] [[\-M | \-X]  \-H homedir \-T tempdir ] [\-I includefile ] [ \-W windowmanager ] [ \-w windowsize ] [[\-i file ]...] [ \-t type ] cmd
 
 .br
 .B sandbox
-[\-C] [\-c] [\-s] [ \-d DPI ] [\-l level ] [[\-M | \-X]  \-H homedir \-T tempdir ] [\-I includefile ] [ \-W windowmanager ] [ \-w windowsize ] [[\-i file ]...] [ \-t type ] \-S
+[\-C] [\-s] [ \-d DPI ] [\-l level ] [[\-M | \-X]  \-H homedir \-T tempdir ] [\-I includefile ] [ \-W windowmanager ] [ \-w windowsize ] [[\-i file ]...] [ \-t type ] \-S
 .br
 .SH DESCRIPTION
 .PP
@@ -24,10 +24,10 @@ allows you to run X applications within a sandbox.  These applications will star
 If directories are specified with \-H or \-T the directory will have its context modified with chcon(1) unless a level is specified with \-l.  If the MLS/MCS security level is specified, the user is responsible to set the correct labels.
 .PP
 .TP
-\fB\-h\ \fB\\-\-help\fR
+\fB\-h\ \fB\-\-help\fR
 display usage message
 .TP
-\fB\-H\ \fB\\-\-homedir\fR
+\fB\-H\ \fB\-\-homedir\fR
 Use alternate homedir to mount over your home directory.  Defaults to temporary. Requires \-X or \-M.
 .TP
 \fB\-i\fR \fB\-\-include\fR
@@ -84,9 +84,6 @@ $HOME and /tmp, secondary Xserver, defaults to sandbox_x_t
 \fB\-d\fR \fB\-\-dpi\fR
 Set the DPI value for the sandbox X Server. Defaults to the current X Sever DPI.
 .TP
-\fB\-c\fR \fB\-\-cgroups\fR
-Use control groups to control this copy of sandbox.  Specify parameters in /etc/sysconfig/sandbox. Max memory usage and cpu usage are to be specified in percent. You can specify which CPUs to use by numbering them 0,1,2... etc.
-.TP
 \fB\-C\fR \fB\-\-capabilities\fR Use capabilities within the
 sandbox. By default applications executed within the sandbox will not
 be allowed to use capabilities (setuid apps), with the \-C flag, you
-- 
2.7.4
