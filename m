Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4971F8AC5;
	Mon,  6 Jul 2026 23:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783381869; cv=none; b=LFc74TbVivoy+5vck7eBCy11svpxiKc4UW37iLWfSh0NTiiJPiEUjhZhISf0ZS97ZJhrfCtiI0E9tNqdcPjNkoGLibj4TWBQn7bUuygBlsFmULahz5YQJVg879e33R9wrkCJ2M6bqwJkRL+fFzfJv2IRkdsu+gi29yNSams58hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783381869; c=relaxed/simple;
	bh=XmQfTLj/Uq0UQJ60PKoYLF0gj3ck+wzWdIdYvC8F598=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dznvPi8pneJeZrgFJWdQtrUJvmKhNsr15mxJL9GI/jFDv3hAQ+i87HJMXaUDx4EJvJCzlaTh0mBHQXlakxGn4Yt2+RFsnxWdyGXmGEhywNLjQ8mufVSoHLdKEcFHwGCkG0EoSZXq+5FsCAQ1OOHaidQiBi+gTUTC66gLmPB0Y0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EX9atma/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EX9atma/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7AA01F000E9;
	Mon,  6 Jul 2026 23:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783381867;
	bh=N0dySpqLody4bXvUC2igYcHz78SgXrpK6txryQQntXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EX9atma/lQEyicV7BIulUw0EqIHH+fJ4OGGdR/mmPx9FCU31EUgQPBWnKLGGPmKBD
	 5fvrgrj7n6yLiPURuqb386FzpK5q38Nknmv88wLUdPTXWaJE4Oqvx4J6T6herduw72
	 ZzxNfZLuOrpiL9wFi6FB/tAwzPn17YtGES7YnPtIXrlvnFB5MSnio8+e2GMngNH5xJ
	 JndCthhfLHjBn95ygnq0axsW1pBXTjslVOzRV52pldDNjQwmusHJiGEKQ/Aa9N/CHo
	 FMfSWHuDbL5oxiZWTWFGTaq2nCo3JYalBHrlHKoJrY/nfYL9OJ0LmV89jikxsYIZqx
	 s+Rlp7QMZdNwA==
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
Subject: [PATCH v6 1/8] lsm: Add granular mount hooks
Date: Mon,  6 Jul 2026 16:50:46 -0700
Message-ID: <20260706235053.4104951-2-song@kernel.org>
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

Add the new granular mount hook declarations and implementations
to the LSM framework:

  mount_bind        - bind mount (pre-resolved source path)
  mount_new         - new filesystem mount (with fs_context)
  mount_remount     - filesystem remount (with fs_context)
  mount_reconfigure - mount flag reconfiguration (MS_REMOUNT|MS_BIND)
  mount_move        - move mount (pre-resolved source, target and top
                      paths; target == top unless MOVE_MOUNT_BENEATH)
  mount_change_type - propagation type changes

These hooks are added alongside the existing security_sb_mount() and
security_move_mount() hooks, which remain in place until all LSMs
are converted.

Code generated with the assistance of Claude, reviewed by human.

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com> # for selinux only
Signed-off-by: Song Liu <song@kernel.org>
---
 include/linux/lsm_hook_defs.h |  12 ++++
 include/linux/security.h      |  52 +++++++++++++++++
 kernel/bpf/bpf_lsm.c          |   7 +++
 security/security.c           | 107 ++++++++++++++++++++++++++++++++++
 4 files changed, 178 insertions(+)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 65c9609ec207..06c904cb478e 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -81,6 +81,18 @@ LSM_HOOK(int, 0, sb_clone_mnt_opts, const struct super_block *oldsb,
 	 unsigned long *set_kern_flags)
 LSM_HOOK(int, 0, move_mount, const struct path *from_path,
 	 const struct path *to_path)
