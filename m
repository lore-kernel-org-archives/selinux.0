Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65AD8C49EA7
	for <selinux@archiver.kernel.org>; Thu, 24 Jun 2021 19:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 492DE61185
	for <selinux@archiver.kernel.org>; Thu, 24 Jun 2021 19:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbhFXUBo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 24 Jun 2021 16:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbhFXUBn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 24 Jun 2021 16:01:43 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5C8C06175F
        for <selinux@vger.kernel.org>; Thu, 24 Jun 2021 12:59:23 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id u2so3953501qvp.13
        for <selinux@vger.kernel.org>; Thu, 24 Jun 2021 12:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HQvtRMDYOarP2SqiVUWERep6sG35J1GxyR16NX4swNs=;
        b=SbNQJDEPMkBDjR6GNVaCRlNi194s25vyolGei5uYf/CpW+bt+FTPd+3BTRkYDTwrae
         PRudkQYYaKON4H5KFopKaZZkk3+QVDTJAKEPg8JsAaxu0RnXgPqbprSxnE/OmxuQoe/V
         623zfYNUlEl3J2WOVK9Fw/B1KmaibjI9s2WzFkTihL1TH+VNy8kI1Od1MzyWP3weHemW
         +/J7ODs9WzjsMQla+1SIaiHIGHICdNhvQgQv5IvcVl9qdkfkJRcqQVl6fbb0OtbcwWFk
         9hE3vYiJR+PPJLNoIymNhQ3s9Xhsd/D9ZmFCvAQPj5dx3jTfUQoo2Ca24xpoU5ztodm7
         x8dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HQvtRMDYOarP2SqiVUWERep6sG35J1GxyR16NX4swNs=;
        b=puboozcv3rtLDndTIcjOWCsF/DshEtipaFFvZi6nP1onlDaDxASP3IqmGFDwan0P6s
         D1edOA2M2K3+7tHQltZAlxBVjZ+HvJt9nPQsVsjQDpRa5VyS1SNfRcZqXLvNfC2T7n2i
         MTAkXKifJnm8Re+sTAT/CTMV4BJXym7cqNIc5FtHSMv8VwDLW58Ya/EMSiIqmuYNFHIN
         PCBcnPVaTR8GbPDx8Z7vQuOUwRZemvQmS4ZOf/TmY4h3DuVHUmZOnpBZs7evBVSGlArI
         qRiP6RoOH15g+5rVmQsE3Ycb88neYw2kkF6smaf9YRRacpw/fAmpp+8Vsz5iWcxW7Jlw
         CqCQ==
X-Gm-Message-State: AOAM533LBbAtviycnbmCt1UuS5+qHW7ssFwR4TKzm6u+q3DSwo3bnW89
        I/qOvNuposDWfXufutrr0r2ZNb75KOW+EA==
X-Google-Smtp-Source: ABdhPJwgRyH+En8Jbswo5mW49A2CH8h1v4buMZmWo0EBa/gJo0AlNm9uYYqLIp92Zcmaqj4ezd/89w==
X-Received: by 2002:ad4:536a:: with SMTP id e10mr7326234qvv.9.1624564762312;
        Thu, 24 Jun 2021 12:59:22 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id w185sm3345813qkd.30.2021.06.24.12.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 12:59:21 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 3/4] libsepol/cil: Add support for using qualified names to secil2tree
Date:   Thu, 24 Jun 2021 15:59:18 -0400
Message-Id: <20210624195919.148828-3-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210624195919.148828-1-jwcart2@gmail.com>
References: <20210624195919.148828-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Provide the option "-Q" or "--qualified-names" to indicate that the
policy is using qualified names.

Using qualified names means that declaration names can have "dots"
in them, but blocks, blockinherits, blockabstracts, and in-statements
are not allowed in the policy.

The libsepol function cil_set_qualified_names() is called with the
desired value for the CIL db's "qualified_names" field.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 secilc/secil2tree.8.xml | 5 +++++
 secilc/secil2tree.c     | 9 ++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/secilc/secil2tree.8.xml b/secilc/secil2tree.8.xml
index 81382ffe..6a969ac9 100644
--- a/secilc/secil2tree.8.xml
+++ b/secilc/secil2tree.8.xml
@@ -45,6 +45,11 @@
             <listitem><para>Treat tunables as booleans.</para></listitem>
          </varlistentry>
 
+         <varlistentry>
+            <term><option>-Q, --qualified-names</option></term>
+            <listitem><para>Use qualified names. Blocks, blockinherits, blockabstracts, and in-statements will not be allowed.</para></listitem>
+         </varlistentry>
+
          <varlistentry>
             <term><option>-A, --ast-phase=&lt;phase></option></term>
             <listitem><para>Write AST of phase <emphasis role="italic">phase</emphasis>. Must be <emphasis role="bold">parse</emphasis>, <emphasis role="bold">build</emphasis>, or <emphasis role="bold">resolve</emphasis>. (default: <emphasis role="bold">resolve</emphasis>)</para></listitem>
diff --git a/secilc/secil2tree.c b/secilc/secil2tree.c
index 218d0583..548a5c63 100644
--- a/secilc/secil2tree.c
+++ b/secilc/secil2tree.c
@@ -54,6 +54,7 @@ static __attribute__((__noreturn__)) void usage(const char *prog)
 	printf("Options:\n");
 	printf("  -o, --output=<file>      write AST to <file>. (default: stdout)\n");
 	printf("  -P, --preserve-tunables  treat tunables as booleans\n");
+	printf("  -Q, --qualified-names    Use qualified names and do not allow blocks\n");
 	printf("  -A, --ast-phase=<phase>  write AST of phase <phase>. Phase must be parse, \n");
 	printf("                           build, or resolve. (default: resolve)\n");
 	printf("  -v, --verbose            increment verbosity level\n");
@@ -71,6 +72,7 @@ int main(int argc, char *argv[])
 	char *output = NULL;
 	struct cil_db *db = NULL;
 	int preserve_tunables = 0;
+	int qualified_names = 0;
 	enum write_ast_phase write_ast = WRITE_AST_PHASE_RESOLVE;
 	int opt_char;
 	int opt_index = 0;
@@ -79,6 +81,7 @@ int main(int argc, char *argv[])
 		{"help", no_argument, 0, 'h'},
 		{"verbose", no_argument, 0, 'v'},
 		{"preserve-tunables", no_argument, 0, 'P'},
+		{"qualified-names", no_argument, 0, 'Q'},
 		{"output", required_argument, 0, 'o'},
 		{"ast-phase", required_argument, 0, 'A'},
 		{0, 0, 0, 0}
@@ -86,7 +89,7 @@ int main(int argc, char *argv[])
 	int i;
 
 	while (1) {
-		opt_char = getopt_long(argc, argv, "o:hvPA:", long_opts, &opt_index);
+		opt_char = getopt_long(argc, argv, "o:hvPQA:", long_opts, &opt_index);
 		if (opt_char == -1) {
 			break;
 		}
@@ -97,6 +100,9 @@ int main(int argc, char *argv[])
 			case 'P':
 				preserve_tunables = 1;
 				break;
+			case 'Q':
+				qualified_names = 1;
+				break;
 			case 'o':
 				output = strdup(optarg);
 				break;
@@ -131,6 +137,7 @@ int main(int argc, char *argv[])
 
 	cil_db_init(&db);
 	cil_set_preserve_tunables(db, preserve_tunables);
+	cil_set_qualified_names(db, qualified_names);
 	cil_set_attrs_expand_generated(db, 0);
 	cil_set_attrs_expand_size(db, 0);
 
-- 
2.26.3

