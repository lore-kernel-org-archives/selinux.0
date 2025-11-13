Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D14C33556C
	for <selinux@vger.kernel.org>; Thu, 13 Nov 2025 17:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763053924; cv=none; b=SQg9G65mnP9QznfiXycYuMcl0IofQNLGyVVupnBZxWVOHLr2fxCwHZvTBh/vLlEdy0fbgjm4WJcCW1zsVaMgDzolDOfmdqm+92aVb3ksx/Tb6fzoZQvt/jWc0Q7HpVqVl/uEcygp5SRoPJVvOxghTbQLAHF3Lp63N8IqwAvVOpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763053924; c=relaxed/simple;
	bh=adCNJvHGGUr2CSLJL5zXOXJ7ufRBZ7WTgc5rIPloxKE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eVx82mufhe79tGjjN/HScvtqGk47Sa5Mj1Wfn+wL9d2rLiuly8n1eQNFh4HFVnYtgSZeg0uMwJ/AktOiWT36jEOqdVlzvVHEFPc1KOqw5K4M19O0RuoDvlWDLcLN8rpSJVwp89DhaJvC977Cotg7a8a0cN/5fL26Arjwxgs608s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WTSOC+sW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WTSOC+sW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763053921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9hAhL2FCuuvR8UWIz2VeMi55WYhkJH2CxTpmu+0WMYk=;
	b=WTSOC+sW1d4Jcu4cnzHU65H51HcseaIPcF2rUD+/RgPvVViYz9YQg0A7C5EEgTLyHDiyjR
	O82D0oAlCE27S0scCYde00ZP65smhNzPwWkM0ce+f0CQNHQebIkb3969dCaq6qS1SXQj6F
	szpa5NNT/eWOaZJLyUzSiOxiBAVp9b0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-462-i4eGflhjNFmCx0JTr1UbWA-1; Thu,
 13 Nov 2025 12:12:00 -0500
X-MC-Unique: i4eGflhjNFmCx0JTr1UbWA-1
X-Mimecast-MFC-AGG-ID: i4eGflhjNFmCx0JTr1UbWA_1763053919
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E0C6F195606D
	for <selinux@vger.kernel.org>; Thu, 13 Nov 2025 17:11:58 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.73])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EB613300018D
	for <selinux@vger.kernel.org>; Thu, 13 Nov 2025 17:11:57 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH v2] restorecon: Add option to count relabeled files
Date: Thu, 13 Nov 2025 18:11:34 +0100
Message-ID: <20251113171151.719458-1-vmojzis@redhat.com>
In-Reply-To: <CAFftDdp3ZChoaVF-5FN=O=b09Hv6VSXAUzRQ0muW0NParjZBhA@mail.gmail.com>
References: <CAFftDdp3ZChoaVF-5FN=O=b09Hv6VSXAUzRQ0muW0NParjZBhA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

This is useful in case we want to check that a remediation using
restorecon was successful (otherwise 0 is always returned, even if no
files were relabeled).

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 libselinux/include/selinux/restorecon.h | 15 +++++++++++
 libselinux/src/libselinux.map           |  1 +
 libselinux/src/selinux_restorecon.c     | 34 ++++++++++++++++++++++---
 policycoreutils/setfiles/restore.c      | 12 ++++++---
 policycoreutils/setfiles/restore.h      |  3 ++-
 policycoreutils/setfiles/restorecon.8   |  3 +++
 policycoreutils/setfiles/setfiles.c     | 26 ++++++++++++++-----
 7 files changed, 79 insertions(+), 15 deletions(-)

