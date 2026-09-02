Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CB4397E85
	for <selinux@vger.kernel.org>; Wed,  2 Sep 2026 14:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788357818; cv=none; b=qoVF02W6jSrjzt3gra8/zcCIRAq1REaSw6lzvZ+wXm+bAfUa4Kay+B47LrG81h9cc5Uq/qxK4kDFOl0WmtohauJJR508kG64palmpzrnqit4KpOPb252pDTu1tU6r82jOBWzAV127f+2oZI69VLT9XguQnJDiNW967OmnSxXPUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788357818; c=relaxed/simple;
	bh=sM1tyqZ0wncPcacgMo6jjo6NPeCdhFok2AqkTjHwCcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OOf+mZc6beQlIWyBFdqyfDjvtZxRikvWccw3JCQSVXl+lV+Pu8l2PTEckBauAFQO0SIxyMcrg8y0SXl/67g5VPNSe7f4wNzFrKREyQghnf6VTkCHOf6OjIhILWm0+jJ/S3+PPqzZNRjl/ID27zN1Vn1pQ32Z6vnz9W9XvtabGik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HYS7031A; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYS7031A"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-66c9995ca60so2569005d50.1
        for <selinux@vger.kernel.org>; Wed, 02 Sep 2026 07:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788357815; x=1788962615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vJEhaBU2J3lkOqiO43JJDI6TMTka0Tzv8SqK/hDfJ/w=;
        b=HYS7031Av8bkgydzVfB23gxUOEPizZtuLlPEpqUqRlqNnwD/FYDDnjc66vT6c2IcuO
         3UZIkSuL2QEvD/MSaqZEynQU5Qo/BTkU/2PHeiUnjmqd4u+5Y0A9hwjKFrCPJ6Sw3VA0
         ZOK6Aax50OM5nRgViYEK685TZaGkHROI3J5zzSsoqBaGfqJYKmsLR/45WDw3yD5PUehg
         9UuEssntkr5XF2wcBMO1zlp+3MBl2SmEGI4A7UcmFMW9QfzjeS7KZvKjijq4++TqwTu2
         feUcDW0pp1O5SdXwsYAFUvSLEBRTq+u46QTwQdfvGT4I50Tu5zdtfMvx1NwK9dy8GJ7T
         GTtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788357815; x=1788962615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vJEhaBU2J3lkOqiO43JJDI6TMTka0Tzv8SqK/hDfJ/w=;
        b=aSmQ+gkNHRw+GQpuWpofKpTdED45p450RSaPOtpyQ0FP/u+DuDiNOrc6k6A6iSuLEY
         PdYO75k7yZi7NZaW02HOoxEKyFQTSOJILiPZ3CXo5eS9oqHSrWJKpQZbbOwL7Zkes4dB
         VA3DldnPg1mB67pSQVX1O1wZlCOeMlE/Ih1QuX3BaEy0Hc5yvRDBt6BCV2C7UrQtNy2j
         KbPfp9thKhJHfN2/smVjFgvoBhl9Ucic8YhTPhq9JR0sDnDwuPMZIHVL+ryU1UY9IC0L
         Smweer6M4+zpbZNiKvgikkDDNaFHYfyWeatNsle2UrGr3lqecMGPyCLLUtuZ0LAR37Zt
         Hqxg==
X-Gm-Message-State: AFuF++nCCV+o2sEiLohutnk1TzOYYLAfa4m3ZpV3IdBKi3IWSJ7fF1Mo
	YMhKPmWwQyzEhde3jE8vw6cgxUGvHpeUjMYRtsiefB9UVMjh261WWa9kwMJaEQ==
