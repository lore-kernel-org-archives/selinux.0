Return-Path: <SRS0=2hro=DQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F067DC43467
	for <selinux@archiver.kernel.org>; Fri,  9 Oct 2020 13:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8699022248
	for <selinux@archiver.kernel.org>; Fri,  9 Oct 2020 13:01:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iUheYBXR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387996AbgJINBJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 9 Oct 2020 09:01:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44671 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387992AbgJINBI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 9 Oct 2020 09:01:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602248466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pjt/uEuGRF/x2LkKgZH+EHE8tJpmcCOU7oej3x2YB8Q=;
        b=iUheYBXRXXEZmcObTQcPSTmR1eHdipDGAkpiJAJwKNLatD4lyGd82+FZX+FmCgNTnGdnBX
        70OFYdFuA8QiwnFKslkX9Wdm4rJ/gyDjVgjFj3iqLPgiT73QxPSfWYW7h1OvtdWoEYeaMF
        SH6kRLAFIHryrQvP3jlmbsO0ExZQMts=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-6yQPBvStM-2HN4LnaUraog-1; Fri, 09 Oct 2020 09:01:04 -0400
X-MC-Unique: 6yQPBvStM-2HN4LnaUraog-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4767F10866A0
        for <selinux@vger.kernel.org>; Fri,  9 Oct 2020 13:01:03 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.193.213])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 50AC07665D;
        Fri,  9 Oct 2020 13:01:02 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH v2 4/6] libsemanage: Remove legacy and duplicate symbols
Date:   Fri,  9 Oct 2020 15:00:50 +0200
Message-Id: <20201009130052.52409-5-plautrba@redhat.com>
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

Related: https://github.com/SELinuxProject/selinux/issues/245

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 libsemanage/include/semanage/modules.h |   2 +-
 libsemanage/src/libsemanage.map        |   5 --
 libsemanage/src/modules.c              | 100 +------------------------
 libsemanage/src/modules.h              |   9 +--
 libsemanage/src/semanageswig_python.i  |   2 -
 5 files changed, 4 insertions(+), 114 deletions(-)

diff --git a/libsemanage/include/semanage/modules.h b/libsemanage/include/semanage/modules.h
index ac4039314857..b51f61f033d5 100644
--- a/libsemanage/include/semanage/modules.h
+++ b/libsemanage/include/semanage/modules.h
@@ -33,7 +33,7 @@ typedef struct semanage_module_key semanage_module_key_t;
  */
 
 extern int semanage_module_install(semanage_handle_t *,
-				   char *module_data, size_t data_len, char *name, char *ext_lang);
+				   char *module_data, size_t data_len, const char *name, const char *ext_lang);
 extern int semanage_module_install_file(semanage_handle_t *,
 					const char *module_name);
 extern int semanage_module_remove(semanage_handle_t *, char *module_name);
