Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C21E3C433F5
	for <selinux@archiver.kernel.org>; Wed, 11 May 2022 18:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345942AbiEKSlo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 11 May 2022 14:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346451AbiEKSln (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 11 May 2022 14:41:43 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360215641C
        for <selinux@vger.kernel.org>; Wed, 11 May 2022 11:41:41 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id ch13so5751991ejb.12
        for <selinux@vger.kernel.org>; Wed, 11 May 2022 11:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8fNBRfPz19sARTJBEpceIDn2rnb16WpfLMq6F6VuZbo=;
        b=d/vggBMQSeMMnoKL6VxP6pQscs1eiTmsyfD4qFQ1GOWTc+WtMmBTlDZWcS5XDE3OBj
         TdqFSC7OcmhurPkywFQTBQAMVqkGJcr0GP+YQB9GsIoW9It0K8zA6REutP+auvgdTw3D
         bGJ6zGJ+F2FWOXsqYtRahNNDdQ2yvVdKTafXWhmaQzsnrGLmUoxz/9Wg+IwGaqcWf64B
         9YW0oexjW0vbx2WcuNyAPGXg0TEdImZoehNuFA6QB3Sa9LVRLqjMxhuplYkdA5Awnk0o
         cgb9k0jX2In9uhyDSnyD1M2AcE5wzYa6qpCXt7lqvkgt3Bkb8uy9E5voU8oLuDrzuZia
         NeAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8fNBRfPz19sARTJBEpceIDn2rnb16WpfLMq6F6VuZbo=;
        b=lm2Yh3U9jDZayrkU1xuT21bJTfTiLNHCM/jzXpZC/lF56iiHfK01epcQ3sg8j7JXX+
         HsnEqz0rJ7DQzxIlYdjRJoJqlHC/v7fqAVwa8qxN/zkpu53MFdW9bQjzJFTco+orbwqM
         dD1JnV7D4m7oybZGIXo6Eg2qlvFLNv7v+0oh24mm/lgBn34wdC0aekDilaP3NpiFP+vE
         Ls617TaGU8S8v9sQAGDM/Ac/XWj35rHRoRhdl6mUG4CwmTHfwUC1QpfdFNcS8QFuQvI4
         MV00vmTrDXcd1hX/H8zENE4SDZXCaNziQvFHucOEtd7L9qemj9Vj8KJwltvlO/GeTSUR
         o9vA==
X-Gm-Message-State: AOAM533NP2gJDR07HGee4grt3OAGD5uhrFYQidWXxr17zIy9Y9fOH0jm
        +bIySl9M3i/1u+Lejslqk+aeFoU+2Tg=
X-Google-Smtp-Source: ABdhPJxXV2waIhB8iQ0vBHEnAZmKVMCnV30GKGTdn+vVapmtTurP1kOdUOcWttPJo0on6fsgIsYzhQ==
X-Received: by 2002:a17:907:215b:b0:6f4:d91c:ef53 with SMTP id rk27-20020a170907215b00b006f4d91cef53mr25074332ejb.175.1652294499683;
        Wed, 11 May 2022 11:41:39 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-112-140-049.95.112.pool.telefonica.de. [95.112.140.49])
        by smtp.gmail.com with ESMTPSA id z11-20020a170906668b00b006f4fc3850a5sm1341727ejo.32.2022.05.11.11.41.38
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 11:41:39 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] libselinux: preserve errno in selinux_log()
Date:   Wed, 11 May 2022 20:41:32 +0200
Message-Id: <20220511184132.217891-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

selinux_log() is used in many error branches, where the caller might
expect errno to bet set, e.g. label_file.c::lookup_all():

    if (match_count) {
		*match_count = 0;
		result = calloc(data->nspec, sizeof(struct spec*));
	} else {
		result = calloc(1, sizeof(struct spec*));
	}
	if (!result) {
		selinux_log(SELINUX_ERROR, "Failed to allocate %zu bytes of data\n",
			    data->nspec * sizeof(struct spec*));
		goto finish;
	}

