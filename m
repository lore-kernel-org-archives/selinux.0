Return-Path: <SRS0=npki=DT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE71AC433E7
	for <selinux@archiver.kernel.org>; Mon, 12 Oct 2020 20:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 796B7208D5
	for <selinux@archiver.kernel.org>; Mon, 12 Oct 2020 20:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="rrSG+Egb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbgJLUk2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 12 Oct 2020 16:40:28 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:39386
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727115AbgJLUk2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 12 Oct 2020 16:40:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1602535227; bh=BB9A9aM9iZ70YoCNoFF6TEVAd4aubY3RFPDbjcohfQc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=rrSG+Egbj4glYJcDJldagtokVwezW5p2QwNrEEZ4jSd04HE079Exd3FFT59IZIF5lJ1yKlW5mwchhvyNruuFhLpWRnruGBAIdytt+rO47/IxhQXjJjSZ5i/lq8gVGUUC4DSm7Mcui+vMJj6fuMIlCGw3mDFaG96isiyqzJQXwrxvb1Zs2r6pqDkuP9IkBM7hZx29tb4AbbK+/pDnJ0R8Gv7VHlc2AG3+OBTJfyzBwwD/5u6AWHrLdfA+wGZQpVdDH0UMHB8fFrkD958l+IowQPAGFiPoAWlpod2midena/jHHKgDGA4EuoTy+th+1dCrPSK5cR0Pn5TwYLn82pN6zg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1602535227; bh=M7+o1VT58A0GNL+dw0MaBA2cleuxSaSAXT5MOj4VcTX=; h=From:To:Subject:Date; b=RkQRW8DIcqYzi9eZKe24MMRzX/u5mfMR+fQMySZh173nkl/P3/vMikzxecq57rX+xAUspTkzWfVx9mJm7sYHhJNQA0lJ6fwdH7dBypb/pQ51+gL2zmXgtIsNZBMb+XNp969p3k1was8mF9tmrWZXQLOyVpqxn3MT2kBpLeahqkbu3LfdB3asl+H6jp6Gq1lOKHYm+qMLx1GFuxr4yOo/d2IpqEqNb6mrFm7nH7BR4p7NsZaNPNZLYMSXfnygkCgM5BjdmSTDQOZYcVQyjMl2FEZjb6VckqRV9YIsbeQk/8NeyJVAyKeWEmoDfOIcwxkoQ3hiJYO51xB/o2riZVOdIA==
X-YMail-OSG: y9k.J5IVM1mA.UcUOeH8DRN9xyLk4ThXSQQ3JnX6XrtiWiZNEBwEYN3rtOf22Nn
 3Xvj81jy2Drs77qe8jFCIITvn1OyqYKV9B5IHmaGWN0Asy1JfbjDjzftBLOBrFw2urALofgf3CIR
 c_5sJTGPRdtRObu8c5_CVhy_4BCvuLEtJ4Vf1MXp1EfD63uJiiu7CYrxM5Nvu9HWQ82RDjMuf3qk
 RGcHN5Hhtuz6TUREKHX54CWoEf2LglSezMehS43MiEm3MJM.YnEwGnf9QDIa0GU4tUmK27uEqiCd
 ho.xahWKSxwB_rhoNUisy8fTkSUHHVvdCc94nl_a.KhHXcYeloYUYBqqEOZ9v6TaKjdaT8HWT3Wq
 aJbvqhvim2NejE1OOhrfWD6AiSiaCN2HviH6y8TUiVqjbw7ORpB0_PUr6d5W8QdNKcIp_TgzBmVL
 l08Tq6o.lRgaJt6zApNiHg5iMq44RUEI8khGIVs3kZ7i0kKEHZFG.k992Hq9C7xDaOVwVUe06WBN
 jmwRVNgqVnPyKHDoKjG48uDRcRnq.KT3QFig2BHHnmi4VipKE8bSkL8CZO03JczyV4OgI7m.p5pt
 vCspj8TZZO5DuNb7CRRvE1ZX6Hp384kG3dWdaolqdjyz2sOJJSr4Cw5R3QEUjvU4RTMjjZ16yROC
 6u8m9nWLXo7eMBbBQCHId6d_zMK1cFJfrGUR5_7mlqrGdqMePrwjJTj81_VJd8n3Ec_klwHhwYTn
 DavGKmrwk3wgCNLiV2K9LyB5nzrMyS63nL2H2gn85n3Qc9Az.Tl9XSqQz0vZRMS7kLsPtksAysrD
 ps32d_1FHKKyj7rRq.mt8aZo4U4zEiU1Po5PF.uq77HfieW9rlhW2CMvrtu.h.qVX7IXCbWzPMNL
 cmWS8bXvoA9SqUJnELR1A2bp9JNJ4AoQL8Lb7EdK1HFujCC7Zt861p_JcIanLXi75peaB665PGtu
 vprFZQ_3gJIwh4QRy8.1NRk7quaLMG4fE2sF8zeDihh7yydAHfErZSKIbkZ8KJRBs8gBZIVFaBTY
 kwcr8smUk5GycIbqOdunkCiIfRVpY0.3CHyqglAshiDUIhS_XOnpcXST.zRb95AVhzaM9AlYzq.5
 mgWbLU7HtgvJxDql0uTQnAHvgRxZsWgazo2vnYpe93X.PWf81AEq25mwL91b.JMK9eekW2bM8tNd
 L_eGjNKft6_DU1BVWZbeaFp2Jdhtg3EGBlXb_BtJc80SGsx29TqZsc2BdjHOW9NMeoTxcN2gcxmv
 ._cttIpIgxP_Zh2ifmipQNYhmyZWx3AGdpjyF66eMgrSMPN9S5N6h117hmTVbNcP9zQO1ved06dh
 UMR69e_YFte5XIUpOoG6zh3FURVg7uPEmP1Eue7gUN4mrnBfu500cyyn9Qgj7Or4tO6mv2eWogBA
 Fa7WK1J_j.UDO8whBSxXwDnEtHSw90r4QeZSJDK6e5GsftMeFmfmDiwdLb_7NCibXea2kLfJgH8f
 z6r0dTl8Vq22Rukd_cGpG1lgV9RIEPeUZNJqnyGBFPuQh9LTy1jzVNgBkQD5FOS3ZT087wxYJI0k
 2edDf9Zi5qmu.u0GcZNOATA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Mon, 12 Oct 2020 20:40:27 +0000
Received: by smtp412.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 584323082e603e317b583141f4b8e463;
          Mon, 12 Oct 2020 20:40:25 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH v21 19/23] audit: add support for non-syscall auxiliary records
Date:   Mon, 12 Oct 2020 13:19:20 -0700
Message-Id: <20201012201924.71463-20-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201012201924.71463-1-casey@schaufler-ca.com>
References: <20201012201924.71463-1-casey@schaufler-ca.com>
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
index ec0cfa7364cc..79454f1180ce 100644
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

