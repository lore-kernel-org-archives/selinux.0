Received: from sonic315-27.consmr.mail.ne1.yahoo.com (sonic315-27.consmr.mail.ne1.yahoo.com [66.163.190.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42BC1FA8D9
	for <selinux@vger.kernel.org>; Tue, 17 Dec 2024 23:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734476951; cv=none; b=J91viWq5VHgzjViVPffNvRQdGUOU5IzeiYW6JK9EBf6diWul22+XWYJD1P87A1uYRK59JAIQHEHUlQp2AYyXX6s3uQCJve/8PTzC824OjxFSNgBBdjKIFcFCkAuLO5DM1P33VkM3+ybvVFlqJ0G0aGqojzCAlxnJasWSXucJucs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734476951; c=relaxed/simple;
	bh=7X9hxfGGCoo9NQbdiYRVgkQeK003on0AJNVvpehoTTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MDsKKBSmLtid6LEH4YvJrryG7gpVHupssTFu6z3739vbKu6WT3fEDnvuAtWjtfHCdqKE2n041W3KvgsWjRnSoNNMB6S+E3wur9JM0OCts2So2hm1hHIloiOA0+f+scGi3RKBMdbpdf2moq1obrWljM3TDlnpESF2+Jl5tWQjJEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=E26hVazk; arc=none smtp.client-ip=66.163.190.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="E26hVazk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1734476948; bh=VXT7VlwL5ukJWqqPMzjF0Hi5B1YDB5oL5n2iax2YZ4Q=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=E26hVazkWiq+0FL2ZiT+QlmFtrAeb0l7TKtiZTPVPZ+ABo08MeeF4TZf7BZVv1b87OyTEgYb5a9rrcd4Sf4Zwr8Gg97XWVctLZic6V5rTlr75UFPqxXt++rQvWgXs8LE9h5aiXcOFnp45EjBCt1DS2toM57E3O6ZiinCvZeZUeSt1c0uVQ/8y/EDmKyV6jKV+W+dCTDroQ17cZqmIcu3z0f+88ySiHmICuK8xmpk1gXpNTkbUZZNcPQJ2YBzG3aOBjt2FRtkLULnUCj4aTetuwbEbMJumsa1XtGcecPvAUrT4vzYRg4MkbKlA9KytFbMV1+hnbQrX1Fweg1DJFgjeg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1734476948; bh=3pQ3G67/L25bGBbbG8LGQ+RTEei+SeI78f01P7Mnfn6=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=lGvPfbYKljDfYk07950HfJecnvFI1njWhz6N5xSgRrUW/gRY6aCGfotV4fEWo/UG6mriZZjWVS9r9f9cpjsCDX2QrlfzNEUrxrqPpO8e+ymkh2Sgy4mppKPfkB+BQdNltpC9A2n6PIwSQsldCq07eMYcrkssxbbpkThjjUtaURvCfeqwxKNX7uR5AKZEMQJoGfUMQP5VE5fgLO4ub98ZDwKzbB7HavxlIIwkFKfXIoaFzVWtDAtN2gQR7tTSWkH1vjXJkOAsGHhk4y+VsOKTUncgLNSMz87M9A/uicuiGZRmpG/lhyiq4eS13Iwbd6+lKgH9MffWf/RoNnh7PTLFPw==
X-YMail-OSG: X8Y5U38VM1mz7y.UYR4Mwc_GwyrH4nYtiamTA1Uuuoai2Rg31ikCQXMHICMdWu0
 ixIlJ1XqAmqLzwS.FXgdZpoXIULW2IC3QSd6H1TCBS5ztPwr1FyoaCqtSCV8mr9cE5nQnCXqzleo
 B2hI6XSIbvjGhZvTPVvBDSIzcMrZFXOj2cTltO9DfnkN1wU9ooveqN8gA7I.T.qPH2Lxr4fHJHBU
 7Bi5H3xyqNcU_xQGk4VMxLUBE9kPbA.dRa3gtFTBGdrZU.ZCubUeY7wmStZQnQ1dEdFlJ1TXzA2w
 hJdj0mAd28fdOY1jqT_RZlV5OWZtcsPAjsJATe7YUt8TcLMMFyuIWfjykdG1zgLMC4BB_CPKuxt1
 pZkEeg4Ue9tXWJJCNZWnn0D2dMZVXAUFlpI.NP5UuUViwdJDJ5ysIECL.QmPwwhurIS0c9vJvVAQ
 W6nDtTBcBa5nFlWspw2tEhqxPSF73xlFfHHkRoMSpy_DLdfMAcGF8ohXjdyBJkevARLPmb6B5PKy
 E2DAbLKRo2BrUhfKnEKlAh.2ulPq4DTAtPuhVu0CTJiWqBGh0c0Rya7YQeQeZe9cOs_vqN_w1Efq
 XcqnAJr3FWsyMGr8YlKMjZDgI17jUnK4F0z1ctP71kYCN5VCKRagXAseTUHitHUbk1nfvJ.uZrar
 pYIuLXpDuyfOGW8GAfzoGcFoNNSoqNFiVxPvx7eX9cBUUkeTlTvOGwsgQ__iFglKkKkXoup5B611
 HOo.ddPhXMqU385UHk5Y3pcIf6Z15t_gu81yUa9FD3DQDQ8mNw1EjYI6AcS_dp8F_XPTVUmqy9s.
 gTe_COpxvprIcFheL1H3CoV3Dtba9jEO0go458lMgSOoyPrseqJis7wJSBKcgyCL4N_hSydOklED
 fpNxvyvSYMRQezY5HJb5CDjJM.AWvryZg12hx758lmAxqZEpwSVFu_kG29tF_AW3O5XFV3ST.AGY
 lehsSkoSwpYomuEHFyOzH1C2qAHwG4oohL2tC7zzfGTWsyDDdzzThSashWaaUdp4dnnW9q3PBzah
 ijHac4IFG2iZ3qsXZ7vebupcgRGjlxdrwpRw5QGQkoeOOoJ7pmHR2pBtq_sxQg8JBAIX6HnCd.Z5
 8PkpXnL0Scq_LhXPkslQn1sZXIoVqU4hpYuHU46o1Y0g9gymWOqQIRn5Mlaw4bClHcKjISqCwCbj
 byff4xOlj5Riz56xtxlAFeFa60mpXd8bm9YqnrEK0oRkghfKBgZggMXKPLoomSl40SdXQKC9I1nI
 nJad.o1BRcT2GY_sUM9TOtSVA6PhfjWLc3e7IK0E71ObNQJR45pl3m0CHidSTGEI6ttYTjkzmc0H
 R45H5AEZUvUxyL2U3Ze2FV3tfYG.yZZf2etsc9bIm8OyR21iCV_Uq3PX3U9PSUKtHaafwWgtEPjT
 xoUaRRB13ybLknVKXB7uduvCK4Egy8xX8mg1P7Fkt2hn9gmJc5s1SUqBdoPLyRXKa5yB2ThsfWDb
 yNIOQxcNKhJtFaKnvvXQSN2wxdUs6y_7EewpZz.Doc9CjA1FvYLcCDyxZGnFf7UgRAJwHvoY1aJ3
 Nf0O3e1BsXQ..IhaZI2fpqc5yRxnSfL9OaFs3_Q3h4ETuosPGAIyzzqDol5IxMESq.DuaCufyYu6
 bI4vj2szerJBuUmfPLvRx3wxtiVka7CkMX2ZAVJp8b_EvAzQ6wUdDOlzoIxJlu6LmX2L.grdfwzp
 Qt8IqQcbHIIEy93ndpaz9JqfYOWNDd.6ByssEXiBAgB93SXA9KSetVXzUlqwEmDN0zIEQX6wOnH2
 qrGuqFwrFOACfMmjgwhFjNHFxYntcOrIGkJBDnt1pTJQ7E9U4U8vZKDQM6zDbcTdeTMjphiRiSh1
 qOL7Z2PUmPFztAcBh4x2YFZiuVDQV6LmokpcU8RnIUlWzNFZMjp1B1CmTrh8L7KVcKV5pIWY0K6u
 DDj5w.ypQJviLL39Qqev.Rx7oAOgCTWp9X0ffNjbG5n.9bAK87tBJcyXK4i38n670Z5JZ.ny8lep
 B1L2OhustX07HP5.tKtuZIWYre8WQgw.DGEoVq7UJs3cuBTl_sYrmDxTuzteVJ4cCJ4UtNNgsuzF
 LcCz7.pm6JN5egCBoRhSol1kdhGpG4OT0klt_VuzUkmCEGi6vTl96GVyGN9wzecGx5EpwmKBL3qI
 XPPJbdyvLApHRQGrDHQpTTKX5YpJq9yGRcMDDtP_Sd4s9gI2wUcj9BPq8vwdxj1xtJiy7zZfJWn5
 XCEtQE0Qb.t2UE6qVaGNqLVBNeGU8sv9XXwRQoB9zLdFB7tgzTuTy9.TuvJpbGKOX.2hSxc_3GoM
 C8gmXA7eqRrFRwJSdklOFWf_Gv7AV
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: fbe28f91-3f1b-48f2-9847-58a23d768626
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Tue, 17 Dec 2024 23:09:08 +0000
Received: by hermes--production-gq1-5dd4b47f46-sx6k2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 617dfd7e8dbc08c7e277f225736da47f;
          Tue, 17 Dec 2024 23:09:03 +0000 (UTC)
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
Subject: [PATCH 2/6] Audit: Allow multiple records in an audit_buffer
Date: Tue, 17 Dec 2024 15:08:50 -0800
Message-ID: <20241217230854.6588-3-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241217230854.6588-1-casey@schaufler-ca.com>
References: <20241217230854.6588-1-casey@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the single skb pointer in an audit_buffer with
a list of skb pointers. Add the audit_stamp information
to the audit_buffer as there's no guarantee that there
will be an audit_context containing the stamp associated
with the event. At audit_log_end() time create auxiliary
records (none are currently defined) as have been added
to the list. Functions are created to manage the skb list
in the audit_buffer.

Suggested-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 kernel/audit.c | 111 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 89 insertions(+), 22 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 310c1a7859bb..e259c48d6148 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -195,8 +195,10 @@ static struct audit_ctl_mutex {
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
 
@@ -1776,10 +1778,13 @@ __setup("audit_backlog_limit=", audit_backlog_limit_set);
 
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
 
@@ -1795,6 +1800,10 @@ static struct audit_buffer *audit_buffer_alloc(struct audit_context *ctx,
 	ab->skb = nlmsg_new(AUDIT_BUFSIZ, gfp_mask);
 	if (!ab->skb)
 		goto err;
+
+	skb_queue_head_init(&ab->skb_list);
+	skb_queue_tail(&ab->skb_list, ab->skb);
+
 	if (!nlmsg_put(ab->skb, 0, 0, type, 0, 0))
 		goto err;
 
@@ -1860,7 +1869,6 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
 				     int type)
 {
 	struct audit_buffer *ab;
-	struct audit_stamp stamp;
 
 	if (audit_initialized != AUDIT_INITIALIZED)
 		return NULL;
@@ -1915,14 +1923,14 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
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
@@ -2178,6 +2186,57 @@ void audit_log_key(struct audit_buffer *ab, char *key)
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
@@ -2412,26 +2471,14 @@ int audit_signal_info(int sig, struct task_struct *t)
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
@@ -2442,6 +2489,26 @@ void audit_log_end(struct audit_buffer *ab)
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
-- 
2.47.0

