Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC6BEB64DD
	for <selinux@archiver.kernel.org>; Fri, 11 Aug 2023 16:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbjHKQ1z (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 11 Aug 2023 12:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbjHKQ1y (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 11 Aug 2023 12:27:54 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182D018F
        for <selinux@vger.kernel.org>; Fri, 11 Aug 2023 09:27:53 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99bf3f59905so297166966b.3
        for <selinux@vger.kernel.org>; Fri, 11 Aug 2023 09:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1691771271; x=1692376071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WMRdXXPySKs4DfE+y8O69B0s6zAZugNBKWTPys88D5c=;
        b=ULQB9Ekc9Pue73t2r+Qg26O+gPeS45at3KV2QSH/O5RBezXumdWDOA9iSE9CHlc2ep
         q43Wpji9zevmLsRhtUavuucl1ECd6XUHR1K5nrVtomMabOy16wC7H/iouEvKfe34ftxg
         TpwAZWTHd6o0NKsEoSr4aVmRI3JGKc2mAXOXzjXXV7hmQdHyraKElWeDXIKWaHF00hBl
         gU5/0GGVdCndPUjTtQawh/ePwqDqrytGLINEDrvu1jLIsMP4Xd5+aSmoprKz+5nE/3fl
         Dw4zfW6oUTnQIbuf+TuxNNtjiEVqMauYI6LRUZfzOslwqsWud1HvMJMJe5qPhu7mkSXH
         uXrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691771271; x=1692376071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WMRdXXPySKs4DfE+y8O69B0s6zAZugNBKWTPys88D5c=;
        b=PFhoZgQznqzoaGFUB9YwuWNJD9P2auWxaFdff8eEu78hIh+IVPaZhOAFuPvsCR7hBL
         JoWRM5tk0tdeYdyCE8GZauxArC+TtKXWVCltMUD5eXUqtrzQSkUUKI/FQYznwOJGxRIa
         N5eYohzqike/KMVn58m5eg/a8M4LT49aHm06BVQ26Uaq4d8YU6gxx2cqCCASja0Urpeo
         Jc2umMDEFk+yDtyE1E9a6ykNavzdDCd3oqJrqtsKHOTBC+CD7SDWBaQJuqZw7EL0vwlE
         GAJck5H7VxfcqcqSzFxHK7R23B6REeDwYFWLRSNiEfwSJCdhMJCl4mQEsgDyRgx8uahG
         lE8A==
X-Gm-Message-State: AOJu0YyqdNi5clGLj03CvKzTCCJP+m1s1vBO/czggJCrD9SiM1HFyAad
        BdkDcLwOpn+iGMK8vw8wyOjbupfjhvMuZg==
X-Google-Smtp-Source: AGHT+IGLE1Li2OQmbn1yzxkN4z99qC6cyu3mwGYYdBH+HtAziTJST1sMz0UI5zyemfHJgKdX8p/Mcw==
X-Received: by 2002:a17:907:7716:b0:99b:bca6:cf94 with SMTP id kw22-20020a170907771600b0099bbca6cf94mr1996186ejc.14.1691771271183;
        Fri, 11 Aug 2023 09:27:51 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-000-174-226.77.0.pool.telefonica.de. [77.0.174.226])
        by smtp.gmail.com with ESMTPSA id p9-20020a170906b20900b00992afee724bsm2408807ejz.76.2023.08.11.09.27.50
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 09:27:50 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 06/24] libselinux: cast to unsigned char for character handling function
Date:   Fri, 11 Aug 2023 18:27:13 +0200
Message-Id: <20230811162731.50697-7-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230811162731.50697-1-cgzones@googlemail.com>
References: <20230811162731.50697-1-cgzones@googlemail.com>
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

