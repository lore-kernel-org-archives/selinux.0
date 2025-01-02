Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF4A14F9D9
	for <selinux@vger.kernel.org>; Thu,  2 Jan 2025 16:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735836342; cv=none; b=IPfmFTZsSPqz1x11WqBt/A9W7jgd7q/RW7+21qcJloZ+uBf+QQgv/BQA3s0h1jp6TW/ODrs9Cf+AdX/s0nUtqU8gPocOHYvdwPM5ihxeZkrxqllFMlQpmlTDNJb/FxBm6rYA0PYzl52+f2uvZDU37uYOLvErEtXBEF9YOe37Ebs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735836342; c=relaxed/simple;
	bh=o8N/64DJtoinQsAVTN05TZEMPh3+U0EiSzZ2huUQjeY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KHi+Qy+x58QsdjDCWi4qhSQtm7i+Bq6VzHMc8URMg5BnJ6VbVZqBHyXLcGjPvRalbvQw+m06/ETlWE0J69Th1UkchVlXXs1uaERkq5ZzdvKWDnpQ4bdeDdGL/FFrUsxRdcPDPQ3Q1OV4foKpDykJIBwC/ViNJvTXRRKCaPPsvlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=coQTNWbd; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="coQTNWbd"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7b9bc648736so916186385a.1
        for <selinux@vger.kernel.org>; Thu, 02 Jan 2025 08:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735836337; x=1736441137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+jc/YEptHV5+pTbMpMTKlAxeLc9Kx4SucnHji5wT4Y=;
        b=coQTNWbdrYH9I7Fw4S3550IK8uOGxqGiddZUkLV0A4dGmajHArNcPsz+c3EsYJ3CQr
         wS42wIdWBfYzZtgIm1YKRI2v5Nt7z22O3HbrWhI2I4xwGZuEZJAIsGmkPURrELjEbre5
         YC8tzuFcDqvTi8skYXurintOFgWKoW9z+oplUOVa6yf4sv4vin4hzzaoKcobvk9b7z43
         JNYKgLm8XnaG0nrA9iBmKL8L8aycvXp7wSLWLkU3+BaaM173+xjwopwqfdBjYnOmmvwg
         ORpojA0H+ln65djOUjLd4Eb61VWLHNiQ/6ZrlOzD/spn7X7hQv3+wUJ4XfPoW1rni6lO
         FBvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735836337; x=1736441137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A+jc/YEptHV5+pTbMpMTKlAxeLc9Kx4SucnHji5wT4Y=;
        b=Z7FJsxMr/BiYS/KuSQuuciEhNTRNzh1CWdNQAPtoa0y7Yqlpjg7TEgxkt/POcM6aSg
         EaXdFvfL57/RdXUki6+bhlYjo7dH+J4lcCKSiS11fNGtNfJmeL8FmSe9HkVPwAVmsScF
         +H9jvphFaA4MFvlMQBiyOasdWBikcPQAXm7zb87Q3xrl0o9Qlzo0iCXDYg53A0B2/l1G
         VwyXUQqDFUVnMOFNBhz65zIYxRA66JfhszqqvN4Sma/ccBbo/2txUUoCkYw0K1U4mJ+E
         rr6Phs40dcuW842WUmIIFyK/3rFHuqPFTNwTpsACkeWjJwdYNIpiZXpXFJdz3sgi1IME
         Nqqg==
X-Gm-Message-State: AOJu0YwUHYpeqsE4Wp/SBu3O3uFQZLiC9zuoYfGNcCYh6bote4eKe9Bx
	vMp10uvhGAkiw7QCObJQlaW4qB13tlHZuHUZC25VvZ6Jws5ZnvVduy2zUw==
X-Gm-Gg: ASbGncuHO0tIBetLocKm97WW+FXN7KLeEEGlYQWRVfwRglI4fANKqPqCC9ETXL3czXF
	/5HC0yflzFRaTOYcG/LI6WjnxVmXX6bHaapo9aD3pTsn/ZjAdbcz+67E3vXXmW4m8Eyhv8EFwS2
	qaLIsbARvcuAZDoPpzI4NMIK640DvEM9To/zpiZP7MgPNmNlcZU0IuhXa4zytdBWUzAh+siLmlC
	X4NkZ8xqNJauYyTKQnKHhwTqAjNnX/Mwj+BYmV2SBPvmGq4wLABv6DPBQyvrpL/XAdJ0i9Zub5J
	2t1Llyx/BZLzW/SmLJDE+xAcpDBC0ai744S+2C9nZ0roRtpm/XZ/5qIYQh5YTrymLeuSKQ==
X-Google-Smtp-Source: AGHT+IFy88yNlBpePC5RbZ+qy5kjncym1+MKAk3mwLFVFkCM1VtVm828yyqzJ2CEyKj+J3bzttA0Hg==
X-Received: by 2002:a05:620a:44c4:b0:7b6:d2bb:25c4 with SMTP id af79cd13be357-7b9ba83e797mr7991196485a.62.1735836337189;
        Thu, 02 Jan 2025 08:45:37 -0800 (PST)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3eb19684sm136795101cf.58.2025.01.02.08.45.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jan 2025 08:45:36 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH 06/44] selinux: support per-task/cred selinux namespace
