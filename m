Return-Path: <SRS0=MX5b=5W=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EE3C2BA1A
	for <selinux@archiver.kernel.org>; Mon,  6 Apr 2020 20:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E7A62072F
	for <selinux@archiver.kernel.org>; Mon,  6 Apr 2020 20:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="AGKOB20H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbgDFUvv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Apr 2020 16:51:51 -0400
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:44592
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726084AbgDFUvv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Apr 2020 16:51:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1586206309; bh=MHI0IvzBXdpPtoeU8HsEweqySq5ScLxvKrqTpMcFywc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=AGKOB20HHz9Ggh5LRyTFGMA6s/c04dP2fYCxYXjxDHpjqlUGXu3bt0gTsRusZKf4BawwrqKSpGQangcbRv431J/qAwaTfPVKYGa6Uit2TnQ32ZFFuMudl8fmE5gT4dGE/eCUT+HF8ImXNRJfLcQJP+MGknoJWfDnNrg045H7d28QPq6L2tiuvzkkh51C3brYOioZbU2YcHaFQMKK8Ak18xLavTL2KvbHje83iGIDpZYc+6UQQnY3qm3hnEwpRUN73/CfDlDQUySUU0x+a6U1iP09Wv5QDgUZvYg43I17Eb4dGgq6HQLt8r5dEK42aayNXx0jqdZd3oDo6f8I3bZ8VA==
X-YMail-OSG: Mg81P.wVM1mtxKDY2jKIB_RAo71aLKkHiHB_FEAMknqhf86Pwsmf3nbsYOTbEbW
 Rn7CGBmnrEEPJBV8IcNInqWx5piZXzbOl64GKZ1TiMgerwgHLVbXXqVRus8wi0SS6XdxsgLVTKGb
 szDh.4QI4Bj3JDTTsFwORbppYT0W073zODx8F.vgxhwxGjA3vzxZN2zHioba8IO1AEHC0a5XCh.i
 n0.MYNbu2ZtSIyImWCsS_sbActfrafsA_c9PPWRwuLMq3ccgMTCbHeXAg5pFccXiPb1mw8lcNA6y
 PK1JtmRKqq31ViXNOMbilPWT1igi.x81UIdVApIIbfXSL0pAmEL6DEfQSh8dFqBX3FqqrOcfc62M
 0aaDxpoWpdyLiVruY56YoBhrBeucvbNiCjMjYetsSjYXu9uDC9CuY.Gok3.a4Uhmyjm4cRWzkjJK
 e1oqWBRqXQGdlqe.brtDl.9lync4noSWvVm4sAlp_UWRzIFTQlLHIf2w0lOXQiNekcd4dF5RYV.e
 dFTDj2BGqNKcyga_o13qYhybwrnhVLK.kl.cS3GkgkXbYqFUBCXJdI1RiB1B8v6_ePZYMi0_JDP4
 HpaaWwesSmUl1ysqfRydnKxROX6hYrDCbS_D794FyqvNkTc9reKIgtJ6pNz7jR6h_TbYZSFT_1cP
 H18rzLPFzFyw1EjetN_.IzYK2FGAjW27bO6Ezcxl1IRq_ITHnkq9fZuoCaM8VUuEcErTrihn12Hn
 Vk2kn0kR2Kik74STg00a5.IcAGdPVdqUtvDMB4WBEF_jATeE6mGJAT1opEQoMekSvb7XSoGuyjiN
 A9jw3MFR0tc5gGafFNGcCQlCKImkKnW0kHxkmNUF8IQsJSgqUbCf6wDbFXc4ZvJ8bhYXZ.5I91N6
 oKIb7_ho7QNexN3g8D65xzbcWuK46j65Aw0o.ZRlz3IDUEIr6Isriztn_jGQbuEJd_vHzfQYn5GC
 mlZ7L4h8gxJ4C4oabGquY6rYErOGgYUrTQi9ZhqYqOhkWFAGZCbS5ySue2HEt4g1FqUGa3AtdRZl
 cyAYlTq_KxjBmP5PdFHWU8RBdcdqE8DTbekrpIclhC_DQPFZVBdbkYvgufiA.gU6omRFGoNyz2xt
 8aYCUlqYjDnHyq4jNO5HLR7VtIJYK8jqETW0bscvI3jOybDVnA3Pe3Y3JrJgjdIqVQO8bPw2jWLf
 XbzP1KmAuk7YWqiXXivMto53PkJt_.PpTVShnmFtupv2D3GczCfQgp4p0FyiVlWze0kOEM2T8Dwi
 ngp2SwL5mbjtd5p4o0B6LKAnIdLqLcUf2Oxc6EWe..0fw9YwewtQqGtVq3kFq9RJT3onLqw5eHDk
 XQxIR8JW.2137RD.2BGIiIsPxZGAsU2Mqyc6MTZovT8eeDrr0tzHtXYDDdh8wvIzoCw7SChiOH8o
 1KXyM0ySKFhU4xxAnUhnEbfgn9_hIYC7uSs2h.tUL72YYrUnCjBbXWPoDbc7rZKBIqDiG
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Mon, 6 Apr 2020 20:51:49 +0000
Received: by smtp411.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 688ec332b345e5705db999f520c2653b;
          Mon, 06 Apr 2020 20:51:45 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v16 08/23] LSM: Use lsmblob in security_ipc_getsecid
Date:   Mon,  6 Apr 2020 13:50:08 -0700
Message-Id: <20200406205023.42338-9-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200406205023.42338-1-casey@schaufler-ca.com>
References: <20200406205023.42338-1-casey@schaufler-ca.com>
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

