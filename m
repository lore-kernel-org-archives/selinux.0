Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B60CBC4332F
	for <selinux@archiver.kernel.org>; Tue, 19 Oct 2021 15:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B91A60FDA
	for <selinux@archiver.kernel.org>; Tue, 19 Oct 2021 15:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbhJSPDt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 Oct 2021 11:03:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32853 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233225AbhJSPDr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 19 Oct 2021 11:03:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634655693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EBJCrTjODRRPPsou+k/TPRZL99DVAN1mrhK42NTVPRE=;
        b=CuT5xmNrh75zKhBZ6aYQVwq5wCsJAaoKTmfAf4HYSZNeebwRmNq7zKsKPkk7B1BeR5Gyq2
        wqYjIlkl650+1CswJvNRsyHVy1NEWZutQ3XnkHPDjMd2fYrYBmtN+NXbqrV2XBe2SmGUKE
        c1z5XTY1YrpdiUNmEMAbcLZQZH7Ivp0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-zgGTJaz_NP-PbRr0dhcAMQ-1; Tue, 19 Oct 2021 11:01:32 -0400
X-MC-Unique: zgGTJaz_NP-PbRr0dhcAMQ-1
Received: by mail-wm1-f70.google.com with SMTP id s25-20020a7bc399000000b0030da0f36afeso1272479wmj.1
        for <selinux@vger.kernel.org>; Tue, 19 Oct 2021 08:01:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EBJCrTjODRRPPsou+k/TPRZL99DVAN1mrhK42NTVPRE=;
        b=j4PTN13nzYcQ7LKvlnlPt8tOTEzcWGuGtMZa+QL9gddOMtUjowglbYHS4uoD39NO7j
         EwdeyyBFJyqL7ySdpTcYw7c6wro0GeD5G7+wIX9B+9LNMjHknqr5WnMn0TXytiYm3wYw
         KrYa5ipPdHC05zg9phJzWtrlCsXHUW7s5RXcy8NKRWRM1YbJkesqBPvcnbHqd2Hrtykq
         H1P00J22YF6pYhDYUEBU/4NICIoFmqBzzsc691V9ekBkmK88rT85ag8KdNY2Fgib6yrQ
         9G5+B7gKqIiXTYf+1jdd583/M+xe0Plp2FV59s7R5R3s5DzDwBz4GL8lQ6czgQFiHBwD
         8N4w==
X-Gm-Message-State: AOAM530nqr72x0TCyuMVVP9BSk2bfyu/4tCUce0uB3DQNXlLd2sFkO0R
        IquD9e1JKgkpdghGQpMR9dWARMFEIp3tQOLRbxH4+dne9UFwZdty181OXKdcoAwx6FoY/U0CYgX
        +sWz94WQSdqax+fyoDZV1Yi0zG9gAB69F3jeOaC54j+QnK58mq4tpmkUjJo7r9jvy8mEcgw==
X-Received: by 2002:a05:600c:2159:: with SMTP id v25mr6476092wml.175.1634655690246;
        Tue, 19 Oct 2021 08:01:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyzzX/lARSU27rlo21/PzVBjf4vxaKaOKWKg/2U4w69lwgWK25ljSENk639nFHUBFxWEv4b0Q==
X-Received: by 2002:a05:600c:2159:: with SMTP id v25mr6475955wml.175.1634655689334;
        Tue, 19 Oct 2021 08:01:29 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id r4sm19271630wrz.58.2021.10.19.08.01.28
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 08:01:28 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace v3 6/7] selinux_restorecon: introduce selinux_restorecon_parallel(3)
Date:   Tue, 19 Oct 2021 17:01:21 +0200
Message-Id: <20211019150122.459722-7-omosnace@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211019150122.459722-1-omosnace@redhat.com>
References: <20211019150122.459722-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Refactor selinux_restorecon(3) to allow for distributing the relabeling
to multiple threads and add a new function
selinux_restorecon_parallel(3), which allows specifying the number of
threads to use. The existing selinux_restorecon(3) function maintains
the same interface and maintains the same behavior (i.e. relabeling is
done on a single thread).

