Return-Path: <SRS0=LK0T=WD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB5DC32756
	for <selinux@archiver.kernel.org>; Wed,  7 Aug 2019 22:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04AAD21743
	for <selinux@archiver.kernel.org>; Wed,  7 Aug 2019 22:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="kfpJkTsG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388681AbfHGWnF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Aug 2019 18:43:05 -0400
Received: from sonic303-28.consmr.mail.ne1.yahoo.com ([66.163.188.154]:38500
        "EHLO sonic303-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389558AbfHGWnF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Aug 2019 18:43:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1565217784; bh=ZUvYNpJVEFecctk/GVbqBSpS33JuXn1Z6n8l1Juxt+8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=kfpJkTsGkeD1IrmTUW+6TU+mYqmYE/eiC6oCKn7xlWpDttkH0Z0DpsHYE6xE3PLtSLGlzqOqQc2wm0P1OFgg+KVG5lY5C5pGyxHCG9OtJ5DtiO1qXREvPpuxr+vtITQSgDFslAEnVRCwQ2o4dh+zjgmLZPjumHem72/YGI4HLGfdgUO4eC71vB7+hZl+N1lcMSEvXmd6XQiyzkvCo5JbC+G7YLxeCV/pJHd2o79MCuFXXvJ/5YBm4aqOt4AytR7cZdluVRwph67nzdIaS/kzZ5KEqrLT9ns9ep63nlziUFbAL4q1amBmDv49uDFy42kezCKjXnlzW6yjcLpZ0Xvq5A==
X-YMail-OSG: XfLy2akVM1kOH7soX8bWdYB6lcpddonom1xINN4DR02fo5TgetX_.ULqQNJMypa
 p2N8xCR5Lcerm.mvTFNw1_hxm7KaRP2eLKjvW_Yy4R5bttqMLxKPJk70ln85rUSA0oXVt_rUC_lN
 YOmJ1.W1y.z4ERcpDgcakYNzJcaElGP2_xBNr4EyXQ5gJn141dKDAJuz05kCMwPT20Q1f0iMU.vK
 8Uq0HOzyRwOvNg9o5RgVtQzWIBazBLdZVGKR0bopmBebO3Y5G3XiO8stxtjAcZdDkRVyPm589qh.
 4k1F.RfAUHgsqd3oiRQGhKAItBxXpaJ.ZH8c2OwEtpFXtcKfR31tUYTjodYvpSirlnQQuANIqem6
 pwy6vYPU.01gXCuwIDQir5CDGnn4j_x7irzykumBeri9uQocjCn.SMp8nu3oPswwWD2F4X5iO5tL
 AvNHpB_7lLoES0CJgUpjN0GhShMayX6tGWS5I4NrdhiCgliDFCuaxsTylz3fgdv6mG_iRANavSBQ
 e1ouw3G8B6jNBPgsDVfSxtJjSGD_8YfXQXBLAk8E0PMRdRssUAIKdY39bxyefqBnZRDdKBf18ZyU
 jevaCdkaus0fb9h2CG71HcnwJJDMWtb1tydjRlPJsgokVa.AsmlbPuqqWSLHQkSkCGd4r.4_Le8H
 LB03UZE1617ksJ7.RnMP6woo21xCS4moh_uAgmSlgVuJtXR6lBK2I6zdH0VDplVyJmKxPdoo7Zvp
 31_kA75Ct64.295vI_jL2OQQSZIpNVrtSCsLn.MV2cqfTrjm6JryyCglLzzH7RH6Xm1aJIqDZ33L
 JlcQ_IQ_dx27wgwWn75dmLMeCMMB9gxLvKmCc9LjbKbeW4oR9OpM2b7VPpc.1OnzOvZ7ogxqc1uc
 bJHXK1R69YzcMpopKF49QAdI8sKnCMLBTMw4WDR6BT2OxL5d5T_g8sQ82EPunvGIbkQRVFUsCXa1
 YsVzeKcs6CfnFCR9jht1zpJAFQV_rlwlz4ER9L7Q8J7MIOj8UiN1hGlZDIq90jCzNOp7ZOeiBGW1
 XngBtLCLtBXi6QEmcS52pIYzdIVhHxunlkvrnT_QqusgH7v8jQlG1Xhb4.YYkxq7lcLJNgHhFRKM
 Db.TGfQZEqJ7yC6F2FmwfuCBR.YDV2mdo9g_nCITECdN60VzcOPbyWfHsnMepc376AnZvBIPx.Ia
 VWcCvPoSW70jNS5fhclEUEXblz1m52w7znd0.uggMNtNmqR48SPLbdeLwk8i9hx3yctwx1dHAODK
 bbJ61bKerloyWVQcar2Vqlc7SsNoxKQZjHmKL4POZA87imfUiV8Pc3yfZ5AFGzoR2iTWR6cbGnH2
 vFFyhFInIczk-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Wed, 7 Aug 2019 22:43:04 +0000
Received: by smtp406.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID a922c1f55dc5f6c930e3c4333b468534;
          Wed, 07 Aug 2019 22:42:59 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v7 05/16] LSM: Multiple modules using security_ismaclabel
Date:   Wed,  7 Aug 2019 15:42:34 -0700
Message-Id: <20190807224245.10798-7-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190807224245.10798-1-casey@schaufler-ca.com>
References: <20190807224245.10798-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Correct the infrastructure logic calling ismaclabel hooks
to reflect the yes/no result of the call. Instead of the
usual "any failure is an error" this hook uses "any success
is success".

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/security.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/security/security.c b/security/security.c
index 87cb3562646b..13102d16bf2c 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2212,7 +2212,12 @@ int security_netlink_send(struct sock *sk, struct sk_buff *skb)
 
 int security_ismaclabel(const char *name)
 {
-	return call_int_hook(ismaclabel, 0, name);
+	struct security_hook_list *hp;
+
+	hlist_for_each_entry(hp, &security_hook_heads.ismaclabel, list)
+		if (hp->hook.ismaclabel(name) != 0)
+			return 1;
+	return 0;
 }
 EXPORT_SYMBOL(security_ismaclabel);
 
-- 
2.20.1

