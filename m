Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61367C10F0C
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DD6B2184A
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="hSIqaYh6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729910AbfB1WUL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:20:11 -0500
Received: from sonic315-15.consmr.mail.gq1.yahoo.com ([98.137.65.39]:40059
        "EHLO sonic315-15.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729875AbfB1WUG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:20:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551392406; bh=Jz4wQbfcze3bBK+GjSLzGZEmDjIBtwBHzwn7qN6Q6k8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=hSIqaYh6PbqlXOxe2Fzo6xGDw66Hi84ejjfgRC7MI+eSsNVbPQWZmU3rkiRMIaDPrpxwCKr2WwDIZjh2k/CGxw4P8iIO+FAEYdW7w4crqZYq3qg6pNF+GUOUj1oEG9w5LVWCa9HqOZRTq7C94untjG4GRrUhnohcrDk659eQg75kHOanfR7eJwvpqcWDYHn5PUg5C/5FbBR7jclxRwN847IylxWD6FAA6r3K72kTwyEeOAhag98+JMjEIZ59hXWJ4HsNJTNOVHl9NBFf7qvaWjcwXhwfNJ5j0VeTW5WPBTt6kVaxAaX7eBfAUYqGwXhcKD77YsEuH2pxXGnlBkAYkg==
X-YMail-OSG: qrBHQY8VM1lH65mADLgUEFbPFjPuuHiuYyLmaBpYGUBgXf0SBvZeIy41S7ZfgmG
 lC6fsCEcaNqboDkytPbgiSVKTCkxwHsimnL4cxxnNSK.IuF_SVfzavnQ5YGxw5T4TN1j9ai6i1ML
 4zH8VpTIJ8CCnlNJ9TF8UM2m_c.K_eg8D1sG6UiYAaDvPKzYVWMKgecnvSzeCZ8U2BbPVwlRxg2V
 dj8kd2qzI4K_GaHwF45JmVGN10X4fETwUDOA17XGOgUm4FhjpJ7awGNmRwXCptK9ZCjgXsi.zr0U
 HhKvcx7nfi71WAjY.4rp.9J.fqqnCSjzYxItfY0sshin0EvIehmGx19qO.ZuCFcgkm2TuhYUuVvi
 9T8bSlBn2EOYIl..AiGoKJ3UPiFiK_hKuk9LuhDW65Ixr4y.gBeBRkr_9_Xmpdxj6BKPJDgUSAdG
 wYV9IGHYaR0hm8UMtL3IUdspaZ9ZBQP3SP3BPxqQSqk.hlnk_iy1AGFIomF_I_WLMxnUEQd_cnc_
 dmLuxo89t.Kimf0ED4aZBeHdBLNLvBT4WSiLM3JSfpAq0yFOPUIdcbmcyQ8b5Ayx2M1hV2luvilu
 0mlBXUrRcXfmXbjk2Qk3ZMFYc.MWIdhEfvcIBsmknlyU.nvp73248s2KRYLHR3q4uQ21bATNmcVw
 0KYYf1FeXwifiMUJGQBP_0E0TyQu_UYPJ9LbG8KU0iKhze4iEecC1ixW4FYNzco..ZCq6wO25ldT
 wOX8T5eWPusmj4dfdLFDtCg2i2m.nJILt.h_6uaUqyTvb2a0zQFNQWnzPmJeZooPZcDW242lTsFr
 yMfu9tC7KUpEekg_._nfjR1_FoofgmIvYz06vHKNYILwg_XQYEnp10.K43u0yuwYU6rFY24DEnke
 Tl5LZNbl9t1R5FmNjnanp.9BrJ.pVszT9jCtBExHXZHVg9qdpmjcMIpqhugAJ5KGBF68B5RrzrDK
 MFbSje9NmS09iks0eeoVN3gWC2eGCtWDmdYsx0CUVv9sW1YCjhA7IT0wwncbDx1lj_mSrIF9HQJp
 VtWq_My.5T6vudvnnB1ShsqDNJYtYCnI0Qp7DifbDN7pTdQIWEFJikmviZpp7nBBIIEvA60DKd7Z
 W8bVl5zkSJtvVyc0QgwkWRhsfOKo.IVope2mwrz4sL4sIuVIq
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Feb 2019 22:20:06 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp409.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID e8fded081226753664bb344863181a7a;
          Thu, 28 Feb 2019 22:20:04 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 34/97] NET: Remove scaffolding on secmarks
Date:   Thu, 28 Feb 2019 14:18:30 -0800
Message-Id: <20190228221933.2551-35-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228221933.2551-1-casey@schaufler-ca.com>
References: <20190228221933.2551-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Replace the lsm_export scaffolding in xt_SECMARK.c
This raises an issue, in that Smack users have been
using SECMARK_MODE_SEL, which is suppoed to be exclusively
for SELinux. This is worked around in the code, but not
fully addressed.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 net/netfilter/xt_SECMARK.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/xt_SECMARK.c b/net/netfilter/xt_SECMARK.c
index 2def8d8898e6..9a2a97c200a2 100644
--- a/net/netfilter/xt_SECMARK.c
+++ b/net/netfilter/xt_SECMARK.c
@@ -55,6 +55,7 @@ static int checkentry_lsm(struct xt_secmark_target_info *info)
 	info->secctx[SECMARK_SECCTX_MAX - 1] = '\0';
 	info->secid = 0;
 
+	lsm_export_init(&le);
 	err = security_secctx_to_secid(info->secctx, strlen(info->secctx), &le);
 	if (err) {
 		if (err == -EINVAL)
@@ -63,7 +64,12 @@ static int checkentry_lsm(struct xt_secmark_target_info *info)
 		return err;
 	}
 
-	lsm_export_secid(&le, &info->secid);
+	/* Smack is cheating, using SECMARK_MODE_SEL */
+	if (le.selinux)
+		info->secid = le.selinux;
+	else
+		info->secid = le.smack;
+
 	if (!info->secid) {
 		pr_info_ratelimited("unable to map security context \'%s\'\n",
 				    info->secctx);
-- 
2.17.0

