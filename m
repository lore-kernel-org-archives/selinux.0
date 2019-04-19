Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51879C10F14
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F4C921736
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ZSYIbuXF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfDSAqu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:46:50 -0400
Received: from sonic308-9.consmr.mail.bf2.yahoo.com ([74.6.130.48]:43583 "EHLO
        sonic308-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726700AbfDSAqu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 20:46:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555634809; bh=fnJcv2J/MrzRf8h1makEn2/UWDvYNR2yTG2TfGic4Xg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=ZSYIbuXFGG+JolKcL/W7FwdpF+1waY9wl1aPF9SaTMJUWJ/dpvHp/rSylOSFODSN0OiIvY+kin10wfzkWReMhmm78NgWBZ2DLraKJfBhFINTB4qrgt15DeO3acbNCtZJGk+Ft5db63xj+vfl9wKesuKEzYnGcFwPuqQQuM6msq3j5Gm5+wSMLm2RQSQO3JL/fkt7l4YpBDQs4fV/M4ImqbLVrlwtpWKkJ16tZaqt7MJDNJX4kEYEFZa2nKsUOCdbz+1XJuj2RT2vfKEyOkHinslbRx12MBpMyAeT8CqP1uJmvYDE38KXDvt4N8YhWaUdgW1QIoIH4lIZcipWW1lWPw==
X-YMail-OSG: n5yrI3IVM1m1pu3Mbixin4888ypnqzAKlalCfwV0e4Zlk2n9r7NcVdPObLO.FcD
 6w4osrtEky4lfTuWqmbhEdn8G7.ZLIuXyhGI_qaCprLUQvVflCV4xL.Gf5EQs0QwaKVteByEaLi6
 .hvFAYWCsGelKVL1b7.ol0FgnCV.wIuNrNbv01CEXKNYT8PtaEetKFDrVW77pJAAk.EEEElccwvD
 OS7fxyATGMYqpOY1TC5FdyMDKXSUPy46IKKMQouFhqD2GfDt9uYLYSKQQAqnG4ZyQYyZO5fSlr3O
 hVltNSF3dbZmKcqlBNieobJ7ea_4royHRlshjez2xbBSb4BpdNnuljPRymC75SrpnYamz4O7wgIl
 I2AfjK.UxkLkQuRw7KUdgv0.YJ0nm5.R_2LOyxwuYrZckjCe.0TPxnjxabfAkT9CxMxybgVzynMT
 ezr1Tp_FPMKphkTE51UH4tinpAb8AycUDQp_fxxpmO.h67FJqyeM1yaQRNJt7l07YsHy1JTYsw.u
 dFzvdbhpWQ0YWcwBdkYgJ3fh7NHaNunFnM7u5c437eRcGrUmFyWKFYDmmnQsIpuACeKLo5ARWWPj
 7vaMAf1YThkH13rjTDZ1iXEL35.B2fewdFBw2rWcuOf1AgoGaZy3naLOQglNaQx8DPEZPApZj5oT
 mpHctxtWSgSiqJGl2IdB9mI0QKLnOy1HMNYaPfBoO_Dola0bprKog0QcQByLuzVSCnher4lXtEpt
 j.Xg.zZD8aGYKfUuhG6VlZrTmT7H6Nr5hfu66UGN640p_zHaVRH_9Kj78DpMJg_U0o8kXuCQ34Uy
 Ps_9ut6EQOcboS1urys0cMmkU6HC7S5.Pu8vqBrhAas7ReW1cxP9g.qqFj9v1Nx0z_0zNKRkQSGF
 BkS3YKqcA7RvCvYgVMHfHVV3aqfMIlY8EO5RtiIyyMJIAsGiWhzj6cx5ECNCpB0egLe9ptFGWn2.
 EG.PsVYJ_Z6jwIBtkpoUaD7sTicbkNGlj5VSVCz3EodsR2j0AX2VIRbPuwhMT1pIE7ZSqgRcMrGu
 dmNZd7gqZOoFl3TuNy75RyvqINWGaysc2HT9FFWUu41btYwKY0MBaanBVDMavBqjeCVrKVIZojZ6
 HSo_7gk1T12jv8OtK7y16ksnfhmuEGu6xjWxIqXmp2VRlVmVfsb2kA92B_eXS7A--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Apr 2019 00:46:49 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp430.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID db33df77ae90d094534f9c2fe92816eb;
          Fri, 19 Apr 2019 00:46:48 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 11/90] LSM: Fix logical operation in lsm_export checks
Date:   Thu, 18 Apr 2019 17:44:58 -0700
Message-Id: <20190419004617.64627-12-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190419004617.64627-1-casey@schaufler-ca.com>
References: <20190419004617.64627-1-casey@schaufler-ca.com>
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

