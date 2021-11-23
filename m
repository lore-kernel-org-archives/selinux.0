Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C273C433F5
	for <selinux@archiver.kernel.org>; Tue, 23 Nov 2021 18:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239847AbhKWSgq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Nov 2021 13:36:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239576AbhKWSgp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Nov 2021 13:36:45 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E10FC061574
        for <selinux@vger.kernel.org>; Tue, 23 Nov 2021 10:33:37 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id r11so96043917edd.9
        for <selinux@vger.kernel.org>; Tue, 23 Nov 2021 10:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NaeaOBO/Q1Qh32FsTl0pwOCuma/9IcYwUUSSAUNIJo4=;
        b=nt0LA1aXjra1c+Q9Iv7KYFZ3cEy+BgLXalGleE+VWq71UUqs9Md3DT2jRKeFmOVtE3
         Vx7o2C99iPjtFS2cEov7BRbS4D9YKgWdt91ZZ6p1Ic2C4fN1DX4bdsuvA6TeV/Bc5PsL
         g2evpXGcuDO0+mYI8izjTX5fe+DZay86aW6gLNsXZBty0XXzTvLinQWydLbHpnhL+3uB
         ky6uw/UQakWhACDK8k7aPYUkSdtV8qtC+aAtDxveO3O4QQjnp7tn9LyKU9kDdrgPMt7P
         W3yuPUjIxGE4kFUzttRhwZH9tYuKozJ1Y+1kRHREON3TNygopEhNn7IA2gCtgZs2ow0i
         MMWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NaeaOBO/Q1Qh32FsTl0pwOCuma/9IcYwUUSSAUNIJo4=;
        b=zce7GZFqt+rCXA/KAgj5rugjXfOBdo/Vbudr061GE3B2hyPRSiXvGX5xtvAfD0g/rN
         AN8+t7CyHkNsOPVTCx7F+sz6DVYxsBHySYpXGC1Dj1xNRrdS3aUrmaygdPQC1OPJ1Bfv
         NSGNLgx0hg5z2qp3zMfkktFIw25aMIjGcqrpJbvGLIcbQBXnavYQKwmTyamLc7x7FleW
         9ThNzr4XtSEj3x3jad0tNbd0dPWCfc3jy45sQj5V3Pie3D6+UnRm9Q0RVTnIq4KXjMck
         4rj4m2oKMaQEwmhyDmQumbo+SYlr6W8Q1rv6rBiR9ICkgXNz02eboWp2/L/7901KdECc
         97Dw==
X-Gm-Message-State: AOAM533yoAtTNIiTsM+CAdEGpcUpftR+NpxqMSkjiLMRb/j8BjRH8+1V
        /lKILT7tKz37/XXSof2q28geA4PYywg=
X-Google-Smtp-Source: ABdhPJwbgB5arHPfxCfKFGQpMuBPsWImEFhWaiW+h9jctfKwKGBRUWOcfpFmfBj1eQkYZmKzPlDBUQ==
X-Received: by 2002:a05:6402:4248:: with SMTP id g8mr12814200edb.182.1637692415837;
        Tue, 23 Nov 2021 10:33:35 -0800 (PST)
Received: from debianHome.localdomain (dynamic-095-112-244-006.95.112.pool.telefonica.de. [95.112.244.6])
        by smtp.gmail.com with ESMTPSA id k16sm6159714edq.77.2021.11.23.10.33.35
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 10:33:35 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/3] mcstrans: port to new PCRE2 from end-of-life PCRE
Date:   Tue, 23 Nov 2021 19:32:47 +0100
Message-Id: <20211123183249.6133-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Quoting pcre.org:

    There are two major versions of the PCRE library. The current
    version, PCRE2, released in 2015, is now at version 10.39.

    The older, but still widely deployed PCRE library, originally
    released in 1997, is at version 8.45. This version of PCRE is now at
    end of life, and is no longer being actively maintained. Version
    8.45 is expected to be the final release of the older PCRE library,
    and new projects should use PCRE2 instead.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 mcstrans/Makefile       |   6 ++
 mcstrans/src/Makefile   |   4 +-
 mcstrans/src/mcstrans.c | 119 +++++++++++++++++++++++++++-------------
 mcstrans/utils/Makefile |   6 +-
 4 files changed, 93 insertions(+), 42 deletions(-)

