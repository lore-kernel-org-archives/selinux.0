Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB70298CC9
	for <selinux@vger.kernel.org>; Thu, 15 May 2025 13:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747314627; cv=none; b=tw7679v42Ttes1AxC9CiVOURDTZqjx/qJlmIEcvPT/6pIa89cmtnU7uSM6uYq+jpUfJPPCRc2XCQeXSVs69op4WRL8JMgg6PgitmHLvLuEJrayYQTYEbOsCskbodm26oZqxll38jRrPgSjkW+nbsuuaXiLEbx6NQIBEiWU9FIXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747314627; c=relaxed/simple;
	bh=H5iDXvJDyqgPy8gYDTebjwNxbk2QqvYynhOa79Eo3eE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N5E6jRmDvcUgkKKrVPxLljlDD/Fp0a56zQODhaoEGeVF2Q/R49WCBtqA1rRX1PS+K8EAYzY3RSO8BGHCVaKAG+4jHo1RHvPDr1Pypm8eWj9wqdmpTLn2iMAPeZUyydSc0DJMk7ZCj3DsFOipxvWMsVUGS2kOcAVrRVVd+lyVMm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cBE6Br5Y; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBE6Br5Y"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-477282401b3so10095951cf.1
        for <selinux@vger.kernel.org>; Thu, 15 May 2025 06:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747314624; x=1747919424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UBRuDwGo8t301O6IYuLSH2xTeBGXsFgkXXDc5WNFCno=;
        b=cBE6Br5Y8CyY/4cLBzp3ROr0ljTLzlWM6WZfej0SvegM0InDMrF9z3DTS+xGW5kcxi
         35JcGfU2gZV5A2oQUnWcR42Arm0Yh3ktwZiuEq6MbfPyzr6jSGuExPfm36OwifA0uxZ0
         8+62SfJ12YVIeW5KFQm8wostzxMAr4shy1AO73QP2kJsayYK4Le4EKM1hNvwIOVjS96e
         skqOZ5KzdfvStfV+AHypXesVidXEe5L9h4sUlIHA7lIRHNMiG+eDFyVHeWeXNRFlis8v
         XCltrh5advXBjLDGE9I4/vYLoRtXvyCNxL5O5RDdQ9i5jk9ddpamZ4QYSrbT+7WQJmjB
         lYHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747314624; x=1747919424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UBRuDwGo8t301O6IYuLSH2xTeBGXsFgkXXDc5WNFCno=;
        b=B90qeaAO6roHrd4PEvItNGTdKwR1bbahXwueA1bpCAqt1URUTv9x+EmZLiYHUsWBJ9
         tg2wYfNqmQIqW1+21+5idx8EV+DBknUApR/Hhij1JsNUsAj5dCp2yTBaC3NYunuQKZNr
         fSMlYm3cBmqMSO81rGFbFblDuA2OhUCpDZqZEolAGjSTk84i+PO2Uy0ov9OL6/Bqu/zs
         Q/BXcNOYn0OfUJBSDOcbAw2+27gUhPZwBc53d8VDyjsaBYkLtjcmXbFJn91gM5NCxUF5
         Rzimts3e3KWmj8vLUetH5FTNJIaMMkBNvx7utnBzmvYLu4fF8fnLcgrvhfZyBooBurs9
         AODg==
X-Gm-Message-State: AOJu0Yy5c7Ltriy/lMC3Yu5tpv9UY1cdW59UuWCG4NApJ9OGpDTGvlWt
	hGlrjD0UdTzRI70eI0f6eiZmNw9hQz5fVjZTBUDVvSbLhli9enFVsXNj6Q==
X-Gm-Gg: ASbGncswUNuvBmlTRp8nA7coTa7sSNpiZqyYDbqcjeuc04BI2BgqCmiYYT/K+ejEWNF
	Z6FOprEt+Z9ZAQK5TfZCnwBb+NCMrZCOrOSQv/J9MD22b5FuE6xVYkgUrq6uWyRTEo9uHkiDw/0
	hKrKnod2Ji+i7Z1CNKn1tLP3saJKnwiky/LmemQlBHGmIW0+CIkT3/PHcqjtCC8mTumBe1wSv3P
	c3oHfDDb/McSFDtziw+rjrVDPGu27oMeO3sB5jNQvfCvEFpHnNBssF2E4BX+g8zUHilL73ogtOo
	pPxkVQN7hewoPX07YlDiLIqF8lR2RzaoeqqBJlZWz4/GRxtqvatOprQFnt0iakrh92g+UtiCfXC
	gjVY4ojcYjyo6GHAiEwT2m9bVpERdUP/606ARKto7n5W5vYd1gysblg==
