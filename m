Return-Path: <SRS0=/A+P=UB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BEDC28CC5
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E42BC248AB
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="g1TvDWKq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfFBQw3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 2 Jun 2019 12:52:29 -0400
Received: from sonic303-8.consmr.mail.bf2.yahoo.com ([74.6.131.47]:35866 "EHLO
        sonic303-8.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726964AbfFBQw3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 2 Jun 2019 12:52:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559494347; bh=j+cuqymh91xxGIirxxPJDUSMb0L9mw21aX8dKstwmqI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=g1TvDWKq2FlNsBjvpG/3aJk8ntBgcTqfcsjq+a0O91O19awkRtjC2PYe30iz6o1GaVJMrk8Hil2ed5jW00RrKiiiHd4m+0PEqXxBSZmO+uVyA8gJ8zV43lGqRPwBS8GDnKQPlACRkn6Uoof+0Ko54Jy42iBBZGbu+LMO/jLPAZBBhdxRsGKBVytiUdAE23GMgZGdiuU+qMnwWf2bDJkZROMVEHMK1thjn5RR9tHkmyp4E3TKpzRJOV5KUH6t1gjA1IfNTEv31KRjKBDRjQKgmEvOOs+um4p3Bgl95qVWJc02rnA5PP6aNp/KFCWF2UlvwiCwRI+Y0OJqGmSiTb2h1g==
X-YMail-OSG: lo2cAu8VM1ldz7jGL0GTnRbU2cz3LqiNtBf5_NSsc8lw9k_rdt3gkInaYw6ePZi
 pxayQhbWC1xLFCev7a75omjYI9x2wztWg.twGFFnP4IQXPiC1oFHV.FpTatpkc.T.86NB41ADmus
 Qlj3gvX3rhVGPETj3coFFUX4p440k.Rn5hmwT51AwKXhNzM49VvHoBJT716tvv6RiX0UzKwajC12
 vgpwkdwVVzptIM79ZHTYx9F6g1b2D1wG4nJEI8h0idBa7PgxyOfGPiWnhY3Ri74nhxG6l_DgDcmM
 CciOj3wzWT49zaXV3GLe4GSgM8v1DKOBzkGTkDK5K26ZIxkf66JR3vOzDcg96fVPeD.VPUQjnHHM
 lP1YVXipS96bagt7N8.4ym_ACQkV0uzJoCrb2l9Q_N5kpCTgUxN7.TTAuVPlgqO1yxNz4MhVFePg
 vR5n9rK5VCBkEXE.UceTDP7pSubA20nMnN48ItASrkVwzBBoyDh03nESnRZVp5u7RU.sqNlIOZ3A
 Tzp3H16cx7MhybyCXexajsLq7CY5_.ftLgfV_W8RUt9anXiuZkoYe7x0NhMLO1v.SuLFfSxTB3Bg
 g_.7rp.XxewX6C8vbXFjydMxbYEQpiA_7geLW5_reAito0HsVQZy4PQkDpKBmscJx4wvWZEbj3mI
 gWVkEe3rlbj_eWyjpZ0hFGDEgZbX8g1lORED0.UKChUvodTg79M2UuPQ_1UvnT3VLo0PDpqTvf9T
 WtAglgli0SgKAUZp6_4PaBJsbDLBizfUN1WefnifiZzyRtEB6ElsxgD1SlrRyn9z6W7zc.jCtg2I
 GGauiBaageexu9iDElf92SLvhv5WxyXQ.wxsXcKDlq_XO1XZURIagrqw5buBJqT9u23NSh_ZGuql
 f0Eh8qdQ5SN4oVQEebkPbjrStDAR8GTe7m3tUPuKJAY8neuJBjchxy4NS3D.6E5b6qZjygaYYF_i
 7AKkceE85Y5vtLAsAvEoKbb81TV3slN13Ns9iE5eu.lH03d6ZFLLLdgV0t6g6qge75xuzMlGQxBi
 DMGfJF9VsTGG13mQhFPCDb5R2jotAT6NUw8AICFC3jly9N9ArIryxzi5HiBj1qmGfQ3LjHwZ.qQQ
 IEsUND6BatQmbf6JPxViTmzFymn9E5vWU1hhg_qyn.ZVxyU.iSB5AErmnd3ZLaAWMiwGbSoVuc73
 912IkNn2zcavbiq0Nr3mC6wbw7nWvbhpD9DtS0gpBjdQFL7hAkaM4PwvmtGAF.5gv3.3zo5HlAJX
 cXPjAXtH7BMxmA4hBIPx1StDV59WWGmU55VOd8Ez1Dvf23JmfyAh_MK6_3w--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.bf2.yahoo.com with HTTP; Sun, 2 Jun 2019 16:52:27 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp403.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID f0b498552947f6b5133c1cce9fc77f09;
          Sun, 02 Jun 2019 16:52:24 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 22/58] Audit: Change audit_sig_sid to audit_sig_lsm
Date:   Sun,  2 Jun 2019 09:50:25 -0700
Message-Id: <20190602165101.25079-23-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190602165101.25079-1-casey@schaufler-ca.com>
References: <20190602165101.25079-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

