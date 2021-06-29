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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1E5C11F67
	for <selinux@archiver.kernel.org>; Tue, 29 Jun 2021 15:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 519A661D5E
	for <selinux@archiver.kernel.org>; Tue, 29 Jun 2021 15:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234675AbhF2PQi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 29 Jun 2021 11:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234645AbhF2PQi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 29 Jun 2021 11:16:38 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27394C061766
        for <selinux@vger.kernel.org>; Tue, 29 Jun 2021 08:14:10 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 11so4536459qvh.3
        for <selinux@vger.kernel.org>; Tue, 29 Jun 2021 08:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5HYLX4L9Ya4++HIky7zFsjKeuN4m+kv72xw/aJWxQik=;
        b=gozmBy8JRafAm3zRkqvuM4O9CMGlukFliGz6EkYpgH6T/5GQ040uRP8AA/HzcKwxkO
         H0ceFaUDfOFHctdCSoc/pnme7wlas5C7WsMtv8YUrUYFgiCM3hJAVV+4Li58UgM4tb+b
         XCNhzAhrKyasp1/oIB48mIM5vu0825EddGvsDN9HCqraWsOT1LnvB8g8181kG9svw1eK
         shq/ighEx//d432JgvCCUG5WYRbqKpTZCCe0NIOD48yU+wBDoM/8Fq5K648Qy+ChL63q
         gSE3XmpbVJ2rgoQWxZgjOZwvSC/OKeCc4hyjVxYc7D/aS0fd/jM+zczFfPzH/yvwSTaG
         C3LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5HYLX4L9Ya4++HIky7zFsjKeuN4m+kv72xw/aJWxQik=;
        b=MF8wO4uNCbzFM5sz3NgpQBW+Qfe3G4Z9fWvb/SOkm/7B/hvD8Xfdd0G5seMDcYdUAM
         1HEdaDRtq3Vu+Qw/rcvH9vAepqqoJXcilEnJHK5H11+IXZk80j7RX8rjmkcnXJc2Vs7m
         QG25zzaFdoGzO2mRcKbZodiimRYW/xJ/rP+CShu996+jtEs9hVIKmStzE3YjeZg6zyCe
         a1KScF42rVicZgbsbZOSMOSk0LVbm1eTYBR26RoDUmUNDNC6/tssH0Uws0BSnQVmdQJ4
         nc8fFIz+X455htmUv/whrqLHPdr1ZNoIdtkvxMWaClkWX5dSuIda+HgUhNd6XOxQa4lp
         /2Ew==
X-Gm-Message-State: AOAM531htFdmthxVE18MzTTCmWJsQ7uATOT2qOragE1xIqYyoT+6lg11
        43jQHatyBCTwDIMd8P/TQfzW3ZFbUntCHQ==
X-Google-Smtp-Source: ABdhPJxaVZ2Igiow2zune+sMXbMa79eFad9MuSD8EPMkjA0lsZoPYkr2KMZWsoRDmP+zqp48H3S7Tg==
X-Received: by 2002:a05:6214:17d2:: with SMTP id cu18mr31635410qvb.48.1624979649249;
        Tue, 29 Jun 2021 08:14:09 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id e12sm7880721qtj.3.2021.06.29.08.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 08:14:08 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 4/4 v2] libsepol/cil: Add support for using qualified names to secil2conf
Date:   Tue, 29 Jun 2021 11:14:02 -0400
Message-Id: <20210629151402.41071-4-jwcart2@gmail.com>
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

 secilc/secil2conf.8.xml |  5 +++++
 secilc/secil2conf.c     | 11 ++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/secilc/secil2conf.8.xml b/secilc/secil2conf.8.xml
index 59d87a54..33646f97 100644
--- a/secilc/secil2conf.8.xml
+++ b/secilc/secil2conf.8.xml
@@ -50,6 +50,11 @@
             <listitem><para>Treat tunables as booleans.</para></listitem>
          </varlistentry>
 
+         <varlistentry>
+            <term><option>-Q, --qualified-names</option></term>
+            <listitem><para>Allow names containing dots (qualified names). Blocks, blockinherits, blockabstracts, and in-statements will not be allowed.</para></listitem>
+         </varlistentry>
+
          <varlistentry>
             <term><option>-v, --verbose</option></term>
             <listitem><para>Increment verbosity level.</para></listitem>
diff --git a/secilc/secil2conf.c b/secilc/secil2conf.c
index 4e97dd66..d4103777 100644
--- a/secilc/secil2conf.c
+++ b/secilc/secil2conf.c
@@ -52,6 +52,9 @@ static __attribute__((__noreturn__)) void usage(const char *prog)
 	printf("                                 This will override the (mls boolean) statement\n");
 	printf("                                 if present in the policy\n");
 	printf("  -P, --preserve-tunables        treat tunables as booleans\n");
+	printf("  -Q, --qualified-names          Allow names containing dots (qualified names).\n");
+	printf("                                 Blocks, blockinherits, blockabstracts, and\n");
+	printf("                                 in-statements will not be allowed.\n");
 	printf("  -v, --verbose                  increment verbosity level\n");
 	printf("  -h, --help                     display usage information\n");
 	exit(1);
@@ -68,6 +71,7 @@ int main(int argc, char *argv[])
 	struct cil_db *db = NULL;
 	int mls = -1;
 	int preserve_tunables = 0;
+	int qualified_names = 0;
 	int opt_char;
 	int opt_index = 0;
 	enum cil_log_level log_level = CIL_ERR;
@@ -76,13 +80,14 @@ int main(int argc, char *argv[])
 		{"verbose", no_argument, 0, 'v'},
 		{"mls", required_argument, 0, 'M'},
 		{"preserve-tunables", no_argument, 0, 'P'},
+		{"qualified-names", no_argument, 0, 'Q'},
 		{"output", required_argument, 0, 'o'},
 		{0, 0, 0, 0}
 	};
 	int i;
 
 	while (1) {
-		opt_char = getopt_long(argc, argv, "o:hvM:P", long_opts, &opt_index);
+		opt_char = getopt_long(argc, argv, "o:hvM:PQ", long_opts, &opt_index);
 		if (opt_char == -1) {
 			break;
 		}
@@ -102,6 +107,9 @@ int main(int argc, char *argv[])
 			case 'P':
 				preserve_tunables = 1;
 				break;
+			case 'Q':
+				qualified_names = 1;
+				break;
 			case 'o':
 				output = strdup(optarg);
 				break;
@@ -123,6 +131,7 @@ int main(int argc, char *argv[])
 
 	cil_db_init(&db);
 	cil_set_preserve_tunables(db, preserve_tunables);
+	cil_set_qualified_names(db, qualified_names);
 	cil_set_mls(db, mls);
 	cil_set_attrs_expand_generated(db, 0);
 	cil_set_attrs_expand_size(db, 0);
-- 
2.31.1

