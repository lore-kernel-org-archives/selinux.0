Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47573373C0E;
	Wed, 18 Mar 2026 18:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773859464; cv=none; b=XJBEDUsjkg8K78qIqcMf7ZAU2nX2wCbB2M8Q70BF4SNrIGZf7oF3pPLK7Hk6xiPhxAA4mNNL7J7a248RUYtiRIqPZjw6J2b6gWfl1560avYaCSHBWuN9p9uE0oh+jdbJtPXEJU1WMksCx7MkLbJs3j7xEK+Tppz3E66ZfcRl4kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773859464; c=relaxed/simple;
	bh=VItNAdlJwiay0RK67lcUJnAqvY7X237O32/UOp8yo/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fy+LjLBOyjPWeMKQ5iTxcAKeFEu7BU7iqAUB7BUhyGH8MjCH0f13+ipK2/T+ismUKfO04VVlwhWQ1O1v1z/3FQpxFiTDD3BAfQ4pVbTBBjeqQ4OVMR6Mr86pb0Nrn/ZIQc+7i6EyQzHSDJs/PkvYIP8FO02yujdrD+6H7HZ+LmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cRJgM+WV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRJgM+WV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0C1AC19421;
	Wed, 18 Mar 2026 18:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773859463;
	bh=VItNAdlJwiay0RK67lcUJnAqvY7X237O32/UOp8yo/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cRJgM+WVe8bE6kJHG4vvwe6UoqKFpgqWD5fywqxH8EVLODQ/uKwMa+GRiIZ5b3/jz
	 1864T7z7BsGFYTBhvEXsf6m/9rHZnuE0gM9O0oRcwDdr8p9bdkLqHyXHzhruM9kkvt
	 d+pRDTZLpTKqDRazoUEiOjVbGTUahqcYpMbQy6Ydk2eWqCvbeApSPrRBxm1tc4WJ4i
	 p34FjDgAwLQw+ulOEpMRmFJXDEOFEViQ0Z0oW0orwzAAd1/AuWBvH90BTJbr+lC2ra
	 cuwAII0aqGbLZVAnuSErF+YZFTIsIUovrR8ruJ/FQ9ALr3SaQQA1iO+7sdpzb8Jlfg
	 SHZjpd/q2gqVA==
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
Subject: [PATCH 3/7] apparmor: Convert from sb_mount to granular mount hooks
Date: Wed, 18 Mar 2026 11:43:56 -0700
Message-ID: <20260318184400.3502908-4-song@kernel.org>
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

Replace AppArmor's monolithic apparmor_sb_mount() with granular
mount hooks.

Key changes:
- mount_bind: uses the pre-resolved struct path from VFS instead of
  re-resolving dev_name via kern_path(), eliminating a TOCTOU
  vulnerability. aa_bind_mount() now takes a struct path instead of
  a string for the source.
- mount_new, mount_remount: receive the original mount(2) flags and
  data parameters for policy matching via match_mnt_flags() and
  AA_MNT_CONT_MATCH data matching.
- mount_reconfigure: handles MS_REMOUNT|MS_BIND (mount attribute
  reconfiguration) which was previously handled as a remount.
- mount_move: reuses apparmor_move_mount() which already handles
  pre-resolved paths.
- mount_change_type: propagation type changes.

aa_move_mount_old() is removed since move mounts now go through
security_mount_move() with pre-resolved struct path pointers for
both the old mount(2) and new move_mount(2) APIs.

Code generated with the assistance of Claude, reviewed by human.

Signed-off-by: Song Liu <song@kernel.org>
---
 security/apparmor/include/mount.h |  5 +-
 security/apparmor/lsm.c           | 99 ++++++++++++++++++++++++-------
 security/apparmor/mount.c         | 37 ++----------
 3 files changed, 83 insertions(+), 58 deletions(-)

