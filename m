Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 717A0C4338F
	for <selinux@archiver.kernel.org>; Mon,  9 Aug 2021 10:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 554DC6103B
	for <selinux@archiver.kernel.org>; Mon,  9 Aug 2021 10:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbhHIKwr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 9 Aug 2021 06:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233254AbhHIKwl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 9 Aug 2021 06:52:41 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD83C0613D3
        for <selinux@vger.kernel.org>; Mon,  9 Aug 2021 03:52:19 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id y12so23882799edo.6
        for <selinux@vger.kernel.org>; Mon, 09 Aug 2021 03:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aGWOhHmBV5lDY/dlCZgHnJ/tfrnuYkAJZYj8NT8D8BQ=;
        b=oyYFQQJ4s5esY5JzMO2zpiEla1QMimXSpUdzIaP20ag4IxMnmBAxJ60hd9TE+w9qG6
         JkVI9XG6rLAWIOuRL86+pqkWomRT8aLR8TkVRs3N/RCjgQmbr2VceGw5SlQKgFF7eAid
         DBOqUhG+49KnFwUlSknytlNr33Wu9/DI7DE5wiOWf46wemWL+0PZMGWXy9Nhe+1ojH0N
         ElT6SLXNPCHL6PAj7bp8yqnAdAMKxOt7M+vvwKmNT954od9uYsAQyf0aqC79s+J+RCbk
         V/upP/qQQu5Ejuv5RB2JV/396NZAx3Ozyoj/F43lgiVnGxWwG9mbGyk2roMCFtPJICy0
         va2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aGWOhHmBV5lDY/dlCZgHnJ/tfrnuYkAJZYj8NT8D8BQ=;
        b=mf21he359TAYER2gbEUc27GKqNoAe5xPgPWBB3bYLrKyR/OjqzMTdepDBDHlRoAXyk
         xTRpXZV226u3RawF1zqT9PK6LFfYQPGBs2urRyf4y46YqG1Swd1X4OgIUqMRatilY0ct
         ztj4His7hQ+ORvpOiCGJUXUpuCqF5G43nocfx8psqod5AeDdwv2n0Tu1/PKQduxEy0qP
         qZLxPvq/MDwyjAHDgVqQDFt5sa7ecnVwb4F8JubrBEELqD37muPO+dXsf8wFUb3AH4eG
         a0/yZVj98+0X5gGxE5/Pikgg9VG9iCG78WXK4z/0VN+d/JSwvbcgShOk525qqSw3q2nK
         f2/Q==
X-Gm-Message-State: AOAM530fCP3rD463AcM2zxyIMqLYS/qY9PbWHmQX2oKZ7Sv5UICpnIV2
        GrH7joa/Xyh0wm0h7nk6SnQ6XC6ZxNNRxg==
X-Google-Smtp-Source: ABdhPJyZxEy7aztPaFH6m5JYpnJR00hmv5QdvT+QfaBtE915Dizttghe+7R9GoSjGvpfQ2ekkjQt5A==
X-Received: by 2002:aa7:da02:: with SMTP id r2mr29253347eds.249.1628506338462;
        Mon, 09 Aug 2021 03:52:18 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-003-178-135.77.3.pool.telefonica.de. [77.3.178.135])
        by smtp.gmail.com with ESMTPSA id x20sm2302090ejb.100.2021.08.09.03.52.17
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 03:52:18 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 1/2] libselinux: replace strerror by %m
Date:   Mon,  9 Aug 2021 12:52:08 +0200
Message-Id: <20210809105209.12705-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The standard function `strerror(3)` is not thread safe.  This does not
only affect the concurrent usage of libselinux itself but also with
other `strerror(3)` linked libraries.
Use the thread safe GNU extension format specifier `%m`[1].

libselinux already uses the GNU extension format specifier `%ms`.

