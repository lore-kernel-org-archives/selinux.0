Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4149EC282CE
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12A482084B
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="rctRlsWg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfDITTO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 15:19:14 -0400
Received: from sonic302-28.consmr.mail.gq1.yahoo.com ([98.137.68.154]:43028
        "EHLO sonic302-28.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726771AbfDITTJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 15:19:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554837548; bh=affcoRY2PaaUmEgcqS6C9HybTLSyjRteSCEEdycSbI0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=rctRlsWgSC5C8HFxq/sP0CAIQge6XAk57NxQUkH+4eF1u/cPod8su+Dx2cH+7XNEpUmqEtAJImr99lX2Wm7kyVmhQvAC0+rIgpg0lIU5J1Y0ZOBwprwAg2Z2T+Fe5SvOULBOkWatLVuhHT0binMy6kNfcGkgxu2LkrXVXg3ykA2sEp+KRj3dJMT8SMAn0w+cypNxrJfF/+pCYf4Enh9lZfiZ/3mrw1FpQwLdcOpEUKdUS16P+NZEuJSeM51Q+bitBPQZj+OS2I/3oYVSp830Wjz/YVeZf4z2gc02GNv9kZVZBkTka++lXRsmwVeX0MyFxDTSxOWjih1QZGdLzRQyzw==
X-YMail-OSG: 2foU4CQVM1m3HXjVX90kurKtONjrT3AmXx_NGjTCjXV.VlVUO9hXloT9r6u0Tpb
 9wVjNaXOzzcSs9gcarGZTXyYNolJ9XRTtsztle4v7bEenoxZXme0llwbJTEP64pMboNRQ84X5XnM
 P4hJw440q.lBM6yiDNkLyAEP.WWMkbzjGmHL1SucmExsBOiQ2M6zIaku4_1JKxcKLOYnn8wXm5vD
 KNaJ.yf2MlqRadI3ZJSZduit2e7COQcr4lF5A_VbMK7mWTDXj3acksERGsHyNK8xubxZrMJQ4xD6
 uoBc_DisannoErJAjXcxZCzEEinsGeBPYCxVps6gJTVnMdI0DzjH6jbgR.ZewDstig1Q5_.k3lZp
 qKwPbloL4dZKulfuJETWoGALIx3VRd564Td7moZA8HhIcn1NVgZpS9QLchfQUNR8wyPM6x4VgbGu
 LVYkI2UHVQvEmC328AJEiJdfZSUYxlLXo.UhHNxDOLwNDayixfWn.8.Vh.IIKrcTO5YWDKo5LgkX
 TQ6zAsU7Rkfq3OdIInJMe6ArBzOLuopa_jAFc8gEuRWQJdyjYZPtVMVYVNU__h9qHqeit59XCCZU
 oV8wJSlbuHpGhDXzG9.TSG.hTteAjKWA216vcjnuG17PqrnNkk6Zcefg0o5OERC3hGp7ypjiN.iA
 9A0.5wV_Mg0shcewjuYcmTrO6hBFyJke4E2xnBja9zZRnHdsJ4Ru3e4jsOaEcA1E10ne1cgFHTWN
 CSopKvKmyCNccb4HvjRrgXh6rT5qli2VmuTHHHNecTKeIHeBXBGEZ2oSPiKhl1p1SGrdJgkXEtBn
 p7RtKBRjmh1E_nilrwp25938deDrmhwHA1hnAbyy4MaZgIpRF511a.suruW4xL1ufuJUOe4XDWHU
 z658IDoK5PIIdd3tq6SMJyPb_Z3EIaR0PAPm.NvWRx6p1Sm7plPl7zpnyy8iQVw5c2RBEExt8b7F
 aAcBnt6gVY2qbm4ts_RpRZpOwzchWUcvJJdd.ncsNUWXU6BFCByA2Bo46GKLrpRhjWUBHH.3b.TT
 jTqCReb1reJ7UHFWPQlIdjDTYAHwzp2zuDzLlphNZcddg10kbRTIugibT.PlwWIel61VE7rtcj.4
 riYjAcF2sKNXPhN7P4Sew.mDULhxSYyk7_0E1LEGMKpNcz7.CIdwB.FY-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.gq1.yahoo.com with HTTP; Tue, 9 Apr 2019 19:19:08 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp401.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 54e8f28a4675c25365c7725d1b772c7b;
          Tue, 09 Apr 2019 19:19:06 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, casey.schaufler@intel.com
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH 19/59] LSM: Use lsm_export in security_ipc_getsecid
Date:   Tue,  9 Apr 2019 12:18:08 -0700
Message-Id: <20190409191848.1380-20-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409191848.1380-1-casey@schaufler-ca.com>
References: <20190409191848.1380-1-casey@schaufler-ca.com>
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

