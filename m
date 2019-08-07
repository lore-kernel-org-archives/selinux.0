Return-Path: <SRS0=LK0T=WD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E03C41514
	for <selinux@archiver.kernel.org>; Wed,  7 Aug 2019 19:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E0F921EF2
	for <selinux@archiver.kernel.org>; Wed,  7 Aug 2019 19:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="cOPVbWut"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389094AbfHGToj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Aug 2019 15:44:39 -0400
Received: from sonic301-9.consmr.mail.bf2.yahoo.com ([74.6.129.48]:36882 "EHLO
        sonic301-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388945AbfHGToj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Aug 2019 15:44:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1565207077; bh=NqpgYkQbkpDA8SdvAINO7YGHoVQ1J9pYODDE5YAZMOY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=cOPVbWutckIAEGQIM6UWfipY/dXgF7Z2h+XocGlnSb1SCE++gVZiG34pMx8e0EeoY86PNDfLghy/IbzMUAyJ6ElttUAZNicVeIFU66BjGlZZkPMjX2vQOuGjoHyEn3wEqJRWv2rxTl+03T6/ku4ITLus5E3WEKeCFjTu8s/gW2QC4L0Woo6QDg6RdkLxr5OqRGfdPrEMqwX2+813aKN1Kr5WiFrYOPDDMqpp+rxheRN5v3LfzhUvebmNUonVU9GEnvrdE5ygRDpHVJh45ZBGRh/7fHiwNkgmrdv3Fs7vYXmbej7wBY+xbnEe+8pFURk316E+69kq5hAiZnQRgEKXHw==
X-YMail-OSG: oiYAE.kVM1mB1n2pvo.BGLbSMPHjeO7ectmWsidsgGkh9nb27DWiDJn5kcqI0SR
 Y1636f9h9L7pZ2RtH6H3wIGVgvBF4iqQqYHtx1GP7Ijo6lwrXmyBucE8kRHjEM3rg_QzPeB1BM75
 lbHi.ZSHgDpEh7ZlR1kHrIyGSNEhW7zIuYbUP_UwCPyOdYhPsHrka7RTYHOSd4utl5pA9c1RaKjp
 aPI4dZ4hp.ir3iGej7Hc5.1d_w4J_RA4Y4JvtDDYOPBkDxzURIKwbOZmSykWo7e5KU_i0o4IV991
 1Ae8EBdFSSpOc_7z7_cHZhB2ob0jWohlNL6KVVwcg88qJu2c5yiM0Higm6T5BQCzikuR_cwoE3XH
 KHUo8ytw2fhRuCE7acbtVCaKbmbQBgTtTaoyvEkbtxpzxAN1FZw1k26yiNK.5._5DJDSjLvSoOld
 tBZleWH4G5WRruSvrOdgky0itlqUa8CgT41foINd8LkVk89OqZTHLFgIdfIY89ANvnjiPLkhCUu7
 dl6ME0HRRHnhCSuJynfYQ5hiWwcOSbQ74JKFEeUhCagT3ntaNhriOEtQPBN4fuXH8Vec3Z7tamdc
 2Rt53PIXePE4fvMK7z3QrxMwn0It51v5o.dvCOoiYdMZj0fKX6ElKGqmDV_YxS85iX5aPpbnUoOg
 .Pu4CQUu0qThRDG0CYtVhD86j.hrLXKfww9zMEtE81Rsn3BKtzl9ElRgYSbfASraqEDOGMPc1WSo
 NGftRrgUc8nvIydhY62tPDag5FYCvyI_5qmRfHaIW5kaTWlxU.ZS_Oe1tdmGrRYxZ_o0TTTWqUMM
 VLdCFl8w1MA7XBHWcCCX0yNbrNY_afvdURxsCCnhe5L0x57y5j4a7.G2JJjIa3i9mAtsFwJKNCFY
 i29fSM579Svnj9ILJQBuEdDCA_1y3PV6bpVDPxNo0fkP0BPJO5KolI2J7K7S_vg0P7dW_fgZqMRv
 BkuOxnaelK22cmu1nNQWw3GGmFUTU3VMqGb0zqZJlV7zCqCZOpQSeepO_nB89WhwmwgWWizeGcw2
 Dxt7KT98U01HyQFiuXCiiRKL3yd6SxnGDIg1As10LLgAKhxpwXpelXrAn7gohDiRqkVHuM3vDyz8
 YcSGFEKR95R9Im0Hsn8zYRrvOnXWJq40Em61Z2yR9vitW03YnVi0f00pJ4gM1MHI4LU.90PfrPLq
 PmtAi6BG3NEVd5ZBjDSrduSECMgkfWkfVyPZVEUcThZGHjF4cwYczdEB4IBvnr.K_TBxwiollyCk
 2P9WXFpWd5wVrdT9bBYmJ3XigcBsaGwUhXOYl7BDodDu7_hu57fjhVwSq8Jv4pH1Kh0zo7ykn71a
 jKL5toMITtA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.bf2.yahoo.com with HTTP; Wed, 7 Aug 2019 19:44:37 +0000
Received: by smtp427.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 5794cbfdaa50515bb41c5d22b089570d;
          Wed, 07 Aug 2019 19:44:33 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v7 10/28] LSM: Use lsmblob in security_ipc_getsecid
Date:   Wed,  7 Aug 2019 12:43:52 -0700
Message-Id: <20190807194410.9762-11-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190807194410.9762-1-casey@schaufler-ca.com>
References: <20190807194410.9762-1-casey@schaufler-ca.com>
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

