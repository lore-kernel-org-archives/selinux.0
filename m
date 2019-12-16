Return-Path: <SRS0=HHao=2G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0291C43603
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 22:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A03CA21835
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 22:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Nzyi0+MH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbfLPWZS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Dec 2019 17:25:18 -0500
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:45475
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726912AbfLPWZS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Dec 2019 17:25:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1576535116; bh=WHSWZ22nKp0hH/7/jZnFbGHSQ8a7TG9sYWeArSzn0QQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=Nzyi0+MHltQRxMo3cQmW7eHSQV0cMZ31O6X76emSE9Sv5GocXDtxbg1FRqlHVmXaBHPlRPsR4//fXFLKjaoBvYN4Zqf76VsmX+b6UUezrRpJOa1nJzJYiHs2x2p2F4sl1NHFp/WV0aWmySmZ3wHna3ZGAgEnUO/c0gmR5rQ8bkzOk8evAOVstHnH/2Vbw4b4AKbszO+5tDdAbTiZO1zyZMguAWa08AlbgSLzyQYxxnMQkMiaCsXlp+jAsNwQc8KcP7DytZfkBypWBU2gIW1BfIr1a9MTm7ni0L34d+kAh8R6BiLixuO6Sfxx5PZfrNb/QcLeowkRTAekAWvEBvQT3g==
X-YMail-OSG: Mzq1kZMVM1mz7L85ps00yFHoF02CdSjStx.UTd.DLBFKnj_xAs8MLTZPqpwqj56
 SOK67RDrREmmLfkuV7kFrP3MPDqgvOz4MQE798Ld_bEByvu9lgOrYfnxZUtj8N.PukMsc.wRwtks
 eFa.esamyuUDbKKQUM1bL2vrru37xbgoRWl7c6HT8HODkJ2ZDNXKeIMRr6tvvuMfENDNcxXsw_RE
 4N9Fcphj8mjj4Qd1ig.84vpsNiTIcauPCiV8sIetu7h_KSoci8I8Lh76gaTj4e1gdXWBVXl08DNg
 pYh3I_0ib9VjfZJURr_R6h3HzpDdUIjRscRIIk.TY2x29qBk5T1YLjascOIkz4mRFwPpAFQ7SvRa
 8RyISwGCxxh1orrXBFeMczm.bFY_v0KuffqcBOc_Ali0zgzC_Ifk9SrIt3XTnMp_RQ3x4qom301A
 KmQJfSJ57t1BM9Smq4y10LzQf3NMTQVCa.v1EJ0sgQTiLYxqEH1JNBVXRKZkLgGcDO.SNvUo6Hq9
 AuE_2sBicHJo9LbPYwzrH.lDFgs5Z25DNPbs4.c9M4hACrJu2dx3lABSVD0XGH.fz9JShOTrDLSm
 GD0DZnO6IaO5oIugS3K9ouBy3c1pvVrl4kOyv3aqA71LjJ9rXKk15s7Fmg6OZUi1KYEJPipvw.o2
 w907j0sq6RNphKBfe9MFb9xi0bYUPYcG9hdCsjHQ2iPdgT78AMwih4C1Vus3iqaQwG30CrWoxL.H
 ZbEw9e8FaBCE6Up.RNcZvb6xJsl41onJaRSlmI.4Uqn83uFG1XL7YqHwQt6ZyYe53.k3Fwcc_NBj
 BSAX_Gwne6Gf5HfTy60WzF6HnqdvbKUEA4lq6PzRdvxeyepAv4Te7c.AnEdu8x.9ly7IqVPsEHSi
 9OirokCKwGyATl3Gx05zxmLF2ADyL2XWGAahM5l8vQ9qMsy3HudVUAvxcvs5mQi0n0QJGZtN0rHX
 1ZbebWg6U5luXe0MQKJLqb3phDbBsjWJvNBcFs4WpOk5tgRiYgyS8wELVQriVwpnz12Gi4wmKARu
 Nv3CMAdoETANuDab5dVkEbmUsXYxZ6LIDndvFDm8W3gvJLp3CPTwGOrzb.nEcKO4bwO8g1FFnK.q
 Uln2p5lO8dXgvQeiE7hbAEDurAPikm1HCyy3h9EzHgnIl6N.Jla4nF.dUJYi7grMGL_8jQSihZ.3
 75aoaROTcHn4RV9G854YlBBL2GpgyAJmOvBLGCuryDLUd57bLsYO0UQwD_xaFGZPh9CheCaenVUw
 vp1Mgzvg.glwfv9p3yMqlZ4IrZSgFfqIWE_VovYI2T3sRw4FD2FhOwqB9reSMVNV2xdSWocf3b81
 OQFJHfCRHY1VCQBEeHpz.vY8uJ8Hqb8_qHx0To1kjOcz7a0uYX2BLcFQ0_C2bYkZkTDjxBrZQGSY
 UZRGqQTYwjTQi_tdjX916Y6XB8YzhGhwek6bCXvM2fDUXScrk7opYniySPs_GShkYBA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Mon, 16 Dec 2019 22:25:16 +0000
Received: by smtp403.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID ace9b923345e057175895f41ef70a2ca;
          Mon, 16 Dec 2019 22:25:11 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH v12 08/25] LSM: Use lsmblob in security_ipc_getsecid
Date:   Mon, 16 Dec 2019 14:24:14 -0800
Message-Id: <20191216222431.4956-9-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216222431.4956-1-casey@schaufler-ca.com>
References: <20191216222431.4956-1-casey@schaufler-ca.com>
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
index 26b8cee65c64..61a80afbbdba 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -466,7 +466,7 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 			unsigned long arg4, unsigned long arg5);
 void security_task_to_inode(struct task_struct *p, struct inode *inode);
 int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag);
-void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid);
+void security_ipc_getsecid(struct kern_ipc_perm *ipcp, struct lsmblob *blob);
 int security_msg_msg_alloc(struct msg_msg *msg);
 void security_msg_msg_free(struct msg_msg *msg);
 int security_msg_queue_alloc(struct kern_ipc_perm *msq);
@@ -1174,9 +1174,10 @@ static inline int security_ipc_permission(struct kern_ipc_perm *ipcp,
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
index 61571f5c7c5f..0d87a2349552 100644
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

