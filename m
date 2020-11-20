Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0927C63798
	for <selinux@archiver.kernel.org>; Fri, 20 Nov 2020 20:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 975B424073
	for <selinux@archiver.kernel.org>; Fri, 20 Nov 2020 20:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="j2Q8UONE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730663AbgKTUXD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 20 Nov 2020 15:23:03 -0500
Received: from sonic302-28.consmr.mail.ne1.yahoo.com ([66.163.186.154]:34539
        "EHLO sonic302-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730651AbgKTUXA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 20 Nov 2020 15:23:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1605903779; bh=U5bKWCQ1u99Nru5o24TB+6IKzAJnsO7yXV4aGiXz6j8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=j2Q8UONEMHycXUGqVXBrOuh+XDIozOhIbO0Vlh4G453nKrKGmFCO2l4Vimg4zSYf0kAn8rIhXJu9Bm+udngdg3PWGrjWTCIZaJ9iTOF2mM0+TfnJiflexelXS8x/92YZbCz0zzj8q4i8Wdlsd4OJOYN4wLJntcmIV5i4lqnU3eAIpLbwNm3RZ58hlGJstFBTnEw4I+swFi+pXFeqoK1upD4y9M4fsLuw3Vt9vpaeX1+FVfqY2TGojDWefvMpEAgN4L69e7gYiRz3rtHqnKxNbFAso7JDObMOY6C1n0l0F4rpfK9uvOT797uksyDGrtw0hJvXHVccBTO+vvKRhYyt1g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1605903779; bh=jUNmP+rfuOlzMzYHIeB6sRYJpkPbV3UBc1+mDGPDr0s=; h=From:To:Subject:Date:From:Subject; b=eIFWEVkJ8dTthVPVFgpd/SNj47M5FJM9re9XRpUwV1RuyNxA1Qn2bGR5wu8UYzFp4NWHXymVfGEE0lpgbFzGaGZcJXojpcV6CFlfbnbj3QnMkxt4m3QQcBBDGB4ZY6oD2Bkm2CFKRlMRQIPAfIi3hOB4Dpu9qX02GmYYYCaKwQc+1Wo5Hi1ZE833ke9FA0D3OimE/ZIbnYCBwkCoVtrPJCke4eanvhfj1kylrD2Cq6ApDKZkhde17fEfXsvdx5oR3rIIZB8CSsefa/SEuOWwyssUR8xzhGy31KfJlCXMuExFBwDwQFOuAHE7Y31j+JK+xITCM9HAnmEBotKJokHAxA==
X-YMail-OSG: M83UJ_EVM1lelBUYSmh7Fx8vIBQfQayYxWAvbMyRPOmHrr_gswxoAiB2pBiyumP
 XMRhLnH2am.lhprytDrj5SyovPHYYSllRsulPfqUs0nqARSI14TtQVP5AqNb5lxCMH47P85daLu3
 sy6VOyMeonPCg1aE0AUU8BLQErqwBv4gzHGmltEurAOeVtgF6MHCyeazzv_Y5eY7TlW_DHsd_ZCE
 z5qa.CZ9KrBwuQTh8Roca2hox6Ir44HmmJ4oBki7qWUfAoUX8Zoag99HFKtBDcskBUYFd2MXkTi_
 MOmmvLl6QnrX2Yfu_H05wdenfc40EGRRo8eLCyTTtdTAY365Qpwpw2Wwo_fs6.eLz.hXQwQbf5We
 M5wCtZgUKr7ZATah5Wja_DIdc0UUU9yGIRbq3HTQgFgTnPUQbEyrZqNR7Vpx37.EY5Hr33bQSblk
 DQBVJ1bEAXdBzRjjrBvHCxDkAyrKc0_NvCjiVTgvakaUOhSfGTYiOE6Bkl9cjd88NT1wTynNqZQe
 CO7omYPWxcy9WnkqwM_IgkYD_AZB9sKxRamHmj1gmk56ulMQsOmYFGDhDoZ2xmxHU.S0yJy7ezqA
 yRNPtKTEQIty2sKzgNpMiyXyQaSffuE0rJaEdU_A3zTbmXQpoYfZaS6CjI_d5c8eM8qWhHkoEqIb
 7skWDsZRffhrFvpe7W9.ZWgXdTWp5X1R5QBiGX8lzE.LLeUPlC.nkul6qdX3aoFURo99rwrrPUPK
 LHY5ZIVSDtjqvinz8XwEEyZzXL5Hd6XmUvNv8m26CgsFQAcLL.tbw9NCwM9uv8cLdO2D2gSxXLR_
 e2K.rYXAJBBVUs.9hak_XEG5leu_45oFo7oAIQvfMuSNWZH4s_q159YHWUN7UwFgbKT8mRfksv7r
 DT2VQN7WT4zuAbCHrGCr1REICYeXXdUyvN98fw3nGFFMalOWNBbGNBUMtElGmQ7TupSd.tSeLK2f
 ADLEs5AzAh3zRFfP6kJMJaWHrOUit6eihond8N997epbXjHrE3w8OkBcTuPAqLLAtYgq36N8nHk2
 YTh6zQeMOiljZpnJXtKTB8uWg_fmE.aJFyKAHqA0PoYESFadq0Ayx3_NdI4b2lREb.LnJEuuVFQF
 q.CELrkYfAL27wBTNYUwkao1SckLV9a4jLEz3MCOud6.qkmp7heItVwWrUKUPueuCBNO6v5Qtknb
 ivf2Ne8kS1dFyuzskUli82MACFsUiQeHS7iJV2Lj5y6KNd8EEcWdGtXWmRV6zpiKU.95D1NvOixk
 XxOAizQoZM2eJjEme7FknAN729QqlrG8dVBc7gC34xSveANnzbS86fNiWVODg8Ilv_fsmdQuA9yt
 OzLv14EfZlTbwaXOxWrfkMY0H6sSaTQUo7wbN9ujd2HKU_chQqHhjQtaXKpxDxve2znh1qFTefkG
 CHAbDnWHiTEgIkllogdfPfKDMvQSPBGVWzeY9Pvrvvk0DbyAp5MmHVM3z5y9Lfo87WwFNqLye7RJ
 DIZ.PD.S0atVsqmxcGiCY4qRZrIASh_Mo3PFQ5StxeUV7v2BwCY10vX6WNrO0sXySyH5D3196rQc
 MTyQc7Rb0IGU34_YwsOU0aE4UPMc9j6tDL6DtlMWXRmvtKHOfcokXiz.qGG4X8QuxaZYHHumba92
 g_ohmjRj02Odz2n6IPW4siusXgyK_cr08MzyXFL.sFK238dkLssGeRfryahg_Z3NbtjjD1eYwsTr
 23XWUVPiPudPqueSrBm3PBHAVR6pvpFeDWGa5BU1pfw2MuuAlI_1837rLNwOVCYdpBg000j4NL31
 2wDYqmWzb9l_rbDm_dzQeDUYL2PeEdcA2vBBKSjnqHnj7Hc9aAIDjzwFovXFfMgbVLcoba4VIcR8
 HV59KUekw3qKvDvADUIa497ay9jgsTLWenjVja2b0uVWqLScFiU_bc32lSEZoHq0phXxFD1JS53p
 _a92mmw9phsoAE5oMJWuiQBJrgOckVLu2GrfXOu9LxvrjSxUvzN92ZmJpyTf9_mCUjaX8FNGzIxj
 fA.4nSlOqN2y_Elwmc2nG8sJUFqHW1xy3Oey3Jm3Y4urikmPDP6pgWogqS2CYoy4THYIPTTgD2zZ
 OQvZGVSrTkH5XMEs_YUicsrjldNI_X29wukFW9miX4GfINsfPlxPDhLqHeakBsK2dhK4L_p2TkCf
 agbIP1Ln2RFicnjy05aBZQ7DEyV_LvnAmUyHrTg3ITiuYRiHasJvpUUYstyIF_sMT3sjCNzWmSJB
 vDablRIUkGorEHRUcIXpCDj2DvxAZ9nJJpRhzVdC1kz023ZTx2tyFs4grYWAH68.BktWUCDP.tXq
 oAx3527xZ9BAtVtcjTpf5lQ8yBDzqbf0tAbpsDRemukvBsniLL3lyzbYRl_CPY3yb3CYw5vEZ2pZ
 NBCfKCtMC4sq9yIFkSAHX1dRS8oi3gDgzFkGKMqj8ULmv3Nrnapg2guo0g5l2wFtvzomhsAnKMHr
 0abdk2oltPlnHF0.HGjbF71bq6Yg63RNMSuJ1f3uD7pTahQsBvTjM_uzYlBZ2xGgqnrfqZuG50YY
 9DpWrl0OONlevi1HvsDINL3O2a1FdEz7nJIH2k7KYH_fw872PBli7bByL40lkdWI.CbuG3Ah74um
 72l5ZQeKeMpV1hFRJxAiZLjQkI0vGOzQfUjQVeIhHgcS8C0YAIJDm0XELDorQAOHXGXJj4uFyo.J
 vSlqzz8GwimXMWz7Ux3D0u1UqwF6dvw9gg8OA04PeiOoXOFYuyOcnm9wabKf3kjHq0W4eHc3YURR
 8LOJ6angztMQK9VUKK2Gdp8YLcQRun2jQx8lzPUtU2tVsNQaTDv0vST7eCsE3Obt4eOSzoonEOJJ
 .AEjR09_buq5N5w3yPeoI4KDGTEucVho2ytNWmz9oasT9uafnvRuK_Lvxo4WGavInC2d29nlATID
 WiZ1uK3bohCGWkjrE989YK6tKn_APNrwYOFxhWTiOebNIqcBpD.2ooQ1OjKyI0d1P6HIslKGVoAG
 fiqVNgxXfRt02i5kEIucAV0mHpd4m4s2ghjvif25vJcjDxFsaAIwYeTMOt1X5jzOaGakpf7nwZYX
 JE9T1J78LmwSDXjsej2B2kqg5fgrnFBD4FWz7b__tIIXnW71Q5_SaETbnLM2uJx6Fvt41OEspgp4
 xl_ze45XlzCRbe.xD2.3xCf.Xz32la.b9vthLV932uDyJ43M4QHgYBroFXa6AvoJhSFUeqS1r2S6
 Pp54hcdyalK75ti0oFSdrq6dMwT5nbrzRJ5s3rThJUoDUF3hZqJ_QHCXUaGniC0rP6a3mPBsh6WH
 d3KY1yqsVL9qpbygFjFw82ZYH8fcuVbZB8e7H14hl6yqvq94qq13cea9kTkQxew_V2n6MZH8zNIm
 5C4ktlPfm
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Fri, 20 Nov 2020 20:22:59 +0000
Received: by smtp417.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 1e2f2843ff94c68f163049ce41d7b5fb;
          Fri, 20 Nov 2020 20:22:58 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v23 07/23] LSM: Use lsmblob in security_ipc_getsecid
Date:   Fri, 20 Nov 2020 12:14:51 -0800
Message-Id: <20201120201507.11993-8-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201120201507.11993-1-casey@schaufler-ca.com>
References: <20201120201507.11993-1-casey@schaufler-ca.com>
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
index fad361bf320e..be8db737da74 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -499,7 +499,7 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 			unsigned long arg4, unsigned long arg5);
 void security_task_to_inode(struct task_struct *p, struct inode *inode);
 int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag);
-void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid);
+void security_ipc_getsecid(struct kern_ipc_perm *ipcp, struct lsmblob *blob);
 int security_msg_msg_alloc(struct msg_msg *msg);
 void security_msg_msg_free(struct msg_msg *msg);
 int security_msg_queue_alloc(struct kern_ipc_perm *msq);
@@ -1228,9 +1228,10 @@ static inline int security_ipc_permission(struct kern_ipc_perm *ipcp,
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
index 5f9bdd62f78d..35d6bd0526a2 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2341,11 +2341,16 @@ void __audit_mq_getsetattr(mqd_t mqdes, struct mq_attr *mqstat)
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
index ea927a00de18..9c1098ecea03 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1882,10 +1882,16 @@ int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
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

