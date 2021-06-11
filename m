Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF26AC48BD1
	for <selinux@archiver.kernel.org>; Fri, 11 Jun 2021 00:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98FE2613CF
	for <selinux@archiver.kernel.org>; Fri, 11 Jun 2021 00:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbhFKAQn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Jun 2021 20:16:43 -0400
Received: from sonic314-27.consmr.mail.ne1.yahoo.com ([66.163.189.153]:34693
        "EHLO sonic314-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230336AbhFKAQn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Jun 2021 20:16:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1623370486; bh=4CSwNt8cX8Ya250gpC4XKc9j/Fty1srcfnNURtXicmA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Yb3YTsroJkwuq2PTZyFo4kkNSPbiGj5vPw0lgRaHBDBqbeTcwS3qb/3QUaXG4oK0867MaOK4/bn6yLosEp6HYYqw+uXEJUcR/yqYbLLiuvGftG2oms4tJ6qhz03FC8ZmNv7bd3u5jZg1W7obqMZNMdzqroxp5QJj+uRo4H1D4hWwXNFoJSKjOW6twI0jj5ekQmi4xvMqvsxjN/NnLkYOhs8HLs2oEMvg88F8RPzG1wSkAcqrAMeXJUmwcqgDBMQqk8jTzDN2Ty2i9T9QVW/VNFTubS3b8oiO4siPTfoL2VDM3+dPSBBaFHyqTK2b3xy1KvUI4lkYN5Ms1hH3nxmDiw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1623370486; bh=pjM15v3nnM9AHwzYmUcv77iMdUA6OVh6oQpbOhV2Z+M=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=VDapF2v7a7p8gkbsaKRf7xbS2cfmJ/iY2QgF3w3pJ9keXNdovLF67uut0j/XnMcewuczuZcs6GWhPLbBgh2xZu8VsutuGvyFz9QgogRSthyYPb4qpgo2rK1RQnXUVX+PHcqw1giahypmue2IAHtEvQg3ggiyTETQCpy9KhtceHiDUBXn0g9ABXiw1qjh73xngGaYhh+Q9LL8O7TfzUXh0r2/7E6yLZGdvWxZF1J6gPT4brpv3s8CRHsbrzN9Py1kAXBvBgM8aFZRvQSwzxCK+lo4cnr1juaErqzpGQU3TQLeeU56qUQt0+vX9qWF0m2KZRcMkTdRP4dwW6vWUO4Vlw==
X-YMail-OSG: ItRF7okVM1la0KUn5yVb9tpf3baLhCVA_rJVO56yT0zAGLEf9gqUuY8sz1rc9_N
 4BZS..57.40mGX81Klee1evdckNb6VLujTjY_2rwPxCkJ8Fdr1SPW3gyFm2026yf97bKEzoqAjom
 l1lGC_ELYu.FB4MHOEg1jf62RZKQNNen6P3.72svsNfkYKR8IIKFyfv5OA7YL72_JyOzBevMbu_8
 QLcSqrNhp1AcnxYaSLnVbhYvFxg2Cno3h2DZYGtUehp4Xix5JYkZc8QdVqVsvX27f0R8uaZrYNGZ
 HOEmTBuOpjw3ddLY_GvnGTNt9qX9dVj4kBO7Q5YA488.66gBva_iXJDTogjpP0KwDXeBttq2sZKS
 O9_HsdPCZLxS2T3CCvYRiqDnOj4MhBWNEceU2Ms5vPtaK2yala3hi8XMc02blu.sHnCHC1DK71iq
 LLCnImv8qWO38ZSLT5GT77Czk_1Hn0K9PjgPBYCzZPzRubyFVMP9vZ4kGLPy1OaMrA1.tGiW9j6g
 ZDQhyX8TsFGqN.GlfQQCfE673z6kVQY1u5hxfXESpfpe0MFeYDlE7D45ew9ELWWa77cBcxvvs_yc
 66PbvHFOvS.fe7C..3B_CLUGPeWhLcadVyNItzN2E.o6.Zgwx.pdaV9yhpCwDjchMOEx1_yZxxPP
 Zy7_ON1p2LK7uKna284CByEtePLfWDyX2.WbzpcUjG.f_UfCZecPRzQOzFvVkR8Bj9v4s1ID7Yin
 Bhm325.EIWjqQYmzFH94PkJLCt5E3dm3D8eJTJzv1zTmEbw.WQOAiwDuPn_AEx3z6iItR8Lt1GZ0
 G4CpJDPvRqL_1YDuZVFTSFgUvb_LcExXVzlv5ihWFSH6pkXc6pOFdkvlZQFKudJ_j_AhFy9vOn9h
 6E_B76ac6wPJLbg6mvRFHaD4iRUbrTH21zlg0AqNUvJG2G1RIkZziw5Gd5gjOXFWaHDywaBvpmm_
 nOWrZp7UK2.GNMnKRUsYghABQN.Hba6vIK0BFk6dW8BBHypEzPd10wXU5PuntMA7gxwcQH27cjkz
 Ox.aZ3z31sKhMe8F7X4aoofwKpmLX3ZhvG3__Dlr_fxX_eHORYYLJb6Gk4ar_HsTYLJch5oTbVtC
 y5MMi.6.f6yo0n5FzKcyX4WajBn3nAXHTw0Ch4nXeDx5f6D1jYTkw7bzeRl.oEgS3nsec64lgM0U
 Nbmj4eVHzY0AQq8_HJ_Plwp5qv9UqEt3xYObR0YkeRw1OtklaHbVXmYTT3wQvzKl4tsJ3Iq4LJQ3
 nuVy7oe942iEw.fcGwNtvgabdJy17eQt0EFCTJgG3TJrriBUB.dBeIyCjNO53IomEF8hUoH1rbKP
 DubnSx0J1vITB0YlBS2WXZpv6Gy3QrobwyMS86siXdWOHG59uaGKEau7EheFTr0oU9TeIqjEHuca
 m1HJnkbns51SJP6k9AQ4JDH74l7GdGCK94HJ5pqE_UxshR_Vamcfdmnr1V7dMnr7418VY6nyo4I_
 pKbHr2vCAFQ5I0O.a8S7l9SsUEPM3_xrbwON4tT_cSqKsXVfF6a5dJ40UI.7oaeCFtcNLbe6Tq.U
 pfdOzcQSQId4hpJJ.qd6.eeyhZxd1Khp7s3P.aLx8tLSbw8Tlgj9OHfh.yHfAC1yPmZGOzvvBjq8
 nf9sgFQ16kf.dypsRrKHIWW7sUZM1mtB0_5s3fyjzUXF_l4SbUJvCCrSUTEfvL3S8qnlUQpZ0kJt
 7A6KVA8pK.KE_SM8AglhKFCV06eSwOTOj5CqfCgtvOZDYBXq6UE3cHOXolTQmGIFzU7JmBB.cTaz
 k3IU7lUATrhDM3vyLDnawNPjQjXsWp.HlLlm82N3QIf5fNzmkzmXroYYRp3gOJ1OIf05OXigIC2Z
 oPKbJuQU2kYvGsg3MiItI9WZtIvdP8XVQ5QqBTumFdeH5ZOk7ecneXToXVdTbKVZvGm84COvmLfV
 .MtHWzIHhsvo2JmtW.WlYC.HptHts503_zIEF1_TNDzVbaD4_GPIzx2omx4vQ1XtR5EH_ImYBm2s
 uX.wCEli8CGkNoFtUaVZzxpsnJhSwb3PCb3hXAtEefGJwSnR.tK0LL7UYBXdGv5MxqIdib2e6A49
 _3sq461.yi7.6opRDUSfV7Lv41KrHpM48824mw5YzEpq8QYNaNjeROiFZ70HTUPwXSM.8CNtNP6B
 BlR6hY8M.6OoBvFSGm4hiZRomqwgUFRlxuQwfQpCrmXbs.xflCtbvlwJZrHscKsRYQcZTVevwtSp
 aHT_OYUUR4k1Marn6e5RmADJG7E0IgrVm94oKKt46nlS5rpb6J6NvycDQ5G68yLNqx4CD1_CP0Z3
 3DNqAGVvidSnc5vjT._oNPE7vpawEmB0Dk5w5Dn2Z.S4Gw9jq5dJ9D5fEEzPpdZk.Af.rB.VguxG
 5af985WeoRXPmEbq0mnso7jCjervPw5fnvPZ7NRgVEjSpNDxj159EdYeQ7hIBt_RVuO1J5eQ2joy
 6i8.s0duT0xULV5vj_5R3Y4DjksR6ep8eT2dHJqawiWzNw5o7sOVx7sWa3qysFIWud7G21L_fTVT
 IGHxd6gDnvbVs96FIspHw_zmp6NFxyxZN4xAnWfb8qhw4U2cQTzu3ZlzUjj7HsvdRwZusoCeUcY1
 AwSWbMJr5xMYiS31VIFGjbvgUJgvUMRCZ4nGgFhLK6dCHzrW4QM_Ab9zC1BFdqqZp4_oCzPpjFsW
 nZxg87WpzDIDaw9xxxC_evegU4UBpZr9Rf_sHQ6tAALcwpeYIa1eAOAuRUjvuV.Lk3vrfu1Yh7zI
 95_3wa.1kxyFG0w2X3gKeG43SmpCGPbtggJ__Avmfi1SYJkRBpCzh_5T1Uz7UhqkSNpD3.xZG_zV
 s4rm2osHsu8HjLVcSrDZ0quUJnN.nw1sDu8kSuN2Qgi2_2vz2hrdfb0pCm2R9axEY73qvahkDKFh
 0jUdoB.XlWfXlTVp_MenWsyXSf8Xs2io2BjqF6acMwrE_NmVIP_RSBjajLcvbAIBoHf45J2mLkMB
 Uxa2MWjxAuaUDsuuhG505ZT9nWJ3RFp_HHa98.iBJo.blaRkOBWW_bpAesRT1G813l90Nsy3DXHd
 wzVot5BPVuJkBapacFwpP5.PW7OxUwCNn2J.xtAtbN_oDKe.lNqmdcVp.2UOkjlQqb.KnSnHRvLj
 4NkxibQKQgI_3sywXlMtOVh4hw6anLKmmE7E-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Fri, 11 Jun 2021 00:14:46 +0000
Received: by kubenode502.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID e5bd28fb5138e5dfab52d7da1cc4d427;
          Fri, 11 Jun 2021 00:14:41 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v27 09/25] LSM: Use lsmblob in security_ipc_getsecid