[1]: https://www.gnu.org/software/libc/manual/html_node/Other-Output-Conversions.html

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/audit2why.c              | 11 ++--
 libselinux/src/avc.c                    |  9 ++--
 libselinux/src/avc_internal.c           |  4 +-
 libselinux/src/label_backends_android.c | 12 +++--
 libselinux/src/label_file.h             | 12 +++--
 libselinux/src/load_policy.c            | 20 ++++----
 libselinux/src/matchpathcon.c           |  8 +--
 libselinux/src/selinux_restorecon.c     | 68 +++++++++++++------------
 8 files changed, 79 insertions(+), 65 deletions(-)

diff --git a/libselinux/src/audit2why.c b/libselinux/src/audit2why.c
index 029f874f..ca38e13c 100644
--- a/libselinux/src/audit2why.c
+++ b/libselinux/src/audit2why.c
@@ -204,8 +204,8 @@ static int __policy_init(const char *init_path)
 		fp = fopen(path, "re");
 		if (!fp) {
 			snprintf(errormsg, sizeof(errormsg), 
-				 "unable to open %s:  %s\n",
-				 path, strerror(errno));
+				 "unable to open %s:  %m\n",
+				 path);
 			PyErr_SetString( PyExc_ValueError, errormsg);
 			return 1;
 		}
@@ -221,9 +221,8 @@ static int __policy_init(const char *init_path)
 		fp = fopen(curpolicy, "re");
 		if (!fp) {
 			snprintf(errormsg, sizeof(errormsg), 
-				 "unable to open %s:  %s\n",
-				 curpolicy,
-				 strerror(errno));
+				 "unable to open %s:  %m\n",
+				 curpolicy);
 			PyErr_SetString( PyExc_ValueError, errormsg);
 			return 1;
 		}
@@ -242,7 +241,7 @@ static int __policy_init(const char *init_path)
 	if (sepol_policy_file_create(&pf) ||
 	    sepol_policydb_create(&avc->policydb)) {
 		snprintf(errormsg, sizeof(errormsg), 
-			 "policydb_init failed: %s\n", strerror(errno));
+			 "policydb_init failed: %m\n");
 		PyErr_SetString( PyExc_RuntimeError, errormsg);
 		fclose(fp);
 		return 1;
diff --git a/libselinux/src/avc.c b/libselinux/src/avc.c
index daaedbc6..7493e4b2 100644
--- a/libselinux/src/avc.c
+++ b/libselinux/src/avc.c
@@ -206,9 +206,8 @@ static int avc_init_internal(const char *prefix,
 		rc = security_getenforce();
 		if (rc < 0) {
 			avc_log(SELINUX_ERROR,
-				"%s:  could not determine enforcing mode: %s\n",
-				avc_prefix,
-				strerror(errno));
+				"%s:  could not determine enforcing mode: %m\n",
+				avc_prefix);
 			goto out;
 		}
 		avc_enforcing = rc;
@@ -217,8 +216,8 @@ static int avc_init_internal(const char *prefix,
 	rc = selinux_status_open(0);
 	if (rc < 0) {
 		avc_log(SELINUX_ERROR,
-			"%s: could not open selinux status page: %d (%s)\n",
-			avc_prefix, errno, strerror(errno));
+			"%s: could not open selinux status page: %d (%m)\n",
+			avc_prefix, errno);
 		goto out;
 	}
 	avc_running = 1;
diff --git a/libselinux/src/avc_internal.c b/libselinux/src/avc_internal.c
index 53a99a1f..71a1357b 100644
--- a/libselinux/src/avc_internal.c
+++ b/libselinux/src/avc_internal.c
@@ -308,8 +308,8 @@ int avc_netlink_acquire_fd(void)
 		rc = avc_netlink_open(0);
 		if (rc < 0) {
 			avc_log(SELINUX_ERROR,
-				"%s: could not open netlink socket: %d (%s)\n",
-				avc_prefix, errno, strerror(errno));
+				"%s: could not open netlink socket: %d (%m)\n",
+				avc_prefix, errno);
 			return rc;
 		}
 	}
