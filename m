Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67114582E0
	for <selinux@vger.kernel.org>; Thu,  3 Sep 2026 12:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788436808; cv=none; b=bCCW26ok/8vl/OjLmBG3LFIeoWSGxQoJJHccPgUIFSuo3nLBZwoZEovKOciG1XAhsitQ+gTx9cB6bzdzstouiiYsCNMu9Y77lIbMxj5/SJUIeh0IkD7xH0k75fTxDdC1Jg2umgAlWRsNKKlzewYrfGqXP5E6pz+1Al94FhsGiWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788436808; c=relaxed/simple;
	bh=G9GBJ8IUzwfruu1iqpA+xqmN1we9tpfYPoUp0ob+jcI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pJ0As9GojK8hn6zCRMQ2o4U1icpDaZXaj06ObdohMPXwp3FTfDoYxo5KsKP6eBvRwmCvibL3U4pQ1V+NbtI5sgyQfHRWUflMYm0E+uak8+fUxa37oReAEeqekzv0GlLDXpP2X9GrKqLcj3H4bdCVB9eu5ypFDs6z34pZBRaht8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o17rLrUr; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o17rLrUr"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-530187593e0so13546611cf.1
        for <selinux@vger.kernel.org>; Thu, 03 Sep 2026 05:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788436806; x=1789041606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mKvFul/zDVsYqZodfJydlpAa/glhzmyK2fxZIQ5dwFA=;
        b=o17rLrUrvVRR94HnhQxvbfAwsqI3ECStpBG3uMnduMfH8sNJ90EZniGQThi1ayLZRE
         WNvsuINJjw2JM0YwALz8FoOokoSwknmvrAAzSq1WENWsOHyQmxYXTFshF1WHtTIkZk+6
         7xI2Y9pqr43Z8PpZRv/LshmwIL9yzTdV96T/zFnOfdJyOmf7ktmGK6KgHeXfk/cf4s9/
         ZxBmcAjQ/RMm8NZnGpS2IbSRGzqLnfwZi9ENuwD9TlZQ4e8gEaFrp5PFGQHr/yZ1Tblb
         mc2tyw6udfutlQaXEA2k9LFFcVXvUQC4WBUuKyqOnXHghrgzZnW2sT29YNEoUORPzxrG
         DaQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788436806; x=1789041606;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mKvFul/zDVsYqZodfJydlpAa/glhzmyK2fxZIQ5dwFA=;
        b=Zp9iAclN/TMFZJPPj6NMuvHAAdBTBvBa0PxrKiV30zQ4zVxVY/lcNF+UF7yzCOfwa5
         7eCHoctrA9bX/a41vcM9X9CnitSXrCzf0i29GTm5zzvmCK4JEX0S29iSWEiZ8L/Tnb7s
         feQhKRO+DIMwU2p2lueST9u7zqPG5uj+r33ifUe7wY8iDYAmWXF9c5HQikglL9eSKuXE
         rz0pAPJgaHolFOmBIcMiQfCFogka0ilVuWJlGSMW0gHI6fdelOeGGGyGOVgWhQehinWe
         wxc8t6aovfH/b6IgJm2AnoBgXRh9r26U6ys0GNhnD7uEI45NqhVH6AVDGOzQBLWBI6A1
         O0Vg==
X-Gm-Message-State: AFuF++mgZUG9Mm5t8NGi3p5PT8QW2gygWYg8FAbMmQJCKVuPqPu0+Ep4
	ECzceLmHlz0vDQAxoCtoNRJm31F8hxB9AtYzKEPNkNQhYYzQu6TuyOQGtnMDyw==
