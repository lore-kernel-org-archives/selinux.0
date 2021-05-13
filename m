Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DB2C433B4
	for <selinux@archiver.kernel.org>; Thu, 13 May 2021 20:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3808861421
	for <selinux@archiver.kernel.org>; Thu, 13 May 2021 20:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbhEMUT2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 May 2021 16:19:28 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:36486
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232513AbhEMUT2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 May 2021 16:19:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1620937097; bh=Ve4ALtoFmy9R8CyWffJ7m4ih0LsnI6GwrPudCc/yRhs=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=bdT83/q9vZu2qsh5dW8faYjNcQYTRkqaZwDvyDTXtXlDwt6jAZ4UOR/uL1LSfHxmLlWv21Pyl1r9DG3hjd1WHWd0zQ/Tw5m04jZxmURzzBYiIA0lOv4PpLmRqI1qVWokJoVeGVVRIrs3NIqneyjb4PgCanF7JByxlw4RTCniw2hzF0FpMwTlZcpRPVP81W+AxzDRgSUcYkY1N1xD/45Y+j0A5FYMlrDr4w3Qe43s2yfzqaoDMgW72shDyg5gtBYgqup9+61ownAeYyLjZSA9cZw7rs7PllDVAUJE2fyO4ZhVYeNHKqSrwlwQzHcRyh1TC8gKmfA7lZTbtLUDh69FKg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1620937097; bh=+SH6x3rDbBj5vk0f9T1wUAaDH4sKVPXfrjFBoxxCfyS=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=VtjV69oV43EtwlSC/GwmQnxtkBbPISZ7pZ9/cIOfzgFgdV5IkUfxx6BaH2le7wvkyxjO8KLjUGns26MkvNEAFdNfOcp/d4J8RCI47L5fi5APLAP0up5IIAT00jmSVhVjwZOflGynpID3rbVsx3jm0Eql1EeVKZAmvwRWtUgpWbgw9ztV7RlxfY9KHmHJa3JMVDdFBGb2uuD4Jq+pGgF3FadgDYiiLaBOI56TEcvN3dYST36f/TVWIEtE6F2Zjj1w7504YV7j7GsI1bHiLuhzOtF33u7K/6JjXoYZUrfQFjQgT0Obut9FDu3qZ2WiunQnVVjc8PYxlQSQ4crLrUglaA==
X-YMail-OSG: mZi93_MVM1l4bb2HCmkFg47zP7qEf51UygyeMwm6bOp0J7YRuYBgSZuEJDshlvg
 y_WuPPLL898z_JAF8BJFzc6eXe8HEBUyWd7dpbwF4fDZ1XisVMF9qfUEAA3OVUXHt47YUV4BlYSf
 AnwBYuHqb9F5LA0lIw0JJvrN336N_5g2xQUXMAD_PWt4O8a._U.T3QeUXjxCy4MfLjU.NrUcagd4
 UnUsUK8_VlMKmRxzL0EEaYpz92NrqLdLmbt8Jpii4Hr1EXRQni8XFtpjthDS8nVqdHr5aAtldtza
 WSG0VaB.k9X7SifL4OUfJFoOhtJDxoFGKetS4cv8qn7PPFm6Vh50BWJiPx_iCT4YVaGkmg_DnHEI
 xPu3vC2aE1UYXml_u7b7y2RXI8u3OS_NDiV.i6giVH07QJUzr8HI1dNwB1eEw2faFf2pYtkaaPHZ
 iqaq2WsM2CH.ANekrA.a8GObb21bV2KinP3JBeK20N33YElBHzGEWJpUOBAyp8ao6Il8aMOIjEDM
 50BNdOP3AL9znyi_MpNHHlVRpuIupoVH5enOvy1cXmrPW51bZOdICE6qrbIZtLSUq4T933S85H61
 2BWXOVv2Mv45smwQAWmCQN8mnOBHw7VGiR.ruZC5OvpKOJy9sohHZG7PhotkOUtdnYVQDQo8MwLl
 Xwz3GMTIlbyEa_zwZmxObZ1lG5aibocW_x6x2Fovyt5vhhrDGG0RZpUQxjbPe2Yf5Z.G23xLWVEi
 qdqEH6Y8T78fKTGJiHVgEsXA4kxJydSp2XXLDl5zqOaIIS4LrI2DVHyaaUWrtQ0Ebf0OEItnMkhJ
 TMAOwOJTbP4lWmuDcoG61Xrz8PLUm3bKBc06MzLWRH2_qrnYkgK4tNh3mBRiskr74nTZWuztXgwx
 Di9I0BzrbzTYpPlZ4sAB779Ba6kz9wpFJ4fsZ_EsX9RzflLz_4q5JY8SBK3HukqNIIltQZ2AWjCX
 BT3IQEywNgzCE3Lklw3yyLrNBygOujEvaaUIK_TAPFQrtpJko6Tm6dIMoHO0gGS_Umu6X.vCnnp5
 Wz_NWVt9tROFX89nYiViwdDegzNkBOc3oQ31n1MurLJT32rc0yuniZwk51YxUHyiWDbuTxyGjQbD
 r6YJppJcj.wqiwk4cN5JDLr4Ar7IPx1.jpWnO_tYSLVZs79N0UnVKC8leRK1inRQyoU7p63AMUsY
 lV2rUlqriGUyUGbx6w3jsTMPFqHoNEG03aCLysTxVbDBh8X4FB9rfSu98eeo25hjxJK3clLd8ums
 eOpdQaM60YbfRs6oyBF0wUB4MPwxgvu27lBMhsCKUGRlMijjA4ZE4CumMtzO6aU8Q_iffXUHwIAS
 IcTqhTY_GRuNd.IPDQ_HEfIP74f5VV_tdo5.pWcI_XAH47Nz_NJyBt5YyiTrFFeo3I_jOgdk9Ysg
 Oq06Vtm.JRJB2BpVlyYJ5ctoOyDQtxDoSvL55VrLYFtUwLokrGbGx77ER4jTEZnuBkxLNU0I69Q_
 NmHJAjVPf6Qvx0cDvmlkjLm3mMD7l7ZFfYUpY3JEH1DlbVx6Pf0Jqomi_vrAbix2uWQgw7E5tPkr
 tNckdeoUtxiSwbVk28GhEMBx7LOTIQbpWiptchOXDGn_ZaXIQIG0XhOtFOLMKwO2LCt0id7YNyfb
 kqJFHpMm0Suyh.TNUPtz0D711OT37QtQrnXaaAOaW2eZLqJeoWC__mSX9JtnrvUcipyyZJoCC3zW
 lSqlgA2UG5tpoh.XL.CFxrLbH3k8_64ZurlUhN73FK.lAMRR7p_e_361Ee2KRcH689ZG5s90T0vu
 C9g_vg2_widJ85S1wAsmpScA5T7L_CvgL6KProxbjuRrUUA9XAQofKHN56Hep4OgqqgZsbJEE6ij
 11A_FnmqrxL0Hy_8ZJlud8ROhYeA8DUyPuPVNUY4WcIK_3n3Bbbmqr7oz7kJGOd6JdJxUvWtacpM
 ezbda4eajQAE9v4vnPhwVzJT8l6sG9L7V_Kia5pwiZhih_V4picLnOCpTrc8c77leggth7YCGVRp
 r1lwxGQzy3WYgyPB7ie0pt1M9COfAHUKpiFMhZMQWuoq.ptcC.nFjfURcL18CMajdcBVYY..Ij2G
 FiVDEiK2dWaTy6yGI3HO2wIvjCdP2iSTSrk7SP5ZFtcnWIuyf_OwGf29WJkN8H4QonYqUWf6bd0p
 nj_tpbHm.KtlT1.Rfn7aCxGUUMLzLgjTR2NTVerN_jGjVeDnuz2KVcvDKZARcGVH2QvKF3ARSmJj
 puajeq8x5KuCcPBkKo4KLhgA9bDyu7ySXNWWT8sWok8rPy1edubm4bikjAuKxR3Kvd9hpIoCiovM
 .10WrrbKRy.8SGbeZ2zh8g3CI.SDac1Pj3Mkj6eagluM4AXfDDZx266EpWPZq2.MxZOl299aavlG
 0wN6M5CXDLFq_H8LK4JYMbM7WGB7Uwcr4sPvEvHI1_BYIUegWBIf.yRT8n7SsUPVQUY.Pi4BTZSt
 JRnigCq30hT6apoSTDNm71YZfNIorWawaqp8yqGPKaBORlmffZ6azZ.FC.jDA4tJ.ezjzmjwN.w4
 Gl0cklyNCyW5u3CX86oVm7y2pO4Lx_S13NxhMG2TUani57PPv6f9gagd71Z7gzfPwzozP0GViZOz
 lJe3VsKzGt2qTf_r2vXJEOOgHhSJVobbQO80QfjFd.wy6y70mKHUgwcUaCuAc3KwLIZwa2FVhWfH
 VdcJbyFsOHnbuMs1F6_elwB29P.2RZFM4HzrLb0iwOOmxkUzI7Ckf0bOryuThJYjajy9IvMmbwzK
 ymXEEE501bduhS1tsZvE2l_dU8ZbTth4n2jKrdDZVsPZ.YsJ4hiaHvBJm6CWG67MvmRKpLRAvIwN
 cu3HGLbL9DNubh60cJaJGAJJ9T92Dw6soorDptEwji6o8XR9jm0rj40RXghZvOHOQPhLIt4Vd4Gp
 8UN6O1MAMNuwXXgnn7ozj9H68AddgyXhd46_BwH_zAxKeNZ1Ee4KZJIboaoKaXJUlsu1Q0979Z3f
 Giwbsal4V4KbYOS5RkiwrVbG5B2vnVG9NNwwShuZcNQJXscePoRUW6Xw0LILT_Lr9bBK63mSMNia
 BmpuOYP15QSQnFS_E07ar9rYf81tjM2JfsdGn_TfK5blBUJr9rso230cIc9NeJMoEeE9pRais3rE
 vgBUQmXTR2EnHu2oq73eTyEnkfBvJr1zLVtNs
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Thu, 13 May 2021 20:18:17 +0000
Received: by kubenode512.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID d77a90177361f3e159594f3c8e3bbc3c;
          Thu, 13 May 2021 20:18:14 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v26 09/25] LSM: Use lsmblob in security_ipc_getsecid
Date:   Thu, 13 May 2021 13:07:51 -0700
Message-Id: <20210513200807.15910-10-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210513200807.15910-1-casey@schaufler-ca.com>
References: <20210513200807.15910-1-casey@schaufler-ca.com>
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
index 67140d6c17a2..0364531d92cf 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1992,10 +1992,16 @@ int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
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

