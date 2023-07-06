Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3432BEB64D9
	for <selinux@archiver.kernel.org>; Thu,  6 Jul 2023 14:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbjGFOyB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Jul 2023 10:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233641AbjGFOxv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Jul 2023 10:53:51 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFE31FD0
        for <selinux@vger.kernel.org>; Thu,  6 Jul 2023 07:53:42 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9923833737eso92350666b.3
        for <selinux@vger.kernel.org>; Thu, 06 Jul 2023 07:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1688655221; x=1691247221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bb3htgQgbIaeF0kcdRyAMMtzYpfuadImE65EPHDASck=;
        b=VN1vUR615ltlZfLEb6xTyB4t5EH7BiyrST1SFG3xbxeZO3TG8sBu5fIghIqeNb8fzj
         u8DEowhpdlSDg8tyRUEkjiwEFsxsrBWzXoW3yn2RKuFEQ5b2jzmR0VAWW9j2BNUYOYZB
         NNVvX6EvXVh3xVmJLohStqzBZz8S+8d+oi9gvhcYP0YMLWtyLJpX2ZRg/kJ2TnGtmQ6V
         +JHRfx2Wd/6ELiaio6liH1Eh7K85/plTBgLOErb50glwFBPfzJJ5dqip/RhhL8uADF/Z
         BYBEjQP0iym6t/fTULHQNqtCLienKXkCU1ybmwYB0J1YTs/3GDxGxV6yF7WdR4NuJR64
         nxWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688655221; x=1691247221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bb3htgQgbIaeF0kcdRyAMMtzYpfuadImE65EPHDASck=;
        b=cvYlmvYexYdgblxnk8VetJDN4j/R0V8zlgPKD3UpsCZcs30SVMupcHOIAx+3U3P3Jg
         XFAI9+nx9qqn227Of+6br8thsMka2gO83jkoXoFeyniHKvgB0Qb9lZq/X/xCJOd4Z6bU
         yjGPquL9m6etjpZUBy5UltvlFxgnq0tZrh7UvZ0hxf+LvkHwDaCN6ZPz3abZ92u/E+WN
         7E9B9VSwYlhFJKwupiTpxgmetvZiln82yqfoanh/S1Ydw5biqw9CWxLhDT32UpcxtOoA
         Tp0jcl5p67vaFLbQaJLOuMeOFkI6x8k0hSpPELHbEB/zr1tbx9VAoOVLbtQIN7Kw8APS
         opGQ==
X-Gm-Message-State: ABy/qLZesJeizcusvcWvUC3ndB6YDtjHVBKXIbR3cF4g7ysnF3BCsuRV
        GiEbwfigUo1SvvCgUBEGqTBpkKcs5p1cyh8R
X-Google-Smtp-Source: APBJJlHAqq/s0k78Zy21fCvIpbne9L6nrzshnm508g6g1aEHWDGmlN1blsLCsdGTImuv5jHJdrBXRg==
X-Received: by 2002:a17:906:3612:b0:97b:6c24:8d2b with SMTP id q18-20020a170906361200b0097b6c248d2bmr1632474ejb.55.1688655220973;
        Thu, 06 Jul 2023 07:53:40 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-008-088-179.77.8.pool.telefonica.de. [77.8.88.179])
        by smtp.gmail.com with ESMTPSA id va25-20020a17090711d900b00992e265495csm905659ejb.212.2023.07.06.07.53.40
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 07:53:40 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2 3/4] semodule_package: update
Date:   Thu,  6 Jul 2023 16:53:34 +0200
Message-Id: <20230706145335.71452-3-cgzones@googlemail.com>
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
Add missing error messages.
More strict command line argument parsing.
Check closing file for incomplete write.
Rework resource cleanup, so that all files and allocated memory are
released in all branches, useful to minimize reports while debugging
libsepol under valgrind(8) or sanitizers.
Set close-on-exec flag in case of any sibling thread.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2:
  - address comment from Jim
    * drop exit() calls
    * reduce to one final return statement
    * drop unnecessary ? option handling
    * drop global variable progname
  - set close-on-exec flag
---
 .../semodule_package/semodule_package.8       |   3 +
 .../semodule_package/semodule_package.c       | 227 +++++++++++-------
 2 files changed, 139 insertions(+), 91 deletions(-)

