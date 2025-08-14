Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2A13002D8;
	Thu, 14 Aug 2025 13:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755178034; cv=none; b=lqlW9yejpGV7PdP5cmdL6L1/sUo+jzIJDpGS1kwmJDQZwTK1+bwvYgbtgnKoK7D43lmTpMwNL2cOVzjjlZ3i99I8VopBgcNZURrGIi08FbgP6QSIAP3QTJ2GMkpuUFfOOeY6elkyKykr1o0t7YIOS3PDeQLx2GoKdwWv4GnTycA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755178034; c=relaxed/simple;
	bh=Fr0OANGzKBZJAfpiqwljkBTP7xgmelZPRiY09WtGe5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kXEsCAyppL1CtwAclpXaWKFVfm3SX9ZXgTALYavRYeiPOEHTd+bQEDNnTMvPTQevrzocyoF7KFgzdWTdhui5Uo9zeUf3aMOHsb2iOU2vN7idYLUp6dMYxcXKkTSUraKRlRMtbBpiqsy8xLlFImyPdwYNn5D57zIQCcooYINkGjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wl9uBE2e; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wl9uBE2e"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7e8706c880eso115619185a.3;
        Thu, 14 Aug 2025 06:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755178030; x=1755782830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kna1FJR69lo74UVyKtBxB1D4/zuPYJ/t1ZNmNHST10o=;
        b=Wl9uBE2etMYfaR3miAu+C2eWyDk8iUIJ+ZUYhFCj9/FzoR4ertq9I2LKI7WFnJOwc5
         TV+seJXHEuHt9oES2sIPYQVb5XSYZs8ASXTx6iBEfGT8y8bmMcaGuhILlXxFOh17KM9j
         yBNn5Nfb+n0lceIJ0634twDz8/VJE1nRU8Ov/oYnNLg95SIjS1m8jC8FYUe4yClUPeNz
         BusUdv9m2vEYKR/HD0JCc8aldLxJCpWn1h5DlxyqEvwP2p624X81y7c8s7Vaiz+Ef4sh
         VAl4W5wJW8IkoSGEu/Vnxx3ZtcK9IDyEILlSn0Sjm5WX9Acp9LSV510Vf/9ZQHA+mwjc
         cKLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755178030; x=1755782830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kna1FJR69lo74UVyKtBxB1D4/zuPYJ/t1ZNmNHST10o=;
        b=bnEZPnOcqxjN2wpcTx/OEExAALL6Nyg/WJEejghCMOrYqAn6Huqhq6ELCBDb3TE5J8
         rjtaFluCgyfI5jrNczsfdLjDpQnLFiaJ4PtRNLSzR5uXTSH5n9D4j3BX5yYsTPh6HVYg
         fV1QIE+0QLQXsyRAVCp/CsP2kno01dlBwF5cEKkTycti6imqs75KDSkQKHR9B4bfODEa
         gS5lmMBniWMOhoSbB25mGFN02bTPyarV5wJMDvqmdOXh21V+CogZpDuFPWevVW+imcss
         U9irKlwUhdcYFqimK7xy5TjNjm9/yy/Zp4riGY69pzPH9JPPoYu0oloVDyUbQauPCNpk
         ZzYA==
X-Forwarded-Encrypted: i=1; AJvYcCVGx3kCwMGi8GQmMCrIekKqngx7qaHVRKToh25uUXE8RAmpzqNcffdHItTp99nE3I++gXnavfI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9ul9Vs3T1qX0omJ5fYIAjjNRa+qPF2Gp5b/iv8EeSBsj2t+D+
	NlS2CQNs4qJGmZmH9py5iJxMYdM0yd0MQqqenx3qwHA4HDo0+69zFZu+63drPg==
X-Gm-Gg: ASbGncso4MxFrYo2hKCF2Dcf/CamxEWWyNFtlI7uuszsY6ypWGEUVGbCOJbacylBpJ2
	kjJf1dxIRUdlLoCb/nTIFY9OlkqeIz70GVSBQVKU6gvlmaZYupGIyh9MvfVQdTvuDNipukaV4JE
	WRuCbJ62jQ0EOKtqrA+4AyDCq/tMbGkSZiZN8Ar6qN+ovQtBO2qjD3LqIJh1Q9cS0Gt15iF9LVF
	Ax1LH3m4Pj2cAqfbwuQ6CHiaDSjt5hgUqNRWA/T/tqYut4Y651g43HzwITLCm9l2dJnWFUWkscZ
	0qOKoDprZLmcwqc7I2QrjXjOCc4rBYFgJa28yDNV3vWmM5nc5u8NkWHbXJDJvmdaD+Q1ime0YBd
	fhOSOw5s+dU5UcvQC3nrRmdCma4ahTlX+shYGcrITIx4cLZE9KnNJFQfCCLgIvWTUCuvJOYOsMe
	Q7zZuUTu3CDG/Y6whcHbzrKjxmvefH+yR+V9zK
