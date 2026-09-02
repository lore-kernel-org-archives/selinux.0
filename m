Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98328330B3F
	for <selinux@vger.kernel.org>; Wed,  2 Sep 2026 14:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788357813; cv=none; b=L+kKyWy3JSetC2+SOJw9VJ3DVvyt8D3lUsfVlSifJSqrNWwyCsx7NCew2YeyRLbt6zJ6bH864koMMx7ZIcAVC1Xyvs6qAaMRIcHBU20rcNl00sZIBP5i+RdN3BQzbLxdO8DlEqIkLT5k8TOiNWEWilq4iqsZEoWK3ZrMIcz9/8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788357813; c=relaxed/simple;
	bh=d5fuBakyaqzqDLar6YCxEnQ2tbiq7ybf97QkXIdiBaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RO/BKPs+fw0kwMFR93vRSNoeFadKYVPrjaD/iqMfcO8+v5VuEBzQCrAbelHzPmEUeqdF0aqEsjJkJwMGm/MSReV2KKSt9kvoELV9D0ESlMqohmLqM0i89yIOXC8DYzdyoas6Qs71SJiXSDlzzB8A6IR+Vbbd+IJBg8z0pqTpFf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=stGgHiRO; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="stGgHiRO"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-910316a2fc9so2370836d6.2
        for <selinux@vger.kernel.org>; Wed, 02 Sep 2026 07:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788357810; x=1788962610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FZGnijxLP7Mz90y6X+LKXGNHor2z8eF8IWVM90PWIBU=;
        b=stGgHiRObfZRJZWqZ4PTyhXmewJuvgHqdDbXfQ7s5WigLKCcEhy+uOWtPMm0EHE0qd
         ncNkLlt4ioeHHUgSxFxrYdGbK1CFYeDtYm2VKAIDG2YIV5Tdc4dHbaxx0UKjVRT6G2h0
         /jLcSOuLW2MsD+v6yx04HHfKRStFpMSXwUER9q42v2Y/kJxytSabkUZdGMedtwDEZpQu
         aZ258um8nZdCWB5/hVzvFJqS3PEYhPVvBBId8SZJqW2qUDIR8VyvrWs1AEvZpjaNRVgH
         7bsLepSDCJOT+RLbfFS3PHP44P/y+NT49hc95SLPwdzmJYsuwu9Njt57JRIBEGRtzV4U
         RU2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788357810; x=1788962610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FZGnijxLP7Mz90y6X+LKXGNHor2z8eF8IWVM90PWIBU=;
        b=Odap5dwCPXLs2GCspzrD3r4/llre+dL/sC55m065ekO8xTG9q8Z2BTDaGhSRqucClD
         ufu3ckSW/JOnETXx/2HLZCM9hlzc9TpiE00T4hrJi2NtAT2+ct0E6hI/Dw5bMMh0ugMK
         cjZderph+GZXyfX/zuwXmXkXFcWB1kQaBHHbnj6LKTuke2f2A4UVWCTStBsxkwP56vzI
         /1Rk1xKm063eUxAl1CQL3cwnvg/9woBj0Nvy1WsiUbWs9x7P84IPgL79/074U9oYjZ1c
         ckIV1Lmt8o+IcUF0wK1DI7f2X5SJDS86IHxr6L2eXaZzFGgHsOvOiM6d0poklfbXzS31
         2mVw==
X-Gm-Message-State: AFuF++lYUqmIQUneOORp02PaDCC+gdJWSc9Fg6y97SgJCasY25LSdSMU
	Jg71rtAUx2e7HexSVT3WM5cX6dLBMM9lXDm5dMa/m2utrhJk8rkDdCPgCY/qeQ==
X-Gm-Gg: AYBFou1JnjJWSRqeZZ3XFv7NQz+8bjWfsgUp/WZX23ACXWNB9Yk1kA6dOO4UaBSMHZ0
	2YaRdKVkHrEyPKja4/pWJgiTvAHeXstahav4mIYjp9e+lJ39V0dzGykGYRi6mI7RkBSioF9jBtx
	2AjpkYTeAbEqbrIclKKNgEdlhlPtL/zUFKypICihE9L+zRhuapMP9MXgrTjEeacu0gZNGbqJvpj
	QpXi/Kg95/Fo+zrnGHp6yGCSTbAbyTBTgRfTHVDgOhV9XVw2yXU5T6JUyeSL5esOx+/HE+8vQ13
	1JZXS+AASLSXr1cOOUCF45/i0OVQYaZMXSOzUrTX4cLrUDYGnkqqlZsIeo1HxNAxtXIDqL9XX8m
	ph4RmiYEQ7pgmXlJnFO2jcLx58S/KQmFxcQLZ6BJcDRWvc1SpeXHzUtVzFI1C1wP57VGOxTZIEZ
	4bmUjeu5NakUalIfo11G6eAeTClUvYqfsqSrLv2tqNpLER2A9fFlCK5uDYpHfa5Xkx+Cj+hZ5de
	n4wdOI4pZAJBGvMd9GpcW+QbPBI/lmuGdo0ihLMq1mRco4b5rc3CQVjBoOPOOyU
