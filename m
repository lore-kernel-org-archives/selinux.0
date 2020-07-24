Return-Path: <SRS0=Hma/=BD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62E9C433E1
	for <selinux@archiver.kernel.org>; Fri, 24 Jul 2020 20:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E965206EB
	for <selinux@archiver.kernel.org>; Fri, 24 Jul 2020 20:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="AS1UUu2Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgGXU6K (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Jul 2020 16:58:10 -0400
Received: from sonic317-32.consmr.mail.bf2.yahoo.com ([74.6.129.87]:44459 "EHLO
        sonic317-32.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726411AbgGXU6K (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 Jul 2020 16:58:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1595624288; bh=P0P3phkgM+q4+dCSn6fYmPJId8J/SlEaW2WbbitI8v4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=AS1UUu2YBRuyTUUmg0S9Qpp1i5bTMbCtzsSF3xVsMoSAS1SEmIXOBdhvsWbdP+WbsN3Wi051zmYVHo33yIf8oPvBDz2SSBnZo/51l5X5pcLsn8Zsnvfl6Y0gORfkc43xd+HpKGT8h3/eGVGOEqCIhbBOP9TKrbqH30FeUkS3AKkvIec8m1IVyjV2JFEtRrkhhrAHzGBv/VXi7czR0oR3OgUPt+7bXkiSaM8vTDXbwN7DgqE4DwcWwF4kNAAEcE84AJWKDfsV8omrMvT2L2kGpEectKlijQnyQJSOCHBO/lrUlLArAqcUZTCy750CI21wxzhjrXJJvUpICohuDaALYQ==
X-YMail-OSG: i36vbAgVM1k0e8FkdtI7vJlDGE2OWFzAhXMIIrvdwr2d5WKOazZzCwh.YGlI8dC
 L_AbkISGc144gyCRUW3S4LlXKaY5PnnHtjA1vVxMerOyG50hWbftTmoc3f_pcFFggtRZQan1Ja7N
 8RsEftng5hXRF_doQLGo8JiAtsu.d9owk2aybDj_QhsxWc3.JPcSL26RAdkg8vpGUR9qpPDc2v72
 5LynQQAA_MMLBSujmohvUQ_RNybiBB.uDbeiK0HU4tS7yEtFQOi.0ASPrPVxKH5GjrvCqAlUSK13
 KKZbAWr_jZqqRhSefR9didWOs7Iq39A3c3F1Ssva01egX8myw_RzfmIbLhCHje4n1I03BCy.zmrU
 pg5FdZFdbfgdBhRqR9f.F2x3.XGwb7ubNb52U9.fVnizFgua8IRba3q9x3hbHWM3ZlZ4_Uk8xjW.
 IpYOg03rtUCmW.UH4Vp3znf4qbHXEjAySKz51XSMayWc8A8uqh35t_cWJQSEXhw5Y2iMgkvMV_kw
 4cfKKQU_1wr3xp6Tzsz3UZaUSO0iPBv15c8aHz2UETg64yGb7jq9VNU3NOj_mi.Zvp3y0gSeljy4
 7X8yO2C_mQW_oMC7_3RmkBdZNSmRaCZ0nXJBtoweQoKX.sYKI6KHUpjpDrTlXisb3bnzTV9pweN0
 WFPin2xJ9VMwqjCrEGYtl7DRyEYV8LWs.9JxAYhApsOYeV1I_JYEMcS.toygaJsAmiifF9d02GZA
 T0FZLJvevFOw7pmIxS65LwSYh55dKB25e09yTkWID3O.4VO_MyzUEWhQpWnqaRfoj1teJTtFsHdZ
 j6zxQXmJ2mfxOoi0ZeLaMjJctjZOyIzqrB..JBNmcEvZnAvP669SX0PTp7owAzYKspFZeSvCYVs2
 9sqVBIugaamfJe2RPZoc_XzR70N8rrUgFxAbm0jetOdTJbxeCOwQcdX4nm0YldRaX4cQQcaHbbET
 gNZXjSyoM8ynLpsKXpYQV3KNhRPSe2P8D5VwzwQz6t5H69TincaS6wbRi_csG6I47tjaa2DsjEnW
 UhHCWB2S7yGPHibnOKi5iP4Sq4jg1_An8wsPP9sqdgtlrnStt9s8HyebhmK.nxtYXkZHbSzGwBiD
 wjyYHkq2sk_xVS1LrIsP5XPOBkwea_fotmYQpYkpkPSLJISTPlYQSMyOZtVg8yDiCrr7nex7.sKc
 PT7y4.Rh4C9mjwTb_ueOZKYrxFwRQ1JqTdIO3gXqYwwxR7fOueKODkiw9s1qu.GRRf8ZOUxW3SjR
 PrItOxXi9GPJwDLBBAoadevijbACeUrj6yb4NLZG7Tn1Fz9BjIF2Aik1LyA3t8kqv9uAhJF7U_uY
 w5UnZTtnIreBcJsPZi.I_OqY3C5QKJCNs9PyKBblIXmrRG9fhY2Gd6w4zLnIOYCM0_.r_CswDxNT
 Cx8Hc_J697ay0yD0jsQbIkFocCbKOZBGbww--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.bf2.yahoo.com with HTTP; Fri, 24 Jul 2020 20:58:08 +0000
Received: by smtp414.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 92e26b0705a6d44aa7f9311a94da2678;
          Fri, 24 Jul 2020 20:58:05 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH v19 23/23] AppArmor: Remove the exclusive flag
Date:   Fri, 24 Jul 2020 13:32:26 -0700
Message-Id: <20200724203226.16374-24-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200724203226.16374-1-casey@schaufler-ca.com>
References: <20200724203226.16374-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

With the inclusion of the "display" process attribute
mechanism AppArmor no longer needs to be treated as an
"exclusive" security module. Remove the flag that indicates
it is exclusive. Remove the stub getpeersec_dgram AppArmor
hook as it has no effect in the single LSM case and
interferes in the multiple LSM case.

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/apparmor/lsm.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 7ce570b0f491..4b7cbe9bb1be 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1129,22 +1129,6 @@ static int apparmor_socket_getpeersec_stream(struct socket *sock,
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
@@ -1248,8 +1232,6 @@ static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
 #endif
 	LSM_HOOK_INIT(socket_getpeersec_stream,
 		      apparmor_socket_getpeersec_stream),
-	LSM_HOOK_INIT(socket_getpeersec_dgram,
-		      apparmor_socket_getpeersec_dgram),
 	LSM_HOOK_INIT(sock_graft, apparmor_sock_graft),
 #ifdef CONFIG_NETWORK_SECMARK
 	LSM_HOOK_INIT(inet_conn_request, apparmor_inet_conn_request),
@@ -1918,7 +1900,7 @@ static int __init apparmor_init(void)
 
 DEFINE_LSM(apparmor) = {
 	.name = "apparmor",
-	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
+	.flags = LSM_FLAG_LEGACY_MAJOR,
 	.enabled = &apparmor_enabled,
 	.blobs = &apparmor_blob_sizes,
 	.init = apparmor_init,
-- 
2.24.1