diff --git a/libselinux/src/label_backends_android.c b/libselinux/src/label_backends_android.c
index cb8aae26..66d4df2d 100644
--- a/libselinux/src/label_backends_android.c
+++ b/libselinux/src/label_backends_android.c
@@ -94,9 +94,15 @@ static int process_line(struct selabel_handle *rec,
 	items = read_spec_entries(line_buf, &errbuf, 2, &prop, &context);
 	if (items < 0) {
 		items = errno;
-		selinux_log(SELINUX_ERROR,
-			"%s:  line %u error due to: %s\n", path,
-			lineno, errbuf ?: strerror(errno));
+		if (errbuf) {
+			selinux_log(SELINUX_ERROR,
+				    "%s:  line %u error due to: %s\n", path,
+				    lineno, errbuf);
+		} else {
+			selinux_log(SELINUX_ERROR,
+				    "%s:  line %u error due to: %m\n", path,
+				    lineno);
+		}
 		errno = items;
 		return -1;
 	}
diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index 9f633701..343ffc70 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -445,9 +445,15 @@ static inline int process_line(struct selabel_handle *rec,
 	items = read_spec_entries(line_buf, &errbuf, 3, &regex, &type, &context);
 	if (items < 0) {
 		rc = errno;
-		selinux_log(SELINUX_ERROR,
-			"%s:  line %u error due to: %s\n", path,
-			lineno, errbuf ?: strerror(errno));
+		if (errbuf) {
+			selinux_log(SELINUX_ERROR,
+				    "%s:  line %u error due to: %s\n", path,
+				    lineno, errbuf);
+		} else {
+			selinux_log(SELINUX_ERROR,
+				    "%s:  line %u error due to: %m\n", path,
+				    lineno);
+		}
 		errno = rc;
 		return -1;
 	}
diff --git a/libselinux/src/load_policy.c b/libselinux/src/load_policy.c
index 5857b821..d8c715ed 100644
--- a/libselinux/src/load_policy.c
+++ b/libselinux/src/load_policy.c
@@ -137,15 +137,15 @@ int selinux_mkload_policy(int preservebools __attribute__((unused)))
 	}
 	if (fd < 0) {
 		fprintf(stderr,
-			"SELinux:  Could not open policy file <= %s.%d:  %s\n",
-			selinux_binary_policy_path(), maxvers, strerror(errno));
+			"SELinux:  Could not open policy file <= %s.%d:  %m\n",
+			selinux_binary_policy_path(), maxvers);
 		goto dlclose;
 	}
 
 	if (fstat(fd, &sb) < 0) {
 		fprintf(stderr,
-			"SELinux:  Could not stat policy file %s:  %s\n",
-			path, strerror(errno));
+			"SELinux:  Could not stat policy file %s:  %m\n",
+			path);
 		goto close;
 	}
 
@@ -153,8 +153,8 @@ int selinux_mkload_policy(int preservebools __attribute__((unused)))
 	data = map = mmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
 	if (map == MAP_FAILED) {
 		fprintf(stderr,
-			"SELinux:  Could not map policy file %s:  %s\n",
-			path, strerror(errno));
+			"SELinux:  Could not map policy file %s:  %m\n",
+			path);
 		goto close;
 	}
 
@@ -193,8 +193,8 @@ int selinux_mkload_policy(int preservebools __attribute__((unused)))
 	
 	if (rc)
 		fprintf(stderr,
-			"SELinux:  Could not load policy file %s:  %s\n",
-			path, strerror(errno));
+			"SELinux:  Could not load policy file %s:  %m\n",
+			path);
 
       unmap:
 	if (data != map)
@@ -306,7 +306,7 @@ int selinux_init_load_policy(int *enforce)
 			*enforce = 0;
 		} else {
 			/* Only emit this error if selinux was not disabled */
-			fprintf(stderr, "Mount failed for selinuxfs on %s:  %s\n", SELINUXMNT, strerror(errno));
+			fprintf(stderr, "Mount failed for selinuxfs on %s:  %m\n", SELINUXMNT);
 		}
 
 		if (rc == 0)
