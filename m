Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F289DC433E6
	for <selinux@archiver.kernel.org>; Tue,  9 Mar 2021 15:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC97E65279
	for <selinux@archiver.kernel.org>; Tue,  9 Mar 2021 15:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbhCIPGc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Mar 2021 10:06:32 -0500
Received: from sonic309-26.consmr.mail.ne1.yahoo.com ([66.163.184.152]:44085
        "EHLO sonic309-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231816AbhCIPGR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Mar 2021 10:06:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1615302376; bh=TxxkSM81ZezArD9sVD2hoKVuJuvsNBpvOjm6apRSzaQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=sdWClzC4jYLI4mgcJnabTC076rsmBUoTcknuKVSjIFjlYB7ZH2myvVWU/RgkLXfvgnSY4LrRASZPJB24WvGqvj2TINtByaZ9xrck2qOdKY/AsFZ4ZsvzJzH3zCnnKUSJsw120rgC97IxRebdGwC2pGPkD642xMlrJaU8MgZo8H9lrizrHCRazER89UV+M3hnNX3ikoGE+Zz9QR6sE2FomIDVWdepkxLJDuzq6gt0QYCVY30y4OGwta9+U3CA7ah/hiI8/GXz9J1kvoEun6r03oUiSa9f5BENVl5XkHUwrmVXWs3bZOpu8N8+lrCSOsJWttqmz2B9rHv+n+k8JEkvxQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1615302376; bh=b2ogy89he/FMha1ep/xaAwy3UMDvA1y+ht1KeX4SwuT=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=cVQzljz3ipe58kOjYH/6RU9BvBy3cO785rYbBw0oRXjLdzOvvm22jWkm1aAlJ8QAL8zedPmVDOjetBzLH2/pP12dwBy0iMe+NBHcz6xLaNGiOQjf5EjMiGMcIUCGIhQStmshk3MPh8fzlE/cJcJgS39ddrRC3jnhGPpQfwmm1ZiJSah7YmumSzCFGsOrwIVbTwVO24GMOkuk+2KSHP0Ux5w7cksUC90NDe1Ta64DhuIy8+RPBKdPN/1VaI7TauNuKh77ygpoF6j9THP+3jg9JQkZ/aOS0jyzY89yroN34bgNal3QgoRhVJPw3IkMpVbsMJHLIwiHV80ES4ulTap7bw==
X-YMail-OSG: 9PDwTAIVM1nQCPXPhBPIvk_VK_.co1ePCaaNm94JANFgL.M5pfB8VpCuLqyHIfK
 NelvJOSiPUMuEreJ_2qWBZJflHr18Hc.1vzZk8R6WPNBrACG.KB0SMquezXN3k5FaH8dioHvmwmv
 lcqV2e7K32GF5ZwF4KrveFjOpFc8fctbe_WOCE_9h3huypuegMdaleXzgKY4myGnHJQM_OEj4j91
 cluGt9K0W4ARwBJ1pZwaUXQhlACtvbDq8N40Zamm08M8kO3Ewcjx9N5EA7m9322O6iTRnlnhQt5a
 69naLO8TTD4W.CSUH0m3k.DPk07e.xOq9X9s.GcWmD0iML1yfdy27PrgpOg4vuLoiXYgCYiWOzpZ
 IgTTocXZjPBOvULPjO2xV4WbpqLrVkG71htE.SIRwDYwBlmUB7e6CyfvR2l7pXmQ2HG56ms_YTCY
 MKhFmlbjfFA9hpSoetIGZe5U0Za0IKQLvYE.eZcT233ZXDIooeSBjwWLb5W9TYHf5G5KavZbYTwD
 LDkGO1tcccsKE_bfflIjkkVY40iCdhZra0I_oQhUAmhxmwL8Vn2I1.l8mzt4YgTb0ivTlRZkRpNU
 aZCEJuwOT.oY.PbLR_1fYVpXApgMwL1S8c_V.o.IIPKv27S4WNubxz15qTZ_c2mzNAAUD_vcQiMI
 D5XjP6CJuG4KuRD6U2ohcV1t0s1k9GDXaWy.jRfp4Q0AdduxnIWzLY2LBTRquDzTqd6OTg94SO6x
 A97L6UTIlo9820UblpF_k_qjibOycZHiWzFRLWchfb5Dxoj3q0llIm0tT54JEOLRFVOZq76S.La.
 ZAu8FjnFILchMP1ap0ekhake9O7hODqO_hbSU6Tvh7TZff7expE4LQxun_kBU7nXIvNz7nAGC5hc
 r9XZquUsGmSJXrbfz3bJYfTNZWJ1ZdtdthpAt6AU7SnoTKq9E3c1vuid7s3sQxbuREI9C3t2TLVZ
 DWjVlqpANM7vN7T6yVQusPe_fkfzlqrZV_mbO5sxqp.9qDOqb6nq0lOXsQUY98XR6UdRR0e.I_UY
 7DqkzHTb7egkIJz7de7nAqntyrGt1N0BJdxjltk_8192EXsKUaBhhsDc15qTIK9Gow5hUpyjXfE6
 kGhkoY9nl8hS919PANi2OiKx92bNim5val7cp7rgmjfGS666H8IHE1uK0E5zsOYZ_wu4XKeeBNYD
 EjHkxaXBuF2IewDAGXJZrDHE7CBL1aF3tzzHBX0awL1Jo9PNV5EoqxgtKByXINDE2_8mLsADiPZv
 U72.xo7xNPQYR6zpw1KCyFcICJloYZ23KDoexPWZa_8m7dCU5N.ZC2CYLfYeZL_1bRu.W8rN0ocZ
 Qi3y889FMviGW7mGGyepEMJr6eSf2YjtUX2ONDrTkzwEP7QnnIcoCRNl3GRX0QtSSrK2k378Z5e4
 qG.PRw9PxE2yVfnUidf0hsY9hHl5BzH9dEvTNn6JfYXURvh81uUFY77yDnMdYz6j42KjMkDvHZsK
 lm7tp0GnmGx8RF2EqNYyzGoBa07dpRQGmo7on3ENC2gZIDtRuHqEa_FAtzlf8jiuszBWyA4SLLQI
 VoFqcZpjqFhKMdpVf1ParQDeFPEvPdliWfPZ_bBWc3IlDLJ.N003n6sFbW9_PRGF.J3RV7HHwunH
 F_fKOWtn7NiyfG_Lpr6.vIOWMW6J0nRc8uzEYaAhY4X5v4bEKBqb7Xmhh.z2JmQlOZZLHtud6xek
 2OXLonHJfvqqoK.XP..mM_KyzqTOyNuwL0UClX_olA4E4WeV2pibKYaMm_hKwtPKG5Mq3oOLLkeN
 SuY6_WzwUXDO3OXj3TxGALQt4Cdq1bBA9efpnWC.Q2NLSUXgms54zUW0U_RgF2dGcjd4gYV2VTdP
 ARMN3scxXxG8MJ_qKzukXorS2Zbji9sogJ_Xo1qNULdtqKdYso4TvJ5wUQQsUjv1JiMdV9MG9j4F
 oYeWDGSUw4SAFkhvQHS85GRFEW6Xl5FsGIusJSsvyh08y027yLVv0KisZypI2tcygrVqyH_BmUaY
 VXHFK0xKRhS91hJn9NW.B_vqme3aRx4qrkAXQo1AsU1hR_kz9AhHBHylAfNA0Cip2P0Ybx9T8wS1
 RiNlfqr31MVy_dVcZvSWauWGa1CSbVtT8xIk6JfFoOy7CDVT_RPBBnkiWwAOd3a6kzTMU5z1MS4G
 CXJeXEKFXxEAAAfhyUXGyKO0Kk_UF4PzoXWWKUC_7UmN1N02RelQl0kiNpksHdE8faWNjCvnE9ym
 suWd4N3o0yhW2kdKFjtYY7Tm1CK4PMyzB0mkkoOuzk.VR6vrcr1W.UasTaUxCmEpwO3VxYirV2Sx
 vl74reLd09mnGUfJvViilZx7ssixV5gYZxhUb5P0SpEh9u4cbR0.Jv8cZmAYbOe0amqHwqum7ZMZ
 mELpaJADe.nth.nwQzKr0j6tOASfFW_F3_r0OeH9xCG5GH3lPbFG.z2_HmNo7fy3b9.VEmbncAoA
 UpcS2X1ZfKZNWWPvCtbLxIuLB4R5D4bZ1fJE3vKdHWGAvz4Q9w6mOGWC7lQPrVR1zEo5Yc5avTm5
 i2kaZ3BvROhXkfU9QjtxK9INtb4yiXE8bSMXXThjL._CuAIcpGapi_rzzp1vQeWDcvovHp_4GpgS
 T5qZZswPbYLhZDYztxApGAvV0oSELx8YY7tCALekfR.GOM1FyGYgW5pFDZL75jRKWVumHTY0GuW3
 n1nbrCkAK6UcbeUdHE7m7iocGHX301sEY_EzqbOYU6ny_AUPlUZD_T4dJeodTr6YsHFJhtMAb_gF
 D2R7aLrC3535kR164Vwc9Cb6nafDPsRWfwZkaMXp9GxT0bjEES7vMEiDEE41BY8f3RKMquua_JVB
 lV5phNTWn9BCzWKYfay6jknILPTFXPrjPQ3azAU1rMhx4a2J.1IV9IY91dGeaJVwwVIcstSeTmeX
 mh3qU_eWa9b6gLFRrzQjpWhLYL.2mve7dE.lmkPa1EkSwT9C_iZB4kYGQ209mOTIbGcIBTqSDD.H
 Q1_L8ZDLyB5sstz.uaKR_r8h_irUTNp6yDzGsGUejgl60lFG12KDCMKNjM32ghzsmr7OSyBfRrgG
 jlRVHetUrIAHjnanfeHwqAij6BHduqWBxQNKKRbRT6YAW_ASq8lbWAK4MBZzF1nVyde6cLwKF8YS
 vv.SfNJAtVwofLk99eOI_TO8d0q2_zFL653eDhZsqeDzLtEA4Y2szOWTs6gfmUEP7
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Mar 2021 15:06:16 +0000
Received: by smtp408.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 1727b5f267b5a9050c270c01787a4afe;
          Tue, 09 Mar 2021 15:06:11 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH v25 21/25] audit: add support for non-syscall auxiliary records
Date:   Tue,  9 Mar 2021 06:42:39 -0800
Message-Id: <20210309144243.12519-22-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210309144243.12519-1-casey@schaufler-ca.com>
References: <20210309144243.12519-1-casey@schaufler-ca.com>
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
index 3db1ec97720e..8994d4f4672e 100644
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
2.29.2

