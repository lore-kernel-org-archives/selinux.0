Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68050C433FE
	for <selinux@archiver.kernel.org>; Thu, 13 Jan 2022 14:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235711AbiAMOjt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Jan 2022 09:39:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43666 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235679AbiAMOjt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Jan 2022 09:39:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642084788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oF8BJzu97Q0KIJpswIqHdeVyGCcbIz57g6pJZuajT/c=;
        b=T1l5cEyOs5r6Sf6E0kUOdRLjTEywS7PrFagayFaK+WHxHSZrU1oow+Z69WB10Vt314kwHK
        jdYISQNf7wu8KWj8HTf16UHGuESckygqCT3LJvJapFb7uhH465pWd6983AC1lHITm5Hcx0
        yYDOtzhMcXRsnaKCkHo5gZqWSnJetV8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-618-FvV5NJFTOQe_A35SG5Ch1g-1; Thu, 13 Jan 2022 09:39:47 -0500
X-MC-Unique: FvV5NJFTOQe_A35SG5Ch1g-1
Received: by mail-ed1-f72.google.com with SMTP id i9-20020a05640242c900b003fe97faab62so5492163edc.9
        for <selinux@vger.kernel.org>; Thu, 13 Jan 2022 06:39:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oF8BJzu97Q0KIJpswIqHdeVyGCcbIz57g6pJZuajT/c=;
        b=LssnC7i3Um+NyfVbkI/sNXShajPFvsYYSeqm69XLwLt24zVZMwbRsvgdUHz+/uvhNc
         iHk+0MksAGojtaZSD59IJV3Q9lmdCSb64lbrHXBNpM5MZUA6ioGv2z7MuJgPqZL+zwIp
         nzxXDSyNzQlF7Sw1h5+UUvM0gD2DzW16zZN01UM+Qsi8nFptLTlDUg0m8o2illVJS+Tj
         0BuGrOUBTF460vtmC78N/ES+2VTgLJUBAgs2eNxo6NI8/p+YBfu1Dc6ivioLvxcVXPyM
         K96ULSPCBl5Ccuzj5gzqxEn42W/Ub6R2DRYD94qthjDWRsqMGzc4Sljn2MfUwAOHQQmz
         UBVg==
X-Gm-Message-State: AOAM532JiefmyZenhpT4fFvBeUajiSlYHE9uNgAlGOtjr4of75hbpfdt
        AV1UyfpNsUcemeJaqxeyQ9DsKz5QOLIKQWLz7UJrxSxVC1DjP5UZGKMVsiO3md8p7kDTophq8IK
        jOyJtfZu7y5VOQLdf3Fb9q+tbGQF3Pc2vi9YhkFlJJxl42dz0/M46ieau1l2uPzT3rxem1Q==
X-Received: by 2002:a05:6402:2696:: with SMTP id w22mr4602980edd.296.1642084786099;
        Thu, 13 Jan 2022 06:39:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyrj5nbh/f3heJy52w3CQxanAjUd6fFbDfdmapn+2Zu22Pr7xKE+dSrXyi6nvfUUxBTsfHiAg==
X-Received: by 2002:a05:6402:2696:: with SMTP id w22mr4602951edd.296.1642084785706;
        Thu, 13 Jan 2022 06:39:45 -0800 (PST)
Received: from localhost.localdomain ([2a02:8308:b106:e300:d5c1:b1da:9874:b302])
        by smtp.gmail.com with ESMTPSA id sc7sm964242ejc.87.2022.01.13.06.39.44
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 06:39:45 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH userspace 2/5] semodule,libsemanage: move module hashing into libsemanage
Date:   Thu, 13 Jan 2022 15:39:32 +0100
Message-Id: <20220113143935.195125-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220113143935.195125-1-omosnace@redhat.com>
References: <20220113143935.195125-1-omosnace@redhat.com>
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

The changes here are only refactoring, no functional change is done
here. A new libsemanage API function semanage_module_compute_checksum()
is provided and semodule is made to use it for implementing its
hash_module_data() function.

Note that the API function also returns a string representation of the
hash algorithm used, which is currently unused by semodule. The intent
is to avoid ambiguity and potential collisions when the algorithm is
potentially changed in the future. I could add the hash algorithm to the
semodule output, but doing so might break tools parsing the exisiting
format. (RFC: Should I change it anyway?)

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 libsemanage/include/semanage/modules.h        | 25 +++++++++
 libsemanage/src/libsemanage.map               |  4 ++
 libsemanage/src/modules.c                     | 36 +++++++++++++
 .../src/semanageswig_python_exception.i       |  8 +++
 .../semodule => libsemanage/src}/sha256.c     |  0
 .../semodule => libsemanage/src}/sha256.h     |  0
 policycoreutils/semodule/Makefile             |  2 +-
 policycoreutils/semodule/semodule.c           | 51 +++++++------------
 8 files changed, 92 insertions(+), 34 deletions(-)
 rename {policycoreutils/semodule => libsemanage/src}/sha256.c (100%)
 rename {policycoreutils/semodule => libsemanage/src}/sha256.h (100%)

