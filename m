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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4FFC49EAB
	for <selinux@archiver.kernel.org>; Thu, 24 Jun 2021 19:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E36161185
	for <selinux@archiver.kernel.org>; Thu, 24 Jun 2021 19:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbhFXUBo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 24 Jun 2021 16:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232778AbhFXUBo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 24 Jun 2021 16:01:44 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9657C061760
        for <selinux@vger.kernel.org>; Thu, 24 Jun 2021 12:59:23 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id g4so16774562qkl.1
        for <selinux@vger.kernel.org>; Thu, 24 Jun 2021 12:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3EfITN/irGToVWBkMD3s90y3eUFguLisHqXzLuQ6mlA=;
        b=HmgM/4g3ZMXX25V+/ND2YPX3c6mQGocQw6ruDgl0bPbjq456fPSIsMrX9m3jt+Wy96
         p+m0B1PERHisRS1I51CiuKFwWrKexImZLgG9VMGrmJHzfsAHbJ/SZozSzS/BuTMtT4U2
         BMtyfEVo5YzsAMXC4PczLoH36Q4um7MfSrj2lhF2nfZ6mG/zlPajGsM2ywJhsp16F/t5
         wX83iawijIKSQ26biWEbZjqrBAkAI/RRLHmc2J3Wp3RqsQzPhlgkPGmOx9X45LfAN0zo
         MGEM0v3jd1L94jO6gMfSKIQTIrrQZYJqLi7XhLpHu20mJ4nsKPrxNXgU7RRDP93AM/PX
         Ibhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3EfITN/irGToVWBkMD3s90y3eUFguLisHqXzLuQ6mlA=;
        b=mPD+sLHcS+HjEZUyQa+SX1z/PxZT5MLbYJfh3XpyTJkuB/9ijOrDztt7AeDS61iiV1
         X55A+XldRCCKhSy5ImTo+sZxCi4ZPz7oUMVsrwo+wKJJzG3dj3gS/8yzmrSCY0iZRUGW
         yY+U+sLyVDJ+Iy/dTkOvxTctKYtk7eUkzfcDCa3Ss4Wv+s6+7UREyV4LFha6eBmCIAA4
         bfP39CuCjFuZsC9vxzwfvwZ8Stu16L9a384xSM2AHLhyyVVp9810ZYu9h0jlKIwoSUTy
         9WXvACFaNOI8lHDWzB96fgJYpDDPNbJtvzUUZ1x/R8AMLSLC7t/tkgOAlajuUYYJrS6R
         dxDw==
X-Gm-Message-State: AOAM532VTSjdWbY/tO5OVtR+YSupidEe/8lqqNoc2wUKXiNRJUdE/7MR
        kbRVspRmR1eAc1Ou7wtAKUMcCuroo7VUTA==
X-Google-Smtp-Source: ABdhPJwQCshGkn7v2SuoEQr8OM7U8THatnMSsJvzB3FUjt3RLTr6HJqAJByCeZhJQ0gony6i9NQ4WQ==
X-Received: by 2002:a05:620a:52c:: with SMTP id h12mr7599831qkh.399.1624564762876;
        Thu, 24 Jun 2021 12:59:22 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id w185sm3345813qkd.30.2021.06.24.12.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 12:59:22 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 4/4] libsepol/cil: Add support for using qualified names to secil2conf
Date:   Thu, 24 Jun 2021 15:59:19 -0400
Message-Id: <20210624195919.148828-4-jwcart2@gmail.com>
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
 secilc/secil2conf.8.xml | 5 +++++
 secilc/secil2conf.c     | 9 ++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/secilc/secil2conf.8.xml b/secilc/secil2conf.8.xml
index 59d87a54..856c1239 100644
--- a/secilc/secil2conf.8.xml
+++ b/secilc/secil2conf.8.xml
@@ -50,6 +50,11 @@
             <listitem><para>Treat tunables as booleans.</para></listitem>
          </varlistentry>
 
+         <varlistentry>
+            <term><option>-Q, --qualified-names</option></term>
+            <listitem><para>Use qualified names. Blocks, blockinherits, blockabstracts, and in-statements will not be allowed.</para></listitem>
+         </varlistentry>
+
          <varlistentry>
             <term><option>-v, --verbose</option></term>
             <listitem><para>Increment verbosity level.</para></listitem>
diff --git a/secilc/secil2conf.c b/secilc/secil2conf.c
index 4e97dd66..7a317ada 100644
--- a/secilc/secil2conf.c
+++ b/secilc/secil2conf.c
@@ -52,6 +52,7 @@ static __attribute__((__noreturn__)) void usage(const char *prog)
 	printf("                                 This will override the (mls boolean) statement\n");
 	printf("                                 if present in the policy\n");
 	printf("  -P, --preserve-tunables        treat tunables as booleans\n");
+	printf("  -Q, --qualified-names          Use qualified names and do not allow blocks\n");
 	printf("  -v, --verbose                  increment verbosity level\n");
 	printf("  -h, --help                     display usage information\n");
 	exit(1);
@@ -68,6 +69,7 @@ int main(int argc, char *argv[])
 	struct cil_db *db = NULL;
 	int mls = -1;
 	int preserve_tunables = 0;
+	int qualified_names = 0;
 	int opt_char;
 	int opt_index = 0;
 	enum cil_log_level log_level = CIL_ERR;
@@ -76,13 +78,14 @@ int main(int argc, char *argv[])
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
@@ -102,6 +105,9 @@ int main(int argc, char *argv[])
 			case 'P':
 				preserve_tunables = 1;
 				break;
+			case 'Q':
+				qualified_names = 1;
+				break;
 			case 'o':
 				output = strdup(optarg);
 				break;
@@ -123,6 +129,7 @@ int main(int argc, char *argv[])
 
 	cil_db_init(&db);
 	cil_set_preserve_tunables(db, preserve_tunables);
+	cil_set_qualified_names(db, qualified_names);
 	cil_set_mls(db, mls);
 	cil_set_attrs_expand_generated(db, 0);
 	cil_set_attrs_expand_size(db, 0);
-- 
2.26.3

