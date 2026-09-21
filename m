Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41862495500
	for <selinux@vger.kernel.org>; Mon, 21 Sep 2026 13:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789997370; cv=none; b=rGutpqSbvwnS1fjT3rn5oFtd/TYZC7V+IxE/mztS8tqGrUomQl7mREOkrfKpipVkJ77kANOziI1bFBpkZrlWzr6pUl9JDwncCgC0WC4smC+yEcAEIHtO/r9g1p0uSlgLfdvj/UcEMxOsiOQ1Uj1dHHvsYqVXH8N3VqN7kcreWhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789997370; c=relaxed/simple;
	bh=xddydEwpgoWVrBQiuThZc+c3GtdsOhQQFi9REhW75Bk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OdjSoH3KRU+JzoyY1Iezk1fPFTkBMCAEKv3xJukyCqGlxdKP81E7cgBZ+I8xvc2UUU8LtfVNLGPVj7oXzx/M28ucgA4PT1qOcwtCrS++FN0R63qL/uTsxoeKARlpTZNlWMsGdNZujJsmWxy+VK0lkn8JYOO0+aSuul7MocgZ5F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZCyilAv; arc=none smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZCyilAv"
Received: by mail-qk2-f43.google.com with SMTP id d75a77b69052e-52fb76bcb1fso32958231cf.0
        for <selinux@vger.kernel.org>; Mon, 21 Sep 2026 06:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789997368; x=1790602168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lQOyMrkPuo2BLDjvcXSII1Ms6/MdKe2yGO+hj4IMC0w=;
        b=kZCyilAveXSt9dXFTMOBGwyntTnFzIcycHggBW3eZ+XWe47vfuIjCxvoDjzSMeWrMm
         Lf46rcIHJ1WDw8w8h0gMYIzX/rhyY3q9QDcgI/XsCZYBOAz+Ik/a4rA5UxKdaOyymh+C
         ZM8z0VGRkOGXDVyF2pmyVG+saNRP1NMabwu67d2CNbZN1/siM2Mdk2UKK7xXzoN8eA9q
         6WL+Wna03aEYMVOzgzGbdvjiz009a5FlASljqThY+j8O+5w8UdNYR6fNWr/j6+5N5qEu
         /BdPG6/KOjAJlX+V3hoRlT7jq7GGDP8/E4Wpx4wmnt6W9jv1muNj7ksdkCHaRyo2GdcQ
         r9/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789997368; x=1790602168;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lQOyMrkPuo2BLDjvcXSII1Ms6/MdKe2yGO+hj4IMC0w=;
        b=CsHXkfbnSZcXMXwijzNt64NmyT9opGAl2LC586jrDOJBSsfUovmn3+FXDnswAKIqd4
         nfIJXrtwAZ2r9b2bdMLkMslhsH5Weipj0uqa2JjNYfvaLCFnYuiTr8SDW4p8GZTx362U
         8PXuljwGBPlCsIHgcGNO8KxW+8x4voNCunu+pzKPW7NADh7s+f+sxdgF/nIwFqMzyQOe
         R5iQqiFCG2vvIQIGxtXyBVjXC8vTksfEJoRuq+dL6wlyydFlzvflACxLSd3pp1vvQwSv
         mIoZ6DtG8ZMW3putKJZU64H1lqjNfGKzv4xo/gB8hg5vFXhwXXgJxSuiMlzq2+l5p+7C
         JXhA==
X-Gm-Message-State: AFuF++lgR3HwyxySFgfhdSvBj4M+p69AxUr1SvP1KkoxDhUpQ2jW4cdM
	QJkSWUsJMXhkEnqSy31RYFJI19hk7M1bu6HmYXDKuf+UNKQQRsnK+sh4M/PugQ==
X-Gm-Gg: AYBFou0+/ukwwRY/DrjpfNOz1ZXaHGdaAcHZ0FYtOfHDjEEY/HKrC40yys7/h7AuLTe
	PxvOlsZzVXO6lvRVlwj0bDaUqx8j7Wyzs7vVlK5doe2tcWXQYmz1PkbSne23VJ4Uuu/wIwJGS6b
	7gwxwCHKda3K5GW/DmovU+VBs1SCCY/guUbUvIPbdcItSiPqvUO6kJ6+WniblmOs7lnUClqTEUG
	L9TviJy9Sbwf66Q/qZ3TO0aSYrvxgQIGWVZB7yXroUi8K4PHRN5w2ofxeqsROXiGieAvZVwiH28
	Xxd0hYtZP2Oz9yN/DQ4DRv+S76qajyOxFy8Kf6brctqPBOPHJVlEBvWucWTutC7OYKuNhNafWTF
	4au+vgNBE7B368R90mm437QdNPfYq1nnfIFl5L4/wf5dWIKyvepkV/ZwdVYYCurVkXw0hzE8nbR
	RmYLwzo+ePoVu1RacQHOYc29u/K/UcywqrkzkMDpGO8M5n5RR0FzVZjoaU7gqg6dxvx2/YGdk8n
	orXVtXAy4oS7U/8GdpSNHyvTMYM5nCG1uyxQw21Ew60Swmy83ytB+Gbr3lHz2cbkyoWxG35dAok
	+v5kBYaBWQ==
