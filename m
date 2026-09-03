Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926024BD0E3
	for <selinux@vger.kernel.org>; Thu,  3 Sep 2026 14:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788446582; cv=none; b=cEyvUosG28hEF7glvnAaw6kDtG1DonbEVZ02KzWbNSIuMeCZ0qvzA7Co/ggU6aSvVK4ana8KGyp9w/TqGHiLjCegzY64ax04GxPauMzUIBzOJIqzos35vNvAtiymxt5gTQ/u7wPl1b+CIFIJTfjb1mqtCMWQR2UQdQqQb40NmiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788446582; c=relaxed/simple;
	bh=sM1tyqZ0wncPcacgMo6jjo6NPeCdhFok2AqkTjHwCcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YbX7ihYMp58gnGcJk9rMlShhaEOm2E1gyicmDdnUIvexE9SfIHqhcrmdI6AxWHMKzadhPezAUuYGSTNbhCyp30B206PHRjCTB5ZgAeURssTX202zk0fYiHBaL9T+za/JXGVZLqHvBGeSoIyOm4WWkcK5/X9oK2k6McMS72AVexw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WHYTsFcz; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHYTsFcz"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5301a453186so20894571cf.2
        for <selinux@vger.kernel.org>; Thu, 03 Sep 2026 07:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788446574; x=1789051374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vJEhaBU2J3lkOqiO43JJDI6TMTka0Tzv8SqK/hDfJ/w=;
        b=WHYTsFczn4RyNQSVXTYekT8WKj/eJZ/ZDjOitZCXSccB09FBm+9j7f9+Eehg4mUK5g
         HHr1+QIuyEB5NBWFRh1TAr7OtfbuRm9jL4p4JLCObknU66gX+k6fHEAUqo+OmojwAcor
         dI75LbNHJ0KGsT/llqGhCPIF54PWI9m6Z8v9gx7Gup9gC0xg4Kbm7vyplxcEEkgzfeDq
         MqcdmaIPE8xlCI5qdeWjXo52hovLt89jek6cpDOJZh2upedCwfpaIXwvmMK+1xUGdkX0
         bcFzrmyg2pzgEiTGiWNoBn0uaRo+qLZ0p6RW1+GEwz9lGZyfEYr/2BNPOFUAzRcX7cou
         iFrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788446574; x=1789051374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vJEhaBU2J3lkOqiO43JJDI6TMTka0Tzv8SqK/hDfJ/w=;
        b=ffHFqID47FCqJX90m0CYrox53xw0FYKvJtrdyX0e7SKMeO+e7D9yScXYE4LyLhFLi0
         gTtPZmERQtD0nMxn2wMe5Kh7yTnaRDkUoSdQnQh+6zGfeouVyfdWwq50PzTcRTxiv/0g
         uMOmH5Ah71xQXgfTdWNEqr2T3hh8jnZ+Z1lI7YXfT5q9/VMsBH9dsHswEJLPewLXW3p/
         hOlsgSbgkBuJZ5llfVrXTFcqM0DuyHEHwTvjlEGbr7NgPzReH8u86Fv1xWtgB182KQTX
         FOXjINZNk3uYLiz6hYEhCdbVzvKiYygE66nwAmyni0616C4NpYIH/7pAgt9vC8OFqh/k
         DdYQ==
X-Gm-Message-State: AFuF++lRSxicZiYn4fm38A+1XnM0JKKwWboIN2bYPlEdQK06hQ6cCD5w
	sUC87IvN++9Z42TrDXlqogFzkrlp63YdNXO+22UQAYycj6BZIlWHaPbg0c03mA==
X-Gm-Gg: AYBFou1XE7VHWk4f1hzuEJpk1/TjflUa65pht8PTmP8A4eZs1D45aYuaCgg4OZH360X
	WDlaPCXr2lPQDumOBW55s7RnB+1tyHiJfm05InW/vxfeTkX03bTvtLdq2Re4CFOlk2UU3sbF6Pg
	x9zL1qsekYhMMhIE0wjPEY8tJ50h+WCKZ/hNMMgbcrz4WHLLwVz+JvJd3Q5l7Qr/tmYnzqj5gUl
	VArOmhqQuLeML8QQs6IBx/D2YmPDQYatDvpzt7sayGvqfG1XF3aZuM7AlWFbah4c4f3sDHKkKSk
	eIXeDqC5QCQZHfPF0ftqgnsWURlPy3kUsj/6YmHsitsax4eyjXfAj64tUAUpnY8LXMsmLZgWXJy
	Z+kvMFbjnQSzqvdnRcxE/+pP5NNTj8iV3qHjG8Y3iqmTjYMq0ggrCaCVgYqtMkXGWYORodz4Nzt
	J/lZTS7ljJ6gM6hsj79+Vh440e2bSsRx5xaUKzDw1gSDWU9mRtWFREhfCW7zhIL2cRRFODwkVtb
	g3KQyLW9ALTIpgvS/wgD0ineV2VrC047pLZJusB456w3Upy8w0PSvAtbzBJaAe2
X-Received: by 2002:ac8:5912:0:b0:517:78c7:d93a with SMTP id d75a77b69052e-53036bca8f2mr141551431cf.16.1788446574366;
        Thu, 03 Sep 2026 07:42:54 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53032ff0e44sm44115851cf.5.2026.09.03.07.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 07:42:54 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	cahu@suse.de,
	bigon@debian.org,
	russell@coker.com.au,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v4 2/9] libsemanage: add semanage_module_find_path() and use it for reads
Date: Thu,  3 Sep 2026 10:34:27 -0400
Message-ID: <20260903143433.19810-5-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903143433.19810-2-stephen.smalley.work@gmail.com>
References: <20260903143433.19810-2-stephen.smalley.work@gmail.com>
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

