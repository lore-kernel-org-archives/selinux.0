Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BB147D474
	for <selinux@vger.kernel.org>; Wed,  2 Sep 2026 14:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788357814; cv=none; b=roc+GI7OOOBWrNmVquozGqOwr2hX2TL3v/cAAA7ATRWYxYX7JJ5w2Yzx+Bmo01EL9/PezphQ2uCcSdQcGTZEKmQ8M12cJEclOM3vtEmf1rw2TDLAIbtiyTfU40qQCUdkfrwSB8puUtgYNHoM1U0/gTpcjYUBIIrcv/RzD1v8diM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788357814; c=relaxed/simple;
	bh=5VUqqG7FzJiP60HZ8r/Ioo2Li8VvQEZTV2alJSgBaTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QW2OdneGI6q308jIp20RgyMtc6iSW0eGarY/YVfPDnKE3lX1T2jRqILwAdtNTivmOQJ7A0g/U+wxY3vqid7F+YxG0csrY1RKPi/st6p8yWlQbZ0AWVfP3YlKhg0Mon6dg/Lst/MaGLnqxNruu3H6EXeOCb1vbOKXRHae4XgM6Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lA8OMrtz; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lA8OMrtz"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-90cbff85fa9so11906466d6.2
        for <selinux@vger.kernel.org>; Wed, 02 Sep 2026 07:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788357812; x=1788962612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=shC6xovgN3vgqKVLWc07H5vTk1UbbO2Ydttha3hTX3A=;
        b=lA8OMrtz+eNAtUvSM9WdVddTAfEdveLZDiJQ9wSSzhy+aSzRHp7/QrLBPIR2n7Dfmr
         SnoPGoZDuq6CyL7DEtwoyt+rf90a8VdrHtz2FVIJ2GQGJlCKDy86E35xzLGV5W6d6nDm
         Z5M1GHOIJhyuJisKnHIXzghhXXrLceEGNE+CP+7r/5VqZZlWYzzWJxT8UGfunQB/rflq
         j31ZYoAFqmp4T3YU1gG1+LL2ik8C7BMYb8sY98AQHYZ+6yNYutmSTsS7Y/ziq9R3w2us
         OtqPAt+oerspyIDQgdUoDdql83VQDmUUyu5ekpot22Dnpm/XCaEbb7dq/XEX/6PvCUja
         dEWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788357812; x=1788962612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=shC6xovgN3vgqKVLWc07H5vTk1UbbO2Ydttha3hTX3A=;
        b=q+nvvgcMzmokn7yfVuwR3cHwZp2k7SX1VnPs7Vlw6Kbqqr5A1IcaxH0r0YPAdYTgIK
         tJsqcbbDdaX9bIYB98WGJsAltzaszfXEIP3b+zjvBiOeJvIrTC862z1blV1Oz5t7A9Wm
         mFk191zNs6s8AxL2U9K3AgpDqpy16I6J0mYT76obbRP7eVncTqMMNJdAf3FJksK9mp2N
         768gGUHc0s/9aBhUYTp9QvJPZCEBigMrQNChxGMOh4muvvPBjE8ORRY2YvqYPSyODnti
         25AoWv7usPVtKuvr6EH7/oW2IY02f1/TWJN/KijMsZcr536vyyyh/yc8qGOr3eKehKzw
         ywyA==
X-Gm-Message-State: AFuF++lYax82jIE4YskQrqDrqjqkvziJS4TJarH6DDZhDw3h1kt5WYlV
	MFeqPA4P7OB33LL0Z4k+m+DC6SNyYRlNO14pLPg9j2GBx0mrCIJZJG+DtGf0nw==
X-Gm-Gg: AR+sD13XhOoNww6dPuHqWlZvtgDy8XepNLS/Dqq6KlUcYcOSIDWYR8XxRfK58qXoVBD
	/JyKUPqx2VPvlI9mZUfojVZPXDV3cktNVS3g7EohdeQ3rMTD9E0VeJuExr4Ia5S8M+xFDjal4XG
	qk8Cu1ieN0wNVfgrtAvzN+RhLS8lTmXTwrrWV3SjZ2tSdovnBRTXEGRiU5+Y4pDcjW2ZvkZ5zKE
	+YlZxGmf2SbrNp4YEqnR5KIssyXFZzdW5vHJ3XhhZsIrqfT0xz7JvVw1t6HR933MpxXa01ZuOsD
	nbUCWCf32/1OQScfyJoOk3Id4wcqcog10pj/NLaZOUMJHF9/23XAfISLWU4Kro7ULhwdNTjZIFJ
	5Vt1axOV6ztpMZEfpnxhl3sRquvjKRLLDL7wiyQMFHYi3uCpIVRGJ3UXvMrt840OdaCarcQiQG6
	MlgsO4r2QYRzSHnfO//tIKFwT55Fn8urbIOczapmDkbbrdPVoIzzWfoPxUSi6SDE/DRt4VOFBZt
	KzzRIIHTt96wSZTyqT7azTHIucW/vyt99RKhm1d5db65daTSWdcB8V+PrUy+MPa
