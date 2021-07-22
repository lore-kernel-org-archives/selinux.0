Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95096C6377B
	for <selinux@archiver.kernel.org>; Thu, 22 Jul 2021 01:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ED6C61249
	for <selinux@archiver.kernel.org>; Thu, 22 Jul 2021 01:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhGVAat (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 21 Jul 2021 20:30:49 -0400
Received: from sonic313-16.consmr.mail.ne1.yahoo.com ([66.163.185.39]:35359
        "EHLO sonic313-16.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229621AbhGVAat (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 21 Jul 2021 20:30:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1626916285; bh=Ncs9h5aFS121GKJa6zcxI6BEv7GaAhOBBGhS26B5l5c=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=NOvQ3KfFQv4Ajz26Xl1giErfa3982ByhvIvS+e8U4Tx/DMmmK4N64cn/s0ETx5N7EVBoXTcHHxwjoUBbVi4i17nYHEoelOf8BqS1NJ68YSvOSsg5ty5YZDI7mM7PBPnh0bxyB1RgOtNGTOSabW12bsMjrbt3eV1Vqw/5XNeD8i8w+YbsUpx2WuSdqv3Of/imvrw+l1/AN/SN6du9UbEAZ+VINDekbeTxnmtkqRwTk+eD/fmabjX75c30WiZzStHNEF5wtZZaT29AgOLqyne9iVL7ylprF7NNlPoB2Rvl3CY5ja0puHokrkyBMXVKez9BX9FTFSEoejIgXG+eYvycnw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1626916285; bh=7shhavg4/Os/Efin+6R4D17JPUm8em/trug5cJtzxel=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=nmiapQ4bRm6+o2zv1qBvMPOwcbtxxTif2URrEtgzdKwSrJ5FPqVcZkjwB9M0BJ+Yvp1lNSZpSdvA4j7thzT8GRCZQ7hMrf2CBpH1mTjlaymJvcqw8l7vyPIjqMNnBNPa9XSR2bGRgqUSsxKJkFa7cEyxc9bCaJ/q+1CGyGIQNiSU/cLVmX7bBxiiU7LuQCSZ6BP9D5ngiF5Ck5eWy3z4ZmW9oEdaljIr1y7vCzywxZl5twLg8FpKG4O22XymniG9INtASFfbcTDwkhBehn1KtfC89imfazB4mPkfoCQ0pL9Kco7g7pUlo3rzL1pWuFi/PafN3G2ny7ZWfMMVdwFjhg==
X-YMail-OSG: qIowusEVM1m0XKrbcFg0NDIadfEzgD5ZH_E3DCy8icK4O.OSutkusc28NEWHKex
 SeKZt7l_ySElzWqZSkVztB79eTYONw4r9i2iQjJCt0egDGJJ1jTG_LaAieXPa1pBcwrzJFRMW3QK
 4IV8Nl5oU6asc.YqWhvOgNcj8XdXGouQ_WSj8JVrnpmZxG6PLXUgDGd7Sc3s1rmXNj8U0MEodoLG
 i0xpwxx.Bb2lHx4auFmFzAhVUDYRsyh3dcZyBwymROPxjG6SPjisQRJ.17nVV8f.R.P4VNQ4GOBi
 H_8RScx5dFFtOXqi486e3WKt6RhXbMode.kzR1ByTWAgKfGdgVGOsq6TfHD6FOwKM0rU5trxbnnW
 hD9PiEQcqTk6Sbqz.EsdyV487w.gQV2IuOg33YqwXYBQHxq8Fq.SiGUD49GSgr2zpzadJSiMJD7N
 ocNkqzpF7vEzQLOg6i7s4Pu1eW9y2a3Yj_rSsNwHs6GaxoznNKOh81T0p20hHxZZr2nowZdEIhxh
 Uue2h_Sy66aMNttJJhdU5_4ZnejdvaY43YG1BKpAnaUf4qyUxCwd63fReML0V5bANVr9P8W3p8.n
 H8Otz68n7wIZo5FONVm76OPWhfSAr4LSv.V70B_DBaRGR7xagV1Hop9t2d3I6uWegPDpuksWANvq
 9eDmOgqEJjmpBj6gS5jNieYKsGbeK9fnH4oTZjsskuUxCY7qIUyhp._kRK_HoiZ1fQQl855Skcv8
 luQpDjiv8mi2mmliJ8qH2bAnNgSAtYn1HRwpOf..M50NEUVHdzlSLTZJdBhZVcZrcL.8guKOBpzW
 WmoPdfGBPXIViFTu6288tCJYiPQXwxdNrgamynEbLnFzxV890Vo7VCqEl5WY8lvWRZLS8wkjW0vk
 Oc8SUi3lMzbjy5yiiIccIOWV5HX0L_n1G8BHrZHQ6LGS7AYzRbadm_97KT1zA.5zEQOE5FTiJqfx
 _zXmFLXgT64UJbsfj7Uw.H246Igk4RTfzbctP64i9rlmJ_zGgMsgt6xULo0bAzw1AYqwC86zHhiK
 08sRVEqWhTfBuRhS4HCBS.2.qwXB3QWrxiiLfQlhAYLuD3l_9RQVI.zf4JIZHdN8udFPvG4ZxZMI
 KZtEe9lZEaCQQDVuvsgWHQ593.c0U3ibmtyeQ1S0wVrCghRdaxmXc.mJ40evK24cV_5YhFiuUbsl
 moGuFeGYgKKxumGcegVGO2_zHqw3VTlfLT.NDdEudHMdiR4LMkK6LO5jauCIVEkwCZXHJzrlHj_v
 _Na6JB6StXVMopaIKGnYi8m.RLwba7vdp.bkZn94UWw0znyhCmvg6fBYkQajcWouJ6q_ANzLp9kr
 twfmWqa5EhfPomveS.ok1J2qZ7uJxtGEl7t62zXGGDZxjRmnvLkLW2_Bd8TTxU7RQeU.XUmVhyyO
 YTGaJ12T447X42qL3XDD0b5B74H94GGJ8tDsjsTm8FV7N0OZRBuXN5ypvXvJh8hWo697NgH1xmaP
 C_Cxyta36MouEwmanYIGM8v4Hr10Mhg4x1AFFC.AyInRC0lj1cGpyNj1QBt_xikel.fIZtE1AzHV
 bljByPGe3GOHTE5HIZG_sJlwa3PV2JztQm_v3xscXY4vIi85ODy8N5SFxaqc3TgAWFHj6KBzVxmm
 qgRS02PViIWolB8Cy800KZU4wRzPPkjwy9p8NxoHdmdwLArM7Ylj4HgUDeU3RlEXUFKu15BbxXKx
 z3j11W6MuSrNa.JrABcx54Pv9lcLGosB4iTGAHl8Cr0.yArU7egzG92lr88PfQ.uj1ObYRERf95.
 Sl1x32k4uip8HuqUjAfB.RZU8mecHQsp3swiQ9kDc2y_CWu5MWkXsXMdbcc4HQj3ugDwcwSYcUPW
 TOHKK0ADhMNIbIa6QYpw_k5IMtRShj7ztkW_SImZrU1o6N.2dn3qlbgFB0p6Qjf1ah10fuf5.dQ3
 EHABZvP4hCiPDcgugLBVXyhY3tivrP3HCJ_jx.ewiR1Wvqc47dXkmvCN_qyHm..CRVvjzrrhEO8_
 3d9x8D.zmpUNZfqBYU_3mQ_3VCJSBrsMphhAJ4h6M0BT1lw2JKGJ5058bxSblvPzGxYnpqNzZhkH
 IlIT5_oJ8JCgkJWy1FK55JWXMyQkT9T8HD94BPSIz1kN_E3dhVVWK9A1c5FqE65ilxf7BCLY8.qs
 Dsfieej7C3Lvle0K.a3lbY.qt6d90tT4KQCGklE0HWrIvjbg9pKjv9XTzPzSnnOtIa9aK_N3s5Qf
 F.iFKQY3RdPa7B6hbJWuYQJCIvG.4KEAsiP09wdONR9WS_K9affVyi7yj9qRCgKfgF65KQPS79TK
 WT8W83otDkwKBce5uDc1sSVAG1wIo6x7_Le7LJyp6U2qTwoEgF3UQKeRShzDlFuGZU2kjiZv18b_
 azHUxIjQl4izTIxas3eaF1Tezt0A5lunCxpJ76nJx.tKQ41Ja1PLbu2Sp8M3tjR3OwuEwGKRctUq
 j39QH6L4.72x2mEqjXYFOUyzVYLvIb70UzwwEb9BHmeswyXkbbluQSw5E_fugM2nrykG_ll.Fdzd
 iISgFWcBa272h6aDPiyyhPzBQSblYoa2ztWwIAGUayHLVOY1o.pajlsqYho2UZ93BT8BuD20CqUP
 2eID0Ot.iuyOFMBhqh_70QSgXkJxSNkktNOPyzYjMnuEN0khSig7eOvJlbayymbbdrOn_e8sKWMp
 LRBpgQUI2U8mB1pBbZxnpJB9qfqNvou2dRMVqmZGOzmsSnddTwEE2PX5SLdAohMl5nIAEeqnYWuZ
 uumzorYWnDg02qLJMZUgE.kc1ki0rVyPL1kI22HTdcdTijvuZmRO6I12ZJDreTJOPU11C.fEq4Bn
 li5ZK_xGD2bbBQlysj5B_G2bZXtMD_k_iphn6uHby8KKNGHehpQz7qYyXux7.9Im6cIcaGX2LnVi
 _VHmcExf6VOvWn1A9jKAC5AsThwBsJxIY19LkJaQI.Fx1zlrJ9zoEUU1cdo814jKRK0XYXCO7q_h
 7naPQWWFQA26ndFv5cNzH0yjwn7ac6Dj4gY3Q0B_EdFPr.c3ODHmf0IjSqaaqwcsrfInZ3uHXmWc
 8nrMKT_d_qV.FT1qQq1ivDINPlMZF8S6HtLcNipw5aBNkEBLO0I7EV9MXUuJz_Z5YQuNwf9LmCbg
 rkndtRkP7lMNRf99XMYn3fR9.mN51eqNBUoGnlU6IiTvN
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Thu, 22 Jul 2021 01:11:25 +0000
Received: by kubenode532.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 31c47ade2e21ad1695861294f7cf99bc;
          Thu, 22 Jul 2021 01:11:19 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH v28 21/25] audit: support non-syscall auxiliary records
Date:   Wed, 21 Jul 2021 17:47:54 -0700
Message-Id: <20210722004758.12371-22-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210722004758.12371-1-casey@schaufler-ca.com>
References: <20210722004758.12371-1-casey@schaufler-ca.com>
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

Acked-by: Paul Moore <paul@paul-moore.com>
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
index b679517a3030..ddc1a69edc79 100644
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
index d198f307a4d8..0e58a3ab56f5 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -931,11 +931,13 @@ static inline void audit_free_aux(struct audit_context *context)
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
@@ -971,7 +973,8 @@ int audit_alloc(struct task_struct *tsk)
 		return 0;
 	}
 
