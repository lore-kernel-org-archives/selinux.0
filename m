Return-Path: <SRS0=LfCf=UQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 658E0C31E57
	for <selinux@archiver.kernel.org>; Mon, 17 Jun 2019 12:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D097B208E4
	for <selinux@archiver.kernel.org>; Mon, 17 Jun 2019 12:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="eaxvcO+E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbfFQMCP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 17 Jun 2019 08:02:15 -0400
Received: from 48.23.240.77.static.louhi.net ([77.240.23.48]:35432 "EHLO
        kolttonen.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725827AbfFQMCP (ORCPT <rfc822;selinux@vger.kernel.org>);
        Mon, 17 Jun 2019 08:02:15 -0400
Received: from 34-41-5D-CA-59-C7 (82-203-159-32.bb.dnainternet.fi [82.203.159.32])
        (authenticated bits=0)
        by vcust561.louhi.net (8.14.7/8.14.7/0) with ESMTP id x5HC1Wok020283
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <selinux@vger.kernel.org>; Mon, 17 Jun 2019 15:01:33 +0300
DKIM-Filter: OpenDKIM Filter v2.11.0 vcust561.louhi.net x5HC1Wok020283
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolttonen.fi;
        s=mail; t=1560772893;
        bh=dycGRLlQgysrz1Eq9tDvnh/RGym2yDAFPnb5gXTFKsA=;
        h=Date:From:To:Subject:From;
        b=eaxvcO+E8AkBELbsmf8+SCfeAgdEIcE+ab9ON0lMXvuwgwt9D8t5GyE8reghBbdit
         4E+mjIwPcRe3LWhH0N3/O804tuMKGUD49UEUJfrp0Ljv4vEsaIXQuluM6geHhiQNT7
         iRjAVzH6K36QfzEec7HpUN/25by734TTzpwx8Q+K65DMUIoVTbHYPyE7xrsrFU5kfn
         nTIbMKx/xvV4IlA3tM4exZeHjkqOnYxG+gqPwV3euiD8TLKmW5LIy62A93dGUGpV+r
         3g14DN1Ia+7xe63vXSLuZJIsJAuPmTfZbTb1ZHIFgUkHQAou7v/CXA5DStBAZBMuzN
         BQXSevKPuxDvQ==
Date:   Mon, 17 Jun 2019 15:02:11 +0300 (EEST)
From:   =?ISO-8859-15?Q?Jokke_H=E4m=E4l=E4inen?= 
        <jokke.hamalainen@kolttonen.fi>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/2] libsepol: Check strdup() failures
Message-ID: <alpine.LFD.2.21.1906171501370.6467@34-41-5D-CA-59-C7>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


Check strdup() failures

Signed-off-by: Unto Sten <sten.unto@gmail.com>
---
 libsepol/src/kernel_to_conf.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index 4f84ee8b..5fb4e838 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -450,6 +450,10 @@ static int write_sids_to_conf(FILE *out, const char *const *sid_to_str,
 		} else {
 			snprintf(unknown, 18, "%s%u", "UNKNOWN", i);
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
-- 
2.21.0

