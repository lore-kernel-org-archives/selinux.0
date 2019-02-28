Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E6BC10F0B
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 003D62184A
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="mMITaC96"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729679AbfB1WUH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:20:07 -0500
Received: from sonic315-15.consmr.mail.gq1.yahoo.com ([98.137.65.39]:45191
        "EHLO sonic315-15.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729666AbfB1WUB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:20:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551392401; bh=6Cf6FrfCTZkdNEsoOhKYWIoy1Gi5G8OXKahME1H4mJQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=mMITaC96ncYoa1Ds1eQt4zaRmo1m9LMx5qXhVd0Z+FzKyfe7FgxglCHLGlax971Fn2zx2UGxP+c9HArrUg+at/FNDh3R5fUEIYo7U3tH0LjWXv0NDwdfZlELPDdOL3W5ZxyohoLs79sAs+6QtIWJaMszwuNJV8m0WwG2QVzD96VsFLLKcM0vNznXkkYvQXAyqF/EZIKLQEWkQIrv5qoO3yPG+yAtY8HuK/4sh2XzGJTHviFYpdHKOO+FT6o2TVpm6ouc4NecQ7DCkC0bInElRtqlPOvSMcZpiIUIz7By8+D8bv0lWTUmDz0aD5VrSEUdIbzdwkEpCXQS4d0XxR1acA==
X-YMail-OSG: k1EOSPcVM1m9sWgStLP9_VoUTiEfa2N5a9EZR9CdqBnSOmN3G39P_X7dhm6XNzU
 4poAG7OOXdGIAfyK9vPVloKVOQZ6hc_nlIAs.vuMV9F.Q9Yy3N6of02NDH0q59s02AnigW4jdIre
 bYhCsUdc5O4JTZOjZPoBXX1UBlaIC6t2weovGGZAQhLO31M1LUEAGyx0xk1eRA8dUF6mCmKlefvr
 6InTu7OjoHWJn2jDkV10RdHkhjZmQmveBoxpw8POZvrnQ2tmlDAC1ojEl77WGPJxgAMfGSbwnHuF
 DE0eQyFLYLZq9Js32V5udSDuyKtLZXUMCUzxiPROZXnZwlSFQZk59HZNX8n7r6KRVEiHGeZdeLnH
 gyUiAc.XmDqQD1ZvnfgK5mSME9HZoocCz5d8qvUvJtNem3_LJXlrJYn2pInbRXG34w05F.XHx2NW
 l_YC.dmG2RLmmUCQQZkr81tT6Ws0AH0igS4BKkggxlR1YmsMlwvfZRBQyEJrNJ0dPMNU1oueqrA.
 1t2Qg9AgT3QioRXJ57KloZZtMHOrHz4HLELYT2fG0rTxjpurjvzIebsfTMWkxJSCXPS1h2tSdzNx
 IWQmVxuQIlfLN6Jh3WzkCos1bgeVPXiGkKGiK9uadZFTcXG4hZKct7.zObpHXRJtKl0nOUaa5mZd
 mSrn0MBgFMMHT_VonwbUhow0CEKxcPOB9paGR59j6dY5lQc7UHT4aYpAT.d7y.dXjZ47WrPvsABv
 0pEg9q8HPDSDvzJ3oR8MRDq7s5qILB.NQRIdF0Q038_pkKu_oY9EfYisRodgOFSC6x.x03V6t9gu
 CsY8jpF0gkR4RnEdDfPlzqN..g_ouGRToaXUOQG2FB4uaRXjZE9S7XdR6BOaE3PXr77vmXOWIVhG
 XHTvBzLuOJ566PRiU4wIip5ydfFmbvXCArqLx2VkqypQDj1FRnHRvp49fLH_zdJdj86ZbNVi3xrg
 hIfv1cgcIrTUv2GUBkArECjQ7TEcEiNfL3jUnnfYsOGr0DoZmoRLpGRJ2gLWjHZ2a1mfVEiIsVA0
 ..sCFMLENPjv14qwdG54nxOdyhr13ErroTkYxAPzNHH4PxgOn3Mz3D2W3BTn9HLTMM5NPuCZBqa.
 IczPULvbKvtWNaYKgBg3_AjJsZNxfzvQmgqb.GcAmZTba.QOg
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Feb 2019 22:20:01 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp406.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 5c7d685bea94a92cc9d12c4cc22f1f0e;
          Thu, 28 Feb 2019 22:19:57 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 22/97] LSM: Use lsm_export in security_ipc_getsecid
Date:   Thu, 28 Feb 2019 14:18:18 -0800
Message-Id: <20190228221933.2551-23-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228221933.2551-1-casey@schaufler-ca.com>
References: <20190228221933.2551-1-casey@schaufler-ca.com>
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
index d0adf4032baf..48ad03f6631e 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -406,7 +406,7 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 			unsigned long arg4, unsigned long arg5);
 void security_task_to_inode(struct task_struct *p, struct inode *inode);
 int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag);
-void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid);
+void security_ipc_getsecid(struct kern_ipc_perm *ipcp, struct lsm_export *l);
 int security_msg_msg_alloc(struct msg_msg *msg);
 void security_msg_msg_free(struct msg_msg *msg);
 int security_msg_queue_alloc(struct kern_ipc_perm *msq);
@@ -1080,9 +1080,10 @@ static inline int security_ipc_permission(struct kern_ipc_perm *ipcp,
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
index 0d4e006a7ae1..6a991e4b1492 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2166,11 +2166,13 @@ void __audit_mq_getsetattr(mqd_t mqdes, struct mq_attr *mqstat)
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
index 0026edf0a424..8e4cdc88acce 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1761,12 +1761,10 @@ int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
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
2.17.0

