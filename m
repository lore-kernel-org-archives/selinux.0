Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D2DC6377A
	for <selinux@archiver.kernel.org>; Thu, 22 Jul 2021 01:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0892B6124C
	for <selinux@archiver.kernel.org>; Thu, 22 Jul 2021 01:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhGVAfU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 21 Jul 2021 20:35:20 -0400
Received: from sonic313-16.consmr.mail.ne1.yahoo.com ([66.163.185.39]:45599
        "EHLO sonic313-16.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230196AbhGVAfT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 21 Jul 2021 20:35:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1626916555; bh=Zs5PRqDTSPyCtuu45vKKUeviuxf3LXsqVRryLcTyfl8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=giV6uSo6WfE0jmbFslrFW62d12g7SE628RTwbbeGI4Vv2s5knDgqIXHwqJkj3kTMb7GqrywtjTqSv5e6cyEPX1h69hk+CS7ctq79SAj8LxUv+n3MGcfX/RBzUgqAIvwSssCBsSE/cp+E1pPpE3SwZaaViEyTxs7ORApGgxwDRBUOj8oiO1tRh5v0eyTfmKn4xpLgTmKO6H6G+MPcMNs37s0FqTMUuUMWad4u1LEUKlWkQMRCFJTwJQOfcpB+/2EMR4WhLpsB7gOsf8bX3krRfY0KqIWHyD1yiGlkdg5WMswfVWfnTxNrIYTC5qQ/JhxMR6gfxvPa+8v3tsbJDDhYeQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1626916555; bh=ttIWdwOGKPZTjAFdOZNqpK+qJGCIjHJ66fNA+Eu1OEN=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=WhxQ4g/e/qeGWuNCTQDyGutS2Um+Ktn77r/xj4K/kQVFbGT4sXyPnggwFvTcFshMpe3faAfkYdWVqTXdc4Tb9SYqNJhRXAW/xW1P2R/vG2xFXMjCn4de3Y3SiCeCzHsGohzIQe0tFHy3f/4gN7whT7gIvDqc8qPSeGtpdJRfq6JWRPEMRqhgfMC+ywU+uNOQAQDAPBOLr1CzIFCfVW8zg/pQSgcU7pPxtWqV1N+iHNqmXnNw7j2Y8jmXHwGUZo6F6Cqy2xwoq4PsQkkrU2OP54RSqvOjlkP9IefMXiBiSU3WNW8SIqlTDy+Axp4gRtOizDrlyUvyQZ0BgpEbi/2Q/A==
X-YMail-OSG: 9cLK3XIVM1kxiXENb0EpKJqoOSOg4kk_fObNRp2valBWOODGNZLSYEhN8wSoSza
 tPJdDc7CTQ6ujUplYnwvEXxYhD2v5G.BbZEYD0n7qCTztmjtx93JEaEsediQvgcIU7J8Rrjsce2n
 VTSZIcILrS7bBWTywTxPvnOGi_sn1PRI.8f1O4xlwxQxD_YN7SUHmChXqfTU6xHHoB8Fy28E6Cgk
 kr_sRrBY0A4N_sSTopNsgtsHj0kt_AGBRhmhp.xDJHhjNjA7Gyw5Nf1dPZoBrbEUhioZVP68_7mD
 cTKYm5tXmm7n6s7TWuSIUyF_TnxUhafJgi88NJjLKIOD3pc5W_QiJKK067bt6yBN0YvVxnqXw9tO
 8Jl6gzVrTp7j42Yafhw2BW1tQWrJcrt3Jyye3M73FMTZnY1Cfuq1IwS82Wv3M7gnnuG47n.iIRA8
 RdyWBiAnuz5ZZRwLXz4yNPHhyWinUY8TsfFL96icaFcXTmTNELJe1X..6ZES2WzVQwbYBiDXgmkf
 RcjwgLFl8GEhnFJtk4_A49glsTi6Ip3a3GbYUdNBpCGyfIU.aOiWXEo7qm3y.XBP63_DjYMVjfPg
 1Vpgaw_Diwee15hbcq7.ioIygVrE6Uoj3xOUtFCDww5pPg_rTxx.EYdYZRo7eEieDuQb5ypA4Cma
 uju2MuGLpojfCT3gXCXCynqdcFWfQD_VjhgHsUxNVYWb7lx5VHcmflkzkFhY7j7LNbxj0IVyFHD9
 kYScvf61oXz0AaoxHnpcYnPnkWjuFmSwN9ew4imSxkSnlzpyVDJr8I8xR_WbymJcTSRwfyMe5p7S
 8ML4iyg7p.d4rHZQhaPxbva8rLxytyK3hWBukeC6fK96adM4qzy8O92xNO_ZQNeVyXtOGWd7mFLx
 qgPPHeyxYvrDJ.gFIDitp4q2GYri3aPw6zkEXx.4U6Cfx7o61epfTSlpxvz3TT8Kij5RICBJknOk
 tpyKF8hYmsoZUlFeRIrjDN_nEu8xSozz3Gg4BBJxfNyMTUv__msNYPVRkZtgIYMWEIT5CjXKqzSY
 68NUfoDXMQnHGjU2_FpJM9g61rsxQXLh0PYs_aqdMbPJ4gOeBsY6QLfuQ2UC8Kmm0Tjn1_acLlNC
 nMCySo4ncmqA_M3Mg1uixGPIRH8QK2URmxtVOSlNrb73nitHpMRxCBYhmXbkTmFPmYxi6xgQ.76p
 1E_JMeIVVkP2nMeIvZsoMbrUkDtD_D.cN8zjkgF_.qcas4k461BMQE2fi7A6_wFIMiVdmr9MB51H
 SDNkCwwn7TrbjYfnv86XZxoudSAVuT3NiFCi_REQTkpYYmrpo3D4ywNcQEN.o80JWYtJZqPPuDHp
 2jFMsiJxEJf_5u2a5vLgC73.Qlht6KfQvk6PdiJHDAX0KoShmruSNvPx0t1scA8l.L0iK55yY7w9
 .TQkv5r3XkmQUZYmhY9lZACXto7Chic0jy_8For2tOumuJCGDy_x12f2kNdJZdXpqtbHhiHvGp.8
 e5BXZj6yoWjEY.tTJN3MmF1Wi9v6Tac58bnQj5TQcAAhdVA3XjoBE79nDbPgb3WhtgJMxnryIs1e
 eNv.kIYe7Nv2S.r6KYGjaxb2CaF6itUl55bYLU0CRyxVlCGr4rCwz1R8GWKJNRtVupq08Z_mIdEC
 VkybApwrBA4fSSMXsdQgeIhCFhi4hYQHvCOolpRE1f7Ojqbi.YXCbM0AwGEl4T4Kq1CXUY8sJ7F6
 m14YPFE_30CstR9KlMFHZ1Hq5TAYVrZ9KEzUW7ijlSSuotje.x3Aa.fOhimQ.zPpDPwyCH_8b6y6
 0yO.AjmjmHOfaPpCh_Q1M2eDwMEhdYYIa1KZs_fX._ins_NVXxODykXS9m1kjsOACOq0.Ga9rb4A
 CC.ys46bf.txf45JiHnGQqX8xDZFPLYBNIozppDUKxwsVunnf3PWCadzvsgbQInRi8kBvqF3D1Hi
 WE8I4sALqJ.0pyNimuhWOZRgECZeGYy.Jl.wEGerqxWmaXbWklsn4bA.ThNYv4wlaOH7VRYPQ.10
 jeb4wm.hYqJw7Bit2pYVck75dG.eCV5cPgscVW2h51GLrgnNjbHq6BGD4lZxIOkkaOF35IGJPGWc
 LcoN.OqxKBUHXkL4va9.dOuRFpYawKpxCkxZk0NcU8tl7Uln8XoLpXuQ5rwsTot4KoUWlsT_B0TZ
 NK4dHoY_VtwRQ3j2gCKd4aXpiNV16d98YXUGTdLqLcsQHhA9YfetPWaViZ5V7Z42z8fQmmzWCeP1
 kKjhwNvLDPr4a_vBt4lxvBD59g_d86D7xqE5MdDYtvm_RlxsLice0gAuiMcMRdVBGix8e_2vUQgE
 zB7gunZdoRzwQxDPlwqVGXGAj8HfxOozvq..DQFSufaqxPWTR9D1Barl_9OwxlHo2QP0Dnsh_a8m
 gdDxdNvYro3_N4V8npciyiyue2drHxbOTIdA4PAkohTLyXiD9Q0tGG09wbc1kNk27eTkTnM1neFb
 X9F063Jc3vyyfNpkE8HCEC0Fbcatf9eOTadw9dUYyRG46X_0.e7bJY325fAW7ClQsZRE6ivj3tSm
 VN8AUvkC5uJx3HKmtHE8XxWIA1_d6m0tJOIIgdmsWTf.OIXL9J3CdVAYEbbrWzz1UKpDONHLwVKL
 Xpr5q8_U6wzv2FcxBAdN5kxFS2rLkY7._n.gNJLA4d87NnXN7w8VE1Es6hwpWeweWrHUXz_ArHk5
 bg925HUY1Mv9z6aRCS1JwSZ58X0lTVVrTwF_jSXQ4rE1kEPFeQqqJ2rixTLMXD2UFfS4Ds7J.Tql
 DIagdfT66f1MgJlLOpzMN18J4NKUPwJT4vb6f3lalJExxRF3kP88cf8V79FK_Txvqf3HIRhha.dt
 ox45L_MocPZHXBidzqdw3GmIYymfO7nExp5joLll9wob4JTcDddS8H1rnMaWOXoIMEACVEGphxqc
 cYztrHjbwULRbpGUTUOFmqpZUbuPj7wIoIrQlsod13xLR8o7q21H8XXukYx2j8Ty0Xk21dvK2Ab5
 sVB.dk5V6YZ06o3aYTed4P06Txu47lOWREJfVEkcVC0857dtkyLcgT.VkaF4d7CbV33_DtpK6.Xc
 DpWpCYYcQi.v1Tw.s930TVMM95h1dWrN65NQoqU9aDYmd6jI7.lvT6C7PFbm2BEdlI5iTwqJKetn
 FzQw4vkmD318golBH0wcghmmxI6I-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Thu, 22 Jul 2021 01:15:55 +0000
Received: by kubenode520.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 2f3755ccd4bf344096bd339e2fe7a05a;
          Thu, 22 Jul 2021 01:15:49 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v28 25/25] AppArmor: Remove the exclusive flag
