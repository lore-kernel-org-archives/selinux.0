Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAF41A072A
	for <selinux@vger.kernel.org>; Mon, 11 Nov 2024 14:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731334645; cv=none; b=RnLoTHVbT8XkZCQRQ1fyQv3bBHb3+xCvDtaa2IgZRu/6Oq9Mu4sPPmcGLif2UyzS9Qqjbb2+dztQpFKudAb/JUVhTjmO2Qn//Vxe8f7/6+FBLy3Nf5YpfT5bxYJm++IzWZljc8ioGvefUch4UyE9x8wGwCw/4yeucjSr/AUqbQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731334645; c=relaxed/simple;
	bh=jixhs1z319aSFFVMRNS4eQTvnnAaGXnVa9fExrT/Z+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uhAbsDjY84KSoHsq39tKZTCvttHeBq5beU9UNpsnBDu+U0iDkNP72vtUYdk26fUeyvXdj6b26HrIl17LQudDAx3wk+UbrUewThtp6v8YdvZDC3YlMY1dzvdWVhzi/BvZ88EnkeATsR7eV8dMSXlxTjXObNS9/k8VRHVM+uhRI0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=AiU1L4Nu; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="AiU1L4Nu"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731334638;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g4k3U6c/LIu11hCwplrBAAoRyBkhG09e0AAaUJ7G5D4=;
	b=AiU1L4Nu7v6WqlmwC+l1sTxVZJNcaXSrSM18GHtL8Q6bOWwOCvtJE6K0tS3JG4RDWa3pD3
	ICkwDQW3PYlK3Xt3BSSZtHvus2Qj9noL/aHP4a1aRs+8nN2XUg4QNY7z6YgR9Am/+OtDC7
	pcasliTUJNueHDPtefEKZJAB8aKUJ+7qHiT0b8xWgmE0LO8sP+lMpr0KZGGA2BJrJ1EOdw
	LLM7zVZZWcqZv9sdLQbB915lzB6dSfOLxFTChI4y+MZfKEdY/Xl4uvuQ+iD22L1TO+Ksmp
	B+zvBpFTgw+g3OoXxMmQY4zY1/QCrGOa1bkuRY08nTbX5J4qtWo40kAAMp5awA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 31/47] libsemanage: adjust sizes to avoid implicit truncations
Date: Mon, 11 Nov 2024 15:16:50 +0100
Message-ID: <20241111141706.38039-31-cgoettsche@seltendoof.de>
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

Use size_t for sizes and align miscellaneous type mismatches.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsemanage/src/compressed_file.c |  2 +-
 libsemanage/src/handle.c          |  2 +-
 libsemanage/src/parse_utils.c     |  4 ++--
 libsemanage/src/semanage_store.c  | 12 ++++++------
 libsemanage/src/utilities.c       |  6 +++---
 libsemanage/src/utilities.h       |  2 +-
 6 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/libsemanage/src/compressed_file.c b/libsemanage/src/compressed_file.c
index 74185c92..e4a1efb0 100644
--- a/libsemanage/src/compressed_file.c
+++ b/libsemanage/src/compressed_file.c
@@ -104,7 +104,7 @@ static ssize_t bunzip(semanage_handle_t *sh, FILE *f, void **data)
 	size_t   total = 0;
 	uint8_t* uncompress = NULL;
 	uint8_t* tmpalloc = NULL;
