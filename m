Return-Path: <SRS0=ovs9=T7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1E0C28CC4
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13FD426FE4
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="SMamQGTG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfEaXNn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 May 2019 19:13:43 -0400
Received: from sonic303-9.consmr.mail.bf2.yahoo.com ([74.6.131.48]:36021 "EHLO
        sonic303-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726666AbfEaXNn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 May 2019 19:13:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559344421; bh=j+cuqymh91xxGIirxxPJDUSMb0L9mw21aX8dKstwmqI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=SMamQGTG9qChc7CbmwsVbhw5oUSGPa4BXrqgSGVLNhj6IMzQuhJuTyxkm1Y0xolKNVf3XHj0RFczDYmTvWxYoDbFMmUqeWQh0p637yFaDagq+PZXkJVk9lY1upPPx/ItyLNRiYIracSVCjLNqYhOAoQWr1dL9e4c12CWbhbXYYj29d6Zjfs190mE8pfUNjS1fSDh+bNSn0Mzd42M1RrBF9v8J4xa+RJCipTMyE1wsm9fInXmoeuUqwZeHxwDyzrT9iFpXFTeLu3wQMNg2MVdPKIY6W4vFYRidf7Do5ShsF1Jx3/s2rVLWKgMAjF6Gms/OzXQuV7zT8/GezmSpkCPJw==
X-YMail-OSG: Vl6wPfIVM1kTOcGLGcQ3CpTSOdAMdgPNJ9S8yHevbXsr7JV1sH9K24aeo9djGUV
 Yz6GQVgA.RXK64b1kq1_wqyeBuzHKOzk.DBdbrL9ScTg0mIeS9r8nDCw0qVAyrM0F7_jZoKS3hS_
 hjmkScw0m0nDfy7HzAAiDG8496i2aHGEx1Lu1HYudPOauRAbEn8hX7UtPdY7cxmkaiDagsdxXFjS
 3agBR7AVzBPdLfQ5FwODobvY_SCRxF1xC8AF5xHLnHMPPiU49mLgyuxY4cPye2GQe6InCekyhwVr
 NVU7jKQ8O9osMXrEQvFgOk6LkgkrUX8.N7RCgjTiAgRHVwHllKo6qByxLUyGEvXI5S.EDPpvMfdD
 iTGRc2SbMw2NqI55kDlO93iemeGzRnX26O1ZG7w9A8SENYFMk5o9BlTeCwx3DvWnbtVUHsjUyeND
 YYZPzyfiyIG6aKL13mtywq77_8sZTh1.swVzT1xgNWmHLq.D3.fAhRwkS2wtVeRwKcdEaF78sozM
 7AyRaLMaw6U.RE_GJTPlTxVKC.hJ2myeDNYcgB1DZ2BQ7Zbh11JgL1XsYz6sKRS3p7xa_MBRN7KL
 QQmTw6iwBeMbdagRB3yLK3E7l7CMQ7hkYgwcFTSs3UClkdy_LCrCpP4U1V9nO25uuIXlGSTjKFC6
 bVMkYseyBra2g4OCFbj4BC4SHDjVMdSWCcvMqEBlJIDBQIdPNu3E1n5WYf20xAInTDscExgxAywn
 iV7rCfj8ZqqhF6BYcNdG.Knt5ZbAiEAkyqGj0qovUPYbBEiVOw49CV3xUXp3iuLtHRo4igzXPfze
 .CPWYoLulWvFIb72n0s9FuADIhB9vhjeObF7LGycH8cIX7rJiaQaqy4IJka54Pft.x4eV_GJ3Rmu
 BuDKsRo1pLxZwTSOCfQ2piatY0209NSdsZmnE3w_JasapXRuy327X3eS3zHmU6TcUyhT9NuOI5v4
 qQGQNqPaWsaFqpydKV.mmPECwwFs52P9Tn8YJsg9hWRzfE4P7EyAeX4lDewqvOYOfVfPf17FYTc9
 YOCDIz2qNm8Abky8L_04czkXTuljJYqq_NZKJNnFUau9K.YppPLXvglZoEArT_7LChMh8u11ss2v
 GrcPnkMkX73mRZOCvmdrj.4Q..mHB3kKen9pv0vECKypZRhi14wwSGzcjiNsl1hk0m36i3PHMQ9h
 nJAXUvUAjBXArb3j9LM65UGfonD6XMP_qNbj0v9x7lRjTDnOtYqos67wHzegmRITrPtNSI3lX3b9
 WUdVMaaHL7WqazusmFSOzK8VS6pS2_1d0YfrB_UTXZh65SR9e2cAzQvUv4w--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.bf2.yahoo.com with HTTP; Fri, 31 May 2019 23:13:41 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([73.223.4.185])
          by smtp427.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID f1f4781a1c1cfce2dfc25044e7a51d44;
          Fri, 31 May 2019 23:13:38 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 22/58] Audit: Change audit_sig_sid to audit_sig_lsm
Date:   Fri, 31 May 2019 16:09:44 -0700
Message-Id: <20190531231020.628-23-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190531231020.628-1-casey@schaufler-ca.com>
References: <20190531231020.628-1-casey@schaufler-ca.com>
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