+LSM_HOOK(int, 0, mount_bind, const struct path *from, const struct path *to,
+	 bool recurse)
+LSM_HOOK(int, 0, mount_new, struct fs_context *fc, const struct path *mp,
+	 int mnt_flags, unsigned long flags, void *data)
+LSM_HOOK(int, 0, mount_remount, struct fs_context *fc,
+	 const struct path *mp, int mnt_flags, unsigned long flags,
+	 void *data)
+LSM_HOOK(int, 0, mount_reconfigure, const struct path *mp,
+	 unsigned int mnt_flags, unsigned long flags)
+LSM_HOOK(int, 0, mount_move, const struct path *from_path,
+	 const struct path *to_path, const struct path *top_path)
+LSM_HOOK(int, 0, mount_change_type, const struct path *mp, int ms_flags)
 LSM_HOOK(int, -EOPNOTSUPP, dentry_init_security, struct dentry *dentry,
 	 int mode, const struct qstr *name, const char **xattr_name,
 	 struct lsm_context *cp)
diff --git a/include/linux/security.h b/include/linux/security.h
index 153e9043058f..5e207e38c004 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -386,6 +386,18 @@ int security_sb_clone_mnt_opts(const struct super_block *oldsb,
 				unsigned long kern_flags,
 				unsigned long *set_kern_flags);
 int security_move_mount(const struct path *from_path, const struct path *to_path);
