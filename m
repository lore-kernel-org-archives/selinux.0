Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834581F8AC5;
	Mon,  6 Jul 2026 23:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783381903; cv=none; b=F8emKpRcJGW2qvwpDM2PAS6NSMAbQW6yeOHYTyBPftWEeirLKCgh4PbQBKQgDBoKnDYwPzMj52iPGlxTB2ebxibG1pKCpEIOnJnQ0oyAZdxPF1V9vgkAkCGV5hX1gx37Hu0GA67rJ4xCAsyV/BLAx0jMjpo1x9JX07jtUCIjXWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783381903; c=relaxed/simple;
	bh=XOuXlxjhcPVjiOBlY+7Rsq5s+jIToYrBOO6f9uQqEJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JEe9YeuLAAgrYvT4Q3EnDbDT2oOZPFiIIuPMRZHdqbTTPYotU7zsJvuK+73RdgMDtuKlwyhUwxX6RmxeREkO58UaXH6O+2fseCwK4sxEId6gUPlrcZhhr8fCy2mV/OFCi6S/mKaD4WkJa3Gee64IpssnvMxFSLxa558UtZRTcAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TpP7WxjQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TpP7WxjQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CF451F00A3A;
	Mon,  6 Jul 2026 23:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783381902;
	bh=cI7qbCuPEAiKnmhl0vJm7quiCcu8umwfiYblq5tpgHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TpP7WxjQCSjNTxzrckhT0zoNrvjP5VaEZFt8qSpP4DCiFe4UV3uuRZ39vmS90OCUW
	 5rNEaIu/0LPQI4qGGGX8oiesCkh211K03VfLokjaEHyo+fl0wQczV+EW0E6Ot1bbr7
	 bEdBG+cCACotpLxw1wZmFJpjTIXHe/r8r5VorRJjwYvzEWo5sfB9GjPwzdKtNlzqKo
	 w9gofU5vwcVX9sm9HhFTI7lUmYZpSRSaym4K8eIoP0dvikpce2JMRgcmFXxJbjn7mo
	 x31K3HbVdfgj2LKEBj26JT0b/fycYX0/9YriS2N/vZyV5dMRT3ssddmcNiXpzhTT5X
	 O5ZBGpXG8URTQ==
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
Subject: [PATCH v6 7/8] vfs: Replace security_sb_mount/security_move_mount with granular hooks
Date: Mon,  6 Jul 2026 16:50:52 -0700
Message-ID: <20260706235053.4104951-8-song@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706235053.4104951-1-song@kernel.org>
References: <20260706235053.4104951-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the monolithic security_sb_mount() call in path_mount() and
the security_move_mount() call on the mount-move paths with the new
granular mount hooks:

- do_loopback(): call security_mount_bind()
- do_new_mount(): call security_mount_new()
- do_remount(): call security_mount_remount()
- do_reconfigure_mnt(): call security_mount_reconfigure()
- do_change_type(): call security_mount_change_type()
- do_move_mount(): call security_mount_move()
- do_set_group(): call security_mount_move()

The new hooks are called at the individual operation level with
appropriate context (resolved paths, fs_context), rather than at
the top of path_mount() with raw string arguments.

security_mount_bind() and security_mount_move() are called under the
namespace semaphore, after the mountpoint has been resolved and pinned
by LOCK_MOUNT(). This ensures the LSM inspects the mount that will
actually be used, instead of a mountpoint that could be overmounted
between the check and the operation. Placing the move hook in
do_move_mount() and do_set_group() also unifies the old mount(2)
MS_MOVE path (do_move_mount_old()) and the move_mount(2) path
(vfs_move_mount()) on a single call site.

For MOVE_MOUNT_BENEATH, security_mount_move() additionally receives the
mount that ends up on top, so an LSM can tell a plain move (target ==
top) apart from a mount-beneath operation.

Code generated with the assistance of Claude, reviewed by human.

Signed-off-by: Song Liu <song@kernel.org>
---
 fs/namespace.c | 77 +++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 61 insertions(+), 16 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 3d5cd5bf3b05..bc9401a2efac 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2893,6 +2893,10 @@ static int do_change_type(const struct path *path, int ms_flags)
 	if (!type)
 		return -EINVAL;
 
