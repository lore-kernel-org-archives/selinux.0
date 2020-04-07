Return-Path: <SRS0=OuNA=5X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1EBC2BA1A
	for <selinux@archiver.kernel.org>; Tue,  7 Apr 2020 00:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39EE120768
	for <selinux@archiver.kernel.org>; Tue,  7 Apr 2020 00:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Q+dfV4Z3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgDGAK4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Apr 2020 20:10:56 -0400
Received: from sonic306-28.consmr.mail.ne1.yahoo.com ([66.163.189.90]:40227
        "EHLO sonic306-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726417AbgDGAK4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Apr 2020 20:10:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1586218255; bh=MHI0IvzBXdpPtoeU8HsEweqySq5ScLxvKrqTpMcFywc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=Q+dfV4Z3moKsKn46vodp9lUQGi2v+ht2TcMTWdTBV3HmpTSlpLeH36h4ks+2Z1za5c2KPq5tByMcFm19/96oRjD/1wELkvnC1iVY7wIVHLtGF/MLgUk5xHBC6o8TGnlhPXbbV6Zc4sRaRbL3n2cwFawAD9YoiZTnMd5eO9GhNFEGUMWbOK0bLLZ2x2h2JaoDjDogXndgh9DiqsgRQZ+GoPy99bHMbzniUWX+kh+R+/WQNMvptBPldmNfdVLt57KgP1L4c561I7VdQg5BRrbluPgqSSrdWNFeLgBNgpXMeM86bkbI0842/XzLhkeFkyLV9yCvL4JH34MSiUOjAw+8Sw==
X-YMail-OSG: 9nFUCNgVM1lR7qF9KuMbU9ULpdB7zOvlKh_M3OLjIrjpMZ2dfD4U.Xljs5D1opB
 9TcreFpuvqICVD2dUqvhcux0WpvxYqd2Hg7VOGPEap2zueY3VcnbqHZ0Uug2Bk.daQU5J8eaM0Fz
 Vhbce3NMYhepj9nVH6WPglWJLFv8OhY8iQHmZk8iTusXTjlFq3RudHTEpVxSiyOXNqGfn_GZ_s0j
 gQwPqG71.3kOCv5UhI1htY9Cn_Lcv56RR5EH24p2nlHKsz3pKIn64VyPexWg46hknlKtKGo_ObyG
 7AacXkjz3Nt1EE0Rz6jV4vq4zofllfN12.M.cuzMVv_GJt95dQzULIJMrpe9BbU4h3bMnSWc3wWb
 qrInCyUaB_6R_uIhL6Rj1f9IkUXZ7n9nz.BrD3.p1AvdDTihiUDZWHmspvpxmYLBB8QVxPO6T9nc
 f_mVxfJpB.3AY4SC201p4AcQCc1bB7rLjsOu85jAevr0Y_bZXFGa.MQhHGTogQ.I0gXv1X6Ezzfe
 wQzIZJEutOJ0DfF90Lj8FU1C8z_i1cQrmnN4EDKazETs9maoVqGrj6Fjx4EJ7BvCdEoXtzaLz7EL
 SL5dEAzMR_1bdZYI_VCKn3YlX3.5ueq2h1EMJgCIHJv1PSVWnrlniGsM9GkzCx4gV8q.4p.cPejl
 .yrF8iq71Gs0dpyJleaIi3WwSfxCTvWN68oaFXpTUSbs6V2ZT8UJAxn.j6_o.CMbErxQapmyhuRN
 9qlwx9wVlREoDnoGlSSG1qOE_lJKUVlTjqpooLQNH2V.FfUzIBUz0x_sp2g377JtZ7FIJxN2y8W0
 iLdycI0xRS1kHRvsUrC12RcaMOrgp_kq8H3vBq1GVNuXRMw4s_d8eYDcsfbaMzCRda4O1q9xRMQJ
 Rj86vQ8tx1c9RnumF6gAuXSlUuSuDwFXAqwyPnb._o6coi.KGf4EK7z3BR7LHCAv5Xygqm5.DCN3
 uXmGKF5E7NiQ_UapSKONTUTUenXfh6lMrZS.xw.qJiun6rsdadn8bOzk8ZTfAhCpaEnSDw79LYxN
 pWd6jfM.Qu5TSgfdlDeA1oPrpCCDTfEroZqvegAh.4hBZ_Q0q84lG0oVpKc0HyFYC1ios1Q_m_N0
 HH4mYOXyfmmJ.6bslrL2nj6.UI.udJUcjXpr4ZL7AL1KfaBz1DUNpxBD2Cg5gHAoX_LUIbgUDhTh
 viaoBR3fSGe4.eEIRIy3hYDOQjr8hc0OghQ6D3nbuBNiMMul6eoZC.iFiRlbDnY4lkqebIAhtyzZ
 7nU6mk6e77V7agjw3Ukmoj813LyJFCKfph.Jh03rg_YplXfd0Oa.rOHWObOjsyjD.xPAHauJ0PjM
 aJUC_Su.1gDPK3ltZGuGi5Ei5XIAm1nxRhHfFmpexl15EISkrZxFQ0y53qjuD8ayx.8U3GCE99N1
 LgfCyjicfF8Uywu.Ops0yN2O0hEDIGWNArBYoywoPb48R4hgJaEq5yhEkmMZUbQvBUJ8-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Tue, 7 Apr 2020 00:10:55 +0000
Received: by smtp412.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 872e464e2a367a830538f58bc8b5b2c1;
          Tue, 07 Apr 2020 00:10:50 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov, linux-audit@redhat.com
Subject: [PATCH v16 08/23] LSM: Use lsmblob in security_ipc_getsecid
Date:   Mon,  6 Apr 2020 17:01:44 -0700
Message-Id: <20200407000159.43602-9-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200407000159.43602-1-casey@schaufler-ca.com>
References: <20200407000159.43602-1-casey@schaufler-ca.com>
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

