Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13DBC10F06
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E6932184A
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="LXxrxrYP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730046AbfB1WUZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:20:25 -0500
Received: from sonic302-28.consmr.mail.gq1.yahoo.com ([98.137.68.154]:42593
        "EHLO sonic302-28.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730134AbfB1WUM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:20:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551392411; bh=Jp6S20INV/cmAGY4JKdDGeb42w/4k/VHg81J41LNPYw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=LXxrxrYPKGmqqZK9iC3o0gumnvZFhZKvW6CeepeGEqgpUsIpvfhFO3phofWX3C6WCBK9S8970hDszZKhKyaRoJdPE2s2p3z+GwYTUQ59oW8QfpCP/aLpCCbnZNv84ni+GyZJHCmnrdlmzmulRDcAKfZWzaNWLZqhbJIKDiAKJ01nDeW2abKg4uzJJXap7fvS3+MmyGtfpG4AQP8UdfBulXCRnjAkCVey9Po2R4FWFUrLKCbvKzVUmYzP+Lhu0q5UL7ny0pgD2hZ6D13Vbzk06PX3nLVMKPKRqiqVyD8ZrnpPV1X/AKfF855zbLejZi9g7Z3Lcf7lKnavOBtg02pgrg==
X-YMail-OSG: rXd8kR0VM1nD3.EZWopDqJS3LG7xgg5OingQRzb5H4V6mb6MqfFrxgVw5vKJlNb
 cYmbFtrlESToxCRgogXiitMtHeshnG7KUA6FJIDDjzKaccrqxUhiwuJQG3LAecgu3qcdpCrCaZoN
 GQ52CfG4PdISl4WL2ChHv_ihpVljSW1oH_Sdp70Ecw9gGqvh4J2bdX2OiWOSnjMLXSkCME8xf3oJ
 0dYY7jRoVgeo6rBMFTkSw9g0a8f2ArtUiGYooZLD7SzUWH0Mhrg_TK0yHnO64zhs.Xx__k4IEuwM
 T.zuZturp6zYD813DfC9eS3xrjMTWAJt2UG62GU5VIY2HjurYRlVhRTJ2cTnJul1xqQwqozx3syO
 H.XUDb2ZIzg0IJOoNO87a2bjcPpcbT_MijJPy47VCSK4txivYciygnpgq5yJoZs6JbHZOqiULT_c
 K0tFkx24SMa7lZgqbnnBYdAyEr2qZYB4G8dd7GMRZXadUtHHkYQXybqV4y0gkOILGa06GL5WYewt
 hF7NDAuidJU5uCxz5badyMsGAvknM3IfUpSiPc3qQGFrMPhGIcEZ.JlF74f3nfGjEsSkFifs2TDK
 fHbywTV5GRcSu8DrLH3aup0L7QgAT_q7_paN3tftXZXsL5jT3rGJ08naiEJZzH69TZuZlimMebho
 IuLv_zti5zHtgAxna1l3xAlD3lA_yHZZoOVcZ.caVy.spb5aCWpRRSGx0Xr35px_QFsYRriJCEPc
 vzWurFtdvjt2coDS9DEfd.ywhObg6c7T5mmRSatWAmTIRGcWedc8Qb97cewt5L91j8__rqz66DqG
 tDmFoUrKtQSu8utRtP9jgPZAs6wpEMaycRdRxNtK0SipC4x._mXzYwaoP.KKZdyplccOSKFk6hKI
 juzcdIkEdEzvlJsvNTnpXGC3i.7t3bMMM2oaJRUzfL.BYqpMIul7Ha_OFPpyu3h28n7HSFR7hAxW
 wsPaqAqMljSO6CnlyqsQ5D_bietD0a6_af_eaO8FC2zxBCRlYLxYaXD.JSnVUSCJQ39s07OIcWgH
 UKdeaFibZG1Bb7cyBua2ed54QqVg.hF0x8pKGmVvgjKnhZI8a0guaSebNj0deQlJVIiBV.vk.6yP
 1HdU0k7D6i7ZYBew9uSHDlfZFZKR0HI_mC0y8yaZvBKYmCk4-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Feb 2019 22:20:11 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp430.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID e588ca5e0935b1286f019b02cb065c6f;
          Thu, 28 Feb 2019 22:20:08 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 41/97] AppArmor: Remove unnecessary hook stub
Date:   Thu, 28 Feb 2019 14:18:37 -0800
Message-Id: <20190228221933.2551-42-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228221933.2551-1-casey@schaufler-ca.com>
References: <20190228221933.2551-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Remove the getpeersec_dgram hook stub. It's unnecessary
and disrupts stacking.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/apparmor/lsm.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 0f8e671df5fe..8c854f95d814 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1094,15 +1094,9 @@ static int apparmor_socket_getpeersec_stream(struct socket *sock,
  * @secid: pointer to where to put the secid of the packet
  *
  * Sets the netlabel socket state on sk from parent
+ *
+ * The TODO stub interfered with stacking and was removed - Casey
  */
-static int apparmor_socket_getpeersec_dgram(struct socket *sock,
-					    struct sk_buff *skb,
-					    struct lsm_export *l)
-
-{
-	/* TODO: requires secid support */
-	return -ENOPROTOOPT;
-}
 
 /**
  * apparmor_sock_graft - Initialize newly created socket
@@ -1202,8 +1196,6 @@ static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
 #endif
 	LSM_HOOK_INIT(socket_getpeersec_stream,
 		      apparmor_socket_getpeersec_stream),
-	LSM_HOOK_INIT(socket_getpeersec_dgram,
-		      apparmor_socket_getpeersec_dgram),
 	LSM_HOOK_INIT(sock_graft, apparmor_sock_graft),
 #ifdef CONFIG_NETWORK_SECMARK
 	LSM_HOOK_INIT(inet_conn_request, apparmor_inet_conn_request),
-- 
2.17.0

