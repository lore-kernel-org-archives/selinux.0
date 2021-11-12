Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2E7C433F5
	for <selinux@archiver.kernel.org>; Fri, 12 Nov 2021 15:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A35A560296
	for <selinux@archiver.kernel.org>; Fri, 12 Nov 2021 15:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235315AbhKLPpE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 12 Nov 2021 10:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235273AbhKLPpD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 12 Nov 2021 10:45:03 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1710C0613F5
        for <selinux@vger.kernel.org>; Fri, 12 Nov 2021 07:42:12 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id t18so19894768edd.8
        for <selinux@vger.kernel.org>; Fri, 12 Nov 2021 07:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=JUddoDP6kGYq7g+Vk2s3Fe9n4QrAeiHqLnmwmu+RgEA=;
        b=O1i2L4pLYmwp6RQuJL59QH9BpVuA6KKvisfuepYnD+Dr8liNerKOzl3F2BThmlfrNE
         1dhJlSPbGjBdVbY5QvAJE1tyiR1NXMdxzWGgGlwEvqSLAIjwcEMoZANbn2S5EeXJ1Teq
         0VvbqhtDcwLYgf/3jaLJwRuZYOxIM6YMCfQ+jtPdbmW5m/FtjsVFKEnst0gchBQEGJTy
         /gWMCNSPqW2KFoWLDPPTiIwMBWy4AuaHKMujGVg268EL8nAOWTYSqVWDXFD/cbmbvbvD
         ClNTl+MeoF0Qg1IhmTLfhWQhXfdw5mOMj0hzIEJTwg0naLfSHWmuQG2m9JG8wbSf7edv
         RViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JUddoDP6kGYq7g+Vk2s3Fe9n4QrAeiHqLnmwmu+RgEA=;
        b=YFWmPnuabRgb1gP4BLAQSGfu1fJHJBjHAiks+v9uaEFkW71ZgVMJv4W4chlMvT8MZL
         0FJYG3NHAqROzMqD0xx/Rs2Zey1NnkblPjBVJXPo3KpTqn3RK6hfDgU6DUvPyXqCC48V
         TwB8Zf31s3C2Z4Y6LhZkU4w8h9ZQLP7t3802KOoluuzsMWI5ZWNr0g6mUToNmO7O/+MU
         B8bYizgPrDkaD6OntTtwPKl1hkpadX6IDyyZ539d+vWq3vJMmyO4WKGycrIZvJ1QuDmW
         lwWDrIDRMejzhG2N7Ke5aheu2FGi2xbryFDIha5kjHvRm4wjef2s0M0mlgbbwB/vhkXb
         7NuA==
X-Gm-Message-State: AOAM531mtJYzIUZMiYqd+foMWrrenNJyOqgAld7NV21opo7a3nW9u+8E
        8cRkznWaW8nucA1GE+Y4Z+BLH7ZrDn0=
X-Google-Smtp-Source: ABdhPJyVYgBdhNWmAhf/4d31E5uB0xUzd2XV9OIsHQAfg+IQk5jo2omMYVpyGpTWivDSwY/wVoGb+Q==
X-Received: by 2002:a17:907:72cf:: with SMTP id du15mr20496783ejc.167.1636731731468;
        Fri, 12 Nov 2021 07:42:11 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-000-195-130.77.0.pool.telefonica.de. [77.0.195.130])
        by smtp.gmail.com with ESMTPSA id m9sm2628914eje.102.2021.11.12.07.42.10
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 07:42:11 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 09/12] mcstrans: avoid missing prototypes
Date:   Fri, 12 Nov 2021 16:41:58 +0100
Message-Id: <20211112154201.78217-9-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211112154201.78217-1-cgzones@googlemail.com>
References: <20211112154201.78217-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Mark local functions static.
Export functions of mcscolor.c in mcscolor.h and avoid bare extern
function declarations.
Drop unused function emit_whitespace().

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 mcstrans/src/mcscolor.c  |  2 ++
 mcstrans/src/mcscolor.h  |  8 ++++++
 mcstrans/src/mcstrans.c  | 57 ++++++++++++++++++----------------------
 mcstrans/src/mcstrans.h  |  1 -
 mcstrans/src/mcstransd.c | 13 +++------
 5 files changed, 38 insertions(+), 43 deletions(-)
 create mode 100644 mcstrans/src/mcscolor.h

diff --git a/mcstrans/src/mcscolor.c b/mcstrans/src/mcscolor.c
index a3838850..9ff0ce2f 100644
--- a/mcstrans/src/mcscolor.c
+++ b/mcstrans/src/mcscolor.c
@@ -11,6 +11,8 @@
 #include <syslog.h>
 #include <selinux/selinux.h>
 #include <selinux/context.h>
