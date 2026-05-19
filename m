Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECAA233958
	for <selinux@vger.kernel.org>; Tue, 19 May 2026 18:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779215802; cv=none; b=N8arvcQleN0HFQUkHVeGvq+BcoFyBSH+lgCmBr/F0NNJRJlhDV2RcH2iqaqUaD+6CYwcwxyTdSat982gedT7rptwTBiAXpGJXY+ir/5O0Frvwo5sWkOpRolFNgQypK1gTiTZ0whIyLNp0YR77NUkTkw+8JfhV1+EQ4niAoFpQio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779215802; c=relaxed/simple;
	bh=K+LFeY1Z1GBjDEIsIhj9Zct/eWFDW2hR4Lz8JlfERv4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=miMoBUQ1IoelgQYl42VO6GRbAqmlUJm0B50GueYzxpKeHf172lMwfSBbNsEUQt879BwJ5foQa2cQp3hp0lmlS3uOCLUzdu1dM65/wvRD0a2WBqpioZfQfkZrvIJOOeTbg2kD+nxbFMouYcapJnx+iXpLd3euCHbDE0eRhALc1PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EDge4vgI; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDge4vgI"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-911796e9885so384985485a.0
        for <selinux@vger.kernel.org>; Tue, 19 May 2026 11:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779215799; x=1779820599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2JXo318DYJgTN4s4E278FQIs5C4HAX7B5ClFuCoLbb4=;
        b=EDge4vgI/wYvZSOW2N4xhQD3l+FjGaSxQ3P67lrHETxKy1VCzDUboLTCXabQlAcgFF
         EeAAfn9rRL4u8h3gwVKJwVt3OOoYwltNUz+lqZwjGABni5lbbt3G6NnB0ZhB3QzPvT+6
         jdf94ztvrOyFKcK8Hk0Fig9O7z3DLm1iyGgiWs+bdPL7XaMXSuxPAUldYZqiRqdJz0wO
         CkCUWl8rRnZpXY4fRcZDvfi/3WEw5Uy3nbvvjrn0V2LbCswHQ/u3IgNCOcxFVv6eZN9B
         VyMPRr4KmEsycLVnSSez1oK7tiSi3ekPkCD6ZpkzJHdLB2Ip28wrmUh0MxGm77ce4aWF
         C9Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779215799; x=1779820599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2JXo318DYJgTN4s4E278FQIs5C4HAX7B5ClFuCoLbb4=;
        b=ocnARm0l3aoL9AwsZVU1SSSF/tTb5S9ows9+FLq/LIBnVzVhfLLZRhE6oDlQz/P2It
         fYfHJohtpOWAXT/YzS1j+D6pgQ7/YTMstYYlhB1KqQEo10VvDtSB2QiVwfmRzZMn+CmX
         c6HgrDEpTraJRa8rnZXYu2y65nQKrhXVurXRkQv0rmphp4HJgF6gqg35KI0rtfgQs+q9
         dcK1Kvya9vdKret1UpB20tZM8L7yRj+wuXY7HluXgX/sHsFt98yB4ULQEkiJ4Zc6beo9
         QCGjH/HV9LZFwN1F9Sxt1gLDHttj+bEOS1yx8ZtrLG6MmS+oCoRqPY0Y3ENogIvy/9La
         nuzA==
X-Gm-Message-State: AOJu0YxZ2Z1Z8VJ6sjJxs/IF+XiKr17GX+VUxNRn3WQAtacm265K5HBo
	pko4jFBO8ztxIHKtNgfsTz/6rYY+tIlK3O99auV8E3g2uhXbOfpTxPFeN2FHtA==
X-Gm-Gg: Acq92OGD2J5YI6eiHTaVWOcuvYMsSSYpvEA9tRsj8uKskHYcI8rFcJWQ6CAjKIFPdQE
	YpH4W71gI84KRlhCljfjmY5mcYlAwRsaFyRQ2eqng4p2d/HiwMBeMrQUaKnReROgYwKjEPqgQ9V
	+sfAUQDzlG/q2wOMm0JNCjrdsgJSINdV1VNcsxRILHlbosSAjZYauY9sakn5hqS2qx8DOYgk2Fd
	ImigiY6o7hT0IJS+gIup/t98I9YAWaQjOTmFq+3mXqvFD7NVCVunfLiypzB6Jk1Ib2oLnTzgiP5
	G0Xaprt5l+HpZ54WHQWuwTgHP6MO9GR4LjN0bDwdq9qy/ItyeeN0QoXARDl1TKo5JWX1Qdcl7Rx
	v5sLQJHO+csvv4JuWDlGBe9+rrYQVcG14rVUDTOYFKiea1c9wiQ56BQatnuWKgCxLnSrJ/Gm8E+
	3i/p0z+59wrqGq5mtiVmYF9pDja2q4szZC/DiO//9zR/jvrX0hGP2lH46+mabUToVwXP+HDG3+t
	YLPZnEQeEwiYYe+0zW8PiZ4x4f9ieHKsxaZqNTDziaYQMox39absa8=
