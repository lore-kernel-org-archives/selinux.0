Return-Path: <SRS0=L/M1=UM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD9FC31E49
	for <selinux@archiver.kernel.org>; Thu, 13 Jun 2019 16:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2872920679
	for <selinux@archiver.kernel.org>; Thu, 13 Jun 2019 16:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="gCvh3J4y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730250AbfFMQAV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:00:21 -0400
Received: from 48.23.240.77.static.louhi.net ([77.240.23.48]:37868 "EHLO
        kolttonen.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728066AbfFMQAU (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 13 Jun 2019 12:00:20 -0400
Received: from 34-41-5D-CA-59-C7 (82-203-159-32.bb.dnainternet.fi [82.203.159.32])
        (authenticated bits=0)
        by vcust561.louhi.net (8.14.7/8.14.7/0) with ESMTP id x5DFxiNN030743
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <selinux@vger.kernel.org>; Thu, 13 Jun 2019 18:59:45 +0300
DKIM-Filter: OpenDKIM Filter v2.11.0 vcust561.louhi.net x5DFxiNN030743
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolttonen.fi;
        s=mail; t=1560441585;
        bh=7esMgPpTrLfZWdE5aLB3vP85piPp/kAwX3li/gGK5Dw=;
        h=Date:From:To:Subject:From;
        b=gCvh3J4yd1YDscIio0TR20gmKs9iKwBA1QDIu4TBDlY1OR4edzrfj85iKpyQwCnkE
         vxVE9UQK5F6m2uvYEo9XIizmObVb3cAIwpsZPXRfjXpCqxtA4UossV4oEwQK5iY4t1
         rtFx2EY4JcDbHcm4JCK8Epr8Ecre5Dqul6BLB896qZB36EqonXIJLkdsLJ3erTUUB/
         K9+pNZO/HoCp+ocH/6D3T7Uh97Re6OdpYca6tVCtq23BXgVmztLTW9XS89U4nZYcT5
         dOZrBDLTM1lPC+OmyHkBp+yGXDkPiQ2chUlz8P1nZyDZuFqXYWv/edBOnhjPRpbt1V
         K2PrQIS6jwaLg==
Date:   Thu, 13 Jun 2019 19:00:18 +0300 (EEST)
From:   =?ISO-8859-15?Q?Jokke_H=E4m=E4l=E4inen?= 
        <jokke.hamalainen@kolttonen.fi>
To:     selinux@vger.kernel.org
Subject: [PATCH 3/3] libsepol: remove unneeded int
Message-ID: <alpine.LFD.2.21.1906131859430.5703@34-41-5D-CA-59-C7>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


Replace int ret with a constant 1 because it is
only used when returning from function and is
never modified.

Signed-off-by: Unto Sten <sten.unto@gmail.com>
---
 libsepol/src/context.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/libsepol/src/context.c b/libsepol/src/context.c
index a88937fc..e81b28c6 100644
--- a/libsepol/src/context.c
+++ b/libsepol/src/context.c
@@ -38,7 +38,6 @@ int context_is_valid(const policydb_t * p, const context_struct_t * c)
 	role_datum_t *role;
 	user_datum_t *usrdatum;
 	ebitmap_t types, roles;
-	int ret = 1;
 
 	ebitmap_init(&types);
 	ebitmap_init(&roles);
@@ -75,7 +74,7 @@ int context_is_valid(const policydb_t * p, const context_struct_t * c)
 	if (!mls_context_isvalid(p, c))
 		return 0;
 
-	return ret;
+	return 1;
 }
 
 /*
-- 
2.21.0

