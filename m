Return-Path: <SRS0=mP8O=3N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA80C35243
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 00:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54F5E2087E
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 00:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="jc0w/mZT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730121AbgAXA07 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 23 Jan 2020 19:26:59 -0500
Received: from sonic304-28.consmr.mail.ne1.yahoo.com ([66.163.191.154]:33523
        "EHLO sonic304-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730124AbgAXA07 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 23 Jan 2020 19:26:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1579825618; bh=+xZS4OpybWN3jlqSAzuQm4ZwAT9KRm/53SJ0M76W1uw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=jc0w/mZTwbvBzCmiPCOrfH/afXSNbPbFOR7MsHlRuaZakHzlarl+0lM5sCpHW07TjA7vW3mMh0f4VoyuhyGPBn1+oNhcEnXQbKTZwjIb13bQqCLy6E/vLQ3/piIvl3cdVeeozrCF7+oyChXfrLNm3RBvzLZ9uF9c7Nuh9Neu7C1in5D6yOr1AClFxwXWWT11Krc+HzusCjr+nRk0Ts/4qTWQ9uQ9o1eMcPsV383Fxany8O6M1K+eBXhpfGJaEXlWRohN1JVmIuVqvzbge2xJRI+mHsjl5wbXPErmfzQ732Snm4LEGgFLGB4YWpNp+04zUjSER5Zus+e+KiuI13HPQg==
X-YMail-OSG: UIG05bIVM1kB7f17kqwsrUSILfXHyC54N4lQdVkk.rfnv12OyGIvZB9kv6v7PpU
 Ww63MODvInTkahVqz6ICmW8foGFA0JWaLqzswdAHLZThvJkEIYAMy2VlOQTWgEHSNW3dq8ROKtsK
 SCvHklQblu5RLPHmAI7ntaWoN5aW92uMhJe9AEl7edE4NelyD29j_nAd4BOK4PEX7iI4f00J.5qA
 RY06AXw98Z.zcGTZPeChPxPI7UWIO8uPJLcaSUgAtwMC7fjkqvMSF8VDcM2B6sUBCKvfSRSZcq5V
 mK02CGLZ6phZKkrbP8z7ceYWZpdeZ96WMfndNNar4IJY_DVHO0BBfXZJDby_R3xrs7A8C7suDLpe
 zbXhdhuunrYWL.rB4Aw9dzRzgPNYfMOb5Z7QeuvAevetRW7Y5VoK7ybbh3ibexukfRLvTkRXyk2A
 jSAp7kDhtY5Cm8eu.JxzttP0v6W_ZAednSjtP0dpBr_oFSmMFHPQ_Omn9F3gBgioQewl_ihvLPYU
 j2w8VRSTyqH_NJCmgm85.3fkuz8EtMG2dkwMWweFAnhte2STQbwu9zbzdTnicbdyQTOhV2eb0gDQ
 rWiLCrlnSNaYPFoyyIVYcywQmzJHQOkGUs.Ip_rEyt2uT5Jq783J766UA7_lW8CJf6zrXIfmWo9h
 G9qfImMuVOW.juAlG.xjy2nBscZBAMAGfNJYhcshWNIZ2MYw.v5DBopfQ54ZpzVx4qz5SM0HamJ_
 fQwlOchxbmf_T7.lrVbHM0cLBN7SJhk6QJPz2rYQ54Dqt8ILSEaTZiMbj1OozUJ.sIT3IBGFEG5k
 h44LGdyNyEHOGg1vaxffze5GTu5IRActYmOhtVpdBv8rVaPhRHQauvjkzYvbMgIm_B8MUFpipksB
 EqIqMyX8I2JmRrSmazjyF9BgVn8dn0HrctxY91baHel3I.nDd4TxXcr7YRRmoIfBy3YhBV8LmkFD
 a.WVDlKH70LvDswyNT9ZmKgklIVyonhmh.bhJkHaClEZPfiRXHvHcmitqeLh2GzRGRP1QGEc_vgz
 ntT9naM4BRgSs16bRshb82EhNrokdPIGGE430M9xPqZYpzvr.V2d0QRPhFvbSDRC8jEadhgorRMV
 jTAM0cJ9VcYq_oQQcfbd.Dhe3GpiI3fWc0_bKBPPAl_C8FA3_8TNw3riMlGArQGIUaLwiZrjZ4Mf
 URxmzoNECCsqDVRPYHhs5o3hW8CKDJwyg8gL49KfCr6p5oJoavHbv_w5r1BdYb4mY1HU6hGnLR4c
 xQGDQf_CLZk6x_uRIdFQPi.VDNu8ywXh9DxTkbivRJ4oum.SMUjE67wsD8ZMecfUUnbnMV.TTRsp
 Fs2_2DEZEgWyW1DY2d2Wfmnqh4BRsPmpIYoUeUx9a7dWI3I_enTqHjDcVRc3ApKVcB5dXxVnMpvS
 bislvbdNj.r4TzYOQxapURBw620iNVxWyTeIiOWCMgFq9vbJgoPxkXlq108gHEGK2RvWCR6lZ
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Fri, 24 Jan 2020 00:26:58 +0000
Received: by smtp406.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 50be027cdc8c4f0f0d7e06f64510609a;
          Fri, 24 Jan 2020 00:26:53 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v14 23/23] AppArmor: Remove the exclusive flag
Date:   Thu, 23 Jan 2020 16:23:06 -0800
Message-Id: <20200124002306.3552-24-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200124002306.3552-1-casey@schaufler-ca.com>
References: <20200124002306.3552-1-casey@schaufler-ca.com>
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
index 16b992235c11..37d003568e82 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1120,22 +1120,6 @@ static int apparmor_socket_getpeersec_stream(struct socket *sock,
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
@@ -1239,8 +1223,6 @@ static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
 #endif
 	LSM_HOOK_INIT(socket_getpeersec_stream,
 		      apparmor_socket_getpeersec_stream),
-	LSM_HOOK_INIT(socket_getpeersec_dgram,
-		      apparmor_socket_getpeersec_dgram),
 	LSM_HOOK_INIT(sock_graft, apparmor_sock_graft),
 #ifdef CONFIG_NETWORK_SECMARK
 	LSM_HOOK_INIT(inet_conn_request, apparmor_inet_conn_request),
@@ -1909,7 +1891,7 @@ static int __init apparmor_init(void)
 
 DEFINE_LSM(apparmor) = {
 	.name = "apparmor",
-	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
+	.flags = LSM_FLAG_LEGACY_MAJOR,
 	.enabled = &apparmor_enabled,
 	.blobs = &apparmor_blob_sizes,
 	.init = apparmor_init,
-- 
2.24.1