X-Received: by 2002:ac8:5743:0:b0:532:a96d:5957 with SMTP id d75a77b69052e-532d8e6b751mr6298611cf.51.1789997367932;
        Mon, 21 Sep 2026 06:29:27 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532ae5ef242sm65932621cf.5.2026.09.21.06.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 06:29:27 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnacek@gmail.com,
	Daniel Durning <danieldurning.work@gmail.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v4] selinux: implement namespace_init and namespace_install hooks
Date: Mon, 21 Sep 2026 09:28:25 -0400
Message-ID: <20260921132825.17526-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Durning <danieldurning.work@gmail.com>

Add implementations of the namespace_init and namespace_install
hooks for SELinux. Corresponding permissions are defined for each
hook (create and setns, respectively). Additionally, mount
namespaces have a create_anon permission to control anonymous
mount namespace creation separately. New security classes are
defined for each individual namespace type to allow granularity.

In namespace_init we check the caller's SID against itself. When
a namespace is created the SID of the caller is saved in the
namespace security blob. This SID is checked against the caller
in namespace_install. We fall back to SECINITSID_KERNEL if
ns_common is pointing to an init namespace, since these are
created before policy load and will be lacking a security blob.

Depends on
https://lore.kernel.org/linux-security-module/20260918143142.19435-2-stephen.smalley.work@gmail.com/
to ensure that the security blob is initialized for the initial namespaces.

Signed-off-by: Daniel Durning <danieldurning.work@gmail.com>
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/hooks.c            | 65 +++++++++++++++++++++++++++++
 security/selinux/include/classmap.h | 12 +++++-
 security/selinux/include/objsec.h   | 10 +++++
 3 files changed, 86 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 368f9dacdcef..ad4436e85eab 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -94,6 +94,8 @@
 #include <linux/io_uring/cmd.h>
 #include <uapi/linux/lsm.h>
 #include <linux/memfd.h>
+#include <linux/ns_common.h>
+#include <linux/nsfs.h>
 #include <uapi/linux/inet_diag.h>
 
 #include "initcalls.h"
@@ -1329,6 +1331,31 @@ static inline u16 socket_type_to_security_class(int family, int type, int protoc
 	return SECCLASS_SOCKET;
 }
 
+static inline u16 ns_type_to_security_class(struct ns_common *ns)
+{
+	switch (ns->ns_type) {
+	case CLONE_NEWCGROUP:
+		return SECCLASS_CGROUP_NAMESPACE;
+	case CLONE_NEWIPC:
+		return SECCLASS_IPC_NAMESPACE;
+	case CLONE_NEWNS:
+		return SECCLASS_MNT_NAMESPACE;
+	case CLONE_NEWNET:
+		return SECCLASS_NET_NAMESPACE;
+	case CLONE_NEWPID:
+		return SECCLASS_PID_NAMESPACE;
+	case CLONE_NEWTIME:
+		return SECCLASS_TIME_NAMESPACE;
+	case CLONE_NEWUSER:
+		return SECCLASS_USER_NAMESPACE;
+	case CLONE_NEWUTS:
+		return SECCLASS_UTS_NAMESPACE;
+	default:
+		WARN_ON(1);
+		return SECCLASS_NAMESPACE;
+	}
+}
+
 static int selinux_genfs_get_sid(struct dentry *dentry,
 				 u16 tclass,
 				 u16 flags,
@@ -7040,6 +7067,41 @@ static int selinux_inode_getsecctx(struct inode *inode, struct lsm_context *cp)
 	cp->id = LSM_ID_SELINUX;
 	return 0;
 }
