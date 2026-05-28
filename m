Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com [209.85.160.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2000E3BC673
	for <selinux@vger.kernel.org>; Thu, 28 May 2026 18:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779993529; cv=none; b=LYl3Oi5Ydd4SfmB4pxYnFwsbU6TdPGxQb7C9ThubIW7CqyjqsEGbuwszJcGPUBw4RcEf1mGYM2auh6J6Ka93Y6os/IFTJwSJ1/evnFvgY1on65V9B4VymaPkLxlKQ4Kt7zaduycA6CHZQfJF1HYfLMRbg3Yp/jaRpJuNRMEeZ04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779993529; c=relaxed/simple;
	bh=nNwOy8bsACfHGzPXPQoQYWCJ3y1xRPJbRimtCPGC/lo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q+3axJaEZ/q2ceLlmUEzyQ+isjT3KN+XggN/beUsJlIfXYlR9EM/CUJVRcyk7Jyhhnw+NAc5Xo++BY88zh97/4GsNFNOo3WA3syVW5Lpm6PAdz+sPBHB0o2AXMdIvIZdbHDxhEFhGkB+OUnN9sZMPJm42bMDxiWDCXYUQW/fMr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dzjpN9qn; arc=none smtp.client-ip=209.85.160.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzjpN9qn"
Received: by mail-qt1-f195.google.com with SMTP id d75a77b69052e-50e5eb0fabaso148145221cf.0
        for <selinux@vger.kernel.org>; Thu, 28 May 2026 11:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779993527; x=1780598327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m6b/6TwIjZUOuEGFgw3Vs5tKY4eYdae7VdlpYM5Bqx0=;
        b=dzjpN9qncwh/xooeA1HMvScNv+PkghIG5dGeekJYZt/XzwH0GqK/pC3XA+LtGM6kun
         KqoNeee+OgvdjtIpqGNuYxGnf8aiWY8qa+ITfyqiV36ea26CHwtsT2fwA5G4sccSnb1r
         7rzkw9yta6gxqiMZ4F/qMZ4JgbGFixj+FaIj2y66t1LXB1Y1XSOjaCHZDTwdmiOdU+09
         FUNwXxCGpX6b3bOjq+cGRnVBPRBQg8LroWCSPFLq2zDLqac/S8G0UepnVfN1ak7pUiUw
         i2mL3Epy6poWGZIk+ZYBxrAa8kExmYgDVAZO1YJS+heJWKlxHOcjiPsCUbk+o0mwiO4m
         gGYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779993527; x=1780598327;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m6b/6TwIjZUOuEGFgw3Vs5tKY4eYdae7VdlpYM5Bqx0=;
        b=hVLesMEFLADHKryFuzG7W3TNXDzJmjy49np5WoEXT18mq7ylMt+I4mJjn7vHroLnV0
         vNe+r71N95lxU+ooZPWeRGTZtkmtglcKgl43frm6L/IdjLHHrivsk+AN2lFutdxADU2Q
         pxM+SjrDzcAjUHWDaaDpWAorbPUpqSsBk77vZ5IA6WNAp2iOfTWsH5dGKRyLZLKtNsrI
         UjcDFacAm3mzACOHXMnxZy5RUGDtqZNnh7gUmehP6zvJjsth/pqtWZ+3bpnliswf8toL
         Xwg/4R0yCCaPRKguFa4OJDPJRJpyzq1zQoB9mJwkdml93GZNXqvrByo+JwxqtIfIGeFp
         LEiA==
X-Gm-Message-State: AOJu0YzR0CtYdYn5Xu8eyTIaYf4q14oi5+dRENxbQCuNHdN/SQoukpV3
	ZpIDT2GItw0ba8XX3thgkCPgrt/pgkb68fkRqb/zh6x4nuKgz+AY7quBTgpwFAth
X-Gm-Gg: Acq92OE2RrcApnDFHu6Kqp8tqpQ2/17jOxqktoNBl/9kLEdpMS4Bz3pkf7R7mz/4qJt
	de78z7XNq7odxt7y1i9rvpmhFEcB31POb9rW2A735cPrIIL7WXCoR2cB1QD1RjOzh5zNyswQgzB
	tR3YE6Nb1svX7P5v5Po+R4krFjc9t8B88yqzppDFObxSM3JPjgFauXMqbXYQuiqjCk6qKsfhl/V
	25e4tZkoRoc6S1aYGLgIByJVFTVCBKmoNqzJBFfnCwTCk7t6M4qp9Hd42DcJSBOnMo3umb2HZPG
	j/0YahZ6iI/JhcuQtitjVMrygB6xt3szmMqME5SuM2Vjps4Ar06ejzOqdViJ7WthaCIPU+IWI85
	kqv/Ym4kXU85PcRbdKndu6ZlGhFjsgYy+VGp7hVaEaViWV7ZbfwZXiTIISPfqlSq0xHGOsj6Pt7
	9OGX8hjm0XMYYcK0aJu9WAO2gGdC+7CbeIE21F7sPpusd3NLuC0lA757tgxUiYJXpxsrCLTexKm
	L56VsRipPOxMzgVbiXVQFdM+x68l7T3f7oVJtU=
X-Received: by 2002:a05:622a:1b05:b0:510:1ae7:88b3 with SMTP id d75a77b69052e-5172cb33938mr709481cf.4.1779993526917;
        Thu, 28 May 2026 11:38:46 -0700 (PDT)
Received: from localhost (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51706af1328sm87714881cf.20.2026.05.28.11.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 11:38:46 -0700 (PDT)
From: danieldurning.work@gmail.com
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	paul@paul-moore.com,
	omosnace@redhat.com,
	brauner@kernel.org,
	mic@digikod.net
Subject: [RFC PATCH v3] selinux: implement namespace_init and namespace_install hooks
Date: Thu, 28 May 2026 18:38:28 +0000
Message-ID: <20260528183828.47756-1-danieldurning.work@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Requires Christian Brauner's revised namespace LSM blob patch
and Mickaël Salaün's v2 LSM namespace audit data patch, which are
the first 2 patches in the series linked below.

Link: https://lore.kernel.org/linux-security-module/20260527181127.879771-2-mic@digikod.net
Signed-off-by: Daniel Durning <danieldurning.work@gmail.com>
---
Changes in v2:
- Added the create_anon permission to separately control creation
of anonymous mount namespaces

Changes in v3:
- Rebased onto v2 of the LSM namespace blob/audit data patches
---
 security/selinux/hooks.c            | 69 +++++++++++++++++++++++++++++
 security/selinux/include/classmap.h | 12 ++++-
 security/selinux/include/objsec.h   | 10 +++++
 3 files changed, 90 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 95d0fb20d84e..94ef03b65e9a 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -94,6 +94,8 @@
 #include <linux/io_uring/cmd.h>
 #include <uapi/linux/lsm.h>
 #include <linux/memfd.h>
+#include <linux/ns_common.h>
+#include <linux/nsfs.h>
 
 #include "initcalls.h"
 #include "avc.h"
@@ -1327,6 +1329,31 @@ static inline u16 socket_type_to_security_class(int family, int type, int protoc
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
@@ -7010,6 +7037,45 @@ static int selinux_inode_getsecctx(struct inode *inode, struct lsm_context *cp)
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
+	if (!nssec)
+		return avc_has_perm(sid, SECINITSID_KERNEL, sclass,
+					NAMESPACE__SETNS, &ad);
+
+	return avc_has_perm(sid, nssec->sid, sclass, NAMESPACE__SETNS, &ad);
+}
+
 #ifdef CONFIG_KEYS
 
 static int selinux_key_alloc(struct key *k, const struct cred *cred,
@@ -7521,6 +7587,7 @@ struct lsm_blob_sizes selinux_blob_sizes __ro_after_init = {
 	.lbs_bpf_map = sizeof(struct bpf_security_struct),
 	.lbs_bpf_prog = sizeof(struct bpf_security_struct),
 	.lbs_bpf_token = sizeof(struct bpf_security_struct),
+	.lbs_ns = sizeof(struct ns_security_struct),
 };
 
 /*
@@ -7724,6 +7791,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(tun_dev_attach_queue, selinux_tun_dev_attach_queue),
 	LSM_HOOK_INIT(tun_dev_attach, selinux_tun_dev_attach),
 	LSM_HOOK_INIT(tun_dev_open, selinux_tun_dev_open),
+	LSM_HOOK_INIT(namespace_install, selinux_namespace_install),
 #ifdef CONFIG_SECURITY_INFINIBAND
 	LSM_HOOK_INIT(ib_pkey_access, selinux_ib_pkey_access),
 	LSM_HOOK_INIT(ib_endport_manage_subnet,
@@ -7799,6 +7867,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
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
index b19e5d978e82..ea14bfd52a3f 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -27,6 +27,7 @@
 #include <linux/msg.h>
 #include <net/net_namespace.h>
 #include <linux/bpf.h>
+#include <linux/ns_common.h>
 #include "flask.h"
 #include "avc.h"
 
@@ -182,6 +183,10 @@ struct perf_event_security_struct {
 	u32 sid; /* SID of perf_event obj creator */
 };
 
+struct ns_security_struct {
+	u32 sid; /* SID of ns obj creator */
+};
+
 extern struct lsm_blob_sizes selinux_blob_sizes;
 static inline struct cred_security_struct *selinux_cred(const struct cred *cred)
 {
@@ -270,6 +275,11 @@ selinux_perf_event(void *perf_event)
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
2.53.0

