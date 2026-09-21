Received: from mail-qk2-f42.google.com (mail-qk2-f42.google.com [74.125.230.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA6649F107
	for <selinux@vger.kernel.org>; Mon, 21 Sep 2026 13:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789997760; cv=none; b=psForiF8bSKuzOheokSjg+T7U5dEKpGN8vP+kzT9RpTCrQDIY5wtasxuRoFR3K5gr2s4IHjlZnfZrfWWlS7IlC6bPleaDjvfdumzWH7TnvkkgHPB8z+Bf86UlA9oNu6DDFV30FTlXbnvWmG3twgkTuoP2NgWFfNL5O099GMRUkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789997760; c=relaxed/simple;
	bh=JI9KKdUDWsPIBUBDnZFqxFeruyOfsR54AmBgXCdEeRc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rLdJsiqnYcQjGLy5HkKpXNnj/OGbpVNpcRoN2itB5fK770TliMVB6jadjW1wZsvyVyZ+lRtGSPVju3PEUv5ZRf7QLHkthc7DcKdrF3buSydN59zRL5n+1pusfeUAyblp6urKVxC5ySBJDEhsNUWsmDfpA5JlbmJhbYIpft+Tshc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n1owgPhd; arc=none smtp.client-ip=74.125.230.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n1owgPhd"
Received: by mail-qk2-f42.google.com with SMTP id d75a77b69052e-53122c5bbb4so34594221cf.2
        for <selinux@vger.kernel.org>; Mon, 21 Sep 2026 06:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789997756; x=1790602556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=j90tNsRB9pm/WJIURUqLasDOC4TOOvoJEmHGXgYInHk=;
        b=n1owgPhdSZeOWyF840PVvkwiCv6R3GUKpSpAIWoiijk/mnJz6NS67JNhLF2phDA5Tm
         1r7oXCUp4KfTaNb3tgZlsX03GwvYQcB7A2zP9naCJljb1MDZawbeDUmrOmhpme9QoVt7
         jTK8YDhazNo+sZQJUKs5rIN3mEaIm8fKsG4hMShifuGm6vR5MXYrvEp3VBty0ybPTaj0
         r65DbEAkRxZ8T1MFj/LtXidhRbEPPtgquysTYJss05uthE2Yh0ODz7hy2lmngl23OWz+
         tqQkxSDvvMw6i81hFByORLXOYTDpghxxAHOeBbIjkYN0MWPTKE5lTTcMpHLXPfJU3eRH
         AI4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789997756; x=1790602556;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j90tNsRB9pm/WJIURUqLasDOC4TOOvoJEmHGXgYInHk=;
        b=BcCATkYXSBnzH1KfOcO0hn/Dpk3qXoP6g/Cb67+ZpDJibN5BFjON3T6s/vZWBMJDLW
         rGQdMJOm2Lboa4isIFrFUKuIllGQsnAlto6dt18f8KGFnP9qthEUBJ29pY8we84GWB3w
         rZAlTbSJFd6HNPaUxw+VmtILkvEAePR2zJPFHbzUoPn3X4Y5RE7GPHAWoP8rdtzX26QC
         HXezzk6DmlsnU//kVqjeNaup3NRIei7ukWP5JCDDNBEatJIw8BFeg3Cj+8C7KhdSxzxl
         a4pIIgPfaQB3EgXsPcLp3aZ88zBB/4PZgbo5Z9x9w9EFCX4cd3oBdQkR5+4e4UYAPVWE
         ruRg==
X-Gm-Message-State: AFuF++m2Hnc1Hw3gfLqZAQPXOMqfNiSRdDf1msUegS7hV0SxdLVxH1/p
	YtYACPB+pAxHFhmIRNnJuFZuXJLGFwHERw7N8HykkD6aZe064tPyiiF+zXnV2A==
X-Gm-Gg: AYBFou0l/0s9krUcIoiEyaSlzxc1xoVjGK/0xO94DKxkmzCJqilm+70M6935lkKOhsx
	/MtsKMp2LS2EsWg2JcdRuN+S577+Iwzr0JTZMR1qDWmQ+frdcBW9hNeJbF+dkWYaDX7go42g+7B
	0fC3xgiUcEadxTh9jrC1jjNs14giqYytF2t7IS41DZon77d6D9EUeDEe2OuFCXULmj5/GzAd/O/
	7Zk2edAJ0mRkvhQvm8egWWbp25DL718TFCGzGtM0ZnzbPLmuWx2tJgsRfcYGqwccgaXekyVU3Ov
	MmVFAKAyqeiC8xq7Zt4ysMFJdnRXd3FOoSNuGv8MuAkQ1GdFVd6EYpoqG8ATfCY9fyWp+mm4SkN
	/65+sI5EdyURREX7vW8hyf5pkW1wm3tlabCtVjHlMEt8LBhQ/jBIb7jJ+dQ4UTMMpL2qWROsUpK
	3M3t5J7uAPvGB4VLmsaLGpkrn2LA7I46VYVIud46Q8lBAEH9OitHpSw06TfDgiFWIjYnT1CvJ2h
	/pQvG4GxYNHQTDP++qJkG+R2Vh+4uPamIKYRaXcDRLE4LIwCYPN5l0WNJ49BNiSPO3qoQaOLi4=
X-Received: by 2002:a05:620a:6f0a:b0:939:6de8:43de with SMTP id af79cd13be357-93c15e9c924mr54185585a.50.1789997755609;
        Mon, 21 Sep 2026 06:35:55 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93bfa73a11fsm477857985a.42.2026.09.21.06.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 06:35:55 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnacek@gmail.com,
	Daniel Durning <danieldurning.work@gmail.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v5] selinux: implement namespace_init and namespace_install hooks
Date: Mon, 21 Sep 2026 09:31:46 -0400
Message-ID: <20260921133145.17768-2-stephen.smalley.work@gmail.com>
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
in namespace_install.

Depends on
https://lore.kernel.org/linux-security-module/20260918143142.19435-2-stephen.smalley.work@gmail.com/
to ensure that the security blob is initialized for the initial namespaces.

Signed-off-by: Daniel Durning <danieldurning.work@gmail.com>
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v5 drops the no-longer-necessary statement about falling back to
SECINITSID_KERNEL if ns_common is pointing to an initial namespace.
v4 dropped the corresponding code from the hook function that was
performing that fallback logic. Both depend on the patch linked
above to ensure that the security blob is initialized for the
initial namespaces. I re-ran the corresponding testsuite tests
added by
https://lore.kernel.org/selinux/20260501125634.7700-1-danieldurning.work@gmail.com/
and they all passed.

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