X-Google-Smtp-Source: AGHT+IEfEadVDRY3r1V5J8dtFR7w2smyhW8Oe/8ghUV2yBNEazNnfAR32JAlz33NiKzMV3zIgljW7A==
X-Received: by 2002:a05:622a:4d0e:b0:4b0:6aa5:be8f with SMTP id d75a77b69052e-4b10a9b02ddmr54114321cf.25.1755178030401;
        Thu, 14 Aug 2025 06:27:10 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b0733088e1sm153587391cf.61.2025.08.14.06.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 06:27:09 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v7 07/42] selinux: support per-task/cred selinux namespace
Date: Thu, 14 Aug 2025 09:25:58 -0400
Message-ID: <20250814132637.1659-8-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250814132637.1659-1-stephen.smalley.work@gmail.com>
References: <20250814132637.1659-1-stephen.smalley.work@gmail.com>
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
 security/selinux/include/objsec.h   | 41 +---------------------
 security/selinux/include/security.h | 48 +++++++++++++++++++++++++-
 3 files changed, 95 insertions(+), 47 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 0d9ec74b6144..6a21c39cfa91 100644
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
@@ -4214,6 +4237,18 @@ static int selinux_task_alloc(struct task_struct *task,
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
@@ -4224,6 +4259,9 @@ static int selinux_cred_prepare(struct cred *new, const struct cred *old,
 	struct task_security_struct *tsec = selinux_cred(new);
 
 	*tsec = *old_tsec;
+	tsec->state = get_selinux_state(old_tsec->state);
+	if (old_tsec->parent_cred)
+		tsec->parent_cred = get_cred(old_tsec->parent_cred);
 	return 0;
 }
 
@@ -4236,6 +4274,9 @@ static void selinux_cred_transfer(struct cred *new, const struct cred *old)
 	struct task_security_struct *tsec = selinux_cred(new);
 
 	*tsec = *old_tsec;
+	tsec->state = get_selinux_state(old_tsec->state);
+	if (old_tsec->parent_cred)
+		tsec->parent_cred = get_cred(old_tsec->parent_cred);
 }
 
 static void selinux_cred_getsecid(const struct cred *c, u32 *secid)
@@ -6650,7 +6691,7 @@ static int selinux_lsm_getattr(unsigned int attr, struct task_struct *p,
 	u32 len;
 
 	rcu_read_lock();
-	tsec = selinux_cred(__task_cred(p));
+	tsec = task_security(p);
 	if (p != current) {
 		error = avc_has_perm(current_selinux_state,
 				     current_sid(), tsec->sid,
@@ -7549,6 +7590,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(file_open, selinux_file_open),
 
 	LSM_HOOK_INIT(task_alloc, selinux_task_alloc),
+	LSM_HOOK_INIT(cred_free, selinux_cred_free),
 	LSM_HOOK_INIT(cred_prepare, selinux_cred_prepare),
 	LSM_HOOK_INIT(cred_transfer, selinux_cred_transfer),
 	LSM_HOOK_INIT(cred_getsecid, selinux_cred_getsecid),
@@ -7809,7 +7851,6 @@ static __init int selinux_init(void)
 	if (selinux_state_create(NULL, &init_selinux_state))
 		panic("SELinux: Could not create initial namespace\n");
 	enforcing_set(init_selinux_state, selinux_enforcing_boot);
-	current_selinux_state = init_selinux_state;
 
 	/* Set the security state for the initial task. */
 	cred_init_security();
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index a4376a0ce032..cfac79df617b 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -29,36 +29,11 @@
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
-		tsec->avdcache.seqno ==
-			avc_policy_seqno(current_selinux_state));
+		tsec->avdcache.seqno == avc_policy_seqno(tsec->state));
 }
 
 enum label_initialized {
@@ -172,10 +147,6 @@ struct perf_event_security_struct {
 };
 
 extern struct lsm_blob_sizes selinux_blob_sizes;
-static inline struct task_security_struct *selinux_cred(const struct cred *cred)
-{
-	return cred->security + selinux_blob_sizes.lbs_cred;
-}
 
 static inline struct file_security_struct *selinux_file(const struct file *file)
 {
@@ -202,16 +173,6 @@ selinux_ipc(const struct kern_ipc_perm *ipc)
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
index 950601a28cd5..ae22ef45321e 100644
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
2.50.1

