Return-Path: <SRS0=POVk=T4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7709DC04AB6
	for <selinux@archiver.kernel.org>; Tue, 28 May 2019 14:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D056206BA
	for <selinux@archiver.kernel.org>; Tue, 28 May 2019 14:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfE1O70 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 May 2019 10:59:26 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36558 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbfE1O7Z (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 May 2019 10:59:25 -0400
Received: by mail-wm1-f67.google.com with SMTP id v22so3238157wml.1
        for <selinux@vger.kernel.org>; Tue, 28 May 2019 07:59:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=und2ww5Xe1nxbtEO9jVGbLHUQXi/9ikkVavnL0HuKAU=;
        b=rjP9b+GtC13tjbfZYyg/likQweiR/R3y5+GRAOM3ijqKZ6Rvfy77WmFe5TKGFwD4Ja
         6qBL7A9qC1H1vPJAPLulEnagrYiE28rMwMlpnK67ViJHU9FkbY2eZgxe5x1TIcFPumQL
         pHK6Z2Sf8o8iktLIakxYv+UzexStlN5gPRzlGj85QTVmZCzsPO1sjNH5lJE1WKfiU4dQ
         3lxYfNdzohQmQT/f4Og6RVQMJxWlmRrN6nmZOExM3TnJrAdLpKHUhR/3n4RuzTG6p/TY
         /KCF9hwNGyHS4U2IXpKa+zNHC5xYkvHYXSjmvAz4OSA4LkyB0zwkFqAEb3DYh8GSeBoO
         Zo4A==
X-Gm-Message-State: APjAAAUQpsvPlo4BJF+5s9ESpF+PgpIj5225a572r6h8ICh4RszsANk5
        BudS5ry87605/ZAjKTvW8HY2tmcA+Vc=
X-Google-Smtp-Source: APXvYqzyfIW/PzRQbkmZcZAcOtxA/vFlisog8WP/XkcXDdKpQ0EftTVrHpLHRKowGnVw+iblumudJg==
X-Received: by 2002:a05:600c:214d:: with SMTP id v13mr3448693wml.12.1559055562141;
        Tue, 28 May 2019 07:59:22 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id p17sm14118849wrq.95.2019.05.28.07.59.21
        for <selinux@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 07:59:21 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace v2 7/7] [RFC] libsemanage: switch to config file entry
Date:   Tue, 28 May 2019 16:59:12 +0200
Message-Id: <20190528145912.13827-8-omosnace@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190528145912.13827-1-omosnace@redhat.com>
References: <20190528145912.13827-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

(to be squashed with the libsemanage + semodule patches or dropped based
on feedback)

Having a global config option for optimization will make more sense if
e.g. we decide to enable it for all operations in Fedora. In such case
it would be difficult to enforce/encourage the use of -O options
everywhere (semodule, semanage, custom Python scripts, ...). There could
still be command-line options and a libsemanage function to override the
global behavior, but I'm not sure if those would be worth the added
complexity...
---
 libsemanage/include/semanage/handle.h |  4 ----
 libsemanage/src/conf-parse.y          | 15 ++++++++++++++-
 libsemanage/src/conf-scan.l           |  1 +
 libsemanage/src/direct_api.c          |  2 +-
 libsemanage/src/handle.c              | 13 -------------
 libsemanage/src/handle.h              |  1 -
 libsemanage/src/libsemanage.map       |  5 -----
 libsemanage/src/semanage_conf.h       |  1 +
 policycoreutils/semodule/semodule.c   | 15 +++------------
 9 files changed, 20 insertions(+), 37 deletions(-)

diff --git a/libsemanage/include/semanage/handle.h b/libsemanage/include/semanage/handle.h
index f23be35a..c8165900 100644
--- a/libsemanage/include/semanage/handle.h
+++ b/libsemanage/include/semanage/handle.h
@@ -66,10 +66,6 @@ void semanage_set_reload(semanage_handle_t * handle, int do_reload);
  * 1 for yes, 0 for no (default) */
 void semanage_set_rebuild(semanage_handle_t * handle, int do_rebuild);
 
-/* set whether to optimize the policy (remove redundancies) when built.
- * 1 for yes, 0 for no (default) */
-void semanage_set_optimize(semanage_handle_t * handle, int do_optimize);
-
 /* Fills *compiler_path with the location of the hll compiler sh->conf->compiler_directory_path
  * corresponding to lang_ext.
  * Upon success returns 0, -1 on error. */
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
index 95cbee81..0153091f 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -1462,7 +1462,7 @@ rebuild:
 		cil_db_destroy(&cildb);
 
 		/* Remove redundancies in binary policy if requested. */
