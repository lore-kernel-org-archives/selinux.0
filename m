Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B78F37C93D
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 13:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782222159; cv=none; b=ipIdW7KQPojXCRBzZxlaw1oBx41iWFpvgrOy5sYnm9VAA/c7a/lfBzcBIqbwLj4cHDjM+oGSf+Z9c1dvyY5pPHeOSz0+w8qP6f5KDjHWKvxKz7lAUjxsDZh71TlafWRWXjnIGQYIXFe2QM3dUl6ZunUwBwWJ03lAF+207vgmzA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782222159; c=relaxed/simple;
	bh=9x78sj5119AYRfCSbQk3F7Ej03FIwVeTjtHbmDdY/d4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VbKMQySSRx6Ub7CwGBUmFnNMFESfh7flQrOalLok4/YjnscoaGdYLWeMmqDnfm9PiRHA0WdTB9nVKtID2VxyRH4s/4qVA0ohSk1fViPFbV4/cNdA3ig40DzORFWk5pguBMn6KNrQKImwg3KYwr5cwxQM5sRejqkg+5YZdvMpQoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=JoR9hNxR; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="JoR9hNxR"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1782222155;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lgMUdk7T9DlsPc1DIlscnsTak1qYRb5OMFtXM+u64JQ=;
	b=JoR9hNxRzt23FnPhxeVatDSfBE9176f32y6nIWQkrFa+j8sVkutMgvMYYtdWxp2gJX62KZ
	6RbX7oNBLpcfddwHujm5L+SL8On3Irb0d/vb6UVOX8aNGwmOzqB5vNg8sugSVJb7IhRspr
	MbxjQefSaTSS1EJFdBQMciR1XA3hB17NkwZ+qyWurdd7SQY72zpLNssIgz1rVLe/yX/AtN
	PtJJv7tkjjv2EZFds0CBiP3H6QSxk+vTvbKJaXeZXLv8nwqAXoOyXFhz6lOm+SPu80M9Y4
	rAVuULV1JGsMgqvz1uuroktZN2/rCWJ/CmXqhjhj3Bngr6zoF3Uv05Sc76YqQw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 01/24] libselinux/include: fix man page grammar, wording and consistency nits
Date: Tue, 23 Jun 2026 15:42:14 +0200
Message-ID: <20260623134215.98273-24-cgoettsche@seltendoof.de>
In-Reply-To: <20260623134215.98273-1-cgoettsche@seltendoof.de>
References: <20260623134215.98273-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Drop a duplicated "and" in the avc_add_callback() header comment.

The selabel_handle pointer parameter was named inconsistently across the
public headers (handle, rec, hndl) and the man pages used hnd.
Standardize on "handle" in the headers; selabel_cmp keeps h1/h2 as it
compares two handles.

Reword "allows to run/use" phrasing.

Correct the selabel_cmp() @h2 kernel-doc (second, not first handle) and
the grammar of the selinux_set_mapping() comment.

Fix RGB triple count in selinux_raw_context_to_color() comment; the
comment claimed "ten ten hex RGB triples" (a duplicated word and the
wrong count). The function returns eight triples: foreground and
background for each of the user, role, type and range components,
matching selinux_raw_context_to_color(3).

Assisted-by: Claude:claude-4.8-opus
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/include/selinux/avc.h        |  2 +-
 libselinux/include/selinux/label.h      | 23 +++++++++++------------
 libselinux/include/selinux/restorecon.h |  6 +++---
 libselinux/include/selinux/selinux.h    |  6 +++---
 4 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/libselinux/include/selinux/avc.h b/libselinux/include/selinux/avc.h
