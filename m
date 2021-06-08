Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7497C47082
	for <selinux@archiver.kernel.org>; Tue,  8 Jun 2021 16:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9043260FEA
	for <selinux@archiver.kernel.org>; Tue,  8 Jun 2021 16:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbhFHQCj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Jun 2021 12:02:39 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:39453 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232973AbhFHQCj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Jun 2021 12:02:39 -0400
Received: by mail-ed1-f43.google.com with SMTP id dj8so25126955edb.6
        for <selinux@vger.kernel.org>; Tue, 08 Jun 2021 09:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=IEGuYh6G2GIs2dFAWSQU0XFKcYPcG5199/XNsvfhk1Y=;
        b=YyEV6AM2LPodnAqlCeg/HgKZZ4dgCdcCCcHyEiqE0tCZTXOkCDoY0eJX99uEp3Jj63
         XUqgRGkcro27O8GCLUjfiONqzHfHkMzF18uycFMeXvRtZZT2TKqymVNU1Z6rk00dBPTH
         92sbpF5Dlru9CM8TCLOhhMLh6am8oZFNyYWRv7H4FIVdOkoOjlwTzXwjlGCBo+TOdsEW
         oPKQdZ20oxLyNqf5t3EIAMGeta117vLAhS45VLXDj+nz3htW6+QCuCjLSrrUQVN6l5Ms
         0me28deJkUI7fvCKITkMhUvv/6yYOZTqkobtFjd98VT8RHuHVaM19LilKg6f55ph+3zt
         mJ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IEGuYh6G2GIs2dFAWSQU0XFKcYPcG5199/XNsvfhk1Y=;
        b=m5sjGcltKpuHIrdCYfYzYHGBh3IJB6qE5cuQigQEXpDBq3iRkX+b+9XoyMDP61Gq2O
         ilQa3nthnqtRfhyMJb+b8xJnrmJpB1h6iIBoffPSOMg4IUjPqW2XnVbA7iNrWzQ22CsJ
         fxq5vcZX0jKUF0qQ1+geQvAwVMxByaKY+L6pRmUlU+7ESA+ikqkqzLwMRUTtzdBgk4Mp
         idWtDqF1YLNPOekH+kEoxS4jaJWKGZlfXPE/c8HZe4eaBSjJW3blZdqDdg2sRBWu0UXf
         96ttL9PxAT7bb+7sYBPRFOSE7drVR+GRPsaw7IAZOySuPKrBhIK+iftMEhP00bsH0QN6
         ZAPA==
X-Gm-Message-State: AOAM532L0/6WfVJ8FoKZDgpWVTU0gwHbl1MflumZN4CzbBwxBDw6gbBx
        BMOUvqzOXty7PRMFnfRHXa22iwjSDqM=
X-Google-Smtp-Source: ABdhPJzyyA87MakTENXkNsTlMF14TjEgPAe2fCRUMpmtZuSz8newhnimSRKpS+5Dnq7iKn/JwkoRPw==
X-Received: by 2002:a50:9346:: with SMTP id n6mr26045739eda.365.1623167972116;
        Tue, 08 Jun 2021 08:59:32 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-112-183-231.95.112.pool.telefonica.de. [95.112.183.231])
        by smtp.gmail.com with ESMTPSA id n13sm51134ejk.97.2021.06.08.08.59.31
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 08:59:31 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 23/23] libsepol: declare read-only arrays const
Date:   Tue,  8 Jun 2021 17:59:12 +0200
Message-Id: <20210608155912.32047-24-cgzones@googlemail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210608155912.32047-1-cgzones@googlemail.com>
References: <20210608155912.32047-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Make it more apparent that those data does not change and enforce it.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/avrule_block.c      |  2 +-
 libsepol/src/avtab.c             |  2 +-
 libsepol/src/link.c              |  2 +-
 libsepol/src/polcaps.c           |  2 +-
 libsepol/src/policydb.c          | 22 +++++++++++-----------
 libsepol/src/policydb_internal.h |  2 +-
 libsepol/src/private.h           |  6 +++---
 libsepol/src/write.c             |  8 ++++----
 8 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/libsepol/src/avrule_block.c b/libsepol/src/avrule_block.c
