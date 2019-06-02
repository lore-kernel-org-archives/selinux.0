Return-Path: <SRS0=/A+P=UB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FEB4C282DC
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 051F32794D
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="fmOzxFWV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfFBQwz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 2 Jun 2019 12:52:55 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:43115
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726994AbfFBQwz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 2 Jun 2019 12:52:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559494374; bh=gEWZCQzFlqcooAYwsHr2Nt701eG0L+I40RIrEVg4i3g=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=fmOzxFWVFWJg0d7+w8ZCOEzSMh6ci3AY81F2UlbLYeODgRxTtkK2ZaIhr7KjD/boLeWreTFeqgg4twj2XHUdVbHPalO2gimBpQxWPFFIo/CxipUvetQDNXGambsmjmtFpRqnfExl8Z9BZIPSpmZuCXNsxMg+5fsDP3Wm9+ZR0RThLYg78KWZ4hRsbA0rmeVid9a0S4rLNcIPoomY3TNjl7Zo5hSgURyv+gtwRilvlQEQQSvJQP0yEByhDplEM4rpzypdDkOqQ3ARsNhfn3xK2556fwD2dvnstqVkBHckV+IjRSYe4abaoZhDhla8bijQKSo3FGodssGTYp7ntrz6pQ==
X-YMail-OSG: g0MlfR8VM1lehV9zPXYdUiJ3UQQp8wDqMmpq9WmNFhgnPYjuDBWpZZ7DAV2KS5k
 YAJJ7i7ESfKQsjGeEcVNy2RtGPfITohxrVlyw8XKTO5yhcMv90S44njieh4myXjA3nuFDsKo00z5
 5D9K81X8DI0LMXKJkcfsqFYbRJlg94pAyfEumMn91C1WGGf7wVm1Q9BUvTonA_XlTU.NEvdw6vVI
 nstPsV96ZTw9ihUdZzMgQlNIkLOA1lusp.sKlKT0yaqWYFkGF.o8rqgrcaI2Wxbjj3fHrArCa_ER
 SH6nvFuNW.dVZSdvGNlTLZ00lEqIom2I63KhzmaCCLUc4bF8gpHittOhqvIGwsvfGbsR_xl0zLsm
 _VVnJheF1NLN1F6BUUJ_Hm1HYtG28crmajThjpIkEsbTiGkK90_HODxCj1Lwmd8zeQnwAPOdvrnf
 hHSNx97daDR5Zg2v3b_ONFh7.dwofTBKFjDUsSL4lShFNbG5oU.RnC3Fz_ylXVkBDiIuGuGrPAWk
 LRO82DOrZ4GChIyg8vH3ApNB200ze2wYF0ktgiYuVnl6oGZcvsmN3vKyQt6Q0ZMS0rgCzmHiqNTO
 1eOfP_i0cjk894R_CjjavnMv8inL_LlTmB5vykXMMQO07m.vldmBP9g5gcpUMCRAyt5JSZ13J7AM
 BD7RAkOmDf9s2w_I10FhfyOByIPoJf5MBJDilR.gl5.7_JfhZKsx5HCKXy5jg_dFIsZqTnpSdTRm
 CQzj7mIaPehV1g2wmMogfbcCz..PpyKppnIVokoE5GGY8FM2H3prlsoOEoncBVRNWouDEx4FwwCl
 K7pl7sxxzjh1LSPVoqtFF1ynlwivHoohW_gOsfugNBg1Q3eU0NpB5QBEM_Z29eFHNXqxVE_waVyC
 7O5BvhDy22dMaFnNjCrc_W0TbskJ.FByOuUZQE.wR26CVC2Ar8mzkNBPXf.udMT1z2TDDUEr60Xi
 7r1K7x2pkgwwLlM56DhvaASEIlPlj6JNzOGYjIikIe7fNA_hu0sWdL6NpEwoOdCzjz1FbWXocuP3
 iCktmW7haCnQkkh_4LZVM2krlJri6dUxKE1ned1APM7NW2Z_0HhYATF29fJvl5lwWgDKRkDuQI_H
 P7QBkUNLCm4.kqqLpDqiINMsGMtgqljaY.AZPW6P4ovRgfsSwHWIcJKuz.yM3wCIYSY1fw4ckAMp
 nvVT3GxdSkqkcHxmUUck690vB7lREP53jGMHs5CK._1F5rYbHkOgqkg_qr00bsYSJAV0A3QHGp4p
 xVpvVMA35YWPOYBvUw1E4d69gl1GG2CSL9YJPlA4AROCzOQEW_v3zAg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Sun, 2 Jun 2019 16:52:54 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp409.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 0c0e3da8255eb26ca342a489fa1b8a19;
          Sun, 02 Jun 2019 16:52:54 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 31/58] LSM: Remove lsm_export scaffolding functions
Date:   Sun,  2 Jun 2019 09:50:34 -0700
Message-Id: <20190602165101.25079-32-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190602165101.25079-1-casey@schaufler-ca.com>
References: <20190602165101.25079-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The scaffolding functions lsm_export_secid and lsm_export_to_all
are no longer required. Remove them.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h | 43 ----------------------------------------
 1 file changed, 43 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 9d8115b3d679..dde36e850cf0 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -116,49 +116,6 @@ static inline bool lsm_export_equal(struct lsm_export *l, struct lsm_export *m)
 	return true;
 }
 
-/**
- * lsm_export_secid - pull the useful secid out of a lsm_export
- * @data: the containing data structure
- * @secid: where to put the one that matters.
- *
- * Shim that will disappear when all lsm_export conversions are done.
- */
-static inline void lsm_export_secid(struct lsm_export *data, u32 *secid)
-{
-	switch (data->flags) {
-	case LSM_EXPORT_NONE:
-		*secid = 0;
-		break;
-	case LSM_EXPORT_SELINUX:
-		*secid = data->selinux;
-		break;
-	case LSM_EXPORT_SMACK:
-		*secid = data->smack;
-		break;
-	case LSM_EXPORT_APPARMOR:
-		*secid = data->apparmor;
-		break;
-	case LSM_EXPORT_SELINUX | LSM_EXPORT_SMACK | LSM_EXPORT_APPARMOR:
-		/* For scaffolding only */
-		*secid = data->selinux;
-		break;
-	default:
-		pr_warn("%s flags=0x%u - not a valid set\n", __func__,
-			data->flags);
-		*secid = 0;
-		break;
-	}
-}
-
-static inline void lsm_export_to_all(struct lsm_export *data, u32 secid)
-{
-	data->selinux = secid;
-	data->smack = secid;
-	data->apparmor = secid;
-	data->flags = LSM_EXPORT_SELINUX | LSM_EXPORT_SMACK |
-		      LSM_EXPORT_APPARMOR;
-}
-
 /* These functions are in security/commoncap.c */
 extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
 		       int cap, unsigned int opts);
-- 
2.19.1

