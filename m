Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769B01F8AC5;
	Mon,  6 Jul 2026 23:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783381880; cv=none; b=Dkls6EWKe0igFn5aMCZESivLgoWu6e/NPIk2y6itQZNnjC+sHB1vr0tZVDtVf7DuL3vq6NYEqXHpKMZkAGtEd7K2aG1nwpW+gOJHdXWFQrQaffeRkQAKsW8PR33x/e3tfFKNChJ4RpSy4Z1f5Z/RNWgWdX+zbNJpNVkTuURmdzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783381880; c=relaxed/simple;
	bh=NxPys2AyUpwEGYIL7r5rTWJ7S7rugUAlBvYoa4f9fsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sw7osUoSaU2hFeF50xQA2JRe2zqKzUAXsxAxxvQq1+GEhrcucfE2w+NpLN/IwMG485aFgfH6hcTB4wTvzwEbVBFw39CP98qRIaI0oce2+17rUHkTk9Cw8/8CorXa7qZ8Hh77LKC66rkIc+0T2qS8ob1Z/3mBjuQTKwUxxxTDB5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ft7NPOlx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ft7NPOlx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84BBD1F000E9;
	Mon,  6 Jul 2026 23:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783381879;
	bh=KnkDaGabnXOeJe9HKQqSLmQTZ5wHAOw+Na55GBMaMFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ft7NPOlxemEYOey5zGfu86k7HAQE4izfQNVSaxWYkNarKErsw9ufqwxYplv/kTFCh
	 3ZNpGH3zUeRwIvXltLl0aRo+e3wzFXTapYGJQV+wjuMPY++D3l466LiFE5AFkKP8Fe
	 9xZTdEIfATCYsf3A4gSpD9TPTilVYjkVMmnuEXYabJAT9b7hVRLMbTRKHYrJmN2CXQ
	 BJgLIwNKwmtXomDdmpw8oE2ttrqaNMzNdax0H4tt8qmiBt3RrDLweiWemA9BpPZgMt
	 c9dcISom+DVn7bHD9DKLOmK9o55zaUFUKdqsDeI69cfvJ7CiSi0M/bhtYdqTVVWeJw
	 MV+YaniJSGc/g==
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
Subject: [PATCH v6 3/8] apparmor: Convert from sb_mount to granular mount hooks
Date: Mon,  6 Jul 2026 16:50:48 -0700
Message-ID: <20260706235053.4104951-4-song@kernel.org>
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
- mount_move: wired to apparmor_move_mount(); its signature gains the
  new top_path argument (currently unused, reserved for
  MOVE_MOUNT_BENEATH policy).
- mount_change_type: propagation type changes.

aa_move_mount_old() is removed since move mounts now go through
security_mount_move() with pre-resolved struct path pointers for
both the old mount(2) and new move_mount(2) APIs.

Code generated with the assistance of Claude, reviewed by human.

Signed-off-by: Song Liu <song@kernel.org>
---
 security/apparmor/include/mount.h |   5 +-
 security/apparmor/lsm.c           | 103 +++++++++++++++++++++++-------
 security/apparmor/mount.c         |  37 ++---------
 3 files changed, 85 insertions(+), 60 deletions(-)

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
index 71f30dd43f97..d9d5822e4022 100644
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
@@ -698,41 +699,91 @@ static int apparmor_uring_sqpoll(void)
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
 }
 
 static int apparmor_move_mount(const struct path *from_path,
-			       const struct path *to_path)
+			       const struct path *to_path,
+			       const struct path *top_path)
 {
 	struct aa_label *label;
 	int error = 0;
@@ -1669,8 +1720,12 @@ static struct security_hook_list apparmor_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(capget, apparmor_capget),
 	LSM_HOOK_INIT(capable, apparmor_capable),
 
-	LSM_HOOK_INIT(move_mount, apparmor_move_mount),
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
index 2f5d918832c1..1ea0d680437c 100644
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
2.53.0-Meta

