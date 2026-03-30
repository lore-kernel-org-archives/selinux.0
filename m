Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com [209.85.222.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C133B3822A3
	for <selinux@vger.kernel.org>; Mon, 30 Mar 2026 19:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774899117; cv=none; b=lf1uDWVMwowbh66fiWKw/vnTvkec7g7ADuZTTnwAyQRKseVqbS2j3PjrgwWuSoQMntn+NQLbcVzbR+wHohxXvPdiaVkZDBPf8Altk6FNtI3X1v6tLMVigODQ5Q//+Niu60dVUpD/izJows3MNzh5qwRYZ4AdIDLCNA+Xd+uar4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774899117; c=relaxed/simple;
	bh=hTJNUBeG7vXyVDRg0wOQuWq1DWswC3DvQT6hIrC/opE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LxmurDppfVr++MT6m+9ueKzncPbEfbxqe1gwAuDC7b3o+oxsUMsnnjxST6LuuZUD8RTLk1aDZymUr5kR7MkiM+MZiG+2yS7g/rKOs8NzOLb7i/47qq5a5Ek+IOfuM6SCYFDAY3x0co8m0CpKojjm3sxpu8mwufqFu5xbG7xhxRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lYq+pnQg; arc=none smtp.client-ip=209.85.222.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYq+pnQg"
Received: by mail-qk1-f195.google.com with SMTP id af79cd13be357-8cfc5941028so864327385a.1
        for <selinux@vger.kernel.org>; Mon, 30 Mar 2026 12:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774899114; x=1775503914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zKgyHge4Us4NhDY6Xc+e31hk4kg0Uewbm8g73M6HJ3k=;
        b=lYq+pnQghRgZEykh3wnESlH/eLUdxl33mQfbZ54c2lfjyVzuMM7O22obYRL7K03UT8
         QfurRvewTDcBEY6gS+F9K+SBx9EJVCOHzzP4jgscwSHpyz2hGMTQMjEkzKQ3w4MvjG62
         +4UQNEQEbxFF5wC2FfjJvdzjL9oEcmdCNE3L7jjURTGo0OC3B2v1d37oVkO17PXXCOgX
         crI40u4pPcAMplMg7iX69YhyF1DuDWgKVpUx9kAUH8xTN5/krRKA+SGGYkqpZlItrcQ+
         m3O1BoB0nqw230qxBMOVF90cBIAEM4Rbo1YVZrL/BX27elEBcffd1J3WZvFlzz5+wxIM
         WqFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774899114; x=1775503914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zKgyHge4Us4NhDY6Xc+e31hk4kg0Uewbm8g73M6HJ3k=;
        b=bXfO9Z9X5RR0dy1M+QSPkxGtgBF78GOFNW6pI0wPR7Lcye1GwvH8F2sHdyMiuapDst
         Ow5tZW2pIkglJhfwe80+ZwXWLbtxAkAnZJs+E6Dn/58qMOdUdOBqsZc5nXVCRl6/Hj4L
         RezTC0geQ6DXjAP79oQRAttUn4/topEP2JWVCmw4FMA6E2A7ERoRjwayUKL3dT4Av7aY
         FtLczKimRCCBwDZiEFWNfweyqFg+jkIIQDww160iGmeLh11XoBf0otqkRsn+CnCTANHt
         sr9jKHRxDtfZxDR9LAePJjvKv7MB/wv7mjMYgc+ebZ4w7aT4HcBi2cCWRwss9e0eDIiB
         t5dQ==
X-Gm-Message-State: AOJu0YyMZGRSEUwxC3G4c2M1YRvEPK4YwbAASH8mjlC4XfiBln6snfRk
	4ekamfYXWqUPL5fegR3LKiM7Ta5p2Fnpd1Sz9YB/hFFkas4prT12plWxxo4tD6E5
X-Gm-Gg: ATEYQzwgAOsX5NsW73AKRNPWpUfk9i+3Tjn01RdBIj2/UF6ccT+992PCdXEEqx7SFWP
	nqe4mA45f4FmQ24T92Psy+JorUIk7bUphXjgHveDcQGsxOMu1y0zSkB/wRmDU396mhE8z08YoJr
	7w+F0DjfK2dxQnFuLT8HpcAYQAFmk5N62F0fLaIWbfPhAYKvut0kBBTxYk3kxg3nIvtsoguMIS5
	qkxFcet2E3lm5nB7pp7SzZX0isi5oPdMwLzZyrEw8ZZLpcnQvH2DwKGlsBx9DBAwaX9scwxTvK/
	2lmSN4ADCkQjnh8v4xjIHC2kAbgAlShQhl0V5OORwtOX2NUjqG/9Bd37Zaq1KalLtZhDbXpWkWA
	GBVY7n/lkVnFskSpWnuyw8owfVvEEcHGPJ0i4oo4bhjuUOQHdZrIEEfyXOXNraSGhQlztyZMOGM
	GbcsIGzN5v5Xidj+qPiZIwGq6qLqrusj9YeYV0W3HP6oIOSlQo+BsIOU6mWz/jV0s8ldEBRv1yR
	LSb0MbQYUWb6B9OxThvHEr2zBl2uX5Tx+rJ+Q==
X-Received: by 2002:a05:620a:2996:b0:8cb:72b2:2a15 with SMTP id af79cd13be357-8d01c614cedmr1700861385a.33.1774899114375;
        Mon, 30 Mar 2026 12:31:54 -0700 (PDT)
Received: from localhost (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d027edc55fsm655619685a.10.2026.03.30.12.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 12:31:53 -0700 (PDT)
From: danieldurning.work@gmail.com
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	paul@paul-moore.com,
	omosnace@redhat.com,
	brauner@kernel.org,
	mic@digikod.net
Subject: [RFC PATCH] selinux: implement namespace_alloc and namespace_install hooks
Date: Mon, 30 Mar 2026 19:31:00 +0000
Message-ID: <20260330193100.3603-1-danieldurning.work@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Daniel Durning <danieldurning.work@gmail.com>

Add implementations of the namespace_alloc and namespace_install
hooks for SELinux. Corresponding permissions are defined for each
hook (create and setns, respectively), New security classes are
defined for each individual namespace type to allow granularity.

In namespace_alloc we check the caller's SID against itself. When
a namespace is allocated the SID of the caller is saved in the
namespace security blob. This SID is checked against the caller
in namespace_install. We fall back to SECINITSID_KERNEL if
ns_common is pointing to an init namespace, since these are
created before policy load and will be lacking a security blob.

Requires Christian Brauner's namespace LSM blob patch and
Mickaël Salaün's LSM namespace audit data patch, which are
the first 2 patches in the series linked below.

As an additional note, the namespace security blob does not
seem to be freed when a mount namespace is marked as anon
in the kernel. The free_mnt_ns() function only calls
ns_common_free() (which ultimately calls the namespace_free()
hook) if a mount namespace is not marked as anon.
This is causing a memory leak. This issue would need to be
addressed in the original LSM namespace blob patch.

Signed-off-by: Daniel Durning <danieldurning.work@gmail.com>
Link: https://lore.kernel.org/all/20260312100444.2609563-3-mic@digikod.net/
---
 security/selinux/hooks.c            | 65 +++++++++++++++++++++++++++++
 security/selinux/include/classmap.h | 12 +++++-
 security/selinux/include/objsec.h   | 10 +++++
 3 files changed, 86 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 6ef9c1aade65..e3cf07008fc8 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -94,6 +94,7 @@
 #include <linux/io_uring/cmd.h>
 #include <uapi/linux/lsm.h>
 #include <linux/memfd.h>
+#include <linux/ns_common.h>
 
 #include "initcalls.h"
 #include "avc.h"
@@ -1327,6 +1328,31 @@ static inline u16 socket_type_to_security_class(int family, int type, int protoc
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
@@ -6899,6 +6925,42 @@ static int selinux_inode_getsecctx(struct inode *inode, struct lsm_context *cp)
 	cp->id = LSM_ID_SELINUX;
 	return 0;
 }
+
+static int selinux_namespace_alloc(struct ns_common *ns)
+{
+	struct common_audit_data ad;
+	struct ns_security_struct *nssec = selinux_ns(ns);
+	u16 sclass = ns_type_to_security_class(ns);
+	u32 sid = current_sid();
+
+	ad.type = LSM_AUDIT_DATA_NS;
+	ad.u.ns.ns_type = ns->ns_type;
+	ad.u.ns.inum = ns->inum;
+
+	nssec->sid = sid;
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
+	ad.u.ns.inum = ns->inum;
+
+	if (!nssec)
+		return avc_has_perm(sid, SECINITSID_KERNEL, sclass,
+					NAMESPACE__SETNS, &ad);
+
+	return avc_has_perm(sid, nssec->sid, sclass, NAMESPACE__SETNS, &ad);
+}
+
 #ifdef CONFIG_KEYS
 
 static int selinux_key_alloc(struct key *k, const struct cred *cred,
@@ -7409,6 +7471,7 @@ struct lsm_blob_sizes selinux_blob_sizes __ro_after_init = {
 	.lbs_bpf_map = sizeof(struct bpf_security_struct),
 	.lbs_bpf_prog = sizeof(struct bpf_security_struct),
 	.lbs_bpf_token = sizeof(struct bpf_security_struct),
+	.lbs_ns = sizeof(struct ns_security_struct),
 };
 
 /*
@@ -7610,6 +7673,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(tun_dev_attach_queue, selinux_tun_dev_attach_queue),
 	LSM_HOOK_INIT(tun_dev_attach, selinux_tun_dev_attach),
 	LSM_HOOK_INIT(tun_dev_open, selinux_tun_dev_open),
+	LSM_HOOK_INIT(namespace_install, selinux_namespace_install),
 #ifdef CONFIG_SECURITY_INFINIBAND
 	LSM_HOOK_INIT(ib_pkey_access, selinux_ib_pkey_access),
 	LSM_HOOK_INIT(ib_endport_manage_subnet,
@@ -7685,6 +7749,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(inode_getsecctx, selinux_inode_getsecctx),
 	LSM_HOOK_INIT(sk_alloc_security, selinux_sk_alloc_security),
 	LSM_HOOK_INIT(tun_dev_alloc_security, selinux_tun_dev_alloc_security),
+	LSM_HOOK_INIT(namespace_alloc, selinux_namespace_alloc),
 #ifdef CONFIG_SECURITY_INFINIBAND
 	LSM_HOOK_INIT(ib_alloc_security, selinux_ib_alloc_security),
 #endif
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 90cb61b16425..e904ed795208 100644
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
+	{ "mnt_namespace", { COMMON_NAMESPACE_PERMS, NULL } },
+	{ "net_namespace", { COMMON_NAMESPACE_PERMS, NULL } },
+	{ "pid_namespace", { COMMON_NAMESPACE_PERMS, NULL } },
+	{ "time_namespace", { COMMON_NAMESPACE_PERMS, NULL } },
+	{ "user_namespace", { COMMON_NAMESPACE_PERMS, NULL } },
+	{ "uts_namespace", { COMMON_NAMESPACE_PERMS, NULL } },
+	{ "namespace", { COMMON_NAMESPACE_PERMS, NULL } },
 	/* last one */ { NULL, {} }
 };
 
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 5bddd28ea5cb..4692a67b7c2f 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -27,6 +27,7 @@
 #include <linux/msg.h>
 #include <net/net_namespace.h>
 #include <linux/bpf.h>
+#include <linux/ns_common.h>
 #include "flask.h"
 #include "avc.h"
 
@@ -178,6 +179,10 @@ struct perf_event_security_struct {
 	u32 sid; /* SID of perf_event obj creator */
 };
 
+struct ns_security_struct {
+	u32 sid; /* SID of ns obj creator */
+};
+
 extern struct lsm_blob_sizes selinux_blob_sizes;
 static inline struct cred_security_struct *selinux_cred(const struct cred *cred)
 {
@@ -259,6 +264,11 @@ selinux_perf_event(void *perf_event)
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
2.51.0

