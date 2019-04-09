Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA248C10F0E
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 834512082A
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="V4W9Oi8k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfDIVkh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:40:37 -0400
Received: from sonic317-39.consmr.mail.ne1.yahoo.com ([66.163.184.50]:39278
        "EHLO sonic317-39.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726712AbfDIVkf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 17:40:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554846034; bh=j+cuqymh91xxGIirxxPJDUSMb0L9mw21aX8dKstwmqI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=V4W9Oi8kUs5hD1VBcUYyqFig9ESXqmhTZ1SjiL2jicUYlzN+0go8THjkYZU2oIvWxiqSP35ci6cA2NiUtbCEoEBcszwD0WS11TsyNL8agIuM6oGBANF2qut7XqnnIiAUcPesxMunglCf6wXKIAvmNJ3h21CRrJncqzfCE0Gkil55JloWITyjoIbglIZSjAS75kcTgovtlrwVjERc1IaGhMIIKor4fZchN7YOYU9a1FRGWOz4OvKwaYfyT3vJDvk/miIrAFFKRQ4g0lTzFn+x7dZSWqUOGuwzuww3KAsDUCV4EtAvuUYUtSh8vprb0CKu6iYhIRlDp1GM8lMneGFYeQ==
X-YMail-OSG: 1E5fiScVM1mxULQMACrePCWHugLs_0sWpb1PqEYRoZfA8qipgpwFtXpGYuxJzoo
 VcMcr7SC_5d.bUbbRdlfsOB7rGX8vL.eoY06YM3CpPLwoNLP5ToEWVuKl_I0udNK00xWqXKJFukG
 GAeeOBZctto5jrorP3FUHXFThGvt5AvEbS7_neclC6Lef0w37yoNR5fnB2tP0NhOj241ZtJ5TFGy
 HJmgpdlngXLbQEt3l8LHt6CjgGZXcI11f9GNJ8ggvT0hVZFAcuTjJ03CUnem2eldP0FJ5j4WKFSj
 MaIxZx_dhKKT.yyDeICgx6OCcnO_WIsGOWqk10jJ7LrgLxkCmm9wDT7KoAjRakTf46upobE2CWnq
 Uqw85Eped31ciNaYoavhIuyfYkSdIqPw503j4VlF6btp3VAUI__kgh5kEs_Rsr.Z0kJgop3IL6nT
 5AjGdpkodb4b6BmGvGpKnZqcrO_qMECq9GDLy6QGNXFV4cQAkKsKB3.tPfor3p1WImbg829QbGOE
 Kgmmf2y59RkRPzJJvhbA0ZgtbRKGTqMMaNgLA943DvCM3tGpg19hBjSskxf9tVUqff3HW4A6uDUX
 482jXn.WH9BRH3FoqzjOHa8r2Sg92qT2Ce3ItFUeNUZpi7VpHtNUZ_rx8zqODGUtrWY0f8PcYb9F
 eL4mO_G1EMhoZZU_bcsF50FSn1vwH0TDGeG7xQmp3RZjuLzCqYWPvaU6lDWCbov_tBMXv70atl5.
 V0x8LEC2IUDo2pdRCpOlGVB8ckcX30orjxskUF_D72182KfdsLRcb73i46SuB.mU8d1CZwFcWr37
 S0VVDQ0v3rOOeG.yA13leZbuhGBTyJRcWKUqmbnJJj5qP8eDshwQ29W93v6SZsgthYM9o7lQvTzD
 uL.hdSDiPHJuR2nvR6xG5vER6xlW7E8ms1JJnZHjp1maM0oDRJY92Z.Lojp23WLg79hj0R8dBFVs
 CAB8KzJNaJ05rLq7rBCYqMwULQbjFXJxQwFVaOGxdiAA8RCSOjzphXTe70_wueESNGy0_8bnC_76
 6D9r_7oz3S9VPzAcP4TrGSk8O2e9IlTFMDiizFBb8aEi8N9SEbQTXNkL_kFd5zsDWfOve9FcIe0u
 N7gHMWI9zWWRGM8CbIGNOz9own7g3wcmQ4VqHU5bpFb2wJozpVY2qkrRoYLN3lQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 21:40:34 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp422.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 9d24739551c480912ea4720c6639d78e;
          Tue, 09 Apr 2019 21:40:28 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 23/59] Audit: Change audit_sig_sid to audit_sig_lsm
Date:   Tue,  9 Apr 2019 14:39:10 -0700
Message-Id: <20190409213946.1667-24-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409213946.1667-1-casey@schaufler-ca.com>
References: <20190409213946.1667-1-casey@schaufler-ca.com>
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