+	err = security_mount_change_type(path, ms_flags);
+	if (err)
+		return err;
+
 	guard(namespace_excl)();
 
 	err = may_change_propagation(mnt);
@@ -3003,6 +3007,7 @@ static int do_loopback(const struct path *path, const char *old_name,
 {
 	struct path old_path __free(path_put) = {};
 	struct mount *mnt = NULL;
+	struct path dest;
 	int err;
 
 	if (!old_name || !*old_name)
@@ -3021,6 +3026,17 @@ static int do_loopback(const struct path *path, const char *old_name,
 	if (!check_mnt(mp.parent))
 		return -EINVAL;
 
+	/*
+	 * Check permission against the mountpoint that was actually pinned
+	 * under the namespace semaphore, rather than the caller-supplied
+	 * @path which may have been overmounted before the lock was taken.
+	 */
+	dest.mnt = &mp.parent->mnt;
+	dest.dentry = mp.mp->m_dentry;
+	err = security_mount_bind(&old_path, &dest, recurse);
+	if (err)
+		return err;
+
 	mnt = __do_loopback(&old_path, recurse, CL_COPY_MNT_NS_FILE);
 	if (IS_ERR(mnt))
 		return PTR_ERR(mnt);
@@ -3335,7 +3351,8 @@ static void mnt_warn_timestamp_expiry(const struct path *mountpoint,
  * superblock it refers to.  This is triggered by specifying MS_REMOUNT|MS_BIND
  * to mount(2).
  */
-static int do_reconfigure_mnt(const struct path *path, unsigned int mnt_flags)
+static int do_reconfigure_mnt(const struct path *path, unsigned int mnt_flags,
+			      unsigned long flags)
 {
 	struct super_block *sb = path->mnt->mnt_sb;
 	struct mount *mnt = real_mount(path->mnt);
@@ -3350,6 +3367,10 @@ static int do_reconfigure_mnt(const struct path *path, unsigned int mnt_flags)
 	if (!can_change_locked_flags(mnt, mnt_flags))
 		return -EPERM;
 
+	ret = security_mount_reconfigure(path, mnt_flags, flags);
+	if (ret)
+		return ret;
+
 	/*
 	 * We're only checking whether the superblock is read-only not
 	 * changing it, so only take down_read(&sb->s_umount).
@@ -3373,7 +3394,7 @@ static int do_reconfigure_mnt(const struct path *path, unsigned int mnt_flags)
  * on it - tough luck.
  */
 static int do_remount(const struct path *path, int sb_flags,
-		      int mnt_flags, void *data)
+		      int mnt_flags, void *data, unsigned long flags)
 {
 	int err;
 	struct super_block *sb = path->mnt->mnt_sb;
@@ -3400,6 +3421,9 @@ static int do_remount(const struct path *path, int sb_flags,
 	fc->oldapi = true;
 
 	err = parse_monolithic_mount_data(fc, data);
+	if (!err)
+		err = security_mount_remount(fc, path, mnt_flags, flags,
+					    data);
 	if (!err) {
 		down_write(&sb->s_umount);
 		err = -EPERM;
@@ -3438,6 +3462,16 @@ static int do_set_group(const struct path *from_path, const struct path *to_path
 
 	guard(namespace_excl)();
 
+	/*
+	 * Setting a sharing group does not overmount anything, so the
+	 * source, target and top mount all refer to @to_path.  The check
+	 * runs under the namespace semaphore for the same reason as the
+	 * move case.
+	 */
+	err = security_mount_move(from_path, to_path, to_path);
+	if (err)
+		return err;
+
 	err = may_change_propagation(from);
 	if (err)
 		return err;
@@ -3634,6 +3668,7 @@ static int do_move_mount(const struct path *old_path,
 			 enum mnt_tree_flags_t flags)
 {
 	struct mount *old = real_mount(old_path->mnt);
+	struct path target, top;
 	int err;
 	bool beneath = flags & MNT_TREE_BENEATH;
 
@@ -3647,6 +3682,17 @@ static int do_move_mount(const struct path *old_path,
 	if (IS_ERR(mp.parent))
 		return PTR_ERR(mp.parent);
 
+	/*
+	 * The destination that was actually pinned under the namespace
+	 * semaphore.  For a plain move the source is attached on top of
+	 * @target, so @target is also the mount that ends up on top; for
+	 * MOVE_MOUNT_BENEATH the source is inserted below the existing top
+	 * mount, which is reported separately below.
+	 */
+	target.mnt = &mp.parent->mnt;
+	target.dentry = mp.mp->m_dentry;
+	top = target;
+
 	if (check_mnt(old)) {
 		/* if the source is in our namespace... */
 		/* ... it should be detachable from parent */
@@ -3687,8 +3733,14 @@ static int do_move_mount(const struct path *old_path,
 		err = can_move_mount_beneath(old, over, &mp);
 		if (err)
 			return err;
+		top.mnt = &over->mnt;
+		top.dentry = over->mnt.mnt_root;
 	}
 
+	err = security_mount_move(old_path, &target, &top);
+	if (err)
+		return err;
+
 	/*
 	 * Don't move a mount tree containing unbindable mounts to a destination
 	 * mount which is shared.
@@ -3793,7 +3845,7 @@ static int do_new_mount_fc(struct fs_context *fc, const struct path *mountpoint,
  */
 static int do_new_mount(const struct path *path, const char *fstype,
 			int sb_flags, int mnt_flags,
-			const char *name, void *data)
+			const char *name, void *data, unsigned long flags)
 {
 	struct file_system_type *type;
 	struct fs_context *fc;
@@ -3837,6 +3889,9 @@ static int do_new_mount(const struct path *path, const char *fstype,
 		err = parse_monolithic_mount_data(fc, data);
 	if (!err && !mount_capable(fc))
 		err = -EPERM;
+
+	if (!err)
+		err = security_mount_new(fc, path, mnt_flags, flags, data);
 	if (!err)
 		err = do_new_mount_fc(fc, path, mnt_flags);
 
@@ -4087,7 +4142,6 @@ int path_mount(const char *dev_name, const struct path *path,
 		const char *type_page, unsigned long flags, void *data_page)
 {
 	unsigned int mnt_flags = 0, sb_flags;
-	int ret;
 
 	/* Discard magic */
 	if ((flags & MS_MGC_MSK) == MS_MGC_VAL)
@@ -4100,9 +4154,6 @@ int path_mount(const char *dev_name, const struct path *path,
 	if (flags & MS_NOUSER)
 		return -EINVAL;
 
-	ret = security_sb_mount(dev_name, path, type_page, flags, data_page);
-	if (ret)
-		return ret;
 	if (!may_mount())
 		return -EPERM;
 	if (flags & SB_MANDLOCK)
@@ -4148,9 +4199,9 @@ int path_mount(const char *dev_name, const struct path *path,
 			    SB_I_VERSION);
 
 	if ((flags & (MS_REMOUNT | MS_BIND)) == (MS_REMOUNT | MS_BIND))
-		return do_reconfigure_mnt(path, mnt_flags);
+		return do_reconfigure_mnt(path, mnt_flags, flags);
 	if (flags & MS_REMOUNT)
-		return do_remount(path, sb_flags, mnt_flags, data_page);
+		return do_remount(path, sb_flags, mnt_flags, data_page, flags);
 	if (flags & MS_BIND)
 		return do_loopback(path, dev_name, flags & MS_REC);
 	if (flags & (MS_SHARED | MS_PRIVATE | MS_SLAVE | MS_UNBINDABLE))
@@ -4159,7 +4210,7 @@ int path_mount(const char *dev_name, const struct path *path,
 		return do_move_mount_old(path, dev_name);
 
 	return do_new_mount(path, type_page, sb_flags, mnt_flags, dev_name,
-			    data_page);
+			    data_page, flags);
 }
 
 int do_mount(const char *dev_name, const char __user *dir_name,
@@ -4554,12 +4605,6 @@ static inline int vfs_move_mount(const struct path *from_path,
 				 const struct path *to_path,
 				 enum mnt_tree_flags_t mflags)
 {
-	int ret;
-
-	ret = security_move_mount(from_path, to_path);
-	if (ret)
-		return ret;
-
 	if (mflags & MNT_TREE_PROPAGATION)
 		return do_set_group(from_path, to_path);
 
-- 
2.53.0-Meta

