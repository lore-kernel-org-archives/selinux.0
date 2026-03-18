Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCB6306486;
	Wed, 18 Mar 2026 18:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773859476; cv=none; b=f0mYmQx1qRw5U+LKe7NO8ARKAOfX/MyDcszqWzWw/1SerofyCEiu3HPj4+oao68wRbtJIMpKfEO8PD11SL9VtPekNDZnyXwVivMzKOmxrDzQKM/TGc2CkZzggeFEQ8GIBGh0DMORDb80qb8rrH3M8P8iq5ojD6titeDeGgD6Rlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773859476; c=relaxed/simple;
	bh=r6WqJOradBzTp18wkJIvtM0Ms39WS3CbAPRTaNLaDyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=seqc7XpcboxZv0oF5c8QOsHeAef8FGFkFdKIk1eAMf7ufFxBZeUbUynf8l0zZv2zPI0kEvC6Y4Wv2fKicK4GWtAgCDnoyoW9b2O96cb95N0j85Zwh1wyRfJhb0XTIG48QL04nbUblI+2DPFz6yks/i0Z1W9XW9O9A6HXShqgnnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DzqKkdzA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DzqKkdzA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D59C19421;
	Wed, 18 Mar 2026 18:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773859475;
	bh=r6WqJOradBzTp18wkJIvtM0Ms39WS3CbAPRTaNLaDyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DzqKkdzAGWLDtzZlTtLChIRmxEFkHUVt0SJVhw/dXd8GtIQSpEMGPS4kemS/rRZfS
	 FXy3rDVg4/RKosqiHs+bmKM47docQNaprx8Zqfax0T68Qqu256+V9x6GAV0ULVdL52
	 yfqwzpZxH3oFECnbLWKarT52VZ2btSepuZckPh0iw0PIyVmaG07WjqooleheNj+Ph9
	 SH4VaodZ9gvw1rMFZevn2nprCMQM2IfAvgPqbKnfoJZF7+FV6shg/PQARLmNSpmD8V
	 RduYDV+aSmf4hbVgfV9+j8zn3J7EYFRzDrvhQtJKARgk4qERKSvResQ/TJLXoBZ5fc
	 fD+JsgaE1rGzw==
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
Subject: [PATCH 5/7] landlock: Convert from sb_mount to granular mount hooks
Date: Wed, 18 Mar 2026 11:43:58 -0700
Message-ID: <20260318184400.3502908-6-song@kernel.org>
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

Replace hook_sb_mount() with granular mount hooks. Landlock denies
all mount operations for sandboxed processes regardless of flags,
so all new hooks share a common hook_mount_deny() helper. The
mount_move hook reuses hook_move_mount().

Code generated with the assistance of Claude, reviewed by human.

Signed-off-by: Song Liu <song@kernel.org>
---
 security/landlock/fs.c | 40 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 36 insertions(+), 4 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index e764470f588c..6e810550efcb 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1417,9 +1417,7 @@ static void log_fs_change_topology_dentry(
  * inherit these new constraints.  Anyway, for backward compatibility reasons,
  * a dedicated user space option would be required (e.g. as a ruleset flag).
  */
-static int hook_sb_mount(const char *const dev_name,
-			 const struct path *const path, const char *const type,
-			 const unsigned long flags, void *const data)
+static int hook_mount_deny(const struct path *const path)
 {
 	size_t handle_layer;
 	const struct landlock_cred_security *const subject =
@@ -1433,6 +1431,35 @@ static int hook_sb_mount(const char *const dev_name,
 	return -EPERM;
 }
 
+static int hook_mount_bind(const struct path *const from,
+			   const struct path *const to, bool recurse)
+{
+	return hook_mount_deny(to);
+}
+
+static int hook_mount_new(struct fs_context *fc, const struct path *const mp,
+			  int mnt_flags, unsigned long flags, void *data)
+{
+	return hook_mount_deny(mp);
+}
+
+static int hook_mount_remount(struct fs_context *fc, const struct path *mp,
+			      int mnt_flags, unsigned long flags, void *data)
+{
+	return hook_mount_deny(mp);
+}
+
+static int hook_mount_reconfigure(const struct path *const mp,
+				  unsigned int mnt_flags, unsigned long flags)
+{
+	return hook_mount_deny(mp);
+}
+
+static int hook_mount_change_type(const struct path *const mp, int ms_flags)
+{
+	return hook_mount_deny(mp);
+}
+
 static int hook_move_mount(const struct path *const from_path,
 			   const struct path *const to_path)
 {
@@ -1824,7 +1851,12 @@ static struct security_hook_list landlock_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(inode_free_security_rcu, hook_inode_free_security_rcu),
 
 	LSM_HOOK_INIT(sb_delete, hook_sb_delete),
-	LSM_HOOK_INIT(sb_mount, hook_sb_mount),
+	LSM_HOOK_INIT(mount_bind, hook_mount_bind),
+	LSM_HOOK_INIT(mount_new, hook_mount_new),
+	LSM_HOOK_INIT(mount_remount, hook_mount_remount),
+	LSM_HOOK_INIT(mount_reconfigure, hook_mount_reconfigure),
+	LSM_HOOK_INIT(mount_change_type, hook_mount_change_type),
+	LSM_HOOK_INIT(mount_move, hook_move_mount),
 	LSM_HOOK_INIT(move_mount, hook_move_mount),
 	LSM_HOOK_INIT(sb_umount, hook_sb_umount),
 	LSM_HOOK_INIT(sb_remount, hook_sb_remount),
-- 
2.52.0

