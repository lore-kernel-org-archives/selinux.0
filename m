Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D284DC282DE
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 20:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ED9A2084B
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 20:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="KXzGxyJt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfDIUAW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 16:00:22 -0400
Received: from sonic304-28.consmr.mail.ne1.yahoo.com ([66.163.191.154]:40273
        "EHLO sonic304-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726832AbfDIUAU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 16:00:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554840017; bh=j+cuqymh91xxGIirxxPJDUSMb0L9mw21aX8dKstwmqI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=KXzGxyJtkkUZ0MoiREIrMSSi6xI+uq4CDK7iOUIlY50sGV1WBv1aQqj9enO6csCt13zbVkCR6Yo1i1x47QetNfGubrgJZuO2z4X9Af47xdKmxguq5Q0SakgXpAk3QuSLvJmh6noqYPE3hP2OO4LEl/lYKK58p3bemwC7Fuw6PmNvSuF/cH9cIIokdMobv56LvFYfongMRg9WJ5o/V+me899xT4uxiGMBCqmMRflOS1I0YRTEywZTOpi3W12NHEYavS4zhD+C/p0RXQ5F3IAvRK3NbfHiN1t39MifB1B2d8pP7g0zVEk8eOAIlGfH5GTkuWHjr+sW5oH9LImW0lp11Q==
X-YMail-OSG: yD6sXoQVM1ljSiW.U4FYihsE9MRkkJBdTk.YOXH_sUYkDumbezUzWIxLkahLAj0
 FF8S1yppCbFFgE9YryOni.Yl8tNXnW4Z6K9xAAAN9Ax0WYetMLSXzYqDBg7QEjS0fBGLo6lY.fP8
 sXO83sAGX_DCWoANcTy_h4ET83lUzvLWZANOd158lGuTKQoPKL3eDJWxbDws51NnUVCrzvKT2Ddj
 7HdNgQCDEnUcQYuAKtj4649mI7GAlhvNBiTqa0xZpjqfVSMHPLyFsYtq8fF2C1JkHGiDvxtustRC
 YoVxXR6BpzWxYqFh.vaFEfbvKpwEdCMbEY_waQQE7mUyS_2uSPCg0XwUCcEpMuaB14QmkMD92jst
 1URm_phDx1ZP_AzLIyf7RwKXSqckTXPh1klQ4ACbSWH1xYb3qBoAXtK025XEqFViNrE4ghXsf7Fr
 nw.MzioulL7numys4F9weDLjS6Ahs6h8wGkcOLox5Ib0qyc8TOpZZJklSONkxm5ipGwvz9lp9Fwn
 voRpIVqI_cL33jzeRlXiebPuQgaGku6g5FORTIj4JjDRvqBdeN0kI03PFL88fniFaQDfOsA7E3EU
 62os41ZqCejZ9fmvCEkm15YCQqFC37mluIU9M5boCTffYDfbfasdkUda_QgTwcY7NmFfwGvKbkfq
 gGYUuYEBgwUzs.QttkZ0wod9vR3spfG55OJbFcwZ_4bpn8jqgYaDOe7sWFFbMzLkwFFFJE1pHPtd
 RqCjA_QnGyJB9CjoxxwleT.ILeTuEvVZQpArPcTU7QIL3sz123h9PPL3XDVsJy_38DRMyuS8pKf_
 KTXp8_X4tXJOZXBMzuBHs_mAgSEcGwAlax8gGvDF7ycVIMlSInsBnLTLcd0u8hgwR7jhYRZvag1G
 1cKjo6C5V7V_hgMv0VRdygdmAD4_yEvswadv1fg34AttHc8W5o0rgwbdr1kwElIitPvsG36CxJQn
 hxZ1opjQFjygOKiPN8_x_PVKdvEWo0znwEn6_.iTzjhqBod0avyOYbYR29C0OvbCfooRJ9CYYaXQ
 _AAMDUCmWGhGIfgke43Uag0xBmQc7y6zNGf84EUGZ9u9EoBxjgdyU38Q.MYZTAL5ec6DMtKceL7H
 pUuxPyfnIj.96.HMJivJM1yPb8HjJhBaOGOfW4CEc14EpVAF744MCiHg5k8U-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 20:00:17 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp401.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 24fceb1ba198cd68afe9603a17bf6fc8;
          Tue, 09 Apr 2019 20:00:15 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 23/59] Audit: Change audit_sig_sid to audit_sig_lsm
