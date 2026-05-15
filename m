Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D0F2BE639;
	Fri, 15 May 2026 20:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778875357; cv=none; b=Edr0sKhRFZcZR0TIl4XUagSFd1MHsISjxGB+4WYTLwvcRJK3KaMY2rZJiu9bWiU29E2Ez6a0sWGjswMhfb17nfnxXjvCKgz+axzXCltVGP3r6hrmp4QmThcREGRdi1rFchJI57Gk0qSdy18la9itAZm1YyyKs4cYXOy2dti7Ec4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778875357; c=relaxed/simple;
	bh=eo9bhAqLfGYgio4oLLGVCJN/6iZacFBKm2yN4eMXtek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KaZ1YF97s4bloLo7p5Sd4tMfP+I0ZelbuocmhpPgJcAVy+Q/9jVOep7uqdjMzQqiwtvMAw+Y/EpQbR4tgOI3Z9LSV4UakbrrBTMhppy/o3CEs3PHNSGPtt/QJcOYePekpEEiGYHFl0Tk0ORNl8C2h8ZGUFIhvSNqqpuu81hH7zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7/qfVjT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7/qfVjT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B21D0C2BCC7;
	Fri, 15 May 2026 20:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778875357;
	bh=eo9bhAqLfGYgio4oLLGVCJN/6iZacFBKm2yN4eMXtek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S7/qfVjT5GOg9HbqIza4+85QpWo+fNgRzOx00iox5L/uwoz3Qkhzvvbz1l4S0t29G
	 4/B0kyD0tGZc/fXdtU8X/dBtSuawsy/cektKGSH0Nm2JmSNpbPc7xL/mHqGwvxqTm0
	 8uEtVhcrSvPyn2R+h7j1Sxbok/ekkWoCDtJzHh9yTjlNSDX98iFCgpK/7a3cFDO1AE
	 xY0F/lq/sdAjRIpLy2HeCy7k/xIvfq2oYxt5YWLiDzlZvuouBv10rVfEYFWOVG9VFD
	 0exohBkPZs6b2qGurvf33fHaQqSu4oPhV0zEETKdJa2OkUfYSAPi25pcSU1TkoNAZe
	 B68RXDsX0kKpg==
From: Song Liu <song@kernel.org>
To: linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	selinux@vger.kernel.org,
	apparmor@lists.ubuntu.com
Cc: paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	john.johansen@canonical.com,
	stephen.smalley.work@gmail.com,
	omosnace@redhat.com,
	mic@digikod.net,
	gnoack@google.com,
	takedakn@nttdata.co.jp,
	penguin-kernel@I-love.SAKURA.ne.jp,
	herton@canonical.com,
	kernel-team@meta.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v4 6/7] tomoyo: Convert from sb_mount to granular mount hooks
Date: Fri, 15 May 2026 13:01:57 -0700
Message-ID: <20260515200158.4081915-7-song@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260515200158.4081915-1-song@kernel.org>
References: <20260515200158.4081915-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace tomoyo_sb_mount() with granular mount hooks. Each hook
reconstructs the MS_* flags expected by tomoyo_mount_permission()
using the original flags parameter where available.

Key changes:
- mount_bind: passes the pre-resolved source path to
  tomoyo_mount_acl() via a new dev_path parameter, instead of
  re-resolving dev_name via kern_path(). This eliminates a TOCTOU
  vulnerability.
- mount_new, mount_remount, mount_reconfigure: use the original
  mount(2) flags for policy matching.
- mount_move: passes pre-resolved paths for both source and
  destination.
- mount_change_type: passes raw ms_flags directly.

Also removes the unused data_page parameter from
tomoyo_mount_permission().

Code generated with the assistance of Claude, reviewed by human.

Acked-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Song Liu <song@kernel.org>
---
 security/tomoyo/common.h |   2 +-
 security/tomoyo/mount.c  |  31 +++++++----
 security/tomoyo/tomoyo.c | 109 +++++++++++++++++++++++++++++++++++----
 3 files changed, 121 insertions(+), 21 deletions(-)

diff --git a/security/tomoyo/common.h b/security/tomoyo/common.h
index d098cf8aae61..9241034cfede 100644
--- a/security/tomoyo/common.h
+++ b/security/tomoyo/common.h
@@ -1013,7 +1013,7 @@ int tomoyo_mkdev_perm(const u8 operation, const struct path *path,
 		      const unsigned int mode, unsigned int dev);
 int tomoyo_mount_permission(const char *dev_name, const struct path *path,
 			    const char *type, unsigned long flags,
-			    void *data_page);
+			    const struct path *dev_path);
 int tomoyo_open_control(const u8 type, struct file *file);
 int tomoyo_path2_perm(const u8 operation, const struct path *path1,
 		      const struct path *path2);
