Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com [209.85.160.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078B634F462
	for <selinux@vger.kernel.org>; Fri,  1 May 2026 12:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777639653; cv=none; b=pMJEO8nl/3U0gg92D5vP76CPzKFwjL7uBNBMDiD3dgG81E+/GIDjy1nNYL6IIBqyquVvfu1a2xSpZMBxLPrlVUZ5F6hC8+8cZvZUjVcc8v1DclqbvXfnp7d33M4KLC/XcBa9hrmB0DGTyg6SpE7H8kMQtnEJsZSLcdHwOzO3raY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777639653; c=relaxed/simple;
	bh=8ORfTCrGBmYA7vrW3anRdfQc91F+2sYvQgUnkTjxmz4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s1xLTJXbM62d8X7uqatohBLTIo+cVzlBWbY8AI6VSWMzYucNBOB53Oh0Y9N5cfM/3fRNKkLfvWf9khLyZ+A6C2yYYRvxk9PsKo/bTyVbb2IsPQgu+Rj0Zk++EFQoMg+oOnPyLjZOnJxP+Zwz77+PA1Zfgj6nm0YulW61gHVHJ0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZKnIjtdx; arc=none smtp.client-ip=209.85.160.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZKnIjtdx"
Received: by mail-qt1-f195.google.com with SMTP id d75a77b69052e-50d87c138e1so17659131cf.1
        for <selinux@vger.kernel.org>; Fri, 01 May 2026 05:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777639651; x=1778244451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=biuYJpImoP/OzdgvCSewPGQJgzJZ5JCKQYOLWQle1lA=;
        b=ZKnIjtdxSZg7naM1okoQ823Bl7dgG8CdqlcC5MRZ5ye1jFrVGk931SYLQcLc94zbGp
         bLvlD7txO2t730eio1Q2nuQIeJiMvie7a/pYXSqEcvxq7xJUGBzZdpywPLhp/UJv6RDQ
         EFYFJunjHStWkYbHVmQmQPqRQpO8cfPUqJ5ZL30R+0yUb1bWKCZDq65ArEi1akl5HY/O
         ZannYXuwpqa7MOBOXzfSEX5uZ9fTYooDTwYuBuO6zFAnaXKeKVkF2HQK2LRGesRHMcae
         4gXx/AyaaqAjfw3I71/WzLj99sQUxXEZPbSmPoHVUCWtlCH6Lh0AmuiWKqv5iThw9tnv
         lXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777639651; x=1778244451;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=biuYJpImoP/OzdgvCSewPGQJgzJZ5JCKQYOLWQle1lA=;
        b=n7Abqj1Rf57WlZYPBUDADkcp59fpLxFdBtVRD9ZQQupi3PRCdKDMkRxVj5S5CWYIXW
         mLp1TCBj7MBfi43kKd9JmpFV5Q+5U+Yjks9q4CyuZsfE1lCw15oxX0yTnAnbZk0vVTGV
         9FF3e4jRs823EUq82q1dQzI6QPpT07OG3HIfKoSaR5de/BLN54OCGEbkVZ9/oJU8Zaox
         N9JZr4fSG6KvavK7t6JBMHhu0+kYz1bPnd7woSMaa9wXSAw6kg5RURgMqiJyM+AuER86
         alx8YFqADGTR/hYwAXOI1qpl10hNX6p++1euH8qX5Ha4mqMdGlyIj84mCldwO3G6SRrR
         7D5g==
X-Gm-Message-State: AOJu0Yymwo1w79VLU0g6giiCsWEQs7q2chbm8ZI+3Rn6cxyIv5OA5LxP
	Xq0BA2CG9gF0/WmijOjL18lur74H9nxMaV9D9Y3oJImJ/VaN4dm8v7oR6PqHHt8L
X-Gm-Gg: AeBDieu7pnEGJXjT0tlCPNmHOp49uVcecoWKRfpygG5F34ffGOg9V/ObNC8dqqP8Cte
	m68P8htLz5KrsKiOrK5SWtWqocTdyHvawV3OdpGc+wQmitztN/21+gM+z6WgNTirHQ/b6ZaKL9C
	Vf/SsmaSpWyTo4Miza9laqwJVS/7wAv38KxJekgdCLTK9C3VOuLidcVdkQBqGyo0BR5/0DdG2fF
	ukwNsG1n+NmmcoD1tix7wtRDTgX7I/QJba2mf4te0CTd5O9iJW+9faQQv/2nVibj1qN7w8jnk+M
	o4Z6e923GXskx7wWjG5tjNNKiOLU3qj5Tt4XtBMYbY9h95uG+PMLY4T63gVdr5vUC38sQu43Bml
	P0e3Q/66jIH0h57aPsmk2YP5mbX76LfTOwZU1C7Bn1vXkqS/V3pnWlBcu0bcbJ1KLG1Xt6/b3tv
	xtrMqxbzNmD2i96uWL9BEnBMwsNe032Dhlz8sLeV6lCPNJE88eVygMYsyk7L2qj5XsjUerVaaiM
	4nFXyQ/glC3KkkTRdn0fsK6Gifz3Y84D0iX2PiACwoy6DXriw==
X-Received: by 2002:a05:622a:412:b0:50d:a26e:1e95 with SMTP id d75a77b69052e-5102adee4b9mr106693851cf.47.1777639650632;
        Fri, 01 May 2026 05:47:30 -0700 (PDT)
Received: from localhost (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51041ddb598sm11385491cf.13.2026.05.01.05.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 05:47:30 -0700 (PDT)
From: danieldurning.work@gmail.com
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	paul@paul-moore.com,
	omosnace@redhat.com,
	brauner@kernel.org,
	mic@digikod.net
Subject: [RFC PATCH v2] selinux: implement namespace_alloc and namespace_install hooks
Date: Fri,  1 May 2026 12:46:13 +0000
Message-ID: <20260501124613.6589-1-danieldurning.work@gmail.com>
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

Add implementations of the namespace_alloc and namespace_install
hooks for SELinux. Corresponding permissions are defined for each
hook (create and setns, respectively). Additionally, mount
namespaces have a create_anon permission to control anonymous
mount namespace creation separately. New security classes are
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

Signed-off-by: Daniel Durning <danieldurning.work@gmail.com>
Link: https://lore.kernel.org/all/20260312100444.2609563-3-mic@digikod.net/
---
Changes in v2:
- Added the create_anon permission to separately control creation
of anonymous mount namespaces
---
 security/selinux/hooks.c            | 69 +++++++++++++++++++++++++++++
 security/selinux/include/classmap.h | 12 ++++-
 security/selinux/include/objsec.h   | 10 +++++
 3 files changed, 90 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 6ef9c1aade65..c71e8076adcd 100644
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
@@ -6899,6 +6926,45 @@ static int selinux_inode_getsecctx(struct inode *inode, struct lsm_context *cp)
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
@@ -7409,6 +7475,7 @@ struct lsm_blob_sizes selinux_blob_sizes __ro_after_init = {
 	.lbs_bpf_map = sizeof(struct bpf_security_struct),
 	.lbs_bpf_prog = sizeof(struct bpf_security_struct),
 	.lbs_bpf_token = sizeof(struct bpf_security_struct),
+	.lbs_ns = sizeof(struct ns_security_struct),
 };
 
 /*
@@ -7610,6 +7677,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(tun_dev_attach_queue, selinux_tun_dev_attach_queue),
 	LSM_HOOK_INIT(tun_dev_attach, selinux_tun_dev_attach),
 	LSM_HOOK_INIT(tun_dev_open, selinux_tun_dev_open),
+	LSM_HOOK_INIT(namespace_install, selinux_namespace_install),
 #ifdef CONFIG_SECURITY_INFINIBAND
 	LSM_HOOK_INIT(ib_pkey_access, selinux_ib_pkey_access),
 	LSM_HOOK_INIT(ib_endport_manage_subnet,
@@ -7685,6 +7753,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(inode_getsecctx, selinux_inode_getsecctx),
 	LSM_HOOK_INIT(sk_alloc_security, selinux_sk_alloc_security),
 	LSM_HOOK_INIT(tun_dev_alloc_security, selinux_tun_dev_alloc_security),
+	LSM_HOOK_INIT(namespace_alloc, selinux_namespace_alloc),
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
2.53.0

