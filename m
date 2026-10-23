Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792778697;
	b=bm+1/TfgUcmo0SvgPGXYP9UDFniaYYSfHVL//2SmYx6M/Raw/ZXz6uyjRc7laAgzYJ6N
	 xG7bCOq3ablfDxT9HgoMUE8wZzAUdFubDOyZF/DL+YSkPpEjnRb5URaJFGn46+Xt0YPuO
	 7Y2IklD1cGlasC6baQydlzU6I9p7cDOQAEgPKxU2HlOPkf2+MaoaY8nQJ3fdyXRSchnUR
	 UhUFU7ziGkwQunWnzGwQUICZpMIGF2veT4FOUWSPbUhSlTWnnrB9iH3WV8vaeVWYupr/H
	 lsGM/xAKBw4ER+/sRtSG10of4owmZgwjDnQVxrO8SuhMKrPm/vETUcvRCiMl18CuF3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792778697;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=hczqeyELO0Nbih1J589BwNyXvbwKIORz9PB+nxPhqmw=;
	b=CJxurzbxqTsqaUwnAYOqS0Z0SFM1DFBXqvv2JKHIJ6cHqpPXdwQPGtOJ0G7wCfu8fY58
	 pSt1Pa+Mns/p7C8fvMG9pl64JsdboHNWSkt7qQpRvUUs9jPj5GPhVnBHGVITSJiV4hJP2
	 HT6p7joaSHzb/rNntsSzHaYnotSzvnpCrMKjZJftiCWr5/iLZU+B006pWLUyD+K25ikrj
	 a0wSmb0JxvRZPmF/WJK6r7dNFCeNGQITILE9zzBfij01nRqZGTj5I8nSG/shOZzCRftOW
	 O4U9GCZGyqUXDc3jqvMYLLFzXp3YzBrKxwgEBKUpdS2CQlXxlSZbKf8bMeRuvtrdWcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Jk5S3J2c;
	arc=none smtp.remote-ip=209.85.160.175
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DCC606A32C
	for <selinux@vger.kernel.org>; Fri, 23 Oct 2026 18:04:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17DCC606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Jk5S3J2c
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-535179e995bso10926311cf.0
        for <selinux@vger.kernel.org>; Fri, 23 Oct 2026 11:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792778696; x=1793383496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hczqeyELO0Nbih1J589BwNyXvbwKIORz9PB+nxPhqmw=;
        b=Jk5S3J2c2z2++LC3AvsvAZBOuNiRHJQ1oCoDpyNWhEZXS0GELm4mzX9zCr1eGNmpq5
         FP6DpH0PlXiSM2xr4N/LNXWJ3fxGrh1Oa9K9G125qWBCMZtg9/ZdtsYPWGDWToD1M00F
         V0ezg8vdr/N0kKUjYa6mz8tRV8jXOb/Y6a54kkDYNaC1rPGT3Qbg2faotK3FLaZ3/VVt
         W1wKo5zLxdzQeR3YpXGQwlUSnC0wxcQv3JEEAhM1drT3DAOsw7M9ff3CTiX9Mbo3LxXZ
         7QfB+amo0mJCsWS66+5n5OedwEx4GuYa/OmtkNwiPrJQH86ozDjy+vIOthuHgNoOAqsp
         mcGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792778696; x=1793383496;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hczqeyELO0Nbih1J589BwNyXvbwKIORz9PB+nxPhqmw=;
        b=CN6ZUj6cZMnKAwYd4pPPjjlw6MC3X/M1pAkzSArArB3ZZHeLTwUMOM76ingp0AFp1j
         dQF6WepuoXxQMqQUzEpfnRTkh0JEbq9pF8KTQ5tMqvSvb6rRod0jLWOlPuGqrVnnO7kE
         hkSCXgPXtg/7V1rFAUQaXUyNW/HnlFjg0mrfJqhpKAlTd4XcIxHKS8woeDQhxUPReAu5
         YcndoRzDhOy/DnrGTH/i2nJT8ZAKjEVEq7G5DNthChwd3XKnAN4VN24YDMpQJLjjHJji
         Fus3RwpGd0EbkWwRZOLybnih7ww/2P5sL30YDC/ZgBC0ayeDk6NSuM3G1ewn5XQUh2+y
         4B0g==
