Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98C0C433E9
	for <selinux@archiver.kernel.org>; Wed, 27 Jan 2021 07:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EE8D2072C
	for <selinux@archiver.kernel.org>; Wed, 27 Jan 2021 07:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S317150AbhA0Anp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 26 Jan 2021 19:43:45 -0500
Received: from sonic307-15.consmr.mail.ne1.yahoo.com ([66.163.190.38]:37243
        "EHLO sonic307-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728509AbhAZRCH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 26 Jan 2021 12:02:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1611680478; bh=FpKGtxhyzTyHF0qxWOJjsudgR7Yn+20vUQDAWNloU74=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=HtJofGQw+8tUp0JXOy2hE/5dRQl9MrZM8ljo2gKWWzgjYEFl5RJ7JOerSZzQumhMlT1/0TAIX6cqFJ8ejCby/7LBF+o7HAJw95N7QNKQ8YH3d77g3WTpXLxAQj0haIhr/08EZmmrSAma1J0F9WJvJOCCYZOVZ7eDiRYen3Ugj6o5ouFaf/P47qqekEtPVYPVC+zBeyRkDQxPcLBBgObYnMwe9oNRKCwvCzm9269A9JoMxIfFasRVlxtUbW5kgI2GuWgOnI/Z1s24XckCNTJwDXdHkKxjqkL0+GhmFldxa4OTwbyoMYU1vBXHWoLYQQvU+jP21rFoXxaYG7i9lhhKoA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1611680478; bh=4kupzX0qrgUB5q175yvNFGL1CUGWdK+Xsjxi9HNb88E=; h=From:To:Subject:Date:From:Subject:Reply-To; b=tV0YeomtZxhYyKeRJvGsKbv4vUN6T6qBOxjAC1KaQsFtDek1/DryzarB6ediVS03CAM5005Q3+appUYUq8vlgQAHvOtXPwJqHh3MEZfarvsMJ27Fm3ISgQbXwmf1ztM+qKx6hyPBz2+ddFxOSnJt2nkXQRQR5LvXyB0wws+/Ku/s0jtYVc2VN5zbqnnLspb0Ra7Oa1sLJT1QG2cZh9e40GWbrArwAE4NBcofLeVi/550OJ5CB8frFtgcUMVP7jAKUWvoycXcyKHp7n7sTAbcuAhfSJfTNZuWbqDC1eo1EVhw1ONiDWZc+5ZGTu8pDKqnj3yl2h8Ak+/Ao/TLl2zzbw==
X-YMail-OSG: WhoWSeMVM1nAZdlIGlcybNdqVFEUJtcDXoq9vQxygvju97vuRBhgg2vxgIq0KlZ
 Jg5WJEN2BPPKfasH9qxP7iioP6xiQfer7_r0cUDsEM7ZJtNy49r0F3Ld1u_L7j1RXUKrktZ2NRzq
 ggdUjjYLEOgprPxF1Evwij5yi3jxAe2y55gGARmJTZPDCL5.eMZ_Oo6_Cu_7Psr0Ofc60HFY1Ug.
 0IB8aNryvqWhoak6Xl5QZ2PXupE9Nga2YbL1lpwZPEKsimZniTyd4HeraRz5PF4fDL3UI1MBwtmr
 82nWLobdRwDkG1yEgVzMt_pkGFH6ghmYypM89Z4E_fT.lp8Gs4jrRCh1kGsAa1oY5ip1Uu.KBfvb
 OUshJ5KQokurFNYAwXvG2xPR26Y2vwUDXN_PLFU2VmkCvJUQRG5v7mG85B4DJMBsYVL6q7Q53LmB
 pFMVrWAY95KV7IL4LyX_itcSVvj6ZvFV0R3Ff1BCpFnbppNI4G2fcmleWk7QcoGOSuAXNs.neCf0
 5a9e9nEaBfupuEOAcraN6M.kCO27Mf4NuH99GTk94MWbMmo2RJyLoIz8PszJbdNVZG2LGlC8KD4t
 UFQ7FLDQu8WbbN49rh.OzdNjvCcOqQGnN.hRhEqTvOyMpt3mTPMVzhP2syeRb6I5j6nT9uxxUCL1
 AzgaBWfXW7FZd3Fy1MgjzdeEgfGWNqKQrWIpdqVeC96abVXtX.3NvJS7IoXv2FeVac16PBCvBOs.
 jKeeUHxKHHD1mFHAS_vdnbRwI2tkgeJEL3oMk0Tkz6uUWBdMcKtCzsMmsr5pW0TVOMXvHvMS4mQN
 S4w.pzlbBkLgR6OQvvjlcq4d9HjyAKZTA0mWGv02qNDyDnjXMC5q44mMle.ZXuBurNQFvYt.vP4U
 1BCnwcQXQxVQ1NpSQw59OpUthYu3xUh9W6Rz_bM94s8LJGXW1zSqtI4evgZaH_shpgNskx22B9Bz
 YQpidUJ6mFEraRgNgHF9_bitv53Z57dmND2z.hEvXP7ZfyNy_v7wskBEfDQHsAXQT10RDL.6yw0I
 Hs.BffJPtGNZHLhVnoiLNVd2xfNL1zu3QX1E_BlScBEwLuCZLa65oCv50Sih9Fatc4JnTD8vJjhN
 XMYkAvUlWy64uis0qfu3JQaQEV_eNEK_4zRxml37NUJBup_aXo6zZTR65kVcgjVZPH7lzxX_QVy1
 oS3ps5_j2rFOd3P0wl1WxZGuWligMbnEf.0Xy4faHgmRr_IgryvoiyhIPFVFfetvdFs2ZsVdCiNI
 ibKSruLchJbtGq0dfmL.IAXkwRk34Ss6cLeqSDk70LuQ3abnwTQWr11VX7FdwkOv7.NdoGgBi0LK
 PDxE6jltdg2zbSroINPRqWaR.sShH6mXUT0fZusRsuCK9AxLB_553ScKHvr2HVzcX_sgEYM__CTr
 cgxF3C1VsRsV__jLXIjXTSOOofez1HFWCxBB7LWCFc5HIj655tnluxccSLwL051yQcWIZXvftlvV
 t00ytFSQY.FPplGaSTMZMyrVfNmRTOA9IZPQKuRS5I1TNhUKNAUXD3DZEPPDbU4vm6Dv6PwTtjmm
 TB9g0t3RI6Ir3jq0qlC1caHdbaUlvDPt4oQzxubk0ZeLSDXgPeezg9RH40JeQ23.i5vqnhew3taN
 .w5v3JbY2Y1nOSzbLe3Iq6J66Gd0_F1FK8ZOByoQXwmj81W1hDZSDXhn66w5D.DOagVPMA9wWBeh
 cVZLJNHdbvdLYifPP1GiQM.KXUWf99joYAcHTDhocrLedIQhs0yIPQ41bXg_t.9tyEM5EjMsl7z2
 b9DB3dhLPq4lmcMffUkkzOEiwZtZP5UVtl2x0v.2oQCPWFmrhjNwOiDcFovP2ylHMSWwIdohM5NH
 jHtTEYTGQ011OfgnKh72kzZCqw8Bnkn8jbt4DlDGeL77UZlWh9FDEObeQIl8OFsh3NTsQsaXix7G
 3Y4qhaP9ix5eneascKkBrq7oXEmd.76RMZT5ZqhJfN7wGO_li3SmIP5LX7Uytr0xuzE9zankrAxV
 YZCZmWRAQiy4WAg.ILssBlha4PXLvtP3W0AiYiNTMxjjN6RKqpmOdMOrXaX0pPvR.Atsf8OA4SWi
 AqTeoclva8aXckk_0ch_R9Pa2aqyVIFkGvYMM_cqLHTNTQbH2WbQ1J5qRivY1umAvuV3jZwuEmoX
 KmIaiFUimwx8XG0pOxQZsHeQVjVw1.qJ.OHTeIeE9zj_io0v3GUcWNmHPJ38wGVRaQdVSPDtE4wr
 WUKnyzjXzxLYHy1jExUL4Y4nbdUHDiS1Ay892ESFaXQehNOvm5l0u0UTQLQTW6jh6K.EkLhRfFMR
 9prWT.ztjjmK9ngkIB_rhtPnaR3UoJ_x.q0xLzodkw81oALhP_R7I_D7GWbD2.4A3T4TXGR_IzpV
 1Mvts29Mh.W_b7iaMUUOCxKs2N_Z174jJrn3ag4UjqBCjmU462opy9rEjqCxIHHkhHxwoCX_fZo.
 OXiyDCt4MBi.ZP2CJbtoZtsQQiRzQwyEti8WWIjk9VjQ0YobJACpaOOU1sdu6gTZ7ePyu0O8kNow
 V3Lig6G8U._dmftudzPyrpzVL_y8m7yutL8_cdGZ8D_zXpzbZm53LwBFm2Aomd5Weymgoa3ZLd3c
 mcUXjn5Cr.8LQrlYyqkfhkUP_6yTXLWADJ0v1NyHrkklSpvZHKGnh.2Ut1PUTccByBaNmxYyH5YM
 4kOBy4dza2rlZJMGs8GosTEX1vJ0jRRzeuWPAamGxU9QMq95CxWYkSS3mGH9C5PrcnuZnNdehQ8S
 BFPEsWs3JdQOjFNANdRoBuLRKu57seuWFpFgzPYC0bq5XjzOLWAqYA4iJsUdckX8kSCzoDZbvGqu
 ir8NIFkDetOHEW02R3WG_1M.nAtJx6JLkfl8E307J0TGQx4H2MpnyBN_3vmmN1qUDw9RgwMKyYzU
 4ZTzTYp7bf3vIC080.NpxW4qR2sPw32pyRhhioBvdGyUneo5n83HgKhGjMw8H6KCQp4GBGyeH6nr
 Bi10_577Jec6L.8tnatSACF_v5Y8y6LmIggkIkKA6OJnmIzH_QTMUDuyzGeT5ZkbZPlmiSMBU7Ot
 xxtwmlQkLmzoheSIfnPlqOFYhAUM-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Tue, 26 Jan 2021 17:01:18 +0000
Received: by smtp418.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 5b003f5feede445ab75d61c891f68aa8;
          Tue, 26 Jan 2021 16:51:12 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v24 09/25] LSM: Use lsmblob in security_ipc_getsecid
Date:   Tue, 26 Jan 2021 08:40:52 -0800
Message-Id: <20210126164108.1958-10-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210126164108.1958-1-casey@schaufler-ca.com>
References: <20210126164108.1958-1-casey@schaufler-ca.com>
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
index f786d8833e7d..20a47bd3930b 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -504,7 +504,7 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 			unsigned long arg4, unsigned long arg5);
 void security_task_to_inode(struct task_struct *p, struct inode *inode);
 int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag);
-void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid);
+void security_ipc_getsecid(struct kern_ipc_perm *ipcp, struct lsmblob *blob);
 int security_msg_msg_alloc(struct msg_msg *msg);
 void security_msg_msg_free(struct msg_msg *msg);
 int security_msg_queue_alloc(struct kern_ipc_perm *msq);
@@ -1233,9 +1233,10 @@ static inline int security_ipc_permission(struct kern_ipc_perm *ipcp,
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
index 220b3a7ed326..b3ad40787740 100644
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
index 271584938404..197f69780783 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1928,10 +1928,16 @@ int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
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
2.25.4

