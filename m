Return-Path: <SRS0=4d9t=ZF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C7CC43215
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 17:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B34F206CB
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 17:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="fiQPsIdl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbfKMR6G (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Nov 2019 12:58:06 -0500
Received: from sonic306-27.consmr.mail.ne1.yahoo.com ([66.163.189.89]:44615
        "EHLO sonic306-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727112AbfKMR6F (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Nov 2019 12:58:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1573667884; bh=6IK8Jmd19p+jg8RRRWD/snF1OW5tAad5UhaaNLHME/M=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=fiQPsIdlqu67Ulrv0aJVzrLswuTCfQzR13wcAbCW7BlTFRwsjxbDSQZ8xlSo+nLLm5tNBEBi6Re9GRQy1iXmyuhyKRoKgCKpClRM/4goTi0C2YmMUPJmDVyipi20XMlJ6tizqwjcJfkIPe7xJ29hCsXmfMENxAaUTrBbjEFhXTGJrXUvs38xshcIeXmbqjQoBPKmi39J97tSA0lU7iFoxj0cJQ8gQeWb+BNFE0mEOtkwAmPJ6G1C8wl0i2uit71U7z+rHktNmcNrtAyr7S4HZ4Wib8yYAcBt1+vn7e7k7CVekk0K1Q4aul+RwYGp1Fd8vTmMrzY5pdqXKO4tDrU2cA==
X-YMail-OSG: K3Sn1rMVM1k87i6LyA3pyRuNR5HMtugvbeK2FhBzL5yX6RWz6nHgq9Hrb6HRP9M
 uVnsSVJ6kmb4dbl5BlQDcc6QxPR06iZds8YkQLV9liQT8uzJ0doO.oBz.4gGqqARI_1KexQyznFy
 UyLAneGz1y2Kn7wE8W2X5_AHHNhg8yx7_h0tbzMA0T4zI_uiepROqHCCeUQK3GCQGYDtx693fQEW
 z8Y0JAuN.402yzcpeB2CSSmOfUSDyr29OJ1rw6MffTh2PVUdoyZcFId3EAovPFFbXY8iC4Gk17_U
 E455U6yyHApCS8XL5zKn4godyGKgncg_aMiv_6HSG.YacSYIhvIW4gHgSP6WggoYGqT7ay42uEL4
 WBzLKSIFuJgRLPLIQKOO7HefAZI2iwfiRPKfyBKsW_FLjSiTAlkynzL.L31H13UBgq.RpjZMLp3C
 ObvMCeLFcboZ8afLHR1DOGkrOc2TYBeLnb5EQXTeCu40mJ9pbxpYzoiTX6A_.DLaeuQ0ap0JbfHT
 yYaT1X2ScsXplMZIOUIsW3O1bqZr9mv3YL25x2b2S8bW3oIY9fTBfstSMxaFFfwKS.RjzKvr8Pv6
 vIX05z5tvFvvEnMHOLSRUxbqF2JVunKecrfXLWCm2KVKEH4NDB_z7ghfoOy8Ty0SWbWypwr8Urqb
 JlCN.cM2iDdVHIWDALf4QD5XNedFfB17RQNkn8Rhh8v77__B9k72CPp5yzGJZtP_R0HSCYT9c8PA
 esDi1ecV8Uz8Dr2LKnnGrGBzyrlA7laffVbhcJI9tiuyx6Ac4nfBQ0BHb6V6crk8_9PbpPNwf7tY
 0imShK3XM6L3P7BOdqCqxfy2_RNodsw4dPv9XGQv7cbDmFlJoz1INIs8BWG8p9cFTxdaa3ifAfgT
 iZ3._LvHNXKNiMv8TKf_bRM0OdO9QUAtaTTk9lp2Y5zvJ0aGrDaTeh0K6PlfMk6swah6aNFuMz7v
 0LuddKVNIKw.vrdPNfp0VGDSYVNyIYG_90EimXgJcXBX2SwAz5Am2a8OvPWsxybDqw2WgRxRRNfP
 Vtf18OQQezeRNuBdkria_Vb.2GRZPOkGb5U9UXJkg5L_URthyUq2qH_XgO9nvKFdeVeZHwRA4Yy2
 3iFtvxjBsgj5Rhav12iBNKE69LB6WJA50pXdTQoDLuKtxtUThOWRQ2uGOsl9rG.umj4EFzIKw.eD
 AGqGWlbBVjgr.z3bIa2trH5RCnbpBddzBGz70ZdwYGbN3ZH8Tcu6puQkWawUMbU0W2eA5nkikeZr
 C4O50YqsbHIzheRGJYLPGo7SmZggTNdJZO_4RXgp7JTC8CPEEokfZd3t4VuZ1W.rYSPdlo6DKWu1
 2oUHZUv6UWD2WR_8bNNXu.oh2ubqIi4gj.uq1OLqXNJXUtunYhSKqGC6zyugu66dHfSAmpQ60VUT
 Nmvmu4kKMEx.I3Tgb33jGwdlR49T0iG5j860oBa9CDhAtrxIcuQxmXiklHowdv2._lxSXYw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Wed, 13 Nov 2019 17:58:04 +0000
Received: by smtp405.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 8aedd18827384fcb8d31d3c5ee93475e;
          Wed, 13 Nov 2019 17:58:02 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v11 08/25] LSM: Use lsmblob in security_ipc_getsecid
Date:   Wed, 13 Nov 2019 09:57:04 -0800
Message-Id: <20191113175721.2317-9-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113175721.2317-1-casey@schaufler-ca.com>
References: <20191113175721.2317-1-casey@schaufler-ca.com>
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
index a3e99bccb1bb..9519b4fb43ae 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -464,7 +464,7 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 			unsigned long arg4, unsigned long arg5);
 void security_task_to_inode(struct task_struct *p, struct inode *inode);
 int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag);
-void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid);
+void security_ipc_getsecid(struct kern_ipc_perm *ipcp, struct lsmblob *blob);
 int security_msg_msg_alloc(struct msg_msg *msg);
 void security_msg_msg_free(struct msg_msg *msg);
 int security_msg_queue_alloc(struct kern_ipc_perm *msq);
@@ -1172,9 +1172,10 @@ static inline int security_ipc_permission(struct kern_ipc_perm *ipcp,
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
index 0fc75a31a6bb..b60c6a51f622 100644
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

