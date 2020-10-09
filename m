Return-Path: <SRS0=2hro=DQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21312C43457
	for <selinux@archiver.kernel.org>; Fri,  9 Oct 2020 13:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA04322248
	for <selinux@archiver.kernel.org>; Fri,  9 Oct 2020 13:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TkdZ6PtC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732706AbgJINBF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 9 Oct 2020 09:01:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47062 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729347AbgJINBF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 9 Oct 2020 09:01:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602248463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bliAGEGppea0R+afTBlb53Edc2NvCaHr+sHZ7NDGN7Y=;
        b=TkdZ6PtCR/Q6ZgbQC5+U2nj3lqS/SGOQQ7Y0H6m1OZUwU3VY9JSiDzgrUoKUhS8t2JxcDf
        2xnZ+ZeXngygxnLGSwCnrI5YhMraImzsQME6+rwpdGuJ7eRo0Wv1JQq2Kiu7/Odqiy2xDo
        cubya9aaA/I8puzLIu6Ab+JkOlRfmWU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-90-7g9fl2KdM1O1hX3OPYbBpg-1; Fri, 09 Oct 2020 09:00:59 -0400
X-MC-Unique: 7g9fl2KdM1O1hX3OPYbBpg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DCAC9835B8F
        for <selinux@vger.kernel.org>; Fri,  9 Oct 2020 13:00:58 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.193.213])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 98CAB76647;
        Fri,  9 Oct 2020 13:00:57 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH v2 1/6] libsepol: Get rid of the old and duplicated symbols
Date:   Fri,  9 Oct 2020 15:00:47 +0200
Message-Id: <20201009130052.52409-2-plautrba@redhat.com>
In-Reply-To: <20201009130052.52409-1-plautrba@redhat.com>
References: <20201009130052.52409-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Versioned duplicate symbols cause problems for LTO. These symbols were
introduced during the CIL integration several releases ago and were only
consumed by other SELinux userspace components.

Fixes: https://github.com/SELinuxProject/selinux/issues/245

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 libsepol/cil/src/cil.c       | 84 ------------------------------------
 libsepol/src/libsepol.map.in |  5 ---
 2 files changed, 89 deletions(-)

diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
index a3c6a2934c72..95bdb5e5854c 100644
--- a/libsepol/cil/src/cil.c
+++ b/libsepol/cil/src/cil.c
@@ -51,27 +51,6 @@
 #include "cil_policy.h"
 #include "cil_strpool.h"
 
-#if !defined(SHARED) || defined(ANDROID) || defined(__APPLE__)
-    #define DISABLE_SYMVER 1
-#endif
-
-#ifndef DISABLE_SYMVER
-asm(".symver cil_build_policydb_pdb,        cil_build_policydb@LIBSEPOL_1.0");
-asm(".symver cil_build_policydb_create_pdb, cil_build_policydb@@LIBSEPOL_1.1");
-
-asm(".symver cil_compile_pdb,   cil_compile@LIBSEPOL_1.0");
-asm(".symver cil_compile_nopdb, cil_compile@@LIBSEPOL_1.1");
-
-asm(".symver cil_userprefixes_to_string_pdb,   cil_userprefixes_to_string@LIBSEPOL_1.0");
-asm(".symver cil_userprefixes_to_string_nopdb, cil_userprefixes_to_string@@LIBSEPOL_1.1");
-
-asm(".symver cil_selinuxusers_to_string_pdb,   cil_selinuxusers_to_string@LIBSEPOL_1.0");
-asm(".symver cil_selinuxusers_to_string_nopdb, cil_selinuxusers_to_string@@LIBSEPOL_1.1");
-
-asm(".symver cil_filecons_to_string_pdb,   cil_filecons_to_string@LIBSEPOL_1.0");
-asm(".symver cil_filecons_to_string_nopdb, cil_filecons_to_string@@LIBSEPOL_1.1");
-#endif
-
 int cil_sym_sizes[CIL_SYM_ARRAY_NUM][CIL_SYM_NUM] = {
 	{64, 64, 64, 1 << 13, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64},
 	{64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64},
@@ -549,11 +528,7 @@ exit:
 	return rc;
 }
 
-#ifdef DISABLE_SYMVER
 int cil_compile(struct cil_db *db)
-#else
-int cil_compile_nopdb(struct cil_db *db)
-#endif
 {
 	int rc = SEPOL_ERR;
 
@@ -597,33 +572,7 @@ exit:
 	return rc;
 }
 