X-Gm-Message-State: AFq9FYIaSrrRqAFcj/cg8HOF7ItJb0LByhZDvXohcqFz8vWhfEhQBBXU
	qJS+/GCCH1p4Y91qfGLA6Vadhqhitc2Gpk+Os8aJ8ShHi6j1UOW1if7F662LJCvA
X-Gm-Gg: AYBFou2YkeQNgJk9Hmz1z+ugcnvV2+upPEsj8FXFOVz2xFmTgJ5LxeA/8RV+k1Nnjo7
	WNMs3DMXAUceL7W74V89ymlPBRwgDEGbOPeI7fqE2iy+dmYB469oE4H9phlgp7kW1N1Lex19fEo
	/ZL/ckJnRb2s+b77cIKYGVq73JKSeCpwSnC0z5K/jvhlMfXN7jOC02LqAIkQuPw1SB1o3baoYd6
	QMEGjCD7Gca8Q0IZ1wL/Kh8SuqFXxzII+/iiJtseLJd7kz/ehEA4h9izNCICEih506mK/8wSoc/
	WZ5XImllHJMsWnsJm32hHFbR2U9X1EvnhVlift/nvhuTGUCu1+a8WGrnJsZYTDB+zqtsXh9VIPq
	xkAaTA+cRDqzMBz37olX0VqEr6RscJdN7c4ru+9ins78b9AhbvvZU2NBZ2kbLIP4AcP/VkJIuog
	ABaqP2kmHdG7PFxO9WVTtCRSs15pFKCOGWyCkSbW1pn3hMB4tI3Vl7P3hBwuWC14x2xKlXJWPEo
	mw4tHfodA1ithAgZjb8tDenhaqNCEKr6Q3k2luA5dGJXlK+dII7/0d87wRa6Fc+KGEoUCdkwx3t
	qtAAFVnwTVqtv/9Hb9B61CuKSbtFkQ0fCjhy0ANoK2404IcrarKTy1JKVDwWmip2p4QcrjUR5Gj
	+ZoyRQ/nH0cTlftZr/3TL3v3MpsJY3tupA56vYtiPg0Q=
X-Received: by 2002:a05:620a:4627:b0:93b:e6d3:3145 with SMTP id af79cd13be357-93f6f82e8b0mr565466785a.64.1792778695951;
        Fri, 23 Oct 2026 11:04:55 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94047811552sm78329485a.18.2026.10.23.11.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 11:04:55 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	jwcart2@gmail.com,
	cathy.hu@suse.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] libsemanage: preserve read-only store overrides
Date: Fri, 23 Oct 2026 14:04:42 -0400
Message-ID: <20261023180442.60362-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Keep per-file store fallback, but stop CIL lookup at an earlier HLL
source whose cache is missing. Create writable module directories
before compiling vendor-only HLL, refresh the extraction path after
compilation, and report enabled state from RO-aware module metadata.

RO HLL can change independently of a writable derived CIL cache.
Recompile externally sourced HLL when processing it for a build or CIL
extraction; retain normal caching for writable HLL.

Resolve store-backed file databases at cache time rather than pinning
the first active path at connect. Permit TMP fallbacks only for local
record files and invalidate cached views across transaction-state
changes.  Existing flush-on-modification provides file-level
copy-on-write, including an empty file that shadows vendor records
after deleting the last entry.  Use the same fallback when publishing
local file contexts.

For ACTIVE as well as TMP, stop fallback when checking the writable
path fails for a reason other than ENOENT, so errors are not hidden by
a read-only copy.

This prevents replacement HLL from silently using vendor CIL, stale
vendor-derived policy after rebuild, and loss of RO local overrides
during transactions. No public API or policy format change is needed.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsemanage/src/database_file.c  | 26 ++++++++++
 libsemanage/src/direct_api.c     | 85 +++++++++++++++++++++-----------
 libsemanage/src/modules.c        | 29 +++++++----
 libsemanage/src/semanage_store.c | 28 +++++++++--
 4 files changed, 125 insertions(+), 43 deletions(-)

diff --git a/libsemanage/src/database_file.c b/libsemanage/src/database_file.c
index 1fdaf1cc..b57bbb2c 100644
--- a/libsemanage/src/database_file.c
+++ b/libsemanage/src/database_file.c
@@ -32,6 +32,9 @@ struct dbase_file {
 	/* Backing path for read-only[0] and transaction[1] */
 	const char *path[2];
 
+	int store_file;
+	int cache_in_transaction;
+
 	/* FILE extension */
 	const record_file_table_t *rftable;
 };
