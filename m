Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E54C484251
	for <selinux@vger.kernel.org>; Wed,  2 Sep 2026 15:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788362121; cv=none; b=K1BfPw3FxuKtbzzEvhtuzzVYcQ56Sk02SihSwRWn724fUpw5PKhoE3SqA+2ut7MBNm8PDEOLrcwLPVL1KsaPIloBjRV8e5Y9hHwIUKI/FawAqlT2u8D6qEXfxm5HrjxzjqjSMBAeL9POn13sCfxutp+Ft6xuimzLbZBY0xAKkCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788362121; c=relaxed/simple;
	bh=5VUqqG7FzJiP60HZ8r/Ioo2Li8VvQEZTV2alJSgBaTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GM8S4i5Fmv/ubfjEHpt2og/1fV+Tjtb4eqCn0JegVAT0AhWxpLJkxd+b6oJEYezoM98GUbFLSXr6U+mg4qer0SdPOKYpiJrS1p7cQgclVwcjr5eEW9/UHGOfd7KqXcC/7ZOOuTX9q0Z7U5Qu1vMgR5HETM3xsOzWh2RM8xxzCXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gMxlwcmw; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMxlwcmw"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-930f618435cso147436585a.3
        for <selinux@vger.kernel.org>; Wed, 02 Sep 2026 08:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788362118; x=1788966918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=shC6xovgN3vgqKVLWc07H5vTk1UbbO2Ydttha3hTX3A=;
        b=gMxlwcmwbDPN4MXuaJYF3iedxv8lwjkcc5bsjtLam+di4t9GEjBQoPJrVIJmQ58jau
         eZCByBefwQE4E+tXvVkIldva8mSxLKA0dW/n7ouVuQcLlxBKCdBPtKkTgVEdKQ6pFXSX
         BboNmQ14/199amZgBZ5LySbx6NcikkjvFENrbqD6ntQmFXk/Yzgw+hEKeTPkmvGVvldg
         HTZAVefuUg9Q8WpGosCsHELI34srd5W7fRit1CES9iBxqB/5T7XRes3z3vhu0KAQvODv
         6O93R+saX7EtiabRM9X9G/seExUxEPlYKsKeIWUtsvE6fE2fAxMiSpcC9wnf4skfcesM
         ryOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788362118; x=1788966918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=shC6xovgN3vgqKVLWc07H5vTk1UbbO2Ydttha3hTX3A=;
        b=gwljId0Nui0KPgM1qSyLcyhlmxQ8pUgnzWbXMl30v8CPsUXDKYyF9fJ2HyMy8+2YCk
         xuWJHkhfV6T15K+5EAMoMVsdRVGaEWJ3JpAkB22jeB3S9s1FbCyu9DBWkp+M/7HZ59Q/
         9IeTx13qHh8IdRDcDSYDIqFybwU2jDhbsQxyFpjqGLcrSqVqfkfO8kTxoLb2ycoGSd+T
         vCK7fCCscpOm2B5Db7GR0yKS2I1ORpQGiu3uLygy2P5SSdaS1OsSqHHoBhYD+zjw8WuQ
         EWFLwH3qw3juXlxSHEAeOMJhfZviU6iNM2FXXt2h9snMNNaVmmn/AX/iw9lGAZ+ootSb
         Y6ew==
X-Gm-Message-State: AFuF++mt72WCA3i9jTGVDgq1uWbzqzzmCcuq5jnfjH4HvLeSLp7BY60S
	jI8DoeXAI2H7cwkBNEMxTzA/BwszZ/bIP7m1MQ/u4evpNEbGkj1Odp9GAhr+Mg==
X-Gm-Gg: AR+sD10rB9n2AI+y4B2s7E7lxeJoEtgqKpZfKRkg2wW4WCcZr9vaQd/JtsFNJD5L1Xa
	qNqxE0t+RkX4ngHcS1pZg5BvCAGdGCDNjFcSJBoJDV8fa8Ts1bVBAENVlthSq325uzA8i/bt/IF
	gB5wXmpVErfOnkC1/CJ2yX4gg7tK+ivarKZXOKpZWW58JcRGUCrUxGyxQMcsZ7JZUVB0kKUb+bj
	rIpEUXEDHQeuZV8SKHm1jkHrsMld5B7b8a+Egu2ewQzmUNJ6N7Xq7mbv652f/aCumYUsVwwajCU
	LKmHpCQBp7qg9WFiBmGdKjNzGpF0dy9OeOxLXWcYaau+XDoBIhpMP3hRWfYHT4+nS/WVZGPdKGd
	TI2i1OzB0IknqRZ+AtKnbC5R/YF4UmFt8cmi5NLFX1EDmOH0s+53QncFiYUWx7rN6h2VW+Ka5Ai
	NQekMWVi6TqR6HmvB2JBdV+jqyC9yChcEtq0a1ozrOFd8o0bZIpHCR9xbPeHMhGVE7hwAx91Ckc
	1BOl85HdevGXYmwVVBcBX3VJ8hYcy1ZmvEfLhg9UEV40P0G75+ipD4dLUw2w/oVNA==
X-Received: by 2002:a05:620a:44c9:b0:92e:fc42:2c1d with SMTP id af79cd13be357-93960f2859cmr660214185a.20.1788362118054;
        Wed, 02 Sep 2026 08:15:18 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9395f17eefdsm229299885a.11.2026.09.02.08.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 08:15:17 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 3/9] libsemanage: list modules across every store root
Date: Wed,  2 Sep 2026 11:14:00 -0400
Message-ID: <20260902151406.54168-5-stephen.smalley.work@gmail.com>
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

