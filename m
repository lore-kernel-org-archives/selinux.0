Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD64C25B73
	for <selinux@archiver.kernel.org>; Mon, 14 Aug 2023 13:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjHNNVY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Aug 2023 09:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbjHNNUt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 14 Aug 2023 09:20:49 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E106173F
        for <selinux@vger.kernel.org>; Mon, 14 Aug 2023 06:20:45 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fe457ec6e7so6848083e87.3
        for <selinux@vger.kernel.org>; Mon, 14 Aug 2023 06:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1692019243; x=1692624043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WMRdXXPySKs4DfE+y8O69B0s6zAZugNBKWTPys88D5c=;
        b=FeXhuEn4ssl5cFBjtlxcYV9o10zgg2RJy8hcAdOtBQp+L6qcM9mFv/fpr08gVEL2IV
         4mNCzonZ+Qav9gU6Cz/y+/Y5iSzEEHV/fW/x4vHAzLrF3mvuZweJ+QZMIqX9kAxQjt2q
         uI8w9h1Y1H4SaNfM9hixVU1iqQ+ATY2EolSyYOBSjUIcErbJ4WauVEkOTd1PpPAevOM4
         4M0fUMZzmi7ZCI4e2Y4xry3vjH5inmxVjuSi8Foofn1l74IenzMIZb+cmmY0hd7Xa+Fc
         SF98hN/0QnOJdWWOHjYUkeVD7t9mlmrwB7CGa7fUexAEhVneS9q7Lz6bAQK7lHTSohjW
         EdTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692019243; x=1692624043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WMRdXXPySKs4DfE+y8O69B0s6zAZugNBKWTPys88D5c=;
        b=XFw/AK/W788r4v36V4Gu4Dd2BW+XmeX3FZucN2gjsl2ZGlw0bizaJLpry0c96oXCVx
         Lc/s+HCTeV3Cx2l04cVBDlrJihfZqbQOiue3YMKwr5CuvXMyV3v8kiuwqFZgQXWJoPBc
         usMnoGGz4Rziw5F6O1Cdym8HytxeyiK7q96SQv6CFk+QKQIq972/D9LCEL+EQGT7b63u
         V6TcryebpCPZxgTIdDxEvkCiv0Ys9bhEvLmjfXWwoFXOsgx5rfEqtirg7KczraaAIV8u
         JEeULOSQa0zd4f9O2taERZKKDD66QHxovhc4dN3yrdo5msipPzjYrHfbsfTyrt78Q1AI
         sPEQ==
X-Gm-Message-State: AOJu0YyOmPkezjgg5KiC9ZbzlwOZvWLsZ56FT3WRCJFlxyDMS0tnFaWr
        iIquiBq1IYQBkAVGJZm0FxIrnqlPMUdAqbjzlZA=
X-Google-Smtp-Source: AGHT+IFZwwlTqCwrn7szGmrCth6vFo76YRSorzOdD5UBe7xZsJxMiAWQhQ/73c/Zytrq3Ml4NnZpRw==
X-Received: by 2002:a05:6512:3b0f:b0:4fc:4f3e:9cbf with SMTP id f15-20020a0565123b0f00b004fc4f3e9cbfmr7960746lfv.50.1692019243320;
        Mon, 14 Aug 2023 06:20:43 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-095-112-167-009.95.112.pool.telefonica.de. [95.112.167.9])
        by smtp.gmail.com with ESMTPSA id ck9-20020a170906c44900b00993664a9987sm5683541ejb.103.2023.08.14.06.20.42
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 06:20:43 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 06/27] libselinux: cast to unsigned char for character handling function
Date:   Mon, 14 Aug 2023 15:20:04 +0200
Message-Id: <20230814132025.45364-7-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230814132025.45364-1-cgzones@googlemail.com>
References: <20230814132025.45364-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Character handling functions, like isspace(3), expect a value
representable as unsigned char or equal to EOF.  Otherwise the behavior
is undefined.

See https://wiki.sei.cmu.edu/confluence/display/c/STR37-C.+Arguments+to+character-handling+functions+must+be+representable+as+an+unsigned+char

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/booleans.c                        |  8 ++++----
 libselinux/src/compute_create.c                  |  2 +-
 libselinux/src/get_context_list.c                | 12 ++++++------
 libselinux/src/get_default_type.c                |  2 +-
 libselinux/src/label_file.c                      |  8 ++++----
 libselinux/src/label_media.c                     |  2 +-
 libselinux/src/label_support.c                   |  8 ++++----
 libselinux/src/label_x.c                         |  2 +-
 libselinux/src/load_policy.c                     |  2 +-
 libselinux/src/matchmediacon.c                   |  6 +++---
 libselinux/src/selinux_check_securetty_context.c |  4 ++--
 libselinux/src/selinux_config.c                  | 12 ++++++------
 libselinux/src/seusers.c                         |  6 +++---
 13 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/libselinux/src/booleans.c b/libselinux/src/booleans.c