diff --git a/mcstrans/Makefile b/mcstrans/Makefile
index c993a9f5..b20279ab 100644
--- a/mcstrans/Makefile
+++ b/mcstrans/Makefile
@@ -1,3 +1,9 @@
+PKG_CONFIG ?= pkg-config
+PCRE_MODULE := libpcre2-8
+PCRE_CFLAGS := $(shell $(PKG_CONFIG) --cflags $(PCRE_MODULE)) -DPCRE2_CODE_UNIT_WIDTH=8
+PCRE_LDLIBS := $(shell $(PKG_CONFIG) --libs $(PCRE_MODULE))
+export PCRE_MODULE PCRE_CFLAGS PCRE_LDLIBS
+
 all: 
 	$(MAKE) -C src 
 	$(MAKE) -C utils
diff --git a/mcstrans/src/Makefile b/mcstrans/src/Makefile
index 76ef0557..ef518625 100644
--- a/mcstrans/src/Makefile
+++ b/mcstrans/src/Makefile
@@ -20,10 +20,10 @@ CFLAGS ?= -Wall -W -Wundef -Wmissing-noreturn -Wmissing-format-attribute
 all: $(PROG)
 
 $(PROG): $(PROG_OBJS) $(LIBSEPOLA)
-	$(CC) $(LDFLAGS) -pie -o $@ $^ -lselinux -lcap -lpcre $(LDLIBS_LIBSEPOLA)
+	$(CC) $(LDFLAGS) -pie -o $@ $^ -lselinux -lcap $(PCRE_LDLIBS) $(LDLIBS_LIBSEPOLA)
 
 %.o:  %.c 
-	$(CC) $(CFLAGS) -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -fPIE -c -o $@ $<
+	$(CC) $(CFLAGS) $(PCRE_CFLAGS) -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -fPIE -c -o $@ $<
 
 install: all
 	test -d $(DESTDIR)$(SBINDIR) || install -m 755 -d $(DESTDIR)$(SBINDIR)
diff --git a/mcstrans/src/mcstrans.c b/mcstrans/src/mcstrans.c
index 09577ea0..60b9291b 100644
--- a/mcstrans/src/mcstrans.c
+++ b/mcstrans/src/mcstrans.c
@@ -26,7 +26,7 @@
 #include <selinux/context.h>
 #include <syslog.h>
 #include <errno.h>
-#include <pcre.h>
+#include <pcre2.h>
 #include <ctype.h>
 #include <time.h>
 #include <sys/time.h>
@@ -36,7 +36,6 @@
 #include "mcstrans.h"
 
 #define N_BUCKETS 1453
-#define OVECCOUNT (512*3)
 
 #define log_error(fmt, ...) fprintf(stderr, fmt, __VA_ARGS__)
 