index a9832d0d..dcfce8b8 100644
--- a/libsepol/src/avrule_block.c
+++ b/libsepol/src/avrule_block.c
@@ -30,7 +30,7 @@
 /* It is anticipated that there be less declarations within an avrule
  * block than the global policy.  Thus the symbol table sizes are
  * smaller than those listed in policydb.c */
-static unsigned int symtab_sizes[SYM_NUM] = {
+static const unsigned int symtab_sizes[SYM_NUM] = {
 	2,
 	4,
 	8,
diff --git a/libsepol/src/avtab.c b/libsepol/src/avtab.c
index c2ccb005..7b80377c 100644
--- a/libsepol/src/avtab.c
+++ b/libsepol/src/avtab.c
@@ -424,7 +424,7 @@ void avtab_hash_eval(avtab_t * h, char *tag)
 }
 
 /* Ordering of datums in the original avtab format in the policy file. */
-static uint16_t spec_order[] = {
+static const uint16_t spec_order[] = {
 	AVTAB_ALLOWED,
 	AVTAB_AUDITDENY,
 	AVTAB_AUDITALLOW,
diff --git a/libsepol/src/link.c b/libsepol/src/link.c
index bdc1fcbf..461d2feb 100644
--- a/libsepol/src/link.c
+++ b/libsepol/src/link.c
@@ -78,7 +78,7 @@ typedef struct missing_requirement {
 	uint32_t perm_value;
 } missing_requirement_t;
 
-static const char *symtab_names[SYM_NUM] = {
+static const char * const symtab_names[SYM_NUM] = {
 	"common", "class", "role", "type/attribute", "user",
 	"bool", "level", "category"
 };
diff --git a/libsepol/src/polcaps.c b/libsepol/src/polcaps.c
index 67ed5786..6a74ec7d 100644
--- a/libsepol/src/polcaps.c
+++ b/libsepol/src/polcaps.c
@@ -5,7 +5,7 @@
 #include <string.h>
 #include <sepol/policydb/polcaps.h>
 
-static const char *polcap_names[] = {
+static const char * const polcap_names[] = {
 	"network_peer_controls",	/* POLICYDB_CAPABILITY_NETPEER */
 	"open_perms",			/* POLICYDB_CAPABILITY_OPENPERM */
 	"extended_socket_class",	/* POLICYDB_CAPABILITY_EXTSOCKCLASS */
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 7739b0fb..0bc0ead8 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -57,10 +57,10 @@
 #include "policydb_validate.h"
 
 #define POLICYDB_TARGET_SZ   ARRAY_SIZE(policydb_target_strings)
-const char *policydb_target_strings[] = { POLICYDB_STRING, POLICYDB_XEN_STRING };
+const char * const policydb_target_strings[] = { POLICYDB_STRING, POLICYDB_XEN_STRING };
 
 /* These need to be updated if SYM_NUM or OCON_NUM changes */
-static struct policydb_compat_info policydb_compat[] = {
+static const struct policydb_compat_info policydb_compat[] = {
 	{
 	 .type = POLICY_KERN,
 	 .version = POLICYDB_VERSION_BOUNDARY,
@@ -460,7 +460,7 @@ static char *symtab_name[SYM_NUM] = {
 };
 #endif
 
-static unsigned int symtab_sizes[SYM_NUM] = {
+static const unsigned int symtab_sizes[SYM_NUM] = {
 	2,
 	32,
 	16,
@@ -471,12 +471,12 @@ static unsigned int symtab_sizes[SYM_NUM] = {
 	16,
 };
 
-struct policydb_compat_info *policydb_lookup_compat(unsigned int version,
-						    unsigned int type,
-						unsigned int target_platform)
+const struct policydb_compat_info *policydb_lookup_compat(unsigned int version,
+						          unsigned int type,
+						          unsigned int target_platform)
 {
 	unsigned int i;
-	struct policydb_compat_info *info = NULL;
+	const struct policydb_compat_info *info = NULL;
 
 	for (i = 0; i < sizeof(policydb_compat) / sizeof(*info); i++) {
 		if (policydb_compat[i].version == version &&
@@ -2854,7 +2854,7 @@ static int filename_trans_read(policydb_t *p, struct policy_file *fp)
 	return 0;
 }
 
-static int ocontext_read_xen(struct policydb_compat_info *info,
+static int ocontext_read_xen(const struct policydb_compat_info *info,
 	policydb_t *p, struct policy_file *fp)
 {
 	unsigned int i, j;
@@ -2963,7 +2963,7 @@ static int ocontext_read_xen(struct policydb_compat_info *info,
 	}
 	return 0;
 }
-static int ocontext_read_selinux(struct policydb_compat_info *info,
+static int ocontext_read_selinux(const struct policydb_compat_info *info,
 			 policydb_t * p, struct policy_file *fp)
 {
 	unsigned int i, j;
@@ -3141,7 +3141,7 @@ static int ocontext_read_selinux(struct policydb_compat_info *info,
 	return 0;
 }
 
-static int ocontext_read(struct policydb_compat_info *info,
+static int ocontext_read(const struct policydb_compat_info *info,
 	policydb_t *p, struct policy_file *fp)
 {
 	int rc = -1;
@@ -4198,7 +4198,7 @@ int policydb_read(policydb_t * p, struct policy_file *fp, unsigned verbose)
 	uint32_t buf[5];
 	size_t len, nprim, nel;
 	char *policydb_str;
-	struct policydb_compat_info *info;
+	const struct policydb_compat_info *info;
 	unsigned int policy_type, bufindex;
 	ebitmap_node_t *tnode;
 	int rc;
diff --git a/libsepol/src/policydb_internal.h b/libsepol/src/policydb_internal.h
index 06ba5c8b..dd8f25d0 100644
--- a/libsepol/src/policydb_internal.h
+++ b/libsepol/src/policydb_internal.h
@@ -3,5 +3,5 @@
 
 #include <sepol/policydb.h>
 
-extern const char *policydb_target_strings[];
+extern const char * const policydb_target_strings[];
 #endif
diff --git a/libsepol/src/private.h b/libsepol/src/private.h
index f5b5277f..72f21262 100644
--- a/libsepol/src/private.h
+++ b/libsepol/src/private.h
@@ -56,9 +56,9 @@ struct policydb_compat_info {
 	unsigned int target_platform;
 };
 
-extern struct policydb_compat_info *policydb_lookup_compat(unsigned int version,
-							   unsigned int type,
-						unsigned int target_platform);
+extern const struct policydb_compat_info *policydb_lookup_compat(unsigned int version,
+								 unsigned int type,
+								 unsigned int target_platform);
 
 /* Reading from a policy "file". */
 extern int next_entry(void *buf, struct policy_file *fp, size_t bytes);
diff --git a/libsepol/src/write.c b/libsepol/src/write.c
index 84bcaf3f..3bd034d6 100644
--- a/libsepol/src/write.c
+++ b/libsepol/src/write.c
@@ -1345,7 +1345,7 @@ static int (*write_f[SYM_NUM]) (hashtab_key_t key, hashtab_datum_t datum,
 common_write, class_write, role_write, type_write, user_write,
 	    cond_write_bool, sens_write, cat_write,};
 
-static int ocontext_write_xen(struct policydb_compat_info *info, policydb_t *p,
+static int ocontext_write_xen(const struct policydb_compat_info *info, policydb_t *p,
 			  struct policy_file *fp)
 {
 	unsigned int i, j;
@@ -1453,7 +1453,7 @@ static int ocontext_write_xen(struct policydb_compat_info *info, policydb_t *p,
 	return POLICYDB_SUCCESS;
 }
 
-static int ocontext_write_selinux(struct policydb_compat_info *info,
+static int ocontext_write_selinux(const struct policydb_compat_info *info,
 	policydb_t *p, struct policy_file *fp)
 {
 	unsigned int i, j;
@@ -1583,7 +1583,7 @@ static int ocontext_write_selinux(struct policydb_compat_info *info,
 	return POLICYDB_SUCCESS;
 }
 
-static int ocontext_write(struct policydb_compat_info *info, policydb_t * p,
+static int ocontext_write(const struct policydb_compat_info *info, policydb_t * p,
 	struct policy_file *fp)
 {
 	int rc = POLICYDB_ERROR;
@@ -2179,7 +2179,7 @@ int policydb_write(policydb_t * p, struct policy_file *fp)
 	unsigned int i, num_syms;
 	uint32_t buf[32], config;
 	size_t items, items2, len;
-	struct policydb_compat_info *info;
+	const struct policydb_compat_info *info;
 	struct policy_data pd;
 	const char *policydb_str;
 
-- 
2.32.0

