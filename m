Return-Path: <SRS0=uP1p=TK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E82BC04A6B
	for <selinux@archiver.kernel.org>; Fri, 10 May 2019 23:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF0CA20881
	for <selinux@archiver.kernel.org>; Fri, 10 May 2019 23:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="OITm1wMV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbfEJXSH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 May 2019 19:18:07 -0400
Received: from 48.23.240.77.static.louhi.net ([77.240.23.48]:60946 "EHLO
        kolttonen.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726944AbfEJXSH (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 10 May 2019 19:18:07 -0400
Received: from 34-41-5D-CA-59-C7 (176-93-196-243.bb.dnainternet.fi [176.93.196.243])
        (authenticated bits=0)
        by vcust561.louhi.net (8.14.7/8.14.7/0) with ESMTP id x4ANHwIH014506
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <selinux@vger.kernel.org>; Sat, 11 May 2019 02:17:58 +0300
DKIM-Filter: OpenDKIM Filter v2.11.0 vcust561.louhi.net x4ANHwIH014506
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolttonen.fi;
        s=mail; t=1557530279;
        bh=47oaSBFBrNYhNhRnKY5eY4OlnG8awTEq5gbrTgHUic0=;
        h=Date:From:To:Subject:From;
        b=OITm1wMVjUhPvNjJM/+KI/PqVqDd6kLhIbv1ys+1gnpndThVHDGQDGu3rpxUhMUQu
         EYwCTizVPrV8+gz2JlddyD7WFmBOMG5rtxQM7T7bAChWIdrslJxQz1meUOHKGjbSn0
         eie+sD3Uv4wWotOqdPvOppnD9l1hOUKgRw5VCGn9s2Qz9MYXHPcwyfx1rneYDFyIGF
         6ItqCdfBcxaqmOQhAB9a/0NTMvjBCuOLvSraY3AqE+Ky/bplmtCGTBhyWZzSB7fWZu
         617Zl0xffJNbx90ji4uC7YBddrwowpKjR+eJ9YmvYEY2Clgyy1SRzG/9XEi8tBtOkb
         AqVh3YgFAcWEg==
Date:   Sat, 11 May 2019 02:18:01 +0300 (EEST)
From:   =?ISO-8859-15?Q?Jokke_H=E4m=E4l=E4inen?= 
        <jokke.hamalainen@kolttonen.fi>
To:     selinux@vger.kernel.org
Subject: [PATCH] General code cleanups, sanity checks and strdup() checks
Message-ID: <alpine.LFD.2.21.1905110216330.19888@34-41-5D-CA-59-C7>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


Needs to be analyzed for correctness.

---
 libsemanage/src/conf-parse.y | 56 ++++++++++++++++++++++++++++++++----
 1 file changed, 51 insertions(+), 5 deletions(-)

diff --git a/libsemanage/src/conf-parse.y b/libsemanage/src/conf-parse.y
index b527e893..75a43cd2 100644
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
 
@@ -240,7 +243,7 @@ handle_unknown: HANDLE_UNKNOWN '=' ARG {
 bzip_blocksize:  BZIP_BLOCKSIZE '=' ARG {
 	int blocksize = atoi($3);
 	free($3);
-	if (blocksize > 9)
+	if (blocksize < 0 || blocksize > 9)
 		yyerror("bzip-blocksize can only be in the range 0-9");
 	else
 		current_conf->bzip_blocksize = blocksize;
@@ -338,10 +341,24 @@ external_opt:   PROG_PATH '=' ARG  { PASSIGN(new_external->path, $3); }
 static int semanage_conf_init(semanage_conf_t * conf)
 {
 	conf->store_type = SEMANAGE_CON_DIRECT;
+
 	conf->store_path = strdup(basename(selinux_policy_root()));
+	if (conf->store_path == NULL) {
+		return -1;
+	}
+
 	conf->ignoredirs = NULL;
+
 	conf->store_root_path = strdup("/var/lib/selinux");
+	if (conf->store_root_path == NULL) {
+		return -1;
+	}
+
 	conf->compiler_directory_path = strdup("/usr/libexec/selinux/hll");
+	if (conf->compiler_directory_path == NULL) {
+		return -1;
+	}
+
 	conf->policyvers = sepol_policy_kern_vers_max();
 	conf->target_platform = SEPOL_TARGET_SELINUX;
 	conf->expand_check = 1;
@@ -366,20 +383,24 @@ static int semanage_conf_init(semanage_conf_t * conf)
 	} else {
 		conf->load_policy->path = strdup("/usr/sbin/load_policy");
 	}
+
 	if (conf->load_policy->path == NULL) {
 		return -1;
 	}
+
 	conf->load_policy->args = NULL;
 
 	if ((conf->setfiles =
 	     calloc(1, sizeof(*(current_conf->setfiles)))) == NULL) {
 		return -1;
 	}
+
 	if (access("/sbin/setfiles", X_OK) == 0) {
 		conf->setfiles->path = strdup("/sbin/setfiles");
 	} else {
 		conf->setfiles->path = strdup("/usr/sbin/setfiles");
 	}
+
 	if ((conf->setfiles->path == NULL) ||
 	    (conf->setfiles->args = strdup("-q -c $@ $<")) == NULL) {
 		return -1;
@@ -389,11 +410,13 @@ static int semanage_conf_init(semanage_conf_t * conf)
 	     calloc(1, sizeof(*(current_conf->sefcontext_compile)))) == NULL) {
 		return -1;
 	}
+
 	if (access("/sbin/sefcontext_compile", X_OK) == 0) {
 		conf->sefcontext_compile->path = strdup("/sbin/sefcontext_compile");
 	} else {
 		conf->sefcontext_compile->path = strdup("/usr/sbin/sefcontext_compile");
 	}
+
 	if ((conf->sefcontext_compile->path == NULL) ||
 	    (conf->sefcontext_compile->args = strdup("$@")) == NULL) {
 		return -1;
@@ -413,24 +436,30 @@ semanage_conf_t *semanage_conf_parse(const char *config_filename)
 	if ((current_conf = calloc(1, sizeof(*current_conf))) == NULL) {
 		return NULL;
 	}
+
 	if (semanage_conf_init(current_conf) == -1) {
 		goto cleanup;
 	}
+
 	if ((semanage_in = fopen(config_filename, "r")) == NULL) {
-		/* configuration file does not exist or could not be
-		 * read.  THIS IS NOT AN ERROR.  just rely on the
+		/* Configuration file does not exist or could not be
+		 * read.  THIS IS NOT AN ERROR.  Just rely on the
 		 * defaults. */
 		return current_conf;
 	}
+
 	parse_errors = 0;
 	semanage_parse();
 	fclose(semanage_in);
 	semanage_lex_destroy();
+
 	if (parse_errors != 0) {
 		goto cleanup;
 	}
+
 	return current_conf;
-      cleanup:
+
+cleanup:
 	semanage_conf_destroy(current_conf);
 	return NULL;
 }
@@ -489,7 +518,9 @@ static int parse_module_store(char *arg)
 	if (arg == NULL) {
 		return -1;
 	}
+
 	free(current_conf->store_path);
+
 	if (strcmp(arg, "direct") == 0) {
 		current_conf->store_type = SEMANAGE_CON_DIRECT;
 		current_conf->store_path =
@@ -515,7 +546,10 @@ static int parse_module_store(char *arg)
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
@@ -525,7 +559,12 @@ static int parse_store_root_path(char *arg)
 	}
 
 	free(current_conf->store_root_path);
+
 	current_conf->store_root_path = strdup(arg);
+	if (current_conf->store_root_path == NULL) {
+		return -2;
+	}
+
 	return 0;
 }
 
@@ -534,8 +573,13 @@ static int parse_compiler_path(char *arg)
 	if (arg == NULL) {
 		return -1;
 	}
+
 	free(current_conf->compiler_directory_path);
+
 	current_conf->compiler_directory_path = strdup(arg);
+	if (current_conf->compiler_directory_path = NULL) {
+		return -2;
+	}
 	return 0;
 }
 
@@ -548,6 +592,7 @@ static int new_external_prog(external_prog_t ** chain)
 	if ((new_external = calloc(1, sizeof(*new_external))) == NULL) {
 		return -1;
 	}
+
 	/* hook this new external program to the end of the chain */
 	if (*chain == NULL) {
 		*chain = new_external;
@@ -558,5 +603,6 @@ static int new_external_prog(external_prog_t ** chain)
 		}
 		prog->next = new_external;
 	}
+
 	return 0;
 }
-- 
2.21.0

