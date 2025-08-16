Received: from sonic310-30.consmr.mail.ne1.yahoo.com (sonic310-30.consmr.mail.ne1.yahoo.com [66.163.186.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86D43002BC
	for <selinux@vger.kernel.org>; Sat, 16 Aug 2025 17:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.186.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755365367; cv=none; b=J80ZO0xhI/YVnvCsCF+dPBT02qWj7NFHWScnUwfKi5RGOhjEDx2qh/cUZ5boql5OVqi/+pMPFrp+//bZnfB0+OHc3HecXtfKI8OtSDlfoehEupbG24ZS/ZlE24TzA9BjKKWVX9idXpVfcRR6TKUl+n1MfZIh3WLd0Am2EMMXsHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755365367; c=relaxed/simple;
	bh=opmLbSEBotBvI1yuKRKT9WejLKBo0eNa0QroIBsDs5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZLmNqm60reu8HQyhQzvdIgjFzwlipUQ4WQPRcpNLLlOFosV6KQ9Lfv1EdNUNfOly9tRDY6mei2cpyQtPupUuJTYqLT689M/v9KO+jZ6N4BLI2LhszR/aIXg7yew9K7GFoIljnU/d69dkKVjX60WIKOS8HZdjqDNIFXaL6KRcRgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=fibusT7f; arc=none smtp.client-ip=66.163.186.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="fibusT7f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1755365356; bh=tORoYsfNrRhhb2GqJbE8RmU2+8hj92sgtnIUvWxQHy0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=fibusT7fkPD/yg1cJlIsd2Fj1JQZ6Oo9Bn54Zo7T/6VhOel8UXoYGSj5rxxVHgvrQns+EnkpSD34naHNGbRq78EqbLYVagNbm8TwuBxjBI1W+07V/ETZ/c8TGmsVFbK9zLIzI1VQuHm8z/Z107r+E03N3ev325o9qMw2PujM3B3ZdUrH+Y8Nb00w7Hm2a3kUIq9jnZXiTK9eiMJkWhJVuSIQnF1p/RBSIYwlNuUZWw8iM16w5pwWFnln7uhrAg2DWN6AEcCVthc5l/dYcxUkL/gYq1K4nHu3aSHuXqxKblbxuKHyvrlzH1wn2YQCQR3NC/6FC7ymKiltfahwbLjZmw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1755365356; bh=dJK++GnwYrPan1iiyMRqTFmjSA+xMbTyUW4OSmVEj48=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=m3htZUxezKD/bGfV/5mjc9yhnoNCrPEi/YexgbYSnKUGrq+LphrF0ylPOuZdlLZPYfZA8QJwK3Q94l014CLGMlW6L3K15CBHb0vFSHEPsSZv5bWV4QCp1J1nkgvPy4bjLOrrcCgMYdok0xORFUbO00HRR6Y8mCQB0zxZgLxYscY04eYJCi4x5AhU961NJZq9TcI1ULeF1QVpC2m1tewRxlfb0tSeeiBUqpJAxl3aclJBwbGKD5rU4sPZN/BCipFmm3IbNMhFbOsnvcnm3BjGJ2BbKr+DvnQue31zHUntaQFAJCgDru+KsFCzLvmuepDiuEzV7iXMbEyTbyRxI7bzbQ==
X-YMail-OSG: byN0QNsVM1muBYYTHteLcN8zhY6e2xjerD2imS1okPnC41pDWfMBtfp0gWxKsV0
 CB6J4iLsIGKW9VFMJpylIviBN.4lA0b1zMDz6Zi5sjFXXm7BNG7637s_jeGLqq3j9S5VlE3saDvv
 C8ix6yDvPuM8Kdvn538YsZHdPWS5omgcp1Y.92xC9uYhSemOL5ymWdvR5HEQCd1D5aA7bkCVtbB2
 bgpx83Z86IfdZP4SNXv2fpDhTlhuHLNOfqHlMoB8gYxH8JJKqRSYcgnhpSmzGStuFiHIDK7ePxQf
 S9LT4O1yMWphE2Nddjw85XkziilRQzv_paf9QLpIgFFev3gbyshoFqBYfKFLA3slo2QM2Babd4yo
 00Mg38C6OErHPv_DsO_f0xXzmX6n7SkFHkRzyzh2Pmlp59OgjdtUdZhtouWB68nxxZERRepUJ.MR
 S4N5oIHNQKJUXrgNKcpBPgAbjrN3RadizXpGRQ1Zo_vwMdlvwutUdoXZQ478SptdQlyRKyyqlM.L
 7FMGG5D3AYHr6w_peXnxXQTKYqTO3Sh.bAivACbxh3Dc9n5DRbTUHz9ZyI5SCdCiY6Xd40j5QDTF
 Nx8Op0lEHCYWYZPOkbaCAYhkp5GkEsVPjdZ1PiaYURIntjjrRMDy3IxRtXbNcT1QXmG3glbVjup_
 pC4Z1XFGQoWBe8XNkf4wYqQQVLApAEPIOjdXwO8t1HRRSrqM9iPfZWnghKCMPWFVLDVQO0qJGMi_
 bXP9VXyjYP1qGLh98XOzfWvpWu3U4B0Z1_SlDFK8ksrE5BC6th29gw1GekebAXjXCgzZEeBB5W.M
 1byJLP_idwLSgbj3ZouG0KJPs4OAhFeo9JndjSpLu.AMGDDr_hOd8udunnDM5kSPpb53KTissd5s
 JhDetNrukq_6rjL.rJ1gQOYXZjK0ws6lUyuxkfL1dSLAEtVujB5wH0s6BF7_5uvRE.sQTk5ArBP.
 AmxIjc9pZUeI33LURBLVm7Q4QvFSLDqyBx1Mk5eYFyLrFz9wRdtckFuwRIBsYWfcspzwqD0pJ0R8
 3LbOMp3_.qxnITmqFm2zwLA4BNilA.p5_IiPLco4zYVlGBmVmTyjSD5vB.zf6rE6srAxgXlLQ1YK
 EQ9MPfhNL9PCoN9d0csbQmtLsiJsvyxhJ8CfVGUhRx2_PSWN2QTY8YOwm0vbst8IZDqIQwVDkFLX
 eOiG6YlQlJxEFJ9YIXII.NnEOfq4EGl7Y.JLGmgc1w6m4W992vJrZFhQ9tmxFKluY0Qa4iWAEBJV
 qW_SML7d2SrQZ9jSEmuylkmVW8FiGJn0oXyfmiXdIP8WFwvgJeg_Bh94hB1mstUcLsd7F8NS0LaF
 fC.sHM12Lnb3xwPK8yXuDbF1nDWaU.HCx92zF7OaRKMgy39CN0QmwRr5FETzzsl3L_GR4c3PkkFP
 LnuUKz4HBsnSZV5p.RHvKj9oOrIBBTn9Auk4GyV6C7yRvBnMEc5VgiW1.7VhW0huY5maJ_1igBnX
 5tcMSNMvLCZ2O3Oo9CeZ6vwbyq5OuWut6x.KqVUhIcyEpGuoOefoiUCLBU_GBLdT4M7bDpErdZaM
 OvnUY8mMD4vm7a7jrTIB6wGDxtsW3.xl5YPM2p2SF_pTgxFu7cQtH9eRghQO2DBa..vxF35PTMW1
 LGfYGWP7qFUl1I1xeb1syrao_TtG9ZcDx7UoGVl6eu0zLAvuGrJK1H4Z6WiRz8jPsqQ9oYURgcWF
 9iSFvTy0ddNv0Mm83_O1xwFqe3wQJmTCu3ybSsLzejXp.RrppLYaKqE3O8MxN2Q7hqAYrVnmHJev
 jd3VcxvMVhVw2IoRuut3NJLuqh5oalwavBzZDpKM8PhPLidqjF0QUjSn2.qgZfIvh1NJbyzvD0YT
 7Lc75hriAX_syNETIDPrwu3xYXgw26ts92NgESpzsff96kn5RHrhZ1ARKk7uN.YmSjNLB_XwrmY3
 F4Y0S2iS8kVhGfUrsVRypIzK0lZ2uu4axyyzD6_UzmDvfw_BVbPpAmH6P0HPa5ki9iVlk_Yx.._J
 BiU.XxAeMtygZ7yq3JyU4pAHkqeYludZWqqoOz6So9WFcVf7fHDSOwfCqEkKeb7NAoia1YFfwN2R
 O8PShWF_pOw0XN.WzSYeDicnCGbhn9nEbgwVzX4PzIvUaXo4R_RaVmr.Qvxo5H5DaFU9zC1TDUbO
 5jXgIYmtE3N4w85MRWokM5O.FXEDsVN34IqSrO8NLvsie58BUMus_JbvdPNYI_NYhrPlaC9sfDcb
 A04WqssvAsvJENRQ6QkfKPh.07fUqXXR149VUth_I4TpKFU4mI5c1s5frIfmG5khrHDgo_j7ndIs
 CiAv.CubjdNtUmok63VKz8ZEw8qgimTvqlw--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 9bba87de-012f-4754-9bce-3e24872a0a32
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Sat, 16 Aug 2025 17:29:16 +0000
Received: by hermes--production-gq1-74d64bb7d7-45lk9 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a7374b10bab8e01c99c92e4838c45fe8;
          Sat, 16 Aug 2025 17:29:15 +0000 (UTC)
From: Casey Schaufler <casey@schaufler-ca.com>
To: casey@schaufler-ca.com,
	paul@paul-moore.com,
	eparis@redhat.com,
	linux-security-module@vger.kernel.org,
	audit@vger.kernel.org
Cc: jmorris@namei.org,
	serge@hallyn.com,
	keescook@chromium.org,
	john.johansen@canonical.com,
	penguin-kernel@i-love.sakura.ne.jp,
	stephen.smalley.work@gmail.com,
	linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org
Subject: [PATCH v6 3/4] Audit: Add record for multiple task security contexts
Date: Sat, 16 Aug 2025 10:28:58 -0700
Message-ID: <20250816172859.6437-4-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250816172859.6437-1-casey@schaufler-ca.com>
References: <20250816172859.6437-1-casey@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the single skb pointer in an audit_buffer with a list of
skb pointers. Add the audit_stamp information to the audit_buffer as
there's no guarantee that there will be an audit_context containing
the stamp associated with the event. At audit_log_end() time create
auxiliary records as have been added to the list. Functions are
created to manage the skb list in the audit_buffer.

Create a new audit record AUDIT_MAC_TASK_CONTEXTS.
An example of the MAC_TASK_CONTEXTS record is:

    type=MAC_TASK_CONTEXTS
    msg=audit(1600880931.832:113)
    subj_apparmor=unconfined
    subj_smack=_

When an audit event includes a AUDIT_MAC_TASK_CONTEXTS record the
"subj=" field in other records in the event will be "subj=?".
An AUDIT_MAC_TASK_CONTEXTS record is supplied when the system has
multiple security modules that may make access decisions based on a
subject security context.

Refactor audit_log_task_context(), creating a new audit_log_subj_ctx().
This is used in netlabel auditing to provide multiple subject security
contexts as necessary.

Suggested-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/audit.h        |  16 +++
 include/uapi/linux/audit.h   |   1 +
 kernel/audit.c               | 208 +++++++++++++++++++++++++++++------
 net/netlabel/netlabel_user.c |   9 +-
 security/apparmor/lsm.c      |   3 +
 security/selinux/hooks.c     |   3 +
 security/smack/smack_lsm.c   |   3 +
 7 files changed, 202 insertions(+), 41 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index a394614ccd0b..38e5edffe371 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -37,6 +37,8 @@ struct audit_watch;
 struct audit_tree;
 struct sk_buff;
 struct kern_ipc_perm;
+struct lsm_id;
+struct lsm_prop;
 
 struct audit_krule {
 	u32			pflags;
@@ -147,6 +149,9 @@ extern unsigned compat_signal_class[];
 #define AUDIT_TTY_ENABLE	BIT(0)
 #define AUDIT_TTY_LOG_PASSWD	BIT(1)
 
+/* bit values for audit_cfg_lsm */
+#define AUDIT_CFG_LSM_SECCTX_SUBJECT	BIT(0)
+
 struct filename;
 
 #define AUDIT_OFF	0
@@ -185,6 +190,7 @@ extern void		    audit_log_path_denied(int type,
 						  const char *operation);
 extern void		    audit_log_lost(const char *message);
 
+extern int audit_log_subj_ctx(struct audit_buffer *ab, struct lsm_prop *prop);
 extern int audit_log_task_context(struct audit_buffer *ab);
 extern void audit_log_task_info(struct audit_buffer *ab);
 
@@ -210,6 +216,8 @@ extern u32 audit_enabled;
 
 extern int audit_signal_info(int sig, struct task_struct *t);
 
+extern void audit_cfg_lsm(const struct lsm_id *lsmid, int flags);
+
 #else /* CONFIG_AUDIT */
 static inline __printf(4, 5)
 void audit_log(struct audit_context *ctx, gfp_t gfp_mask, int type,
@@ -245,6 +253,11 @@ static inline void audit_log_key(struct audit_buffer *ab, char *key)
 { }
 static inline void audit_log_path_denied(int type, const char *operation)
 { }
+static inline int audit_log_subj_ctx(struct audit_buffer *ab,
+				     struct lsm_prop *prop)
+{
+	return 0;
+}
 static inline int audit_log_task_context(struct audit_buffer *ab)
 {
 	return 0;
@@ -269,6 +282,9 @@ static inline int audit_signal_info(int sig, struct task_struct *t)
 	return 0;
 }
 
+static inline void audit_cfg_lsm(const struct lsm_id *lsmid, int flags)
+{ }
+
 #endif /* CONFIG_AUDIT */
 
 #ifdef CONFIG_AUDIT_COMPAT_GENERIC
diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index 9a4ecc9f6dc5..8cad2f307719 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -148,6 +148,7 @@
 #define AUDIT_IPE_POLICY_LOAD	1422	/* IPE policy load */
 #define AUDIT_LANDLOCK_ACCESS	1423	/* Landlock denial */
 #define AUDIT_LANDLOCK_DOMAIN	1424	/* Landlock domain status */
+#define AUDIT_MAC_TASK_CONTEXTS	1425	/* Multiple LSM task contexts */
 
 #define AUDIT_FIRST_KERN_ANOM_MSG   1700
 #define AUDIT_LAST_KERN_ANOM_MSG    1799
diff --git a/kernel/audit.c b/kernel/audit.c
index 226c8ae00d04..c924b30f2524 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -54,6 +54,7 @@
 #include <net/netlink.h>
 #include <linux/skbuff.h>
 #include <linux/security.h>
+#include <linux/lsm_hooks.h>
 #include <linux/freezer.h>
 #include <linux/pid_namespace.h>
 #include <net/netns/generic.h>
@@ -81,6 +82,11 @@ static u32	audit_failure = AUDIT_FAIL_PRINTK;
 /* private audit network namespace index */
 static unsigned int audit_net_id;
 
+/* Number of modules that provide a security context.
+   List of lsms that provide a security context */
+static u32 audit_subj_secctx_cnt;
+static const struct lsm_id *audit_subj_lsms[MAX_LSM_COUNT];
+
 /**
  * struct audit_net - audit private network namespace data
  * @sk: communication socket
@@ -195,8 +201,10 @@ static struct audit_ctl_mutex {
  * to place it on a transmit queue.  Multiple audit_buffers can be in
  * use simultaneously. */
 struct audit_buffer {
-	struct sk_buff       *skb;	/* formatted skb ready to send */
+	struct sk_buff       *skb;	/* the skb for audit_log functions */
+	struct sk_buff_head  skb_list;	/* formatted skbs, ready to send */
 	struct audit_context *ctx;	/* NULL or associated context */
+	struct audit_stamp   stamp;	/* audit stamp for these records */
 	gfp_t		     gfp_mask;
 };
 
@@ -278,6 +286,27 @@ static pid_t auditd_pid_vnr(void)
 	return pid;
 }
 
+/**
+ * audit_cfg_lsm - Identify a security module as providing a secctx.
+ * @lsmid: LSM identity
+ * @flags: which contexts are provided
+ *
+ * Description:
+ * Increments the count of the security modules providing a secctx.
+ * If the LSM id is already in the list leave it alone.
+ */
+void audit_cfg_lsm(const struct lsm_id *lsmid, int flags)
+{
+	int i;
+
+	if (flags & AUDIT_CFG_LSM_SECCTX_SUBJECT) {
+		for (i = 0 ; i < audit_subj_secctx_cnt; i++)
+			if (audit_subj_lsms[i] == lsmid)
+				return;
+		audit_subj_lsms[audit_subj_secctx_cnt++] = lsmid;
+	}
+}
+
 /**
  * audit_get_sk - Return the audit socket for the given network namespace
  * @net: the destination network namespace
@@ -1776,10 +1805,13 @@ __setup("audit_backlog_limit=", audit_backlog_limit_set);
 
 static void audit_buffer_free(struct audit_buffer *ab)
 {
+	struct sk_buff *skb;
+
 	if (!ab)
 		return;
 
-	kfree_skb(ab->skb);
+	while ((skb = skb_dequeue(&ab->skb_list)))
+		kfree_skb(skb);
 	kmem_cache_free(audit_buffer_cache, ab);
 }
 
@@ -1795,6 +1827,10 @@ static struct audit_buffer *audit_buffer_alloc(struct audit_context *ctx,
 	ab->skb = nlmsg_new(AUDIT_BUFSIZ, gfp_mask);
 	if (!ab->skb)
 		goto err;
+
+	skb_queue_head_init(&ab->skb_list);
+	skb_queue_tail(&ab->skb_list, ab->skb);
+
 	if (!nlmsg_put(ab->skb, 0, 0, type, 0, 0))
 		goto err;
 
@@ -1860,7 +1896,6 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
 				     int type)
 {
 	struct audit_buffer *ab;
-	struct audit_stamp stamp;
 
 	if (audit_initialized != AUDIT_INITIALIZED)
 		return NULL;
@@ -1915,14 +1950,14 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
 		return NULL;
 	}
 
-	audit_get_stamp(ab->ctx, &stamp);
+	audit_get_stamp(ab->ctx, &ab->stamp);
 	/* cancel dummy context to enable supporting records */
 	if (ctx)
 		ctx->dummy = 0;
 	audit_log_format(ab, "audit(%llu.%03lu:%u): ",
-			 (unsigned long long)stamp.ctime.tv_sec,
-			 stamp.ctime.tv_nsec/1000000,
-			 stamp.serial);
+			 (unsigned long long)ab->stamp.ctime.tv_sec,
+			 ab->stamp.ctime.tv_nsec/1000000,
+			 ab->stamp.serial);
 
 	return ab;
 }
@@ -2178,31 +2213,128 @@ void audit_log_key(struct audit_buffer *ab, char *key)
 		audit_log_format(ab, "(null)");
 }
 
