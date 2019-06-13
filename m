Return-Path: <SRS0=L/M1=UM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B829AC31E45
	for <selinux@archiver.kernel.org>; Thu, 13 Jun 2019 15:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91656206BB
	for <selinux@archiver.kernel.org>; Thu, 13 Jun 2019 15:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbfFMP0W (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:26:22 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34512 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729216AbfFMLqE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Jun 2019 07:46:04 -0400
Received: by mail-wm1-f65.google.com with SMTP id w9so6440623wmd.1
        for <selinux@vger.kernel.org>; Thu, 13 Jun 2019 04:46:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pt2qT3+bo4o+3RMCu3laPePon0gCUEX1f5s3e1eN4QI=;
        b=BfYS4v1O00BBSYB0dI2niu4ubucvvO73xZ/imbVRQqwIG5L91eVJkFr3CZ6L4ee3qq
         CuSLaZuOLEZDjsM1SEaBgCjAlsswVYS32fBfmDbVBhTzAZj6OYCi2/xgGdDMcti+hOH1
         vgAMiVSf00P3HRD5DvgmeV0KkinICNUSQIavmp8kG7FplRwQyttXg2pCZxb1ew3HHX2z
         eKYWhwqNWOaad4uNNsLw6TUGR4nNIeTveG/UvWZ7quUAxup71UIrXgQKNN0gFdmWfPE6
         2m/9H+L5ZUxB1CiMLnFUABv9+rSeBMbXBkndDfd9fio4S2xcaSu5/V0/mV+G8Ft190PB
         zJZA==
X-Gm-Message-State: APjAAAWWbEz83Ysy6eqUIzy61p851j3/MApzLliCOebZsGg4v72tN1NT
        dW2BnfdHmezfiRFD6uqEW1DUk1fvQi4=
X-Google-Smtp-Source: APXvYqzCSI/lQswTmdSCLsmWocfFogeQs0EzJSfyeMnXUmrAHLMcXErFn1cAOlu0Fx4Mb9MjFWpgTQ==
X-Received: by 2002:a1c:40c6:: with SMTP id n189mr3387125wma.118.1560426362656;
        Thu, 13 Jun 2019 04:46:02 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id b203sm2906357wmd.41.2019.06.13.04.46.01
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 04:46:02 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace v4 2/4] libsemanage: optionally optimize policy on rebuild
Date:   Thu, 13 Jun 2019 13:45:56 +0200
Message-Id: <20190613114558.32621-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613114558.32621-1-omosnace@redhat.com>
References: <20190613114558.32621-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When building binary policy, optionally run it through
sepol_policydb_optimize() just before writing it out.

Add an optimize-policy variable to semanage.conf(5) that controls
whether optimization will be applied during libsemanage operations.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 libsemanage/man/man5/semanage.conf.5 |  5 +++++
 libsemanage/src/conf-parse.y         | 15 ++++++++++++++-
 libsemanage/src/conf-scan.l          |  1 +
 libsemanage/src/direct_api.c         |  7 +++++++
 libsemanage/src/semanage_conf.h      |  1 +
 5 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/libsemanage/man/man5/semanage.conf.5 b/libsemanage/man/man5/semanage.conf.5
index 8f8de55a..8efc7dd5 100644
--- a/libsemanage/man/man5/semanage.conf.5
+++ b/libsemanage/man/man5/semanage.conf.5
@@ -121,6 +121,11 @@ and by default it is set to "false".
 Please note that since this option deletes all HLL files, an updated HLL compiler will not be able to recompile the original HLL file into CIL.
 In order to compile the original HLL file into CIL, the same HLL file will need to be reinstalled.
 
+.TP
+.B optimize-policy
+When set to "true", the kernel policy will be optimized upon rebuilds.
+It can be set to either "true" or "false" and by default it is set to "false".
+
 .SH "SEE ALSO"
 .TP
 semanage(8)
diff --git a/libsemanage/src/conf-parse.y b/libsemanage/src/conf-parse.y
index b527e893..9bf9364a 100644
--- a/libsemanage/src/conf-parse.y
+++ b/libsemanage/src/conf-parse.y
@@ -59,7 +59,7 @@ static int parse_errors;
         char *s;
 }
 
