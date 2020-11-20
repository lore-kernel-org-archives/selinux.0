Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291E5C56202
	for <selinux@archiver.kernel.org>; Fri, 20 Nov 2020 20:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD3E4221EB
	for <selinux@archiver.kernel.org>; Fri, 20 Nov 2020 20:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="F4PsQP9t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731410AbgKTUg0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 20 Nov 2020 15:36:26 -0500
Received: from sonic302-28.consmr.mail.ne1.yahoo.com ([66.163.186.154]:46657
        "EHLO sonic302-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731209AbgKTUg0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 20 Nov 2020 15:36:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1605904584; bh=w9xLW8fzQ+muRk3i6Rg4v/KL8LDGXzoawLg2496xC34=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=F4PsQP9tayrtHhAOwFnWu/6ouhzCP/P1HB6uvNu8y20iTcvpgsa3tKliYY3gDu8erT58ZdVSu41RBRtF5snZ3S378YX2FxocEWyK36r+ahjgkkboz9WCPfdPbuyjq2GmS/RmYSUX5vjHOekVC7vBmZVpHRoEvCN0IHXQfWJ7hBX8s7pNJkLUTJEYlt6vijQwJMBnwDL574oN+rr4PApNp28lz8yX8lZQl2AsRU2C888CnMZNC2ELOQhvwryCGXdBm8hBNIma4D0O7M/0R17gIBWsP/woPIsZxXhvaz22WgYINhT2DELGVOmXDyPHRp0mHMCi1BKPMAw9VHv0sqoa4A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1605904584; bh=8uyXUzvAhbvheMsiXZAa/E+eklq4R7xaRhSY3asBCwv=; h=From:To:Subject:Date:From:Subject; b=ZsOvhCGBqkC7FkOodRUjVEOgVT6iBKFLyeVSLTZvm9vPPW0nzeDe0/8Bbbujbz0idrhhRBsAQ8Z7fuIde3SHse33S4lX9Mt1mIHnQIn9aUQwDBQAmO0hDi/wAj8+3Ooea0CC2JbgoP1WzuB+MSBwZUtMKgX1HUmgqNFyxwnhZa0v/YsUXjwPSJgi2eCXLMrkNN1kN8+DgppqZYbZrbeN8G8pi0HctW2MBlqn1Ho1v3r58uVo4grei7alkJnU+qkvdmZE4pirGZrpFnoggXbEz09ANA6Edrz9XlMZfs69+wQYKPXNYAB6ojCk6HXsH1n3RElKyBW/eRPmn8LH+SRdgw==
X-YMail-OSG: .Ti0jnAVM1nZO.oQSZPG7_A3loM8xPybvAudxKxziEt8SPRGPFGYMmq9J_vYjtm
 qF7yxPSr1eZIsZKSF1ErH4Cu9wGfeeZq7fQ1qhjqGoIH9_pGSA0Xv5CIM6ta5xP28q9YzTqtcLuL
 0jnowLqdg9Ad_ejDE0SnZKowu3jJFPW3EEIAVqjdJF2dulPlMWZU1OT6hjA8Ljdvu6b5m1OqX.2b
 kEOcpG8URwAkJ9C3G6grwNPn2mMgUqsgolotwHUtj.v8n5VrKToroz8GsuMxc_p_eNXh1byK4_FU
 7sQgINaogfi8FC_PFHB7tmv7b5NEhLrAjdCQ56Glg5exq410ICH.4FbAFe6aPjg8UiveYyhFZWo2
 htgOA1JiF.53PvaaePh882vrxdp.SXiwFhfvLj27m9Qox_VlRuPVZD3qtdgYZB65Qr6pUV1nu37V
 NbM82raagSjgpGtGSx75Egy9dy.3N9rgU9oRVWETN2ka7_a__k1YSyL0faHNCZBE9y20Z7GYejPW
 WEqLRuddLoqVrQyPDEVkbMVk9_TocrBbPlcowYYvEkWQo1SzVOjILV8wn8TOc9NM24HKyO6x7ET_
 DV5Vbm3QuAD_K.fqxGaRSzIqeYZ2a0tQkmIn5p1v3SgFB9jws5CTmNvQEV2bQfSe4CdszMevAiaH
 8n2oQ2Dw_1EK_KMYRfZudb9FHpTcot18SJsBJtSNGtjFG9MjyqFmVnSCfp8NwybdFbsjkL4aYEz9
 JqdhtKzKRasXWYlkpxsoVgUKVhdYid3gHLMqaQnfrEI10T2lPoXaj72Kdxz_N0E9y66XAVY4CEZm
 kJ04h5IX0KwrRg6MTR0M_WWIL1CjdMPRihJYRlYMVtLoPvXURF97veFPzkRS9k7Jandbll0gqj6K
 HQyRNh2uFsCfRV5JCmHBk74XCGbSYEOeqebPRIfmaQA9f6169exKBVQAH9Jutr.HuFcMjYn71.pW
 PnV_1o0XXkaEXiDjrC4CMU3kKxlRLKQ1cpiDxFIfvOocvylMTvdnCbEXUSsWpXGEqDElJlXWTUtL
 whxUEIj6LiL9wXvzzBJ1iQy5PA.wlJLO5naiATRbOetSDVVYfzsTABh.7KbDl0K3VcPhhjbcjB0B
 UhemWrtrfVqPYxl6J.Fpdi2H31nebqyYCvRnmTzqJ4qUXQpS5Fzkbi.z23QpnpdULiMyOEvbaJ6A
 KGH7GsYDpcTR8AuZYubduNkIMuZm6UU.RdbMEZMHJPAPOzJfCg.ZQ_4U2MjtRIyvedGJz_tR.kfM
 zR.I1X_lili_2SfxGXDbLYe8glZMfILJeiu4wdiZVDwjlwqLUBS0IKIkhJ3wuG83rnn29.VDrp3Y
 iNNsSUDTuZ8XlXLzArFPstO2vTsLqLiO0yFi6Up8EfBZyIsMmvLIws6vDaHkWUdmprJjHQicUzjB
 z4H3rQpwVYhMbid_W0PkWkULuNTGY5ayXATpAkTHgk4AV1Ft18iPAgd6zyQnWWzPXvlCIFu5oRj5
 Aud0hKQGBueHyJHqVwyC0rnAKa9L9iIwTtNootiIi4xIK5aXwI5JpSJZggRKBLwh9mAY8Gs75SxW
 Qo0pQIaw28.EJbzO_TdbkPjcEpiDvRP5nHLhxN44DNx_7hkAdawMAj2w8n7baP6QC.bc3VPoNThi
 2LYs0q4yfwwes0SNVVjpyBX9.3ZQ5cBTXMllDkvEvd87Eq4ozkAvzZ7tPKPQ0Bjqp8OrClp2Vw7l
 BgyDuco6RzvrLUZ6zyyMszPGcC0WoXbpK_4chPUDtS3rfId9H1HWKzjoVIAofrYJyEL63b4GHUOU
 51Y2B4MzaZDlBh.BpPxShsLYsyV9TefUITBbjLWCyrmXzM54P1IH5aFmwzzYcRzWRNCR0Gq2sVyZ
 t8OHmc4f7vw8OZx09Eg3Xg5Nq4jez57mWmap6a3re0mVDIK_eu5fbjoDws235o_vpynkJljnm1JH
 5W.zHOHtAiUTh2vtmr7MH9d7b.i9v698f0zB8W_9RWE3kOJA2ujDMDCVQrHfihrjlIgbQLt4SjFB
 _wmG75xQ2GDt1sxl_SJ1p.zdbyF8PlAVZtJUACFUUhmHTjKu4z.apb7HCE6HhLl5Cf.Xh2vmYJuj
 OpqHPKjQ0iZ6c3iKBfWaci6tfvG0sVIfukcG1A4bc499NiG92pspYUb9ypE7Jo.z5euprtJbUjIx
 cesO9jtN69BHI3HCwODyvv9WnhnrDW3LvIOGYPSPwP85S668_Vsfd0banF6u0W.zBYPn1mAz0qr3
 werPk.kBDC3fEK62v8hBM6QF6jDvbu8YT3fuZE8k_2lNu1onVr58_qihEOHhWvzZzFaUtDN7gDTz
 DZWyiK9g1lIBMwPoa6eEIzUV41vyUr1RMgIi3wZcjIvVgJNIx8OOWZ2MPaXXk0bF7YjD6KG3xa.N
 bsTOJCEKTXtK1Ch1zHgdmfTWpfyLrjuKXLiK7AOWCxIwD2YI0OqJAS84mSwK3R3bqWaH0O2vDF8S
 QuVYPoY1hQnyNaR1LnGKXCbLqwvxslLhgb1adJGH91rQAv1.vJDvVnd6kCTIg5s88DY_o7k1R5Ld
 1oy7PgQeW03Dat8CPZqxB3XwajbybJp2O8OwhiXzJGVGRgpPdj8bh2urHGuXebQ0XDEOshXy0OXL
 ganY0Bia4J1VCiwY1u8wvQq.spHzG.x5BjVkMjfGEkgYJ8Cv6tbeOm3.V16.i4YH5RYG3XPlwuE7
 k0uZsCToEiICxXSgL2dmHbozrcqVaPM34QmXgpAfagB.8svCD9YdRk.1rchbFd0vH6mXs0omLTPy
 5M0mBNHHGvypLR47_SsEGidRkN0mvKJNe0aLZwqy6rFDCSEW94Z_qWRaJUeTqEXXgUGZp9s6BXRI
 Vabq1bzr3ZursP5btp_yb.z9wcyM767.XR.UG4Vy8TUVTm9UnRbC70ORD9oSpQ7IkRaZIpts2WiV
 zeYXka0bzKTIE0RNiQto4KPlZrjQZuwWAyHSa7CZem3Mn2WpGOFHlV8hrdYAH.Cw8uyglVfdZy1S
 dcaBDToBl6Rhp_qyYNJjwtt0A1XzdXukxjOkRieurTHd48avmoiYPyvzC__T.TTSURuiiDfc3_H0
 k1b3EYKNp2aokdPmUKDtjdrWAz7.MzwFxXwp8yD5qHIOstZ9eFLs0Faeo8Vj7yswaV.tu3WsAF0u
 mSN9AYXNNoOBz.MJ1K7bIHTmq.z1.KxTEpWRipf4qtMbjwbTQSgoRGYBg8tkddsN_80ePDYGC3kQ
 NJOzMC4rsylJCrS6xsA0tCwVGvm2olsBDMEzehRTyS5mERGv55Tq314NZSnAlS6zJeu0H_tYeoHx
 3KS28izjUj5eo5Q6BQ0qCyw4LT9z2IMao0VmLYM6na9g41jZAUroVeC1ZMq1AyJF.HtT_qdFf_0Q
 VPHODzrVxzjSwm8vIPZ0yfM8QHsuV1_OGGFwcCTsj6U5mfGLm9T18pj4Ghzj.7DWHIA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Fri, 20 Nov 2020 20:36:24 +0000
Received: by smtp408.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 964fb92d139b644675ce3959b594e192;
          Fri, 20 Nov 2020 20:36:19 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH v23 19/23] audit: add support for non-syscall auxiliary records
