Return-Path: <SRS0=g6d+=UX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C9FC43613
	for <selinux@archiver.kernel.org>; Mon, 24 Jun 2019 18:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6308220657
	for <selinux@archiver.kernel.org>; Mon, 24 Jun 2019 18:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="b0t3rqAW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732728AbfFXSEM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Jun 2019 14:04:12 -0400
Received: from rgout0103.bt.lon5.cpcloud.co.uk ([65.20.0.123]:5235 "EHLO
        rgout01.bt.lon5.cpcloud.co.uk" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727607AbfFXSEM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Jun 2019 14:04:12 -0400
X-OWM-Source-IP: 86.147.202.200 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade-Verdict: clean 0
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-SNCR-VADESECURE: CLEAN
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduvddruddvgdduvdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucfkphepkeeirddugeejrddvtddvrddvtddtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddugeejrddvtddvrddvtddtpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehsughssehthigthhhordhnshgrrdhgohhvqedprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheqnecuvehluhhsthgvrhfuihiivgeptd
Received: from localhost.localdomain (86.147.202.200) by rgout01.bt.lon5.cpcloud.co.uk (9.0.019.26-1) (authenticated as richard_c_haines@btinternet.com)
        id 5CFA38CA01A6115E; Mon, 24 Jun 2019 19:04:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btcpcloud; t=1561399450; 
        bh=uQg97jPWMZ1HIjLemtznRpXxNLhFSJxDCEYoW1iJgyk=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=b0t3rqAW2YeeICB+byJCyUAKtP54K+JzVC7OCnfimgy2Zbt//Ozf11Z0cOT54Y8tJe6ehn9jSx2EZ0kixf3o/0iZeMAYZT98z4A5qYafg3nlekxtOZDr8BMcB+eI/vHl21t9z3KUxoBiCN8r0hy7gE1epBt4UBxQFKAo74NyxHU=
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org, sds@tycho.nsa.gov
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH V3 1/2] selinux: Remove legacy local boolean and user code
Date:   Mon, 24 Jun 2019 19:02:28 +0100
Message-Id: <20190624180229.9573-2-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190624180229.9573-1-richard_c_haines@btinternet.com>
References: <20190624180229.9573-1-richard_c_haines@btinternet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Remove legacy local boolean and user code, and to preserve API/ABI
compatibility the following functions int values should be set to '0'
as they are no longer used:
  selinux_mkload_policy(int preservebools)
  security_set_boolean_list(.... int permanent)
and the following are now no-op and return '-1':
  security_load_booleans()
  sepol_genusers()
  sepol_set_delusers()
  sepol_genbools()
  sepol_genbools_array()
and these still return their paths for compatibility, however they are
marked as deprecated:
  selinux_booleans_path()
  selinux_users_path()

These have been removed as they are local functions only:
  sepol_genusers_policydb()
  sepol_genbools_policydb()

Also "SETLOCALDEFS" removed from SELinux config file and code.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 libselinux/include/selinux/selinux.h       |  18 +-
 libselinux/src/booleans.c                  | 225 +-------------
 libselinux/src/file_path_suffixes.h        |   2 +
 libselinux/src/load_policy.c               | 100 +-----
 libselinux/src/selinux_config.c            |   9 +-
 libselinux/src/selinux_internal.h          |   1 -
 libsepol/include/sepol/booleans.h          |  15 +-
 libsepol/include/sepol/policydb/services.h |   6 -
 libsepol/include/sepol/users.h             |  13 +-
 libsepol/src/deprecated_funcs.c            |  50 +++
 libsepol/src/genbools.c                    | 279 -----------------
 libsepol/src/genusers.c                    | 343 ---------------------
 policycoreutils/load_policy/load_policy.c  |   2 +-
 13 files changed, 78 insertions(+), 985 deletions(-)
 create mode 100644 libsepol/src/deprecated_funcs.c
 delete mode 100644 libsepol/src/genbools.c
 delete mode 100644 libsepol/src/genusers.c

diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index f54f236b..f2d32214 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -286,11 +286,7 @@ extern int security_get_initial_context_raw(const char *name,
  * manipulating it as needed for current boolean settings and/or local 
  * definitions, and then calling security_load_policy to load it.
  *
- * 'preservebools' is a boolean flag indicating whether current 
- * policy boolean values should be preserved into the new policy (if 1) 
- * or reset to the saved policy settings (if 0).  The former case is the
- * default for policy reloads, while the latter case is an option for policy
- * reloads but is primarily for the initial policy load.
+ * 'preservebools' is no longer supported, set to 0.
  */
 extern int selinux_mkload_policy(int preservebools);
 
@@ -316,13 +312,15 @@ typedef struct {
 	char *name;
 	int value;
 } SELboolean;
-/* save a list of booleans in a single transaction.  */
+/* save a list of booleans in a single transaction. 'permanent' is no
+ * longer supported, set to 0.
+ */
 extern int security_set_boolean_list(size_t boolcnt,
 				     SELboolean * boollist, int permanent);
 
-/* Load policy boolean settings.
-   Path may be NULL, in which case the booleans are loaded from
-   the active policy boolean configuration file. */
+/* Load policy boolean settings. Deprecated as local policy booleans no
+ * longer supported. Will always return 0.
+ */
 extern int security_load_booleans(char *path);
 
 /* Check the validity of a security context. */
@@ -569,8 +567,10 @@ extern const char *selinux_systemd_contexts_path(void);
 extern const char *selinux_contexts_path(void);
 extern const char *selinux_securetty_types_path(void);
 extern const char *selinux_booleans_subs_path(void);
+/* Deprecated as local policy booleans no longer supported. */
 extern const char *selinux_booleans_path(void);
 extern const char *selinux_customizable_types_path(void);
+/* Deprecated as policy ./users no longer supported. */
 extern const char *selinux_users_path(void);
 extern const char *selinux_usersconf_path(void);
 extern const char *selinux_translations_path(void);
diff --git a/libselinux/src/booleans.c b/libselinux/src/booleans.c
index ab1e0754..c1caf929 100644
--- a/libselinux/src/booleans.c
+++ b/libselinux/src/booleans.c
@@ -322,175 +322,6 @@ int security_commit_booleans(void)
 		return -1;
 }
 
