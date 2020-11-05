Return-Path: <SRS0=HUo+=EL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5EBC2D0A3
	for <selinux@archiver.kernel.org>; Thu,  5 Nov 2020 01:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F31F20825
	for <selinux@archiver.kernel.org>; Thu,  5 Nov 2020 01:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="lXnwSleP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388264AbgKEBQO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Nov 2020 20:16:14 -0500
Received: from sonic301-36.consmr.mail.ne1.yahoo.com ([66.163.184.205]:43840
        "EHLO sonic301-36.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388262AbgKEBQO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 Nov 2020 20:16:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1604538972; bh=yY/yFVl1emb2zJDw1hk6NF/KbSJkukEm4lylfgSZeVc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=lXnwSlePCq8EyA4T1vcN2vOrDNlPAcl2buH7ckrYgpmlxHXAIit12mmW8sUU9SY/aX9Gg/8aCHfEYI6kB9J2VSa3SUxKNz0kS4HPxHTPuxIQplmoJCkooygolNfEx63M/8VhPKK4KVKBETH3UY+ro2uRNzeyLiE5M52fVVALfJg0WY5cDLqGPbzxqBKOdrLBHtCpJiJZDJK1irfBz5kkPgCjB+lhrXDAoLSEdBsGcB7bMdb0Vpu7jbevaOMPnD2iP6GQjhDkmu6ZSqKiZgX/LYxg6fiGgSrIsdJ2EgYOO2M0DdaZ+wKUBHcBmLvn9eqd+rwgVPMapcmC0C4yuQ2kFA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1604538972; bh=ZAFMtpEOnazVgELbNLnWZ7misYOeJpXC6zIg5jypNKI=; h=From:To:Subject:Date; b=NMUHFfokFLRYl6F4JhHwSuPQJBTwDpCERNHKVSFKVb5YcUDYp6+BnHzoWYrLEtk1FCN6VTCe0xDCUqXKl6ssb15OJP9tJreJ1Tdt4Hq3an9eQ3BXWhfUztZwmNhMv4tcRFWjlupv9Y4OxP0G5md/us6EXDySHYAoCuz2Wyqiun99R3x95b5tE8hHlrNihwwUGzKk9xtFNqKxne+onppOBt2Z1MBOQQxOgorcq0mXYJJmUA9hNShQnEqTbMMyPRk2lxXFhzXDghMLbmtwwF24pfYsHRNwMy1/WBUqsw3eBYhdaUgWTFt9Gry+mNIM/Wc9CHsr8fI3V+/nOjTu5yPG2Q==
X-YMail-OSG: uz66ApoVM1l9Q3PPl5hgCxQ_1ZcZlcX3DZQgALm1T.elz3Jajx7r1MfjZV4eHLX
 BojODkcHJx1YIWXdAxA1RBTkclb2Bj3wuZz4IgNRe5KES._QrcQcu.3owhzxbb.hQNe_3bzQ..3K
 Z43gJ8RHG80OVbKEB7x5TEYpCXiZ_v7H_v6Du_eXCp8Q1mR.8l_S1Xkj2zDQIpTZz6tiKRwZbGQl
 bW5GibYbaEJCHIR0wj69mxRDPO76eNDu37RUOPX.tG5djHHuHAAExjd_qEvogBgh9N3nXajzOnZh
 9SWsgE0Q62MtoELIKspRscYTvY7ZTv031zYATaxzRa.qWRGCD.IWCPpQW7H14IaF546voMx6XxNK
 RMJiVWp25xXlRGOAJtmiUYgUsLQweC0CTrap6EcqiLzWKW0XPalGR656uMWi5b.Z30omTWysR4kO
 _0ziEM9ec0dqYC83BohF_BKbSuut6UQC_83FtVprPF1ixFRwDt9V0gwsf5cWvANtb3TuQhK913gi
 O1.nqhMSxS8f0lGcssn50OsEO1TDr1knIyU3H5rhHWM.DtBQrk6BUVGfs2d4yoOaPwE726hvzN3w
 fMHX5TivDxd1xpRFza6gsCY9R7HWT7NYCdRwBGoXAu54Kdr5Mmh1jgMDsuMJGYHysHhxSop63GLC
 XuPngwsbcA9BeAmR6_Ywg5sW.HvYpJgUz5NDJSLMwCnlx3JdiGAkj4eTkgWby7rgHpIyOG8X8zoF
 .dfYLaypTiESp574K0zI0I1pgGT6Z8SMQdv2tIa.LutsUyC.m8W0C4wKwY.RuVLo8VkUmdrG.ynm
 qE6bHFQRewQcK4b5criXYy16_rWQOJev7TwfAjAGe77e_lsI93J46f1K53oy.W2ImKVhzu6LnsBo
 4evp_56Q.qMD3zEEBiCDqavl4vS8sglctFYHzfk8e37YHqXFY__7WGfkYZET3MVV5ik5xAk.sxUJ
 LexEFNPJk_pbkYjvL2.iNoUFcTU8rqkbLDKN9HnLbVJU4UWTkeOeI0d4jjVXyQ0EcD.R6hZW.DT7
 qvF_4yHOGDopw4N3t7Gt3SSG5vDspFbpxOitmEdjwzdJBMHIYsR3rDsWvJesDo.7KiUtYCwqCj2K
 xYHkcZGU6AZG_zwSgY1YSwl3AFsn6j0ZzHQW0ADzVQCH.JxkCcTYuzNl8w.u_2hKyMIZb3o9XZR9
 lT4PQ2F3.dpgYqZufDjPo75Iy9Dr0J2Eh2ep4suA0IHMeEH2RHZ7FbotiVtv1IJSseM6LfjgW13I
 tNOHg.SdO_DF7gEOYXDF2EmD4G9V.6.jveEZhKBwo6zIKyT2o3oZ4rGsYfZNnlt_ePjVDCLTZn0N
 49X9cSJxP_ZxdmZl385.aGTIslovkrqZcPGLs2Z2q.L1MMD5rCD.SDni8u2bFM8SJpUWPssSzIQv
 nvWW77jM1ijipPKUaJAwA5iJ3AXpSsdugyiVCHU9EjPFoh5NZHLR_LLphkazGbCMBTAgXwXWRD99
 DD2Bmkk4f9KdDNzUpvS3qckuxzQ9LwUijS2L9oq7eGyjS9rqiaQPT_wnkvCicXGrFTmGU7ZC3jwl
 SBUvV8tnMiEc19B_ZCjlJlgGhIOooNKu5o6ieVFWDFeZfqEuNJAykF_I.t1GVofipSemcLHxRdSa
 7zxAFWJTBquKdQs9S_cVUMPkYmlk9YRe1QT2Hr1k93.ebA9aY484YDBHVZ2xNwHa2N5QO0sKxcxr
 XGJhPpwnOgL2hrchj6LPoo4OS1Wcr6CxXeIT5BTn6UvrF4g7awp.9H1h2EqiWQewy8fB9kwJr7.A
 3ko6aW_0.3rLzaERp2zPG6wySnz49BNTT8b.6g8Unq93ECZJYZ2aLMxOqVtHsIEqcSW8n7PMU1UO
 5r5AXjG7l5qHz_9c9k85Xa4EUpG0WUx0yecUYNDXTfmYuSqpE8U9NcYm_qpkVKZL8h1SJEy9p6xz
 8Nm5Ejkh6boYRUHRIEZF948NM4hXl2yvxwhcM2RisLswq0ZxAFCL8HgXurNqC02TfmvXjqWIOCAf
 VLqYYx3Yu8ktjbHRvl66ncjssthS5DupC.qbi6IyLlPFTg5wUrijfZPThkjcv1siO7vX1gprq79a
 cGC0ClYThZ4boTZ8X7foPG958k78EOi3osvRhxXugkPI5O6I1z_6HllgoXza7Ben0gFmQQs4Htjk
 6tYCErIhOpM3KjXZC0CKZoMj5eltBMnbvsq3WL80c16KhrM1QJjc7X.1cIIunUntZe.J2CH1qjar
 5vr6QNke0s6UA3fiV9_KO9MG7qftOwqa0oogCzOFx19yyHfuMSdTCJIkZv6shpT8SdTlfDYwDSfn
 314U.WqwvD.qRvG1FLtt3bxQfZXa2hCdJ8yCEtVCED1Vk8qwLWyHcNLlbc3nFGofe1Em81prZOTL
 7X7h5klhXSx4OqEaWAX2XJeryj_NK16ORB6ISSee..nFSBoY4KnUNRflsAjEb8S1_odW1bEvoJzz
 qIsWSrBS4Ifw_zc.ThVOIRlX.QKUuHUV8CBSc7IQcab9WS3rvvtJZFipSGdMrchkg5JyJOkNpKaA
 A_Y8ObHKewMQP_B4DhGs0b_kgZSxMBdcmeLdGJcM21AUnEcKZk0TrhgYV4SvBZdij6Fgt4hhjvAl
 CJj8rzZgFkMACQbjzkMKLA2nzYBP12MDc6p8VTewq7qqC7wuwx2exVamUAFtnF9qAazDOVLTkoE0
 DCtcfAv_16zH4PA97M1gNQsClYZHxyc8gZ4MHLZ1H7otMeMnyabqeX__QJWnjRHFQaZhpcN7j1Qb
 CayDtU6Bp..Nd2NHhmkwmhRsAE3faaxb.lJHCRPVrJWrkIadt9AKOiztDlosWgXpKmLJ_rebs38K
 d1MMYV7PYAZvJbuNFCUZsTB278.zpJDA8SNR6utWfWj3Qw1mw8UmQzbYu3uDeJH57znZjdXbYK6.
 lmppoIVxcWB05EMalUVBCg4JB40BE3tjnRxYiOhYv8LuyL7l8bX05g4_CuMxVk3vGlQzvB5YYdQw
 iF1ktCrWuB5ydr6IFsj5cC7sZZQOEaxNhwGwzBkSzQX12Utr1yA3sR9uB1KKfL_tqVFJ6DS8DO3U
 MipNOIk7nxQUCpkRQJTdz8AXD2Tet5.KIqbkohcOApQQMybkLFWpbHhikeqIyuwaAfnxDMjmYK1b
 6nw9aOYpBxA_ndCvcWrpA96rFfNkqDN4D.yetx4bBZWhsiV7B3zFCoisH.J.JdSwtacKyueAvfbM
 JXYoyhWcJly4R6KjR0iRH3zw13VcjcoKbZ1rKRaO_zyEfz_8s7eZGmOSPFOszyDaEAVPB2JHJTJq
 eODvgeL.kh0wWxqOSU9a2m_GSNWjPN0IyEqswyeGTjXb4WJQ67ZrR4VWX7JVH2WvFCKxTTL8ZVtr
 OFRg.M5v7gyY-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Thu, 5 Nov 2020 01:16:12 +0000
Received: by smtp402.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 9b08706fcc5b5291f7c73cdec733f17c;
          Thu, 05 Nov 2020 01:16:08 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v22 23/23] AppArmor: Remove the exclusive flag
Date:   Wed,  4 Nov 2020 16:49:24 -0800
Message-Id: <20201105004924.11651-24-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201105004924.11651-1-casey@schaufler-ca.com>
References: <20201105004924.11651-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Acked-by: John Johansen <john.johansen@canonical.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
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

