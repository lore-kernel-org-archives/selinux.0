Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F39343D62
	for <selinux@vger.kernel.org>; Thu, 21 Aug 2025 18:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755800427; cv=none; b=Q6aGFyeybKWoynoORzNBN5lJ2LNn613p9EqhpcbqTudey7InCzRghFC9mFM/2vLPNw/SPfznZqlAx3Vfl2aXMKDZ2j3EZH97j/ItP8H7n724VT1f569+29GDaA5gZWvUzAVnFor2I0ksgIuPWC304BeCC2XtNoVb8xWcxtmD26o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755800427; c=relaxed/simple;
	bh=Grr94Y4+WcQtq5B7GDFDmBFdWsTzLGUs80bRp4QuhF0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UOEENfWdfQ8rroHVs/i3BoCZBU/w4kpdHh2p/0hEpwqFB8W1u+OsU/MpC/GDAc0EIzlejQEs/Dz0bbQD50chzYUnBpnxOP+iuQl31mz++Bi1lEtJI3kNlhISDiyH2DPa+kVh8ZwSNi7h5rgO746v3A1y23NWm08z5vI+3RKz0bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=svx8Tkj6; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="svx8Tkj6"
Received: from ericsu-dev1 (unknown [131.107.1.202])
	by linux.microsoft.com (Postfix) with ESMTPSA id 398F22015BB5;
	Thu, 21 Aug 2025 11:20:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 398F22015BB5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1755800424;
	bh=In5lP29lhYv3TmbnCDKL9u2584Y5yY0Ff5ZiTKVmvcw=;
	h=From:To:Cc:Subject:Date:From;
	b=svx8Tkj6ZNWcJgNPj1xERl8SixQY15rsJVcWEcrvBXGT6HYFmeWvdD9JK9LYvYQio
	 vQk4GjRWLbj1QirkwWXu3wnmqVHCYkU44+2KYduI1RtJP/UZZG+b0XydKzyLQq7GSq
	 FI0FbbtrMTCZbxMbRMBGY68cf5GBwemfgPEAimIc=
From: Eric Suen <ericsu@linux.microsoft.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	stephen.smalley.work@gmail.com,
	omosnace@redhat.com,
	danieldurning.work@gmail.com
Subject: [PATCH v3] SELinux: Add support for BPF token access control
Date: Thu, 21 Aug 2025 11:20:21 -0700
Message-ID: <20250821182021.304-1-ericsu@linux.microsoft.com>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

BPF token support was introduced to allow a privileged process to delegate
limited BPF functionality—such as map creation and program loading—to an
unprivileged process:
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

Changes in v2:
- Fixed bug in selinux_bpffs_creator_sid(u32 fd) where it retrieved
  creator_sid from wrong file descriptor
- Removed unnecessary checks for null, per review comments from
  the first patch

Changes in v3:
- Removed check for 'sid == SECSID_NULL' in selinux_bpf_token_create and
  allow it to fall through to the permission checks which will fail as
  access denied to unlabeled_t

Signed-off-by: Eric Suen <ericsu@linux.microsoft.com>
---
 security/selinux/hooks.c                   | 90 +++++++++++++++++++++-
 security/selinux/include/classmap.h        |  2 +-
 security/selinux/include/objsec.h          |  4 +
 security/selinux/include/policycap.h       |  1 +
 security/selinux/include/policycap_names.h |  1 +
 security/selinux/include/security.h        |  6 ++
 6 files changed, 101 insertions(+), 3 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index e474cd7398ef..d949e9c5aa31 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -733,6 +733,8 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 		goto out;
 	}
 
+	sbsec->creator_sid = current_sid();
+
 	if (strcmp(sb->s_type->name, "proc") == 0)
 		sbsec->flags |= SE_SBPROC | SE_SBGENFS;
 
