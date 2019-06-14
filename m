Return-Path: <SRS0=ZMzQ=UN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48054C31E50
	for <selinux@archiver.kernel.org>; Fri, 14 Jun 2019 23:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA32A21848
	for <selinux@archiver.kernel.org>; Fri, 14 Jun 2019 23:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="BXSlPJu8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725812AbfFNXQo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 14 Jun 2019 19:16:44 -0400
Received: from 48.23.240.77.static.louhi.net ([77.240.23.48]:48776 "EHLO
        kolttonen.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725809AbfFNXQo (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 14 Jun 2019 19:16:44 -0400
Received: from 34-41-5D-CA-59-C7 (82-203-159-32.bb.dnainternet.fi [82.203.159.32])
        (authenticated bits=0)
        by vcust561.louhi.net (8.14.7/8.14.7/0) with ESMTP id x5ENG4Xf007703
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <selinux@vger.kernel.org>; Sat, 15 Jun 2019 02:16:04 +0300
DKIM-Filter: OpenDKIM Filter v2.11.0 vcust561.louhi.net x5ENG4Xf007703
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolttonen.fi;
        s=mail; t=1560554164;
        bh=SYg9zGFUQDMcMVwOiBlqLOyy6JGQZy8dm8cOZ9iXssg=;
        h=Date:From:To:Subject:From;
        b=BXSlPJu8a5LYX5qS1Jp02AqbRqi3WeJ/9bu0tVWF2kWmW7Kgusg1DgYEO+DIIeiuy
         ajTpFnkpGizts1rGbDkpWg0UcAygU5naqlndC7nR/ZVk5PMXCaRm0ojzv9XZKfxiGM
         YiORR4uU8B1lKbpqIhtedAmZucd6wk0XHIOj1Qjh9X/aiWum6Rf09SNtQ5NcLvTzfo
         COqSqai9SnLYAmGNQ/oc17xAC8wgTEbNjRujt8SJfneAaegRr5C2dyrLlirR+13L9z
         kctGSvZixBaP59RK4580XI8XkJwVWTnndSc0UqvXz2J+MNlCT3LskhnrcKhc0uQYC4
         IHuGGv3D1DVwQ==
Date:   Sat, 15 Jun 2019 02:16:39 +0300 (EEST)
From:   =?ISO-8859-15?Q?Jokke_H=E4m=E4l=E4inen?= 
        <jokke.hamalainen@kolttonen.fi>
To:     selinux@vger.kernel.org
Subject: [PATCH] libsepol: check strdup() failures and replace constant
Message-ID: <alpine.LFD.2.21.1906150215140.18365@34-41-5D-CA-59-C7>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


Check for strdup() failures. Also replace constant 18
with a safer sizeof() use.

Signed-off-by: Unto Sten <sten.unto@gmail.com>
---
 libsepol/src/kernel_to_conf.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

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
 
-- 
2.21.0

