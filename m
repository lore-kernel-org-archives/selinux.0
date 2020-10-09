Return-Path: <SRS0=2hro=DQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C1CBC433DF
	for <selinux@archiver.kernel.org>; Fri,  9 Oct 2020 13:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27270222D5
	for <selinux@archiver.kernel.org>; Fri,  9 Oct 2020 13:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YM79a5o7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732803AbgJINBH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 9 Oct 2020 09:01:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48624 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729347AbgJINBH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 9 Oct 2020 09:01:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602248465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HBj1Hr6AxJHuJcCtCDETozEDjrjAOpBolsuXLIGDfeI=;
        b=YM79a5o7ZDXoTVKfq/JmdHbzTFFrsb8HZ5u2qk49Yb4aThFd4ogioWrzZsPVxVUU3dZ68q
        t+zh5BXvG1qztYOZgOAR2tAL68uC/PoRcP09s75Xvs6eClbu4EyjqeiuQ8x8KuID0o8Fq8
        fPCZlsMb2GlJxsnsndB3wUO/NqSwCQE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-YNZwCPcFOyqKEnanUZIpgg-1; Fri, 09 Oct 2020 09:01:01 -0400
X-MC-Unique: YNZwCPcFOyqKEnanUZIpgg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7657384BA14
        for <selinux@vger.kernel.org>; Fri,  9 Oct 2020 13:01:00 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.193.213])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7280F7665E;
        Fri,  9 Oct 2020 13:00:59 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH v2 2/6] libsepol: Drop deprecated functions
Date:   Fri,  9 Oct 2020 15:00:48 +0200
Message-Id: <20201009130052.52409-3-plautrba@redhat.com>
In-Reply-To: <20201009130052.52409-1-plautrba@redhat.com>
References: <20201009130052.52409-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

These functions were converted to no-op by commit
c3f9492d7ff0 ("selinux: Remove legacy local boolean and user code") and
left in libsepol/src/deprecated_functions.c to preserve API/ABI. As we
change libsepol ABI dropping duplicate symbols it's time to drop these
functions too.

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 libsepol/include/sepol/booleans.h |  5 ----
 libsepol/include/sepol/users.h    |  6 ----
 libsepol/src/deprecated_funcs.c   | 50 -------------------------------
 libsepol/src/libsepol.map.in      |  4 ---
 4 files changed, 65 deletions(-)
 delete mode 100644 libsepol/src/deprecated_funcs.c

diff --git a/libsepol/include/sepol/booleans.h b/libsepol/include/sepol/booleans.h
index 06d2230c395d..25229057dbd7 100644
--- a/libsepol/include/sepol/booleans.h
+++ b/libsepol/include/sepol/booleans.h
@@ -10,11 +10,6 @@
 extern "C" {
 #endif
 
-/* These two functions are deprecated. See src/deprecated_funcs.c */
-extern int sepol_genbools(void *data, size_t len, const char *boolpath);
-extern int sepol_genbools_array(void *data, size_t len,
-				char **names, int *values, int nel);
-
 /* Set the specified boolean */
 extern int sepol_bool_set(sepol_handle_t * handle,
 			  sepol_policydb_t * policydb,
diff --git a/libsepol/include/sepol/users.h b/libsepol/include/sepol/users.h
index 70158ac41e40..156d1adb2d60 100644
--- a/libsepol/include/sepol/users.h
+++ b/libsepol/include/sepol/users.h
@@ -10,12 +10,6 @@
 extern "C" {
 #endif
 
-/* These two functions are deprecated. See src/deprecated_funcs.c */
-extern int sepol_genusers(void *data, size_t len,
-			  const char *usersdir,
-			  void **newdata, size_t * newlen);
-extern void sepol_set_delusers(int on);
-
 /* Modify the user, or add it, if the key is not found */
 extern int sepol_user_modify(sepol_handle_t * handle,
 			     sepol_policydb_t * policydb,
diff --git a/libsepol/src/deprecated_funcs.c b/libsepol/src/deprecated_funcs.c
deleted file mode 100644
index d0dab7dfcb4a..000000000000
--- a/libsepol/src/deprecated_funcs.c
+++ /dev/null
@@ -1,50 +0,0 @@
-#include <stdio.h>
-#include "debug.h"
-
-/*
- * Need to keep these stubs for the libsepol interfaces exported in
- * libsepol.map.in, as they are part of the shared library ABI.
- */
-
-static const char *msg = "Deprecated interface";
-
-/*
- * These two functions are deprecated and referenced in:
- *	include/libsepol/users.h
- */
-int sepol_genusers(void *data __attribute((unused)),
-		   size_t len __attribute((unused)),
-		   const char *usersdir __attribute((unused)),
-		   void **newdata __attribute((unused)),
-		   size_t *newlen __attribute((unused)))
-{
-	WARN(NULL, "%s", msg);
-	return -1;
-}
-
-void sepol_set_delusers(int on __attribute((unused)))
-{
-	WARN(NULL, "%s", msg);
-}
-
-/*
- * These two functions are deprecated and referenced in:
- *	include/libsepol/booleans.h
- */
-int sepol_genbools(void *data __attribute((unused)),
-		   size_t len __attribute((unused)),
-		   const char *booleans __attribute((unused)))
-{
-	WARN(NULL, "%s", msg);
-	return -1;
-}
-
-int sepol_genbools_array(void *data __attribute((unused)),
-			 size_t len __attribute((unused)),
-			 char **names __attribute((unused)),
-			 int *values __attribute((unused)),
-			 int nel __attribute((unused)))
-{
-	WARN(NULL, "%s", msg);
-	return -1;
-}
diff --git a/libsepol/src/libsepol.map.in b/libsepol/src/libsepol.map.in
index 98da9789b71b..eb5721257638 100644
--- a/libsepol/src/libsepol.map.in
+++ b/libsepol/src/libsepol.map.in
@@ -45,9 +45,6 @@ LIBSEPOL_1.0 {
 	sepol_context_to_string;
 	sepol_debug;
 	sepol_expand_module;
-	sepol_genbools;
-	sepol_genbools_array;
-	sepol_genusers;
 	sepol_get_disable_dontaudit;
 	sepol_get_preserve_tunables;
 	sepol_handle_create;
@@ -213,7 +210,6 @@ LIBSEPOL_1.0 {
 	sepol_port_set_port;
 	sepol_port_set_proto;
 	sepol_port_set_range;
-	sepol_set_delusers;
 	sepol_set_disable_dontaudit;
 	sepol_set_expand_consume_base;
 	sepol_set_policydb_from_file;
-- 
2.28.0

