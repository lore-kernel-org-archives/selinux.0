Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB2427E05F;
	Sat,  9 May 2026 01:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778291588; cv=none; b=SFnfjJSBDVwMbIjyc9XuCBMPRF4+Cja8p59m5lKC3BZkqLXHz6G3YVM8VfxC4LvlUhA1y+f0g1/+G4rlw8m1Mw4zc+afJlkzBBhUJA95QrmZhcWHlxn4/+022KCIVyAZvn3lFeTUVwZ6QQL7HmtPOJ/PGqmTfrxxvuHdphiqYJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778291588; c=relaxed/simple;
	bh=flPtFM+VnoNcNw6gVB7Faz+5pOBFgpse98euvUsn3Q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t306IubfdIotQmyBIEgt/aoIHeVbp1q1iU7PAVH8I54O/EPmIPuv2Hsw6UYgzUg3JtYHH/AawS0CXQ/9Xk5sIBEWKrEtgCl6nOP30O05JkIpO8DkVRs+r/UyunakUEOgotS3vOYy+L5kRvngwJ4tLGMOJWNER+c3HQr/I5B/qfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=flfN35i7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="flfN35i7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78890C2BCB4;
	Sat,  9 May 2026 01:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778291588;
	bh=flPtFM+VnoNcNw6gVB7Faz+5pOBFgpse98euvUsn3Q4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=flfN35i79YpBdiFntxIUTFrE9tiopTYpsc3Tcz7jA/2XrL+sCr98tlRpHrytb16Y4
	 tbTeh2qVbwF+jj5/FofVSPI7e/DgZ1dXbIPnQxH2CAIerpl2uX8mK+6jaFsfgwnr6I
	 DbpubAoi49fvYVKL7dy6FtUwuqKyIIuJcwSq0jfKsfNmpUNZpcVnVGln02YWo8dScx
	 4sSXa9/3m6kApB49FJRHDmWKgAvwQWUvbSdT1LM9KPTwiStpx7pcKuzeNLoKNgGvg2
	 892lsLbAUiauhNrE4J3NGMSW0F0hiTXJhTFw12OV6QxOgvbYMYfq/mOQYbyBtp1dg9
	 gyuHzBfgeRgyg==
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
Subject: [PATCH v3 7/7] lsm: Remove security_sb_mount and security_move_mount
Date: Fri,  8 May 2026 18:52:08 -0700
Message-ID: <20260509015208.3853132-8-song@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260509015208.3853132-1-song@kernel.org>
References: <20260509015208.3853132-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that all LSMs have been converted to granular mount hooks,
remove the old hooks:

- security_sb_mount(): removed from lsm_hook_defs.h, security.h,
  security.c, and its call in path_mount().
- security_move_mount(): removed and replaced by security_mount_move()
  in do_move_mount(). All LSMs now use mount_move exclusively.