X-Gm-Gg: AYBFou0QcHrBUoM6p0+OU1L9zkzMKSP8XOs4yv2aftN8WewxA6nmyvfk9jivJpIjJdm
	k8waOcbzKOiYBHwYAzOo6J8w5hUrrthhNX3eGbUMKJK7T90Q6uIuPzeStulU34DLHXCSHmy4a7u
	8Y/1D9ejZoiQKd+x6HXQEikY7C2BNxtebclisB+Zyvx3PbeSJzOTvCaz2agisfdVz5FVoB+P1FF
	8Z7bW4FF6qEiwv6WsddVCVQ9vBYZXni5D5BTu5SLiwrK28ANOkMUaep+9p1fUVPCFv03PhhH1fS
	5JZqUmGAjU67RIJr42hc9pP5Xg9JEsJKIDVE5OcolJSh0gbahGV+u4gQ//0KBC65ysaHSc16mkE
	KkCA29TTkLZAR/np+gm8PPNzlSxYESac3MYaMh6naD9beiuiUkg8IOqo9anwQka++weBrr4awuo
	eaBeJiZ06mNUArdF8tlDvALM8tThQD9Ly5a0ozdVbiL8QMgjHXDmsaxAgMOQEnfk8uNjZF7gSdh
	fUPxT7yxYhi+9BNY2sMtOx6+hanzIq2BsfvAgmGZaPq1efkSi3HfOTkRfsW8vLF
X-Received: by 2002:a05:622a:8413:20b0:530:4773:114d with SMTP id d75a77b69052e-530477313f0mr13168941cf.43.1788436805528;
        Thu, 03 Sep 2026 05:00:05 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530331d9d83sm40638061cf.14.2026.09.03.05.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 05:00:04 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2] libsemanage: optionally sort file_contexts.local by specificity
Date: Thu,  3 Sep 2026 07:59:28 -0400
Message-ID: <20260903115927.17117-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The policy-supplied file_contexts is emitted by the CIL compiler in
least-to-most-specific order (cil_post_filecon_compare()) so that the
libselinux label_file backend, which returns last matching spec, picks
the most specific match. file_contexts.local is written by libsemanage
in the order the entriers were added with semanage fcontext -a, so a
broad entry added after a narrow one overrides it, and callers cannot
rely on "most specific wins" for local customizations.

Add a semanage.conf sort-local-fcontexts boolean. When set to true,
the copy of file_contexts.local installed to the policy directory is
run through semanage_fc_sort(), which uses the same heuristics as
cil_post_filecon_compare(), with equally-specific entries retaining
their insertion order. The module store copy is left in insertion
order, so semanage fcontext -l -C still shows entries as they were
added.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=678577
Fixes: https://github.com/SELinuxProject/selinux/issues/40
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v2 fixes the code formatting.

 libsemanage/man/man5/semanage.conf.5 | 13 ++++++
 libsemanage/src/conf-parse.y         | 15 +++++-
 libsemanage/src/conf-scan.l          |  1 +
 libsemanage/src/direct_api.c         | 19 ++++++--
 libsemanage/src/semanage_conf.h      |  1 +
 libsemanage/src/semanage_store.c     | 70 ++++++++++++++++++++++++++++
 libsemanage/src/semanage_store.h     |  2 +
 7 files changed, 116 insertions(+), 5 deletions(-)

diff --git a/libsemanage/man/man5/semanage.conf.5 b/libsemanage/man/man5/semanage.conf.5
index 74f0d34f..336e02d0 100644
--- a/libsemanage/man/man5/semanage.conf.5
+++ b/libsemanage/man/man5/semanage.conf.5
@@ -131,6 +131,19 @@ It can be set to either "true" or "false" and by default it is set to "true".
 When set to "true", duplicate type, type attribute, and role declarations will be allowed.
 It can be set to either "true" or "false" and by default it is set to "true".
 
+.TP
+.B sort-local-fcontexts
+When set to "true", the installed
+.I file_contexts.local
+file is sorted from least to most specific using the same heuristic as the policy-supplied
+.IR file_contexts ,
+so the most specific local entry wins regardless of the order the entries were added with
+.BR "semanage fcontext \-a" .
+The module store copy (and thus
+.BR "semanage fcontext \-l \-C" )
+is unaffected.
+It can be set to either "true" or "false" and by default it is set to "false", preserving insertion-order matching.
+
 .RE
 .PP
 For certain tasks the SELinux Management library resorts to running
diff --git a/libsemanage/src/conf-parse.y b/libsemanage/src/conf-parse.y
index dee17b2f..ba75a1ec 100644
--- a/libsemanage/src/conf-parse.y
+++ b/libsemanage/src/conf-parse.y
@@ -62,7 +62,7 @@ static int parse_errors;
         char *s;
 }
 
