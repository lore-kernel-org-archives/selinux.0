Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A29BC77B75
	for <selinux@archiver.kernel.org>; Fri, 12 May 2023 11:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240333AbjELLHi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 12 May 2023 07:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239919AbjELLHh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 12 May 2023 07:07:37 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F4930DC
        for <selinux@vger.kernel.org>; Fri, 12 May 2023 04:07:36 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-50bceaf07b8so17915170a12.3
        for <selinux@vger.kernel.org>; Fri, 12 May 2023 04:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1683889655; x=1686481655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=mfWUcV0M0NL0oIA6gXma0OTQCk5PechLdX2RyNUV3h0=;
        b=iL6MdKbHpBdAzOVKFAwnsQSzGEjAK4EJ5q63TnG6Xj6AbKQhnO9qmfe2iGpfZ3mdda
         cfpSPZQWgx0fIymXO1mgXukMirdenhR1ljNWvLujMrRasMXN5ExZNXJR1/IicKMzkaO/
         XaYPfiM6sjf/KqwO/PVpu+u6LgVbdictYMHzelDRrFPulXQ7KO3BYCxYb35q34H/Ji3b
         oJuY7P4fli2R4X/N5A+3Msc5etUnqTgBBPX0kZ1VzP3UZZLJOdobiDwU/rpZzDB+iglf
         rPTkun8urZT3XLjn8hU5uQe05ycxxUg/vI3EDQcmr3gez+3OXYXQYsqw/M0J7rNJInR2
         C3Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683889655; x=1686481655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mfWUcV0M0NL0oIA6gXma0OTQCk5PechLdX2RyNUV3h0=;
        b=l24Ce/3CIkocVkxnf9hx9S8FHN8Kcyg2Qq8nXlnHWatbHvxjF3tSb+HMh+bE+p5JZU
         Y2jMAKap+VdtzJ0B86xQroAne+jF73dMH0yVz00iWPGCRhtkIlVauBFQFp3BBMlPjdCY
         zpael8CwYdJVpg+v37RhgXDo2UWF3qupsjaaqvl7NVu0wW6waVlObPvUTPSsy1SnuVmu
         2lh9Iz9l6QQJvkw7QdtDNYm6gzLMlRYSftNwTZr/Ppn6mlNU7Fjksaouiz2sUhyUWpNu
         LtnhLNedKsQKnjry/5pXWMu4/nArpcsn/hEf8DPBpzKmHJOiP4JgtnoL40OqyA5HDdQC
         /OPg==
X-Gm-Message-State: AC+VfDyM5ZaFSTlNygUMmtIBm40HYnKUwJNDY3zSV9bu+6F0s7AdEDEM
        aBHd2BTyujr/xkdVeb8StA8UqGkIW3P0aA==
X-Google-Smtp-Source: ACHHUZ6dIMBfqANUQtzNVSclcpX0fbNBgcVGduR+Qy6acDaM33IvO1ihN1fvLSgDrGeNbpdWwljPaw==
X-Received: by 2002:aa7:c586:0:b0:50d:b92e:d1dc with SMTP id g6-20020aa7c586000000b0050db92ed1dcmr10058258edq.14.1683889654687;
        Fri, 12 May 2023 04:07:34 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-116-181-041.95.116.pool.telefonica.de. [95.116.181.41])
        by smtp.gmail.com with ESMTPSA id o11-20020aa7c7cb000000b0050bde945c00sm3812016eds.78.2023.05.12.04.07.34
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 04:07:34 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 1/4] semodule_expand: update
Date:   Fri, 12 May 2023 13:07:27 +0200
Message-Id: <20230512110730.78672-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Drop unnecessary declarations.
Reduce scope of file global variable.
Mention -v argument in help usage message.
More strict integer conversion.
More strict argument count checking.
Check closing file for incomplete write.
Rework resource cleanup, so that all files and allocated memory are
released in all branches, useful to minimize reports while debugging
libsepol under valgrind(8) or sanitizers.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 .../semodule_expand/semodule_expand.c         | 91 +++++++++++--------
 1 file changed, 55 insertions(+), 36 deletions(-)

diff --git a/semodule-utils/semodule_expand/semodule_expand.c b/semodule-utils/semodule_expand/semodule_expand.c
index 895cdd78..8d9feb05 100644
--- a/semodule-utils/semodule_expand/semodule_expand.c
+++ b/semodule-utils/semodule_expand/semodule_expand.c
@@ -21,30 +21,24 @@
 #include <unistd.h>
 #include <string.h>
 
