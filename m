Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D259C433EF
	for <selinux@archiver.kernel.org>; Tue, 10 May 2022 18:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242421AbiEJSYr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 May 2022 14:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242059AbiEJSYq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 10 May 2022 14:24:46 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7611035860
        for <selinux@vger.kernel.org>; Tue, 10 May 2022 11:20:46 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id i27so34590419ejd.9
        for <selinux@vger.kernel.org>; Tue, 10 May 2022 11:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=C+mwM3ujfpjc0+acHLGDniw9/hhwIyhdGzExpNHmTww=;
        b=Gfml8NYEGbNHBdBKbhRAz8kDzakAmKzg1+i0Ylus7ZsuZcDZ3SyNftF/TaCYuJK5uk
         JjoVscS8qhM8E9RC1vbKkekYaCujnL7RpbwZXxjf5+5N8DO29wKbvDboZIKYLTxA2cAA
         7AR36OZUqhT1Ro5msPLpSC72fpUwHkAduJ7FLJS1I37I2XN0Z7VVAiDqNdVL2toTleWx
         sTTwoQxLcS7d9LvJ/e7u0ZGkwin3/6KgQ9GyXlTPogO7M1jvGzkAM7aXAL3M5iDnq86/
         h4A6YRFZUNLOBuR2+3+v0FQUiR6kLcqSgsWZGZNcJ18ZaXsYpEIeosWqKzxrnmMdBjF8
         btbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C+mwM3ujfpjc0+acHLGDniw9/hhwIyhdGzExpNHmTww=;
        b=yv7bZDUSH8k4bDsG3VTh416MQoCuW2abaD+9j80LmVCTeZ4uzEaQlZcRvhpl1QTTPz
         86ZJhkl6daZzUTkBwQgwzuMAG2L9G69hxXdP7kGJaZCsaxgZ5iVdpMADoUlrnlZR3IvL
         TridmfoJSCdlLxjMLmNHPmDHKoWhfDLCAN99PbZU02WttGPM9yCHBns73HEuddNITkJp
         xTxu+eTW+tBE/9cbg3vk3gHu7NAzx884YU9gTFZSjfjJMPlZRuPD62pQxxz+ekda/4om
         x94UaGk1CsR9SAHgyXRYeIsABTUg5Yi6D3jS7RS1bynJXZYZRvtoWRvKIFqIAhxcgjZu
         LIdw==
X-Gm-Message-State: AOAM530tSxf8mJCIs/nO9JFZ7ZAgkWWVUfOeIF6WyeqCXYl+5fYrOGoA
        60BIiZ81GIJfcmfudjer8Hmi3aRpy1U=
X-Google-Smtp-Source: ABdhPJxrK+zAs5DhEa1Gb7PvJ+oGxJJ3rWjKWV/ZTtj0oUKVhpsVFHcbKu2NPgTlk0OeQREso5comg==
X-Received: by 2002:a17:907:7810:b0:6e7:ef73:8326 with SMTP id la16-20020a170907781000b006e7ef738326mr20382521ejc.429.1652206844934;
        Tue, 10 May 2022 11:20:44 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-078-050-241-079.78.50.pool.telefonica.de. [78.50.241.79])
        by smtp.gmail.com with ESMTPSA id p3-20020a056402154300b0042877d166fdsm5339947edx.38.2022.05.10.11.20.44
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 11:20:44 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 3/4] libselinux: introduce strlcpy
Date:   Tue, 10 May 2022 20:20:38 +0200
Message-Id: <20220510182039.28771-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220510182039.28771-1-cgzones@googlemail.com>
References: <20220510182039.28771-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

To copy string safely, by always NULL-terminating them, and provide an
easy way to check for truncation introduce the nonstandard function
strlcpy(3).  Use the system implementation if available.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/Makefile           |  6 ++++++
 libselinux/src/selinux_internal.c | 18 ++++++++++++++++++
 libselinux/src/selinux_internal.h |  4 ++++
 3 files changed, 28 insertions(+)
 create mode 100644 libselinux/src/selinux_internal.c

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 04bf4f24..88aa32f8 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -103,6 +103,12 @@ FTS_LDLIBS ?=
 
 override CFLAGS += -I../include -D_GNU_SOURCE $(DISABLE_FLAGS) $(PCRE_CFLAGS)
 
+# check for strlcpy(3) availability
+H := \#
+ifeq (yes,$(shell printf '${H}include <string.h>\nint main(void){char*d,*s;strlcpy(d, s, 0);return 0;}' | $(CC) -x c -o /dev/null - >/dev/null 2>&1 && echo yes))
+override CFLAGS += -DHAVE_STRLCPY
+endif
+
 SWIG_CFLAGS += -Wno-error -Wno-unused-variable -Wno-unused-but-set-variable -Wno-unused-parameter \
 		-Wno-shadow -Wno-uninitialized -Wno-missing-prototypes -Wno-missing-declarations \
 		-Wno-deprecated-declarations
diff --git a/libselinux/src/selinux_internal.c b/libselinux/src/selinux_internal.c
new file mode 100644
index 00000000..c2be7c0a
--- /dev/null
+++ b/libselinux/src/selinux_internal.c
@@ -0,0 +1,18 @@
+#include "selinux_internal.h"
+
+#include <string.h>
+
+
+#ifndef HAVE_STRLCPY
+size_t strlcpy(char *dest, const char *src, size_t size)
+{
+	size_t ret = strlen(src);
+
+	if (size) {
+		size_t len = (ret >= size) ? size - 1 : ret;
+		memcpy(dest, src, len);
+		dest[len] = '\0';
+	}
+	return ret;
+}
+#endif /* HAVE_STRLCPY */
diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux_internal.h
index 9f4c9073..06f2c038 100644
--- a/libselinux/src/selinux_internal.h
+++ b/libselinux/src/selinux_internal.h
@@ -94,4 +94,8 @@ extern int selinux_page_size ;
 
 extern int has_selinux_config ;
 
+#ifndef HAVE_STRLCPY
+size_t strlcpy(char *dest, const char *src, size_t size);
+#endif
+
 #endif /* SELINUX_INTERNAL_H_ */
-- 
2.36.1