-static char *strtrim(char *dest, char *source, int size)
-{
-	int i = 0;
-	char *ptr = source;
-	i = 0;
-	while (isspace(*ptr) && i < size) {
-		ptr++;
-		i++;
-	}
-	strncpy(dest, ptr, size);
-	for (i = strlen(dest) - 1; i > 0; i--) {
-		if (!isspace(dest[i]))
-			break;
-	}
-	dest[i + 1] = '\0';
-	return dest;
-}
-static int process_boolean(char *buffer, char *name, int namesize, int *val)
-{
-	char name1[BUFSIZ];
-	char *ptr = NULL;
-	char *tok;
-
-	/* Skip spaces */
-	while (isspace(buffer[0]))
-		buffer++;
-	/* Ignore comments */
-	if (buffer[0] == '#')
-		return 0;
-
-	tok = strtok_r(buffer, "=", &ptr);
-	if (!tok) {
-		errno = EINVAL;
-		return -1;
-	}
-	strncpy(name1, tok, BUFSIZ - 1);
-	strtrim(name, name1, namesize - 1);
-
-	tok = strtok_r(NULL, "\0", &ptr);
-	if (!tok) {
-		errno = EINVAL;
-		return -1;
-	}
-
-	while (isspace(*tok))
-		tok++;
-
-	*val = -1;
-	if (isdigit(tok[0]))
-		*val = atoi(tok);
-	else if (!strncasecmp(tok, "true", sizeof("true") - 1))
-		*val = 1;
-	else if (!strncasecmp(tok, "false", sizeof("false") - 1))
-		*val = 0;
-	if (*val != 0 && *val != 1) {
-		errno = EINVAL;
-		return -1;
-	}
-	return 1;
-}
-static int save_booleans(size_t boolcnt, SELboolean * boollist)
-{
-	ssize_t len;
-	size_t i;
-	char outbuf[BUFSIZ];
-	char *inbuf = NULL;
-
-	/* Open file */
-	const char *bool_file = selinux_booleans_path();
-	char local_bool_file[PATH_MAX];
-	char tmp_bool_file[PATH_MAX];
-	FILE *boolf;
-	int fd;
-	int *used = (int *)malloc(sizeof(int) * boolcnt);
-	if (!used) {
-		return -1;
-	}
-	/* zero out used field */
-	for (i = 0; i < boolcnt; i++)
-		used[i] = 0;
-
-	snprintf(tmp_bool_file, sizeof(tmp_bool_file), "%s.XXXXXX", bool_file);
-	fd = mkstemp(tmp_bool_file);
-	if (fd < 0) {
-		free(used);
-		return -1;
-	}
-
-	snprintf(local_bool_file, sizeof(local_bool_file), "%s.local",
-		 bool_file);
-	boolf = fopen(local_bool_file, "re");
-	if (boolf != NULL) {
-		ssize_t ret;
-		size_t size = 0;
-		int val;
-		char boolname[BUFSIZ-3];
-		char *buffer;
-		inbuf = NULL;
-		__fsetlocking(boolf, FSETLOCKING_BYCALLER);
-		while ((len = getline(&inbuf, &size, boolf)) > 0) {
-			buffer = strdup(inbuf);
-			if (!buffer)
-				goto close_remove_fail;
-			ret =
-			    process_boolean(inbuf, boolname, sizeof(boolname),
-					    &val);
-			if (ret != 1) {
-				ret = write(fd, buffer, len);
-				free(buffer);
-				if (ret != len)
-					goto close_remove_fail;
-			} else {
-				free(buffer);
-				for (i = 0; i < boolcnt; i++) {
-					if (strcmp(boollist[i].name, boolname)
-					    == 0) {
-						snprintf(outbuf, sizeof(outbuf),
-							 "%s=%d\n", boolname,
-							 boollist[i].value);
-						len = strlen(outbuf);
-						used[i] = 1;
-						if (write(fd, outbuf, len) !=
-						    len)
-							goto close_remove_fail;
-						else
-							break;
-					}
-				}
-				if (i == boolcnt) {
-					val = !!val;
-					snprintf(outbuf, sizeof(outbuf),
-						 "%s=%d\n", boolname, val);
-					len = strlen(outbuf);
-					if (write(fd, outbuf, len) != len)
-						goto close_remove_fail;
-				}
-			}
-			free(inbuf);
-			inbuf = NULL;
-		}
-		fclose(boolf);
-	}
-
-	for (i = 0; i < boolcnt; i++) {
-		if (used[i] == 0) {
-			snprintf(outbuf, sizeof(outbuf), "%s=%d\n",
-				 boollist[i].name, boollist[i].value);
-			len = strlen(outbuf);
-			if (write(fd, outbuf, len) != len) {
-			      close_remove_fail:
-				free(inbuf);
-				close(fd);
-			      remove_fail:
-				unlink(tmp_bool_file);
-				free(used);
-				return -1;
-			}
-		}
-
-	}
-	if (fchmod(fd, S_IRUSR | S_IWUSR) != 0)
-		goto close_remove_fail;
-	close(fd);
-	if (rename(tmp_bool_file, local_bool_file) != 0)
-		goto remove_fail;
-
-	free(used);
-	return 0;
-}
 static void rollback(SELboolean * boollist, int end)
 {
 	int i;
@@ -519,62 +350,18 @@ int security_set_boolean_list(size_t boolcnt, SELboolean * boollist,
 		return -1;
 	}
 
+	/* Return error as flag no longer used */
 	if (permanent)
-		return save_booleans(boolcnt, boollist);
+		return -1;
 
 	return 0;
 }
