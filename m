Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1228BC433EF
	for <selinux@archiver.kernel.org>; Thu,  3 Feb 2022 16:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352442AbiBCQxm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 3 Feb 2022 11:53:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50658 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229983AbiBCQxm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 3 Feb 2022 11:53:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643907221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kLj5rIYoxuXza2VTX/p5g3c8ZU52lxSdFwfIoLT8qV4=;
        b=iZCVjn1xQRveGI3RUShUDN8kM4VsQPTB899J31si1s9AHK6Y6MJXqQE/9Wcn0H3YSLbpF/
        PpDyumn5TbnYCRGikJZwLnE7Lk5m9Iq1TgnqGDDbkNimW+Bnu72CfbN4jKaBc+wT1I/6ju
        GORVspdWlD2bjuFn70NHR0EvliN8eyI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-620-n2VDwWbHPeeF9K8G_U922g-1; Thu, 03 Feb 2022 11:53:40 -0500
X-MC-Unique: n2VDwWbHPeeF9K8G_U922g-1
Received: by mail-ej1-f72.google.com with SMTP id k16-20020a17090632d000b006ae1cdb0f07so1425675ejk.16
        for <selinux@vger.kernel.org>; Thu, 03 Feb 2022 08:53:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kLj5rIYoxuXza2VTX/p5g3c8ZU52lxSdFwfIoLT8qV4=;
        b=U7IZxUeRDYHI0+dved55qal2PV1u0YAMqtOb9tvF3/EJ+6vVXEQEKakXTaRL9486qS
         o23xqM+ZfrsiER6N9uOwHRlshIH2Q1JNxihSjvjPqXLWUral6u6uOuELdGmAUHVF49ip
         QVDnbRu8I3bG0IbAF9cw5sCCPTfkywGIFzf2yTWz/new4cEp6P+Id94bjyuvLcTxzbQi
         f2c8HNK+yVEMosVDuyTUwAZPAh60Tfb0oFkfExi8rlqsxPB7VWCtxCbMDf8RURERHA3S
         JLF93j+FtV35ybda8/rIZRhPVJ0oJSlmEDYxd6sV7RK9p/9AuZnKFjhXJJDjFgECPqQP
         6WrA==
X-Gm-Message-State: AOAM5302mBdF7ZfeqRv9SJbeJCYH7T6zEWlnwdrR8c9VFMtpsSPiyhVl
        5Jd+99zyOoyUSHyQaBXHfM0ALx9WXrZSMYn+qT5DxePwTSAD/1iz9MAwqjlrtdpbFQMYLVuNvN/
        5/V7j0UXrabRmreBjvk3GMpLc7XcNpvbQ1MZRpjo90v7idrljBj3ANn0w7ZBnqO+c7X9zng==
X-Received: by 2002:a50:bf4f:: with SMTP id g15mr36575450edk.362.1643907218884;
        Thu, 03 Feb 2022 08:53:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwsotniQu273Xa1wl/co0GSzKCqEDDKTGihdEWvSjOtpCUwh/EhjvmDlO7vNnUEsg7Yg5vRNQ==
X-Received: by 2002:a50:bf4f:: with SMTP id g15mr36575425edk.362.1643907218556;
        Thu, 03 Feb 2022 08:53:38 -0800 (PST)
Received: from localhost.localdomain ([2a02:8308:b106:e300:32b0:6ebb:8ca4:d4d3])
        by smtp.gmail.com with ESMTPSA id bs4sm18141027edb.84.2022.02.03.08.53.37
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 08:53:37 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace v2 2/6] semodule,libsemanage: move module hashing into libsemanage
Date:   Thu,  3 Feb 2022 17:53:23 +0100
Message-Id: <20220203165327.213601-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220203165327.213601-1-omosnace@redhat.com>
References: <20220203165327.213601-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The main goal of this move is to have the SHA-256 implementation under
libsemanage, since upcoming patches will make use of SHA-256 for a
different (but similar) purpose in libsemanage. Having the hashing code
in libsemanage will reduce code duplication and allow for easier hash
algorithm upgrade in the future.

Note that libselinux currently also contains a hash function
implementation (for yet another different purpose). This patch doesn't
make any effort to address that duplicity yet.

This patch also changes the format of the hash string printed by
semodule to include the name of the hash. The intent is to avoid
ambiguity and potential collisions when the algorithm is potentially
changed in the future.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 libsemanage/include/semanage/modules.h        | 26 ++++++++
 libsemanage/src/libsemanage.map               |  4 ++
 libsemanage/src/modules.c                     | 59 +++++++++++++++++++
 .../src/semanageswig_python_exception.i       |  8 +++
 .../semodule => libsemanage/src}/sha256.c     |  0
 .../semodule => libsemanage/src}/sha256.h     |  0
 policycoreutils/semodule/Makefile             |  2 +-
 policycoreutils/semodule/semodule.c           | 53 +++++------------
 8 files changed, 114 insertions(+), 38 deletions(-)
 rename {policycoreutils/semodule => libsemanage/src}/sha256.c (100%)
 rename {policycoreutils/semodule => libsemanage/src}/sha256.h (100%)

