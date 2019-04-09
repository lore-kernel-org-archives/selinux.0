Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD9EC10F0E
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64A1220833
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="NKxlku0g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbfDIT75 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 15:59:57 -0400
Received: from sonic301-38.consmr.mail.ne1.yahoo.com ([66.163.184.207]:45464
        "EHLO sonic301-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726629AbfDIT74 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 15:59:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554839995; bh=fnJcv2J/MrzRf8h1makEn2/UWDvYNR2yTG2TfGic4Xg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=NKxlku0giK8evWYM9DtaeAAFKlgUbQzCGaUjW5QrtcxXxJ1S1S6JnwMNeEvboVrwYD4Iv/x9DIo/eYxvKAgucNGAJzAtpKtajxR8uV0zzWng4NvevuzDFLi27tYqv5lURnxyu085+c7MqA+OSLZdAl8koLmFar0ycH64ftn04Zfld1mOeIWniX3TPw5Fyqd1pxXsZOWqgBAiId/wjfq//qRhECKlNEYicFKFcux2AsDaG2MlCLDskfxCKHTj4ZTiVp8htLy3tObilwg9QeIb00Vid56lmySM0fFUySR3lN2+rCj12pufDli+x2ZiX6b88tuVjv/ikDcOzF41Xy82iQ==
X-YMail-OSG: v4bt42YVM1n3quPRqRucVkIAzkHs_NhJTiMTLvmwn.31U6O6RK57tlCh5GBpJJH
 d3VehZojSkeLTGuvO2OxDHrf1Xyj5rN4hxbYeVfgCEfbceJomNtmJnT5o_IXd6SPxseEjPXfKnvU
 DcIY2Qbaf7MoeTkzDnsG6g9SHsx5BB1MsVqhbDJ6jgqLLLkYDNjih7u6r7D6ChLg_dd4YV._wUHY
 cTGrMMt_Jy8SMR7nqCFREGdh4lQyJvG4wwlQOCXsT5OdWMXTmJdxkzaRNMlQLgThwAuqCBTEHDLi
 F6UVilk9Owc2AdYSP2GoUVMzwoYOdrRCZmTvATFoPeKvN6KfYaIqTnskIny0uBlO5.nUhSTlC.ds
 G.fvSq8Vwsca53B5Y.Q6i9m5VamzYrh6d889rTtEGxIHMRa.HEEEtFYzaOq0BiooQFdd4B494kao
 QagXXqZolhcaGjGTa_17BAlnmGOTUetvbiq_hqABeSyAPnVx5sh2lCP4uzlV3_L6EllPLUB7fd0b
 W6bIrASecPDxXGevIKNRNoJvP9FwQlS3coP4nr8ZJSk_rJXVS9ax_3THGlHp95x_J8nCRq88q91u
 suuO.ttxy8gJpiU0hGjHZoD8UfgdG.JlGIPlmDwuXl0DPswyCVeFa2oWhH7UKADSavjpXwETL1k.
 jt6WtSDNPwUJvo6r_qYw6qXfKpLJUZiLU.22ar8ZkJTUeHf1.DRxT607aEJ43WW9rGnOSHeCHjE6
 ZTPv.dBaGGeZJ5MKp4eZ2iaUTTY6QKfqu8I54UnXnjgq5abmKojPaWqA7pouoKd1SB4XXCMIeT3P
 s_EWCAOrth.6drbIxiMj_gZmTfpt6zNO09HlW969no2JTCunH.pg6gjQfI16Nl5zBQIgjtQRI7Wy
 1HzAtECZaNQcX1difq6x7zPML.CPPegyyQmgBDwTElpNmSCbEFFeuqFP_mnDOHX5n3ucWPMafa67
 bHV51fGtCPCSIz4eGNImI3cl6Z7ziRVEE.CNEi8BZDD9BucHFONnU3iaOmbBTFm4FhL00GpNiRre
 vMuT.cVUKeI5RZ2IG0UanyLBviNDGp3e3cCPQqt3RtBWGlFToYunLrOxdHtTqTlcRqNi3wbfBJeV
 d0ziz8GHcoVe01yi56qWAh6ACpq5DrtwwdKh0w7fat5PnYtpDLst6rl2ctyU-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 19:59:55 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp430.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 552806e231f63bbc1dbaec1014ade557;
          Tue, 09 Apr 2019 19:59:54 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 11/59] LSM: Fix logical operation in lsm_export checks
Date:   Tue,  9 Apr 2019 12:58:36 -0700
Message-Id: <20190409195924.1509-12-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409195924.1509-1-casey@schaufler-ca.com>
References: <20190409195924.1509-1-casey@schaufler-ca.com>
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