Date: Thu,  2 Jan 2025 11:44:31 -0500
Message-Id: <20250102164509.25606-7-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250102164509.25606-1-stephen.smalley.work@gmail.com>
References: <20250102164509.25606-1-stephen.smalley.work@gmail.com>
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
 security/selinux/hooks.c            | 50 +++++++++++++++++++++++++----
 security/selinux/include/objsec.h   | 23 -------------
 security/selinux/include/security.h | 32 +++++++++++++++++-
 3 files changed, 75 insertions(+), 30 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index ad8172ae7fda..ddaf1f527fe3 100644
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
@@ -216,6 +215,7 @@ static void cred_init_security(void)
 
 	tsec = selinux_cred(unrcu_pointer(current->real_cred));
 	tsec->osid = tsec->sid = SECINITSID_KERNEL;
+	tsec->state = get_selinux_state(init_selinux_state);
 }
 
 /*
@@ -229,6 +229,24 @@ static inline u32 cred_sid(const struct cred *cred)
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
@@ -259,10 +277,12 @@ static void ad_net_init_from_iif(struct common_audit_data *ad,
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
@@ -4067,6 +4087,18 @@ static int selinux_task_alloc(struct task_struct *task,
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
@@ -4077,6 +4109,9 @@ static int selinux_cred_prepare(struct cred *new, const struct cred *old,
 	struct task_security_struct *tsec = selinux_cred(new);
 
 	*tsec = *old_tsec;
+	tsec->state = get_selinux_state(old_tsec->state);
+	if (old_tsec->parent_cred)
+		tsec->parent_cred = get_cred(old_tsec->parent_cred);
 	return 0;
 }
 
@@ -4089,6 +4124,9 @@ static void selinux_cred_transfer(struct cred *new, const struct cred *old)
 	struct task_security_struct *tsec = selinux_cred(new);
 
 	*tsec = *old_tsec;
+	tsec->state = get_selinux_state(old_tsec->state);
+	if (old_tsec->parent_cred)
+		tsec->parent_cred = get_cred(old_tsec->parent_cred);
 }
 
 static void selinux_cred_getsecid(const struct cred *c, u32 *secid)
@@ -6499,7 +6537,7 @@ static int selinux_lsm_getattr(unsigned int attr, struct task_struct *p,
 	u32 len;
 
 	rcu_read_lock();
-	tsec = selinux_cred(__task_cred(p));
+	tsec = task_security(p);
 	if (p != current) {
 		error = avc_has_perm(current_selinux_state,
 				     current_sid(), tsec->sid,
@@ -7363,6 +7401,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(file_open, selinux_file_open),
 
 	LSM_HOOK_INIT(task_alloc, selinux_task_alloc),
+	LSM_HOOK_INIT(cred_free, selinux_cred_free),
 	LSM_HOOK_INIT(cred_prepare, selinux_cred_prepare),
 	LSM_HOOK_INIT(cred_transfer, selinux_cred_transfer),
 	LSM_HOOK_INIT(cred_getsecid, selinux_cred_getsecid),
@@ -7622,7 +7661,6 @@ static __init int selinux_init(void)
 	if (selinux_state_create(NULL, &init_selinux_state))
 		panic("SELinux: Could not create initial namespace\n");
 	enforcing_set(init_selinux_state, selinux_enforcing_boot);
-	current_selinux_state = init_selinux_state;
 
 	/* Set the security state for the initial task. */
 	cred_init_security();
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index c88cae81ee4c..d522caa7f93a 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -29,15 +29,6 @@
 #include "flask.h"
 #include "avc.h"
 
-struct task_security_struct {
-	u32 osid; /* SID prior to last execve */
-	u32 sid; /* current SID */
-	u32 exec_sid; /* exec SID */
-	u32 create_sid; /* fscreate SID */
-	u32 keycreate_sid; /* keycreate SID */
-	u32 sockcreate_sid; /* fscreate SID */
-} __randomize_layout;
-
 enum label_initialized {
 	LABEL_INVALID, /* invalid or not initialized */
 	LABEL_INITIALIZED, /* initialized */
@@ -149,10 +140,6 @@ struct perf_event_security_struct {
 };
 
 extern struct lsm_blob_sizes selinux_blob_sizes;
-static inline struct task_security_struct *selinux_cred(const struct cred *cred)
-{
-	return cred->security + selinux_blob_sizes.lbs_cred;
-}
 
 static inline struct file_security_struct *selinux_file(const struct file *file)
 {
@@ -179,16 +166,6 @@ selinux_ipc(const struct kern_ipc_perm *ipc)
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
index 6df38c714d1f..a66f061c7784 100644
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
@@ -132,7 +134,35 @@ get_selinux_state(struct selinux_state *state)
 	return state;
 }
 
-extern struct selinux_state *current_selinux_state;
+struct task_security_struct {
+	u32 osid; /* SID prior to last execve */
+	u32 sid; /* current SID */
+	u32 exec_sid; /* SID upon next execve */
+	u32 create_sid; /* SID for new files */
+	u32 keycreate_sid; /* SID for new keys */
+	u32 sockcreate_sid; /* SID for new sockets */
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
2.47.1

