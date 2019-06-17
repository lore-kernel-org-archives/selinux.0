Return-Path: <SRS0=LfCf=UQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93390C31E57
	for <selinux@archiver.kernel.org>; Mon, 17 Jun 2019 12:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C00B20673
	for <selinux@archiver.kernel.org>; Mon, 17 Jun 2019 12:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="KypmUyyQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725826AbfFQMCn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 17 Jun 2019 08:02:43 -0400
Received: from 48.23.240.77.static.louhi.net ([77.240.23.48]:35458 "EHLO
        kolttonen.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbfFQMCm (ORCPT <rfc822;selinux@vger.kernel.org>);
        Mon, 17 Jun 2019 08:02:42 -0400
Received: from 34-41-5D-CA-59-C7 (82-203-159-32.bb.dnainternet.fi [82.203.159.32])
        (authenticated bits=0)
        by vcust561.louhi.net (8.14.7/8.14.7/0) with ESMTP id x5HC20AI020301
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <selinux@vger.kernel.org>; Mon, 17 Jun 2019 15:02:01 +0300
DKIM-Filter: OpenDKIM Filter v2.11.0 vcust561.louhi.net x5HC20AI020301
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolttonen.fi;
        s=mail; t=1560772921;
        bh=iBapWBlFAC8uEhXMaDlu4Wm2rq2P36qpR8UPcFVZw/c=;
        h=Date:From:To:Subject:From;
        b=KypmUyyQc8KCLQ9L3A+xmz5cgCJOQolwLIIO9Atul4vX5PxIl+ywMdJQ/DxX5GWrO
         XvXCDVcKgXbd7d/C+0qkuWBAmpq52wwrObuJ8qXty3hPF15/B2RH26GX/xDJuY9x9d
         2CAEL2XMEKUDo2HkdgsZ1/Kf9hhAM+wcjASUCTmW+8WWowYnVHLGQ05LDhpkXEcoLj
         utBROU2I9DpOc/YLd6Xc0LUNuDSs1NfQh9p9hbD6TgdqgJRtTK3S5brBqPAZiiDyEA
         M09Mgdces9CCu1YVNxpTX8mNmjpzYOAouF+CRFCnIbfN59/J1Z8vDQyyLWvVUzXW6i
         SUSA66YkiSuNQ==
Date:   Mon, 17 Jun 2019 15:02:39 +0300 (EEST)
From:   =?ISO-8859-15?Q?Jokke_H=E4m=E4l=E4inen?= 
        <jokke.hamalainen@kolttonen.fi>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/2] libsepol: Replace constant with sizeof()
Message-ID: <alpine.LFD.2.21.1906171502130.6467@34-41-5D-CA-59-C7>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


Replace constant 18 with safer use of sizeof()

Signed-off-by: Unto Sten <sten.unto@gmail.com>
---
 libsepol/src/kernel_to_conf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index 5fb4e838..930bafab 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -448,7 +448,7 @@ static int write_sids_to_conf(FILE *out, const char *const *sid_to_str,
 		if (i < num_sids) {
 			sid = (char *)sid_to_str[i];
 		} else {
-			snprintf(unknown, 18, "%s%u", "UNKNOWN", i);
+			snprintf(unknown, sizeof(unknown), "%s%u", "UNKNOWN", i);
 			sid = strdup(unknown);
 			if (!sid) {
 				rc = -1;
@@ -2376,7 +2376,7 @@ static int write_sid_context_rules_to_conf(FILE *out, struct policydb *pdb, cons
 		if (i < num_sids) {
 			sid = (char *)sid_to_str[i];
 		} else {
-			snprintf(unknown, 18, "%s%u", "UNKNOWN", i);
+			snprintf(unknown, sizeof(unknown), "%s%u", "UNKNOWN", i);
 			sid = unknown;
 		}
 
-- 
2.21.0

