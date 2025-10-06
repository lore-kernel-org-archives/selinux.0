Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139DD1C8630
	for <selinux@vger.kernel.org>; Mon,  6 Oct 2025 17:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759771331; cv=none; b=uLqvBAgm2yhqtpOEaHGbXt/oue9PaP/tFOUcEepFSTQpKijI49VCh31gtwB35C43Xau22XNLTtekcxlh0xl0GR17FZkeiDGJRBe3yvXCWioP47XIW3Z1ghQi0Ou93obzuH1NDO4il1MaC2VfZtcA5ZU0FnbYO5r+i+242TFR8Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759771331; c=relaxed/simple;
	bh=WveVLeLOaa1vVCWgCYUwki6ZnG0uSVZNUsOjAATItAk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TpTMzZtC8H0Do4JcUiR4681vThNvXnOMcb8oxa0PCL6J5sNYmuQWpiw7ddT/1g3IhsNfGeQFx1e1Av4xX5Oo90ftcZveoD8BSQRQnp1fRHnaUyHwBM1dzedmTyJIwfJBZJtuTbRkZbbJQCW1DqJZ1GWbrEi0pxR9X2jwq02IztI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=QEU4gofv; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="QEU4gofv"
Received: from ericsu-dev1 (unknown [131.107.1.202])
	by linux.microsoft.com (Postfix) with ESMTPSA id C392A211CDF1;
	Mon,  6 Oct 2025 10:22:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C392A211CDF1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759771328;
	bh=2TzgA4RICgASYLzH+DwqWN2cCnHpj9Fmc9Rs5vM1Z88=;
	h=From:To:Cc:Subject:Date:From;
	b=QEU4gofvDtgiENtM1yQqJ2IugYWUhxT60etcYITnMoK3Kg9nrMsN+s/4gBnpDIsUY
	 OlBj2tiNKi5/wd1wvrVfuEvfNdsDT1LiwkBQQl9KMq8UjDOjqoFVGiKDMq2E5rPv55
	 rzGeghnBYkMTW1ySYWxGDVN0NxzKf0az5LWSvGFs=
From: Eric Suen <ericsu@linux.microsoft.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	stephen.smalley.work@gmail.com,
	omosnace@redhat.com,
	danieldurning.work@gmail.com
Subject: [PATCH v4] SELinux: Add support for BPF token access control
Date: Mon,  6 Oct 2025 10:22:05 -0700
Message-ID: <20251006172205.429-1-ericsu@linux.microsoft.com>
X-Mailer: git-send-email 2.51.0.windows.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

BPF token support was introduced to allow a privileged process to delegate
limited BPF functionality—such as map creation and program loading—to
an unprivileged process:
  https://lore.kernel.org/linux-security-module/20231130185229.2688956-1-andrii@kernel.org/

This patch adds SELinux support for controlling BPF token access. With
this change, SELinux policies can now enforce constraints on BPF token
usage based on both the delegating (privileged) process and the recipient
(unprivileged) process.

Supported operations currently include:
  - map_create
  - prog_load

High-level workflow:
  1. An unprivileged process creates a VFS context via `fsopen()` and
     obtains a file descriptor.
  2. This descriptor is passed to a privileged process, which configures
     BPF token delegation options and mounts a BPF filesystem.
  3. SELinux records the `creator_sid` of the privileged process during
     mount setup.
  4. The unprivileged process then uses this BPF fs mount to create a
     token and attach it to subsequent BPF syscalls.
  5. During verification of `map_create` and `prog_load`, SELinux uses
     `creator_sid` and the current SID to check policy permissions via:
       avc_has_perm(creator_sid, current_sid, SECCLASS_BPF,
                    BPF__MAP_CREATE, NULL);

The implementation introduces two new permissions:
  - map_create_as
  - prog_load_as

At token creation time, SELinux verifies that the current process has the
appropriate `*_as` permission (depending on the `allowed_cmds` value in
the bpf_token) to act on behalf of the `creator_sid`.

Example SELinux policy:
  allow test_bpf_t self:bpf {
      map_create map_read map_write prog_load prog_run
      map_create_as prog_load_as
  };

