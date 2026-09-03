Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A284BC016
	for <selinux@vger.kernel.org>; Thu,  3 Sep 2026 14:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788446578; cv=none; b=e5SP4c6Xd/8/T6XukQuQ/6c//vy5ch0yjuohlUloEyyuvWdbeD7Ot3oh5/DnqPxh9FBffAHOMqD1cb7jCxxTC3PRhVbW2xhvS39GtcbYDc+B0wucjufDk4uDdvoCjEdH9w/xXPkc6qsZ852kHRyO2aX4UQIpEKB9V6MuwWf5OM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788446578; c=relaxed/simple;
	bh=d5fuBakyaqzqDLar6YCxEnQ2tbiq7ybf97QkXIdiBaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lRKqatTw13wnOlVDGBhwG/VmJ8ugYODKsXnFPfwd/p3ZJpUJfOLZdAQYFWwbyWTVAVhpMPMd78VHMreLwjTOZJCPrfmY3nX/oKtFHcpg09zqU5RKwsYSN1AVEmXN248amHtC7bsx5Vyj9douDhYW0b5kjwNkqA1E8PWwohqCMNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pMDS+0UR; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pMDS+0UR"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5301a453186so20893221cf.2
        for <selinux@vger.kernel.org>; Thu, 03 Sep 2026 07:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788446569; x=1789051369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FZGnijxLP7Mz90y6X+LKXGNHor2z8eF8IWVM90PWIBU=;
        b=pMDS+0URiHucXnmneRMo+wrhN16NgkmbsLa3aTdDV+B6HgnSMPMm8Sxtt0DSF5cj1j
         YNFav7T5slGIoAXa6ChntaGMZ3HuavIsOwbhGyFw9byL3Vvks5B+0+/f626WYF9qeZUf
         km8fp8xxgu2XnXod3M1BTOtxcdSC0HI7MMzc95iXwSLoHI+xMJZBI7wwLjwm14QrlsgF
         6GUXz6gRwb/6KIGTUZtrgKZ3zgFc9uyOjjEqsdBbi8Wv/vapxWYG/66yqAj16GhZBBmv
         06sKC3BHMftYF7VUjT0r2yc3PL52oKjfB4VFKtP/LBKSYPBk+fjCUtwULH2rOklnRVHe
         76rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788446569; x=1789051369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FZGnijxLP7Mz90y6X+LKXGNHor2z8eF8IWVM90PWIBU=;
        b=OTXQT4OjnQ9VxDw1mei/yhpo0TaNn/9gI7MgTmXK8S/V9IYkCZEqsBXbSNdMz4yWpS
         XhqhtIlDSCK3B7ogM/Pqkpg9CncEN9E8GKuL3W+0WHNPNgG2u8xpEzR1Y2vkZDyiM9c/
         zHr5bxWed+2wtStvVMsKaWmt994pHBtQWA1pZlENOt8AQZymRdvelNEc2Vsjb4iWLLAH
         nxFNFNjNJx4/BMXWk1S3rSPb09PQn39cH9TAiGSXR0+ZhB1A6sY55agEqVqI3KE0iYS0
         7xRz2Q7RtNXwosuo4/vl5av+HtOPkdVKM6Y9fLgdoWISelP5cAK55mbqpBIhMR3WzN7b
         UwjA==
X-Gm-Message-State: AFuF++nmkt0NHJIWfAdENIRvARS2l7EGapO8upcJ/KIaVNvls0L/Td7z
	+y0xBtUxwjVMNYQeiX8HbS1RXpyIuSYfLL5yeK3k5zDTq1c7sNT7PDlMIYVgGQ==
X-Gm-Gg: AYBFou04Wqo0ys9aTsHvIS25dySwrN5VblHq4fcgQnuqHm7U6xIEAP+3n7JVBpZZzeu
	uVb99p5AP5B9V36sdMMvkbpDGyJoHaM8a/Up/p6vOvPyZ6tWYLqQz7huFcVOtJNJ+DcA1WidMQQ
	FKXKEu1pIF6zl4mDh6WpUTvj6+H1MBp4zqKYR5VKXiPulsttNGizxOg1NF3JM1S2gAzfvVXJYJB
	LmVmIM4KQh+4yGBT5lpxl/7sXOfy/yv1362uZ7O7LK0P0khUZg7fGTw/sN1XA5voZg71hd1927s
	WQdsu7f12c054kkmkyYMqK7XYE4KrpVZvqAzmpQl7N5PODxaaTI/ULM12msuWw3Vi2eswcdz1tQ
	cu448rTSA7dLJaDKIs/G5DXK3Ur7nxDw+d02VesQPOmPi2SrgQON9OWt1F7GTC6fIziZpPg+i7n
	fKeYNvokAJ6S/9Pv77VOsPtLkczH8reU3k41RUXOcgAl13JBBobCBccgWJSrDA9bIUvaFE27bo2
	thXup0SwIEmLDzX+FI01NzSKAYzGXPs/ZsUy56KEfOisFRWbmgYFkBpq5LEuYsmKQ64LdfH1r0=
X-Received: by 2002:a05:622a:10f:b0:530:3386:6648 with SMTP id d75a77b69052e-53036b92bbcmr135835521cf.10.1788446569003;
        Thu, 03 Sep 2026 07:42:49 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53032ff0e44sm44115851cf.5.2026.09.03.07.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 07:42:48 -0700 (PDT)
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
Subject: [PATCH v4 1/9] libsemanage: accept a list of read-only fallback store roots
Date: Thu,  3 Sep 2026 10:34:26 -0400
Message-ID: <20260903143433.19810-4-stephen.smalley.work@gmail.com>
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

