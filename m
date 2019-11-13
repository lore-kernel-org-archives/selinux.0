Return-Path: <SRS0=4d9t=ZF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C041DC432C3
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 16:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40A5E20637
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 16:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="r8FxsBCn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbfKMQv6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Nov 2019 11:51:58 -0500
Received: from sonic315-26.consmr.mail.ne1.yahoo.com ([66.163.190.152]:36387
        "EHLO sonic315-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727112AbfKMQv6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Nov 2019 11:51:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1573663916; bh=6IK8Jmd19p+jg8RRRWD/snF1OW5tAad5UhaaNLHME/M=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=r8FxsBCnsvRPSum+RXOSJUso7JSBULRwWortt9VVl+5t5dBS7hMInHYTr7cm+BtJGGl28mRMQfvLfB4vJnF+Q6LR2uMQCYnFZ4JTk0tOGfjKNMGpQUSsFP+uYVz1Bb9HM32tcNGzn05M/hjvQsCSILGIbmdt8kJuOArJGlYejvT559wNN9+j/wpElh+1doALadR5nX2cj+NKJqOguaJEqnkJaEj9vMazV3/qS3QvbyFHpi0u5e5IoZZPG8MF4cUfieIQNgtjzsFC0LPwjcme+pAaK0I3+loeFE0wgT/QIaXJ2C16LjLFrHMSe/9tZUGk2VBLfpn+j/3oWzuNiAtiiQ==
X-YMail-OSG: PS2uAXsVM1nc8EWcg1BJZfxvzWrvNLyhWg7.ZJrps.IuG3Xtc_R8sKES_Tgjs73
 qJG1yQny.1RAmtrlifo9G.LFWIgHjf19915ETH5xY87ClfZYOYc_6PcbuAbUaXGuMIpjjtrV.XDE
 QaRpzC15uNAEVb5wVl_ZJ9WkzqBZIB_Mcf0nKBfx7Lj9ZfL9LE3ko9woFYR4ReJB5unf8E2wrXIB
 aR2Jzqu5aUEhVFbiGyPQc5IBvQuMo_5RFTBnAE1Y8rSyu9KxMM037j73nrCIDG.vlXPvKzjtZXNa
 Zms8UXsVmXkTKj9kxhPkRzmwrm6raazUb8Qtdhpz_KoYKbW6BRcTkFoER53wcO1YV1Kv0FF5OsyX
 VQJIGT9v1zHxCfT9la30BU5g0mKtjRjD8N7bQemCtKOwsvmpd.ojuhoFXhEIR8JJo4..g9sOCQLe
 8ppYRPgxKcphGzvKM_JzfRtrzPROQd1iupN9P.vzCp5Y5Uis8Y7hC1Pha.ZALe65OZRCoFkbMWEU
 AxSC3rcQAQyllSpf2raWcyYKE4.ALozrPkxImYC2JCVV7V2i8iZkOYuqiN1v3y2nsAuagwxRcDxM
 Q6sgvFeRwMR.Fbm2yguQLFeIF_zqSBWC54DE9ttghIl.JXJpcGAjfbQrtXsC2jS3Wju7zG4YL51n
 EI5I7R4XCOht6Uy8sGj_LiE3Sa5.Nc7nIv7_.3LzGno3pjhHU0NCyNNMjx_RhdGar7Id3u2ex7hl
 BaIUs8xhv_lEQKaVLvkcTS89M.HQodQ8uGyu2stvEP8H1BVSdZsm.iYPiCYoQvvuf.Mf6BFB1z6M
 Bu94CvCzTEU2nlEnRr.0TLXGOg7HPNN2hVeRGGg50OdVDi4d2NGOV2RdTrKWoLGIEzK5aeozIocD
 7v_gCbKp7VYRBxNqQds6Hiumrp8T5PLSBX.83KDWvGIrMZ_KJr2b8D.eK.1QxGs2L04oh.SfL8zr
 W1KfHS5jgOOGT0OxrVTPr4.X9Bvrntb9ByiHss.lbTJsbQBRMiUn_.GGQZYZV5rjStuzT7sFv5oV
 6k9f7LfqwZs5gxyXspsiSKBbl6VJClSeN8aFp9wG6R5X.1ckUzSSXR3HFho2lZG7nXC88OCGL_Bg
 nfNP22vEE__oKKXC8fsSnmFXCQV8W.Q.g6Sr5owVpchwxAnJvUfZtC7w3WHftTgNxKjuT6lW.Okx
 tkqNQ44qY8PkE19chSQrMDG7YfUj6gIqpjqFyOaJqGMFY0wDKSpG0K7YC3XQ81genRWjPTkQnXzl
 5TYW7bKGi9I3x8qMjEJCRuMwzDz5WyqiT0ferxTLBW8F8NvtuzLDV.kpMn4WoyqHWAlj1CQ56lhQ
 yu6i2i1YVKk.WlJoIbq9AEJowCRdAolYz4RQaQQG9yGPfwuL_jOemo5OMuVBHORQaXk2zEX7Y1Gx
 n3JrVXaVNy6VTH7UAhEJcM0Z9.OMvbZ1lwdrGvKCWXOZrnseWtUfs5n9H8Q--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Wed, 13 Nov 2019 16:51:56 +0000
Received: by smtp428.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 689fd9ed4f3afbe656322824a2096f21;
          Wed, 13 Nov 2019 16:51:54 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v11 08/25] LSM: Use lsmblob in security_ipc_getsecid
