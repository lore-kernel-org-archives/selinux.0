Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B2CC433DB
	for <selinux@archiver.kernel.org>; Tue,  9 Mar 2021 14:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F49864F56
	for <selinux@archiver.kernel.org>; Tue,  9 Mar 2021 14:53:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbhCIOxI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Mar 2021 09:53:08 -0500
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:38240
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231735AbhCIOwx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Mar 2021 09:52:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1615301573; bh=usTuQN/ubb1EFIUe3c9whA5Y9qOmw34rBjIeCw2H0+w=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=rJTOjcVmTHN0MtdyD5fWx/k6cEVl4zezX+k9v5INMfYEo2qqEtpkZk123DFdw0RAJq/URNFGywdKI3ZlpzjE++e83RDqgiW0hcM9fyWwm+1LT5hU02wtMApSvtw9Pio3pJnIBkreO6AK7ZQPRLhq5rSHfXHIdHoJbZFKGNehv0nTAK3dRi2GKCJskQKaWLk79xt90iSmVlYc9eobIhRWIdW80yU5JPiAg8uOGF2iV7MEhwyz+vFNstKaZkh0LIvnl2k/gKXWRuanrZ89O+RNpmfsP6m8KsUBFZW+Tyuy5RR15rSb8q8xjwuLZBrpzFIi0xHI1LPhTTgwBw+dOSNnLA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1615301573; bh=8BHFneAn5JIuF5O/ij84Bv6/NLObLcaFQKEBsW7iMVi=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=V73oEBqUOCdqOm3veyVf1jtuqFrp1ey51BVElSmspgCLNRhb05ecCxYtd3UpADQSgEPO9FZOtmBBxrvUMI5y7z90LxbKLTRCHbWZUN2J419DkMfPYxI40y0nN6gEpUitMMbmgkxJpl/4xHI+mu+wTJGOb3dCn2RsqSbWoeGCU+eYjhtgv4+Iewm77vwo8oeCeNOYKsISDXO5q019ipULub6XNTjoY9THXuOasM29+3J/q5g0nuP7E1fJOdgebsTc0tL+6twVLPC8Ldbs/MkSecdzOPeXykr9Hc6UJYne7v28RQE3Ut5YI9X5Ip8H8mU1rxjTAvBcjVJEjNjFQK6bNg==
X-YMail-OSG: g0jSePgVM1ljss9ZgcfVBcRCrTZcoHv4vqOjn_Xaz.TYM3mJsYy2WU4UR7wos4C
 2vapG0bSu1yOI0evICQHCLAOxfJGp6w1yU8BIECQdm8Js_l22BYex0cmSvTdr6_BTtvi.xJ.rXXd
 4adnLjIfcpaxLwKVX_jGJ.vPNsdkBHkHuRbZv2blXcbyo5vQM9_hatukofnLtVAQHwEa4X8mUSCp
 8pgIsCVOCugVQ2eJjYF8JdDw1.mPcNgu.u21C_Ma155oNkpzH6I4n60hSxWiRraFuHx0ILXDI_gI
 rpU1vUikqXPM.n3zX9cthYv6HcDJMC30ceIHT11Q_eGUn6h_JDUwb25bbHKwtQfyxd556xDaZ8Bp
 fU0tYcb0MK3HOm3jav2heH4.Mid_GHPNcKQmD0YjHdnvDFQcVAtTcxkI0PW3xDRPZB1Ic1q7y1rd
 Eq4CZqUPpW_j5tpR.f5GCTyYIGLkMXQ0RmcQR92xZboLTVLt1x2dffHhTAoG8cBFKDhTjILUvJvN
 zGehXVUQDCRtsl.3DXhcFox6ukLOt2cYbdGw1N2HEvBPHhJYSQ3J4z_9kQAiXYG1dJEWjOeh9D4r
 ElNnmeJwVZpXM3cZHBH3w6v_mq5rZjhSBT1j5YIRSTmvM7rBFigk_uUE1KBmOAK5rWDFIztL0VLt
 Zt8rSQl2pMQ8e8wLeyDXn9BfrWILSMEDCDnhJrxBH.m9SWjpT6tPZMCW6__T6h_Dau285S7eX4hu
 44wkKkWiaEOX6iBPyMv2RGI7EIFqf7ocKLOudtjQfxp9pQdM8hJMxFHcu5BBFSiSMhhyGcTWepe3
 rRhC8yGgb2wI_NfMl_QCAMvO_iGLe6V5xMx5lqyrNCbw4jZprFu3CYjMkI8oUPEMa17xVeM99yno
 DmGt1qwrT_4s0ZV2bDzGWVp0NlcWf5hRBbbs2tZMudjQxQGkYllT1IdzA_kP4oY1d2.d5WD03Bnx
 g6ZgEOmjbM0nrYl0_LhRKovTLvYnclr5iME8XeJND2IysYsm0U7rimIjc6mpmOHPtsIqZZhTmUp6
 ZFTsrSvjeQCO.RmUhPIMRBDuKXGtQp3ghvhawVxp_UxAGk78flZqbsaIBWEeKmznVhBpWvWI4ndt
 Q_O2oLZoE1YfhfCs_LrJi5R.zO9VRTpxEIjGwSODZpnuMU.TA9FwvT4Zq3h_0yyYti531UAytRhy
 O1R8vvVdGF7nvFAskcpQ8a7vNTVtQ1BwMXp0JMM0Y9pBpo7xG1nFLe4RG0FDKkQRT68WFj80sQS1
 CENHxfizw_1qRUm2MaafhzOSQHAd29Qd49HqluvtACfTA3BuNjM.fwoqcO74KbudhWMWZH7pc4KF
 U2P_0eAOwop0rRtc7_ostWKvVkF.3FhqQQzsYd4LtyQC6r2sha9R.BT9r6YfNB3_fnvjIckvqvxn
 Y1yZckNBDuMqxQ9P_2dr4_OOBm.9XY.m7B8b0iXK6tA4pbit8s2KWGC5o0bNEvpVe0l4zQKjOcrc
 rf8Hq5V_XZsL7oPgAiPiHKY8SMNDGegahePSJmIJAWkcNdaecXj9rcsExURgrFZX9kw7fzC7BIf6
 OQbwiyW5u_uN8JSeYXli1i1KETA5sWBi_p3.Yn1H8knbaTP6gBW4ooce4a7dx6dLuOtz0NzupzDx
 K7_cZ.9YBxrhfXEayWvauj5lcSW4sl2yoc4ICwSeK4IBYg4Wt1J2Evc8Vl0jJuQxr.q9VsIQWTSV
 pIGsXWeNShM6v.3Iq5JhWhXuqYfdPx92.SKtEID09ZEV9.dTp8vQu5PuNdDr6tYfiCYg73sIU2EN
 thJw7aJ8nJAZBbL6Z6W5.wnOB3lWwZ0IVntAsFALdw9fyPwM3j0iBiHDmbO91JpG95Br5fCN7vRP
 DA__Efxnfi89MSvXMcGIEI7eBIurisZKO_0ZQXsdJCDCagnzNReiOeykJa9nBVnFHi75HCZe2u5K
 EYZstxMAfQJWPAt7rLVUVMsaxGzpf7RJR9fHsnQhLFNaBjQFA5F6Il.JHPAmS9xy7QWU_ppfNS8r
 zauqQr6RytoC1R4eqG7samse1UbcyrarxEZ.g.zkM8Zak0Gupj_k8GiAgWbQl1XWmQ1Sx8QA3DwG
 ydjjWffAgSBLUXzzgkcbeMnK8344qDSQPcmvizc278bFvUqEUOvFZjFcb1eLhVuRGsW2NrgXgg0O
 HI9mSlrwDuSthFDXzfiP9Ap8LsUdtCuKOY0MgU_wWMGeIkLGfHGOzy7.6oqMavtnZ5ixNlTR1qKM
 AjXENfkdYiAHsMuTD4yb97LyCqnlBD33dskorPmrbdrFjaPfWPvVPQnUnEkvrFtxXMjR.cg8xW57
 CPPcKBedwALznR6q4CckbrkbkpIYSgwOwzFkQzyqimzFw1GPCv8ahf6E1sZkOfvBDaKDSCC5P2mG
 NrmPSTOpMhVSD_YEZUlcCC.1UxIib0X_JqAt0A5oKtcZYoqQSVCR.85lxk7aCojUZZouFUlgoMKz
 BRJqqvCvjRwz8GqRLNyAzE5i6qVMtxxxWlZir4oQ9eqqH9QWKgVsa1qTPWik4MRW2qqGN4WfBz6r
 SbAICIy.Z9.2B4yVZNUqOB6y6I89sXiHnmv515Tb3JVkeRfIXQqtqPAhjSzB.9APpGKR_cBfbDxA
 vpf3q7c6aBaz0mvrbPfZ9wHgXCbaDuom2_sjf4LDDvLlK8xKTHlmNZPvdGTAb6E3dsK2zB_LmQbt
 SkHAr3dhUde1.QovE_g.i62oO3ZaYSDmrtfpQAHndQZ.4H6Q1whW6eCj7kpikyNPRXEdPmTaDeKv
 Twd6ojRlUeo1lqZO.Tq4d_BhtL1FPfiPmvlR0qA.iIY3y6jsbJJx_uuQ7Ma0HTaJzv.9526CAGtf
 Zx14vApuRiGPYOykck1SbrT3iyu_HFr0rx4Senfx2PNwhIh5vaL1dmSGkMFXeEO1PnYCZExlnov4
 mXBa9vefoJM1xLQffdZ.jmiXqSOpGGYl_gVjyza7kF7JTygM5Y8biXhQhJVp0IhSAHNkjTB.hPzG
 U3zcCb9z9JoDPNEyipEX_watV9Xnd_BFSPSXg29ki6vq2tO9.ZRI1DMqCeCh1vPhOs3eBFHolr8L
 jPOakEfkW_G9htqgRH6u90g4kcIY7SgCF8oV.MKW3mbsbMn3qKqAdrLkstQ4JXQ--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Mar 2021 14:52:53 +0000
