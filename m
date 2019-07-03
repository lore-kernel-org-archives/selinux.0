Return-Path: <SRS0=dBUy=VA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED780C06511
	for <selinux@archiver.kernel.org>; Wed,  3 Jul 2019 21:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5C4F21882
	for <selinux@archiver.kernel.org>; Wed,  3 Jul 2019 21:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="mL7+8YvI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbfGCV0N (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 3 Jul 2019 17:26:13 -0400
Received: from sonic316-13.consmr.mail.gq1.yahoo.com ([98.137.69.37]:43145
        "EHLO sonic316-13.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727310AbfGCV0N (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 3 Jul 2019 17:26:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1562189172; bh=NqpgYkQbkpDA8SdvAINO7YGHoVQ1J9pYODDE5YAZMOY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=mL7+8YvIRkOwWgrzyR2oYscFcOm464yGaozFrdf/jbTIJJ0TIdl4cINmbTYmFDnQChH106/ymZVI6TVdQfM1sSF/0ThlbxUQkdh2HZ6LBkcLwrRmoO5cfWAQsRxAu/3PPaTgx6lh0a1lSjgiwcEs6gsJR0mC0aa/8SyGwnAl0GBPrtXgE4z9ckrrfuyoUNtaphO0c3jyIUE5szCF5FyM8AVCnkl5mULi3wC3WJH/okC0l4KdaZyU73ncp5PwlHk5myDwRith/VSElPLnqrczrrYQQ4p1+z8fadGnqfB1QP3gabCuzQdMbuOB08jR+3r/WG8WIs73iEOpyelBCbI1YQ==
X-YMail-OSG: gDYSZnMVM1kIBvbuW53OTc64h2UNMDURBMA3x8e0zQgAXKAXJ_llY_XB.yAiC_6
 meB.8E2uIL86M6fD5T8x8mMIggiBAvtVZuQWLAx1wxOS0PcZAo.AiqhlUrMzsIUaCRkGRMNxElPx
 x5Y25C7mR4wUs2WYQEfhGZmd8pwZKqcRAP4XGkrP.sKLjEA4oydvLQKxPhPbhazGu0_2tKrKDSrP
 m9GC5dugd4xb5G.MDDQJWwl_hGPf8pG3Mw2li73v7j.bnSeWV8vttBB9yNBMt8GZMh.b2JNxxG_I
 iOBUlzS9NVxheC1_TUj6fvI22L0NWBYBDf0zp49rIMhuxfPQknZbJFvwHzbe3tE2_o8qHucY2opA
 pAbah3wSU_YBJypBcat4D7xhYBJhMTpgXVyY4ZJIEl_GLBQmUTrONSuWbzkh1n.vbpKsofSAvIxc
 pQpLKPi06XNiSGMymxU1jIZrqx4eno1jgsIIrPM7r0aEYv4QEvzdaSv1rTi4wamP9FzwhZ5VUX62
 KUWWBcNaL3M_Gk.0I5euop45yeJri1l6Czv_0vWFritKF9gfiD.WnuVWW.lSUwV6eVDje1G3X5RG
 VBEekc0REQflBXSJ0mArlZSjNvnY.T2pg2HHTAU4ui_IjeSEN.YfrlhjtwJFzqlnvqL_4qBEGKeH
 M4iz78dLLPEQ1.NiWHRoEFwX9WdkcdlMl1IfCTvFZRnFNrGhxoUMZi2Sk9xMFvoUSN12LrNrhChJ
 SPQgaFa3qcyXD.EdJKZb1_uT6j0K3mxuhGLfIlcG5vQbli2dnZg4QsKY_o_mXYkjqPQHZpvyigcP
 2XmNlLoik2EQ.rH6TDBCgm7snE.hre7Athjok4ap54rXhVTtMrKNOsPw6bwFIk1hLMmqGBpAvCnt
 zf4eNGU_wEXiSwCpbqOo6_oYDR_GXV1BeERh1mlNKy8tNqx.8mnwCVHhpVUlJ2wPoZHNdZhFVKhT
 aL1MoNY_d1wtIKcxIuY8GM.r_IvLpbnqMNxnGw87P8q176zqGzku1mpjUjLHs4L_icqhGBkRP3jn
 fw2Yh4NMv7QpABmSPEg50Lv3NjT08.qAqm95p8N3yKihTYqwycwRyFpSIKOiWbcxSza4v7wzD8gd
 Qf23znI89HQ1lIuKtBgdm1gSwHA4FlsSDH2Z.6StDEYR0q48M.byyet.UOtVcvnNIfJzgF5_vYGI
 M90R45ddBezzSHD77YomcenVwPWL6FngljMtgpb9dybzhfvlK.6R6haXpsNKZtlFWMcpdKtuEqUe
 S0Aqmtosrqz9pHUPIMxsprFclfZ_533rvC22uUVY.XyeyJg1Z
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.gq1.yahoo.com with HTTP; Wed, 3 Jul 2019 21:26:12 +0000
Received: by smtp412.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID e093f62029a4b38b2a118356b3265900;
          Wed, 03 Jul 2019 21:26:11 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v5 10/23] LSM: Use lsmblob in security_ipc_getsecid
Date:   Wed,  3 Jul 2019 14:25:25 -0700
Message-Id: <20190703212538.7383-11-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190703212538.7383-1-casey@schaufler-ca.com>
References: <20190703212538.7383-1-casey@schaufler-ca.com>
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

