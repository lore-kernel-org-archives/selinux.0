Received: from sonic313-15.consmr.mail.ne1.yahoo.com (sonic313-15.consmr.mail.ne1.yahoo.com [66.163.185.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825342417C3
	for <selinux@vger.kernel.org>; Fri,  7 Mar 2025 18:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741372643; cv=none; b=bf3nkUBN2Jrn47oo0L9+zeav7DE8znhFtWO1dyekAdQNDQxxG1glwLfFlaZeAo3hV60ZOdiGu2gqsLXdQrdHU+LQSl4iDU0DeqHGwgbIWGDWYmgLM/CowUD7jQRywe/IBjG3y9bYQcB+qRX1hDt7E0xsQ/v5EDgfrpfmKRXGp40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741372643; c=relaxed/simple;
	bh=O520XCBXS2x+I9s35ielYReLlm716tHd8FSnv7v/wzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h6UZc7ixS1gOIP5p4wFehtzRcO5IO5IMDMMN1JY0sf8RwhKeeonL2/c6AEXRjEZoUTuWciuYvVFzek3G8GDbVmkuFCB+QWhoe8lFuh7ocEozDDREJhYvjfHXRrcOWoWF3aulnhCTGMrCJrKkKElrSv9OYwiVyb6b3tYtK87no24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=tdtSC6+T; arc=none smtp.client-ip=66.163.185.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="tdtSC6+T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1741372639; bh=wwQQc6uVjiuVerD0doILMzpDf6RWPtnsEN6Tqwh9Lb4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=tdtSC6+TqnyvF3vgSiwJTv4yJd4ud2YAkbMSVsOgXIiM7TxfWDm5CHZMQns9hNNElhLAzwapyvb/WV7os8I4413RnuE8R/J05vhiHHrEeFQ9nr6hPx5W7gkaVo9hwjjH/RETAy7Yd1BF7F1E2cpURSmv0OSiJQVUQG3z4106Tb1+HeiWHvgIYevfEum0T8xPr5JEJillg21MCn/IY1eiCpEZjENxNj0RFrD3ELXOElb5vpShf0LMmnJ3x3M3aycnlHqSQF9Cgi9alo7oeJtYNh+9g1POHKmWvSSs1a+QKJtWUJhc0jxb5nVfld1uEbzM4JgYB61FZx/Y95ojek5maA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1741372639; bh=pIWKAmTrcc8bHi1mzzGWf96kfrp1RBFpJjKkP/UQGCG=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=jGuNcI+QsFfeYlx86xzvynEF9pbSna2GFzoNzBwAY1Bqaxu98hXcRNLcOytxVPCksEec3vpfHAw45/SS3eVwnBcfWVAAc5Z/thhd+rGbvFemjQi6KSOeQyoPyY9KRO5fGQFpIffdaGZ03WuAtmWZWbwHa2ayNllU528T3mRM2F1d6leo86dyIDZvGd0zqD7NglBpBKbvUsyhG8TrDvUhvc6+CLTcpYrpf26RCkJwEzACKRLRQQknpBYct2NY4GY6YHjfoJGq6Acw98GykJNch3e4SUOSXwsKGeI6dUktUcuLDuOds+dpz96+TuE4XqobU0+WuuPC3ImKIji6RgAqPw==
X-YMail-OSG: Rz3MZbEVM1nU9bOVdgVwX_D1FPURhra5SiCrx.B0d9ULWTvUXqepjDqFo9riqUz
 mW0i6VT1mwTqifs_RvqNL3fAyZUp5l81xDohDFIpKR5Rmq5mGgdpUY49UMpUSEY8hvrYPN7hNxH9
 qz_WDnoBJBX44LmQAYAniuw1t2q_6x9PEjBMtzMrd7m8At1WLVdF.PDgR7LKYCL.lwP9P4XcQrka
 wa4McFXLbU_sPfoU9PfkrH723TFxOADlluyp7jiJX5e9lCJ2zhE5bqZhNyKchYf8HSG427fK0eXp
 7_XL5MvJCA.g9BlekoJCg11jPh.439PNlHw4l8.uQUJeE2CTDi4DyCOhjLmxQ98SpLrPuLrRVj4U
 cChk7k8EWF.GgxOB2acpy.7VKzSdnJ3iazD1o5KX9dAEOTmxyvkDF6Y.NF91sxwBn6otP21Ewtt3
 xqnTCuiMloZ5ULJlczRlq35iu98cKbT.iVrUFd9erVBYF3TepOxWmhP0_r01TwdTezTdak22gSye
 UeAUyL0sxq77i3uIol5uswEw78UrJ5JqXtMC2xZSutWGnv6TUJSvd0VKog.SUlaqPtrKtJGFSRgz
 CRrcXtoaVoZwNkgsNs_Uhl.1HY_01lOTGZX8EkHU7taV.CpVh07HP0mX9VB5jVICKH.A5qVdr_mM
 Yf6ZHa9pdGl0NLu_CrrYXAagK1ZoqARFw0Pq6u3tUJdJsb5ZjUXeRsqNhmnfsk5tb.0UCLb2a7Vr
 7EXc1qf2Pidu4rj66Flq.VArf5GHVt5s3uHB4COxI.AnXhEpseceXwwN34D.Y2LpIDnPAwKWsLcK
 2wgK7GzsBW529UO9VZXcKkS2QELpB0i3D0_NgGNeECtPCrMWRV4AQx9Tew67B.w3_PCcYseBcw5W
 G6DPQWRS5Wf_1LKLq6OL2KGdUp_GVfH9o39gmBjd7kmQu53LVEYHE98VUYKhyf961uMWRkOUjj5L
 y1TskDYXrjcZvOP1YdF2zaqq.oLCvEazNF8eKslG5bRJ7sSwlwuG.cmzq.b937Vg__WRw59b6TBS
 vY2jXtX7jA.r_kE7VUlchqJJg8Mp2VY4ompyEFnPcLEOg8xJNd74TwkaPDEjEeYN46guz40psBzD
 mGvVTgkfzQb12LdVHvN5TUV9xT_51mJy_dYuWrqRwX01OdZrGPNiCKeo6qHOk1ve8qDmaPHN5avH
 t4n1D70j1V7w8VSc6vsYZBKwHgCD1m2IMxIsILav.NHbvO4OMnfb19Ru3I8tk2F1.MchQU8LWzoE
 bcwwvAGY4DdzniAOCpHD_BGpdiwsCessIfJfPrYWXMnqj1uviIeT9e1OP1JPLu9y7RqNUvWNkWaK
 HU7BAoSVxIg5EgNXr6XOrHTD_goGI0FebMww0.A9AYv54Ku.cfIqndcYZi3CJ3mmERuzWKo0nCZ.
 82oiKgZQIqkaAeMKYf_zLHxb1eEJe_p4R6f9a865AFakFbdEi9v9NH9vf7rDI370pvwoWyzH04Ve
 dpT8l3bkHvfBXC4OT2ruGBUo6Almw8qiYt9nTCxt82ogyzzleGtdac4NVOUWsCLoIYa79rW0_W1x
 Cilty_Jzeo7pVpaP6vvlMam_1WoF84FyO2fH7m1ea2UKRExn.H0hhVGesKkbLu6kv9ShKTKbGGnS
 BOgI07yye_mKM98aYkwFosUwE.HifegHu7r13Lofpo.U9KUR_0umZ5.ubG6qCWBqQdILgSZTNEi8
 ZakkfqzOtEGSEpcAoQa.BcYbRc2cJwmrXDYqvXlKHbl3mrsbdXWABs6cfkLT_FzGI_I8De6LZRIr
 pe5Gn0uepTAKokWjOXtqJUO4Rhii_gE_uFOWYrZSFQJN4qfDRVGaauvy.lS5Z2rveblu._Khc7jz
 RbB39srIKrse4Cq90use0bGInQ5BJQAoU3lemxVapnNDn6bBZ8zUpOqonwJdYF8OPJAVqy7xzA2O
 fdAHnup9AHXg3yUspEkD9G6yt9gnKxSslHNcYQM_TJUeuSzROgvk8ZbhwcEQSzZTtAzf5Btf.G6W
 .EohM3gL73voPP_EY3EFZ7b4NewLsIsFY59IHYJjExKp9xgu.uk4_ypHK1COsGv8DzhyecbBZV5X
 I6LZuH4M09jmT_WdLT8alRwQLdgv2r5hqwl4sxKrDFlwmh2vpjhxWlXz4oF4qf6QILjX9nQ2qk68
 vKewnl4z779GhK8m19_7klJ113BKf5sJ8Fksvhs1NZhcFlIAWl10jHkmu0Avz6..ZukNYjtYetKS
 nqvEyfN0PlqWWI_OSqBEPviMcwwRnmDlgcbsnE5SPo3uv5dQBVOTLn1aUSYhT24klsmnXh.RL1yw
 E9F_vcrfz5RtSWTJpdeJcZDwxiqnuqA--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 54a0f2e8-1b5e-4a0b-a351-74edd27fdbba
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Fri, 7 Mar 2025 18:37:19 +0000
Received: by hermes--production-gq1-7d5f4447dd-9qjv2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 9e6d6a2ea591e1dd2da3497c747300b1;
          Fri, 07 Mar 2025 18:37:13 +0000 (UTC)
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
Subject: [PATCH v2 2/6] Audit: Allow multiple records in an audit_buffer
Date: Fri,  7 Mar 2025 10:36:57 -0800
Message-ID: <20250307183701.16970-3-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250307183701.16970-1-casey@schaufler-ca.com>
References: <20250307183701.16970-1-casey@schaufler-ca.com>
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
index 2a567f667528..a4945f1c3ec0 100644
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