X-Received: by 2002:a05:620a:4148:b0:912:322f:1665 with SMTP id af79cd13be357-912323e6515mr2471072585a.5.1779215799298;
        Tue, 19 May 2026 11:36:39 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910ba36e68csm1915162785a.10.2026.05.19.11.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 11:36:38 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2] libselinux: selinux_restorecon: write digests during traversal
Date: Tue, 19 May 2026 14:35:08 -0400
Message-ID: <20260519183507.402648-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rather than creating a linked list of digests and setting them all by
pathname at the end of selinux_restorecon_common(), set them during
the traversal using the directory fd we already have. This eliminates
TOCTOU issues in setting the digest.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v2 switches to just always setting the security.sehash xattr via
fsetxattr(); this works because the directory fd is opened O_RDONLY
so that it can be read, unlike the O_PATH descriptors for non-directories.

 libselinux/src/selinux_restorecon.c | 140 ++++++++++------------------
 1 file changed, 48 insertions(+), 92 deletions(-)

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index cb22cab4..682923b2 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -865,65 +865,42 @@ err:
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
@@ -931,6 +908,8 @@ struct walk_level {
 	dev_t dev;
 	ino_t ino;
 	size_t pathlen;
+	uint8_t digest[SHA1_HASH_SIZE];
+	bool write_digest;
 };
 
 struct rest_state {
@@ -949,7 +928,6 @@ struct rest_state {
 	int root_fd;
 	struct stat root_sb;
 
-	struct dir_hash_node *head, *current;
 	bool abort;
 	int error;
 	long unsigned skipped_errors;
@@ -987,6 +965,7 @@ static int walk_push(struct rest_state *st, int rdfd, dev_t dev, ino_t ino,
 	wl->dev = dev;
 	wl->ino = ino;
 	wl->pathlen = pathlen;
+	wl->write_digest = false;
 	st->depth++;
 	return 0;
 }
@@ -1184,6 +1163,20 @@ static int walk_next(struct rest_state *state, int *ent_fd, int *rd_fd,
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
+			    fsetxattr(dirfd(top->dirp),
+				      RESTORECON_PARTIAL_MATCH_DIGEST,
+				      top->digest, SHA1_HASH_SIZE, 0) < 0) {
+				selinux_log(SELINUX_ERROR,
+					"Could not set digest on %s: %m\n",
+					state->pathbuf);
+			}
 			walk_pop(state);
 			continue;
 		}
@@ -1333,32 +1326,21 @@ static void *selinux_restorecon_thread(void *arg)
 				continue;
 			}
 
-			if (state->setrestorecondigest) {
-				struct dir_hash_node *new_node = NULL;
+			uint8_t digest[SHA1_HASH_SIZE];
+			bool have_digest = false;
 
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
-
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
@@ -1370,6 +1352,13 @@ static void *selinux_restorecon_thread(void *arg)
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
 
@@ -1465,8 +1454,6 @@ static int selinux_restorecon_common(const char *pathname_orig,
 		    SELINUX_RESTORECON_COUNT_RELABELED) ? true : false;
 	state.setrestorecondigest = true;
 
-	state.head = NULL;
-	state.current = NULL;
 	state.abort = false;
 	state.error = 0;
 	state.skipped_errors = 0;
@@ -1480,7 +1467,6 @@ static int selinux_restorecon_common(const char *pathname_orig,
 	struct stat sb;
 	char *pathname = NULL, *pathdnamer = NULL, *pathdname, *pathbname;
 	int error;
-	struct dir_hash_node *current = NULL;
 
 	if (state.flags.verbose && state.flags.progress)
 		state.flags.verbose = false;
@@ -1687,27 +1673,6 @@ static int selinux_restorecon_common(const char *pathname_orig,
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
@@ -1727,15 +1692,6 @@ cleanup:
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

