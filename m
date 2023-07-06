Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD568EB64D9
	for <selinux@archiver.kernel.org>; Thu,  6 Jul 2023 14:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233565AbjGFOx6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Jul 2023 10:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233604AbjGFOxo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Jul 2023 10:53:44 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2E31FCA
        for <selinux@vger.kernel.org>; Thu,  6 Jul 2023 07:53:41 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9926623e367so103634066b.0
        for <selinux@vger.kernel.org>; Thu, 06 Jul 2023 07:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1688655220; x=1691247220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=JrJUCbPpR15HSV/1m+431MW6QwBTpjwWVs3effp6liY=;
        b=l5WPPJKaHv/myy5dIjWWr1Uf5+HIvnDTaBrviiN4yyz0qWB4Ciogu4oasVmvA9ZG7y
         YbDWEQbgehlPyrj2xr62BSimKG1OBBaVjcqStnbI/dedyoZwnZUDwBwwuVsk5Jnz4AiH
         SGg5Z1hjURzXfNJd+uGlABKjN9rzFyNMsgKWYXfe9Wpm5gS1jR77ZjowL3tbjSLOQEKw
         dEfSz57t8OPH7CKMc0IyLWT28ijv5BViXr7ZFimpYDiJQ6AMWnObU/uQ4waUJ0Ux4Ifd
         Va9TLlxcZT6X4+aidCA1oI33YejKJC5nx48/CuYBkCCtddzSgXHDbcTHixESYFN+G8gi
         lQqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688655220; x=1691247220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JrJUCbPpR15HSV/1m+431MW6QwBTpjwWVs3effp6liY=;
        b=eqMiffauIugmQNy6pE+VDEifTLhucP+UdwSLSezZtJh+vfMstBgG8TMDke0BCJTwkF
         WNqRwBuA/iGxqt7rPJ6QtaMIAIVgPdGcUVHXRCqDpSxMzXZ+Qkn9DgduZ8VSUdDGi6ZD
         nPelJyqCGJ9dkD1giz8VSnPVOiyagL+AusfC1I3apiV8NYCgI3nu4AdkQLqb7tNEGsSu
         pTpdDY/83eSgFHwcaJVKfYGq+n/yC9w5SGNCbkTbfLczOFFgvDdkN2ZoL5z5s4aP9RZo
         ukYA8GQsG3iJBAi5gWDAmH4n6zUdzU1nV8X23WefIuaxDQLBcDzIuVo7rvLkepu0sfEx
         6s1g==
X-Gm-Message-State: ABy/qLb4727xyP4z+E9tz7zkZ9nkgNOpE7GtF1t4eDW/Fuq2t4Gjjx7X
        sCjPiLBw8I0J7ZUKXRLIb/NJIqa9AkzTZ6V8
X-Google-Smtp-Source: APBJJlGws0VOWv87Ba9yMTLF0xgXzzuVO39So3pHsglr5VD/s6t9GJBfSi1K641wODckcJS/Yf3Szg==
X-Received: by 2002:a17:906:e17:b0:988:dced:f339 with SMTP id l23-20020a1709060e1700b00988dcedf339mr1351902eji.31.1688655220015;
        Thu, 06 Jul 2023 07:53:40 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-008-088-179.77.8.pool.telefonica.de. [77.8.88.179])
        by smtp.gmail.com with ESMTPSA id va25-20020a17090711d900b00992e265495csm905659ejb.212.2023.07.06.07.53.39
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 07:53:39 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2 1/4] semodule_expand: update
Date:   Thu,  6 Jul 2023 16:53:32 +0200
Message-Id: <20230706145335.71452-1-cgzones@googlemail.com>
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
Add help argument option -h.
Set close-on-exec flag in case of any sibling threads.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2:
  - address comments by Jim:
    * drop exit() calls
    * reduce to only one final return statement
  - add help argument option -h
  - set close-on-exec flag
---
 .../semodule_expand/semodule_expand.8         |   5 +-
 .../semodule_expand/semodule_expand.c         | 112 +++++++++++-------
 2 files changed, 73 insertions(+), 44 deletions(-)

diff --git a/semodule-utils/semodule_expand/semodule_expand.8 b/semodule-utils/semodule_expand/semodule_expand.8
index 1b482a1f..84b943cd 100644
--- a/semodule-utils/semodule_expand/semodule_expand.8
+++ b/semodule-utils/semodule_expand/semodule_expand.8
@@ -3,7 +3,7 @@
 semodule_expand \- Expand a SELinux policy module package.
 
 .SH SYNOPSIS