The parallel implementation takes a simple approach of performing all
the directory tree traversal in a critical section and only letting the
relabeling of individual objects run in parallel. Thankfully, this
approach turns out to be efficient enough in practice, as shown by
restorecon benchmarks (detailed in a subsequent patch that switches
setfiles & restorecon to use selinux_restorecon_parallel(3)).

Note that to be able to use the parallelism, the calling application/
library must be explicitly linked to the libpthread library (statically
or dynamically). This is necessary to mantain the requirement that
libselinux shouldn't explicitly link with libpthread. (I don't know what
exactly was the reason behind this requirement as the commit logs are
fuzzy, but special care has been taken in the past to maintain it, so I
didn't want to break it...)

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 libselinux/include/selinux/restorecon.h       |  14 +
 libselinux/man/man3/selinux_restorecon.3      |  29 ++
 .../man/man3/selinux_restorecon_parallel.3    |   1 +
 libselinux/src/libselinux.map                 |   5 +
 libselinux/src/selinux_internal.h             |  16 +
 libselinux/src/selinux_restorecon.c           | 436 ++++++++++++------
 libselinux/src/selinuxswig_python.i           |   6 +-
 libselinux/src/selinuxswig_python_exception.i |   8 +
 8 files changed, 368 insertions(+), 147 deletions(-)
 create mode 100644 libselinux/man/man3/selinux_restorecon_parallel.3

diff --git a/libselinux/include/selinux/restorecon.h b/libselinux/include/selinux/restorecon.h
index 466de39a..1821a3dc 100644
--- a/libselinux/include/selinux/restorecon.h
+++ b/libselinux/include/selinux/restorecon.h
@@ -2,6 +2,7 @@
 #define _RESTORECON_H_
 
 #include <sys/types.h>
+#include <stddef.h>
 #include <stdarg.h>
 
 #ifdef __cplusplus
@@ -23,6 +24,19 @@ extern "C" {
  */
 extern int selinux_restorecon(const char *pathname,
 				    unsigned int restorecon_flags);
+/**
+ * selinux_restorecon_parallel - Relabel files, optionally use more threads.
+ * @pathname: specifies file/directory to relabel.
+ * @restorecon_flags: specifies the actions to be performed when relabeling.
+ * @nthreads: specifies the number of threads to use (0 = use number of CPUs
+ *            currently online)
+ *
+ * Same as selinux_restorecon(3), but allows to use multiple threads to do
+ * the work.
+ */
+extern int selinux_restorecon_parallel(const char *pathname,
+				       unsigned int restorecon_flags,
+				       size_t nthreads);
 /*
  * restorecon_flags options
  */
diff --git a/libselinux/man/man3/selinux_restorecon.3 b/libselinux/man/man3/selinux_restorecon.3
index ad637406..334d2930 100644
--- a/libselinux/man/man3/selinux_restorecon.3
+++ b/libselinux/man/man3/selinux_restorecon.3
@@ -11,6 +11,14 @@ selinux_restorecon \- restore file(s) default SELinux security contexts
 .br
 .BI "unsigned int " restorecon_flags ");"
 .in
+.sp
+.BI "int selinux_restorecon_parallel(const char *" pathname ,
+.in +\w'int selinux_restorecon_parallel('u
+.br
+.BI "unsigned int " restorecon_flags ","
+.br
+.BI "size_t " nthreads ");"
+.in
 .
 .SH "DESCRIPTION"
 .BR selinux_restorecon ()
@@ -187,6 +195,27 @@ unless the
 .B SELINUX_RESTORECON_IGNORE_MOUNTS
 flag has been set.
 .RE
+.sp
+.BR selinux_restorecon_parallel()
+is similar to
+.BR selinux_restorecon (3),
+but accepts another parameter that allows to run relabeling over multiple
+threads:
+.sp
+.RS
+.IR nthreads
+specifies the number of threads to use during relabeling. When set to 1,
+the behavior is the same as calling
+.BR selinux_restorecon (3).
+When set to 0, the function will try to use as many threads as there are
+online CPU cores. When set to any other number, the function will try to use
+the given number of threads.
+.sp
+Note that to use the parallel relabeling capability, the calling process
+must be linked with the
+.B libpthread
+library (either at compile time or dynamically at run time). Otherwise the
+function will print a warning and fall back to the single threaded mode.
 .
 .SH "RETURN VALUE"
 On success, zero is returned.  On error, \-1 is returned and
diff --git a/libselinux/man/man3/selinux_restorecon_parallel.3 b/libselinux/man/man3/selinux_restorecon_parallel.3
new file mode 100644
index 00000000..092d8412
--- /dev/null
+++ b/libselinux/man/man3/selinux_restorecon_parallel.3
@@ -0,0 +1 @@
+.so man3/selinux_restorecon.3
diff --git a/libselinux/src/libselinux.map b/libselinux/src/libselinux.map
index 2a368e93..d138e951 100644
--- a/libselinux/src/libselinux.map
+++ b/libselinux/src/libselinux.map
@@ -240,3 +240,8 @@ LIBSELINUX_1.0 {
   local:
     *;
 };
+
+LIBSELINUX_3.3 {
+  global:
+    selinux_restorecon_parallel;
+} LIBSELINUX_1.0;
diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux_internal.h
index 27e9ac53..297dcf26 100644
--- a/libselinux/src/selinux_internal.h
+++ b/libselinux/src/selinux_internal.h
@@ -69,6 +69,22 @@ extern int selinux_page_size ;
 			pthread_mutex_unlock(LOCK);		\
 	} while (0)
 