diff --git a/semodule-utils/semodule_package/semodule_package.8 b/semodule-utils/semodule_package/semodule_package.8
index 9697cc55..725d3d15 100644
--- a/semodule-utils/semodule_package/semodule_package.8
+++ b/semodule-utils/semodule_package/semodule_package.8
@@ -42,6 +42,9 @@ File contexts file for the module (optional).
 .TP
 .B  \-n \-\-nc <netfilter context file>
 netfilter context file to be included in the package.
+.TP
+.B  \-h \-\-help
+Show help message.
 
 .SH SEE ALSO
 .B checkmodule(8), semodule(8), semodule_unpackage(8)
diff --git a/semodule-utils/semodule_package/semodule_package.c b/semodule-utils/semodule_package/semodule_package.c
index bc8584b5..4cb6f5a3 100644
--- a/semodule-utils/semodule_package/semodule_package.c
+++ b/semodule-utils/semodule_package/semodule_package.c
@@ -19,10 +19,7 @@
 #include <fcntl.h>
 #include <errno.h>
 
-char *progname = NULL;
-extern char *optarg;
-
-static __attribute__((__noreturn__)) void usage(const char *prog)
+static void usage(const char *prog)
 {
 	printf("usage: %s -o <output file> -m <module> [-f <file contexts>]\n",
 	       prog);
@@ -34,34 +31,14 @@ static __attribute__((__noreturn__)) void usage(const char *prog)
 	printf
 	    ("  -u --user_extra	user_extra file (only valid in base)\n");
 	printf("  -n --nc		Netfilter contexts file\n");
-	exit(1);
+	printf("  -h --help		Show this help message\n");
 }
 
