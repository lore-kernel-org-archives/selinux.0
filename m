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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF50AC11F69
	for <selinux@archiver.kernel.org>; Tue, 29 Jun 2021 15:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE71C61DAD
	for <selinux@archiver.kernel.org>; Tue, 29 Jun 2021 15:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234613AbhF2PQg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 29 Jun 2021 11:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbhF2PQf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 29 Jun 2021 11:16:35 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD941C061760
        for <selinux@vger.kernel.org>; Tue, 29 Jun 2021 08:14:08 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id t9so16341682qtw.7
        for <selinux@vger.kernel.org>; Tue, 29 Jun 2021 08:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nl/6GSi6nJLwX+VAMnsOsFwvaWWKg01e44XxQpPQkWA=;
        b=NAZLtFf+YwfJ6H2BTqaguJ6EPishUn+MYFbMIlOAX6UjSQVIKynH3rtjvR1TwSuRAx
         fO3Vic/9zS+jDPt+DNTTN/p8vplvKon9nyUh10rlc+SaJ5Ox06wa8iHJPIePKWUM4Xz9
         1mKuipn+CakeiVoMot2KuyOyx92LdkigMutAa+EDF81ERZTs4zUQAC4LyvBdL9q+HWsy
         Gb578TNR5FojDd77KMmxVv0dhakU8PaT3K8vlnK2wxZw5tDUBdtINREPnIj2A8NxQpNH
         SlFlv5RW/Qo3+Z4QEMZhG/uDedQ+aEvqZqYmj/qlcbdyb/AdK0b0O3+0czly04Lq4w1k
         1E3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nl/6GSi6nJLwX+VAMnsOsFwvaWWKg01e44XxQpPQkWA=;
        b=sp9rQw7YWUSCQqTb6sOMYAOteVpgZoD6IXN387QU4a2AOweRSEcr7X7JotoAMx7l5g
         y5czQXPci+j56o7ACyjVgPg0eCN0xS7AEfBqsJ6rYHFnhPqmi1N6gSqbKDRF+cnFE7lF
         zw/oqL2ekd0a8wjfIRv5R3RIkvmsc7SNuKHR1+uHqnpzez0xt+U6eem4ejPahnwW4img
         zglcxTWkyeOEL7M8lp5YTKAzgS3QMSeLR9/WBR7HOWCiJhAaTS6InTFqKNK6G0qz4xFp
         Vxk8kSUwl5KX+DDvjdtN04/d0JwzCKuxhQfCaxYwfXXQTSMtRyuD8C9OblpiNX1IV6XQ
         BNyQ==
X-Gm-Message-State: AOAM530MaIYWC32+Eld99l2Y/qzhRjZ3+OSSMqMB9W445nHqU8NmxbUb
        W/IwyU9N7hjwqDuVpdmrJ5MF4LRVG2mLvg==
X-Google-Smtp-Source: ABdhPJwAsJduA/H0n2hGWzO3BYtWD/uJayCiCKKDSQm7f3behK5VzgeqfYedF7Y7lyDHA1EFLKq2Yg==
X-Received: by 2002:ac8:4b6d:: with SMTP id g13mr13239563qts.288.1624979647669;
        Tue, 29 Jun 2021 08:14:07 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id e12sm7880721qtj.3.2021.06.29.08.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 08:14:07 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 2/4 v2] secilc: Add support for using qualified names to secilc
Date:   Tue, 29 Jun 2021 11:14:00 -0400
Message-Id: <20210629151402.41071-2-jwcart2@gmail.com>
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

 secilc/secilc.8.xml |  5 +++++
 secilc/secilc.c     | 11 ++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/secilc/secilc.8.xml b/secilc/secilc.8.xml
index 2b734f09..e9a121e2 100644
--- a/secilc/secilc.8.xml
+++ b/secilc/secilc.8.xml
@@ -75,6 +75,11 @@
             <listitem><para>Treat tunables as booleans.</para></listitem>
          </varlistentry>
 
+         <varlistentry>
+            <term><option>-Q, --qualified-names</option></term>
+            <listitem><para>Allow names containing dots (qualified names). Blocks, blockinherits, blockabstracts, and in-statements will not be allowed.</para></listitem>
+         </varlistentry>
+
          <varlistentry>
             <term><option>-m, --multiple-decls</option></term>
             <listitem><para>Allow some statements to be re-declared.</para></listitem>
diff --git a/secilc/secilc.c b/secilc/secilc.c
index 9c78e425..1c4f1ca0 100644
--- a/secilc/secilc.c
+++ b/secilc/secilc.c
@@ -63,6 +63,9 @@ static __attribute__((__noreturn__)) void usage(const char *prog)
 	printf("                                 statement if present in the policy\n");
 	printf("  -D, --disable-dontaudit        do not add dontaudit rules to the binary policy\n");
 	printf("  -P, --preserve-tunables        treat tunables as booleans\n");
+	printf("  -Q, --qualified-names          Allow names containing dots (qualified names).\n");
+	printf("                                 Blocks, blockinherits, blockabstracts, and\n");
+	printf("                                 in-statements will not be allowed.\n");
 	printf("  -m, --multiple-decls           allow some statements to be re-declared\n");
 	printf("  -N, --disable-neverallow       do not check neverallow rules\n");
 	printf("  -G, --expand-generated         Expand and remove auto-generated attributes\n");
@@ -94,6 +97,7 @@ int main(int argc, char *argv[])
 	int multiple_decls = 0;
 	int disable_neverallow = 0;
 	int preserve_tunables = 0;
+	int qualified_names = 0;
 	int handle_unknown = -1;
 	int policyvers = POLICYDB_VERSION_MAX;
 	int attrs_expand_generated = 0;
@@ -115,6 +119,7 @@ int main(int argc, char *argv[])
 		{"multiple-decls", no_argument, 0, 'm'},
 		{"disable-neverallow", no_argument, 0, 'N'},
 		{"preserve-tunables", no_argument, 0, 'P'},
+		{"qualified-names", no_argument, 0, 'Q'},
 		{"output", required_argument, 0, 'o'},
 		{"filecontexts", required_argument, 0, 'f'},
 		{"expand-generated", no_argument, 0, 'G'},
@@ -125,7 +130,7 @@ int main(int argc, char *argv[])
 	int i;
 
 	while (1) {
-		opt_char = getopt_long(argc, argv, "o:f:U:hvt:M:PDmNOc:GX:n", long_opts, &opt_index);
+		opt_char = getopt_long(argc, argv, "o:f:U:hvt:M:PQDmNOc:GX:n", long_opts, &opt_index);
 		if (opt_char == -1) {
 			break;
 		}
@@ -190,6 +195,9 @@ int main(int argc, char *argv[])
 			case 'P':
 				preserve_tunables = 1;
 				break;
+			case 'Q':
+				qualified_names = 1;
+				break;
 			case 'o':
 				output = strdup(optarg);
 				break;
@@ -238,6 +246,7 @@ int main(int argc, char *argv[])
 	cil_set_multiple_decls(db, multiple_decls);
 	cil_set_disable_neverallow(db, disable_neverallow);
 	cil_set_preserve_tunables(db, preserve_tunables);
+	cil_set_qualified_names(db, qualified_names);
 	if (handle_unknown != -1) {
 		rc = cil_set_handle_unknown(db, handle_unknown);
 		if (rc != SEPOL_OK) {
-- 
2.31.1

