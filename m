Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681AB319859;
	Fri, 15 May 2026 20:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778875346; cv=none; b=B5FsLnXX4ohWwaveclmU8Ri+RumY14tXay1eUHD6TdutxP9wfpCaB3+DATQSJy2Hm+kaDD4UBTBIZWfRh+8l0VX2ivGEDNPN1F2Nnboj9wCtR30WhH+2y2D/9Ql2UNcVZ1iESmi1bizT6ve0l8OoVPbhFJfkY+k+r+uC1mavC6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778875346; c=relaxed/simple;
	bh=Y0gPuwYpANZz2TeKwRKvm0LwrP6QIGLkR2rBec5wm04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UgJ4OCAwcU4/6hZeotuA1L0kPZGykW5EGZbK0m6Am6OcIJ7CQdxtC5mBmNaQQDqSU6NDGEVm+DoKwPrS/PkMnT5UBI1t84M7A00JCq8pbMIQWe1rBpNA8ip8ZuUxucO7+ZqKSDizrwuyQnfDGNORLmD3WN5ALXKH77qBfO6X4F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZnLrJVG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZnLrJVG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADBBBC2BCB0;
	Fri, 15 May 2026 20:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778875346;
	bh=Y0gPuwYpANZz2TeKwRKvm0LwrP6QIGLkR2rBec5wm04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VZnLrJVGmDqpnGrSaNkwlQEFcymm3H1t+2YW+eWWgTLZcWGsauIzHqHvv64GWQbm+
	 Oxns5MV1Glf5c5llHSX46iJjEbnq5ica6aQ4OBvbWuceb/liPvoAoJXFyHiO9YJ6CZ
	 EBxBF29f1CCVNhlwME8Slij6geFeuB+GH+giP9IQH5dGbB3Hzxu32ERO+2HkNiuKEN
	 wrjrkfc+LtbEvIX+yl2aCDroIncV+behjQ3SiT47/TZ6ybaXhOgKWrr0N7QGeKfSEL
	 95LjTycgCgJGltyH/ETtQrNtrnMNn+qEvE2tDSXT3Le7Ihsmp4hx7oZ53g5MBxz3ad
	 PyWeqdiuahXpw==
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
Subject: [PATCH v4 4/7] selinux: Convert from sb_mount to granular mount hooks
Date: Fri, 15 May 2026 13:01:55 -0700
Message-ID: <20260515200158.4081915-5-song@kernel.org>
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

Replace selinux_mount() with granular mount hooks, preserving the
same permission checks:

- mount_bind, mount_new, mount_change_type: FILE__MOUNTON
- mount_remount, mount_reconfigure: FILESYSTEM__REMOUNT
- mount_move: FILE__MOUNTON (reuses selinux_move_mount)

The flags and data parameters are unused by SELinux.

Code generated with the assistance of Claude, reviewed by human.

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Signed-off-by: Song Liu <song@kernel.org>
---
 security/selinux/hooks.c | 49 ++++++++++++++++++++++++++++------------
 1 file changed, 35 insertions(+), 14 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 0f704380a8c8..c8de175bde04 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2802,19 +2802,37 @@ static int selinux_sb_statfs(struct dentry *dentry)
 	return superblock_has_perm(cred, dentry->d_sb, FILESYSTEM__GETATTR, &ad);
 }
 
-static int selinux_mount(const char *dev_name,
-			 const struct path *path,
-			 const char *type,
-			 unsigned long flags,
-			 void *data)
+static int selinux_mount_bind(const struct path *from, const struct path *to,
+			      bool recurse)
 {
-	const struct cred *cred = current_cred();
+	return path_has_perm(current_cred(), to, FILE__MOUNTON);
+}
 
-	if (flags & MS_REMOUNT)
-		return superblock_has_perm(cred, path->dentry->d_sb,
-					   FILESYSTEM__REMOUNT, NULL);
-	else
-		return path_has_perm(cred, path, FILE__MOUNTON);
+static int selinux_mount_new(struct fs_context *fc, const struct path *mp,
+			     int mnt_flags, unsigned long flags, void *data)
+{
+	return path_has_perm(current_cred(), mp, FILE__MOUNTON);
+}
+
+static int selinux_mount_remount(struct fs_context *fc, const struct path *mp,
+				 int mnt_flags, unsigned long flags,
+				 void *data)
+{
+	return superblock_has_perm(current_cred(), fc->root->d_sb,
+				   FILESYSTEM__REMOUNT, NULL);
+}
+
+static int selinux_mount_reconfigure(const struct path *mp,
+				     unsigned int mnt_flags,
+				     unsigned long flags)
+{
+	return superblock_has_perm(current_cred(), mp->dentry->d_sb,
+				   FILESYSTEM__REMOUNT, NULL);
+}
+
+static int selinux_mount_change_type(const struct path *mp, int ms_flags)
+{
+	return path_has_perm(current_cred(), mp, FILE__MOUNTON);
 }
 
 static int selinux_move_mount(const struct path *from_path,
@@ -7558,13 +7576,16 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(sb_kern_mount, selinux_sb_kern_mount),
 	LSM_HOOK_INIT(sb_show_options, selinux_sb_show_options),
 	LSM_HOOK_INIT(sb_statfs, selinux_sb_statfs),
-	LSM_HOOK_INIT(sb_mount, selinux_mount),
+	LSM_HOOK_INIT(mount_bind, selinux_mount_bind),
+	LSM_HOOK_INIT(mount_new, selinux_mount_new),
+	LSM_HOOK_INIT(mount_remount, selinux_mount_remount),
+	LSM_HOOK_INIT(mount_reconfigure, selinux_mount_reconfigure),
+	LSM_HOOK_INIT(mount_change_type, selinux_mount_change_type),
+	LSM_HOOK_INIT(mount_move, selinux_move_mount),
 	LSM_HOOK_INIT(sb_umount, selinux_umount),
 	LSM_HOOK_INIT(sb_set_mnt_opts, selinux_set_mnt_opts),
 	LSM_HOOK_INIT(sb_clone_mnt_opts, selinux_sb_clone_mnt_opts),
 
-	LSM_HOOK_INIT(move_mount, selinux_move_mount),
-
 	LSM_HOOK_INIT(dentry_init_security, selinux_dentry_init_security),
 	LSM_HOOK_INIT(dentry_create_files_as, selinux_dentry_create_files_as),
 
-- 
2.53.0-Meta

