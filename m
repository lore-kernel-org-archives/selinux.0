Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u41IIDpt005806
 for <selinux@tycho.nsa.gov>; Sun, 1 May 2016 14:18:14 -0400
Received: from anor.bigon.be (localhost.localdomain [127.0.0.1])
 by anor.bigon.be (Postfix) with ESMTP id BC4CD1A21E
 for <selinux@tycho.nsa.gov>; Sun,  1 May 2016 20:18:06 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
 by anor.bigon.be (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id YZvo5d2UnPm3 for <selinux@tycho.nsa.gov>;
 Sun,  1 May 2016 20:18:04 +0200 (CEST)
Received: from fornost.bigon.be (unknown
 [IPv6:2a02:578:85fc:1:226:18ff:fe08:6073])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate) (Authenticated sender: bigon)
 by anor.bigon.be (Postfix) with ESMTPSA id DC6081A218
 for <selinux@tycho.nsa.gov>; Sun,  1 May 2016 20:18:03 +0200 (CEST)
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH] Fix multiple spelling errors
Date: Sun,  1 May 2016 20:18:03 +0200
Message-Id: <1462126683-15704-1-git-send-email-bigon@debian.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Laurent Bigonville <bigon@bigon.be>

Thanks to the lintian utility from Debian
---
 libselinux/man/man3/avc_add_callback.3   | 4 ++--
 libselinux/man/man3/avc_has_perm.3       | 2 +-
 libselinux/man/man3/is_selinux_enabled.3 | 2 +-
 libsemanage/include/semanage/handle.h    | 2 +-
 libsemanage/src/database.h               | 2 +-
 libsepol/cil/src/cil_find.c              | 2 +-
 policycoreutils/sandbox/seunshare.8      | 2 +-
 7 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/libselinux/man/man3/avc_add_callback.3 b/libselinux/man/man3/avc_add_callback.3
index dbfe72d..bdbbadf 100644
--- a/libselinux/man/man3/avc_add_callback.3
+++ b/libselinux/man/man3/avc_add_callback.3
@@ -57,7 +57,7 @@ and will cause any SID to match.
 .I callback
 is the callback function provided by the userspace object manager.  The
 .I event
-argument indicates the security event which occured; the remaining arguments
+argument indicates the security event which occurred; the remaining arguments
 are interpreted according to the event as described below.  The return value
 of the callback should be zero on success, \-1 on error with
 .I errno
@@ -175,7 +175,7 @@ If the userspace AVC is running in threaded mode, callbacks registered via
 may be executed in the context of the netlink handler thread.  This will likely introduce synchronization issues requiring the use of locks.  See
 .BR avc_init (3).
 
-Support for dynamic revocation and retained permissions is mostly unimplemented in the SELinux kernel module.  The only security event that currently gets excercised is
+Support for dynamic revocation and retained permissions is mostly unimplemented in the SELinux kernel module.  The only security event that currently gets exercised is
 .BR AVC_CALLBACK_RESET .
 .
 .SH "AUTHOR"
diff --git a/libselinux/man/man3/avc_has_perm.3 b/libselinux/man/man3/avc_has_perm.3
index 7353952..3e9fca8 100644
--- a/libselinux/man/man3/avc_has_perm.3
+++ b/libselinux/man/man3/avc_has_perm.3
@@ -108,7 +108,7 @@ for the first time.
 Using an uninitialized structure will produce undefined behavior.
 .
 .SH "RETURN VALUE"
-If requested permissions are granted, zero is returned.  If requested permissions are denied or an error occured, \-1 is returned and
+If requested permissions are granted, zero is returned.  If requested permissions are denied or an error occurred, \-1 is returned and
 .I errno
 is set appropriately.
 
diff --git a/libselinux/man/man3/is_selinux_enabled.3 b/libselinux/man/man3/is_selinux_enabled.3
index f02052c..b2df562 100644
--- a/libselinux/man/man3/is_selinux_enabled.3
+++ b/libselinux/man/man3/is_selinux_enabled.3
@@ -3,7 +3,7 @@
 is_selinux_enabled \- check whether SELinux is enabled
 .
 .SH "NAME"
-is_selinux_mls_enabled \- check whether SELinux is enabled for (Multi Level Securty) MLS 
+is_selinux_mls_enabled \- check whether SELinux is enabled for (Multi Level Security) MLS
 .
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
diff --git a/libsemanage/include/semanage/handle.h b/libsemanage/include/semanage/handle.h
index 6cad529..c816590 100644
--- a/libsemanage/include/semanage/handle.h
+++ b/libsemanage/include/semanage/handle.h
@@ -130,7 +130,7 @@ int semanage_commit(semanage_handle_t *);
 #define SEMANAGE_CAN_READ 1
 #define SEMANAGE_CAN_WRITE 2
 /* returns SEMANAGE_CAN_READ or SEMANAGE_CAN_WRITE if the store is readable
- * or writable, respectively. <0 if an error occured */
+ * or writable, respectively. <0 if an error occurred */
 int semanage_access_check(semanage_handle_t * sh);
 
 /* returns 0 if not connected, 1 if connected */
diff --git a/libsemanage/src/database.h b/libsemanage/src/database.h
index e460379..6a4a164 100644
--- a/libsemanage/src/database.h
+++ b/libsemanage/src/database.h
@@ -148,7 +148,7 @@ typedef struct dbase_table {
 	 * This function must be invoked before using
 	 * any of the database functions above. It may be invoked
 	 * multiple times, and will update the cache if a commit
-	 * occured between invocations */
+	 * occurred between invocations */
 	int (*cache) (struct semanage_handle * handle, dbase_t * dbase);
 
 	/* Forgets all changes that haven't been written
diff --git a/libsepol/cil/src/cil_find.c b/libsepol/cil/src/cil_find.c
index 8e0688c..4134242 100644
--- a/libsepol/cil/src/cil_find.c
+++ b/libsepol/cil/src/cil_find.c
@@ -383,7 +383,7 @@ int cil_find_matching_avrule_in_ast(struct cil_tree_node *current, enum cil_flav
 
 	rc = cil_tree_walk(current, __cil_find_matching_avrule_in_ast, NULL, NULL, &args);
 	if (rc) {
-		cil_log(CIL_ERR, "An error occured while searching for avrule in AST\n");
+		cil_log(CIL_ERR, "An error occurred while searching for avrule in AST\n");
 	}
 
 	return rc;
diff --git a/policycoreutils/sandbox/seunshare.8 b/policycoreutils/sandbox/seunshare.8
index 76b75c8..9e105a1 100644
--- a/policycoreutils/sandbox/seunshare.8
+++ b/policycoreutils/sandbox/seunshare.8
@@ -25,7 +25,7 @@ Allow apps executed within the namespace to use capabilities.  Default is no cap
 Kill all processes with matching MCS level.
 .TP
 \fB\-Z\ context
-Use alternate SELinux context while runing the executable.
+Use alternate SELinux context while running the executable.
 .TP
 \fB\-v\fR
 Verbose output
-- 
2.8.1
