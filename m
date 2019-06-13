Return-Path: <SRS0=L/M1=UM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48014C31E49
	for <selinux@archiver.kernel.org>; Thu, 13 Jun 2019 15:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17EC420679
	for <selinux@archiver.kernel.org>; Thu, 13 Jun 2019 15:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="0xAxUTEb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732645AbfFMP7H (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:59:07 -0400
Received: from 48.23.240.77.static.louhi.net ([77.240.23.48]:37830 "EHLO
        kolttonen.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731464AbfFMP7G (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 13 Jun 2019 11:59:06 -0400
Received: from 34-41-5D-CA-59-C7 (82-203-159-32.bb.dnainternet.fi [82.203.159.32])
        (authenticated bits=0)
        by vcust561.louhi.net (8.14.7/8.14.7/0) with ESMTP id x5DFwTCR030721
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <selinux@vger.kernel.org>; Thu, 13 Jun 2019 18:58:30 +0300
DKIM-Filter: OpenDKIM Filter v2.11.0 vcust561.louhi.net x5DFwTCR030721
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolttonen.fi;
        s=mail; t=1560441510;
        bh=kFIqmoF1y1FmmcCtfN0cG3SJeQ30V50WPy1BzAZ1ND8=;
        h=Date:From:To:Subject:From;
        b=0xAxUTEbr/NHASNu05SC8o8GfKLJJisv9NXUtgh65X5SnhUIVszGBVboWM8F71q91
         SVuV6v+6aFKithbzKiTV70CWyEBmDoH6uiDFaSEG1P3L2UahB3mCcEk2lteU/6IW8E
         rtVoBb2OnJu1j4HGbObMjCRiNHNabJv6NNRzOwl1pagLejmIHArHskLqibeh33BeZE
         17rynwU+E1eGEuJ+0v0fJidQ115Q036q4fFLrE9KMlyrkP295WeTgWvYQyXPIr217r
         yRGSi4VRW5H7x8X+N+XgJuPfn7L3IAJQLNzTFAPZa6tCtzTvJqz6vaPoDWVO0s5SiI
         glS5WMVsOKtKQ==
Date:   Thu, 13 Jun 2019 18:59:03 +0300 (EEST)
From:   =?ISO-8859-15?Q?Jokke_H=E4m=E4l=E4inen?= 
        <jokke.hamalainen@kolttonen.fi>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/3] libsepol: more accurate error messages
Message-ID: <alpine.LFD.2.21.1906131858100.5703@34-41-5D-CA-59-C7>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


When reporting errors, differetiate between
source and target SIDs.

Signed-off-by: Unto Sten <sten.unto@gmail.com>
---
 libsepol/src/services.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

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
-- 
2.21.0