X-Google-Smtp-Source: AGHT+IGsNy3JODlbbAMaq0JYEstK5pfpHsDaS2/ip4RGlpeD7jHRroWrHQ0aouViqzeeawTziHfuGA==
X-Received: by 2002:a05:622a:1f93:b0:476:ac03:3c2a with SMTP id d75a77b69052e-49495d2aefcmr134589351cf.43.1747314623282;
        Thu, 15 May 2025 06:10:23 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-49452583e88sm91723891cf.63.2025.05.15.06.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 06:10:22 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 06/49] selinux: support per-task/cred selinux namespace
Date: Thu, 15 May 2025 09:09:04 -0400
Message-ID: <20250515130947.52806-7-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515130947.52806-1-stephen.smalley.work@gmail.com>
References: <20250515130947.52806-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/hooks.c            | 53 +++++++++++++++++++++++++----
 security/selinux/include/objsec.h   | 37 --------------------
 security/selinux/include/security.h | 46 ++++++++++++++++++++++++-
 3 files changed, 92 insertions(+), 44 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index fe4c65b132a4..b6c619ba5635 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -108,9 +108,6 @@
 
 #define SELINUX_INODE_INIT_XATTRS 1
 
-static struct selinux_state *init_selinux_state;
-struct selinux_state *current_selinux_state;
-
 /* SECMARK reference count */
 static atomic_t selinux_secmark_refcount = ATOMIC_INIT(0);
 
@@ -207,6 +204,8 @@ static int selinux_lsm_notifier_avc_callback(u32 event)
 	return 0;
 }
 
+static struct selinux_state *init_selinux_state;
+
 /*
  * initialise the security for the init task
  */
@@ -218,6 +217,7 @@ static void cred_init_security(void)
 
 	tsec = selinux_cred(unrcu_pointer(current->real_cred));
 	tsec->osid = tsec->sid = tsec->avdcache.sid = SECINITSID_KERNEL;
+	tsec->state = get_selinux_state(init_selinux_state);
 }
 
 /*
@@ -231,6 +231,27 @@ static inline u32 cred_sid(const struct cred *cred)
 	return tsec->sid;
 }
 
+static struct task_security_struct unlabeled_task_security = {
+	.osid = SECINITSID_UNLABELED,
+	.sid = SECINITSID_UNLABELED,
+};
+
+/*
+ * Caller must hold RCU read lock.
+ */
+static const struct task_security_struct *task_security(
+	const struct task_struct *p)
+{
+	const struct task_security_struct *tsec;
+
+	tsec = selinux_cred(__task_cred(p));
+	while (tsec->state != current_selinux_state && tsec->parent_cred)
+		tsec = selinux_cred(tsec->parent_cred);
+	if (tsec->state != current_selinux_state)
+		return &unlabeled_task_security;
+	return tsec;
+}
+
 static void __ad_net_init(struct common_audit_data *ad,
 			  struct lsm_network_audit *net,
 			  int ifindex, struct sock *sk, u16 family)
@@ -261,10 +282,12 @@ static void ad_net_init_from_iif(struct common_audit_data *ad,
  */
 static inline u32 task_sid_obj(const struct task_struct *task)
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
@@ -4193,6 +4216,18 @@ static int selinux_task_alloc(struct task_struct *task,
 			    sid, sid, SECCLASS_PROCESS, PROCESS__FORK, NULL);
 }
 
+/*
+ * free/release any cred memory other than the blob itself
+ */
+static void selinux_cred_free(struct cred *cred)
+{
+	struct task_security_struct *tsec = selinux_cred(cred);
+
+	put_selinux_state(tsec->state);
+	if (tsec->parent_cred)
+		put_cred(tsec->parent_cred);
+}
+
 /*
  * prepare a new set of credentials for modification
  */
@@ -4203,6 +4238,9 @@ static int selinux_cred_prepare(struct cred *new, const struct cred *old,
 	struct task_security_struct *tsec = selinux_cred(new);
 
 	*tsec = *old_tsec;
+	tsec->state = get_selinux_state(old_tsec->state);
+	if (old_tsec->parent_cred)
+		tsec->parent_cred = get_cred(old_tsec->parent_cred);
 	return 0;
 }
 
@@ -4215,6 +4253,9 @@ static void selinux_cred_transfer(struct cred *new, const struct cred *old)
 	struct task_security_struct *tsec = selinux_cred(new);
 
 	*tsec = *old_tsec;
+	tsec->state = get_selinux_state(old_tsec->state);
+	if (old_tsec->parent_cred)
+		tsec->parent_cred = get_cred(old_tsec->parent_cred);
 }
 
 static void selinux_cred_getsecid(const struct cred *c, u32 *secid)