-int security_load_booleans(char *path)
-{
-	FILE *boolf;
-	char *inbuf;
-	char localbools[BUFSIZ];
-	size_t len = 0, errors = 0;
-	int val;
-	char name[BUFSIZ];
-
-	boolf = fopen(path ? path : selinux_booleans_path(), "re");
-	if (boolf == NULL)
-		goto localbool;
-
-	__fsetlocking(boolf, FSETLOCKING_BYCALLER);
-	while (getline(&inbuf, &len, boolf) > 0) {
-		int ret = process_boolean(inbuf, name, sizeof(name), &val);
-		if (ret == -1)
-			errors++;
-		if (ret == 1)
-			if (security_set_boolean(name, val) < 0) {
-				errors++;
-			}
-	}
-	fclose(boolf);
-      localbool:
-	snprintf(localbools, sizeof(localbools), "%s.local",
-		 (path ? path : selinux_booleans_path()));
-	boolf = fopen(localbools, "re");
-
-	if (boolf != NULL) {
-		int ret;
-		__fsetlocking(boolf, FSETLOCKING_BYCALLER);
-		while (getline(&inbuf, &len, boolf) > 0) {
-			ret = process_boolean(inbuf, name, sizeof(name), &val);
-			if (ret == -1)
-				errors++;
-			if (ret == 1)
-				if (security_set_boolean(name, val) < 0) {
-					errors++;
-				}
-		}
-		fclose(boolf);
-	}
-	if (security_commit_booleans() < 0)
-		return -1;
 
-	if (errors)
-		errno = EINVAL;
-	return errors ? -1 : 0;
+/* This function is deprecated */
+int security_load_booleans(char *path __attribute__((unused)))
+{
+	return -1;
 }
-
 #else
 
 #include <stdlib.h>
diff --git a/libselinux/src/file_path_suffixes.h b/libselinux/src/file_path_suffixes.h
index 2d3ca497..a5573134 100644
--- a/libselinux/src/file_path_suffixes.h
+++ b/libselinux/src/file_path_suffixes.h
@@ -8,10 +8,12 @@ S_(BINPOLICY, "/policy/policy")
     S_(FAILSAFE_CONTEXT, "/contexts/failsafe_context")
     S_(DEFAULT_TYPE, "/contexts/default_type")
     S_(SECURETTY_TYPES, "/contexts/securetty_types")
+	/* BOOLEANS is deprecated */
     S_(BOOLEANS, "/booleans")
     S_(MEDIA_CONTEXTS, "/contexts/files/media")
     S_(REMOVABLE_CONTEXT, "/contexts/removable_context")
     S_(CUSTOMIZABLE_TYPES, "/contexts/customizable_types")
+	/* USERS_DIR is deprecated */
     S_(USERS_DIR, "/users/")
     S_(SEUSERS, "/seusers")
     S_(TRANSLATIONS, "/setrans.conf")
diff --git a/libselinux/src/load_policy.c b/libselinux/src/load_policy.c
index 20052beb..9e75292d 100644
--- a/libselinux/src/load_policy.c
+++ b/libselinux/src/load_policy.c
@@ -48,22 +48,18 @@ int security_load_policy(void *data, size_t len)
 hidden_def(security_load_policy)
 
 #ifndef ANDROID
-int load_setlocaldefs hidden = 1;
-
 #undef max
 #define max(a, b) (((a) > (b)) ? (a) : (b))
 
-int selinux_mkload_policy(int preservebools)
+int selinux_mkload_policy(int preservebools __attribute__((unused)))
 {	
 	int kernvers = security_policyvers();
 	int maxvers = kernvers, minvers = DEFAULT_POLICY_VERSION, vers;
-	int setlocaldefs = load_setlocaldefs;
 	char path[PATH_MAX];
 	struct stat sb;
-	struct utsname uts;
 	size_t size;
 	void *map, *data;
-	int fd, rc = -1, prot;
+	int fd, rc = -1;
 	sepol_policydb_t *policydb;
 	sepol_policy_file_t *pf;
 	int usesepol = 0;
@@ -77,9 +73,6 @@ int selinux_mkload_policy(int preservebools)
 	int (*policydb_read)(sepol_policydb_t *, sepol_policy_file_t *) = NULL;
 	int (*policydb_set_vers)(sepol_policydb_t *, unsigned int) = NULL;
 	int (*policydb_to_image)(sepol_handle_t *, sepol_policydb_t *, void **, size_t *) = NULL;
-	int (*genbools_array)(void *data, size_t len, char **names, int *values, int nel) = NULL;
-	int (*genusers)(void *data, size_t len, const char *usersdir, void **newdata, size_t * newlen) = NULL;
-	int (*genbools)(void *data, size_t len, const char *boolpath) = NULL;
 
 #ifdef SHARED
 	char *errormsg = NULL;
@@ -110,13 +103,6 @@ int selinux_mkload_policy(int preservebools)
 		DLERR();
 		policydb_to_image = dlsym(libsepolh, "sepol_policydb_to_image");
 		DLERR();
-		genbools_array = dlsym(libsepolh, "sepol_genbools_array");
-		DLERR();
-		genusers = dlsym(libsepolh, "sepol_genusers");
-		DLERR();
-		genbools = dlsym(libsepolh, "sepol_genbools");
-		DLERR();
-
 #undef DLERR
 	}
 #else
@@ -131,42 +117,11 @@ int selinux_mkload_policy(int preservebools)
 	policydb_read = sepol_policydb_read;
 	policydb_set_vers = sepol_policydb_set_vers;
 	policydb_to_image = sepol_policydb_to_image;
-	genbools_array = sepol_genbools_array;
-	genusers = sepol_genusers;
-	genbools = sepol_genbools;
-
 #endif
 
-	/*
-	 * Check whether we need to support local boolean and user definitions.
-	 */
-	if (setlocaldefs) {
-		if (access(selinux_booleans_path(), F_OK) == 0)
-			goto checkbool;
-		snprintf(path, sizeof path, "%s.local", selinux_booleans_path());
-		if (access(path, F_OK) == 0)
-			goto checkbool;
-		snprintf(path, sizeof path, "%s/local.users", selinux_users_path());
-		if (access(path, F_OK) == 0)
-			goto checkbool;
-		/* No local definition files, so disable setlocaldefs. */
-		setlocaldefs = 0;
-	}
-
-checkbool:
-	/* 
-	 * As of Linux 2.6.22, the kernel preserves boolean
-	 * values across a reload, so we do not need to 
-	 * preserve them in userspace.
-	 */
-	if (preservebools && uname(&uts) == 0 && strverscmp(uts.release, "2.6.22") >= 0)
-		preservebools = 0;
-
 	if (usesepol) {
-		maxvers = vers_max();
+		maxvers = max(kernvers, vers_max());
 		minvers = vers_min();
-		if (!setlocaldefs && !preservebools)
-			maxvers = max(kernvers, maxvers);
 	}
 
 	vers = maxvers;
@@ -195,12 +150,8 @@ checkbool:
 		goto close;
 	}
 