-	int      ret = -1;
+	ssize_t  ret = -1;
 
 	buf = malloc(bufsize);
 	if (buf == NULL) {
diff --git a/libsemanage/src/handle.c b/libsemanage/src/handle.c
index 4577ac35..740bc83f 100644
--- a/libsemanage/src/handle.c
+++ b/libsemanage/src/handle.c
@@ -172,7 +172,7 @@ int semanage_get_hll_compiler_path(semanage_handle_t *sh,
 	}
 
 	num_printed = snprintf(compiler, len, "%s/%s", sh->conf->compiler_directory_path, lower_lang_ext);
-	if (num_printed < 0 || (int)num_printed >= (int)len) {
+	if (num_printed < 0 || (size_t)num_printed >= len) {
 		ERR(sh, "Error creating compiler path.");
 		status = -1;
 		goto cleanup;
diff --git a/libsemanage/src/parse_utils.c b/libsemanage/src/parse_utils.c
index d57e59c9..d1d6e930 100644
--- a/libsemanage/src/parse_utils.c
+++ b/libsemanage/src/parse_utils.c
@@ -85,7 +85,7 @@ int parse_skip_space(semanage_handle_t * handle, parse_info_t * info)
 
 	size_t buf_len = 0;
 	ssize_t len;
-	int lineno = info->lineno;
+	unsigned int lineno = info->lineno;
 	char *buffer = NULL;
 	char *ptr;
 
@@ -271,7 +271,7 @@ int parse_fetch_string(semanage_handle_t * handle,
 {
 
 	const char *start = info->ptr;
-	int len = 0;
+	size_t len = 0;
 	char *tmp_str = NULL;
 
 	if (parse_assert_noeof(handle, info) < 0)
diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index 427952a1..937089b2 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -137,10 +137,10 @@ typedef struct semanage_file_context_node {
 	char *path;
 	char *file_type;
 	char *context;
-	int path_len;
-	int effective_len;
-	int type_len;
-	int context_len;
+	size_t path_len;
+	size_t effective_len;
+	size_t type_len;
+	size_t context_len;
 	int meta;		/* position of first meta char in path, -1 if none */
 	struct semanage_file_context_node *next;
 } semanage_file_context_node_t;
@@ -514,7 +514,7 @@ const char *semanage_final_path(enum semanage_final_defs store,
 char *semanage_conf_path(void)
 {
 	char *semanage_conf = NULL;
-	int len;
+	size_t len;
 	struct stat sb;
 
 	len = strlen(semanage_root()) + strlen(selinux_path()) + strlen(SEMANAGE_CONF_FILE);
@@ -2895,7 +2895,7 @@ int semanage_nc_sort(semanage_handle_t * sh, const char *buf, size_t buf_len,
 
 	/* parsing bits */
 	const char *priority_names[] = NC_SORT_NAMES;
-	const int priority_names_len[] = NC_SORT_NAMES_LEN;
+	const size_t priority_names_len[] = NC_SORT_NAMES_LEN;
 	size_t line_len, buf_remainder, i, offset;
 	const char *line_buf, *line_end;
 
diff --git a/libsemanage/src/utilities.c b/libsemanage/src/utilities.c
index a64015f8..38ac72e4 100644
--- a/libsemanage/src/utilities.c
+++ b/libsemanage/src/utilities.c
@@ -202,9 +202,9 @@ int semanage_cmp_plist_t(const void *x, const void *y)
 	return strcmp((*l1)->data, (*l2)->data);
 }
 
-int semanage_str_count(const char *data, char what)
+size_t semanage_str_count(const char *data, char what)
 {
-	int count = 0;
+	size_t count = 0;
 
 	if (!data)
 		return 0;
@@ -219,7 +219,7 @@ int semanage_str_count(const char *data, char what)
 
 void semanage_rtrim(char *str, char trim_to)
 {
-	int len = 0;
+	size_t len;
 
 	if (!str)
 		return;
diff --git a/libsemanage/src/utilities.h b/libsemanage/src/utilities.h
index 4cc41f84..c2d484a7 100644
--- a/libsemanage/src/utilities.h
+++ b/libsemanage/src/utilities.h
@@ -104,7 +104,7 @@ int semanage_cmp_plist_t(const void *x, const void *y);
  * @param      what  a character
  * @returns    the number of times the char appears in the string
  */
-int semanage_str_count(const char *data, char what);
+size_t semanage_str_count(const char *data, char what);
 /**
  * @param      - a string
  * @param            the character to trim to
-- 
2.45.2