Date:   Wed, 21 Jul 2021 17:47:58 -0700
Message-Id: <20210722004758.12371-26-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210722004758.12371-1-casey@schaufler-ca.com>
References: <20210722004758.12371-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

With the inclusion of the interface LSM process attribute
mechanism AppArmor no longer needs to be treated as an
"exclusive" security module. Remove the flag that indicates
it is exclusive. Remove the stub getpeersec_dgram AppArmor
hook as it has no effect in the single LSM case and
interferes in the multiple LSM case.

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
Acked-by: John Johansen <john.johansen@canonical.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/apparmor/lsm.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 65a004597e53..15af5a5cb0c0 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1138,22 +1138,6 @@ static int apparmor_socket_getpeersec_stream(struct socket *sock,
 	return error;
 }
 
-/**
- * apparmor_socket_getpeersec_dgram - get security label of packet
- * @sock: the peer socket
- * @skb: packet data
- * @secid: pointer to where to put the secid of the packet
- *
- * Sets the netlabel socket state on sk from parent
- */
-static int apparmor_socket_getpeersec_dgram(struct socket *sock,
-					    struct sk_buff *skb, u32 *secid)
-
-{
-	/* TODO: requires secid support */
-	return -ENOPROTOOPT;
-}
-
 /**
  * apparmor_sock_graft - Initialize newly created socket
  * @sk: child sock
@@ -1257,8 +1241,6 @@ static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
 #endif
 	LSM_HOOK_INIT(socket_getpeersec_stream,
 		      apparmor_socket_getpeersec_stream),
-	LSM_HOOK_INIT(socket_getpeersec_dgram,
-		      apparmor_socket_getpeersec_dgram),
 	LSM_HOOK_INIT(sock_graft, apparmor_sock_graft),
 #ifdef CONFIG_NETWORK_SECMARK
 	LSM_HOOK_INIT(inet_conn_request, apparmor_inet_conn_request),
@@ -1928,7 +1910,7 @@ static int __init apparmor_init(void)
 
 DEFINE_LSM(apparmor) = {
 	.name = "apparmor",
-	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
+	.flags = LSM_FLAG_LEGACY_MAJOR,
 	.enabled = &apparmor_enabled,
 	.blobs = &apparmor_blob_sizes,
 	.init = apparmor_init,
-- 
2.31.1