diff --git a/security/tomoyo/mount.c b/security/tomoyo/mount.c
index 322dfd188ada..82ffe7d02814 100644
--- a/security/tomoyo/mount.c
+++ b/security/tomoyo/mount.c
@@ -70,6 +70,7 @@ static bool tomoyo_check_mount_acl(struct tomoyo_request_info *r,
  * @dir:      Pointer to "struct path".
  * @type:     Name of filesystem type.
  * @flags:    Mount options.
+ * @dev_path: Pre-resolved device/source path. Maybe NULL.
  *
  * Returns 0 on success, negative value otherwise.
  *
@@ -78,11 +79,11 @@ static bool tomoyo_check_mount_acl(struct tomoyo_request_info *r,
 static int tomoyo_mount_acl(struct tomoyo_request_info *r,
 			    const char *dev_name,
 			    const struct path *dir, const char *type,
-			    unsigned long flags)
+			    unsigned long flags,
+			    const struct path *dev_path)
 	__must_hold_shared(&tomoyo_ss)
 {
 	struct tomoyo_obj_info obj = { };
-	struct path path;
 	struct file_system_type *fstype = NULL;
 	const char *requested_type = NULL;
 	const char *requested_dir_name = NULL;
@@ -134,13 +135,23 @@ static int tomoyo_mount_acl(struct tomoyo_request_info *r,
 			need_dev = 1;
 	}
 	if (need_dev) {
-		/* Get mount point or device file. */
-		if (!dev_name || kern_path(dev_name, LOOKUP_FOLLOW, &path)) {
+		if (dev_path) {
+			/* Use pre-resolved path to avoid TOCTOU issues. */
+			obj.path1 = *dev_path;
+			path_get(&obj.path1);
+		} else if (!dev_name) {
 			error = -ENOENT;
 			goto out;
+		} else {
+			struct path path;
+
+			if (kern_path(dev_name, LOOKUP_FOLLOW, &path)) {
+				error = -ENOENT;
+				goto out;
+			}
+			obj.path1 = path;
 		}
-		obj.path1 = path;
-		requested_dev_name = tomoyo_realpath_from_path(&path);
+		requested_dev_name = tomoyo_realpath_from_path(&obj.path1);
 		if (!requested_dev_name) {
 			error = -ENOENT;
 			goto out;
@@ -173,7 +184,7 @@ static int tomoyo_mount_acl(struct tomoyo_request_info *r,
 	if (fstype)
 		put_filesystem(fstype);
 	kfree(requested_type);
-	/* Drop refcount obtained by kern_path(). */
+	/* Drop refcount obtained by kern_path() or path_get(). */
 	if (obj.path1.dentry)
 		path_put(&obj.path1);
 	return error;
@@ -186,13 +197,13 @@ static int tomoyo_mount_acl(struct tomoyo_request_info *r,
  * @path:      Pointer to "struct path".
  * @type:      Name of filesystem type. Maybe NULL.
  * @flags:     Mount options.
- * @data_page: Optional data. Maybe NULL.
+ * @dev_path:  Pre-resolved device/source path. Maybe NULL.
  *
  * Returns 0 on success, negative value otherwise.
  */
 int tomoyo_mount_permission(const char *dev_name, const struct path *path,
 			    const char *type, unsigned long flags,
-			    void *data_page)
+			    const struct path *dev_path)
 {
 	struct tomoyo_request_info r;
 	int error;
@@ -236,7 +247,7 @@ int tomoyo_mount_permission(const char *dev_name, const struct path *path,
 	if (!type)
 		type = "<NULL>";
 	idx = tomoyo_read_lock();
-	error = tomoyo_mount_acl(&r, dev_name, path, type, flags);
+	error = tomoyo_mount_acl(&r, dev_name, path, type, flags, dev_path);
 	tomoyo_read_unlock(idx);
 	return error;
 }
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index c66e02ed8ee3..c93d000acc95 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -6,6 +6,8 @@
  */
 
 #include <linux/lsm_hooks.h>
+#include <linux/fs_context.h>
+#include <uapi/linux/mount.h>
 #include <uapi/linux/lsm.h>
 #include "common.h"
 
@@ -399,20 +401,102 @@ static int tomoyo_path_chroot(const struct path *path)
 }
 
 /**
- * tomoyo_sb_mount - Target for security_sb_mount().
+ * tomoyo_mount_bind - Target for security_mount_bind().
  *
- * @dev_name: Name of device file. Maybe NULL.
- * @path:     Pointer to "struct path".
- * @type:     Name of filesystem type. Maybe NULL.
- * @flags:    Mount options.
- * @data:     Optional data. Maybe NULL.
+ * @from:    Pointer to "struct path".
+ * @to:      Pointer to "struct path".
+ * @recurse: Whether recursive bind mount or not.
  *
  * Returns 0 on success, negative value otherwise.
  */
-static int tomoyo_sb_mount(const char *dev_name, const struct path *path,
-			   const char *type, unsigned long flags, void *data)
+static int tomoyo_mount_bind(const struct path *from, const struct path *to,
+			     bool recurse)
 {
-	return tomoyo_mount_permission(dev_name, path, type, flags, data);
+	unsigned long flags = MS_BIND | (recurse ? MS_REC : 0);
+
+	return tomoyo_mount_permission(NULL, to, NULL, flags, from);
+}
+
+/**
+ * tomoyo_mount_new - Target for security_mount_new().
+ *
+ * @fc:        Pointer to "struct fs_context".
+ * @mp:        Pointer to "struct path".
+ * @mnt_flags: Mount options.
+ * @flags:     Original mount options.
+ * @data:      Optional data. Maybe NULL.
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+static int tomoyo_mount_new(struct fs_context *fc, const struct path *mp,
+			    int mnt_flags, unsigned long flags, void *data)
+{
+	/* Use original MS_* flags for policy matching */
+	return tomoyo_mount_permission(fc->source, mp, fc->fs_type->name,
+				       flags, NULL);
+}
+
+/**
+ * tomoyo_mount_remount - Target for security_mount_remount().
+ *
+ * @fc:        Pointer to "struct fs_context".
+ * @mp:        Pointer to "struct path".
+ * @mnt_flags: Mount options.
+ * @flags:     Original mount options.
+ * @data:      Optional data. Maybe NULL.
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+static int tomoyo_mount_remount(struct fs_context *fc, const struct path *mp,
+				int mnt_flags, unsigned long flags, void *data)
+{
+	/* Use original MS_* flags for policy matching */
+	return tomoyo_mount_permission(NULL, mp, NULL, flags, NULL);
+}
+
+/**
+ * tomoyo_mount_reconfigure - Target for security_mount_reconfigure().
+ *
+ * @mp:        Pointer to "struct path".
+ * @mnt_flags: Mount options.
+ * @flags:     Original mount options.
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+static int tomoyo_mount_reconfigure(const struct path *mp,
+				    unsigned int mnt_flags,
+				    unsigned long flags)
+{
+	/* Use original MS_* flags for policy matching */
+	return tomoyo_mount_permission(NULL, mp, NULL, flags, NULL);
+}
+
+/**
+ * tomoyo_mount_change_type - Target for security_mount_change_type().
+ *
+ * @mp:       Pointer to "struct path".
+ * @ms_flags: Mount options.
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+static int tomoyo_mount_change_type(const struct path *mp, int ms_flags)
+{
+	return tomoyo_mount_permission(NULL, mp, NULL, ms_flags, NULL);
+}
+
+/**
+ * tomoyo_mount_move - Target for security_mount_move().
+ *
+ * @from_path: Pointer to "struct path".
+ * @to_path:   Pointer to "struct path".
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+static int tomoyo_mount_move(const struct path *from_path,
+			     const struct path *to_path)
+{
+	return tomoyo_mount_permission(NULL, to_path, NULL, MS_MOVE,
+				       from_path);
 }
 
 /**
@@ -576,7 +660,12 @@ static struct security_hook_list tomoyo_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(path_chmod, tomoyo_path_chmod),
 	LSM_HOOK_INIT(path_chown, tomoyo_path_chown),
 	LSM_HOOK_INIT(path_chroot, tomoyo_path_chroot),
-	LSM_HOOK_INIT(sb_mount, tomoyo_sb_mount),
+	LSM_HOOK_INIT(mount_bind, tomoyo_mount_bind),
+	LSM_HOOK_INIT(mount_new, tomoyo_mount_new),
+	LSM_HOOK_INIT(mount_remount, tomoyo_mount_remount),
+	LSM_HOOK_INIT(mount_reconfigure, tomoyo_mount_reconfigure),
+	LSM_HOOK_INIT(mount_change_type, tomoyo_mount_change_type),
+	LSM_HOOK_INIT(mount_move, tomoyo_mount_move),
 	LSM_HOOK_INIT(sb_umount, tomoyo_sb_umount),
 	LSM_HOOK_INIT(sb_pivotroot, tomoyo_sb_pivotroot),
 	LSM_HOOK_INIT(socket_bind, tomoyo_socket_bind),
-- 
2.53.0-Meta

