Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A3DC433EF
	for <selinux@archiver.kernel.org>; Wed, 24 Nov 2021 02:10:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240451AbhKXCNQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Nov 2021 21:13:16 -0500
Received: from sonic306-28.consmr.mail.ne1.yahoo.com ([66.163.189.90]:33812
        "EHLO sonic306-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239932AbhKXCNP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Nov 2021 21:13:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1637719806; bh=FYfnW5aLV+shcP/5TMFUCwsaABbn5+q2oGvuTIwRTTU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=gtS0BGGUeTmjEzZxiOaLYKAjadHQdEhMN+DJzpkCkjlMqq4xcYth+WX7ElQK73i3ilRnJadi3Cwvz1eKWYynBSppRPha6yqaEsHVRB3p/ukCH2lapI2I31oif7kiLaTROYFf00Mi0Q3tz/MCxJ8ZXGxX1Gdr5dNHdKwkw4D831sw3QKc2RiB/dOjw2FoE9NuqaIKgngMMTlkBVlWhqJwS36jl5COAoRH5PwZ75RY1i9ubkCWd5za/0g/02IPg7N0/EjPuxFbbPk2GqoC9EiNvuML2E9zr7u1L68rqyrl+9ifFQweYqbsvIoZrKA5/bf1ghkXwdFPEeSOCPp8AHXrCg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1637719806; bh=Di5hPUPZpGsAZ5Odpf8+egZj+tkXjdTZJAf9Or35Eix=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=GTK1uSmRFXzCBcXy6takztcysJ24s+sYsC/PTbSwBlgQZTFCyjsUew39GYJQV7RL9y7Fhb6/oorMUP3gaIPBqaYU34gByDPT0sL7CnsYgueOWaE+pv5f0fbIUs6Q8YsH55IqKbLgStnB6shpSkK1ctVIc8rPQ2ZcL62QOrrq37yO6a9rSgq8mLkzgKyilLdlxkt3WsvTuc+U1VBtVD+hu8jjPVAISedVUepBxlVDSxMxlIm4fCyU9QtVv6sajgTKOh88yEUlgt86dz70Rur25Ame4NyufriIFACeCfIFEhk7y1ngb3ueyRFwQHdv3jtEn+31jytc/xOpwJaJ3sYozA==
X-YMail-OSG: IW5yBxYVM1niQT5IRqng8nMPZPMjYAEQxmu9KjcobD6tB0YhZoDevZ6WvwBSSr2
 zQJwpBPuG.Tcl01nx3qdP0z7rqzODzXoZu38Sj2vDKPss1YXqv6IoOLv5_E.8PYk2fe_jWMO077p
 tHMYDRdR4wugnkV3pmVWhfJiW0re_4Q0FX0buYIVtrHeevnE3EZuoL61pkDI.g_aP_q58vZmDPnL
 nv59BGPWvoCmt_2ewh_YOGnbFnKYYu8h8qQa8H0Y5oSc5.G5ka8BxkHhP5vo.IpduZSajwNY4fxV
 0ToiTEkCGRzWf_wQpZ9J9mSU670eaf9oXFEczCe2Vl0zAUfio.uoM1FDx_DzQltBkIimosltiMpS
 ix5eFDN54xEEAssmc57uLi6r1EiziG7Oeg7cbE.OpHkVj.k.tFy48Vtg5cRlJDKv8moNuEchNnDi
 zgoic2wTNOmy_H_zDeGbVoqBwdS3B8z_28VJrcXQ39LGCy76tJIoaKPYh3e5Y4quySZ3R3kiNvor
 RZwCJ7JGMi1jQgCZnnPH3f8.c3AQ01IiNhJUYGCUVZQtJ1pMudVoJPTer6iin_vMechpWXn17PVL
 fTgbLE6whMsAoxBNkOkNjh682Ou2qgFYNbqTXhkVgBV7myXJemS_uxMyJaJWgbGUGwBGAEACcT8C
 iBdzMHYMX5C4YYpqAziodMAQIZ_JZJP7c8QFL94AMyjUhcBxssBGCeYaZFdf5d3CXU_E9HTY5mxA
 zS_ZOQZCm0or2qaeEf8uH.m9PFpoHhWTki5WdTzBDkFvvwJYwDxXhs3om8HqsKX5ldCbkeLolCfX
 u05u8CIA1tPgiEsPmoY3d1e.shDt2FzWf7s5nw4uj_reRGoW5NcuyaMJERMwEE6OEr.EtV2ZsWjt
 IyJEjXBqYPbQ_4PB3e3BwJfv.IP570amP.QhCV8hVVRE0E9eNEFGxNYaMMTC6b_zvSFKXMF21UK8
 HD9eHS1JWL6dYdJo6qhHBo4pDA.VtIVyIREtaQZ0Z5d25_..TCN6NjOHcudXc0F6Cv.5GYQi_.9v
 GqAPCO7438udz_QS.7lCCjswCgLk6RDDGbc3UB6VH3Myn6ex_zFHbpGtyrxeM3VPvNu0lOEn0H.N
 SnggRsojF4meJ3TPAa5DcWIKLFZ6LZcU4OqDKHbSjwKqrCUI3tMVi6.GqxZUjmoMM7p4rKyxjgt.
 PEhcccIYGGXAAhvPz5QsZfY3rJVU47j.pkgo3SoqYCN23lZwU4R6j568ZccIS_jgVjUJrk_TXdX6
 kGqJIuDbEKAxxMOZcFfSTQ3b0RsCNxgXPFIG7H0p4FIoNmnD.fJRnkSp5RjPTXbl2XVjYPQAMfuR
 qKB4.ux6.YNmvW1OSDtKNzk_CHQuYRbt0GQ3c4HPOQwipnZUMBIwe4ukmplDMBmldXeTxiRpoVrw
 yiT6eP8lHptwfmCXum2SLHKgXMB7JPe6mq2CsIX0Q8RcNdlCoIj78FUnREk1J4P3oqhoBrJI5cRl
 mGf_t4mH_IO.uGhT_jTnKfYRPLD5DR7msQnWkELPfWBwvgkPe4rueqkaYGkRU3Qfx9tnTzvaXdlP
 Y3E3d0QOZnh1sbX9C6t_83fkKmY2Rsc.RHnRWwpjNqH2xcL0j41Y56IvbYOC5.tB_rRMao03jigf
 .pMgowAyr6hTV9a7q3DB54sYobhBL1IAu9DqFRS5pOhEDG78VV.GCTpKapbBzqznFgPtcfoD3seN
 EFLKiae.PglmuZV7DIaTv8DCRQLB_ognUaAzN0DGyYd_07gzn8v1rEYBQKaHX9kuiHjvG85_0WaT
 5U959oP0pfTbolac4UBCPx9Tp3Gj9viJyJ7s22UKUFRHYoX0Fs9P6ZEoERxlmMnfHHsIdOoWAD4l
 chJZU79bIzI0ivX9gE8pK5MjKC73auAOqVcPwQmqu7j9V8Ei1lJyApTRSLyGh0LG.Q7VGO6wXN3_
 _XjXdHztaHDcCg0WhWAnRoWvs_BPTVLM_Gev_Lbs8EIeOCopFnByJpKlRw5TptMpZZvdPbhguHyP
 9A3_myRcBEuawkuyqUreHmYp8g0dR2NpkzYrib8fvUCN_WJ9nEfK5E3UvTF23z6zdpKdhsLGP8jh
 b_xPW8k7GLdlalb8hNTNOoLCihHhPGM6F6lGw_iWNOiT8FpaSl04_Xauu0ZphYOA1iQGvf6OysCd
 oMs.Id.GHqhsakCcqf5DZfKs45212ZMijlDlJewOdIpwgWNVm9_pgzEsuexHgA8VpgsKXzf_JxLX
 YFgEXOndXTzQ4CfKd3h3D5QRxmeuewVX.6jHH7h6dWDvWR2FdfLDFzLj6t4YUxoeazRkFSn6i4kS
 Wmd2g26vC4AwVEBFQpQ--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Wed, 24 Nov 2021 02:10:06 +0000
Received: by kubenode512.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID fa97930e4df2168aeebf019ebc923940;
          Wed, 24 Nov 2021 02:10:03 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v30 24/28] Audit: Add framework for auxiliary records