Date:   Thu, 10 Jun 2021 17:04:19 -0700
Message-Id: <20210611000435.36398-10-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210611000435.36398-1-casey@schaufler-ca.com>
References: <20210611000435.36398-1-casey@schaufler-ca.com>
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
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-audit@redhat.com
---
 include/linux/security.h |  7 ++++---
 kernel/auditsc.c         |  7 ++++++-
 security/security.c      | 12 +++++++++---
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 5a8c50a95c46..bdac0a124052 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -518,7 +518,7 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 			unsigned long arg4, unsigned long arg5);
 void security_task_to_inode(struct task_struct *p, struct inode *inode);
 int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag);
-void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid);
+void security_ipc_getsecid(struct kern_ipc_perm *ipcp, struct lsmblob *blob);
 int security_msg_msg_alloc(struct msg_msg *msg);
 void security_msg_msg_free(struct msg_msg *msg);
 int security_msg_queue_alloc(struct kern_ipc_perm *msq);
@@ -1275,9 +1275,10 @@ static inline int security_ipc_permission(struct kern_ipc_perm *ipcp,
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
index 6e977d312acb..9aeddf881e67 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2323,11 +2323,16 @@ void __audit_mq_getsetattr(mqd_t mqdes, struct mq_attr *mqstat)
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
index b0faeee91d02..7f722ac04d99 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1994,10 +1994,16 @@ int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
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
2.29.2

