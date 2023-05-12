Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE96DC77B7C
	for <selinux@archiver.kernel.org>; Fri, 12 May 2023 11:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240546AbjELLHk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 12 May 2023 07:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240091AbjELLHk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 12 May 2023 07:07:40 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8414C1F
        for <selinux@vger.kernel.org>; Fri, 12 May 2023 04:07:37 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-50bc22805d3so14864813a12.1
        for <selinux@vger.kernel.org>; Fri, 12 May 2023 04:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1683889656; x=1686481656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CE2efAKMBmF3jP0rKtjqoFVIPFNvp/HlcNe0SSC0aD4=;
        b=Qunp6CUpgIpLMmIhIsRXXkyjw4f3O8n0NyaTLiXGKqoJ+CZOUon4gNdjXnsfRqdjjm
         SW65vGFsDZMtRhhgjulanV0zUAAaD4QBs59/oVhd3obGQzh8jkpgJe0raQlDdy7VwAmT
         PbWaneezsoDTWwR114cPJAOxUug0TtnBgWXXm6b2pe9tkqVmtbh+uAHpQ0v0ImNs7hPo
         GVHplaUt7szcwKUtAa48Dkxlm5o5CVdjIEVi+0yopAVp5ZOAOy4EjG6hyqiQniTYPfiT
         IXePz4z115MHAK4f/q/KVs4B14GWzvYf7Vcx+UwpOKl8GH6I/XXUymWNQgM4LtG5vLR1
         EnUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683889656; x=1686481656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CE2efAKMBmF3jP0rKtjqoFVIPFNvp/HlcNe0SSC0aD4=;
        b=VJI1UNZDcOYK+diyCxhq0xNWFKCyPat8NtZ6k3GCwEQAmaUSrgU0bIHTaXZak1N+nI
         Cj/LCnNIoRNSLGNLUUFglSMUwjlJlwyrd89PBo6v7RBRqOlDIEC9vy0kRibRQklYQXO1
         QB1SmUe5o4bxDNP7NDyA/aBLFSbBupXiLYFT/yuJDfOsJBwf8VByhrNFMgwOVUQVlCq3
         uglX5ibMeexdyjs8ulAhYk8g03ug0ssypZ2E4GYfjWh7ZTzZFQSXGoztZu98WV3tMmL4
         O48o9nIftwmueZlorzHcLYPnFQgO3kQFIhKCMcZ1mtPnzeZcdlA7HNFE3px65acKDvGR
         IbVg==
X-Gm-Message-State: AC+VfDwPSDY6fFR+jaMLuSU/IAslmAk2iebHA18HFVDMpEncls9L/clp
        neQfY8pCHvkAcAEhdo8IHUTWvf+DuolFRg==
X-Google-Smtp-Source: ACHHUZ64RJtDnPfOx3r2Jt5SbkGCowDYTzys7gpVJuFFKTZKpumFm6Y60TwTJCAQ6Pad3JkEfBbsAw==
X-Received: by 2002:a05:6402:150e:b0:50d:dcaa:6b7f with SMTP id f14-20020a056402150e00b0050ddcaa6b7fmr6783828edw.20.1683889656112;
        Fri, 12 May 2023 04:07:36 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-116-181-041.95.116.pool.telefonica.de. [95.116.181.41])
        by smtp.gmail.com with ESMTPSA id o11-20020aa7c7cb000000b0050bde945c00sm3812016eds.78.2023.05.12.04.07.35
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 04:07:35 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 3/4] semodule_package: update
Date:   Fri, 12 May 2023 13:07:29 +0200
Message-Id: <20230512110730.78672-3-cgzones@googlemail.com>
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
Add missing error messages.
More strict command line argument parsing.
Check closing file for incomplete write.
Rework resource cleanup, so that all files and allocated memory are
released in all branches, useful to minimize reports while debugging
libsepol under valgrind(8) or sanitizers.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 .../semodule_package/semodule_package.c       | 203 +++++++++++-------
 1 file changed, 125 insertions(+), 78 deletions(-)

diff --git a/semodule-utils/semodule_package/semodule_package.c b/semodule-utils/semodule_package/semodule_package.c
index bc8584b5..7485e254 100644
--- a/semodule-utils/semodule_package/semodule_package.c
+++ b/semodule-utils/semodule_package/semodule_package.c
@@ -19,8 +19,7 @@
 #include <fcntl.h>
 #include <errno.h>
 
