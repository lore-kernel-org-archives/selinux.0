Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7526AC282E2
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44BCD21736
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="jECWNrwr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfDSArF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:47:05 -0400
Received: from sonic310-23.consmr.mail.bf2.yahoo.com ([74.6.135.197]:41547
        "EHLO sonic310-23.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726750AbfDSArF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 20:47:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555634824; bh=affcoRY2PaaUmEgcqS6C9HybTLSyjRteSCEEdycSbI0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=jECWNrwrIgowuHkP0xyUd4fI2QGQq6+5RuTSnA1yfDG4XpMzuzjJxNSXy0Ao2I7mAksZPdemIv7JirjsINccroxmXZ0FwnVj19cG8+lHEKDtXcIT057P5vn/ENEMGXTlqWCCTHbYDzsl/J/fzEkj+iG1Ghz/LSG/czOnE2+DqmRid2cHwxzNLvAQjBnwvKgnf4D5xFuLHgZX0CEKZRdJhjAqnTyx2eA+npADthutVaXwr99+QaWzYFAOasMSM8G8IG6KLx9wGVtRxITq+NF+rJ0lSZo7ENJv9nBIozPBUeebd4EkkZX8QdwRdK7K7BiK1uJDTXzdwKPkWi0HFtfSlQ==
X-YMail-OSG: sfX6tlsVM1k9h1ebifzdIQC3Fo3dWTlRzxUZYpZ8C1hqliIK7aK7WBr6E5nmNr.
 HEVKUtaGm0N8AHFgpTCFTK.sOMY_rnZbLZU9Dd_YztgsB6RLp8BUb_tzMljVzHZ5U6KlLTBneAUU
 LVsvUXsR_tYkAfOM8Ucepif2G10u5wVGwH4u_LQ2g_6sLGhH6zvh9VDLN_sLGONSl8OVee01sd1P
 pTc_iw6UVbef4OvsZWmIrC3BNXT2ysT_NB5v3Uhd49TLHsD7G1EPTyk4iH86O.6UjrLT14_xWz9.
 I4pvET8qnuJmsvpKRAB2jeQR1d0D8_gYtAIL5kZ7YKohv2dfdjB0AcF74jAgzFBgOrZU9VucUo9Z
 HssqRJ2SnUg8Rc.dOEXRjG2465x4ibT3yQal6PJ16Au4X7BkgLVqpI8QRC56p4T5TddM2.7wunkH
 B41Z7wkGAvpe.W2CEaUrb4X9JAJ9JqeP8ERu8jHgL0lDEriKZ74Sxr6X3187KwtIIu.oKWSbZmK1
 cZqwNZaqRFYXFK8QdD6CC47g76217YmG0qs3XR5e55PpwlzhBx6REWcn86Lc7YsJxCQ3w823xBM_
 Mv.px7FASxCj5UORhdXZznjdCUYQ1Xnv8she6WCziM0O4EBy8_6DBBeq7InwUd43xgjv9cwAOiAz
 GS1C9w4A8qcgqPKuTV50Q4GcosCWMWld7YPjqJ.X5rFvKcAV4R6RqcvYhLy47yl7qQb2hd7MG24k
 fl.8HgPERS_ClSxLObvJX2HlD0dHpynqi4yFfiBu8E0_In1dM6vx18HhX_ydUsyw_Tu.byXpxPNK
 7_490e6Y.I0hG3oqW8PcE27nH4iE7bju9GGzrix3WjHkVdVjpxjdGpWwJcynFko.0Y1eJqF3ED_U
 9bLha1uqeo.JDVsr2V1QftjvzlvqrZgEjyWDVOZaDxXXdFpZDBZZXeuXQh5dFOqWETFxh9mANPeB
 4.RDDHxUXTGUHUjZ4C_pvuzsSzBnZ3rwt66aGoNVq7qJgn6jNp7jAjsMfidRwui2W0RWTieGIEBr
 lF8fRt.dhlfVvXe08gUBb5Sib8fqOIrwLBLb2NnIygV_pAXwGzKjJ2GnpEov_Hgf_SvPBvjbwU37
 KCyNpmuHzAkMonWk_wkxrS92A50PGWjslvpq5jffVn9JG5HMRbz76RrqD2rqQhMT3dBOCAyJontO
 bi1N9Y0Nug4hE
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Apr 2019 00:47:04 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp404.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 7bfda36ec44e7fd17a13267c14302369;
          Fri, 19 Apr 2019 00:47:02 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 19/90] LSM: Use lsm_export in security_ipc_getsecid
Date:   Thu, 18 Apr 2019 17:45:06 -0700
Message-Id: <20190419004617.64627-20-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190419004617.64627-1-casey@schaufler-ca.com>
References: <20190419004617.64627-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Convert security_ipc_getsecid to use the lsm_export structure
instead of a u32 secid. There is some scaffolding involved
that will be removed when the related data is updated.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h | 7 ++++---
 kernel/auditsc.c         | 4 +++-
 security/security.c      | 8 +++-----
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 5cea6260bbd9..6ac48c7c4a41 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -411,7 +411,7 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 			unsigned long arg4, unsigned long arg5);
 void security_task_to_inode(struct task_struct *p, struct inode *inode);
 int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag);
-void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid);
+void security_ipc_getsecid(struct kern_ipc_perm *ipcp, struct lsm_export *l);
 int security_msg_msg_alloc(struct msg_msg *msg);
 void security_msg_msg_free(struct msg_msg *msg);
 int security_msg_queue_alloc(struct kern_ipc_perm *msq);
@@ -1096,9 +1096,10 @@ static inline int security_ipc_permission(struct kern_ipc_perm *ipcp,
 	return 0;
 }
 
-static inline void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
+static inline void security_ipc_getsecid(struct kern_ipc_perm *ipcp,
+					 struct lsm_export *l)
 {
-	*secid = 0;
+	lsm_export_init(l);
 }
 
 static inline int security_msg_msg_alloc(struct msg_msg *msg)
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 83aba0336eac..eabbf78fee96 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2266,11 +2266,13 @@ void __audit_mq_getsetattr(mqd_t mqdes, struct mq_attr *mqstat)
 void __audit_ipc_obj(struct kern_ipc_perm *ipcp)
 {
 	struct audit_context *context = audit_context();
+	struct lsm_export le;
 	context->ipc.uid = ipcp->uid;
 	context->ipc.gid = ipcp->gid;
 	context->ipc.mode = ipcp->mode;
 	context->ipc.has_perm = 0;
-	security_ipc_getsecid(ipcp, &context->ipc.osid);
+	security_ipc_getsecid(ipcp, &le);
+	lsm_export_secid(&le, &context->ipc.osid);
 	context->type = AUDIT_IPC;
 }
 
diff --git a/security/security.c b/security/security.c
index b6a096be95ac..6ba1187c9655 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1775,12 +1775,10 @@ int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
 	return call_int_hook(ipc_permission, 0, ipcp, flag);
 }
 
-void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
+void security_ipc_getsecid(struct kern_ipc_perm *ipcp, struct lsm_export *l)
 {
-	struct lsm_export data = { .flags = LSM_EXPORT_NONE };
-
-	call_void_hook(ipc_getsecid, ipcp, &data);
-	lsm_export_secid(&data, secid);
+	lsm_export_init(l);
+	call_void_hook(ipc_getsecid, ipcp, l);
 }
 
 int security_msg_msg_alloc(struct msg_msg *msg)
-- 
2.19.1