-#ifndef DISABLE_SYMVER
-int cil_compile_pdb(struct cil_db *db, __attribute__((unused)) sepol_policydb_t *sepol_db)
-{
-	return cil_compile_nopdb(db);
-}
-
-int cil_build_policydb_pdb(cil_db_t *db, sepol_policydb_t *sepol_db)
-{
-	int rc;
-
-	cil_log(CIL_INFO, "Building policy binary\n");
-	rc = cil_binary_create_allocated_pdb(db, sepol_db);
-	if (rc != SEPOL_OK) {
-		cil_log(CIL_ERR, "Failed to generate binary\n");
-		goto exit;
-	}
-
-exit:
-	return rc;
-}
-#endif
-
-#ifdef DISABLE_SYMVER
 int cil_build_policydb(cil_db_t *db, sepol_policydb_t **sepol_db)
-#else
-int cil_build_policydb_create_pdb(cil_db_t *db, sepol_policydb_t **sepol_db)
-#endif
 {
 	int rc;
 
@@ -1371,11 +1320,7 @@ const char * cil_node_to_string(struct cil_tree_node *node)
 	return "<unknown>";
 }
 
-#ifdef DISABLE_SYMVER
 int cil_userprefixes_to_string(struct cil_db *db, char **out, size_t *size)
-#else
-int cil_userprefixes_to_string_nopdb(struct cil_db *db, char **out, size_t *size)
-#endif
 {
 	int rc = SEPOL_ERR;
 	size_t str_len = 0;
@@ -1420,13 +1365,6 @@ exit:
 
 }
 
-#ifndef DISABLE_SYMVER
-int cil_userprefixes_to_string_pdb(struct cil_db *db, __attribute__((unused)) sepol_policydb_t *sepol_db, char **out, size_t *size)
-{
-	return cil_userprefixes_to_string_nopdb(db, out, size);
-}
-#endif
-
 static int cil_cats_to_ebitmap(struct cil_cats *cats, struct ebitmap* cats_ebitmap)
 {
 	int rc = SEPOL_ERR;
@@ -1614,11 +1552,7 @@ static int __cil_level_to_string(struct cil_level *lvl, char *out)
 	return str_tmp - out;
 }
 
-#ifdef DISABLE_SYMVER
 int cil_selinuxusers_to_string(struct cil_db *db, char **out, size_t *size)
-#else
-int cil_selinuxusers_to_string_nopdb(struct cil_db *db, char **out, size_t *size)
-#endif
 {
 	size_t str_len = 0;
 	int buf_pos = 0;
@@ -1675,18 +1609,7 @@ int cil_selinuxusers_to_string_nopdb(struct cil_db *db, char **out, size_t *size
 	return SEPOL_OK;
 }
 
-#ifndef DISABLE_SYMVER
-int cil_selinuxusers_to_string_pdb(struct cil_db *db, __attribute__((unused)) sepol_policydb_t *sepol_db, char **out, size_t *size)
-{
-	return cil_selinuxusers_to_string_nopdb(db, out, size);
-}
-#endif
-
-#ifdef DISABLE_SYMVER
 int cil_filecons_to_string(struct cil_db *db, char **out, size_t *size)
-#else
-int cil_filecons_to_string_nopdb(struct cil_db *db, char **out, size_t *size)
-#endif
 {
 	uint32_t i = 0;
 	int buf_pos = 0;
@@ -1804,13 +1727,6 @@ int cil_filecons_to_string_nopdb(struct cil_db *db, char **out, size_t *size)
 	return SEPOL_OK;
 }
 
-#ifndef DISABLE_SYMVER
-int cil_filecons_to_string_pdb(struct cil_db *db, __attribute__((unused)) sepol_policydb_t *sepol_db, char **out, size_t *size)
-{
-	return cil_filecons_to_string_nopdb(db, out, size);
-}
-#endif
-
 void cil_set_disable_dontaudit(struct cil_db *db, int disable_dontaudit)
 {
 	db->disable_dontaudit = disable_dontaudit;
diff --git a/libsepol/src/libsepol.map.in b/libsepol/src/libsepol.map.in
index f08c2a861693..98da9789b71b 100644
--- a/libsepol/src/libsepol.map.in
+++ b/libsepol/src/libsepol.map.in
@@ -1,19 +1,14 @@
 LIBSEPOL_1.0 {
   global:
 	cil_add_file;
-	cil_build_policydb;
-	cil_compile;
 	cil_db_destroy;
 	cil_db_init;
-	cil_filecons_to_string;
-	cil_selinuxusers_to_string;
 	cil_set_disable_dontaudit;
 	cil_set_disable_neverallow;
 	cil_set_handle_unknown;
 	cil_set_log_handler;
 	cil_set_log_level;
 	cil_set_preserve_tunables;
-	cil_userprefixes_to_string;
 	expand_module_avrules;
 	sepol_bool_clone;
 	sepol_bool_compare;
-- 
2.28.0