Date:   Tue, 23 Nov 2021 17:43:28 -0800
Message-Id: <20211124014332.36128-25-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211124014332.36128-1-casey@schaufler-ca.com>
References: <20211124014332.36128-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add a list for auxiliary record data to the audit_buffer structure.
Add the audit_stamp information to the audit_buffer as there's no
guarantee that there will be an audit_context containing the stamp
associated with the event. At audit_log_end() time create auxiliary
records (none are currently defined) as have been added to the list.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 kernel/audit.c   | 85 ++++++++++++++++++++++++++++++++++++++++++------
 kernel/audit.h   |  1 +
 kernel/auditsc.c |  2 ++
 3 files changed, 78 insertions(+), 10 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 069cd4c81a61..2b22498d3532 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -191,15 +191,25 @@ static struct audit_ctl_mutex {
  * should be at least that large. */
 #define AUDIT_BUFSIZ 1024
 
+/* The audit_context_entry contains data required to create an
+ * auxiliary record.
+ */
+struct audit_context_entry {
+	struct list_head	list;
+	int			type;	/* Audit record type */
+};
+
 /* The audit_buffer is used when formatting an audit record.  The caller
  * locks briefly to get the record off the freelist or to allocate the
  * buffer, and locks briefly to send the buffer to the netlink layer or
  * to place it on a transmit queue.  Multiple audit_buffers can be in
  * use simultaneously. */
 struct audit_buffer {
-	struct sk_buff       *skb;	/* formatted skb ready to send */
-	struct audit_context *ctx;	/* NULL or associated context */
-	gfp_t		     gfp_mask;
+	struct sk_buff		*skb;	/* formatted skb ready to send */
+	struct audit_context	*ctx;	/* NULL or associated context */
+	struct list_head	aux_records;	/* aux record data */
+	struct audit_stamp	stamp;	/* event stamp */
+	gfp_t			gfp_mask;
 };
 
 struct audit_reply {
@@ -1753,6 +1763,7 @@ static struct audit_buffer *audit_buffer_alloc(struct audit_context *ctx,
 
 	ab->ctx = ctx;
 	ab->gfp_mask = gfp_mask;
+	INIT_LIST_HEAD(&ab->aux_records);
 
 	return ab;
 
@@ -1813,7 +1824,6 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
 				     int type)
 {
 	struct audit_buffer *ab;
-	struct audit_stamp stamp;
 
 	if (audit_initialized != AUDIT_INITIALIZED)
 		return NULL;
@@ -1866,14 +1876,14 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
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
@@ -2363,7 +2373,7 @@ int audit_signal_info(int sig, struct task_struct *t)
 }
 
 /**
- * audit_log_end - end one audit record
+ * __audit_log_end - end one audit record
  * @ab: the audit_buffer
  *
  * We can not do a netlink send inside an irq context because it blocks (last
@@ -2371,7 +2381,7 @@ int audit_signal_info(int sig, struct task_struct *t)
  * queue and a kthread is scheduled to remove them from the queue outside the
  * irq context.  May be called in any context.
  */
-void audit_log_end(struct audit_buffer *ab)
+void __audit_log_end(struct audit_buffer *ab)
 {
 	struct sk_buff *skb;
 	struct nlmsghdr *nlh;
@@ -2393,6 +2403,61 @@ void audit_log_end(struct audit_buffer *ab)
 		wake_up_interruptible(&kauditd_wait);
 	} else
 		audit_log_lost("rate limit exceeded");
+}
+
+/**
+ * audit_log_end - end one audit record
+ * @ab: the audit_buffer
+ *
+ * Let __audit_log_end() handle the message while the buffer housekeeping
+ * is done here.
+ * If there are other records that have been deferred for the event
+ * create them here.
+ */
+void audit_log_end(struct audit_buffer *ab)
+{
+	struct audit_context_entry *entry;
+	struct audit_context mcontext;
+	struct audit_context *mctx;
+	struct audit_buffer *mab;
+	struct list_head *l;
+	struct list_head *n;
+
+	if (!ab)
+		return;
+
+	__audit_log_end(ab);
+
+	if (list_empty(&ab->aux_records)) {
+		audit_buffer_free(ab);
+		return;
+	}
+
+	if (ab->ctx == NULL) {
+		mcontext.context = AUDIT_CTX_AUXRECORD;
+		mcontext.stamp = ab->stamp;
+		mctx = &mcontext;
+	} else
+		mctx = ab->ctx;
+
+	list_for_each_safe(l, n, &ab->aux_records) {
+		entry = list_entry(l, struct audit_context_entry, list);
+		mab = audit_log_start(mctx, ab->gfp_mask, entry->type);
+		if (!mab) {
+			audit_panic("alloc error in audit_log_end");
+			continue;
+		}
+		switch (entry->type) {
+		/* Don't know of any quite yet. */
+		default:
+			audit_panic("Unknown type in audit_log_end");
+			break;
+		}
+		__audit_log_end(mab);
+		audit_buffer_free(mab);
+		list_del(&entry->list);
+		kfree(entry);
+	}
 
 	audit_buffer_free(ab);
 }
diff --git a/kernel/audit.h b/kernel/audit.h
index 56560846f3b0..f87da8e0a5a4 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -112,6 +112,7 @@ struct audit_context {
 		AUDIT_CTX_UNUSED,	/* audit_context is currently unused */
 		AUDIT_CTX_SYSCALL,	/* in use by syscall */
 		AUDIT_CTX_URING,	/* in use by io_uring */
+		AUDIT_CTX_AUXRECORD,	/* in use for auxiliary records */
 	} context;
 	enum audit_state    state, current_state;
 	struct audit_stamp  stamp;	/* event identifier */
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index e6868d072648..c128f7e73e89 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1681,6 +1681,8 @@ static void audit_log_exit(void)
 	case AUDIT_CTX_URING:
 		audit_log_uring(context);
 		break;
+	case AUDIT_CTX_AUXRECORD:
+		break;
 	default:
 		BUG();
 		break;
-- 
2.31.1

