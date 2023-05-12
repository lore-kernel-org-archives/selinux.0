Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5816BC77B7F
	for <selinux@archiver.kernel.org>; Fri, 12 May 2023 09:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240385AbjELJ6Z (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 12 May 2023 05:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240196AbjELJ6S (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 12 May 2023 05:58:18 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4ED11D86
        for <selinux@vger.kernel.org>; Fri, 12 May 2023 02:58:02 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-50bc3088b7aso18199585a12.3
        for <selinux@vger.kernel.org>; Fri, 12 May 2023 02:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1683885481; x=1686477481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sz/Dej0nIS3WwAWmKMJsHCyJCu6E1BYJ3ixCA6x4He0=;
        b=W0bMf62D5Fqk9uTUhgGVGrQu1L5uFFSXcGMmRdnbaVD97ksdJy1AEs9mQaB88A97np
         ua9+1klZxlXft1GGonNeFUXsgMRZFnSf9AFR9WOUXNz984has8L5vSUEVziFY9UpyRCL
         mtQLN90sBbnoupLQQhvhoNi1THXcZPHE44EHSnYhi/37cF2TN8StyUvG5sNeo4vAJ19O
         hq++Qjc3pbtrwDoMFSXhgId8ZTU5wqNBkJddfbVMGs9HjcdrM6ylzdXzL0pquk71entr
         ypga4WfphCCH62hwQMwnfjpDL9DNURTve+i/+RpyYv3Vp58Vb5/C94y1qBINCvj5CWIq
         WOxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683885481; x=1686477481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sz/Dej0nIS3WwAWmKMJsHCyJCu6E1BYJ3ixCA6x4He0=;
        b=QcMRhIECxTshOMqsy6EIw5O/SPg2iyA1innlgKjWg22YH0z2wbRO/gyBGeD0x99eYC
         TWNRVyJJ8bhT7ap/BSkv9zTadkxNmiDvfbSizDWIvjwBeyn2GDMT6jq91pnPsbk0WxE6
         jWxcye9XHh3GynvTEv/mHEnEm5FUr+qNlM8U3jXwMA8/ilQgr22UTyypJSLEp9R+VYKc
         JCS+KKZMdgD/Zoo9NeFVDWDxJjrIjo9LRzpgXfb2PSteWAN3JXsngjDT12O2yfRb3IuX
         4QeifD64/55YYEYUdhz/pzpzw1oun0HEx4YNjXif75kxp72gpP3Y7aSTCEt4eTeCAgCa
         GpqA==
X-Gm-Message-State: AC+VfDzi1W1CSAciDz5rsyEap88Aw08vRyUvjEP/3EM0qKa7m3/4KrBU
        QXUzAn5+/FtagrKqFU0UuzzYYgCd84Wi9Q==
X-Google-Smtp-Source: ACHHUZ7TuMkKpXArnH5EoN2/qpDF0YVVOxa2U9xU++I/ss2vVRLEQIG+usy9CEplKebKgCEY9sCsXA==
X-Received: by 2002:a05:6402:398:b0:50b:c4b7:ee7c with SMTP id o24-20020a056402039800b0050bc4b7ee7cmr19106852edv.36.1683885480604;
        Fri, 12 May 2023 02:58:00 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-116-181-041.95.116.pool.telefonica.de. [95.116.181.41])
        by smtp.gmail.com with ESMTPSA id i8-20020a056402054800b0050bd59fd0efsm3721159edx.49.2023.05.12.02.57.59
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 02:58:00 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2] checkpolicy: add option to skip checking neverallow rules
Date:   Fri, 12 May 2023 11:57:49 +0200
Message-Id: <20230512095749.59577-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230331173442.101678-1-cgzones@googlemail.com>
References: <20230331173442.101678-1-cgzones@googlemail.com>
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
v2:
   invert variable logic from check_neverallow to disable_neverallow
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
index 3432608b..14e6c891 100644
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
+	unsigned int binary = 0, cil = 0, disable_neverallow = 0;
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
+			disable_neverallow = 1;
+			break;
 		case 'C':
 			cil = 1;
 			break;
@@ -317,7 +322,7 @@ int main(int argc, char **argv)
 			fprintf(stderr, "%s:  link modules failed\n", argv[0]);
 			exit(1);
 		}
-		if (expand_module(NULL, &modpolicydb, &kernpolicydb, 0, 1)) {
+		if (expand_module(NULL, &modpolicydb, &kernpolicydb, /*verbose=*/0, !disable_neverallow)) {
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
index 2485142d..623ba8b2 100644
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
+	unsigned int binary = 0, debug = 0, sort = 0, cil = 0, conf = 0, optimize = 0, disable_neverallow = 0;
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
+			disable_neverallow = 1;
+			break;
 		case 'C':
 			cil = 1;
 			break;
@@ -630,7 +634,7 @@ int main(int argc, char **argv)
 				fprintf(stderr, "%s:  policydb_init failed\n", argv[0]);
 				exit(1);
 			}
-			if (expand_module(NULL, policydbp, &policydb, 0, 1)) {
+			if (expand_module(NULL, policydbp, &policydb, /*verbose=*/0, !disable_neverallow)) {
 				fprintf(stderr, "Error while expanding policy\n");
 				exit(1);
 			}
-- 
2.40.1