+
+#include "mcscolor.h"
 #include "mcstrans.h"
 
 /* Define data structures */
diff --git a/mcstrans/src/mcscolor.h b/mcstrans/src/mcscolor.h
new file mode 100644
index 00000000..c37fe6ed
--- /dev/null
+++ b/mcstrans/src/mcscolor.h
@@ -0,0 +1,8 @@
+#ifndef __mcscolor_h__
+#define __mcscolor_h__
+
+extern void finish_context_colors(void);
+extern int init_colors(void);
+extern int raw_color(const char *raw, char **color_str);
+
+#endif
diff --git a/mcstrans/src/mcstrans.c b/mcstrans/src/mcstrans.c
index e92dfddb..09577ea0 100644
--- a/mcstrans/src/mcstrans.c
+++ b/mcstrans/src/mcstrans.c
@@ -136,7 +136,7 @@ typedef struct cat_constraint {
 
 static cat_constraint_t *cat_constraints;
 
-unsigned int
+static unsigned int
 hash(const char *str) {
 	unsigned int hash = 5381;
 	int c;
@@ -213,7 +213,7 @@ parse_category(ebitmap_t *e, const char *raw, int allowinverse)
 	return 0;
 }
 
-int
+static int
 parse_ebitmap(ebitmap_t *e, ebitmap_t *def, const char *raw) {
 	int rc = ebitmap_cpy(e, def);
 	if (rc < 0)
@@ -224,7 +224,7 @@ parse_ebitmap(ebitmap_t *e, ebitmap_t *def, const char *raw) {
 	return 0;
 }
 
-mls_level_t *
+static mls_level_t *
 parse_raw(const char *raw) {
 	mls_level_t *mls = calloc(1, sizeof(mls_level_t));
 	if (!mls)
@@ -248,7 +248,7 @@ err:
 	return NULL;
 }
 
-void
+static void
 destroy_word(word_t **list, word_t *word) {
 	if (!word) {
 		return;
@@ -267,7 +267,7 @@ destroy_word(word_t **list, word_t *word) {
 	free(word);
 }
 
-word_t *
+static word_t *
 create_word(word_t **list, const char *text) {
 	word_t *w = calloc(1, sizeof(word_t));
 	if (!w) {
@@ -291,7 +291,7 @@ err:
 	return NULL;
 }
 
-void
+static void
 destroy_group(word_group_t **list, word_group_t *group) {
 	for (; list && *list; list = &(*list)->next) {
 		if (*list == group) {
@@ -324,7 +324,7 @@ destroy_group(word_group_t **list, word_group_t *group) {
 	free(group);
 }
 
-word_group_t *
+static word_group_t *
 create_group(word_group_t **list, const char *name) {
 	word_group_t *group = calloc(1, sizeof(word_group_t));
 	if (!group)
@@ -357,7 +357,7 @@ err:
 	return NULL;
 }
 
-void
+static void
 destroy_domain(domain_t *domain) {
 	int i;
         unsigned int rt = 0, tr = 0;
@@ -401,7 +401,7 @@ destroy_domain(domain_t *domain) {
 	syslog(LOG_INFO, "cache sizes: tr = %u, rt = %u", tr, rt);
 }
 
-domain_t *
+static domain_t *
 create_domain(const char *name) {
 	domain_t *domain = calloc(1, sizeof(domain_t));
 	if (!domain) {
@@ -425,7 +425,7 @@ err:
 	return NULL;
 }
 
-int
+static int
 add_word(word_group_t *group, char *raw, char *trans) {
 	if (strchr(trans,'-')) {
 		log_error("'%s'is invalid because '-' is illegal in modifiers.\n", trans);
@@ -451,7 +451,7 @@ add_word(word_group_t *group, char *raw, char *trans) {
 	return 0;
 }
 
-int
+static int
 add_constraint(char op, char *raw, char *tok) {
 	log_debug("%s\n", "add_constraint");
 	ebitmap_t empty;
@@ -521,7 +521,7 @@ add_constraint(char op, char *raw, char *tok) {
 	return 0;
 }
 
-int
+static int
 violates_constraints(mls_level_t *l) {
 	int nbits;
 	sens_constraint_t *s;
@@ -563,7 +563,7 @@ violates_constraints(mls_level_t *l) {
 	return 0;
 }
 
-void
+static void
 destroy_sens_constraint(sens_constraint_t **list, sens_constraint_t *constraint) {
 	if (!constraint) {
 		return;
@@ -580,7 +580,7 @@ destroy_sens_constraint(sens_constraint_t **list, sens_constraint_t *constraint)
 	free(constraint);
 }
 
-void
+static void
 destroy_cat_constraint(cat_constraint_t **list, cat_constraint_t *constraint) {
 	if (!constraint) {
 		return;
@@ -663,7 +663,7 @@ find_in_table(context_map_node_t **table, const char *key) {
 	return NULL;
 }
 
-char *
+static char *
 trim(char *str, const char *whitespace) {
 	char *p = str + strlen(str);
 
@@ -672,7 +672,7 @@ trim(char *str, const char *whitespace) {
 	return str;
 }
 
-char *
+static char *
 triml(char *str, const char *whitespace) {
 	char *p = str;
 
@@ -681,7 +681,7 @@ triml(char *str, const char *whitespace) {
 	return p;
 }
 
-int
+static int
 update(char **p, char *const val) {
 	free (*p);
 	*p = strdup(val);
@@ -692,7 +692,7 @@ update(char **p, char *const val) {
 	return 0;
 }
 
-int
+static int
 append(affix_t **affixes, const char *val) {
 	affix_t *affix = calloc(1, sizeof(affix_t));
 	if (!affix) {
@@ -887,7 +887,7 @@ init_translations(void) {
 	return(read_translations(selinux_translations_path()));
 }
 
-char *
+static char *
 extract_range(const char *incon) {
 	context_t con = context_new(incon);
 	if (!con) {
@@ -910,7 +910,7 @@ extract_range(const char *incon) {
 	return r;
 }
 
-char *
+static char *
 new_context_str(const char *incon, const char *range) {
 	char *rcon = NULL;
 	context_t con = context_new(incon);
@@ -931,7 +931,7 @@ exit:
 	return NULL;
 }
 
-char *
+static char *
 find_in_hashtable(const char *range, domain_t *domain, context_map_node_t **table) {
 	char *trans = NULL;
 	context_map_t *map = find_in_table(table, range);
@@ -946,13 +946,6 @@ find_in_hashtable(const char *range, domain_t *domain, context_map_node_t **tabl
 	return trans;
 }
 
-void
-emit_whitespace(char*buffer, char *whitespace) {
-	strcat(buffer, "[");
-	strcat(buffer, whitespace);
-	strcat(buffer, "]");
-}
-
 static int
 string_size(const void *p1, const void *p2) {
 	return strlen(*(char **)p2) - strlen(*(char **)p1);
@@ -969,7 +962,7 @@ word_size(const void *p1, const void *p2) {
 	return (w2_len - w1_len);
 }
 
-void
+static void
 build_regexp(pcre **r, char *buffer) {
 	const char *error;
 	int error_offset;
@@ -982,7 +975,7 @@ build_regexp(pcre **r, char *buffer) {
 	buffer[0] = '\0';
 }
 
-int
+static int
 build_regexps(domain_t *domain) {
 	char buffer[1024 * 128];
 	buffer[0] = '\0';
@@ -1086,7 +1079,7 @@ build_regexps(domain_t *domain) {
 	return 0;
 }
 
-char *
+static char *
 compute_raw_from_trans(const char *level, domain_t *domain) {
 
 #ifdef DEBUG
@@ -1278,7 +1271,7 @@ err:
 	return NULL;
 }
 
-char *
+static char *
 compute_trans_from_raw(const char *level, domain_t *domain) {
 
 #ifdef DEBUG
diff --git a/mcstrans/src/mcstrans.h b/mcstrans/src/mcstrans.h
index e5cda93b..0addb325 100644
--- a/mcstrans/src/mcstrans.h
+++ b/mcstrans/src/mcstrans.h
@@ -6,4 +6,3 @@ extern int init_translations(void);
 extern void finish_context_translations(void);
 extern int trans_context(const char *, char **);
 extern int untrans_context(const char *, char **);
-
diff --git a/mcstrans/src/mcstransd.c b/mcstrans/src/mcstransd.c
index 59c152e7..536c0f32 100644
--- a/mcstrans/src/mcstransd.c
+++ b/mcstrans/src/mcstransd.c
@@ -16,6 +16,8 @@
 #include <sys/types.h>
 #include <sys/uio.h>
 #include <sys/un.h>
+
+#include "mcscolor.h"
 #include "mcstrans.h"
 
 #ifdef UNUSED
@@ -43,15 +45,6 @@
 #define log_debug(fmt, ...) do {} while (0)
 #endif
 
-extern int init_translations(void);
-extern void finish_context_translations(void);
-extern int trans_context(const char *, char **);
-extern int untrans_context(const char *, char **);
-
-extern int init_colors(void);
-extern void finish_context_colors(void);
-extern int raw_color(const char *, char **);
-
 #define SETRANSD_PATHNAME "/sbin/mcstransd"
 
 /* name of program (for error messages) */
@@ -514,7 +507,7 @@ initialize(void)
 
 }
 
-void dropprivs(void)
+static void dropprivs(void)
 {
 	cap_t new_caps;
 
-- 
2.33.1

