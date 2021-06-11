Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC36C48BD1
	for <selinux@archiver.kernel.org>; Fri, 11 Jun 2021 00:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C92206128A
	for <selinux@archiver.kernel.org>; Fri, 11 Jun 2021 00:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbhFKAaC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Jun 2021 20:30:02 -0400
Received: from sonic312-31.consmr.mail.ne1.yahoo.com ([66.163.191.212]:43763
        "EHLO sonic312-31.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230083AbhFKAaC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Jun 2021 20:30:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1623371285; bh=7V2RZ/HRpW1AoAp/Iq1XcaU0GNuu+Wd9ZV/RFltAMkg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=G0f2JDj9OdpNMHRJKcMyh5PZLlqsiyIr/IqEyK2prB7qunHnf1YAU20IxMf2KZlfEH3T9epstFxLKRaN4BVr4y571gtsYEth4yfWWxXJt27APLi5Lcx7xrB6V8naJiYgk0nPO6aUuF6kBt4OiKskr+De8X+IAYxI9hRBWlRnXDboQdCM6YhPIItg5FcqWFFI8T/Hc/rDB1od8Gkr0VVMLBsy0juimXY66//bGU56XnPCqr+1/28NwkrpMMXuEOeLvPBMgi9bnU39ZAVVdoi8tG7v7a2n8X+YzCKSfHnA80axuAw7tCClTuUim7MFncIDPn3piCtp5mEfd6GP1qjEkQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1623371285; bh=vJxgvEmJ50fqSZZQUpBsn1288uDgaGKP4jySsukHIgJ=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Haainc8GXLFWrjQYZHXiCFJf57+GcmXpV2j/4CbgzxyZPK7zTXGQl7O7y2sM1QBkkJM4GJDcM8zJ+vAj061PU4nIz3Xx8j1zbBAYci+Khl0c6HzBJ9cXyUjHF5vZqaPqVWKrQ9vT54LzGiqy30I9EgLU/olioeHqmZ+WNW+x9LoWrr3Usb6xOuh9jHxNITKQP+xj6WCdB6WPvguVv32/adFquP0XSxqj4SFk3zTUOuSdwDxR0aIHoorzezWuzIQXv6EZznP+jEQ9wX7IC4Pk/x5kNlfYwvs1L2+dHEBSXbh7amQX2vJx4zc+pDcmLhS/BJZoGdLfKmc/hpmclF7mgQ==
X-YMail-OSG: jHyRJOUVM1nfLGTW2Md_ZjNO6VRfXLCt_w8x.tnfXCj2eVQoAMbsyc3XRgZM7.O
 GWGYoDrxgOo0GhHvc2Nw05opUWUvuC4kldArZEOHsGz8h22f1byFlcJziikmTela4zgXOBQQmzpe
 LP6CMuh77l6Mgs5zVH9gG.BLnmYUpw2rqa8avEnf2tISMMFffKaXOLbZ6I4wdbkp5fAmglohYp7c
 0NY7k0R3ajR7TdZlA.sap4O.e2Rt_lzG8XKpV6CH9MB6WCnuJCrtJlum7bRWZA_Z37tBIw4rHBJZ
 VOw804rTUF_eeDIz2t6vZG0FBiU27Y9381KleCTgcE.y.YLwjhuyieEhOA_t8votaTh2BnibNn0M
 38Yjvl1G9ysZNDp4h7Ea9tO4xFCVnBLgqVokQOJ391_tvgsbTff3PVjtggvptEQnodmIxHpSqPGQ
 UT57qJf9WFB_TkyxwFU1cPKa5QuSxTI61pd3_dn7OJWFYlVOdFBXa18ZyEAOFcdpv4zFuxnHCiyZ
 A43QQvemMpFm.bUgRlp3hIL66jMlTVGrduZNqBTgqarExQctIRefRLdtdqofNqIDE7jclshvhhh2
 7eoyadS6nqkdJ0olKfb7uNnqD_Yr740V3CEAt2wwpSHiZXmDNAqEvP_M.P6PlTw3KUKjxdyq8DjX
 v0gmma_1A0tQVOy_Rdp0ia7ItUCULwXaaAw7dVOyutYZwWWfitAb6UQpKrSM5oGTgpfYGSEljq0_
 RfsBD6xE7wyxjpDLgHGk8TvOzCSUjntMkYtTQN1jd9YUxYCECBQ4zseEugvb1fBLDL8iNpJrlrBp
 hXEDUB9p0DazJ0a4QvJ83pRfAYFASR0rS3nhLSGgxdkS2N6xoK1uF2i97h.7PMY2L0J23g9GoYT6
 exZ3ozLBpZ1rdi4l6hTvGrlImXCQHRRE.A.HpzyK0y6Qb5BHoIyo8rrugCVgeQhfBVLV0zrgYoXA
 NHNoRntKvMIdkh8ZG0M40TmbbeArpmEM5U1PIerXRiUA3FUBHQNI0SEDschnYYacvkE599sW4FcA
 Tn_K217A..e0CbYgwZFpv21NcrrKr3kpbSsV7DX_PEXn14sD0GXfypQtlLVtnfkR7xEYsmuSOCf9
 jre51x7XYxzEjDo9EiQUscYZzzC62iW79dJJtg9ukfi9P.F4YZpKzckWmDQjYarST4RrqZ6HRTeq
 RtyGDBF.I_KritetrziT4SLcYydFzMjl91gmyh.7rtRZkQs8eCYdpi0.a_.4s.EqXZQ0oXTwqdkH
 avTqmC1o27LU1wvKX2LKw4d3Va8cY8J5pnh5i5qEqX.ysjNnCxo8FddtFke8Sdx0PGmr0FV8LxlW
 niblF2rMMX.XzJe.ak2LwyVyw4rIXJYVOvOz2ARMP.doEuSkN7wyS6pmizxCmSxUlpoCG_FtDqRC
 HfMuE9DFk.4LPKJbrZr.i2QCXA6l1MBQT103Jro_3NX7jU0bHl_54COfCMsf1cZjbZshga5pO8OT
 uBrGw2ieMc_gXL42VqdakwjM2Ze5eOnVEbaJL6afUT8IwV1rU1269bX1hP6O.KWfUBNyMokdu2Hl
 Jh353DVFVSXiRptfeu_t_Ix_fkozMHvy08QkbF61ZdKfe9Q1.BmPrRvEHafJKfU13ztWHwokBI5W
 TBfg0Y0R3USfB_7U3P2PeVp3CAxy_tb92gZrn6IidsB_iw7.X89boyoXx_wmhuv0aaeAsV0LXXRn
 o.NdBhreWBo87T8Erl2F8V9ooSStP1MS22CdwbQzklE7ddP9sVh3c3PrcPeqocoy4bPx6rMUxmQ5
 3pTxXKt3v9uY5PCcdeH96KO2qYafp9rMxQNT1Ahi5jrGnZMfYe4fR3TkytWwhaEBsSP8XgWQVHgA
 BO_vvvTvYo_Q8LK76pGHPtFEeZF3FWRb9kkALy6SzOJs_qfVtvgWfZLqaPgFVcpBcKjzFQgyrNKz
 yMafqWidZVC7SCVgnUxBqVEmhy.6Vn4PSIn1_43Cu1sbBTRTb8E8u7RuIafQtfB2Gjik9znNIjMq
 fexWuxedlizmcVyLWxWjb_w_eb241YzDY3er7.GPaveJLkcf0rW2PC9CBXnmX0db.RVKMXbS8cRT
 4NqmFt6oqs0MfU5UoioQwwuSx_LoW2SOrqq1SZca_Eg3VYtbhIkIgD88g.HLPrGy8ac_RCgZPb0s
 .t4l2Hf2y_rBVYYtQqoE4wzR.9GZXOETfXh9SCxBIUwajk7rX6cL5E5.cumTNZwnI.y9hKM9VjlW
 IrWTtnyiJ2m_PcWLx3xlyuGNHY6tq7JSql9YMtq1pUHUTl1SJhb8tgGuHe9qwFKiP8mEWGSTObyV
 UDBln4X8RRrt_RFr6lFGltLBGGkoZadY6j6t1RO00UaD1V7VQuLcoluXjNlNZ9t8eL8_43fRPUrb
 TtQKUeFjwaMgpjQRqvv0LD.8DBoZoUBvIE8GkOA7LkNMY2M_d5I5Eo4MevOHraxQWHeIvu00pV6N
 YMnSqfwa_5_DCf0x_n0IQSB3DmyTQ9x.pRuEcoBJxfxl8BrcwlwHJSynAQeJyWv1o3G_mRyFBvNO
 YIlHYu3KXyU2YfubAbTXbcvVWck8YVbTglfKZczi3ENt8vBIob.S_MQMDpcnq35JSbVZNk9cU.Dp
 K_Vdsd4lbGW53SogZJy8RumSdT4ECFskivCkh5SC1o5lHs2kTZ_77QBuBn4jmQJxwLSK3Qm.PL_L
 0sQQ.tyUVEK3thwTpo2bAQExA2FL4GniCtK5iyH.9zedoK7aSrJwfyhlxli6oGaTQ2WeAruqa58e
 wDsXcypO.nM.bK4YBJwc5yGvmRgII9MBfRbPVbnut0GujR28KFbkaoNK3LH18_2gm8zyKTne6j54
 96YxdpT74ASYxrBrkuq.7uLHgkNGSyhFiSll7ioQzQ.GsL3Q3GcXP3X7OyyzFP3rGxdiEqQfsNDC
 XCT9uS14prnPvZuQk1vV5.5GBcvQHOxA8ODEVIzXBlHJ80.riSOw5XD5Zm3GoLZLD5hG7NWlxB4D
 tZiFA8q9ZbNueXMUEq1YGRqExMeNZyoJhEKKoKBmjTiMm1S6a4MQrI4CfjDldNZSW4YymewgBKDP
 QmZcoIKcGoOlfTFbNF5S1z9kZlh9vL_KBEjnlDAE6eJgWg4R55gJ3LNjxUQqs8nb_WvwHj5Psg9w
 Xsfqmh9KJQzsF8eq1wo06mEHkzSD91fHDBxMViCSfma63FpwOk5GjCvlXMT4-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Fri, 11 Jun 2021 00:28:05 +0000
Received: by kubenode560.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 03105bb17edb9375c7f9fde1dbc1d821;
          Fri, 11 Jun 2021 00:27:59 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH v27 21/25] audit: add support for non-syscall auxiliary records
