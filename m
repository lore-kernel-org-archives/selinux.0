Received: from sonic303-28.consmr.mail.ne1.yahoo.com (sonic303-28.consmr.mail.ne1.yahoo.com [66.163.188.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0421519AC
	for <selinux@vger.kernel.org>; Sat,  7 Jun 2025 01:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749258117; cv=none; b=GB/XQ0zOaOJDRifyRaYcCaLMGP9owWdIfAEv2PU5A9yer7vj0sFwTl527j656d1kAi34xw3jLomMjpJCpBw/bB7b6LfaYTSPBw9jADv2P8t+L2Aj0uf9fxWzROlpSie3ThIOb+J5+iv7BO7L8eFSZVTIdAjEhJFm9fWLZThjavc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749258117; c=relaxed/simple;
	bh=pahT5/AZtLJqmqnj4Fx2qzvSECN7TzTtZWNFYbrBfpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SYunXu3yr97fed1q1k+HZpGCDjzU0essDgN4ucxfHHuj2vjMjhATCBNA+olSH7CSGeC7cxqChlmSrtreznPCoGGB+LGrWRsrsd3HZQ1QPU/9X4rZVAdlpYNs6notWWmiMrBNSmBTozzdD9FChM3Wz/X1FjXhibiEiMbWDnSnIz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=shn/9fvB; arc=none smtp.client-ip=66.163.188.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="shn/9fvB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1749258114; bh=FANMOcSKaAjB90pMvB5JWdKco5eZLFlABgl6oxSFxyw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=shn/9fvBo6kugTNbuv7uiixIcbrMHbfQiI08c83tiMksFpxRqFjRVzdFYL+5fy78ZkXPipKkl6uBxO1cDTxKLa0giru4qb15teW4EYHGChfkUwVDFeuqftJIDpuKruuQp9TzohO0IuudUr2r7nk683VzSJ2PQMpnOCXmO3cSCIj7nysbGXNtRE7sKPPI7tWU6gRLHJb9I3Il3EpCxPDOCw+6YtokUtNMVSk14WKlWmL2Oq2TAx4m55XDYwVspq/PcHErGnGZBsMqFE2VZkYJvaoUHG6fMULUjHGAwdKFPizfD9AKOKv0L234M2F5w+QjvyWeRYkRp19+8YmUxLvi3w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1749258114; bh=h6uWHHtn1I3AH6PG0SU1Ol5E5q3yKolt1yDQiOhn+sR=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=PbCKDlpZm94q+tVNEo/rb7nDK3wizYFCpePETDL4tZcuCrho4aB55aeaYB1pdFblRdEUejUr4DNA8aDt+PSb8/RgLTFTE4VbK1v3uXdyOWQsea7QbnZ55UI1QzEGmWIE/uG3AvydUSPsEX2Lz2CtttaOGVgyihBD9QLZXvtaKoQ501JtwzjBV4Kq2gjFm3arco216oaI0lSw/zUR1yQ0D2lSsWk+z8zI1ilJFFw9xKdlWxvisB4Es7+xdon3c1LEXKm5Zecae62u3GJRP5WV9rawTzy2GqM73YhiBry/pQl/bcAIqtMkEsWxvd37wNKe/+I0FyeJwatba3oWq84aVQ==
X-YMail-OSG: 7LdvR3UVM1l6kDdtTP1svJLlpceCPCFSUdJGf2JFkiQmxJ28DyMc4JSKePZI.oE
 Dafa7iYpBU4LuvQSrSKBOP_E.XX5QOkhvlUTyPugIxjhe1HDpCgWx3eY2x66FicdJtxwBKZVaesH
 sJCSKNobzY.uZURGDO5Jwke_CNJyOHH0MMArlQfRPQeFf.Op8FBUo8Kbq.BPFUAHFIoPmgNqe7os
 cXQWVw8dw0vCWgRvcyRzeDoLYSkpPad7wxvnFKi_4_rmH4FwXFN0JSQ7UG1K3I4duQAPLeBZL.UO
 hoNoUo.Zi3tyfEEjiZRBJM7B2Fz6xdj2IevsBl6qIv4S8Y0NaK05U6zw25i1TyPWBrFMoO7K4eQ6
 JnDPcbxA_B_Y6RvLPQEogg4NEcaJgtVj9kgEfROxo0skyYN466QAPk_L2DMB.kJbOUiQf9oxp49n
 3zFEkxshiKRREaSnocUSZ_etBrnFhCV59dLN2VbGazQAAyp6TC5nfmp2BSCGsM_Tn2tiMSY.r1B2
 8Pr43OIJz8cOIN_3I5d2CvrAQVa4BusCXolDCHqjc43FRdYQknoL6C6OKp9BWf2pN_BGRzvcJkLa
 SRHlyDIRmQuaTNuQ3Mklxy_H9ln82ojC0KMDcZzrjlKANiFK4V898flzFmvPzUER6cIFQOiHVkkg
 etH8YTkyIDc6sShONkPpZNddZ3O5lSbmYMjH1Nj9jaG_JYhyyE7LgdqmaOaLRsKlJW7C498c._zl
 dC6uugS0lcJp.VcJ8aqj5BNaAJmqgOX3oMyIAtB6Z7810ez4zGjmufqBRtaLxwQPCDP3jM3MWQr4
 8k2.rbECbJD6gRqu9edw10Mwe4MvLKZMr9O0vxB_nhBWzl7teDiu6w_Mxsxmk4ZHdGzluQWRuwat
 pe3SCJYyV6uzBC8V2gn8Lre81ZwHqxKtEAewpOs6NhAQ06Isq4XqS_vYU_thwM28zaXbUFPDVU14
 puoVmnYP5jce.5rGLv892Pn6sMd_10qHn_zMTEBB8dgDZOFy8THqqn2rvjH04yBe6NnqpcGCo12C
 Xr1ddTPRxqof13eflxZhk58cJo.9CWNotaXpSQFxl8JiUo9HF4zC9Wsb1kx03BWFOUq1jBZsG4bu
 STZ_lFi5umYFpqZKlMA4C9d6BLqhIvCxEDV87147Oh0fx8Pjvi4d26fLId2xMbum2qHotmckFwks
 k_O13df45t3dUycWHRQlysxIOmnfCqWm7bxVWCm8AUIgmezIE9OvpWuSYciqDqpcbj_WXQBD3Ncf
 TGfiUWNF9QN5gX1FqQU5_BuCd_XLJrFrKcIVTNnEq8WNtHODpgciwQs.Y4gxgt8nLsJ6Oku.dBFE
 A7a6GrH1B8OkLT5yqVAoWxfttFdq9FLNJczqWyJN5I2hRZSludeq39BhTl7tIs7nof_UP.2FGCk1
 BuCO5_G1.9RqPos1EQaCIA2XszbTA60iq2KBEzNXyHXwWmC3r9VgI2vsyjqMGeP5J.oUwSlBkJmh
 OVxqQC4XxXeTI9EbQXBGVgNvnHFeJb5u4HNVdPhkzOceECZWIe..XoDLpa8kjmDAb8UXTUPwtyLy
 baeE6EfSZL7voShJ2hN21S2FJ45HXWEFmlfiLkLgigQTc_toeFltU.5MGpwnP5EMpNVQACKg4sQ2
 8tmwV.D3wAjaipGePUh6kvEiGbZK6ZYWg_i5rQ06BqtVwAX9zUUpI8_bTOWI8teU91c9RFwxbQJT
 FKfpSXoWN_BrF9dDFKZ7VOK4rrv3AKF1j96wsNxjE8m.LqOr8qiVii7Hyi1f4goDQaSHK1fzcB4Y
 7jQrMMRhfWzM.DebNhLUzyYG7PUz8u.aRw8V0V1ceeDL7.HFfz371TGq4.Ydl5yE7swNsGvQgiSI
 HgkIgWm2SXCoIrZRRVfU_A9gMYWXBZfqxdUT_jqovpe1Jmmpow9_IK_tgZbmjJIyHxCDcvcehvR3
 _.NG3NaU6r_1Pf4Zp24hnIGWiSg6iRS_w5mvxjuEv1g_2B3Cnm3UIeBPL59MZnEikKyngJ8.fVQy
 .ZaS0DVgBSK0_KMvhG0ITQw5e71e9KkkkB1ocdteEsqLWb486_3g8zyrpApaz9HY3Dv70BTV7nsC
 _YXmD2GzjDa.znaio_SkA8.S13LuqdatBnzydrnDMpfu_PathhMql2601VExkbbSFiOvY.TG5v6d
 PZ4WjsXABLjm1D.DLifNXSeBdyXMHB8xbp5491MaKxfxVx6oE9p3JuM4r502nYZqZfA38aW1vOBg
 .r3P03G9Mqr7Pxxx.zX0Zv7lyrHuBMgT.ttvbw9O0D4qgkTab1yhSiKVIETzD5ihnn6OEtklXXgx
 5L3EwL19B6Ut.UQFH5F62ULuvRXGS
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 60c8aa22-0e0f-4724-9cbf-096cb7921969
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Sat, 7 Jun 2025 01:01:54 +0000
Received: by hermes--production-gq1-74d64bb7d7-5qmwx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 7461f2feac0d1a8decd03521522bae75;
          Sat, 07 Jun 2025 00:51:42 +0000 (UTC)
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
Subject: [PATCH v4 3/4] Audit: Add record for multiple task security contexts
Date: Fri,  6 Jun 2025 17:51:33 -0700
Message-ID: <20250607005134.10488-4-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250607005134.10488-1-casey@schaufler-ca.com>
References: <20250607005134.10488-1-casey@schaufler-ca.com>
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
index 0050ef288ab3..5020939fb8bc 100644
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
 
+/* bit values for audit_lsm_secctx */
+#define AUDIT_SECCTX_SUBJECT	BIT(0)
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
 
+extern void audit_lsm_secctx(const struct lsm_id *lsmid, int flags);
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
 
+static inline void audit_lsm_secctx(const struct lsm_id *lsmid, int flags)
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
index 6bbadb605ca3..0987b2f391cc 100644
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
+ * audit_lsm_secctx - Identify a security module as providing a secctx.
+ * @lsmid: LSM identity
+ * @flags: which contexts are provided
+ *
+ * Description:
+ * Increments the count of the security modules providing a secctx.
+ * If the LSM id is already in the list leave it alone.
+ */
+void audit_lsm_secctx(const struct lsm_id *lsmid, int flags)
+{
+	int i;
+
+	if (flags & AUDIT_SECCTX_SUBJECT) {
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
index db8592bed189..4ba6db93e5b0 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -2251,6 +2251,9 @@ static int __init apparmor_init(void)
 	security_add_hooks(apparmor_hooks, ARRAY_SIZE(apparmor_hooks),
 				&apparmor_lsmid);
 
+	/* Inform the audit system that secctx is used */
+	audit_lsm_secctx(&apparmor_lsmid, AUDIT_SECCTX_SUBJECT);
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
index 306860434200..0bb7e0d6ec8b 100644
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
index 1dc4b3987af4..a89561c1fdea 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7516,6 +7516,9 @@ static __init int selinux_init(void)
 	/* Set the security state for the initial task. */
 	cred_init_security();
 
+	/* Inform the audit system that secctx is used */
+	audit_lsm_secctx(&selinux_lsmid, AUDIT_SECCTX_SUBJECT);
+
 	default_noexec = !(VM_DATA_DEFAULT_FLAGS & VM_EXEC);
 	if (!default_noexec)
 		pr_notice("SELinux:  virtual memory is executable by default\n");
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 47a036e8e452..06603c328079 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -5275,6 +5275,9 @@ static __init int smack_init(void)
 	/* initialize the smack_known_list */
 	init_smack_known_list();
 
+	/* Inform the audit system that secctx is used */
+	audit_lsm_secctx(&smack_lsmid, AUDIT_SECCTX_SUBJECT);
+
 	return 0;
 }
 
-- 
2.47.0

