Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E362C77B7F
	for <selinux@archiver.kernel.org>; Fri, 12 May 2023 11:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239919AbjELLHj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 12 May 2023 07:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240091AbjELLHi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 12 May 2023 07:07:38 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB7F10C
        for <selinux@vger.kernel.org>; Fri, 12 May 2023 04:07:37 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-965ddb2093bso1413727066b.2
        for <selinux@vger.kernel.org>; Fri, 12 May 2023 04:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1683889655; x=1686481655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nFiuVsxKFUZx7E8GAEhGTXPdCZlmj4NaqGM1VUvD2lI=;
        b=HWq9iz6IIfax5hFx+D0bhpy55tEWPaF7EogLMClVadfVq7W/9fQdEB3ySxwbWMd6td
         KbGi8HSTxpAO8e7Qx1ULS9SWGg5o4tb6w6Wy/XJtnE3uCZHiGJowYBRIxgyQWRS6YhJ6
         Kwpg1BeMcWf9wRIawz8keP7AYyNnNvfrBYBMpQqW8VXwY0BLmY9RZVfH0En1zTRmmMi+
         kLP1s6FHve+WgUQe+EmdKsTSh++RGzpwnRIaJTMxMvfpfCUJhKfPRlveE7qcBszQHXqb
         yZMzkfOGvpphOw4zof8fGzq40F3zG87/bPelUgCMM8Y9iVPDLIPU2NKadcK/UjJN4acC
         6FMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683889655; x=1686481655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nFiuVsxKFUZx7E8GAEhGTXPdCZlmj4NaqGM1VUvD2lI=;
        b=iILSY05CihIfb+Z01n6YwM/gSm5df+7fFwPQZIHIXWZLPOUIjJ1Eyf6YfOMmeu0c0R
         oW24OIUk1CUQ5KWyeXn+LhvqelpTkn37EB24n60DFvPftPWhXkjNKT31YzeNBq3V7bxh
         WEMiRrwSoVBTj9v5xY40e3pzKfmIL0G95pX3fxkm93zwyyboZvJzT/ehgonU3EaPTOEE
         ghNE8c7Rwsc2KuxihF3bx9ChOaWWe4b8JPVkqNx6P6hwTX0aW1b5/uqK3TbSYm3FE4H7
         tcnZVqkLv0tO9MF7zmpGXYbtttymshT+3eL3WLqn06NtlouzGfnsCPkh5GG94yf3du0p
         Uyiw==
X-Gm-Message-State: AC+VfDzFg8rQ5AQDYXhLmoHAWKW/kkXMJx2FMILuN9JQ5wM2mKXrKw9Y
        42HN7IDY7TZ6tVNFl2/scaX4wRXIPkRIEw==
X-Google-Smtp-Source: ACHHUZ7kn6PMENFEZIf86XfN7Nu9nOK+3plONmJhMXxZu3yxlvnIgeAB7g/2QTxWKq2S6XUEXT2Hdw==
X-Received: by 2002:a17:907:9488:b0:96a:a0fd:d43e with SMTP id dm8-20020a170907948800b0096aa0fdd43emr1953720ejc.49.1683889655371;
        Fri, 12 May 2023 04:07:35 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-116-181-041.95.116.pool.telefonica.de. [95.116.181.41])
        by smtp.gmail.com with ESMTPSA id o11-20020aa7c7cb000000b0050bde945c00sm3812016eds.78.2023.05.12.04.07.34
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 04:07:34 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 2/4] semodule_link: update
Date:   Fri, 12 May 2023 13:07:28 +0200
Message-Id: <20230512110730.78672-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230512110730.78672-1-cgzones@googlemail.com>
References: <20230512110730.78672-1-cgzones@googlemail.com>
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

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 semodule-utils/semodule_link/semodule_link.c | 65 ++++++++++++--------
 1 file changed, 38 insertions(+), 27 deletions(-)

diff --git a/semodule-utils/semodule_link/semodule_link.c b/semodule-utils/semodule_link/semodule_link.c
index 38a6843c..58a82cb0 100644
--- a/semodule-utils/semodule_link/semodule_link.c
+++ b/semodule-utils/semodule_link/semodule_link.c
@@ -21,9 +21,7 @@
 
 #define LINKPOLICY_VERSION "1.0"
 
-char *progname;
-extern char *optarg;
-extern int optind;
+static const char *progname;
 
 static __attribute__((__noreturn__)) void usage(const char *program_name)
 {
@@ -32,7 +30,7 @@ static __attribute__((__noreturn__)) void usage(const char *program_name)
 	exit(1);
 }
 
-static sepol_module_package_t *load_module(char *filename)
+static sepol_module_package_t *load_module(const char *filename)
 {
 	int ret;
 	FILE *fp = NULL;
@@ -49,7 +47,7 @@ static sepol_module_package_t *load_module(char *filename)
 	}
 	fp = fopen(filename, "r");
 	if (!fp) {
-		fprintf(stderr, "%s:  Could not open package %s:  %s", progname,
+		fprintf(stderr, "%s:  Could not open package %s:  %s\n", progname,
 			filename, strerror(errno));
 		goto bad;
 	}
@@ -76,11 +74,10 @@ static sepol_module_package_t *load_module(char *filename)
 
 int main(int argc, char **argv)
 {
-	int ch, i, show_version = 0, verbose = 0, num_mods;
-	char *basename, *outname = NULL;
-	sepol_module_package_t *base, **mods;
-	FILE *outfile;
-	struct sepol_policy_file *pf;
+	int ch, i, ret, show_version = 0, verbose = 0, num_mods = 0;
+	const char *basename, *outname = NULL;
+	sepol_module_package_t *base = NULL, **mods = NULL;
+	struct sepol_policy_file *pf = NULL;
 
 	progname = argv[0];
 
@@ -106,7 +103,7 @@ int main(int argc, char **argv)
 	}
 
 	/* check args */
-	if (argc < 3 || !(optind != (argc - 1))) {
+	if (argc < 3 || optind + 2 > argc) {
 		fprintf(stderr,
 			"%s:  You must provide the base module package and at least one other module package\n",
 			argv[0]);
@@ -119,18 +116,15 @@ int main(int argc, char **argv)
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
 		mods[i] = load_module(argv[optind]);
@@ -138,39 +132,56 @@ int main(int argc, char **argv)
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
+		FILE *outfile = fopen(outname, "w");
 		if (!outfile) {
-			perror(outname);
-			exit(1);
+			fprintf(stderr, "%s:  Could not open output file %s:  %s\n",
+				progname, outname, strerror(errno));
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
+
+cleanup:
 	for (i = 0; i < num_mods; i++)
 		sepol_module_package_free(mods[i]);
 	free(mods);
-	exit(0);
+	sepol_module_package_free(base);
+
+	return ret;
+
+failure:
+	ret = EXIT_FAILURE;
+	goto cleanup;
 }
-- 
2.40.1

