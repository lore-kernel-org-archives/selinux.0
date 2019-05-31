Return-Path: <SRS0=ovs9=T7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E37AC04AB6
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6AA126FE4
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="KLwNbx6A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfEaXMz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 May 2019 19:12:55 -0400
Received: from sonic302-9.consmr.mail.bf2.yahoo.com ([74.6.135.48]:36941 "EHLO
        sonic302-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726653AbfEaXMz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 May 2019 19:12:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559344374; bh=affcoRY2PaaUmEgcqS6C9HybTLSyjRteSCEEdycSbI0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=KLwNbx6AsHAwP7WEjhfxk+aEARHwWExRNyDhMsrRjP7wzF6NyJpPIy2EmtD3pGmAdXndcPJRC5Pskw28OnmhBGLFzmeHrovSr48PG2jN3Ud9TSjLXyFAJD/uNTXOtauWqGjH8wmPAxFlhnWIoUmoyXIB4xjltt8olMbh0ucxWfHxCSMzUdwFCrI3V16mIA8b9ss4k1yPkRCVPkut0DafFMkBs8kZB1XopzB/5zeZDMDxdtnNoOK7j2TF8orRcG8Sv+D5b98Ek+/pc3jCRESwtcbgrCUBLbjr+NKUtsrqi31A3N6l3D5U4NG7wNu9wnoDbIyBqtb/BZ9Xhrgck3OV4Q==
X-YMail-OSG: 4PMBBjwVM1nK4PghUgjt9CKcWrIUgJ1I4TF7Hgv.2DaXSGTQ00tpz6isKzMIW83
 zhwt5r3QyUq436Ds_S0xqoGVhmA6apzHbIorHPrvd2j6eKM99ufOiqNoyptse2uFkMUgMLyrYYRf
 0wiC7nbzMqq1KWag5D3Z0qArjg1gWxIE_3xrQt3a_k8vYLhcxW6qwDnLXdlRsm3PlNzEiPPxSTMN
 cc95WQbuYj9gOXHzPuJ9LZmpiOt0X3mVYfWiA_AgB1mFfElOiz4sVTLpCgOp5D3u0PYv1vcmK3dr
 zBvS4uZu0VrJWIyTdwM.0i8qqzmoQl0aiODvKwAPQTS3XCcPxfVPFmUpbCKVMufmUj8IoeA_gQah
 wueOILaIzm8Tuoo65446GvkkZbjYF.3tUdPf2WRpOxfy513Dcz5_gJvrh_NwsajgbCQB_tZrQYt_
 LR0pKLpFTvaXlz9kOECLTzgGdWceJwl9xJMg_AslVSEMil0fumuUMNfZ8gP4ziTneHSEFx9QzZHR
 tc83twqMUDmYBH5mLAoMsbKyJ9f3ECaRAIyNVyAqXzvrn6TWh.yc7efPmy4jOMbg_0R0FdgXWrbF
 wWygJZ2SuSJzzKJJiVDKDDmpLxNo2Ay7WQXFDQfrdDhcrfCtAS2d6NhtCxXfF3TWkQA1ozWUm0dx
 Ak37BTeAU6Ofg5M5GwJvpF6t5JvNXVxS9UNtgAi01ZZFLQD2rquo7RXDY0_ibtU9_fnytSRhRFYv
 zyHjMwECVMqok6KnLMRNhx2gO8Ewo3AGzWuV5gEVEhGGyKwCDO5AeWPwbNkIiPPmklVE7Eql5TDK
 AJCsd_oNgjS.i0SQrZGbmJJVgwpSH6c_0MkDqL4wY3fIrdLlpJ.scw.iMouAk9a69PLjGv.OYt_S
 0VPgxnS7nqKvxQ5FVTUYdiqQ7bFvY8HnnK0LCGsRvZiwjF1T.xJWHF_jupjZdIoRZIBEY5b3zYf_
 4OgVlJTMdkGZkYVH9_2RkyM1Vzn5nlBzeleaM0fsGxGvjJnKYjlTYVs.EUPdnOF0v_BGqgX8rT9x
 60.9gPd81maF8QozLpZu6zgMJDX7DM7RU6lLE0D3hjz0xkxIdUh31cTl1kUqyMXgfAiEMbKujblq
 MOh8XOegC8_MrE8zINVAYxk6.akUA4nLpJ7blwewflmRiyt8pgGLWWfZrDWAla2WYhRihZb8C2SA
 a3woBJVidHG9AJk5YENi4BQK8fypfyPfs0co3ZRL3pR8BpJ3SCbagfc9GZQ9q_dqz_ls3Oqpa_fK
 BSp1o2Qm1ap96aZjo64ZpB9R_bodA.Ho0Zay__yu_5zQYoYzSGeJEycw-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.bf2.yahoo.com with HTTP; Fri, 31 May 2019 23:12:54 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([73.223.4.185])
          by smtp402.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 6b512c5bef0dbdf030d04ed894ce55d5;
          Fri, 31 May 2019 23:12:53 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 18/58] LSM: Use lsm_export in security_ipc_getsecid
Date:   Fri, 31 May 2019 16:09:40 -0700
Message-Id: <20190531231020.628-19-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190531231020.628-1-casey@schaufler-ca.com>
References: <20190531231020.628-1-casey@schaufler-ca.com>
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

