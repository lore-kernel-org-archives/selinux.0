Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADB6C433EF
	for <selinux@archiver.kernel.org>; Fri, 24 Sep 2021 18:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08F7061107
	for <selinux@archiver.kernel.org>; Fri, 24 Sep 2021 18:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347815AbhIXSGY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Sep 2021 14:06:24 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:33336
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347806AbhIXSGX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 Sep 2021 14:06:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1632506690; bh=xKCUJV/noB85NzHuofJ0A55XB4HuQXNjaZR3bcQzwRI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=QQ3S+b9klZG8Yr8RrhPsHBwO2Lp8/qwf2ITsGFW8zXv1WEDyE0wV4JcopMcKepT+p5O1dWDbq1rVUHu03WXkf3dXJjpe4YABCFFWGqdjXaTHq3WWI2bGnxo4qnt/GJi9fcUgcYUadNVvXGtaJ8+Ej6jyesufIrU+j8W2CKW9VVMT39YooN1N2L57ZSiVj/nlu9zY8sg7iiprKYcuEJNahrVCMhYMUI7knUCkdKZSRMZchtX6f8rpnI4r/vOADv9z6oC1BglX2n+VLdCdN32YSgpTYOuUSE8Iq75bgf3KRF/cv/+TN/TfZhoWf9GCHhf3YFleNDO+/M6/hQNhFaiCkQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1632506690; bh=HZJMe6GOqo6ThhR/Ce91mUT+BCOkp3Hvt28wvC56USq=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=uJQL/QkdHcLIEzd8KfgUI4lqexiMThpqIIEiTgb+MvA8YQ1H1LyIu8/dGjGvmFj46TEsg5mCDeF/S6kxvwmdpldw52RwU3OCsHqlT5HaFaQq+z7Ks35FKwoDkTPZ/EBiK0Vg0Cx2ZXwhUIWByn7WOCmvVr44lozyMKyOUflwy/in5o/gW6P0K6zG37gz39jTxzbVsnVRDqsSInyaZQqZiBF9jmWHGNlZqMcrGFiwiEgsiDMbP4zgdcYkOWmaqVwwI99sJTDpxxcjMRxIqMvDsDEZfebk2ym9QJbVRelQsHzhb2ptcDmb+Tne7OErRTRfMO5vPhbFoCiEAaJc/KOLvg==
X-YMail-OSG: SVyf_oEVM1mnwrVTstD1GUT_mPueb6aBf0utDdLhdk6qFVeG6CySPpXKxGh2LSB
 2aTu1SDRYeB0j1iB2YjRqAzOd7O0ca8OYZYP0ryNjmudR7azKUD9ux6We.2jG_5z3L3.eiGbJyFi
 N3iJvuKMjw2Khztobhp2bzWG8uoVKUNrbm2Wv0zw3wbJeR2SxCiuttlo8dSxeQiZIQatfYOPL4pi
 3YeKtpkRSwWXUjke_ZO3eGBakfDMR_piLsCccOIZleGjMdHWRvU3DJrBv5yvWwvaGjm.yLBp2rLS
 s8Pvfgw1y99MHmwjBb_wh4NtriBKKcyebkJnXUyk9f0ocMlAy6lPc3nMhFDKQfVTEzMfFznt_Nhm
 .SwLWqi0ZYJVa_vBfdJjX_maURvL2mSwkpBahi31Ys02vSWTGPfWPHI3p36DXu7SlOmszN42MbDi
 uy1FUavch5HLXFv_di0uPf8Ghph1arXRYdqBvTb6Z_SO0vHisUdZIwyr3VV6iuOdWIv5l44uC9gB
 99fv.aAj_J95M_4ERyOg1Skg_foz27iZ26dULi6Jszr0rWeK9EDD3VxB5yduKP2H0kdBqGNtQyyU
 H4ark08jEvt1vFJmswL6nuClFocC6ktkSgvRq4pBlLvmN7uyfiHn9bzdTXmk7U82GZ.rX1WpbyS_
 tk6grohsYGxiBol.Kt4a8f68vQ2NgsYAjI.HVbA1twkNwMShvSl5NKXWWt0MJku9dfijpBQsd2eI
 x5lQ0lhI2pekKBUsK_8YD2SpeVmpaLlGYAlBAzsHMg8FhquzwWTXbCvJ0v64flwwJpsfe.GSQEMS
 qAScYqqWuL.yH_1VnPCBZr2R5w2.nlQMjzxrfPx22CRUmCNfJpELJqD0kjbbUY19JbEdZBXUktIR
 zZzlvqtqH87DLRuFCFdLqLjX1XaR6xwvCjsPjGe7Ph8Uc45FQxaQzRR4xjjO0m9bIB5scv1n91Na
 jxgqlRKhDR0AJRoM1xXZJ7o0ID9n1CfsPcXjGJAiI.OtsXjraU.f5C9fdp7XBlSaYvR0GqYNMUtz
 tZMmBn_GEPZGRzxhvbGY9PKlOk_Q3FR_Lzivc__h5MpVzy15D3dl1X0YNArCVj2j73Ynw.Pgg7UI
 jsNxF4SnMf_F3rO5MpCA8djks_P41mCCjKSXLRV8NGU6E0jBsXMdVm3D2xmMCOO21dF7QCXKtKPQ
 w92Lveuj69joX2D9oE9dssRUkqpoDiKOlwdnhQw1y31PVxYZbxWUJ2DotkuDrdRhhR1E726ozjIA
 04ODOWLlI.slPX.ZFhNuDb33upaJYt3cG8CPzV2m960xGLWVlZ3auMlDufkicltXZzotgalgiY1k
 j5qmEGArXaGujoxl1QXtuXrVO7NpVTQTywaqH0YI9YKTA9MmiWmA.L40u7H_ynb_WgyPJRS1QklD
 X9idInTgDw8hOlaUUKmvB73TrZFqZ.MhlPmYNS15VCLqAX_4zMzQrUuxoLop_t43ErJWC9VGE7_2
 ysJKOfVWRaq80JIY51SNW.BfXiNEhXRAT39W4KYKcOY2P60EPVGlejSRYmvyWpBIMj0MOndwt9xe
 3Mnza8itIS_asMCCiQXa6.Bf7t.5G6YC4Nc7bCXuJDt1yG3FqWuqtzGgTRTUD9v_EGwBAJUARNr_
 wImeporS1cQNtVi4TKwjKdeXbhg1fv4XBnAxwPNgMvfEZqa5F_unDNxMlaYVMQsWO6OeCXpxOABT
 .8NM46tYctkzc.JMRuyqlVuB668KogRS_p3yaEYzUiLElY_erRokHtZxsrMIY45Mo2C5MYvS76jj
 GBOlEYL7B4l1gAyH7J37xDZtWUDTolPtoEH3wSXTyxZ8uduKVy4IZ44eQS6aS8mPqPwsIioFDC5e
 VkF4bjzAEd47WQHodE.bw_XO58NiCFn5s2GqvP2KQKP7R9kLP7JjBev1wrXAROtOZUaLUPAsDGcv
 5uaswCTmbWY5oJk_F6SYjP03hDkj0T49QkeeIL6oeQMNtStHVR.6zcLh93SDQEgMCPcfy4WTu8Tr
 ZFGN4OIzPBVQZl0jKHMhIi4YL6qYRQ5l2kYWTpoz4IrVCI3bohI3muI79ihR6kaUurv.grFOqdtX
 kp7NO0tOcSzuCEzzekbwOFFSN9_4UdJ.mH0_h8kWwNhQndZE7AA6_chmcsniQtFy282l.zBEcijd
 RAzxbRiN_dwh2QF5zjDoOHmK7DI34eBnEe8Ax9s3w.5fteW2rne6nALM9zYvDe0COPcMYEkEstSy
 o8rmKjDo8XzekCM_xQoXmnwOO8i93GTDG_ia2FZ6ZWQKjEjBIkFmauqct0734MQXj3FqlEPh1S03
 vBugLA..iHNhDefJmMHNB.ufkaWYolGU39emOCK0zab9K.mndi6QehrC4EqYEL4ZEur3zIpf7qa8
 2UD8QcQ--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Fri, 24 Sep 2021 18:04:50 +0000
