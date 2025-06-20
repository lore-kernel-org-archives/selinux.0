Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7FE2EAD08;
	Fri, 20 Jun 2025 17:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750441529; cv=none; b=EfiL4w7Z7bt9UuOT0YFNJT27qoMnFcitS+mgUjUoypau/429HVYf9fKDTV0LFKyyAXk+sM3uhJjD5owbiGySI2HxCFSiN0RVkivYMiYSm8cH8hB480YkCmVcNhVht51I44xIFhIxql5IsJcTeQDZ29OkNg/polaM0IQ5RMvr6ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750441529; c=relaxed/simple;
	bh=GIQEtkPd0+Yyuynvw6c04QoHyoYXGlMmFMtz3Vf+z1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ouh72nLoJbFe+qiqV78EZGecLNPdreSztXwVtRUzJbkrY6ghdMxpK91DMNJLJ/yh2MPh3U4cVGdPPLpcs45zHUCU4sRn5gXFuxzuNZIyhJkJhyzzUt7kAsis4ukxSpil5eN009hNCdcJUuT6lXBdJ1RG6aTsa13KqYfHm0uBXyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=miR6BWlw; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="miR6BWlw"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6fad4e6d949so11298126d6.0;
        Fri, 20 Jun 2025 10:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750441526; x=1751046326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E4j8vVSoHeVr2jBINWWnPVGTfVTA6QYA6ziuPExi7Ug=;
        b=miR6BWlwRBnCSl4ssm15HP9hj8knuY7wIi8BmizTrq1KCkdcapLMBGXgPgHfwFHYPP
         twwiwpHEL/5VBCVGRhTkd3KXtw3HhqJLv6e8g/2BGG8LIM27itVdVQbdeabZRNBne/IG
         989jKqJGKueW+PFLRl+Mk0v1/wLFZp6yW3azMSBTO/Oe70YjeZRQTg5XvE+d/JepD6R8
         /ZrdL0zxNGc2e1FZObtUBwUIr1sEPMhrRNuPlz53ERNxlytpJgcL9v6y+X+0kn8pvpW7
         FdCTWfEywMFiWsjr5px4lC9KlzUfmn8B+4hJc5CEN+HNY/YjkdsVJ2Nw2vZuvbdaPwKD
         6/eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750441526; x=1751046326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E4j8vVSoHeVr2jBINWWnPVGTfVTA6QYA6ziuPExi7Ug=;
        b=wNk6tCcmZcyWyhq+AwAm8yoGPuELXWzNBoXW7QY3RtjXjZmRoT/uZAW3aBFFv41tnA
         Le/GykfRsyj+Pncj7vfiRYCauUMW0u3d+msIRZKDn+tqZf6H8/WjmH/SKxQM6hzntxzS
         lO5DRaquEVv1PPFDoqdYLSBtyIWeYXh1SONKPl3TWi9yTsRV23BHyNTeTRuXcGvU8Lsa
         GaAHAJWC42riftdWrgiuIUNwz20G22US48JuS+RFt+45m50gdNOChrqCGXN7WrKBuUrT
         yWIsd5NECW8875lISFynolgxjKonlL6nGmq8I44MvqikEbO5nZpRNb9Qc9Kim6VEIQ1P
         P6pA==
X-Forwarded-Encrypted: i=1; AJvYcCUlYhQV06EEgPBFGGQvJyPMN/PfUwOHt0ETZgEWdI0Cd9YA6esk6xxWr+dKTNHciQMBLJdVjlE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKvUiLseic23Z9CZxsVcR4GJRj/vfUq2AjgDw5MQf2K5bHZ3Vx
	3xFYslxOh1jqRfNHFsRQMKoyFMo5GYc4/xMY3Yf/SuM/M3VE9Q8H0YCMLddYOw==
X-Gm-Gg: ASbGnctbjFnigY87DzXElMAqhFkcnjx3X0fdwx3OjxK68yWv88aYLrR596E5o5UV/Mw
	srenP7wWb9Mb03N2g+yLQJ5KA5jLfBwlXct/TNypXLN1wF4uQZH81PHBAGjEdV8ZOo0+oAb5u3s
	ahtsKwg4yz0XvzP2YFMM6L74D/cwuEx0k1rya0+1qEwJciPxyqOw0cScEtkOxeDuHAvn6wzUFDP
	oaDQUedaOeuiHHG2nSfCwJqCTB/YHkgo4DcmJOfgJED1HzbvuYMK/R6+xSYScuKcXUllJzh5rNA
	oTZ7OwqJPQWVxcnWjhzNtXxBQ+k91UktMcboqEbRM80qarg0IKZgMcOli9D3Jtq+vli6li5Mkx/
	ssqUMRix0lkT0z4C/0/Ofjg8dynHxKnEGaRIQmUm0EALlzvcBNh7hoz4ilFMGKuyLEA==