-		if (sh->do_optimize) {
+		if (sh->conf->optimize_policy) {
 			retval = sepol_policydb_optimize(out);
 			if (retval < 0)
 				goto cleanup;
diff --git a/libsemanage/src/handle.c b/libsemanage/src/handle.c
index 8f4530c2..e5109aef 100644
--- a/libsemanage/src/handle.c
+++ b/libsemanage/src/handle.c
@@ -88,10 +88,6 @@ semanage_handle_t *semanage_handle_create(void)
 	 * If any changes are made, this flag is ignored */
 	sh->do_rebuild = 0;
 
-	/* By default do not optimize policy on rebuild.
-	 * If the policy is not being rebuilt, this flag is ignored. */
-	sh->do_optimize = 0;
-
 	sh->commit_err = 0;
 
 	/* By default always reload policy after commit if SELinux is enabled. */
@@ -129,15 +125,6 @@ void semanage_set_rebuild(semanage_handle_t * sh, int do_rebuild)
 	return;
 }
 
-void semanage_set_optimize(semanage_handle_t * sh, int do_optimize)
-{
-
-	assert(sh != NULL);
-
-	sh->do_optimize = do_optimize;
-	return;
-}
-
 void semanage_set_reload(semanage_handle_t * sh, int do_reload)
 {
 
diff --git a/libsemanage/src/handle.h b/libsemanage/src/handle.h
index b8fbf120..a91907b0 100644
--- a/libsemanage/src/handle.h
+++ b/libsemanage/src/handle.h
@@ -62,7 +62,6 @@ struct semanage_handle {
 	int is_in_transaction;
 	int do_reload;		/* whether to reload policy after commit */
 	int do_rebuild;		/* whether to rebuild policy if there were no changes */
-	int do_optimize;	/* whether to optimize the built policy */
 	int commit_err;		/* set by semanage_direct_commit() if there are
 				 * any errors when building or committing the
 				 * sandbox to kernel policy at /etc/selinux
diff --git a/libsemanage/src/libsemanage.map b/libsemanage/src/libsemanage.map
index 535bd9b5..02036696 100644
--- a/libsemanage/src/libsemanage.map
+++ b/libsemanage/src/libsemanage.map
@@ -63,8 +63,3 @@ LIBSEMANAGE_1.1 {
 	  semanage_module_remove_key;
 	  semanage_set_store_root;
 } LIBSEMANAGE_1.0;
-
-LIBSEMANAGE_1.2 {
-  global:
-	  semanage_set_optimize;
-} LIBSEMANAGE_1.1;
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
diff --git a/policycoreutils/semodule/semodule.c b/policycoreutils/semodule/semodule.c
index 40314117..a76797f5 100644
--- a/policycoreutils/semodule/semodule.c
+++ b/policycoreutils/semodule/semodule.c
@@ -46,7 +46,6 @@ static int verbose;
 static int reload;
 static int no_reload;
 static int build;
-static int optimize;
 static int disable_dontaudit;
 static int preserve_tunables;
 static int ignore_module_cache;
@@ -124,10 +123,9 @@ static void usage(char *progname)
 	printf("usage:  %s [option]... MODE...\n", progname);
 	printf("Manage SELinux policy modules.\n");
 	printf("MODES:\n");
-	printf("  -R,--reload		    reload policy\n");
-	printf("  -B,--build		    build and reload policy\n");
+	printf("  -R, --reload		    reload policy\n");
+	printf("  -B, --build		    build and reload policy\n");
 	printf("  -D,--disable_dontaudit    Remove dontaudits from policy\n");
-	printf("  -O,--optimize		    optimize built policy\n");
 	printf("  -i,--install=MODULE_PKG   install a new module\n");
 	printf("  -r,--remove=MODULE_NAME   remove existing module at desired priority\n");
 	printf("  -l[KIND],--list-modules[=KIND]  display list of installed modules\n");
@@ -193,7 +191,6 @@ static void parse_command_line(int argc, char **argv)
 		{"reload", 0, NULL, 'R'},
 		{"noreload", 0, NULL, 'n'},
 		{"build", 0, NULL, 'B'},
-		{"optimize", 0, NULL, 'O'},
 		{"disable_dontaudit", 0, NULL, 'D'},
 		{"preserve_tunables", 0, NULL, 'P'},
 		{"ignore-module-cache", 0, NULL, 'C'},
@@ -210,10 +207,9 @@ static void parse_command_line(int argc, char **argv)
 	verbose = 0;
 	reload = 0;
 	no_reload = 0;
-	optimize = 0;
 	priority = 400;
 	while ((i =
-		getopt_long(argc, argv, "s:b:hi:l::vr:u:RnNBDOCPX:e:d:p:S:E:cH", opts,
+		getopt_long(argc, argv, "s:b:hi:l::vr:u:RnNBDCPX:e:d:p:S:E:cH", opts,
 			    NULL)) != -1) {
 		switch (i) {
 		case 'b':
@@ -272,9 +268,6 @@ static void parse_command_line(int argc, char **argv)
 		case 'B':
 			build = 1;
 			break;
-		case 'O':
-			optimize = 1;
-			break;
 		case 'D':
 			disable_dontaudit = 1;
 			break;
@@ -745,8 +738,6 @@ cleanup_disable:
 			semanage_set_reload(sh, 0);
 		if (build)
 			semanage_set_rebuild(sh, 1);
-		if (optimize)
-			semanage_set_optimize(sh, 1);
 		if (disable_dontaudit)
 			semanage_set_disable_dontaudit(sh, 1);
 		else if (build)
-- 
2.20.1

