Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CB33A48C5
	for <selinux@vger.kernel.org>; Wed,  2 Sep 2026 19:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788378627; cv=none; b=T8xDq2DB5g42/M5fQI3T/ZfaCVKGTBAgqYmTfn9ce0VLRHlKYkUHIl491xryrSNZ22DyNmSfFqztpSWuplzOOhNzj8Q22d+WLGmLc/aLqXTh9lyNNmhzRrv8NQ4QnNrmGR8Vnc4f8hd9mYol0s+Nzit3CP8NJeyOFAq9SFnuMw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788378627; c=relaxed/simple;
	bh=A6GEYNJFmoVnHyPgdufQmWKTg1ote0BnIpag9bxpFIA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JBiNpev9TNjX/nWXj+eE1dCam/MIfVk8bjDOUwMSqjQzT3aqOxDlfcrnvNVhaJDv08WDvYYnOTbx9Jc4zRf/dvsfQjvY95u35OtQV8r3aQbsN3Z7XIna+7q782fk2s8AumCO+867EGt6bpWlI/mHS3sipQgfOKEpv3xBnEYrrzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NjHcFhNm; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NjHcFhNm"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-52ff0eea420so2919981cf.0
        for <selinux@vger.kernel.org>; Wed, 02 Sep 2026 12:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788378620; x=1788983420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pzWUSczOi9yLOlL0klfd0lj8Xxw15DO6hhmCd6Et+Cc=;
        b=NjHcFhNmq5n0s/WomdTbofLGHX4irNmK00OTOza+GG799AtdyaDcXW13DGpihgYgfE
         7D21h/SaEGhlx6QfPqjpkgyZrfDOh91E//vV1AHDzPDjFPxeT/NxGjfIzCS7iCrm4VH6
         xZoSEV9ueL7EFSme8ry04myze+OrHYPaoEhobYTvlFpwT6B/PA+Q/wvFrcAusrhgG+AN
         7FAjoSb/nmM09qexoDKS+om9Olumo5VrXvCmKnt+MKI9q6gJvnhJtfQINb55XxNj4oAN
         AtBF/8lrLrkJNtSsfrQlrt+a64fCXk7xV9Udb2UEcbEZVQjevPA6LWf8RBQ1rS1iERPc
         zwEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788378620; x=1788983420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pzWUSczOi9yLOlL0klfd0lj8Xxw15DO6hhmCd6Et+Cc=;
        b=q+jiNdzbc9kTCuKcCrgZYzZHIax8Shz/hANauhmnFPRfJPgMYMsB6NhZFAO935u8bp
         cnnlTiDhRVNLwHoKVtmNZGrgNk2SwI3VQInt4MQKfXsD01yAXiLNUGQPZM6RmE0ONbUf
         PdHvV8rCr+2nbvAFYTQi/DQU2R6Wxol+yoqGis9ycjyp4KV9fVW//fjg9N8q9/Cs/+18
         +XST0ObiRF8lYcU2AdSXTZ/q+4zS/9Dooxhj3AssqO54eqtxJvQSU9JVhkwT7u91MA1q
         YhjtFLfe+R3Rd7MHmfd22LuNh58R6pKiiYFtJoBkLx2U9SFLNbXQkH2cZgm8V9Z92MT0
         Pihg==
X-Gm-Message-State: AFuF++mNRxuIgXMogWapZgDAn40H2HQlAo2OmAGUInUR4pUd3jBlpr6k
	gCL+byUEhaohzXbK4lYUuBKPv2XCrusY06Hb0arLwhbczcUceScw5bn+h59n3A==
