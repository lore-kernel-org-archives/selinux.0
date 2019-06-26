Return-Path: <SRS0=8O8t=UZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B86BC48BD3
	for <selinux@archiver.kernel.org>; Wed, 26 Jun 2019 19:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F400220663
	for <selinux@archiver.kernel.org>; Wed, 26 Jun 2019 19:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="P2cD1BRK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfFZTXB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Jun 2019 15:23:01 -0400
Received: from sonic310-22.consmr.mail.bf2.yahoo.com ([74.6.135.196]:36413
        "EHLO sonic310-22.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726505AbfFZTXB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Jun 2019 15:23:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1561576979; bh=UN9byRInB8DjR/VQv4OEunflDs08B/K/Pf+lPB5TJVc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=P2cD1BRK7ZAEYRvD25SY8e/M08cTSgCKWv0o5AeDK3ZcXpwkVhm+0lOh6wwFOGSSksPR+FhsoOQ+Vp4XqIYbnT+9Oj/gpJubIUx2P0OpaGXmAkfbEC3wFCSu9EbkegALcJxW/9lCeIjKWQS+ZXUoevBDNp+rS9QiKOmcTaDeNNtya0rK+5hzwH1xYPtUPwaHRLrEBEwudZSlXVeg0Qwfg2jCDeQGiWEwnoluEC/b+HLaqqwnm3IHTLSJr252OYjXX8xn041tr6JGuCwQ4kyK6TNr6QNvZcHzRZxrRuG949zILTVm/8Mm6ApvEOOKJor9d5XouFoYJE1Wl+LAjvXvGw==
X-YMail-OSG: DIcRWaQVM1kflGxZnpnmn72q1ViernVK1eczHSfMG3AiTv1p_E4caad8Q7Yo3LX
 KxlPnQojqGPNI3.fK_5a7W_oRiEq50Y.t6wZeUcvBgdnLTWzme2sGVuGtOQrfGd4jGUgBGyFGG.h
 9FfkzLTZFzbNx4wSHlGulf.Tt4HK.lvKaQUL7TL1icHnktoalwnIe8S76aQmeyuxLVUu83vSPl0K
 04cBKtQFqRlYUxac6eszoMA3JVAyzEsRSIYuk10_tAI8_rHlhuETKLjerBtV_1ErGw182EHZpAus
 tlFcwr5E5vDpVRTU1H.DojlDEbKl7CBL7LdDLHF7CgDX6k7YAQxhPrarti1Vz2ZObZGI4t7tBX1H
 VB8Rb0XDsgNwgy4DkhGA4e1tpqtIelGDdTVHMzK4pkLSf4Ov1L22gq0dECpmfUUwqAcg6g_6vGB2
 IJBRPWL4XKLP_SLMG3EH2.ynIuQLeibcYdN7mZdBjC8UC7bJYTFRvxmcqOYRpZTDA_EUWQntPfNv
 VXyqVLT2W1Bu6C6VTlmsJKnNL_bXrd4uKL7CuzgYmqWt3FP23H8I69EJaF1o7q1GHWngiZb4_o3h
 ZyTFbH0cPyYn0swqyTi3iVH_Ubjl1U9TggyO1yOVyJbTqFkBYvW5sNVNofVUON3IOZiZFr9.uccS
 G9G4Vvmi3f_nkovrILNC3DxRJ7T9FI5SXeLT4nHn7QX90snwpeocbka7kqDh1b_0CJ7FSeaQKVpm
 ZsXF94d3yNN74m8WF1SfBXs2CGJAUPzCNrr0XfYTdF7QS32nNy0tJOL60MMXS9u7CsN5fsFDTaj.
 R7qtLDZgmmqBJrNwMybTqL.jU3sNF.RN3JMhGNnnAJ3dW8OvUawbRv5B1akC3us3cUbEzIHSK1Xx
 BKYchwAX98OopwAh_.QtvIn8ZAwMEpZJl2fm1jS0awsvwYkzEh1287mNTmNWLwZY7RudNGf1ToTO
 bRUSMOLwm2v8bxe2Fu0OL0Gy7tTtlx7K.l1iGpubojT_nCFYe.uqLT3X_KXhRPgd6zxpkIndx3Ej
 gC4iPvhmjOFtktOlii5vitWti3accov0lZQEOgSlgxlk6gD9RAsDvHu9.epCI_PUjoHFJnu_bO9o
 axW3cc0GPpojsZfMYYCs2j_PRzPEWRcb2bHsR0o4_GtTne4f9Or18ZmS4YFUIjq28jbw6nob24oi
 CH6HYFsy1aXQeAa7zRRZFeZQGsA4hyTxj146Yny2QHfKrpIr4ieJq9f9jDgfSAyqBPR7yYe00_Dy
 qexOnibToXZdGM0GK151O0HEESDjbtxe73AF1k5CFTlzhYtA-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Wed, 26 Jun 2019 19:22:59 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp404.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 26b5d486eeba45c4663afdb6eeff7186;
          Wed, 26 Jun 2019 19:22:57 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v4 10/23] LSM: Use lsmblob in security_ipc_getsecid
Date:   Wed, 26 Jun 2019 12:22:21 -0700
Message-Id: <20190626192234.11725-11-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190626192234.11725-1-casey@schaufler-ca.com>
References: <20190626192234.11725-1-casey@schaufler-ca.com>
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
index 0c7784a243e7..5245d4d1e799 100644
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