Received: by smtp402.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 8f45571bb9982a4b3c7b1c171608d68a;
          Tue, 09 Mar 2021 14:52:49 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v25 09/25] LSM: Use lsmblob in security_ipc_getsecid
Date:   Tue,  9 Mar 2021 06:42:27 -0800
Message-Id: <20210309144243.12519-10-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210309144243.12519-1-casey@schaufler-ca.com>
References: <20210309144243.12519-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-audit@redhat.com
---
 include/linux/security.h |  7 ++++---
 kernel/auditsc.c         |  7 ++++++-
 security/security.c      | 12 +++++++++---
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 01bf23c68847..4f5bc3b424e4 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -515,7 +515,7 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 			unsigned long arg4, unsigned long arg5);
 void security_task_to_inode(struct task_struct *p, struct inode *inode);
 int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag);
-void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid);
+void security_ipc_getsecid(struct kern_ipc_perm *ipcp, struct lsmblob *blob);
 int security_msg_msg_alloc(struct msg_msg *msg);
 void security_msg_msg_free(struct msg_msg *msg);
 int security_msg_queue_alloc(struct kern_ipc_perm *msq);
@@ -1257,9 +1257,10 @@ static inline int security_ipc_permission(struct kern_ipc_perm *ipcp,
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
index 9963c3bb240b..818e4389941a 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2327,11 +2327,16 @@ void __audit_mq_getsetattr(mqd_t mqdes, struct mq_attr *mqstat)
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
index 7a168d7adc02..23540664cdb9 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1941,10 +1941,16 @@ int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
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
2.29.2

