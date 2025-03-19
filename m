Received: from sonic307-16.consmr.mail.ne1.yahoo.com (sonic307-16.consmr.mail.ne1.yahoo.com [66.163.190.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9660F21CFF4
	for <selinux@vger.kernel.org>; Wed, 19 Mar 2025 22:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742423287; cv=none; b=ZHhCPyUSEpxCz48ktq22CVvc5XnjIpnvZofz02Euh2bBHcY8vmz4XtA0F87n3ecFrdcTVbXtApUBrY38xpV+It3Kv/W6By/Xu5J+5v6RrCKttxUb/s1LDHzgFG38hrjRk9xfqBAFlfK0dunLiRPGeVrBLdf0XBOdxpTjWhvWK1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742423287; c=relaxed/simple;
	bh=QYm7mXZ/JhLkdMLR0Zx3COpzmegytyB4GsVm6ToHNeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fgJ4JZ9dVq8VUuPnvfUJUY25f2iRUxxmc8UaFtg9VD8IqNANasMfCdr4uryGC18dwES/u89pKqsX/c57t9F5WyfmU78Oicw1L3yex576VIIvUBfL1zlwT3DZq4tRtXSPwk7NTLzqzkU02lXLL57CRUGzTJr2yXbsE+1PozgeO04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=HSOGg3EV; arc=none smtp.client-ip=66.163.190.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="HSOGg3EV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1742423278; bh=1HLSJ6PQBJVM8UKP/Mn1Kyw9A4uIXcyC98bjgzIu7GU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=HSOGg3EVexYbv13DlM3gC7IQlZmyTbQh/YhCkY4biU4bHJDvUCV9sAOhbpNVQK4NUQDIaQJscGsCbfyroaGUyaAKhacLFfNSescDY8cRtpIh3W36wGAEzoD/MiVIt3UqbG2r420uEtNZOvtHYwVCPQowAxtaBo8uZQfEnIh9uDWy3+qGVGyGkRdlGV298jyXjZZ26Brj1ohkNdyBpkuiN0YxAy1r3fLEvVkKOFxg/WGZnlLdBecoWvbwZ2y5+NRQpJ3y2ZYeA8nq2BJWLUSJEhKhSoLfd3RwCuywDSzb2WB4OBeE543DmcJZVRJQu+0ymeZZMwCvy1amSpy99cy4Nw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1742423278; bh=LQro4866b1MJOIfG51sL32VeYtbqRgFUxD2Yv5yKwgp=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=em7imcSrDC5L6QWEFtJfH88naAqdj9WRXoLM6LfZfkJsDoB3quCCd5al30BEWde631h4oVlLgfy67NZm8+kFGO3tWL9hmS0XB1qbyuvL2SIP3koEUdAB20FJ8Gqlus9GqQF2ZHuocLMY9Jud8p4o8n9RDdae5e/M0kiolFcPBeq44X/T4O/ove+/2QW5EmK014Z8RywsdUpB+XFmfAFI2DNAoqkoyoI4zitDYCRlpJcdGi3a3qInhrbaVhmmg+sZWe4byNnznKUCl+LI+zrhOnt/FkvDTu5neE/I6IG/xhoMaxdI7aDIdSKZN7u12Jf3YPgrqL42mWe+4qpAaeWlwA==
X-YMail-OSG: NZwbdAMVM1muHfnogJMvhIOBqmXU6hd2NczuQiP48OwoB2ZfglBRPXq2ylBYX.G
 L9qXMR9_coQ9TvqcR.TzZtVnoNzRydFGYpy1PAJPfsozfnv6zCWHPEPXewS0Bmna0SepJ2EKLL0l
 A8y_1UlSlCmvEwMadsnqPsyqwuesit9jJnH5BWWcgYEcMX1TLn3ue4ZVoDHJVftfKXrD5LpU2r2n
 7R_c.enZEf0pbQ2d6raReE8wT3EcWYUxuj58_xd6ElybEV3u2wkA7hr6rwTF5b.4gXmAvy2Jquas
 bGVbUa3ySX8n0B8G6SN.jUNeD5kegbdIwMXbKI4b9aiRzhaE2_YneDi8WWvzOVNqrdqk26JBNhLt
 Ps4dP.agiVqS_f6Q0kZGMocwdVEhM9JVOk4mPXDQkMamroTabTzmbMTD7HkIZx5WltTpq3fZqlHK
 Y68dDfHwXGLZvNrbHRJhrzDrptTHqYa6twsaZrxbErNNNqt.YyVk.6JReSAfJHWTBLM0hgwDmpC0
 dbD610bKyBf6bmAN_.Rl7i4r6Cfq_XLIX19nTMUrRYlyHYfQix2w.N_Wydj3Pa1QSGBIUeRk1e6p
 epBb6jei4D_Nn1fANUKpfsUZvwgynyRRsbr.ZkiyVwE4Gnfn04MjsPfpV1SBYx0eBbC0MhKURT07
 uBJ4I78gKI7.ImYMIlU2PQjzDSJqSxzEXNEvfmwH6CLjbPLJZ2sduVez9T218u7FLTFEdkW3NiEC
 3x.z5hU6rfJKYra4kqnEC5J6EvVATkGxSnWEjzIsMxIM2lw.Gedo8IIlkSWe2ztl7QHfRoqLEnuo
 gIL346hs9gQgwKxNc5utnmeP6euFW5MGoR9_q.NAyHcyWu577TTyXNqQPHD.rCQOk7PhQ5OhQ5Eg
 qze8_ZAgySkxcD8bOZciX45YUzh8_jJBvii8dluHia6Aygem1IqowY4D3oehkv.pLAP3i_uKsY_j
 IMp_QAAy_h3JoZe2Ql5mcHcS7wgOw79Dq1nHMGoGrrM3bjHQN9eAfjzJBkSGJM2jxBrlmlBBEAM2
 k2OPkk8GJ1AwESxvQx9OimlAcB5iHyao1wCdIn9Q9Cp1RUpNi_rzAbM2U8SSFGQ.fJZAJThTKXB6
 hYL6jOxLnYaC5.3FizXf30V4AESI4sapBftuce8nONGcqyiRbODFaZaK5iPwW4pcCD8lgxS1p6VL
 M_h1apFuBV89_K3C5ODLCJMjstV0PPLX4aZ14DF5Q4dsdzSCiWdCuQy20RDOFeJ73De_2tC1Goak
 7GaSlC945vxrL1_9fPJEhgey.fvI3xtJYT862i_RLTOtBxyE3DamPG30lvXsFxftnNP5vcEaGxh5
 9guNMuX5WBBK.NaUdanb_F_nLbOmke1uU4gbOEflGd_rBBKUd1mQNOoX.vyx6D4EUlRW8Jh1sH8x
 JV.5hg5tJm_brdhIQk4_vqbtGegT7FJRDrgJAP4L3eTWbfXrYb8heuxzyZFrycwcWxhqqlDsnpGF
 YHaqjpyVKVZi7Rer_lwiltikOy6jpXZGsP.cBoSC5QVU85pIvDtCrvMkTXiBaYc3vPg1hRSBhUXj
 GMvCt.SwkQKtiQswNsKHeZTnHoTFbUInSwsC7EyiBFw1XyxnHzyd2ZRpjWvdfDyf2o1AAqjPJ0W3
 Gvp57b3HG50FaJBSbgjXhSOskmaQpqAoidu_pRtDocH4j8Zj_jPv6z2I0MTGZJSPWXVbOodlkW2u
 uDlLB0dCOQvYb8O0Ae0sieRhj_N9K3emAJU4gIBCzy1kiegST6yTtvyxTYvdKJKUBJwQtYC1Qbto
 61zgcCRw3gEuiaVe_l5nbjLBbmULIOL6oK.TcFqHU1pDfxGt09c_iVaE0asHRWUJ7IxpOmlc7Zx6
 AKXBhxcZo2GLyOBboOzkG9Vn7ln2TaoNsF9dDt2s66thr02aKvC5MK20yyGwLo8dkTrbv09f7Z0i
 1Z6rlYbUXlITMgWWN6WlF0tuOlRgbAmdMBgIgwKWpi7PWMjz9KjJAP9FxNBAYaP6SzNd5h1XupBy
 inILxPENmLaAIFtRisfs0f4AwqhccSdQ7HS4H_CR1kD15e86q0Lw5gTch9DODTPSD7JxCMxGwYZR
 8iOVOzbk7YWgghWCblUUxp4JuOlQjd6R.MDQMzeOrpLZWoeGElCjeeDOBZXdrq5a7L525.Op9NTW
 5UkCrXTHxKKOTG9NtdPDGncdIUzQC2MBjxeCx2l5XZ0ih4aBtlJJ_CLkCvFrw8DEqgCn3._U9Byl
 9Pi36gTtbk5LRPd0EIgpt5iEeKVZh0hxIpfDBWUTAHpn3Xoa44Q8_kUuBFIGXc5EqScc85pQddNm
 hW2BCgRhEmtOZg7gE2F8OGFcs_9qX
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: bdf52ab6-1241-4a1b-a6b4-49ed67e951c4
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Wed, 19 Mar 2025 22:27:58 +0000
Received: by hermes--production-gq1-7d5f4447dd-jcqz7 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1e9bd32085bcf3fce38fe3767fad9b05;
          Wed, 19 Mar 2025 22:27:52 +0000 (UTC)
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
Subject: [PATCH v3 3/5] Audit: Add record for multiple task security contexts
Date: Wed, 19 Mar 2025 15:27:42 -0700
Message-ID: <20250319222744.17576-4-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250319222744.17576-1-casey@schaufler-ca.com>
References: <20250319222744.17576-1-casey@schaufler-ca.com>
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
auxiliary records (none are currently defined) as have been added to the
list. Functions are created to manage the skb list in the audit_buffer.

Create a new audit record AUDIT_MAC_TASK_CONTEXTS.
An example of the MAC_TASK_CONTEXTS (1423) record is:

    type=MAC_TASK_CONTEXTS[1423]
    msg=audit(1600880931.832:113)
    subj_apparmor=unconfined
    subj_smack=_

When an audit event includes a AUDIT_MAC_TASK_CONTEXTS record the
"subj=" field in other records in the event will be "subj=?".
An AUDIT_MAC_TASK_CONTEXTS record is supplied when the system has
multiple security modules that may make access decisions based on a
subject security context.

Suggested-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/audit.h      |   6 ++
 include/uapi/linux/audit.h |   1 +
 kernel/audit.c             | 171 ++++++++++++++++++++++++++++++-------
 security/apparmor/lsm.c    |   3 +
 security/selinux/hooks.c   |   3 +
 security/smack/smack_lsm.c |   3 +
 6 files changed, 158 insertions(+), 29 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 0050ef288ab3..b493ca5976cf 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -37,6 +37,7 @@ struct audit_watch;
 struct audit_tree;
 struct sk_buff;
 struct kern_ipc_perm;
+struct lsm_id;
 
 struct audit_krule {
 	u32			pflags;
@@ -210,6 +211,8 @@ extern u32 audit_enabled;
 
 extern int audit_signal_info(int sig, struct task_struct *t);
 
+extern void audit_lsm_secctx(const struct lsm_id *lsmid);
+
 #else /* CONFIG_AUDIT */
 static inline __printf(4, 5)
 void audit_log(struct audit_context *ctx, gfp_t gfp_mask, int type,
@@ -269,6 +272,9 @@ static inline int audit_signal_info(int sig, struct task_struct *t)
 	return 0;
 }
 
+static inline void audit_lsm_secctx(const struct lsm_id *lsmid)
+{ }
+
 #endif /* CONFIG_AUDIT */
 
 #ifdef CONFIG_AUDIT_COMPAT_GENERIC
diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index d9a069b4a775..5ebb5d80363d 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -146,6 +146,7 @@
 #define AUDIT_IPE_ACCESS	1420	/* IPE denial or grant */
 #define AUDIT_IPE_CONFIG_CHANGE	1421	/* IPE config change */
 #define AUDIT_IPE_POLICY_LOAD	1422	/* IPE policy load */
+#define AUDIT_MAC_TASK_CONTEXTS	1423	/* Multiple LSM task contexts */
 
 #define AUDIT_FIRST_KERN_ANOM_MSG   1700
 #define AUDIT_LAST_KERN_ANOM_MSG    1799
diff --git a/kernel/audit.c b/kernel/audit.c
index 6bbadb605ca3..7ec3919ae925 100644
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
+static u32 audit_secctx_cnt = 0;
+static const struct lsm_id *audit_lsms[MAX_LSM_COUNT];
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
 
@@ -278,6 +286,18 @@ static pid_t auditd_pid_vnr(void)
 	return pid;
 }
 
+/**
+ * audit_lsm_secctx - Identify a security module as providing a secctx.
+ * @lsmid - LSM identity
+ *
+ * Description:
+ * Increments the count of the security modules providing a secctx.
+ */
+void audit_lsm_secctx(const struct lsm_id *lsmid)
+{
+	audit_lsms[audit_secctx_cnt++] = lsmid;
+}
+
 /**
  * audit_get_sk - Return the audit socket for the given network namespace
  * @net: the destination network namespace
@@ -1776,10 +1796,13 @@ __setup("audit_backlog_limit=", audit_backlog_limit_set);
 
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
 
@@ -1795,6 +1818,10 @@ static struct audit_buffer *audit_buffer_alloc(struct audit_context *ctx,
 	ab->skb = nlmsg_new(AUDIT_BUFSIZ, gfp_mask);
 	if (!ab->skb)
 		goto err;
+
+	skb_queue_head_init(&ab->skb_list);
+	skb_queue_tail(&ab->skb_list, ab->skb);
+
 	if (!nlmsg_put(ab->skb, 0, 0, type, 0, 0))
 		goto err;
 
@@ -1860,7 +1887,6 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
 				     int type)
 {
 	struct audit_buffer *ab;
-	struct audit_stamp stamp;
 
 	if (audit_initialized != AUDIT_INITIALIZED)
 		return NULL;
@@ -1915,14 +1941,14 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
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
@@ -2178,25 +2204,104 @@ void audit_log_key(struct audit_buffer *ab, char *key)
 		audit_log_format(ab, "(null)");
 }
 
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
 int audit_log_task_context(struct audit_buffer *ab)
 {
 	struct lsm_prop prop;
 	struct lsm_context ctx;
+	bool space = false;
 	int error;
+	int i;
 
 	security_current_getlsmprop_subj(&prop);
 	if (!lsmprop_is_set(&prop))
 		return 0;
 
-	error = security_lsmprop_to_secctx(&prop, &ctx, LSM_ID_UNDEF);
-	if (error < 0) {
-		if (error != -EINVAL)
-			goto error_path;
+	if (audit_secctx_cnt < 2) {
+		error = security_lsmprop_to_secctx(&prop, &ctx, LSM_ID_UNDEF);
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
+	for (i = 0; i < audit_secctx_cnt; i++) {
+		error = security_lsmprop_to_secctx(&prop, &ctx,
+						   audit_lsms[i]->id);
+		if (error < 0) {
+			if (error == -EOPNOTSUPP)
+				continue;
+			audit_log_format(ab, "%ssubj_%s=?", space ? " " : "",
+					 audit_lsms[i]->name);
+			if (error != -EINVAL)
+				audit_panic("error in audit_log_task_context");
+		} else {
+			audit_log_format(ab, "%ssubj_%s=%s", space ? " " : "",
+					 audit_lsms[i]->name, ctx.context);
+			security_release_secctx(&ctx);
+		}
+		space = true;
+	}
+	audit_buffer_aux_end(ab);
 	return 0;
 
 error_path:
@@ -2412,26 +2517,14 @@ int audit_signal_info(int sig, struct task_struct *t)
 }
 
 /**
- * audit_log_end - end one audit record
- * @ab: the audit_buffer
- *
- * We can not do a netlink send inside an irq context because it blocks (last
- * arg, flags, is not set to MSG_DONTWAIT), so the audit buffer is placed on a
- * queue and a kthread is scheduled to remove them from the queue outside the
- * irq context.  May be called in any context.
+ * __audit_log_end - enqueue one audit record
+ * @skb: the buffer to send
  */
-void audit_log_end(struct audit_buffer *ab)
+static void __audit_log_end(struct sk_buff *skb)
 {
-	struct sk_buff *skb;
 	struct nlmsghdr *nlh;
 
-	if (!ab)
-		return;
-
 	if (audit_rate_check()) {
-		skb = ab->skb;
-		ab->skb = NULL;
-
 		/* setup the netlink header, see the comments in
 		 * kauditd_send_multicast_skb() for length quirks */
 		nlh = nlmsg_hdr(skb);
@@ -2442,6 +2535,26 @@ void audit_log_end(struct audit_buffer *ab)
 		wake_up_interruptible(&kauditd_wait);
 	} else
 		audit_log_lost("rate limit exceeded");
+}
+
+/**
+ * audit_log_end - end one audit record
+ * @ab: the audit_buffer
+ *
+ * We can not do a netlink send inside an irq context because it blocks (last
+ * arg, flags, is not set to MSG_DONTWAIT), so the audit buffer is placed on a
+ * queue and a kthread is scheduled to remove them from the queue outside the
+ * irq context.  May be called in any context.
+ */
+void audit_log_end(struct audit_buffer *ab)
+{
+	struct sk_buff *skb;
+
+	if (!ab)
+		return;
+
+	while ((skb = skb_dequeue(&ab->skb_list)))
+		__audit_log_end(skb);
 
 	audit_buffer_free(ab);
 }
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 9b6c2f157f83..50242210670a 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -2250,6 +2250,9 @@ static int __init apparmor_init(void)
 	security_add_hooks(apparmor_hooks, ARRAY_SIZE(apparmor_hooks),
 				&apparmor_lsmid);
 
+	/* Inform the audit system that secctx is used */
+	audit_lsm_secctx(&apparmor_lsmid);
+
 	/* Report that AppArmor successfully initialized */
 	apparmor_initialized = 1;
 	if (aa_g_profile_mode == APPARMOR_COMPLAIN)
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 7b867dfec88b..0772e9dc0414 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7456,6 +7456,9 @@ static __init int selinux_init(void)
 	/* Set the security state for the initial task. */
 	cred_init_security();
 
+	/* Inform the audit system that secctx is used */
+	audit_lsm_secctx(&selinux_lsmid);
+
 	default_noexec = !(VM_DATA_DEFAULT_FLAGS & VM_EXEC);
 	if (!default_noexec)
 		pr_notice("SELinux:  virtual memory is executable by default\n");
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 239773cdcdcf..214989d2146b 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -5290,6 +5290,9 @@ static __init int smack_init(void)
 	/* initialize the smack_known_list */
 	init_smack_known_list();
 
+	/* Inform the audit system that secctx is used */
+	audit_lsm_secctx(&smack_lsmid);
+
 	return 0;
 }
 
-- 
2.47.0

