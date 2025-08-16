Received: from sonic315-26.consmr.mail.ne1.yahoo.com (sonic315-26.consmr.mail.ne1.yahoo.com [66.163.190.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4B67261C
	for <selinux@vger.kernel.org>; Sat, 16 Aug 2025 16:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755362523; cv=none; b=TU4Ygulbtg7Ns8BWV9Ox76+0y0qX0lc1C+KU4UhltPHm58HWMbX5jm8SKq9lVjhivRl4OxC0HV0CEp2dKIy9XDn+TVLhrfgjZyL/cGcbGNUkpO9hL9LaeQzWxS/Rgh7jPibhHBz+4VhM76h8Rpe1ow5JdLJNytlpdMc9SwQe2Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755362523; c=relaxed/simple;
	bh=RZsczI2qKPb6wpwHpGXqFXe64UEJThjrE35pdwN6uMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nPuZu7ZbXbS5Y/lO6q2t8X+Pg7K0tIJxz5gnBCdo9q1NkT+c3R2qNflXYi4hnuOthkhxKeD8YRVOWYU3TmQr6RBFOXusOGXFYqcpElE1WTRQlLnM9aWRPZXDe7yaBrb2VBBggy7D8tirmmWUKTXb0nsfI26zWR492LrD4e5t+mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=re0fXTH4; arc=none smtp.client-ip=66.163.190.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="re0fXTH4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1755362518; bh=NmjJjDbE529xR/k66oAME0ljhZKXuXg4AmefI3c/uRQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=re0fXTH4kSYu/JM1fGphiwF4bV52KMjDepQNFsy8wFLnQvAxNX1/ur90ErBM7nbp2b4a+lqykn+z8IDlYGj8USMtGFLN1fGkDbA2lkATxIPvos4LXumCscGkVov7qnapylMxLb8ouk/9z5OhZMnXuJqk59j7a7LNiqL690HSUyFFjorH6gJNk59z2ElkDXhNMfvm9pRBDo3fo1a652n0rvqrs//BqhODPwjYxdff6p3t9g+w3vDVG2pAzfORdp/3VGn07NG3O6VjEnAdqHe1AGd7KtrR9P5yNSo8IABEvfxnHBjHClVuLKiPvxyhbrxntlw9Il3Pgx3YT1uRjiot7g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1755362518; bh=qAaTLdTCQS2iAeMJSuFXi36jMuNK7Bk80/D13ofdbXg=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=je0Xn2sHgiOTqeYsQimXoRGjYQEH1oM6iAZI1mNLetsKVniqi9LHVrVCsGfLg0MqhkVLGmxODCJoG1xMZO8l68oMbJ7s/lcWiIzIpY0xXSK/c15BXyyb3k3YTJewBsRMDj2QdYN43h8sS0eBtvC3uM1RqjQfNZOgX14oa3zqMX0Gf7gFV63OfnDPq7Qm+Hd5z2HavDMZrFwFikODNlwJdJx97NzvQnYW3Y8RVpQIOKvKxN2HLVV0fgY1gTsex5NeKquBQmXogC23UVg+pDckIaHNEUQBa20r/ec/HFZZxEgIy/j1CpLN389+VNWS1EcVlDd1fDtw8YQ/Nm1a1nh18A==
X-YMail-OSG: 2OeQPGkVM1n9j7.a2ZnWVyhRc8fSQlbK4EfLvyL5MF7ePVeUad3JE9D6rqOsxxU
 XEqNVNBBxbOfTLdWAcU1h7gh.fj9e7O4SVdZw5MJIae0_gN0fR0Eep0DdlEzl5PYrg7DfH_QPSYn
 24buimFANtXhnF5ARxI7peN2AbbyhEXLVCo0WmiFsqWZx.nL7yesbfk6SKB9hyHwcjuLDsNhfz6P
 I7fa2deEx60jhKXaggRpBHkJghCN3D9hDAOO6u0UyKSW.DJb_6At.VxO06JCllKVYRZJGv2JC6Ln
 lkDYUximOI0Py9BSOZFn.L4IWGWHf1mKTcCOYieEd.NgpwRYMyihMJwh_7kHXQb5J3kswtLqJZig
 .oJW80yVa7Qzrhw975wy7fUNcnQuDjbC8i5igqnZKN6h8roXNcvsfNZgCUQISzDE7s4plx5JPKye
 Od8hIGOiykZLObShe7eJH_N3HIJ29VgHJcqRGz3_Ftw1pUZ9U5INQ04atVr4.9nTDIVNHNf8u.xH
 GWhWW0wqEKzWY7bWDk51rhM7whoJ004FMuPgMf0s8eLDwMuN267vLhkRIH42hQE6DiXnmoazTkE.
 rQX7u0oPpPjX512AfS57KkJdIyUNEt5U.aF5UmYX6yoavoDHkGxoEwR4r9ceZgwwnajbl3ZL40NQ
 JsytZYWRHcMN9nDXrzbFLFC8i3nDPm2.7Y_ea4e6rPTQHeBr2.Rdp3OYQESwR1.3m25RRjEOlRcq
 caaU9ajKCMK0zZHdLp_HnR8UOAnRMNrrHB2i2NxEAQq3LKt9dToFfYTJH.IJX0iCKKaf.oZOWwqa
 ISdfG8rYryYGjdt7Wm3B_g8l7TbPFULaTgT5_CXSxOOGF.GMs6SqPXneEJ0Rd1XoVh0SqBl1Zm3o
 KiVPakHptD83yPNDGN7LixCpKf7m25NX8IbNmNxyy3qPog_A1rIlFXjri6UmmEgbkuxX_k2bcH82
 yQjbxVdeyV4CLhIGX8ZrBJtEtDM8nnGBTxQKyFj5Q5KVnzzB.zJPGTYTeG2FcrWtMySUhQvAEwyK
 piTAVIGMWO3nyH6JxL3L4I5l6bbuPfhgxqYNmlSi3gPavbms01p6aD.gNyDx8Ox7cA9Nu4UXhhsE
 aC5dJH8QO7EYeqpXo1tRMFn9aedWzsOxtDDXLc9V0HJhGC9hyQESjR0jqCBFPRPYw7X0UUu8X5u8
 IYKdYO_GamdYtXqXgjK7iHuxQ9ACkE_E9dvLsyy5LOvsWuigXkOOVSdxoc5eKwFK.dm0ZtMZ8q5P
 gUtOpfuxUHzkB0vRveg13IqFljVZ3EZaBNCNw_yXmc93hgS4fbplfnn6MtsLq7gd_qnNN6gDHeJL
 LiRDOT36WOJYZqLHqettFW3PDQs.iYSy.4pTh1DrvIiJm4fPD8N9zKlM_.F_ddFme01i8FzZKX7x
 gsevifcSIp1SrLlAwWP1icVc4vVTL.ZccJR5XPe09VgSJkVGvU18MgBNxAm39kSL0jqLeu6bZnCh
 jbTTaWqzTASjiKKcUXbPV2avtpc1kbqmPdp0MJcX_9k5jj_xvPB_KGv.Rk349Szs4ZNfKJGwyseJ
 _iu1GoGqLAzuN7QLLm1NB44XoMO5R52SBbBB.kgwnIztBeORw7stIJHa_oOmxAKrdObToSdTKpzM
 Kii6tyNhpZgEWsycUMEWot9_VrxbKDtZOpMgTx1n.ALzhuGW4WUgPk50yLaCvGXeHhxxjmMMOQjN
 IMmW8qQrLFJ3JQ897WHmgWfO5nZzd_ug72NNDEEsvA1BFA3n0sb9Q5FhgCL.k2b2vXXZ_0ldVeWp
 aSdUkHUQdwBnCjic3qm_mYcuf6VSuzSvFvGRjGpm244i_jyjLrXXjEd7pQeOEuZOK5jdMECsRcTm
 pN.Jl8O3f0C0Avkd3H2ztFmoj6Iu0raf_zOThg9y_lY7uL1TLieJ92OU8kNGXN5ARQ2oTJFGGs2i
 6s63NPyKQTzanIo_0EvBV0rTIBCyV7_hOzQ8p.N8lRnFycw7EXR4pseuBHVZ6x3ADGkZ1fVP_17J
 dZRVqzbTI5cN8Q7k9g.68nw9kv8o0ayj6oiTi0ulk7dkNTDuIJVsdrW8paDTzLSv2KciM3XLg8EW
 n8RQ.SPdlxN.Bp_8mLefTg4Otm2LtRlzjkRrwrCkJa1Wp1J8MiE9V9I8HaCUw5kPf8_eoMoS_Wip
 wNkaekkBNnh8mwd5LTNdX4om_KokXnNrXBaR6Ml4HN9Ix1yBiDIwUkmI3gtvwG0mQn_Y8JdxRx1m
 liBTDpsHV9RPTFVv5nzcXs_UqKFSY8r8uIXRp1dHPlfq0_tVs.ELvVPBmFr_U6lHmgW8GGoZ5CzJ
 tRKx4Uy0vyO0CoZa8YDNrZzbusg5.
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 1e946f18-5119-436b-875c-4cf553b1f614
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Sat, 16 Aug 2025 16:41:58 +0000
Received: by hermes--production-gq1-74d64bb7d7-5qmwx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 12cf07a2fbb9800c7a9ea9632f3a0835;
          Sat, 16 Aug 2025 16:41:57 +0000 (UTC)
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
Subject: [PATCH v5 3/5] Audit: Add record for multiple task security contexts
Date: Sat, 16 Aug 2025 09:41:38 -0700
Message-ID: <20250816164140.6045-4-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250816164140.6045-1-casey@schaufler-ca.com>
References: <20250816164140.6045-1-casey@schaufler-ca.com>
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
 kernel/audit.c               | 207 +++++++++++++++++++++++++++++------
 net/netlabel/netlabel_user.c |   9 +-
 security/apparmor/lsm.c      |   3 +
 security/lsm.h               |   4 -
 security/lsm_init.c          |   5 -
 security/security.c          |   3 -
 security/selinux/hooks.c     |   3 +
 security/smack/smack_lsm.c   |   3 +
 10 files changed, 202 insertions(+), 52 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 0050ef288ab3..fb54c1119947 100644
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
index 226c8ae00d04..c7dea6bfacdd 100644
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
+				audit_panic("error in audit_log_task_context");
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
@@ -2423,25 +2575,16 @@ int audit_signal_info(int sig, struct task_struct *t)
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
+	/* poke the kauditd thread */
+	if (audit_rate_check())
 		wake_up_interruptible(&kauditd_wait);
-	} else
-		audit_log_lost("rate limit exceeded");
 
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
index db8592bed189..a74825eebba0 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -2251,6 +2251,9 @@ static int __init apparmor_init(void)
 	security_add_hooks(apparmor_hooks, ARRAY_SIZE(apparmor_hooks),
 				&apparmor_lsmid);
 
+	/* Inform the audit system that secctx is used */
+	audit_cfg_lsm(&apparmor_lsmid, AUDIT_CFG_LSM_SECCTX_SUBJECT);
+
 	/* Report that AppArmor successfully initialized */
 	apparmor_initialized = 1;
 	if (aa_g_profile_mode == APPARMOR_COMPLAIN)
diff --git a/security/lsm.h b/security/lsm.h
index d1d54540da98..c432dc0c5e30 100644
--- a/security/lsm.h
+++ b/security/lsm.h
@@ -24,10 +24,6 @@ extern bool lsm_debug;
 extern unsigned int lsm_count;
 extern const struct lsm_id *lsm_idlist[];
 
-/* LSM property configuration */
-extern unsigned int lsm_count_prop_subj;
-extern unsigned int lsm_count_prop_obj;
-
 /* LSM blob configuration */
 extern struct lsm_blob_sizes blob_sizes;
 
diff --git a/security/lsm_init.c b/security/lsm_init.c
index c2ef4db055db..54166688efff 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -190,11 +190,6 @@ static void __init lsm_order_append(struct lsm_info *lsm, const char *src)
 	lsm_order[lsm_count] = lsm;
 	lsm_idlist[lsm_count++] = lsm->id;
 
-	if (lsm->id->flags & LSM_ID_FLG_PROP_SUBJ)
-		lsm_count_prop_subj++;
-	if (lsm->id->flags & LSM_ID_FLG_PROP_OBJ)
-		lsm_count_prop_obj++;
-
 	lsm_pr_dbg("enabling LSM %s:%s\n", src, lsm->id->name);
 }
 