+int security_mount_bind(const struct path *from, const struct path *to,
+			bool recurse);
+int security_mount_new(struct fs_context *fc, const struct path *mp,
+		       int mnt_flags, unsigned long flags, void *data);
+int security_mount_remount(struct fs_context *fc, const struct path *mp,
+			   int mnt_flags, unsigned long flags, void *data);
+int security_mount_reconfigure(const struct path *mp, unsigned int mnt_flags,
+			       unsigned long flags);
+int security_mount_move(const struct path *from_path,
+			const struct path *to_path,
+			const struct path *top_path);
+int security_mount_change_type(const struct path *mp, int ms_flags);
 int security_dentry_init_security(struct dentry *dentry, int mode,
 				  const struct qstr *name,
 				  const char **xattr_name,
@@ -854,6 +866,46 @@ static inline int security_move_mount(const struct path *from_path,
 	return 0;
 }
 
+static inline int security_mount_bind(const struct path *from,
+				      const struct path *to, bool recurse)
+{
+	return 0;
+}
+
+static inline int security_mount_new(struct fs_context *fc,
+				     const struct path *mp, int mnt_flags,
+				     unsigned long flags, void *data)
+{
+	return 0;
+}
+
+static inline int security_mount_remount(struct fs_context *fc,
+					 const struct path *mp, int mnt_flags,
+					 unsigned long flags, void *data)
+{
+	return 0;
+}
+
+static inline int security_mount_reconfigure(const struct path *mp,
+					     unsigned int mnt_flags,
+					     unsigned long flags)
+{
+	return 0;
+}
+
+static inline int security_mount_move(const struct path *from_path,
+				      const struct path *to_path,
+				      const struct path *top_path)
+{
+	return 0;
+}
+
+static inline int security_mount_change_type(const struct path *mp,
+					     int ms_flags)
+{
+	return 0;
+}
+
 static inline int security_path_notify(const struct path *path, u64 mask,
 				unsigned int obj_type)
 {
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 1433809bb166..4b1ee9c67d6f 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -385,6 +385,13 @@ BTF_ID(func, bpf_lsm_task_setscheduler)
 BTF_ID(func, bpf_lsm_userns_create)
 BTF_ID(func, bpf_lsm_bdev_alloc_security)
 BTF_ID(func, bpf_lsm_bdev_setintegrity)
+BTF_ID(func, bpf_lsm_move_mount)
+BTF_ID(func, bpf_lsm_mount_bind)
+BTF_ID(func, bpf_lsm_mount_new)
+BTF_ID(func, bpf_lsm_mount_remount)
+BTF_ID(func, bpf_lsm_mount_reconfigure)
+BTF_ID(func, bpf_lsm_mount_move)
+BTF_ID(func, bpf_lsm_mount_change_type)
 BTF_SET_END(sleepable_lsm_hooks)
 
 BTF_SET_START(untrusted_lsm_hooks)
diff --git a/security/security.c b/security/security.c
index 71aea8fdf014..1ede060db3ca 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1182,6 +1182,113 @@ int security_move_mount(const struct path *from_path,
 	return call_int_hook(move_mount, from_path, to_path);
 }
 
+/**
+ * security_mount_bind() - Check permissions for a bind mount
+ * @from: source path
+ * @to: destination mount point
+ * @recurse: whether this is a recursive bind mount
+ *
+ * Check permission before a bind mount is performed. Called with the
+ * source path already resolved, eliminating TOCTOU issues with
+ * string-based dev_name in security_sb_mount().
+ *
+ * Return: Returns 0 if permission is granted.
+ */
+int security_mount_bind(const struct path *from, const struct path *to,
+			bool recurse)
+{
+	return call_int_hook(mount_bind, from, to, recurse);
+}
+
+/**
+ * security_mount_new() - Check permissions for a new mount
+ * @fc: filesystem context with parsed options
+ * @mp: mount point path
+ * @mnt_flags: mount flags (MNT_*)
+ * @flags: original mount flags (MS_*, used by AppArmor/Tomoyo)
+ * @data: filesystem specific data (used by AppArmor)
+ *
+ * Check permission before a new filesystem is mounted. Called after
+ * mount options are parsed, providing access to the fs_context.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
+int security_mount_new(struct fs_context *fc, const struct path *mp,
+		       int mnt_flags, unsigned long flags, void *data)
+{
+	return call_int_hook(mount_new, fc, mp, mnt_flags, flags, data);
+}
+
+/**
+ * security_mount_remount() - Check permissions for a remount
+ * @fc: filesystem context with parsed options
+ * @mp: mount point path
+ * @mnt_flags: mount flags (MNT_*)
+ * @flags: original mount flags (MS_*, used by AppArmor/Tomoyo)
+ * @data: filesystem specific data (used by AppArmor)
+ *
+ * Check permission before a filesystem is remounted. Called after
+ * mount options are parsed, providing access to the fs_context.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
+int security_mount_remount(struct fs_context *fc, const struct path *mp,
+			   int mnt_flags, unsigned long flags, void *data)
+{
+	return call_int_hook(mount_remount, fc, mp, mnt_flags, flags, data);
+}
+
+/**
+ * security_mount_reconfigure() - Check permissions for mount reconfiguration
+ * @mp: mount point path
+ * @mnt_flags: new mount flags (MNT_*)
+ * @flags: original mount flags (MS_*, used by AppArmor/Tomoyo)
+ *
+ * Check permission before mount flags are reconfigured (MS_REMOUNT|MS_BIND).
+ *
+ * Return: Returns 0 if permission is granted.
+ */
+int security_mount_reconfigure(const struct path *mp, unsigned int mnt_flags,
+			       unsigned long flags)
+{
+	return call_int_hook(mount_reconfigure, mp, mnt_flags, flags);
+}
+
+/**
+ * security_mount_move() - Check permissions for moving a mount
+ * @from_path: source mount path
+ * @to_path: destination mount point path
+ * @top_path: mount that ends up on top at the destination
+ *
+ * Check permission before a mount is moved.  Called with the destination
+ * pinned under the namespace semaphore, so @to_path reflects the mount
+ * point that will actually be used.  For a plain move @top_path equals
+ * @to_path; for a MOVE_MOUNT_BENEATH move the source is inserted below
+ * @top_path, allowing a policy over the (source, target, top) triple.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
+int security_mount_move(const struct path *from_path,
+			const struct path *to_path,
+			const struct path *top_path)
+{
+	return call_int_hook(mount_move, from_path, to_path, top_path);
+}
+
+/**
+ * security_mount_change_type() - Check permissions for propagation changes
+ * @mp: mount point path
+ * @ms_flags: propagation flags (MS_SHARED, MS_PRIVATE, etc.)
+ *
+ * Check permission before mount propagation type is changed.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
+int security_mount_change_type(const struct path *mp, int ms_flags)
+{
+	return call_int_hook(mount_change_type, mp, ms_flags);
+}
+
 /**
  * security_path_notify() - Check if setting a watch is allowed
  * @path: file path
-- 
2.53.0-Meta