Additionally, a new policy capability bpf_token_perms is added to ensure
backward compatibility. If disabled, previous behavior ((checks based on
current process SID)) is preserved.

Signed-off-by: Eric Suen <ericsu@linux.microsoft.com>
---
Changes in v2:
- Fixed bug in selinux_bpffs_creator_sid(u32 fd) where it retrieved
  creator_sid from wrong file descriptor
- Removed unnecessary checks for null, per review comments from
  the first patch

Changes in v3:
- Removed check for 'sid == SECSID_NULL' in selinux_bpf_token_create and
  allow it to fall through to the permission checks which will fail as
  access denied to unlabeled_t

Changes in v4:
- Added initialization of creator_sid in selinux_sb_alloc_security
- Enabled handling of creator_sid in selinux_cmp_sb_context and
  selinux_sb_clone_mnt_opts
- Minor updates based on review comments

 security/selinux/hooks.c                   | 93 +++++++++++++++++++++-
 security/selinux/include/classmap.h        |  2 +-
 security/selinux/include/objsec.h          |  2 +
 security/selinux/include/policycap.h       |  1 +
 security/selinux/include/policycap_names.h |  1 +
 security/selinux/include/security.h        |  6 ++
 6 files changed, 102 insertions(+), 3 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index e7a7dcab81db..ae26bb927bdf 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -726,6 +726,8 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 		goto out;
 	}
 
+	sbsec->creator_sid = current_sid();
+
 	if (strcmp(sb->s_type->name, "proc") == 0)
 		sbsec->flags |= SE_SBPROC | SE_SBGENFS;
 
@@ -895,6 +897,8 @@ static int selinux_cmp_sb_context(const struct super_block *oldsb,
 		if (oldroot->sid != newroot->sid)
 			goto mismatch;
 	}