-	prot = PROT_READ;
-	if (setlocaldefs || preservebools)
-		prot |= PROT_WRITE;
-
 	size = sb.st_size;
-	data = map = mmap(NULL, size, prot, MAP_PRIVATE, fd, 0);
+	data = map = mmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
 	if (map == MAP_FAILED) {
 		fprintf(stderr,
 			"SELinux:  Could not map policy file %s:  %s\n",
@@ -239,49 +190,6 @@ checkbool:
 		policydb_free(policydb);
 	}
 
-	if (usesepol) {
-		if (setlocaldefs) {
-			void *olddata = data;
-			size_t oldsize = size;
-			rc = genusers(olddata, oldsize, selinux_users_path(),
-				      &data, &size);
-			if (rc < 0) {
-				/* Fall back to the prior image if genusers failed. */
-				data = olddata;
-				size = oldsize;
-				rc = 0;
-			} else {
-				if (olddata != map)
-					free(olddata);
-			}
-		}
-		
-		if (preservebools) {
-			int *values, len, i;
-			char **names;
-			rc = security_get_boolean_names(&names, &len);
-			if (!rc) {
-				values = malloc(sizeof(int) * len);
-				if (!values) {
-					free(names);
-					goto unmap;
-				}
-				for (i = 0; i < len; i++)
-					values[i] =
-						security_get_boolean_active(names[i]);
-				(void)genbools_array(data, size, names, values,
-						     len);
-				free(values);
-				for (i = 0; i < len; i++)
-					free(names[i]);
-				free(names);
-			}
-		} else if (setlocaldefs) {
-			(void)genbools(data, size, selinux_booleans_path());
-		}
-	}
-
-
 	rc = security_load_policy(data, size);
 	
 	if (rc)
diff --git a/libselinux/src/selinux_config.c b/libselinux/src/selinux_config.c
index b06cb63b..b16a3851 100644
--- a/libselinux/src/selinux_config.c
+++ b/libselinux/src/selinux_config.c
@@ -16,7 +16,6 @@
 #define SELINUXDEFAULT "targeted"
 #define SELINUXTYPETAG "SELINUXTYPE="
 #define SELINUXTAG "SELINUX="
-#define SETLOCALDEFS "SETLOCALDEFS="
 #define REQUIRESEUSERS "REQUIRESEUSERS="
 
 /* Indices for file paths arrays. */
@@ -28,10 +27,12 @@
 #define USER_CONTEXTS     5
 #define FAILSAFE_CONTEXT  6
 #define DEFAULT_TYPE      7
+/* BOOLEANS is deprecated */
 #define BOOLEANS          8
 #define MEDIA_CONTEXTS    9
 #define REMOVABLE_CONTEXT 10
 #define CUSTOMIZABLE_TYPES    11
+/* USERS_DIR is deprecated */
 #define USERS_DIR         12
 #define SEUSERS           13
 #define TRANSLATIONS      14
@@ -192,10 +193,6 @@ static void init_selinux_config(void)
 				}
 				free(type);
 				continue;
