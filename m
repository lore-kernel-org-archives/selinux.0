Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2EE4028EE;
	Thu, 28 May 2026 18:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779992794; cv=none; b=HnO6+Gfr5+nBfB64+DZ5g2kLydm9kktMn5TGd5h0tQpfwu5xCcw/U4QqII2kL4b6DFrGDf9YYHzpEuUt1bbjtKv+Zdu9WyXIx212IqnQm7NbTL78wjLXrNNfxkPXfsIQKhSHIib79ox+i7lPRbPuNP6fMRu9jIwsyEvOx69d9DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779992794; c=relaxed/simple;
	bh=J5YcgTV2QJ8NNvCV3Xi6DLJ7XGAuJWi72SO+uuQjpJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m6wjObolVC8gaRQpGsqwdultJ/QsTADDqgvxbOpWr2Da4rOQtY6aBP0Q7h44Hv1IY+nyqHmfUJVz7hyLhy1kvh88BRhjTPSAsfpJrSrEqv4Hqbhj4zEA2lmRLUP9gzXapfg+Ll47x8P5dV00bOoIFlCvpIro7v9pMDNuiNI5pv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ONZoarzH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONZoarzH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE1A11F00A3A;
	Thu, 28 May 2026 18:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779992793;
	bh=BlSZcRwIsA5ewekVYMqjQAeYDGubVmB7kEjSWFqot8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ONZoarzHJmQlv5MsAUwJHQTfLBiqo8ykHuhLC1aEk0Pyau5oSrPXbzdduZ7cR8nym
	 qQZktQpiEfFl0h6O0t3JBW0qCq1aTUZDmYYiqeWo2KnCWiiiZtZbp7yZgt2JwbHgbF
	 KHx+kKX7XIJ92J1ReVTyXG+WE6vXmJ0IKVMxoesGZTtKz79I3wQkKZNH8BR4KegU76
	 Ha6oBwcQw8+na/Eqn8rlSsdWzXD5G7GCSt/+i8VOwWVAEhrF+vE0mSWbHFUnjWbnLW
	 2I+Qtpj0+5SfLHrrzZy5jdlHVU/9nh9Ag6peURAZ86yMVH+4j4qgj4tkbXWaCQcEu9
	 Yc3chv2Npppzw==
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
Subject: [PATCH v5 3/8] apparmor: Convert from sb_mount to granular mount hooks
Date: Thu, 28 May 2026 11:26:02 -0700
Message-ID: <20260528182607.3150386-4-song@kernel.org>
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
 security/apparmor/include/mount.h |   5 +-
 security/apparmor/lsm.c           | 100 +++++++++++++++++++++++-------
 security/apparmor/mount.c         |  37 ++---------
 3 files changed, 83 insertions(+), 59 deletions(-)

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
index 4415bca5889c..b0de7f316f51 100644
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
@@ -698,34 +699,83 @@ static int apparmor_uring_sqpoll(void)
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
@@ -1655,8 +1705,12 @@ static struct security_hook_list apparmor_hooks[] __ro_after_init = {
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
2.53.0-Meta

