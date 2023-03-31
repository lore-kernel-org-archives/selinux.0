Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB10C761A6
	for <selinux@archiver.kernel.org>; Fri, 31 Mar 2023 17:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbjCaRfI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 Mar 2023 13:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjCaRfH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 Mar 2023 13:35:07 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4180B1E718
        for <selinux@vger.kernel.org>; Fri, 31 Mar 2023 10:35:06 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id h8so92601323ede.8
        for <selinux@vger.kernel.org>; Fri, 31 Mar 2023 10:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112; t=1680284105;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=gWIzJNhIhCHy8SJIB0mB5mC6ccpzgVRifADrYuM4Tb4=;
        b=N/b3Jzlvdg4jxOO+ZD3wNCosxdVakJgZJvDw9+urUfxm/fGaaVA13Yg6/29U0HfiOe
         7bXSmHzDR3eIBLjX34lbMhZFnOoQOnO3B4aJN/Sltdl1r+mZDmA5fEyC2QNe8uldfDoa
         n7UJUFXQJYA94Oroyo+HqWXeBma/Q5Ldkoie5lBHMWRyORZ3oHovi6et8j+guUrZ+fmN
         PivY6Spd0TrHVlynYbEFHjDHPVJKGnbM+4PZrkLn8he+RnDorm44deOCs69VZpW3GVOF
         NNRUs/DeXul6MTMbRBmEIuusM+cx624cWGgXZy1j1Rvu1QaNk7Z5y0+d3/V21sDtJurY
         tYGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680284105;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gWIzJNhIhCHy8SJIB0mB5mC6ccpzgVRifADrYuM4Tb4=;
        b=mgDUmJj16jLsLkh8yi3+WkLjT9/RM5zN5IqA5PqEG2uZZXdJhDIBEeuufkHK2RNyry
         47qPArGEvWrxL1ITrS+pNLeOGIuUsaf0qLg9YTUXafbby0H3GvLGtUUR+/D0HdnK06wa
         Ju4k0zDjB3V5Je9JoHi59lNGmz2aOZEDZEdhsfXSO9yRMfcFZosl9KZlssd3K9Ht75W0
         Gzo+jxqLu2lKyd6KSx1epotE8MDxUeAWG+18/6KCIdZg+SQMpao7oI7jC55Jh1kZXwRT
         /acpsoN3UyM1XBNwE7RO6DTnwIZrN92CV1iLJubyWvMMDY409efytBYdXhTeXZVDmlOx
         MFBw==
X-Gm-Message-State: AAQBX9cW0CEMc842WRsoYOJbYyhlje2oYTX/ldJ7/UaguHJoov0u2lza
        eI4JsCvn+9n14s37vqnI9pobyN5Gd/Lph3qV
X-Google-Smtp-Source: AKy350bx1PgtUzcpyHBbvIC2cvTLTbrg9aCmIk493o8Kc7Zcu9otIvs/wmqOe/wldG8qUGIsz+XGXQ==
X-Received: by 2002:a17:906:2b8e:b0:946:c022:8979 with SMTP id m14-20020a1709062b8e00b00946c0228979mr15912962ejg.21.1680284104675;
        Fri, 31 Mar 2023 10:35:04 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-010-126-250.77.10.pool.telefonica.de. [77.10.126.250])
        by smtp.gmail.com with ESMTPSA id h5-20020a50c385000000b004ad601533a3sm1303138edf.55.2023.03.31.10.35.04
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 10:35:04 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/3] checkpolicy: add option to skip checking neverallow rules
Date:   Fri, 31 Mar 2023 19:34:40 +0200
Message-Id: <20230331173442.101678-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add the command line argument `-N/--disable-neverallow`, similar to
secilc(8), to checkpolicy(8) and checkmodule(8) to skip the check of
neverallow rule violations.

This is mainly useful in development, e.g. to quickly add rules to a
policy without fulfilling all neverallow rules or build policies with
known violations.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/checkmodule.8 |  5 ++++-
 checkpolicy/checkmodule.c | 13 +++++++++----
 checkpolicy/checkpolicy.8 |  5 ++++-
 checkpolicy/checkpolicy.c | 12 ++++++++----
 4 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/checkpolicy/checkmodule.8 b/checkpolicy/checkmodule.8
index 1061a6f2..ed9efd4c 100644
--- a/checkpolicy/checkmodule.8
+++ b/checkpolicy/checkmodule.8
@@ -3,7 +3,7 @@
 checkmodule \- SELinux policy module compiler
 .SH SYNOPSIS
 .B checkmodule