-int audit_log_task_context(struct audit_buffer *ab)
+/**
+ * audit_buffer_aux_new - Add an aux record buffer to the skb list
+ * @ab: audit_buffer
+ * @type: message type
+ *
+ * Aux records are allocated and added to the skb list of
+ * the "main" record. The ab->skb is reset to point to the
+ * aux record on its creation. When the aux record in complete
+ * ab->skb has to be reset to point to the "main" record.
+ * This allows the audit_log_ functions to be ignorant of
+ * which kind of record it is logging to. It also avoids adding
+ * special data for aux records.
+ *
+ * On success ab->skb will point to the new aux record.
+ * Returns 0 on success, -ENOMEM should allocation fail.
+ */
+static int audit_buffer_aux_new(struct audit_buffer *ab, int type)
+{
+	WARN_ON(ab->skb != skb_peek(&ab->skb_list));
+
+	ab->skb = nlmsg_new(AUDIT_BUFSIZ, ab->gfp_mask);
+	if (!ab->skb)
+		goto err;
+	if (!nlmsg_put(ab->skb, 0, 0, type, 0, 0))
+		goto err;
+	skb_queue_tail(&ab->skb_list, ab->skb);
+
+	audit_log_format(ab, "audit(%llu.%03lu:%u): ",
+			 (unsigned long long)ab->stamp.ctime.tv_sec,
+			 ab->stamp.ctime.tv_nsec/1000000,
+			 ab->stamp.serial);
+
+	return 0;
+
+err:
+	kfree_skb(ab->skb);
+	ab->skb = skb_peek(&ab->skb_list);
+	return -ENOMEM;
+}
+
+/**
+ * audit_buffer_aux_end - Switch back to the "main" record from an aux record
+ * @ab: audit_buffer
+ *
+ * Restores the "main" audit record to ab->skb.
+ */
+static void audit_buffer_aux_end(struct audit_buffer *ab)
+{
+	ab->skb = skb_peek(&ab->skb_list);
+}
+
+/**
+ * audit_log_subj_ctx - Add LSM subject information
+ * @ab: audit_buffer
+ * @prop: LSM subject properties.
+ *
+ * Add a subj= field and, if necessary, a AUDIT_MAC_TASK_CONTEXTS record.
+ */
+int audit_log_subj_ctx(struct audit_buffer *ab, struct lsm_prop *prop)
 {
-	struct lsm_prop prop;
 	struct lsm_context ctx;
+	char *space = "";
 	int error;
+	int i;
 
-	security_current_getlsmprop_subj(&prop);
-	if (!lsmprop_is_set(&prop))
+	security_current_getlsmprop_subj(prop);
+	if (!lsmprop_is_set(prop))
 		return 0;
 
-	error = security_lsmprop_to_secctx(&prop, &ctx, LSM_ID_UNDEF);
-	if (error < 0) {
-		if (error != -EINVAL)
-			goto error_path;
+	if (audit_subj_secctx_cnt < 2) {
+		error = security_lsmprop_to_secctx(prop, &ctx, LSM_ID_UNDEF);
+		if (error < 0) {
+			if (error != -EINVAL)
+				goto error_path;
+			return 0;
+		}
+		audit_log_format(ab, " subj=%s", ctx.context);
+		security_release_secctx(&ctx);
 		return 0;
 	}
-
-	audit_log_format(ab, " subj=%s", ctx.context);
-	security_release_secctx(&ctx);
+	/* Multiple LSMs provide contexts. Include an aux record. */
+	audit_log_format(ab, " subj=?");
+	error = audit_buffer_aux_new(ab, AUDIT_MAC_TASK_CONTEXTS);
+	if (error)
+		goto error_path;
+
+	for (i = 0; i < audit_subj_secctx_cnt; i++) {
+		error = security_lsmprop_to_secctx(prop, &ctx,
+						   audit_subj_lsms[i]->id);
+		if (error < 0) {
+			/*
+			 * Don't print anything. An LSM like BPF could
+			 * claim to support contexts, but only do so under
+			 * certain conditions.
+			 */
+			if (error == -EOPNOTSUPP)
+				continue;
+			if (error != -EINVAL)
+				audit_panic("error in audit_log_subj_ctx");
+		} else {
+			audit_log_format(ab, "%ssubj_%s=%s", space,
+					 audit_subj_lsms[i]->name, ctx.context);
+			space = " ";
+			security_release_secctx(&ctx);
+		}
+	}
+	audit_buffer_aux_end(ab);
 	return 0;
 
 error_path:
-	audit_panic("error in audit_log_task_context");
+	audit_panic("error in audit_log_subj_ctx");
 	return error;
 }
+EXPORT_SYMBOL(audit_log_subj_ctx);
+
+int audit_log_task_context(struct audit_buffer *ab)
+{
+	struct lsm_prop prop;
+
+	security_current_getlsmprop_subj(&prop);
+	return audit_log_subj_ctx(ab, &prop);
+}
 EXPORT_SYMBOL(audit_log_task_context);
 
 void audit_log_d_path_exe(struct audit_buffer *ab,
@@ -2411,6 +2543,26 @@ int audit_signal_info(int sig, struct task_struct *t)
 	return audit_signal_info_syscall(t);
 }
 
+/**
+ * __audit_log_end - enqueue one audit record
+ * @skb: the buffer to send
+ */
+static void __audit_log_end(struct sk_buff *skb)
+{
+	struct nlmsghdr *nlh;
+
+	if (audit_rate_check()) {
+		/* setup the netlink header, see the comments in
+		 * kauditd_send_multicast_skb() for length quirks */
+		nlh = nlmsg_hdr(skb);
+		nlh->nlmsg_len = skb->len - NLMSG_HDRLEN;
+
+		/* queue the netlink packet */
+		skb_queue_tail(&audit_queue, skb);
+	} else
+		audit_log_lost("rate limit exceeded");
+}
+
 /**
  * audit_log_end - end one audit record
  * @ab: the audit_buffer
@@ -2423,25 +2575,15 @@ int audit_signal_info(int sig, struct task_struct *t)
 void audit_log_end(struct audit_buffer *ab)
 {
 	struct sk_buff *skb;
-	struct nlmsghdr *nlh;
 
 	if (!ab)
 		return;
 
-	if (audit_rate_check()) {
-		skb = ab->skb;
-		ab->skb = NULL;
+	while ((skb = skb_dequeue(&ab->skb_list)))
+		__audit_log_end(skb);
 
-		/* setup the netlink header, see the comments in
-		 * kauditd_send_multicast_skb() for length quirks */
-		nlh = nlmsg_hdr(skb);
-		nlh->nlmsg_len = skb->len - NLMSG_HDRLEN;
-
-		/* queue the netlink packet and poke the kauditd thread */
-		skb_queue_tail(&audit_queue, skb);
-		wake_up_interruptible(&kauditd_wait);
-	} else
-		audit_log_lost("rate limit exceeded");
+	/* poke the kauditd thread */
+	wake_up_interruptible(&kauditd_wait);
 
 	audit_buffer_free(ab);
 }