diff --git a/libsemanage/src/libsemanage.map b/libsemanage/src/libsemanage.map
index 1375a8ca0ea7..4bec06aaae27 100644
--- a/libsemanage/src/libsemanage.map
+++ b/libsemanage/src/libsemanage.map
@@ -167,18 +167,13 @@ LIBSEMANAGE_1.0 {
     semanage_mls_enabled;
     semanage_module_disable;
     semanage_module_enable;
-    semanage_module_get_enabled;
     semanage_module_get_name;
     semanage_module_get_version;
     semanage_module_info_datum_destroy;
-    semanage_module_install;
-    semanage_module_install_base;
-    semanage_module_install_base_file;
     semanage_module_install_file;
     semanage_module_list;
     semanage_module_list_nth;
     semanage_module_remove;
-    semanage_module_upgrade;
     semanage_module_upgrade_file;
     semanage_msg_get_channel;
     semanage_msg_get_fname;
diff --git a/libsemanage/src/modules.c b/libsemanage/src/modules.c
index 6d3eb60ae462..8b36801038df 100644
--- a/libsemanage/src/modules.c
+++ b/libsemanage/src/modules.c
@@ -42,70 +42,7 @@
 #include "modules.h"
 #include "debug.h"
 
-asm(".symver semanage_module_get_enabled_1_1,semanage_module_get_enabled@@LIBSEMANAGE_1.1");
-asm(".symver semanage_module_get_enabled_1_0,semanage_module_get_enabled@LIBSEMANAGE_1.0");
-asm(".symver semanage_module_install_pp,semanage_module_install@LIBSEMANAGE_1.0");
-asm(".symver semanage_module_install_hll,semanage_module_install@@LIBSEMANAGE_1.1");
-
-/* Takes a module stored in 'module_data' and parses its headers.
- * Sets reference variables 'module_name' to module's name and
- * 'version' to module's version. The caller is responsible for
- * free()ing 'module_name' and 'version'; they will be
- * set to NULL upon entering this function.  Returns 0 on success, -1
- * if out of memory, or -2 if data did not represent a module.
- */
-static int parse_module_headers(semanage_handle_t * sh, char *module_data,
-				size_t data_len, char **module_name, char **version)
-{
-	struct sepol_policy_file *pf;
-	int file_type;
-	*version = NULL;
-
-	if (sepol_policy_file_create(&pf)) {
-		ERR(sh, "Out of memory!");
-		return -1;
-	}
-	sepol_policy_file_set_mem(pf, module_data, data_len);
-	sepol_policy_file_set_handle(pf, sh->sepolh);
-	if (module_data == NULL ||
-	    data_len == 0 ||
-	    sepol_module_package_info(pf, &file_type, module_name, version) == -1) {
-		sepol_policy_file_free(pf);
-		ERR(sh, "Could not parse module data.");
-		return -2;
-	}
-	sepol_policy_file_free(pf);
-	if (file_type != SEPOL_POLICY_MOD) {
-		ERR(sh, "Data did not represent a pp module. Please upgrade to the latest version of libsemanage to support hll modules.");
-		return -2;
-	}
-
-	return 0;
-}
-
-/* This function is used to preserve ABI compatibility with
- * versions of semodule using LIBSEMANAGE_1.0
- */
-int semanage_module_install_pp(semanage_handle_t * sh,
-			    char *module_data, size_t data_len)
-{
-	char *name = NULL;
-	char *version = NULL;
-	int status;
-
-	if ((status = parse_module_headers(sh, module_data, data_len, &name, &version)) != 0) {
-		goto cleanup;
-	}
-
-	status = semanage_module_install_hll(sh, module_data, data_len, name, "pp");
-
-cleanup:
-	free(name);
-	free(version);
-	return status;
-}
-
-int semanage_module_install_hll(semanage_handle_t * sh,
+int semanage_module_install(semanage_handle_t * sh,
 			    char *module_data, size_t data_len, const char *name, const char *ext_lang)
 {
 	if (sh->funcs->install == NULL) {
@@ -160,16 +97,6 @@ int semanage_module_extract(semanage_handle_t * sh,
 	return sh->funcs->extract(sh, modkey, extract_cil, mapped_data, data_len, modinfo);
 }
 
-/* Legacy function that remains to preserve ABI
- * compatibility. Please use semanage_module_install instead.
- */
-int semanage_module_upgrade(semanage_handle_t * sh,
-			    char *module_data, size_t data_len)
-{
-	return semanage_module_install_pp(sh, module_data, data_len);
-	
-}
-
 /* Legacy function that remains to preserve ABI
  * compatibility. Please use semanage_module_install_file instead.
  */
@@ -179,24 +106,6 @@ int semanage_module_upgrade_file(semanage_handle_t * sh,
 	return semanage_module_install_file(sh, module_name);
 }
 
-/* Legacy function that remains to preserve ABI
- * compatibility. Please use semanage_module_install instead.
- */
-int semanage_module_install_base(semanage_handle_t * sh,
-				 char *module_data, size_t data_len)
-{
-	return semanage_module_install_pp(sh, module_data, data_len);
-}
-
-/* Legacy function that remains to preserve ABI
- * compatibility. Please use semanage_module_install_file instead.
- */
-int semanage_module_install_base_file(semanage_handle_t * sh,
-				 const char *module_name)
-{
-	return semanage_module_install_file(sh, module_name);
-}
-
 int semanage_module_remove(semanage_handle_t * sh, char *module_name)
 {
 	if (sh->funcs->remove == NULL) {
@@ -780,7 +689,7 @@ int semanage_module_key_set_priority(semanage_handle_t *sh,
 }
 
 
-int semanage_module_get_enabled_1_1(semanage_handle_t *sh,
+int semanage_module_get_enabled(semanage_handle_t *sh,
 				const semanage_module_key_t *modkey,
 				int *enabled)
 {
@@ -800,11 +709,6 @@ int semanage_module_get_enabled_1_1(semanage_handle_t *sh,
 	return sh->funcs->get_enabled(sh, modkey, enabled);
 }
 
-int semanage_module_get_enabled_1_0(semanage_module_info_t *modinfo)
-{
-	return modinfo->enabled;
-}
-
 int semanage_module_set_enabled(semanage_handle_t *sh,
 				const semanage_module_key_t *modkey,
 				int enabled)
diff --git a/libsemanage/src/modules.h b/libsemanage/src/modules.h
index 2d3576fb15df..64d4a157f5ca 100644
--- a/libsemanage/src/modules.h
+++ b/libsemanage/src/modules.h
@@ -26,16 +26,9 @@
 
 #include "semanage/modules.h"
 
-int semanage_module_install_pp(semanage_handle_t * sh,
-			    char *module_data, size_t data_len);
-int semanage_module_install_hll(semanage_handle_t * sh,
-			    char *module_data, size_t data_len, const char *name, const char *ext_lang);
-int semanage_module_upgrade(semanage_handle_t * sh,
-			    char *module_data, size_t data_len);
+
 int semanage_module_upgrade_file(semanage_handle_t * sh,
 				 const char *module_name);
-int semanage_module_install_base(semanage_handle_t * sh,
-				 char *module_data, size_t data_len);
 int semanage_module_install_base_file(semanage_handle_t * sh,
 				 const char *module_name);
 
diff --git a/libsemanage/src/semanageswig_python.i b/libsemanage/src/semanageswig_python.i
index 8dd79fc24213..5f0113966962 100644
--- a/libsemanage/src/semanageswig_python.i
+++ b/libsemanage/src/semanageswig_python.i
@@ -30,8 +30,6 @@
 %}
 
 %include "stdint.i"
-%ignore semanage_module_install_pp;
-%ignore semanage_module_install_hll;
 
 %wrapper %{
 
-- 
2.28.0

