Return-Path: <SRS0=MX5b=5W=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C8CC2BA1A
	for <selinux@archiver.kernel.org>; Mon,  6 Apr 2020 20:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDC20206C3
	for <selinux@archiver.kernel.org>; Mon,  6 Apr 2020 20:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="pAseiCvD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbgDFU4b (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Apr 2020 16:56:31 -0400
Received: from sonic306-27.consmr.mail.ne1.yahoo.com ([66.163.189.89]:41725
        "EHLO sonic306-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726084AbgDFU4b (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Apr 2020 16:56:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1586206590; bh=MHI0IvzBXdpPtoeU8HsEweqySq5ScLxvKrqTpMcFywc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=pAseiCvDAS5ut4ykc5LQuhSWdxFJOV9YINbWL0kOoNt73Kzls4ju9jv1bF8/Wz/wTTfJuZFI5PJXmCK+GONzvIyUef9Jk5yyzzEeWDCxpJKczz5xgZ4uzn4cLljIega06kGITxgXZy9Oyz5qfFGH1HaBmb9AVTqh1dXIl/fRBaoxpf43eA6afTyyb603JL3RyoQX1kRDWrvyqSi7Qu++MP06S9VjOK925YAhkUJ08MsShxyZoSYT8c+yOS7JLJ7+OfjyXKDrxlS2G+bC9zvF9dzGoQ5uwzAmJvKY62InIg3Ay/bdPUdeQe4xOh7Egd9nC4vurld3dkbTdobpfJdwqA==
X-YMail-OSG: AWbS0iIVM1lrhUVaDCYE6Sg7du42PEI7nUDcUHdtGr_TtEYamLWqLPVbNcuy4Xi
 NBQUNOqs.qM8WlfrwHC5XZrpj4XPqvAKMvwZq4teR2pnhqYDPED6CRDZdU7Xo0gQoW2IqjT.pKD4
 3dzMNkf0TcrKjU3IfOi2Nwk70i8nIJOSZCz8eIRlcj2UMatHA3wnCDLb38bh3046jDojY813evC.
 9hE2M_AnEyiocFHNjtzmmgQ.pbFvLyc7mdzjAuyKKZhM2k4ZK0Y9ZRSGCaHmPwttNDzqH8u1X3h2
 WS7iLlP9w9pwoUp_pY20s3JuyNup1ZSPWQPwxP9eQdk8JwHuvD2eY8F6AMU0bVCGanFlRM68klCL
 vwYw5f52kx71Pc1_Ud9cQkhb5BPxcy1y8TKlTLFOQlPGAD_iV7bJzfWi9cxhqY9tACfiSBCWDP5O
 zSJWG1lfSQ4m9AfRQMSe6R1qzlkfvnEo2DRrDZaG3yWLYS5oPfIvCSaN2vhJQp8anDZR4OvjLt8W
 V6zobR94BfcQ4pnf.rJbCdlA4lcVx60no1YmQ2ua4vAGXBPB7wjTy6op.LmWMX0XAcbeSieKCvHa
 6ijKYRWseI6FEtd16G_CDZHogj54KY1hARSq6IaGMHzZ62aeS3tXIid.AtU7H6XJGa_azUWNhJL2
 tVgf8.w1pZlH9dYbKytki79XwdoGLNBJLMp9Cb9jxfiVewi0pNkHIF8lPuYQeyZ_zd39R0K92SCR
 ewtTNSlzVTR8dtFl6sR5FWB_TbNJcM4oWred5B15zNm32AP6XLCRQrltm5csEoHyVKgN.zXlj4ky
 .75uRUasMqhEQ2rfyqz1aXcj5LG83x8XicpHhN2tMYVX5NWNs3a6ipFTJ7HXpWneA1ptfEzdb929
 04VuBcFh0uF1B9l.EA6oTex_O25R9AhU4DnhZTV5vh0KYc1Cnq7vyFcRHx3phWdqV3DKrs50oAsP
 X2cahhxhUQEUkJKpn1qK5FKU_eYk2wFibBv2NFi7.crai7E8i8exoSaSUnWQ_LI.v3nGxuYAi5Wj
 9ph1V.mhqJ9gZ1JGhcwVS0efFpfqImf5wkhImJVpxqvtxsgclouJirGKuTD3LLoR5_SLu9h1cY2b
 Cjjvtw4slSflLOGEoLzv6Whzphtx11Z4kW_7nClDkhqKjxWrCyXkZSl8mCkqkIun7_5nu8qSY5JO
 VQkCLpRAO_QuyGolAq.AaY7hF6KMeMpE.svdQRk1.qHjQoQmnD9ovF3gY7bo_MPhjT.EtYUyFZsE
 nx3P6he5xfXcPL3KIL2h5Qiabok20f_xu2WvjErvp2ncp6KSPEdd0.AgFDeXP_s.DcucCJrXpI_E
 zmXPSpXMZE9ERLoTZeIaODxHCEFWA3nP_0AIblO.AUQR9YoM5cLmeIlOBqTRSBVAxr9drQ5BXJOR
 vEMWv.K97tP6DcJNb.PAANaTRi1qZYZ5fRzPLqunwwQMzHg1XWc4dfJ5hs8BbMw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Mon, 6 Apr 2020 20:56:30 +0000
Received: by smtp408.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 87c36420c8a46d6a691b1340496849b9;
          Mon, 06 Apr 2020 20:56:28 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v16 08/23] LSM: Use lsmblob in security_ipc_getsecid
Date:   Mon,  6 Apr 2020 13:54:54 -0700
Message-Id: <20200406205509.42473-9-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200406205509.42473-1-casey@schaufler-ca.com>
References: <20200406205509.42473-1-casey@schaufler-ca.com>
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

