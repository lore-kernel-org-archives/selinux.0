Return-Path: <SRS0=yIcu=YI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379B7ECE588
	for <selinux@archiver.kernel.org>; Tue, 15 Oct 2019 13:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4970218DE
	for <selinux@archiver.kernel.org>; Tue, 15 Oct 2019 13:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="Kwx1EOkj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731968AbfJON1P (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 15 Oct 2019 09:27:15 -0400
Received: from UPDC19PA20.eemsg.mail.mil ([214.24.27.195]:20310 "EHLO
        UPDC19PA20.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727745AbfJON1P (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 15 Oct 2019 09:27:15 -0400
X-EEMSG-check-017: 22420364|UPDC19PA20_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.67,300,1566864000"; 
   d="scan'208";a="22420364"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA20.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 15 Oct 2019 13:27:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1571146031; x=1602682031;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jZPzasM3Ai9mJ5Y5jzcSODF0MyAgpS6VP6aGDlhzlNY=;
  b=Kwx1EOkjccVwYH31Qdjzle3x7ANgpr6z806HphPCggnff8m4vTWVP2Ae
   ZcfSy9t9HqilKVehZRKZMRESSugsCJiS8TFoJs3zFF5yv3XOK+vd5M2V+
   oGHzOTAj194Z8pI+G2zYPHv0KphPRtJVAp6xeCXdLJnJYvZV1np61AvtF
   IXQ++hkqh1+wErzJyd57hsthbuTsTNVgpv2iTso5leNB00UvCzAEpDFAh
   NqIoPM1AiUK8BCT14X5BMuPColWjAORCA6qHLmQkV8xG70ntv6EfDIV85
   EbNxXE905SisnyjVeWaFmatyWPZx6hsvndujhK7ptGkGs0PioacryaiVf
   g==;
X-IronPort-AV: E=Sophos;i="5.67,300,1566864000"; 
   d="scan'208";a="34156707"
IronPort-PHdr: =?us-ascii?q?9a23=3AIBQvvxwv8vaDk6vXCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd2+oSIJqq85mqBkHD//Il1AaPAdyAra0fwLeI+4nbGkU4qa6bt34DdJEeHz?=
 =?us-ascii?q?Qksu4x2zIaPcieFEfgJ+TrZSFpVO5LVVti4m3peRMNQJW2aFLduGC94iAPER?=
 =?us-ascii?q?vjKwV1Ov71GonPhMiryuy+4ZLebxhGiTanY75/Ihq6oAXQu8ILnYZsN6E9xw?=
 =?us-ascii?q?fTrHBVYepW32RoJVySnxb4+Mi9+YNo/jpTtfw86cNOSL32cKskQ7NWCjQmKH?=
 =?us-ascii?q?0169bwtRbfVwuP52ATXXsQnxFVHgXK9hD6XpP2sivnqupw3TSRMMPqQbwoXz?=
 =?us-ascii?q?mp8qlkSAXsiCwaKTA39m/ZgdF0gK5CoB+soxlzzojJa4+XKfV+ZLvQc9MES2?=
 =?us-ascii?q?RcUMhfVCtPDYGyb4QAAOQMJvpUoornqlcStxayGRWgCeXywTFInH/22qg63v?=
 =?us-ascii?q?w8HwHawgMgB9IOv2rSrN7oKakSVPq6zK3MzTrdb/JdxDDw6JPVfRA6uvyMQb?=
 =?us-ascii?q?JxftbRyUkoDQ/FiE6Qppb/MzOa0eQNrXGW4ux9Xuysk24qsxx9rzegy8s2io?=
 =?us-ascii?q?TFm5gZxk7L+Cln2oo5ONu1Q1Nhb9G+CptfrSSaOpNzQsMlXm5npj43yqYDuZ?=
 =?us-ascii?q?6nZCgKz4knxwLHZ/yHbYeI5hXjWf6NIThinnJlea+/hw2o/Ui8yuzzSsm00F?=
 =?us-ascii?q?FQoipDjtbMrWwC2wbW6siGTvtx5kah2TCR2ADP8uxIPE85mKXBJ5Mh37I8jI?=
 =?us-ascii?q?QfvEvdEiPshUn6lKqWeV8l+uis5eTneLLmppqEOo9vlw7+Kb8jmtC/AOskMg?=
 =?us-ascii?q?gOWHKX+eKn1LL550H5T7JKjuMunqnDrJ/aPdgbprK+AwJNyoYs8Qu/DzO93d?=
 =?us-ascii?q?QAh3YHMVZFdAuCj4juPFHOOu73Ae2jjFSrlTdh3+rGMaH5ApXRMnjDl6/sfa?=
 =?us-ascii?q?1j5E5YyQozy81f5p1PB7EfL/L8RFXxuMbbDhAnKQy0xfjoCNFn2oMZQ2KPDf?=
 =?us-ascii?q?zRDKSHqlKM5+QyM8GSa4IP/jXwMf4o47jpl3Bqt0UaePySwZYPaH2+Vs9jKk?=
 =?us-ascii?q?GdbGuk1swNCk8WrwE+S6rsk1TEXjlNMSXhF5kg7y02Xdr1RbzIQZqg1fncjS?=
 =?us-ascii?q?o=3D?=
X-IPAS-Result: =?us-ascii?q?A2ACCwAuxaVd/wHyM5BmHQEBAQkBEQUFAYF7gXQsgT8BM?=
 =?us-ascii?q?iqTUgEBAQEBAQaCNIh6kS8JAQEBAQEBAQEBGxkBAgEBhEACgmskOBMCDAEBA?=
 =?us-ascii?q?QQBAQEBAQUDAQFshTmCOimCaQYnCwFGEFFXGYJXDD+CUyWwKzOFTYMugUiBN?=
 =?us-ascii?q?Ic1hFkYeIEHgRGCXXOKMASNB6BDgiyCMZJeDBuCOpcHj3CaDSKBWCsIAhgII?=
 =?us-ascii?q?Q+DJ1AQFIFbF44/JQMwgQYBAZBBAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 15 Oct 2019 13:27:01 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x9FDPV4L010187;
        Tue, 15 Oct 2019 09:27:01 -0400
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [RFC PATCH 07/10] selinux: support per-task/cred selinux namespace
Date:   Tue, 15 Oct 2019 09:25:25 -0400
Message-Id: <20191015132528.13519-8-sds@tycho.nsa.gov>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191015132528.13519-1-sds@tycho.nsa.gov>
References: <20191015132528.13519-1-sds@tycho.nsa.gov>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Extend the task security structure to include a reference to
the associated selinux namespace, and to also contain a
pointer to the cred in the parent namespace.  The current selinux
namespace is changed to the per-task/cred selinux namespace
for the current task/cred.

This change makes it possible to support per-cred selinux namespaces,
but does not yet introduce a mechanism for unsharing of the selinux
namespace.  Thus, by itself, this change does not alter the existing
situation with respect to all processes still using a single init
selinux namespace.

An alternative would be to hang the selinux namespace off of the
user namespace, which itself is associated with the cred.  This
seems undesirable however since DAC and MAC are orthogonal, and
there appear to be real use cases where one will want to use selinux
namespaces without user namespaces and vice versa. However, one
advantage of hanging off the user namespace would be that it is already
associated with other namespaces, such as the network namespace, thus
potentially facilitating looking up the relevant selinux namespace from
the network input/forward hooks.  In most cases however, it appears that
we could instead copy a reference to the creating task selinux namespace
to sock security structures and use that in those hooks.

Introduce a task_security() helper to obtain the correct task/cred
security structure from the hooks, and update the hooks to use it.
This returns a pointer to the security structure for the task in
the same selinux namespace as the caller, or if there is none, a
fake security structure with the well-defined unlabeled SIDs.  This
ensures that we return a valid result that can be used for permission
checks and for returning contexts from e.g. reading /proc/pid/attr files.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 security/selinux/hooks.c            | 51 +++++++++++++++++++++++++----
 security/selinux/include/objsec.h   | 23 -------------
 security/selinux/include/security.h | 32 +++++++++++++++++-
 3 files changed, 75 insertions(+), 31 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index dc0b143ffa55..28cc75e5361b 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -103,8 +103,6 @@
 #include "audit.h"
 #include "avc_ss.h"
 
-struct selinux_ns *current_selinux_ns;
-
 /* SECMARK reference count */
 static atomic_t selinux_secmark_refcount = ATOMIC_INIT(0);
 
@@ -202,6 +200,8 @@ static int selinux_lsm_notifier_avc_callback(u32 event)
 	return 0;
 }
 
+static struct selinux_ns *init_selinux_ns  __ro_after_init;
+
 /*
  * initialise the security for the init task
  */
@@ -212,6 +212,7 @@ static void cred_init_security(void)
 
 	tsec = selinux_cred(cred);
 	tsec->osid = tsec->sid = SECINITSID_KERNEL;
+	tsec->ns = get_selinux_ns(init_selinux_ns);
 }
 
 /*
@@ -225,15 +226,35 @@ static inline u32 cred_sid(const struct cred *cred)
 	return tsec->sid;
 }
 
+static struct task_security_struct unlabeled_task_security = {
+	.osid = SECINITSID_UNLABELED,
+	.sid = SECINITSID_UNLABELED,
+};
+
+static const struct task_security_struct *task_security(
+	const struct task_struct *p)
+{
+	const struct task_security_struct *tsec;
+
+	tsec = selinux_cred(__task_cred(p));
+	while (tsec->ns != current_selinux_ns && tsec->parent_cred)
+		tsec = selinux_cred(tsec->parent_cred);
+	if (tsec->ns != current_selinux_ns)
+		return &unlabeled_task_security;
+	return tsec;
+}
+
 /*
  * get the objective security ID of a task
  */
 static inline u32 task_sid(const struct task_struct *task)
 {
+	const struct task_security_struct *tsec;
 	u32 sid;
 
 	rcu_read_lock();
-	sid = cred_sid(__task_cred(task));
+	tsec = task_security(task);
+	sid = tsec->sid;
 	rcu_read_unlock();
 	return sid;
 }
