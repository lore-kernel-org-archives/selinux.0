Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6995C6377A
	for <selinux@archiver.kernel.org>; Thu, 22 Jul 2021 00:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9474661249
	for <selinux@archiver.kernel.org>; Thu, 22 Jul 2021 00:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbhGVAR2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 21 Jul 2021 20:17:28 -0400
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:40369
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229764AbhGVAR2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 21 Jul 2021 20:17:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1626915484; bh=KIY5MODEqMix6NqMDjtf9M9zeiD1HjHaqgXFjbWFAZc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=fL4jxPfGDW6SLdazm/0NruGUXxNJQcOeF9JAJdsb3i7N0LSe4d98VuNN2yooI9KecA6LFXPAIm03IBn/+EEWGXDB9MdbFLp8MOKEOgKSG8xE4AoNKiYbgqcaaPJPz36Favo/m6QrluOv4Rl9fcLcpsNkoV0LFvyyNusKlZ1nLmyEaCyf7q59x8sePhx8miOVZkAF07W35kr6ix6q/w1gJvQQjgDR4vO6ITaW6ABR5PDcXVPBnqlaCWnFRMpzZpCh58S9LYkZuTHNzuCK7pwztY4n+XGGyVbm2PhXysvY2phd/HeZH3mWLYRaXZ0JxpJmqqjU1aVH1MOlLJwnd2QvvQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1626915484; bh=3IzidGq0+JvGd0No4GVr8vYwO5BfJlvyBS0pSjj89Cf=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=rkS0G2eX6MUMcvCeLm3xyqO1TxhUv4RDmbZMd9Gd+6fV4+5zi5MAOQL6HQL4ub/J+kBe+z0QKvL2O1TsC94240XM6+5desQtTKJ7zGuisr7cdVsKSb4wNYUNk3I6kADooKkTPRaiOMqJ7yCoQ54Ny/bs2YaHDEjVrA8XKqhvQryvJIzsyC/fDvY/2V5XpGNMfmW93WdHgzteupbT56dqU57WCSl5SITsSClbGDGlteYm/w026kiHQCF3ElEh+v8JIhe55vtUilpwjpTeIt+H+p8vqPS6GGPzpP5K3C7+gTtSyJWObxp41OdgEJxiPLLpA4jtPWhxeihECegEcUpeYg==
X-YMail-OSG: _uCW9xUVM1lFKgm5tOOjdoM_AT.LKGnGyji2Yiug9SwxaMwH6gAlJuhy1s86qaY
 y5.Akwp35DnpfQ1xVmt446Zm3ZEFLmCS8vITqErewOnKS_4iuCBJ8.gM5EKHOOOBcOBATR1ufOBL
 8DoUJNCwxIbnhWngqCbqhRE3RDjl49OidYLLiZJMqwG9l6unAteo3FfX7JUttygrleEMNOzwQILh
 7Xee5jOoX6IBCaWOLDQ0xlV0.uU7hssmaqGjX0bTgm59UzOcdboHPXtTM0QL5N3yxd2HX2YkKJtO
 aEIAOtCnH49TvB.pECdf3cpFZVCn12e921EBxe6t6GIKSCJlgwanmGwGXgXtCc6u3Rfs6wF96ZfK
 L0z5eaVH00EecyvRKmcPukVkiZ6A5Ya6T0Ck7cOm6.H0MUg2Dox8_svLKbKv9e_ERP9wUCMjhnqF
 RxvdVyPEtwIxC78nOCtfkBi.nOoJI5gwGb0J2OkdZ3Nl3_9qYBmbQS6DET6B.9cWMJ7BvsapUmRC
 7uwdrji9rLIgh7cntWP5YTYCszogkomTtC.r8yfoYcbx6HuqCZn33LKSMP1jPK8uRzLJhr_yvuil
 0pConLKv83_8Y7tW1l5kfIQbghdG7qbE.Rv1rft.U3FnnlAGzXhb5oJOMfUsivn.Ts6PcBfEHVNq
 9EU17j1Bol4PliqFHb7EZs2zdQmi4kL.uIkskCWp0Kn7Cj.GsYd3jqeXrqaCLcRwRCbwJmVCn5F4
 QtbHNozYcIvrd5W0.KGdTkfC9Wdyd_d4y8ciPYxGJMNFqdEOBo3NuUsWSDjvZbsRtqCWJb1gy1Pz
 SIzBUKw61TGswMnQCcuWHZd_TlU3JUw1BSMrwDIrIAynbnMz.Pbk2KWaVf_C1vo3SCqZj7Zy4WkE
 y20EBQAuwwvh25lm1JhkVEEcFXaT0XIs9MIvDXYsE8mLa0QvkqZZ3PadUdDgaVpn2xLtabUgYvyc
 2QdM4EZ_uOoNHIoJKPSagfcH9LCx4GZ5SYeTRGer38aCg9ChWEQysumI3QcrrimfGNFoNFbNLwh9
 JAIbcxWzdwdiH71z8IG6l4uNut45kBdinKtIUv6rhVNd8MyQfRBVGbN6hYJVJ1VQ7Zjs9HrfGhjz
 SSo2FOjt.6XTv0au4PfWwblsOBmaCOHwa1_zYaXhyssEMJ7WCWVYcPD0avMpUJgiWm_mz7aYHdv5
 S2PLhn6PHOAHLdZECXzlSUPg_tZfJyyFjKOkt6ONFC.Kmid1jC.DA9dXj.Lx0CqVBYNpGiW_XQP6
 WDTbn2jv_47U67loW10hUZzqICLfX6ZM8iorg.ulSr2PJOBwT0G262NrYB_bBO71bAhpT3OOkM2b
 _Z2JhPyEy.qk3BpZZqhUaljDQZK0yA7cFXD4q.GKVvoNKca9QZDC5JW4TxVCmzxYImlioKmYfwNA
 e2YuyQJD_ENlfya5B3HNsVc6FP8K82t6Q3zHHABa0cxPt.jHhQpRlNWSuXAbUlwsZRDxEe.Ec2Z8
 j8nvutQVdoyzgpi9NT8Y__Wq5h9W73mpuUJQn9gvkq0xguJA6.QXffetJ3LTKWRRRdJ7_taJ2cbx
 GJ.e2S8.DmLy6iGT6D5HZ9VII2KJIgcVZWwjSfKBVCQGjSIQ_XWTS_3AydDs5QaWy.DwWQGgVLBp
 lGSUDpJPAWztbg.fqAEjBBFO2ekoYhjXkdYf4J59zgt.AYx0FTZ4zYUfZJTFM5sCVpN50B2jI3t2
 gvIm6Jaie0hDmuV2MWbDI09F8L0v3GXLeBL8EapRjFKw6ikrE7T_0UmHAUPjo1XF9yzWKIN6.H_B
 CEgFswu9OH7zkqc1PU6V0a1U0MpChfsV8R49cBgVMYno.MiXWYy3AHfKUgh9QEI._2GA44MW4.8h
 UfaacRyUa_lkCYD6LvBLFfCPmoUsKq.F.FI1RHet3CCxxdNdnUS7IVw2YjnuVQj33OqMNcfO7ITc
 51Z5F20vHSGj9Fi9ili3eXfT73xsM4pAYBJss8.R8ZhLhS0S3mx9Ii2wvNCH_T.289eUnykF6X3E
 .71AppQ8dzs9S.ZhfZWQJI_a3hxDBvBpVBK0fXbtkdDJGpQzSkqWZnV_yHTgoUmjndb8SabCMyQy
 FRv.7BUcUJcrcz5IG5oEbebsl_QvlEpJkej70zEB3weXDvmPRvlz8dfEfemihxTmXlmL71FWpkuP
 efO8nMqPE1i_WwtPUsQeOoHSx99udUnDWZwmKfk7OFMwDz79gB1_jnDqMi2GYIHRI_SAd1KGzWAK
 uAM994eXAohbTPlRwSVHKPWAkBLULicgGo5cUM8ejjva.qhw1XD36VgG8JHNGmQu1MyCE.rZgkgW
 EXcs2REZfSVmpG1s_iHpSrpCckp9qLlcajLsb6dEe0g2PnbXsSzYqHWrMPtQr5BJS7kVhP_uyofl
 EsD627xUygnuXCX6nkY.cPXR05kV.n6.1X6.8ycY0Yd.8E_uF6lPQpjdVEE7mVUFPWT0MZg_956J
 xY6tR5S2pBhjtoym7Os452bdP6mSyJd2HH_1xTdWwwq59euh3RFnPx_9WXyEYe2nwT.kOc3UjRHB
 sHuSWKrV8wEfqcdoq5Il4rRnLEOj6ikLI1qLpSfvojoTHgWSHqK25Z1CATFn4ByTuX_a_2PPXv6q
 Vq9zFBJdmZr.YD57SimyyMBdQC2Z82w.AEINKmwdYUub1bbdQVyoM4bOKxgvfjehpyoE4cVid3w2
 veb0MOAhFx90b4z486rpAV3AMJvzxU_9As9x5iqvPNkFpCBxmRBTu0K3duC6IGeIhQXBT9bkFGXU
 tq.9XAiI23X6rmkXjWDXPdCDK55GLMhr7D_CE7nogEPInCpAipdTqe2K_tRCrHR2t4lBHQTbguxA
 hQ4lq5YRj4ogE_yrIxJaLyoINU67QiA5RHBPg8YcTuuN2xJTuZdlJ8glnw1QJW0KNWz7V1YyY_DG
 RY0e90b0AXW0lrbNUEiAcoIaOdb7a4VNXl8sfT2DvKdNIxQ96BNjh170BJoCLJoBTeKilMfYUa4W
 mWBAo9BrPCUVv0JQaoV.1FIQUkW6QNPjalRxin3XeoX2jM3NEEHgjpLsd1VT24psuKohSXGlx0Td
 caTdUMB1OLkElrvVPoCEl5cxJhsN52H_JwNRdb5zc9R.IRUTCwve7iZNrjQd2L2Bq8n5F3kR8Hsf
 Poc8l9J4gOj8xh0xXpycw0y40Dzva
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Thu, 22 Jul 2021 00:58:04 +0000
Received: by kubenode531.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID bfa1e919ff4b48ff1da916806d4cbb98;
          Thu, 22 Jul 2021 00:58:03 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v28 09/25] LSM: Use lsmblob in security_ipc_getsecid
Date:   Wed, 21 Jul 2021 17:47:42 -0700
Message-Id: <20210722004758.12371-10-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210722004758.12371-1-casey@schaufler-ca.com>
References: <20210722004758.12371-1-casey@schaufler-ca.com>
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
index ef33be59998e..886128899d5f 100644
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
index 607e54a0e85f..c38816ef9778 100644
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
2.31.1