-%token MODULE_STORE VERSION EXPAND_CHECK FILE_MODE SAVE_PREVIOUS SAVE_LINKED TARGET_PLATFORM COMPILER_DIR IGNORE_MODULE_CACHE STORE_ROOT OPTIMIZE_POLICY MULTIPLE_DECLS
+%token MODULE_STORE VERSION EXPAND_CHECK FILE_MODE SAVE_PREVIOUS SAVE_LINKED TARGET_PLATFORM COMPILER_DIR IGNORE_MODULE_CACHE STORE_ROOT OPTIMIZE_POLICY MULTIPLE_DECLS SORT_LOCAL_FCONTEXTS
 %token LOAD_POLICY_START SETFILES_START SEFCONTEXT_COMPILE_START DISABLE_GENHOMEDIRCON HANDLE_UNKNOWN USEPASSWD IGNOREDIRS
 %token BZIP_BLOCKSIZE BZIP_SMALL RELABEL_STORE REMOVE_HLL
 %token VERIFY_MOD_START VERIFY_LINKED_START VERIFY_KERNEL_START BLOCK_END
@@ -101,6 +101,7 @@ single_opt:     module_store
 	|	relabel_store
 	|	optimize_policy
 	|	multiple_decls
+        |       sort_local_fcontexts
         ;
 
 module_store:   MODULE_STORE '=' ARG {
@@ -329,6 +330,17 @@ multiple_decls:  MULTIPLE_DECLS '=' ARG {
 	free($3);
 }
 
+sort_local_fcontexts: SORT_LOCAL_FCONTEXTS '=' ARG {
+	if (strcasecmp($3, "false") == 0) {
+		current_conf->sort_local_fcontexts = false;
+	} else if (strcasecmp($3, "true") == 0) {
+		current_conf->sort_local_fcontexts = true;
+	} else {
+		yyerror("sort-local-fcontexts can only be 'true' or 'false'");
+	}
+	free($3);
+}
+
 command_block:
                 command_start external_opts BLOCK_END  {
                         if (new_external->path == NULL) {
@@ -425,6 +437,7 @@ static int semanage_conf_init(semanage_conf_t * conf)
 	conf->relabel_store = true;
 	conf->optimize_policy = true;
 	conf->multiple_decls = true;
+	conf->sort_local_fcontexts = false;
 
 	conf->save_previous = false;
 	conf->save_linked = false;
diff --git a/libsemanage/src/conf-scan.l b/libsemanage/src/conf-scan.l
index c592fb63..8d1d56ac 100644
--- a/libsemanage/src/conf-scan.l
+++ b/libsemanage/src/conf-scan.l
@@ -57,6 +57,7 @@ remove-hll	return REMOVE_HLL;
 relabel_store	return RELABEL_STORE;
 optimize-policy return OPTIMIZE_POLICY;
 multiple-decls return MULTIPLE_DECLS;
+sort-local-fcontexts return SORT_LOCAL_FCONTEXTS;
 "[load_policy]"   return LOAD_POLICY_START;
 "[setfiles]"      return SETFILES_START;
 "[sefcontext_compile]"      return SEFCONTEXT_COMPILE_START;
diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index 132e2a2a..be4a1bd3 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -1675,10 +1675,21 @@ static int semanage_direct_commit(semanage_handle_t *sh)
 		goto cleanup;
 	}
 
-	retval = copy_file_if_exists(
-		sh, semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_FC_LOCAL),
-		semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_FC_LOCAL),
-		sh->conf->file_mode);
+	if (sh->conf->sort_local_fcontexts) {
+		retval = semanage_sort_fc_file(
+			sh,
+			semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_FC_LOCAL),
+			semanage_final_path(SEMANAGE_FINAL_TMP,
+					    SEMANAGE_FC_LOCAL),
+			sh->conf->file_mode);
+	} else {
+		retval = copy_file_if_exists(
+			sh,
+			semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_FC_LOCAL),
+			semanage_final_path(SEMANAGE_FINAL_TMP,
+					    SEMANAGE_FC_LOCAL),
+			sh->conf->file_mode);
+	}
 	if (retval < 0) {
 		goto cleanup;
 	}