Date:   Wed, 13 Nov 2019 08:50:54 -0800
Message-Id: <20191113165111.6744-9-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113165111.6744-1-casey@schaufler-ca.com>
References: <20191113165111.6744-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

There may be more than one LSM that provides IPC data
for auditing. Change security_ipc_getsecid() to fill in
a lsmblob structure instead of the u32 secid. The
audit data structure containing the secid will be updated
later, so there is a bit of scaffolding here.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h |  7 ++++---
 kernel/auditsc.c         |  5 ++++-
 security/security.c      | 12 +++++++++---
 3 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index a3e99bccb1bb..9519b4fb43ae 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -464,7 +464,7 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 			unsigned long arg4, unsigned long arg5);
 void security_task_to_inode(struct task_struct *p, struct inode *inode);
 int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag);
-void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid);
+void security_ipc_getsecid(struct kern_ipc_perm *ipcp, struct lsmblob *blob);
 int security_msg_msg_alloc(struct msg_msg *msg);
 void security_msg_msg_free(struct msg_msg *msg);
 int security_msg_queue_alloc(struct kern_ipc_perm *msq);
@@ -1172,9 +1172,10 @@ static inline int security_ipc_permission(struct kern_ipc_perm *ipcp,
 	return 0;
 }
 
-static inline void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
+static inline void security_ipc_getsecid(struct kern_ipc_perm *ipcp,
+					 struct lsmblob *blob)
 {
-	*secid = 0;
+	lsmblob_init(blob, 0);
 }
 
 static inline int security_msg_msg_alloc(struct msg_msg *msg)
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 04803c3099b2..ce8bf2d8f8d2 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2285,11 +2285,14 @@ void __audit_mq_getsetattr(mqd_t mqdes, struct mq_attr *mqstat)
 void __audit_ipc_obj(struct kern_ipc_perm *ipcp)
 {
 	struct audit_context *context = audit_context();
+	struct lsmblob blob;
 	context->ipc.uid = ipcp->uid;
 	context->ipc.gid = ipcp->gid;
 	context->ipc.mode = ipcp->mode;
 	context->ipc.has_perm = 0;
-	security_ipc_getsecid(ipcp, &context->ipc.osid);
+	security_ipc_getsecid(ipcp, &blob);
+	/* scaffolding on the [0] - change "osid" to a lsmblob */
+	context->ipc.osid = blob.secid[0];
 	context->type = AUDIT_IPC;
 }
 
diff --git a/security/security.c b/security/security.c
index 0fc75a31a6bb..b60c6a51f622 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1783,10 +1783,16 @@ int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
 	return call_int_hook(ipc_permission, 0, ipcp, flag);
 }
 
-void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
+void security_ipc_getsecid(struct kern_ipc_perm *ipcp, struct lsmblob *blob)
 {
-	*secid = 0;
-	call_void_hook(ipc_getsecid, ipcp, secid);
+	struct security_hook_list *hp;
+
+	lsmblob_init(blob, 0);
+	hlist_for_each_entry(hp, &security_hook_heads.ipc_getsecid, list) {
+		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
+			continue;
+		hp->hook.ipc_getsecid(ipcp, &blob->secid[hp->lsmid->slot]);
+	}
 }
 
 int security_msg_msg_alloc(struct msg_msg *msg)
-- 
2.20.1