-extern char *optarg;
-extern int optind;
-
-int policyvers = 0;
-
 #define EXPANDPOLICY_VERSION "1.0"
 
 static __attribute__((__noreturn__)) void usage(const char *program_name)
 {
-	printf("usage: %s [-V -a -c [version]] basemodpkg outputfile\n",
+	printf("usage: %s [-V -a -c [version] -v] basemodpkg outputfile\n",
 	       program_name);
 	exit(1);
 }
 
 int main(int argc, char **argv)
 {
-	char *basename, *outname;
-	int ch, ret, show_version = 0, verbose = 0;
-	struct sepol_policy_file *pf;
-	sepol_module_package_t *base;
-	sepol_policydb_t *out, *p;
-	FILE *fp, *outfile;
-	int check_assertions = 1;
-	sepol_handle_t *handle;
+	const char *basename, *outname;
+	int ch, ret, show_version = 0, verbose = 0, policyvers = 0, check_assertions = 1;
+	struct sepol_policy_file *pf = NULL;
+	sepol_module_package_t *base = NULL;
+	sepol_policydb_t *out = NULL, *p;
+	FILE *fp = NULL, *outfile = NULL;
+	sepol_handle_t *handle = NULL;
 
 	while ((ch = getopt(argc, argv, "c:Vva")) != EOF) {
 		switch (ch) {
@@ -55,13 +49,15 @@ int main(int argc, char **argv)
 			verbose = 1;
 			break;
 		case 'c':{
-				long int n = strtol(optarg, NULL, 10);
+				long int n;
+
+				errno = 0;
+				n = strtol(optarg, NULL, 10);
 				if (errno) {
 					fprintf(stderr,
 						"%s:  Invalid policyvers specified: %s\n",
 						argv[0], optarg);
 					usage(argv[0]);
-					exit(1);
 				}
 				if (n < sepol_policy_kern_vers_min()
 				    || n > sepol_policy_kern_vers_max()) {
@@ -71,7 +67,6 @@ int main(int argc, char **argv)
 						sepol_policy_kern_vers_min(),
 						sepol_policy_kern_vers_max());
 					usage(argv[0]);
-					exit(1);
 				}
 				policyvers = n;
 				break;
@@ -96,7 +91,7 @@ int main(int argc, char **argv)
 	}
 
 	/* check args */
-	if (argc < 3 || !(optind != (argc - 1))) {
+	if (argc < 3 || argc - optind != 2) {
 		fprintf(stderr,
 			"%s:  You must provide the base module package and output filename\n",
 			argv[0]);
@@ -107,69 +102,74 @@ int main(int argc, char **argv)
 	outname = argv[optind];
 
 	handle = sepol_handle_create();
-	if (!handle)
-		exit(1);
+	if (!handle) {
+		fprintf(stderr, "%s:  Out of memory\n", argv[0]);
+		goto failure;
+	}
 
 	if (sepol_policy_file_create(&pf)) {
 		fprintf(stderr, "%s:  Out of memory\n", argv[0]);
-		exit(1);
+		goto failure;
 	}
 
 	/* read the base module */
 	if (sepol_module_package_create(&base)) {
 		fprintf(stderr, "%s:  Out of memory\n", argv[0]);
-		exit(1);
+		goto failure;
 	}
+
 	fp = fopen(basename, "r");
 	if (!fp) {
 		fprintf(stderr, "%s:  Can't open '%s':  %s\n",
 			argv[0], basename, strerror(errno));
-		exit(1);
+		goto failure;
 	}
+
 	sepol_policy_file_set_fp(pf, fp);
 	ret = sepol_module_package_read(base, pf, 0);
 	if (ret) {
 		fprintf(stderr, "%s:  Error in reading package from %s\n",
 			argv[0], basename);
-		exit(1);
+		goto failure;
 	}
+
 	fclose(fp);
+	fp = NULL;
 
 	/* linking the base takes care of enabling optional avrules */
 	p = sepol_module_package_get_policy(base);
 	if (sepol_link_modules(handle, p, NULL, 0, 0)) {
 		fprintf(stderr, "%s:  Error while enabling avrules\n", argv[0]);
-		exit(1);
+		goto failure;
 	}
 
 	/* create the output policy */
 
 	if (sepol_policydb_create(&out)) {
 		fprintf(stderr, "%s:  Out of memory\n", argv[0]);
-		exit(1);
+		goto failure;
 	}
 
 	sepol_set_expand_consume_base(handle, 1);
 
 	if (sepol_expand_module(handle, p, out, verbose, check_assertions)) {
 		fprintf(stderr, "%s:  Error while expanding policy\n", argv[0]);
-		exit(1);
+		goto failure;
 	}
 
 	if (policyvers) {
 		if (sepol_policydb_set_vers(out, policyvers)) {
 			fprintf(stderr, "%s:  Invalid version %d\n", argv[0],
 				policyvers);
-			exit(1);
+			goto failure;
 		}
 	}
 
-	sepol_module_package_free(base);
-
 	outfile = fopen(outname, "w");
 	if (!outfile) {
-		perror(outname);
-		exit(1);
+		fprintf(stderr, "%s:  Can't open '%s':  %s\n",
+			argv[0], outname, strerror(errno));
+		goto failure;
 	}
 
 	sepol_policy_file_set_fp(pf, outfile);
@@ -178,12 +178,31 @@ int main(int argc, char **argv)
 		fprintf(stderr,
 			"%s:  Error while writing expanded policy to %s\n",
 			argv[0], outname);
-		exit(1);
+		goto failure;
 	}
-	fclose(outfile);
-	sepol_handle_destroy(handle);
+
+	ret = fclose(outfile);
+	outfile = NULL;
+	if (ret) {
+		fprintf(stderr, "%s:  Error closing policy file %s:  %s\n",
+			argv[0], outname, strerror(errno));
+		goto failure;
+	}
+
+	ret = EXIT_SUCCESS;
+cleanup:
+	if (outfile)
+		fclose(outfile);
 	sepol_policydb_free(out);
+	if (fp)
+		fclose(fp);
+	sepol_module_package_free(base);
 	sepol_policy_file_free(pf);
+	sepol_handle_destroy(handle);
+
+	return ret;
 
-	return 0;
+failure:
+	ret = EXIT_FAILURE;
+	goto cleanup;
 }
-- 
2.40.1