Date:   Tue,  9 Apr 2019 12:58:48 -0700
Message-Id: <20190409195924.1509-24-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409195924.1509-1-casey@schaufler-ca.com>
References: <20190409195924.1509-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Remove lsm_export scaffolding around audit_sig_sid by
changing the u32 secid into an lsm_export structure named
audit_sig_lsm.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h |  7 +++++++
 kernel/audit.c           | 18 ++++++++----------
 kernel/audit.h           |  2 +-
 kernel/auditsc.c         |  3 +--
 4 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 40aa7b9f3c83..e76d7a9dbe50 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -93,6 +93,13 @@ static inline void lsm_export_init(struct lsm_export *l)
 	memset(l, 0, sizeof(*l));
 }
 
+static inline bool lsm_export_any(struct lsm_export *l)
+{
+	return (((l->flags & LSM_EXPORT_SELINUX) && l->selinux) ||
+		((l->flags & LSM_EXPORT_SMACK) && l->smack) ||
+		((l->flags & LSM_EXPORT_APPARMOR) && l->apparmor));
+}
+
 /**
  * lsm_export_secid - pull the useful secid out of a lsm_export
  * @data: the containing data structure
diff --git a/kernel/audit.c b/kernel/audit.c
index fa4c5544eb37..5226e2af9498 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -135,9 +135,9 @@ static u32	audit_backlog_limit = 64;
 static u32	audit_backlog_wait_time = AUDIT_BACKLOG_WAIT_TIME;
 
 /* The identity of the user shutting down the audit system. */
-kuid_t		audit_sig_uid = INVALID_UID;
-pid_t		audit_sig_pid = -1;
-u32		audit_sig_sid = 0;
+kuid_t			audit_sig_uid = INVALID_UID;
+pid_t			audit_sig_pid = -1;
+struct lsm_export	audit_sig_lsm;
 
 /* Records can be lost in several ways:
    0) [suppressed in audit_alloc]
@@ -1429,23 +1429,21 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 	}
 	case AUDIT_SIGNAL_INFO:
 		len = 0;
-		if (audit_sig_sid) {
-			struct lsm_export le;
-
-			lsm_export_to_all(&le, audit_sig_sid);
-			err = security_secid_to_secctx(&le, &ctx, &len);
+		if (lsm_export_any(&audit_sig_lsm)) {
+			err = security_secid_to_secctx(&audit_sig_lsm, &ctx,
+						       &len);
 			if (err)
 				return err;
 		}
 		sig_data = kmalloc(sizeof(*sig_data) + len, GFP_KERNEL);
 		if (!sig_data) {
-			if (audit_sig_sid)
+			if (lsm_export_any(&audit_sig_lsm))
 				security_release_secctx(ctx, len);
 			return -ENOMEM;
 		}
 		sig_data->uid = from_kuid(&init_user_ns, audit_sig_uid);
 		sig_data->pid = audit_sig_pid;
-		if (audit_sig_sid) {
+		if (lsm_export_any(&audit_sig_lsm)) {
 			memcpy(sig_data->ctx, ctx, len);
 			security_release_secctx(ctx, len);
 		}
diff --git a/kernel/audit.h b/kernel/audit.h
index 958d5b8fc1b3..64498850c52b 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -338,7 +338,7 @@ extern char *audit_unpack_string(void **bufp, size_t *remain, size_t len);
 
 extern pid_t audit_sig_pid;
 extern kuid_t audit_sig_uid;
-extern u32 audit_sig_sid;
+extern struct lsm_export audit_sig_lsm;
 
 extern int audit_filter(int msgtype, unsigned int listtype);
 
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 71daead619e5..41f540037a93 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2398,8 +2398,7 @@ int audit_signal_info(int sig, struct task_struct *t)
 			audit_sig_uid = auid;
 		else
 			audit_sig_uid = uid;
-		security_task_getsecid(current, &le);
-		lsm_export_secid(&le, &audit_sig_sid);
+		security_task_getsecid(current, &audit_sig_lsm);
 	}
 
 	if (!audit_signals || audit_dummy_context())
-- 
2.19.1

