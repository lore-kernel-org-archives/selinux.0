Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E63EB64DD
	for <selinux@archiver.kernel.org>; Thu,  6 Jul 2023 14:54:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233591AbjGFOyA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Jul 2023 10:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233635AbjGFOxu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Jul 2023 10:53:50 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648651FCD
        for <selinux@vger.kernel.org>; Thu,  6 Jul 2023 07:53:42 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so3114582a12.1
        for <selinux@vger.kernel.org>; Thu, 06 Jul 2023 07:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1688655220; x=1691247220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9HpY4Gh6QgXBtXMuvVmIeoV7IOkNU6VF7iQ1M4SSVAU=;
        b=HVTH1gESZNERcCZtt5tCv+NpluqFGk1m+ITKfRtalu2IZyM6Wh9zf+O2b1fON/ZM7G
         o1Lvo4SmXsSGfq6dez5lV7WOBodv0zgImm0dhiLOOD0QkJqoBSaw87sY2pYZRyvwYUiQ
         CdKJ+9hlV6bO1ZWiHYyrfjtD/XTAhMOFkWRO1YwERF3MZutlu6TLZDQm1Zl2Hvyitwzq
         0W+1ENqRw/OY3OA4WuUQwoHh8tE5BrZY/ccRkwCxwJDWww69d/gP6GGqx7EzJKYiovCn
         y3XUZnkE1McOoLWuv+Y5clAsJgRtYdjXS5AHSFfFBC4vm3kaxOTSBlyTSh1etnO3fSam
         D3FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688655220; x=1691247220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9HpY4Gh6QgXBtXMuvVmIeoV7IOkNU6VF7iQ1M4SSVAU=;
        b=ViBt0SIIdrJutvyMmMyti9NRFIjcjTlf+CPtj5Ys+DAlKbjXxE5nf2PgIQDu6PerG9
         SODYNWmdfZwmwP6ztu0EvsJbCuqzwTnqa6zwE7Sy6mv8fJk+4Mt32ChKuafV2W5JiRR1
         sZkCTUCdQcqyliIw2FI8X6mobt0EFf0R9Yxf6N0MqDMr1xVWTZ6wnYXRJ4ag9DAW3pwf
         PFUSXdwU+bluqKlgB0Hpgpm64HonLy4XHx0/QZFh9YLS3k+7mOZEWQGQHiwDtCjgaWOK
         sn4IF8m8qdAoZ3DoXPwcU5DwzGUWjbEI6OOcIG2nVkpW00ExYWenhWVKPTi5qPpUO9bL
         4pWg==
X-Gm-Message-State: ABy/qLYdrY31m9pXgOou7Kc7koRRrf+AndaVvjODPq/qJUwI3cPZ5pdY
        NA46pk2Cyu7vSvsNMCzm2pPy13cf19bXzGE2
X-Google-Smtp-Source: APBJJlFEKqMRFALsd+QsiYKmwytv57vKLypmgUACvnG+VjgfrJ9zg3v1ejW5Lurxiz4trwMWdoWK2w==
X-Received: by 2002:a17:906:728f:b0:94e:4285:390c with SMTP id b15-20020a170906728f00b0094e4285390cmr2498701ejl.10.1688655220464;
        Thu, 06 Jul 2023 07:53:40 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-008-088-179.77.8.pool.telefonica.de. [77.8.88.179])
        by smtp.gmail.com with ESMTPSA id va25-20020a17090711d900b00992e265495csm905659ejb.212.2023.07.06.07.53.40
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 07:53:40 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2 2/4] semodule_link: update
Date:   Thu,  6 Jul 2023 16:53:33 +0200
Message-Id: <20230706145335.71452-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230706145335.71452-1-cgzones@googlemail.com>
References: <20230706145335.71452-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Drop unnecessary declarations.
More verbose error messages and add missing trailing newline.
More strict argument count checking.
Check closing file for incomplete write.
Rework resource cleanup, so that all files and allocated memory are
released in all branches, useful to minimize reports while debugging
libsepol under valgrind(8) or sanitizers.
Add help argument option -h.
Set close-on-exec flag in case of any sibling thread.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2:
  - address comment from Jim
    * avoid exit() calls
    * reduce to one final return statement
    * drop global variable progname
  - add help argument option
  - set close-on-exec flag