Date:   Fri, 20 Nov 2020 12:15:03 -0800
Message-Id: <20201120201507.11993-20-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201120201507.11993-1-casey@schaufler-ca.com>
References: <20201120201507.11993-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Standalone audit records have the timestamp and serial number generated
on the fly and as such are unique, making them standalone.  This new
function audit_alloc_local() generates a local audit context that will
be used only for a standalone record and its auxiliary record(s).  The
context is discarded immediately after the local associated records are
produced.

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-audit@redhat.com
To: Richard Guy Briggs <rgb@redhat.com>
---
 include/linux/audit.h |  8 ++++++++
 kernel/audit.h        |  1 +
 kernel/auditsc.c      | 33 ++++++++++++++++++++++++++++-----
 3 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index ba1cd38d601b..786d065a64ef 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -289,6 +289,8 @@ static inline int audit_signal_info(int sig, struct task_struct *t)
 				/* Public API */
 extern int  audit_alloc(struct task_struct *task);
 extern void __audit_free(struct task_struct *task);
+extern struct audit_context *audit_alloc_local(gfp_t gfpflags);
+extern void audit_free_context(struct audit_context *context);
 extern void __audit_syscall_entry(int major, unsigned long a0, unsigned long a1,
 				  unsigned long a2, unsigned long a3);
 extern void __audit_syscall_exit(int ret_success, long ret_value);
