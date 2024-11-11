Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D571A08DC
	for <selinux@vger.kernel.org>; Mon, 11 Nov 2024 14:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731334646; cv=none; b=QsPB4PKNHk9XibUUKgNu1w09gLaCpBEAY+xgIdgZgjgh5Abm/yLufmUjLHa/4VD1SWmCRAnZA0D7lk+b1DyM6aQwXQy9QFmsCPykX+2SzXa4+Bs6Wwrwg4LuWxQb1PloAuRg3ztG20Zwm22apYqZ8aw8mQMHTCs1siASn0hbECk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731334646; c=relaxed/simple;
	bh=hQPS8/VRaTkf3QeNZYyCrah3TKJ3WCU7fjZsMUxRjCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fHo24mPcxvxS5fJkcE0IYhs5syPRLcWOQzB3nQFelLszCG70mXobEYvycNrLxxcQIACAwKfIQGM6YAG7rv7aiOEvAxteWRnqqjgc3VWpEy20Go7zpYe28tn8pzSSHODvi6TDlCH2ox2tbERoSWJFo0GYeQ9h8I2DEgiH6a9CSdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=ne7KxuTx; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="ne7KxuTx"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731334638;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jp5dLhtsqIDDx177LRXP2FSvQsHEoQY0e3nKm7F704U=;
	b=ne7KxuTxT/uuSmoCvypdt6zIDSPU/dDeaIs2PqHPuEO7JT7g4CYGuGkEzX2RZcb3+/MmBW
	tgQZ/v3DBrSQgvBlu1EvrRpbOlhlZsF0G6erVFoDkjVyVrB37wgwHZmDYd8hQerWaQG0Oi
	Z4B+HojnOMkcOki5HCVWZtUQmPEAb0OnxfCjGpPcaAkcwRygX+i5AGpUvucEu/pMgrgU/y
	LrV+Zu0C66K/pvMhdCA4CznlCDvBq1R+YTwqUq0vBeLlNP8TQiobot996xWVQBbIeyTtx+
	5tbvIGFwIxwJqsYcduwaab8Tkt6IvJooMuSFSGTKAYVC1egXD0taSS4HSljPrw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 32/47] libsemanage: use asprintf(3) to simplify code
Date: Mon, 11 Nov 2024 15:16:51 +0100
Message-ID: <20241111141706.38039-32-cgoettsche@seltendoof.de>
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

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsemanage/src/handle.c         | 26 ++--------
 libsemanage/src/semanage_store.c | 86 +++++++++-----------------------
 2 files changed, 28 insertions(+), 84 deletions(-)

