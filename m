Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C023BBA09;
	Mon,  6 Jul 2026 23:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783381886; cv=none; b=qD8IehI8iKcRAJU35n3uTDQuZ+oWng0IUUNlWLXHzaCa1Nuz9TC9ER6nz6QX5hgXe9waRTw8tjUtHiIzOJTSvow/kP+ZVwGkM5OIPVFM/d7YhttO5uHRES6uKwik3h/9viFfKmNLPj/G59MflR9onB0nRe4qyydTFDE0Ji7F97g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783381886; c=relaxed/simple;
	bh=A0MG881t7y2AXm2MKIQBT1IRCnxkBh+83E3W0N8d7YA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T4brWLt53lETEsP1XUixB9Dym2M41np6bTpyMPYmHnI5U/+E2J23tuPlAtiBLlhIwWor37yQYi9c0UHAnfeWXOr48VBXfM+697qu5t8BnDzXEvc2D7MKM7rKkjj6nUaJ5zgCPgzGJVLbHKYU3fkfSNVVNhfCGAfBoNu5HskZSec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EH9a/4Wh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EH9a/4Wh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 422851F00A3A;
	Mon,  6 Jul 2026 23:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783381885;
	bh=f561vauYf2jm/On8ly/9SE1PpTiNUBpG3W5/WWHoQkk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EH9a/4Wh+QGsp7vLOUMYUy6JfZ5TYPEOuhhXC9g4d7Y67Z27KCa5kxkb8NxpcvbN2
	 9Mp4YT2GAjl29kAjIPfTiAw2tZEXDsXeyvrJ2IJDxu+LfV2tTmekyVa5UmPKojiBdl
	 MAFpcgXFx/59kaV/c9r1HJS4oeuyC+uuDxJNPD7twWQdQGPM0nc//g6cEx4gPUstHH
	 Bdv8BIbXB3iNXedbcUdFpFE0BZpHczpQRwVDu27So5GwPXJZD3dbVfWwFtvm9ZziL7
	 7TE8J+jv2ckvXl957bCIGxSK3pJSUbLND04Jsu0iABWplJQ2O7Do5LPc7Oi2QtRIBP
	 JP84w1OXPQQqw==
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
Subject: [PATCH v6 4/8] selinux: Convert from sb_mount to granular mount hooks
Date: Mon,  6 Jul 2026 16:50:49 -0700
Message-ID: <20260706235053.4104951-5-song@kernel.org>
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

Replace selinux_mount() with granular mount hooks, preserving the
same permission checks:

- mount_bind, mount_new, mount_change_type: FILE__MOUNTON
- mount_remount, mount_reconfigure: FILESYSTEM__REMOUNT
- mount_move: FILE__MOUNTON (reuses selinux_move_mount)

The flags, data, and top_path parameters are unused by SELinux.

Code generated with the assistance of Claude, reviewed by human.

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Signed-off-by: Song Liu <song@kernel.org>
---
 security/selinux/hooks.c | 52 ++++++++++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 15 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 1a713d96206f..6cbe52375b5c 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2802,23 +2802,42 @@ static int selinux_sb_statfs(struct dentry *dentry)
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
-			      const struct path *to_path)
+			      const struct path *to_path,
+			      const struct path *top_path)
 {
 	const struct cred *cred = current_cred();
 
@@ -7554,13 +7573,16 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
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