---
 semodule-utils/semodule_link/semodule_link.8 |  5 +-
 semodule-utils/semodule_link/semodule_link.c | 87 +++++++++++---------
 2 files changed, 53 insertions(+), 39 deletions(-)

diff --git a/semodule-utils/semodule_link/semodule_link.8 b/semodule-utils/semodule_link/semodule_link.8
index a2bda3f9..dba3d3b6 100644
--- a/semodule-utils/semodule_link/semodule_link.8
+++ b/semodule-utils/semodule_link/semodule_link.8
@@ -3,7 +3,7 @@
 semodule_link \- Link SELinux policy module packages together
 
 .SH SYNOPSIS
-.B semodule_link [-Vv] [-o outfile] basemodpkg modpkg1 [modpkg2]...
+.B semodule_link [-hVv] [-o outfile] basemodpkg modpkg1 [modpkg2]...
 .br
 .SH DESCRIPTION
 .PP
@@ -16,6 +16,9 @@ semodule_package.
 
 .SH "OPTIONS"
 .TP
+.B \-h
+show help
+.TP
 .B \-V
 show version
 .TP
diff --git a/semodule-utils/semodule_link/semodule_link.c b/semodule-utils/semodule_link/semodule_link.c
index 38a6843c..0f157bd9 100644
--- a/semodule-utils/semodule_link/semodule_link.c
+++ b/semodule-utils/semodule_link/semodule_link.c
@@ -21,18 +21,13 @@
 
 #define LINKPOLICY_VERSION "1.0"
 