-.I "[\-h] [\-b] [\-c policy_version] [\-C] [\-E] [\-m] [\-M] [\-U handle_unknown] [\-V] [\-o output_file] [input_file]"
+.I "[\-h] [\-b] [\-c policy_version] [\-C] [\-E] [\-m] [\-M] [\-N] [\-U handle_unknown] [\-V] [\-o output_file] [input_file]"
 .SH "DESCRIPTION"
 This manual page describes the
 .BR checkmodule
@@ -43,6 +43,9 @@ Generate a non-base policy module.
 .B \-M,\-\-mls
 Enable the MLS/MCS support when checking and compiling the policy module.
 .TP
+.B \-N,\-\-disable-neverallow
+Do not check neverallow rules.
+.TP
 .B \-V,\-\-version
 Show policy versions created by this program.
 .TP
diff --git a/checkpolicy/checkmodule.c b/checkpolicy/checkmodule.c
index 3432608b..4f0d7bbe 100644
--- a/checkpolicy/checkmodule.c
+++ b/checkpolicy/checkmodule.c
@@ -123,7 +123,7 @@ static int write_binary_policy(policydb_t * p, FILE *outfp)
 
 static __attribute__((__noreturn__)) void usage(const char *progname)
 {
-	printf("usage:  %s [-h] [-V] [-b] [-C] [-E] [-U handle_unknown] [-m] [-M] [-o FILE] [-c VERSION] [INPUT]\n", progname);
+	printf("usage:  %s [-h] [-V] [-b] [-C] [-E] [-U handle_unknown] [-m] [-M] [-N] [-o FILE] [-c VERSION] [INPUT]\n", progname);
 	printf("Build base and policy modules.\n");
 	printf("Options:\n");
 	printf("  INPUT      build module from INPUT (else read from \"%s\")\n",
@@ -139,6 +139,7 @@ static __attribute__((__noreturn__)) void usage(const char *progname)
 	printf("               allow: Allow unknown kernel checks\n");
 	printf("  -m         build a policy module instead of a base module\n");
 	printf("  -M         enable MLS policy\n");
+	printf("  -N         do not check neverallow rules\n");
 	printf("  -o FILE    write module to FILE (else just check syntax)\n");
 	printf("  -c VERSION build a policy module targeting a modular policy version (%d-%d)\n",
 	       MOD_POLICYDB_VERSION_MIN, MOD_POLICYDB_VERSION_MAX);
@@ -148,7 +149,7 @@ static __attribute__((__noreturn__)) void usage(const char *progname)
 int main(int argc, char **argv)
 {
 	const char *file = txtfile, *outfile = NULL;
-	unsigned int binary = 0, cil = 0;
+	unsigned int binary = 0, cil = 0, check_neverallow = 1;
 	int ch;
 	int show_version = 0;
 	policydb_t modpolicydb;
@@ -159,12 +160,13 @@ int main(int argc, char **argv)
 		{"version", no_argument, NULL, 'V'},
 		{"handle-unknown", required_argument, NULL, 'U'},
 		{"mls", no_argument, NULL, 'M'},
+		{"disable-neverallow", no_argument, NULL, 'N'},
 		{"cil", no_argument, NULL, 'C'},
 		{"werror", no_argument, NULL, 'E'},
 		{NULL, 0, NULL, 0}
 	};
 
-	while ((ch = getopt_long(argc, argv, "ho:bVEU:mMCc:", long_options, NULL)) != -1) {
+	while ((ch = getopt_long(argc, argv, "ho:bVEU:mMNCc:", long_options, NULL)) != -1) {
 		switch (ch) {
 		case 'h':
 			usage(argv[0]);
@@ -202,6 +204,9 @@ int main(int argc, char **argv)
 		case 'M':
 			mlspol = 1;
 			break;
+		case 'N':
+			check_neverallow = 0;
+			break;
 		case 'C':
 			cil = 1;
 			break;
@@ -317,7 +322,7 @@ int main(int argc, char **argv)
 			fprintf(stderr, "%s:  link modules failed\n", argv[0]);
 			exit(1);
 		}
-		if (expand_module(NULL, &modpolicydb, &kernpolicydb, 0, 1)) {
+		if (expand_module(NULL, &modpolicydb, &kernpolicydb, /*verbose=*/0, check_neverallow)) {
 			fprintf(stderr, "%s:  expand module failed\n", argv[0]);
 			exit(1);
 		}
diff --git a/checkpolicy/checkpolicy.8 b/checkpolicy/checkpolicy.8
index 2984c238..c66e084b 100644
--- a/checkpolicy/checkpolicy.8
+++ b/checkpolicy/checkpolicy.8
@@ -3,7 +3,7 @@
 checkpolicy \- SELinux policy compiler
 .SH SYNOPSIS
 .B checkpolicy
-.I "[\-b[F]] [\-C] [\-d] [\-U handle_unknown (allow,deny,reject)] [\-M] [\-c policyvers] [\-o output_file|\-] [\-S] [\-t target_platform (selinux,xen)] [\-O] [\-E] [\-V] [input_file]"
+.I "[\-b[F]] [\-C] [\-d] [\-U handle_unknown (allow,deny,reject)] [\-M] [\-N] [\-c policyvers] [\-o output_file|\-] [\-S] [\-t target_platform (selinux,xen)] [\-O] [\-E] [\-V] [input_file]"
 .br
 .SH "DESCRIPTION"
 This manual page describes the
@@ -38,6 +38,9 @@ Specify how the kernel should handle unknown classes or permissions (deny, allow
 .B \-M,\-\-mls
 Enable the MLS policy when checking and compiling the policy.
 .TP
+.B \-N,\-\-disable-neverallow
+Do not check neverallow rules.
+.TP
 .B \-c policyvers
 Specify the policy version, defaults to the latest.
 .TP
diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
index 48c31261..209f36d8 100644
--- a/checkpolicy/checkpolicy.c
+++ b/checkpolicy/checkpolicy.c
@@ -109,7 +109,7 @@ static __attribute__((__noreturn__)) void usage(const char *progname)
 {
 	printf
 	    ("usage:  %s [-b[F]] [-C] [-d] [-U handle_unknown (allow,deny,reject)] [-M] "
-	     "[-c policyvers (%d-%d)] [-o output_file|-] [-S] [-O] "
+	     "[-N] [-c policyvers (%d-%d)] [-o output_file|-] [-S] [-O] "
 	     "[-t target_platform (selinux,xen)] [-E] [-V] [input_file]\n",
 	     progname, POLICYDB_VERSION_MIN, POLICYDB_VERSION_MAX);
 	exit(1);
@@ -393,7 +393,7 @@ int main(int argc, char **argv)
 	size_t scontext_len, pathlen;
 	unsigned int i;
 	unsigned int protocol, port;
-	unsigned int binary = 0, debug = 0, sort = 0, cil = 0, conf = 0, optimize = 0;
+	unsigned int binary = 0, debug = 0, sort = 0, cil = 0, conf = 0, optimize = 0, check_neverallow = 1;
 	struct val_to_name v;
 	int ret, ch, fd, target = SEPOL_TARGET_SELINUX;
 	unsigned int nel, uret;
@@ -415,6 +415,7 @@ int main(int argc, char **argv)
 		{"version", no_argument, NULL, 'V'},
 		{"handle-unknown", required_argument, NULL, 'U'},
 		{"mls", no_argument, NULL, 'M'},
+		{"disable-neverallow", no_argument, NULL, 'N'},
 		{"cil", no_argument, NULL, 'C'},
 		{"conf",no_argument, NULL, 'F'},
 		{"sort", no_argument, NULL, 'S'},
@@ -424,7 +425,7 @@ int main(int argc, char **argv)
 		{NULL, 0, NULL, 0}
 	};
 
-	while ((ch = getopt_long(argc, argv, "o:t:dbU:MCFSVc:OEh", long_options, NULL)) != -1) {
+	while ((ch = getopt_long(argc, argv, "o:t:dbU:MNCFSVc:OEh", long_options, NULL)) != -1) {
 		switch (ch) {
 		case 'o':
 			outfile = optarg;
@@ -473,6 +474,9 @@ int main(int argc, char **argv)
 		case 'M':
 			mlspol = 1;
 			break;
+		case 'N':
+			check_neverallow = 0;
+			break;
 		case 'C':
 			cil = 1;
 			break;
@@ -630,7 +634,7 @@ int main(int argc, char **argv)
 				fprintf(stderr, "%s:  policydb_init failed\n", argv[0]);
 				exit(1);
 			}
-			if (expand_module(NULL, policydbp, &policydb, 0, 1)) {
+			if (expand_module(NULL, policydbp, &policydb, /*verbose=*/0, check_neverallow)) {
 				fprintf(stderr, "Error while expanding policy\n");
 				exit(1);
 			}
-- 
2.40.0

