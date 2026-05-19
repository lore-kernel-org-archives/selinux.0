Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A7640800E
	for <selinux@vger.kernel.org>; Tue, 19 May 2026 15:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779205098; cv=none; b=AFUp2j4RguGilEx67kSenEtXTIUbCeLBazz4VGDH76v3ciIUZnVJucjYoP3UXLxnNLCA7hPu8h7jJ3w0vSF0/q8L6GxJod9rgAmQaw2+x5+j9N+LZymXLRhqMGqwzkQqEX5KwChyBctSQWpEtV93klCmsxVbETO+NNf+1o7Ry2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779205098; c=relaxed/simple;
	bh=LkCBB4XGmSGz11+mohA0oKgNrsMDFyFRfPFt9j4qUKE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mR2JvbZ3Lnkgp8cFlTZr1l2wJOJj/9QDg0/Q2fFrlHvCk6JEgCsFw9NR1PiMgPIfdFtfPMD0F0YvTVb87vo0QCN0awmU/khuWmxYxolOZy8VXXiW8RqxkFa3w6RfjrD3HZD+TqGTlb9y4KkMQzl3Jot0BbCGXKPhxPNKHRjRcfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eahhkFt5; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eahhkFt5"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-50e5c5033f6so33951211cf.0
        for <selinux@vger.kernel.org>; Tue, 19 May 2026 08:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779205096; x=1779809896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8f2OnjTHvwD/37BvvXtVw3qROeadRk/NxPQhKY/lFgQ=;
        b=eahhkFt5/+Eaf+VJaCHPRQcWhYgNSRo+cUWgdEylfMmRa5lVBopEjya7xDPN8F1rEz
         iuI0pobzM/Aa+KFb7yWWgjOcxA7bxri+R0L/F9dLgiQ6Lw+NJ/SDGPAAKKwuhgACCyot
         a6dyaopWC0UHa8zGtBtdY9qI4wS17VVp7a2g6zHipLu0dHQjlIQgEU5GWbveU9/LZc2N
         xGH22gVEr0hjXOYqJEGPL15j6kR7hRdb1Cbhv7ter9x/w07VJHiAfded+dDv8Qri8Uda
         Rfn2w0j6Kzd6ijrNG7ES+7OJZoQXYP6ZTn25ZDUV52dsjw/6PITp4k8E8ANjTc/+vYgk
         PRqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779205096; x=1779809896;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8f2OnjTHvwD/37BvvXtVw3qROeadRk/NxPQhKY/lFgQ=;
        b=k3gzCitw75FnJVgqMibaEJfmzkgypbgVkzWUSW4MpCSqPBt9hyJf3E407jEIVUyBgA
         vGToudhIgahIcZANZf/E/9u3uMcFcjxnDmAxKnXXq6/WP9w470l0UVtNpCjUdCbCA4kr
         Oo7ZUwfo0uZXGW20u7VPGdTE9tOV4b80UiSReOTCzCuLWC7j5T32Tlf8XMnrT+uGFyU+
         nepP5Pq3YdwlWW+jUyqrD/FEiOMY4N+v0TCU9cXDpBWOpNTp+eQdhHv06WQPip0lzW+u
         cdK5bKn/9/bLZ9LR8oVIFxyRWenVTzvymmt6EK4kGhDInlvGZHiQOy+Usvz7IDru/934
         va0g==
X-Gm-Message-State: AOJu0Yy9F18ukX4ctVCN3Y73MxksalyZBgx6YiYZpQBeDQWo/6IRPmb0
	5GrZI0ZBIjlzj+1LegpcXsCte0LdrACe0ehe7SAQN5XGBRTe3KlvO3ASsUQ1IA==
X-Gm-Gg: Acq92OE7GVu3IrFBnLHQAlvXi8QEOWTUOEtlUjX099rPSTZvRyrL+1xyoiwzpDaurho
	B1aL9ik0MfIeMbMkBgkh0ju+v3BadWnuaH0F0G2GMhT9+4GmTtdLjbXMZJcmPzZelGonDEyyDNZ
	Sob09OgMuAHGM4KvhqjXbNfp772rd4mv7rdUydi2GJlI7v9j+C1UpkmhrNUsAQWh77xzdMXMyJW
	2wNtZmdbb4B2qwfXdOOhrI3wo5GFGgEF+/FId9r5zymklB1aslDkBIbHYUt8fTiItiBkpM/wLrz
	oi45n+kfHr2jXMTTq7APB901o2y89kxoEn7MTCZIzpNfDaCX8iDTKE3l4YrtK5EB4ViB0mcmZGM
	zeVXayqrtWZ//DdWW3hmNK9SNe5nLjprWmb4V2ioR02conaO31+HsolgM9jYu6kSgk3Yd5sdGfA
	qgvpyhdUFXW8GBPTdPJ8wTxV8aExChEcAW/q27XBRbqNwfappXMyc6MyeBZFOCBfnulJNzUcurP
	S+gRpzypLzXt4pXoNAjkcK20A9RmA1mWGQtlu+IonUoZRvYCr5jJuw=
