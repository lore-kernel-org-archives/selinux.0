Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2563F37646A;
	Fri, 15 May 2026 20:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778875352; cv=none; b=JjtkFNbNK9WLdSxmlmPK21tYUN3o0ykGaO/z2QjLle2aCTmevBZMSzMEJU4/+xNWYM17QkUEtApQqnhPqx9Mab9U13F9JdSPDsAS/FeFOoHp086CqyEovNBcH8OK9jhV1r1mLv7ccDJ+b2funyA0Fm8x5ikBybYffFrvIMlYQHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778875352; c=relaxed/simple;
	bh=oC0ErG+06cyRGFumQtb3kjgRktLHV6sucTXy9iL0f1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=px4SBwZrLMM4z0Kd4T0Niaask3JVlf5X7o/upbo+/JuEuY1/WCcDtiEM6iWWnnp9Z+p/KU+L1CJbbJHKtzidtTJVuUQkY/KKilUfoAxqPPsM5GlWdL6kpbSbUcCe5O8gPq8EVREf6GB6JYKtAEQ6S1pmsPL+PxIi0P4H4RngSRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uQaGuqpi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQaGuqpi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A0CDC2BCB0;
	Fri, 15 May 2026 20:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778875351;
	bh=oC0ErG+06cyRGFumQtb3kjgRktLHV6sucTXy9iL0f1Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uQaGuqpiJ169/XON000UoNRzVskaFMuy6dy+MuJhoUK8j7BgpoNtUBoLI36K7gA6R
	 LFRJdogSM6J0QEA5AWrc87ZuEolNlTc8oSO/Kmsli2bNXPVbApvxNYnMDDutOUfaLp
	 0pP9V0SDzzja+Zj6EFQVUZPsyXOrc3SvvPPr8RwnUAP8vfAGXsNoxjmBpVMDmOUqEt
	 X2p19U/jLt6feJ8K7ga+HpMcBgriJMwhyunvVKv7zNPdANde4YDZ8YidG3o/gslSg5
	 M1viVZyidNmfEyx5r1vKwntP5Rdgi7R+FpHD9PBS1NOGQ35PCZB3K9PTdTWS1604Jb
	 2oeefICw6IPOg==
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
Subject: [PATCH v4 5/7] landlock: Convert from sb_mount to granular mount hooks
Date: Fri, 15 May 2026 13:01:56 -0700
Message-ID: <20260515200158.4081915-6-song@kernel.org>
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