diff --git a/net/netlabel/netlabel_user.c b/net/netlabel/netlabel_user.c
index 6d6545297ee3..0da652844dd6 100644
--- a/net/netlabel/netlabel_user.c
+++ b/net/netlabel/netlabel_user.c
@@ -84,7 +84,6 @@ struct audit_buffer *netlbl_audit_start_common(int type,
 					       struct netlbl_audit *audit_info)
 {
 	struct audit_buffer *audit_buf;
-	struct lsm_context ctx;
 
 	if (audit_enabled == AUDIT_OFF)
 		return NULL;
@@ -96,13 +95,7 @@ struct audit_buffer *netlbl_audit_start_common(int type,
 	audit_log_format(audit_buf, "netlabel: auid=%u ses=%u",
 			 from_kuid(&init_user_ns, audit_info->loginuid),
 			 audit_info->sessionid);
-
-	if (lsmprop_is_set(&audit_info->prop) &&
-	    security_lsmprop_to_secctx(&audit_info->prop, &ctx,
-				       LSM_ID_UNDEF) > 0) {
-		audit_log_format(audit_buf, " subj=%s", ctx.context);
-		security_release_secctx(&ctx);
-	}
+	audit_log_subj_ctx(audit_buf, &audit_info->prop);
 
 	return audit_buf;
 }
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 8e1cc229b41b..220d1684b8d4 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -2530,6 +2530,9 @@ static int __init apparmor_init(void)
 	security_add_hooks(apparmor_hooks, ARRAY_SIZE(apparmor_hooks),
 				&apparmor_lsmid);
 
+	/* Inform the audit system that secctx is used */
+	audit_cfg_lsm(&apparmor_lsmid, AUDIT_CFG_LSM_SECCTX_SUBJECT);
+
 	/* Report that AppArmor successfully initialized */
 	apparmor_initialized = 1;
 	if (aa_g_profile_mode == APPARMOR_COMPLAIN)
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index c95a5874bf7d..975b84b466b4 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7618,6 +7618,9 @@ static __init int selinux_init(void)
 	/* Set the security state for the initial task. */
 	cred_init_security();
 
+	/* Inform the audit system that secctx is used */
+	audit_cfg_lsm(&selinux_lsmid, AUDIT_CFG_LSM_SECCTX_SUBJECT);
+
 	default_noexec = !(VM_DATA_DEFAULT_FLAGS & VM_EXEC);
 	if (!default_noexec)
 		pr_notice("SELinux:  virtual memory is executable by default\n");
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index fc340a6f0dde..eaff9b8901a7 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -5267,6 +5267,9 @@ static __init int smack_init(void)
 	/* initialize the smack_known_list */
 	init_smack_known_list();
 
+	/* Inform the audit system that secctx is used */
+	audit_cfg_lsm(&smack_lsmid, AUDIT_CFG_LSM_SECCTX_SUBJECT);
+
 	return 0;
 }
 
-- 
2.50.1