-char *progname = NULL;
-extern char *optarg;
+static const char *progname = NULL;
 
 static __attribute__((__noreturn__)) void usage(const char *prog)
 {
@@ -37,26 +36,6 @@ static __attribute__((__noreturn__)) void usage(const char *prog)
 	exit(1);
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
 static int file_to_data(const char *path, char **data, size_t * len)
 {
 	int fd;
@@ -94,17 +73,18 @@ static int file_to_data(const char *path, char **data, size_t * len)
 
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
@@ -115,11 +95,12 @@ int main(int argc, char **argv)
 		{NULL, 0, NULL, 0}
 	};
 
+	progname = argv[0];
+
 	while ((i = getopt_long(argc, argv, "m:f:s:u:o:n:h", opts, NULL)) != -1) {
 		switch (i) {
 		case 'h':
-			usage(argv[0]);
-			exit(0);
+			usage(progname);
 		case 'm':
 			if (module) {
 				fprintf(stderr,
@@ -127,8 +108,10 @@ int main(int argc, char **argv)
 				exit(1);
 			}
 			module = strdup(optarg);
-			if (!module)
+			if (!module) {
+				fprintf(stderr, "%s:  Out of memory\n", progname);
 				exit(1);
+			}
 			break;
 		case 'f':
 			if (file_contexts) {
@@ -137,8 +120,10 @@ int main(int argc, char **argv)
 				exit(1);
 			}
 			file_contexts = strdup(optarg);
-			if (!file_contexts)
+			if (!file_contexts) {
+				fprintf(stderr, "%s:  Out of memory\n", progname);
 				exit(1);
+			}
 			break;
 		case 'o':
 			if (outfile) {
@@ -147,8 +132,10 @@ int main(int argc, char **argv)
 				exit(1);
 			}
 			outfile = strdup(optarg);
-			if (!outfile)
+			if (!outfile) {
+				fprintf(stderr, "%s:  Out of memory\n", progname);
 				exit(1);
+			}
 			break;
 		case 's':
 			if (seusers) {
@@ -157,8 +144,10 @@ int main(int argc, char **argv)
 				exit(1);
 			}
 			seusers = strdup(optarg);
-			if (!seusers)
+			if (!seusers) {
+				fprintf(stderr, "%s:  Out of memory\n", progname);
 				exit(1);
+			}
 			break;
 		case 'u':
 			if (user_extra) {
@@ -167,8 +156,10 @@ int main(int argc, char **argv)
 				exit(1);
 			}
 			user_extra = strdup(optarg);
-			if (!user_extra)
+			if (!user_extra) {
+				fprintf(stderr, "%s:  Out of memory\n", progname);
 				exit(1);
+			}
 			break;
 		case 'n':
 			if (netfilter_contexts) {
@@ -177,88 +168,144 @@ int main(int argc, char **argv)
 				exit(1);
 			}
 			netfilter_contexts = strdup(optarg);
-			if (!netfilter_contexts)
+			if (!netfilter_contexts) {
+				fprintf(stderr, "%s:  Out of memory\n", progname);
 				exit(1);
+			}
 			break;
+		case '?':
+			usage(progname);
+		default:
+			fprintf(stderr, "%s:  Unsupported getopt return code: %d\n", progname, i);
+			usage(progname);
 		}
 	}
 
-	progname = argv[0];
-
-	if (!module || !outfile) {
-		usage(argv[0]);
-		exit(0);
+	if (optind < argc) {
+		fprintf(stderr, "%s:  Superfluous command line arguments: ", progname);
+		 while (optind < argc)
+			 fprintf(stderr, "%s ", argv[optind++]);
+		fprintf(stderr, "\n");
+		usage(progname);
 	}
 
-	if (file_contexts) {
-		if (file_to_data(file_contexts, &fcdata, &fclen))
-			exit(1);
-	}
+	if (!module || !outfile)
+		usage(progname);
 
-	if (seusers) {
-		if (file_to_data(seusers, &seusersdata, &seuserslen))
-			exit(1);
-	}
+	if (file_contexts && file_to_data(file_contexts, &fcdata, &fclen))
+		goto failure;
 
-	if (user_extra) {
-		if (file_to_data(user_extra, &user_extradata, &user_extralen))
-			exit(1);
-	}
+	if (seusers && file_to_data(seusers, &seusersdata, &seuserslen))
+		goto failure;
+
+	if (user_extra && file_to_data(user_extra, &user_extradata, &user_extralen))
+		goto failure;
 
-	if (netfilter_contexts) {
-		if (file_to_data(netfilter_contexts, &ncdata, &nclen))
-			exit(1);
+	if (netfilter_contexts && file_to_data(netfilter_contexts, &ncdata, &nclen))
+		goto failure;
+
+	if (sepol_policy_file_create(&mod)) {
+		fprintf(stderr, "%s:  Out of memory\n", progname);
+		goto failure;
 	}
 
-	if (file_to_policy_file(module, &mod, "r"))
-		exit(1);
+	fp = fopen(module, "r");
+	if (!fp) {
+		fprintf(stderr, "%s:  Could not open file %s:  %s\n", progname,
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
+		fprintf(stderr, "%s:  Error while setting file contexts\n", progname);
+		goto failure;
+	}
 
-	if (user_extra)
-		sepol_module_package_set_user_extra(pkg, user_extradata,
-						    user_extralen);
+	if (seuserslen && sepol_module_package_set_seusers(pkg, seusersdata, seuserslen)) {
+		fprintf(stderr, "%s:  Error while setting seusers\n", progname);
+		goto failure;
+	}
 
-	if (nclen)
-		sepol_module_package_set_netfilter_contexts(pkg, ncdata, nclen);
+	if (user_extra && sepol_module_package_set_user_extra(pkg, user_extradata, user_extralen)) {
+		fprintf(stderr, "%s:  Error while setting extra users\n", progname);
+		goto failure;
+	}
+
+	if (nclen && sepol_module_package_set_netfilter_contexts(pkg, ncdata, nclen)) {
+		fprintf(stderr, "%s:  Error while setting netfilter contexts\n", progname);
+		goto failure;
+	}
+
+	if (sepol_policy_file_create(&out)) {
+		fprintf(stderr, "%s:  Out of memory\n", progname);
+		goto failure;
+	}
 
-	if (file_to_policy_file(outfile, &out, "w"))
-		exit(1);
+	fp = fopen(outfile, "w");
+	if (!fp) {
+		fprintf(stderr, "%s:  Could not open file %s:  %s\n", progname,
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
+		fprintf(stderr, "%s:  Could not close file %s:  %s\n", progname,
+			outfile, strerror(errno));
+		goto failure;
+	}
+
+	ret = EXIT_SUCCESS;
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
+
+failure:
+	ret = EXIT_FAILURE;
+	goto cleanup;
 }
-- 
2.40.1