X-Received: by 2002:a05:622a:1f96:b0:50f:ccdd:13f1 with SMTP id d75a77b69052e-5165a03f078mr281538731cf.16.1779205096092;
        Tue, 19 May 2026 08:38:16 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5164568a275sm166835161cf.5.2026.05.19.08.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 08:38:15 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] libselinux: selinux_restorecon: write digests during traversal
Date: Tue, 19 May 2026 11:37:54 -0400
Message-ID: <20260519153754.380679-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rather than creating a linked list of digests and setting them all
at the end of selinux_restorecon_common(), set them during the
traversal using the directory fd we already have. This eliminates
TOCTOU issues in setting the digest if /proc is mounted.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/src/selinux_restorecon.c | 157 ++++++++++++----------------
 1 file changed, 65 insertions(+), 92 deletions(-)

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index cb22cab4..f53ecdd3 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -138,6 +138,24 @@ static int fd_path_setfilecon(int fd, const char *pathname, char *con)
 	return lsetfilecon_raw(pathname, con);
 }
 
+static int fd_path_setdigest(int fd, const char *pathname,
+			     uint8_t digest[SHA1_HASH_SIZE])
+{
+	char proc_path[32];
+	int rc;
+
+	if (have_proc) {
+		rc = snprintf(proc_path, sizeof(proc_path), "/proc/self/fd/%d", fd);
+		if (rc < 0 || (size_t)rc >= sizeof(proc_path))
+			return -1;
+		return setxattr(proc_path, RESTORECON_PARTIAL_MATCH_DIGEST,
+				digest, SHA1_HASH_SIZE, 0);
+	}
+
+	return lsetxattr(pathname, RESTORECON_PARTIAL_MATCH_DIGEST,
+			 digest, SHA1_HASH_SIZE, 0);
+}
+
 static void restorecon_init(void)
 {
 	struct selabel_handle *sehandle = NULL;
@@ -865,65 +883,42 @@ err:
 	goto out1;
 }
 