Date:   Thu, 10 Jun 2021 17:04:31 -0700
Message-Id: <20210611000435.36398-22-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210611000435.36398-1-casey@schaufler-ca.com>
References: <20210611000435.36398-1-casey@schaufler-ca.com>
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
index 418a485af114..97cd7471e572 100644
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
@@ -552,6 +554,12 @@ static inline void audit_log_nfcfg(const char *name, u8 af,
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
index 23a85a470121..27ef690afd30 100644
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
index 67da23f6bebd..d4e061f95da8 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -925,11 +925,13 @@ static inline void audit_free_aux(struct audit_context *context)
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
@@ -965,7 +967,8 @@ int audit_alloc(struct task_struct *tsk)
 		return 0;
 	}
 
-	if (!(context = audit_alloc_context(state))) {
+	context = audit_alloc_context(state, GFP_KERNEL);
+	if (!context) {
 		kfree(key);
 		audit_log_lost("out of memory in audit_alloc");
 		return -ENOMEM;
@@ -977,8 +980,27 @@ int audit_alloc(struct task_struct *tsk)
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
@@ -989,6 +1011,7 @@ static inline void audit_free_context(struct audit_context *context)
 	audit_proctitle_free(context);
 	kfree(context);
 }
+EXPORT_SYMBOL(audit_free_context);
 
 static int audit_log_pid_context(struct audit_context *context, pid_t pid,
 				 kuid_t auid, kuid_t uid,
@@ -2210,7 +2233,7 @@ EXPORT_SYMBOL_GPL(__audit_inode_child);
 int auditsc_get_stamp(struct audit_context *ctx,
 		       struct timespec64 *t, unsigned int *serial)
 {
-	if (!ctx->in_syscall)
+	if (!ctx->in_syscall && !ctx->local)
 		return 0;
 	if (!ctx->serial)
 		ctx->serial = audit_serial();
-- 
2.29.2

