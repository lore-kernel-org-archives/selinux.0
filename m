Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AB71F8AC5;
	Mon,  6 Jul 2026 23:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783381892; cv=none; b=fSC4pBu/KOiM6btSs6mrOKdiIHpmq0OnZal+Q3UpM0Tm2k8hP4xAiyQ89ZD0ueHpCvCNANOgK6kPSlL0wk7jCNezzjkmnGSBXyMj1tcq9ZOgSeRKE50IkTkuCQyYJKgzHdjp0MZWGwuMqpvYcEfdNwEHqaYVMIgF5he47Svc5sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783381892; c=relaxed/simple;
	bh=PoY6BkexSrMKLmM/3kNiPeM1VE/HdoEoSDjmVGBv7MA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Al9mApsIXaRNXASZrU9/yLgSnKUIyHry1e1tn8w2Z8UBPR5QQjqpkD6y5vYws9G/mJFSyxMJo2EkaQiccmvixDhpo6UqfhP06qVHc7utPHoukmR8B2AgzAdQUN2cDeh5Ww2YHnQfKUGmNZyRBnHipIgDe8qS7EAo/CCGpsEGPmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KHCWWHpr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHCWWHpr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F21811F000E9;
	Mon,  6 Jul 2026 23:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783381890;
	bh=5e18mKaceyvPdKmjWxSGiZSSpeMG3K1M6ZoQQrOYLNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KHCWWHprbUf4J/faHxW63xAwh1eFhrJq1DLABhrNuuaWIfaa0J5WnR4DO/1Lfq7+q
	 E3Eyl+pSKJ55KD8i8fnPwO8Ngx5LtQWgYMEHMfrFniFtOGWz/afbBKB7NWo0OZM6bn
	 x4LoJyvDvQKJ605AEvKEOTdlj9Oydxk+TZQgzjKTdCqkfcG0EQHQcJgWnHf8qxyMXy
	 4+oYNMKmbZClvJn9aDB/zg9UrRIrswwn2oZQLgHb8ZmvVAAGap6/fyFrEEbBXrMCQi
	 KjvFv9MwoqewmtmlEQQhd2Ok86ghB++u59pF8IpFsH9JZmB0DI+GjV424ARigeeSrV
	 ye/EYgWgakE0w==
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
Subject: [PATCH v6 5/8] landlock: Convert from sb_mount to granular mount hooks
Date: Mon,  6 Jul 2026 16:50:50 -0700
Message-ID: <20260706235053.4104951-6-song@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706235053.4104951-1-song@kernel.org>
References: <20260706235053.4104951-1-song@kernel.org>
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
mount_move hook reuses hook_move_mount() (its new top_path argument
is unused).

Code generated with the assistance of Claude, reviewed by human.

Signed-off-by: Song Liu <song@kernel.org>
---
 security/landlock/fs.c | 44 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 38 insertions(+), 6 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index f7e5e4ef9eac..0c56a3aa45ea 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1427,9 +1427,7 @@ static void log_fs_change_topology_dentry(
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
@@ -1443,8 +1441,38 @@ static int hook_sb_mount(const char *const dev_name,
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
-			   const struct path *const to_path)
+			   const struct path *const to_path,
+			   const struct path *const top_path)
 {
 	size_t handle_layer;
 	const struct landlock_cred_security *const subject =
@@ -1981,8 +2009,12 @@ static struct security_hook_list landlock_hooks[] __ro_after_init = {
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

