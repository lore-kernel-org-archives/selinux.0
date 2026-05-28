Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC4F403144;
	Thu, 28 May 2026 18:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779992807; cv=none; b=jNrFlo0g3rj0TiGrLPivGLrYwX4ZqSJvGjd8HHvA4fB3+PMHY+zZFfGR4OPl8+4W7Oa9rRxrYZu1nq6EB9kVDzWsrCFVricAqjz68KP6kZeiiPFu+gwsAIy3ThohSeJpl9ZI8AnuDJf6ywU3OPgKoKHCwJt6Tia6l56WPpyO4sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779992807; c=relaxed/simple;
	bh=oC0ErG+06cyRGFumQtb3kjgRktLHV6sucTXy9iL0f1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PY+kftSR9cUa1gb4m8fIGjkAADLF9Ix+1dc4VleV0Ouz2H6C6Zlgu3zy+K/5KDjG4PkjMjcbWbgmn2lTYXDtcPy1JiUhZJyOQy0dwSqzZLtzyLg8QfUBpSSMgJG0pDbtQjRWZqYcdKmFfAap60enrCq56vxxprHau7kwS1oFehs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYzseYlg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYzseYlg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3831C1F00A3A;
	Thu, 28 May 2026 18:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779992806;
	bh=J+lUD/Cu8P5uUsV/I5uuKs/FO/AKYlu80PBfktiMjOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VYzseYlgzPFwNRV8fWg+owe51s8xSydjjndJSJ4HSoWaMwynlaW9oYflj+b1F47D8
	 iT7uj8D2+JYVCDazAP/MvsSRJpvsXOsm/vKbcLOqrwjhTikVU/Q4/c0/QmCb4NSzDT
	 F+tX+Sbpv7ON91TfUWBipyxLIj1SdI1mj4RMQKYcG/JQXfgvjbkNUgx8SH5WE3N/Vm
	 areNoFF/sZ6RdQXmaHC4T9SkA43vFfJGjYqkSU9IDC5hPGg29AX4k2zUMlW0+9upyw
	 m1eHwQ4BpWeee9DTURH/AhRL5Eljlzm1t11bX/gRcXBr90xmQIYqzqmfDM0eIt8XX4
	 ETVhQ9e5WSqBA==
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
Subject: [PATCH v5 5/8] landlock: Convert from sb_mount to granular mount hooks
Date: Thu, 28 May 2026 11:26:04 -0700
Message-ID: <20260528182607.3150386-6-song@kernel.org>
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

Replace hook_sb_mount() with granular mount hooks. Landlock denies
all mount operations for sandboxed processes regardless of flags,
so all new hooks share a common hook_mount_deny() helper. The
mount_move hook reuses hook_move_mount().

Code generated with the assistance of Claude, reviewed by human.

Signed-off-by: Song Liu <song@kernel.org>
---
 security/landlock/fs.c | 41 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 5 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index c1ecfe239032..7377f22a165e 100644
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
@@ -1950,8 +1977,12 @@ static struct security_hook_list landlock_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(inode_free_security_rcu, hook_inode_free_security_rcu),
 
 	LSM_HOOK_INIT(sb_delete, hook_sb_delete),
-	LSM_HOOK_INIT(sb_mount, hook_sb_mount),
-	LSM_HOOK_INIT(move_mount, hook_move_mount),
+	LSM_HOOK_INIT(mount_bind, hook_mount_bind),
+	LSM_HOOK_INIT(mount_new, hook_mount_new),
+	LSM_HOOK_INIT(mount_remount, hook_mount_remount),
+	LSM_HOOK_INIT(mount_reconfigure, hook_mount_reconfigure),
+	LSM_HOOK_INIT(mount_change_type, hook_mount_change_type),
+	LSM_HOOK_INIT(mount_move, hook_move_mount),
 	LSM_HOOK_INIT(sb_umount, hook_sb_umount),
 	LSM_HOOK_INIT(sb_remount, hook_sb_remount),
 	LSM_HOOK_INIT(sb_pivotroot, hook_sb_pivotroot),
-- 
2.53.0-Meta

