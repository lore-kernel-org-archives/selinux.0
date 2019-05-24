Return-Path: <SRS0=UID1=TY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9120C282E1
	for <selinux@archiver.kernel.org>; Fri, 24 May 2019 21:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A21D521850
	for <selinux@archiver.kernel.org>; Fri, 24 May 2019 21:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="gY1D7R5l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404265AbfEXVwN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 May 2019 17:52:13 -0400
Received: from 48.23.240.77.static.louhi.net ([77.240.23.48]:36278 "EHLO
        kolttonen.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404176AbfEXVwN (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 24 May 2019 17:52:13 -0400
Received: from 34-41-5D-CA-59-C7 (176-93-196-243.bb.dnainternet.fi [176.93.196.243])
        (authenticated bits=0)
        by vcust561.louhi.net (8.14.7/8.14.7/0) with ESMTP id x4OLq1q3010766
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <selinux@vger.kernel.org>; Sat, 25 May 2019 00:52:01 +0300
DKIM-Filter: OpenDKIM Filter v2.11.0 vcust561.louhi.net x4OLq1q3010766
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolttonen.fi;
        s=mail; t=1558734721;
        bh=HI+scW3lnvLLst3Ph0gZHyxvXAFliSD8b9OA9ssI+LU=;
        h=Date:From:To:Subject:From;
        b=gY1D7R5ltyqztz9Q4Od2xvly67i+SyGAGfypeNqGgA5K1cgAKUFvKWCcg4/jECmu+
         6ZGlVZqGRBQ/xNZwJVNX35GqrAPXGnWaF4WUxWW0Y2tDj9VqiJHHTbpaYlffvzF+5g
         zAViNlJlm/T2tNLJ9DGP+hsAUr8HboD8bvsKcOXK0roBLG0/PoL2BP5BO4m42Of4Gs
         biHRemLXKVD65NcJUwdQufIIEdWSIbg4N6x9v2LeI9BszyRBnIACnl2ibML3TeyPXi
         GDOafXpRO1txzUbZ9mAEgDuj8w+2cxR7mLnYYgyeoCa5g9mWTqAPF0DfEP86Oa9Yov
         fubAlC5t6z6Sg==
Date:   Sat, 25 May 2019 00:52:09 +0300 (EEST)
From:   =?ISO-8859-15?Q?Jokke_H=E4m=E4l=E4inen?= 
        <jokke.hamalainen@kolttonen.fi>
To:     selinux@vger.kernel.org
Subject: [PATCH] More accurate error messages
Message-ID: <alpine.LFD.2.21.1905250050490.11289@34-41-5D-CA-59-C7>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


diff --git a/libsepol/src/services.c b/libsepol/src/services.c
index 303a138c..3758436f 100644
--- a/libsepol/src/services.c
+++ b/libsepol/src/services.c
@@ -1134,13 +1134,13 @@ int hidden sepol_compute_av_reason(sepol_security_id_t ssid,
 
 	scontext = sepol_sidtab_search(sidtab, ssid);
 	if (!scontext) {
-		ERR(NULL, "unrecognized SID %d", ssid);
+		ERR(NULL, "unrecognized source SID %d", ssid);
 		rc = -EINVAL;
 		goto out;
 	}
 	tcontext = sepol_sidtab_search(sidtab, tsid);
 	if (!tcontext) {
-		ERR(NULL, "unrecognized SID %d", tsid);
+		ERR(NULL, "unrecognized target SID %d", tsid);
 		rc = -EINVAL;
 		goto out;
 	}
@@ -1170,13 +1170,13 @@ int hidden sepol_compute_av_reason_buffer(sepol_security_id_t ssid,
 
 	scontext = sepol_sidtab_search(sidtab, ssid);
 	if (!scontext) {
-		ERR(NULL, "unrecognized SID %d", ssid);
+		ERR(NULL, "unrecognized source SID %d", ssid);
 		rc = -EINVAL;
 		goto out;
 	}
 	tcontext = sepol_sidtab_search(sidtab, tsid);
 	if (!tcontext) {
-		ERR(NULL, "unrecognized SID %d", tsid);
+		ERR(NULL, "unrecognized target SID %d", tsid);
 		rc = -EINVAL;
 		goto out;
 	}
