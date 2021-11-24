Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 023C1C433EF
	for <selinux@archiver.kernel.org>; Wed, 24 Nov 2021 02:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240684AbhKXCRn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Nov 2021 21:17:43 -0500
Received: from sonic302-26.consmr.mail.ne1.yahoo.com ([66.163.186.152]:37722
        "EHLO sonic302-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240680AbhKXCRl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Nov 2021 21:17:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1637720072; bh=ILfwu5YCWq+aaMpJ0ICX0L0I4dees4dHGOc836rinKI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=FcehUgNGgdaZ8bYJYqJ0gwcR47myELZIen+NDS7OmuXxWqIg2jWNfAavpZfSKguRKlD62Isp9u6mOPp9ImmbXmwO8BQgU11J4HE6UohAbTO7+VIbMywoM0pyrCno8Km4MgattrwnP82UVKiICiQ0a6dpbcDO1yZXs0azw1ZYLk3cPpEjccKnROMWv98gh08NejCpt76/XiR7kOn9fuaREOsnvkD+UrEjniFyDhFbRFymf4LfpCoUMLjYlZ0nzzvwXI4dxwIsDmFjPSkujYkYzMCjmhKXHugcGUiv/tv2ckbMPXbYyWj+hi5/Hvc+vDD3Q3o23CS2RuC5nQIyMeF9zw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1637720072; bh=xBiLKlq3uTDxd4bd6pUOra3LliEZJKEkhJA2olglmkN=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=fITZ4yZFwbiv7TJaf3royrkUmIIQRr+uyJ2ZxHT8ewbli+jK0xWAKFdemNbbiWUnjKt/6GWCvIQ4zd1EqxrzhwKltjYp8auekXHGA3rf6u0IAI1yHuBCoX6eUXul6QV/dDDcCKYn1bswwkMC86CnMPSxSfoLz0z5trwXbEFgXDaQz5cI+LxneMa55GBofjCHWjXLeLuct830HR8N9IGXng2CI+q3u26L/s1Yg+Hex3GzjIAP9+A/X6rvStAeKsIhyniCYdCVRdoihY7ZfzgL94GfatiulKWwyR5ISCfJgc3YXUJh76bgg2e9s4+j4/UcTzQkZTewhpIdnSZviB6Vuw==
X-YMail-OSG: 45jzrVAVM1lZbcepjp.ENRkly5I2ZMoM9pmMkK4kFE_dqLdnuEr4TSLhpjaw0kr
 A71NSpJ_BSl5RakQVM.jHAf2B9zGBGDPDZQTY2J797OAqscJ6VGuRDwRDZnqszIZqyGeWoBJ9s3F
 vgMNn3FyUAoMO4idCsaGNm_nfwkVpF8FArwzYEQQDeRqhk6Y7bTLJzCyq.PNgT8iDwPWeJdYCqzz
 4Xt5Q1TY9XOq6XAzCqruRU75p0leUS4Fvsfhiv3OX9NAWrfhEjNT8N9tFYwdtlo8hSbtvw1OpGcc
 rgrsdeN5f8_hbaPoGMmIvrxeWHjjx5W60_7WbGBAyqZFex0crZJt9SLt5oteud3LIHT6v2WinzjP
 KmDCZdfYZwMOT1LnK8jUWChYEFkj.G15xhHwO_81hKFSOvF0odnurJiCQQms3SKrcGIXDsg_rqRO
 PQyASJTgxacvhXCbxjPSARxXcDFYkXEhc9tn2m5AwnBQ.fgC2z9tXKXSi1A9SqZDYy_a6oy8H0yb
 B_V2Ivc8HrW3ZFyqaRfqX5vlJWfKkgBrd0t7zNYLoVuYa7p0Noot7ph.061oF4TuM6iS62Kyt_Q0
 .Bq0Sdss_QvhT6uL.ifTg2wKex.SxrCQHFyq.BoTIOMBQFQDB66c.x8FomJDCC2s4yoaKb.OFE3R
 tWivyRN7.7EejIC.yvoWT6mP075y8TQJe_JbwtyI3tHeecfjt5valdk0G9GwMrOmBeXviC9s7DI_
 wZ6w6xTgoDtpoyi6PcVXam7z1ecqs7ofwD0OacRwTWd9xmejveDu2fD.ZM7imEezJQk7Qf7jJkrL
 2g_MNHya6LwRyQaUPtvF.Knj.tYMper.3gsIeI82LRrWSFqdIXl54lMJM1J6OO4iLiAAILl_wKbn
 d4OxCW2ZJu.JUKvm4XdxChD6T5csU9Cxr6yjYIlpLSKCpqKk0QS0DBhEEwmTg4zGFu36CPJ73jqZ
 .TlNeS7rjNhnw1.s1xpUKmGKbv_44PwB6d.XofrgHVts.GolL3OG.PUkPDkYc.YA40zBvpMTi2CB
 sARxaOyHByD2PQTihrmViCFEVDqtAWpsemvqqWuOMrgyegYsFRFdy91Rpr4pl1mM4tSEF4qy.8Hg
 dJ9UmohNcN_EcDHjA5mmib5.LCbuhisqBQ.nMvXZVlFFPdJC8MFR3l4zjUkHqUXJOEqLWaJcvqCn
 hr4Zu_oD2uSikzW5c0B2fp5bX5_CFWYGgGp07f6Dbyd6KiNjyWljtS34jIR17khaQ5P94IFieqEC
 bZiVh9p6Sy9TiQOPjJXlI3zh5KkWFkLzDCImmFwqngjHb.a3jDmuKgTM6WPxrB3_.6zZGlP364xW
 pvFZ7YdoDa5HBpE3.NzusRay.wGiMKRb1KBaamZx7BX__fvbXUsAdUoifcIpurb7vC51XOxPplCP
 QwTYtYPZSiMsUSCMPVCdJeh9ho5PMGPopg72SG.I0dZW94BLZwepyVT9tv5ioBoPFeCZZ.fU1Wrv
 8myxQCtWbJRihvSQ8vZtNkQCdLG2YgvWBAwggK9K5ZL7srw2jUJN76zhcnrtubqqNAdbuViyGlki
 PFMs2Bz5FetWjhHijaAVUE5CTrrBxFGPpZhjwqLpTrsL4j01JTXDQaznSJXnrvcYKU0tIRGLBdh0
 DzkJaCOqASUo011EZLueIESFxC3cwtaFILdxYNHTGx4MnYaDAiUwFRZeXGquCSCcAsuVt9NR8eqX
 InDH06Qa_YCGNkwirp6GXYqM7aNxyvt4xdiNdxXa.7lr1iVr7k7PT6kuTk9rM4nD9erBHxqiD6lj
 s70lZMsO.RtV98W.Actt45ZR1p2mNLhblbizXOAmsuqrtCK5tBwEFA9kmqENoXicr5Ncl57nSbzV
 E838HtAzHdOKGepegGzVjIMlI6Xc3k8Js9qWRVSBu53vGIrWDZVv6yXVow4yUGaACoz2484ZbiGq
 tHZE3DS_dWiMmHk65CemhrNPbkgnJs8M6cTxB69H660LUUtwpulvFY0mMPC4Zch6u2fg0JoLrpez
 leX7TCD1KUEdgsOiYiPAci6h5pbelnwllAwpeyzmjFETZW44UJVSE5uYWpPJg08Irq9ipsAym_Ao
 1R4mWpHKki7vDaodadkdqAZUGPO6Uw5AoJGPcp45gh0qFxCr.14fTsWZRS.ok.2sGHdD_WxB8CE3
 ENkLEd5fikesB4bIWF_qXMVkhNAK563hyw1OibzBBADLDbsDilVqpb00hAFhSaRNKTLvBGqFNCS8
 ltx.mQJRZ7PbeSjX3biy4LUfHl.6Db3RFLOBdM9DQZrwzhcEyPn1dJneeZFqOMHqMikfACvlJ3ee
 2mue7aQAEbK6STs9T
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Wed, 24 Nov 2021 02:14:32 +0000
Received: by kubenode545.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID d31ad0ab77aa94fadbac5ad1dbcc6cd1;
          Wed, 24 Nov 2021 02:14:30 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v30 28/28] AppArmor: Remove the exclusive flag
Date:   Tue, 23 Nov 2021 17:43:32 -0800
Message-Id: <20211124014332.36128-29-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211124014332.36128-1-casey@schaufler-ca.com>
References: <20211124014332.36128-1-casey@schaufler-ca.com>
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

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Acked-by: John Johansen <john.johansen@canonical.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/apparmor/lsm.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 28ed41a3ffcf..816145276c74 100644
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
@@ -1912,7 +1894,7 @@ static int __init apparmor_init(void)
 
 DEFINE_LSM(apparmor) = {
 	.name = "apparmor",
-	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
+	.flags = LSM_FLAG_LEGACY_MAJOR,
 	.enabled = &apparmor_enabled,
 	.blobs = &apparmor_blob_sizes,
 	.init = apparmor_init,
-- 
2.31.1