@@ -352,7 +352,7 @@ int selinux_init_load_policy(int *enforce)
 	if (orig_enforce != *enforce) {
 		rc = security_setenforce(*enforce);
 		if (rc < 0) {
-			fprintf(stderr, "SELinux:  Unable to switch to %s mode:  %s\n", (*enforce ? "enforcing" : "permissive"), strerror(errno));
+			fprintf(stderr, "SELinux:  Unable to switch to %s mode:  %m\n", (*enforce ? "enforcing" : "permissive"));
 			if (*enforce)
 				goto noload;
 		}
diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathcon.c
index 075a3fb3..1e7f8890 100644
--- a/libselinux/src/matchpathcon.c
+++ b/libselinux/src/matchpathcon.c
@@ -393,8 +393,8 @@ int realpath_not_final(const char *name, char *resolved_path)
 
 	tmp_path = strdup(name);
 	if (!tmp_path) {
-		myprintf("symlink_realpath(%s) strdup() failed: %s\n",
-			name, strerror(errno));
+		myprintf("symlink_realpath(%s) strdup() failed: %m\n",
+			name);
 		rc = -1;
 		goto out;
 	}
@@ -414,8 +414,8 @@ int realpath_not_final(const char *name, char *resolved_path)
 	}
 
 	if (!p) {
-		myprintf("symlink_realpath(%s) realpath() failed: %s\n",
-			name, strerror(errno));
+		myprintf("symlink_realpath(%s) realpath() failed: %m\n",
+			name);
 		rc = -1;
 		goto out;
 	}
diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index 999aa924..04d95650 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -333,8 +333,7 @@ static int add_xattr_entry(const char *directory, bool delete_nonmatch,
 		rc = removexattr(directory, RESTORECON_PARTIAL_MATCH_DIGEST);
 		if (rc) {
 			selinux_log(SELINUX_ERROR,
-				  "Error: %s removing xattr \"%s\" from: %s\n",
-				  strerror(errno),
+				  "Error: %m removing xattr \"%s\" from: %s\n",
 				  RESTORECON_PARTIAL_MATCH_DIGEST, directory);
 			digest_result = ERROR;
 		}
@@ -734,8 +733,8 @@ out1:
 	return rc;
 err:
 	selinux_log(SELINUX_ERROR,
-		    "Could not set context for %s:  %s\n",
-		    pathname, strerror(errno));
+		    "Could not set context for %s:  %m\n",
+		    pathname);
 	rc = -1;
 	goto out1;
 }
@@ -857,6 +856,7 @@ int selinux_restorecon(const char *pathname_orig,
 	dev_t dev_num = 0;
 	struct dir_hash_node *current = NULL;
 	struct dir_hash_node *head = NULL;
+	int errno_tmp;
 
 	if (flags.verbose && flags.progress)
 		flags.verbose = false;
@@ -929,8 +929,8 @@ int selinux_restorecon(const char *pathname_orig,
 			return 0;
 		} else {
 			selinux_log(SELINUX_ERROR,
-				    "lstat(%s) failed: %s\n",
-				    pathname, strerror(errno));
+				    "lstat(%s) failed: %m\n",
+				    pathname);
 			error = -1;
 			goto cleanup;
 		}
@@ -954,8 +954,8 @@ int selinux_restorecon(const char *pathname_orig,
 	memset(&sfsb, 0, sizeof sfsb);
 	if (!S_ISLNK(sb.st_mode) && statfs(pathname, &sfsb) < 0) {
 		selinux_log(SELINUX_ERROR,
-			    "statfs(%s) failed: %s\n",
-			    pathname, strerror(errno));
+			    "statfs(%s) failed: %m\n",
+			    pathname);
 		error = -1;
 		goto cleanup;
 	}
@@ -1006,24 +1006,30 @@ int selinux_restorecon(const char *pathname_orig,
 		case FTS_DP:
 			continue;
 		case FTS_DNR:
+			errno_tmp = errno;
+			errno = ftsent->fts_errno;
 			selinux_log(SELINUX_ERROR,
-				    "Could not read %s: %s.\n",
-				    ftsent->fts_path,
-						  strerror(ftsent->fts_errno));
+				    "Could not read %s: %m.\n",
+				    ftsent->fts_path);
+			errno = errno_tmp;
 			fts_set(fts, ftsent, FTS_SKIP);
 			continue;
 		case FTS_NS:
