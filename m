Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8CFC4167B
	for <selinux@archiver.kernel.org>; Wed,  1 Nov 2023 16:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbjKAQ4u (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 1 Nov 2023 12:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjKAQ4t (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 1 Nov 2023 12:56:49 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4A8FD
        for <selinux@vger.kernel.org>; Wed,  1 Nov 2023 09:56:43 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9cf83c044b7so1685966b.1
        for <selinux@vger.kernel.org>; Wed, 01 Nov 2023 09:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1698857802; x=1699462602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=yF1195uVZM+3s9IqKtAhO/7nNiga5unBtmxsjeec70s=;
        b=DZ10tLTSLVlqOvxYI1U2wG9IaVrMcCwcdWc/peHQDTNT3oRor/s6EJXR5aGAPS7AyJ
         Faqj9PYjEfINpi57/ovQbMuULBB4lE50zaiS+Ugel8eHTEVCtaU36oAVhatemqapwhPL
         dmfNqRr5mJX1kBhd1aXLP8kUt57rNVFBLFWraJAi7upZCy2ormXf5NJl11IDa3jhkaYn
         2eOqUDAm18OKlPkBsNCYReYb7c/OI9MtfSF9yI8vTnzQbo0n07OgVrIuYOhHIH7PH9Oj
         M17lARXnLtUbu+U499UqUHgKrU1jh/tSW/juNtbwaGnrSR9aH49co32TGlOGFUqLaIhY
         hdvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698857802; x=1699462602;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yF1195uVZM+3s9IqKtAhO/7nNiga5unBtmxsjeec70s=;
        b=BH1m2ja5jkH0dZg5YtCcEq8Q4VPcqNexVItjZjz12qTXF9VpAhJ0iGne+fZIWnjGJV
         dyDu4VZ+buS4pi+X6mbBhkgJvzR7kR9AtpM8WNwVkSKL5IstM2vxtTywUkCt/iujbmbc
         HTuXBDxHWXUVpQFd5lZMCUTkqXNR7EirW4XYFphh4lEgmFYWludwZOhJtlk7+s9Ruxm9
         26izFUu8xie2OGYowd8YAt5dKSdZZOo1AIlSY0e1Une0sEE4/QSbspqKx4U7H+dGgS+H
         E0oie/yyYPgMTfTDtGig5+mGIui17YhIHc+GhPh0ICFJ2Cekp6o4E1T68pbeQDOyUPRu
         UMwA==
X-Gm-Message-State: AOJu0Yxa+mjV75IteO37Sfnob8eUOYkII+gmT2X70YE2JdiP+IFXTrUx
        wdeR5bq9kOpRsZpImwyw0knUMYRUjKg=
X-Google-Smtp-Source: AGHT+IHGYkJMHIC5suWmoTwbQUrRLo9kH/NIRSTbKb96Cvdc31F7zpUJ1wJPVPN8tS2pa43tJ9EWUw==
X-Received: by 2002:a17:907:9603:b0:9d3:f436:6807 with SMTP id gb3-20020a170907960300b009d3f4366807mr2426990ejc.42.1698857801830;
        Wed, 01 Nov 2023 09:56:41 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-095-116-163-023.95.116.pool.telefonica.de. [95.116.163.23])
        by smtp.gmail.com with ESMTPSA id q22-20020a170906145600b009ad875d12d7sm133277ejc.210.2023.11.01.09.56.41
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 09:56:41 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v3 1/2] libselinux: cast to unsigned char for character handling function
Date:   Wed,  1 Nov 2023 17:56:35 +0100
Message-ID: <20231101165636.184983-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.42.0
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
v3:
  - compute_create.c: avoid cast by changing type of variable
  - drop RFC and split from original patch set
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
index e9f3c96a..d19baa0b 100644
--- a/libselinux/src/compute_create.c
+++ b/libselinux/src/compute_create.c
@@ -13,7 +13,7 @@
 
 static int object_name_encode(const char *objname, char *buffer, size_t buflen)
 {
-	int	code;
+	unsigned char code;
 	size_t	offset = 0;
 
 	if (buflen - offset < 1)
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
index a665c9b4..4778f8f8 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -708,20 +708,20 @@ static int selabel_subs_init(const char *path, struct selabel_digest *digest,
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
index d33b614a..b3443b47 100644
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
index 49f72b1c..f7ab9292 100644
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
index 4b8f524f..e15190ca 100644
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
2.42.0