diff --git a/libselinux/include/selinux/restorecon.h b/libselinux/include/selinux/restorecon.h
index 0ccf73a6..65aaef23 100644
--- a/libselinux/include/selinux/restorecon.h
+++ b/libselinux/include/selinux/restorecon.h
@@ -134,6 +134,11 @@ extern int selinux_restorecon_parallel(const char *pathname,
  */
 #define SELINUX_RESTORECON_SET_USER_ROLE		0x40000
 
+/*
+ * Count the number of relabeled files (or would be relabeled if "nochange" was not set).
+ */
+ #define SELINUX_RESTORECON_COUNT_RELABELED		0x80000
+
 /**
  * selinux_restorecon_set_sehandle - Set the global fc handle.
  * @hndl: specifies handle to set as the global fc handle.
@@ -228,6 +233,16 @@ extern int selinux_restorecon_xattr(const char *pathname,
  */
 extern long unsigned selinux_restorecon_get_skipped_errors(void);
 
+/* selinux_restorecon_get_relabeled_files - Get the number of relabeled files
+ *
+ * If SELINUX_RESTORECON_COUNT_RELABELED was passed to selinux_restorecon(3) or
+ * selinux_restorecon_parallel(3), this function returns the number of files
+ * that were successfully relabeled.
+ * If the SELINUX_RESTORECON_NOCHANGE flag was set, this function returns
+ * the number of files that would be relabeled.
+ */
+extern long unsigned selinux_restorecon_get_relabeled_files(void);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/libselinux/src/libselinux.map b/libselinux/src/libselinux.map
index ab002f01..f21e089e 100644
--- a/libselinux/src/libselinux.map
+++ b/libselinux/src/libselinux.map
@@ -244,6 +244,7 @@ LIBSELINUX_1.0 {
 LIBSELINUX_3.4 {
   global:
     selinux_restorecon_get_skipped_errors;
+    selinux_restorecon_get_relabeled_files;
     selinux_restorecon_parallel;
 } LIBSELINUX_1.0;
 
diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index 681c69db..8fadf4d2 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -69,6 +69,9 @@ static struct dir_xattr *dir_xattr_last;
 /* Number of errors ignored during the file tree walk. */
 static long unsigned skipped_errors;
 
+/* Number of successfully relabeled files or files that would be relabeled */
+static long unsigned relabeled_files;
+
 /* restorecon_flags for passing to restorecon_sb() */
 struct rest_flags {
 	bool nochange;
@@ -88,6 +91,7 @@ struct rest_flags {
 	bool warnonnomatch;
 	bool conflicterror;
 	bool count_errors;
+	bool count_relabeled;
 };
 
 static void restorecon_init(void)
@@ -650,11 +654,12 @@ out:
 }
 
 static int restorecon_sb(const char *pathname, const struct stat *sb,
-			    const struct rest_flags *flags, bool first)
+			    const struct rest_flags *flags, bool first, bool *updated_out)
 {
 	char *newcon = NULL;
 	char *curcon = NULL;
 	int rc;
+	bool updated = false;
 	const char *lookup_path = pathname;
 
 	if (rootpath) {
@@ -736,7 +741,6 @@ static int restorecon_sb(const char *pathname, const struct stat *sb,
 	}
 
 	if (curcon == NULL || strcmp(curcon, newcon) != 0) {
-		bool updated = false;
 
 		if (!flags->set_specctx && curcon &&
 				    (is_context_customizable(curcon) > 0)) {
@@ -796,9 +800,14 @@ static int restorecon_sb(const char *pathname, const struct stat *sb,
 				syslog(LOG_INFO, "labeling %s to %s\n",
 					    pathname, newcon);
 		}
+
+		/* Note: relabel counting handled by caller */
+
 	}
 
 out:
+	if (updated_out)
+		*updated_out = updated;
 	rc = 0;
 out1:
 	freecon(curcon);
@@ -887,6 +896,7 @@ struct rest_state {
 	bool abort;
 	int error;
 	long unsigned skipped_errors;
+	long unsigned relabeled_files;
 	int saved_errno;
 	pthread_mutex_t mutex;
 };
@@ -1010,8 +1020,9 @@ loop_body:
 			if (state->parallel)
 				pthread_mutex_unlock(&state->mutex);
 
+			bool updated = false;
 			error = restorecon_sb(ent_path, &ent_st, &state->flags,
-					      first);
+					      first, &updated);
 
 			if (state->parallel) {
 				pthread_mutex_lock(&state->mutex);
@@ -1030,6 +1041,8 @@ loop_body:
 					state->skipped_errors++;
 				else
 					state->error = error;
+			} else if (updated && state->flags.count_relabeled) {
+				state->relabeled_files++;
 			}
 			break;
 		}
@@ -1087,6 +1100,8 @@ static int selinux_restorecon_common(const char *pathname_orig,
 		    SELINUX_RESTORECON_IGNORE_DIGEST) ? true : false;
 	state.flags.count_errors = (restorecon_flags &
 		    SELINUX_RESTORECON_COUNT_ERRORS) ? true : false;
+	state.flags.count_relabeled = (restorecon_flags &
+		    SELINUX_RESTORECON_COUNT_RELABELED) ? true : false;
 	state.setrestorecondigest = true;
 
 	state.head = NULL;
@@ -1094,6 +1109,7 @@ static int selinux_restorecon_common(const char *pathname_orig,
 	state.abort = false;
 	state.error = 0;
 	state.skipped_errors = 0;
+	state.relabeled_files = 0;
 	state.saved_errno = 0;
 
 	struct stat sb;
@@ -1215,7 +1231,11 @@ static int selinux_restorecon_common(const char *pathname_orig,
 			goto cleanup;
 		}
 
-		error = restorecon_sb(pathname, &sb, &state.flags, true);
+		bool updated = false;
+		error = restorecon_sb(pathname, &sb, &state.flags, true, &updated);
+		if (updated && state.flags.count_relabeled) {
+			state.relabeled_files++;
+		}
 		goto cleanup;
 	}
 
@@ -1341,6 +1361,7 @@ out:
 	(void) fts_close(state.fts);
 	errno = state.saved_errno;
 cleanup:
+	relabeled_files = state.relabeled_files;
 	if (state.flags.add_assoc) {
 		if (state.flags.verbose)
 			filespec_eval();
@@ -1618,3 +1639,8 @@ long unsigned selinux_restorecon_get_skipped_errors(void)
 {
 	return skipped_errors;
 }
+
+long unsigned selinux_restorecon_get_relabeled_files(void)
+{
+	return relabeled_files;
+}
diff --git a/policycoreutils/setfiles/restore.c b/policycoreutils/setfiles/restore.c
index 2c031ccc..07582e7c 100644
--- a/policycoreutils/setfiles/restore.c
+++ b/policycoreutils/setfiles/restore.c
@@ -43,7 +43,7 @@ void restore_init(struct restore_opts *opts)
 			   opts->syslog_changes | opts->log_matches |
 			   opts->ignore_noent | opts->ignore_mounts |
 			   opts->mass_relabel | opts->conflict_error |
-			   opts->count_errors;
+			   opts->count_errors | opts->count_relabeled;
 
 	/* Use setfiles, restorecon and restorecond own handles */
 	selinux_restorecon_set_sehandle(opts->hnd);
@@ -75,7 +75,7 @@ void restore_finish(void)
 }
 
 int process_glob(char *name, struct restore_opts *opts, size_t nthreads,
-		 long unsigned *skipped_errors)
+		 long unsigned *skipped_errors, long unsigned *relabeled_files)
 {
 	glob_t globbuf;
 	size_t i, len;
@@ -99,8 +99,12 @@ int process_glob(char *name, struct restore_opts *opts, size_t nthreads,
 						 nthreads);
 		if (rc < 0)
 			errors = rc;
-		else if (opts->restorecon_flags & SELINUX_RESTORECON_COUNT_ERRORS)
-			*skipped_errors += selinux_restorecon_get_skipped_errors();
+		else {
+			if (opts->restorecon_flags & SELINUX_RESTORECON_COUNT_ERRORS)
+				*skipped_errors += selinux_restorecon_get_skipped_errors();
+			if (opts->restorecon_flags & SELINUX_RESTORECON_COUNT_RELABELED)
+				*relabeled_files += selinux_restorecon_get_relabeled_files();
+		}
 	}
 
 	globfree(&globbuf);
diff --git a/policycoreutils/setfiles/restore.h b/policycoreutils/setfiles/restore.h
index 95afb960..36f73059 100644
--- a/policycoreutils/setfiles/restore.h
+++ b/policycoreutils/setfiles/restore.h
@@ -37,6 +37,7 @@ struct restore_opts {
 	unsigned int ignore_mounts;
 	unsigned int conflict_error;
 	unsigned int count_errors;
+	unsigned int count_relabeled;
 	/* restorecon_flags holds | of above for restore_init() */
 	unsigned int restorecon_flags;
 	char *rootpath;
@@ -52,7 +53,7 @@ void restore_init(struct restore_opts *opts);
 void restore_finish(void);
 void add_exclude(const char *directory);
 int process_glob(char *name, struct restore_opts *opts, size_t nthreads,
-		 long unsigned *skipped_errors);
+		 long unsigned *skipped_errors, long unsigned *relabeled_files);
 extern char **exclude_list;
 
 #endif
diff --git a/policycoreutils/setfiles/restorecon.8 b/policycoreutils/setfiles/restorecon.8
index 1134420e..b7ff9715 100644
--- a/policycoreutils/setfiles/restorecon.8
+++ b/policycoreutils/setfiles/restorecon.8
@@ -153,6 +153,9 @@ display warnings about entries that had no matching files by outputting the
 .BR selabel_stats (3)
 results.
 .TP
+.B \-c
+count and display the number of (would be) relabeled files. The exit code will be set to 0 only if at least one file is relabeled.
+.TP
 .B \-0
 the separator for the input items is assumed to be the null character
 (instead of the white space).  The quotes and the backslash characters are
diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfiles/setfiles.c
index 31034316..351940f3 100644
--- a/policycoreutils/setfiles/setfiles.c
+++ b/policycoreutils/setfiles/setfiles.c
@@ -35,8 +35,8 @@ static __attribute__((__noreturn__)) void usage(const char *const name)
 {
 	if (iamrestorecon) {
 		fprintf(stderr,
-			"usage:  %s [-iIDFUmnprRv0xT] [-e excludedir] pathname...\n"
-			"usage:  %s [-iIDFUmnprRv0xT] [-e excludedir] -f filename\n",
+			"usage:  %s [-ciIDFUmnprRv0xT] [-e excludedir] pathname...\n"
+			"usage:  %s [-ciIDFUmnprRv0xT] [-e excludedir] -f filename\n",
 			name, name);
 	} else {
 		fprintf(stderr,
@@ -146,11 +146,12 @@ int main(int argc, char **argv)
 	size_t buf_len, nthreads = 1;
 	const char *base;
 	int errors = 0;
-	const char *ropts = "e:f:hiIDlmno:pqrsvFURW0xT:";
+	const char *ropts = "ce:f:hiIDlmno:pqrsvFURW0xT:";
 	const char *sopts = "c:de:f:hiIDlmno:pqr:svACEFUR:W0T:";
 	const char *opts;
 	union selinux_callback cb;
 	long unsigned skipped_errors;
+	long unsigned relabeled_files;
 
 	/* Initialize variables */
 	memset(&r_opts, 0, sizeof(r_opts));
@@ -160,6 +161,7 @@ int main(int argc, char **argv)
 	request_digest = 0;
 	policyfile = NULL;
 	skipped_errors = 0;
+	relabeled_files = 0;
 
 	if (!argv[0]) {
 		fprintf(stderr, "Called without required program name!\n");
@@ -223,7 +225,10 @@ int main(int argc, char **argv)
 	while ((opt = getopt(argc, argv, opts)) > 0) {
 		switch (opt) {
 		case 'c':
-			{
+			if (iamrestorecon) {
+				r_opts.count_relabeled = SELINUX_RESTORECON_COUNT_RELABELED;
+				break;
+			} else {
 				FILE *policystream;
 
 				policyfile = optarg;
@@ -457,14 +462,14 @@ int main(int argc, char **argv)
 			if (!strcmp(buf, "/"))
 				r_opts.mass_relabel = SELINUX_RESTORECON_MASS_RELABEL;
 			errors |= process_glob(buf, &r_opts, nthreads,
-					       &skipped_errors) < 0;
+					       &skipped_errors, &relabeled_files) < 0;
 		}
 		if (strcmp(input_filename, "-") != 0)
 			fclose(f);
 	} else {
 		for (i = optind; i < argc; i++)
 			errors |= process_glob(argv[i], &r_opts, nthreads,
-					       &skipped_errors) < 0;
+					       &skipped_errors, &relabeled_files) < 0;
 	}
 
 	if (r_opts.mass_relabel && !r_opts.nochange)
@@ -479,5 +484,14 @@ int main(int argc, char **argv)
 	if (r_opts.progress)
 		fprintf(stdout, "\n");
 
+	/* Output relabeled file count if requested */
+	if (r_opts.count_relabeled) {
+		long unsigned relabeled_count = selinux_restorecon_get_relabeled_files();
+		printf("Relabeled %lu files\n", relabeled_count);
+
+		/* Set exit code to 0 if at least one file was relabeled */
+		exit(errors ? -1 : relabeled_count ? 0 : 1);
+	}
+
 	exit(errors ? -1 : skipped_errors ? 1 : 0);
 }
-- 
2.51.1

