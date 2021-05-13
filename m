Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE365C433B4
	for <selinux@archiver.kernel.org>; Thu, 13 May 2021 20:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95FA561278
	for <selinux@archiver.kernel.org>; Thu, 13 May 2021 20:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbhEMUcm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 May 2021 16:32:42 -0400
Received: from sonic309-27.consmr.mail.ne1.yahoo.com ([66.163.184.153]:44145
        "EHLO sonic309-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232440AbhEMUcm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 May 2021 16:32:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1620937891; bh=7V2RZ/HRpW1AoAp/Iq1XcaU0GNuu+Wd9ZV/RFltAMkg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=kvydQvuLMkFVVs2B1sZrl6vJ0pa3oWS90EWe1BYnTxNjaKgNGqcrsfEXzzNiyaWKhiAmHD5RobjW3dMPm8rTV5wFS9bC42CRx4h1zxuVJjk/dvVmNYHrpjVkvxXXgFn4nGvwELlF68Fkp/T4D9KcG3Qzal2rHIOsoCDLD2t3CzOMxldUeALF1G7q5jB6UHKIHQr1tZVUAovuLNw9fqjthsfekBCHwa3nVWx5X2AyA5O3viU5lwPFdfHx6IJCRVNmp84jLYegnPsfAQ+8t3y8WCVIfSRl044ibggKQgYgBZVtlgWMpJOuyDMaAEz9e+N1j7m4zqTI242wc4Loc/BgIg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1620937891; bh=4N2u0Sp150XJ2GywJA+V6LxsXUu6t6ripev9snnstJ9=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=NRmIHenQe3wrWD1G6/boUMmSnRc6dvoAKZHsYIlMiRFGQKDDGDVvHGLLw0MsXKxnrqz3TxdTXyjIjc11iB8svCuRbTaxiXsJDE4xhWQUjwyAEsu075NsV+kMzJEbv9Kpvy6FjvoeVHDdVTgNsVrDf1xlpEIZxss10J6GRaMU/6+nxAtsudrece/jcDMkThp7WXtja9+BMWCa+fBCN+d57Z3bmorU7to5+2livS/eGyEjlKpH4O+K4jeH4jIHod2HIiVhFaSX2Cz1UUU7GmfX20Xxtcr/n8qo/CB3zmz7B8ZfPcDNRA7fY9Hsvy9BJufYrnjAn1jh/o/H7u0BKjSs2w==
X-YMail-OSG: kPJePJ0VM1mUFHUKIuV2NqtLmCMe99NBEJarxZ4Ex2o4LG9ojKrGw7egXG102wK
 48X6xkSg6GHM2RSIEy6B83jWWeUZ3mEMgaogBQuk9tw89WnCt4wyXpinoLlh4cVE4iePYp.exgbc
 CsXTV9zl87CAMVxQ645lkdnP1zW7tiqDiHIiQYa2fkh0oinq1lQygL5H5DNmXYPMsvWh15qfSL8h
 V9u_S1SrdsTjFK2P98VmJ8NVYFUwR_yNAqsibgw8qXStFuqmptvxABU3frvhCEBf_9jSnbq6QxwR
 EknFh123IUAZK0iHWQL.bh7v5FDJqSwxwn2idP45W._w7xuBqFRze9G3A9AH9mZXDCid.4BuFEcf
 HkXIb1TZJI8IKd2KGsfiXsaWLxkCxtrm2kNgN7Y_moBl2PLT9B3wZ68l7vv1nrihKVL9Q8vT_mRl
 RhMv1wBiF6D8hhgKED9msXWr2X7wutTxs5AVzoRyLwhPFNPD1H7Cm33sPwcr6iKuUQerH9uj0ww1
 vND8cvODQjm4glQCzczzOLqP7EB80Q4Knk4RXH6XG6huQXUc_xgsmoV7K39ubY_29.9u3D1ckHjH
 bVrmo.2rRVyRD0OhdTzAbU1PgwoQMXJC.lOZc8VMrNO31FN8KqnrD5MgcX8Hi9UUNJHxehk5yulH
 SgS0Gt4zQ4A5DbNlkNUr4JGGY2S2y9LdEnr2i1fbzSBP6QQArUHBZ2.PF.4kOVmyOX8zEA8ha8lZ
 lQQARlPrUKYU4wkaP6MiIEQx2ncXCiB6q__.Jsrj40hlmGyQ0swXv7PzOfMssiJWFiTLDa.Dqv.W
 vgV9xHOTN7dZLvuBABL_CO1HOEE9M44xPS3NDhFofrFQE7ChzDFP0Hz3b8QXczyV5mBnIEQj.M3I
 Wy6moQedJOgypeIE.DdiqpFaPCUwETVDFdf8ZS5RgiJ_9R9YriDzlTIXPMy7KFn2LhFr1v2f992f
 S6f6Une2r4o6W0mDbYFc.t3eOAUvlIUmnE7SAq55W2hGGaDFcnCP8otCq.gLD_b6m.eHgZ_RVcxX
 qWscaHyJyK2V7epy2gHJJdrtw9aVctoUMLHaZya5Sf3pWguZ6eCVEFyldq7w8chaf3mGCy_J0tno
 ycGl8jA4SuQZ2VQ.5YqnRi0oJjhnxAyUvDK7R.fXjJorlWXj6izl8kkUQi9nTTqdxtoV3MxYSX3Z
 hP9LXBwiao996LoB._fqU0Z0N8mDv0j.zToa5kfK_t.wHI4MMM_OmA07Jd5wMBHwi6_CLCAWExIH
 1ECKCs.R7hF5lDBWq6uvBWewemoTUo.LV2U_90rgTL8b64D6oQCirEdUTiXzNY5t7PNJTmPmOHdr
 eMVQdywBDRDg0ZmGcNxpZggKfqakR1627feCatiHpcV8XtMHEBx3EOIYT6QYmNhO6I1TgRuT5X2G
 Pg6dQQm5tIz1B01GbwYhAw5lIOrVAu_wTIsKj0KBwbBjrBCUdol2Eb.c7vdrskRBaRepLiZa7nAb
 ezE6Adt_OXe3g8vRIx0RNkD3ncSgDiBg.xOuT7sRJuGVI78UUxVqjfpPxU5tgAGL_6DNBMnSNmHo
 TVXBEeKBqqbK3Ko8mvhjLdon8KvVDwrhfk1DwgpOifckDU2BlM_1mwswaFt87aeFsPJ61oDWLOSA
 pY4ZxOwHzRZ7JSCtB3PV6TAAnmZ1tbZL0udh39JfUW1R.JHfcWuczgrzqbcOnnbKSzUTJx_akr3G
 xRapH6VVAht_zIdQqqLBUGVAuG5_mm4wtz_aWw99pclvP1ecvh5qT7QqaYxh.qlQAstXJwDY27Gd
 KEHx0poAC6vuqYzvnV43r2WXANJpIBbfJLLg7JJwAEv512JvmLxwJrUR8rM_pRxG0YCEcH3PWBHM
 JF1f7PflLptSbHN9vXSt7GMjOKvCCv8rqwUhzmNpPA_rCviffQ9a_4M7T0rpSfqqTnLFz48wgaFu
 y8mPhRFQ3M.tPG4jYZqWZdmDU5wE7tiW1Zje.9caVF18knodviuAyOusDuhvP7GZxkHK3_Vg6bIo
 vF0je1mHBw4FYispQHaO0V6Fzsi8wQ7jVncZ6AwMcblyaMtx69jFUL0J.KemRmQ4TtDTaMIKic3n
 TGVywiRje8xXf1mFl9Om4O.nODlnOyVtme92tsHnnofGU8d5dyon5UuNMX3jhVduyxJdLnDQdB8_
 vMMv7e5G19QM7ewwkRgJdOaf6Svd3yHjFkLSluhlPk9deXrZlqnlaW2JUWxLRI0Tc6WQvpIa0oI4
 hpttd2xVN4593NKvBvg2k2tvAnf9mAPphDpM2Nm_tzEcnHo_49yKeJTQ.ZV9trhDWJ604XEh9PFa
 .aiWIWwd.5VXxQr5ohc1cw8ufxJneJUIVmsm4.uh.sN7ZQXaRPTP3hN0E1jIpXDVZMA2sHKrpznT
 A5Utr9D4PZSXVHO1CSHIg8RbYSFPnRa.rTUt08rluZdcLvIIYW8Msfq1nJK26Pl0DccPc5puE.NP
 UZ4f7mYYxRlQ8gQgzQfEuQGSPPOQUa_jngjBr040CJ6guzlM6fu7.pN7cM20PKskiBg1zScXV.Vr
 XoIhGaG.T1gzNLVpjon6b0B08zGH8fDWSX4EWiNbdvZobxT6gjQtTIjbGYw3XRfvMEW3C2xMyMDv
 95sYtGK36XE39qhP6yAp8dtp68jWoThrUcLP_joFV6tcI.YwWDVIOtqNHFYS9j3AY.7CX0KpQfFC
 HefRT0C2j6m3g3otxXybGr99MH0IBYacuUBh1FoMZolwiDAK4_tXaQMyc754QhaHJ7mzzK3RftKr
 UsGV4OdGSIllU3sJ37nPmWZbCnTOQPUu1Cws.us5mYzXcoTA1xHL_KG8_ozuVi7gZmx03T2RxeNI
 fjcmJzj9RqPDBL8CSGdOa0rBPgHmdvQx1n4Lbox1TPd_3Itadj2hElXQcXlwlaY4D75NRB.85LwX
 pnD8xgSxNa5RJv89Y0CIdNvpvjcCUcI8OQoDG6s84S4pQIKJ6p3bFZmnFuKXAFgBobaaVzHC8Ayx
 g4hXWx_BRRZKF9VbHVx.uZZ2NgzEhgYkQYonlobuG8EoVpnNR_U_iWZtOFP6WmYFIle.0cRROFb4
 3Lv6Z9QPYtYz1vSz4hnmaxBMu0FO6oF3QTUHRpcZrd2r1aPvGMZQj181BB5bBjlR80WXybd8oBai
 MnckoBtVjTQXPYWubpFlBv4CGaD8WsivYA34zSU1SoRFUG9VpGVMQqayy_o4-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Thu, 13 May 2021 20:31:31 +0000
Received: by kubenode547.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID d32d99f643fa23047b61ede1e4e08778;
          Thu, 13 May 2021 20:31:27 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH v26 21/25] audit: add support for non-syscall auxiliary records
Date:   Thu, 13 May 2021 13:08:03 -0700
Message-Id: <20210513200807.15910-22-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210513200807.15910-1-casey@schaufler-ca.com>
References: <20210513200807.15910-1-casey@schaufler-ca.com>
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

