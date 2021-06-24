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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E22C49EA6
	for <selinux@archiver.kernel.org>; Thu, 24 Jun 2021 19:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 169BD60E0C
	for <selinux@archiver.kernel.org>; Thu, 24 Jun 2021 19:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbhFXUBo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 24 Jun 2021 16:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232778AbhFXUBn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 24 Jun 2021 16:01:43 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93EE6C061756
        for <selinux@vger.kernel.org>; Thu, 24 Jun 2021 12:59:22 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id q190so16680421qkd.2
        for <selinux@vger.kernel.org>; Thu, 24 Jun 2021 12:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GYe02PgXT9Q27ySRbQ7B/5Xj8MIBUt+EAS/oAfr0uPc=;
        b=TzbfU9ZJ4nPQMZvbjLklgg+J3YXPBurXUM6iZVaRrsWWZHz94rOOnLEVWLXO9iSBkY
         O/55lVEag1B0JQ1URyH0JprXxVStCcuGOLqrRXjeGnl6mCATG/MQbVqMwuSuz/u4XvV7
         hQFh0LLcFX8TgVZgm9A7dP8NQVzBMKwdUQ7u+Qfko3a43oVnGiuK6FhcEAz4TxiJ4Vq2
         YgxlsoIwVeZWce9gSt2NLZGtu0HHkHb8IPUgYB0kMXsuNVQNfOVwFHOVjNPYxB09MQOc
         JJDsedjR3UemUkr9wM2r9sftL6UrKyh4c3U6Y8YNkYYPvyIywHR426Qa2dAvLxbrdIPC
         FFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GYe02PgXT9Q27ySRbQ7B/5Xj8MIBUt+EAS/oAfr0uPc=;
        b=SFF+Or4+c856MBaxGpTkYkH3g8xc86bIpFM7G7dA98us7YrG5iyo5IpFK8ZVP7/rB1
         yEAJTXkdjj9FpEmSNOAcFhykwSOz1aZFY/z+5IX49B6/33VywU/6qb83R0isCi+eQBeS
         5AT6Ffc2WLhNQx4rtAMsQ3JYP+FWEqBRTiBaeUTcqaxAfVHsmWpjDulwvj7may712ldE
         3PJpIndTsmIN/YToWbrLqsjvcC5eClPp/cdTceNbclnFDiu7yhWpZs1UbvUL2tyRCaCc
         dAnz2ZRIWfAvw4vc9wRqqu2fUYO2Q4XAAhd7h2TyZk6qzXFplMBE4sGwnVCcqsxUG8Mf
         3RRw==
X-Gm-Message-State: AOAM531H7pFE7J3tfbzp3KzArXdfQEF6jUBa1aOpjAaC3YehK/Zq/gy2
        EiGGJDy67Sq1IWcalljZEtUphuwpc0lawQ==
X-Google-Smtp-Source: ABdhPJyoLTNLZu6iMcDK5gcp5Sdri9G1TJfgIMwwMJqAAizK2I6unTnUxw0geyWhnUDQgw0lUQwlaA==
X-Received: by 2002:a37:d4d:: with SMTP id 74mr7370881qkn.354.1624564761707;
        Thu, 24 Jun 2021 12:59:21 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id w185sm3345813qkd.30.2021.06.24.12.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 12:59:21 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 2/4] secilc: Add support for using qualified names to secilc
Date:   Thu, 24 Jun 2021 15:59:17 -0400
Message-Id: <20210624195919.148828-2-jwcart2@gmail.com>
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
 secilc/secilc.8.xml | 5 +++++
 secilc/secilc.c     | 9 ++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/secilc/secilc.8.xml b/secilc/secilc.8.xml
index 2b734f09..74b78f2b 100644
--- a/secilc/secilc.8.xml
+++ b/secilc/secilc.8.xml
@@ -75,6 +75,11 @@
             <listitem><para>Treat tunables as booleans.</para></listitem>
          </varlistentry>
 
+         <varlistentry>
+            <term><option>-Q, --qualified-names</option></term>
+            <listitem><para>Use qualified names. Do not allow blocks, blockinherits, blockabstracts, or in-statements.</para></listitem>
+         </varlistentry>
+
          <varlistentry>
             <term><option>-m, --multiple-decls</option></term>
             <listitem><para>Allow some statements to be re-declared.</para></listitem>
diff --git a/secilc/secilc.c b/secilc/secilc.c
index 9c78e425..91b619b9 100644
--- a/secilc/secilc.c
+++ b/secilc/secilc.c
@@ -63,6 +63,7 @@ static __attribute__((__noreturn__)) void usage(const char *prog)
 	printf("                                 statement if present in the policy\n");
 	printf("  -D, --disable-dontaudit        do not add dontaudit rules to the binary policy\n");
 	printf("  -P, --preserve-tunables        treat tunables as booleans\n");
+	printf("  -Q, --qualified-names          Use qualified names and do not allow blocks\n");
 	printf("  -m, --multiple-decls           allow some statements to be re-declared\n");
 	printf("  -N, --disable-neverallow       do not check neverallow rules\n");
 	printf("  -G, --expand-generated         Expand and remove auto-generated attributes\n");
@@ -94,6 +95,7 @@ int main(int argc, char *argv[])
 	int multiple_decls = 0;
 	int disable_neverallow = 0;
 	int preserve_tunables = 0;
+	int qualified_names = 0;
 	int handle_unknown = -1;
 	int policyvers = POLICYDB_VERSION_MAX;
 	int attrs_expand_generated = 0;
@@ -115,6 +117,7 @@ int main(int argc, char *argv[])
 		{"multiple-decls", no_argument, 0, 'm'},
 		{"disable-neverallow", no_argument, 0, 'N'},
 		{"preserve-tunables", no_argument, 0, 'P'},
+		{"qualified-names", no_argument, 0, 'Q'},
 		{"output", required_argument, 0, 'o'},
 		{"filecontexts", required_argument, 0, 'f'},
 		{"expand-generated", no_argument, 0, 'G'},
@@ -125,7 +128,7 @@ int main(int argc, char *argv[])
 	int i;
 
 	while (1) {
-		opt_char = getopt_long(argc, argv, "o:f:U:hvt:M:PDmNOc:GX:n", long_opts, &opt_index);
+		opt_char = getopt_long(argc, argv, "o:f:U:hvt:M:PQDmNOc:GX:n", long_opts, &opt_index);
 		if (opt_char == -1) {
 			break;
 		}
@@ -190,6 +193,9 @@ int main(int argc, char *argv[])
 			case 'P':
 				preserve_tunables = 1;
 				break;
+			case 'Q':
+				qualified_names = 1;
+				break;
 			case 'o':
 				output = strdup(optarg);
 				break;
@@ -238,6 +244,7 @@ int main(int argc, char *argv[])
 	cil_set_multiple_decls(db, multiple_decls);
 	cil_set_disable_neverallow(db, disable_neverallow);
 	cil_set_preserve_tunables(db, preserve_tunables);
+	cil_set_qualified_names(db, qualified_names);
 	if (handle_unknown != -1) {
 		rc = cil_set_handle_unknown(db, handle_unknown);
 		if (rc != SEPOL_OK) {
-- 
2.26.3