-.B semodule_expand [-V ] [ -a ] [ -c [version]] basemodpkg outputfile
+.B semodule_expand [-ahV] [ -c [version]] basemodpkg outputfile
 .br
 .SH DESCRIPTION
 .PP
@@ -17,6 +17,9 @@ together a set of packages into a single package).
 
 .SH "OPTIONS"
 .TP
+.B \-h
+show help
+.TP
 .B \-V
 show version
 .TP
diff --git a/semodule-utils/semodule_expand/semodule_expand.c b/semodule-utils/semodule_expand/semodule_expand.c
index 895cdd78..99380abe 100644
--- a/semodule-utils/semodule_expand/semodule_expand.c
+++ b/semodule-utils/semodule_expand/semodule_expand.c
@@ -21,32 +21,25 @@
 #include <unistd.h>
 #include <string.h>
 
-extern char *optarg;
-extern int optind;
-
-int policyvers = 0;
-
 #define EXPANDPOLICY_VERSION "1.0"
 
-static __attribute__((__noreturn__)) void usage(const char *program_name)
+static void usage(const char *program_name)
 {
-	printf("usage: %s [-V -a -c [version]] basemodpkg outputfile\n",
+	printf("usage: %s [-h -V -a -c [version] -v] basemodpkg outputfile\n",
 	       program_name);
-	exit(1);
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
-
-	while ((ch = getopt(argc, argv, "c:Vva")) != EOF) {
+	const char *basename, *outname;
+	int ch, ret, show_version = 0, verbose = 0, policyvers = 0, check_assertions = 1;
+	struct sepol_policy_file *pf = NULL;
+	sepol_module_package_t *base = NULL;
+	sepol_policydb_t *out = NULL, *p;
+	FILE *fp = NULL, *outfile = NULL;
+	sepol_handle_t *handle = NULL;
+
+	while ((ch = getopt(argc, argv, "c:Vvah")) != EOF) {
 		switch (ch) {
 		case 'V':
 			show_version = 1;
@@ -54,14 +47,20 @@ int main(int argc, char **argv)
 		case 'v':
 			verbose = 1;
 			break;
+		case 'h':
+			usage(argv[0]);
+			return EXIT_SUCCESS;
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
+					return EXIT_FAILURE;
 				}
 				if (n < sepol_policy_kern_vers_min()
 				    || n > sepol_policy_kern_vers_max()) {
@@ -71,7 +70,7 @@ int main(int argc, char **argv)
 						sepol_policy_kern_vers_min(),
 						sepol_policy_kern_vers_max());
 					usage(argv[0]);
-					exit(1);
+					return EXIT_FAILURE;
 				}
 				policyvers = n;
 				break;
@@ -82,6 +81,7 @@ int main(int argc, char **argv)
 			}
 		default:
 			usage(argv[0]);
+			return EXIT_FAILURE;
 		}
 	}
 
@@ -92,84 +92,90 @@ int main(int argc, char **argv)
 
 	if (show_version) {
 		printf("%s\n", EXPANDPOLICY_VERSION);
-		exit(0);
+		return EXIT_SUCCESS;
 	}
 
 	/* check args */
-	if (argc < 3 || !(optind != (argc - 1))) {
+	if (argc < 3 || argc - optind != 2) {
 		fprintf(stderr,
 			"%s:  You must provide the base module package and output filename\n",
 			argv[0]);
 		usage(argv[0]);
+		return EXIT_FAILURE;
 	}
 
 	basename = argv[optind++];
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
-	fp = fopen(basename, "r");
+
+	fp = fopen(basename, "re");
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
-	outfile = fopen(outname, "w");
+	outfile = fopen(outname, "we");
 	if (!outfile) {
-		perror(outname);
-		exit(1);
+		fprintf(stderr, "%s:  Can't open '%s':  %s\n",
+			argv[0], outname, strerror(errno));
+		goto failure;
 	}
 
 	sepol_policy_file_set_fp(pf, outfile);
@@ -178,12 +184,32 @@ int main(int argc, char **argv)
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
+	goto cleanup;
+
+failure:
+	ret = EXIT_FAILURE;
+
+cleanup:
+	if (outfile)
+		fclose(outfile);
 	sepol_policydb_free(out);
+	if (fp)
+		fclose(fp);
+	sepol_module_package_free(base);
 	sepol_policy_file_free(pf);
+	sepol_handle_destroy(handle);
 
-	return 0;
+	return ret;
 }
-- 
2.40.1

