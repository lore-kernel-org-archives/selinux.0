Return-Path: <SRS0=Y9t7=WZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD046C3A59F
	for <selinux@archiver.kernel.org>; Thu, 29 Aug 2019 23:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EB3421874
	for <selinux@archiver.kernel.org>; Thu, 29 Aug 2019 23:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="bmM20i6x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbfH2X34 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 29 Aug 2019 19:29:56 -0400
Received: from sonic303-28.consmr.mail.ne1.yahoo.com ([66.163.188.154]:35963
        "EHLO sonic303-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727738AbfH2X3z (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 29 Aug 2019 19:29:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1567121394; bh=NqpgYkQbkpDA8SdvAINO7YGHoVQ1J9pYODDE5YAZMOY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=bmM20i6xir/VyI1Jaau7FUFZSM4chAi8V3tZ1RiWYO6O/C663Yk5ZbH7ioT1QtaaBN+6w6HPHuiOfpNeplaSdzmkOyK8y9kbag5SUph/GyjwsIkmHe2smBaD6MVX5Ed9/m+5IlSjPbm2W1qRV0DKUryAQzLOIUZiDMVLfUjI2nOaeWIrbjFxT6gWRjTshUMN7389JDLBeu3/iqKe3RaCQymjmk/UnKaeVwKfAP41fibsZKTdXAGccMPbDZ7NObs4hfqXzQa+hfTsajEdSJ+sXAtUbanj6LKH8iXwouCPKWif/vPjCYv0MLJpmY+0QAEw/hVyw2nyIqLjYSm28GBupg==
X-YMail-OSG: kkI.h_4VM1lc2yBN.nfeRIb9ycw76_QBt73RQxznAsQkIeS.uOXhshrSkTtIpOA
 AwsElvNQb5BH1udRIrcOU2RcwX6ncpPIXfQwVjzr6wOhThnZGe6b3VlmrhMEXOrpxoz2BUyw7R7h
 WvSp4jjRq3JpC2JwJLx0nfUi7WhIrY.2EfP3xcRULveOgAmJ_fVDUzBODErkN.E6nfTKtMxVE6XU
 E1bsXvtuITcs.BBbXTvl40T8rPW9Arcfhn7cK57V0MlSzhizvUncQFoE5R.juW2aOwEx7jpGk.Dg
 pQYfTXdO9Z6cFeBu_Q4ZoiZY6tjRgwdLN2w9oreJNIYtcoh4T1ncLEaWoZ_r3tH_ksOesgsN.wbo
 MLiAF3U6nLXec1LVHIGYvIvuRxqsVHknZCoRhD4MM9QNdyB3DfEowuk56rZ9Qh.iZjbl6BV_fW.o
 Tx4ksC_QcNI5tMTg3a8iTRLrfF1fQ94V4uWTOrOif7HrduPjVLVPZLFnEQVsQQDqKoEmLe2KH20z
 nTxlSzM24ykraCTUQbgjcKgGgn2gwohxcfp0RmUeiAc.UQqYtaKhEmO7FtUpo_1_9k0KI4_yRFNq
 528V4tf9Tltwd4lj2SG0S3uWmB_tx1fIJh9XTHOVT0KFaWXXyxrCMMLuRhbJHUx0EHaRuLnup7zv
 jJoM2Cc5ixX7pmfmVgtbBUMwwDMtBvWhuNq870MiOJHivMw1GPfFsAISl9QswJCAQtBNojZ6jYvY
 .sNcNp9aQ4tU9vds6BafIiVc.UZVE14kboePVWkLLRWkvI4tN9zEK_nhMH.1pSP7HC7vk.IrE0LO
 yrTG4DNfIA8f4Iqs7Aqx_Uxi3UHqJAJbDF_ZgqEF54OYYGeqtZED2dHXvnkNqFCodR5YQSG3M1a4
 fiC7Q79SE7kr_.eEN.x2Ot5htTZH6VN_wjVqBUQHhY0Ad41dpaWNXG8P55EgzEnWf2fRBUUDrXpV
 QAAQU_bgMPwjkzfOfrLMoOC.JpzEnIQhZDMGsg49XJr.R0271vRAPE6UY_LWUItBsnvPBFf7VGzT
 oFFvuUZhjoNkC8IYM8XKC7RaquWy5kTJyx8cJQky278IePhuedmJDjsMikxFLfDEpAQo0oZ0G8cl
 I1ze.IrFA4n75L0yx66qUz_qTO4TLbD_V8_snVEoYEE96gQPWwHz23v8pWOmzqyTsMiQVEhk5LF4
 x7h6x5S8bdmIdtOFbdQRsksVZMqagFRiGVUg6Y4fj9AedCC1opkzIlMAMH5224IMdpdw8KCQWnXC
 t2xvWdcaZMLyTGFJyTH2ceoGPKmGJkgPU1rPpyp.S16Q8K0zy.XBOTdv2yqSFkTxhlaUFbuI.qAO
 aR22180X6iBpY
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Thu, 29 Aug 2019 23:29:54 +0000
Received: by smtp416.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 0a952b05a9b27bc17439acbca9e87b38;
          Thu, 29 Aug 2019 23:29:50 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v8 10/28] LSM: Use lsmblob in security_ipc_getsecid
Date:   Thu, 29 Aug 2019 16:29:17 -0700
Message-Id: <20190829232935.7099-11-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190829232935.7099-1-casey@schaufler-ca.com>
References: <20190829232935.7099-1-casey@schaufler-ca.com>
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

