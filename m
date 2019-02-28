Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4963C10F06
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 912CE20851
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="mh8RaDtE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729931AbfB1WUk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:20:40 -0500
Received: from sonic309-27.consmr.mail.gq1.yahoo.com ([98.137.65.153]:33029
        "EHLO sonic309-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729663AbfB1WUB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:20:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551392400; bh=UQjfh0v16AxJWcccZZiZEJMDUSepDFazKRU1XVl6thk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=mh8RaDtEIK6adxBCjINF6fsh0f6WDhdJs288T6f3JsUkmUSNUJUTyRAK6QfuZuWyord+0IJnm/msv3lbkjo+KsM7iia2lvo6e5z84G94IXT1Jn96I7ZKjYWtlda7lTj04eZ+XbSetDthwiDNONepa7++Fie3CNxiXTKD+WEDw3XGiwSK3RJljDvxFKwnB/WuhrPkThRqNu/TSw355gAzp170NQCXCqSuMXhsjEHAroiHneG+lN7jDHOxi0/HlsGwmxZwqiS4jGdpVT6A6NNd37/9vfBiw6EXFDgUJak30ktY4FhT2RRVRVqJFYHz1KRJC+mS7TVx//qd+U624Sq4yQ==
X-YMail-OSG: LlSbQ_EVM1nhKYIZOdbAZdv7qN5DoxDdlD5BDkoQ6b6kJ9Pqmlvk3n59k0vGb4c
 l0Tlf17Ppw6ZBQga70oljqEw6x9tv6WDwfwGrq6xWUUMgMoUUOF5McK9hN1EdkRG_RXD5z58YXyq
 pT_v2UtZJmV2CwiiXBeDbtJHGpZE9PiE0Rwxgv15ER7bKTwRIU0Xg6CSmP9Dk56Wot80e6tBr0kw
 WtgD.6RdXHZnDTtNM6QpZ3bUBZ_PQ18JllqTLUW7l5jeTc2Ey62slzC2U9Ny_K9jdUNdEqMMxHE7
 O7uZaECGsbCWyedVrTGaDdnmvuJo2DBUVf_BC_TZosbS9ka9eKGdVS_Aj6wM1fSZymI.pqGOuuBw
 4Pm1QdDyFvJxxvvyBCDikgp71ZTy54krZE7.7QW7WJ50MoJ9Tcn0C.kKjHD9Zt1a6Mt.7NtN_85p
 HAdu1zSQXRuoUWEIwS49gcnIX5bmleJAw8ZMf1kcUOVaCFLGkZH4ix8ssVvB3LtQMmJg4OyCHgVA
 Z7ITUGuWQTCTRnkkM4OXIlyVSDlFYJNBE9oMVY7XmMo2MvViOVy0XfGxMQij_1We1hd5HRgj2PFf
 bs7VD8fZnMC6BkkPrHzl0I_Ar1yuW.8gq3Ds6XclG6YMDJHjstMGv4uXk278Sn24d_v_8jHVM5wi
 HI9wwrxJtaGKZT9x.FmKm611q6BA_jqzcx2r4wnMogOd53Nwl_3Grsd4tXauEHX9ERTY3QyFdXiX
 185Jc1TL999EpyggLcuMgiMdjceWKfMYu625grZjpDSc9eVGE6vTnMrLuvp7hOY4qCCuCbEkM4qs
 _6mxCk_aRNXAhxIUG5XBF4hMVa2Mg.9qAG4B79bb0ICfEM8AEcVLEme3l3XgaTVGUCzUvL42CwcY
 .qT2t0ilVnNwhV3b4Cw7EexjA62kfwsnAoQVnh6Ur1NZ_YqDkLXvYOmc4ph.TrO8sM1SkkxVMSoK
 bXychDixdLj7k89CDehC2zaAGNCjmxPO7tYl0mGfR5JDzCSdRx1lwhUcTZPzRw98lWicvD7sfb3z
 7cyp0QQJZTlt0PsCa1i.I0EXwK1pBg2sEZoFSZqWeEi4IdYpSsFydeKqfvTo5KneuSR4W1oPHb5a
 fKxpzT84iUtc64lZvEh7HidyrpS.mAPuTJxqSC6lIyyCA2Rs-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Feb 2019 22:20:00 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp406.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 5c7d685bea94a92cc9d12c4cc22f1f0e;
          Thu, 28 Feb 2019 22:19:58 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 25/97] LSM: FIXUP - security_secid_to_secctx
Date:   Thu, 28 Feb 2019 14:18:21 -0800
Message-Id: <20190228221933.2551-26-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228221933.2551-1-casey@schaufler-ca.com>
References: <20190228221933.2551-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Fix in netlabel for security_secid_to_secctx

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 net/netlabel/netlabel_user.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/netlabel/netlabel_user.c b/net/netlabel/netlabel_user.c
index 4676f5bb16ae..0266879efef1 100644
--- a/net/netlabel/netlabel_user.c
+++ b/net/netlabel/netlabel_user.c
@@ -100,6 +100,7 @@ struct audit_buffer *netlbl_audit_start_common(int type,
 	struct audit_buffer *audit_buf;
 	char *secctx;
 	u32 secctx_len;
+	struct lsm_export le;
 
 	if (audit_enabled == AUDIT_OFF)
 		return NULL;
@@ -112,8 +113,10 @@ struct audit_buffer *netlbl_audit_start_common(int type,
 			 from_kuid(&init_user_ns, audit_info->loginuid),
 			 audit_info->sessionid);
 
+	if (audit_info->secid != 0)
+		lsm_export_to_all(&le, audit_info->secid);
 	if (audit_info->secid != 0 &&
-	    security_secid_to_secctx(audit_info->secid,
+	    security_secid_to_secctx(&le,
 				     &secctx,
 				     &secctx_len) == 0) {
 		audit_log_format(audit_buf, " subj=%s", secctx);
-- 
2.17.0

