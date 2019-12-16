Return-Path: <SRS0=HHao=2G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD533C2D0C3
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 22:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81F9C21739
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 22:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="C0RGNuPt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbfLPWhG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Dec 2019 17:37:06 -0500
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:44247
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727731AbfLPWhG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Dec 2019 17:37:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1576535824; bh=WHSWZ22nKp0hH/7/jZnFbGHSQ8a7TG9sYWeArSzn0QQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=C0RGNuPtIWXbXQY9Fs/udDun2X9bHG0XJRXAKM9fbzgbachTIgx54Aq1rltrLxulGOAfRbXjrF6KSIgWelXCyQJFpFpwjmEUx3bOM3IKAIKY6uLBJQ+VJz0r7CYWJl4jyP2CcNcMUwcoF6SBztht83wKAVlOk2uUDu9bY601rMZ/4bxlw19InLVMHofQsZIyLInPjgCQ7NYSouKBc4Kmswj9iv+nLEyKlAqKsnuhObJX6qFE2cGkDtqbKE8r8rZ44SQtk5qLN59f1zARI9msUFWlvOjZrScu/uqy1gHnFZw9SuuAS82nYVlNnU6B6nO4YBZluDu0eKsWs2P1py5GfA==
X-YMail-OSG: 0yBANlkVM1kLeqvWHyRAAYkLOY6SI.vSC2cB7OGWHS0boKIOK.sE8I_Q6g7G0EQ
 jqrn4SkSofYRko2IFe.WOz48andDAugfjtl4s6KCsmQk5QzHUYFgsacrXhaLvafd_Vrph4ajbNig
 JLxyuec0kLhP7S8_moKKY_lqioCu6L.ugcmB5lg7p00iOU2iUCsteP1j0NbCIgfevAIZ2c.OVEq6
 r062c173jBevCF7tEyeP5Tmn2pV86LFV.QkCJ7qFzJFtDRgHjRIgEaWT3Djxc.zPBeOEZ4rPhUnf
 GATpyozDB6JP8GGBzQFg5sR84bIdXtEnRyriTDXr2Wbi.APECSc9ROUXqhLf9j2c7bvaUElQoMkg
 xVGuVmmBVzpNWyMl5LlpKj_VHz8FC4fY6dxAbJox5_qQvOujAGJ5_qpqRe1mKAydTDp0mwh.l8QP
 hlh5A_Wx.p.wVRpoP._SJLedL2o0WE_v8Au8fl.PoFeb_znUJM5seV3aDwSBvC6Bz6.gSZ1ERFte
 o3uB.dY99TTl0OWEReFNnRBUWMGogh_q7mLIYjerecLcKC0q2VXgsNYpxhN3OAcOd1cuo7V5lD8b
 2xhEoVzwToyOXiaqfwUTQQESRMCEHS0gmQoLxmenr6QTEDKceaCK3keqSjde.UnlKyApdnk2pLec
 4sFgM4po9afDiMKdHwYO9wPjFPwfzsN26zwajzlwMwVn2dI6LOvj0R69_CH.X2ZnBMJdBZHR7LS1
 SwLopxaKv_hWKxYHCRfjz.1HLVCVUM3NX0OtOuaVsL5LjXAwJY68li68d11xxdWr5NsSOqOZuUNL
 NSEZTMuFkfX_p9qwY3QdR0OJLW4Mc_1E5WIPu8j8gDoghJ8ZoyUptoFUD3E3gXXf43PePDuXJ2U_
 6XaiNRmSpXa8uL8k7byo1zYUBEG4NeDZC7rnwwS7yIpEbf7zHC6nVRfqXJjBt35oS9v9VZ.aOTyY
 c2br7wEnj.WFSkUkVcWLA1DWvucPwdWP2WEM4fL5S1UNzTd8cY57mardenGO63ngqstKWN42PNIj
 oU7On0pCZPL8gz1IfFcwibcWAXotfKiBJtbnWuGtrLiw05cYaqNI1ObwpClTAOblb60ra93KhLOt
 QYVz4.xu_6Nz0x173sB0sJNfou3HCPICrmPvJ4AeBPfgVzSoCjvthKbNCKQwMzZmNrD_Lkgt5sno
 YfNRWgfZ2NyGgXhh8x.1gm1eFaHTeWCGLmv8FoUY6zsL99Po1bzQj0oZkneW7Evw7CH3fVXFrljt
 Kh.r4zEcai_tQVc8_A3hnJMAUmK0Tdt_GuUzobsVuFaLNCUJVaxdKlMrx3bj8N_lVwKx9eK5XkyQ
 x6Q7aWYoFDj0mMd5XArbmddb82i46vhy1rXkmytFq9r30WpoCDGSehn0pyp2QelTFwlNyVehKvc0
 CqgOowfBHYJRRHVulfLAbW28rzO8KBX_22DLuH9hFqoVX3D_hyYuQLkYvO0ISnu4BikuMvYc-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Mon, 16 Dec 2019 22:37:04 +0000
Received: by smtp427.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 786e24f6854d13fd6e7d0cab589c1b74;
          Mon, 16 Dec 2019 22:37:03 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH v12 08/25] LSM: Use lsmblob in security_ipc_getsecid
Date:   Mon, 16 Dec 2019 14:36:04 -0800
Message-Id: <20191216223621.5127-9-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216223621.5127-1-casey@schaufler-ca.com>
References: <20191216223621.5127-1-casey@schaufler-ca.com>
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