index e34b39ff..c557df65 100644
--- a/libselinux/src/booleans.c
+++ b/libselinux/src/booleans.c
@@ -107,7 +107,7 @@ char *selinux_boolean_sub(const char *name)
 		char *ptr;
 		char *src = line_buf;
 		char *dst;
-		while (*src && isspace(*src))
+		while (*src && isspace((unsigned char)*src))
 			src++;
 		if (!*src)
 			continue;
@@ -115,19 +115,19 @@ char *selinux_boolean_sub(const char *name)
 			continue;
 
 		ptr = src;
-		while (*ptr && !isspace(*ptr))
+		while (*ptr && !isspace((unsigned char)*ptr))
 			ptr++;
 		*ptr++ = '\0';
 		if (strcmp(src, name) != 0)
 			continue;
 
 		dst = ptr;
-		while (*dst && isspace(*dst))
+		while (*dst && isspace((unsigned char)*dst))
 			dst++;
 		if (!*dst)
 			continue;
 		ptr = dst;
-		while (*ptr && !isspace(*ptr))
+		while (*ptr && !isspace((unsigned char)*ptr))
 			ptr++;
 		*ptr = '\0';
 
diff --git a/libselinux/src/compute_create.c b/libselinux/src/compute_create.c
index e9f3c96a..92ee2fc3 100644
--- a/libselinux/src/compute_create.c
+++ b/libselinux/src/compute_create.c
@@ -23,7 +23,7 @@ static int object_name_encode(const char *objname, char *buffer, size_t buflen)
 	do {
 		code = *objname++;
 
-		if (isalnum(code) || code == '\0' || code == '-' ||
+		if (isalnum((unsigned char)code) || code == '\0' || code == '-' ||
 		    code == '.' || code == '_' || code == '~') {
 			if (buflen - offset < 1)
 				return -1;
diff --git a/libselinux/src/get_context_list.c b/libselinux/src/get_context_list.c
index d774b9cf..0342823c 100644
--- a/libselinux/src/get_context_list.c
+++ b/libselinux/src/get_context_list.c
@@ -170,27 +170,27 @@ static int get_context_user(FILE * fp,
 
 		/* Skip leading whitespace. */
 		start = line;
-		while (*start && isspace(*start))
+		while (*start && isspace((unsigned char)*start))
 			start++;
 		if (!(*start))
 			continue;
 
 		/* Find the end of the (partial) fromcon in the line. */
 		end = start;
-		while (*end && !isspace(*end))
+		while (*end && !isspace((unsigned char)*end))
 			end++;
 		if (!(*end))
 			continue;
 
 		/* Check for a match. */
 		linerole = start;
-		while (*start && !isspace(*start) && *start != ':')
+		while (*start && !isspace((unsigned char)*start) && *start != ':')
 			start++;
 		if (*start != ':')
 			continue;
 		*start = 0;
 		linetype = ++start;
-		while (*start && !isspace(*start) && *start != ':')
+		while (*start && !isspace((unsigned char)*start) && *start != ':')
 			start++;
 		if (!(*start))
 			continue;
@@ -210,14 +210,14 @@ static int get_context_user(FILE * fp,
 	start = ++end;
 	while (*start) {
 		/* Skip leading whitespace */
-		while (*start && isspace(*start))
+		while (*start && isspace((unsigned char)*start))
 			start++;
 		if (!(*start))
 			break;
 
 		/* Find the end of this partial context. */
 		end = start;
-		while (*end && !isspace(*end))
+		while (*end && !isspace((unsigned char)*end))
 			end++;
 		if (*end)
 			*end++ = 0;
diff --git a/libselinux/src/get_default_type.c b/libselinux/src/get_default_type.c
index 766ea4b7..87e9c72c 100644
--- a/libselinux/src/get_default_type.c
+++ b/libselinux/src/get_default_type.c
@@ -42,7 +42,7 @@ static int find_default_type(FILE * fp, const char *role, char **type)
 			buf[strlen(buf) - 1] = 0;
 
 		ptr = buf;
-		while (*ptr && isspace(*ptr))
+		while (*ptr && isspace((unsigned char)*ptr))
 			ptr++;
 		if (!(*ptr))
 			continue;
diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 3da28c45..461abc61 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -697,20 +697,20 @@ static int selabel_subs_init(const char *path, struct selabel_digest *digest,
 		char *src = buf;
 		char *dst = NULL;
 
-		while (*src && isspace(*src))
+		while (*src && isspace((unsigned char)*src))
 			src++;
 		if (src[0] == '#') continue;
 		ptr = src;
-		while (*ptr && ! isspace(*ptr))
+		while (*ptr && ! isspace((unsigned char)*ptr))
 			ptr++;
 		*ptr++ = '\0';
 		if (! *src) continue;
 
 		dst = ptr;
-		while (*dst && isspace(*dst))
+		while (*dst && isspace((unsigned char)*dst))
 			dst++;
 		ptr = dst;
-		while (*ptr && ! isspace(*ptr))
+		while (*ptr && ! isspace((unsigned char)*ptr))
 			ptr++;
 		*ptr = '\0';
 		if (! *dst)
diff --git a/libselinux/src/label_media.c b/libselinux/src/label_media.c
index 3137c18e..f09461ab 100644
--- a/libselinux/src/label_media.c
+++ b/libselinux/src/label_media.c
@@ -39,7 +39,7 @@ static int process_line(const char *path, char *line_buf, int pass,
 	char *key, *context;
 
 	buf_p = line_buf;
-	while (isspace(*buf_p))
+	while (isspace((unsigned char)*buf_p))
 		buf_p++;
 	/* Skip comment lines and empty lines. */
 	if (*buf_p == '#' || *buf_p == 0)
diff --git a/libselinux/src/label_support.c b/libselinux/src/label_support.c
index df474cba..94fb6697 100644
--- a/libselinux/src/label_support.c
+++ b/libselinux/src/label_support.c
@@ -26,14 +26,14 @@ static inline int read_spec_entry(char **entry, char **ptr, int *len, const char
 	*entry = NULL;
 	char *tmp_buf = NULL;
 
-	while (isspace(**ptr) && **ptr != '\0')
+	while (isspace((unsigned char)**ptr) && **ptr != '\0')
 		(*ptr)++;
 
 	tmp_buf = *ptr;
 	*len = 0;
 
-	while (!isspace(**ptr) && **ptr != '\0') {
-		if (!isascii(**ptr)) {
+	while (!isspace((unsigned char)**ptr) && **ptr != '\0') {
+		if (!isascii((unsigned char)**ptr)) {
 			errno = EINVAL;
 			*errbuf = "Non-ASCII characters found";
 			return -1;
@@ -80,7 +80,7 @@ int  read_spec_entries(char *line_buf, const char **errbuf, int num_args, ...)
 		len++;
 
 	buf_p = line_buf;
-	while (isspace(*buf_p))
+	while (isspace((unsigned char)*buf_p))
 		buf_p++;
 
 	/* Skip comment lines and empty lines. */
diff --git a/libselinux/src/label_x.c b/libselinux/src/label_x.c
index e6e8d9f6..e80bf107 100644
--- a/libselinux/src/label_x.c
+++ b/libselinux/src/label_x.c
@@ -41,7 +41,7 @@ static int process_line(const char *path, char *line_buf, int pass,
 	char *type, *key, *context;
 
 	buf_p = line_buf;
-	while (isspace(*buf_p))
+	while (isspace((unsigned char)*buf_p))
 		buf_p++;
 	/* Skip comment lines and empty lines. */
 	if (*buf_p == '#' || *buf_p == 0)
diff --git a/libselinux/src/load_policy.c b/libselinux/src/load_policy.c
index 17918e8b..57d7aaef 100644
--- a/libselinux/src/load_policy.c
+++ b/libselinux/src/load_policy.c
@@ -252,7 +252,7 @@ int selinux_init_load_policy(int *enforce)
 		}
 		if (fgets(buf, selinux_page_size, cfg) &&
 		    (tmp = strstr(buf, "enforcing="))) {
-			if (tmp == buf || isspace(*(tmp - 1))) {
+			if (tmp == buf || isspace((unsigned char)*(tmp - 1))) {
 				secmdline =
 				    atoi(tmp + sizeof("enforcing=") - 1);
 			}
diff --git a/libselinux/src/matchmediacon.c b/libselinux/src/matchmediacon.c
index d3d95043..6ba87b99 100644
--- a/libselinux/src/matchmediacon.c
+++ b/libselinux/src/matchmediacon.c
@@ -29,7 +29,7 @@ int matchmediacon(const char *media, char ** con)
 			current_line[strlen(current_line) - 1] = 0;
 		/* Skip leading whitespace before the partial context. */
 		ptr = current_line;
-		while (*ptr && isspace(*ptr))
+		while (*ptr && isspace((unsigned char)*ptr))
 			ptr++;
 
 		if (!(*ptr))
@@ -37,7 +37,7 @@ int matchmediacon(const char *media, char ** con)
 
 		/* Find the end of the media context. */
 		ptr2 = ptr;
-		while (*ptr2 && !isspace(*ptr2))
+		while (*ptr2 && !isspace((unsigned char)*ptr2))
 			ptr2++;
 		if (!(*ptr2))
 			continue;
@@ -53,7 +53,7 @@ int matchmediacon(const char *media, char ** con)
 		return -1;
 
 	/* Skip whitespace. */
-	while (*ptr2 && isspace(*ptr2))
+	while (*ptr2 && isspace((unsigned char)*ptr2))
 		ptr2++;
 	if (!(*ptr2)) {
 		return -1;
diff --git a/libselinux/src/selinux_check_securetty_context.c b/libselinux/src/selinux_check_securetty_context.c
index c5c557fd..7609752e 100644
--- a/libselinux/src/selinux_check_securetty_context.c
+++ b/libselinux/src/selinux_check_securetty_context.c
@@ -26,13 +26,13 @@ int selinux_check_securetty_context(const char * tty_context)
 
 				/* Skip leading whitespace. */
 				start = line;
-				while (*start && isspace(*start))
+				while (*start && isspace((unsigned char)*start))
 					start++;
 				if (!(*start))
 					continue;
 
 				end = start;
-				while (*end && !isspace(*end))
+				while (*end && !isspace((unsigned char)*end))
 					end++;
 				if (*end)
 					*end++ = 0;
diff --git a/libselinux/src/selinux_config.c b/libselinux/src/selinux_config.c
index d2e49ee1..1d8cfb71 100644
--- a/libselinux/src/selinux_config.c
+++ b/libselinux/src/selinux_config.c
@@ -103,7 +103,7 @@ int selinux_getenforcemode(int *enforce)
 			if (strncmp(buf, SELINUXTAG, len))
 				continue;
 			tag = buf+len;
-			while (isspace(*tag))
+			while (isspace((unsigned char)*tag))
 				tag++;
 			if (!strncasecmp
 			    (tag, "enforcing", sizeof("enforcing") - 1)) {
@@ -173,7 +173,7 @@ static void init_selinux_config(void)
 			if (line_buf[len - 1] == '\n')
 				line_buf[len - 1] = 0;
 			buf_p = line_buf;
-			while (isspace(*buf_p))
+			while (isspace((unsigned char)*buf_p))
 				buf_p++;
 			if (*buf_p == '#' || *buf_p == 0)
 				continue;
@@ -181,7 +181,7 @@ static void init_selinux_config(void)
 			if (!strncasecmp(buf_p, SELINUXTYPETAG,
 					 sizeof(SELINUXTYPETAG) - 1)) {
 				buf_p += sizeof(SELINUXTYPETAG) - 1;
-				while (isspace(*buf_p))
+				while (isspace((unsigned char)*buf_p))
 					buf_p++;
 				type = strdup(buf_p);
 				if (!type) {
@@ -191,7 +191,7 @@ static void init_selinux_config(void)
 				}
 				end = type + strlen(type) - 1;
 				while ((end > type) &&
-				       (isspace(*end) || iscntrl(*end))) {
+				       (isspace((unsigned char)*end) || iscntrl((unsigned char)*end))) {
 					*end = 0;
 					end--;
 				}
@@ -206,14 +206,14 @@ static void init_selinux_config(void)
 			} else if (!strncmp(buf_p, REQUIRESEUSERS,
 					    sizeof(REQUIRESEUSERS) - 1)) {
 				value = buf_p + sizeof(REQUIRESEUSERS) - 1;
-				while (isspace(*value))
+				while (isspace((unsigned char)*value))
 					value++;
 				intptr = &require_seusers;
 			} else {
 				continue;
 			}
 
-			if (isdigit(*value))
+			if (isdigit((unsigned char)*value))
 				*intptr = atoi(value);
 			else if (strncasecmp(value, "true", sizeof("true") - 1))
 				*intptr = 1;
diff --git a/libselinux/src/seusers.c b/libselinux/src/seusers.c
index fff80c1a..6da8c318 100644
--- a/libselinux/src/seusers.c
+++ b/libselinux/src/seusers.c
@@ -25,7 +25,7 @@ static int process_seusers(const char *buffer,
 		goto err;
 
 	start = newbuf;
-	while (isspace(*start))
+	while (isspace((unsigned char)*start))
 		start++;
 	if (*start == '#' || *start == 0) {
 		free(newbuf);
@@ -46,7 +46,7 @@ static int process_seusers(const char *buffer,
 		mls_found = 0;
 
 		end = start;
-		while (*end && !isspace(*end))
+		while (*end && !isspace((unsigned char)*end))
 			end++;
 	}
 	*end = 0;
@@ -63,7 +63,7 @@ static int process_seusers(const char *buffer,
 		goto out;
 
 	start = ++end;
-	while (*end && !isspace(*end))
+	while (*end && !isspace((unsigned char)*end))
 		end++;
 	*end = 0;
 
-- 
2.40.1

