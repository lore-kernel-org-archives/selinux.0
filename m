Return-Path: <SRS0=qygk=4C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53077C35242
	for <selinux@archiver.kernel.org>; Fri, 14 Feb 2020 23:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25837222C4
	for <selinux@archiver.kernel.org>; Fri, 14 Feb 2020 23:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Rkq9dkQa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbgBNXp4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 14 Feb 2020 18:45:56 -0500
Received: from sonic308-16.consmr.mail.ne1.yahoo.com ([66.163.187.39]:36348
        "EHLO sonic308-16.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728316AbgBNXp4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 14 Feb 2020 18:45:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1581723955; bh=Q8pZI23fVgfFGKWrmlgNPluY61x22Nwjp2FtFTY2yZQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=Rkq9dkQaNoxE1Xw+Z3Nv+O6P4ZNS5pExvgY9nkypzVP0WZ3qMHqPRGkvTUQ3wpkjj9Tn4pzGebPWwGbV82Kqxscsh0fxtrptKJA4f0m4A0fXDq6WANNsQOJa+EMkyIkVMtY0qT6puhVRWTcLpmRMaP7Ww+ggALgbFovlAPzCtXcwdT1a56ATtm5KHIjdDSfPtQfEfduvsThnu1AQUlHYMSnbaKG10F21BozTCPPCB7tVlxqxgRuVUccTQaWZaM0rntPtAj1Rt9acUPTLDJRmfFyvg2hbWYnZ1LxO4sKc34Pu766ivvnFYBJyBj+BsLx2VPMHgf4oAI1dD4FpmsrDwA==
X-YMail-OSG: kyx.NW4VM1lwDs8qckf6WaVXgAaTqSHAPI1R4rhDABpo2Bu71vub5MotftI6OX.
 xkh33swdObjzKRY9Ud7KC9aoheK51GgxamrU631YG5TXJnP3_FAGESdn1i3uJMjDBw.uGMHya0iG
 1duZAxyKFNWNVcmxZjYkNG7rzTWWjNPiR7TgYFgv4W9WdrV2scNWMXQIXLxdqOEfcmgs2aOiWkb2
 SOe599bqhvPPGcuK0mneK2ofc7fpiKNzvo.kl.yGb37a383gcTPjWAmNV7uThc7USMWGOdDs3pC.
 MoFZwVInj33ufG2HDciIsc4YtbuziDAGEGwkVc6BkyQialaAHWyCXu1C6vN6y_ff2a64U3KCxEkw
 DStFSHE3PntAb0vhcSP0xThcLJ82iQMolNZnsTCOTPFdaEn8w_Exlr4Yyda0rdyjwtADXnOv35EJ
 2JeWpSAUDqLNuaGFbZtUtEVZzme1dnh11sSAaDhUZk_8QbtwoCFSEQloozxidAkcWIWUG27mHC7N
 dmV7QNp9gzwArzLxbmugQayJbjIFSSGPivvEhrl6h6N_h35thNFv3oRCrsaUOhh1s2HrK4BdeJs7
 B82NSOGq7uTk.IXfDgUQcpmcLbGxC3rvIQ_hGpSWvNqACPBCziSkvkWqMM3D5rGTTX2xe.F7F2Jl
 .Qg1tabXf8q56WDzq769KCEFq78PKT116dyB3lEDmQLUvAAqayZWs60I_Ba9oCKUvFPEoHKvhqBM
 Y3Zh2whYADDvUiBCvwVzIpxTBcCVVIGVLDQLaxHJwW4mKFjmqLQ2pauBlyrE6oNdhGUeYRJxJBLK
 wUBgZu9Izc1Ik.L4n8sLNPIx.kuGcP3sGouWDZ3sgomAxEb0_naqmFhLtmW1A37TYuWTLfg2FbXI
 CXSS7M.fSmquqNhdHqxcNE6PS_VKQegKf_JBcuUxsR1gns.pB9.Meu1IxkWNQUM98Ugn3Vxh7T85
 _X0uWixBD2ahKuNXoytgtzlq9nlqeFk5D7IBG34wtapfFmcnDemsdO3Hy5J4wO21HLWmvQwHJXl5
 QKWLSn21CkGYu2f46RkFLM5SkCMZV1UQEJ9Ld1hUdk2yIHiI6ztAOyLOIzk8gdZ7zNoAu5Vbe.DC
 cN2fUZVatB_v4yL_IBsJ8AmJbnSWJ3AJitxQI2ujmsbwXMXfmZzMmyvUXEZh4b8S6MA6feX4tcTU
 I6kdWAlnp7cGRkmAZevQVks4DZBBNH1fGjR9x7G_B7bjxduGiuPURDx.UarJF8.PWDxcp9Mkio0M
 _iA1JmQsVZRYmU9qSXftiveY0ldl48bHBuI4C5mdcQrCBttFF25b3.ofRkH.YrOGb0O_xtZ_rcUn
 edXLlKo4XXZ1_7kHwAXHVPr.MPRBDfZWBvCFJ2XEcIr.BJYl.xlwDGd_K0hktBn0CXyaADc5zfaP
 Y9RiNXuH7Cr9Puw.bRHOVisnYxKvMpx.Y4rWV1d7y5Hm9kg1oucyl.NZIjbjwC0dfPVKoLwky
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Fri, 14 Feb 2020 23:45:55 +0000
Received: by smtp419.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID d59e699c21931303bcffa3291bec6e27;
          Fri, 14 Feb 2020 23:45:52 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v15 23/23] AppArmor: Remove the exclusive flag
Date:   Fri, 14 Feb 2020 15:42:03 -0800
Message-Id: <20200214234203.7086-24-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200214234203.7086-1-casey@schaufler-ca.com>
References: <20200214234203.7086-1-casey@schaufler-ca.com>
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

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/apparmor/lsm.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 02f305ab2c69..07729c28275e 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1124,22 +1124,6 @@ static int apparmor_socket_getpeersec_stream(struct socket *sock,
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
@@ -1243,8 +1227,6 @@ static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
 #endif
 	LSM_HOOK_INIT(socket_getpeersec_stream,
 		      apparmor_socket_getpeersec_stream),
-	LSM_HOOK_INIT(socket_getpeersec_dgram,
-		      apparmor_socket_getpeersec_dgram),
 	LSM_HOOK_INIT(sock_graft, apparmor_sock_graft),
 #ifdef CONFIG_NETWORK_SECMARK
 	LSM_HOOK_INIT(inet_conn_request, apparmor_inet_conn_request),
@@ -1913,7 +1895,7 @@ static int __init apparmor_init(void)
 
 DEFINE_LSM(apparmor) = {
 	.name = "apparmor",
-	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
+	.flags = LSM_FLAG_LEGACY_MAJOR,
 	.enabled = &apparmor_enabled,
 	.blobs = &apparmor_blob_sizes,
 	.init = apparmor_init,
-- 
2.24.1

