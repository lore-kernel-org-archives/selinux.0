Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0846361DB8
	for <selinux@vger.kernel.org>; Wed,  2 Sep 2026 13:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788356762; cv=none; b=SxPaP2Yyw669qqxncWy+a/F9COYcYRdvgnh7xihp1AV2+b5j7coJEEGBThL04ZH3VSd6MW8eByDeAcC/IyvApLe97L6ZP5JKQAJ2s0uSOxSgJob95SAphSoSKS/8Omjo4k+6PJBLQYqtwKnCw/jwxHkkr5NwCfq3140eI3DZkXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788356762; c=relaxed/simple;
	bh=d5fuBakyaqzqDLar6YCxEnQ2tbiq7ybf97QkXIdiBaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cc3sL2TBWjMu34zkLeGtKUoXMiuhP39H8RDNxSkwsXBc1F9UHQLbnHVpUwinWJNVyIOpYP0EiEzodpiU6jMZ8c07Qll+8y5gueRbC/X6Es+4piKWGD1tWIJNhK9iLyNYSJ0Y8Ve8gwYLCPYE0SAq8+Xb3Hd2Q1yLAz2B8mRh2eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PN42Ihs8; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PN42Ihs8"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5276d598b96so9046291cf.3
        for <selinux@vger.kernel.org>; Wed, 02 Sep 2026 06:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788356760; x=1788961560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FZGnijxLP7Mz90y6X+LKXGNHor2z8eF8IWVM90PWIBU=;
        b=PN42Ihs8MWYmZT3x0tQFmcs4Ob1rfZqkxk+Bz0qoItVCMTPiGeU9LKZE46YcU5dBP0
         SJ8eNuxyafJr3aKkmSV0QIQKcoXxiQp0WNIsqlYBERaqT6Z1l5mE9l6KCryzLasaZi6c
         8g9Fh0sLdxpe2vhpwo+7fNeMEs/ymIKRUjk8J15snXre6WhNx5IIFJi7oy0bLQv427Vf
         S04GFSnhbWGLLkj9wV3UBO2FyHBsrma/rAd4OZiLutou4b4Jf+KA6GwobQp1e8zmz+ct
         S2ymIDkfqjJDFVxiYkFOVyn7SaeQ78iSDeRSJDFBZegE6KrMM51GdIiM9hkyOwVCQ5e8
         uI3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788356760; x=1788961560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FZGnijxLP7Mz90y6X+LKXGNHor2z8eF8IWVM90PWIBU=;
        b=cx19LAp/LHuZRgIf1FLSLJkiA5/opi6zFEIW4ff9nocbjkPY7a/CcJd4PhsdBwm1HH
         gfBiap/lASYkO4vIIK7onyLdy3vlr8bwP9cTQvV0+WyTx1Qzi0kz614piJPH8vwq8zW6
         rfinnLAkjjklrL65eMBtt4Sc5qGZ4/x1FLRy+0xX6N1efN9Puf/qEJvEMq9fij3TVW1z
         CNNvdXQnyvDHmTxm7nEwt1BhB2p3JpyC5PWS9W7stw/CVu67LMfed4ovufFRqxe3tttI
         WeT5ROnv3IG+iXO0HwL9jIT3cooydUGzdDfsuKfyREcBsr2//Wo+VXEMo6n88NckXuvm
         ZDyw==
X-Gm-Message-State: AFuF++nKzWO1Xk/YiheO4q20bYa5MjgYlRw7J64ZJpCopKmpsSNFTQI1
	tKgC1gqRBxEoM2YIXJBhGzu8nthywJmM0I7sW/qmfGutq0Ulvk5KHwC2Xw1pcA==
X-Gm-Gg: AR+sD10e7K+i6Tj7LIZ21waB5mLqUtTj5vJX3dfU5sODOLZINrv0Foc+DlwtiHdc1bs
	2XrUCNB5ySeEIUodibW2pcf5v2KAzcZt1ztPklqejqDKeOIhHRDzqgCk/UTys8m9iirzCawZOYV
	Rzffb+G0dh2+dvRCzjKXNK8aAN0FJ3bJ5IwBklBdueEF5+S54Dze89hZ6XsPDy1Mn627CErP+oa
	LNf+DcuUsBBVOb7b8ti6ac2y4RT9JICEL3BaaDhH7q+V1E4rRc+hQaVAd3Gz+NaMBn8m81KBZr1
	0FawrkpxkQyWMOmLT3KAWNPKFasA8Jhz3PVVJj0SJx0M9MEukkBx1He9wT5EDc8J97fccik68fE
	p+le/PfdqRmJcxAysY+Re2n03XAlvbnRHwaUS+yYaQRXGKqJMKr1wKHu7pY6oK0mdNShVe2TX1B
	Xq1FKp6FbK6bflcqlCMwR5xZA+o4bGCn5qTbbQhgVyNLKEqp8Y65oIIssvKLrIgjBGxMTvCueIu
	D4RjVbawbgIFhCHzPuIQBt1TZJTHSbfvMwyDOC9Oa9drM1mLEXg6thYwr2xTXud
X-Received: by 2002:a05:622a:1493:b0:51c:1c73:5943 with SMTP id d75a77b69052e-53036ce39demr52558871cf.23.1788356759584;
        Wed, 02 Sep 2026 06:45:59 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5303325af1esm18686011cf.29.2026.09.02.06.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 06:45:59 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 1/9] libsemanage: accept a list of read-only fallback store roots
Date: Wed,  2 Sep 2026 09:33:09 -0400
Message-ID: <20260902133316.51981-3-stephen.smalley.work@gmail.com>
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

