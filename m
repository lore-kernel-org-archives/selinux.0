Return-Path: <SRS0=dBUy=VA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139C8C5B578
	for <selinux@archiver.kernel.org>; Wed,  3 Jul 2019 21:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E012D21882
	for <selinux@archiver.kernel.org>; Wed,  3 Jul 2019 21:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="YLTY7L4D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbfGCV0j (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 3 Jul 2019 17:26:39 -0400
Received: from sonic310-22.consmr.mail.bf2.yahoo.com ([74.6.135.196]:42025
        "EHLO sonic310-22.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727076AbfGCV0j (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 3 Jul 2019 17:26:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1562189198; bh=ZBCR9N1e0illEtm3FBcHnIiKSpXNoXtCZlu7E+Q1jGg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=YLTY7L4D+6ODEZO04A9tIxvYV1/xZas0h25FS2Ax3ePaRZXT0i0NBt954q0WscYk6TAajNPhb/QRzzo3aQYseTVKmbqa07HgHLmdjs7erOhDriV9wvi4xWkjzZyNa/KvW5lPOodnNRlduRArKh7c2Q+VQEeYZWPKnTI3WCrSzSFOId+kJDjCajn9NS4ZG+uzvIsGJhfR6vqO3059xmzOCkuURhvF+3p/fim7154/kR+zpXGKopuaT1VUe30U5HmFjmAzakmfwGPXgh+pYeFea+ozbdzpfenwmH/+VhAPNO6vuVISMLvczQgG9hidYEs2jzuN1gQWkQ0H5nSuiiKeBA==
X-YMail-OSG: sIjWTaQVM1kduFLzCOHsEPLYkJuCpy.UShLlQBpKCB0McEY_Ke56Oo_n1ENjzbn
 HOfuo0WYc0rvcWb.EfAi1bcERgkOm94un0_.6r4cnHOg_3iwJvXjZImjZNiPkhWRQjhLLccjqaDz
 I9s6adWoEQz.rCKGN4f75.NCI90R8OZN_SuUs0bseNbiuKmN9sxH3Ml.roKEyLEuokdSL6oF2eie
 pqKICdPynroAzYRC5jlCYIE2TGkEhdBQbaiCJpEzBZDmN8C.4NtIUqM6GA7ybysUOR.8JYhoFnas
 zHdJzkbyAuycq2bQE6Zig5j9h7Olz1RAma6PEi.eijjK5PrtI2aEVkddNeHG5lK8gDNUfq9.jp0D
 KDylsjuDw5zF4nVc1QdK7q2R60D.mSWTChKhgGzUbmx06faiemHP2Ko.t1aTDnd.HcBtr8sNLkiV
 LC7_c7zEyw6bJ5..kJ8AOWq.4q_3Vwwr89HY8CiPb2HR9r5K1DlrWajOqQvpCFhbSQ2NDSIxTXWh
 LdGevIxSEfve92RNW5HVPf8fVlzimqBjOeOFjVv5ocrtV0jjhHIV9SNepENd9hfbmLjeB2pfcsyl
 mr5nF4H5qD2NuVneGPZv7BTlNECYESljBX_ltOQj__Xkq.i8cUNgPw6ze3_BWUxyPLajmvyJcmJT
 CrQFcQAjutycxvibGyM3GFik7QWYQKcG8uA_BR.bX6ieMhE0sH_B2VczShjVgMB2sslYW6uEnv5Q
 R2J1E.x9tIIDLsOn.kUWAQW_YmKSC9Hxv8gL2J6frzdAp6DT3CEfcTwAUvbe1IoUlcjpIaG3H2Hv
 jSPQ6RI95Y8iav_IoPwUsKDFIRw_pttZBDi5ObMwNg7xwwahwtYnPWvpt23aWABB1BG8.2XKgedP
 yV_spIWlPGxug.E6ImMR8zH9Fp8fD76vpjlpG7TbCUgRipnU0l7Z0_buAvrfTPOTCf7DN3ayR_Hw
 7e.r4pplS8lFxZppuAIS_h7A1Mu1JsGDkEzeregk4JeIpkuEYv_W29dupOy14iX.zIBhM5yj8IiV
 cU.EJ_DzLl1OabwOiUYiXGO5tUhlCGcB5iVdOht06o7PiaR_V37sSOzH8aKuMWzfOn0eaHMS2_1F
 AvAYegfOk7z3TaeD6s9n3OQP3pMsEzR4_H1Wrv5nKG.tR7fBTMTc4smJf4zaxFwoCUgo2GtF2H9J
 iY85VPW0Z37kV4cwRK0KbtWELBDxa4hk6srIh9m8gyePeRErhVKHMlXdsMfzwE7NlU3xSYAl.Sov
 qG0VFS3Y47n_uzVRH6scYMUu1yiX0d.F87B0DWX3cCLjcSIcfdGuTZg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Wed, 3 Jul 2019 21:26:38 +0000
Received: by smtp421.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID dcee8b60478c08e91221837756b9c2c8;
          Wed, 03 Jul 2019 21:26:33 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v5 22/23] AppArmor: Remove the exclusive flag
Date:   Wed,  3 Jul 2019 14:25:37 -0700
Message-Id: <20190703212538.7383-23-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190703212538.7383-1-casey@schaufler-ca.com>
References: <20190703212538.7383-1-casey@schaufler-ca.com>
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
index ec2e39aa9a84..08d9867123a9 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1079,22 +1079,6 @@ static int apparmor_socket_getpeersec_stream(struct socket *sock,
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
@@ -1198,8 +1182,6 @@ static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
 #endif
 	LSM_HOOK_INIT(socket_getpeersec_stream,
 		      apparmor_socket_getpeersec_stream),
-	LSM_HOOK_INIT(socket_getpeersec_dgram,
-		      apparmor_socket_getpeersec_dgram),
 	LSM_HOOK_INIT(sock_graft, apparmor_sock_graft),
 #ifdef CONFIG_NETWORK_SECMARK
 	LSM_HOOK_INIT(inet_conn_request, apparmor_inet_conn_request),
@@ -1710,7 +1692,7 @@ static int __init apparmor_init(void)
 
 DEFINE_LSM(apparmor) = {
 	.name = "apparmor",
-	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
+	.flags = LSM_FLAG_LEGACY_MAJOR,
 	.enabled = &apparmor_enabled,
 	.blobs = &apparmor_blob_sizes,
 	.init = apparmor_init,
-- 
2.20.1