@@ -47,6 +50,12 @@ static int dbase_file_cache(semanage_handle_t *handle, dbase_file_t *dbase)
 	parse_info_t *parse_info = NULL;
 	const char *fname = NULL;
 
+	/* A transaction changes the source even when the serial is unchanged. */
+	if (dbase->store_file >= 0 &&
+	    dbase->cache_in_transaction != handle->is_in_transaction)
+		dbase_llist_drop_cache(&dbase->llist);
+	dbase->cache_in_transaction = handle->is_in_transaction;
+
 	/* Already cached */
 	if (!dbase_llist_needs_resync(handle, &dbase->llist))
 		return STATUS_SUCCESS;
@@ -57,6 +66,11 @@ static int dbase_file_cache(semanage_handle_t *handle, dbase_file_t *dbase)
 		goto err;
 
 	fname = dbase->path[handle->is_in_transaction];
+	if (dbase->store_file >= 0)
+		fname = semanage_path_read(handle->is_in_transaction ?
+						   SEMANAGE_TMP :
+						   SEMANAGE_ACTIVE,
+					   dbase->store_file);
 
 	if (parse_init(handle, fname, NULL, &parse_info) < 0)
 		goto err;
@@ -168,6 +182,18 @@ int dbase_file_init(semanage_handle_t *handle, const char *path_ro,
 
 	tmp_dbase->path[0] = path_ro;
 	tmp_dbase->path[1] = path_rw;
+	tmp_dbase->store_file = -1;
+	tmp_dbase->cache_in_transaction = handle->is_in_transaction;
+	if (semanage_ro_root_count() > 0) {
+		int i;
+
+		for (i = 0; i < SEMANAGE_STORE_NUM_PATHS; i++) {
+			if (!strcmp(path_rw, semanage_path(SEMANAGE_TMP, i))) {
+				tmp_dbase->store_file = i;
+				break;
+			}
+		}
+	}
 	tmp_dbase->rftable = rftable;
 	dbase_llist_init(&tmp_dbase->llist, rtable, &SEMANAGE_FILE_DTABLE);
 
diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index 90a5f7f0..05c9392c 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -1000,6 +1000,7 @@ static int semanage_compile_module(semanage_handle_t *sh,
 {
 	char cil_path[PATH_MAX];
 	char hll_path[PATH_MAX];
+	char module_path[PATH_MAX];
 	char *compiler_path = NULL;
 	char *cil_data = NULL;
 	char *err_data = NULL;
@@ -1072,6 +1073,16 @@ static int semanage_compile_module(semanage_handle_t *sh,
 		Sha256Update(context, cil_data, cil_data_len);
 	}
 
+	/* Vendor-only modules have no writable directory for their CIL cache. */
+	status = semanage_module_get_path(sh, modinfo,
+					  SEMANAGE_MODULE_PATH_NAME,
+					  module_path, sizeof(module_path));
+	if (status != 0)
+		goto cleanup;
+	status = semanage_mkpath(sh, module_path);
+	if (status != 0)
+		goto cleanup;
+
 	status = write_compressed_file(sh, cil_path, cil_data, cil_data_len);
 	if (status == -1) {
 		ERR(sh, "Failed to write %s.", cil_path);
@@ -1125,6 +1136,23 @@ struct extra_checksum_params {
 	int policyvers;
 };
 
+static int semanage_module_external_hll(semanage_handle_t *sh,
+					const semanage_module_info_t *modinfo)
+{
+	char source[PATH_MAX], writable[PATH_MAX];
+
+	if (!strcasecmp(modinfo->lang_ext, "cil") || !semanage_ro_root_count())
+		return 0;
+
+	if (semanage_module_find_path(sh, modinfo, SEMANAGE_MODULE_PATH_HLL,
+				      source, sizeof(source)) != 0 ||
+	    semanage_module_get_path(sh, modinfo, SEMANAGE_MODULE_PATH_HLL,
+				     writable, sizeof(writable)) != 0)
+		return -1;
+
+	return strcmp(source, writable) != 0;
+}
+
 static int
 semanage_compile_hll_modules(semanage_handle_t *sh,
 			     semanage_module_info_t *modinfos, int num_modinfos,
@@ -1157,13 +1185,20 @@ semanage_compile_hll_modules(semanage_handle_t *sh,
 	/* prefix with module count to avoid collisions */
 	update_checksum_with_len(&context, num_modinfos);
 	for (i = 0; i < num_modinfos; i++) {
+		int external_hll =
+			semanage_module_external_hll(sh, &modinfos[i]);
+
+		if (external_hll < 0)
+			return -1;
+
 		status = semanage_module_find_path(sh, &modinfos[i],
 						   SEMANAGE_MODULE_PATH_CIL,
 						   cil_path, sizeof(cil_path));
 		if (status != 0)
 			return -1;
 
-		if (!semanage_get_ignore_module_cache(sh)) {
+		/* RO sources can change independently of the writable CIL cache. */
+		if (!external_hll && !semanage_get_ignore_module_cache(sh)) {
 			status = stat(cil_path, &sb);
 			if (status == 0) {
 				status = map_compressed_file(sh, cil_path,
@@ -1717,14 +1752,16 @@ static int semanage_direct_commit(semanage_handle_t *sh)
 	if (sh->conf->sort_local_fcontexts) {
 		retval = semanage_sort_fc_file(
 			sh,
-			semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_FC_LOCAL),
+			semanage_path_read(SEMANAGE_TMP,
+					   SEMANAGE_STORE_FC_LOCAL),
 			semanage_final_path(SEMANAGE_FINAL_TMP,
 					    SEMANAGE_FC_LOCAL),
 			sh->conf->file_mode);
 	} else {
 		retval = copy_file_if_exists(
 			sh,
-			semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_FC_LOCAL),
+			semanage_path_read(SEMANAGE_TMP,
+					   SEMANAGE_STORE_FC_LOCAL),
 			semanage_final_path(SEMANAGE_FINAL_TMP,
 					    SEMANAGE_FC_LOCAL),
 			sh->conf->file_mode);
@@ -2014,17 +2051,25 @@ static int semanage_direct_extract(semanage_handle_t *sh,
 		goto cleanup;
 	}
 
-	if (extract_cil == 1 && strcmp(_modinfo->lang_ext, "cil") &&
-	    stat(input_file, &sb) != 0) {
-		if (errno != ENOENT) {
+	if (extract_cil == 1 && strcmp(_modinfo->lang_ext, "cil")) {
+		int external_hll = semanage_module_external_hll(sh, _modinfo);
+		int missing = (stat(input_file, &sb) != 0);
+
+		if (external_hll < 0 || (missing && errno != ENOENT)) {
 			ERR(sh, "Unable to access %s.", input_file);
 			rc = -1;
 			goto cleanup;
 		}
 
-		rc = semanage_compile_module(sh, _modinfo, NULL);
-		if (rc < 0) {
-			goto cleanup;
+		if (external_hll || missing) {
+			rc = semanage_compile_module(sh, _modinfo, NULL);
+			if (rc < 0)
+				goto cleanup;
+			rc = semanage_module_get_path(sh, _modinfo, file_type,
+						      input_file,
+						      sizeof(input_file));
+			if (rc != 0)
+				goto cleanup;
 		}
 	}
 
@@ -2148,8 +2193,6 @@ static int semanage_direct_get_enabled(semanage_handle_t *sh,
 	int status = 0;
 	int ret = 0;
 
-	char path[PATH_MAX];
-	struct stat sb;
 	semanage_module_info_t *modinfo = NULL;
 
 	/* get module info */
@@ -2159,25 +2202,7 @@ static int semanage_direct_get_enabled(semanage_handle_t *sh,
 		goto cleanup;
 	}
 
-	/* get disabled file path */
-	ret = semanage_module_get_path(
-		sh, modinfo, SEMANAGE_MODULE_PATH_DISABLED, path, sizeof(path));
-	if (ret != 0) {
-		status = -1;
-		goto cleanup;
-	}
-
-	if (stat(path, &sb) < 0) {
-		if (errno != ENOENT) {
-			ERR(sh, "Unable to access %s.", path);
-			status = -1;
-			goto cleanup;
-		}
-
-		*enabled = 1;
-	} else {
-		*enabled = 0;
-	}
+	*enabled = modinfo->enabled;
 
 cleanup:
 	semanage_module_info_destroy(sh, modinfo);
diff --git a/libsemanage/src/modules.c b/libsemanage/src/modules.c
index 5e667b7d..38096df5 100644
--- a/libsemanage/src/modules.c
+++ b/libsemanage/src/modules.c
@@ -555,6 +555,8 @@ int semanage_module_get_path(semanage_handle_t *sh,
  * modules root, filling @path with the first location that exists.
  * When the module exists nowhere, @path is left with the writable root
  * value so the caller's error message names the write target.
+ * A missing CIL cache beside an HLL source must be rebuilt, not replaced
+ * by a lower root's cache for a different source module.
  */
 int semanage_module_find_path(semanage_handle_t *sh,
 			      const semanage_module_info_t *modinfo,
@@ -562,19 +564,28 @@ int semanage_module_find_path(semanage_handle_t *sh,
 			      size_t len)
 {
 	unsigned int i, n = semanage_ro_root_count();
+	const char *root;
+	char hll_path[PATH_MAX];
 	int ret;
 
-	ret = semanage_module_build_path(sh, semanage_module_write_root(sh),
-					 modinfo, type, path, len);
-	if (ret != 0 || n == 0 || access(path, F_OK) == 0)
-		return ret;
-
-	for (i = 0; i < n; i++) {
-		ret = semanage_module_build_path(
-			sh, semanage_ro_active_path(i, SEMANAGE_MODULES),
-			modinfo, type, path, len);
+	for (i = 0;; i++) {
+		root = (i == 0) ?
+			       semanage_module_write_root(sh) :
+			       semanage_ro_active_path(i - 1, SEMANAGE_MODULES);
+		ret = semanage_module_build_path(sh, root, modinfo, type, path,
+						 len);
 		if (ret != 0 || access(path, F_OK) == 0)
 			return ret;
+
+		if (type == SEMANAGE_MODULE_PATH_CIL) {
+			ret = semanage_module_build_path(
+				sh, root, modinfo, SEMANAGE_MODULE_PATH_HLL,
+				hll_path, sizeof(hll_path));
+			if (ret != 0 || access(hll_path, F_OK) == 0)
+				return ret;
+		}
+		if (i == n)
+			break;
 	}
 
 	/* Not found anywhere; restore the writable-root path */
diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index 89e7456f..d904e698 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -502,9 +502,10 @@ const char *semanage_ro_active_path(unsigned int idx,
 
 /*
  * First-existing of the writable ACTIVE path and each RO ACTIVE path,
- * for read-side lookups. For TMP/PREVIOUS, or when no fallback root
- * has the file, this is semanage_path(store, file) so callers that
- * then create the file use the writable store.
+ * for read-side lookups. TMP also falls back for local record files;
+ * generated policy files and PREVIOUS never fall back. An existing empty
+ * writable file shadows the read-only file, including after deleting
+ * the last local record.
  */
 const char *semanage_path_read(enum semanage_store_defs store,
 			       enum semanage_sandbox_defs file)
@@ -512,7 +513,26 @@ const char *semanage_path_read(enum semanage_store_defs store,
 	const char *path = semanage_path(store, file);
 	unsigned int i;
 
-	if (store != SEMANAGE_ACTIVE || access(path, F_OK) == 0)
+	if (store == SEMANAGE_TMP) {
+		switch (file) {
+		case SEMANAGE_IBPKEYS_LOCAL:
+		case SEMANAGE_IBENDPORTS_LOCAL:
+		case SEMANAGE_PORTS_LOCAL:
+		case SEMANAGE_INTERFACES_LOCAL:
+		case SEMANAGE_NODES_LOCAL:
+		case SEMANAGE_BOOLEANS_LOCAL:
+		case SEMANAGE_SEUSERS_LOCAL:
+		case SEMANAGE_USERS_BASE_LOCAL:
+		case SEMANAGE_USERS_EXTRA_LOCAL:
+		case SEMANAGE_STORE_FC_LOCAL:
+			break;
+		default:
+			return path;
+		}
+	} else if (store != SEMANAGE_ACTIVE)
+		return path;
+
+	if (access(path, F_OK) == 0 || errno != ENOENT)
 		return path;
 
 	for (i = 0; i < semanage_n_ro_roots; i++) {
-- 
2.56.0