@@ -82,9 +81,9 @@ typedef struct word_group {
 	affix_t *suffixes;
 	word_t *words;
 
-	pcre *prefix_regexp;
-	pcre *word_regexp;
-	pcre *suffix_regexp;
+	pcre2_code *prefix_regexp;
+	pcre2_code *word_regexp;
+	pcre2_code *suffix_regexp;
 
 	ebitmap_t def;
 
@@ -109,7 +108,7 @@ typedef struct domain {
 	base_classification_t *base_classifications;
 	word_group_t *groups;
 
-	pcre *base_classification_regexp;
+	pcre2_code *base_classification_regexp;
 	struct domain *next;
 } domain_t;
 
@@ -317,9 +316,9 @@ destroy_group(word_group_t **list, word_group_t *group) {
 	free(group->name);
 	free(group->sword);
 	free(group->join);
-	pcre_free(group->prefix_regexp);
-	pcre_free(group->word_regexp);
-	pcre_free(group->suffix_regexp);
+	pcre2_code_free(group->prefix_regexp);
+	pcre2_code_free(group->word_regexp);
+	pcre2_code_free(group->suffix_regexp);
 	ebitmap_destroy(&group->def);
 	free(group);
 }
@@ -392,7 +391,7 @@ destroy_domain(domain_t *domain) {
 		free(domain->base_classifications);
 		domain->base_classifications = next;
 	}
-	pcre_free(domain->base_classification_regexp);
+	pcre2_code_free(domain->base_classification_regexp);
 	while (domain->groups)
 		destroy_group(&domain->groups, domain->groups);
 	free(domain->name);
@@ -963,14 +962,16 @@ word_size(const void *p1, const void *p2) {
 }
 
 static void
-build_regexp(pcre **r, char *buffer) {
-	const char *error;
-	int error_offset;
+build_regexp(pcre2_code **r, char *buffer) {
+	int error;
+	PCRE2_SIZE error_offset;
 	if (*r)
-		pcre_free(*r);
-	*r = pcre_compile(buffer, PCRE_CASELESS, &error, &error_offset, NULL);
-	if (error) {
-		log_error("pcre=%s, error=%s\n", buffer, error ? error: "none");
+		pcre2_code_free(*r);
+	*r = pcre2_compile((PCRE2_SPTR8) buffer, PCRE2_ZERO_TERMINATED, PCRE2_CASELESS, &error, &error_offset, NULL);
+	if (!*r) {
+		PCRE2_UCHAR errbuf[256];
+  		pcre2_get_error_message(error, errbuf, sizeof(errbuf));
+		log_error("pcre compilation of '%s' failed at offset %zu: %s\n", buffer, error_offset, errbuf);
 	}
 	buffer[0] = '\0';
 }
@@ -1088,14 +1089,14 @@ compute_raw_from_trans(const char *level, domain_t *domain) {
 #endif
 
 	int rc = 0;
-	int ovector[OVECCOUNT];
 	word_group_t *g = NULL;
 	char *work = NULL;
 	char *r = NULL;
-	const char * match = NULL;
-	int work_len;
+	size_t work_len;
 	mls_level_t *mraw = NULL;
 	ebitmap_t set, clear, tmp;
+	PCRE2_UCHAR *match = NULL;
+	pcre2_match_data *match_data = NULL;
 
 	ebitmap_init(&set);
 	ebitmap_init(&clear);
@@ -1114,14 +1115,21 @@ compute_raw_from_trans(const char *level, domain_t *domain) {
 	if (!domain->base_classification_regexp)
 		goto err;
 	log_debug(" compute_raw_from_trans work = %s\n", work);
-	rc = pcre_exec(domain->base_classification_regexp, 0, work, work_len, 0, PCRE_ANCHORED, ovector, OVECCOUNT);
+	match_data = pcre2_match_data_create_from_pattern(domain->base_classification_regexp, NULL);
+	if (!match_data) {
+		log_error("allocation error %s", strerror(errno));
+		goto err;
+	}
+	rc = pcre2_match(domain->base_classification_regexp, (PCRE2_SPTR8)work, work_len, 0, PCRE2_ANCHORED, match_data, NULL);
 	if (rc > 0) {
-		match = NULL;
-		pcre_get_substring(work, ovector, rc, 0, &match);
-		log_debug(" compute_raw_from_trans match = %s len = %u\n", match, strlen(match));
+		PCRE2_SIZE match_size;
+		const PCRE2_SIZE *ovector;
+		if (!pcre2_substring_get_bynumber(match_data, 0, &match, &match_size))
+			goto err;
+		log_debug(" compute_raw_from_trans match = %s len = %zu\n", match, strlen((const char *)match));
 		base_classification_t *bc;
 		for (bc = domain->base_classifications; bc; bc = bc->next) {
-			if (!strcmp(bc->trans, match)) {
+			if (!strcmp(bc->trans, (const char *)match)) {
 				log_debug(" compute_raw_from_trans base classification %s matched %s\n", level, bc->trans);
 				mraw = malloc(sizeof(mls_level_t));
 				if (!mraw) {
@@ -1134,16 +1142,27 @@ compute_raw_from_trans(const char *level, domain_t *domain) {
 			}
 		}
 
+		ovector = pcre2_get_ovector_pointer(match_data);
 		memset(work + ovector[0], '#', ovector[1] - ovector[0]);
 		char *p=work + ovector[0] + ovector[1];
 		while (*p && (strchr(" 	", *p) != NULL))
 			*p++ = '#';
-		pcre_free((char *)match);
+		pcre2_substring_free(match);
 		match = NULL;
 	} else {
-		log_debug(" compute_raw_from_trans no base classification matched %s\n", level);
+		switch (rc) {
+		case PCRE2_ERROR_NOMATCH:
+			log_debug(" compute_raw_from_trans no base classification matched %s\n", level);
+			break;
+		default:
+			log_error("compute_raw_from_trans: matching error for input '%s': %d\n", level, rc);
+			break;
+		}		
 	}
 
+	pcre2_match_data_free(match_data);
+	match_data = NULL;
+
 	if (mraw == NULL) {
 		goto err;
 	}
@@ -1154,23 +1173,39 @@ compute_raw_from_trans(const char *level, domain_t *domain) {
 		change = 0;
 		for (g = domain->groups; g && !change && !complete; g = g->next) {
 			int prefix = 0, suffix = 0;
-			int prefix_offset = 0, prefix_len = 0;
-			int suffix_offset = 0, suffix_len = 0;
+			PCRE2_SIZE prefix_offset = 0, prefix_len = 0;
+			PCRE2_SIZE suffix_offset = 0, suffix_len = 0;
 			if (g->prefix_regexp) {
-				rc = pcre_exec(g->prefix_regexp, 0, work, work_len, 0, 0, ovector, OVECCOUNT);
+				match_data = pcre2_match_data_create_from_pattern(g->prefix_regexp, NULL);
+				if (!match_data) {
+					log_error("allocation error %s", strerror(errno));
+					goto err;
+				}
+				rc = pcre2_match(g->prefix_regexp, (PCRE2_SPTR8)work, work_len, 0, 0, match_data, NULL);
 				if (rc > 0) {
+					const PCRE2_SIZE *ovector = pcre2_get_ovector_pointer(match_data);
 					prefix = 1;
 					prefix_offset = ovector[0];
 					prefix_len = ovector[1] - ovector[0];
 				}
+				pcre2_match_data_free(match_data);
+				match_data = NULL;
 			}
 			if (g->suffix_regexp) {
-				rc = pcre_exec(g->suffix_regexp, 0, work, work_len, 0, 0, ovector, OVECCOUNT);
+				match_data = pcre2_match_data_create_from_pattern(g->suffix_regexp, NULL);
+				if (!match_data) {
+					log_error("allocation error %s", strerror(errno));
+					goto err;
+				}
+				rc = pcre2_match(g->suffix_regexp, (PCRE2_SPTR8)work, work_len, 0, 0, match_data, NULL);
 				if (rc > 0) {
+					const PCRE2_SIZE *ovector = pcre2_get_ovector_pointer(match_data);
 					suffix = 1;
 					suffix_offset = ovector[0];
 					suffix_len = ovector[1] - ovector[0];
 				}
+				pcre2_match_data_free(match_data);
+				match_data = NULL;
 			}
 
 /* anchors prefix ^, suffix $ */
@@ -1179,11 +1214,18 @@ compute_raw_from_trans(const char *level, domain_t *domain) {
 			     (g->suffixes && suffix)) &&
 			     g->word_regexp) {
 				char *s = work + prefix_offset + prefix_len;
-				int l = (suffix_len ? suffix_offset : work_len) - prefix_len - prefix_offset;
-				rc = pcre_exec(g->word_regexp, 0, s, l, 0, 0, ovector, OVECCOUNT);
+				PCRE2_SIZE len = (suffix_len ? suffix_offset : work_len) - prefix_len - prefix_offset;
+				match_data = pcre2_match_data_create_from_pattern(g->word_regexp, NULL);
+				if (!match_data) {
+					log_error("allocation error %s", strerror(errno));
+					goto err;
+				}
+				rc = pcre2_match(g->word_regexp, (PCRE2_SPTR8)s, len, 0, 0, match_data, NULL);
 				if (rc > 0) {
-					match = NULL;
-					pcre_get_substring(s, ovector, rc, 0, &match);
+					PCRE2_SIZE match_size;
+					const PCRE2_SIZE *ovector = pcre2_get_ovector_pointer(match_data);
+					if (!pcre2_substring_get_bynumber(match_data, 0, &match, &match_size))
+						goto err;
 					trim((char *)match, g->whitespace);
 					if (*match) {
 						char *p = triml((char *)match, g->whitespace);
@@ -1223,9 +1265,11 @@ compute_raw_from_trans(const char *level, domain_t *domain) {
 						memset(work + suffix_offset, '#', suffix_len);
 						memset(s + ovector[0], '#', ovector[1] - ovector[0]);
 					}
-					pcre_free((void *)match);
+					pcre2_substring_free(match);
 					match = NULL;
 				}
+				pcre2_match_data_free(match_data);
+				match_data = NULL;
 			}
 /* YYY */
 			complete=1;
@@ -1264,10 +1308,11 @@ err:
 	mls_level_destroy(mraw);
 	free(mraw);
 	free(work);
-	pcre_free((void *)match);
 	ebitmap_destroy(&tmp);
 	ebitmap_destroy(&set);
 	ebitmap_destroy(&clear);
+	pcre2_substring_free(match);
+	pcre2_match_data_free(match_data);
 	return NULL;
 }
 
diff --git a/mcstrans/utils/Makefile b/mcstrans/utils/Makefile
index 9dfe7723..a48f4e72 100644
--- a/mcstrans/utils/Makefile
+++ b/mcstrans/utils/Makefile
@@ -14,13 +14,13 @@ endif
 all: $(TARGETS)
 
 transcon: transcon.o ../src/mcstrans.o ../src/mls_level.o $(LIBSEPOLA)
-	$(CC) $(LDFLAGS) -o $@ $^ -lpcre -lselinux $(LDLIBS_LIBSEPOLA)
+	$(CC) $(LDFLAGS) -o $@ $^ $(PCRE_LDLIBS) -lselinux $(LDLIBS_LIBSEPOLA)
 
 untranscon: untranscon.o ../src/mcstrans.o ../src/mls_level.o $(LIBSEPOLA)
-	$(CC) $(LDFLAGS) -o $@ $^ -lpcre -lselinux $(LDLIBS_LIBSEPOLA)
+	$(CC) $(LDFLAGS) -o $@ $^ $(PCRE_LDLIBS) -lselinux $(LDLIBS_LIBSEPOLA)
 
 %.o:  %.c 
-	$(CC) $(CFLAGS) -D_GNU_SOURCE -I../src -fPIE -c -o $@ $<
+	$(CC) $(CFLAGS) $(PCRE_CFLAGS) -D_GNU_SOURCE -I../src -fPIE -c -o $@ $<
 
 install: all
 	-mkdir -p $(DESTDIR)$(SBINDIR)
-- 
2.34.0