@@ -7014,9 +7016,13 @@ static int selinux_ib_alloc_security(void *ib_sec)
 static int selinux_bpf(int cmd, union bpf_attr *attr,
 		       unsigned int size, bool kernel)
 {
+	bool bpf_token_perms = selinux_policycap_bpf_token_perms();
 	u32 sid = current_sid();
 	int ret;
 
+	if (bpf_token_perms)
+		return 0;
+
 	switch (cmd) {
 	case BPF_MAP_CREATE:
 		ret = avc_has_perm(sid, sid, SECCLASS_BPF, BPF__MAP_CREATE,
@@ -7098,10 +7104,29 @@ static int selinux_bpf_prog(struct bpf_prog *prog)
 			    BPF__PROG_RUN, NULL);
 }
 
+static int selinux_bpffs_creator_sid(u32 fd)
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
@@ -7110,7 +7135,12 @@ static int selinux_bpf_map_create(struct bpf_map *map, union bpf_attr *attr,
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
@@ -7125,6 +7155,7 @@ static int selinux_bpf_prog_load(struct bpf_prog *prog, union bpf_attr *attr,
 				 struct bpf_token *token, bool kernel)
 {
 	struct bpf_security_struct *bpfsec;
+	u32 ssid;
 
 	bpfsec = kzalloc(sizeof(*bpfsec), GFP_KERNEL);
 	if (!bpfsec)
@@ -7133,7 +7164,12 @@ static int selinux_bpf_prog_load(struct bpf_prog *prog, union bpf_attr *attr,
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
@@ -7144,10 +7180,15 @@ static void selinux_bpf_prog_free(struct bpf_prog *prog)
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
@@ -7156,6 +7197,29 @@ static int selinux_bpf_token_create(struct bpf_token *token, union bpf_attr *att
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
 
@@ -7166,6 +7230,27 @@ static void selinux_bpf_token_free(struct bpf_token *token)
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
+		if ((bpfsec->perms & BPF__MAP_CREATE) != BPF__MAP_CREATE)
+			return -EACCES;
+		break;
+	case BPF_PROG_LOAD:
+		if ((bpfsec->perms & BPF__PROG_LOAD) != BPF__PROG_LOAD)
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
@@ -7599,6 +7684,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(bpf_map_create, selinux_bpf_map_create),
 	LSM_HOOK_INIT(bpf_prog_load, selinux_bpf_prog_load),
 	LSM_HOOK_INIT(bpf_token_create, selinux_bpf_token_create),
+	LSM_HOOK_INIT(bpf_token_cmd, selinux_bpf_token_cmd),
 #endif
 #ifdef CONFIG_PERF_EVENTS
 	LSM_HOOK_INIT(perf_event_alloc, selinux_perf_event_alloc),
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 5665aa5e7853..a6ed864af64c 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -171,7 +171,7 @@ const struct security_class_mapping secclass_map[] = {
 	{ "infiniband_endport", { "manage_subnet", NULL } },
 	{ "bpf",
 	  { "map_create", "map_read", "map_write", "prog_load", "prog_run",
-	    NULL } },
+	    "map_create_as", "prog_load_as", NULL } },
 	{ "xdp_socket", { COMMON_SOCK_PERMS, NULL } },
 	{ "mctp_socket", { COMMON_SOCK_PERMS, NULL } },
 	{ "perf_event",
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 1d7ac59015a1..b7e55e5c6d9c 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -87,6 +87,8 @@ struct superblock_security_struct {
 	u32 sid; /* SID of file system superblock */
 	u32 def_sid; /* default SID for labeling */
 	u32 mntpoint_sid; /* SECURITY_FS_USE_MNTPOINT context for files */
+	u32 creator_sid;	/* SID of privileged process and is used to */
+						/* verify bpf operations */
 	unsigned short behavior; /* labeling behavior */
 	unsigned short flags; /* which mount options were specified */
 	struct mutex lock;
@@ -164,6 +166,8 @@ struct pkey_security_struct {
 
 struct bpf_security_struct {
 	u32 sid; /* SID of bpf obj creator */
+	u32 perms;	/* allowed AV permissions, e.g. BPF__MAP_CREATE, */
+				/* for requested bpf commands */
 };
 
 struct perf_event_security_struct {
diff --git a/security/selinux/include/policycap.h b/security/selinux/include/policycap.h
index 7405154e6c42..cde6aaf442cd 100644
--- a/security/selinux/include/policycap.h
+++ b/security/selinux/include/policycap.h
@@ -17,6 +17,7 @@ enum {
 	POLICYDB_CAP_NETLINK_XPERM,
 	POLICYDB_CAP_NETIF_WILDCARD,
 	POLICYDB_CAP_GENFS_SECLABEL_WILDCARD,
+	POLICYDB_CAP_BPF_TOKEN_PERMS,
 	__POLICYDB_CAP_MAX
 };
 #define POLICYDB_CAP_MAX (__POLICYDB_CAP_MAX - 1)
diff --git a/security/selinux/include/policycap_names.h b/security/selinux/include/policycap_names.h
index d8962fcf2ff9..cd5e73f992ea 100644
--- a/security/selinux/include/policycap_names.h
+++ b/security/selinux/include/policycap_names.h
@@ -20,6 +20,7 @@ const char *const selinux_policycap_names[__POLICYDB_CAP_MAX] = {
 	"netlink_xperm",
 	"netif_wildcard",
 	"genfs_seclabel_wildcard",
+	"bpf_token_perms",
 };
 /* clang-format on */
 
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 7f19972f7922..02f0789b6254 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -203,6 +203,12 @@ static inline bool selinux_policycap_netlink_xperm(void)
 		selinux_state.policycap[POLICYDB_CAP_NETLINK_XPERM]);
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
2.50.1.windows.1

