Return-Path: <SRS0=8O8t=UZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE109C48BD6
	for <selinux@archiver.kernel.org>; Wed, 26 Jun 2019 19:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85E3220663
	for <selinux@archiver.kernel.org>; Wed, 26 Jun 2019 19:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="c1d4Xzx6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfFZTX2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Jun 2019 15:23:28 -0400
Received: from sonic308-13.consmr.mail.gq1.yahoo.com ([98.137.68.37]:34648
        "EHLO sonic308-13.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726328AbfFZTX1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Jun 2019 15:23:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1561577006; bh=8dC1jVQXX043wsRfaniHkOG90Ze0+lXUWQhSzRkq1W0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=c1d4Xzx6sx9J+WjbsoNGt97cM9K+luz/v2OuH/oiOpMGeVU/uh8XqUyfStDQwTUXD7dg83iYY7tHKDrOviPM3SVZvO/DszB9u95mqLfLqITKUdUUUcrkQuIwgr26CDwK/b59oh+ZnKlLsFu5NlmoYNrPXwkoZJRVptOY5q7Y5TqK5HElNssKo6cc0Efy+5ggSLCHTQbfmSJpTfCSsTFqyrbHc2ACjbDASdQjAwj4MKtzYZXfrhlbSf967kQtW+gUC7v4XK61diH94d05upG2m7d28KqMEX4n1n5nKWGbHOo5q8h2BZp3xS0Axx46zKET+OmSXwH7/sISlI71fca2DA==
X-YMail-OSG: _NWEug0VM1lN0.btj2278hRw9Vdt6C1c8GH7esYu6CQGwcFEn7wTJ.6P.S.6eZV
 LCFpOZbrXy0vR2KaDG_XeEapGiUq22eetj9XovKsEYOyrpC2UynDoj4J6vNwM7.Z5s111d4j9p1a
 hHgwhI_r0Jc.azv2Z.DaAJJoe9ipGTHOZ6p_tjWcXiDI6Al.h01cYunviH3UoOqoxufnln9zpSC9
 u0V2bWmK1.vjzGI0EcngYS6f_pFU7DT8_KwD0BOKHpcgYlWsOn9ulP73h0sGJaScrBChyaUjGyPK
 7xv3kFATO1lBK5Q0DY.4PIddUKqM0lV.7TGGFVCWCcfcgo3oicewc8AhH.bwIwO0DP3rlJ3JKQBs
 wUNsqkBGxsDBKmJ4yBdl5UUywcZEylkLi_xXIDyLOtA1WFrNmK1K69aqPt4DmfDqwXClObqh4GBt
 TUXxq25y6MLyL3EFjotbsuPN5GFy_Q_mQlSrKH0.D2qo4vBWeArjIaCafGMPrFfjBML4K91f.WIg
 uiZFe3yr42RMxBHBnO5k3K85GpatatJ5jJumm1oFJgZ9ur8eUkB5hRl66IPsXRaGD9X4CNlnctw1
 h6JdEE7lLSkGPAxpKovg9tndY5sPEXr.ckVodyrbgRAyEY2guLxVml6ljGAytQFx6vHzBdaqUVpM
 xtkwPsA_tndtocYVJLhnI1soQSD7Q8jbRLPHfD6ozhmU3AJALKtRKTYSmSZPGQ_Q9jcVatF_ReKV
 q1qfskMkNrarBu8yhLGtyrmXqo6L5Ov.Qy8yHuBIRCu9X70V.wEjGw86Qdk2VV_tM0P.byw3eilq
 _yJ_GZ4eD..PpWkhL3i.EUxEVDjXLXvPOiLt8FjDmQLqDOPhg.3A_kl0fQe5li31WRKChEBkliE5
 Yf4tqOBHyGSuUdYhxsP_k64HN4pIzx3ZswhpOCPPUNFnObUxxuuW7Uvbw0syOrSiHghhJYjOSvkE
 Bd2fMRZGYx0IlCpBymT4EbKNolwi42kZ.unoilxezfzqB_IzMYKp5EyEQOKGK6vFTSXx_hJ_yYjG
 YkDo67oJ6CIDdWvXVYqBcOvnhuW3niOsfbEyLa2F80j7i7jhVt3cJk6DDqVrdLLGN8HW0mu6gH0E
 0M88YtYJmS3fU0n7.8YVQfCsfAe4.mo08DQ77R19hy5o5PU6iWRT5RofvYKuqkK9oeUoW8Jgm39V
 x4RM1jqwO2PBpPhHW1wqlJcBgJFKh5NdyuXSlRXnglAaIJ75kpk3_XwMJL0WR8x0t0Cyq7trWWjl
 XkvhpFDlahCT_1.wXNcxHAvrTi8s8D55sngAUwWxQMEQ-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.gq1.yahoo.com with HTTP; Wed, 26 Jun 2019 19:23:26 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp413.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 7fc532bf6bcf33ac8b649a0abf15fbe8;
          Wed, 26 Jun 2019 19:23:21 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v4 23/23] AppArmor: Remove the exclusive flag
Date:   Wed, 26 Jun 2019 12:22:34 -0700
Message-Id: <20190626192234.11725-24-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190626192234.11725-1-casey@schaufler-ca.com>
References: <20190626192234.11725-1-casey@schaufler-ca.com>
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

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/apparmor/lsm.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 6d2eefc9b7c1..fb5798683ae1 100644
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
@@ -1195,8 +1179,6 @@ static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
 #endif
 	LSM_HOOK_INIT(socket_getpeersec_stream,
 		      apparmor_socket_getpeersec_stream),
-	LSM_HOOK_INIT(socket_getpeersec_dgram,
-		      apparmor_socket_getpeersec_dgram),
 	LSM_HOOK_INIT(sock_graft, apparmor_sock_graft),
 #ifdef CONFIG_NETWORK_SECMARK
 	LSM_HOOK_INIT(inet_conn_request, apparmor_inet_conn_request),
@@ -1707,7 +1689,7 @@ static int __init apparmor_init(void)
 
 DEFINE_LSM(apparmor) = {
 	.name = "apparmor",
-	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
+	.flags = LSM_FLAG_LEGACY_MAJOR,
 	.enabled = &apparmor_enabled,
 	.blobs = &apparmor_blob_sizes,
 	.init = apparmor_init,
-- 
2.20.1

