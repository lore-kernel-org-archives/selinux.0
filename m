Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1131E2DE21D;
	Tue, 17 Jun 2025 14:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750169176; cv=none; b=f2yc2bURU5FDmIg17uUWIJPd0zbX2ZjcjlKJgzZtX2cVB3SI57kOMVP+DeqHHwBxPXXCByLHj1ZH51r6fAEHd1Metr5VxICFo9MgX2iKDO1UCxkq4ZuE6muQjkJOMh+YozAFdqzqKG3sHtFT4nuFOYUsEVyJ/4ouQLppocS45v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750169176; c=relaxed/simple;
	bh=nTIqpR2g6dJM2VeAHRGW9wVFSqCny+FCOQ1YJkNtLjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q6NU9quo2O2aekbAXPPz8KjNUU/HMf6MfkpI0b3jUBh1dZ8ilKDqL/4hbfbXhCru9yhzfRLbDU8+9cdKsWBwu9VR/FVq/WukLHDN2JPYUrYlsWqNVsXVSnjJn0d8/rYBlQDv3ZgThnyUcdN6kKspOmru6Ju3NZLX1IUc9s2hDj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hwJYYuj5; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hwJYYuj5"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7d219896edeso640452185a.1;
        Tue, 17 Jun 2025 07:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750169173; x=1750773973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LunVC5OZqfXksneF5KHB4IQpHU4Xy9+rqQQWbwmjr7Q=;
        b=hwJYYuj5p6GqPbx+fPjERT2suCr2ldxXdU9F3jV+H8z0tH2jxXyit4v/lJJb6QGXjd
         pnltii4bfUaAeKAapDFvwRxgdKCUeeYevznNEItHM4D9XsYqezmB5MISlwaR1ErUXlor
         W3ksG5ZYB9mCWrSloi9w/9/wAhj2GZKL0Q5ZUcbtSDKhtDPMfTX4uJV8HROx5xcxqhLQ
         J+I5VU00U9+kxq3/NeXLjkwk82cLX/DNS+jgctuljg/YEzR7vyoXmfILlTxRMJRpYXvj
         k6mSBQ4f8TXm+SNcx5j8HUiHp8+woqI4qXuGFWNrAZke3Wf98F0tyUuHeMKVQe8Vzwh+
         fjHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750169173; x=1750773973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LunVC5OZqfXksneF5KHB4IQpHU4Xy9+rqQQWbwmjr7Q=;
        b=g6qbvY2ciwqOta8qal5s5BqCR3hqlZpHqQv744FE3yRY4U9ypQJLXTxQS2Bwetfhpp
         f/ZtM9HHSl1E1qv7NR/DOqlgzA8OiQ88MxqnbbtXB3YE/C84mz09MauDCIahFae8hdjU
         Au8Mz01qCUtyWRridHu7QWMS53tOfrpfdXTqbax/BTnn/pkZASmFq+ONW1iuHBg9LVqA
         qMWREG6AKyaz4Jv+jnivekKzGYrt+MWTSJsyqPR/qVpC/WCkLTHJ+LvEy9jIdeVKwhCY
         H0ZZjdvDIUwG04f44YJgz/ukwV8CyXrFi/jwbygevtyXG8cHg1E/796DOV3Csp5gq1PN
         cyFg==
X-Forwarded-Encrypted: i=1; AJvYcCXOaF/vL8YXEbu9MoPcEVjY2fvEIwvzOWLd3NMf/x0iV5POHgUBU/RorOX4/wu1EXlM0+j3Wmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTEIV0d8LSmg7KCyZi3uhLHWZrnL9vOpfv7DaR8eHpC/GXjkQO
	VKg4DzYixNI465RtqCobxeFPhdUkiJk5jGzpgZhi45lwLiWKsNZTqSDsBCKwiA==
X-Gm-Gg: ASbGnctM4OkAXzycGg2SOnp/jnWA27AJl4ALVNrs/aX5+JpKUdjzf/qiBgSABogth1H
	BKwcFwfwG13ysQ4AWRyd1MAw6t1m95eDzlF/TuWng/dAXjerb3qmNZSDWaKEbWd1fHl2aMzEVWy
	mmlQCg3gwVbTVSMGwfWyCCGwjXjKYv4t50JE4649fAZMXtewz8OfTnMU/4QhTGoL3RXFH6PEpkp
	O6XD5aV3nXUc+oKweDoE9YfkaUU9Vd1Cg1hn6WvrRz7PqphxBJAl8aY3IkVdxh4Tmvuf4yB4CxN
	o/zjIxh4g/PZdwRpzuHUqTTg1rH7F47iVMy4DkNi4XrY0o4OC90rqp9J075XGe7RN7QjFk8VQLD
	RgMqqgi2X/az4nNdhsvdpGBIZBFhhWK4gHnO3zhL2GtGGeuSepXBBUeZAKL0feeaafg==
