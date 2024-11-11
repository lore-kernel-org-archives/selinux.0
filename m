Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF7A1A0714
	for <selinux@vger.kernel.org>; Mon, 11 Nov 2024 14:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731334643; cv=none; b=FSZdNo1dzRF8LN4roC8DzqFhskupAB3Y97Gxgs8a6zD+YwG0+DLGMWN/PgnJghkkkcSEt4Jb61Wud4lWcEbVelcqe+izAWjozKxI2CC9+T143n3Zj7/ySsKXV3fkGqGJaHyTXTV/pDa/s7Q3diwhqKRosjb4ho1i7cXCv3/kdGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731334643; c=relaxed/simple;
	bh=BCYkPibHr8mJqNX/uudDQxmIkMlMJddVZxuATiHeUAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BbnOmUrcgZIZrbLnIQRFGAh+C9j8qqpBJ7T+50nKpbJBJbLOwy6pG5ewsqdZuJfbv9CAlSctK2vs0rAqaYKw+cBU2wpgcO6B2T9bD8p8PAEyNr5jdgjndtcI0Jbxqx/97Nf8+LzaQE8npGPdD62JRLg1owoXH7aFx6GzGHPThwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=aNFhNskm; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="aNFhNskm"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731334635;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AxRnLsEc9JYnGbm/RmRWa4v0FQFYfs3WMKJCaqfR1yQ=;
	b=aNFhNskmv8MprZOxR51mzaFPfBiEPMQOdQRPsUTlU1EJttw7sRHQHwKXENfQVzUqH0ouJd
	m2WCd+coQjqO3tpYNlxNG3LQsIWaYmvQhnTh0l4uoo2KhA25NSSun0qZke4+VayOSdG6Ch
	LLFhBju0EZYn0pev5DISlqFBIxOA1h8IQa7WArU1jQWk1HqgBaq48wuT1d9tmCdztWV0Qm
	n+IhDjXRh8E8bzgKaLNms13xfk8QpnVpXSFgkpb8VqU0DQng7cseP0mlozSDjljQ5X7D9g
	Ki+3sLQGYiWYojZtxNNt+xY/ZEIdRSp2pwFjRbjyuqtOMJaAFJqb8DV7Ktj4DQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 16/47] libsemanage: cast to unsigned char for character checking functions
Date: Mon, 11 Nov 2024 15:16:35 +0100
Message-ID: <20241111141706.38039-16-cgoettsche@seltendoof.de>
In-Reply-To: <20241111141706.38039-1-cgoettsche@seltendoof.de>
References: <20241111141706.38039-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Character checking functions, like isspace(3), take an unsigned char as
input, and passing any other value is undefined behavior.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsemanage/src/conf-scan.l       |  4 ++--
 libsemanage/src/genhomedircon.c   |  4 ++--
 libsemanage/src/modules.c         |  8 ++++----
 libsemanage/src/parse_utils.c     | 10 +++++-----
 libsemanage/src/semanage_store.c  | 16 ++++++++--------
 libsemanage/src/users_base_file.c |  4 ++--
 6 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/libsemanage/src/conf-scan.l b/libsemanage/src/conf-scan.l