Preserve errno in the macro wrapper itself, also preventing accidental
errno modifications in client specified SELINUX_CB_LOG callbacks.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/callbacks.h              | 3 +++
 libselinux/src/label_backends_android.c | 2 --
 libselinux/src/label_file.h             | 2 --
 libselinux/src/selinux_restorecon.c     | 6 +-----
 4 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/libselinux/src/callbacks.h b/libselinux/src/callbacks.h
index f4dab157..5a4d0f8a 100644
--- a/libselinux/src/callbacks.h
+++ b/libselinux/src/callbacks.h
@@ -5,6 +5,7 @@
 #ifndef _SELINUX_CALLBACKS_H_
 #define _SELINUX_CALLBACKS_H_
 
+#include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -32,9 +33,11 @@ extern int
 extern pthread_mutex_t log_mutex;
 
 #define selinux_log(type, ...) do { \
+	int saved_errno__ = errno; \
 	__pthread_mutex_lock(&log_mutex); \
 	selinux_log_direct(type, __VA_ARGS__); \
 	__pthread_mutex_unlock(&log_mutex); \
+	errno = saved_errno__; \
 } while(0)
 
 #endif				/* _SELINUX_CALLBACKS_H_ */
diff --git a/libselinux/src/label_backends_android.c b/libselinux/src/label_backends_android.c
index 66d4df2d..c2d78360 100644
--- a/libselinux/src/label_backends_android.c
+++ b/libselinux/src/label_backends_android.c
@@ -93,7 +93,6 @@ static int process_line(struct selabel_handle *rec,
 
 	items = read_spec_entries(line_buf, &errbuf, 2, &prop, &context);
 	if (items < 0) {
-		items = errno;
 		if (errbuf) {
 			selinux_log(SELINUX_ERROR,
 				    "%s:  line %u error due to: %s\n", path,
@@ -103,7 +102,6 @@ static int process_line(struct selabel_handle *rec,
 				    "%s:  line %u error due to: %m\n", path,
 				    lineno);
 		}
-		errno = items;
 		return -1;
 	}
 
diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index b453e13f..190bc175 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -444,7 +444,6 @@ static inline int process_line(struct selabel_handle *rec,
 
 	items = read_spec_entries(line_buf, &errbuf, 3, &regex, &type, &context);
 	if (items < 0) {
-		rc = errno;
 		if (errbuf) {
 			selinux_log(SELINUX_ERROR,
 				    "%s:  line %u error due to: %s\n", path,
@@ -454,7 +453,6 @@ static inline int process_line(struct selabel_handle *rec,
 				    "%s:  line %u error due to: %m\n", path,
 				    lineno);
 		}
-		errno = rc;
 		return -1;
 	}
 
diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index e6192912..ba7b3692 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -1032,7 +1032,7 @@ static int selinux_restorecon_common(const char *pathname_orig,
 	struct stat sb;
 	char *pathname = NULL, *pathdnamer = NULL, *pathdname, *pathbname;
 	char *paths[2] = { NULL, NULL };
-	int fts_flags, error, sverrno;
+	int fts_flags, error;
 	struct dir_hash_node *current = NULL;
 
 	if (state.flags.verbose && state.flags.progress)
@@ -1286,18 +1286,14 @@ cleanup:
 	return error;
 
 oom:
-	sverrno = errno;
 	selinux_log(SELINUX_ERROR, "%s:  Out of memory\n", __func__);
-	errno = sverrno;
 	error = -1;
 	goto cleanup;
 
 realpatherr:
-	sverrno = errno;
 	selinux_log(SELINUX_ERROR,
 		    "SELinux: Could not get canonical path for %s restorecon: %m.\n",
 		    pathname_orig);
-	errno = sverrno;
 	error = -1;
 	goto cleanup;
 
-- 
2.36.1