Received: by kubenode587.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 7b718ee39b02e3cfc6fa46b68938565f;
          Fri, 24 Sep 2021 18:04:47 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v29 09/28] LSM: Use lsmblob in security_ipc_getsecid
Date:   Fri, 24 Sep 2021 10:54:22 -0700
Message-Id: <20210924175441.7943-10-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210924175441.7943-1-casey@schaufler-ca.com>
References: <20210924175441.7943-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-audit@redhat.com
---
 include/linux/security.h |  7 ++++---
 kernel/auditsc.c         |  7 ++++++-
 security/security.c      | 12 +++++++++---
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 60f0a56f43ed..e674a6cdab46 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -519,7 +519,7 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 			unsigned long arg4, unsigned long arg5);
 void security_task_to_inode(struct task_struct *p, struct inode *inode);
 int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag);
-void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid);
+void security_ipc_getsecid(struct kern_ipc_perm *ipcp, struct lsmblob *blob);
 int security_msg_msg_alloc(struct msg_msg *msg);
 void security_msg_msg_free(struct msg_msg *msg);
 int security_msg_queue_alloc(struct kern_ipc_perm *msq);
@@ -1276,9 +1276,10 @@ static inline int security_ipc_permission(struct kern_ipc_perm *ipcp,
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
index df8a57c5355d..b4d214b21b97 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2337,12 +2337,17 @@ void __audit_mq_getsetattr(mqd_t mqdes, struct mq_attr *mqstat)
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
+	/* context->ipc.osid will be changed to a lsmblob later in
+	 * the patch series. This will allow auditing of all the object
+	 * labels associated with the ipc object. */
+	context->ipc.osid = lsmblob_value(&blob);
 	context->type = AUDIT_IPC;
 }
 
diff --git a/security/security.c b/security/security.c
index 8163dc615ba6..f6760b25fed0 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1995,10 +1995,16 @@ int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
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
2.31.1

