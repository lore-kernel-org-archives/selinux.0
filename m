Return-Path: <SRS0=UID1=TY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DB3C282E1
	for <selinux@archiver.kernel.org>; Fri, 24 May 2019 21:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FE5F206BA
	for <selinux@archiver.kernel.org>; Fri, 24 May 2019 21:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="KyDAsAjx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404176AbfEXVgu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 May 2019 17:36:50 -0400
Received: from 48.23.240.77.static.louhi.net ([77.240.23.48]:36064 "EHLO
        kolttonen.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404163AbfEXVgu (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 24 May 2019 17:36:50 -0400
Received: from 34-41-5D-CA-59-C7 (176-93-196-243.bb.dnainternet.fi [176.93.196.243])
        (authenticated bits=0)
        by vcust561.louhi.net (8.14.7/8.14.7/0) with ESMTP id x4OLabeC010736
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <selinux@vger.kernel.org>; Sat, 25 May 2019 00:36:38 +0300
DKIM-Filter: OpenDKIM Filter v2.11.0 vcust561.louhi.net x4OLabeC010736
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolttonen.fi;
        s=mail; t=1558733798;
        bh=G1lxI7eAk72Nqx6RICYhHvgbwVxR6IKGSt99Qb4m7+o=;
        h=Date:From:To:Subject:From;
        b=KyDAsAjx6IO9WZXC5W+gkn4NsitoqHeUpPXKmEh1BH+qRK6ISYtLnQ8ymyyz6FOwe
         8VIupSz5s7i5TeAPTiQGlWYA6J9I0/i5NpHCYrDVeeWPODERW/Pkuv//4/MJfXb2F5
         tPpelqALyQvbxmIqVmmfNIQQrNBJ3fTgD9JHeefiGRc5+IjhDx/aloaHhlbDR7LAAN
         HnZtFFaMSk3ywVVNp9EhWybW4LXYQ7gjEsCj2h1MhJl4lrPr8wHfCN3q4TdpxQDx9J
         YINAKiTQkQ2cCAkiRxXLhZtgNQLXprGqt53SEDa0WXWbrUsvLng6QR3kKIs7Lkx67O
         IJw0DYeZEPEtQ==
Date:   Sat, 25 May 2019 00:36:46 +0300 (EEST)
From:   =?ISO-8859-15?Q?Jokke_H=E4m=E4l=E4inen?= 
        <jokke.hamalainen@kolttonen.fi>
To:     selinux@vger.kernel.org
Subject: [PATCH] trivial kernel_to_conf.c checks
Message-ID: <alpine.LFD.2.21.1905250034390.11070@34-41-5D-CA-59-C7>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index 4f84ee8b..930bafab 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -448,8 +448,12 @@ static int write_sids_to_conf(FILE *out, const char *const *sid_to_str,
 		if (i < num_sids) {
 			sid = (char *)sid_to_str[i];
 		} else {
-			snprintf(unknown, 18, "%s%u", "UNKNOWN", i);
+			snprintf(unknown, sizeof(unknown), "%s%u", "UNKNOWN", i);
 			sid = strdup(unknown);
+			if (!sid) {
+				rc = -1;
+				goto exit;
+			}
 		}
 		rc = strs_add_at_index(strs, sid, i);
 		if (rc != 0) {
@@ -792,6 +796,10 @@ static int write_sensitivity_rules_to_conf(FILE *out, struct policydb *pdb)
 			j = level->level->sens - 1;
 			if (!sens_alias_map[j]) {
 				sens_alias_map[j] = strdup(name);
+				if (!sens_alias_map[j]) {
+					rc = -1;
+					goto exit;
+				}
 			} else {
 				alias = sens_alias_map[j];
 				sens_alias_map[j] = create_str("%s %s", 2, alias, name);
@@ -919,6 +927,10 @@ static int write_category_rules_to_conf(FILE *out, struct policydb *pdb)
 			j = cat->s.value - 1;
 			if (!cat_alias_map[j]) {
 				cat_alias_map[j] = strdup(name);
+				if (!cat_alias_map[j]) {
+					rc = -1;
+					goto exit;
+				}
 			} else {
 				alias = cat_alias_map[j];
 				cat_alias_map[j] = create_str("%s %s", 2, alias, name);
@@ -2364,7 +2376,7 @@ static int write_sid_context_rules_to_conf(FILE *out, struct policydb *pdb, cons
 		if (i < num_sids) {
 			sid = (char *)sid_to_str[i];
 		} else {
-			snprintf(unknown, 18, "%s%u", "UNKNOWN", i);
+			snprintf(unknown, sizeof(unknown), "%s%u", "UNKNOWN", i);
 			sid = unknown;
 		}
 
