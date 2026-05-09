Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4C8284662;
	Sat,  9 May 2026 01:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778291575; cv=none; b=aM5gtZkNzKMlH87ucEfiOlqeGElhIM1xEAnsVKdG5wh19XrXuzeqxpWyWidNMvqD+CODOeQPpbZOHaSKyNfnBIOAfsJieeunuTh3vja80x/coaiT9k6C+qc3ypyJpsANLi644Os2r0YMhbdFBK7fH0rno5gDPR6i0+4xzV7Y8/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778291575; c=relaxed/simple;
	bh=AtrOkJUBiJw15BHd9exFumAP4R9M99uCBNgnQ+ZQ5FU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IUtx8YbaCrIzhZvBRnXoTYHPD3PHFEaxVnqs3zPOwZYQAo353Y3a9ft3EvDc2rfO4nFlvpJnTPthFzajKW7Mfh5IKQz9eZW7kDqCXXeFFlwbbgVbwzCUdXWkSMO/WukCn9yJngTI+n7EhNO3t7fFmi0vs6T9Vu3YuuLqpaBIBL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LxbhM+Ft; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LxbhM+Ft"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5886C2BCB4;
	Sat,  9 May 2026 01:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778291575;
	bh=AtrOkJUBiJw15BHd9exFumAP4R9M99uCBNgnQ+ZQ5FU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LxbhM+FttoH5/6Ck7glfu96/9h4Lj7wrkU+rn26m1TKiQyjyUe/dMYDzE09kD5TH5
	 6gI0omZ7agXTze0nbQuw6C6FAmZmuIFLpVUH0tss2PN4oJhUacQEXh9y800sDPyi5u
	 V7h+5o4Y1BRueL3JNxH3aOyRa4L78iDK6Z8BkfGG1lL09R33XmtsZTgxlh1Yf9T1zB
	 y0g9nU6W+Flae3bJaipeaslizOd1TKTmHyp9tKJW1LqtoBfe3tmheVRKmoet4MLAgY
	 3slPcuUKvC8m+gN+3do8pBTdsNAA8LkWc4IhM5uBIuvL4vY0waHgEJLjeJfzzJ/tod
	 bhhuOaWx+RDag==
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
Subject: [PATCH v3 5/7] landlock: Convert from sb_mount to granular mount hooks
Date: Fri,  8 May 2026 18:52:06 -0700
Message-ID: <20260509015208.3853132-6-song@kernel.org>
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
2.53.0-Meta

