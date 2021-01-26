Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E1BC43381
	for <selinux@archiver.kernel.org>; Wed, 27 Jan 2021 07:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D31402073C
	for <selinux@archiver.kernel.org>; Wed, 27 Jan 2021 07:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S317803AbhA0AwL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 26 Jan 2021 19:52:11 -0500
Received: from sonic314-26.consmr.mail.ne1.yahoo.com ([66.163.189.152]:37159
        "EHLO sonic314-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390438AbhAZRSj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 26 Jan 2021 12:18:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1611681472; bh=t274PRuUJPpqSEMeAKlRR4jHEevTbSisO+Vq3gO+ZCk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=RR7BNwrKbtYFeYaIKWzb/KfLrWsHH/lmiiykiFfkGzQJDL9qgwB94cRm4bMBczU5vIcErM59mVntURyPv0Hp8iyONGtcp3wjoRCDo9adnWNNxsikrxJiCF9IljONYptRKXGKSXPLlzbxSM0Ry+ST8ytnwoXaY0Q5d/3EAAwofhuIxIA2nXE0yAMk6b7vbI0pz76LXNMYRYv4pLIXSpEBVOOD1VCEcYEMEk6gtU7FwUHbdCabSGi07ushiC3uSicEOKhC48N0LkXYtFq/ZyPP/Mgpm8mL6XofJf8lDTsV3E9kRx4ZOWLkQ4J6uSmVS7mJLPkkxC5WoyOPjcXIDLVa7Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1611681472; bh=iQpjyyHcGCIhcxRlLss+dc6qtYUPQjsV8g7Kv94OqJb=; h=From:To:Subject:Date:From:Subject:Reply-To; b=qSHuTQiSVUJLh/F7l2ZncNpIs3tdjQkxJVlOr2KcfyHwI1nqFaH9wmFiaZwpPmkcnygyengQNP2Py+GrVTl7LYcSgOA4IAMdEVV7330SfTDUO4uM+ukzue5WS4/AQ9Kk2kCltMQlBbsnC9WaTpsnD+jK3dW52ffHXYy3bWJAlOR788ZSe5AIuVwyxz+dsA60E03FNXZ+TtkvXMXYSv/00qmv5HZy+rFODliiWUpF28B7FLqPCW383s8H8TVMEfFXtHfr2LAdW8fcnQ5dabDyU8ZGwSzN4EUotluagh1B3vWR/3GiSUaiQMI7Sf/Hzy1qRojQpHT7C65z73oa7DcXSA==
X-YMail-OSG: D_8mL3EVM1mbhu0jczLqEnoNy5LJ6Q0SHNYnNlvaHLm9rwto_921ljSCGQEOYR9
 3tMMKG2AOu8BvOSHQLRD7.UyP.SMPHGBTc6bGH5tnswPruSCpjZCsR4vyP5buH3X7sdio0Ye2cql
 584O0c37R6RiyqkbM4NxcEiy1HkQvDidVxLICtfSgJfV0LZagK_f3a0dvMy0Bb2B1l7otwM7yL_k
 XLE8GZPBnSPCa0LbtWvB5up5ooBlDZ7i8bknYsDBcFYE9.5bNrRxu0fTaC790CRNF4khJR6vvSyl
 QYZYV73jjB2pjAcRmxvzB8h.fHP6iya0zagQ6LTkHdJicO99ZRDxbJIEXNX0.9GqTs53Kkvddap6
 Bzn_XXRBrqbAyTrUNoBO.5MVQVM728KXnFEKvaSIfrL3RgWRtBMq2mW38W6_UMKxhMGY.vn8eutD
 OODu_rpiP7E_GfrfC7GxVsljhP3Edpr8K60PaqCbjgKmgngRKrx9L8bWIIgIduATiyxbTQfnCdCQ
 _RwtXOFLpMNPsUFg61TrMEvnYUlRMrU4KyWSVYOSBxHYAGqKuRyQSZ0Es0Yj02CstG2rE6xqNeQz
 IKTX.CBgCphNDO2MY.mmqKmAbU8nkk._aBj0f5EyRxtQVZ4W607SRaLLoqI0zHqkDBiXtzWrRqqH
 h09u.XRswfQhqVOc2NHGTcgN5sTZqVhU9nqeRRudKVyrF9D.yf9htegqtRL6oyuFJlFW3uNioVbE
 sVmNdpxql3EBcBXFHt0W4IS2Yk8y6xI9bKp3wyIZmLVQhrp9_PJFaNL5D02FYuMRguR7GJqfNiim
 2CHdMEBB8LTN50aAfs09zUJHgZfi7Y1g0K3.TT8biZAy0SxitS15LeNZ7mNfeHczKtuHfqtD2nqm
 CN2HZ6dlIlnhyl913eYEgBIA7VwirYgzTgvW3SuxRf_f__vwyqHnmOViDBcYW6TUtCP.lRujrNj8
 53NGnG1IyD7DZyRGXAaGCywL.gYm8IZiraCXLpB8KInvditmgHZ47G.XbNeGDSJF6VwdDCJ9uxQa
 ppU2UvLSk.3hwhg_YDQUQ7DRlrIJBcqJwsl4oMFkX_yhXDffO7Cm.vaSpiFeMdeAvjnZsBXd4Pwz
 hPgFredi_9yMamNbUswKUYP38PyQ0mEH3.EjWJMDQ8LLdsY_trCP8N1jSD.yT6QlG0VebRTPNnwW
 n_qd8df_0KT8ns06ko19vrzi_T7aRXJyR0YrYYa.2LC6pNHsn5EXx9_.4aVhm.Ns7n8suKTnJbPQ
 oJgAFhf5xsgh7oVswxkUNxDv7FTNpaYJS84lyPs3HE8W4_O_.lI7MPewIavV4KKGvcYISqW1cpvK
 11mrOALHrEW_hPeDhj74BJXXhYJV.THDgG_YN7hZGrkc10QlCBsehBmirduLDdHlXEyG3.bxYCx4
 yNFbw3UDIAOXtWjWxko7KoWuMp5gFRerCPb4fWJkDAtb2WW4WvCzrrzTkF145IRYO8U9_U6eHaq.
 _Ci2gCBBSc0.XXgxENwT9NAlM3T1oWDyz00S0v_Q1KDh3tAdYCOew2bs4SgjnVfCxb32HVW9qzBa
 fSRJJ69UZzLdYWtAPSZYzNaW7oTMH4uWhXp9utCtSCMM9zB2xATXo9LfkEdsgAesKGNOpK0O4GAE
 _sLTkvV18rf0zwfaseCb7RFp75fo3zMlM38lzSEPENZNklX.k68Eu8GcGKiGNuKwwDGO4mrAnGx8
 RP3ipwgBWHeHj9IrMxZlGFbSjV4NLo.gFTECI5vjVaBX.w.kZfMmzSrDT.6K8gBSNK7ZWd9S57MI
 A556McMc2H91zcYbFtsNNbPkNK6Dm3HANEE3SjfZAqlOQ4OLHmk7oS2KwcCG_gksgVKxg7l5JHUw
 IavUN3eopSaSPUhL0dmXM.3m3vyFxE3KewXCA8qHvxcbxKnRt4SxoJ0ohAw8Vm28oejqB3QCSol7
 kIfWJOQxQOwPH2d2XBaMGvkTKo4fF57OTmBtG_auZk1s.vn2lriywxUMHjCVjyJPXaWeBNSl7OnF
 PrVjUqKscyEnzak1lYwLnkqF4DM8rMu3jsSUP9mBlfK_KZlV3ZLp_Kb4kgeqUocCZWqZeArBNxYK
 ZoF7AJQDGG4UBjtyP3OD4yTjD1_f82xXXWfyF2p9tI4Lf14r10D7qTZadqB0hZLNzBKoPVqr3FeY
 bvFiToeFxeUhIqDlTQCNWLY77w3vdBXuqwZM3_NeIH2odhaxLWkl7vs4K8mOR4hz31xys7a4hlTo
 zFjnw3_YZ_G5rzMSDOuysfyAzd53qTU_sVukR7f55ZPLDK5D4WCRKNeTxb4P7gYwN5.UnPK_HFhc
 HObnA8FTPXcST6ma5sCznbxusCZJ5wiHkP76yIkxJm9o6tKjouXAJpidTlZwKRyycFOXD2NVoxhD
 T40dIDGZRBVNRCIIUbfWAc9.a0dR2Re8ojcr3SF.Tt7CXfmm.s7IjcFWTAVmJC.j_btlDgDneZq4
 _ZpqWZc1ttsig8xn6MUJoVqRwcB87OO6cyKZJ82McIEPB2vvMU.5VY_tq9jOvdcX4oAbRezuFAUa
 Q9BO5ix2nD4Jc4XlJhI7uKtvZOWkp9GWaMkE.Y3_XbKhUm23PCAesYj4qknHdxx.QWbb2mJz2NEs
 jtlouPq905QMG_MeGJV_dwHeiax3MhJvU8TFqZD_v0is8sp8TY_j665LXZksGS6_WEYUJAtDYRo_
 xi2ei_T4eUwNtB15qmds8trTy2hQghOS5dO36ftCHIuyDABAGgz.6MsN42yWBbjYtp0PZ9P8HmtH
 UX.rgieSXlnrut_3YoI4j4qlCnLJH2hqGq2K7L_OOBZ_GbV0E3TvZJLNlz97z4ELzEm3pI4DxaRM
 VTTHWp73qkmRWFvT9o6lDS8ZD7jY42DUh_Gb3siV3KtNB1.FlC6MfNZEcNDZ9_2BjjDmGeZhQKve
 7qTMjNLKvf9MKSl4Ka9PvHwfJBPiJCgQU94MDZ3T4WIPbLLqsehnnGebphUQPoeMDBzq0B1pibzF
 TrI2F3LRoJ3zEa_jo1_Zi.Or4LEJOMO9P6VRII7CAV26NveNLqBjwC4JCwpzBJp5qD7xtP1MgReT
 OqO7bL1CLfjNjB0c4.3fEQyKshLTbtyPssshI7wYBKtErfuJg7NCpa0tXMuPA1f9xtpcdR5ZCYrq
 s_.zWVlC2zaCHx8trwTloMWZE4lgHJyiF3wbegQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Tue, 26 Jan 2021 17:17:52 +0000
Received: by smtp419.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 80a7e5fb8bfd1848cd008884d9f83c54;
          Tue, 26 Jan 2021 17:04:52 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH v24 21/25] audit: add support for non-syscall auxiliary records
Date:   Tue, 26 Jan 2021 08:41:04 -0800
Message-Id: <20210126164108.1958-22-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210126164108.1958-1-casey@schaufler-ca.com>
References: <20210126164108.1958-1-casey@schaufler-ca.com>
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
index de2b2ecb3aea..479b3933d788 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -927,11 +927,13 @@ static inline void audit_free_aux(struct audit_context *context)
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
@@ -2214,7 +2237,7 @@ EXPORT_SYMBOL_GPL(__audit_inode_child);
 int auditsc_get_stamp(struct audit_context *ctx,
 		       struct timespec64 *t, unsigned int *serial)
 {
-	if (!ctx->in_syscall)
+	if (!ctx->in_syscall && !ctx->local)
 		return 0;
 	if (!ctx->serial)
 		ctx->serial = audit_serial();
-- 
2.25.4