diff --git a/libsemanage/include/semanage/modules.h b/libsemanage/include/semanage/modules.h
index b51f61f0..14666f6d 100644
--- a/libsemanage/include/semanage/modules.h
+++ b/libsemanage/include/semanage/modules.h
@@ -282,4 +282,30 @@ extern int semanage_module_get_enabled(semanage_handle_t *sh,
 				       const semanage_module_key_t *modkey,
 				       int *enabled);
 
+/* Compute checksum for @modkey module contents.
+ *
+ * If @checksum is NULL, the function will just return the length of the
+ * checksum string in @checksum_len (checksum strings are guaranteed to
+ * have a fixed length for a given libsemanage binary). @modkey and @cil
+ * are ignored in this case and should be set to NULL and 0 (respectively).
+ *
+ * If @checksum is non-NULL, on success, @checksum will point to a buffer
+ * containing the checksum string and @checksum_len will point to the
+ * length of the string (without the null terminator). The semantics of
+ * @cil are the same as for @extract_cil in semanage_module_extract().
+ *
+ * The caller is responsible to free the buffer returned in @checksum (using
+ * free(3)).
+ *
+ * Callers may assume that if the checksum strings for two modules match,
+ * the module content is the same (collisions are theoretically possible,
+ * yet extremely unlikely).
+ *
+ * Returns 0 on success and -1 on error.
+ */
+extern int semanage_module_compute_checksum(semanage_handle_t *sh,
+					    semanage_module_key_t *modkey,
+					    int cil, char **checksum,
+					    size_t *checksum_len);
+
 #endif
diff --git a/libsemanage/src/libsemanage.map b/libsemanage/src/libsemanage.map
index 3ea7b60f..00259fc8 100644
--- a/libsemanage/src/libsemanage.map
+++ b/libsemanage/src/libsemanage.map
@@ -345,3 +345,7 @@ LIBSEMANAGE_1.1 {
     semanage_module_remove_key;
     semanage_set_store_root;
 } LIBSEMANAGE_1.0;
+
+LIBSEMANAGE_3.4 {
+    semanage_module_compute_checksum;
+} LIBSEMANAGE_1.1;
diff --git a/libsemanage/src/modules.c b/libsemanage/src/modules.c
index c98df4dd..fe937519 100644
--- a/libsemanage/src/modules.c
+++ b/libsemanage/src/modules.c
@@ -35,11 +35,13 @@
 #include <fcntl.h>
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <sys/mman.h>
 #include <errno.h>
 #include <ctype.h>
 
 #include "handle.h"
 #include "modules.h"
+#include "sha256.h"
 #include "debug.h"
 
 int semanage_module_install(semanage_handle_t * sh,
@@ -976,3 +978,60 @@ int semanage_module_remove_key(semanage_handle_t *sh,
 	return sh->funcs->remove_key(sh, modkey);
 }
 
+static const char CHECKSUM_TYPE[] = "sha256";
+static const size_t CHECKSUM_CONTENT_SIZE = sizeof(CHECKSUM_TYPE) + 1 + 2 * SHA256_HASH_SIZE;
+
+static void semanage_hash_to_checksum_string(const uint8_t *hash, char *checksum)
+{
+	size_t i;
+
+	checksum += sprintf(checksum, "%s:", CHECKSUM_TYPE);
+	for (i = 0; i < SHA256_HASH_SIZE; i++) {
+		checksum += sprintf(checksum, "%02x", (unsigned)hash[i]);
+	}
+}
+
+int semanage_module_compute_checksum(semanage_handle_t *sh,
+				     semanage_module_key_t *modkey,
+				     int cil, char **checksum,
+				     size_t *checksum_len)
+{
+	semanage_module_info_t *extract_info = NULL;
+	Sha256Context context;
+	SHA256_HASH sha256_hash;
+	char *checksum_str;
+	void *data;
+	size_t data_len = 0;
+	int result;
+
+	if (!checksum_len)
+		return -1;
+
+	if (!checksum) {
+		*checksum_len = CHECKSUM_CONTENT_SIZE;
+		return 0;
+	}
+
+	result = semanage_module_extract(sh, modkey, cil, &data, &data_len, &extract_info);
+	if (result != 0)
+		return -1;
+
+	semanage_module_info_destroy(sh, extract_info);
+	free(extract_info);
+
+	Sha256Initialise(&context);
+	Sha256Update(&context, data, data_len);
+	Sha256Finalise(&context, &sha256_hash);
+
+	munmap(data, data_len);
+
+	checksum_str = malloc(CHECKSUM_CONTENT_SIZE + 1 /* '\0' */);
+	if (!checksum_str)
+		return -1;
+
+	semanage_hash_to_checksum_string(sha256_hash.bytes, checksum_str);
+
+	*checksum = checksum_str;
+	*checksum_len = CHECKSUM_CONTENT_SIZE;
+	return 0;
+}
diff --git a/libsemanage/src/semanageswig_python_exception.i b/libsemanage/src/semanageswig_python_exception.i
index 372ec948..0df8bbc3 100644
--- a/libsemanage/src/semanageswig_python_exception.i
+++ b/libsemanage/src/semanageswig_python_exception.i
@@ -351,6 +351,14 @@
   }
 }
 
