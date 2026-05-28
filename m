Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FE43E121D;
	Thu, 28 May 2026 18:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779992819; cv=none; b=j81wWAKn2iPePkrYbYp4SsSTzn6kWr6PSuUXuAaBzIeegTkBumy2rhBtgCpUoSDbkFG4GegDYxYHGWExiNCutBCfFft703LPrg6bwVHUT2RGltUu8EitVcAkE0LK/ete7BgzOhDzNV1DlEFNfRNRuSrMjUWfDVKq6WtgnMIcJVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779992819; c=relaxed/simple;
	bh=9tVyMY4bvHIYU8Qnrce0WCiBk7rOpMXBT5XwkVjV8Bs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GFOaPJWws/pxWaPHPh/DKxtQ8TQw4BhAlECJoNKzMj9cRuQzoitxVg1nPzsDuL2yO/xpnEwAiBeEi0gVzRGgkuRnSiC1G+JwxOGyP39/fkDGUE5/MAWLPKk1qPhQjfjNcgQV7QZFiRcFPTuNQCqHYhzjNbR99wXAMMMLj+UphNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RyxDGY/6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RyxDGY/6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 454D71F000E9;
	Thu, 28 May 2026 18:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779992818;
	bh=E6D8c8zo5pcf/ptb7XHN+GBQ0Ur4niiILkXMgVdJtv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RyxDGY/6kxl57zS2NUMKYGhw6+0YL/EVnYlgqky7YujmjJeh4Bpa/++0le29IfKS2
	 L9N8gSQFK7dQIknV7PesznKte/faMo43Jfu/7WGj56L7UoZOimPJKWOcuKOgNLocl5
	 v67yW450P3xg3CjZrRc4/b3R4w+0xw0JoMZP3pKC/0tn5y/3wuQgKsK2QykC5313MI
	 CF6aWEJXoO5R1TPBYpnafH1flZo4z6ped+s7PmV3R+6XTJHK9yLyiZiLMXSifMhwVe
	 6+DFQ4IQmTSggZ+tIAtWTBDXXjDxC4wCCEacHjzl+j+DcJj3YDcZTBB+wwYzaV4j7M
	 AOsvEwV8EKnuA==
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
Subject: [PATCH v5 7/8] vfs: Replace security_sb_mount/security_move_mount with granular hooks
Date: Thu, 28 May 2026 11:26:06 -0700
Message-ID: <20260528182607.3150386-8-song@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260528182607.3150386-1-song@kernel.org>
References: <20260528182607.3150386-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the monolithic security_sb_mount() call in path_mount() and
security_move_mount() in vfs_move_mount() with the new granular mount
hooks:

- do_loopback(): call security_mount_bind()
- do_new_mount(): call security_mount_new()
- do_remount(): call security_mount_remount()
- do_reconfigure_mnt(): call security_mount_reconfigure()
- do_move_mount_old(): call security_mount_move()
- do_change_type(): call security_mount_change_type()
- vfs_move_mount(): replace security_move_mount() with
  security_mount_move()

The new hooks are called at the individual operation level with
appropriate context (resolved paths, fs_context), rather than at
the top of path_mount() with raw string arguments.

Code generated with the assistance of Claude, reviewed by human.

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com> # for selinux only
Signed-off-by: Song Liu <song@kernel.org>
---
 fs/namespace.c | 41 ++++++++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 11 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index fe919abd2f01..43f22c5e2bf4 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2888,6 +2888,10 @@ static int do_change_type(const struct path *path, int ms_flags)
 	if (!type)
 		return -EINVAL;
 
+	err = security_mount_change_type(path, ms_flags);
+	if (err)
+		return err;
+
 	guard(namespace_excl)();
 
 	err = may_change_propagation(mnt);