+#pragma weak pthread_create
+#pragma weak pthread_join
+#pragma weak pthread_cond_init
+#pragma weak pthread_cond_signal
+#pragma weak pthread_cond_destroy
+#pragma weak pthread_cond_wait
+
+/* check if all functions needed to do parallel operations are available */
+#define __pthread_supported (					\
+	pthread_create &&					\
+	pthread_join &&						\
+	pthread_cond_init &&					\
+	pthread_cond_destroy &&					\
+	pthread_cond_signal &&					\
+	pthread_cond_wait					\
+)
 
 #define SELINUXDIR "/etc/selinux/"
 #define SELINUXCONFIG SELINUXDIR "config"
diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index 252b775f..72f4fb46 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -610,7 +610,7 @@ out:
 }
 
 static int restorecon_sb(const char *pathname, const struct stat *sb,
-			    struct rest_flags *flags)
+			    struct rest_flags *flags, bool first)
 {
 	char *newcon = NULL;
 	char *curcon = NULL;
@@ -639,7 +639,7 @@ static int restorecon_sb(const char *pathname, const struct stat *sb,
 						    sb->st_mode);
 
 	if (rc < 0) {
-		if (errno == ENOENT && flags->warnonnomatch)
+		if (errno == ENOENT && flags->warnonnomatch && first)
 			selinux_log(SELINUX_INFO,
 				    "Warning no default label for %s\n",
 				    lookup_path);
@@ -814,66 +814,215 @@ oom:
 	goto free;
 }
 
+struct rest_state {
+	struct rest_flags flags;
+	dev_t dev_num;
+	struct statfs sfsb;
+	bool ignore_digest;
+	bool setrestorecondigest;
+	bool parallel;
 
-/*
- * Public API
- */
+	FTS *fts;
+	FTSENT *ftsent_first;
+	struct dir_hash_node *head, *current;
+	bool abort;
+	int error;
+	int saved_errno;
+	pthread_mutex_t mutex;
+};
 
-/* selinux_restorecon(3) - Main function that is responsible for labeling */
-int selinux_restorecon(const char *pathname_orig,
-		       unsigned int restorecon_flags)
+static void *selinux_restorecon_thread(void *arg)
 {
-	struct rest_flags flags;
+	struct rest_state *state = arg;
+	FTS *fts = state->fts;
+	FTSENT *ftsent;
+	int error;
+	char ent_path[PATH_MAX];
+	struct stat ent_st;
+	bool first = false;
+
+	if (state->parallel)
+		pthread_mutex_lock(&state->mutex);
+
+	if (state->ftsent_first) {
+		ftsent = state->ftsent_first;
+		state->ftsent_first = NULL;
+		first = true;
+		goto loop_body;
+	}
+
+	while (((void)(errno = 0), ftsent = fts_read(fts)) != NULL) {
+loop_body:
+		/* If the FTS_XDEV flag is set and the device is different */
+		if (state->flags.set_xdev &&
+		    ftsent->fts_statp->st_dev != state->dev_num)
+			continue;
+
+		switch (ftsent->fts_info) {
+		case FTS_DC:
+			selinux_log(SELINUX_ERROR,
+				    "Directory cycle on %s.\n",
+				    ftsent->fts_path);
+			errno = ELOOP;
+			state->error = -1;
+			state->abort = true;
+			goto finish;
+		case FTS_DP:
+			continue;
+		case FTS_DNR:
+			error = errno;
+			errno = ftsent->fts_errno;
+			selinux_log(SELINUX_ERROR,
+				    "Could not read %s: %m.\n",
+				    ftsent->fts_path);
+			errno = error;
+			fts_set(fts, ftsent, FTS_SKIP);
+			continue;
+		case FTS_NS:
+			error = errno;
+			errno = ftsent->fts_errno;
+			selinux_log(SELINUX_ERROR,
+				    "Could not stat %s: %m.\n",
+				    ftsent->fts_path);
+			errno = error;
+			fts_set(fts, ftsent, FTS_SKIP);
+			continue;
+		case FTS_ERR:
+			error = errno;
+			errno = ftsent->fts_errno;
+			selinux_log(SELINUX_ERROR,
+				    "Error on %s: %m.\n",
+				    ftsent->fts_path);
+			errno = error;
+			fts_set(fts, ftsent, FTS_SKIP);
+			continue;
+		case FTS_D:
+			if (state->sfsb.f_type == SYSFS_MAGIC &&
+			    !selabel_partial_match(fc_sehandle,
+			    ftsent->fts_path)) {
+				fts_set(fts, ftsent, FTS_SKIP);
+				continue;
+			}
+
+			if (check_excluded(ftsent->fts_path)) {
+				fts_set(fts, ftsent, FTS_SKIP);
+				continue;
+			}
 
-	flags.nochange = (restorecon_flags &
+			if (state->setrestorecondigest) {
+				struct dir_hash_node *new_node = NULL;
+
+				if (check_context_match_for_dir(ftsent->fts_path,
+								&new_node,
+								state->error) &&
+								!state->ignore_digest) {
+					selinux_log(SELINUX_INFO,
+						"Skipping restorecon on directory(%s)\n",
+						    ftsent->fts_path);
+					fts_set(fts, ftsent, FTS_SKIP);
+					continue;
+				}
+
+				if (new_node && !state->error) {
+					if (!state->current) {
+						state->current = new_node;
+						state->head = state->current;
+					} else {
+						state->current->next = new_node;
+						state->current = new_node;
+					}
+				}
+			}
+			/* fall through */
+		default:
+			strcpy(ent_path, ftsent->fts_path);
+			ent_st = *ftsent->fts_statp;
+			if (state->parallel)
+				pthread_mutex_unlock(&state->mutex);
+
+			error = restorecon_sb(ent_path, &ent_st, &state->flags,
+					      first);
+
+			if (state->parallel) {
+				pthread_mutex_lock(&state->mutex);
+				if (state->abort)
+					goto unlock;
+			}
+
+			state->error |= error;
+			first = false;
+			if (error && state->flags.abort_on_error) {
+				state->abort = true;
+				goto finish;
+			}
+			break;
+		}
+	}
+
+finish:
+	if (!state->saved_errno)
+		state->saved_errno = errno;
+unlock:
+	if (state->parallel)
+		pthread_mutex_unlock(&state->mutex);
+	return NULL;
+}
+
+static int selinux_restorecon_common(const char *pathname_orig,
+				     unsigned int restorecon_flags,
+				     size_t nthreads)
+{
+	struct rest_state state;
+
+	state.flags.nochange = (restorecon_flags &
 		    SELINUX_RESTORECON_NOCHANGE) ? true : false;
-	flags.verbose = (restorecon_flags &
+	state.flags.verbose = (restorecon_flags &
 		    SELINUX_RESTORECON_VERBOSE) ? true : false;
-	flags.progress = (restorecon_flags &
+	state.flags.progress = (restorecon_flags &
 		    SELINUX_RESTORECON_PROGRESS) ? true : false;
-	flags.mass_relabel = (restorecon_flags &
+	state.flags.mass_relabel = (restorecon_flags &
 		    SELINUX_RESTORECON_MASS_RELABEL) ? true : false;
-	flags.recurse = (restorecon_flags &
+	state.flags.recurse = (restorecon_flags &
 		    SELINUX_RESTORECON_RECURSE) ? true : false;
-	flags.set_specctx = (restorecon_flags &
+	state.flags.set_specctx = (restorecon_flags &
 		    SELINUX_RESTORECON_SET_SPECFILE_CTX) ? true : false;
-	flags.userealpath = (restorecon_flags &
+	state.flags.userealpath = (restorecon_flags &
 		   SELINUX_RESTORECON_REALPATH) ? true : false;
-	flags.set_xdev = (restorecon_flags &
+	state.flags.set_xdev = (restorecon_flags &
 		   SELINUX_RESTORECON_XDEV) ? true : false;
-	flags.add_assoc = (restorecon_flags &
+	state.flags.add_assoc = (restorecon_flags &
 		   SELINUX_RESTORECON_ADD_ASSOC) ? true : false;
-	flags.abort_on_error = (restorecon_flags &
+	state.flags.abort_on_error = (restorecon_flags &
 		   SELINUX_RESTORECON_ABORT_ON_ERROR) ? true : false;
-	flags.syslog_changes = (restorecon_flags &
+	state.flags.syslog_changes = (restorecon_flags &
 		   SELINUX_RESTORECON_SYSLOG_CHANGES) ? true : false;
-	flags.log_matches = (restorecon_flags &
+	state.flags.log_matches = (restorecon_flags &
 		   SELINUX_RESTORECON_LOG_MATCHES) ? true : false;
-	flags.ignore_noent = (restorecon_flags &
+	state.flags.ignore_noent = (restorecon_flags &
 		   SELINUX_RESTORECON_IGNORE_NOENTRY) ? true : false;
-	flags.warnonnomatch = true;
-	flags.conflicterror = (restorecon_flags &
+	state.flags.warnonnomatch = true;
+	state.flags.conflicterror = (restorecon_flags &
 		   SELINUX_RESTORECON_CONFLICT_ERROR) ? true : false;
 	ignore_mounts = (restorecon_flags &
 		   SELINUX_RESTORECON_IGNORE_MOUNTS) ? true : false;
-	bool ignore_digest = (restorecon_flags &
+	state.ignore_digest = (restorecon_flags &
 		    SELINUX_RESTORECON_IGNORE_DIGEST) ? true : false;
-	bool setrestorecondigest = true;
+	state.setrestorecondigest = true;
+
+	state.head = NULL;
+	state.current = NULL;
+	state.abort = false;
+	state.error = 0;
+	state.saved_errno = 0;
 
 	struct stat sb;
-	struct statfs sfsb;
-	FTS *fts;
-	FTSENT *ftsent;
 	char *pathname = NULL, *pathdnamer = NULL, *pathdname, *pathbname;
 	char *paths[2] = { NULL, NULL };
 	int fts_flags, error, sverrno;
-	dev_t dev_num = 0;
 	struct dir_hash_node *current = NULL;
-	struct dir_hash_node *head = NULL;
-	int errno_tmp;
 
-	if (flags.verbose && flags.progress)
-		flags.verbose = false;
+	if (state.flags.verbose && state.flags.progress)
+		state.flags.verbose = false;
 
 	__selinux_once(fc_once, restorecon_init);
 
@@ -886,13 +1035,31 @@ int selinux_restorecon(const char *pathname_orig,
 	 */
 	if (selabel_no_digest ||
 	    (restorecon_flags & SELINUX_RESTORECON_SKIP_DIGEST))
-		setrestorecondigest = false;
+		state.setrestorecondigest = false;
+
+	if (!__pthread_supported) {
+		if (nthreads != 1) {
+			nthreads = 1;
+			selinux_log(SELINUX_WARNING,
+				"Threading functionality not available, falling back to 1 thread.");
+		}
+	} else if (nthreads == 0) {
+		long nproc = sysconf(_SC_NPROCESSORS_ONLN);
+
+		if (nproc > 0) {
+			nthreads = nproc;
+		} else {
+			nthreads = 1;
+			selinux_log(SELINUX_WARNING,
+				"Unable to detect CPU count, falling back to 1 thread.");
+		}
+	}
 
 	/*
 	 * Convert passed-in pathname to canonical pathname by resolving
 	 * realpath of containing dir, then appending last component name.
 	 */
-	if (flags.userealpath) {
+	if (state.flags.userealpath) {
 		char *basename_cpy = strdup(pathname_orig);
 		if (!basename_cpy)
 			goto realpatherr;
@@ -937,7 +1104,7 @@ int selinux_restorecon(const char *pathname_orig,
 	paths[0] = pathname;
 
 	if (lstat(pathname, &sb) < 0) {
-		if (flags.ignore_noent && errno == ENOENT) {
+		if (state.flags.ignore_noent && errno == ENOENT) {
 			free(pathdnamer);
 			free(pathname);
 			return 0;
@@ -952,21 +1119,21 @@ int selinux_restorecon(const char *pathname_orig,
 
 	/* Skip digest if not a directory */
 	if (!S_ISDIR(sb.st_mode))
-		setrestorecondigest = false;
+		state.setrestorecondigest = false;
 
-	if (!flags.recurse) {
+	if (!state.flags.recurse) {
 		if (check_excluded(pathname)) {
 			error = 0;
 			goto cleanup;
 		}
 
-		error = restorecon_sb(pathname, &sb, &flags);
+		error = restorecon_sb(pathname, &sb, &state.flags, true);
 		goto cleanup;
 	}
 
 	/* Obtain fs type */
-	memset(&sfsb, 0, sizeof sfsb);
-	if (!S_ISLNK(sb.st_mode) && statfs(pathname, &sfsb) < 0) {
+	memset(&state.sfsb, 0, sizeof(state.sfsb));
+	if (!S_ISLNK(sb.st_mode) && statfs(pathname, &state.sfsb) < 0) {
 		selinux_log(SELINUX_ERROR,
 			    "statfs(%s) failed: %m\n",
 			    pathname);
@@ -975,21 +1142,21 @@ int selinux_restorecon(const char *pathname_orig,
 	}
 
 	/* Skip digest on in-memory filesystems and /sys */
-	if (sfsb.f_type == RAMFS_MAGIC || sfsb.f_type == TMPFS_MAGIC ||
-	    sfsb.f_type == SYSFS_MAGIC)
-		setrestorecondigest = false;
+	if (state.sfsb.f_type == RAMFS_MAGIC || state.sfsb.f_type == TMPFS_MAGIC ||
+	    state.sfsb.f_type == SYSFS_MAGIC)
+		state.setrestorecondigest = false;
 
-	if (flags.set_xdev)
+	if (state.flags.set_xdev)
 		fts_flags = FTS_PHYSICAL | FTS_NOCHDIR | FTS_XDEV;
 	else
 		fts_flags = FTS_PHYSICAL | FTS_NOCHDIR;
 
-	fts = fts_open(paths, fts_flags, NULL);
-	if (!fts)
+	state.fts = fts_open(paths, fts_flags, NULL);
+	if (!state.fts)
 		goto fts_err;
 
-	ftsent = fts_read(fts);
-	if (!ftsent)
+	state.ftsent_first = fts_read(state.fts);
+	if (!state.ftsent_first)
 		goto fts_err;
 
 	/*
@@ -1001,106 +1168,66 @@ int selinux_restorecon(const char *pathname_orig,
 	 * directories with a different device number when the FTS_XDEV flag
 	 * is set (from http://marc.info/?l=selinux&m=124688830500777&w=2).
 	 */
-	dev_num = ftsent->fts_statp->st_dev;
+	state.dev_num = state.ftsent_first->fts_statp->st_dev;
 
-	error = 0;
-	do {
-		/* If the FTS_XDEV flag is set and the device is different */
-		if (flags.set_xdev && ftsent->fts_statp->st_dev != dev_num)
-			continue;
+	if (nthreads == 1) {
+		state.parallel = false;
+		selinux_restorecon_thread(&state);
+	} else {
+		size_t i;
+		pthread_t self = pthread_self();
+		pthread_t *threads = NULL;
 
-		switch (ftsent->fts_info) {
-		case FTS_DC:
-			selinux_log(SELINUX_ERROR,
-				    "Directory cycle on %s.\n",
-				    ftsent->fts_path);
-			errno = ELOOP;
-			error = -1;
-			goto out;
-		case FTS_DP:
-			continue;
-		case FTS_DNR:
-			errno_tmp = errno;
-			errno = ftsent->fts_errno;
-			selinux_log(SELINUX_ERROR,
-				    "Could not read %s: %m.\n",
-				    ftsent->fts_path);
-			errno = errno_tmp;
-			fts_set(fts, ftsent, FTS_SKIP);
-			continue;
-		case FTS_NS:
-			errno_tmp = errno;
-			errno = ftsent->fts_errno;
-			selinux_log(SELINUX_ERROR,
-				    "Could not stat %s: %m.\n",
-				    ftsent->fts_path);
-			errno = errno_tmp;
-			fts_set(fts, ftsent, FTS_SKIP);
-			continue;
-		case FTS_ERR:
-			errno_tmp = errno;
-			errno = ftsent->fts_errno;
-			selinux_log(SELINUX_ERROR,
-				    "Error on %s: %m.\n",
-				    ftsent->fts_path);
-			errno = errno_tmp;
-			fts_set(fts, ftsent, FTS_SKIP);
-			continue;
-		case FTS_D:
-			if (sfsb.f_type == SYSFS_MAGIC &&
-			    !selabel_partial_match(fc_sehandle,
-			    ftsent->fts_path)) {
-				fts_set(fts, ftsent, FTS_SKIP);
-				continue;
-			}
+		pthread_mutex_init(&state.mutex, NULL);
 
-			if (check_excluded(ftsent->fts_path)) {
-				fts_set(fts, ftsent, FTS_SKIP);
-				continue;
+		threads = calloc(nthreads - 1, sizeof(*threads));
+		if (!threads)
+			goto oom;
+
+		state.parallel = true;
+		/*
+		 * Start (nthreads - 1) threads - the main thread is going to
+		 * take part, too.
+		 */
+		for (i = 0; i < nthreads - 1; i++) {
+			if (pthread_create(&threads[i], NULL,
+					   selinux_restorecon_thread, &state)) {
+				/*
+				 * If any thread fails to be created, just mark
+				 * it as such and let the successfully created
+				 * threads do the job. In the worst case the
+				 * main thread will do everything, but that's
+				 * still better than to give up.
+				 */
+				threads[i] = self;
 			}
+		}
 
-			if (setrestorecondigest) {
-				struct dir_hash_node *new_node = NULL;
+		/* Let's join in on the fun! */
+		selinux_restorecon_thread(&state);
 
-				if (check_context_match_for_dir(ftsent->fts_path,
-								&new_node,
-								error) &&
-								!ignore_digest) {
-					selinux_log(SELINUX_INFO,
-						    "Skipping restorecon on directory(%s)\n",
-						    ftsent->fts_path);
-					fts_set(fts, ftsent, FTS_SKIP);
-					continue;
-				}
-
-				if (new_node && !error) {
-					if (!current) {
-						current = new_node;
-						head = current;
-					} else {
-						current->next = new_node;
-						current = current->next;
-					}
-				}
-			}
-			/* fall through */
-		default:
-			error |= restorecon_sb(ftsent->fts_path,
-					       ftsent->fts_statp, &flags);
-			if (flags.warnonnomatch)
-				flags.warnonnomatch = false;
-			if (error && flags.abort_on_error)
-				goto out;
-			break;
+		/* Now wait for all threads to finish. */
+		for (i = 0; i < nthreads - 1; i++) {
+			/* Skip threads that failed to be created. */
+			if (pthread_equal(threads[i], self))
+				continue;
+			pthread_join(threads[i], NULL);
 		}
-	} while ((ftsent = fts_read(fts)) != NULL);
+		free(threads);
+
+		pthread_mutex_destroy(&state.mutex);
+	}
+
+	error = state.error;
+	if (state.saved_errno)
+		goto out;
 
 	/*
 	 * Labeling successful. Write partial match digests for subdirectories.
 	 * TODO: Write digest upon FTS_DP if no error occurs in its descents.
 	 */
-	if (setrestorecondigest && !flags.nochange && !error) {
-		current = head;
+	if (state.setrestorecondigest && !state.flags.nochange && !error) {
+		current = state.head;
 		while (current != NULL) {
 			if (setxattr(current->path,
 			    RESTORECON_PARTIAL_MATCH_DIGEST,
@@ -1115,22 +1242,21 @@ int selinux_restorecon(const char *pathname_orig,
 	}
 
 out:
-	if (flags.progress && flags.mass_relabel)
+	if (state.flags.progress && state.flags.mass_relabel)
 		fprintf(stdout, "\r%s 100.0%%\n", pathname);
 
-	sverrno = errno;
-	(void) fts_close(fts);
-	errno = sverrno;
+	(void) fts_close(state.fts);
+	errno = state.saved_errno;
 cleanup:
-	if (flags.add_assoc) {
-		if (flags.verbose)
+	if (state.flags.add_assoc) {
+		if (state.flags.verbose)
 			filespec_eval();
 		filespec_destroy();
 	}
 	free(pathdnamer);
 	free(pathname);
 
-	current = head;
+	current = state.head;
 	while (current != NULL) {
 		struct dir_hash_node *next = current->next;
 
@@ -1164,6 +1290,26 @@ fts_err:
 	goto cleanup;
 }
 
+
+/*
+ * Public API
+ */
+
+/* selinux_restorecon(3) - Main function that is responsible for labeling */
+int selinux_restorecon(const char *pathname_orig,
+		       unsigned int restorecon_flags)
+{
+	return selinux_restorecon_common(pathname_orig, restorecon_flags, 1);
+}
+
+/* selinux_restorecon_parallel(3) - Parallel version of selinux_restorecon(3) */
+int selinux_restorecon_parallel(const char *pathname_orig,
+				unsigned int restorecon_flags,
+				size_t nthreads)
+{
+	return selinux_restorecon_common(pathname_orig, restorecon_flags, nthreads);
+}
+
 /* selinux_restorecon_set_sehandle(3) is called to set the global fc handle */
 void selinux_restorecon_set_sehandle(struct selabel_handle *hndl)
 {
diff --git a/libselinux/src/selinuxswig_python.i b/libselinux/src/selinuxswig_python.i
index 4c73bf92..17e03b9e 100644
--- a/libselinux/src/selinuxswig_python.i
+++ b/libselinux/src/selinuxswig_python.i
@@ -20,7 +20,7 @@ DISABLED = -1
 PERMISSIVE = 0
 ENFORCING = 1
 
-def restorecon(path, recursive=False, verbose=False, force=False):
+def restorecon(path, recursive=False, verbose=False, force=False, nthreads=1):
     """ Restore SELinux context on a given path
 
     Arguments:
@@ -32,6 +32,8 @@ def restorecon(path, recursive=False, verbose=False, force=False):
     force -- Force reset of context to match file_context for customizable files,
     and the default file context, changing the user, role, range portion  as well
     as the type (default False)
+    nthreads -- The number of threads to use during relabeling, or 0 to use as many
+    threads as there are online CPU cores (default 1)
     """
 
     restorecon_flags = SELINUX_RESTORECON_IGNORE_DIGEST | SELINUX_RESTORECON_REALPATH
@@ -41,7 +43,7 @@ def restorecon(path, recursive=False, verbose=False, force=False):
         restorecon_flags |= SELINUX_RESTORECON_VERBOSE
     if force:
         restorecon_flags |= SELINUX_RESTORECON_SET_SPECFILE_CTX
-    selinux_restorecon(os.path.expanduser(path), restorecon_flags)
+    selinux_restorecon_parallel(os.path.expanduser(path), restorecon_flags, nthreads)
 
 def chcon(path, context, recursive=False):
     """ Set the SELinux context on a given path """
diff --git a/libselinux/src/selinuxswig_python_exception.i b/libselinux/src/selinuxswig_python_exception.i
index 237ea69a..a02f4923 100644
--- a/libselinux/src/selinuxswig_python_exception.i
+++ b/libselinux/src/selinuxswig_python_exception.i
@@ -1183,6 +1183,14 @@
   }
 }
 
+%exception selinux_restorecon_parallel {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
 %exception selinux_restorecon_set_alt_rootpath {
   $action
   if (result < 0) {
-- 
2.31.1