+
+static int selinux_namespace_init(struct ns_common *ns)
+{
+	struct common_audit_data ad;
+	struct ns_security_struct *nssec = selinux_ns(ns);
+	u16 sclass = ns_type_to_security_class(ns);
+	u32 sid = current_sid();
+
+	ad.type = LSM_AUDIT_DATA_NS;
+	ad.u.ns.ns_type = ns->ns_type;
+	ad.u.ns.ns_id = ns->ns_id;
+
+	nssec->sid = sid;
+	if (ns->inum == MNT_NS_ANON_INO)
+		return avc_has_perm(sid, sid, sclass,
+					MNT_NAMESPACE__CREATE_ANON, &ad);
+
+	return avc_has_perm(sid, sid, sclass, NAMESPACE__CREATE, &ad);
+}
+
+static int selinux_namespace_install(const struct nsset *nsset,
+				  struct ns_common *ns)
+{
+	struct common_audit_data ad;
+	struct ns_security_struct *nssec = selinux_ns(ns);
+	u16 sclass = ns_type_to_security_class(ns);
+	u32 sid = current_sid();
+
+	ad.type = LSM_AUDIT_DATA_NS;
+	ad.u.ns.ns_type = ns->ns_type;
+	ad.u.ns.ns_id = ns->ns_id;
+
+	return avc_has_perm(sid, nssec->sid, sclass, NAMESPACE__SETNS, &ad);
+}
+
 #ifdef CONFIG_KEYS
 
 static int selinux_key_alloc(struct key *k, const struct cred *cred,
@@ -7551,6 +7613,7 @@ struct lsm_blob_sizes selinux_blob_sizes __ro_after_init = {
 	.lbs_bpf_map = sizeof(struct bpf_security_struct),
 	.lbs_bpf_prog = sizeof(struct bpf_security_struct),
 	.lbs_bpf_token = sizeof(struct bpf_security_struct),
+	.lbs_ns = sizeof(struct ns_security_struct),
 };
 
 /*
@@ -7754,6 +7817,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(tun_dev_attach_queue, selinux_tun_dev_attach_queue),
 	LSM_HOOK_INIT(tun_dev_attach, selinux_tun_dev_attach),
 	LSM_HOOK_INIT(tun_dev_open, selinux_tun_dev_open),
+	LSM_HOOK_INIT(namespace_install, selinux_namespace_install),
 #ifdef CONFIG_SECURITY_INFINIBAND
 	LSM_HOOK_INIT(ib_pkey_access, selinux_ib_pkey_access),
 	LSM_HOOK_INIT(ib_endport_manage_subnet,
@@ -7829,6 +7893,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(inode_getsecctx, selinux_inode_getsecctx),
 	LSM_HOOK_INIT(sk_alloc_security, selinux_sk_alloc_security),
 	LSM_HOOK_INIT(tun_dev_alloc_security, selinux_tun_dev_alloc_security),
+	LSM_HOOK_INIT(namespace_init, selinux_namespace_init),
 #ifdef CONFIG_SECURITY_INFINIBAND
 	LSM_HOOK_INIT(ib_alloc_security, selinux_ib_alloc_security),
 #endif
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 90cb61b16425..26ee7a0123a6 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -33,6 +33,8 @@
 	"mac_override", "mac_admin", "syslog", "wake_alarm", "block_suspend", \
 		"audit_read", "perfmon", "bpf", "checkpoint_restore"
 
+#define COMMON_NAMESPACE_PERMS "create", "setns"
+
 #ifdef __KERNEL__ /* avoid this check when building host programs */
 #include <linux/capability.h>
 
@@ -178,9 +180,17 @@ const struct security_class_mapping secclass_map[] = {
 	  { "open", "cpu", "kernel", "tracepoint", "read", "write", NULL } },
 	{ "anon_inode", { COMMON_FILE_PERMS, NULL } },
 	{ "io_uring", { "override_creds", "sqpoll", "cmd", "allowed", NULL } },
-	{ "user_namespace", { "create", NULL } },
 	{ "memfd_file",
 	  { COMMON_FILE_PERMS, "execute_no_trans", "entrypoint", NULL } },
+	{ "cgroup_namespace", { COMMON_NAMESPACE_PERMS, NULL } },
+	{ "ipc_namespace", { COMMON_NAMESPACE_PERMS, NULL } },
+	{ "mnt_namespace", { COMMON_NAMESPACE_PERMS, "create_anon", NULL } },
+	{ "net_namespace", { COMMON_NAMESPACE_PERMS, NULL } },
+	{ "pid_namespace", { COMMON_NAMESPACE_PERMS, NULL } },
+	{ "time_namespace", { COMMON_NAMESPACE_PERMS, NULL } },
+	{ "user_namespace", { COMMON_NAMESPACE_PERMS, NULL } },
+	{ "uts_namespace", { COMMON_NAMESPACE_PERMS, NULL } },
+	{ "namespace", { COMMON_NAMESPACE_PERMS, NULL } },
 	/* last one */ { NULL, {} }
 };
 
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 3c0a16ec978b..c6eae8f9c16b 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -27,6 +27,7 @@
 #include <linux/msg.h>
 #include <net/net_namespace.h>
 #include <linux/bpf.h>
+#include <linux/ns_common.h>
 #include "flask.h"
 #include "avc.h"
 
@@ -180,6 +181,10 @@ struct perf_event_security_struct {
 	u32 sid; /* SID of perf_event obj creator */
 };
 
+struct ns_security_struct {
+	u32 sid; /* SID of ns obj creator */
+};
+
 extern struct lsm_blob_sizes selinux_blob_sizes;
 static inline struct cred_security_struct *selinux_cred(const struct cred *cred)
 {
@@ -268,6 +273,11 @@ selinux_perf_event(void *perf_event)
 	return perf_event + selinux_blob_sizes.lbs_perf_event;
 }
 
+static inline struct ns_security_struct *selinux_ns(struct ns_common *ns)
+{
+	return ns->ns_security + selinux_blob_sizes.lbs_ns;
+}
+
 #ifdef CONFIG_BPF_SYSCALL
 static inline struct bpf_security_struct *
 selinux_bpf_map_security(struct bpf_map *map)
-- 
2.55.0

