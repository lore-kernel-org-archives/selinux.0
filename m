Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C86C10F0E
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 20:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84CEC2084B
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 20:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="DPXmwx2x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfDIUAf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 16:00:35 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:35849
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726784AbfDIUAf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 16:00:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554840033; bh=fGxfp/CN22PmumS7bLwAFMtRgSd8WhnZOIiNQimjmvQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=DPXmwx2xt4ez9iiFeWQL6QtgsKqj4tJxhAGFjX2dsSVaHqv/GLFdwV5uWMkTI1sgD3zpNXktOUJ8YSGPydslNFGGnjvD9IfI8B//GuxopOVIBcTV8Q/34f4kXkbrDAODTaX70Kb9MFzRuuBE21hFbK2Kai+SEQfFCGdYZKgDqoFZ/nRk2WKHbdsqNkjg2P13ZS0U54ODYOIBxKzsXXO+DwB5KKxt95XJB1QvwMwdKmyPFnBqe/K+AL8atJz1CjxmTVpDWO9uJLAZ6gW+uVuqZyXYz9R6HMPPbd19u8Ep9DRHgz+VhFT3Cr1T4iZvTtndVudheU2Yb2ROcT3gWZ0zVQ==
X-YMail-OSG: KAs1KBgVM1mso7r_kJ4FOvi8i0qcv.J7e9If91efrIm0lpwfCYtMMDCHZ_.sKy3
 ev8TW7AAzfy5QW8E2spznbpS8rDRcojMswkzkmxZOggLqlCV.GkQCtQINX0M7gDZwHeeTM0hflei
 oF74bin8zw8nOFNhxfAvkKTLyVHWSBOhqlaq60Z9LlcrR6IMNNaHIPMt3zJZGNw0oQYQ_oXsI2hD
 FSuOEYYbfOZZqgn7HBZ9w6xh7YodPvfY9PKatR_csxTDZdpb3U1s7gIxUlgGZlE7htgPAK6j3mpD
 zKVSkv9tc17FxycXEwGevF9iw6792bLwePBsv_6BlGZv3kmI7gKVTJk8h8bU1aKynAJ9yLtjJPv6
 yPSgvvSAGX6MswGRDlraBvvDuWS5A7_4aC2CrC7vcROdSNhOE0LV9EQUMsff6UyAvKV18O56m1x2
 A6sc1p53M5kr9fAlLVo.cAE9lwcDA_XlXjrnzQUTA4AZUg9HNYYJVVdan5Djn5wEqa2RtlAT7Jew
 qAXpH_9di5x1WO9wiyH7ePhoUND5X6wFduw.VhOKIkYNj8VEZ9.9iWl5eFLpFHcXTaZP2PjhXA5W
 xrE7tZEZIbuV4qY6cSfgLSxR._yXkTFeG5RMDeOtBJImJUaBMY2A23xUNieqYn94.Byul8inTJBF
 Tuvi.yQtYo2GK.wsKdXds2Bo4.AReNRI0BHuq6Pey8y_hV_wewAk3.eYwAD8g9tqM0Ks9BU3pzRg
 FhZ.Dz8DB77Q7jNO7BIdD06hoanUDKWR.sKg9Vvh88E8_7ZVn9muZ25DT8sBST4vt8r5UiT39WMS
 fzD0i9TeBpIgeEYsMxcY7lgOylG1F3EQWPtyUpMU7O8Qkj21cqYs_NPfqg0SWfNcXegnTKzfAvDw
 UowBUqnjF5.zygK90hEIOVAMJA8uuX92s9fnX_pkxzAz5xJr9B4v_R1dyw8rf.nPt76G65PMqMZ6
 1Ktr2V4iPZu.LyPurvBIlyPbgTRXvcSjLL3x1Wgu5b_ap.pyAOzsdQSJjnnwepZ4Ru2.wurJaRUm
 YRXRVt6U8KP0DqesmWmPIdu33iX8Lh0sgv4lJ7moNCQrXBNF5i03D1PZjbdwuSwtG3d22tvBCgku
 JoEpPbwqkGtSryFhrcaaOWYDqSW5wNvYVRjRbnpl9.yJT8bRmORTsOrDCG7c-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 20:00:33 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp428.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID dd207be9b16b6375049b46b06443493a;
          Tue, 09 Apr 2019 20:00:32 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 32/59] LSM: Remove lsm_export scaffolding functions
Date:   Tue,  9 Apr 2019 12:58:57 -0700
Message-Id: <20190409195924.1509-33-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409195924.1509-1-casey@schaufler-ca.com>
References: <20190409195924.1509-1-casey@schaufler-ca.com>
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
index c413dcc1905a..6c44aca19c65 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -117,49 +117,6 @@ static inline bool lsm_export_equal(struct lsm_export *l, struct lsm_export *m)
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
 extern struct lsm_export *lsm_export_skb(struct sk_buff *skb);
 
 /* These functions are in security/commoncap.c */
-- 
2.19.1

