Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA1CC433F5
	for <selinux@archiver.kernel.org>; Fri, 24 Sep 2021 18:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E5D161241
	for <selinux@archiver.kernel.org>; Fri, 24 Sep 2021 18:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348088AbhIXSXB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Sep 2021 14:23:01 -0400
Received: from sonic309-27.consmr.mail.ne1.yahoo.com ([66.163.184.153]:38692
        "EHLO sonic309-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345782AbhIXSXB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 Sep 2021 14:23:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1632507687; bh=rvCi4pnsy6UYY4nylaGEogT1My30kNvv4BtpxQ0xsVg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=f+xpP0XeKASGUajgaWl0y2oZ52nzbHJs1XSzMjOUOfw0R1BwLJoGiJNjohjPzC8pZLc3wNP08A8vYZwJYTX3HzO2XL2WtX6IlZskukaRPK6T+art60qveIKitdfskWTPWh2UgubDuI8R4kBtl/Yaykw0mUlGuQid5z8h/Ue46aHqPDOk/c6efWWCQNxJCIbf51lxsTUfbST9+jVSd7zqhXPhcV2LJswg7+uFZx1+OEo4FR/iPodGI5xijza4E5F+e8F1K+McFhnYbat7D3kTMwsP61rpMtkt8lrHNcwXZE35ST+WcaA1jqLc+2zYh8YnfABP6zF1KBpKUbasfC5KKA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1632507687; bh=AO8dD0TRQshiX+BD9j/+bDqJBD3Y9N9NyxJF98dOnF3=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=hi2dNjWyYStcuJ0L5/6gVQxEizGQh3KSMY3qVRU3gjratQON6Cd+4FaKTrJIu9cLtDF8QSg0hMJLQaTSATVfyLa2DDBxP6efQw0l7/3H6AVBxJKTerdcMVBCyFWCxmFBk7LKwn9ui1prWAeelxOr95XQzPuNRw7kgE12h2Jtag1RqD59XPFqm92sO9wc7oVT+Wqb6H8nwWdothi0rKhJrqba2iOA0WXEEri4oTuNsHb2SuOqL3AP1eqsnXFx0U8IVp3JtKQOggNZSAcadFUk2sAYKZeaX0gM2COQ5yL1WQTamlItfTDAO6/doNs/YKEPsBYNapQoIUx7E3WTwC0HsQ==
X-YMail-OSG: RxGJQ38VM1lh3csaUoBkgkzajAj7w_wmV7.OOQypTmEOaAlq55buUPPP_gFKN.m
 0ngw5UcslnigF6OxPU2Dq_6unndCTQtezt5iJyPZjomqyiUTQxLSX7DDyrBHw4CmzGPoSHF61D_5
 Yqt3SRm3Mm3UErB8QjU4lC.onqfBWOoED_NhUJy5a6Oydfwf4c8LegL1UclxqtpBVVnqkRH.JLH2
 p0uZAT63w3dWHs6hRbAt9F21bArRfdR3gbzNovvn7mXEZLGYOKUXuY72qPAeDVJfoYKomo2TbyKm
 K01o5leW_9g87TGQzaboPHq9yhx6HmFqiGj2iWBf4VVT2rcLvgwKw71bW1vZZ_d29.AIfgWoXXm5
 Q0sm.HajXqCQiRggsYQs0Rpj2r1hISAZKGf1scG_6bvrFT5CdSSLEhlN0USFW9af6VYcYO6Mx6dH
 bYJ3m4GBK_p73uCXKhJupsxiVFZyrni3s4DYhXjiVg_ZWatJz3VSlS6dPTOew6c8DYQVyb89q.iR
 Tvk8a0Dsl7gmjiNM81SNc_LhiI2SgR3ECaOOVaLz1R5peDITA4.AmB5I4kIJKIbFpJI5quWZk.It
 i6KF4OGa97xWeCHNDwxCnIAP4xqsbMxR1ityhKtDHlDtMaumxGBUnMaJs84EYqCzPPhOu1bObNm_
 pfRwlQSrYey38XLIbP_TupdZ4j9UeohsbryyHIC05zyVU8dFo0xtrHU5gPnsbAWcSLNdg2Gt3Tyw
 8VFGIGrfgKRkhtyoIgT6rxO1ukwRS9w3Gjvm2tM8abDtJg1oySuxNkXaG4Y.ojCZmjbDCMa9a9W2
 BcVqubrRyZBw_GYEWeDgrLUJpnVrJ8V.QlWYuQ7801STkcWSeA4J1nfHr3W6TOk4cAU.Fyjbr58K
 RjOK0aZy0F25YKQaiSJZshXZcUyP4JI8GfghQjtCHsl2tWndktgOhawLouallL6wvJUevV6shqyZ
 r6irj2m20Qz6dFjPBCdSVBarl7fc4QOOmw8HwyNpU1lGgzfzocemd0Wv8309IwFbR0MuTcF7wTXM
 P2O9mJuePBkV9kLlgIuwG2zCiKRruagQZwDX7N2MNHa_s2ZF_VoKy5i68x59wDLHPY.NiZNEeXs.
 abpW_bum672wGk4yaelWQH7hJvynEA7sdb2qLjg2114IbEoWVf0B_EIvH5fEhG5D6OeUa9zWE7iY
 baXbLsAecevCHGu44jWYne9kKzctnB2VuJccWZBH8IJGUa1bTC3mhAZ7TW6mS1fgdq8ywyPzbeNg
 N6L5NeIGp3FwU6Vpo0JebXao3f8QDzIbDl7X5CZWgjKYk_Yph3901Z3aMEQfaEu3JJYxZmBnWpzI
 vkleDRCk9hFkaeWtp0l6NeHZxNEHyotsC_aUOPjgAceTHP7EkGVegQtoxKQQ5SDzwMXKNApci8v5
 nbKbIlB0JW.IdiUNiKY0hd4jr5BxzoFDLV8e62t_PcAJPLJ..gqOsvuh2zESq3dU6purDjOebRSp
 AShWhCfFDiyJEr8KPT61DhrcmSnICtQ3E7WT8rLs9Od_ritRA7ULW39VXUy7EGdPKhRXQyco5Nm.
 XLykHCGvCENelH_onGouazywXfDqSytACsO2spHszilRKRihBN9tTvTfJD4Aq7H9gazIKLUGulAf
 LWb9dpCHrO0TiDKrTmYZQQbwzCJx8VFGU5tO3.Gj5b6Uj8M9GnJqvMdJZ80hYpBiE1wTmZ40b7OR
 f1nlU80jz3w6GCcq3ZE3OSh8o3Z2ST.J0vmjFomJp8wgliqD1L0rk70I2We57cQ_2wPAaA2Kvgli
 .xoGQyknrWlylsTeGnvHFI89pCGrlI3xxpntpyS9EikzSGxqcUZT9RrHe.93k4xchbJC8BVSUl1h
 FdVEhQViCK1t5pt2ETNd_9XZ5muaEtxxYtUVAzWClkj9B2YQ4xb3rMoB9C3gWFGuwyN60okb0QGt
 vU7_ZeWMbcrg5INGRDU6Ezlp514.r4EpUVLR_vBCaEcW2Gi0_1saWFOffEGKReJGF.Qw942Zs1jp
 B0Ym3ly4eQ4wUI3XpE_0H473LcrRIAxsahzDTZRsJa4OFbpt5k5p_yqAwiFbVL4B78EzToGj7GF8
 8cQUfNNWRppIttIdUSK7HQHozYn5jICpMvjetVmJzn.hBij.CMt54f1gmtNMugq3wZgDn5JOcdrd
 kU4LPC81.ndd9J21wgQ2zPfNsdivlcCSwDzzm7BfH8NRfkHjhKnL5Sd1mNCGIGRKvuLcjD0sWejj
 IAhHa_nR1FX2T0iE9zbESCBVlAp2j2X_JT.rLMgPnEUSDTny4InW3TlxSkp6dJzylX8PfwKjuA1B
 YjNS4tNHMYQeTh26u9PESj6X.GF1V.gvNHLJreBKxAVJaSWSkL0DrZKP41oJFsNqhp0BnIXKhsPW
 gz2f5qskGsqU-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Fri, 24 Sep 2021 18:21:27 +0000
Received: by kubenode508.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 683a7366971fea1064dcd8a39110196b;
          Fri, 24 Sep 2021 18:21:25 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v29 24/28] Audit: Add framework for auxiliary records
Date:   Fri, 24 Sep 2021 10:54:37 -0700
Message-Id: <20210924175441.7943-25-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210924175441.7943-1-casey@schaufler-ca.com>
References: <20210924175441.7943-1-casey@schaufler-ca.com>
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
 kernel/audit.c | 85 ++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 75 insertions(+), 10 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 069cd4c81a61..0d4aa6667125 100644
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
+		mcontext.in_syscall = 1;
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
-- 
2.31.1