Code generated with the assistance of Claude, reviewed by human.

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com> # for selinux only
Signed-off-by: Song Liu <song@kernel.org>
---
 fs/namespace.c                |  8 --------
 include/linux/lsm_hook_defs.h |  4 ----
 include/linux/security.h      | 16 ---------------
 kernel/bpf/bpf_lsm.c          |  2 --
 security/apparmor/lsm.c       |  1 -
 security/landlock/fs.c        |  1 -
 security/security.c           | 38 -----------------------------------
 security/selinux/hooks.c      |  2 --
 8 files changed, 72 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 04e3bd7f6336..43f22c5e2bf4 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4103,7 +4103,6 @@ int path_mount(const char *dev_name, const struct path *path,
 		const char *type_page, unsigned long flags, void *data_page)
 {
 	unsigned int mnt_flags = 0, sb_flags;
-	int ret;
 
 	/* Discard magic */
 	if ((flags & MS_MGC_MSK) == MS_MGC_VAL)
@@ -4116,9 +4115,6 @@ int path_mount(const char *dev_name, const struct path *path,
 	if (flags & MS_NOUSER)
 		return -EINVAL;
 
-	ret = security_sb_mount(dev_name, path, type_page, flags, data_page);
-	if (ret)
-		return ret;
 	if (!may_mount())
 		return -EPERM;
 	if (flags & SB_MANDLOCK)
@@ -4568,10 +4564,6 @@ static inline int vfs_move_mount(const struct path *from_path,
 {
 	int ret;
 
-	ret = security_move_mount(from_path, to_path);
-	if (ret)
-		return ret;
-
 	ret = security_mount_move(from_path, to_path);
 	if (ret)
 		return ret;
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 98f0fe382665..c870260bf402 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -69,8 +69,6 @@ LSM_HOOK(int, 0, sb_remount, struct super_block *sb, void *mnt_opts)
 LSM_HOOK(int, 0, sb_kern_mount, const struct super_block *sb)
 LSM_HOOK(int, 0, sb_show_options, struct seq_file *m, struct super_block *sb)
 LSM_HOOK(int, 0, sb_statfs, struct dentry *dentry)
-LSM_HOOK(int, 0, sb_mount, const char *dev_name, const struct path *path,
-	 const char *type, unsigned long flags, void *data)
 LSM_HOOK(int, 0, sb_umount, struct vfsmount *mnt, int flags)
 LSM_HOOK(int, 0, sb_pivotroot, const struct path *old_path,
 	 const struct path *new_path)
@@ -79,8 +77,6 @@ LSM_HOOK(int, 0, sb_set_mnt_opts, struct super_block *sb, void *mnt_opts,
 LSM_HOOK(int, 0, sb_clone_mnt_opts, const struct super_block *oldsb,
 	 struct super_block *newsb, unsigned long kern_flags,
 	 unsigned long *set_kern_flags)
-LSM_HOOK(int, 0, move_mount, const struct path *from_path,
-	 const struct path *to_path)
 LSM_HOOK(int, 0, mount_bind, const struct path *from, const struct path *to,
 	 bool recurse)
 LSM_HOOK(int, 0, mount_new, struct fs_context *fc, const struct path *mp,
diff --git a/include/linux/security.h b/include/linux/security.h
index b1b3da51a88d..f1dcfc569cf2 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -373,8 +373,6 @@ int security_sb_remount(struct super_block *sb, void *mnt_opts);
 int security_sb_kern_mount(const struct super_block *sb);
 int security_sb_show_options(struct seq_file *m, struct super_block *sb);
 int security_sb_statfs(struct dentry *dentry);
-int security_sb_mount(const char *dev_name, const struct path *path,
-		      const char *type, unsigned long flags, void *data);
 int security_sb_umount(struct vfsmount *mnt, int flags);
 int security_sb_pivotroot(const struct path *old_path, const struct path *new_path);
 int security_sb_set_mnt_opts(struct super_block *sb,
@@ -385,7 +383,6 @@ int security_sb_clone_mnt_opts(const struct super_block *oldsb,
 				struct super_block *newsb,
 				unsigned long kern_flags,
 				unsigned long *set_kern_flags);
-int security_move_mount(const struct path *from_path, const struct path *to_path);
 int security_mount_bind(const struct path *from, const struct path *to,
 			bool recurse);
 int security_mount_new(struct fs_context *fc, const struct path *mp,
@@ -825,13 +822,6 @@ static inline int security_sb_statfs(struct dentry *dentry)
 	return 0;
 }
 
-static inline int security_sb_mount(const char *dev_name, const struct path *path,
-				    const char *type, unsigned long flags,
-				    void *data)
-{
-	return 0;
-}
-
 static inline int security_sb_umount(struct vfsmount *mnt, int flags)
 {
 	return 0;
@@ -859,12 +849,6 @@ static inline int security_sb_clone_mnt_opts(const struct super_block *oldsb,
 	return 0;
 }
 
-static inline int security_move_mount(const struct path *from_path,
-				      const struct path *to_path)
-{
-	return 0;
-}
-
 static inline int security_mount_bind(const struct path *from,
 				      const struct path *to, bool recurse)
 {
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index aa228372cfb4..77371ca25d09 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -350,7 +350,6 @@ BTF_ID(func, bpf_lsm_release_secctx)
 BTF_ID(func, bpf_lsm_sb_alloc_security)
 BTF_ID(func, bpf_lsm_sb_eat_lsm_opts)
 BTF_ID(func, bpf_lsm_sb_kern_mount)
-BTF_ID(func, bpf_lsm_sb_mount)
 BTF_ID(func, bpf_lsm_sb_remount)
 BTF_ID(func, bpf_lsm_sb_set_mnt_opts)
 BTF_ID(func, bpf_lsm_sb_show_options)
@@ -382,7 +381,6 @@ BTF_ID(func, bpf_lsm_task_setscheduler)
 BTF_ID(func, bpf_lsm_userns_create)
 BTF_ID(func, bpf_lsm_bdev_alloc_security)
 BTF_ID(func, bpf_lsm_bdev_setintegrity)
-BTF_ID(func, bpf_lsm_move_mount)
 BTF_ID(func, bpf_lsm_mount_bind)
 BTF_ID(func, bpf_lsm_mount_new)
 BTF_ID(func, bpf_lsm_mount_remount)
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index e0a8a44c95aa..b0de7f316f51 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1705,7 +1705,6 @@ static struct security_hook_list apparmor_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(capget, apparmor_capget),
 	LSM_HOOK_INIT(capable, apparmor_capable),
 
-	LSM_HOOK_INIT(move_mount, apparmor_move_mount),
 	LSM_HOOK_INIT(mount_bind, apparmor_mount_bind),
 	LSM_HOOK_INIT(mount_new, apparmor_mount_new),
 	LSM_HOOK_INIT(mount_remount, apparmor_mount_remount),
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 4547e736e496..7377f22a165e 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1983,7 +1983,6 @@ static struct security_hook_list landlock_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(mount_reconfigure, hook_mount_reconfigure),
 	LSM_HOOK_INIT(mount_change_type, hook_mount_change_type),
 	LSM_HOOK_INIT(mount_move, hook_move_mount),
-	LSM_HOOK_INIT(move_mount, hook_move_mount),
 	LSM_HOOK_INIT(sb_umount, hook_sb_umount),
 	LSM_HOOK_INIT(sb_remount, hook_sb_remount),
 	LSM_HOOK_INIT(sb_pivotroot, hook_sb_pivotroot),
diff --git a/security/security.c b/security/security.c
index b7ec0ec7af26..bc55ee588c59 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1065,29 +1065,6 @@ int security_sb_statfs(struct dentry *dentry)
 	return call_int_hook(sb_statfs, dentry);
 }
 
-/**
- * security_sb_mount() - Check permission for mounting a filesystem
- * @dev_name: filesystem backing device
- * @path: mount point
- * @type: filesystem type
- * @flags: mount flags
- * @data: filesystem specific data
- *
- * Check permission before an object specified by @dev_name is mounted on the
- * mount point named by @nd.  For an ordinary mount, @dev_name identifies a
- * device if the file system type requires a device.  For a remount
- * (@flags & MS_REMOUNT), @dev_name is irrelevant.  For a loopback/bind mount
- * (@flags & MS_BIND), @dev_name identifies the	pathname of the object being
- * mounted.
- *
- * Return: Returns 0 if permission is granted.
- */
-int security_sb_mount(const char *dev_name, const struct path *path,
-		      const char *type, unsigned long flags, void *data)
-{
-	return call_int_hook(sb_mount, dev_name, path, type, flags, data);
-}
-
 /**
  * security_sb_umount() - Check permission for unmounting a filesystem
  * @mnt: mounted filesystem
@@ -1167,21 +1144,6 @@ int security_sb_clone_mnt_opts(const struct super_block *oldsb,
 }
 EXPORT_SYMBOL(security_sb_clone_mnt_opts);
 
-/**
- * security_move_mount() - Check permissions for moving a mount
- * @from_path: source mount point
- * @to_path: destination mount point
- *
- * Check permission before a mount is moved.
- *
- * Return: Returns 0 if permission is granted.
- */
-int security_move_mount(const struct path *from_path,
-			const struct path *to_path)
-{
-	return call_int_hook(move_mount, from_path, to_path);
-}
-
 /**
  * security_mount_bind() - Check permissions for a bind mount
  * @from: source path
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 864a3ca772c9..c8de175bde04 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7586,8 +7586,6 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(sb_set_mnt_opts, selinux_set_mnt_opts),
 	LSM_HOOK_INIT(sb_clone_mnt_opts, selinux_sb_clone_mnt_opts),
 
-	LSM_HOOK_INIT(move_mount, selinux_move_mount),
-
 	LSM_HOOK_INIT(dentry_init_security, selinux_dentry_init_security),
 	LSM_HOOK_INIT(dentry_create_files_as, selinux_dentry_create_files_as),
 
-- 
2.53.0-Meta

