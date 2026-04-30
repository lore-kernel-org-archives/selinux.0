Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6F840DFDB;
	Thu, 30 Apr 2026 00:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777507460; cv=none; b=JD86DCOuaTDsLX7jBEGhNREEc2XleG3865oCrCBheOj/YxxCR0eT3TqrHiuRrW6NnzcK3jGL0xdNNtIYdhVqmOv1MpZ0NwhZdsneOP0e5d7uOIGstGbuZjUQJY+nbDFU+v4u2v2nQG3ywkidbFS9nm23QzDJ8cVJkbVHssswvXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777507460; c=relaxed/simple;
	bh=kQpR7f7zhcEaGggR0lMXimoDWOjcXP7AIpA9hGFTcLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MIKGZguASAl+GiUcLk3WANqtFL/mVI2+lRWKh+cdq71bY29ImV4iWdHu5COYT43rrDg0xfJ7+75ZwtR2MNWrR81MfKu8Y6p+a4ww/HsnHr+1WTfjUnrOWwSrtzdFAJPiNKvBOUWKoCz1fFJDPqx5b32Gm+Wsywt++y+hBFkHgbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMJEeuMy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMJEeuMy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90F5EC2BCB4;
	Thu, 30 Apr 2026 00:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777507460;
	bh=kQpR7f7zhcEaGggR0lMXimoDWOjcXP7AIpA9hGFTcLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aMJEeuMyQmkK0E24YJ5YNJaamnd0nRjomlvPFTDJOE/p0776hXqQbY1hQT/nNDyX/
	 1ASGk/AXjiRca6utz4AW6bT82koUIgpPmU2n6c0LKiT2v3RJqX6ih/ZCOl7ahFn9Jf
	 iLAHvpiTfkWG6pV5LoJaqqcnn9z0LnJf+fTGm6QXuqL4XEtmX4rF9wrq654f7f2i/A
	 iIxuwQuPrtvZVI12uKEZ0+HylowVn9eBtfrbqB+OUoXUoAyjTLYO3AqiUVHRMJYc5H
	 YH7K1HNr50NFOlWFlT/+9wkw9OjjAkShIRjbwpFr58kXB3HCK1eoezUcktgwydv3CD
	 6IDB/qAtNdShw==
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
Subject: [PATCH v2 4/7] selinux: Convert from sb_mount to granular mount hooks
Date: Wed, 29 Apr 2026 17:03:12 -0700
Message-ID: <20260430000315.918964-5-song@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260430000315.918964-1-song@kernel.org>
References: <20260430000315.918964-1-song@kernel.org>
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
index 97801966bf32..f0d9712356cf 100644
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
@@ -7562,7 +7580,12 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
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
2.52.0

