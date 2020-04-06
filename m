Return-Path: <SRS0=MX5b=5W=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082C0C2BA80
	for <selinux@archiver.kernel.org>; Mon,  6 Apr 2020 20:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC5AF2072F
	for <selinux@archiver.kernel.org>; Mon,  6 Apr 2020 20:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ukuR9P/U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgDFUmE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Apr 2020 16:42:04 -0400
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:45519
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725933AbgDFUmE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Apr 2020 16:42:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1586205723; bh=MHI0IvzBXdpPtoeU8HsEweqySq5ScLxvKrqTpMcFywc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=ukuR9P/UG5cZdHHTdD2Jrh29yWQD4/8d3kbvrvs+gWxExPcofa+U/x6AsCgMTmVsA0eFBe9uyaPpk2mjnxyL8hFzD0ouufa9yEzdMz781z0kYz5UoyxbMgpJklzdXmSimCY7F4nSPtIeMEhtdY3h9bP7EImHvtA30td6jLlUHLgvucWR3MFDDXlwvEVIDUICinxORbu6nGOSVv9sMV2wa10cTyFK9Lf+ub5y9Q6GNtgiAV9f0yU7U9flRF2UHYKs2em0Vvs4SvvCkouUNOQ4shQmtaIIBSzWRL0YZHN6WJ4UKt5EKLVuiVfyLhvE1sMNbtMF6MsoJtgz1glwd4Dokg==
X-YMail-OSG: YmIR8qUVM1k3L4uEhE3lw6N5d3lW1tI6RR_8XtL.pMeSci0dc9rO59GvyIM0XDY
 Szu7t._zxrT28ZxA5wG1pHt8x_GGNvw2uu4hEgNMVHn4lI3ygT01DswBUOvE0_7mCwVtiTrWy03T
 2h.GvBpQXdzvOUELFOGjcNBQKmXkTATQm3hjd_QvDRkFJmdk2m5RrlYWignfpDpUSCRsTbDkoIxk
 eacTIgkqQJ5AJq.AOHJLiH_h5Wjdzdg7CD2B1n_9VoQ.1DfU.F4teuPY00nlviMI0tL1aeMqW3OX
 uUu9mbnWpU5wrPAo.4efWHAC9jHsM0n2hNkJXNVyo5MjwrBOzJ1vqqLR.hT_TYeqwB8AbKHnDDK3
 9toKDxnJ6sQwPhMR.Uj1X0nSiJYatj1Pz3tiBM0n8ClJt19yazFbGK_6S3VrlfCj6txZxiN7NvZe
 fqWRq61Oixj5Ba1FQ56GlF15t.c0GYUm2x4S2rT6UqLegE7NO2yTxDzwgTLkZP.Elf5esWVuCvC_
 LLPrFaNT1nl53wVvfbQnb7AbjL3RNB2lXzoVi6MH2jDHByLqFB4Ty2qIVycryLMpa3CUGp5SywTO
 JSEZO5pu.Wj0Czm8nN252.VJ5CAtGLCWIOgw_EgUApfhd5ioLuvDg4p..VJzkcfwBjFUFxUOjoqE
 VkAJqWJjZfMm.BDXuxoj6gNmVJVJNJMU93bNEVofVnRnz53dj0W1SSMKlYMJjGAD.Zl7_aGXv9NI
 FIs1rAg0taLKg8xwKu8CJ7QuPWX9v4icJqi88DkW_R2ETTxluE9GArCFkVm55GtTaJJUX5xXmj4d
 7z.qsRQuXRBeWafFnFJvny8LX5IPAK_iP1CECfuvRa1JKZVs6Q2IsDXHKe4zAQCjH_Bj2CruPvJV
 JGT8nMNFjc06lddRZJKwLsWuVvY8gbjoCgBSZ0pK7NMcBzzHo_RbujeEa0eY8Vy3xnp6OOb4Gucq
 b3fhMRiLigz6yNEzZFC2fTbBIvrYYWOO2JcSitdv7jmSloLdIXa7pJPz.8jN4drjotu3vfxMiwFO
 JVNVWa8ZVA4IgtamG_oVnS1_pEXCfFye11N9PdLIO3X15sfnP1BD9XLoO.wWVkuFGpUXdzuNhsiT
 YDRSdnBQBqHx87VK2ojbHgw.pkvO4aalbmfm7vbQqYNMQZCGUgHdzG9UkZ07hN1ARYH21EkaB7Gl
 pPZaxDBjN8k8MCWa.AH5LxpfT9E_Ab5vTZ9120DLE3LImNJ1UzRyGKJIMjcfCcEB_Gb7M..nSwUG
 1nNkxZx_26V62gBwYFBF8O8kBE8CVW6zUyfF0Q._ZnFDN6uV1pZ3fNt5n5lkOvZe8bufbC11XgB5
 13lSzgVAZRdbu6q09WSG8blzC_LBSvl2pQWZ8rDWMZ28Q2_dLGhhLTPuJ.rgQWc6ofhgEGiKJCwG
 LKuyCbSuc9UAxbJQO9jA9Z0ospWmbsr3tGPw6ZnEaR9XclrevuBblMmfhbvW6
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Mon, 6 Apr 2020 20:42:03 +0000
Received: by smtp422.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 330bc0ae330c243d0dc3a8e85f923118;
          Mon, 06 Apr 2020 20:41:59 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov, linux-audit@redhat.com
Subject: [PATCH v16 08/23] LSM: Use lsmblob in security_ipc_getsecid
Date:   Mon,  6 Apr 2020 13:40:22 -0700
Message-Id: <20200406204037.42262-9-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200406204037.42262-1-casey@schaufler-ca.com>
References: <20200406204037.42262-1-casey@schaufler-ca.com>
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

