Return-Path: <SRS0=XbfQ=AU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B32C433DF
	for <selinux@archiver.kernel.org>; Thu,  9 Jul 2020 00:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B47820739
	for <selinux@archiver.kernel.org>; Thu,  9 Jul 2020 00:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="aMHHaBcV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgGIA0o (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Jul 2020 20:26:44 -0400
Received: from sonic312-28.consmr.mail.bf2.yahoo.com ([74.6.128.90]:39435 "EHLO
        sonic312-28.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726121AbgGIA0o (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Jul 2020 20:26:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1594254403; bh=w0MJZq7E8vUExS16Agu5AzeHj9dg7MKd+ZyDKpSBqBk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=aMHHaBcVsxwsHk/89+YD8IwbQ5pDT//sqUAzbd6uH9c9O2lqNMAsOwhuCTr5LiXozR+VomSmlOPJKpA92l5A42VFZMlrV8WtHreV4Ij7K776AUrpQXgcittNSDqW8ND7/buS5irFbnd4iE6mJ1sOM7y3rTR2Na8dQXcR+6lqw1c/bgSIMDG2xMhsqqPFfKuPqtz2rcb83pw7loE3WeOw/jjKrWE1kbYNTvN6HN0kuXEc9Ho5vdt+L0d/GI6bhBmxbUDpqMFUlNPn8MByQcb9XVS69GJnscXitmmzvHFthCoeWjRPPmsrj04H22oXNStVyeiO80HHAiMPrTaw40174Q==
X-YMail-OSG: KAXdUoYVM1noEqNIQ4jcrVA2gYuMCIMuDMfWRKOXN3rjz86Rvvp71f7KrRNpc9z
 isTXzsvmdSxvCjpakgFJtrkF.Ipbp17s52xmZrZb_L4kxOWzJShKCvMlAB4axzkzL5eIfI.d13fj
 UUIcVMHnpxPxq2Z_g5Evh0FZ0Ez3Y3X_dYJK9gTZWOmwaxAWiAInZMGySLQ38Nzuza8kjzI0FmWW
 7wHtI43iQkFl6gT52i4E0ipfqq76fjBKonn5yxLt8S0Zfkvn06w7WpbMjLnLfRBBaFTPs.uoHmlO
 YNR4Vr3Yy7s0AKBCIiidq6TYtlImgKMhuXlLnlPqpOEpUO_vEngcGyXm1rAsiy6FLVN3hJUT.6IJ
 57SxOvWqOUL869OyWYNYKKLv7HOf.hL6bxAYTl3QfpWJSnhdCvF.yWG_LJblggGkaSo5uCdgnBAl
 RtFMT3Rg5QZ5TxQWeo2WQepuhvAptyqhhpZ6ke2plF40DWClfcjVDXQV_tIWPIqz.GoWtoexPS85
 IUUOHiNATnY7SVJBVR9b3kyn_U0HUlNVSa_hzAWTLxwumJ2Y8mA1Ej1rZBU1mvZk6L1LEhTolOC8
 s14sskYy2nAc4v07Ftl_RbHAPY6NmIvYlnaSJd2HP211VU6zMteU4Zj_jnq0qdGF_K_pFeCOSyTK
 TKTwkNyChPtgnvEHhdNa7BEACq4zZFaub9.w2yAVRxqbU6gZ2pttXL_tfxPKuz_tNc.yEmSs1ArB
 osHEkT27I9x.3Yl9D5tbT7gwlHzTSETG_4Mv4EymcMtwjNcAwHw.H.7wzd9P1JWb_RmpzBnGtCH4
 _fOadMlyI7UJDNjroSMBUj64Ab_aI7El6BKCInCFXSKHWuOtoFeShPTC37TK0wLSc25mul8UEBOA
 fv1L8hp5_0oWtIkW4Ilywml0AfkuDOHf2XKQMq57uO2faTe9.oz0zRo4yUfp8_1cdglnK4e5Io1r
 1U4hdOkIS0XzbOpuBM_29Zgf6wjY1xM04vcuP8c0DDtHj4jMz1H2W56m8Ns_wDLxvYZyfuYRaE1n
 5tj7j1ktjGFvqXV6RmJn_hPHhwnFp2gvxqjzaS5G0v45QhpvGNkYpBvWNmM8m.boZRjjTMhNL1rp
 MDE9b9peroMhd_qHy.a16mTw7HWwdRchGEbF8SCwFhFzCrsGaEdWJFizkv9TPBdUvPFxMJOVH7LZ
 dXe0c1hX7gE_fMXEIOQr.cqnitXNtui708SRDQJms_5xRacy.ttZ593nk6YSymceBQt0j6d16jYS
 M40Z9whJPJ9J6OFNy2p7uh3YP5IZFj1A5g1uM4acVyVBw6D6osx4Xk.OPGQxfj.1mSh6aUYmESxO
 GCA5qbNGIanOov7BwaFuDU1lWIpNt0yHWStAqtGPAglpcoHkrV2kmeu9p5ZPbawBKDWisTucqlXJ
 i65QqcfGqb_aPwAsX1TNkGlCPXvymbv.wPQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.bf2.yahoo.com with HTTP; Thu, 9 Jul 2020 00:26:43 +0000
Received: by smtp410.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 5663245f750b7eb0a7be81c3616cf370;
          Thu, 09 Jul 2020 00:26:37 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v18 08/23] LSM: Use lsmblob in security_ipc_getsecid
Date:   Wed,  8 Jul 2020 17:12:19 -0700
Message-Id: <20200709001234.9719-9-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200709001234.9719-1-casey@schaufler-ca.com>
References: <20200709001234.9719-1-casey@schaufler-ca.com>
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
index df5e4e8d8e2c..7883975ea6b0 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -493,7 +493,7 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 			unsigned long arg4, unsigned long arg5);
 void security_task_to_inode(struct task_struct *p, struct inode *inode);
 int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag);
-void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid);
+void security_ipc_getsecid(struct kern_ipc_perm *ipcp, struct lsmblob *blob);
 int security_msg_msg_alloc(struct msg_msg *msg);
 void security_msg_msg_free(struct msg_msg *msg);
 int security_msg_queue_alloc(struct kern_ipc_perm *msq);
@@ -1214,9 +1214,10 @@ static inline int security_ipc_permission(struct kern_ipc_perm *ipcp,
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
index 3c9525c72c89..ff30714c89dc 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2307,11 +2307,16 @@ void __audit_mq_getsetattr(mqd_t mqdes, struct mq_attr *mqstat)
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
index 2b83735ca7fc..b52d8f87f8e7 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1851,10 +1851,16 @@ int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
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

