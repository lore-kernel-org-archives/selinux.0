Return-Path: <SRS0=lMs6=2O=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 812BFC2D0C3
	for <selinux@archiver.kernel.org>; Tue, 24 Dec 2019 23:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 538CE206D3
	for <selinux@archiver.kernel.org>; Tue, 24 Dec 2019 23:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="JUlN7fGs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbfLXXUl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 24 Dec 2019 18:20:41 -0500
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:38044
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726259AbfLXXUk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 24 Dec 2019 18:20:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1577229639; bh=WHSWZ22nKp0hH/7/jZnFbGHSQ8a7TG9sYWeArSzn0QQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=JUlN7fGs3KhY8MzqqQ4lL/RQ5bZ5wNO5NiP5mdNN7TuqFRdfaLzL3jOYr5cLcL+PP2V38CFJE/OHXqd9wSC186Ogf0WWJeAkE0qSN+KDfjK/e5mqPmFykRG1VNWt+mNkNqj+vikoNzKD2be2zc9xcUIDv1CrZP0KBpI2oc5K7c8dI3Pz6QEipS1Zrkd356yZZiVrER+7JYVqFOhizI/eRLDcCzNkAVk7i1Js8lUfINVsj4YhN97xxbbpVEdVy1WjCh+qJzSOkDbXJHE0dDKRMDCdKJSNKU8nm4V5cHmgmp9PodjOCJhxRl0MC1KKSzNsX78JIqoEGccwC7HXJ1LRBg==
X-YMail-OSG: hHP0aDMVM1ketr4WmJr2bh.nIES2r6xEeHGodVkFOFjDJD_RHYZjQX54nLZM1J5
 8Qa83Pz08iKvwKDwV5kR_gB75k_OpEShjUAP0tIU4EcM5Wcawch_NOCYIs4FvQfhlSDIdsyt8IEa
 pBgNQ.kVcU_eB1uM9HsTYrVRuEWsW4KXrCiEAZ3PJiJYT3J_xYW8D1jpb5I9KfXkJRlQcJHxF6Ms
 s0VyWS3_XQ4BcSmpoFhkOCEdYX9QqI1ZwI.PpCPw73IJuCyjovwrtuckvdOS_JFvJ74oSBETnc2n
 7wxw15mcyOZaX6nGCQcd4hZecx.nKrkrnx_AHcHC8mOTakXJYF5pkFxhkhDYDWWl_GfZxiZxG52t
 bD1T9yP8a9T.eJO0OolPXXlkHywNsWLkYxk5Ccw1TIpSu5wkmaXLwbeyNuJ7SoTkO6SSKAzZqUY5
 MEvzSQ_7b1zzKPcArcg0hDInRUfsmbj_uhErcaX3JoZbNmRs3StoCRjoOraV6.M43SWSntAJUCpM
 iVI7nYA6M8Ks4R7mcXrBv6Jbddkj6Hjy3JZmoAcB0J3GCbVyxi_gDLtlg87LGqrGmGqDjxhCgXIo
 zyBiAiTg9V9PVEsphbYkLfN5.SxLFxnzeUKJa08sZiPeF8haMWvm.Owhj8zr2w8ARCWH_03co0.F
 NsCEXligsXXUIn.ScwwJC3kguZhDd_aD3f6Ud09Ns..JOiutdFt3JzdLg327AxixByq.ZhFMxv4I
 3.WuFne3Zn46KIsHWAmfA.tUPPyi9.L5AtqSQ0Fyf_nGOqALk_VTNvHG3P4mjz4aoiu_4JB6CY6R
 pxyLZfbw9sLZBzuneSeFZ3SjFOiSbKJuGVPeEDCmuCk1Ydr3P0Gf63XzbVt27xJ5BNhy9QiJQSjB
 Zd54BzxkeU_MugfA3JrF2.KotRJ7mLIyZiBwpj31sLSMINiTpN1J0UCvlEtete3NG717F56Wvj1w
 1W.gq9D3MdVpLVvCeDLjF3OZZNFADrBG3mMYHl0IUUtAnInKJD5P3CVceK5BYreGQZVEpmHjaCa0
 wM3iDLJ7EflR1oJgln4JAkbWsYR1lI3sTuIKgVQ3nmbzzD5MdJjaI1MTCoAS6v7kXEMaSR9tJQ8A
 4sginysXYEFLryT667rB5e7bEegQWVCB2CiLcm3CkKYnRayU7F1t1xwoG9ha42yIPbASWnrdVySV
 SBnqQZx1qGk2l1HIfstR89eiRmv68kA78nsm5npoBkOjseZQLryyCnZbIgCa1zQ4vJnhfGY8Mf9j
 nC_zbbUywhBBsIqhEmp5NBs7CU95WSojIRBeNDMww3Fvem4Yl.onJTUYynwz1jrNJb.x2s9i81X4
 V8CgLMENOiedbc5A2.5OGdyhfhEcfSlRnI0dwQ7K1YjXajv4.vJse5OGD.R0rqP.ctL_8UqKfQjo
 1pCulyjfPg010xB_0V6qAOa32.7rUeAj4gO9FD0DPU.r7yarZ9xKeghBkRWQIatbG5.oFfQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Tue, 24 Dec 2019 23:20:39 +0000
Received: by smtp430.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID a5bdac7be9f9295991d05848345d8d80;
          Tue, 24 Dec 2019 23:20:35 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v12 08/25] LSM: Use lsmblob in security_ipc_getsecid
Date:   Tue, 24 Dec 2019 15:18:58 -0800
Message-Id: <20191224231915.7208-9-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191224231915.7208-1-casey@schaufler-ca.com>
References: <20191224231915.7208-1-casey@schaufler-ca.com>
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
index 26b8cee65c64..61a80afbbdba 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -466,7 +466,7 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 			unsigned long arg4, unsigned long arg5);
 void security_task_to_inode(struct task_struct *p, struct inode *inode);
 int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag);
-void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid);
+void security_ipc_getsecid(struct kern_ipc_perm *ipcp, struct lsmblob *blob);
 int security_msg_msg_alloc(struct msg_msg *msg);
 void security_msg_msg_free(struct msg_msg *msg);
 int security_msg_queue_alloc(struct kern_ipc_perm *msq);
@@ -1174,9 +1174,10 @@ static inline int security_ipc_permission(struct kern_ipc_perm *ipcp,
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
index 04803c3099b2..ce8bf2d8f8d2 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2285,11 +2285,14 @@ void __audit_mq_getsetattr(mqd_t mqdes, struct mq_attr *mqstat)
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
index 61571f5c7c5f..0d87a2349552 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1783,10 +1783,16 @@ int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
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