X-Received: by 2002:a05:6214:2dc4:b0:8ef:e0d0:9fae with SMTP id 6a1803df08f44-90eca3e368cmr77173996d6.14.1788357811515;
        Wed, 02 Sep 2026 07:03:31 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90e9ee316f7sm18790446d6.19.2026.09.02.07.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 07:03:31 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 3/9] libsemanage: list modules across every store root
Date: Wed,  2 Sep 2026 10:02:05 -0400
Message-ID: <20260902140211.53084-5-stephen.smalley.work@gmail.com>
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

semanage_direct_list_all() now scans the writable modules root (TMP in
a transaction, ACTIVE otherwise) and each ro-store-root ACTIVE modules
root, collecting every (priority, name) pair. The result is sorted by
(priority descending, name ascending) so that
semanage_get_active_modules() still picks the highest priority one,
and adjacent duplicates are collapsed.

For each unique pair, semanage_direct_get_module_info() reads lang_ext
and the disabled marker via semanage_module_find_path(), so a module
present only in a read-only root is fully described, and a writable-
store copy at the same priority/name shadows a fallback.

An ENOENT from any root's modules directory is treated as an empty
contribution rather than a hard error, so a fresh /var or /etc with no
active/ tree does not break 'semodule -l'.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsemanage/src/direct_api.c | 293 ++++++++++++++++++++---------------
 1 file changed, 168 insertions(+), 125 deletions(-)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index ded6bb9e..dae9d003 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -2622,6 +2622,105 @@ static int semanage_modules_filename_select(const struct dirent *d)
 	return 1;
 }
 
+struct raw_module {
+	uint16_t priority;
+	char *name;
+};
+
+static int raw_module_cmp(const void *a, const void *b)
+{
+	const struct raw_module *ra = a, *rb = b;
+
+	if (ra->priority != rb->priority)
+		return (int)rb->priority - (int)ra->priority;
+	return strcmp(ra->name, rb->name);
+}
+
+static void free_scandir_result(struct dirent **entries, int n)
+{
+	int i;
+
+	for (i = 0; i < n; i++)
+		free(entries[i]);
+	free(entries);
+}
+
+static int semanage_scan_modules_root(semanage_handle_t *sh,
+				      const char *toplevel,
+				      struct raw_module **raw, int *raw_len)
+{
+	struct dirent **priorities = NULL, **modules = NULL;
+	int priorities_len, modules_len;
+	char priority_path[PATH_MAX];
+	uint16_t priority;
+	int i, j, status = 0;
+	void *tmp;
+
+	priorities_len = scandir(toplevel, &priorities,
+				 semanage_priorities_filename_select,
+				 versionsort);
+	if (priorities_len < 0) {
+		if (errno == ENOENT)
+			return 0;
+		ERR(sh, "Error while scanning directory %s.", toplevel);
+		return -1;
+	}
+
+	for (i = 0; i < priorities_len; i++) {
+		if (semanage_string_to_priority(priorities[i]->d_name,
+						&priority)) {
+			status = -1;
+			break;
+		}
+
+		snprintf(priority_path, sizeof(priority_path), "%s/%s",
+			 toplevel, priorities[i]->d_name);
+		modules_len = scandir(priority_path, &modules,
+				      semanage_modules_filename_select,
+				      versionsort);
+		if (modules_len < 0) {
+			ERR(sh, "Error while scanning directory %s.",
+			    priority_path);
+			status = -1;
+			break;
+		}
+		if (modules_len == 0) {
+			free(modules);
+			modules = NULL;
+			continue;
+		}
+
+		tmp = realloc(*raw,
+			      sizeof(**raw) * ((size_t)*raw_len + modules_len));
+		if (tmp == NULL) {
+			ERR(sh, "Error allocating memory for module list.");
+			free_scandir_result(modules, modules_len);
+			status = -1;
+			break;
+		}
+		*raw = tmp;
+
+		for (j = 0; j < modules_len; j++) {
+			(*raw)[*raw_len].priority = priority;
+			(*raw)[*raw_len].name = strdup(modules[j]->d_name);
+			if ((*raw)[*raw_len].name == NULL) {
+				ERR(sh, "Out of memory.");
+				status = -1;
+				break;
+			}
+			(*raw_len)++;
+		}
+
+		free_scandir_result(modules, modules_len);
+		modules = NULL;
+		if (status)
+			break;
+	}
+
+	free_scandir_result(priorities, priorities_len);
+	return status;
+}
+
 static int semanage_direct_list_all(semanage_handle_t *sh,
 				    semanage_module_info_t **modinfos,
 				    int *modinfos_len)
