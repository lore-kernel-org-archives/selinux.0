Return-Path: <SRS0=uP1p=TK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2154EC04A6B
	for <selinux@archiver.kernel.org>; Fri, 10 May 2019 21:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88B9E217D6
	for <selinux@archiver.kernel.org>; Fri, 10 May 2019 21:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="qsLRjnLg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbfEJV4t (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 May 2019 17:56:49 -0400
Received: from 48.23.240.77.static.louhi.net ([77.240.23.48]:59402 "EHLO
        kolttonen.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728204AbfEJV4t (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 10 May 2019 17:56:49 -0400
Received: from 34-41-5D-CA-59-C7 (176-93-196-243.bb.dnainternet.fi [176.93.196.243])
        (authenticated bits=0)
        by vcust561.louhi.net (8.14.7/8.14.7/0) with ESMTP id x4ALufKf014298
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <selinux@vger.kernel.org>; Sat, 11 May 2019 00:56:42 +0300
DKIM-Filter: OpenDKIM Filter v2.11.0 vcust561.louhi.net x4ALufKf014298
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolttonen.fi;
        s=mail; t=1557525402;
        bh=Q6RrQBS4umzy8S7jiQbG460nl4GDC5n4m1mZmSp+E0k=;
        h=Date:From:To:Subject:From;
        b=qsLRjnLgS28VaeJIcgwkXPipGgkYi11zErENM3I1RAHNLABJUZDSwJNZ4HpS1qbQ6
         Q6e7VZiMSDwkWXGOTaNtHXrVZayCpeCHIjn6CDVPVr2Th6GWhrJYmbpUUlR9aPwOFG
         YU8mPHY9RJxG/IEpzxBKDYArbuzexJUYWwDiIZNLrE29Y27rNIJqlVoXOqnO0AP1zs
         qEG+rE3v7suCTOTlq3Z0Tkdb+xIaa8qo74f/5rJzfxV2SjZH30pJ8/qn62SZgO+na9
         y+AZwrS+arVCG0dV0/JOK6+l6o0GcAqs+IPzmwFFBgmpWXKdfVwrop3HyUGEmoqo3A
         PfQ3aHyWOROkA==
Date:   Sat, 11 May 2019 00:56:45 +0300 (EEST)
From:   =?ISO-8859-15?Q?Jokke_H=E4m=E4l=E4inen?= 
        <jokke.hamalainen@kolttonen.fi>
To:     selinux@vger.kernel.org
Subject: [PATCH] Trivial style improvements
Message-ID: <alpine.LFD.2.21.1905110053540.18564@34-41-5D-CA-59-C7>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


Yet another trivial style patch while spending the night reading
C code.

---
 policycoreutils/setsebool/setsebool.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/policycoreutils/setsebool/setsebool.c b/policycoreutils/setsebool/setsebool.c
index a5157efc..9d8abfac 100644
--- a/policycoreutils/setsebool/setsebool.c
+++ b/policycoreutils/setsebool/setsebool.c
@@ -77,7 +77,7 @@ int main(int argc, char **argv)
 		/* Add 1 for the '=' */
 		len = strlen(argv[optind]) + strlen(argv[optind + 1]) + 2;
 		bool_list[0] = (char *)malloc(len);
-		if (bool_list[0] == 0) {
+		if (bool_list[0] == NULL) {
 			fputs("Out of memory - aborting\n", stderr);
 			return 1;
 		}
@@ -133,8 +133,8 @@ static int semanage_set_boolean_list(size_t boolcnt,
 		goto err;
 	}
 
-	if (! verbose) {
-		semanage_msg_set_callback(handle,NULL, NULL);
+	if (!verbose) {
+		semanage_msg_set_callback(handle, NULL, NULL);
 	}
 
 	managed = semanage_is_managed(handle);
@@ -175,9 +175,9 @@ static int semanage_set_boolean_list(size_t boolcnt,
 			goto err;
 
 		semanage_bool_exists(handle, bool_key, &result);
-		if ( !result ) {
+		if (!result) {
 			semanage_bool_exists_local(handle, bool_key, &result);
-			if ( !result ) {
+			if (!result) {
 				fprintf(stderr, "Boolean %s is not defined\n", boollist[j].name);
 				goto err;
 			}
@@ -230,13 +230,13 @@ int setbool(char **list, size_t start, size_t end)
 	while (i < end) {
 		name = list[i];
 		value_ptr = strchr(list[i], '=');
-		if (value_ptr == 0) {
+		if (value_ptr == NULL) {
 			fprintf(stderr,
 				"setsebool: '=' not found in boolean expression %s\n",
 				list[i]);
 			goto err;
 		}
-		*value_ptr = 0;
+		*value_ptr = '\0';
 		value_ptr++;
 		if (strcmp(value_ptr, "1") == 0 ||
 		    strcasecmp(value_ptr, "true") == 0 ||
@@ -278,7 +278,7 @@ int setbool(char **list, size_t start, size_t end)
 	while (i < end) {
 		name = list[i];
 		value_ptr = strchr(name, '=');
-		*value_ptr = 0;
+		*value_ptr = '\0';
 		value_ptr++;
 		if (pwd && pwd->pw_name)
 			syslog(LOG_NOTICE,
-- 
2.21.0

