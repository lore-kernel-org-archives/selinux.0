Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4544719C546;
	Wed, 18 Mar 2026 18:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773859470; cv=none; b=jCdArtm5WJsw8eq1MPAXG8GZUpvQ6yTOAUXlXEg1LxO9Z9WYo2jw7fh2k2yi5xRKhseXlmMmAclTSQj54nYsWxfvDyVDM0M0iMdFvBYkuxDngh2VZGPRp2h8aTefCjdi5R0m0Vr7qHwNJ+neqiBpe3SDST/uSjL3YKVEVfh2Gic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773859470; c=relaxed/simple;
	bh=d/5YsHV2PKUMXB+uIpWwal1wS+f2kTUASoCVQoo16Z0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hu0se/3txVMuydj8/dCGKQ12Zl0zbax5GHqAIIs5Ig35dZAmDAzHqdWUSyR7eDYEkZcbJywtugr70JVPj6VY/ebYl0GPvpSZAMA/SFomNsB3vmzj3txVvQpg1o+9m3pZPLDfgX//JVN8eoa8r2x627BY3hRn2CUn3w1sDkHnNf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3K8/cZJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3K8/cZJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB6B2C19421;
	Wed, 18 Mar 2026 18:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773859469;
	bh=d/5YsHV2PKUMXB+uIpWwal1wS+f2kTUASoCVQoo16Z0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j3K8/cZJTXt42OoEUAWrQ9dRdjGRc+JphRiLohXAXlF++DWo7wMpS7bYaMFc9wyGA
	 BB6rsHFwYrGvtqqNwRqZXsxPTczi/ykfFDQGp/UlIYSGiQm6mHfLgbHmYS/7uQEzmS
	 aKfOfF2QJuWPV8yoZNwg+smEEI6NxCRWav98fLolXNZlEo309jyrQtOb+egsH2CG++
	 rmFigwmMRMXVsaJLZeWob0ylu7jRTDuqoOfZJDpSffCITFm3D1pqT1a4CLAX0a5TVs
	 l6Wi98vuLKOqtkfBB3/ZHGe1eO2SDtLO/F+bf9vNNy0C7bkIJWskH1Xw1uIY2jXg6N
	 OEnPPimgbRJLQ==
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
Subject: [PATCH 4/7] selinux: Convert from sb_mount to granular mount hooks
Date: Wed, 18 Mar 2026 11:43:57 -0700
Message-ID: <20260318184400.3502908-5-song@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260318184400.3502908-1-song@kernel.org>
References: <20260318184400.3502908-1-song@kernel.org>
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

Signed-off-by: Song Liu <song@kernel.org>
---
 security/selinux/hooks.c | 47 ++++++++++++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 12 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index d8224ea113d1..415b5541ab9e 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2778,19 +2778,37 @@ static int selinux_sb_statfs(struct dentry *dentry)
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
@@ -7449,7 +7467,12 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
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