diff --git a/libsemanage/src/handle.c b/libsemanage/src/handle.c
index 740bc83f..2f4121db 100644
--- a/libsemanage/src/handle.c
+++ b/libsemanage/src/handle.c
@@ -141,16 +141,14 @@ int semanage_get_hll_compiler_path(semanage_handle_t *sh,
 				const char *lang_ext,
 				char **compiler_path)
 {
-	assert(sh != NULL);
-	assert(lang_ext != NULL);
-
-	int i;
+	size_t i;
 	int status = 0;
-	int num_printed = 0;
-	size_t len;
 	char *compiler = NULL;
 	char *lower_lang_ext = NULL;
 
+	assert(sh != NULL);
+	assert(lang_ext != NULL);
+
 	lower_lang_ext = strdup(lang_ext);
 	if (lower_lang_ext == NULL) {
 		ERR(sh, "Could not create copy of lang_ext. Out of memory.\n");
@@ -162,17 +160,7 @@ int semanage_get_hll_compiler_path(semanage_handle_t *sh,
 		lower_lang_ext[i] = tolower(lower_lang_ext[i]);
 	}
 
-	len = strlen(sh->conf->compiler_directory_path) + strlen("/") + strlen(lower_lang_ext) + 1;
-
-	compiler = malloc(len * sizeof(*compiler));
-	if (compiler == NULL) {
-		ERR(sh, "Error allocating space for compiler path.");
-		status = -1;
-		goto cleanup;
-	}
-
-	num_printed = snprintf(compiler, len, "%s/%s", sh->conf->compiler_directory_path, lower_lang_ext);
-	if (num_printed < 0 || (size_t)num_printed >= len) {
+	if (asprintf(&compiler, "%s/%s", sh->conf->compiler_directory_path, lower_lang_ext) < 0) {
 		ERR(sh, "Error creating compiler path.");
 		status = -1;
 		goto cleanup;
@@ -183,10 +171,6 @@ int semanage_get_hll_compiler_path(semanage_handle_t *sh,
 
 cleanup:
 	free(lower_lang_ext);
-	if (status != 0) {
-		free(compiler);
-	}
-
 	return status;
 }
 
diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index 937089b2..98ef2524 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -165,21 +165,17 @@ typedef struct semanage_netfilter_context_node {
  */
 static int semanage_init_paths(const char *root)
 {
-	size_t len, prefix_len;
 	int i;
 
 	if (!root)
 		return -1;
 
-	prefix_len = strlen(root);
-
 	for (i = 0; i < SEMANAGE_NUM_FILES; i++) {
-		len = (strlen(semanage_relative_files[i]) + prefix_len);
-		semanage_files[i] = calloc(len + 1, sizeof(char));
-		if (!semanage_files[i])
+		if (asprintf(&semanage_files[i], "%s%s",
+			     root, semanage_relative_files[i]) < 0) {
+			semanage_files[i] = NULL;
 			return -1;
-		sprintf(semanage_files[i], "%s%s", root,
-			semanage_relative_files[i]);
+		}
 	}
 
 	return 0;
@@ -191,28 +187,20 @@ static int semanage_init_paths(const char *root)
 static int semanage_init_store_paths(const char *root)
 {
 	int i, j;
-	size_t len;
-	size_t prefix_len;
 
 	if (!root)
 		return -1;
 
-	prefix_len = strlen(root);
-
 	for (i = 0; i < SEMANAGE_NUM_STORES; i++) {
 		for (j = 0; j < SEMANAGE_STORE_NUM_PATHS; j++) {
-			len = prefix_len + strlen(semanage_store_paths[i])
-			    + strlen(semanage_sandbox_paths[j]);
-			semanage_paths[i][j] = calloc(len + 1, sizeof(char));
-			if (!semanage_paths[i][j])
-				goto cleanup;
-			sprintf(semanage_paths[i][j], "%s%s%s", root,
-				semanage_store_paths[i],
-				semanage_sandbox_paths[j]);
+			if (asprintf(&semanage_paths[i][j], "%s%s%s",
+				     root, semanage_store_paths[i], semanage_sandbox_paths[j]) < 0) {
+				semanage_paths[i][j] = NULL;
+				return -1;
+			}
 		}
 	}
 
-      cleanup:
 	return 0;
 }
 
@@ -222,48 +210,26 @@ static int semanage_init_final(semanage_handle_t *sh, const char *prefix)
 	assert(prefix);
 
 	int status = 0;
-	size_t len;
 	const char *store_path = sh->conf->store_path;
-	size_t store_len = strlen(store_path);
 
 	/* SEMANAGE_FINAL_TMP */
-	len = strlen(semanage_root()) +
-	      strlen(prefix) +
-	      strlen("/") +
-	      strlen(semanage_final_prefix[SEMANAGE_FINAL_TMP]) +
-	      store_len;
-	semanage_final[SEMANAGE_FINAL_TMP] = malloc(len + 1);
-	if (semanage_final[SEMANAGE_FINAL_TMP] == NULL) {
+	if (asprintf(&semanage_final[SEMANAGE_FINAL_TMP], "%s%s%s/%s",
+		     semanage_root(), prefix,
+		     semanage_final_prefix[SEMANAGE_FINAL_TMP], store_path) < 0) {
+		semanage_final[SEMANAGE_FINAL_TMP] = NULL;
 		status = -1;
 		goto cleanup;
 	}
 
-	sprintf(semanage_final[SEMANAGE_FINAL_TMP],
-		"%s%s%s/%s",
-		semanage_root(),
-		prefix,
-		semanage_final_prefix[SEMANAGE_FINAL_TMP],
-		store_path);
-
 	/* SEMANAGE_FINAL_SELINUX */
-	const char *selinux_root = selinux_path();
-	len = strlen(semanage_root()) +
-	      strlen(selinux_root) +
-	      strlen(semanage_final_prefix[SEMANAGE_FINAL_SELINUX]) +
-	      store_len;
-	semanage_final[SEMANAGE_FINAL_SELINUX] = malloc(len + 1);
-	if (semanage_final[SEMANAGE_FINAL_SELINUX] == NULL) {
+	if (asprintf(&semanage_final[SEMANAGE_FINAL_SELINUX], "%s%s%s%s",
+		     semanage_root(), selinux_path(),
+		     semanage_final_prefix[SEMANAGE_FINAL_SELINUX], store_path) < 0) {
+		semanage_final[SEMANAGE_FINAL_SELINUX] = NULL;
 		status = -1;
 		goto cleanup;
 	}
 
-	sprintf(semanage_final[SEMANAGE_FINAL_SELINUX],
-		"%s%s%s%s",
-		semanage_root(),
-		selinux_root,
-		semanage_final_prefix[SEMANAGE_FINAL_SELINUX],
-		store_path);
-
 cleanup:
 	if (status != 0) {
 		int i;
@@ -386,24 +352,18 @@ static int semanage_init_final_paths(semanage_handle_t *sh)
 {
 	int status = 0;
 	int i, j;
-	size_t len;
 
 	for (i = 0; i < SEMANAGE_FINAL_NUM; i++) {
 		for (j = 0; j < SEMANAGE_FINAL_PATH_NUM; j++) {
-			len = 	  strlen(semanage_final[i])
-				+ strlen(semanage_final_suffix[j]);
-
-			semanage_final_paths[i][j] = malloc(len + 1);
-			if (semanage_final_paths[i][j] == NULL) {
+			if (asprintf(&semanage_final_paths[i][j],
+				 "%s%s",
+				     semanage_final[i],
+				     semanage_final_suffix[j]) < 0) {
+				semanage_final_paths[i][j] = NULL;
 				ERR(sh, "Unable to allocate space for policy final path.");
 				status = -1;
 				goto cleanup;
-			}
-
-			sprintf(semanage_final_paths[i][j],
-				"%s%s",
-				semanage_final[i],
-				semanage_final_suffix[j]);
+				}
 		}
 	}
 
-- 
2.45.2

