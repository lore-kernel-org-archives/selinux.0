Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u0B9Uv73006631
 for <selinux@tycho.nsa.gov>; Mon, 11 Jan 2016 04:30:57 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
 (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
 by mx1.redhat.com (Postfix) with ESMTPS id 22A8EC09FAA9
 for <selinux@tycho.nsa.gov>; Mon, 11 Jan 2016 09:30:55 +0000 (UTC)
From: Lukas Vrabec <lvrabec@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/2] Add description of missing newrole parameter -p in
 newrole man page.
Date: Mon, 11 Jan 2016 10:30:40 +0100
Message-Id: <1452504641-26411-1-git-send-email-lvrabec@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Lukas Vrabec <lvrabec@redhat.com>
---
 policycoreutils/newrole/newrole.1 | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/policycoreutils/newrole/newrole.1 b/policycoreutils/newrole/newrole.1
index c47bc52..3bd57e7 100644
--- a/policycoreutils/newrole/newrole.1
+++ b/policycoreutils/newrole/newrole.1
@@ -8,6 +8,7 @@ newrole \- run a shell with a new SELinux role
 [\fB-t\fR|\fB--type\fR]
 \fITYPE\fR
 [\fB-l\fR|\fB--level\fR]
+[\fB-p\fR|\fB--preserve-environment\fR]
 \fILEVEL\fR [-- [\fIARGS\fR]...]
 .SH DESCRIPTION
 .PP
@@ -38,7 +39,12 @@ specified by
 If
 \fILEVEL\fR
 is a range, the new context will have the sensitivity level and clearance
-specified by that range.
+specified by that range.  If the
+.B -p
+or
+.B --preserve-environment
+option is specified, then shell with new SELinux context will preserve environment variables,
+otherwise new minimal enviroment is created.
 .PP
 Additional arguments
 .I ARGS
-- 
2.5.0