-static int file_to_policy_file(const char *filename, struct sepol_policy_file **pf,
-			       const char *mode)
-{
-	FILE *f;
-
-	if (sepol_policy_file_create(pf)) {
-		fprintf(stderr, "%s:  Out of memory\n", progname);
-		return -1;
-	}
-
-	f = fopen(filename, mode);
-	if (!f) {
-		fprintf(stderr, "%s:  Could not open file %s:  %s\n", progname,
-			strerror(errno), filename);
-		return -1;
-	}
-	sepol_policy_file_set_fp(*pf, f);
-	return 0;
-}
-
-static int file_to_data(const char *path, char **data, size_t * len)
+static int file_to_data(const char *path, char **data, size_t * len, const char *progname)
 {
 	int fd;
 	struct stat sb;
-	fd = open(path, O_RDONLY);
+	fd = open(path, O_RDONLY | O_CLOEXEC);
 	if (fd < 0) {
 		fprintf(stderr, "%s:  Failed to open %s:  %s\n", progname, path,
 			strerror(errno));
@@ -94,17 +71,18 @@ static int file_to_data(const char *path, char **data, size_t * len)
 
 int main(int argc, char **argv)
 {
-	struct sepol_module_package *pkg;
-	struct sepol_policy_file *mod, *out;
+	struct sepol_module_package *pkg = NULL;
+	struct sepol_policy_file *mod = NULL, *out = NULL;
+	FILE *fp = NULL;
 	char *module = NULL, *file_contexts = NULL, *seusers =
 	    NULL, *user_extra = NULL;
 	char *fcdata = NULL, *outfile = NULL, *seusersdata =
 	    NULL, *user_extradata = NULL;
 	char *netfilter_contexts = NULL, *ncdata = NULL;
 	size_t fclen = 0, seuserslen = 0, user_extralen = 0, nclen = 0;
-	int i;
+	int i, ret;
 
-	static struct option opts[] = {
+	const struct option opts[] = {
 		{"module", required_argument, NULL, 'm'},
 		{"fc", required_argument, NULL, 'f'},
 		{"seuser", required_argument, NULL, 's'},
@@ -119,146 +97,213 @@ int main(int argc, char **argv)
 		switch (i) {
 		case 'h':
 			usage(argv[0]);
-			exit(0);
+			return EXIT_SUCCESS;
 		case 'm':
 			if (module) {
 				fprintf(stderr,
 					"May not specify more than one module\n");
-				exit(1);
+				return EXIT_FAILURE;
 			}
 			module = strdup(optarg);
-			if (!module)
-				exit(1);
+			if (!module) {
+				fprintf(stderr, "%s:  Out of memory\n", argv[0]);
+				return EXIT_FAILURE;
+			}
 			break;
 		case 'f':
 			if (file_contexts) {
 				fprintf(stderr,
 					"May not specify more than one file context file\n");
-				exit(1);
+				return EXIT_FAILURE;
 			}
 			file_contexts = strdup(optarg);
-			if (!file_contexts)
-				exit(1);
+			if (!file_contexts) {
+				fprintf(stderr, "%s:  Out of memory\n", argv[0]);
+				return EXIT_FAILURE;
+			}
 			break;
 		case 'o':
 			if (outfile) {
 				fprintf(stderr,
 					"May not specify more than one output file\n");
-				exit(1);
+				return EXIT_FAILURE;
 			}
 			outfile = strdup(optarg);
-			if (!outfile)
-				exit(1);
+			if (!outfile) {
+				fprintf(stderr, "%s:  Out of memory\n", argv[0]);
+				return EXIT_FAILURE;
+			}
 			break;
 		case 's':
 			if (seusers) {
 				fprintf(stderr,
 					"May not specify more than one seuser file\n");
-				exit(1);
+				return EXIT_FAILURE;
 			}
 			seusers = strdup(optarg);
-			if (!seusers)
-				exit(1);
+			if (!seusers) {
+				fprintf(stderr, "%s:  Out of memory\n", argv[0]);
+				return EXIT_FAILURE;
+			}
 			break;
 		case 'u':
 			if (user_extra) {
 				fprintf(stderr,
 					"May not specify more than one user_extra file\n");
-				exit(1);
+				return EXIT_FAILURE;
 			}
 			user_extra = strdup(optarg);
-			if (!user_extra)
-				exit(1);
+			if (!user_extra) {
+				fprintf(stderr, "%s:  Out of memory\n", argv[0]);
+				return EXIT_FAILURE;
+			}
 			break;
 		case 'n':
 			if (netfilter_contexts) {
 				fprintf(stderr,
 					"May not specify more than one netfilter contexts file\n");
-				exit(1);
+				return EXIT_FAILURE;
 			}
 			netfilter_contexts = strdup(optarg);
-			if (!netfilter_contexts)
-				exit(1);
+			if (!netfilter_contexts) {
+				fprintf(stderr, "%s:  Out of memory\n", argv[0]);
+				return EXIT_FAILURE;
+			}
 			break;
+		default:
+			usage(argv[0]);
+			return EXIT_FAILURE;
 		}
 	}
 
-	progname = argv[0];
+	if (optind < argc) {
+		fprintf(stderr, "%s:  Superfluous command line arguments: ", argv[0]);
+		while (optind < argc)
+			 fprintf(stderr, "%s ", argv[optind++]);
+		fprintf(stderr, "\n");
+		usage(argv[0]);
+		return EXIT_FAILURE;
+	}
 
 	if (!module || !outfile) {
 		usage(argv[0]);
-		exit(0);
+		return EXIT_FAILURE;
 	}
 
-	if (file_contexts) {
-		if (file_to_data(file_contexts, &fcdata, &fclen))
-			exit(1);
-	}
+	if (file_contexts && file_to_data(file_contexts, &fcdata, &fclen, argv[0]))
+		goto failure;
 
-	if (seusers) {
-		if (file_to_data(seusers, &seusersdata, &seuserslen))
-			exit(1);
-	}
+	if (seusers && file_to_data(seusers, &seusersdata, &seuserslen, argv[0]))
+		goto failure;
 
-	if (user_extra) {
-		if (file_to_data(user_extra, &user_extradata, &user_extralen))
-			exit(1);
-	}
+	if (user_extra && file_to_data(user_extra, &user_extradata, &user_extralen, argv[0]))
+		goto failure;
+
+	if (netfilter_contexts && file_to_data(netfilter_contexts, &ncdata, &nclen, argv[0]))
+		goto failure;
 
-	if (netfilter_contexts) {
-		if (file_to_data(netfilter_contexts, &ncdata, &nclen))
-			exit(1);
+	if (sepol_policy_file_create(&mod)) {
+		fprintf(stderr, "%s:  Out of memory\n", argv[0]);
+		goto failure;
 	}
 
-	if (file_to_policy_file(module, &mod, "r"))
-		exit(1);
+	fp = fopen(module, "re");
+	if (!fp) {
+		fprintf(stderr, "%s:  Could not open file %s:  %s\n", argv[0],
+			module, strerror(errno));
+		goto failure;
+	}
+	sepol_policy_file_set_fp(mod, fp);
 
 	if (sepol_module_package_create(&pkg)) {
 		fprintf(stderr, "%s:  Out of memory\n", argv[0]);
-		exit(1);
+		goto failure;
 	}
 
 	if (sepol_policydb_read(sepol_module_package_get_policy(pkg), mod)) {
 		fprintf(stderr,
 			"%s:  Error while reading policy module from %s\n",
 			argv[0], module);
-		exit(1);
+		goto failure;
 	}
 
-	if (fclen)
-		sepol_module_package_set_file_contexts(pkg, fcdata, fclen);
+	fclose(fp);
+	fp = NULL;
 
-	if (seuserslen)
-		sepol_module_package_set_seusers(pkg, seusersdata, seuserslen);
+	if (fclen && sepol_module_package_set_file_contexts(pkg, fcdata, fclen)) {
+		fprintf(stderr, "%s:  Error while setting file contexts\n", argv[0]);
+		goto failure;
+	}
 
-	if (user_extra)
-		sepol_module_package_set_user_extra(pkg, user_extradata,
-						    user_extralen);
+	if (seuserslen && sepol_module_package_set_seusers(pkg, seusersdata, seuserslen)) {
+		fprintf(stderr, "%s:  Error while setting seusers\n", argv[0]);
+		goto failure;
+	}
 
-	if (nclen)
-		sepol_module_package_set_netfilter_contexts(pkg, ncdata, nclen);
+	if (user_extra && sepol_module_package_set_user_extra(pkg, user_extradata, user_extralen)) {
+		fprintf(stderr, "%s:  Error while setting extra users\n", argv[0]);
+		goto failure;
+	}
+
+	if (nclen && sepol_module_package_set_netfilter_contexts(pkg, ncdata, nclen)) {
+		fprintf(stderr, "%s:  Error while setting netfilter contexts\n", argv[0]);
+		goto failure;
+	}
 
-	if (file_to_policy_file(outfile, &out, "w"))
-		exit(1);
+	if (sepol_policy_file_create(&out)) {
+		fprintf(stderr, "%s:  Out of memory\n", argv[0]);
+		goto failure;
+	}
+
+	fp = fopen(outfile, "we");
+	if (!fp) {
+		fprintf(stderr, "%s:  Could not open file %s:  %s\n", argv[0],
+			outfile, strerror(errno));
+		goto failure;
+	}
+	sepol_policy_file_set_fp(out, fp);
 
 	if (sepol_module_package_write(pkg, out)) {
 		fprintf(stderr,
 			"%s:  Error while writing module package to %s\n",
 			argv[0], argv[1]);
-		exit(1);
+		goto failure;
 	}
 
-	if (fclen)
-		munmap(fcdata, fclen);
+	ret = fclose(fp);
+	fp = NULL;
+	if (ret) {
+		fprintf(stderr, "%s:  Could not close file %s:  %s\n", argv[0],
+			outfile, strerror(errno));
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
+	if (fp)
+		fclose(fp);
+	sepol_policy_file_free(out);
 	if (nclen)
 		munmap(ncdata, nclen);
-	sepol_policy_file_free(mod);
-	sepol_policy_file_free(out);
+	if (user_extradata)
+		munmap(user_extradata, user_extralen);
+	if (seuserslen)
+		munmap(seusersdata, seuserslen);
+	if (fclen)
+		munmap(fcdata, fclen);
 	sepol_module_package_free(pkg);
-	free(file_contexts);
+	sepol_policy_file_free(mod);
+	free(netfilter_contexts);
+	free(user_extra);
+	free(seusers);
 	free(outfile);
+	free(file_contexts);
 	free(module);
-	free(seusers);
-	free(user_extra);
-	exit(0);
+
+	return ret;
 }
-- 
2.40.1

