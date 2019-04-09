Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333E3C282E0
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 003332084B
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="FW2Cn/Tq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfDITTX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 15:19:23 -0400
Received: from sonic313-26.consmr.mail.gq1.yahoo.com ([98.137.65.89]:35190
        "EHLO sonic313-26.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726844AbfDITTV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 15:19:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554837560; bh=fGxfp/CN22PmumS7bLwAFMtRgSd8WhnZOIiNQimjmvQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=FW2Cn/TqkZQDcyr2S/WlPANNrLAS0BmG1R9L5BH68qT2m0lPviF4cCf9d5xoL/xFy6l3IRexLZjtFdntgsfpZICzkn0WWqNETEJkFttNnbrR4aBcqfABvp2XMPEjEc4vq7AjimdLmzfh5GDljmyQBFYUb901ZPdZLLhy6Q4OpPqJyPlYEbi853GFUTClwBoeS6AunA/9dyQnNwE6oIve7j/LsRj32lUoGkS9gQeUpFG/oJfmH1gaKNxMziikWXlgvImE9CYPBgnTEjDVsOCpk2Nr+E30bHkkInoz9k82cIGpost4+1SC4TVMtz+lbWZ2apJwqW81S+dCvs9z9ujzpg==
X-YMail-OSG: J5NvMuoVM1lta_3oE8bBR6UjIMWLG30stY8TgLpskyVYvs1PeHKocvsol.XM9vO
 KOuzhsmJwR42oKRkYCoPDeKXoAcUctFRHQrFXO9xifhX_dI9afS2ZD5kawRkLKRLFBMsYl7EfDHt
 sKZBAoZywYTXZak95wZGAOMXbznM86mpKrtyXJSrvrliGHgumVsrOudZzm5zx4gUTsdptDA6nJzK
 2yZXBWhbsgtfzTyIh8Tl71BuzogKSELIXEJzw80tiWcjhsoDpcWH72j93Pg5fATaSoAqdlG3HHER
 nSm.LTCAwIrOdUivmw4QgFQakgtkLt3SmMRgpIPbhEsdnPui3SmjzkbrV2b2yswd2b68uoB7fILf
 Z4wskoxx.N3e6GNBAmQGjj1W.CUhulLC0gYXxqo08qX3FnBtEUPQ0hCe5r_0EyIy9hkfDlD0wWcW
 DnsLkj5KEiWB3475F6avMA5uXzxavYQyT6QC.L2Ca9XWvQdBSeeXCkXofKfDOLGIq0SRw.gKV9i_
 .IzT4B5FDUFWd4kAgiqxf3aW1o6ZUk_GUbaiYfaYztrm5MuuwpHV0lINKVkLWEP26JNyNaGOjBL.
 JxQzFA_2TJLWy45vOiADgKZcXMpmmSREg.tNOqExLn9PlLdvTs9UZ_cT8v1xutt4h9u3DkPXZVTc
 ZMhUHnXq_w1MPH08ApGPcaQ_OpXAxXl9652cgOI4za4fZNf0aVZD5RAneFSQmM7j5av9g09a3raJ
 5F95uQ.T52Ziv6jwETinvRSRYKmvLdmuj2MZgJIG4mYErLjVx2Vv_ktdtaIpT_R_D8eWWSyBAxDc
 6ta07hQy0eRAWayVzEUTjKAx8qvQAiFN_2pRUjmybWLu0oEuKizhXIUeyTK9snPQc2oGb.Z3pMh3
 WBAkt0slBFtp643W6ULMxG.nFEhlXw9x5uhlTSgM6fXuVIf2ZXFa9Q.aH1UkfxaEF_Bq4cXwdqr1
 GATpJnatw7VoLs4OXrWMeXHR5EnNAwXEeZXeShTEyn.Ms1YIAz5md9DMxHtpyLo8IyfmGLLXAY6T
 w9ubc6WEJRpRNmioFr342dbnWga2biGGtbue3R_vlAtqtvaIMaA3cQVKA3RYefe.OA8QTfUbJ0yQ
 FcHhd1b_fH2aFjGyWk3kf8JfmQu2as5EfTYC2J92rji1O3ufzPhStMFc-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.gq1.yahoo.com with HTTP; Tue, 9 Apr 2019 19:19:20 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp420.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 564a224fa9abd9f41816cac9472f1914;
          Tue, 09 Apr 2019 19:19:16 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, casey.schaufler@intel.com
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH 32/59] LSM: Remove lsm_export scaffolding functions
Date:   Tue,  9 Apr 2019 12:18:21 -0700
Message-Id: <20190409191848.1380-33-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409191848.1380-1-casey@schaufler-ca.com>
References: <20190409191848.1380-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The scaffolding functions lsm_export_secid and lsm_export_to_all
are no longer required. Remove them.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h | 43 ----------------------------------------
 1 file changed, 43 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index c413dcc1905a..6c44aca19c65 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -117,49 +117,6 @@ static inline bool lsm_export_equal(struct lsm_export *l, struct lsm_export *m)
 	return true;
 }
 
-/**
- * lsm_export_secid - pull the useful secid out of a lsm_export
- * @data: the containing data structure
- * @secid: where to put the one that matters.
- *
- * Shim that will disappear when all lsm_export conversions are done.
- */
-static inline void lsm_export_secid(struct lsm_export *data, u32 *secid)
-{
-	switch (data->flags) {
-	case LSM_EXPORT_NONE:
-		*secid = 0;
-		break;
-	case LSM_EXPORT_SELINUX:
-		*secid = data->selinux;
-		break;
-	case LSM_EXPORT_SMACK:
-		*secid = data->smack;
-		break;
-	case LSM_EXPORT_APPARMOR:
-		*secid = data->apparmor;
-		break;
-	case LSM_EXPORT_SELINUX | LSM_EXPORT_SMACK | LSM_EXPORT_APPARMOR:
-		/* For scaffolding only */
-		*secid = data->selinux;
-		break;
-	default:
-		pr_warn("%s flags=0x%u - not a valid set\n", __func__,
-			data->flags);
-		*secid = 0;
-		break;
-	}
-}
-
-static inline void lsm_export_to_all(struct lsm_export *data, u32 secid)
-{
-	data->selinux = secid;
-	data->smack = secid;
-	data->apparmor = secid;
-	data->flags = LSM_EXPORT_SELINUX | LSM_EXPORT_SMACK |
-		      LSM_EXPORT_APPARMOR;
-}
-
 extern struct lsm_export *lsm_export_skb(struct sk_buff *skb);
 
 /* These functions are in security/commoncap.c */
-- 
2.19.1

