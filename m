Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335384A3E;
	Thu, 30 Apr 2026 00:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777507473; cv=none; b=qw/zeR9T8VXkGcIEmT8TMHroFvCdjAT4o12x5ktlgKT6kz1R8BRYYe+bHdhnmQYjQBlzAZaFQuJdyAQso9B2VXCJOQMD3rGuTcd38X0UTzAxc0LRBccXRTK9evKfrllKiE0/CoaQmE4zDRNF8NtmI7u1CH1UWDMc4ae9OfqoMrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777507473; c=relaxed/simple;
	bh=5Pin48K3ors2EVIbm1ZxpGJPQguHfPS7LTKC/YYuDJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G3S3A3yCOEZjaqybhYJe00rW72MEXGTchjML6Gg5IZTHrhnkcQHWLkBmOu97caEBjyi92ZlgWKB1hHFvwniFmRTTZW0b2p6fO92Pnmkbluk/bm9qD4Afpntsqg7JnrCc4WrnvO/gXRrY/x98On7BYze8mRsEg16Tq0Rk0CQ3BYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q8NQFgDB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q8NQFgDB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 325C4C19425;
	Thu, 30 Apr 2026 00:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777507472;
	bh=5Pin48K3ors2EVIbm1ZxpGJPQguHfPS7LTKC/YYuDJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q8NQFgDBkmrZx/vOMbalFtjCD8fBf+kUnvTzlLaYMpj+YPPaujjCmE3BotsVRe/Zc
	 RhjmzTBjXJlTZfnkV9SzHbxKXaidGMQTNN76EkTm/K5hsZ8rMpkT/xGsifIs6UpOkN
	 YBX8FtGk5sg9GozP615tXQC7Wr9BFtR5OlGnz157NEsZKSfLcz8+q1ozQpZJczxz4T
	 MH5591a0IdAmPLjdI82Cmg8Q610vYGf7pPUnNX93iX/cEUmPEeQ3rkkeCWCC6f/5Aw
	 WBOccdlkNJPke81lQ6uO+gHQS7uqLHy9WjzRE9IrQIOu8yesQG9pwNLi+T03pwBYki
	 QQr2wfNH7KghA==
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
Subject: [PATCH v2 5/7] landlock: Convert from sb_mount to granular mount hooks
Date: Wed, 29 Apr 2026 17:03:13 -0700
Message-ID: <20260430000315.918964-6-song@kernel.org>
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
index c1ecfe239032..4547e736e496 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1416,9 +1416,7 @@ static void log_fs_change_topology_dentry(
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
@@ -1432,6 +1430,35 @@ static int hook_sb_mount(const char *const dev_name,
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
@@ -1950,7 +1977,12 @@ static struct security_hook_list landlock_hooks[] __ro_after_init = {
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