-	if (!(context = audit_alloc_context(state))) {
+	context = audit_alloc_context(state, GFP_KERNEL);
+	if (!context) {
 		kfree(key);
 		audit_log_lost("out of memory in audit_alloc");
 		return -ENOMEM;
@@ -983,8 +986,27 @@ int audit_alloc(struct task_struct *tsk)
 	return 0;
 }
 
-static inline void audit_free_context(struct audit_context *context)
+struct audit_context *audit_alloc_local(gfp_t gfpflags)
 {
+	struct audit_context *context = NULL;
+
+	context = audit_alloc_context(AUDIT_STATE_BUILD, gfpflags);
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
@@ -995,6 +1017,7 @@ static inline void audit_free_context(struct audit_context *context)
 	audit_proctitle_free(context);
 	kfree(context);
 }
+EXPORT_SYMBOL(audit_free_context);
 
 static int audit_log_pid_context(struct audit_context *context, pid_t pid,
 				 kuid_t auid, kuid_t uid,
@@ -2223,7 +2246,7 @@ EXPORT_SYMBOL_GPL(__audit_inode_child);
 int auditsc_get_stamp(struct audit_context *ctx,
 		       struct timespec64 *t, unsigned int *serial)
 {
-	if (!ctx->in_syscall)
+	if (!ctx->in_syscall && !ctx->local)
 		return 0;
 	if (!ctx->serial)
 		ctx->serial = audit_serial();
-- 
2.31.1