diff --git a/security/apparmor/include/mount.h b/security/apparmor/include/mount.h
index 46834f828179..088e2f938cc1 100644
--- a/security/apparmor/include/mount.h
+++ b/security/apparmor/include/mount.h
@@ -31,16 +31,13 @@ int aa_remount(const struct cred *subj_cred,
 
 int aa_bind_mount(const struct cred *subj_cred,
 		  struct aa_label *label, const struct path *path,
-		  const char *old_name, unsigned long flags);
+		  const struct path *old_path, bool recurse);
 
 
 int aa_mount_change_type(const struct cred *subj_cred,
 			 struct aa_label *label, const struct path *path,
 			 unsigned long flags);
 
-int aa_move_mount_old(const struct cred *subj_cred,
-		      struct aa_label *label, const struct path *path,
-		      const char *old_name);
 int aa_move_mount(const struct cred *subj_cred,
 		  struct aa_label *label, const struct path *from_path,
 		  const struct path *to_path);
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 48a8655af11e..7fe774535992 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -13,6 +13,7 @@
 #include <linux/mm.h>
 #include <linux/mman.h>
 #include <linux/mount.h>
+#include <linux/fs_context.h>
 #include <linux/namei.h>
 #include <linux/ptrace.h>
 #include <linux/ctype.h>
@@ -697,34 +698,83 @@ static int apparmor_uring_sqpoll(void)
 }
 #endif /* CONFIG_IO_URING */
 