@@ -6665,7 +6706,7 @@ static int selinux_lsm_getattr(unsigned int attr, struct task_struct *p,
 	u32 len;
 
 	rcu_read_lock();
-	tsec = selinux_cred(__task_cred(p));
+	tsec = task_security(p);
 	if (p != current) {
 		error = avc_has_perm(current_selinux_state,
 				     current_sid(), tsec->sid,
@@ -7562,6 +7603,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(file_open, selinux_file_open),
 
 	LSM_HOOK_INIT(task_alloc, selinux_task_alloc),
+	LSM_HOOK_INIT(cred_free, selinux_cred_free),
 	LSM_HOOK_INIT(cred_prepare, selinux_cred_prepare),
 	LSM_HOOK_INIT(cred_transfer, selinux_cred_transfer),
 	LSM_HOOK_INIT(cred_getsecid, selinux_cred_getsecid),
@@ -7822,7 +7864,6 @@ static __init int selinux_init(void)
 	if (selinux_state_create(NULL, &init_selinux_state))
 		panic("SELinux: Could not create initial namespace\n");
 	enforcing_set(init_selinux_state, selinux_enforcing_boot);
-	current_selinux_state = init_selinux_state;
 
 	/* Set the security state for the initial task. */
 	cred_init_security();
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 6ee7dc4dfd6e..48cb69865a35 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -29,29 +29,6 @@
 #include "flask.h"
 #include "avc.h"
 
-struct avdc_entry {
-	u32 isid; /* inode SID */
-	u32 allowed; /* allowed permission bitmask */
-	u32 audited; /* audited permission bitmask */
-	bool permissive; /* AVC permissive flag */
-};
-
-struct task_security_struct {
-	u32 osid; /* SID prior to last execve */
-	u32 sid; /* current SID */
-	u32 exec_sid; /* exec SID */
-	u32 create_sid; /* fscreate SID */
-	u32 keycreate_sid; /* keycreate SID */
-	u32 sockcreate_sid; /* fscreate SID */
-#define TSEC_AVDC_DIR_SIZE (1 << 2)
-	struct {
-		u32 sid; /* current SID for cached entries */
-		u32 seqno; /* AVC sequence number */
-		unsigned int dir_spot; /* dir cache index to check first */
-		struct avdc_entry dir[TSEC_AVDC_DIR_SIZE]; /* dir entries */
-	} avdcache;
-} __randomize_layout;
-
 enum label_initialized {
 	LABEL_INVALID, /* invalid or not initialized */
 	LABEL_INITIALIZED, /* initialized */
@@ -163,10 +140,6 @@ struct perf_event_security_struct {
 };
 
 extern struct lsm_blob_sizes selinux_blob_sizes;
-static inline struct task_security_struct *selinux_cred(const struct cred *cred)
-{
-	return cred->security + selinux_blob_sizes.lbs_cred;
-}
 
 static inline struct file_security_struct *selinux_file(const struct file *file)
 {
@@ -193,16 +166,6 @@ selinux_ipc(const struct kern_ipc_perm *ipc)
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
 static inline struct superblock_security_struct *
 selinux_superblock(const struct super_block *superblock)
 {
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index eadef3f02c45..e628b66a1ed0 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -16,6 +16,8 @@
 #include <linux/rcupdate.h>
 #include <linux/refcount.h>
 #include <linux/workqueue.h>
+#include <linux/cred.h>
+#include <linux/lsm_hooks.h>
 #include <linux/delay.h>
 #include <linux/printk.h>
 #include "flask.h"
@@ -132,7 +134,49 @@ get_selinux_state(struct selinux_state *state)
 	return state;
 }
 
-extern struct selinux_state *current_selinux_state;
+struct avdc_entry {
+	u32 isid; /* inode SID */
+	u32 allowed; /* allowed permission bitmask */
+	u32 audited; /* audited permission bitmask */
+	bool permissive; /* AVC permissive flag */
+};
+
+struct task_security_struct {
+	u32 osid; /* SID prior to last execve */
+	u32 sid; /* current SID */
+	u32 exec_sid; /* SID upon next execve */
+	u32 create_sid; /* SID for new files */
+	u32 keycreate_sid; /* SID for new keys */
+	u32 sockcreate_sid; /* SID for new sockets */
+#define TSEC_AVDC_DIR_SIZE (1 << 2)
+	struct {
+		u32 sid; /* current SID for cached entries */
+		u32 seqno; /* AVC sequence number */
+		unsigned int dir_spot; /* dir cache index to check first */
+		struct avdc_entry dir[TSEC_AVDC_DIR_SIZE]; /* dir entries */
+	} avdcache;
+	struct selinux_state *state; /* selinux namespace */
+	const struct cred *parent_cred; /* cred in parent ns */
+} __randomize_layout;
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
+#define current_selinux_state (selinux_cred(current_cred())->state)
 
 static inline bool selinux_initialized(const struct selinux_state *state)
 {
-- 
2.49.0