@@ -3006,6 +3010,10 @@ static int do_loopback(const struct path *path, const char *old_name,
 	if (err)
 		return err;
 
+	err = security_mount_bind(&old_path, path, recurse);
+	if (err)
+		return err;
+
 	if (mnt_ns_loop(old_path.dentry))
 		return -EINVAL;
 
@@ -3328,7 +3336,8 @@ static void mnt_warn_timestamp_expiry(const struct path *mountpoint,
  * superblock it refers to.  This is triggered by specifying MS_REMOUNT|MS_BIND
  * to mount(2).
  */
-static int do_reconfigure_mnt(const struct path *path, unsigned int mnt_flags)
+static int do_reconfigure_mnt(const struct path *path, unsigned int mnt_flags,
+			      unsigned long flags)
 {
 	struct super_block *sb = path->mnt->mnt_sb;
 	struct mount *mnt = real_mount(path->mnt);
@@ -3343,6 +3352,10 @@ static int do_reconfigure_mnt(const struct path *path, unsigned int mnt_flags)
 	if (!can_change_locked_flags(mnt, mnt_flags))
 		return -EPERM;
 
+	ret = security_mount_reconfigure(path, mnt_flags, flags);
+	if (ret)
+		return ret;
+
 	/*
 	 * We're only checking whether the superblock is read-only not
 	 * changing it, so only take down_read(&sb->s_umount).
@@ -3366,7 +3379,7 @@ static int do_reconfigure_mnt(const struct path *path, unsigned int mnt_flags)
  * on it - tough luck.
  */
 static int do_remount(const struct path *path, int sb_flags,
-		      int mnt_flags, void *data)
+		      int mnt_flags, void *data, unsigned long flags)
 {
 	int err;
 	struct super_block *sb = path->mnt->mnt_sb;
@@ -3393,6 +3406,9 @@ static int do_remount(const struct path *path, int sb_flags,
 	fc->oldapi = true;
 
 	err = parse_monolithic_mount_data(fc, data);
+	if (!err)
+		err = security_mount_remount(fc, path, mnt_flags, flags,
+					    data);
 	if (!err) {
 		down_write(&sb->s_umount);
 		err = -EPERM;
@@ -3708,6 +3724,10 @@ static int do_move_mount_old(const struct path *path, const char *old_name)
 	if (err)
 		return err;
 
+	err = security_mount_move(&old_path, path);
+	if (err)
+		return err;
+
 	return do_move_mount(&old_path, path, 0);
 }
 
@@ -3786,7 +3806,7 @@ static int do_new_mount_fc(struct fs_context *fc, const struct path *mountpoint,
  */
 static int do_new_mount(const struct path *path, const char *fstype,
 			int sb_flags, int mnt_flags,
-			const char *name, void *data)
+			const char *name, void *data, unsigned long flags)
 {
 	struct file_system_type *type;
 	struct fs_context *fc;
@@ -3830,6 +3850,9 @@ static int do_new_mount(const struct path *path, const char *fstype,
 		err = parse_monolithic_mount_data(fc, data);
 	if (!err && !mount_capable(fc))
 		err = -EPERM;
+
+	if (!err)
+		err = security_mount_new(fc, path, mnt_flags, flags, data);
 	if (!err)
 		err = do_new_mount_fc(fc, path, mnt_flags);
 
@@ -4080,7 +4103,6 @@ int path_mount(const char *dev_name, const struct path *path,
 		const char *type_page, unsigned long flags, void *data_page)
 {
 	unsigned int mnt_flags = 0, sb_flags;
-	int ret;
 
 	/* Discard magic */
 	if ((flags & MS_MGC_MSK) == MS_MGC_VAL)
@@ -4093,9 +4115,6 @@ int path_mount(const char *dev_name, const struct path *path,
 	if (flags & MS_NOUSER)
 		return -EINVAL;
 
-	ret = security_sb_mount(dev_name, path, type_page, flags, data_page);
-	if (ret)
-		return ret;
 	if (!may_mount())
 		return -EPERM;
 	if (flags & SB_MANDLOCK)
@@ -4141,9 +4160,9 @@ int path_mount(const char *dev_name, const struct path *path,
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
@@ -4152,7 +4171,7 @@ int path_mount(const char *dev_name, const struct path *path,
 		return do_move_mount_old(path, dev_name);
 
 	return do_new_mount(path, type_page, sb_flags, mnt_flags, dev_name,
-			    data_page);
+			    data_page, flags);
 }
 
 int do_mount(const char *dev_name, const char __user *dir_name,
@@ -4545,7 +4564,7 @@ static inline int vfs_move_mount(const struct path *from_path,
 {
 	int ret;
 
-	ret = security_move_mount(from_path, to_path);
+	ret = security_mount_move(from_path, to_path);
 	if (ret)
 		return ret;
 
-- 
2.53.0-Meta

