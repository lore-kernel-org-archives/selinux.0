Return-Path: <SRS0=4d9t=ZF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B385EC43331
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 00:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87EC22196E
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 00:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="CZ5mY4Hy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfKMAJy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Nov 2019 19:09:54 -0500
Received: from sonic306-28.consmr.mail.ne1.yahoo.com ([66.163.189.90]:45331
        "EHLO sonic306-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727185AbfKMAJy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Nov 2019 19:09:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1573603792; bh=DNCo0JuQorE9PAmGgQWZPLTpILlPu5l/KRbFUnDCaw8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=CZ5mY4Hy85+L4SCcWzdwF+xe6YjrdJ8pNSzOQtNuen15FYfX3xgwUI4JQgSTD757CG8BljzOkL51aMA8YLHeibjWROGOgixeO6kr1YnSFTsNCjOuDcK3PRlZKdQwIvHpVWssdr5Mc59E0DwNrU1UKsduVm9Y3z5ALxjwS6uSn5SxXLGCGEb7B0VCTiSG/9moZJYehsgneybA30P8BqK2E6p9t9TnAUBJIRJFt0ZTXKg2Mmq/Px+pEf1Q/uPQeLJyUZ0bvCy2Xk171xLizlV2kyA2DblN8xXygGMlF8wt4WyE4IsDbk15Z/6dk+gUyepll1Chph+TWdalktjdbvHkvw==
X-YMail-OSG: wVt3b2EVM1lTb20fAdzJnVQrO2OioyTMp2HsxdhPfL97v.l4L4jlqeQpxgV84BV
 320LH7lxbsKQprEGwm2JEc9_gR5IAdXpKYZn7yJ5JWAB_I69P92TXo.d79y8ELk4jNLYUB70ZJk1
 MTAlTf4HIHoQPxR5_u6RDIJGfkxdy.QcMtpxvpK6vdnXODUBUk5cjXAfWGBobPGoLVDt9eEQQYUM
 O0i0Gi9rRVpcaE2oiD0q578rxByr9zz3oYI0g5h96lR6g_.TYQt0fFNBt2wsmI9EzFGSpFfthqR3
 7olofh9mAqBirrL0UKrGDAJ3Eki6Pc5zNEC5WI1vbeMHOHSbZwSuSS73O6TmKmTvGIu9yHhwzXc4
 ZxqYUCrz_.r1.AmJ9UAmsOUniEwfKfVo.YRF7mBXCgEB6Hbr0Ge0W_isq8.3SYiSgJyC4nJnzQ8G
 Cz9fWc4wdrDoyq5GJzP8AY3oSsNg8Cc9TrYQadMU6wYn3AqjLsegdIzn3I8i1H_egrE_VgEStAM4
 Ev_aE.TBTmRyfn.TJFHoJkfJNTx2ivRQ8y_otAMCBcEcStkhR5bWKAkuiJSMa4k93_EPbDDsllOk
 89WKWa_dloL1dasxOu.wazj_Ctg7TMGsO8PM1ss565xt4mksrLUYWzRzS6GZenHMw0olvJOt4zyW
 bU5U9ED65V6p.IXlWmmbwTR_MbtDLkE2mBETy7G_E1pot4u7Wt5K4bk2SYudOMi_fi1Ma0cTWpv2
 G7rL9t_oLzEZMXaF0zlnOcT8a1agXV5ZF01EixuZ2N2_mXWgVkMYU_yxKtdb42aKLzYo9sV5Jt4B
 80zA0xvPyHko4mar9E2Jnr__4MqyiP67AjHi.WyWpUKLT3PWL0ucu3DvxPyjUUTnLNA44YdeUHvg
 SgwEmGrPmPFrFUhvDUzhu.j_WAqjsNh9lq8Z1evxEQqF8h53Ujy3ysIyG1fYGvheI5TmkucMEmjY
 H83Ymr7mzrJ_rmOelF2Ikqi8VUe7xTKzMC0ebAhNtTYhsxMOLEjy7nGg.4vtYCx67uwZ03sAal0c
 IRPtMXwNSyhsi2YgQo8PbcSHozaK4XHI7QeSMFgwIQoKFFzg5zCmo6F7UTcQyrUjcgnopflPHbF5
 0o0nV9LBQPbv__qZf4am8JT8TpBccZLDnH8_uZjpYtwREu92iDilkwgtk3LKLccNtJ4iP3IaydCa
 qB17HUIowWn5DggtVzv0EJEc7JiYxauNnyStRHvdY8zf.bxXSRZ2fwZ2tpm9FsrCi0PplN4SLION
 eRAQarN0ENpVBw.NXvgkHZPSQGbahCwGHbV0mpB4V.oPRul7fU1HOrv0zY0I4axWukNgaLLX7hSY
 UZgOVEaGtnNA0.ZvwfQdNOwB7mmtrELB7SYIkEmc9i7m6mZbWNKKbV2bVgkRFAfwqeiYHpriZ61g
 6fp0u3j_D8Q4O0jgoEk3fVZyygqJWrMea_Q--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Wed, 13 Nov 2019 00:09:52 +0000
Received: by smtp432.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID a194c842b715663bc900de4e5d395aa8;
          Wed, 13 Nov 2019 00:09:49 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov, linux-audit@redhat.com
Subject: [PATCH 08/25] LSM: Use lsmblob in security_ipc_getsecid
Date:   Tue, 12 Nov 2019 16:08:56 -0800
Message-Id: <20191113000913.5414-9-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113000913.5414-1-casey@schaufler-ca.com>
References: <20191113000913.5414-1-casey@schaufler-ca.com>
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
cc: linux-audit@redhat.com
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

