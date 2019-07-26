Return-Path: <SRS0=eUs8=VX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35374C76190
	for <selinux@archiver.kernel.org>; Fri, 26 Jul 2019 23:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08FBF21994
	for <selinux@archiver.kernel.org>; Fri, 26 Jul 2019 23:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="jbQlONsm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbfGZXjj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 26 Jul 2019 19:39:39 -0400
Received: from sonic301-38.consmr.mail.ne1.yahoo.com ([66.163.184.207]:36152
        "EHLO sonic301-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727660AbfGZXji (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 26 Jul 2019 19:39:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1564184376; bh=NqpgYkQbkpDA8SdvAINO7YGHoVQ1J9pYODDE5YAZMOY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=jbQlONsm6+eewbx+7TwVCH9mGESeQVCl/cJ/y+hJtgC3q4KzcHKIh5wusTJRarGDyjkmUyOL5fNLs0eK41RWq9kjwG7tFpgy6y+960Rx0NE82dYXl+vHqwQ0aji+N8Hcc/aeEOuh8N/G7QR74cT62qZOXbM6WnFAm50gupiueNIyCXmpHheNHU4hcTxjYC73vNEBTC9dU33/cUDGGZlK+gqFdunJdI6O/XP9fbPOn+ivdEf2Uz7Frn/zCybU34v6XXBGFKJevBT4rsD0bM55WwHXqK0w3TJKWK2sjINge6vsw48PuucdAbQjV28nSuvBLiMB9fJKpHVrEl/3l009Ow==
X-YMail-OSG: AZDkUDIVM1nDKNiWEHOFO9LoBo5Nx7R8MbCbMUSWqLqN3jf1WiisXtoeEKV4SVW
 H0Br_VMfB4ruHL2_HadgbMxD4PFWcaFRiutNy89CO5MZLHXhqU8wCHJpjn7rmL0.BfXM.cuRDiVJ
 Ra7U509j_T1kWaLp4Iu89zVZE_rprp144KkzuuRZIAHZOWlAT_VfAsxveX9UTqnUrXBBlppEWxat
 ICE7lPerr5pGYlqb.kdf0f2WZhQq.uTglUocZNBPpKTBq_guNOi22WZluBTHC94RIP3AIp885Vr2
 hhGFIl4wZXUg.RAm0ZY.aX1_K0WKElV3WTkBXHs7RyCWCoIeB.uMRDt7CsRD83Y40lDfeP2o4RvC
 bCNJkb4i_l5R.RfpWMMJo1jidOf_ZegV_0pM9HtSyGiye5bly2bzhEneAAxhab2CxpvxRw.5zhJN
 NQaxJDNiYjw7W5i254yQPI26rGthLMgH92jx1JGlyparz.A7e4yfWbf7iA5HmqjH8CAQHiW2M.xi
 DMR09nQ6ZC88Il18pM06YzMNeEfGPcjsaI094M6bdj8YrSOL83V8rLRhnidnGIIEtqGouo6p4AO6
 eGr.35a6zVmRzgF8D786ln6rIFpH3hTfMYyH.xG6V4g5UIyeeMigSqiLhykFhXjK.X0QDlTaPChi
 jZjlUO3ck4QzQfiM28p_xSVVsSKz3kd5ZKbj69KFtWqQJewsrr7ZtYGUT5yol7aGCQsr91.gwW1K
 BbbmClZKdr0xm3gsWYOW1krkShYQMh309hOcsDMDGbGhjbIQHkcFeYowHY__o5nVsKezBycl5FPX
 x.ohOcnvTSFj8cgYASxmqVoCVLhCWzaUSan9i50eIYFrV1eF6AyQL66zi2xAk_NStFPOwUFl34RI
 w2SBrkpKJ2QSIc3v1u9HqmxQ9dkILi4fhH.BSjMnTeHsVegjDXDLqqYYXnq.6e9YRV5S3D1hdCyA
 Wf5JVT0EaYxJEKNB46AZ2dj5QvDaH9vIT7MSczKELasbI37QZb01D.VkBdO6uR5Ih7SlQLdLuh14
 10aBuapjpFuQ9Ui8P1PxL5ZzKqFxEGOZ9I52rXYllfqgUZ8Zh02EJhMlaQGunGyaqtM7NS53GKog
 Nf.uWh_NfarA4jYJZN8Kfx6RZ1WCeLAtTKP_7NmjtUjz6tkyckuVauYUGcdCzN7CaInBFrBucUL.
 i4c3h7ItG7v1qe7Utdcjn1REqc1lTcdCzaJ.X4TID2GqJAx0rfOtIsS_yEcpwQtkMpPTqG1qtuK6
 5y6JVQr5e4umRHwb7.UIjqiZcKA7ADUrcAzYfB1cPxvEPICpLJBJ1b5g-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Fri, 26 Jul 2019 23:39:36 +0000
Received: by smtp419.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID faf3134ce3e2400a4a56efaeaba728ba;
          Fri, 26 Jul 2019 23:39:35 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 09/27] LSM: Use lsmblob in security_ipc_getsecid
Date:   Fri, 26 Jul 2019 16:39:05 -0700
Message-Id: <20190726233923.2570-10-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726233923.2570-1-casey@schaufler-ca.com>
References: <20190726233923.2570-1-casey@schaufler-ca.com>
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
index 7b4667cc4930..41dc3053094e 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -417,7 +417,7 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 			unsigned long arg4, unsigned long arg5);
 void security_task_to_inode(struct task_struct *p, struct inode *inode);
 int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag);
-void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid);
+void security_ipc_getsecid(struct kern_ipc_perm *ipcp, struct lsmblob *blob);
 int security_msg_msg_alloc(struct msg_msg *msg);
 void security_msg_msg_free(struct msg_msg *msg);
 int security_msg_queue_alloc(struct kern_ipc_perm *msq);
@@ -1102,9 +1102,10 @@ static inline int security_ipc_permission(struct kern_ipc_perm *ipcp,
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
index d31914088a82..148733ec3c72 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2268,11 +2268,14 @@ void __audit_mq_getsetattr(mqd_t mqdes, struct mq_attr *mqstat)
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
index 837c3c6b6e7c..b4789c31e532 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1795,10 +1795,16 @@ int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
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