@@ -2634,22 +2733,13 @@ static int semanage_direct_list_all(semanage_handle_t *sh,
 	int ret = 0;
 
 	int i = 0;
-	int j = 0;
+	unsigned int r;
+
+	struct raw_module *raw = NULL;
+	int raw_len = 0;
 
 	*modinfos = NULL;
 	*modinfos_len = 0;
-	void *tmp = NULL;
-
-	const char *toplevel = NULL;
-
-	struct dirent **priorities = NULL;
-	int priorities_len = 0;
-	char priority_path[PATH_MAX];
-
-	struct dirent **modules = NULL;
-	int modules_len = 0;
-
-	uint16_t priority = 0;
 
 	semanage_module_info_t *modinfo_tmp = NULL;
 
@@ -2660,158 +2750,111 @@ static int semanage_direct_list_all(semanage_handle_t *sh,
 		goto cleanup;
 	}
 
-	if (sh->is_in_transaction) {
-		toplevel = semanage_path(SEMANAGE_TMP, SEMANAGE_MODULES);
-	} else {
-		toplevel = semanage_path(SEMANAGE_ACTIVE, SEMANAGE_MODULES);
+	/*
+	 * Collect (priority, name) from the writable store and every
+	 * read-only fallback root. A missing modules directory in
+	 * any root contributes nothing rather than failing the listing.
+	 */
+	status = semanage_scan_modules_root(
+		sh,
+		semanage_path(sh->is_in_transaction ? SEMANAGE_TMP :
+						      SEMANAGE_ACTIVE,
+			      SEMANAGE_MODULES),
+		&raw, &raw_len);
+	if (status)
+		goto cleanup;
+
+	for (r = 0; r < semanage_ro_root_count(); r++) {
+		status = semanage_scan_modules_root(
+			sh, semanage_ro_active_path(r, SEMANAGE_MODULES), &raw,
+			&raw_len);
+		if (status)
+			goto cleanup;
 	}
 
-	/* find priorities */
-	priorities_len = scandir(toplevel, &priorities,
-				 semanage_priorities_filename_select,
-				 versionsort);
-	if (priorities_len == -1) {
-		ERR(sh, "Error while scanning directory %s.", toplevel);
+	if (raw_len == 0)
+		goto cleanup;
+
+	/*
+	 * Sort by (priority descending, name ascending) so
+	 * semanage_get_active_modules() still sees the highest priority
+	 * first for each name. Duplicates are adjacent after the sort;
+	 * get_module_info() resolve them to the first-existing root via
+	 * semanage_module_find_path(), so which duplicate we keep is
+	 * immaterial.
+	 */
+	qsort(raw, raw_len, sizeof(*raw), raw_module_cmp);
+
+	*modinfos = calloc(raw_len, sizeof(**modinfos));
+	if (*modinfos == NULL) {
+		ERR(sh, "Error allocating memory for module array.");
 		status = -1;
 		goto cleanup;
 	}
 
-	/* for each priority directory */
-	/* loop through in reverse so that highest priority is first */
-	for (i = priorities_len - 1; i >= 0; i--) {
-		/* convert priority string to uint16_t */
-		ret = semanage_string_to_priority(priorities[i]->d_name,
-						  &priority);
+	for (i = 0; i < raw_len; i++) {
+		if (i > 0 && raw[i].priority == raw[i - 1].priority &&
+		    strcmp(raw[i].name, raw[i - 1].name) == 0)
+			continue;
+
+		ret = semanage_module_info_set_priority(sh, &modinfo,
+							raw[i].priority);
 		if (ret != 0) {
 			status = -1;
 			goto cleanup;
 		}
 
-		/* set our priority */
-		ret = semanage_module_info_set_priority(sh, &modinfo, priority);
+		ret = semanage_module_info_set_name(sh, &modinfo, raw[i].name);
 		if (ret != 0) {
 			status = -1;
 			goto cleanup;
 		}
 
-		/* get the priority path */
-		ret = semanage_module_get_path(sh, &modinfo,
-					       SEMANAGE_MODULE_PATH_PRIORITY,
-					       priority_path,
-					       sizeof(priority_path));
+		ret = semanage_direct_get_module_info(
+			sh, (const semanage_module_key_t *)(&modinfo),
+			&modinfo_tmp);
 		if (ret != 0) {
 			status = -1;
 			goto cleanup;
 		}
 
-		/* cleanup old modules */
-		if (modules != NULL) {
-			for (j = 0; j < modules_len; j++) {
-				free(modules[j]);
-				modules[j] = NULL;
-			}
-			free(modules);
-			modules = NULL;
-			modules_len = 0;
-		}
-
-		/* find modules at this priority */
-		modules_len = scandir(priority_path, &modules,
-				      semanage_modules_filename_select,
-				      versionsort);
-		if (modules_len == -1) {
-			ERR(sh, "Error while scanning directory %s.",
-			    priority_path);
+		ret = semanage_module_info_init(sh,
+						&((*modinfos)[*modinfos_len]));
+		if (ret != 0) {
 			status = -1;
 			goto cleanup;
 		}
 
-		if (modules_len == 0)
-			continue;
-
-		/* add space for modules */
-		tmp = realloc(*modinfos, sizeof(semanage_module_info_t) *
-						 (*modinfos_len + modules_len));
-		if (tmp == NULL) {
-			ERR(sh, "Error allocating memory for module array.");
+		ret = semanage_module_info_clone(sh, modinfo_tmp,
+						 &((*modinfos)[*modinfos_len]));
+		if (ret != 0) {
 			status = -1;
 			goto cleanup;
 		}
-		*modinfos = tmp;
 
-		/* for each module directory */
-		for (j = 0; j < modules_len; j++) {
-			/* set module name */
-			ret = semanage_module_info_set_name(sh, &modinfo,
-							    modules[j]->d_name);
-			if (ret != 0) {
-				status = -1;
-				goto cleanup;
-			}
+		semanage_module_info_destroy(sh, modinfo_tmp);
+		free(modinfo_tmp);
+		modinfo_tmp = NULL;
 
-			/* get module values */
-			ret = semanage_direct_get_module_info(
-				sh, (const semanage_module_key_t *)(&modinfo),
-				&modinfo_tmp);
-			if (ret != 0) {
-				status = -1;
-				goto cleanup;
-			}
-
-			/* copy into array */
-			ret = semanage_module_info_init(
-				sh, &((*modinfos)[*modinfos_len]));
-			if (ret != 0) {
-				status = -1;
-				goto cleanup;
-			}
-
-			ret = semanage_module_info_clone(
-				sh, modinfo_tmp, &((*modinfos)[*modinfos_len]));
-			if (ret != 0) {
-				status = -1;
-				goto cleanup;
-			}
-
-			semanage_module_info_destroy(sh, modinfo_tmp);
-			free(modinfo_tmp);
-			modinfo_tmp = NULL;
-
-			*modinfos_len += 1;
-		}
+		*modinfos_len += 1;
 	}
 
 cleanup:
 	semanage_module_info_destroy(sh, &modinfo);
 
-	if (priorities != NULL) {
-		for (i = 0; i < priorities_len; i++) {
-			free(priorities[i]);
-		}
-		free(priorities);
-	}
-
-	if (modules != NULL) {
-		for (i = 0; i < modules_len; i++) {
-			free(modules[i]);
-		}
-		free(modules);
-	}
+	for (i = 0; i < raw_len; i++)
+		free(raw[i].name);
+	free(raw);
 
 	semanage_module_info_destroy(sh, modinfo_tmp);
 	free(modinfo_tmp);
-	modinfo_tmp = NULL;
 
 	if (status != 0) {
-		if (modinfos != NULL) {
-			for (i = 0; i < *modinfos_len; i++) {
-				semanage_module_info_destroy(sh,
-							     &(*modinfos)[i]);
-			}
-			free(*modinfos);
-			*modinfos = NULL;
-			*modinfos_len = 0;
-		}
+		for (i = 0; i < *modinfos_len; i++)
+			semanage_module_info_destroy(sh, &(*modinfos)[i]);
+		free(*modinfos);
+		*modinfos = NULL;
+		*modinfos_len = 0;
 	}
 
 	return status;
-- 
2.55.0

