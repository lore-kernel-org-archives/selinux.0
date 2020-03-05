Return-Path: <SRS0=pcXh=4W=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4AC9C3F2D1
	for <selinux@archiver.kernel.org>; Thu,  5 Mar 2020 18:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ABED2072D
	for <selinux@archiver.kernel.org>; Thu,  5 Mar 2020 18:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="pglJfkfQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbgCESkm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 5 Mar 2020 13:40:42 -0500
Received: from linux.microsoft.com ([13.77.154.182]:49652 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgCESkm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 5 Mar 2020 13:40:42 -0500
Received: from localhost.localdomain (c-73-172-233-15.hsd1.md.comcast.net [73.172.233.15])
        by linux.microsoft.com (Postfix) with ESMTPSA id B6344200767B
        for <selinux@vger.kernel.org>; Thu,  5 Mar 2020 10:40:39 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B6344200767B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1583433639;
        bh=QOCR2KCz/J9Trn77zO7HLunUvm6yFUBwpe11VqScdz8=;
        h=From:To:Subject:Date:From;
        b=pglJfkfQIZXOqa6mqEF+1zDBbiqC3ejgtg+y54+ABbw+UL7FE0tX3zTlR91i2Y/qH
         94Nuz7Q/vzzwuehMXHDOt7xEsOWqNA1/H9FbameIPsI9pBIpBovHNCkRZKxt2O9dP8
         2hvTRJYwvhW42zYsKuDqSz35KJwqfQ4wMrQOBcNg=
From:   Daniel Burgener <dburgener@linux.microsoft.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] checkpolicy: Add --werror flag to checkmodule and checkpolicy to treat warnings as errors.
Date:   Thu,  5 Mar 2020 13:40:34 -0500
Message-Id: <20200305184034.165554-1-dburgener@linux.microsoft.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When the lexer encounters an unexpected character in a policy source file, it prints a warning, discards the character and moves on.  In some build environments, these characters could be a symptom of an earlier problem, such as unintended results of expansion of preprocessor macros, and the ability to have the compiler halt on such issues would be helpful for diagnosis.

Signed-off-by: Daniel Burgener <Daniel.Burgener@microsoft.com>
---
 checkpolicy/checkmodule.8 |  3 +++
 checkpolicy/checkmodule.c | 10 ++++++++--
 checkpolicy/checkpolicy.8 |  3 +++
 checkpolicy/checkpolicy.c |  9 +++++++--
 checkpolicy/policy_scan.l |  4 ++++
 5 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/checkpolicy/checkmodule.8 b/checkpolicy/checkmodule.8
index e597d9d4..70e67f1e 100644
--- a/checkpolicy/checkmodule.8
+++ b/checkpolicy/checkmodule.8
@@ -28,6 +28,9 @@ module file.  This option is a development/debugging aid.
 .B \-C,\-\-cil
 Write CIL policy file rather than binary policy file.
 .TP
+.B \-E,\-\-werror
+Treat warnings as errors
+.TP
 .B \-h,\-\-help
 Print usage.
 .TP
diff --git a/checkpolicy/checkmodule.c b/checkpolicy/checkmodule.c
index c9efaf8b..ddf0700f 100644
--- a/checkpolicy/checkmodule.c
+++ b/checkpolicy/checkmodule.c
@@ -41,6 +41,7 @@ extern int optind;
 static sidtab_t sidtab;
 
 extern int mlspol;
+extern int werror;
 
 static int handle_unknown = SEPOL_DENY_UNKNOWN;
 static const char *txtfile = "policy.conf";