-static int apparmor_sb_mount(const char *dev_name, const struct path *path,
-			     const char *type, unsigned long flags, void *data)
+static int apparmor_mount_bind(const struct path *from, const struct path *to,
+			       bool recurse)
 {
 	struct aa_label *label;
 	int error = 0;
 	bool needput;
 
-	flags &= ~AA_MS_IGNORE_MASK;
+	label = __begin_current_label_crit_section(&needput);
+	if (!unconfined(label))
+		error = aa_bind_mount(current_cred(), label, to, from,
+				      recurse);
+	__end_current_label_crit_section(label, needput);
 
+	return error;
+}
+
+static int apparmor_mount_new(struct fs_context *fc, const struct path *mp,
+			      int mnt_flags, unsigned long flags, void *data)
+{
+	struct aa_label *label;
+	int error = 0;
+	bool needput;
+
+	/* flags and data are from the original mount(2) call */
 	label = __begin_current_label_crit_section(&needput);
-	if (!unconfined(label)) {
-		if (flags & MS_REMOUNT)
-			error = aa_remount(current_cred(), label, path, flags,
-					   data);
-		else if (flags & MS_BIND)
-			error = aa_bind_mount(current_cred(), label, path,
-					      dev_name, flags);
-		else if (flags & (MS_SHARED | MS_PRIVATE | MS_SLAVE |
-				  MS_UNBINDABLE))
-			error = aa_mount_change_type(current_cred(), label,
-						     path, flags);
-		else if (flags & MS_MOVE)
-			error = aa_move_mount_old(current_cred(), label, path,
-						  dev_name);
-		else
-			error = aa_new_mount(current_cred(), label, dev_name,
-					     path, type, flags, data);
-	}
+	if (!unconfined(label))
+		error = aa_new_mount(current_cred(), label, fc->source,
+				     mp, fc->fs_type->name, flags, data);
+	__end_current_label_crit_section(label, needput);
+
+	return error;
+}
+
+static int apparmor_mount_remount(struct fs_context *fc, const struct path *mp,
+				  int mnt_flags, unsigned long flags,
+				  void *data)
+{
+	struct aa_label *label;
+	int error = 0;
+	bool needput;
+
+	/* flags and data are from the original mount(2) call */
+	label = __begin_current_label_crit_section(&needput);
+	if (!unconfined(label))
+		error = aa_remount(current_cred(), label, mp, flags, data);
+	__end_current_label_crit_section(label, needput);
+
+	return error;
+}
+
+static int apparmor_mount_reconfigure(const struct path *mp,
+				      unsigned int mnt_flags,
+				      unsigned long flags)
+{
+	struct aa_label *label;
+	int error = 0;
+	bool needput;
+
+	/* flags are from the original mount(2) call */
+	label = __begin_current_label_crit_section(&needput);
+	if (!unconfined(label))
+		error = aa_remount(current_cred(), label, mp, flags, NULL);
+	__end_current_label_crit_section(label, needput);
+
+	return error;
+}
+
+static int apparmor_mount_change_type(const struct path *mp, int ms_flags)
+{
+	struct aa_label *label;
+	int error = 0;
+	bool needput;
+
+	label = __begin_current_label_crit_section(&needput);
+	if (!unconfined(label))
+		error = aa_mount_change_type(current_cred(), label, mp,
+					     ms_flags);
 	__end_current_label_crit_section(label, needput);
 
 	return error;
@@ -1664,7 +1714,12 @@ static struct security_hook_list apparmor_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(capable, apparmor_capable),
 
 	LSM_HOOK_INIT(move_mount, apparmor_move_mount),
-	LSM_HOOK_INIT(sb_mount, apparmor_sb_mount),
+	LSM_HOOK_INIT(mount_bind, apparmor_mount_bind),
+	LSM_HOOK_INIT(mount_new, apparmor_mount_new),
+	LSM_HOOK_INIT(mount_remount, apparmor_mount_remount),
+	LSM_HOOK_INIT(mount_reconfigure, apparmor_mount_reconfigure),
+	LSM_HOOK_INIT(mount_move, apparmor_move_mount),
+	LSM_HOOK_INIT(mount_change_type, apparmor_mount_change_type),
 	LSM_HOOK_INIT(sb_umount, apparmor_sb_umount),
 	LSM_HOOK_INIT(sb_pivotroot, apparmor_sb_pivotroot),
 
diff --git a/security/apparmor/mount.c b/security/apparmor/mount.c
index 523570aa1a5a..38b40e16014f 100644
--- a/security/apparmor/mount.c
+++ b/security/apparmor/mount.c
@@ -418,25 +418,17 @@ int aa_remount(const struct cred *subj_cred,
 }
 
 int aa_bind_mount(const struct cred *subj_cred,
-		  struct aa_label *label, const struct path *path,
-		  const char *dev_name, unsigned long flags)
+		       struct aa_label *label, const struct path *path,
+		       const struct path *old_path, bool recurse)
 {
 	struct aa_profile *profile;
 	char *buffer = NULL, *old_buffer = NULL;
-	struct path old_path;
+	unsigned long flags = MS_BIND | (recurse ? MS_REC : 0);
 	int error;
 
 	AA_BUG(!label);
 	AA_BUG(!path);
-
-	if (!dev_name || !*dev_name)
-		return -EINVAL;
-
-	flags &= MS_REC | MS_BIND;
-
-	error = kern_path(dev_name, LOOKUP_FOLLOW|LOOKUP_AUTOMOUNT, &old_path);
-	if (error)
-		return error;
+	AA_BUG(!old_path);
 
 	buffer = aa_get_buffer(false);
 	old_buffer = aa_get_buffer(false);
@@ -445,12 +437,11 @@ int aa_bind_mount(const struct cred *subj_cred,
 		goto out;
 
 	error = fn_for_each_confined(label, profile,
-			match_mnt(subj_cred, profile, path, buffer, &old_path,
+			match_mnt(subj_cred, profile, path, buffer, old_path,
 				  old_buffer, NULL, flags, NULL, false));
 out:
 	aa_put_buffer(buffer);
 	aa_put_buffer(old_buffer);
-	path_put(&old_path);
 
 	return error;
 }
@@ -514,24 +505,6 @@ int aa_move_mount(const struct cred *subj_cred,
 	return error;
 }
 
-int aa_move_mount_old(const struct cred *subj_cred, struct aa_label *label,
-		      const struct path *path, const char *orig_name)
-{
-	struct path old_path;
-	int error;
-
-	if (!orig_name || !*orig_name)
-		return -EINVAL;
-	error = kern_path(orig_name, LOOKUP_FOLLOW, &old_path);
-	if (error)
-		return error;
-
-	error = aa_move_mount(subj_cred, label, &old_path, path);
-	path_put(&old_path);
-
-	return error;
-}
-
 int aa_new_mount(const struct cred *subj_cred, struct aa_label *label,
 		 const char *dev_name, const struct path *path,
 		 const char *type, unsigned long flags, void *data)
-- 
2.52.0