+	if (old->creator_sid != new->creator_sid)
+		goto mismatch;
 	return 0;
 mismatch:
 	pr_warn("SELinux: mount invalid.  Same superblock, "
@@ -954,6 +958,7 @@ static int selinux_sb_clone_mnt_opts(const struct super_block *oldsb,
 	newsbsec->sid = oldsbsec->sid;
 	newsbsec->def_sid = oldsbsec->def_sid;
 	newsbsec->behavior = oldsbsec->behavior;
+	newsbsec->creator_sid = oldsbsec->creator_sid;
 
 	if (newsbsec->behavior == SECURITY_FS_USE_NATIVE &&
 		!(kern_flags & SECURITY_LSM_NATIVE_LABELS) && !set_context) {
@@ -2565,6 +2570,7 @@ static int selinux_sb_alloc_security(struct super_block *sb)
 	sbsec->sid = SECINITSID_UNLABELED;
 	sbsec->def_sid = SECINITSID_FILE;
 	sbsec->mntpoint_sid = SECINITSID_UNLABELED;
+	sbsec->creator_sid = SECINITSID_UNLABELED;
 
 	return 0;
 }
@@ -6915,6 +6921,9 @@ static int selinux_bpf(int cmd, union bpf_attr *attr,
 	u32 sid = current_sid();
 	int ret;
 
+	if (selinux_policycap_bpf_token_perms())
+		return 0;
+
 	switch (cmd) {
 	case BPF_MAP_CREATE:
 		ret = avc_has_perm(sid, sid, SECCLASS_BPF, BPF__MAP_CREATE,
@@ -6996,10 +7005,29 @@ static int selinux_bpf_prog(struct bpf_prog *prog)
 			    BPF__PROG_RUN, NULL);
 }
 
+static u32 selinux_bpffs_creator_sid(u32 fd)
+{
+	struct path path;
+	struct super_block *sb;
+	struct superblock_security_struct *sbsec;
+
+	CLASS(fd, f)(fd);
+
+	if (fd_empty(f))
+		return SECSID_NULL;
+
+	path = fd_file(f)->f_path;
+	sb = path.dentry->d_sb;
+	sbsec = selinux_superblock(sb);
+
+	return sbsec->creator_sid;
+}
+
 static int selinux_bpf_map_create(struct bpf_map *map, union bpf_attr *attr,
 				  struct bpf_token *token, bool kernel)
 {
 	struct bpf_security_struct *bpfsec;
+	u32 ssid;
 
 	bpfsec = kzalloc(sizeof(*bpfsec), GFP_KERNEL);
 	if (!bpfsec)
@@ -7008,7 +7036,12 @@ static int selinux_bpf_map_create(struct bpf_map *map, union bpf_attr *attr,
 	bpfsec->sid = current_sid();
 	map->security = bpfsec;
 
-	return 0;
+	if (!token)
+		ssid = bpfsec->sid;
+	else
+		ssid = selinux_bpffs_creator_sid(attr->map_token_fd);
+
+	return avc_has_perm(ssid, bpfsec->sid, SECCLASS_BPF, BPF__MAP_CREATE, NULL);
 }
 
 static void selinux_bpf_map_free(struct bpf_map *map)
@@ -7023,6 +7056,7 @@ static int selinux_bpf_prog_load(struct bpf_prog *prog, union bpf_attr *attr,
 				 struct bpf_token *token, bool kernel)
 {
 	struct bpf_security_struct *bpfsec;
+	u32 ssid;
 
 	bpfsec = kzalloc(sizeof(*bpfsec), GFP_KERNEL);
 	if (!bpfsec)
@@ -7031,7 +7065,12 @@ static int selinux_bpf_prog_load(struct bpf_prog *prog, union bpf_attr *attr,
 	bpfsec->sid = current_sid();
 	prog->aux->security = bpfsec;
 
-	return 0;
+	if (!token)
+		ssid = bpfsec->sid;
+	else
+		ssid = selinux_bpffs_creator_sid(attr->prog_token_fd);
+
+	return avc_has_perm(ssid, bpfsec->sid, SECCLASS_BPF, BPF__PROG_LOAD, NULL);
 }
 
 static void selinux_bpf_prog_free(struct bpf_prog *prog)
@@ -7042,10 +7081,15 @@ static void selinux_bpf_prog_free(struct bpf_prog *prog)
 	kfree(bpfsec);
 }
 
+#define bpf_token_cmd(T, C) \
+	((T)->allowed_cmds & (1ULL << (C)))
+
 static int selinux_bpf_token_create(struct bpf_token *token, union bpf_attr *attr,
 				    const struct path *path)
 {
 	struct bpf_security_struct *bpfsec;
+	u32 sid = selinux_bpffs_creator_sid(attr->token_create.bpffs_fd);
+	int err;
 
 	bpfsec = kzalloc(sizeof(*bpfsec), GFP_KERNEL);
 	if (!bpfsec)
@@ -7054,6 +7098,29 @@ static int selinux_bpf_token_create(struct bpf_token *token, union bpf_attr *att
 	bpfsec->sid = current_sid();
 	token->security = bpfsec;
 
+	bpfsec->perms = 0;
+
+	/**
+	 * 'token->allowed_cmds' is a bit mask of allowed commands
+	 * Convert the BPF command enum to a bitmask representing its position in the
+	 * allowed_cmds bitmap.
+	 */
+	if (bpf_token_cmd(token, BPF_MAP_CREATE)) {
+		err = avc_has_perm(bpfsec->sid, sid, SECCLASS_BPF, BPF__MAP_CREATE_AS, NULL);
+		if (err)
+			return err;
+
+		bpfsec->perms |= BPF__MAP_CREATE;
+	}
+
+	if (bpf_token_cmd(token, BPF_PROG_LOAD)) {
+		err = avc_has_perm(bpfsec->sid, sid, SECCLASS_BPF, BPF__PROG_LOAD_AS, NULL);
+		if (err)
+			return err;
+
+		bpfsec->perms |= BPF__PROG_LOAD;
+	}
+
 	return 0;
 }
 
@@ -7064,6 +7131,27 @@ static void selinux_bpf_token_free(struct bpf_token *token)
 	token->security = NULL;
 	kfree(bpfsec);
 }
+
+static int selinux_bpf_token_cmd(const struct bpf_token *token, enum bpf_cmd cmd)
+{
+	struct bpf_security_struct *bpfsec;
+
+	bpfsec = token->security;
+	switch (cmd) {
+	case BPF_MAP_CREATE:
+		if (!(bpfsec->perms & BPF__MAP_CREATE))
+			return -EACCES;
+		break;
+	case BPF_PROG_LOAD:
+		if (!(bpfsec->perms & BPF__PROG_LOAD))
+			return -EACCES;
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
 #endif
 
 struct lsm_blob_sizes selinux_blob_sizes __ro_after_init = {
@@ -7495,6 +7583,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(bpf_map_create, selinux_bpf_map_create),
 	LSM_HOOK_INIT(bpf_prog_load, selinux_bpf_prog_load),
 	LSM_HOOK_INIT(bpf_token_create, selinux_bpf_token_create),
+	LSM_HOOK_INIT(bpf_token_cmd, selinux_bpf_token_cmd),
 #endif
 #ifdef CONFIG_PERF_EVENTS
 	LSM_HOOK_INIT(perf_event_alloc, selinux_perf_event_alloc),
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 04a9b480885e..0af64019a3c3 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -173,7 +173,7 @@ const struct security_class_mapping secclass_map[] = {
 	{ "infiniband_endport", { "manage_subnet", NULL } },
 	{ "bpf",
 	  { "map_create", "map_read", "map_write", "prog_load", "prog_run",
-	    NULL } },
+	    "map_create_as", "prog_load_as", NULL } },
 	{ "xdp_socket", { COMMON_SOCK_PERMS, NULL } },
 	{ "mctp_socket", { COMMON_SOCK_PERMS, NULL } },
 	{ "perf_event",
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index c88cae81ee4c..8f4d1c404ecd 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -65,6 +65,7 @@ struct superblock_security_struct {
 	u32 sid; /* SID of file system superblock */
 	u32 def_sid; /* default SID for labeling */
 	u32 mntpoint_sid; /* SECURITY_FS_USE_MNTPOINT context for files */
+	u32 creator_sid; /* SID of privileged process and is used to verify bpf operations */
 	unsigned short behavior; /* labeling behavior */
 	unsigned short flags; /* which mount options were specified */
 	struct mutex lock;
@@ -142,6 +143,7 @@ struct pkey_security_struct {
 
 struct bpf_security_struct {
 	u32 sid; /* SID of bpf obj creator */
+	u32 perms; /* allowed AV permissions, e.g. BPF__MAP_CREATE, for requested bpf commands */
 };
 
 struct perf_event_security_struct {
diff --git a/security/selinux/include/policycap.h b/security/selinux/include/policycap.h
index bd402d3fd3ae..ea55b7c10da4 100644
--- a/security/selinux/include/policycap.h
+++ b/security/selinux/include/policycap.h
@@ -16,6 +16,7 @@ enum {
 	POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT,
 	POLICYDB_CAP_NETLINK_XPERM,
 	POLICYDB_CAP_NETIF_WILDCARD,
+	POLICYDB_CAP_BPF_TOKEN_PERMS,
 	__POLICYDB_CAP_MAX
 };
 #define POLICYDB_CAP_MAX (__POLICYDB_CAP_MAX - 1)
diff --git a/security/selinux/include/policycap_names.h b/security/selinux/include/policycap_names.h
index ac1342d6d5bb..e9f53e6a4aeb 100644
--- a/security/selinux/include/policycap_names.h
+++ b/security/selinux/include/policycap_names.h
@@ -19,6 +19,7 @@ const char *const selinux_policycap_names[__POLICYDB_CAP_MAX] = {
 	"userspace_initial_context",
 	"netlink_xperm",
 	"netif_wildcard",
+	"bpf_token_perms",
 };
 /* clang-format on */
 
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index e7827ed7be5f..3d9e6f9dfa9a 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -208,6 +208,12 @@ static inline bool selinux_policycap_netif_wildcard(void)
 		selinux_state.policycap[POLICYDB_CAP_NETIF_WILDCARD]);
 }
 
+static inline bool selinux_policycap_bpf_token_perms(void)
+{
+	return READ_ONCE(
+		selinux_state.policycap[POLICYDB_CAP_BPF_TOKEN_PERMS]);
+}
+
 struct selinux_policy_convert_data;
 
 struct selinux_load_state {
-- 
2.50.1

