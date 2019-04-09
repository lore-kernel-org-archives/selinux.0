Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA669C282E1
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9D6C2084B
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Banpc0FE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfDITTG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 15:19:06 -0400
Received: from sonic302-28.consmr.mail.gq1.yahoo.com ([98.137.68.154]:45014
        "EHLO sonic302-28.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726711AbfDITTE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 15:19:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554837543; bh=fnJcv2J/MrzRf8h1makEn2/UWDvYNR2yTG2TfGic4Xg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=Banpc0FEiVu1YfmezPMFFO1ACx1VPo4s2E+/WV/yn3SY3dMW06fqnvdz+dsINa63VX19MgY0OMVXteJhiWJ6eccvKLLN88XKHzSeYH0s9w/hGONGZ1mLT61voNw2br/6/y2uPieNYr6JgLWLeee6TU3vAqEq2hIm10YtTUzte2FZQG/ShU67cjPfhu2X1ZRQeQspt+ceheDvPcD4jjCtQsfKfYn0FOYMekW49w9hud8v+PBvwCENSdDFYE5jbVfLdm9L42o6LfkJftDQg/nd1uHeujzRwIQUSYJLn8LEGWpZbKXH9zPUIPcvhjQIHyz+EdhkDevY3bDUp+LMH1XgKw==
X-YMail-OSG: A10j7E0VM1nFMlRT9W7FSsAb1jHUKi56S6SPhMxOPZx3IdxKX5sHoCBJMolS_Re
 Wq1ZeVWoiv1ZJyKJyRhxo2FgR_x2NwYlT2F28onvI9abmqpUK8nrvTLLkvmCcoPcjBkKeLHw5CNM
 bpWx_6U2H9i7alv.9UZPKe2.uaaj33p8EODU_Ent1z6HkTqHQJGxNBopYkpGxoT5d.5llPB98i_A
 iZ8mkjoCnyhup0ApW4pR6ws5BiUjgimJFDIIGwGt2Rwo_nq_xRFoUyioQmxyroC4iiF6.lf.1kMr
 zx77bCdQYfQI8bo.vgc2QT.eFCPjjtWYVeJecfry80lXJspiAOrOWXB4KTG1bOIc.2RZHOVeFet.
 flG1r0SktSQq3RDMWJqlCloytedHF4r.DZI2CEUALwdv_7VRK2QI0m18OFT9TMMnpY7CcrXU.Ssr
 6CAthXRx0NCgNdimD0eeDSue.M1ieZZNO5SR.yQ4LfscPuhhnhjjhp.xGhvtUMJePJHK4ZtY9SPV
 Cn3W8bwDFnlukd537lKyuIDX2hPBn0SM25LV3MSujbZwP7dWPJik7ftAVkg4aMntkTlSgHJLseny
 Lbi7IMRsq3ei7EELBQOUn7gcIlwAgMlunl4I1w.L2lSPje1OIhZbF2qotmh5I7xdo.3GCfUJntAj
 xKczRgcgPKOh.Np5ejSpJBfSZ9O6gYNihBkgET5dHAPoye1KW68edeaeFD1phk8elyHTilJ6MbLJ
 M3maKLRS29kZjjmKn7Faki7ZuO_e9D20LqQfREUMAtK_XIj1SbSShjgT6Ch70n75WQI70cjOik2P
 IhtNCcGdW6udFkxW5C3fCtOj._KbkTc7eoejzgZbePH4K4K6BsiWeH4Dtq14LlRygRnrXD.N2Q.d
 0wrPVMWHOfw.sYDg9KuCrytY9JqhwbyZ2wRh1rV0.91Y0BR1QhzLJjeoku8SYBDmYD3Gx.nI5dpa
 20yyOI4Xij7byRTt.RVWd8SODuwI5L38dsz20HPOmAEr.zuYfg6tbC7XEeJ0kYm5e5QG9Zb83XnO
 bA.2VIhIyP8I2wRLAl4DF8H2RGn6G5uMf6w7Jn9iIZJNnvG778trnfwPUMH9c4Lgb_xlWxCcfEpj
 w3Arx_xsw2uVOTG1KkKDQ.OaMVGysKdRZHtd8AbCmLGFkpnSh9DRuIk4-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.gq1.yahoo.com with HTTP; Tue, 9 Apr 2019 19:19:03 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp401.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 54e8f28a4675c25365c7725d1b772c7b;
          Tue, 09 Apr 2019 19:19:01 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, casey.schaufler@intel.com
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH 11/59] LSM: Fix logical operation in lsm_export checks
Date:   Tue,  9 Apr 2019 12:18:00 -0700
Message-Id: <20190409191848.1380-12-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409191848.1380-1-casey@schaufler-ca.com>
References: <20190409191848.1380-1-casey@schaufler-ca.com>
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
index 0e048c1456ed..a3776501965d 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -477,7 +477,7 @@ static inline void smack_export_secid(struct lsm_export *l, u32 secid)
 
 static inline void smack_import_secid(struct lsm_export *l, u32 *secid)
 {
-	if (l->flags | LSM_EXPORT_SMACK)
+	if (l->flags & LSM_EXPORT_SMACK)
 		*secid = l->smack;
 	else
 		*secid = 0;
-- 
2.19.1

