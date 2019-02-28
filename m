Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E34A3C10F0B
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD2652184A
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="fc49QvBG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbfB1WT7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:19:59 -0500
Received: from sonic309-27.consmr.mail.gq1.yahoo.com ([98.137.65.153]:45945
        "EHLO sonic309-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727920AbfB1WT4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:19:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551392395; bh=vscZ9YAV9EYGaY9d6eksjc998gZocceOZ6hh36Ogb+U=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=fc49QvBGrqxBift7F/nNzrZYVIFx/3EdTE9MNiIQ+/sWIBT2xZlFdKuSVMbPJhoPsXEFGrL2GX7wQNdFcudj06z5MTzoppOaE70yFoOxtknUKoNtjuA8qjAanI5C2zLkSPQJXD3ywWfoUWLXtMsXw3cwxJ32Q0m9jbbdh9TDyNTZdQlZSeCL/6hXCq8oUFsTt7TsZMFe+4g0Ls4RI/2Z6uLGOKwVfHTdeUbcZYwnJtm7ZP9oga56F4Erme1bJmvz/Y8e8VvDDvK3n26bhRhv2S3o24uNr6SPJjOEOat5E6T79F0yLBPE4WrJ5mtySEEapSK3HlqzleuMKcEBAtVlNA==
X-YMail-OSG: MkDa1esVM1lvwGe6uDFUyZYvjxp199A5he5kesVstAaAJHnee_Rhse0TKQn9ONw
 dHXTmjXiowbDAAxhpbp4pIgCIpNw9RuJjR9ecR1q_wHTi6VKVNo.Zpp0jclbWwF2kvXTlMFxsXRU
 eH8r8fpMOYHO6E07wp46P19LJCzbZE354jaEMjAuj3iEwOVpOSOH1aHr5ZkY4VDSr.79eRosbOzR
 NRbd19Gv53V.AFjmyhZ2buWGHEkfMNRdg1EdExLwyOX6j1ABgAKU.cBXkrTqu.9EbaJMPBWPK1Pt
 sWdv4piY_972GGXKAaHJhAi_B7PAauMTvz0WEZhF73ysVxYOt8EzaqyQpbtxMPJjBQQsQ.MANJ4z
 Iyt9mf.IKItWQBayJKbw8hZNWlEUrmVl807ogCmUxLveTIJ98FSXU6LeJkB52uWsLD6pqrImqIAe
 0TYZxlsA5t2mhFdzlEoCh6moOz8cQAcN4ZyHdOBmzbK6VULLVdg79zZgU4nR3.oq1ekfgQn0aogh
 C00iDxnbgjS.fPLltKWha6ottiZW29Sl74TVNB3UhD7B2fUB4rLh2HmP9S1vQ9Ep6uxFXfm3ky5a
 KDfvZYiwxwKVQTfew9OqTLpZhssrp662iwzZ_I3sVO_BI4GyObm46Le4Ci0xle3j1PRQThO26cwj
 rqa6_YWB27rHU5reI2BxiW_fsplQIJ1ZsCOZvHkiAaKTtVn1SK7UURxKXqxF3mV.mPisXOWCDfIk
 VUQsQ4h6bwPQek3A.9Rt4TOXSUCrqixRMQDH_92X8F8E9FBV9cjDKXytE719Awp98MJ4m_Gek7oc
 MM4BORzYnH3NHidyde.EOCXRz7w1bhvzPS1s2FMPTlEdngxNLVzSjelZ7sbGHvNwHm09cRjtyqZC
 6LEDFIun52sDU2T_xIAfwBuCpcaUpOtNO7B.CL7Tzlk3oINRN7Pgxf6PauYYbMaZziVDAjrgnWIl
 ZoyG0UzMk1i07eV4rfGN3AqOU4QBDkSlU2EEiNC1mrKWOMaizLwQEnnKYk2KuG4GHANSfylYa5N8
 olcwN3z36_hwOaWNxcFXASUjt87dzOT6XbdsXOsISDk6Om78qbWVP0kb_v0KWzgIzo2eVCqAs98v
 _IsvnKX7JfrC5YD9RVJdkofEnjJHswz_yIu3wSvuXFAFCFg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Feb 2019 22:19:55 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp427.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 0da9962b364e649f4905df2b440bd211;
          Thu, 28 Feb 2019 22:19:51 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 14/97] LSM: Fix logical operation in lsm_export checks
Date:   Thu, 28 Feb 2019 14:18:10 -0800
Message-Id: <20190228221933.2551-15-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228221933.2551-1-casey@schaufler-ca.com>
References: <20190228221933.2551-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Fix the logic in Smack and SELinux when checking to
see if the secid is included.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/selinux/include/objsec.h | 2 +-
 security/smack/smack_lsm.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index d7efc5f23c1e..59a3b1cd5ba9 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -61,7 +61,7 @@ static inline void selinux_export_secid(struct lsm_export *l, u32 secid)
 
 static inline void selinux_import_secid(struct lsm_export *l, u32 *secid)
 {
-	if (l->flags | LSM_EXPORT_SELINUX)
+	if (l->flags & LSM_EXPORT_SELINUX)
 		*secid = l->selinux;
 	else
 		*secid = SECSID_NULL;
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index d26a5e77a92c..a1a9fdd3f1c7 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -475,7 +475,7 @@ static inline void smack_export_secid(struct lsm_export *l, u32 secid)
 
 static inline void smack_import_secid(struct lsm_export *l, u32 *secid)
 {
-	if (l->flags | LSM_EXPORT_SMACK)
+	if (l->flags & LSM_EXPORT_SMACK)
 		*secid = l->smack;
 	else
 		*secid = 0;
-- 
2.17.0

