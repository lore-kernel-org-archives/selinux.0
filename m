Return-Path: <SRS0=CL7O=TS=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE67C04AAF
	for <selinux@archiver.kernel.org>; Sat, 18 May 2019 16:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5F8120873
	for <selinux@archiver.kernel.org>; Sat, 18 May 2019 16:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="fDWms0B+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbfERQ5I (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 18 May 2019 12:57:08 -0400
Received: from 48.23.240.77.static.louhi.net ([77.240.23.48]:37096 "EHLO
        kolttonen.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727073AbfERQ5I (ORCPT <rfc822;selinux@vger.kernel.org>);
        Sat, 18 May 2019 12:57:08 -0400
Received: from 34-41-5D-CA-59-C7 (176-93-196-243.bb.dnainternet.fi [176.93.196.243])
        (authenticated bits=0)
        by vcust561.louhi.net (8.14.7/8.14.7/0) with ESMTP id x4IGuoR6008607
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <selinux@vger.kernel.org>; Sat, 18 May 2019 19:56:50 +0300
DKIM-Filter: OpenDKIM Filter v2.11.0 vcust561.louhi.net x4IGuoR6008607
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolttonen.fi;
        s=mail; t=1558198611;
        bh=vpnh3THTO15/+oODvCd8xHOl0IwW3kxamlVp6AKJQsw=;
        h=Date:From:To:Subject:From;
        b=fDWms0B+3hgCZt8bYUe3rTt8Zjir8ZL7wuETImnFYprKUPyrJ+VEpeO0tIankas7e
         PYNOXf22baC3jHkmz/8y/fZ6U/7CUMGF6RyXX/G6nCCZQFgp14Bw1pVqIDZy++3X9n
         8+HrxMGNjTcO0h7ZJ55+AtUkc/JQsiQq6pUhvWV8ETrn35uFp5slFll+2G+OyCHPBn
         1nt/hQyqUGDkAbi27NoKinagMkcKvT0F/EcA4pzU/INsNjkY5cMBb0wRF0NCY32/kU
         NFMlcPMGQsrpN+1zz2joTDevuX7GODsdkeu6A+wcnozNbNO9x6oDS+ezUrMXz2vut5
         NQcaOX8joBZFA==
Date:   Sat, 18 May 2019 19:57:03 +0300 (EEST)
From:   =?ISO-8859-15?Q?Jokke_H=E4m=E4l=E4inen?= 
        <jokke.hamalainen@kolttonen.fi>
To:     selinux@vger.kernel.org
Subject: [PATCH] conf-parse.y checks (with style fixes removed)
Message-ID: <alpine.LFD.2.21.1905181955170.29988@34-41-5D-CA-59-C7>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


diff --git a/libsemanage/src/conf-parse.y b/libsemanage/src/conf-parse.y
index b527e893..64b53c2d 100644
--- a/libsemanage/src/conf-parse.y
+++ b/libsemanage/src/conf-parse.y
@@ -221,6 +221,9 @@ usepasswd: USEPASSWD '=' ARG {
 
 ignoredirs: IGNOREDIRS '=' ARG {
 	current_conf->ignoredirs = strdup($3);
+	if (current_conf->ignoredirs == NULL) {
+		yyerror("could not allocate memory for current_conf->ignoredirs");
+	}
 	free($3);
  }
 
@@ -240,8 +243,8 @@ handle_unknown: HANDLE_UNKNOWN '=' ARG {
 bzip_blocksize:  BZIP_BLOCKSIZE '=' ARG {
 	int blocksize = atoi($3);
 	free($3);
-	if (blocksize > 9)
-		yyerror("bzip-blocksize can only be in the range 0-9");
+	if (blocksize < 1 || blocksize > 9)
+		yyerror("bzip-blocksize can only be in the range 1-9");
 	else
 		current_conf->bzip_blocksize = blocksize;
 }
@@ -339,9 +342,18 @@ static int semanage_conf_init(semanage_conf_t * conf)
 {
 	conf->store_type = SEMANAGE_CON_DIRECT;
 	conf->store_path = strdup(basename(selinux_policy_root()));
+	if (conf->store_path == NULL) {
+		return -1;
+	}
 	conf->ignoredirs = NULL;
 	conf->store_root_path = strdup("/var/lib/selinux");
+	if (conf->store_root_path == NULL) {
+		return -1;
+	}
 	conf->compiler_directory_path = strdup("/usr/libexec/selinux/hll");
+	if (conf->compiler_directory_path == NULL) {
+		return -1;
+	}
 	conf->policyvers = sepol_policy_kern_vers_max();
 	conf->target_platform = SEPOL_TARGET_SELINUX;
 	conf->expand_check = 1;
@@ -515,7 +527,10 @@ static int parse_module_store(char *arg)
 			}
 		}
 	}
-	return 0;
+
+	if (current_conf->store_path)
+		return 0;
+	return -3;
 }
 
 static int parse_store_root_path(char *arg)
@@ -526,6 +541,10 @@ static int parse_store_root_path(char *arg)
 
 	free(current_conf->store_root_path);
 	current_conf->store_root_path = strdup(arg);
+	if (current_conf->store_root_path == NULL) {
+		return -2;
+	}
+
 	return 0;
 }
 
@@ -536,6 +555,9 @@ static int parse_compiler_path(char *arg)
 	}
 	free(current_conf->compiler_directory_path);
 	current_conf->compiler_directory_path = strdup(arg);
+	if (current_conf->compiler_directory_path = NULL) {
+		return -2;
+	}
 	return 0;
 }
 
