Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 424D4C04FE2
	for <selinux@archiver.kernel.org>; Mon, 14 Aug 2023 13:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjHNNVS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Aug 2023 09:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjHNNUw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 14 Aug 2023 09:20:52 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED121997
        for <selinux@vger.kernel.org>; Mon, 14 Aug 2023 06:20:46 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99bfcf4c814so578917066b.0
        for <selinux@vger.kernel.org>; Mon, 14 Aug 2023 06:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1692019245; x=1692624045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zldRw8Qz99PhYJpeHb62+a0eKAIAXQBkbyHdUHPmJps=;
        b=jcFBX/EyVx3WnMtyhERuE+vwPe5u96DpEgen4kDx/L+mrGo4wvuCeY0xCQNUYpTiFe
         IJo2XzWkwmDmsFBvR+4h5eFwCN4X07dnIUmanJ3f9O3TtGSM4Me54zUECJbYLLnHj+WD
         L3unTp270LvoVXXWK9xJpQyd/wMv0qHZdpwVNtRPZAUanTkirFQc8G6JmgXs7VWPpF0q
         f61cO6wQp1XXwzIH4E5kk2Lnw9I77A6hDZMQmeGvX5q4Ki6qgECorxh34PNvUIgbg9jk
         uZnOPJRZ19aw6jpuFZ0gA4L+ya1QeRkBZIHbSYzetPzsozyaLUvFeCHB7Dl7ZKHviTkm
         ycfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692019245; x=1692624045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zldRw8Qz99PhYJpeHb62+a0eKAIAXQBkbyHdUHPmJps=;
        b=AZvpZlb8J6pA/3kX2hZQ3U4gSfFiq4GvIa2Akf6mBqsdstNYbLJh2u9EMBHSOJ6Awa
         7AJqWu/U9UyV7GLdMw35yPD70g66Od0Jp+0mo7T63TGC/yJj0tnhGTtawuGEhu0D69xE
         7wImkp+qMzEoOXEtamiAb4zKUBK4uKD+uqhn5z3fCE7VGBJq8aNMEe0euahtkqYKobQB
         4dqsX9qVIP+yG3yjwOGex8E8oLMnfv4LVVVLlt4ZgIgvPlp8obF3t1IA4c39w5CBP8t2
         LBbfCJxVZOzh0ap9ysF9owsWP0230ZW5A3ZDt9EJs6zY/EnQv/6drLcA1V76C1YAkb08
         S57g==
X-Gm-Message-State: AOJu0Ywh7a4ay6RA9Y1J2FqoP9xtyr5Nz4B1BHDptXHmmn+/Gcx71EcW
        xK6m3J1CZujDbnobWSgRx4MKKmyPmHmwJM0WHOE=
X-Google-Smtp-Source: AGHT+IH8aD/dARVEei/ay7el7lWmnm9sWEWN1tfjKmfRj+LC4K97ziI1f4zuqjjPs9NNfMdS4c4pzQ==
X-Received: by 2002:a17:906:51d8:b0:994:555a:e49f with SMTP id v24-20020a17090651d800b00994555ae49fmr8179748ejk.31.1692019244665;
        Mon, 14 Aug 2023 06:20:44 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-095-112-167-009.95.112.pool.telefonica.de. [95.112.167.9])
        by smtp.gmail.com with ESMTPSA id ck9-20020a170906c44900b00993664a9987sm5683541ejb.103.2023.08.14.06.20.44
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 06:20:44 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 08/27] libselinux: introduce reallocarray(3)
Date:   Mon, 14 Aug 2023 15:20:06 +0200
Message-Id: <20230814132025.45364-9-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230814132025.45364-1-cgzones@googlemail.com>
References: <20230814132025.45364-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Introduce reallocarray(3), a realloc(3) wrapper incorporating a
multiplication overflow check.

Add private implementation in case the function is not provided by the
standard C library.