@@ -3889,6 +3910,18 @@ static int selinux_task_alloc(struct task_struct *task,
 			    sid, sid, SECCLASS_PROCESS, PROCESS__FORK, NULL);
 }
 
+/*
+ * free/release any cred memory other than the blob itself
+ */
+static void selinux_cred_free(struct cred *cred)
+{
+	struct task_security_struct *tsec = selinux_cred(cred);
+
+	put_selinux_ns(tsec->ns);
+	if (tsec->parent_cred)
+		put_cred(tsec->parent_cred);
+}
+
 /*
  * prepare a new set of credentials for modification
  */
@@ -3899,6 +3932,9 @@ static int selinux_cred_prepare(struct cred *new, const struct cred *old,
 	struct task_security_struct *tsec = selinux_cred(new);
 
 	*tsec = *old_tsec;
+	tsec->ns = get_selinux_ns(old_tsec->ns);
+	if (old_tsec->parent_cred)
+		tsec->parent_cred = get_cred(old_tsec->parent_cred);
 	return 0;
 }
 
@@ -3911,6 +3947,9 @@ static void selinux_cred_transfer(struct cred *new, const struct cred *old)
 	struct task_security_struct *tsec = selinux_cred(new);
 
 	*tsec = *old_tsec;
+	tsec->ns = get_selinux_ns(old_tsec->ns);
+	if (old_tsec->parent_cred)
+		tsec->parent_cred = get_cred(old_tsec->parent_cred);
 }
 
 static void selinux_cred_getsecid(const struct cred *c, u32 *secid)