diff --git a/security/security.c b/security/security.c
index 2cc832dc8a45..678b261e91de 100644
--- a/security/security.c
+++ b/security/security.c
@@ -78,9 +78,6 @@ bool lsm_debug __ro_after_init;
 unsigned int lsm_count __ro_after_init;
 const struct lsm_id *lsm_idlist[MAX_LSM_COUNT];
 
-unsigned int lsm_count_prop_subj __ro_after_init;
-unsigned int lsm_count_prop_obj __ro_after_init;
-
 struct lsm_blob_sizes blob_sizes;
 
 struct kmem_cache *lsm_file_cache;
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index b00c2627286a..81b66b4d9695 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7594,6 +7594,9 @@ static __init int selinux_init(void)
 	/* Set the security state for the initial task. */
 	cred_init_security();
 
+	/* Inform the audit system that secctx is used */
+	audit_cfg_lsm(&selinux_lsmid, AUDIT_CFG_LSM_SECCTX_SUBJECT);
+
 	default_noexec = !(VM_DATA_DEFAULT_FLAGS & VM_EXEC);
 	if (!default_noexec)
 		pr_notice("SELinux:  virtual memory is executable by default\n");
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 46ef5ece991c..9a76821b7191 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -5268,6 +5268,9 @@ static __init int smack_init(void)
 	/* initialize the smack_known_list */
 	init_smack_known_list();
 
+	/* Inform the audit system that secctx is used */
+	audit_cfg_lsm(&smack_lsmid, AUDIT_CFG_LSM_SECCTX_SUBJECT);
+
 	return 0;
 }
 
-- 
2.50.1

