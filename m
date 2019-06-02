Return-Path: <SRS0=/A+P=UB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A7AC282DC
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A2252794D
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="V/yfTB4B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfFBQxI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 2 Jun 2019 12:53:08 -0400
Received: from sonic303-8.consmr.mail.bf2.yahoo.com ([74.6.131.47]:44340 "EHLO
        sonic303-8.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727001AbfFBQxI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 2 Jun 2019 12:53:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559494387; bh=cOt9caKD/749IXNAg082OZdZ8wyzsShJ6Dne6L26IXA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=V/yfTB4Bvuf0mleZIpJzrQbmnlRVqPNpn1vpSX2seKqKsA6sh4x5kiOyLcxV8aGbWzWjsWCcwbBni9uCVYv2lWQJLVAk5xauFGUKrdTtq1cE7RNsCGrRd6Le3zX57/AVmqJrY+OmJ/zNOQb4vlWjyOuFud90jOPYl9JOW9+E3kyBNs+jC06o8K8WNQrS7/5IQ5TgMDsZs+nYRnyQX1rYBgK0GUfNTmgjL1jVjlmyib6CzN+VTr2bT9HhBrzDmcCfRxYp5tKHWkF299CLRUy8Qd91WyOZfxCl53phqI5EktXsZ/9Vwhxhz8vHl0luiMj39aS74Pr+zcOLlBnUte51ZA==
X-YMail-OSG: KpTs0qcVM1nEUPkWDpaRfdUIoTk4IpSwXhHqlPf_542uJwcivoGz5DWGNioiV1l
 rHYD6Vs3l4pxv4ZSqRmWQpXR3jViQWTEXeNUbl8uY3tUWw_CoT9gK.53Ll5F0O337jKg.5cQ4jwf
 B5J_ZQpvUB.DyxWyW9RaRgU1_T9ECw7vBydG537Z1jxRTlJqnAUTEBXpnR_VVJQHh3XoYqEvg42x
 2Ru9Qphvyq5b3h.1gjSF0anjSkMQy4UA3Frx1YOyMqEBgDVXl_fOn22egl54MtT_gwwO32hrrO_q
 gtYi.fxNciz6.T2KnUilGpsHXzJiBFk8rL.sR8jK.WIk8.NR3msjgxR_jlpoVFbCANcDLJNqeb5G
 HPgXy6HfAkfapKmLn7RxUVwDt9JfmR.4YMyPMFPmayYxNAIsBQWqsypK1AA9Sg2._jQ7Y3B.FQBE
 CisPouBg_wt3.r0LPFHdIavpxGKOzW04BNvCAkWrK2cv7ywaj9T8dSU242fDKKn5IH0YkK0LG5jA
 zYJlcxaDd4pHoA2me6pYNtWRXq2WmKeksu43PLYvlFoJuNKQUCYkdqY7eprc9IvFV6hvEaPiFqSf
 ltIBQv445VRB7XK_FUKQ7Arnx2vhl3aMlhMM_RU39yhsjbv43ZRgRQ1k__w_2TbDZHQy6zNdOPmu
 2NM7rhkek2naMlPcUhEp_..H8WLlOzPlpyZQWdvSqgnDxqck8DSiT4TmGjsChFufvS62QEPHWJxm
 srtLELQx3afciA1AaNfUlD3aZTvrdjS5LdQHVrprY832SMOFrhA2D8m0RL32.fomRiFQyofZkQ1N
 K2ArVpC46bFK0xu8__4axMFEgApUd4a2tUccsNy594zyPdKxa5mlw.7vT52yqZuiCPh41IFYGJ79
 NSQGVSeYLHOrp9nbA5xIrmXJGsUo4iveawMjihaLuyyOeArfT6MASQ.Nk9wguyQyU2yvXowf4A5v
 laGSHNDanS_sGvIRuEMq2cFLwpC9W82pgSrYoOMUoNVskd9ZWxhPil1zyGxn7OQB6kjwAt2DAXQX
 DL1zRBJS.KWbCSuCAOecenHxW5yfqcW1NCQ50pFOAmUxdUJE8ImO_o98Orz_P9KUZP5gQg29S8PI
 9x4AifuCDMVruDD6WvgIT.92gU7fgJVekjmrjC2Un1KeGF0flxDExX8zsgJ9gj.P5qP0TGDHnzIg
 Gz4o8F7PYDXps_wxv7f7Y4VaCcz6oxdxomifg9PU8.Ya031X_rBfQ6U.4kctpXBNQ6zuuaBtU1x6
 sAb99UY85681W_z8.X1HkxLOcUhUe8mcUW8mgjmtbZ8_YxxHVUzYXSK5V
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.bf2.yahoo.com with HTTP; Sun, 2 Jun 2019 16:53:07 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp430.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 740888a1156cdff0756b5bee8a218310;
          Sun, 02 Jun 2019 16:53:06 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 32/58] IMA: FIXUP prototype using lsm_export
Date:   Sun,  2 Jun 2019 09:50:35 -0700
Message-Id: <20190602165101.25079-33-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190602165101.25079-1-casey@schaufler-ca.com>
References: <20190602165101.25079-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Fix the prototype on a function stub

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/integrity/ima/ima.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 8b109ad0de2e..7ae41218eb07 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -309,8 +309,8 @@ static inline int security_filter_rule_init(u32 field, u32 op, char *rulestr,
 	return -EINVAL;
 }
 
-static inline int security_filter_rule_match(u32 secid, u32 field, u32 op,
-					     void *lsmrule)
+static inline int security_filter_rule_match(struct lsm_export *l, u32 field,
+					     u32 op, void *lsmrule)
 {
 	return -EINVAL;
 }
-- 
2.19.1

