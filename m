Return-Path: <SRS0=ovs9=T7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE2A1C04AB6
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A67F26FE6
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="mv2iFgJl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfEaXPx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 May 2019 19:15:53 -0400
Received: from sonic305-9.consmr.mail.bf2.yahoo.com ([74.6.133.48]:44164 "EHLO
        sonic305-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726643AbfEaXPx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 May 2019 19:15:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559344551; bh=cOt9caKD/749IXNAg082OZdZ8wyzsShJ6Dne6L26IXA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=mv2iFgJl+Md3hSgZcNjMrtg66euZh7uR1Y9OQ2VJr2MdDc5bVqM3QX3c0Se4dJscZ6ILAKRZoztTYbaUwiv91Z86iVulsTGgyBo5UaIcXeM2YYhrhG7m/mLm6b2vjno8g/7gzddoADuu/x/lDaEnypm/EtBq2wQUCsq49r/AvKEDbJEs7TUNiIC4GUGYKprsSOUejwS7uULiUsUs2MHBNn/Nsu1l71Nb8MNT1YpwlNz8hSRLKLMo67to2/Wgt536mMiqeggEYbHdy+Pm+8MEHoB5f8siYqfv1VTWKhV1u1NtIoiB6xmb3cgvN4QMD7/nOJK/ckawrL3XFhLumEHYog==
X-YMail-OSG: V8XuVlUVM1l87kbiC6kIMAxkxw5rNIkmZFjajQQlaipOuNvGbaO2FWn5DeXsSxa
 FAqr0STLZRfMyJ2oO1f._jjdpH09CUUV8zUF_ftiC4uxpDL6w.YsWktnxzr.LI8iQc.rHZkQfU.z
 PDJab24Y8FG5vnArN8vtTAhisgWQiUM3roTDtVYU9_dgFZogR6yAa_0i_iULNHu91F22qJvFWxxK
 gn5ovtAWyxwR_jxXtPrMIXLdkAYXZd8n2XYsC02GwI5sfZWBNRhFkieZYcvDvSCp5DkB9ULIDK.x
 oS7OSs091GtJncCc9dn6XgDfj_MAZMIhH0mf9CPGsGkNyC63_PYdr4_.FuwCbiElu62muptsmn.8
 3cACjtjY9v.8KvUj4eUGk3iTM_gNb9qVIOy1aIcCWMmxET3il4jTP7FLbfo2ppMKsafm9oZMdD9o
 0FcmVSKGUa93BAa7_y_dkWJIp0CCROBjKU66mcOZ1qMWA3njlVYWUj7aU1Q4htst9km4TYFhnp4f
 NutsLAB._9e52Nxn0MuOfyPKDH3.XoFIDsRFXkeY_Wsz6qe9zRjWKfyFo9fp.4HJNwlkY4qoIKOG
 OdLUGK294OEKZ8nUyAa4vnoK_di0OlVME7HY73TdYNWmNtEfmASsoMkzdOiomig2kw10Za_5nzav
 nfVFYg5YshMWcD4KImdHZyXVBDW2pS89P.mOT2njf70q_hX0qd7sHI6v7NBeW7hpRylBJZazFrLT
 SuciOg1xIdlOdBninZ3yFJ6VsxEs57N.A0Y3p9xIpyrMWuw3KdJksynuMolfJcl1anx62T5mqgnX
 Ol7YUINzoDVr7_0dZP.te91W1yTssJlxJX4LJyoW3uZn2LHHnpSN589YYsln0m5PsmbmJgddefk5
 UwqQm7nRYYJfh19vemgmX65wMAjLa87mgbcct7k_AjbvKDdJAncNttdu1gqFVrAIIHcrVaWpCo8f
 Bezeym9rnWlfEEsDdoXsakHfW0dC_o3b6yJbm4q2NSP6gDsWP4NKTuqIc1IInNelzv90LY79b4M7
 Cqu4ZPazK._CYOtakbesQ0VlwvUhcBFY8nMRVt5Lu5OOsEsJxOt8.xR8Hq7PCOZjpi8u8BXVzZel
 umHv2LUbFeCpVl5dwiHIpFJQNQiKGYZXB24i2II.glCGJh3wVgaLbcXm7zLKwiOjrzYhs5frlxD8
 X7FJrtEQZjnd..JtEiK.5oimA9V36Qi.U2oVX1Mm7f09Aoc6fzW.OiUgoouPwQqWz9azdf4bkAat
 O0vfHuLV_yfmuxLYGToSN4H58O01BJ6cxt1rNVsPHnfOkTpYn4b7XZ3A-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Fri, 31 May 2019 23:15:51 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([73.223.4.185])
          by smtp419.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 4dedb584d5bfc5b80f3c45100d9ad329;
          Fri, 31 May 2019 23:15:49 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 32/58] IMA: FIXUP prototype using lsm_export
Date:   Fri, 31 May 2019 16:09:54 -0700
Message-Id: <20190531231020.628-33-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190531231020.628-1-casey@schaufler-ca.com>
References: <20190531231020.628-1-casey@schaufler-ca.com>
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