diff --git a/libsemanage/src/semanage_conf.h b/libsemanage/src/semanage_conf.h
index 5a24ea87..d8544dc9 100644
--- a/libsemanage/src/semanage_conf.h
+++ b/libsemanage/src/semanage_conf.h
@@ -51,6 +51,7 @@ typedef struct semanage_conf {
 	bool optimize_policy;
 	bool multiple_decls;
 	bool relabel_store;
+	bool sort_local_fcontexts;
 	char *ignoredirs; /* ";" separated of list for genhomedircon to ignore */
 	struct external_prog *load_policy;
 	struct external_prog *setfiles;
diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index f6ca1afb..a8c050b6 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -1605,6 +1605,76 @@ cleanup:
 	return retval;
 }
 
+/*
+ * Read file-context specifications from @src, sort them from least
+ * to most specific using the same heuristic as the policy-supplied
+ * file_contexts (see semanage_fc_compare()), and write the result to
+ * @dst. Comments in @src are dropped; the auto-generated header is
+ * re-emitted. A missing @src is not an error.
+ */
+int semanage_sort_fc_file(semanage_handle_t *sh, const char *src,
+			  const char *dst, mode_t mode)
+{
+	const char *header = "# This file is auto-generated by libsemanage\n"
+			     "# Do not edit directly.\n\n";
+	struct file_contents contents = {};
+	char *sorted = NULL;
+	size_t sorted_len = 0;
+	int out = -1, retval = -1;
+	mode_t mask;
+
+	if (access(src, F_OK) != 0)
+		return (errno == ENOENT) ? 0 : -1;
+
+	if (map_compressed_file(sh, src, &contents) < 0) {
+		ERR(sh, "Could not read %s.", src);
+		return -1;
+	}
+
+	if (contents.len > 0 &&
+	    semanage_fc_sort(sh, contents.data, contents.len, &sorted,
+			     &sorted_len) < 0) {
+		ERR(sh, "Could not sort file contexts from %s.", src);
+		goto cleanup;
+	}
+
+	if (!mode)
+		mode = S_IRUSR | S_IWUSR;
+	mask = umask(0);
+	out = open(dst, O_WRONLY | O_CREAT | O_TRUNC | O_CLOEXEC, mode);
+	umask(mask);
+	if (out < 0) {
+		ERR(sh, "Could not open %s for writing.", dst);
+		goto cleanup;
+	}
+	if (write_full(out, header, strlen(header)) < 0) {
+		ERR(sh, "Write to %s failed.", dst);
+		goto cleanup;
+	}
+
+	if (sorted && sorted_len > 1 &&
+	    write_full(out, sorted, sorted_len - 1) < 0) {
+		ERR(sh, "Write to %s failed.", dst);
+		goto cleanup;
+	}
+
+	if (close(out) < 0 && errno != EINTR) {
+		out = -1;
+		goto cleanup;
+	}
+	out = -1;
+
+	semanage_setfiles(sh, dst);
+	retval = 0;
+
+cleanup:
+	if (out >= 0)
+		close(out);
+	free(sorted);
+	unmap_compressed_file(&contents);
+	return retval;
+}
+
 static int sefcontext_compile(semanage_handle_t *sh, const char *path)
 {
 	int r;
diff --git a/libsemanage/src/semanage_store.h b/libsemanage/src/semanage_store.h
index 86ae0936..34805951 100644
--- a/libsemanage/src/semanage_store.h
+++ b/libsemanage/src/semanage_store.h
@@ -156,6 +156,8 @@ int semanage_split_fc(semanage_handle_t *sh);
 /* sort file context routines */
 int semanage_fc_sort(semanage_handle_t *sh, const char *buf, size_t buf_len,
 		     char **sorted_buf, size_t *sorted_buf_len);
+int semanage_sort_fc_file(semanage_handle_t *sh, const char *src,
+			  const char *dst, mode_t mode);
 
 /* sort netfilter context routines */
 int semanage_nc_sort(semanage_handle_t *sh, const char *buf, size_t buf_len,
-- 
2.55.0