@@ -126,7 +127,7 @@ static int write_binary_policy(policydb_t * p, FILE *outfp)
 
 static __attribute__((__noreturn__)) void usage(const char *progname)
 {
-	printf("usage:  %s [-h] [-V] [-b] [-C] [-U handle_unknown] [-m] [-M] [-o FILE] [INPUT]\n", progname);
+	printf("usage:  %s [-h] [-V] [-b] [-C] [-E] [-U handle_unknown] [-m] [-M] [-o FILE] [INPUT]\n", progname);
 	printf("Build base and policy modules.\n");
 	printf("Options:\n");
 	printf("  INPUT      build module from INPUT (else read from \"%s\")\n",
@@ -134,6 +135,7 @@ static __attribute__((__noreturn__)) void usage(const char *progname)
 	printf("  -V         show policy versions created by this program\n");
 	printf("  -b         treat input as a binary policy file\n");
 	printf("  -C         output CIL policy instead of binary policy\n");
+	printf("  -E         treat warnings as errors\n");
 	printf("  -h         print usage\n");
 	printf("  -U OPTION  How to handle unknown classes and permissions\n");
 	printf("               deny: Deny unknown kernel checks\n");
@@ -162,10 +164,11 @@ int main(int argc, char **argv)
 		{"handle-unknown", required_argument, NULL, 'U'},
 		{"mls", no_argument, NULL, 'M'},
 		{"cil", no_argument, NULL, 'C'},
+		{"werror", no_argument, NULL, 'E'},
 		{NULL, 0, NULL, 0}
 	};
 
-	while ((ch = getopt_long(argc, argv, "ho:bVU:mMCc:", long_options, NULL)) != -1) {
+	while ((ch = getopt_long(argc, argv, "ho:bVEU:mMCc:", long_options, NULL)) != -1) {
 		switch (ch) {
 		case 'h':
 			usage(argv[0]);
@@ -180,6 +183,9 @@ int main(int argc, char **argv)
 		case 'V':
 			show_version = 1;
 			break;
+		case 'E':
+			werror = 1;
+			break;
 		case 'U':
 			if (!strcasecmp(optarg, "deny")) {
 				handle_unknown = DENY_UNKNOWN;
diff --git a/checkpolicy/checkpolicy.8 b/checkpolicy/checkpolicy.8
index 97e10ca7..3d7c7539 100644
--- a/checkpolicy/checkpolicy.8
+++ b/checkpolicy/checkpolicy.8
@@ -53,6 +53,9 @@ Specify the target platform (selinux or xen).
 .B \-O,\-\-optimize
 Optimize the final kernel policy (remove redundant rules).
 .TP
+.B \-E,\-\-werror
+Treat warnings as errors
+.TP
 .B \-V,\-\-version
 Show version information.
 .TP
diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
index 7c5b63f8..b6e2d43a 100644
--- a/checkpolicy/checkpolicy.c
+++ b/checkpolicy/checkpolicy.c
@@ -101,6 +101,7 @@ static sidtab_t sidtab;
 
 extern policydb_t *policydbp;
 extern int mlspol;
+extern int werror;
 
 static int handle_unknown = SEPOL_DENY_UNKNOWN;
 static const char *txtfile = "policy.conf";
@@ -113,7 +114,7 @@ static __attribute__((__noreturn__)) void usage(const char *progname)
 	printf
 	    ("usage:  %s [-b[F]] [-C] [-d] [-U handle_unknown (allow,deny,reject)] [-M] "
 	     "[-c policyvers (%d-%d)] [-o output_file|-] [-S] "
-	     "[-t target_platform (selinux,xen)] [-V] [input_file]\n",
+	     "[-t target_platform (selinux,xen)] [-E] [-V] [input_file]\n",
 	     progname, POLICYDB_VERSION_MIN, POLICYDB_VERSION_MAX);
 	exit(1);
 }
@@ -421,11 +422,12 @@ int main(int argc, char **argv)
 		{"conf",no_argument, NULL, 'F'},
 		{"sort", no_argument, NULL, 'S'},
 		{"optimize", no_argument, NULL, 'O'},
+		{"werror", no_argument, NULL, 'E'},
 		{"help", no_argument, NULL, 'h'},
 		{NULL, 0, NULL, 0}
 	};
 
-	while ((ch = getopt_long(argc, argv, "o:t:dbU:MCFSVc:Oh", long_options, NULL)) != -1) {
+	while ((ch = getopt_long(argc, argv, "o:t:dbU:MCFSVc:OEh", long_options, NULL)) != -1) {
 		switch (ch) {
 		case 'o':
 			outfile = optarg;
@@ -504,6 +506,9 @@ int main(int argc, char **argv)
 					policyvers = n;
 				break;
 			}
+		case 'E':
+			 werror = 1;
+			 break;
 		case 'h':
 		default:
 			usage(argv[0]);
diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
index e2f676e4..b90a7378 100644
--- a/checkpolicy/policy_scan.l
+++ b/checkpolicy/policy_scan.l
@@ -36,6 +36,7 @@ typedef int (* require_func_t)(void);
 
 static char linebuf[2][255];
 static unsigned int lno = 0;
+int werror = 0;
 int yywarn(const char *msg);
 
 void set_source_file(const char *name);
@@ -310,6 +311,9 @@ int yyerror(const char *msg)
 
 int yywarn(const char *msg)
 {
+	if (werror)
+		return yyerror(msg);
+
 	if (source_file[0])
 		fprintf(stderr, "%s:%ld:",
 			source_file, source_lineno);
-- 
2.24.1

