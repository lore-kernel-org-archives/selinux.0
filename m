Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u1LFZfwb012842
 for <selinux@tycho.nsa.gov>; Sun, 21 Feb 2016 10:35:43 -0500
From: Richard Haines <richard_c_haines@btinternet.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libselinux: selinux_restorecon.3 man page corrections.
Date: Sun, 21 Feb 2016 15:35:29 +0000
Message-Id: <1456068929-20352-1-git-send-email-richard_c_haines@btinternet.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Fix typo's and clarify usage.

Reported-by: Nicolas Iooss <nicolas.iooss@m4x.org>
Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 libselinux/man/man3/selinux_restorecon.3 | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/libselinux/man/man3/selinux_restorecon.3 b/libselinux/man/man3/selinux_restorecon.3
index 152b29c..0293c4d 100644
--- a/libselinux/man/man3/selinux_restorecon.3
+++ b/libselinux/man/man3/selinux_restorecon.3
@@ -6,7 +6,7 @@ selinux_restorecon \- restore file(s) default SELinux security contexts
 .SH "SYNOPSIS"
 .B #include <selinux/restorecon.h>
 .sp
-.BI "int selinux_restorecon(const char **" pathname ,
+.BI "int selinux_restorecon(const char *" pathname ,
 .in +\w'int selinux_restorecon('u
 .br
 .BI "unsigned int " restorecon_flags ");"
@@ -14,7 +14,10 @@ selinux_restorecon \- restore file(s) default SELinux security contexts
 .
 .SH "DESCRIPTION"
 .BR selinux_restorecon ()
-restores file default security contexts based on:
+restores file default security contexts on filesystems that support extended
+attributes (see
+.BR xattr (7)),
+based on:
 .sp
 .RS
 .IR pathname
@@ -40,7 +43,7 @@ flag set. If any of the specfiles had been updated, the digest
 will also be updated. However if the digest is the same, no relabeling checks
 will take place (unless the
 .B SELINUX_RESTORECON_IGNORE_DIGEST
-is set).
+flag is set).
 .sp
 .IR restorecon_flags
 contains the labeling option/rules as follows:
@@ -53,7 +56,7 @@ specfiles SHA1 digest. The specfiles digest will be written to the
 .IR security.restorecon_last
 extended attribute once relabeling has been completed successfully provided the
 .B SELINUX_RESTORECON_NOCHANGE
-has not been set.
+flag has not been set.
 .sp
 .B SELINUX_RESTORECON_NOCHANGE
 don't change any file labels (passive check) or update the digest in the
@@ -62,7 +65,7 @@ extended attribute.
 .sp
 .B SELINUX_RESTORECON_SET_SPECFILE_CTX
 If set, reset the files label to match the default specfile context.
-if not set only reset the files "type" component of the context to match the
+If not set only reset the files "type" component of the context to match the
 default specfile context.
 .br
 
@@ -114,8 +117,8 @@ to set the handle to be used by
 .sp
 If the
 .I pathname
-is a directory path, then it is possible to set files/directories to be exluded
-from the path by calling
+is a directory path, then it is possible to set files/directories to be
+excluded from the path by calling
 .BR selinux_restorecon_set_exclude_list (3)
 with a
 .B NULL
@@ -177,15 +180,20 @@ is not set).
 .B /sys
 and in-memory filesystems do not support the
 .IR security.restorecon_last
-extended attribute.
+extended attribute and are automatically excluded from any relabeling checks.
 .sp
 .BR selinux_restorecon ()
-does not check whether the mounted filesystems support the
+does not check whether mounted filesystems support the
 .B seclabel
-option. These should be set by the caller by
+option (i.e. support extended attributes as described in
+.BR xattr (7)).
+To exclude these filesystems from any relabeling checks
 .BR selinux_restorecon_set_exclude_list (3)
-in the
-.IR exclude_list .
+should be called prior to
+.BR selinux_restorecon ()
+with a NULL terminated
+.IR exclude_list
+of these filesystems.
 .
 .SH "SEE ALSO"
 .BR selinux_restorecon_set_sehandle (3),
-- 
2.5.0
