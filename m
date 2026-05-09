Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00ACF24B28;
	Sat,  9 May 2026 01:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778291570; cv=none; b=TUasn2zNZArUWaQGaPFZrCReSAN4s3/AXbN1F36p2Pq+Felv9wGjlpm6QtgG0alR8dmN9s/c2m9PfBOts5bsTy9FhISmx89v1MhZGzT7xHYHjHEBEK6tQT1xqE01pZCoA5SKH4eR7V2/BNfe63DuDKbKek6fCr3EXPdJv58+51k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778291570; c=relaxed/simple;
	bh=mmCExyJxTO6Xp2k5oCU3W/AMDGuM9RqzltHMW2TSgDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LpiSQX+g4n0d0AHkDxSlBDTVbt0sI2MDta+ymrDcq6b4/LNswI/RneCyeCELjnm2/5zGBzqYG4NCu9QXNab7QD+je09SwRLSTSMPtt6qNQLRsuIn2L87z8uEOziBfsuWpgGCJvHnCz9shBXlTGGV3Hre3hmqYnykZXg6NO4prj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQqdw7Nv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQqdw7Nv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E993FC2BCB4;
	Sat,  9 May 2026 01:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778291569;
	bh=mmCExyJxTO6Xp2k5oCU3W/AMDGuM9RqzltHMW2TSgDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZQqdw7NvvJ9A1doCnkVidfTnep1Bu+m60nkU9Y8ITYY7jPdK7AitG4cEE1ZoDF7XQ
	 eRIfjNU+pV9laSfpePYcX4KfUvM90/nrVrGxkX3tjPM16XjHwsTpB8Ee8yousR7OOp
	 CYgpBa7q7hIK44YMaqKx/3tjYqwdSYua+LnZt2ETK/a2etge7sDwRjLpiram4enxEk
	 wLVNThU7+TqSAlcoAZOXQkFb1xVprfFUWVR0zWAC2cjHKZwMmNB9FOgfZ1JaqtjQdA
	 X4RO1bGfC8jhxkbS6bJ+/x8gA9jQAhDR2nE7sl8i/Y/+b+8kzj7YvBNngm+IpVdrPQ
	 +qkTzdV1HTiDA==
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
Subject: [PATCH v3 4/7] selinux: Convert from sb_mount to granular mount hooks
Date: Fri,  8 May 2026 18:52:05 -0700
Message-ID: <20260509015208.3853132-5-song@kernel.org>
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
 security/selinux/hooks.c | 47 ++++++++++++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 12 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 0f704380a8c8..864a3ca772c9 100644
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
@@ -7558,7 +7576,12 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
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
-- 
2.53.0-Meta

