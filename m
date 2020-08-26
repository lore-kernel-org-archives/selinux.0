Return-Path: <SRS0=r6Mn=CE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1267C433DF
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 15:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9C132075E
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 15:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="HevY255L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgHZP0x (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Aug 2020 11:26:53 -0400
Received: from sonic302-27.consmr.mail.ne1.yahoo.com ([66.163.186.153]:36258
        "EHLO sonic302-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726985AbgHZP0w (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Aug 2020 11:26:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1598455611; bh=P0P3phkgM+q4+dCSn6fYmPJId8J/SlEaW2WbbitI8v4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=HevY255LtV1EesdkcbHX6o1seVdtmpw97mDgkGACZ2Qr5+zV9g4VTdUTYpVw517yJWK0icGPH3eFbuQ2G4lBzWqAwM9Ns5U5zXz9jPQKUxGsAzAyVXLRVqWlhlAQeTAUd17WiA9mIplbpTMEf9wpGx8VGa2QHSYKYTo9+TLroS7z7pDKzx4yQ8XxTnIDPCx0wdks3y/oHSClF48SFyknOLafgFa1AN9TtvrFWGqkVN7efXYrcPfNUgnK9GTfs1xmZo/BXhLSVo/2z2QSJfpudkn6S4dyJbc96exOlY6iPST0eaWYC9WKKnzlYkc3ixmaqCg4BhzpJDOLf9Tu0+WSvg==
X-YMail-OSG: L9c25aoVM1mRgn4qkAJj2r_SOlFZqHX3qneM3l4k3tmPGij543a9vlpkINSgjEB
 XJXlijNwjr3D2hjJlvsOtB33KNpmUAP5lXh_.S5w3hUgGLnObKr6dlubooKBdI_FUl9IN0oUIcBi
 7q4tJ3ALH.rsS4_Gm.OIc7KnPFPweu81HGmgAcoT8INw5FZoGzIXLEAPPTNfJ7qYwOVCz4ua7kco
 uE2ybXdGNWNUChdOMU1L4Y9zFE1AqRXzNsSRapIFuF1HzKOh5S1iTzSH60v1TIup6pk8YaC9kfXa
 CzAHM4n01DJ0l6TrukVeESNMKMY8S1oIzrsP0mv7FanBGWLsNfpWOpfFgX64NjCym_MMHy.xkC6P
 EByoFF7EiU73nWaEMiCyMSutNrRE5wocVGDC.OeI0kiJQcWzWCedCiHR86WVjkLZ.kNGcIrlWuiC
 jh_U2utNDJNqiSV9avtt2mOa6r73PG5utUmlzOHMN9if4ufqakRlmqHCa9abMdyNM8vtTm4CiB2H
 D2Q3CntArKzHxfeiD7sEsqeLzvD19Twdl8mADzuHpUWTEFQlcjBNxwke5T4sncOX5gHYx29M9k6V
 oStaZbbMDnSfY2JGBtJONPj.EhXlR6NyaAcBMhXgPihXxfaPegTEaE2XdK0BfUYgwlgMLFEkENyV
 8jgebK1C8oykRlMBd4csVfYA955wPa0mGQd7BDOLFARPpRWFHVx8ydxJTpDMT5M9To6I.gMQwtzu
 MWVtckZcCBPMdmKrklGXwbeFoXA0OY4OAR4u_O3TsmwQPT2Codsx5auELebhlKXiSQrzoPAkr1cM
 WrIXkQNjcHKNtDCpClK_qkwQhqcvR.87jXbtKpova1nhDFmvIo3a0XYYrzUChgLYGaQvYaje9KQt
 M7BNWmV7Kf.RnGurvtup3dv3SuNZpU6dcHw8GxOBBrtobeV.cHa1nExvGvgX5mg.TeCznX7N9B6P
 mVNYvxBhFmg1D2qWeObtIZ7zhiG233N7yhVVp9Y5xurxGRX3hPNJ5VliFFh5JzKqWE1RyK7AJ3gp
 Ny64GUvV_wgN2yUkT7VlwiT9leDi3gy42hR_5RRuHu88Oodf.IXcphBLskDx2pH9N.Bs0glP0PSy
 bea1_maFo0.2iYMx.ozNaAMmwHZL7hOlJiS0nIbr1d154187Q4E5fdikoRmgnXHgI2KYTqGYwSVT
 .EDiaHyEeysd3u439sTVaKw4OrehNSF67FNCP6SkSEFgq87f57BqrhUX8d6eYkXNHkgOIwT0y24r
 _E7MwHMNJeTOnrSxoDDx.SidcmrW1dFhC21sS5.yO8l5HvocAhhdSFkNGm1MSVUiUEBE3F_GOJnP
 WKsLpYqpAM7oR1FCoALKZMzERmF2FAxGi6hqEOQTBOYO5qMmyw05dtYqTfec085P51v9DGZqkbHU
 H4uid83w5EZsXo1gqCVESOrBYm.ELpvlOFX82iW3evpb30iCh_QxTCEC.c8JWZy58_4WRtCO5uBF
 jjU9nqEkzm.LAm9LpqGVUux.XfZ0RqRbAjpkugpkYntChwO2CTGAbMgLSdb5aN9BrpJ4YpK5F1j0
 3c6exY8BiIUsdmQrrYfdfbC_6Epd8vMk-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Wed, 26 Aug 2020 15:26:51 +0000
Received: by smtp405.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 0dfa992d5c241b7d78b3cce1ea5b362d;
          Wed, 26 Aug 2020 15:26:46 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH v20 23/23] AppArmor: Remove the exclusive flag
Date:   Wed, 26 Aug 2020 07:52:47 -0700
Message-Id: <20200826145247.10029-24-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200826145247.10029-1-casey@schaufler-ca.com>
References: <20200826145247.10029-1-casey@schaufler-ca.com>
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