X-Gm-Gg: AYBFou33Mt08jH2l+vYDIhpg21b700kJBMS+XmjCmS8LqRsnKVh09gfGeSe6BijzfMW
	reLpl/PB+N/PJNR+jMbYnWHs0yFrEB1Ml65VV/XPS1ojQ8uuFNHVciGaFDQnjbKVJU+xceCZ9sU
	LGTNaND3qO+AllmIRZ1lTKPX+8Z0MHPhSJ3vzIL3Z9zz/jCXOhWKqMk38WHd3VaI3KBrVW7C80S
	0skVKno7pnYjvaeI617lZ/Q1fUtY3Mu6hgiNbjnng0q5nAaBVXLa1eAVx1Nfngv9AZVMlS6TV2x
	VcrgMydQwgxnDfk2WvuLFZIG/Ky83O+w4aHLE4ISOr4D3ObKx/DtgSL18MynwqLLixEvdo2c8UI
	kLRVZPYoEVgeOEkdDWEq1nVIpM+8bbbITAVlJ4JfsxSo5ZVzwtPvO+TXbIZ6jaZzHaY439+J01D
	RnVZO7X+HdECqQNjP6XAivIjb2EPydbDVXHFFXyEK7BA/a8WAzFNHIFe9VZ7ID9Utqk84nQgTXC
	iDz5gB4oF7Hqg6C45i4tCJROKBz1yuS1xu3w0V+NVLxPcdlhUrLQyYVWSwQ0O0r
X-Received: by 2002:ac8:7d0b:0:b0:50e:474a:47e1 with SMTP id d75a77b69052e-530431af04fmr19433811cf.10.1788378620154;
        Wed, 02 Sep 2026 12:50:20 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90e9ef0ef6csm25330456d6.44.2026.09.02.12.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 12:50:19 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] libsemanage: optionally sort file_contexts.local by specificity
Date: Wed,  2 Sep 2026 15:50:04 -0400
Message-ID: <20260902195004.12254-1-stephen.smalley.work@gmail.com>
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
 libsemanage/man/man5/semanage.conf.5 | 13 ++++++
 libsemanage/src/conf-parse.y         | 15 +++++-
 libsemanage/src/conf-scan.l          |  1 +
 libsemanage/src/direct_api.c         | 16 +++++--
 libsemanage/src/semanage_conf.h      |  1 +
 libsemanage/src/semanage_store.c     | 70 ++++++++++++++++++++++++++++
 libsemanage/src/semanage_store.h     |  2 +
 7 files changed, 113 insertions(+), 5 deletions(-)

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
index 132e2a2a..14880081 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -1675,10 +1675,18 @@ static int semanage_direct_commit(semanage_handle_t *sh)
 		goto cleanup;
 	}
 
-	retval = copy_file_if_exists(
-		sh, semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_FC_LOCAL),
-		semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_FC_LOCAL),
-		sh->conf->file_mode);
+	if (sh->conf->sort_local_fcontexts) {
+		retval = semanage_sort_fc_file(sh,
+			semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_FC_LOCAL),
+			semanage_final_path(SEMANAGE_FINAL_TMP,
+					SEMANAGE_FC_LOCAL),
+					sh->conf->file_mode);
+	} else {
+		retval = copy_file_if_exists(
+			sh, semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_FC_LOCAL),
+			semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_FC_LOCAL),
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
index f6ca1afb..5471abdd 100644
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
+			const char *dst, mode_t mode)
+{
+	const char *header = "# This file is auto-generated by libsemanage\n"
+		"# Do not edit directly.\n\n";
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
+		semanage_fc_sort(sh, contents.data, contents.len,
+				&sorted, &sorted_len) < 0) {
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
+		write_full(out, sorted, sorted_len - 1) < 0) {
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
index 86ae0936..1fe122ec 100644
--- a/libsemanage/src/semanage_store.h
+++ b/libsemanage/src/semanage_store.h
@@ -156,6 +156,8 @@ int semanage_split_fc(semanage_handle_t *sh);
 /* sort file context routines */
 int semanage_fc_sort(semanage_handle_t *sh, const char *buf, size_t buf_len,
 		     char **sorted_buf, size_t *sorted_buf_len);
+int semanage_sort_fc_file(semanage_handle_t *sh, const char *src,
+			const char *dst, mode_t mode);
 
 /* sort netfilter context routines */
 int semanage_nc_sort(semanage_handle_t *sh, const char *buf, size_t buf_len,
-- 
2.55.0