index 1fefbf4e..6d728ce0 100644
--- a/libselinux/include/selinux/avc.h
+++ b/libselinux/include/selinux/avc.h
@@ -379,7 +379,7 @@ extern int avc_compute_member(security_id_t ssid, security_id_t tsid,
  *
  * Register a callback function for events in the set @events
  * related to the SID pair (@ssid, @tsid) and
- * and the permissions @perms, interpreting
+ * the permissions @perms, interpreting
  * @perms based on @tclass.  Returns %0 on success or
  * -%1 if insufficient memory exists to add the callback.
  */
diff --git a/libselinux/include/selinux/label.h b/libselinux/include/selinux/label.h
index 05e1fd56..748b0db0 100644
--- a/libselinux/include/selinux/label.h
+++ b/libselinux/include/selinux/label.h
@@ -107,20 +107,19 @@ extern int selabel_lookup_raw(struct selabel_handle *handle, char **con,
 extern bool selabel_partial_match(struct selabel_handle *handle,
 				  const char *key);
 
-extern bool selabel_get_digests_all_partial_matches(struct selabel_handle *rec,
-						    const char *key,
-						    uint8_t **calculated_digest,
-						    uint8_t **xattr_digest,
-						    size_t *digest_len);
-extern bool selabel_hash_all_partial_matches(struct selabel_handle *rec,
+extern bool selabel_get_digests_all_partial_matches(
+	struct selabel_handle *handle, const char *key,
+	uint8_t **calculated_digest, uint8_t **xattr_digest,
+	size_t *digest_len);
+extern bool selabel_hash_all_partial_matches(struct selabel_handle *handle,
 					     const char *key, uint8_t *digest);
 
-extern int selabel_lookup_best_match(struct selabel_handle *rec, char **con,
+extern int selabel_lookup_best_match(struct selabel_handle *handle, char **con,
 				     const char *key, const char **aliases,
 				     int type);
-extern int selabel_lookup_best_match_raw(struct selabel_handle *rec, char **con,
-					 const char *key, const char **aliases,
-					 int type);
+extern int selabel_lookup_best_match_raw(struct selabel_handle *handle,
+					 char **con, const char *key,
+					 const char **aliases, int type);
 
 /**
  * selabel_digest - Retrieve the SHA1 digest and the list of specfiles used to
@@ -135,7 +134,7 @@ extern int selabel_lookup_best_match_raw(struct selabel_handle *rec, char **con,
  *
  * Return %0 on success, -%1 with @errno set on failure.
  */
-extern int selabel_digest(struct selabel_handle *rec, unsigned char **digest,
+extern int selabel_digest(struct selabel_handle *handle, unsigned char **digest,
 			  size_t *digest_len, char ***specfiles,
 			  size_t *num_specfiles);
 
@@ -149,7 +148,7 @@ enum selabel_cmp_result {
 /**
  * selabel_cmp - Compare two label configurations.
  * @h1: handle for the first label configuration
- * @h2: handle for the first label configuration
+ * @h2: handle for the second label configuration
  *
  * Compare two label configurations.
  * Return %SELABEL_SUBSET if @h1 is a subset of @h2, %SELABEL_EQUAL
diff --git a/libselinux/include/selinux/restorecon.h b/libselinux/include/selinux/restorecon.h
index 6680589e..34ba0f43 100644
--- a/libselinux/include/selinux/restorecon.h
+++ b/libselinux/include/selinux/restorecon.h
@@ -33,7 +33,7 @@ extern int selinux_restorecon(const char *pathname,
  * @nthreads: specifies the number of threads to use (0 = use number of CPUs
  *            currently online)
  *
- * Same as selinux_restorecon(3), but allows to use multiple threads to do
+ * Same as selinux_restorecon(3), but allows the use of multiple threads to do
  * the work.
  */
 extern int selinux_restorecon_parallel(const char *pathname,
@@ -146,13 +146,13 @@ extern int selinux_restorecon_parallel(const char *pathname,
 
 /**
  * selinux_restorecon_set_sehandle - Set the global fc handle.
- * @hndl: specifies handle to set as the global fc handle.
+ * @handle: specifies handle to set as the global fc handle.
  *
  * Called by a process that has already called selabel_open(3) with its
  * required parameters, or if selinux_restorecon_default_handle(3) has been
  * called to set the default selabel_open(3) parameters.
  */
-extern void selinux_restorecon_set_sehandle(struct selabel_handle *hndl);
+extern void selinux_restorecon_set_sehandle(struct selabel_handle *handle);
 
 /**
  * selinux_restorecon_default_handle - Sets default selabel_open(3) parameters
diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index de56b727..364f955d 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -387,7 +387,7 @@ struct security_class_mapping {
  * offsets for a particular policy.  However, that strongly ties the build of the userspace components to a particular policy.
  *
  * By using this function to map between integer offsets and security
- * class names, it's possible to replace a system policies that have
+ * class names, it's possible to replace a system policy with one that has
  * at least the same set of security class names as used by the
  * userspace object managers.
  *
@@ -689,8 +689,8 @@ extern int selinux_trans_to_raw_context(const char *trans, char **rawp);
 extern int selinux_raw_to_trans_context(const char *raw, char **transp);
 
 /* Perform context translation between security contexts
-   and display colors.  Returns a space-separated list of ten
-   ten hex RGB triples prefixed by hash marks, e.g. "#ff0000".
+   and display colors.  Returns a space-separated list of eight
+   hex RGB triples prefixed by hash marks, e.g. "#ff0000".
    Caller must free the resulting string via free.
    Returns -1 upon an error or 0 otherwise. */
 extern int selinux_raw_context_to_color(const char *raw, char **color_str);
-- 
2.53.0

