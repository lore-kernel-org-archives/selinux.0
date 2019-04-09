Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5AB6C10F0E
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 913382084F
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="OvWj9qZ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbfDITTR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 15:19:17 -0400
Received: from sonic309-27.consmr.mail.gq1.yahoo.com ([98.137.65.153]:42253
        "EHLO sonic309-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726841AbfDITTQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 15:19:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554837555; bh=j+cuqymh91xxGIirxxPJDUSMb0L9mw21aX8dKstwmqI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=OvWj9qZ02uNEWwbVQt/75N/N+nI6Df32LE+2fvD9j88Syy2lyCpuL+BcZbJPRcg8d8x3ZchuxEOYz3awB7yUwfwpYq/rpb/pmblldo96E2NmafO68qKR1QZ7s28WFBiyOocrRoKMPISTZMfT25CW/at+kZkh6TGxKb+DzX7blL6JBqSwn90upFkABmUP5XVMAXzU/Ai/3Jc7Gzjp/B7fzCaTbCrTrMl46AaUuzu8qvDMlTScMFlO2GHSWjOSPaDxAinHezefwxhByEd2VPR+ppidyjfAzK6ziXRJwSNc48dtOiudkClBbl6OKUhNyAjhilyZTGldxxAsbbSribEoRg==
X-YMail-OSG: 6J7QVgwVM1lKWmNpo43mkcpnDZd2TKM.DkuPUQP6wIj0CTt5OU39mB1CGy3zED7
 FzqdvDZfSmzfFeK6BrcgeIai3inSMxAniB.bvjZCr7EK35wED8h_Jgf48sD_Dl37OgP4mW7L4XB3
 INVXVGXSjFY64wnmi0Z.jNwaPzZeBWpaufgD2nhDYabR4kPg7HcBZXMil979rNbYoKTXiXeVzSfC
 DuRJiGutNpch0SI1a_6iSsg4e9YHaDmY7S5xbXMTtoDNMIVMm1Sfyv9xEgzkC4xr_8XYY0ClNMCW
 0iXGQ5yuvZohMvWo8351TJTWP96bGBFyQ6IVqJd_dG.CSF3SKNoG3e3NKe.GnkVVvGcFhminX6Vm
 Z7Rr5A7TGbj6G_oS0eHwy75FDmAYNdOLbz.aMtBpaGwcUTJ6prbUxHzBZ_UkO74NpSeobiDWi8tr
 8QvGBG0_q7zDvcfRctuB6tWREi7Z8yAHgHAUmtTrxnUuuB.uM_L5Aia674TWXe_Qg9J7lQ_9PjBQ
 fk4_yAh3QCO0bV.8dgTjWUVhroxKg_d8ZIM7Yxbx0ho4Up5Fi6wMIKRmKqaKgK2oTuSsckPAMVg_
 ujyXx8DpKSW.0ecD3sXyHMXUwtcXBoWAQs1nDNblLhkRmLWMVZq0xiqMgt8uW6GcZllMH73dFe4S
 FNGcYJujYTDGUGdLtkLUOLFygIkF3lpuXyc6JY4aUGyTiqBYNk9G3nlwQ9v06Nu9aYoqy8Emm.QR
 HimU_EdY1T_sQZftQWkhDB3RwokRGi1FyVETDpbZ6nm0iso9E29xzPMTwFVXw9bkZIAo2nQFAusF
 TS7ALBRP8i3T544uWqu1JjfGcSAo5QWx9aziInvOzwwfnIGmokY5Pqb3W711lIhfUjkrGZxI9fDH
 Sud2fSanjQWUghoSPcdBUN08X3noW5tiUS9TLePrdaqFpiHxJ7N3YAr9UA84JB7DmICilc9EFe4W
 gytbf5OQKfiRv_1lMLt_AU1qbl2JBBjdDxh_OU0KQdDgMUWt6AmhdAGDvIB3e2jGrRrWbH9aAmZZ
 .LfAildkUr2pItslXsM.MP62rHMShOoHyMC4VNLmYDVCs5KT6u7DTi5XxQmrtvHxlo1H5ERv_IyC
 hFOzdYCE5NBj9kx7inQ64ZI3iLD67p1UzU6yJvTrjN3rldhdebtJq6ms-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.gq1.yahoo.com with HTTP; Tue, 9 Apr 2019 19:19:15 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp401.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 70e478474b1bad4641d6b335096eeb36;
          Tue, 09 Apr 2019 19:19:10 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, casey.schaufler@intel.com
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH 23/59] Audit: Change audit_sig_sid to audit_sig_lsm
Date:   Tue,  9 Apr 2019 12:18:12 -0700
Message-Id: <20190409191848.1380-24-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409191848.1380-1-casey@schaufler-ca.com>
References: <20190409191848.1380-1-casey@schaufler-ca.com>
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

