Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AA6485CDD
	for <selinux@vger.kernel.org>; Wed,  2 Sep 2026 13:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788356766; cv=none; b=oxfpXHAVp57AMIkhI/gCWf9SV0LQFcrlDGfjeNqoYvdXpekjuv3s1n6Tg82IhNr5GZkY1QLd+YSgSTGgSCwoZMKyjQPGnpaP2JcfpGma81Jtq0jb0/uGIpedkFjuyvtdnsi55yURAxxpN4SPeOpCcst/u8T1ckhUCSWMZa5IQwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788356766; c=relaxed/simple;
	bh=xppoRC7AfVl4ctGsPMpa1F3ZdtDiMR33VgZKyka11dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Be0ekwG+rIRnO3n2Qx05t17zHSaShKHRjAvJGY1UEakZ1qhQ2OWqH4k9R4aS5C+K1EY/fHNR7MjC1k8mqDGHscWo55mjezfsv3fGeQXMjn9Zp4Sh27Ewfct47GcjCRZxJcyySJ2Y6ksksotaGlXVrTH91GZmnVUhFe7IER948dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQG2vx5n; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQG2vx5n"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-52fa6005224so9002101cf.1
        for <selinux@vger.kernel.org>; Wed, 02 Sep 2026 06:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788356763; x=1788961563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9VVdTLhXia2muEg0eekxOfgR4FgkGk1WVMBDLZi+NFI=;
        b=VQG2vx5nBKr/37vdEDMTKoGdVBIftYU3ZJH4Hbjscr6PpCdOoMZuMmdsWUEAdVVnG6
         FC6jj/RNL9VnOWwGSkkVH9tJzXF2XEBBKMcMTEAH1G6xnD2T40/Q0nRtn1oXXJhwzk+P
         Y4UF/QMuvBbqwnRgZSQohy9p+El3bJtKf9s/NpA3pPUcszdQhFN1VtJMclaM5Zsle4o0
         YCj60Mf3MQ+ztV8fpqSHyR+L+ZnRAwlRCFHBAteB1i7fsijoch5kfS0K3qiThePMjXWq
         +o/6+4HvEOZUl+GJCXzDjMWYuEMTyiIxML32xAYUxijPUuS/PEScE2i+g2IH28HobxHi
         wlGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788356763; x=1788961563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9VVdTLhXia2muEg0eekxOfgR4FgkGk1WVMBDLZi+NFI=;
        b=V5sTQF7gnF8qWtlEiX9nYlgHv2JQtcSR96TtbKgYEsCEJSGcA5qExuztq2wJ0K8tlo
         I2slF5PV3NfdwnWX2E0gWhI6CSkoEjG1XVEVebfGtfmPMVXiu4u9qPQ/0+np1os/aNq3
         kl4wkiUIM2cLs5gIbKvTjWXLYSoN9iK0DAHxQeqfh+sAP99mEoAMUC8BCcd9oWyUHeas
         btcAMgxR6YjMC29pBAhlgfCmn2n1+R0+qlSY2CiVKHCk9yYqHjS6x4VPqPJ9Oig4RXf2
         q7uzUm0U70bRD6KqM8tMO1ZE/XyvYl/QAnLsHlOOk4n6lZ/6Lrebm0poCs6Akizk2vDb
         s7/g==
X-Gm-Message-State: AFuF++kZRzNaB1x3tlVHPlQmQTWpH84uO08rkGgP97fx0jwLghLqEIlu
	SHahb5IP89xPrdr1m1JB3Tz0zzmb/NlQm/i18xWlVbiAoLWZjCwJKiCrpYkHZw==
X-Gm-Gg: AR+sD11iPRShsXUWCAHz9D0aVqrUkLjFErxtugMvuRI/I69fbOUILJ0ZdGrE/1D4oYV
	SseLuSKiaiNk/sjDtRxnLBZ5FwplNviB17mxIm/tDt4zMpeP5jjp9Wr33Ywm7nDdkfYLxc+o3rV
	ThNgGN7JNnNp8IH+uaulYMFTuM2PKOUNJM4DWxawBWG7Lj6h5mhVhw1wfoL6F4kS7qZNBcSRWsE
	bpzOKFIhgln68ePW9bLakVfoHCOm1IQ6a3DIdYk6DF4ANvxw19qn2Uy7ez/YlvxOYdJdiMLH/Hv
	3NwzbiMBhukdiOjKPTi5aJ6//YIHTcOW+stL7sdGgH3BR6hdxy+dgsFE3ASAtNtGjkSXPb6EJZP
	Y6pRs4W7zFKuqn1xTe6GWnsSduIyUDibZPcEdSuCRQQ27GFoA6k8HghpqxpomIf/vr/8lgI2AFi
	10DovonHPc9hoOo6T8mC/zL4NsDTUMZNt/f0sIU+6JWTkkMf7CGyelNC4x/ZPSKAhpbPyOJOYvy
	TeOIPDNrBY5JuFH/4IQUHYlt2dhKWPl02vsmJoKp/ugbC0fx+8jqaY5DFH2nY3E
X-Received: by 2002:a05:622a:5810:b0:52e:a24:ee52 with SMTP id d75a77b69052e-5303699ffe5mr66325351cf.0.1788356761126;
        Wed, 02 Sep 2026 06:46:01 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5303325af1esm18686011cf.29.2026.09.02.06.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 06:46:00 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 3/9] libsemanage: list modules across every store root
Date: Wed,  2 Sep 2026 09:33:11 -0400
Message-ID: <20260902133316.51981-5-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902133316.51981-2-stephen.smalley.work@gmail.com>
References: <20260902133316.51981-2-stephen.smalley.work@gmail.com>
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
index ded6bb9e..e2e3a66b 100644
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
+			      sizeof(**raw) * ((size_t)raw_len + modules_len));
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