X-Gm-Gg: AYBFou35SElIryvfi2f3JCoL6csLd8mKsiBicquIY+xPP54OVtT7mb39Wb924WJuvPw
	oGtMmWZqEhl4AeBpO2P4XvB0yUG1kitmnI/Dg94j9oFJ28QnUsDbfpJdc6wXFp6f8m5KxiO1woy
	Q5glUl2oDfnwwdZKtZczDAkVLT5soMGIJwcuYN2SdVwRkHqoKachz1x7K4yqCR4Mq9Utrc7uZcR
	N3m8mtNXdzkJyYEmd9XB+DEmsCKGsTHXQGmxQmoblNKNFEJtLH0sVDq7grWf1VxJO9+kwnKE2i3
	9F2zKirUW/8atwJFqMrc1nfHjJEOaX30RvloIcnTFdgX3twOPdD+c3BAu1/D36ibaDfjypP+1kp
	FP4j6gtlxJTf8e0dQBl4C9GfroluzWg3X4//k4E+TGkjb+LOwC7/WwGYS7IncWqdAjIV3FFEWrW
	k3J8joaJ5IXw59X7co/MsHAR5sfynmZjlrxe27cJYtcvwnlPYd7bMtSGwsTuCKcrw7rPiw5qWww
	QuZ4v7g2FnmekiK4YGEjvua0uVIv6oczaSCm9t9fEFT9t6EoFGVCuFKPEo5aDlRs4SdNOOUL6k=
X-Received: by 2002:a53:ed89:0:b0:66e:5bd7:7dec with SMTP id 956f58d0204a3-66f8a3c50f6mr3426711d50.3.1788357810772;
        Wed, 02 Sep 2026 07:03:30 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90e9ee316f7sm18790446d6.19.2026.09.02.07.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 07:03:30 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 2/9] libsemanage: add semanage_module_find_path() and use it for reads
Date: Wed,  2 Sep 2026 10:02:04 -0400
Message-ID: <20260902140211.53084-4-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902140211.53084-2-stephen.smalley.work@gmail.com>
References: <20260902140211.53084-2-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a semanage_module_find_path() helper which tries the writable
modules root (TMP in a transaction, ACTIVE otherwise) and then each
ro-store-root ACTIVE modules root, filling @path with the first
location that exists. If the file doesn't exist anywhere, leave the
writable-root path in @path so error messages refer to the write
target. semanage_module_get_path() itself is unchanged and remains the
write-side accessor.

Convert the read-side callers to use semanage_module_find_path().
With no ro-store-root configured this is a single extra access()
per call.

semanage_compile_module() may now read a HLL from a read-only root and
write the compiled CIL into the writable sandbox; guard the remove-hll
unlink so it only happens when the HLL actually lives in the sandbox.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsemanage/src/direct_api.c     | 53 ++++++++++++++++-----------
 libsemanage/src/modules.c        | 63 +++++++++++++++++++++++++++-----
 libsemanage/src/modules.h        | 10 +++++
 libsemanage/src/semanage_store.c |  6 +--
 4 files changed, 99 insertions(+), 33 deletions(-)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index 132e2a2a..ded6bb9e 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -998,8 +998,9 @@ static int semanage_compile_module(semanage_handle_t *sh,
 		goto cleanup;
 	}
 
-	status = semanage_module_get_path(sh, modinfo, SEMANAGE_MODULE_PATH_HLL,
-					  hll_path, sizeof(hll_path));
+	status = semanage_module_find_path(sh, modinfo,
+					   SEMANAGE_MODULE_PATH_HLL, hll_path,
+					   sizeof(hll_path));
 	if (status != 0) {
 		goto cleanup;
 	}