-struct dir_hash_node {
-	char *path;
-	uint8_t digest[SHA1_HASH_SIZE];
-	struct dir_hash_node *next;
-};
 /*
  * Returns true if the digest of all partial matched contexts is the same as
- * the one saved by setxattr. Otherwise returns false and constructs a
- * dir_hash_node with the newly calculated digest.
+ * the one saved by setxattr. Otherwise returns false and sets @have_digest
+ * to indicate if @digest_out was set to the digest to apply after
+ * relabeling this directory.
  */
 static bool check_context_match_for_dir(const char *pathname,
-					struct dir_hash_node **new_node,
-					int error)
+					uint8_t digest_out[SHA1_HASH_SIZE],
+					bool *have_digest)
 {
 	bool status;
 	size_t digest_len = 0;
 	uint8_t *read_digest = NULL;
 	uint8_t *calculated_digest = NULL;
 
-	if (!new_node)
-		return false;
-
-	*new_node = NULL;
+	*have_digest = false;
 
 	/* status = true if digests match, false otherwise. */
 	status = selabel_get_digests_all_partial_matches(fc_sehandle, pathname,
 							 &calculated_digest,
 							 &read_digest,
 							 &digest_len);
-
 	if (status)
 		goto free;
 
 	/* Save digest of all matched contexts for the current directory. */
-	if (!error && calculated_digest) {
-		*new_node = calloc(1, sizeof(struct dir_hash_node));
-
-		if (!*new_node)
-			goto oom;
-
-		(*new_node)->path = strdup(pathname);
-
-		if (!(*new_node)->path) {
-			free(*new_node);
-			*new_node = NULL;
-			goto oom;
-		}
-		memcpy((*new_node)->digest, calculated_digest, digest_len);
-		(*new_node)->next = NULL;
+	if (calculated_digest) {
+		assert(digest_len == SHA1_HASH_SIZE);
+		memcpy(digest_out, calculated_digest, SHA1_HASH_SIZE);
+		*have_digest = true;
 	}
 
 free:
 	free(calculated_digest);
 	free(read_digest);
 	return status;
-
-oom:
-	selinux_log(SELINUX_ERROR, "%s: Out of memory\n", __func__);
-	goto free;
 }
 
 struct walk_level {
@@ -931,6 +926,8 @@ struct walk_level {
 	dev_t dev;
 	ino_t ino;
 	size_t pathlen;
+	uint8_t digest[SHA1_HASH_SIZE];
+	bool write_digest;
 };
 
 struct rest_state {
@@ -949,7 +946,6 @@ struct rest_state {
 	int root_fd;
 	struct stat root_sb;
 
-	struct dir_hash_node *head, *current;
 	bool abort;
 	int error;
 	long unsigned skipped_errors;
@@ -987,6 +983,7 @@ static int walk_push(struct rest_state *st, int rdfd, dev_t dev, ino_t ino,
 	wl->dev = dev;
 	wl->ino = ino;
 	wl->pathlen = pathlen;
+	wl->write_digest = false;
 	st->depth++;
 	return 0;
 }
@@ -1184,6 +1181,19 @@ static int walk_next(struct rest_state *state, int *ent_fd, int *rd_fd,
 					return -1;
 				continue;
 			}
+			/*
+			 * Completed directory traversal; set digest
+			 * if requested and no errors.
+			 */
+			if (top->write_digest && state->setrestorecondigest &&
+			    !state->flags.nochange && !state->error &&
+			    !state->skipped_errors &&
+			    fd_path_setdigest(dirfd(top->dirp), state->pathbuf,
+					      top->digest) < 0) {
+				selinux_log(SELINUX_ERROR,
+					"Could not set digest on %s: %m\n",
+					state->pathbuf);
+			}
 			walk_pop(state);
 			continue;
 		}
@@ -1333,32 +1343,21 @@ static void *selinux_restorecon_thread(void *arg)
 				continue;
 			}
 
-			if (state->setrestorecondigest) {
-				struct dir_hash_node *new_node = NULL;
-
-				if (check_context_match_for_dir(ent_path,
-								&new_node,
-								state->error) &&
-								!state->ignore_digest) {
-					selinux_log(SELINUX_INFO,
-						"Skipping restorecon on directory(%s)\n",
-						    ent_path);
-					close(ent_fd);
-					if (rd_fd >= 0)
-						close(rd_fd);
-					prune_pathbuf(state);
-					continue;
-				}
+			uint8_t digest[SHA1_HASH_SIZE];
+			bool have_digest = false;
 
-				if (new_node && !state->error) {
-					if (!state->current) {
-						state->current = new_node;
-						state->head = state->current;
-					} else {
-						state->current->next = new_node;
-						state->current = new_node;
-					}
-				}
+			if (descend && state->setrestorecondigest &&
+			    check_context_match_for_dir(ent_path,
+						        digest,
+						        &have_digest) &&
+				                        !state->ignore_digest) {
+				selinux_log(SELINUX_INFO,
+					"Skipping restorecon on directory(%s)\n",
+					ent_path);
+				close(ent_fd);
+				close(rd_fd);
+				prune_pathbuf(state);
+				continue;
 			}
 
 			if (descend) {
@@ -1370,6 +1369,13 @@ static void *selinux_restorecon_thread(void *arg)
 					state->abort = true;
 					goto finish;
 				}
+
+				if (have_digest) {
+					struct walk_level *wl = &state->stack[state->depth - 1];
+
+					memcpy(wl->digest, digest, SHA1_HASH_SIZE);
+					wl->write_digest = true;
+				}
 			}
 		}
 
@@ -1465,8 +1471,6 @@ static int selinux_restorecon_common(const char *pathname_orig,
 		    SELINUX_RESTORECON_COUNT_RELABELED) ? true : false;
 	state.setrestorecondigest = true;
 
-	state.head = NULL;
-	state.current = NULL;
 	state.abort = false;
 	state.error = 0;
 	state.skipped_errors = 0;
@@ -1480,7 +1484,6 @@ static int selinux_restorecon_common(const char *pathname_orig,
 	struct stat sb;
 	char *pathname = NULL, *pathdnamer = NULL, *pathdname, *pathbname;
 	int error;
-	struct dir_hash_node *current = NULL;
 
 	if (state.flags.verbose && state.flags.progress)
 		state.flags.verbose = false;
@@ -1687,27 +1690,6 @@ static int selinux_restorecon_common(const char *pathname_orig,
 	if (state.saved_errno)
 		goto out;
 
-	/*
-	 * Labeling successful. Write partial match digests for subdirectories.
-	 * Note: we can't ignore errors here that we've masked due to
-	 * SELINUX_RESTORECON_COUNT_ERRORS.
-	 */
-	if (state.setrestorecondigest && !state.flags.nochange && !error &&
-	    state.skipped_errors == 0) {
-		current = state.head;
-		while (current != NULL) {
-			if (setxattr(current->path,
-			    RESTORECON_PARTIAL_MATCH_DIGEST,
-			    current->digest,
-			    SHA1_HASH_SIZE, 0) < 0) {
-				selinux_log(SELINUX_ERROR,
-					    "setxattr failed: %s: %m\n",
-					    current->path);
-			}
-			current = current->next;
-		}
-	}
-
 	skipped_errors = state.skipped_errors;
 
 out:
@@ -1727,15 +1709,6 @@ cleanup:
 	}
 	free(pathdnamer);
 	free(pathname);
-
-	current = state.head;
-	while (current != NULL) {
-		struct dir_hash_node *next = current->next;
-
-		free(current->path);
-		free(current);
-		current = next;
-	}
 	return error;
 
 oom:
-- 
2.54.0