+%exception semanage_module_compute_checksum {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
 %exception semanage_msg_get_level {
   $action
   if (result < 0) {
diff --git a/policycoreutils/semodule/sha256.c b/libsemanage/src/sha256.c
similarity index 100%
rename from policycoreutils/semodule/sha256.c
rename to libsemanage/src/sha256.c
diff --git a/policycoreutils/semodule/sha256.h b/libsemanage/src/sha256.h
similarity index 100%
rename from policycoreutils/semodule/sha256.h
rename to libsemanage/src/sha256.h
diff --git a/policycoreutils/semodule/Makefile b/policycoreutils/semodule/Makefile
index 9875ac38..73801e48 100644
--- a/policycoreutils/semodule/Makefile
+++ b/policycoreutils/semodule/Makefile
@@ -6,7 +6,7 @@ MANDIR = $(PREFIX)/share/man
 
 CFLAGS ?= -Werror -Wall -W
 override LDLIBS += -lsepol -lselinux -lsemanage
-SEMODULE_OBJS = semodule.o sha256.o
+SEMODULE_OBJS = semodule.o
 
 all: semodule genhomedircon
 
diff --git a/policycoreutils/semodule/semodule.c b/policycoreutils/semodule/semodule.c
index 94a9d131..f4a76289 100644
--- a/policycoreutils/semodule/semodule.c
+++ b/policycoreutils/semodule/semodule.c
@@ -25,8 +25,6 @@
 #include <sepol/cil/cil.h>
 #include <semanage/modules.h>
 
-#include "sha256.h"
-
 enum client_modes {
 	NO_MODE, INSTALL_M, REMOVE_M, EXTRACT_M, CIL_M, HLL_M,
 	LIST_M, RELOAD, PRIORITY_M, ENABLE_M, DISABLE_M
@@ -348,60 +346,38 @@ static void parse_command_line(int argc, char **argv)
 
 /* Get module checksum */
 static char *hash_module_data(const char *module_name, const int prio) {
-	semanage_module_info_t *extract_info = NULL;
 	semanage_module_key_t *modkey = NULL;
-	Sha256Context context;
-	uint8_t sha256_hash[SHA256_HASH_SIZE];
-	char *sha256_buf = NULL;
-	void *data;
-	size_t data_len = 0, i;
+	char *hash_str = NULL;
+	void *hash = NULL;
+	size_t hash_len = 0;
 	int result;
 
 	result = semanage_module_key_create(sh, &modkey);
 	if (result != 0) {
-		goto cleanup_extract;
+		goto cleanup;
 	}
 
 	result = semanage_module_key_set_name(sh, modkey, module_name);
 	if (result != 0) {
-		goto cleanup_extract;
+		goto cleanup;
 	}
 
 	result = semanage_module_key_set_priority(sh, modkey, prio);
 	if (result != 0) {
-		goto cleanup_extract;
+		goto cleanup;
 	}
 
-	result = semanage_module_extract(sh, modkey, 1, &data, &data_len,
-									 &extract_info);
+	result = semanage_module_compute_checksum(sh, modkey, 1, &hash_str,
+						  &hash_len);
 	if (result != 0) {
-		goto cleanup_extract;
-	}
-
-	Sha256Initialise(&context);
-	Sha256Update(&context, data, data_len);
-
-	Sha256Finalise(&context, (SHA256_HASH *)sha256_hash);
-
-	sha256_buf = calloc(1, SHA256_HASH_SIZE * 2 + 1);
-
-	if (sha256_buf == NULL)
-		goto cleanup_extract;
-
-	for (i = 0; i < SHA256_HASH_SIZE; i++) {
-		sprintf((&sha256_buf[i * 2]), "%02x", sha256_hash[i]);
+		goto cleanup;
 	}
-	sha256_buf[i * 2] = 0;
 
-cleanup_extract:
-	if (data_len > 0) {
-		munmap(data, data_len);
-	}
-	semanage_module_info_destroy(sh, extract_info);
-	free(extract_info);
+cleanup:
+	free(hash);
 	semanage_module_key_destroy(sh, modkey);
 	free(modkey);
-	return sha256_buf;
+	return hash_str;
 }
 
 int main(int argc, char *argv[])
@@ -669,7 +645,10 @@ cleanup_extract:
 					/* fixed width columns */
 					column[0] = sizeof("000") - 1;
 					column[3] = sizeof("disabled") - 1;
-					column[4] = 64; /* SHA256_HASH_SIZE * 2 */
+
+					result = semanage_module_compute_checksum(sh, NULL, 0, NULL,
+										  &column[4]);
+					if (result != 0) goto cleanup_list;
 
 					/* variable width columns */
 					const char *tmp = NULL;
-- 
2.34.1