X-Google-Smtp-Source: AGHT+IHKBltZMW9wHsJ2kHQohEfnn32y2xgWoA4SF6RgBbBYS4Du6+3I/bZjfZXZcsnHXgRahcOHug==
X-Received: by 2002:a05:620a:40cb:b0:7d0:97b1:bfa with SMTP id af79cd13be357-7d3c6c0d376mr2418516885a.8.1750169172382;
        Tue, 17 Jun 2025 07:06:12 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8edbe29sm651079585a.91.2025.06.17.07.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 07:06:11 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v5 07/42] selinux: support per-task/cred selinux namespace
Date: Tue, 17 Jun 2025 10:04:54 -0400
Message-ID: <20250617140531.2036-8-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617140531.2036-1-stephen.smalley.work@gmail.com>
References: <20250617140531.2036-1-stephen.smalley.work@gmail.com>
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
 security/selinux/include/security.h | 47 ++++++++++++++++++++++++-
 3 files changed, 93 insertions(+), 44 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 32d961cecfab..95265434f1d4 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -107,9 +107,6 @@
 
 #define SELINUX_INODE_INIT_XATTRS 1
 
-struct selinux_state *init_selinux_state;
-struct selinux_state *current_selinux_state;
-
 /* SECMARK reference count */
 static atomic_t selinux_secmark_refcount = ATOMIC_INIT(0);
 
@@ -206,6 +203,8 @@ static int selinux_lsm_notifier_avc_callback(u32 event)
 	return 0;
 }
 
+struct selinux_state *init_selinux_state;
+
 /*
  * initialise the security for the init task
  */
@@ -217,6 +216,7 @@ static void cred_init_security(void)
 
 	tsec = selinux_cred(unrcu_pointer(current->real_cred));
 	tsec->osid = tsec->sid = tsec->avdcache.sid = SECINITSID_KERNEL;
+	tsec->state = get_selinux_state(init_selinux_state);
 }
 
 /*
@@ -230,6 +230,27 @@ static inline u32 cred_sid(const struct cred *cred)
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
@@ -260,10 +281,12 @@ static void ad_net_init_from_iif(struct common_audit_data *ad,
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
@@ -4190,6 +4213,18 @@ static int selinux_task_alloc(struct task_struct *task,
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
@@ -4200,6 +4235,9 @@ static int selinux_cred_prepare(struct cred *new, const struct cred *old,
 	struct task_security_struct *tsec = selinux_cred(new);
 
 	*tsec = *old_tsec;
+	tsec->state = get_selinux_state(old_tsec->state);
+	if (old_tsec->parent_cred)
+		tsec->parent_cred = get_cred(old_tsec->parent_cred);
 	return 0;
 }
 
@@ -4212,6 +4250,9 @@ static void selinux_cred_transfer(struct cred *new, const struct cred *old)
 	struct task_security_struct *tsec = selinux_cred(new);
 
 	*tsec = *old_tsec;
+	tsec->state = get_selinux_state(old_tsec->state);
+	if (old_tsec->parent_cred)
+		tsec->parent_cred = get_cred(old_tsec->parent_cred);
 }
 
 static void selinux_cred_getsecid(const struct cred *c, u32 *secid)
@@ -6626,7 +6667,7 @@ static int selinux_lsm_getattr(unsigned int attr, struct task_struct *p,
 	u32 len;
 
 	rcu_read_lock();
-	tsec = selinux_cred(__task_cred(p));
+	tsec = task_security(p);
 	if (p != current) {
 		error = avc_has_perm(current_selinux_state,
 				     current_sid(), tsec->sid,
@@ -7523,6 +7564,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(file_open, selinux_file_open),
 
 	LSM_HOOK_INIT(task_alloc, selinux_task_alloc),
+	LSM_HOOK_INIT(cred_free, selinux_cred_free),
 	LSM_HOOK_INIT(cred_prepare, selinux_cred_prepare),
 	LSM_HOOK_INIT(cred_transfer, selinux_cred_transfer),
 	LSM_HOOK_INIT(cred_getsecid, selinux_cred_getsecid),
@@ -7783,7 +7825,6 @@ static __init int selinux_init(void)
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
index 10f5b2079f04..8d162a32ad9e 100644
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
@@ -134,7 +136,50 @@ get_selinux_state(struct selinux_state *state)
 }
 
 extern struct selinux_state *init_selinux_state;
-extern struct selinux_state *current_selinux_state;
+
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

