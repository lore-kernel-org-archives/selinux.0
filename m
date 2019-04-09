Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5791CC10F0E
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2878C2082A
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="LF+BYpqo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbfDIVkr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:40:47 -0400
Received: from sonic317-39.consmr.mail.ne1.yahoo.com ([66.163.184.50]:34763
        "EHLO sonic317-39.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726713AbfDIVkr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 17:40:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554846045; bh=cOt9caKD/749IXNAg082OZdZ8wyzsShJ6Dne6L26IXA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=LF+BYpqoKJrMqE19IIdBfLGQmwaV5qxDfFGBKSluqeKf2jQtPJKP3JkU3KFYFPHQRYWM0r/MwEJpUyl2frlfH5tzqbcbGEnKZ060NZpHH0vqGsPue48T0EJtmp0Xw1lxkTSlNc08J7GLZGwoTeYjhpEagHiFoHjDZugo/cSkOxF3EMVXYxPloZw+U02AvL4PUjd3GyFpmvn8KI43AxF1OKjqoUuVrTEbsBGCy8jb1SD+xk+nm8oq4L2jvyCLRpxh6IZ0BI0Uf1/gSLTY3YMtX+atM2w7147Q6P7HKIcbvoVcRPB8uhF424ZEm3w+YZljlyaDV9iLuqh93By0E/VLdA==
X-YMail-OSG: TY_BuJ0VM1k2_9KaJoa9yxP_t3enDIJBjDjdiGANZqEf3XOIXPmso82VdA7C3I7
 WgVGLxJuKqypJ5.JRki9ACB5m8qJMDRneHr7tnUloNPLTcuKLeLLnVbSS5TKBuq5pLv9b6VDtSwm
 5mGFroe_5uku4XFSnw9Id2ygShLr465dwYOwJiKN6vUzerXHrNl86CcgXRrGpBCOqgtYcZgdraKy
 Xs2oeq7UDx56._tI6B15lUh69mBYzX3o4gsQJBIXa.aiGiGqRJJKX2F8rzrnyHR_UFlRe.7a3tom
 xV3t.BEN6howQ0WGnOApvAIsC6LsUGbd5_c9oQlCZvbm0o0wqOoHNRLDiO992mPDPmbZYq5vFWAs
 MXV.N7CVeNagaBP917LBdO3p0m9TtitYBTfh9ypNB0KaD7RcVoMB70iRjGDhMdPfMwikPje.ZGm2
 mU3EKGL5HOWxo_Br_2w3jDAHiPZpxFqK32tMKMk2GqJzWfshvtDvOAAigejO4vGr55f4.Kc1T84x
 55IyQ9nPYm48ZoQDZa6Zx0P_sCPJdBsUhXYi0ChQ5BkvarVaqmUehL.SItq3Xe3p0XT19MP8g_YJ
 cqridA2ONGQWVyz7GLv1jZDuQLP117tSPsD6vc8fYR.dCVVptUwv8qYrcX9YerMBf6Bxdgz_rpf0
 AWphTuLbCV1aydKHlvjeQfGnOcrHHe5ShCQ6IjQFqsrg1PWxa5_ByipmTEJD_pp21bSPqdRLsb.T
 368K4KB3DToP_P4Twz68mopUoevJUfLnXqKocAKk5f4V4tvwh9GCSHSfORwmL8DaPpKiD5JJ2Ior
 5LvBeEvapEMcgszBJecAX9IHIIhQ7XZUvw.lYZ14sq.j.m.mshLaKuewqgpTzE8bN6rWB0q8G8bG
 YVGLIPm1AOUszl1pQSFoLa70BeCazR9Z.5lLfXL4a1A72FVNGwSd1FK6JVKkrKAZdkfhu4gVZqDC
 v1lYOawpm.KH.DEPl3Q4HXJ2KhvbUCmDrUjtyrUHq_kNEwyQDqZU5K.yjScLHI4C3HPpLd.gwOSA
 Z1lB0ONbMRQh8hYFMiFNWXhtYMBsnoE4BVDqSPDh77avCRQssqI5p5fEKDEcdvaJOaWwcJy_.ctQ
 cinTFK39CQ9Tce4zZk5JB1bnG.jrZnTt_s2o7R3HR2VaBrsIbEUCVn4Me4be5cQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 21:40:45 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp422.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 4c017142cf03fa35170466cff726262b;
          Tue, 09 Apr 2019 21:40:45 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 33/59] IMA: FIXUP prototype using lsm_export
Date:   Tue,  9 Apr 2019 14:39:20 -0700
Message-Id: <20190409213946.1667-34-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409213946.1667-1-casey@schaufler-ca.com>
References: <20190409213946.1667-1-casey@schaufler-ca.com>
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

