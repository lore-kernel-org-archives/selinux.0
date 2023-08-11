Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FCFC04A94
	for <selinux@archiver.kernel.org>; Fri, 11 Aug 2023 16:27:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233767AbjHKQ15 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 11 Aug 2023 12:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232970AbjHKQ1z (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 11 Aug 2023 12:27:55 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455DF2D69
        for <selinux@vger.kernel.org>; Fri, 11 Aug 2023 09:27:54 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99bcfe28909so294209566b.3
        for <selinux@vger.kernel.org>; Fri, 11 Aug 2023 09:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1691771273; x=1692376073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zldRw8Qz99PhYJpeHb62+a0eKAIAXQBkbyHdUHPmJps=;
        b=G6UgNH4/d0jYp/YGUav2/pFvZNeG7xrjnjE7MrFvQUsRzFt008R17ml5RHKe0usWlz
         473tGCbIPg0FbLm3DJ0g0RaBJK4o9aTAKfRyPZFZzYr6NL7SACYX/d+DSTlYSAAUlB49
         wn/VJTJWxSryTxbTqn99Qct+Lzw5WkoMwOfCes5pZZuiulNKXHzHyNyPzePv1wJ8Xxzv
         /2QnnuLJ/9C1gBrq2/HBtO01GNwrQ+9zyW6iVW5XfJNtF/+3VO1+zLW79T1+li09GhiY
         1UBQ/E9LJLV6UCr04ziEC9rU2YYq5cdm9+kPgFK8YYwth5L+gKXRL8C7mjZuMCeSiemG
         Cipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691771273; x=1692376073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zldRw8Qz99PhYJpeHb62+a0eKAIAXQBkbyHdUHPmJps=;
        b=IxXwxIgcrNquVmnNQ5YTfYnM+P4E7VturYwjX3EYcRUXrbG7JTjDWOasUqX3z61Avw
         n7zJ1RdywDFRiAfFKunYrh2bT22nu1pJ0XrHvY1/42rZjJHqQKN8lTpnDT0nRwA3RYV4
         1VeZZuuJPlrnQO72lMVvyfIXQseDoMWfSx+JlWz1o0IZ7cHyl/ruJ03FtBp45YvTx5Dm
         Bhugh8h8z7sEcbKjBbjr/UW/Btfz8nx9WNOgiD03l92iKYNPnfqKytVrNjq7wEQ8psyO
         6Hj47IQpLTYQUCC/T2XQcBCX6iUOuLLfHNmiRGxzjfUDcdrBHNbm9OApXc5RoZXwSJtL
         CvbA==
X-Gm-Message-State: AOJu0YxswGAzm0nvPG0xd9bm74VvZGEfolAZUdZTve10mSc1R0gtO8+T
        s4tvkMt8iSz+O9mPV+/MglfZzGQSp6VdPg==
X-Google-Smtp-Source: AGHT+IGZJJZsBB7Eu964glbwp9HGn1TOA3gUD7okgVmGVVSaLh1168llUyi9ZSqK5TwD8Jx2JdgJ+w==
X-Received: by 2002:a17:906:3097:b0:991:c566:979 with SMTP id 23-20020a170906309700b00991c5660979mr1931837ejv.36.1691771272434;
        Fri, 11 Aug 2023 09:27:52 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-000-174-226.77.0.pool.telefonica.de. [77.0.174.226])
        by smtp.gmail.com with ESMTPSA id p9-20020a170906b20900b00992afee724bsm2408807ejz.76.2023.08.11.09.27.51
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 09:27:52 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 08/24] libselinux: introduce reallocarray(3)
Date:   Fri, 11 Aug 2023 18:27:15 +0200
Message-Id: <20230811162731.50697-9-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230811162731.50697-1-cgzones@googlemail.com>
References: <20230811162731.50697-1-cgzones@googlemail.com>
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