index b06a896c..bc0630b9 100644
--- a/libsemanage/src/conf-scan.l
+++ b/libsemanage/src/conf-scan.l
@@ -78,11 +78,11 @@ args              return PROG_ARGS;
  * Returns NULL on error. */
 static char *my_strdup(char *s) {
 	char *t;
-	while (isspace(*s)) {
+	while (isspace((unsigned char)*s)) {
 		s++;
 	}
 	t = s + strlen(s) - 1;
-	while (t >= s && isspace(*t)) {
+	while (t >= s && isspace((unsigned char)*t)) {
 		*t = '\0';
 		t--;
 	}
diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index 34b5ff93..31c9a5bf 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -543,14 +543,14 @@ static const char *extract_context(const char *line)
 	while (off > 0) {
 		p--;
 		off--;
-		if (!isspace(*p))
+		if (!isspace((unsigned char)*p))
 			break;
 	}
 	if (off == 0)
 		return NULL;
 
 	/* find the last field in line */
-	while (off > 0 && !isspace(*(p - 1))) {
+	while (off > 0 && !isspace((unsigned char)*(p - 1))) {
 		p--;
 		off--;
 	}
diff --git a/libsemanage/src/modules.c b/libsemanage/src/modules.c
index eeb85be6..e6a47362 100644
--- a/libsemanage/src/modules.c
+++ b/libsemanage/src/modules.c
@@ -819,12 +819,12 @@ int semanage_module_validate_name(const char * name)
 		goto exit;
 	}
 
-	if (!isalpha(*name)) {
+	if (!isalpha((unsigned char)*name)) {
 		status = -1;
 		goto exit;
 	}
 
-#define ISVALIDCHAR(c) (isalnum(c) || c == '_' || c == '-')
+#define ISVALIDCHAR(c) (isalnum((unsigned char)c) || c == '_' || c == '-')
 
 	for (name++; *name; name++) {
 		if (ISVALIDCHAR(*name)) {
@@ -876,12 +876,12 @@ int semanage_module_validate_lang_ext(const char *ext)
 		goto exit;
 	}
 
-	if (!isalnum(*ext)) {
+	if (!isalnum((unsigned char)*ext)) {
 		status = -1;
 		goto exit;
 	}
 
-#define ISVALIDCHAR(c) (isalnum(c) || c == '_' || c == '-')
+#define ISVALIDCHAR(c) (isalnum((unsigned char)c) || c == '_' || c == '-')
 
 	for (ext++; *ext; ext++) {
 		if (ISVALIDCHAR(*ext)) {
diff --git a/libsemanage/src/parse_utils.c b/libsemanage/src/parse_utils.c
index 13837c87..d9b12763 100644
--- a/libsemanage/src/parse_utils.c
+++ b/libsemanage/src/parse_utils.c
@@ -90,7 +90,7 @@ int parse_skip_space(semanage_handle_t * handle, parse_info_t * info)
 	char *ptr;
 
 	if (info->ptr) {
-		while (*(info->ptr) && isspace(*(info->ptr)))
+		while (*(info->ptr) && isspace((unsigned char)*(info->ptr)))
 			info->ptr++;
 
 		if (*(info->ptr))
@@ -109,7 +109,7 @@ int parse_skip_space(semanage_handle_t * handle, parse_info_t * info)
 			buffer[len - 1] = '\0';
 
 		ptr = buffer;
-		while (*ptr && isspace(*ptr))
+		while (*ptr && isspace((unsigned char)*ptr))
 			ptr++;
 
 		/* Skip comments and blank lines */
@@ -156,7 +156,7 @@ int parse_assert_space(semanage_handle_t * handle, parse_info_t * info)
 	if (parse_assert_noeof(handle, info) < 0)
 		return STATUS_ERR;
 
-	if (*(info->ptr) && !isspace(*(info->ptr))) {
+	if (*(info->ptr) && !isspace((unsigned char)*(info->ptr))) {
 		ERR(handle, "missing whitespace (%s: %u):\n%s",
 		    info->filename, info->lineno, info->orig_line);
 		return STATUS_ERR;
@@ -242,7 +242,7 @@ int parse_fetch_int(semanage_handle_t * handle,
 	if (parse_fetch_string(handle, info, &str, delim, 0) < 0)
 		goto err;
 
-	if (!isdigit((int)*str)) {
+	if (!isdigit((unsigned char)*str)) {
 		ERR(handle, "expected a numeric value: (%s: %u)\n%s",
 		    info->filename, info->lineno, info->orig_line);
 		goto err;
@@ -277,7 +277,7 @@ int parse_fetch_string(semanage_handle_t * handle,
 	if (parse_assert_noeof(handle, info) < 0)
 		goto err;
 
-	while (*(info->ptr) && (allow_spaces || !isspace(*(info->ptr))) &&
+	while (*(info->ptr) && (allow_spaces || !isspace((unsigned char)*(info->ptr))) &&
 	       (*(info->ptr) != delim)) {
 		info->ptr++;
 		len++;
diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index 0684b2e8..f5c19e00 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -1409,7 +1409,7 @@ static char **split_args(const char *arg0, char *arg_string,
 				break;
 			}
 		default:{
-				if (isspace(*s) && !in_quote && !in_dquote) {
+				if (isspace((unsigned char)*s) && !in_quote && !in_dquote) {
 					if (arg != NULL) {
 						rc = append_arg(&argv, &num_args, arg);
 						if (rc)
@@ -2598,7 +2598,7 @@ int semanage_fc_sort(semanage_handle_t * sh, const char *buf, size_t buf_len,
 
 		/* Skip the whitespace at the front of the line. */
 		for (i = 0; i < line_len; i++) {
-			if (!isspace(line_buf[i]))
+			if (!isspace((unsigned char)line_buf[i]))
 				break;
 		}
 
@@ -2630,7 +2630,7 @@ int semanage_fc_sort(semanage_handle_t * sh, const char *buf, size_t buf_len,
 		escape_chars = 0;
 		just_saw_escape = 0;
 		start = i;
-		while (i < line_len && (!isspace(line_buf[i]))) {
+		while (i < line_len && (!isspace((unsigned char)line_buf[i]))) {
 			if (line_buf[i] == '\\') {
 				if (!just_saw_escape) {
 					escape_chars++;
@@ -2666,7 +2666,7 @@ int semanage_fc_sort(semanage_handle_t * sh, const char *buf, size_t buf_len,
 
 		/* Skip the whitespace after the regular expression. */
 		for (; i < line_len; i++) {
-			if (!isspace(line_buf[i]))
+			if (!isspace((unsigned char)line_buf[i]))
 				break;
 		}
 		if (i == line_len) {
@@ -2703,7 +2703,7 @@ int semanage_fc_sort(semanage_handle_t * sh, const char *buf, size_t buf_len,
 
 			/* Skip the whitespace after the type. */
 			for (; i < line_len; i++) {
-				if (!isspace(line_buf[i]))
+				if (!isspace((unsigned char)line_buf[i]))
 					break;
 			}
 			if (i == line_len) {
@@ -2719,7 +2719,7 @@ int semanage_fc_sort(semanage_handle_t * sh, const char *buf, size_t buf_len,
 
 		/* Extract the context from the line. */
 		start = i;
-		while (i < line_len && (!isspace(line_buf[i])))
+		while (i < line_len && (!isspace((unsigned char)line_buf[i])))
 			i++;
 		finish = i;
 		context_len = finish - start;
@@ -2914,7 +2914,7 @@ int semanage_nc_sort(semanage_handle_t * sh, const char *buf, size_t buf_len,
 
 		/* Skip the whitespace at the front of the line. */
 		for (i = 0; i < line_len; i++) {
-			if (!isspace(line_buf[i]))
+			if (!isspace((unsigned char)line_buf[i]))
 				break;
 		}
 
@@ -2950,7 +2950,7 @@ int semanage_nc_sort(semanage_handle_t * sh, const char *buf, size_t buf_len,
 		}
 
 		/* skip over whitespace */
-		for (; offset < line_len && isspace(line_buf[offset]);
+		for (; offset < line_len && isspace((unsigned char)line_buf[offset]);
 		     offset++) ;
 
 		/* load rule into node */
diff --git a/libsemanage/src/users_base_file.c b/libsemanage/src/users_base_file.c
index 8fb00698..f4d15451 100644
--- a/libsemanage/src/users_base_file.c
+++ b/libsemanage/src/users_base_file.c
@@ -113,7 +113,7 @@ static int user_base_parse(semanage_handle_t * handle,
 		start = info->ptr;
 		while (*(info->ptr) &&
 		       *(info->ptr) != ';' &&
-		       *(info->ptr) != '}' && !isspace(*(info->ptr)))
+		       *(info->ptr) != '}' && !isspace((unsigned char)*(info->ptr)))
 			info->ptr++;
 
 		delim = *(info->ptr);
@@ -122,7 +122,7 @@ static int user_base_parse(semanage_handle_t * handle,
 		if (semanage_user_base_add_role(handle, user, start) < 0)
 			goto err;
 
-		if (delim && !isspace(delim)) {
+		if (delim && !isspace((unsigned char)delim)) {
 			if (islist && delim == '}')
 				break;
 			else if (!islist && delim == ';')
-- 
2.45.2