diff --git a/libsemanage/include/semanage/modules.h b/libsemanage/include/semanage/modules.h
index b51f61f0..1332654d 100644
--- a/libsemanage/include/semanage/modules.h
+++ b/libsemanage/include/semanage/modules.h
@@ -282,4 +282,29 @@ extern int semanage_module_get_enabled(semanage_handle_t *sh,
 				       const semanage_module_key_t *modkey,
 				       int *enabled);
 
+/* Compute checksum for @modkey module contents. On success, @checksum_type
+ * will point to a string containing the checksum type (i.e. the checksum
+ * algorithm), @checksum will point to a buffer containig the checksum as
+ * binary data, and @checksum_len will point to the size of the checksum.
+ * The semantics of @cil are the same as for extract_cil in
+ * semanage_module_extract().
+ *
+ * The caller is responsible to free the buffer returned in @checksum (using
+ * free(3)). The string returned via @checksum_type must NOT be freed by the
+ * caller.
+ *
+ * Two checksums are considered equal when both @checksum_type and the
+ * checksum itself are equal. Most versions of libsemanage should return
+ * the same @checksum_type, although it may change occasionally when
+ * libsemanage switches to a different algorithm.
+ *
+ * Returns 0 on success and -1 on error.
+ */
+extern int semanage_module_compute_checksum(semanage_handle_t *sh,
+					    semanage_module_key_t *modkey,
+					    int cil,
+					    const char **checksum_type,
+					    void **checksum,
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
index c98df4dd..72c5ed2c 100644
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
@@ -976,3 +978,37 @@ int semanage_module_remove_key(semanage_handle_t *sh,
 	return sh->funcs->remove_key(sh, modkey);
 }
 
+int semanage_module_compute_checksum(semanage_handle_t *sh,
+				     semanage_module_key_t *modkey,
+				     int cil, const char **checksum_type,
+				     void **checksum, size_t *checksum_len)
+{
+	semanage_module_info_t *extract_info = NULL;
+	Sha256Context context;
+	SHA256_HASH sha256_hash;
+	void *data;
+	size_t data_len = 0;
+	int result;
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
+	*checksum = malloc(SHA256_HASH_SIZE);
+	if (!*checksum)
+		return -1;
+
+	memcpy(*checksum, sha256_hash.bytes, SHA256_HASH_SIZE);
+	*checksum_len = SHA256_HASH_SIZE;
+	*checksum_type = "sha256";
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
index 94a9d131..a5b71fc4 100644
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
@@ -348,60 +346,47 @@ static void parse_command_line(int argc, char **argv)
 
 /* Get module checksum */
 static char *hash_module_data(const char *module_name, const int prio) {
-	semanage_module_info_t *extract_info = NULL;
 	semanage_module_key_t *modkey = NULL;
-	Sha256Context context;
-	uint8_t sha256_hash[SHA256_HASH_SIZE];
-	char *sha256_buf = NULL;
-	void *data;
-	size_t data_len = 0, i;
+	const char *checksum_type;
+	char *hash_str = NULL;
+	void *hash = NULL;
+	size_t hash_len = 0, i;
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
+	result = semanage_module_compute_checksum(sh, modkey, 1, &checksum_type,
+						  &hash, &hash_len);
 	if (result != 0) {
-		goto cleanup_extract;
+		goto cleanup;
 	}
 
-	Sha256Initialise(&context);
-	Sha256Update(&context, data, data_len);
-
-	Sha256Finalise(&context, (SHA256_HASH *)sha256_hash);
-
-	sha256_buf = calloc(1, SHA256_HASH_SIZE * 2 + 1);
-
-	if (sha256_buf == NULL)
-		goto cleanup_extract;
+	hash_str = calloc(1, hash_len * 2 + 1);
+	if (!hash_str)
+		goto cleanup;
 
-	for (i = 0; i < SHA256_HASH_SIZE; i++) {
-		sprintf((&sha256_buf[i * 2]), "%02x", sha256_hash[i]);
+	for (i = 0; i < hash_len; i++) {
+		sprintf(&hash_str[i * 2], "%02x", ((uint8_t *)hash)[i]);
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
-- 
2.34.1

