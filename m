Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413D8C282DA
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09C8B20833
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="DD3MVxpi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfDIT7n (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 15:59:43 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:45328
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726529AbfDIT7n (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 15:59:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554839981; bh=is2u5Y0DRwzBY1W00Se6/XMCwBAVUpvFG8LStFYaqTs=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=DD3MVxpi61CQJoO3GCGRchAGxs7izmslk2ibDSm4ozIMavmsub+uNHeTaXXM9P1onrAP0NI261KRYewI+xaVw23GLYYtbdDCXinA93/dECgDrnYeQkYw163YRlnzFuOdF7FO8a0iVvasluIULRDCydmqxU3xpSoT3B48ifRf26n6vnRCuKytNs6DUzhrhPAsUJdzGV5PePck/tZDZwVGY+k4E+JjrVwzVkzzpRBNP6HXnxVwKl7rSd2LNWDNv1iQgbJ6jddoJdHuQjKcjk7bu6ZnLW2Mkp4q/5/UfTHK02nKKk7clDEYdYhuxeGgTBbfEFClzbmzbheT8xyldoUbUw==
X-YMail-OSG: K.6.TVoVM1nTxt.wSatzSogZTh_fBFvpgEEAU5dbkcsJKy79X2Fxj3yySa_oMO3
 QD5U00KiWSChUYPvfreX4.Ofk1sWQgLbkyeiGLB9REqgdHeJjk52aungfDJuC4NR4kC3t.RCSFMe
 170mnRCd92Dq8igPt5ujGriiT8heExS6zSV4Xk77.nG39AnDp185JgAoyFLc4Kuq4vVbLaUoe8TY
 s44bhAB9ijo0cirS6EcS7fB5eRNPUBGA8PsGXWmBA8JFtN1lLcbKJB6z0fUKAleThuopF1JGDIud
 vMvQ7Ts.uT9qC08Hmr4ZSNITC19jDBZX4URsSaXjKIjDZWBG3RXTmcOEk3KuNKlv9G6OeintgbwX
 mMPriB97aJDMTuA.kdPxg1DZ2EW9TfSi9xu4l9n1AdQXK3dw0m8awtJmA7UCwS0k0ctJnwhAftTb
 do.GWP28lf_VbIQYzngoYd9_xG8WrmBqGZgA6oI6MAuA6pb2iXtMKULC5emr7dVOe41YDbm7FiWj
 dZQN7nbejV1vXB3V3oR_wBZETygD.ynFwsSE0sKq1UT0lJ6IZ5tGe2rvjpVSI9KXU26XU4f4ImtX
 Y02LgCnUPy2gmmlwQDH6wGQ0WG3l0XJYHQ.3NJJY0wJdVFqcdlTMwKegnK9JY3AI.9KezqBjrKZC
 zg5MtDn7Y3wDYSY20_S0m4fR59p8_V0rjSQI2VTfVCyx7Gu3afg_nbde_OliftgKA5vZxCtzKPIj
 x9o8Ux5PDtdeKUOpQ82b42NyH49uhqoT8_6aO2tGA3gQMDuxrOgVSnCQv7zndssXTmz06BBW2LJJ
 _E316DCVw68Zxp2RwrkCIM2OOhr.ZCCLNX.k779Bu1HRTlH8FlAOY5C3YXhao0EHmgBovuoW70k.
 LzquRxva18e4r3aS3Z1BckefzxuOdWMCHQ8IObx7iQ5PEoHWvV1_wbsiIULiLvOH.gBXtCdnSqyw
 XJhjGrFFPAiRcA76sIk7GA3YFc0oLw5Dp_w5dVigzrget35nAHqd0E6xmdg7BC9EPLh8T2QIGA91
 dw5mL9_4zxlQBoBfLLJUymNLhLciUaBbpbTYX_e5RcwncJyC2Rq4BmMVtzwOfZWZQRrcNmR9QNAf
 0j25tH1rEQhecBVG91F2icMpEt.QSpOQop_cnejWdBizs5WUKMuLNrotH.e8-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 19:59:41 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp410.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 353dc739e5c49befbce16148938a824a;
          Tue, 09 Apr 2019 19:59:40 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 04/59] LSM: Create an lsm_export data structure.
Date:   Tue,  9 Apr 2019 12:58:29 -0700
Message-Id: <20190409195924.1509-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409195924.1509-1-casey@schaufler-ca.com>
References: <20190409195924.1509-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When more than one security module is exporting data to
audit and networking sub-systems a single 32 bit integer
is no longer sufficient to represent the data. Add a
structure to be used instead.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index 49f2685324b0..81f9f79f9a1e 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -76,6 +76,18 @@ enum lsm_event {
 	LSM_POLICY_CHANGE,
 };
 
+/* Data exported by the security modules */
+struct lsm_export {
+	u32	selinux;
+	u32	smack;
+	u32	apparmor;
+	u32	flags;
+};
+#define LSM_EXPORT_NONE		0x00
+#define LSM_EXPORT_SELINUX	0x01
+#define LSM_EXPORT_SMACK	0x02
+#define LSM_EXPORT_APPARMOR	0x04
+
 /* These functions are in security/commoncap.c */
 extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
 		       int cap, unsigned int opts);
-- 
2.19.1

