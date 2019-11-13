Return-Path: <SRS0=4d9t=ZF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D05C43331
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 00:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AB1B2196E
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 00:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="S4yFDBaO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfKMABD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Nov 2019 19:01:03 -0500
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:46200
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726985AbfKMABC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Nov 2019 19:01:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1573603261; bh=SzhkUBMInZW21eDTVaDgtuRnxZhqJtkvtFFiFP3irFg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=S4yFDBaOfjLaY87ww8Te37Re8lPOi1QRHZENqmuf6c3dcSz1WzNvEJ+4GUNe2esnrQDJri8GajEnHhbspq+Z3N+KjGPy63dBPb+CZFSfTtAbbFRyRK8+t3vOjVxjD80SPXzfgftZa9RdrODwFuc2GkfknEAL8XfJ61KYjtzEb3dplf3B4e98PKsbaP4aQ0kgqkwvL38/o8wk9/IpRXpjOggZTjerl1ZMsIp+svPhoaEoi+C1au5iE4+4QK3foSkgVv3c7KDRn19rP0s1I5rBLYJ34HbUhGP5SZh8eQb2WBReUGodFjRwKDUx/bjbOjhfLTstQbexOC3K7nIkwDdvjA==
X-YMail-OSG: 7DCxbn0VM1nGn5dD2eFmKF7geqE4ijJ.O9v3jksBMr.j.rkIg90VubtS_EoCNCX
 YEufSlXUfq_vlyRH.dTbt1IY0H.1bLpK4x67arrtJbStRyfiHEbHrjT3sDlaP4pnB7szpn8bhKVr
 vlCPovTBt9m9HVgz1i7HqBFW6qw8vtjRjC5M5Fiz.URFn0hIUDftEyj1lBIcUIu8Jp7ZRETqoz26
 eyhi2Q4.RI7BVe72GVT6orTP00LcDF.IUOU4xtrYWjSN58i43Ef7CEzakUjock_e63ezURcjvfTv
 qQcLMIUMXVkYRBy7XMAN4wZBvOsOoHuMtPfeYI.0nq5dQq4ceXXcoJOYXXua3msH3HGgpf60hcgC
 8Q_ftcgvwAEtoB6QIkGspVU1dmPEV.vKIzLsK.esFXeTE.orrgBsMi4rw.Z82.ABfUXSDIzyF5Em
 ONVsJd14YYOum1tChYn.ggnb3NbGpAf18ghjX.4854XFLcUIqDST5bd7687SMCAfrMm7gISZIxy0
 noI7z9mF9WnDh1_kE5L1l32abN7py8P13qwAkEahK18C1fNRTcD.mHQoE.s5qzkztjMj5PtLLBZf
 wh_jiDnHBSWNxsbpbrGGEwJupvuclOaINWvO9rb4wyn5ZiWlZylfur5bpz9_tdg43m7_mFRnJa1v
 gdch5t61yDmy3tU6Rc06bXwA2vkq93fKi8t33dwobm7afNAODT8ZmbBoinkNidUT8mrHrJWV81lH
 XLKePrZDAdKVnheCQjWNO37Xqe38D2oIGykky_zrDMHgHydAH8lbURFsQRaCwU1WoWtASGeggFWL
 ZvU4fnDGZhyPpA.U5h37pnlgZPDvQiE8OQY9WH7OcxHKquXG2sfzAT1jnIVKzX9OfpACtrWOO28j
 GK.CHUPZXFnD1ORvGYmCAXPW50RXw5VhZDFpnQG8fQ1P6TwhcAG2vUIBXvOGPLz0Ve3waMJ3D13M
 bv_JPzvNvT2pEL7rnuJsSffjCz34_5cl6fI0Uyb.oBZSaSM9ai8fds56fSvrJlqL5gv2qBYTSNWu
 71gkxwvixM9xFIfTwonSZMkhJqsN_EOs05fLdRUka_MZvKmpN8TuKcVYP2kxoR2NMkJApeY.PKgz
 qP7x4QIlWg6ijGQR8IHbWX3xjtkAB297LBX_QB_cV_YvCBmcS1Gl_rnzMmIybXwPP34V5h._rVAU
 6HhgfeuBJNwkgUIuGQw2KQpdBzdV21g_G2bz30Akch3mO5qN5RN32r1uv0rliXZQchJl_Som1UMq
 9FY9g4bTQRA9GhZVbf9gl2SkcyUyra9T8PhYUVD5tqx5BituvTT90l3kKuU8e9R7YbAu9oARpixV
 OvuTJ1FrGSN8uNjRT2Hf_RrMLOpKRQjEcK8Jbj6GxVP.3PkoawBe4BP6kC.0rQiXPytnuZiw.QxF
 nQzTvElf1NWHmeglnzVRWKguT_CbsjnNWNSdKL0wF6vvrNxulpUxvxp4-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Wed, 13 Nov 2019 00:01:01 +0000
Received: by smtp408.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 4229ab0c2c09480daae2d5bd36928ec2;
          Wed, 13 Nov 2019 00:00:56 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v10 08/25] LSM: Use lsmblob in security_ipc_getsecid
Date:   Tue, 12 Nov 2019 16:00:05 -0800
Message-Id: <20191113000022.5300-9-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113000022.5300-1-casey@schaufler-ca.com>
References: <20191113000022.5300-1-casey@schaufler-ca.com>
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
index 6add7925bfba..a1659fba6afe 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -409,7 +409,7 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 			unsigned long arg4, unsigned long arg5);
 void security_task_to_inode(struct task_struct *p, struct inode *inode);
 int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag);
-void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid);
+void security_ipc_getsecid(struct kern_ipc_perm *ipcp, struct lsmblob *blob);
 int security_msg_msg_alloc(struct msg_msg *msg);
 void security_msg_msg_free(struct msg_msg *msg);
 int security_msg_queue_alloc(struct kern_ipc_perm *msq);
@@ -1094,9 +1094,10 @@ static inline int security_ipc_permission(struct kern_ipc_perm *ipcp,
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
index 121e395a39ff..e4b50ae05f6c 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1734,10 +1734,16 @@ int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
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

