Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t0DMXa8j017027
 for <selinux@tycho.nsa.gov>; Tue, 13 Jan 2015 17:33:36 -0500
Received: by mail-ie0-f169.google.com with SMTP id y20so5678965ier.0
 for <selinux@tycho.nsa.gov>; Tue, 13 Jan 2015 14:33:34 -0800 (PST)
From: Mark Salyzyn <salyzyn@android.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] pstore: selinux: add security in-core xattr support for
 pstore and debugfs
Date: Tue, 13 Jan 2015 14:33:18 -0800
Message-Id: <1421188410-2006-1-git-send-email-salyzyn@android.com>
Cc: Mark Salyzyn <salyzyn@android.com>, linux-security-module@vger.kernel.org,
 James Morris <james.l.morris@oracle.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

- add "pstore" and "debugfs" to list of in-core exceptions
- change fstype checks to boolean equation
- change from strncmp to strcmp for checking

Signed-off-by: Mark Salyzyn <salyzyn@android.com>
---
 security/selinux/hooks.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 6da7532..789a7e1 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -401,23 +401,14 @@ static int selinux_is_sblabel_mnt(struct super_block *sb)
 {
 	struct superblock_security_struct *sbsec = sb->s_security;
 
-	if (sbsec->behavior == SECURITY_FS_USE_XATTR ||
-	    sbsec->behavior == SECURITY_FS_USE_TRANS ||
-	    sbsec->behavior == SECURITY_FS_USE_TASK)
-		return 1;
-
-	/* Special handling for sysfs. Is genfs but also has setxattr handler*/
-	if (strncmp(sb->s_type->name, "sysfs", sizeof("sysfs")) == 0)
-		return 1;
-
-	/*
-	 * Special handling for rootfs. Is genfs but supports
-	 * setting SELinux context on in-core inodes.
-	 */
-	if (strncmp(sb->s_type->name, "rootfs", sizeof("rootfs")) == 0)
-		return 1;
-
-	return 0;
+	return sbsec->behavior == SECURITY_FS_USE_XATTR ||
+		sbsec->behavior == SECURITY_FS_USE_TRANS ||
+		sbsec->behavior == SECURITY_FS_USE_TASK ||
+		/* Special handling. Genfs but also in-core setxattr handler */
+		!strcmp(sb->s_type->name, "sysfs") ||
+		!strcmp(sb->s_type->name, "pstore") ||
+		!strcmp(sb->s_type->name, "debugfs") ||
+		!strcmp(sb->s_type->name, "rootfs");
 }
 
 static int sb_finish_set_opts(struct super_block *sb)
-- 
2.2.0.rc0.207.ga3a616c