@@ -558,6 +560,12 @@ static inline void audit_log_nfcfg(const char *name, u8 af,
 extern int audit_n_rules;
 extern int audit_signals;
 #else /* CONFIG_AUDITSYSCALL */
++static inline struct audit_context *audit_alloc_local(gfp_t gfpflags)
+{
+	return NULL;
+}
+static inline void audit_free_context(struct audit_context *context)
+{ }
 static inline int audit_alloc(struct task_struct *task)
 {
 	return 0;
diff --git a/kernel/audit.h b/kernel/audit.h
index ce41886807bb..3f2285e1c6e0 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -99,6 +99,7 @@ struct audit_proctitle {
 struct audit_context {
 	int		    dummy;	/* must be the first element */
 	int		    in_syscall;	/* 1 if task is in a syscall */
+	bool		    local;	/* local context needed */
 	enum audit_state    state, current_state;
 	unsigned int	    serial;     /* serial number for record */
 	int		    major;      /* syscall number */
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 4af5861bcb9a..5bfee5d0812d 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -929,11 +929,13 @@ static inline void audit_free_aux(struct audit_context *context)
 	}
 }
 
-static inline struct audit_context *audit_alloc_context(enum audit_state state)
+static inline struct audit_context *audit_alloc_context(enum audit_state state,
+							gfp_t gfpflags)
 {
 	struct audit_context *context;
 
-	context = kzalloc(sizeof(*context), GFP_KERNEL);
+	/* We can be called in atomic context via audit_tg() */
+	context = kzalloc(sizeof(*context), gfpflags);
 	if (!context)
 		return NULL;
 	context->state = state;
@@ -967,7 +969,8 @@ int audit_alloc(struct task_struct *tsk)
 		return 0;
 	}
 
-	if (!(context = audit_alloc_context(state))) {
+	context = audit_alloc_context(state, GFP_KERNEL);
+	if (!context) {
 		kfree(key);
 		audit_log_lost("out of memory in audit_alloc");
 		return -ENOMEM;
@@ -979,8 +982,27 @@ int audit_alloc(struct task_struct *tsk)
 	return 0;
 }
 
-static inline void audit_free_context(struct audit_context *context)
+struct audit_context *audit_alloc_local(gfp_t gfpflags)
 {
+	struct audit_context *context = NULL;
+
+	context = audit_alloc_context(AUDIT_RECORD_CONTEXT, gfpflags);
+	if (!context) {
+		audit_log_lost("out of memory in audit_alloc_local");
+		goto out;
+	}
+	context->serial = audit_serial();
+	ktime_get_coarse_real_ts64(&context->ctime);
+	context->local = true;
+out:
+	return context;
+}
+EXPORT_SYMBOL(audit_alloc_local);
+
+void audit_free_context(struct audit_context *context)
+{
+	if (!context)
+		return;
 	audit_free_module(context);
 	audit_free_names(context);
 	unroll_tree_refs(context, NULL, 0);
@@ -991,6 +1013,7 @@ static inline void audit_free_context(struct audit_context *context)
 	audit_proctitle_free(context);
 	kfree(context);
 }
+EXPORT_SYMBOL(audit_free_context);
 
 static int audit_log_pid_context(struct audit_context *context, pid_t pid,
 				 kuid_t auid, kuid_t uid,
@@ -2228,7 +2251,7 @@ EXPORT_SYMBOL_GPL(__audit_inode_child);
 int auditsc_get_stamp(struct audit_context *ctx,
 		       struct timespec64 *t, unsigned int *serial)
 {
-	if (!ctx->in_syscall)
+	if (!ctx->in_syscall && !ctx->local)
 		return 0;
 	if (!ctx->serial)
 		ctx->serial = audit_serial();
-- 
2.24.1