Use in appropriate locations.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/Makefile             |  6 ++++++
 libselinux/src/get_context_list.c   |  2 +-
 libselinux/src/matchpathcon.c       |  4 ++--
 libselinux/src/selinux_internal.c   | 16 ++++++++++++++++
 libselinux/src/selinux_internal.h   |  4 ++++
 libselinux/src/selinux_restorecon.c |  3 +--
 6 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 20d79312..ac656257 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -108,6 +108,12 @@ ifeq (yes,$(shell printf '${H}include <string.h>\nint main(void){char*d,*s;strlc
 override CFLAGS += -DHAVE_STRLCPY
 endif
 
+# check for reallocarray(3) availability
+H := \#
+ifeq (yes,$(shell printf '${H}include <stdlib.h>\nint main(void){reallocarray(NULL, 0, 0);return 0;}' | $(CC) -x c -o /dev/null - >/dev/null 2>&1 && echo yes))
+override CFLAGS += -DHAVE_REALLOCARRAY
+endif
+
 SWIG_CFLAGS += -Wno-error -Wno-unused-variable -Wno-unused-but-set-variable -Wno-unused-parameter \
 		-Wno-shadow -Wno-uninitialized -Wno-missing-prototypes -Wno-missing-declarations \
 		-Wno-deprecated-declarations
diff --git a/libselinux/src/get_context_list.c b/libselinux/src/get_context_list.c
index 0342823c..9dafa519 100644
--- a/libselinux/src/get_context_list.c
+++ b/libselinux/src/get_context_list.c
@@ -272,7 +272,7 @@ static int get_context_user(FILE * fp,
 			continue;
 		}
 		if (security_check_context(usercon_str2) == 0) {
-			new_reachable = realloc(*reachable, (*nreachable + 2) * sizeof(char *));
+			new_reachable = reallocarray(*reachable, *nreachable + 2, sizeof(char *));
 			if (!new_reachable) {
 				context_free(usercon);
 				rc = -1;
diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathcon.c
index 9a9bafb0..a1c5b0cc 100644
--- a/libselinux/src/matchpathcon.c
+++ b/libselinux/src/matchpathcon.c
@@ -95,8 +95,8 @@ static int add_array_elt(char *con)
 	if (con_array_size) {
 		while (con_array_used >= con_array_size) {
 			con_array_size *= 2;
-			tmp = (char **)realloc(con_array, sizeof(char*) *
-						     con_array_size);
+			tmp = (char **)reallocarray(con_array, con_array_size,
+						    sizeof(char*));
 			if (!tmp) {
 				free_array_elts();
 				return -1;
diff --git a/libselinux/src/selinux_internal.c b/libselinux/src/selinux_internal.c
index c2be7c0a..9f1aff40 100644
--- a/libselinux/src/selinux_internal.c
+++ b/libselinux/src/selinux_internal.c
@@ -1,5 +1,7 @@
 #include "selinux_internal.h"
 
+#include <errno.h>
+#include <stdlib.h>
 #include <string.h>
 
 
@@ -16,3 +18,17 @@ size_t strlcpy(char *dest, const char *src, size_t size)
 	return ret;
 }
 #endif /* HAVE_STRLCPY */
+
+#ifndef HAVE_REALLOCARRAY
+void *reallocarray(void *ptr, size_t nmemb, size_t size)
+{
+	
+	if (size && nmemb > -1 / size) {
+			errno = ENOMEM;
+			return 0;
+	}
+
+	return realloc(ptr, nmemb * size);
+
+}
+#endif /* HAVE_REALLOCARRAY */
diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux_internal.h
index 06f2c038..af69ff04 100644
--- a/libselinux/src/selinux_internal.h
+++ b/libselinux/src/selinux_internal.h
@@ -98,4 +98,8 @@ extern int has_selinux_config ;
 size_t strlcpy(char *dest, const char *src, size_t size);
 #endif
 
+#ifndef HAVE_REALLOCARRAY
+void *reallocarray(void *ptr, size_t nmemb, size_t size);
+#endif
+
 #endif /* SELINUX_INTERNAL_H_ */
diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index 7ef2d45d..38f10f1c 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -175,8 +175,7 @@ static int add_exclude(const char *directory, bool who)
 		return -1;
 	}
 
-	tmp_list = realloc(exclude_lst,
-			   sizeof(struct edir) * (exclude_count + 1));
+	tmp_list = reallocarray(exclude_lst, exclude_count + 1, sizeof(struct edir));
 	if (!tmp_list)
 		goto oom;
 
-- 
2.40.1