-%token MODULE_STORE VERSION EXPAND_CHECK FILE_MODE SAVE_PREVIOUS SAVE_LINKED TARGET_PLATFORM COMPILER_DIR IGNORE_MODULE_CACHE STORE_ROOT
+%token MODULE_STORE VERSION EXPAND_CHECK FILE_MODE SAVE_PREVIOUS SAVE_LINKED TARGET_PLATFORM COMPILER_DIR IGNORE_MODULE_CACHE STORE_ROOT OPTIMIZE_POLICY
 %token LOAD_POLICY_START SETFILES_START SEFCONTEXT_COMPILE_START DISABLE_GENHOMEDIRCON HANDLE_UNKNOWN USEPASSWD IGNOREDIRS
 %token BZIP_BLOCKSIZE BZIP_SMALL REMOVE_HLL
 %token VERIFY_MOD_START VERIFY_LINKED_START VERIFY_KERNEL_START BLOCK_END
@@ -95,6 +95,7 @@ single_opt:     module_store
 	|	bzip_blocksize
 	|	bzip_small
 	|	remove_hll
+	|	optimize_policy
         ;
 
 module_store:   MODULE_STORE '=' ARG {
@@ -268,6 +269,17 @@ remove_hll:  REMOVE_HLL'=' ARG {
 	free($3);
 }
 
+optimize_policy:  OPTIMIZE_POLICY '=' ARG {
+	if (strcasecmp($3, "false") == 0) {
+		current_conf->optimize_policy = 0;
+	} else if (strcasecmp($3, "true") == 0) {
+		current_conf->optimize_policy = 1;
+	} else {
+		yyerror("optimize-policy can only be 'true' or 'false'");
+	}
+	free($3);
+}
+
 command_block: 
                 command_start external_opts BLOCK_END  {
                         if (new_external->path == NULL) {
@@ -352,6 +364,7 @@ static int semanage_conf_init(semanage_conf_t * conf)
 	conf->bzip_small = 0;
 	conf->ignore_module_cache = 0;
 	conf->remove_hll = 0;
+	conf->optimize_policy = 0;
 
 	conf->save_previous = 0;
 	conf->save_linked = 0;
diff --git a/libsemanage/src/conf-scan.l b/libsemanage/src/conf-scan.l
index 607bbf0b..b06a896c 100644
--- a/libsemanage/src/conf-scan.l
+++ b/libsemanage/src/conf-scan.l
@@ -54,6 +54,7 @@ handle-unknown    return HANDLE_UNKNOWN;
 bzip-blocksize	return BZIP_BLOCKSIZE;
 bzip-small	return BZIP_SMALL;
 remove-hll	return REMOVE_HLL;
+optimize-policy return OPTIMIZE_POLICY;
 "[load_policy]"   return LOAD_POLICY_START;
 "[setfiles]"      return SETFILES_START;
 "[sefcontext_compile]"      return SEFCONTEXT_COMPILE_START;
diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index c58961be..0153091f 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -1461,6 +1461,13 @@ rebuild:
 
 		cil_db_destroy(&cildb);
 
+		/* Remove redundancies in binary policy if requested. */
+		if (sh->conf->optimize_policy) {
+			retval = sepol_policydb_optimize(out);
+			if (retval < 0)
+				goto cleanup;
+		}
+
 		/* Write the linked policy before merging local changes. */
 		retval = semanage_write_policydb(sh, out,
 						 SEMANAGE_LINKED);
diff --git a/libsemanage/src/semanage_conf.h b/libsemanage/src/semanage_conf.h
index c99ac8c7..23c4b8b4 100644
--- a/libsemanage/src/semanage_conf.h
+++ b/libsemanage/src/semanage_conf.h
@@ -47,6 +47,7 @@ typedef struct semanage_conf {
 	int bzip_small;
 	int remove_hll;
 	int ignore_module_cache;
+	int optimize_policy;
 	char *ignoredirs;	/* ";" separated of list for genhomedircon to ignore */
 	struct external_prog *load_policy;
 	struct external_prog *setfiles;
-- 
2.20.1