-			} else if (!strncmp(buf_p, SETLOCALDEFS,
-					    sizeof(SETLOCALDEFS) - 1)) {
-				value = buf_p + sizeof(SETLOCALDEFS) - 1;
-				intptr = &load_setlocaldefs;
 			} else if (!strncmp(buf_p, REQUIRESEUSERS,
 					    sizeof(REQUIRESEUSERS) - 1)) {
 				value = buf_p + sizeof(REQUIRESEUSERS) - 1;
@@ -410,6 +407,7 @@ const char *selinux_user_contexts_path(void)
 
 hidden_def(selinux_user_contexts_path)
 
+/* Deprecated as local policy booleans no longer supported. */
 const char *selinux_booleans_path(void)
 {
 	return get_path(BOOLEANS);
@@ -417,6 +415,7 @@ const char *selinux_booleans_path(void)
 
 hidden_def(selinux_booleans_path)
 
+/* Deprecated as no longer supported. */
 const char *selinux_users_path(void)
 {
 	return get_path(USERS_DIR);
diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux_internal.h
index acd59c7c..8b4bed2f 100644
--- a/libselinux/src/selinux_internal.h
+++ b/libselinux/src/selinux_internal.h
@@ -110,7 +110,6 @@ hidden_proto(selinux_reset_config);
 
 hidden void flush_class_cache(void);
 
-extern int load_setlocaldefs hidden;
 extern int require_seusers hidden;
 extern int selinux_page_size hidden;
 
diff --git a/libsepol/include/sepol/booleans.h b/libsepol/include/sepol/booleans.h
index 2966903d..06d2230c 100644
--- a/libsepol/include/sepol/booleans.h
+++ b/libsepol/include/sepol/booleans.h
@@ -10,23 +10,10 @@
 extern "C" {
 #endif
 
-/*--------------compatibility--------------*/
-
-/* Given an existing binary policy (starting at 'data', with length 'len')
-   and a boolean configuration file named by 'boolpath', rewrite the binary
-   policy for the boolean settings in the boolean configuration file.
-   The binary policy is rewritten in place in memory.
-   Returns 0 upon success, or -1 otherwise. */
+/* These two functions are deprecated. See src/deprecated_funcs.c */
 extern int sepol_genbools(void *data, size_t len, const char *boolpath);
-
-/* Given an existing binary policy (starting at 'data', with length 'len')
-   and boolean settings specified by the parallel arrays ('names', 'values')
-   with 'nel' elements, rewrite the binary policy for the boolean settings.
-   The binary policy is rewritten in place in memory.
-   Returns 0 upon success or -1 otherwise. */
 extern int sepol_genbools_array(void *data, size_t len,
 				char **names, int *values, int nel);
-/*---------------end compatbility------------*/
 
 /* Set the specified boolean */
 extern int sepol_bool_set(sepol_handle_t * handle,
diff --git a/libsepol/include/sepol/policydb/services.h b/libsepol/include/sepol/policydb/services.h
index 6ef27a8c..776c2cff 100644
--- a/libsepol/include/sepol/policydb/services.h
+++ b/libsepol/include/sepol/policydb/services.h
@@ -30,12 +30,6 @@ extern "C" {
 extern int sepol_set_policydb(policydb_t * p);
 extern int sepol_set_sidtab(sidtab_t * s);
 
-/* Modify a policydb for boolean settings. */
-int sepol_genbools_policydb(policydb_t * policydb, const char *booleans);
-
-/* Modify a policydb for user settings. */
-int sepol_genusers_policydb(policydb_t * policydb, const char *usersdir);
-
 /* Load the security policy. This initializes the policydb
    and sidtab based on the provided binary policy. */
 extern int sepol_load_policy(void *data, size_t len);
diff --git a/libsepol/include/sepol/users.h b/libsepol/include/sepol/users.h
index ad23f89b..70158ac4 100644
--- a/libsepol/include/sepol/users.h
+++ b/libsepol/include/sepol/users.h
@@ -10,23 +10,12 @@
 extern "C" {
 #endif
 
-/*---------compatibility------------*/
-
-/* Given an existing binary policy (starting at 'data with length 'len')
-   and user configurations living in 'usersdir', generate a new binary
-   policy for the new user configurations.  Sets '*newdata' and '*newlen'
-   to refer to the new binary policy image. */
+/* These two functions are deprecated. See src/deprecated_funcs.c */
 extern int sepol_genusers(void *data, size_t len,
 			  const char *usersdir,
 			  void **newdata, size_t * newlen);
-
-/* Enable or disable deletion of users by sepol_genusers(3) when
-   a user in original binary policy image is not defined by the
-   new user configurations.  Defaults to disabled. */
 extern void sepol_set_delusers(int on);
 
-/*--------end compatibility----------*/
-
 /* Modify the user, or add it, if the key is not found */
 extern int sepol_user_modify(sepol_handle_t * handle,
 			     sepol_policydb_t * policydb,
diff --git a/libsepol/src/deprecated_funcs.c b/libsepol/src/deprecated_funcs.c
new file mode 100644
index 00000000..d0dab7df
--- /dev/null
+++ b/libsepol/src/deprecated_funcs.c
@@ -0,0 +1,50 @@
+#include <stdio.h>
+#include "debug.h"
+
+/*
+ * Need to keep these stubs for the libsepol interfaces exported in
+ * libsepol.map.in, as they are part of the shared library ABI.
+ */
+
+static const char *msg = "Deprecated interface";
+
+/*
+ * These two functions are deprecated and referenced in:
+ *	include/libsepol/users.h
+ */
+int sepol_genusers(void *data __attribute((unused)),
+		   size_t len __attribute((unused)),
+		   const char *usersdir __attribute((unused)),
+		   void **newdata __attribute((unused)),
+		   size_t *newlen __attribute((unused)))
+{
+	WARN(NULL, "%s", msg);
+	return -1;
+}
+
+void sepol_set_delusers(int on __attribute((unused)))
+{
+	WARN(NULL, "%s", msg);
+}
+
+/*
+ * These two functions are deprecated and referenced in:
+ *	include/libsepol/booleans.h
+ */
+int sepol_genbools(void *data __attribute((unused)),
+		   size_t len __attribute((unused)),
+		   const char *booleans __attribute((unused)))
+{
+	WARN(NULL, "%s", msg);
+	return -1;
+}
+
+int sepol_genbools_array(void *data __attribute((unused)),
+			 size_t len __attribute((unused)),
+			 char **names __attribute((unused)),
+			 int *values __attribute((unused)),
+			 int nel __attribute((unused)))
+{
+	WARN(NULL, "%s", msg);
+	return -1;
+}
diff --git a/libsepol/src/genbools.c b/libsepol/src/genbools.c
deleted file mode 100644
index d4a2df62..00000000
--- a/libsepol/src/genbools.c
+++ /dev/null
@@ -1,279 +0,0 @@
-#include <stdio.h>
-#include <stdlib.h>
-#include <ctype.h>
-#include <errno.h>
-
-#include <sepol/policydb/policydb.h>
-#include <sepol/policydb/conditional.h>
-
-#include "debug.h"
-#include "private.h"
-#include "dso.h"
-
-/* -- Deprecated -- */
-
-static char *strtrim(char *dest, char *source, int size)
-{
-	int i = 0;
-	char *ptr = source;
-	i = 0;
-	while (isspace(*ptr) && i < size) {
-		ptr++;
-		i++;
-	}
-	strncpy(dest, ptr, size);
-	for (i = strlen(dest) - 1; i > 0; i--) {
-		if (!isspace(dest[i]))
-			break;
-	}
-	dest[i + 1] = '\0';
-	return dest;
-}
-
-static int process_boolean(char *buffer, char *name, int namesize, int *val)
-{
-	char name1[BUFSIZ];
-	char *ptr = NULL;
-	char *tok;
-
-	/* Skip spaces */
-	while (isspace(buffer[0]))
-		buffer++;
-	/* Ignore comments */
-	if (buffer[0] == '#')
-		return 0;
-
-	tok = strtok_r(buffer, "=", &ptr);
-	if (!tok) {
-		ERR(NULL, "illegal boolean definition %s", buffer);
-		return -1;
-	}
-	strncpy(name1, tok, BUFSIZ - 1);
-	strtrim(name, name1, namesize - 1);
-
-	tok = strtok_r(NULL, "\0", &ptr);
-	if (!tok) {
-		ERR(NULL, "illegal boolean definition %s=%s", name, buffer);
-		return -1;
-	}
-
-	while (isspace(*tok))
-		tok++;
-
-	*val = -1;
-	if (isdigit(tok[0]))
-		*val = atoi(tok);
-	else if (!strncasecmp(tok, "true", sizeof("true") - 1))
-		*val = 1;
-	else if (!strncasecmp(tok, "false", sizeof("false") - 1))
-		*val = 0;
-	if (*val != 0 && *val != 1) {
-		ERR(NULL, "illegal value for boolean %s=%s", name, tok);
-		return -1;
-	}
-	return 1;
-}
-
-static int load_booleans(struct policydb *policydb, const char *path,
-			 int *changesp)
-{
-	FILE *boolf;
-	char *buffer = NULL;
-	char localbools[BUFSIZ];
-	char name[BUFSIZ];
-	int val;
-	int errors = 0, changes = 0;
-	struct cond_bool_datum *datum;
-
-	boolf = fopen(path, "r");
-	if (boolf == NULL)
-		goto localbool;
-
-#ifdef __APPLE__
-        if ((buffer = (char *)malloc(255 * sizeof(char))) == NULL) {
-          ERR(NULL, "out of memory");
-	  return -1;
-	}
-
-        while(fgets(buffer, 255, boolf) != NULL) {
-#else
-	size_t size = 0;
-	while (getline(&buffer, &size, boolf) > 0) {
-#endif
-		int ret = process_boolean(buffer, name, sizeof(name), &val);
-		if (ret == -1)
-			errors++;
-		if (ret == 1) {
-			datum = hashtab_search(policydb->p_bools.table, name);
-			if (!datum) {
-				ERR(NULL, "unknown boolean %s", name);
-				errors++;
-				continue;
-			}
-			if (datum->state != val) {
-				datum->state = val;
-				changes++;
-			}
-		}
-	}
-	fclose(boolf);
-      localbool:
-	snprintf(localbools, sizeof(localbools), "%s.local", path);
-	boolf = fopen(localbools, "r");
-	if (boolf != NULL) {
-
-#ifdef __APPLE__
-
-	  while(fgets(buffer, 255, boolf) != NULL) {
-#else
-
-	    while (getline(&buffer, &size, boolf) > 0) {
-#endif
-			int ret =
-			    process_boolean(buffer, name, sizeof(name), &val);
-			if (ret == -1)
-				errors++;
-			if (ret == 1) {
-				datum =
-				    hashtab_search(policydb->p_bools.table,
-						   name);
-				if (!datum) {
-					ERR(NULL, "unknown boolean %s", name);
-					errors++;
-					continue;
-				}
-				if (datum->state != val) {
-					datum->state = val;
-					changes++;
-				}
-			}
-		}
-		fclose(boolf);
-	}
-	free(buffer);
-	if (errors)
-		errno = EINVAL;
-	*changesp = changes;
-	return errors ? -1 : 0;
-}
-
-int sepol_genbools(void *data, size_t len, const char *booleans)
-{
-	struct policydb policydb;
-	struct policy_file pf;
-	int rc, changes = 0;
-
-	if (policydb_init(&policydb))
-		goto err;
-	if (policydb_from_image(NULL, data, len, &policydb) < 0)
-		goto err;
-
-	if (load_booleans(&policydb, booleans, &changes) < 0) {
-		WARN(NULL, "error while reading %s", booleans);
-	}
-
-	if (!changes)
-		goto out;
-
-	if (evaluate_conds(&policydb) < 0) {
-		ERR(NULL, "error while re-evaluating conditionals");
-		errno = EINVAL;
-		goto err_destroy;
-	}
-
-	policy_file_init(&pf);
-	pf.type = PF_USE_MEMORY;
-	pf.data = data;
-	pf.len = len;
-	rc = policydb_write(&policydb, &pf);
-	if (rc) {
-		ERR(NULL, "unable to write new binary policy image");
-		errno = EINVAL;
-		goto err_destroy;
-	}
-
-      out:
-	policydb_destroy(&policydb);
-	return 0;
-
-      err_destroy:
-	policydb_destroy(&policydb);
-
-      err:
-	return -1;
-}
-
-int hidden sepol_genbools_policydb(policydb_t * policydb, const char *booleans)
-{
-	int rc, changes = 0;
-
-	rc = load_booleans(policydb, booleans, &changes);
-	if (!rc && changes)
-		rc = evaluate_conds(policydb);
-	if (rc)
-		errno = EINVAL;
-	return rc;
-}
-
-/* -- End Deprecated -- */
-
-int sepol_genbools_array(void *data, size_t len, char **names, int *values,
-			 int nel)
-{
-	struct policydb policydb;
-	struct policy_file pf;
-	int rc, i, errors = 0;
-	struct cond_bool_datum *datum;
-
-	/* Create policy database from image */
-	if (policydb_init(&policydb))
-		goto err;
-	if (policydb_from_image(NULL, data, len, &policydb) < 0)
-		goto err;
-
-	for (i = 0; i < nel; i++) {
-		datum = hashtab_search(policydb.p_bools.table, names[i]);
-		if (!datum) {
-			ERR(NULL, "boolean %s no longer in policy", names[i]);
-			errors++;
-			continue;
-		}
-		if (values[i] != 0 && values[i] != 1) {
-			ERR(NULL, "illegal value %d for boolean %s",
-			    values[i], names[i]);
-			errors++;
-			continue;
-		}
-		datum->state = values[i];
-	}
-
-	if (evaluate_conds(&policydb) < 0) {
-		ERR(NULL, "error while re-evaluating conditionals");
-		errno = EINVAL;
-		goto err_destroy;
-	}
-
-	policy_file_init(&pf);
-	pf.type = PF_USE_MEMORY;
-	pf.data = data;
-	pf.len = len;
-	rc = policydb_write(&policydb, &pf);
-	if (rc) {
-		ERR(NULL, "unable to write binary policy");
-		errno = EINVAL;
-		goto err_destroy;
-	}
-	if (errors) {
-		errno = EINVAL;
-		goto err_destroy;
-	}
-
-	policydb_destroy(&policydb);
-	return 0;
-
-      err_destroy:
-	policydb_destroy(&policydb);
-
-      err:
-	return -1;
-}
diff --git a/libsepol/src/genusers.c b/libsepol/src/genusers.c
deleted file mode 100644
index c375c669..00000000
--- a/libsepol/src/genusers.c
+++ /dev/null
@@ -1,343 +0,0 @@
-#include <stdio.h>
-
-#include <stdlib.h>
-#include <ctype.h>
-#include <errno.h>
-#include <limits.h>
-
-#include <sepol/policydb/policydb.h>
-
-#ifndef __APPLE__
-#include <stdio_ext.h>
-#endif
-
-#include <stdarg.h>
-
-#include "debug.h"
-#include "private.h"
-#include "dso.h"
-#include "mls.h"
-
-/* -- Deprecated -- */
-
-void sepol_set_delusers(int on __attribute((unused)))
-{
-	WARN(NULL, "Deprecated interface");
-}
-
-#undef BADLINE
-#define BADLINE() { \
-	ERR(NULL, "invalid entry %s (%s:%u)", \
-		buffer, path, lineno); \
-	continue; \
-}
-
-static int load_users(struct policydb *policydb, const char *path)
-{
-	FILE *fp;
-	char *buffer = NULL, *p, *q, oldc;
-	ssize_t nread;
-	unsigned lineno = 0, islist = 0, bit;
-	user_datum_t *usrdatum;
-	role_datum_t *roldatum;
-	ebitmap_node_t *rnode;
-
-	fp = fopen(path, "r");
-	if (fp == NULL)
-		return -1;
-
-#ifdef __APPLE__
-	if ((buffer = (char *)malloc(255 * sizeof(char))) == NULL) {
-	  ERR(NULL, "out of memory");
-	  return -1;
-	}
-
-	while(fgets(buffer, 255, fp) != NULL) {
-		nread = strlen(buffer);
-#else
-	size_t len = 0;
-	__fsetlocking(fp, FSETLOCKING_BYCALLER);
-	while ((nread = getline(&buffer, &len, fp)) > 0) {
-#endif
-
-		lineno++;
-		if (buffer[nread - 1] == '\n')
-			buffer[nread - 1] = 0;
-		p = buffer;
-		while (*p && isspace(*p))
-			p++;
-		if (!(*p) || *p == '#')
-			continue;
-
-		if (strncasecmp(p, "user", 4))
-			BADLINE();
-		p += 4;
-		if (!isspace(*p))
-			BADLINE();
-		while (*p && isspace(*p))
-			p++;
-		if (!(*p))
-			BADLINE();
-		q = p;
-		while (*p && !isspace(*p))
-			p++;
-		if (!(*p))
-			BADLINE();
-		*p++ = 0;
-
-		usrdatum = hashtab_search(policydb->p_users.table, q);
-		if (usrdatum) {
-			/* Replacing an existing user definition. */
-			ebitmap_destroy(&usrdatum->roles.roles);
-			ebitmap_init(&usrdatum->roles.roles);
-		} else {
-			char *id = strdup(q);
-
-			if (!id) {
-				ERR(NULL, "out of memory");
-				free(buffer);
-				fclose(fp);
-				return -1;
-			}
-
-			/* Adding a new user definition. */
-			usrdatum = malloc(sizeof(user_datum_t));
-			if (!usrdatum) {
-				ERR(NULL, "out of memory");
-				free(buffer);
-				free(id);
-				fclose(fp);
-				return -1;
-			}
-
-			user_datum_init(usrdatum);
-			usrdatum->s.value = ++policydb->p_users.nprim;
-			if (hashtab_insert(policydb->p_users.table,
-					   id, (hashtab_datum_t) usrdatum)) {
-				ERR(NULL, "out of memory");
-				free(buffer);
-				free(id);
-				user_datum_destroy(usrdatum);
-				free(usrdatum);
-				fclose(fp);
-				return -1;
-			}
-		}
-
-		while (*p && isspace(*p))
-			p++;
-		if (!(*p))
-			BADLINE();
-		if (strncasecmp(p, "roles", 5))
-			BADLINE();
-		p += 5;
-		if (!isspace(*p))
-			BADLINE();
-		while (*p && isspace(*p))
-			p++;
-		if (!(*p))
-			BADLINE();
-		if (*p == '{') {
-			islist = 1;
-			p++;
-		} else
-			islist = 0;
-
-		oldc = 0;
-		do {
-			while (*p && isspace(*p))
-				p++;
-			if (!(*p))
-				break;
-
-			q = p;
-			while (*p && *p != ';' && *p != '}' && !isspace(*p))
-				p++;
-			if (!(*p))
-				break;
-			if (*p == '}')
-				islist = 0;
-			oldc = *p;
-			*p++ = 0;
-			if (!q[0])
-				break;
-
-			roldatum = hashtab_search(policydb->p_roles.table, q);
-			if (!roldatum) {
-				ERR(NULL, "undefined role %s (%s:%u)",
-				    q, path, lineno);
-				continue;
-			}
-			/* Set the role and every role it dominates */
-			ebitmap_for_each_positive_bit(&roldatum->dominates, rnode, bit) {
-				if (ebitmap_set_bit
-				    (&usrdatum->roles.roles, bit, 1)) {
-					ERR(NULL, "out of memory");
-					free(buffer);
-					fclose(fp);
-					return -1;
-				}
-			}
-		} while (islist);
-		if (oldc == 0)
-			BADLINE();
-
-		if (policydb->mls) {
-			context_struct_t context;
-			char *scontext, *r, *s;
-
-			while (*p && isspace(*p))
-				p++;
-			if (!(*p))
-				BADLINE();
-			if (strncasecmp(p, "level", 5))
-				BADLINE();
-			p += 5;
-			if (!isspace(*p))
-				BADLINE();
-			while (*p && isspace(*p))
-				p++;
-			if (!(*p))
-				BADLINE();
-			q = p;
-			while (*p && (!isspace(*p) || strncasecmp(p + 1, "range", 5)))
-				p++;
-			if (!(*p) || p == q)
-				BADLINE();
-			*p = 0;
-			p++;
-
-			scontext = malloc(p - q);
-			if (!scontext) {
-				ERR(NULL, "out of memory");
-				free(buffer);
-				fclose(fp);
-				return -1;
-			}
-			r = scontext;
-			s = q;
-			while (*s) {
-				if (!isspace(*s))
-					*r++ = *s;
-				s++;
-			}
-			*r = 0;
-			r = scontext;
-
-			context_init(&context);
-			if (mls_context_to_sid(policydb, oldc, &r, &context) <
-			    0) {
-				ERR(NULL, "invalid level %s (%s:%u)", scontext,
-				    path, lineno);
-				free(scontext);
-				continue;
-
-			}
-			free(scontext);
-			memcpy(&usrdatum->dfltlevel, &context.range.level[0],
-			       sizeof(usrdatum->dfltlevel));
-
-			if (strncasecmp(p, "range", 5))
-				BADLINE();
-			p += 5;
-			if (!isspace(*p))
-				BADLINE();
-			while (*p && isspace(*p))
-				p++;
-			if (!(*p))
-				BADLINE();
-			q = p;
-			while (*p && *p != ';')
-				p++;
-			if (!(*p))
-				BADLINE();
-			*p++ = 0;
-
-			scontext = malloc(p - q);
-			if (!scontext) {
-				ERR(NULL, "out of memory");
-				free(buffer);
-				fclose(fp);
-				return -1;
-			}
-			r = scontext;
-			s = q;
-			while (*s) {
-				if (!isspace(*s))
-					*r++ = *s;
-				s++;
-			}
-			*r = 0;
-			r = scontext;
-
-			context_init(&context);
-			if (mls_context_to_sid(policydb, oldc, &r, &context) <
-			    0) {
-				ERR(NULL, "invalid range %s (%s:%u)", scontext,
-				    path, lineno);
-				free(scontext);
-				continue;
-			}
-			free(scontext);
-			memcpy(&usrdatum->range, &context.range,
-			       sizeof(usrdatum->range));
-		}
-	}
-
-	free(buffer);
-	fclose(fp);
-	return 0;
-}
-
-int sepol_genusers(void *data, size_t len,
-		   const char *usersdir, void **newdata, size_t * newlen)
-{
-	struct policydb policydb;
-	char path[PATH_MAX];
-
-	/* Construct policy database */
-	if (policydb_init(&policydb))
-		goto err;
-	if (policydb_from_image(NULL, data, len, &policydb) < 0)
-		goto err;
-
-	/* Load locally defined users. */
-	snprintf(path, sizeof path, "%s/local.users", usersdir);
-	if (load_users(&policydb, path) < 0)
-		goto err_destroy;
-
-	/* Write policy database */
-	if (policydb_to_image(NULL, &policydb, newdata, newlen) < 0)
-		goto err_destroy;
-
-	policydb_destroy(&policydb);
-	return 0;
-
-      err_destroy:
-	policydb_destroy(&policydb);
-
-      err:
-	return -1;
-}
-
-int hidden sepol_genusers_policydb(policydb_t * policydb, const char *usersdir)
-{
-	char path[PATH_MAX];
-
-	/* Load locally defined users. */
-	snprintf(path, sizeof path, "%s/local.users", usersdir);
-	if (load_users(policydb, path) < 0) {
-		ERR(NULL, "unable to load local.users: %s", strerror(errno));
-		return -1;
-	}
-
-	if (policydb_reindex_users(policydb) < 0) {
-		ERR(NULL, "unable to reindex users: %s", strerror(errno));
-		return -1;
-
-	}
-
-	return 0;
-}
-
-/* -- End Deprecated -- */
diff --git a/policycoreutils/load_policy/load_policy.c b/policycoreutils/load_policy/load_policy.c
index 2707d6fe..322ed002 100644
--- a/policycoreutils/load_policy/load_policy.c
+++ b/policycoreutils/load_policy/load_policy.c
@@ -77,7 +77,7 @@ int main(int argc, char **argv)
 		}
 	}
 	else {
-		ret = selinux_mkload_policy(1);
+		ret = selinux_mkload_policy(0);
 	}
 	if (ret < 0) {
 		fprintf(stderr, _("%s:  Can't load policy:  %s\n"),
-- 
2.21.0

