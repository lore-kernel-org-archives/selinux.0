Return-Path: <SRS0=r6Mn=CE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 252EEC433E1
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 15:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFF5F2074A
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 15:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="lnIVwvIa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgHZPKW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Aug 2020 11:10:22 -0400
Received: from sonic302-27.consmr.mail.ne1.yahoo.com ([66.163.186.153]:34823
        "EHLO sonic302-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727022AbgHZPKV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Aug 2020 11:10:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1598454619; bh=34ZRWip6M6aDaRZvdOQYqEeo2IqLUMLWjVJ5O62PWBI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=lnIVwvIaJZf7vgCsMO4SwOLp2lpJOHGAy/KoHyqByZf6GA2MupqS4+ee/tA1TBCkGRya/2YlqL8asxG6issQp9cphJSZr+N/O6FighMrgM5EVX0KhJXJ4SXXoXX7EZhdgO6u3sBSnzsP6QXgYYtpF9NHNYrHQdjk5yCUUUioScJIybE4AqJmfwl/FxZkmLYbpUDRbNzCzubl5yzHEe5ts8mttr/s2ypiEJmC9v/fZSH6qEUY6PpX0EIUN570s9Idmj+N7ItCFEjmZbrytPh2iXFFcztLxt56rgaISkGe/UU8o1+cIWuMGuLCTgTNMhTbIceqymW3lvBO+EqD0YY3HQ==
X-YMail-OSG: SKu.ip0VM1mOKBpN1yNjZmiI7FvaGv41xuO4tl5.zjopbfRBhUUAu8sNYmGryhe
 JntfFzE4ufF6YyraNTYsZoFqjGOxqstIz2hOo5xhjCq.Hz05ESVtxr55lbCrQINTRydJm1lmyiCv
 g3LnzZdxGRjlqBEtBGyXRDBzetFYvzOkfBCpX1k3pQEADd.P0KmufNrTegKoQjS_20_gM.2FnnTK
 qtJ4xetPPoTkDmtkSdiQIY.9PqpAy_nCqqELTdzn_dS28luRJ7DvHIJq3XNIptv12B4.lIDg0.1X
 oCYPufhYA.MpGvX1LMa9ML3jk2aDJrzXUjXyCq6l8xHCCIHm8yYlnxECWzzBUiSR6SRJmoSr48IL
 COx9mKYxlTDyJ.ACWXp5cuFyqDx_tWnimQJ3bhfuachpp.qAsigq0qVR77DaSZy9DmHnOeGbBOUU
 wZ8o8xb.s7lWKyAA9TeX9MsisAV9mdZI7Bo7QMr_GWNhXPm2OtJfmvjanOt_X45W29QH9p2HNnx7
 u57iYCJlzHEDYO6VgxAK1p66r5hZKu.lBTAsUDUOx0_eigzzX4uhD_rTgxnisHIT2YhEMrdkPisb
 Y9dFGymiNmXFHm7ULEhuQy7Q.bcVxXi9VWGzGV45qNLZtF.kxjFCrmFULm.1aA.OZkZ_4iVqgAC9
 OMpHfehqK0PnzAcP0.RVseknVtfn7n3nKCpLsyfdbpMwMQtVdYdKvN0SMclDvlTEjYvIaivUvKf.
 i7WNxLVY3Y2elnekrOfYItIL_Owl59pB2oJduqMB3CKW0WST4d1k_d7p69XVaqcaFeKZs9btSOlS
 9W7iY2oPhc_T6fWVb4bDnxYg69oQ9x6cteSDqggWSr.GRDbN8BhkhCs3wRglWd_z3aA4nl5fKsK6
 ONf_kSt7NAArNjyJNY2ln62evs50TJP8ZKSNhqEPI.yUfNQGyT4YgNkg4TsTbFD3fdSod4WPwXzQ
 qDRaFc5vv1ELSnnsTmLVLWg9aqzjqQ3N3Dmx.mMszhXpsnD58BMcubdr53vfsxlEGlxMTY5TbcuT
 lvflrjtdXOrUsADHhf9ywgAhenS9vSdW7mWmL8P644EsnP.dklLlHCY3brEiIdfdW3M3l1coDqF_
 VHgRY.OItpCl6Vot3cB6CcdvEC4kPkkV4T.gHOx6UN0_633eo5xdzQwVaMZ9RVZoi2oUkNWFXRrn
 bczQwJbiLAUWhoXvAkEAaeCt9QJ1b37.6E..oqYxuf0uSPfiumSaeGSKNa4I_TCF3fZcoBXkjf7q
 qezRrJBnDWEATOs0yDXbhFtStot.aZ9NeVnV1SubCQyQXDWfNbqLqWra4vs7SHuYt_M_ga1ghIOx
 BA1voGhuccr6e1TnNsfJXvK4X2uW8RHXyDgbAHXY98xHsqDX7CPmV7AODItM1.Ami.Rh5BQKO.Z5
 HgnSoILpOpuxf5.XpNGvd6gYAod55eunxge8Iu2nAOkcFBz2cv_7EJHBZvhz8PiYcStUJapeneGf
 azUjITlrHgaSvFqoPXl98m5BkEHvUwu4U1c1EAh5gK6ZsPuvNvL0p3fbE__wFev3SmRy_bYDXikc
 kvKYZIvsXpUouRPSrgzDbAIB_
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Wed, 26 Aug 2020 15:10:19 +0000
Received: by smtp424.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 4a79242ab2db84f56b5dd2596a16b4ad;
          Wed, 26 Aug 2020 15:10:18 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH v20 08/23] LSM: Use lsmblob in security_ipc_getsecid
Date:   Wed, 26 Aug 2020 07:52:32 -0700
Message-Id: <20200826145247.10029-9-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200826145247.10029-1-casey@schaufler-ca.com>
References: <20200826145247.10029-1-casey@schaufler-ca.com>
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
index 5c66348d9ab0..5f38bde9162f 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -494,7 +494,7 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 			unsigned long arg4, unsigned long arg5);
 void security_task_to_inode(struct task_struct *p, struct inode *inode);
 int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag);
-void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid);
+void security_ipc_getsecid(struct kern_ipc_perm *ipcp, struct lsmblob *blob);
 int security_msg_msg_alloc(struct msg_msg *msg);
 void security_msg_msg_free(struct msg_msg *msg);
 int security_msg_queue_alloc(struct kern_ipc_perm *msq);
@@ -1215,9 +1215,10 @@ static inline int security_ipc_permission(struct kern_ipc_perm *ipcp,
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
index 5f9bdd62f78d..35d6bd0526a2 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2341,11 +2341,16 @@ void __audit_mq_getsetattr(mqd_t mqdes, struct mq_attr *mqstat)
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
index ce0934395c53..c74c7722e5f4 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1866,10 +1866,16 @@ int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
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