@@ -1050,15 +1051,25 @@ static int semanage_compile_module(semanage_handle_t *sh,
 	}
 
 	if (sh->conf->remove_hll) {
-		status = unlink(hll_path);
-		if (status != 0) {
-			ERR(sh, "Error while removing HLL file %s.", hll_path);
-			goto cleanup;
-		}
+		const char *rw = semanage_path(SEMANAGE_TMP, SEMANAGE_MODULES);
 
-		status = semanage_direct_write_langext(sh, "cil", modinfo);
-		if (status != 0) {
-			goto cleanup;
+		/*
+		 * Only remove a HLL that lives in the writable sandbox;
+		 * a ro-store-root vendor module keeps its HLL.
+		 */
+		if (strncmp(hll_path, rw, strlen(rw)) == 0) {
+			status = unlink(hll_path);
+			if (status != 0) {
+				ERR(sh, "Error while removing HLL file %s.",
+				    hll_path);
+				goto cleanup;
+			}
+
+			status = semanage_direct_write_langext(sh, "cil",
+							       modinfo);
+			if (status != 0) {
+				goto cleanup;
+			}
 		}
 	}
 
@@ -1118,9 +1129,9 @@ semanage_compile_hll_modules(semanage_handle_t *sh,
 	/* prefix with module count to avoid collisions */
 	update_checksum_with_len(&context, num_modinfos);
 	for (i = 0; i < num_modinfos; i++) {
-		status = semanage_module_get_path(sh, &modinfos[i],
-						  SEMANAGE_MODULE_PATH_CIL,
-						  cil_path, sizeof(cil_path));
+		status = semanage_module_find_path(sh, &modinfos[i],
+						   SEMANAGE_MODULE_PATH_CIL,
+						   cil_path, sizeof(cil_path));
 		if (status != 0)
 			return -1;
 
@@ -1932,10 +1943,10 @@ static int semanage_direct_extract(semanage_handle_t *sh,
 	struct file_contents contents = {};
 
 	/* get path of module */
-	rc = semanage_module_get_path(sh,
-				      (const semanage_module_info_t *)modkey,
-				      SEMANAGE_MODULE_PATH_NAME, module_path,
-				      sizeof(module_path));
+	rc = semanage_module_find_path(sh,
+				       (const semanage_module_info_t *)modkey,
+				       SEMANAGE_MODULE_PATH_NAME, module_path,
+				       sizeof(module_path));
 	if (rc != 0) {
 		goto cleanup;
 	}
@@ -1958,8 +1969,8 @@ static int semanage_direct_extract(semanage_handle_t *sh,
 	}
 
 	/* get path of what to extract */
-	rc = semanage_module_get_path(sh, _modinfo, file_type, input_file,
-				      sizeof(input_file));
+	rc = semanage_module_find_path(sh, _modinfo, file_type, input_file,
+				       sizeof(input_file));
 	if (rc != 0) {
 		goto cleanup;
 	}
@@ -2377,7 +2388,7 @@ static int semanage_direct_get_module_info(semanage_handle_t *sh,
 	}
 
 	/* lookup module ext */
-	ret = semanage_module_get_path(
+	ret = semanage_module_find_path(
 		sh, *modinfo, SEMANAGE_MODULE_PATH_LANG_EXT, fn, sizeof(fn));
 	if (ret != 0) {
 		status = -1;
@@ -2420,7 +2431,7 @@ static int semanage_direct_get_module_info(semanage_handle_t *sh,
 	fp = NULL;
 
 	/* lookup enabled/disabled status */
-	ret = semanage_module_get_path(
+	ret = semanage_module_find_path(
 		sh, *modinfo, SEMANAGE_MODULE_PATH_DISABLED, fn, sizeof(fn));
 	if (ret != 0) {
 		status = -1;
diff --git a/libsemanage/src/modules.c b/libsemanage/src/modules.c
index 55dfdd47..5e667b7d 100644
--- a/libsemanage/src/modules.c
+++ b/libsemanage/src/modules.c
@@ -408,10 +408,11 @@ int semanage_module_info_set_enabled(semanage_handle_t *sh,
 	return 0;
 }
 
-int semanage_module_get_path(semanage_handle_t *sh,
-			     const semanage_module_info_t *modinfo,
-			     enum semanage_module_path_type type, char *path,
-			     size_t len)
+static int semanage_module_build_path(semanage_handle_t *sh,
+				      const char *modules_path,
+				      const semanage_module_info_t *modinfo,
+				      enum semanage_module_path_type type,
+				      char *path, size_t len)
 {
 	assert(sh);
 	assert(modinfo);
@@ -420,13 +421,8 @@ int semanage_module_get_path(semanage_handle_t *sh,
 	int status = 0;
 	int ret = 0;
 
-	const char *modules_path = NULL;
 	const char *file = NULL;
 
-	modules_path = sh->is_in_transaction ?
-			       semanage_path(SEMANAGE_TMP, SEMANAGE_MODULES) :
-			       semanage_path(SEMANAGE_ACTIVE, SEMANAGE_MODULES);
-
 	switch (type) {
 	case SEMANAGE_MODULE_PATH_PRIORITY:
 		/* verify priority */
@@ -537,6 +533,55 @@ cleanup:
 	return status;
 }
 
+static const char *semanage_module_write_root(semanage_handle_t *sh)
+{
+	return sh->is_in_transaction ?
+		       semanage_path(SEMANAGE_TMP, SEMANAGE_MODULES) :
+		       semanage_path(SEMANAGE_ACTIVE, SEMANAGE_MODULES);
+}
+
+int semanage_module_get_path(semanage_handle_t *sh,
+			     const semanage_module_info_t *modinfo,
+			     enum semanage_module_path_type type, char *path,
+			     size_t len)
+{
+	return semanage_module_build_path(sh, semanage_module_write_root(sh),
+					  modinfo, type, path, len);
+}
+
+/*
+ * Read-side variant: search the writable modules root (TMP when in
+ * a transaction, ACTIVE otherwise) and then each ro-store-root's ACTIVE
+ * modules root, filling @path with the first location that exists.
+ * When the module exists nowhere, @path is left with the writable root
+ * value so the caller's error message names the write target.
+ */
+int semanage_module_find_path(semanage_handle_t *sh,
+			      const semanage_module_info_t *modinfo,
+			      enum semanage_module_path_type type, char *path,
+			      size_t len)
+{
+	unsigned int i, n = semanage_ro_root_count();
+	int ret;
+
+	ret = semanage_module_build_path(sh, semanage_module_write_root(sh),
+					 modinfo, type, path, len);
+	if (ret != 0 || n == 0 || access(path, F_OK) == 0)
+		return ret;
+
+	for (i = 0; i < n; i++) {
+		ret = semanage_module_build_path(
+			sh, semanage_ro_active_path(i, SEMANAGE_MODULES),
+			modinfo, type, path, len);
+		if (ret != 0 || access(path, F_OK) == 0)
+			return ret;
+	}
+
+	/* Not found anywhere; restore the writable-root path */
+	return semanage_module_build_path(sh, semanage_module_write_root(sh),
+					  modinfo, type, path, len);
+}
+
 int semanage_module_key_create(semanage_handle_t *sh,
 			       semanage_module_key_t **modkey)
 {
diff --git a/libsemanage/src/modules.h b/libsemanage/src/modules.h
index fdd771a4..22e6803e 100644
--- a/libsemanage/src/modules.h
+++ b/libsemanage/src/modules.h
@@ -100,6 +100,16 @@ int semanage_module_get_path(semanage_handle_t *sh,
 			     enum semanage_module_path_type type, char *path,
 			     size_t len);
 
+/*
+ * Read-side variant: fill @path with the first location that exists
+ * across the writable and any ro-store-root modules roots. Falls back
+ * to the writable-root path when the file is not found anywhere.
+ */
+int semanage_module_find_path(semanage_handle_t *sh,
+			      const semanage_module_info_t *modinfo,
+			      enum semanage_module_path_type type, char *path,
+			      size_t len);
+
 extern const size_t CHECKSUM_CONTENT_SIZE;
 void semanage_hash_to_checksum_string(const uint8_t *hash, char *checksum);
 
diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index 187fd6b6..a9b471a2 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -1195,9 +1195,9 @@ int semanage_get_cil_paths(semanage_handle_t *sh,
 	}
 
 	for (i = 0; i < num_modinfos; i++) {
-		ret = semanage_module_get_path(sh, &modinfos[i],
-					       SEMANAGE_MODULE_PATH_CIL, path,
-					       sizeof(path));
+		ret = semanage_module_find_path(sh, &modinfos[i],
+						SEMANAGE_MODULE_PATH_CIL, path,
+						sizeof(path));
 		if (ret != 0) {
 			status = -1;
 			goto cleanup;
-- 
2.55.0

