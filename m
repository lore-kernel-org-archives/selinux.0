Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D47C4332F
	for <selinux@archiver.kernel.org>; Wed,  1 Nov 2023 16:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbjKAQ4s (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 1 Nov 2023 12:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjKAQ4r (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 1 Nov 2023 12:56:47 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E0110E
        for <selinux@vger.kernel.org>; Wed,  1 Nov 2023 09:56:44 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-991c786369cso2072066b.1
        for <selinux@vger.kernel.org>; Wed, 01 Nov 2023 09:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1698857802; x=1699462602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5oLAiAl4xCyji4OfS+SQcQU///K9BdWsUv3YDctLUsA=;
        b=mL1YqeU9hTb8sdeQ7IxboImSoLB4J6cZkU8IwCNJncfugo7j2gd6tk49Cc2i+++akP
         QMCWXNlfDyfLcdQkNOhudO8ZelOyP9993A9rFzlvfZ16GR3ApkYn6EcjE5eLgeUnihwr
         4oTjeQRLY0JMCAyKjQfRmnN6iXW/Xxu0+zl26ytik2GiTRp20e7Uf5g7QNHoYokxy1JC
         4k6/B7KulKpJzBFJC7AcNtMN7G459YCMbRLylntXNJeXE/0aB2I6dSL9lixv/o25/yye
         nq4hnkgaqsxfzJudoHcI3KZ4SEGBm3gN+o09UqF6s1Cac4PTDtYFL6xk3waCnnsKtTgP
         tuLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698857802; x=1699462602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5oLAiAl4xCyji4OfS+SQcQU///K9BdWsUv3YDctLUsA=;
        b=HYjrxarOnP+j+df4sMfxwVHGzcq7YO17JKE0eZoQ44LtDEjYOJriVhChES9FWRcQMJ
         YU0bnnO4DuFlYwvht6mFV3cNLPcnmeWmL7e6HMEbhO7ALJ1D5W90oO9UjAdIXvILKY4F
         e7j+m1f4r2JYXNq6Uj3fLZvJ40ECrYAHbK/reihdsH28LyXRr5veRbRgIj1U0rKupI2Q
         VEdQTOJfXOg5CTy6IHbQ+33eGNou/7auHw0ewWwANYAzoY3EDoELdmD5L87cSwfkcw4c
         dwxcCwEfQYSCVdH8IlGm5wohpj49+9WkTz5IhzwvC2ynXwSU4M4dKbZypYICTdXqrakz
         zwbQ==
X-Gm-Message-State: AOJu0YyyenxgRGJ51HNy1NczIlBbSmbLRFZizVS8Khi7sEALaA3/nTrs
        0AqgYMnnyH6hAyubS+kjxECW3eTBKoQ=
X-Google-Smtp-Source: AGHT+IE6buOy4T04yJYIk626xldWIKJ8p1lqbzyz/aAnOwvw1Cl++kGi/JWvjZaFHrzw+uPIdNuBYA==
X-Received: by 2002:a17:906:c10c:b0:9a1:f10d:9746 with SMTP id do12-20020a170906c10c00b009a1f10d9746mr2462090ejc.20.1698857802318;
        Wed, 01 Nov 2023 09:56:42 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-095-116-163-023.95.116.pool.telefonica.de. [95.116.163.23])
        by smtp.gmail.com with ESMTPSA id q22-20020a170906145600b009ad875d12d7sm133277ejc.210.2023.11.01.09.56.41
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 09:56:42 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v3 2/2] libselinux: introduce reallocarray(3)
Date:   Wed,  1 Nov 2023 17:56:36 +0100
Message-ID: <20231101165636.184983-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231101165636.184983-1-cgzones@googlemail.com>
References: <20231101165636.184983-1-cgzones@googlemail.com>
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
v3:
  - use SIZE_MAX and NULL instead of -1 and 0
  - fix indentation
  - drop RFC and split from original patch set
---
 libselinux/src/Makefile             |  6 ++++++
 libselinux/src/get_context_list.c   |  2 +-
 libselinux/src/matchpathcon.c       |  4 ++--
 libselinux/src/selinux_internal.c   | 16 ++++++++++++++++
 libselinux/src/selinux_internal.h   |  4 ++++
 libselinux/src/selinux_restorecon.c |  3 +--
 6 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index cf830046..7aadb822 100644
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
index b98849d9..e44734c3 100644
--- a/libselinux/src/matchpathcon.c
+++ b/libselinux/src/matchpathcon.c
@@ -96,8 +96,8 @@ static int add_array_elt(char *con)
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
index c2be7c0a..678bd99c 100644
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
+	if (size && nmemb > SIZE_MAX / size) {
+		errno = ENOMEM;
+		return NULL;
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
2.42.0

