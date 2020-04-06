Return-Path: <SRS0=MX5b=5W=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483C4C2BB1D
	for <selinux@archiver.kernel.org>; Mon,  6 Apr 2020 21:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A3E020768
	for <selinux@archiver.kernel.org>; Mon,  6 Apr 2020 21:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="KkggZ9+X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgDFVB4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Apr 2020 17:01:56 -0400
Received: from sonic311-30.consmr.mail.ne1.yahoo.com ([66.163.188.211]:38259
        "EHLO sonic311-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726421AbgDFVB4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Apr 2020 17:01:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1586206915; bh=MHI0IvzBXdpPtoeU8HsEweqySq5ScLxvKrqTpMcFywc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=KkggZ9+X5VjMh1g8Q6qbSJ5xYfj6U0jDejyUI6AItG0lC2OLJ7/+KM695oTASRta/ybuh5qCkQaR31IySteYz1qYGKaMAh0RaciVUOmudYuO67jpeTGwXTtLXcplkHbLs/7J/WClfRXRPvevtYLd28vTfMCRgEWvLI7m7Y+hbm051mn2cJqcJPZMWn9L93OmMUda+TcbPYFW57Rc/TNrVK2YKPzpu+fkGIcb6YYNcl+OYo1cgQgzQLMvbK0UWCh7s6+fhSnY2RkLcCbj5S7xx12G9CoLlUa1Iu9jUqZ7722MPm7GPrOi9BbQozWfeCThn2wv+6yNiAGDjHLpa9diIQ==
X-YMail-OSG: lDLCa.MVM1kPRzoaugJ64kJRdUnDDxT8z5PkXjoHg7HLoG0Adt44WMtOUY1g4AQ
 h.1L2N562MYXF2eMWhVCk7ruERO1D7zlWSfphBo7iVcU5eymj7p2SI7O6FQ9gZEuYDTnpHE5m2m1
 0FJ_KBlEp12_Y61HjwJBk_nUHkUCC4j4145pi.BGdYBsw_l5HkpBQ6aLqDAA.b16I62HrB4SOb6c
 p4TROSoUEaE8H9YNPWoznq7Zmz3DM.swoAEgfpNkWAzxd2du03VxD4bpS2TpXYpeDqNRCnnltVzp
 eWoC2p3ZWN1TD3fFrWxu5hA9lftmVGRRSxZ1QI7zKU66NJ9W07zQ_AIV6Wj8QQ1GSkM9UxHSWPjR
 LtMU32VnYcZpalx_X6aLzijAJcDxuWtDfs1P11VCuzGDvWhy66mmJkC_F3QYm040l.bykavdNUaR
 X_h78jSKRjyXj_OcOxoFyPJh6Em_qLaSV7N9IlOtxIDPQkfGOj8RzaNfcYa3chBgMGiGA2UZCj9O
 2zcnENAF14epig8NohCfsNa6.MSN.AHUbBF.egZGj.1tMGdhsSYCOE3z7AjvFzWCwDf5ZslDqcg2
 zrDzS6.sqDIMIjuYj9tsPqY8xRiArfmKChZeCeOvNmTKhxeejhLR8QSSkxCVMBVGj45mIGjkJIAI
 _uRK8elc9yVEH4hq80SLiTLHcQCMuGot4q5xtQDLK_Z7OT9Ge7B1932U7.ITx.g8CZtyhrQVgc6.
 uLUrB5wR6YiAwPo33yLEFWlEqzklH_l1dP6PV6opI8Q0eE9mjUjNMwvn1E_fMJbudN9EmOQ9TkTs
 xIFunAQ48ERofi1JI1k8_3_PNvN1IM6zkqyv6nDwtD0owZPQR8sWTTiJSKGP3EvUp49I_N_EeRLi
 aBFFWnBWJWYQZ5RP8.yFI8PgY7op0ZFX3mB6GUqqGORQigPFNQvD3zhDd1KshjpfW5Pne5uuiQ.8
 ie4pRygQbZ9bGMm8Ljr.A8Q5kNxS3G_FQZjk2ggP7H.Qo5vtVRh40M1Aq1Kvs7HDzBXteuLAPUtv
 s2ELvmnoaYU2SNKnF0CruVOEVCZD05Qibb2.YNiMKcsHRNUvDdcEL6JuDZ9WKPh.Fz04kh.17Cfr
 YqeDRvEQRBRjUIzbuEcmqrqiwhc5yQrm38EV9oHj134_KZLNgBwMNOJGFUXDr9m.iCkX8zH2HzEg
 cKcwI4ibfTjS_i05S2U2sw2QNiKUOtaXDyeXf0ZkmBQXhbVL9qibj0EJG0rh9tBvrFekCGdcjoJ1
 gQLCTlvdLoqNYSnMu05nRh_VTIIDBGcmFqZtTkpJmebabhiekdk4Tbfor9vDE7puYVfcPYIwvnAl
 m5vnFCQOEnjNXR5xGX3vbyFTEyovWxhf898pimx951pDItA3jOC2iScYr37gd6SWaVNlitiM5nJa
 satdsg.4BRxKfU0zLBPInE5WL8AMRRPTQa33WrUPqMOQv7e1cBiFKfYkRzODW_TUuyF5_
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Mon, 6 Apr 2020 21:01:55 +0000
Received: by smtp410.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 7c203c6b3a5ede762d0a99e279a453f6;
          Mon, 06 Apr 2020 21:01:54 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v16 08/23] LSM: Use lsmblob in security_ipc_getsecid
Date:   Mon,  6 Apr 2020 14:00:20 -0700
Message-Id: <20200406210035.42547-9-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200406210035.42547-1-casey@schaufler-ca.com>
References: <20200406210035.42547-1-casey@schaufler-ca.com>
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
 kernel/auditsc.c         |  7 ++++++-
 security/security.c      | 12 +++++++++---
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 97921325b2e9..10c607a40057 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -489,7 +489,7 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 			unsigned long arg4, unsigned long arg5);
 void security_task_to_inode(struct task_struct *p, struct inode *inode);
 int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag);
-void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid);
+void security_ipc_getsecid(struct kern_ipc_perm *ipcp, struct lsmblob *blob);
 int security_msg_msg_alloc(struct msg_msg *msg);
 void security_msg_msg_free(struct msg_msg *msg);
 int security_msg_queue_alloc(struct kern_ipc_perm *msq);
@@ -1197,9 +1197,10 @@ static inline int security_ipc_permission(struct kern_ipc_perm *ipcp,
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
index 56cbb113975a..c5aa1f10e7cc 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2299,11 +2299,16 @@ void __audit_mq_getsetattr(mqd_t mqdes, struct mq_attr *mqstat)
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
index 85751ebe8842..776f62291b9f 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1815,10 +1815,16 @@ int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
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
2.24.1

