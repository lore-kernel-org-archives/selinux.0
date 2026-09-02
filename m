Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17084A49B8
	for <selinux@vger.kernel.org>; Wed,  2 Sep 2026 15:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788362120; cv=none; b=cqvaCLswlXVe/fgUEy4fRzZyULtoa7S41g1gjLh6vhHJxRDwuKgTZwG7j2gLCJeu8Okyx63dG1vZuGYBPWDBJX4YJmhJJaLglUO/aoJdexEfZFO/xIvaR3j3TTK8khnaO0KfGZ0c1DbJ91ieZpsHSm/XXVdwoiyOvRafbKvGq80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788362120; c=relaxed/simple;
	bh=sM1tyqZ0wncPcacgMo6jjo6NPeCdhFok2AqkTjHwCcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wd/+RANl1zG8TWLZSHaBf8p13hc+an+ZZvhw8dcEyYEy6a2PJBvyNT6RfbpKty25v1eipT2RDUK1rHhRdPslCgYazlxPJarDvtd7uAgnxe/MpogxefquaAnYnhJLPfsULAyZxS+kq66os6sbMIfoN741SPuaHjklP7BhHF2faWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ye0DFNfX; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ye0DFNfX"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-93905b1dc65so105717785a.1
        for <selinux@vger.kernel.org>; Wed, 02 Sep 2026 08:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788362117; x=1788966917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vJEhaBU2J3lkOqiO43JJDI6TMTka0Tzv8SqK/hDfJ/w=;
        b=Ye0DFNfXL6Se5HJFPJrLkcPSY2wIOWJU0Gxv8YQNk3HM8mRRoedrQfUS2za65U4+Sb
         SmD5Ji1V0nbM0TxFqNFnDP1QAz4wW4i/QvCcK6QBWgY+AiC+bu2YFOL8+Xl/gtrUWLHI
         gPCS1U1FikrTi2qz76gpumyTAKsvHe1gQSNuKoPMAifWxFIDmo/xsECosvTRqXv+EnMC
         l9IvlN2BpPDaX2m34Y/NOoYJjLK0qE99ZUEHjTLOYNiv8RwVAJ1hdxAfQFIFLFhEhXF/
         tepyvIiMAb2MoLPKTDuEb8MBEm2nu6JegiUksd1ymkTE2h6GLrwWqC8tnIz/7wMgOoNV
         BqbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788362117; x=1788966917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vJEhaBU2J3lkOqiO43JJDI6TMTka0Tzv8SqK/hDfJ/w=;
        b=WWzU94mmTgflRo6rQlsthP2mpPgDCJzt1+eL+31KnS2r1BKy51CrFF4MOX9AXtkjza
         Gj8XRz0yjmUeoOxCKkhil+JgdvekBLcuZHbrXOOMOXRO0mxKXznAOx21PcJko/+B5NYe
         POTZ3JdrBMGi2d68i11buxEOI3OtIIrRtVlwX4EAHiUClvhz1n1S+cf7t6aMI13WLI0r
         TQY/UoZ/2LcZYjVzianDB+zsxMuHo+8B++IeZ1iZIipPd+QvrUkCI3CmkRn7J6KBMiJx
         +esj0mTT80WyAffUwyGY+5/xc3HPcoo/TAwWqC17Cdcig30ZDjTANMFM0xzeeIKKscdI
         ydrw==
X-Gm-Message-State: AFuF++lh393YApzioSGNjlbnpKH0WcbzjHj6gdyRVSCVEcfzaSdLL9NY
	0hjLrqlsD3OsI4FTBG+uBWqHO1U5r7u2qanl3GbU8MCdbawD090zmc8Y6w5zHw==
X-Gm-Gg: AR+sD12sGwxbnWctaVxLzMwvefrKh0g8zB3sm6/kji0MWvGzE9Y0FT/Qk0U8JMW2dU9
	futKRuQ/I8D/P28HfVUdcKFSyu3b1qI6Y9JoQrCBHEJifUzM7atliTwerCDnswvwUQ4Tv8Byje8
	M9ebkd3NT+4WNymxHyxnjm06pJWAnetAWIDJ/uXYtScN78D8VVh+HhRcW/PZcEEcsoGFlKp/t4m
	O74ZCIft9v55s6EsXoE0olQmZyp4yNPdch1+gnqvd5KP6uHjFfv5e7ULAmVAOMcN5q8o6EcfZE0
	cIHaaBlMd7H+bJvlm71FowTONPcv4fXfsQnHy9u3RlwPMWFpOzeW9cJzXx//Da8rNKbzGoJE8Yj
	2k3e4703LOCJAwl+VmKqyn/rGAaX+hr8VsZfHjA5AitoNZvC+1TJOt+xyS6v2Ouy4721fhWDXcG
	lGyv2/TckW/0ubKyA0wTvJq9GIpuFjxSFW7TI2zxc0bsnFLFR8pxF23LUvwFmsE9ufNeoAGJFF/
	vlBjq3fZtVq7VXDpWbAAnz+jrm5NsxEPx83rnyjnKgYe/jQi8LrJCdsMpvkC8RI
X-Received: by 2002:a05:620a:b1c:b0:937:80a9:94b4 with SMTP id af79cd13be357-93960cb9449mr594040185a.2.1788362117321;
        Wed, 02 Sep 2026 08:15:17 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9395f17eefdsm229299885a.11.2026.09.02.08.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 08:15:17 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 2/9] libsemanage: add semanage_module_find_path() and use it for reads
Date: Wed,  2 Sep 2026 11:13:59 -0400
Message-ID: <20260902151406.54168-4-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902151406.54168-2-stephen.smalley.work@gmail.com>
References: <20260902151406.54168-2-stephen.smalley.work@gmail.com>
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