+			errno_tmp = errno;
+			errno = ftsent->fts_errno;
 			selinux_log(SELINUX_ERROR,
-				    "Could not stat %s: %s.\n",
-				    ftsent->fts_path,
-						  strerror(ftsent->fts_errno));
+				    "Could not stat %s: %m.\n",
+				    ftsent->fts_path);
+			errno = errno_tmp;
 			fts_set(fts, ftsent, FTS_SKIP);
 			continue;
 		case FTS_ERR:
+			errno_tmp = errno;
+			errno = ftsent->fts_errno;
 			selinux_log(SELINUX_ERROR,
-				    "Error on %s: %s.\n",
-				    ftsent->fts_path,
-						  strerror(ftsent->fts_errno));
+				    "Error on %s: %m.\n",
+				    ftsent->fts_path);
+			errno = errno_tmp;
 			fts_set(fts, ftsent, FTS_SKIP);
 			continue;
 		case FTS_D:
@@ -1087,9 +1093,8 @@ int selinux_restorecon(const char *pathname_orig,
 			    current->digest,
 			    SHA1_HASH_SIZE, 0) < 0) {
 				selinux_log(SELINUX_ERROR,
-					    "setxattr failed: %s: %s\n",
-					    current->path,
-					    strerror(errno));
+					    "setxattr failed: %s: %m\n",
+					    current->path);
 			}
 			current = current->next;
 		}
@@ -1131,16 +1136,16 @@ oom:
 realpatherr:
 	sverrno = errno;
 	selinux_log(SELINUX_ERROR,
-		    "SELinux: Could not get canonical path for %s restorecon: %s.\n",
-		    pathname_orig, strerror(errno));
+		    "SELinux: Could not get canonical path for %s restorecon: %m.\n",
+		    pathname_orig);
 	errno = sverrno;
 	error = -1;
 	goto cleanup;
 
 fts_err:
 	selinux_log(SELINUX_ERROR,
-		    "fts error while labeling %s: %s\n",
-		    paths[0], strerror(errno));
+		    "fts error while labeling %s: %m\n",
+		    paths[0]);
 	error = -1;
 	goto cleanup;
 }
@@ -1181,8 +1186,7 @@ struct selabel_handle *selinux_restorecon_default_handle(void)
 
 	if (!sehandle) {
 		selinux_log(SELINUX_ERROR,
-			    "Error obtaining file context handle: %s\n",
-						    strerror(errno));
+			    "Error obtaining file context handle: %m\n");
 		return NULL;
 	}
 
@@ -1202,8 +1206,8 @@ void selinux_restorecon_set_exclude_list(const char **exclude_list)
 	for (i = 0; exclude_list[i]; i++) {
 		if (lstat(exclude_list[i], &sb) < 0 && errno != EACCES) {
 			selinux_log(SELINUX_ERROR,
-				    "lstat error on exclude path \"%s\", %s - ignoring.\n",
-				    exclude_list[i], strerror(errno));
+				    "lstat error on exclude path \"%s\", %m - ignoring.\n",
+				    exclude_list[i]);
 			break;
 		}
 		if (add_exclude(exclude_list[i], CALLER_EXCLUDED) &&
@@ -1269,8 +1273,8 @@ int selinux_restorecon_xattr(const char *pathname, unsigned int xattr_flags,
 			return 0;
 
 		selinux_log(SELINUX_ERROR,
-			    "lstat(%s) failed: %s\n",
-			    pathname, strerror(errno));
+			    "lstat(%s) failed: %m\n",
+			    pathname);
 		return -1;
 	}
 
@@ -1300,8 +1304,8 @@ int selinux_restorecon_xattr(const char *pathname, unsigned int xattr_flags,
 	fts = fts_open(paths, fts_flags, NULL);
 	if (!fts) {
 		selinux_log(SELINUX_ERROR,
-			    "fts error on %s: %s\n",
-			    paths[0], strerror(errno));
+			    "fts error on %s: %m\n",
+			    paths[0]);
 		return -1;
 	}
 
-- 
2.32.0

