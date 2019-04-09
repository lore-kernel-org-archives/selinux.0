Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7390EC10F0E
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 20:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D3292084B
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 20:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="poNhIY9q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfDIUAS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 16:00:18 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:38861
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726785AbfDIUAP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 16:00:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554840012; bh=affcoRY2PaaUmEgcqS6C9HybTLSyjRteSCEEdycSbI0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=poNhIY9qt5ThJYFwQ9xPiD+rHz+/zPHx6/iEdNshu5NXVk79G7jRj5j3kjj8Rj7bz22ridPaiE3kEibBX9UYT5DWKVDOlNP1Iu67MsDPQ96wkF6H1bel2SIUo3emPDofWpmtzZq52Bt1DqsC0F8qo9qRypvRca+0nd1fTMFW8UVax8Xjq4cq1uPpe4IhfvauyU8ryFgfa6Y+oOBP7WyvRxs87+ewjajLUR6VqwQwsJH02rUC6cP81sjw3yhoop9RASG8zEBFOkjsdp6Q6ZlYv2W1BUqFaOryxNsQi/xWt6EY8zUMJhADsuAHoAjjPei1gnjiyK8IloY4l4bHQS9dEA==
X-YMail-OSG: GdzSJnEVM1mMugNzrAFrDh7Fcax0VHKryARJbihndVGA_WJhIQdkNlpeuYb.yYy
 I0JfuWdBaLP0RFbxevCsAqbHAhwTC3zDj7HzzsJE2GCYjKlgXQRQwWBYyOcefvYAVoDCt2hJR5i3
 UvgcQsTjfeSNLeOlCA0aqEfAs4ROGoiFkcbvEya5.TLXEPcgcLSw5bNi_rODwR.yBRqckXRlOFcL
 55Fxsa1A_XwrPjCPvEKNuFnWuDONNpZNfKa_4RmynxT2pm4jy7Wy0rFcRQ.zEzT2_L8nX2CKbAuC
 1.ovt57lvwdH8LI73BmWhvth7nxOmrfXkRkIPymq37DRN4A1mwBWF8Zw_UUe3PM7b7DoIDvAKP45
 367awkfOrKNqz1pjFu7n9Adtf7HV8naidx4ahpP4zk3RfClAGf5DGHRfl45.uqZM3A6rJkm1JFcA
 cGdIkh3artvGqfiYvNltWbrgqa5.91lfYl1BqC4ewSYWcNx3jfBEJ83BMlbIOThCm5yXYOxtsPXr
 lZq3kYpokeQsAez2KGzOUiRPjIh_QwFYQoMxFSmc22bHPbugvZtCOOBmZKAFlyZipwy_FLWQJdqg
 whpGjir5tL5u56k5H7WxH2oQGPtfx4zrU40jdA2IblRaY6XQmllgq2k6ATM3oqmmGUFQfGMZdvXU
 1vfNYc5Y6oCHh0uJtSe8mEfu2zChzxhzTXxU8DbDuNjktng3bf5pd0oQgyOLvi0Fclly2XeC4Lf3
 iQ.meeDvPolKKbFTYcgwNdrGWre7FipqBH3blfPS7kUJI6gBvsEpLhqZQ3sqFqV404KdUA_xFKM9
 NogMHHk4oVhY.sHuFtAZ595ZYmTsjhSZ96SgiiRZ7V8r2LA43UKYEI766U3MxKXL5CTsrUKbqAN7
 QeTHrH7NCl6juJPyXxmrqKuconr_Az_ICPG5i4GMtTPcfHe5KZe.8a1Oh522AH.EC_xtPiP89MBH
 2erSjBLrmibY6bcmXHglG3AKlDKZnEuKVHe_7LZKTGuhklc6nsr6tB8wlnbkNAC2.m6yRUxIDR.A
 t0kAbB.46qJgW_VQTKgm33U1byI_Fb7lCnuuitm8j4xTbYbs21pznjw9L2gjeE57Mr.Zd2tJK7uD
 Jn4oByBKgFdp429HVMEOFX_AVNeCoH4arCADrnJUQ1emtUifSk7fwucClk6A-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 20:00:12 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp401.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 24fceb1ba198cd68afe9603a17bf6fc8;
          Tue, 09 Apr 2019 20:00:08 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 19/59] LSM: Use lsm_export in security_ipc_getsecid
Date:   Tue,  9 Apr 2019 12:58:44 -0700
Message-Id: <20190409195924.1509-20-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409195924.1509-1-casey@schaufler-ca.com>
References: <20190409195924.1509-1-casey@schaufler-ca.com>
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

