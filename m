Return-Path: <SRS0=cgF/=2P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE3DC2D0C3
	for <selinux@archiver.kernel.org>; Wed, 25 Dec 2019 00:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AE89206D7
	for <selinux@archiver.kernel.org>; Wed, 25 Dec 2019 00:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Z5JSoucU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbfLYABD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 24 Dec 2019 19:01:03 -0500
Received: from sonic306-28.consmr.mail.ne1.yahoo.com ([66.163.189.90]:44475
        "EHLO sonic306-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726258AbfLYABC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 24 Dec 2019 19:01:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1577232061; bh=5oRGhxeengIqekP6bAeZ94XlpWqlbfRNdfUOT0IQXWo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=Z5JSoucUcnkNQtFRxf62lm7eyDcr+api8YXbPhEi88vT4aDfUpY+b1ucyBZhUU+kSzEPRvaQVJvO9uqfoXw48XN7kxN7R9O6Uwib897hI/2LnIz5EcS3oAzHZJTkn6Zz3zFxxEUb89zaqZHsJumavI36nMcKfkKDDTlqftoBxa1OVMMO5Jq82GXH8EzWBBxR5YcOQWbiuUOEVOec4LDoKVn+ZuO74VJS7D0EnJggv75MAvHmAEk/7+qM4xqD0XRG81k4H6LJRmCey3yZBiUtBlXiyP8W3cw8TcW4Gkh9L5CDfFermPCiE2FjTzInVCzzVJkdHR4RrzyQNqtVopWEWQ==
X-YMail-OSG: WjJmT98VM1krUlGC1j4ZKQFJTeWvNCwxRVAOBIdGMYI1w4uRcIDZW0rBzInbYrZ
 ScJYbXAocADuFdqjwW2A9Iik.atOU6Pdiw_9yqPRmgbhT3Bn87F9SgIqZuskCNq0z2UvxwMfOOPT
 YGO2kWAIbLKbJjjdXh3cJPNzYG1hmcJjsH_sPL1KYRXBnPcc0GQhRrSTA4kQqWnMoj6VS29NZfH0
 NxsjITELpWj23gd0bkFM14DCDUqk8x0.mQsyCpKaN9MyiWpMZzthFQ.thUoURSW11Khybr0Psu2u
 4IhDyN3zrDJ4VwddCaneEZmp12kF6f99oB8STIdxUkCsm6QMU0t_d.qEKYTe4oXMP0_.KKogeN4B
 caYma1.jtDjKyttNuHmEPHdo1ClBTzZeW24bpzl16B.VjqyfCB93ZhEoe_3_98ccE6lor9WWPrul
 LIiFw0HXhl2ydV_20SsPVCXaCjjTJAtpZBGu_WJSMCU7bdjWp.pM9qSvNznaeN8LoB8ktRJaChuv
 BVvKIMqLJHv1vuGfdEu1.d9cJAUKoh8p8ENdMOtY.dgUtvWtUeYuvh69jVEg9l6X79nxZVsAygVq
 FSoWBt9bIacnR.umZr3Iie7jLvtpw.1cvPkDCAC5brk9BQON0fMJnNRrAPQuEcD_HdASQMDIKiDp
 wLRyCcNPdPP27IkHR4jfiBCvVXGikCvIM0wmLxD2eBJP.OaLUchFIlciVN7cJBtDHD4zPrL1flFD
 mcTDax2AMpbl2zQXr_dWS7Pcg_bHejFwbBgVJT23omRyEE5DO.9MEELa4fACmLdEDK1tIhRiSa7O
 _R.qvauKAa8TIlQ3v33wIiSVxdDZF2jIrfCYoP70YnfUEFrJu6n.YhFHLUZVpHG8XWwIusdDqof9
 QLa9MokHkU88Dns3UYQqx30MoF9Fl_X_oQuR5tCJGLQ18D_nneEZuVM48LpNnhMj4RvyL6ge69bm
 6Z2L7ypHxPE_0FojOQxHGiJ0ICUYX2zAfaoeHonkf6wDJ9545orwlqINCiaL_cXMF5rE1Ofl_Yzl
 QMDrnOOZkUX6QanNM0DUyTMMFLNRd9mIlHrhPW_Os08XLy91Li_i5SDZh7FTBgX2h8t3SwnOrjYv
 .HLp3K4Ddb2qL6X0mk1igk_RQL682A9T6oyH2c0gM41zgKdhgSvpcNX_o70zpKH2GPKa2dNPz_yi
 W3B2t7HBdR2sSYL2wR.uDZaVj5zIJvGae_SZYctQDFzgYvs3NS3kcvaamJq.2cq65PzTlo6rr001
 zIWQKdCJD3xBLTYgm4YUBIO8d3O2vRAmdIddFTTeG8k3pRmIc1FLXslNghGkbFTNRgeXohxa1eIA
 vhmbKFOX3vHvo0_tiaJpZnHIwqj.rUt7bzBEdJwZ6kjr6EpAz08F5OEcBdKnU900wWJsoIGHWqdi
 X94nAa5hlfCpEXIvVslmrcRn4oWtmu0lm3IxS6e_wK_bqeTquH1qcy1PKBO306M2QXvyMbA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Wed, 25 Dec 2019 00:01:01 +0000
Received: by smtp413.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 09b2f23d3d5d902a4e4f9c7446ca66df;
          Wed, 25 Dec 2019 00:01:00 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v13 08/25] LSM: Use lsmblob in security_ipc_getsecid
Date:   Tue, 24 Dec 2019 15:59:22 -0800
Message-Id: <20191224235939.7483-9-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191224235939.7483-1-casey@schaufler-ca.com>
References: <20191224235939.7483-1-casey@schaufler-ca.com>
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
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
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
index 8a04eca716b9..793c4ee0cf4e 100644
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