-char *progname;
-extern char *optarg;
-extern int optind;
-
-static __attribute__((__noreturn__)) void usage(const char *program_name)
+static void usage(const char *program_name)
 {
-	printf("usage: %s [-Vv] [-o outfile] basemodpkg modpkg1 [modpkg2]...\n",
+	printf("usage: %s [-hVv] [-o outfile] basemodpkg modpkg1 [modpkg2]...\n",
 	       program_name);
-	exit(1);
 }
 
-static sepol_module_package_t *load_module(char *filename)
+static sepol_module_package_t *load_module(const char *filename, const char *progname)
 {
 	int ret;
 	FILE *fp = NULL;
@@ -47,9 +42,9 @@ static sepol_module_package_t *load_module(char *filename)
 		fprintf(stderr, "%s:  Out of memory\n", progname);
 		goto bad;
 	}
-	fp = fopen(filename, "r");
+	fp = fopen(filename, "re");
 	if (!fp) {
-		fprintf(stderr, "%s:  Could not open package %s:  %s", progname,
+		fprintf(stderr, "%s:  Could not open package %s:  %s\n", progname,
 			filename, strerror(errno));
 		goto bad;
 	}
@@ -76,16 +71,16 @@ static sepol_module_package_t *load_module(char *filename)
 
 int main(int argc, char **argv)
 {
-	int ch, i, show_version = 0, verbose = 0, num_mods;
-	char *basename, *outname = NULL;
-	sepol_module_package_t *base, **mods;
-	FILE *outfile;
-	struct sepol_policy_file *pf;
-
-	progname = argv[0];
+	int ch, i, ret, show_version = 0, verbose = 0, num_mods = 0;
+	const char *basename, *outname = NULL;
+	sepol_module_package_t *base = NULL, **mods = NULL;
+	struct sepol_policy_file *pf = NULL;
 
-	while ((ch = getopt(argc, argv, "o:Vv")) != EOF) {
+	while ((ch = getopt(argc, argv, "ho:Vv")) != EOF) {
 		switch (ch) {
+		case 'h':
+			usage(argv[0]);
+			return EXIT_SUCCESS;
 		case 'V':
 			show_version = 1;
 			break;
@@ -97,80 +92,96 @@ int main(int argc, char **argv)
 			break;
 		default:
 			usage(argv[0]);
+			return EXIT_FAILURE;
 		}
 	}
 
 	if (show_version) {
 		printf("%s\n", LINKPOLICY_VERSION);
-		exit(0);
+		return EXIT_SUCCESS;
 	}
 
 	/* check args */
-	if (argc < 3 || !(optind != (argc - 1))) {
+	if (argc < 3 || optind + 2 > argc) {
 		fprintf(stderr,
 			"%s:  You must provide the base module package and at least one other module package\n",
 			argv[0]);
 		usage(argv[0]);
+		return EXIT_FAILURE;
 	}
 
 	basename = argv[optind++];
-	base = load_module(basename);
+	base = load_module(basename, argv[0]);
 	if (!base) {
 		fprintf(stderr,
 			"%s:  Could not load base module from file %s\n",
 			argv[0], basename);
-		exit(1);
+		goto failure;
 	}
 
 	num_mods = argc - optind;
-	mods =
-	    (sepol_module_package_t **) malloc(sizeof(sepol_module_package_t *)
-					       * num_mods);
+	mods = calloc(num_mods, sizeof(sepol_module_package_t *));
 	if (!mods) {
 		fprintf(stderr, "%s:  Out of memory\n", argv[0]);
-		exit(1);
+		goto failure;
 	}
-	memset(mods, 0, sizeof(sepol_module_package_t *) * num_mods);
 
 	for (i = 0; optind < argc; optind++, i++) {
-		mods[i] = load_module(argv[optind]);
+		mods[i] = load_module(argv[optind], argv[0]);
 		if (!mods[i]) {
 			fprintf(stderr,
 				"%s:  Could not load module from file %s\n",
 				argv[0], argv[optind]);
-			exit(1);
+			goto failure;
 		}
 	}
 
 	if (sepol_link_packages(NULL, base, mods, num_mods, verbose)) {
 		fprintf(stderr, "%s:  Error while linking packages\n", argv[0]);
-		exit(1);
+		goto failure;
 	}
 
 	if (outname) {
-		outfile = fopen(outname, "w");
+		FILE *outfile = fopen(outname, "we");
 		if (!outfile) {
-			perror(outname);
-			exit(1);
+			fprintf(stderr, "%s:  Could not open output file %s:  %s\n",
+				argv[0], outname, strerror(errno));
+			goto failure;
 		}
 
 		if (sepol_policy_file_create(&pf)) {
 			fprintf(stderr, "%s:  Out of memory\n", argv[0]);
-			exit(1);
+			fclose(outfile);
+			goto failure;
 		}
 		sepol_policy_file_set_fp(pf, outfile);
 		if (sepol_module_package_write(base, pf)) {
 			fprintf(stderr, "%s:  Error writing linked package.\n",
 				argv[0]);
-			exit(1);
+			sepol_policy_file_free(pf);
+			fclose(outfile);
+			goto failure;
 		}
 		sepol_policy_file_free(pf);
-		fclose(outfile);
+
+		if (fclose(outfile)) {
+			fprintf(stderr, "%s:  Error closing linked package:  %s\n",
+				argv[0], strerror(errno));
+			goto failure;
+		}
 	}
 
-	sepol_module_package_free(base);
+	ret = EXIT_SUCCESS;
+	goto cleanup;
+
+failure:
+	ret = EXIT_FAILURE;
+
+cleanup:
 	for (i = 0; i < num_mods; i++)
 		sepol_module_package_free(mods[i]);
 	free(mods);
-	exit(0);
+	sepol_module_package_free(base);
+
+	return ret;
 }
-- 
2.40.1

