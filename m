Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9181340245F;
	Thu, 28 May 2026 18:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779992801; cv=none; b=plan2VbolkdU1ZmokhhI9+qce9eqnoQOi+CyWu6koET4R+6CaWk1N6T9NbQ2pPfU6JPDwHdMa3nGlSBzQgMkgh3miVKzIV/I0cB8k1rYSRI62q3udmLcug39ApMtmmmGZLOIlQh2CC56XS0OG1Mo+fMnF6/DaiushMyMdxgms7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779992801; c=relaxed/simple;
	bh=Y0gPuwYpANZz2TeKwRKvm0LwrP6QIGLkR2rBec5wm04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KedoSn96erNhpY7VoT5uIU3X79WDt1NCGxhoGINDK1Vz5NK4N16bUENuOSJzUonmdLTVmf9TYr5or9UsmiOW5rQa3Bu+7E+JXPNLzpIFdX6r3O2oXS4FPxCdYzGvcpFtQypP92lktECG7bGOxrqsAzQ2BTsWgexjdYK4jKvXZX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNBsBCs4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNBsBCs4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 634671F000E9;
	Thu, 28 May 2026 18:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779992800;
	bh=Lc+0RIgeTZyQ7oB7itJh4YrMxGRDPlNKryFucvof/oE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZNBsBCs4by1rYi1FYbaww0uFgTfcRTX7zxMEq8GlNg6/Mc5NdJYX2fPhNylPtNhJ9
	 lPMPBFPJhr7NFauSiwFShzb1cYla2zCpQdTtSIOpCm7yEMX7WnOjQAlgOGK2jxgbcF
	 Z/axJmbVFOlYqCu3DD2BlGPc6pn3eq5K/RayWZitGh4f4cyxV1Us2jaUcdBx4HXUhh
	 r+1WKD0EKNk0PVPQgtxAHt9pHJpydTknOQBqShh1XEXlaknP/gvBtKmt6g3jUmQeAi
	 XBZtPO2jERm0NXg/YlU11omlFfzn7jc+E8EIZfPcwgjDsLRqWKFJ5HJgkT9pBMcwBJ
	 h54Qooo44e1qg==
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
Subject: [PATCH v5 4/8] selinux: Convert from sb_mount to granular mount hooks
Date: Thu, 28 May 2026 11:26:03 -0700
Message-ID: <20260528182607.3150386-5-song@kernel.org>
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