X-Google-Smtp-Source: AGHT+IF1IPbRtGzLW90MtzS4rlW5XNntaykix2YkFBsqoYad5Vz37fgVdvF9qL1FtcoF91JMcYGKZg==
X-Received: by 2002:a05:6214:242f:b0:6fa:c168:8de4 with SMTP id 6a1803df08f44-6fd0a5785edmr57108776d6.33.1750441525525;
        Fri, 20 Jun 2025 10:45:25 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd093decf0sm14580976d6.16.2025.06.20.10.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 10:45:25 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v6 07/42] selinux: support per-task/cred selinux namespace
Date: Fri, 20 Jun 2025 13:44:19 -0400
Message-ID: <20250620174502.1838-8-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620174502.1838-1-stephen.smalley.work@gmail.com>
References: <20250620174502.1838-1-stephen.smalley.work@gmail.com>
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
 security/selinux/include/objsec.h   | 40 +---------------------
 security/selinux/include/security.h | 48 +++++++++++++++++++++++++-
 3 files changed, 95 insertions(+), 46 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 331b464fcec9..53147dd87ce4 100644
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
@@ -4202,6 +4225,18 @@ static int selinux_task_alloc(struct task_struct *task,
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
@@ -4212,6 +4247,9 @@ static int selinux_cred_prepare(struct cred *new, const struct cred *old,
 	struct task_security_struct *tsec = selinux_cred(new);
 
 	*tsec = *old_tsec;
+	tsec->state = get_selinux_state(old_tsec->state);
+	if (old_tsec->parent_cred)
+		tsec->parent_cred = get_cred(old_tsec->parent_cred);
 	return 0;
 }
 
@@ -4224,6 +4262,9 @@ static void selinux_cred_transfer(struct cred *new, const struct cred *old)
 	struct task_security_struct *tsec = selinux_cred(new);
 
 	*tsec = *old_tsec;
+	tsec->state = get_selinux_state(old_tsec->state);
+	if (old_tsec->parent_cred)
+		tsec->parent_cred = get_cred(old_tsec->parent_cred);
 }
 
 static void selinux_cred_getsecid(const struct cred *c, u32 *secid)
@@ -6638,7 +6679,7 @@ static int selinux_lsm_getattr(unsigned int attr, struct task_struct *p,
 	u32 len;
 
 	rcu_read_lock();
-	tsec = selinux_cred(__task_cred(p));
+	tsec = task_security(p);
 	if (p != current) {
 		error = avc_has_perm(current_selinux_state,
 				     current_sid(), tsec->sid,
@@ -7535,6 +7576,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(file_open, selinux_file_open),
 
 	LSM_HOOK_INIT(task_alloc, selinux_task_alloc),
+	LSM_HOOK_INIT(cred_free, selinux_cred_free),
 	LSM_HOOK_INIT(cred_prepare, selinux_cred_prepare),
 	LSM_HOOK_INIT(cred_transfer, selinux_cred_transfer),
 	LSM_HOOK_INIT(cred_getsecid, selinux_cred_getsecid),
@@ -7795,7 +7837,6 @@ static __init int selinux_init(void)
 	if (selinux_state_create(NULL, &init_selinux_state))
 		panic("SELinux: Could not create initial namespace\n");
 	enforcing_set(init_selinux_state, selinux_enforcing_boot);
-	current_selinux_state = init_selinux_state;
 
 	/* Set the security state for the initial task. */
 	cred_init_security();
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 1d7ac59015a1..cfac79df617b 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -29,35 +29,11 @@
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
-		bool permissive_neveraudit; /* permissive and neveraudit */
-	} avdcache;
-} __randomize_layout;
-
 static inline bool task_avdcache_permnoaudit(struct task_security_struct *tsec)
 {
 	return (tsec->avdcache.permissive_neveraudit &&
 		tsec->sid == tsec->avdcache.sid &&
-		tsec->avdcache.seqno == avc_policy_seqno());
+		tsec->avdcache.seqno == avc_policy_seqno(tsec->state));
 }
 
 enum label_initialized {
@@ -171,10 +147,6 @@ struct perf_event_security_struct {
 };
 
 extern struct lsm_blob_sizes selinux_blob_sizes;
-static inline struct task_security_struct *selinux_cred(const struct cred *cred)
-{
-	return cred->security + selinux_blob_sizes.lbs_cred;
-}
 
 static inline struct file_security_struct *selinux_file(const struct file *file)
 {
@@ -201,16 +173,6 @@ selinux_ipc(const struct kern_ipc_perm *ipc)
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
index fbbca70ab963..b94cc01f181a 100644
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
@@ -135,7 +137,51 @@ get_selinux_state(struct selinux_state *state)
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
+		bool permissive_neveraudit; /* permissive and neveraudit */
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

