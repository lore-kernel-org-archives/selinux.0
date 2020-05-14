Return-Path: <SRS0=6moO=64=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A380C433DF
	for <selinux@archiver.kernel.org>; Thu, 14 May 2020 22:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 706FD2065F
	for <selinux@archiver.kernel.org>; Thu, 14 May 2020 22:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="dnCrxGD4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbgENWUn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 May 2020 18:20:43 -0400
Received: from sonic309-27.consmr.mail.ne1.yahoo.com ([66.163.184.153]:32927
        "EHLO sonic309-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728332AbgENWUn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 May 2020 18:20:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1589494842; bh=6kCasyZbnBSM6aUi3LLV5uU6Mp5a0Stjc5rmUr3QGCU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=dnCrxGD4yStJZSHbfWiIAK19JM3c4UPKIFac2VH4bCRE7oNJ2uSmnm6uUO5Yi/SLvyrcC2oehxZZ6/27c/gcEAAJXuwk3E15l6Qx/P0QS6UqQOygBI6FkrmHJPh5gUgWurS2b1bO/8x+8F1LEgh5m2ZxBJzo3Zhwkrl4fQVshD98DdAs0nTjymo5Yymhh0K1AnikOw14FnGSmnYlMSFAwYwaFD2nzF3z3xbdcLLs3RHCfr4rmRCdxYcmoA34NJRJoP5fQSq9zCBDL9oDqZZ5I7SCxA4BJA4heLGUnv0CBV8NwXqNrDX/Hj9e25RwKDuknYwXrU8v2HdkywFmeczmjw==
X-YMail-OSG: aRJA2DoVM1mMt6nktE1RwQ4Qig3wsfitX0OjU4H41mHnTjTsl6rghQL8Q2vMRFq
 Y1ZQk.tLExl1LisnrhhKIfGfN0_r_2X3NmS2gE_yFVbNMJM806N2NpvvXQL7NuLPqQPE6EO6ScV6
 MffWWMG8GWHCw2m5vCG1qH.iDOoPQENlrKWr_CoUFEL8HbIsKzt1_f8E0uVW_UGYtuCZcFqj92mz
 1of2RO6LxIjIFQwihFQ5GJpYmtHd0cR7Tu6K3sR5VPtFCfezKKJLSpVCyrXI1wDZnZMq._oOA5kB
 cMsFIqZotVJINtCQgmQsW64fmJ26TvCwlAHowBYODJyoa1z3gWPj2RMQ_NARNUbjW8WP_EbzTF.j
 J_QUOkWGxEFi6lFuchsxQaslEvb4J.D0dz4xXEV4ehxcXhU_6HwyB0G9bIJ90x8_WexsykVdeHhb
 pwiYWM71hc_PFt0zTaq6ipAh2OZD8F8GHPt9InP8eDmZB2pY5P82Q962rYSDM_NYscDl8DaJtyi9
 nW5IEhDb0kiIsN8lY64ZDEx5VFD_024yQV2UU4GWOfhDkHYYLn7WtEcD6VgmgVQ66vQjcYFZJEsa
 8.9N5WR1sINcn_fYVn0XMcCHn4t7WnSKOQTn.m6O_inlA763mLIh0Vf_KOWFG1dr.9gFmB0_MLU2
 XWSKMZpRGv8Ew6TQtDmHiUGXZloL7KVLLsG6BN8a4SOYjBAK.AJSj8LRXfC9WmHglkAzFm5f4QVP
 XKf9Hucx0MLWv7zNT9K7PD4gUPOPENrxPvVxuDa65dYyYfKbnvvWuaU9ubYrKu7RdIL_0Xs9wXVD
 ImoqBUfYexIEW3U7hs5PPMv1fXvU51dwBxmsWn86H_DR9BK7I1n8uCKHUBaaGI17otGRbevmvOiI
 1MbBJazRU3dIR2pHf.TlTa_YV4w4cuHlUq.LmwM6ehoLjfbLRVvSWvCgdJhwdRFTZoS14WAF8ONE
 qITFwf2gE_25G1.F8TCiK2FEtFxVMEwn0BDW0LCHkOywcnysE_gYA4Oq6WLewCfv1MBZN6KEC88f
 ylGiO1OhZU3EvKz7MRlYfz9jB3hWCTguy.EEJz.ynCzrW.K2rfIJBdb4pwqWxnK5sbuyByz34NnG
 g8MMJPw4aIFLmzBj8Tp6IVsEjW2otFeM1_7YwyVDNrzB24ujwuAZXeTDqRzYEyc.j4qRG0v4Exft
 .kLfmR952sBodv.DkNThhsS7CpafiHfWrGJLcR60w6EKPahgQWZc87vCONjcjMzfANrYo5NBUuQD
 9ahfDZBBR.T9GUbqVogfWcARCdPgA5BTPg0r_3rgfU7AIF0jRU3N4aZaEs2JqXlCiMCEWuhc8Coe
 PSYwY1.vxyErh9gyAgI4OZ2lc1lyiGhU0weZyzXlrzbEGsMED6YIoxI3R97JNwX_8Sr1Im8RFCq6
 pp..f0CSsRvneOn8WaDDDYD_24EgmXGgcvOjdlh5WLXGq6bR7krEts1c-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Thu, 14 May 2020 22:20:42 +0000
Received: by smtp421.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 0c511fbc001a3a5bf9289aff8b2acbb5;
          Thu, 14 May 2020 22:20:38 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov, linux-audit@redhat.com
Subject: [PATCH v17 08/23] LSM: Use lsmblob in security_ipc_getsecid
Date:   Thu, 14 May 2020 15:11:27 -0700
Message-Id: <20200514221142.11857-9-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200514221142.11857-1-casey@schaufler-ca.com>
References: <20200514221142.11857-1-casey@schaufler-ca.com>
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
index 2ab69ebd2f72..c7e4ce8d209a 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -488,7 +488,7 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 			unsigned long arg4, unsigned long arg5);
 void security_task_to_inode(struct task_struct *p, struct inode *inode);
 int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag);
-void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid);
+void security_ipc_getsecid(struct kern_ipc_perm *ipcp, struct lsmblob *blob);
 int security_msg_msg_alloc(struct msg_msg *msg);
 void security_msg_msg_free(struct msg_msg *msg);
 int security_msg_queue_alloc(struct kern_ipc_perm *msq);
@@ -1196,9 +1196,10 @@ static inline int security_ipc_permission(struct kern_ipc_perm *ipcp,
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
index 585a1b3afa51..6fb75f799c60 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2296,11 +2296,16 @@ void __audit_mq_getsetattr(mqd_t mqdes, struct mq_attr *mqstat)
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
index 9df05c1eb7bd..18370f3f824b 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1834,10 +1834,16 @@ int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
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