X-Received: by 2002:a05:6214:460b:b0:90e:945e:61d2 with SMTP id 6a1803df08f44-90eb6c5e9a9mr68003476d6.15.1788357810068;
        Wed, 02 Sep 2026 07:03:30 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90e9ee316f7sm18790446d6.19.2026.09.02.07.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 07:03:29 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 1/9] libsemanage: accept a list of read-only fallback store roots
Date: Wed,  2 Sep 2026 10:02:03 -0400
Message-ID: <20260902140211.53084-3-stephen.smalley.work@gmail.com>
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

Add a semanage.conf option:

    ro-store-root = /usr/lib/selinux[:/another/root...]

naming one or more read-only module-store roots to search after
store-root when reading. Only the ACTIVE tree of a fallback root
is used - TMP/PREVIOUS and both lock files stay in the writable
store. With no ro-store-root the behavior is unchanged.

New helper functions:

    semanage_ro_root_count() - number of RO roots
    semanage_ro_active_path(i, X) - <ro_root_i>/<type>/active/<X>
    semanage_path_read(store, X) - for ACTIVE, first-existing across
    			           [store-root, ro-store-root...];
				   for TMP/PREVIOUS, semanage_path()

The subsequent patches switch the ACTIVE readers to
semanage_path_read(), teach module enumeration to union across the
roots, and stop the sandbox from copying anything but the writable
ACTIVE, so /var (or /etc, depending on store-root configuration) holds
only the admin delta over a vendor /usr/lib store.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsemanage/src/conf-parse.y     | 57 +++++++++++++++++++++++-
 libsemanage/src/conf-scan.l      |  1 +
 libsemanage/src/semanage_conf.h  |  2 +
 libsemanage/src/semanage_store.c | 76 ++++++++++++++++++++++++++++++++
 libsemanage/src/semanage_store.h |  6 +++
 5 files changed, 141 insertions(+), 1 deletion(-)

diff --git a/libsemanage/src/conf-parse.y b/libsemanage/src/conf-parse.y
index dee17b2f..264ccf70 100644
--- a/libsemanage/src/conf-parse.y
+++ b/libsemanage/src/conf-parse.y
@@ -43,6 +43,7 @@ extern char *semanage_text;
 
 static int parse_module_store(char *arg);
 static int parse_store_root_path(char *arg);
+static int parse_ro_store_root_paths(char *arg);
 static int parse_compiler_path(char *arg);
 static void semanage_conf_external_prog_destroy(external_prog_t *ep);
 static int new_external_prog(external_prog_t **chain);
@@ -62,7 +63,7 @@ static int parse_errors;
         char *s;
 }
 
-%token MODULE_STORE VERSION EXPAND_CHECK FILE_MODE SAVE_PREVIOUS SAVE_LINKED TARGET_PLATFORM COMPILER_DIR IGNORE_MODULE_CACHE STORE_ROOT OPTIMIZE_POLICY MULTIPLE_DECLS
+%token MODULE_STORE VERSION EXPAND_CHECK FILE_MODE SAVE_PREVIOUS SAVE_LINKED TARGET_PLATFORM COMPILER_DIR IGNORE_MODULE_CACHE STORE_ROOT RO_STORE_ROOT OPTIMIZE_POLICY MULTIPLE_DECLS
 %token LOAD_POLICY_START SETFILES_START SEFCONTEXT_COMPILE_START DISABLE_GENHOMEDIRCON HANDLE_UNKNOWN USEPASSWD IGNOREDIRS
 %token BZIP_BLOCKSIZE BZIP_SMALL RELABEL_STORE REMOVE_HLL
 %token VERIFY_MOD_START VERIFY_LINKED_START VERIFY_KERNEL_START BLOCK_END