@@ -6280,7 +6319,7 @@ static int selinux_getprocattr(struct task_struct *p,
 	unsigned len;
 
 	rcu_read_lock();
-	__tsec = selinux_cred(__task_cred(p));
+	__tsec = task_security(p);
 
 	if (current != p) {
 		error = avc_has_perm(current_selinux_ns,
@@ -6895,6 +6934,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(file_open, selinux_file_open),
 
 	LSM_HOOK_INIT(task_alloc, selinux_task_alloc),
+	LSM_HOOK_INIT(cred_free, selinux_cred_free),
 	LSM_HOOK_INIT(cred_prepare, selinux_cred_prepare),
 	LSM_HOOK_INIT(cred_transfer, selinux_cred_transfer),
 	LSM_HOOK_INIT(cred_getsecid, selinux_cred_getsecid),
@@ -7096,8 +7136,6 @@ void __put_selinux_ns(struct selinux_ns *ns)
 	schedule_work(&ns->work);
 }
 
-static struct selinux_ns *init_selinux_ns  __ro_after_init;
-
 static __init int selinux_init(void)
 {
 	pr_info("SELinux:  Initializing.\n");
@@ -7107,7 +7145,6 @@ static __init int selinux_init(void)
 
 	enforcing_set(init_selinux_ns, selinux_enforcing_boot);
 	init_selinux_ns->checkreqprot = selinux_checkreqprot_boot;
-	current_selinux_ns = init_selinux_ns;
 
 	/* Set the security state for the initial task. */
 	cred_init_security();
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 586b7abd0aa7..23188a47474f 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -28,15 +28,6 @@
 #include "flask.h"
 #include "avc.h"
 
-struct task_security_struct {
-	u32 osid;		/* SID prior to last execve */
-	u32 sid;		/* current SID */
-	u32 exec_sid;		/* exec SID */
-	u32 create_sid;		/* fscreate SID */
-	u32 keycreate_sid;	/* keycreate SID */
-	u32 sockcreate_sid;	/* fscreate SID */
-};
-
 enum label_initialized {
 	LABEL_INVALID,		/* invalid or not initialized */
 	LABEL_INITIALIZED,	/* initialized */
@@ -145,10 +136,6 @@ struct bpf_security_struct {
 };
 
 extern struct lsm_blob_sizes selinux_blob_sizes;
-static inline struct task_security_struct *selinux_cred(const struct cred *cred)
-{
-	return cred->security + selinux_blob_sizes.lbs_cred;
-}
 
 static inline struct file_security_struct *selinux_file(const struct file *file)
 {
@@ -175,14 +162,4 @@ static inline struct ipc_security_struct *selinux_ipc(
 	return ipc->security + selinux_blob_sizes.lbs_ipc;
 }
 
-/*
- * get the subjective security ID of the current task
- */
-static inline u32 current_sid(void)
-{
-	const struct task_security_struct *tsec = selinux_cred(current_cred());
-
-	return tsec->sid;
-}
-
 #endif /* _SELINUX_OBJSEC_H_ */
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 971fd5f53b6e..380ef3ede216 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -15,6 +15,8 @@
 #include <linux/types.h>
 #include <linux/refcount.h>
 #include <linux/workqueue.h>
+#include <linux/cred.h>
+#include <linux/lsm_hooks.h>
 #include "flask.h"
 
 #define SECSID_NULL			0x00000000 /* unspecified SID */
@@ -134,7 +136,35 @@ static inline struct selinux_ns *get_selinux_ns(struct selinux_ns *ns)
 	return ns;
 }
 
-extern struct selinux_ns *current_selinux_ns;
+struct task_security_struct {
+	u32 osid;		/* SID prior to last execve */
+	u32 sid;		/* current SID */
+	u32 exec_sid;		/* exec SID */
+	u32 create_sid;		/* fscreate SID */
+	u32 keycreate_sid;	/* keycreate SID */
+	u32 sockcreate_sid;	/* fscreate SID */
+	struct selinux_ns *ns;  /* selinux namespace */
+	const struct cred *parent_cred; /* cred in parent ns */
+};
+
+extern struct lsm_blob_sizes selinux_blob_sizes;
+
+static inline struct task_security_struct *selinux_cred(const struct cred *cred)
+{
+	return cred->security + selinux_blob_sizes.lbs_cred;
+}
+
+/*
+ * get the subjective security ID of the current task
+ */
+static inline u32 current_sid(void)
+{
+	const struct task_security_struct *tsec = selinux_cred(current_cred());
+
+	return tsec->sid;
+}
+
+#define current_selinux_ns (selinux_cred(current_cred())->ns)
 
 #ifdef CONFIG_SECURITY_SELINUX_DEVELOP
 static inline bool enforcing_enabled(struct selinux_ns *ns)
-- 
2.21.0

