Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BDCC11F6A
	for <selinux@archiver.kernel.org>; Tue, 29 Jun 2021 15:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5B8C61DAD
	for <selinux@archiver.kernel.org>; Tue, 29 Jun 2021 15:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbhF2PQh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 29 Jun 2021 11:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234675AbhF2PQh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 29 Jun 2021 11:16:37 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436CDC061760
        for <selinux@vger.kernel.org>; Tue, 29 Jun 2021 08:14:09 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id u2so11228196qvp.13
        for <selinux@vger.kernel.org>; Tue, 29 Jun 2021 08:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hOSdcoyirD7T7lz/XB/2NnXaCzqLTb1zPohYa35nAmQ=;
        b=OaA+/f5Ge7ykqzFdbLqK//5pQ3yAQNvp1InFQZo7hCV9YkNIBpvS7yAFFz501B9lG4
         MaIFvwhziNfxKK2MVWRG4DCz8Gxw3Kza4UEBcQdlGHDfBI2gFI9iDLSDye1XYsTZ50GO
         /rPuA9kdh+aLDK+yU1HN8j8ESF/gpX2IWvzj6K7dfYqvofJdvcyyebsZ/MyQAagUCkbX
         WieiDDefz3miyWUDrDu6o76vS34Dci8nHzjORQV924hFKipjMHjb+tHgv3wsUHqZMd5I
         PVCzw4J+Z1k6tqHz1XHxiCLKP0ru+GVnTxqitvr0APop2bya+pcMgzh6F7EwxhRB2Uh6
         MoYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hOSdcoyirD7T7lz/XB/2NnXaCzqLTb1zPohYa35nAmQ=;
        b=USUR6t4JmL/gFX1PpEiTKfKsIMejm9Ya8XH903dc89RCxbV+5Qxv94WtrQancwJJgm
         16WNqCpRdtu10UWIwO+MBxNXaQXUY3kxq4DuPiU2EXYW+Qi+oqwygB+OIY9j/Yz+IU3j
         BRhH0zW5X2m6k5Mu6kZg63+DMPb7V+l2/noIJSAdDoCavsdRd7aUctsXxfb3BTFmx+46
         c8EYTMt3EchcBdf41M9jZpZPE+F8eLq/i3IeOXbA0Nagj1JqnUcjr6y8aDDgH6napdlA
         pANcxbe/UevoYHxPM91R8XaE/bdPb7K0lPdGuFkgi26wM0PtRc2qN+FdYLc/m6dsbD1x
         Hs3w==
X-Gm-Message-State: AOAM531TfHk3+xEk5m476RSNDepFHZyRkSNZZ6VjxDom8DNrj6sPThwJ
        ck/A49p53dnK4EJZ8ArnYFVMVRzhP5fv+Q==
X-Google-Smtp-Source: ABdhPJzD53lwgnuWaAmTbVQhMsjIx0AR6t9VrUi+DLi/8SClMnBaQ+zmBBfBvI0D1zVaYOw6sUBo3w==
X-Received: by 2002:a0c:9a43:: with SMTP id q3mr31846192qvd.30.1624979648409;
        Tue, 29 Jun 2021 08:14:08 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id e12sm7880721qtj.3.2021.06.29.08.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 08:14:08 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 3/4 v2] libsepol/cil: Add support for using qualified names to secil2tree
Date:   Tue, 29 Jun 2021 11:14:01 -0400
Message-Id: <20210629151402.41071-3-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210629151402.41071-1-jwcart2@gmail.com>
References: <20210629151402.41071-1-jwcart2@gmail.com>
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
v2:
 Changed the language for the man page and "--help" documentation

 secilc/secil2tree.8.xml |  5 +++++
 secilc/secil2tree.c     | 11 ++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/secilc/secil2tree.8.xml b/secilc/secil2tree.8.xml
index 81382ffe..e95a8947 100644
--- a/secilc/secil2tree.8.xml
+++ b/secilc/secil2tree.8.xml
@@ -45,6 +45,11 @@
             <listitem><para>Treat tunables as booleans.</para></listitem>
          </varlistentry>
 
+         <varlistentry>
+            <term><option>-Q, --qualified-names</option></term>
+            <listitem><para>Allow names containing dots (qualified names). Blocks, blockinherits, blockabstracts, and in-statements will not be allowed.</para></listitem>
+         </varlistentry>
+
          <varlistentry>
             <term><option>-A, --ast-phase=&lt;phase></option></term>
             <listitem><para>Write AST of phase <emphasis role="italic">phase</emphasis>. Must be <emphasis role="bold">parse</emphasis>, <emphasis role="bold">build</emphasis>, or <emphasis role="bold">resolve</emphasis>. (default: <emphasis role="bold">resolve</emphasis>)</para></listitem>
diff --git a/secilc/secil2tree.c b/secilc/secil2tree.c
index 218d0583..e5cdf6bd 100644
--- a/secilc/secil2tree.c
+++ b/secilc/secil2tree.c
@@ -54,6 +54,9 @@ static __attribute__((__noreturn__)) void usage(const char *prog)
 	printf("Options:\n");
 	printf("  -o, --output=<file>      write AST to <file>. (default: stdout)\n");
 	printf("  -P, --preserve-tunables  treat tunables as booleans\n");
+	printf("  -Q, --qualified-names    Allow names containing dots (qualified names).\n");
+	printf("                           Blocks, blockinherits, blockabstracts, and\n");
+	printf("                           in-statements will not be allowed.\n");
 	printf("  -A, --ast-phase=<phase>  write AST of phase <phase>. Phase must be parse, \n");
 	printf("                           build, or resolve. (default: resolve)\n");
 	printf("  -v, --verbose            increment verbosity level\n");
@@ -71,6 +74,7 @@ int main(int argc, char *argv[])
 	char *output = NULL;
 	struct cil_db *db = NULL;
 	int preserve_tunables = 0;
+	int qualified_names = 0;
 	enum write_ast_phase write_ast = WRITE_AST_PHASE_RESOLVE;
 	int opt_char;
 	int opt_index = 0;
@@ -79,6 +83,7 @@ int main(int argc, char *argv[])
 		{"help", no_argument, 0, 'h'},
 		{"verbose", no_argument, 0, 'v'},
 		{"preserve-tunables", no_argument, 0, 'P'},
+		{"qualified-names", no_argument, 0, 'Q'},
 		{"output", required_argument, 0, 'o'},
 		{"ast-phase", required_argument, 0, 'A'},
 		{0, 0, 0, 0}
@@ -86,7 +91,7 @@ int main(int argc, char *argv[])
 	int i;
 
 	while (1) {
-		opt_char = getopt_long(argc, argv, "o:hvPA:", long_opts, &opt_index);
+		opt_char = getopt_long(argc, argv, "o:hvPQA:", long_opts, &opt_index);
 		if (opt_char == -1) {
 			break;
 		}
@@ -97,6 +102,9 @@ int main(int argc, char *argv[])
 			case 'P':
 				preserve_tunables = 1;
 				break;
+			case 'Q':
+				qualified_names = 1;
+				break;
 			case 'o':
 				output = strdup(optarg);
 				break;
@@ -131,6 +139,7 @@ int main(int argc, char *argv[])
 
 	cil_db_init(&db);
 	cil_set_preserve_tunables(db, preserve_tunables);
+	cil_set_qualified_names(db, qualified_names);
 	cil_set_attrs_expand_generated(db, 0);
 	cil_set_attrs_expand_size(db, 0);
 
-- 
2.31.1