@@ -85,6 +86,7 @@ single_opt:     module_store
         |       version
         |       target_platform
         |       store_root
+        |       ro_store_root
         |       compiler_dir
         |       ignore_module_cache
         |       expand_check
@@ -122,6 +124,15 @@ store_root:     STORE_ROOT '=' ARG  {
                 }
         ;
 
+ro_store_root:  RO_STORE_ROOT '=' ARG  {
+                        if (parse_ro_store_root_paths($3) != 0) {
+                                parse_errors++;
+                                YYABORT;
+                        }
+                        free($3);
+                }
+        ;
+
 compiler_dir:       COMPILER_DIR '=' ARG  {
                         if (parse_compiler_path($3) != 0) {
                                 parse_errors++;
@@ -534,6 +545,9 @@ void semanage_conf_destroy(semanage_conf_t * conf)
 		free(conf->store_path);
 		free(conf->ignoredirs);
 		free(conf->store_root_path);
+		while (conf->n_ro_store_roots)
+			free(conf->ro_store_root_paths[--conf->n_ro_store_roots]);
+		free(conf->ro_store_root_paths);
 		free(conf->compiler_directory_path);
 		semanage_conf_external_prog_destroy(conf->load_policy);
 		semanage_conf_external_prog_destroy(conf->setfiles);
@@ -612,6 +626,47 @@ static int parse_store_root_path(char *arg)
 	return 0;
 }
 
+/* ro-store-root = /usr/lib/selinux[:/another/root...] */
+static int parse_ro_store_root_paths(char *arg)
+{
+	char *p, *saveptr = NULL;
+	unsigned int n = 0;
+	char **v;
+
+	if (arg == NULL) {
+		return -1;
+	}
+
+	for (p = arg; *p; p++)
+		if (*p == ':')
+			n++;
+	n++;
+
+	v = calloc(n, sizeof(*v));
+	if (!v)
+		return -1;
+
+	n = 0;
+	for (p = strtok_r(arg, ":", &saveptr); p;
+	     p = strtok_r(NULL, ":", &saveptr)) {
+		v[n] = strdup(p);
+		if (!v[n]) {
+			while (n)
+				free(v[--n]);
+			free(v);
+			return -1;
+		}
+		n++;
+	}
+
+	while (current_conf->n_ro_store_roots)
+		free(current_conf->ro_store_root_paths[--current_conf->n_ro_store_roots]);
+	free(current_conf->ro_store_root_paths);
+	current_conf->ro_store_root_paths = v;
+	current_conf->n_ro_store_roots = n;
+	return 0;
+}
+
 static int parse_compiler_path(char *arg)
 {
 	if (arg == NULL) {
diff --git a/libsemanage/src/conf-scan.l b/libsemanage/src/conf-scan.l
index c592fb63..d3f74b66 100644
--- a/libsemanage/src/conf-scan.l
+++ b/libsemanage/src/conf-scan.l
@@ -39,6 +39,7 @@ static char *my_qstrdup (char * s);
 #.*               /* ignore comments */
 module-store      return MODULE_STORE;
 store-root        return STORE_ROOT;
+ro-store-root     return RO_STORE_ROOT;
 compiler-directory	return COMPILER_DIR;
 ignore-module-cache return IGNORE_MODULE_CACHE;
 policy-version    return VERSION;
diff --git a/libsemanage/src/semanage_conf.h b/libsemanage/src/semanage_conf.h
index 5a24ea87..b2059962 100644
--- a/libsemanage/src/semanage_conf.h
+++ b/libsemanage/src/semanage_conf.h
@@ -57,6 +57,8 @@ typedef struct semanage_conf {
 	struct external_prog *sefcontext_compile;
 	struct external_prog *mod_prog, *linked_prog, *kernel_prog;
 	char *store_root_path;
+	char **ro_store_root_paths;
+	unsigned int n_ro_store_roots;
 } semanage_conf_t;
 
 /* A linked list of verification programs.  Each one is called in
diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index f6ca1afb..187fd6b6 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -76,6 +76,9 @@ enum semanage_file_defs {
 
 static char *semanage_paths[SEMANAGE_NUM_STORES][SEMANAGE_STORE_NUM_PATHS];
 static char *semanage_files[SEMANAGE_NUM_FILES] = { NULL };
+
+static char **semanage_ro_active_paths;
+static unsigned int semanage_n_ro_roots;
 static int semanage_paths_initialized = 0;
 
 /* These are paths relative to the bottom of the module store */
@@ -203,6 +206,33 @@ static int semanage_init_store_paths(const char *root)
 	return 0;
 }
 
+static int semanage_init_ro_store_paths(semanage_handle_t *sh)
+{
+	unsigned int i, j, n = sh->conf->n_ro_store_roots;
+
+	if (n == 0)
+		return 0;
+
+	semanage_ro_active_paths = calloc((size_t)n * SEMANAGE_STORE_NUM_PATHS,
+					  sizeof(*semanage_ro_active_paths));
+	if (!semanage_ro_active_paths)
+		return -1;
+
+	for (i = 0; i < n; i++)
+		for (j = 0; j < SEMANAGE_STORE_NUM_PATHS; j++) {
+			if (asprintf(&semanage_ro_active_paths
+					     [i * SEMANAGE_STORE_NUM_PATHS + j],
+				     "%s%s/%s%s%s", semanage_root(),
+				     sh->conf->ro_store_root_paths[i],
+				     sh->conf->store_path,
+				     semanage_store_paths[SEMANAGE_ACTIVE],
+				     semanage_sandbox_paths[j]) < 0)
+				return -1;
+		}
+	semanage_n_ro_roots = n;
+	return 0;
+}
+
 static int semanage_init_final(semanage_handle_t *sh, const char *prefix)
 {
 	assert(sh);
@@ -410,6 +440,10 @@ int semanage_check_init(semanage_handle_t *sh, const char *prefix)
 		if (rc)
 			return rc;
 
+		rc = semanage_init_ro_store_paths(sh);
+		if (rc)
+			return rc;
+
 		rc = semanage_init_final(sh, prefix);
 		if (rc)
 			return rc;
@@ -448,6 +482,48 @@ const char *semanage_path(enum semanage_store_defs store,
 	return semanage_paths[store][path_name];
 }
 
+/* Number of read-only fallback store roots. */
+unsigned int semanage_ro_root_count(void)
+{
+	return semanage_n_ro_roots;
+}
+
+/*
+ * ACTIVE path in the @idx-th read-only fallback root (0-based).
+ * Returns NULL if no such root; the caller must not alter the string.
+ */
+const char *semanage_ro_active_path(unsigned int idx,
+				    enum semanage_sandbox_defs file)
+{
+	if (idx >= semanage_n_ro_roots)
+		return NULL;
+	return semanage_ro_active_paths[idx * SEMANAGE_STORE_NUM_PATHS + file];
+}
+
+/*
+ * First-existing of the writable ACTIVE path and each RO ACTIVE path,
+ * for read-side lookups. For TMP/PREVIOUS, or when no fallback root
+ * has the file, this is semanage_path(store, file) so callers that
+ * then create the file use the writable store.
+ */
+const char *semanage_path_read(enum semanage_store_defs store,
+			       enum semanage_sandbox_defs file)
+{
+	const char *path = semanage_path(store, file);
+	unsigned int i;
+
+	if (store != SEMANAGE_ACTIVE || access(path, F_OK) == 0)
+		return path;
+
+	for (i = 0; i < semanage_n_ro_roots; i++) {
+		const char *ropath = semanage_ro_active_path(i, file);
+
+		if (ropath && access(ropath, F_OK) == 0)
+			return ropath;
+	}
+	return path;
+}
+
 /* Given a store location (tmp or selinux) and a definition
  * number, return a fully-qualified path to that file or directory.
  * The caller must not alter the string returned (and hence why this
diff --git a/libsemanage/src/semanage_store.h b/libsemanage/src/semanage_store.h
index 86ae0936..36cef62c 100644
--- a/libsemanage/src/semanage_store.h
+++ b/libsemanage/src/semanage_store.h
@@ -101,6 +101,12 @@ extern const char *semanage_fname(enum semanage_sandbox_defs file_enum);
 extern const char *semanage_path(enum semanage_store_defs store,
 				 enum semanage_sandbox_defs file);
 
+extern unsigned int semanage_ro_root_count(void);
+extern const char *semanage_ro_active_path(unsigned int idx,
+					   enum semanage_sandbox_defs file);
+extern const char *semanage_path_read(enum semanage_store_defs store,
+				      enum semanage_sandbox_defs file);
+
 extern const char *semanage_final_path(enum semanage_final_defs root,
 				       enum semanage_final_path_defs suffix);
 
-- 
2.55.0

