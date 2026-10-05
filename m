Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BC5486BB6
	for <selinux@vger.kernel.org>; Mon,  5 Oct 2026 13:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791207124; cv=none; b=WVS2brriPydWlonpz4wVa5RlvpgZ3AsTln4tvMKp4apA3wNhIpIujKLhx8Pg47Hsx1ZYJHhuQJJqkOblyeMMLFQ78xZ16EogUGtCAmWBoW0OIoU0iJA+l7XeTDub9FUBPuLktEyrOL4LbEgxUOmkQPzOAAxigPCdSWk5YlqcGe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791207124; c=relaxed/simple;
	bh=oq6sB5Vq09chYRrL22smdOcHF/INc6Kgo/88KqccwLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=EPg6uiI7ZBdsWcSgj6s3s4kRC2QzNuZTIp7A7vQd3mUcm36DMZX7QfqzdlNNHOM1VV8p69h28CbDHH1U5gLlRM+/eVQ78AvWR7RPt7ZgULzosa8LXdiXRA+vwhT70TyzJVqEX6BIKCgFGn3o4FYzwawF3XHZLH0Z0JjYuhDwOQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EUBox4s8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EUBox4s8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791207120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5PNEX33nSqt2g2yrELnARxganGW2TTwIH0RR8RwIWsI=;
	b=EUBox4s883KPR7hbtX3P/VowqYt2Z1QOYM3LJ8+w6SYcH8c7NWhEqZsNDZGBFqT9zAs1sk
	hdeyhDeJ7a1Wv4XPsnQVlCLneFHS7XodJAncocXLekUeUHXQcCKyQkCtYQP+HTw6RDfe0M
	NTZ1zsFp4T2/OVW8Dso0J052UrOOY88=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-542-T6XnjW8pMmGOUaSJZhZ1vw-1; Mon,
 05 Oct 2026 09:31:58 -0400
X-MC-Unique: T6XnjW8pMmGOUaSJZhZ1vw-1
X-Mimecast-MFC-AGG-ID: T6XnjW8pMmGOUaSJZhZ1vw_1791207117
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 958461955F61
	for <selinux@vger.kernel.org>; Mon,  5 Oct 2026 13:31:57 +0000 (UTC)
Received: from plautrba-thinkpadp16vgen1.rmtcz.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 854971956095;
	Mon,  5 Oct 2026 13:31:56 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Cc: Petr Lautrbach <lautrbach@redhat.com>
Subject: [PATCH v2 2/2] libselinux: Use SHA256 for label digests
Date: Mon,  5 Oct 2026 15:29:17 +0200
Message-ID: <20261005133143.91648-2-lautrbach@redhat.com>
In-Reply-To: <20261005133143.91648-1-lautrbach@redhat.com>
References: <20261005133143.91648-1-lautrbach@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

SHA-1 is considered obsolete

Use hashing code from libsemanage/src/sha256.*

Provide versioned selabel_hash_all_partial_matches() symbol
- selabel_hash_all_partial_matches@LIBSELINUX_1.0 generates original SHA1 digest
  and uses 20 bytes (SHA1_HASH_SIZE)
- selabel_hash_all_partial_matches@@LIBSELINUX_3.12 generates SHA256 digest and
  uses 32 bytes (SHA256_HASH_SIZE)

All external selabel_hash_all_partial_matches() users has to make sure that they
provide "uint8_t *digest" with size at least 32 bytes.

The change in digest means that the first run of `restorecon -D ...` or
`setfiles -D ...` after libselinux update will resets all directory SHA256
digest. This could cause one time performance hit.

Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
---
v1 - https://lore.kernel.org/selinux/20260930111444.192037-2-lautrbach@redhat.com/

v2 changes:

-- libselinux/src/sha256.* are copies of libsemanage/src/sha256.*
-- improved commit message
-- selabel_hash_all_partial_matches is symbol versioned


 libselinux/include/selinux/label.h            |   6 +-
 libselinux/include/selinux/restorecon.h       |   4 +-
 libselinux/man/man3/selabel_digest.3          |   4 +-
 libselinux/man/man3/selabel_open.3            |   2 +-
 libselinux/man/man3/selinux_restorecon.3      |  18 +-
 .../man/man3/selinux_restorecon_xattr.3       |   2 +-
 libselinux/src/Makefile                       |   2 +-
 libselinux/src/label.c                        |  24 +-
 libselinux/src/label_file.c                   |  64 +++-
 libselinux/src/label_internal.h               |  12 +-
 libselinux/src/label_support.c                |  17 +-
 libselinux/src/libselinux.map                 |   5 +-
 libselinux/src/selinux_restorecon.c           |  42 ++-
 libselinux/src/sha256.c                       | 274 ++++++++++++++++++
 libselinux/src/sha256.h                       |  75 +++++
 libselinux/utils/selabel_digest.c             |  26 +-
 .../selabel_get_digests_all_partial_matches.c |  30 +-
 policycoreutils/setfiles/restorecon.8         |  10 +-
 policycoreutils/setfiles/restorecon_xattr.8   |   8 +-
 policycoreutils/setfiles/restorecon_xattr.c   |  12 +-
 policycoreutils/setfiles/setfiles.8           |  10 +-
 21 files changed, 531 insertions(+), 116 deletions(-)
 create mode 100644 libselinux/src/sha256.c
 create mode 100644 libselinux/src/sha256.h

diff --git a/libselinux/include/selinux/label.h b/libselinux/include/selinux/label.h
index 994b3c9cf0a1..dc136d3589b5 100644
--- a/libselinux/include/selinux/label.h
+++ b/libselinux/include/selinux/label.h
@@ -129,13 +129,13 @@ extern int selabel_lookup_best_match_raw(struct selabel_handle *handle,
 					 const char **aliases, int type);
 
 /**
- * selabel_digest - Retrieve the SHA1 digest and the list of specfiles used to
+ * selabel_digest - Retrieve the SHA256 digest and the list of specfiles used to
  *		    generate the digest. The SELABEL_OPT_DIGEST option must
  *		    be set in selabel_open() to initiate the digest generation.
  * @handle: specifies backend instance to query
- * @digest: returns a pointer to the SHA1 digest.
+ * @digest: returns a pointer to the SHA256 digest.
  * @digest_len: returns length of digest in bytes.
- * @specfiles: a list of specfiles used in the SHA1 digest generation.
+ * @specfiles: a list of specfiles used in the SHA256 digest generation.
  *	       The list is NULL terminated and will hold @num_specfiles entries.
  * @num_specfiles: number of specfiles in the list.
  *
diff --git a/libselinux/include/selinux/restorecon.h b/libselinux/include/selinux/restorecon.h
index 34ba0f43a26c..46fcfb611f67 100644
--- a/libselinux/include/selinux/restorecon.h
+++ b/libselinux/include/selinux/restorecon.h
@@ -43,8 +43,8 @@ extern int selinux_restorecon_parallel(const char *pathname,
  * restorecon_flags options
  */
 /*
- * Force the checking of labels even if the stored SHA1 digest
- * matches the specfiles SHA1 digest (requires CAP_SYS_ADMIN).
+ * Force the checking of labels even if the stored SHA256 digest
+ * matches the specfiles SHA256 digest (requires CAP_SYS_ADMIN).
  */
 #define SELINUX_RESTORECON_IGNORE_DIGEST 0x00001
 /*
diff --git a/libselinux/man/man3/selabel_digest.3 b/libselinux/man/man3/selabel_digest.3
index 56a008f00df0..5f7c42533d0e 100644
--- a/libselinux/man/man3/selabel_digest.3
+++ b/libselinux/man/man3/selabel_digest.3
@@ -20,11 +20,11 @@ selabel_digest \- Return digest of specfiles and list of files used
 .BR selabel_digest ()
 performs an operation on the handle
 .IR hnd ,
-returning the results of the SHA1 digest pointed to by
+returning the results of the SHA256 digest pointed to by
 .IR digest ,
 whose length will be
 .IR digest_len .
-The list of specfiles used in the SHA1 digest calculation is returned in
+The list of specfiles used in the SHA256 digest calculation is returned in
 .I specfiles
 with the number of entries in
 .IR num_specfiles .
diff --git a/libselinux/man/man3/selabel_open.3 b/libselinux/man/man3/selabel_open.3
index fa71d27c3482..9df777cdfcf9 100644
--- a/libselinux/man/man3/selabel_open.3
+++ b/libselinux/man/man3/selabel_open.3
@@ -69,7 +69,7 @@ is used; a custom validation function can be provided via
 Note that an invalid context may not be treated as an error unless it is actually encountered during a lookup operation.
 .TP
 .B SELABEL_OPT_DIGEST
-A non-null value for this option enables the generation of an SHA1 digest of
+A non-null value for this option enables the generation of an SHA256 digest of
 the spec files loaded as described in
 .BR selabel_digest (3)
 .
diff --git a/libselinux/man/man3/selinux_restorecon.3 b/libselinux/man/man3/selinux_restorecon.3
index bafa86a29768..1b1fd58b9d70 100644
--- a/libselinux/man/man3/selinux_restorecon.3
+++ b/libselinux/man/man3/selinux_restorecon.3
@@ -36,7 +36,7 @@ If this is a directory and the
 .B SELINUX_RESTORECON_RECURSE
 has been set (for descending through directories), then
 .BR selinux_restorecon ()
-will write an SHA1 digest of specfile entries calculated by
+will write an SHA256 digest of specfile entries calculated by
 .BR selabel_get_digests_all_partial_matches (3)
 to an extended attribute of
 .IR security.sehash
@@ -55,7 +55,7 @@ will take place.
 .br
 The
 .IR restorecon_flags
-that can be used to manage the usage of the SHA1 digest are:
+that can be used to manage the usage of the SHA256 digest are:
 .RS
 .B SELINUX_RESTORECON_SKIP_DIGEST
 .br
@@ -73,8 +73,8 @@ Do not check or update any extended attribute
 entries.
 .sp
 .B SELINUX_RESTORECON_IGNORE_DIGEST
-force the checking of labels even if the stored SHA1 digest matches the
-specfile entries SHA1 digest. The specfile entries digest will be written to the
+force the checking of labels even if the stored SHA256 digest matches the
+specfile entries SHA256 digest. The specfile entries digest will be written to the
 .IR security.sehash
 extended attribute once relabeling has been completed successfully provided the
 .B SELINUX_RESTORECON_NOCHANGE
@@ -95,7 +95,7 @@ default specfile context.
 .sp
 .B SELINUX_RESTORECON_RECURSE
 change file and directory labels recursively (descend directories)
-and if successful write an SHA1 digest of the specfile entries to an
+and if successful write an SHA256 digest of the specfile entries to an
 extended attribute as described in the
 .B NOTES
 section.
@@ -194,7 +194,7 @@ for fetching the ignored (skipped) error count after
 or
 .BR selinux_restorecon_parallel (3)
 completes with success. In case any errors were skipped during the file tree
-walk, the specfile entries SHA1 digest will not have been written to the
+walk, the specfile entries SHA256 digest will not have been written to the
 .IR security.sehash
 extended attribute.
 .sp
@@ -212,7 +212,7 @@ Use this option when relabeling untrusted directories that might
 contain hard links to files owned by others.
 .RE
 .sp
-The behavior regarding the checking and updating of the SHA1 digest described
+The behavior regarding the checking and updating of the SHA256 digest described
 above is the default behavior. It is possible to change this by first calling
 .BR selabel_open (3)
 and not enabling the
@@ -275,7 +275,7 @@ To improve performance when relabeling file systems recursively (e.g. the
 .B SELINUX_RESTORECON_RECURSE
 flag is set)
 .BR selinux_restorecon ()
-will write a calculated SHA1 digest of the specfile entries returned by
+will write a calculated SHA256 digest of the specfile entries returned by
 .BR selabel_get_digests_all_partial_matches (3)
 to an extended attribute named
 .IR security.sehash
@@ -297,7 +297,7 @@ Should any of the specfile entries have changed, then when
 .BR selinux_restorecon ()
 is run again with the
 .B SELINUX_RESTORECON_RECURSE
-flag set, new SHA1 digests will be calculated and all files automatically
+flag set, new SHA256 digests will be calculated and all files automatically
 relabeled depending on the settings of the
 .B SELINUX_RESTORECON_SET_SPECFILE_CTX
 flag (provided
diff --git a/libselinux/man/man3/selinux_restorecon_xattr.3 b/libselinux/man/man3/selinux_restorecon_xattr.3
index c56326814b94..098c840fc59b 100644
--- a/libselinux/man/man3/selinux_restorecon_xattr.3
+++ b/libselinux/man/man3/selinux_restorecon_xattr.3
@@ -119,7 +119,7 @@ By default
 .BR selinux_restorecon_xattr (3)
 will use the default set of specfiles described in
 .BR files_contexts (5)
-to calculate the SHA1 digests to be used for comparison.
+to calculate the SHA256 digests to be used for comparison.
 To change this default behavior
 .BR selabel_open (3)
 must be called specifying the required
diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 9ecdbd4d0af8..7ce094cd0855 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -130,7 +130,7 @@ DISABLE_FLAGS+= -DNO_MEDIA_BACKEND -DNO_DB_BACKEND -DNO_X_BACKEND \
 	-DBUILD_HOST
 SRCS= callbacks.c freecon.c label.c label_file.c \
 	label_backends_android.c regex.c label_support.c \
-	matchpathcon.c setrans_client.c sha1.c booleans.c
+	matchpathcon.c setrans_client.c sha1.c sha256.c booleans.c
 LABEL_BACKEND_ANDROID=y
 endif
 
diff --git a/libselinux/src/label.c b/libselinux/src/label.c
index 93848bfebd16..03606fa248e6 100644
--- a/libselinux/src/label.c
+++ b/libselinux/src/label.c
@@ -338,15 +338,31 @@ bool selabel_get_digests_all_partial_matches(struct selabel_handle *rec,
 		rec, key, calculated_digest, xattr_digest, digest_len);
 }
 
-bool selabel_hash_all_partial_matches(struct selabel_handle *rec,
-				      const char *key, uint8_t *digest)
+bool selabel_hash_all_partial_matches_sha1_compat(struct selabel_handle *rec,
+						  const char *key,
+						  uint8_t *digest);
+bool selabel_hash_all_partial_matches_sha1_compat(struct selabel_handle *rec,
+						  const char *key,
+						  uint8_t *digest)
 {
-	if (!rec->func_hash_all_partial_matches) {
+	if (!rec->func_hash_all_partial_matches_sha1)
+		return false;
+
+	return rec->func_hash_all_partial_matches_sha1(rec, key, digest);
+}
+__asm__(".symver selabel_hash_all_partial_matches_sha1_compat, selabel_hash_all_partial_matches@LIBSELINUX_1.0");
+
+bool selabel_hash_all_partial_matches_sha256(struct selabel_handle *rec,
+					     const char *key, uint8_t *digest);
+bool selabel_hash_all_partial_matches_sha256(struct selabel_handle *rec,
+					     const char *key, uint8_t *digest)
+{
+	if (!rec->func_hash_all_partial_matches)
 		return false;
-	}
 
 	return rec->func_hash_all_partial_matches(rec, key, digest);
 }
+__asm__(".symver selabel_hash_all_partial_matches_sha256, selabel_hash_all_partial_matches@@LIBSELINUX_3.12");
 
 int selabel_lookup_best_match(struct selabel_handle *rec, char **con,
 			      const char *key, const char **aliases, int type)
diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 8ad1b97cc09e..45b9b0931353 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -2434,7 +2434,7 @@ static struct lookup_result *lookup_common(struct selabel_handle *rec,
 
 /*
  * Returns true if the digest of all partial matched contexts is the same as
- * the one saved by setxattr, otherwise returns false. The length of the SHA1
+ * the one saved by setxattr, otherwise returns false. The length of the SHA256
  * digest will always be returned. The caller must free any returned digests.
  */
 static bool get_digests_all_partial_matches(struct selabel_handle *rec,
@@ -2443,40 +2443,40 @@ static bool get_digests_all_partial_matches(struct selabel_handle *rec,
 					    uint8_t **xattr_digest,
 					    size_t *digest_len)
 {
-	uint8_t read_digest[SHA1_HASH_SIZE];
+	uint8_t read_digest[SHA256_HASH_SIZE];
 	ssize_t read_size = getxattr(pathname, RESTORECON_PARTIAL_MATCH_DIGEST,
-				     read_digest, SHA1_HASH_SIZE
+				     read_digest, SHA256_HASH_SIZE
 #ifdef __APPLE__
 				     ,
 				     0, 0
 #endif /* __APPLE __ */
 	);
-	uint8_t hash_digest[SHA1_HASH_SIZE];
+	uint8_t hash_digest[SHA256_HASH_SIZE];
 	bool status =
-		selabel_hash_all_partial_matches(rec, pathname, hash_digest);
+		rec->func_hash_all_partial_matches(rec, pathname, hash_digest);
 
 	*xattr_digest = NULL;
 	*calculated_digest = NULL;
-	*digest_len = SHA1_HASH_SIZE;
+	*digest_len = SHA256_HASH_SIZE;
 
-	if (read_size == SHA1_HASH_SIZE) {
-		*xattr_digest = calloc(1, SHA1_HASH_SIZE + 1);
+	if (read_size == SHA256_HASH_SIZE) {
+		*xattr_digest = calloc(1, SHA256_HASH_SIZE + 1);
 		if (!*xattr_digest)
 			goto oom;
 
-		memcpy(*xattr_digest, read_digest, SHA1_HASH_SIZE);
+		memcpy(*xattr_digest, read_digest, SHA256_HASH_SIZE);
 	}
 
 	if (status) {
-		*calculated_digest = calloc(1, SHA1_HASH_SIZE + 1);
+		*calculated_digest = calloc(1, SHA256_HASH_SIZE + 1);
 		if (!*calculated_digest)
 			goto oom;
 
-		memcpy(*calculated_digest, hash_digest, SHA1_HASH_SIZE);
+		memcpy(*calculated_digest, hash_digest, SHA256_HASH_SIZE);
 	}
 
-	if (status && read_size == SHA1_HASH_SIZE &&
-	    memcmp(read_digest, hash_digest, SHA1_HASH_SIZE) == 0)
+	if (status && read_size == SHA256_HASH_SIZE &&
+	    memcmp(read_digest, hash_digest, SHA256_HASH_SIZE) == 0)
 		return true;
 
 	return false;
@@ -2486,8 +2486,8 @@ oom:
 	return false;
 }
 
-static bool hash_all_partial_matches(struct selabel_handle *rec,
-				     const char *key, uint8_t *digest)
+static bool hash_all_partial_matches_sha1(struct selabel_handle *rec,
+					  const char *key, uint8_t *digest)
 {
 	assert(digest);
 
@@ -2518,6 +2518,38 @@ static bool hash_all_partial_matches(struct selabel_handle *rec,
 	return true;
 }
 
+static bool hash_all_partial_matches(struct selabel_handle *rec,
+				     const char *key, uint8_t *digest)
+{
+	assert(digest);
+
+	struct lookup_result *matches =
+		lookup_all(rec, key, 0, true, true, NULL);
+	if (!matches) {
+		return false;
+	}
+
+	Sha256Context context;
+	Sha256Initialise(&context);
+
+	for (const struct lookup_result *m = matches; m; m = m->next) {
+		const char *regex_str = m->regex_str;
+		uint8_t file_kind = m->file_kind;
+		const char *ctx_raw = m->lr->ctx_raw;
+
+		Sha256Update(&context, regex_str, strlen(regex_str) + 1);
+		Sha256Update(&context, &file_kind, sizeof(file_kind));
+		Sha256Update(&context, ctx_raw, strlen(ctx_raw) + 1);
+	}
+
+	SHA256_HASH sha256_hash;
+	Sha256Finalise(&context, &sha256_hash);
+	memcpy(digest, sha256_hash.bytes, SHA256_HASH_SIZE);
+
+	free_lookup_result(matches);
+	return true;
+}
+
 static struct selabel_lookup_rec *lookup(struct selabel_handle *rec,
 					 const char *key, int type)
 {
@@ -3064,6 +3096,8 @@ int selabel_file_init(struct selabel_handle *rec,
 	rec->func_get_digests_all_partial_matches =
 		&get_digests_all_partial_matches;
 	rec->func_hash_all_partial_matches = &hash_all_partial_matches;
+	rec->func_hash_all_partial_matches_sha1 =
+		&hash_all_partial_matches_sha1;
 	rec->func_lookup_best_match = &lookup_best_match;
 	rec->func_cmp = &cmp;
 
diff --git a/libselinux/src/label_internal.h b/libselinux/src/label_internal.h
index 47c5d3cb3798..d4d4d3598017 100644
--- a/libselinux/src/label_internal.h
+++ b/libselinux/src/label_internal.h
@@ -15,6 +15,7 @@
 #include <selinux/selinux.h>
 #include <selinux/label.h>
 #include "sha1.h"
+#include "sha256.h"
 
 #if defined(ANDROID) || defined(__APPLE__)
 // Android and Mac do not have fgets_unlocked()
@@ -42,15 +43,15 @@ int selabel_service_init(struct selabel_handle *rec,
  */
 
 /*
- * Calculate an SHA1 hash of all the files used to build the specs.
+ * Calculate an SHA256 hash of all the files used to build the specs.
  * The hash value is held in rec->digest if SELABEL_OPT_DIGEST set. To
  * calculate the hash the hashbuf will hold a concatenation of all the files
  * used. This is released once the value has been calculated.
  */
-#define DIGEST_SPECFILE_SIZE SHA1_HASH_SIZE
+#define DIGEST_SPECFILE_SIZE SHA256_HASH_SIZE
 #define DIGEST_FILES_MAX 8
 struct selabel_digest {
-	unsigned char *digest; /* SHA1 digest of specfiles */
+	unsigned char *digest; /* SHA256 digest of specfiles */
 	unsigned char *hashbuf; /* buffer to hold specfiles */
 	size_t hashbuf_size; /* buffer size */
 	size_t specfile_cnt; /* how many specfiles processed */
@@ -88,6 +89,9 @@ struct selabel_handle {
 		size_t *digest_len);
 	bool (*func_hash_all_partial_matches)(struct selabel_handle *h,
 					      const char *key, uint8_t *digest);
+	bool (*func_hash_all_partial_matches_sha1)(struct selabel_handle *h,
+						   const char *key,
+						   uint8_t *digest);
 	struct selabel_lookup_rec *(*func_lookup_best_match)(
 		struct selabel_handle *h, const char *key, const char **aliases,
 		int type);
@@ -103,7 +107,7 @@ struct selabel_handle {
 	size_t spec_files_len;
 	char **spec_files;
 
-	/* ptr to SHA1 hash information if SELABEL_OPT_DIGEST set */
+	/* ptr to SHA256 hash information if SELABEL_OPT_DIGEST set */
 	struct selabel_digest *digest;
 };
 
diff --git a/libselinux/src/label_support.c b/libselinux/src/label_support.c
index 5112c59cdd5c..a229373af09c 100644
--- a/libselinux/src/label_support.c
+++ b/libselinux/src/label_support.c
@@ -214,28 +214,27 @@ int read_spec_entries(char *line_buf, size_t nread, const char **errbuf,
 /* Once all the specfiles are in the hash_buf, generate the hash. */
 void digest_gen_hash(struct selabel_digest *digest)
 {
-	Sha1Context context;
+	Sha256Context context;
 	size_t remaining_size;
 	const unsigned char *ptr;
-	const uint32_t chunkSize = UINT32_MAX >> 3;
 
 	/* If SELABEL_OPT_DIGEST not set then just return */
 	if (!digest)
 		return;
 
-	Sha1Initialise(&context);
+	Sha256Initialise(&context);
 
 	/* Process in blocks of chunkSize bytes */
 	remaining_size = digest->hashbuf_size;
 	ptr = digest->hashbuf;
-	while (remaining_size > chunkSize) {
-		Sha1Update(&context, ptr, chunkSize);
-		remaining_size -= chunkSize;
-		ptr += chunkSize;
+	while (remaining_size > UINT32_MAX) {
+		Sha256Update(&context, ptr, UINT32_MAX);
+		remaining_size -= UINT32_MAX;
+		ptr += UINT32_MAX;
 	}
-	Sha1Update(&context, ptr, remaining_size);
+	Sha256Update(&context, ptr, remaining_size);
 
-	Sha1Finalise(&context, (SHA1_HASH *)digest->digest);
+	Sha256Finalise(&context, (SHA256_HASH *)digest->digest);
 	free(digest->hashbuf);
 	digest->hashbuf = NULL;
 }
diff --git a/libselinux/src/libselinux.map b/libselinux/src/libselinux.map
index 9b439d8e7f22..b39e41d40aff 100644
--- a/libselinux/src/libselinux.map
+++ b/libselinux/src/libselinux.map
@@ -237,8 +237,8 @@ LIBSELINUX_1.0 {
     sidput;
     string_to_av_perm;
     string_to_security_class;
-  local:
-    *;
+    local:
+      *;
 };
 
 LIBSELINUX_3.4 {
@@ -271,4 +271,5 @@ LIBSELINUX_3.10 {
 LIBSELINUX_3.12 {
   global:
     selinux_policy_open;
+    selabel_hash_all_partial_matches;
 } LIBSELINUX_3.10;
diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index fbadf367ce60..681c967182fe 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -42,7 +42,7 @@
 #include "callbacks.h"
 #include "selinux_internal.h"
 #include "label_file.h"
-#include "sha1.h"
+#include "sha256.h"
 
 static struct selabel_handle *fc_sehandle = NULL;
 static bool selabel_no_digest;
@@ -364,7 +364,7 @@ static uint64_t exclude_non_seclabel_mounts(void)
 static int add_xattr_entry(const char *directory, bool delete_nonmatch,
 			   bool delete_all)
 {
-	char *sha1_buf = NULL;
+	char *sha256_buf = NULL;
 	size_t i, digest_len = 0;
 	int rc;
 	enum digest_result digest_result;
@@ -385,19 +385,30 @@ static int add_xattr_entry(const char *directory, bool delete_nonmatch,
 
 	if (!xattr_digest || !digest_len) {
 		free(calculated_digest);
+		if (delete_all || delete_nonmatch) {
+			/* legacy 20-byte SHA-1 xattr does not satisfy SHA256_HASH_SIZE, remove it */
+			rc = removexattr(directory,
+					 RESTORECON_PARTIAL_MATCH_DIGEST);
+			if (rc && errno != ENODATA)
+				selinux_log(
+					SELINUX_ERROR,
+					"Error: %m removing xattr \"%s\" from: %s\n",
+					RESTORECON_PARTIAL_MATCH_DIGEST,
+					directory);
+		}
 		return 1;
 	}
 
 	/* Convert entry to a hex encoded string. */
-	sha1_buf = malloc(digest_len * 2 + 1);
-	if (!sha1_buf) {
+	sha256_buf = malloc(digest_len * 2 + 1);
+	if (!sha256_buf) {
 		free(xattr_digest);
 		free(calculated_digest);
 		goto oom;
 	}
 
 	for (i = 0; i < digest_len; i++)
-		sprintf((&sha1_buf[i * 2]), "%02x", xattr_digest[i]);
+		sprintf((&sha256_buf[i * 2]), "%02x", xattr_digest[i]);
 
 	digest_result = match ? MATCH : NOMATCH;
 
@@ -418,7 +429,7 @@ static int add_xattr_entry(const char *directory, bool delete_nonmatch,
 	/* Now add entries to link list. */
 	new_entry = malloc(sizeof(struct dir_xattr));
 	if (!new_entry) {
-		free(sha1_buf);
+		free(sha256_buf);
 		goto oom;
 	}
 	new_entry->next = NULL;
@@ -426,11 +437,11 @@ static int add_xattr_entry(const char *directory, bool delete_nonmatch,
 	new_entry->directory = strdup(directory);
 	if (!new_entry->directory) {
 		free(new_entry);
-		free(sha1_buf);
+		free(sha256_buf);
 		goto oom;
 	}
 
-	new_entry->digest = sha1_buf;
+	new_entry->digest = sha256_buf;
 
 	new_entry->result = digest_result;
 
@@ -441,7 +452,6 @@ static int add_xattr_entry(const char *directory, bool delete_nonmatch,
 		dir_xattr_last->next = new_entry;
 		dir_xattr_last = new_entry;
 	}
-
 	return 0;
 
 oom:
@@ -902,7 +912,7 @@ err:
  * relabeling this directory.
  */
 static bool check_context_match_for_dir(const char *pathname,
-					uint8_t digest_out[SHA1_HASH_SIZE],
+					uint8_t digest_out[SHA256_HASH_SIZE],
 					bool *have_digest)
 {
 	bool status;
@@ -922,8 +932,8 @@ static bool check_context_match_for_dir(const char *pathname,
 
 	/* Save digest of all matched contexts for the current directory. */
 	if (calculated_digest) {
-		assert(digest_len == SHA1_HASH_SIZE);
-		memcpy(digest_out, calculated_digest, SHA1_HASH_SIZE);
+		assert(digest_len == SHA256_HASH_SIZE);
+		memcpy(digest_out, calculated_digest, SHA256_HASH_SIZE);
 		*have_digest = true;
 	}
 
@@ -938,7 +948,7 @@ struct walk_level {
 	dev_t dev;
 	ino_t ino;
 	size_t pathlen;
-	uint8_t digest[SHA1_HASH_SIZE];
+	uint8_t digest[SHA256_HASH_SIZE];
 	bool write_digest;
 };
 
@@ -1269,7 +1279,7 @@ static int walk_next(struct rest_state *state, int *ent_fd, int *rd_fd,
 			    !state->skipped_errors &&
 			    fsetxattr(dirfd(top->dirp),
 				      RESTORECON_PARTIAL_MATCH_DIGEST,
-				      top->digest, SHA1_HASH_SIZE, 0) < 0) {
+				      top->digest, SHA256_HASH_SIZE, 0) < 0) {
 				selinux_log(SELINUX_ERROR,
 					    "Could not set digest on %s: %m\n",
 					    state->pathbuf);
@@ -1438,7 +1448,7 @@ static void *selinux_restorecon_thread(void *arg)
 				continue;
 			}
 
-			uint8_t digest[SHA1_HASH_SIZE];
+			uint8_t digest[SHA256_HASH_SIZE];
 			bool have_digest = false;
 
 			if (descend && state->setrestorecondigest &&
@@ -1470,7 +1480,7 @@ static void *selinux_restorecon_thread(void *arg)
 						&state->stack[state->depth - 1];
 
 					memcpy(wl->digest, digest,
-					       SHA1_HASH_SIZE);
+					       SHA256_HASH_SIZE);
 					wl->write_digest = true;
 				}
 			}
diff --git a/libselinux/src/sha256.c b/libselinux/src/sha256.c
new file mode 100644
index 000000000000..1fc80cefa5a5
--- /dev/null
+++ b/libselinux/src/sha256.c
@@ -0,0 +1,274 @@
+////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
+//  WjCryptLib_Sha256
+//
+//  Implementation of SHA256 hash function.
+//  Original author: Tom St Denis, tomstdenis@gmail.com, http://libtom.org
+//  Modified by WaterJuice retaining Public Domain license.
+//
+//  This is free and unencumbered software released into the public domain - June 2013 waterjuice.org
+////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
+
+////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
+//  IMPORTS
+////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
+
+#include "sha256.h"
+#include <memory.h>
+
+////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
+//  MACROS
+////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
+
+#define ror(value, bits) (((value) >> (bits)) | ((value) << (32 - (bits))))
+
+#define MIN(x, y) (((x) < (y)) ? (x) : (y))
+
+#define STORE32H(x, y)                                 \
+	{                                              \
+		(y)[0] = (uint8_t)(((x) >> 24) & 255); \
+		(y)[1] = (uint8_t)(((x) >> 16) & 255); \
+		(y)[2] = (uint8_t)(((x) >> 8) & 255);  \
+		(y)[3] = (uint8_t)((x) & 255);         \
+	}
+
+#define LOAD32H(x, y)                                  \
+	{                                              \
+		x = ((uint32_t)((y)[0] & 255) << 24) | \
+		    ((uint32_t)((y)[1] & 255) << 16) | \
+		    ((uint32_t)((y)[2] & 255) << 8) |  \
+		    ((uint32_t)((y)[3] & 255));        \
+	}
+
+#define STORE64H(x, y)                                 \
+	{                                              \
+		(y)[0] = (uint8_t)(((x) >> 56) & 255); \
+		(y)[1] = (uint8_t)(((x) >> 48) & 255); \
+		(y)[2] = (uint8_t)(((x) >> 40) & 255); \
+		(y)[3] = (uint8_t)(((x) >> 32) & 255); \
+		(y)[4] = (uint8_t)(((x) >> 24) & 255); \
+		(y)[5] = (uint8_t)(((x) >> 16) & 255); \
+		(y)[6] = (uint8_t)(((x) >> 8) & 255);  \
+		(y)[7] = (uint8_t)((x) & 255);         \
+	}
+
+////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
+//  CONSTANTS
+////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
+
+// The K array
+static const uint32_t K[64] = {
+	0x428a2f98UL, 0x71374491UL, 0xb5c0fbcfUL, 0xe9b5dba5UL, 0x3956c25bUL,
+	0x59f111f1UL, 0x923f82a4UL, 0xab1c5ed5UL, 0xd807aa98UL, 0x12835b01UL,
+	0x243185beUL, 0x550c7dc3UL, 0x72be5d74UL, 0x80deb1feUL, 0x9bdc06a7UL,
+	0xc19bf174UL, 0xe49b69c1UL, 0xefbe4786UL, 0x0fc19dc6UL, 0x240ca1ccUL,
+	0x2de92c6fUL, 0x4a7484aaUL, 0x5cb0a9dcUL, 0x76f988daUL, 0x983e5152UL,
+	0xa831c66dUL, 0xb00327c8UL, 0xbf597fc7UL, 0xc6e00bf3UL, 0xd5a79147UL,
+	0x06ca6351UL, 0x14292967UL, 0x27b70a85UL, 0x2e1b2138UL, 0x4d2c6dfcUL,
+	0x53380d13UL, 0x650a7354UL, 0x766a0abbUL, 0x81c2c92eUL, 0x92722c85UL,
+	0xa2bfe8a1UL, 0xa81a664bUL, 0xc24b8b70UL, 0xc76c51a3UL, 0xd192e819UL,
+	0xd6990624UL, 0xf40e3585UL, 0x106aa070UL, 0x19a4c116UL, 0x1e376c08UL,
+	0x2748774cUL, 0x34b0bcb5UL, 0x391c0cb3UL, 0x4ed8aa4aUL, 0x5b9cca4fUL,
+	0x682e6ff3UL, 0x748f82eeUL, 0x78a5636fUL, 0x84c87814UL, 0x8cc70208UL,
+	0x90befffaUL, 0xa4506cebUL, 0xbef9a3f7UL, 0xc67178f2UL
+};
+
+#define BLOCK_SIZE 64
+
+////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
+//  INTERNAL FUNCTIONS
+////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
+
+// Various logical functions
+#define Ch(x, y, z) (z ^ (x & (y ^ z)))
+#define Maj(x, y, z) (((x | y) & z) | (x & y))
+#define S(x, n) ror((x), (n))
+#define R(x, n) (((x) & 0xFFFFFFFFUL) >> (n))
+#define Sigma0(x) (S(x, 2) ^ S(x, 13) ^ S(x, 22))
+#define Sigma1(x) (S(x, 6) ^ S(x, 11) ^ S(x, 25))
+#define Gamma0(x) (S(x, 7) ^ S(x, 18) ^ R(x, 3))
+#define Gamma1(x) (S(x, 17) ^ S(x, 19) ^ R(x, 10))
+
+#define Sha256Round(a, b, c, d, e, f, g, h, i)          \
+	t0 = h + Sigma1(e) + Ch(e, f, g) + K[i] + W[i]; \
+	t1 = Sigma0(a) + Maj(a, b, c);                  \
+	d += t0;                                        \
+	h = t0 + t1;
+
+////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
+//  TransformFunction
+//
+//  Compress 512-bits
+////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
+static void TransformFunction(Sha256Context *Context, uint8_t const *Buffer)
+{
+	uint32_t S[8];
+	uint32_t W[64];
+	uint32_t t0;
+	uint32_t t1;
+	uint32_t t;
+	int i;
+
+	// Copy state into S
+	for (i = 0; i < 8; i++) {
+		S[i] = Context->state[i];
+	}
+
+	// Copy the state into 512-bits into W[0..15]
+	for (i = 0; i < 16; i++) {
+		LOAD32H(W[i], Buffer + (4 * i));
+	}
+
+	// Fill W[16..63]
+	for (i = 16; i < 64; i++) {
+		W[i] = Gamma1(W[i - 2]) + W[i - 7] + Gamma0(W[i - 15]) +
+		       W[i - 16];
+	}
+
+	// Compress
+	for (i = 0; i < 64; i++) {
+		Sha256Round(S[0], S[1], S[2], S[3], S[4], S[5], S[6], S[7], i);
+		t = S[7];
+		S[7] = S[6];
+		S[6] = S[5];
+		S[5] = S[4];
+		S[4] = S[3];
+		S[3] = S[2];
+		S[2] = S[1];
+		S[1] = S[0];
+		S[0] = t;
+	}
+
+	// Feedback
+	for (i = 0; i < 8; i++) {
+		Context->state[i] = Context->state[i] + S[i];
+	}
+}
+
+////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
+//  PUBLIC FUNCTIONS
+////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
+
+////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
+//  Sha256Initialise
+//
+//  Initialises a SHA256 Context. Use this to initialise/reset a context.
+////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
+void Sha256Initialise(Sha256Context *Context // [out]
+)
+{
+	Context->curlen = 0;
+	Context->length = 0;
+	Context->state[0] = 0x6A09E667UL;
+	Context->state[1] = 0xBB67AE85UL;
+	Context->state[2] = 0x3C6EF372UL;
+	Context->state[3] = 0xA54FF53AUL;
+	Context->state[4] = 0x510E527FUL;
+	Context->state[5] = 0x9B05688CUL;
+	Context->state[6] = 0x1F83D9ABUL;
+	Context->state[7] = 0x5BE0CD19UL;
+}
+
+////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
+//  Sha256Update
+//
+//  Adds data to the SHA256 context. This will process the data and update the internal state of the context. Keep on
+//  calling this function until all the data has been added. Then call Sha256Finalise to calculate the hash.
+////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
+void Sha256Update(Sha256Context *Context, // [in out]
+		  void const *Buffer, // [in]
+		  size_t BufferSize // [in]
+)
+{
+	uint32_t n;
+
+	if (Context->curlen >= sizeof(Context->buf)) {
+		return;
+	}
+
+	while (BufferSize > 0) {
+		if (Context->curlen == 0 && BufferSize >= BLOCK_SIZE) {
+			TransformFunction(Context, (const uint8_t *)Buffer);
+			Context->length += BLOCK_SIZE * 8;
+			Buffer = (const uint8_t *)Buffer + BLOCK_SIZE;
+			BufferSize -= BLOCK_SIZE;
+		} else {
+			n = MIN(BufferSize, (BLOCK_SIZE - Context->curlen));
+			memcpy(Context->buf + Context->curlen, Buffer,
+			       (size_t)n);
+			Context->curlen += n;
+			Buffer = (const uint8_t *)Buffer + n;
+			BufferSize -= n;
+			if (Context->curlen == BLOCK_SIZE) {
+				TransformFunction(Context, Context->buf);
+				Context->length += 8 * BLOCK_SIZE;
+				Context->curlen = 0;
+			}
+		}
+	}
+}
+
+////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
+//  Sha256Finalise
+//
+//  Performs the final calculation of the hash and returns the digest (32 byte buffer containing 256bit hash). After
+//  calling this, Sha256Initialised must be used to reuse the context.
+////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
+void Sha256Finalise(Sha256Context *Context, // [in out]
+		    SHA256_HASH *Digest // [out]
+)
+{
+	int i;
+
+	if (Context->curlen >= sizeof(Context->buf)) {
+		return;
+	}
+
+	// Increase the length of the message
+	Context->length += Context->curlen * 8;
+
+	// Append the '1' bit
+	Context->buf[Context->curlen++] = (uint8_t)0x80;
+
+	// if the length is currently above 56 bytes we append zeros
+	// then compress.  Then we can fall back to padding zeros and length
+	// encoding like normal.
+	if (Context->curlen > 56) {
+		while (Context->curlen < 64) {
+			Context->buf[Context->curlen++] = (uint8_t)0;
+		}
+		TransformFunction(Context, Context->buf);
+		Context->curlen = 0;
+	}
+
+	// Pad up to 56 bytes of zeroes
+	while (Context->curlen < 56) {
+		Context->buf[Context->curlen++] = (uint8_t)0;
+	}
+
+	// Store length
+	STORE64H(Context->length, Context->buf + 56);
+	TransformFunction(Context, Context->buf);
+
+	// Copy output
+	for (i = 0; i < 8; i++) {
+		STORE32H(Context->state[i], Digest->bytes + (4 * i));
+	}
+}
+
+////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
+//  Sha256Calculate
+//
+//  Combines Sha256Initialise, Sha256Update, and Sha256Finalise into one function. Calculates the SHA256 hash of the
+//  buffer.
+////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
+void Sha256Calculate(void const *Buffer, // [in]
+		     size_t BufferSize, // [in]
+		     SHA256_HASH *Digest // [out]
+)
+{
+	Sha256Context context;
+
+	Sha256Initialise(&context);
+	Sha256Update(&context, Buffer, BufferSize);
+	Sha256Finalise(&context, Digest);
+}
diff --git a/libselinux/src/sha256.h b/libselinux/src/sha256.h
new file mode 100644
index 000000000000..a55a5bcdb5f8
--- /dev/null
+++ b/libselinux/src/sha256.h
@@ -0,0 +1,75 @@
+////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
+//  WjCryptLib_Sha256
+//
+//  Implementation of SHA256 hash function.
+//  Original author: Tom St Denis, tomstdenis@gmail.com, http://libtom.org
+//  Modified by WaterJuice retaining Public Domain license.
+//
+//  This is free and unencumbered software released into the public domain - June 2013 waterjuice.org
+////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
+
+#pragma once
+
+////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
+//  IMPORTS
+////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
+
+#include <stdint.h>
+#include <stdio.h>
+
+typedef struct {
+	uint64_t length;
+	uint32_t state[8];
+	uint32_t curlen;
+	uint8_t buf[64];
+} Sha256Context;
+
+#define SHA256_HASH_SIZE (256 / 8)
+
+typedef struct {
+	uint8_t bytes[SHA256_HASH_SIZE];
+} SHA256_HASH;
+
+////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
+//  PUBLIC FUNCTIONS
+////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
+
+////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
+//  Sha256Initialise
+//
+//  Initialises a SHA256 Context. Use this to initialise/reset a context.
+////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
+void Sha256Initialise(Sha256Context *Context // [out]
+);
+
+////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
+//  Sha256Update
+//
+//  Adds data to the SHA256 context. This will process the data and update the internal state of the context. Keep on
+//  calling this function until all the data has been added. Then call Sha256Finalise to calculate the hash.
+////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
+void Sha256Update(Sha256Context *Context, // [in out]
+		  void const *Buffer, // [in]
+		  size_t BufferSize // [in]
+);
+
+////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
+//  Sha256Finalise
+//
+//  Performs the final calculation of the hash and returns the digest (32 byte buffer containing 256bit hash). After
+//  calling this, Sha256Initialised must be used to reuse the context.
+////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
+void Sha256Finalise(Sha256Context *Context, // [in out]
+		    SHA256_HASH *Digest // [out]
+);
+
+////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
+//  Sha256Calculate
+//
+//  Combines Sha256Initialise, Sha256Update, and Sha256Finalise into one function. Calculates the SHA256 hash of the
+//  buffer.
+////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
+void Sha256Calculate(void const *Buffer, // [in]
+		     size_t BufferSize, // [in]
+		     SHA256_HASH *Digest // [out]
+);
diff --git a/libselinux/utils/selabel_digest.c b/libselinux/utils/selabel_digest.c
index 689ca7f47c5f..402f4d163fca 100644
--- a/libselinux/utils/selabel_digest.c
+++ b/libselinux/utils/selabel_digest.c
@@ -13,8 +13,8 @@ static __attribute__((__noreturn__)) void usage(const char *progname)
 		"Where:\n\t"
 		"-b  The backend - \"file\", \"media\", \"x\", \"db\" or "
 		"\"prop\"\n\t"
-		"-v  Run \"cat <specfile_list> | openssl dgst -sha1 -hex\"\n\t"
-		"    on the list of specfiles to compare the SHA1 digests.\n\t"
+		"-v  Run \"cat <specfile_list> | openssl dgst -sha256 -hex\"\n\t"
+		"    on the list of specfiles to compare the SHA256 digests.\n\t"
 		"-B  Use base specfiles only (valid for \"-b file\" only).\n\t"
 		"-i  Do not request a digest.\n\t"
 		"-f  Optional file containing the specs (defaults to\n\t"
@@ -70,12 +70,12 @@ int main(int argc, char **argv)
 	int rc, opt, validate = 0;
 	char *baseonly = NULL, *file = NULL, *digest = (char *)1;
 	char **specfiles = NULL;
-	unsigned char *sha1_digest = NULL;
+	unsigned char *sha256_digest = NULL;
 	size_t digest_len, i, num_specfiles;
 
 	char cmd_buf[4096];
 	char *cmd_ptr;
-	char *sha1_buf = NULL;
+	char *sha256_buf = NULL;
 
 	struct selabel_handle *hnd;
 	struct selinux_opt selabel_option[] = { { SELABEL_OPT_PATH, file },
@@ -145,7 +145,7 @@ int main(int argc, char **argv)
 		return -1;
 	}
 
-	rc = selabel_digest(hnd, &sha1_digest, &digest_len, &specfiles,
+	rc = selabel_digest(hnd, &sha256_digest, &digest_len, &specfiles,
 			    &num_specfiles);
 
 	if (rc) {
@@ -160,19 +160,19 @@ int main(int argc, char **argv)
 		goto err;
 	}
 
-	sha1_buf = malloc(digest_len * 2 + 1);
-	if (!sha1_buf) {
+	sha256_buf = malloc(digest_len * 2 + 1);
+	if (!sha256_buf) {
 		fprintf(stderr, "Could not malloc buffer ERROR: %s\n",
 			strerror(errno));
 		rc = -1;
 		goto err;
 	}
 
-	printf("SHA1 digest: ");
+	printf("SHA256 digest: ");
 	for (i = 0; i < digest_len; i++)
-		sprintf(&(sha1_buf[i * 2]), "%02x", sha1_digest[i]);
+		sprintf(&(sha256_buf[i * 2]), "%02x", sha256_digest[i]);
 
-	printf("%s\n", sha1_buf);
+	printf("%s\n", sha256_buf);
 	printf("calculated using the following specfile(s):\n");
 
 	if (specfiles) {
@@ -211,7 +211,7 @@ int main(int argc, char **argv)
 
 		if (validate) {
 			ret = snprintf(cmd_ptr, cmd_rem,
-				       "| /usr/bin/openssl dgst -sha1 -hex");
+				       "| /usr/bin/openssl dgst -sha256 -hex");
 			if (ret < 0 || (size_t)ret >= cmd_rem) {
 				fprintf(stderr,
 					"Could not format validate command\n");
@@ -219,12 +219,12 @@ int main(int argc, char **argv)
 				goto err;
 			}
 
-			rc = run_check_digest(cmd_buf, sha1_buf, digest_len);
+			rc = run_check_digest(cmd_buf, sha256_buf, digest_len);
 		}
 	}
 
 err:
-	free(sha1_buf);
+	free(sha256_buf);
 	selabel_close(hnd);
 	return rc;
 }
diff --git a/libselinux/utils/selabel_get_digests_all_partial_matches.c b/libselinux/utils/selabel_get_digests_all_partial_matches.c
index 0552ef0f58df..0fc193c858df 100644
--- a/libselinux/utils/selabel_get_digests_all_partial_matches.c
+++ b/libselinux/utils/selabel_get_digests_all_partial_matches.c
@@ -16,8 +16,8 @@ static __attribute__((__noreturn__)) void usage(const char *progname)
 		"-v  Validate file_contxts entries against loaded policy.\n\t"
 		"-r  Recursively descend directories.\n\t"
 		"-f  Optional file_contexts file (defaults to current policy).\n\t"
-		"path  Path to check current SHA1 digest against file_contexts entries.\n\n"
-		"This will check the directory selinux.sehash SHA1 digest for "
+		"path  Path to check current SHA256 digest against file_contexts entries.\n\n"
+		"This will check the directory selinux.sehash SHA256 digest for "
 		"<path> against\na newly generated digest based on the "
 		"file_context entries for that node\n(using the regx, mode "
 		"and path entries).\n",
@@ -36,7 +36,7 @@ int main(int argc, char **argv)
 	char *paths[2] = { NULL, NULL };
 	uint8_t *xattr_digest = NULL;
 	uint8_t *calculated_digest = NULL;
-	char *sha1_buf = NULL;
+	char *sha256_buf = NULL;
 
 	struct selabel_handle *hnd;
 	struct selinux_opt selabel_option[] = {
@@ -101,8 +101,8 @@ int main(int argc, char **argv)
 				hnd, ftsent->fts_path, &calculated_digest,
 				&xattr_digest, &digest_len);
 
-			sha1_buf = calloc(1, digest_len * 2 + 1);
-			if (!sha1_buf) {
+			sha256_buf = calloc(1, digest_len * 2 + 1);
+			if (!sha256_buf) {
 				fprintf(stderr,
 					"Could not calloc buffer ERROR: %s\n",
 					strerror(errno));
@@ -110,19 +110,20 @@ int main(int argc, char **argv)
 			}
 
 			if (status) { /* They match */
-				printf("xattr and file_contexts SHA1 digests match for: %s\n",
+				printf("xattr and file_contexts SHA256 digests match for: %s\n",
 				       ftsent->fts_path);
 
 				if (calculated_digest) {
 					for (i = 0; i < digest_len; i++)
-						sprintf((&sha1_buf[i * 2]),
+						sprintf((&sha256_buf[i * 2]),
 							"%02x",
 							calculated_digest[i]);
-					printf("SHA1 digest: %s\n", sha1_buf);
+					printf("SHA256 digest: %s\n",
+					       sha256_buf);
 				}
 			} else {
 				if (!calculated_digest) {
-					printf("No SHA1 digest available for: %s\n",
+					printf("No SHA256 digest available for: %s\n",
 					       ftsent->fts_path);
 					printf("as file_context entry is \"<<none>>\"\n");
 					goto cleanup;
@@ -132,25 +133,26 @@ int main(int argc, char **argv)
 				       ftsent->fts_path);
 
 				for (i = 0; i < digest_len; i++)
-					sprintf((&sha1_buf[i * 2]), "%02x",
+					sprintf((&sha256_buf[i * 2]), "%02x",
 						calculated_digest[i]);
-				printf("generated SHA1 digest: %s\n", sha1_buf);
+				printf("generated SHA256 digest: %s\n",
+				       sha256_buf);
 
 				if (!xattr_digest) {
 					printf("however there is no selinux.sehash xattr entry.\n");
 				} else {
 					printf("however it does NOT match the current entry of:\n");
 					for (i = 0; i < digest_len; i++)
-						sprintf((&sha1_buf[i * 2]),
+						sprintf((&sha256_buf[i * 2]),
 							"%02x",
 							xattr_digest[i]);
-					printf("%s\n", sha1_buf);
+					printf("%s\n", sha256_buf);
 				}
 			}
 cleanup:
 			free(xattr_digest);
 			free(calculated_digest);
-			free(sha1_buf);
+			free(sha256_buf);
 			break;
 		}
 		default:
diff --git a/policycoreutils/setfiles/restorecon.8 b/policycoreutils/setfiles/restorecon.8
index 3a8b8ee098c6..6b84604982e0 100644
--- a/policycoreutils/setfiles/restorecon.8
+++ b/policycoreutils/setfiles/restorecon.8
@@ -111,14 +111,14 @@ display usage information and exit.
 ignore files that do not exist.
 .TP
 .B \-I
-ignore digest to force checking of labels even if the stored SHA1 digest
-matches the specfiles SHA1 digest. The digest will then be updated provided
+ignore digest to force checking of labels even if the stored SHA256 digest
+matches the specfiles SHA256 digest. The digest will then be updated provided
 there are no errors. See the
 .B NOTES
 section for further details.
 .TP
 .B \-D
-Set or update any directory SHA1 digests. Use this option to
+Set or update any directory SHA256 digests. Use this option to
 enable usage of the
 .IR security.sehash
 extended attribute.
@@ -237,7 +237,7 @@ the
 .B \-D
 option to
 .B restorecon
-will cause it to store a SHA1 digest of the default specfiles set in an extended
+will cause it to store a SHA256 digest of the default specfiles set in an extended
 attribute named
 .IR security.sehash
 on each directory specified in
@@ -254,7 +254,7 @@ for further details.
 .sp
 The
 .B \-I
-option will ignore the SHA1 digest from each directory specified in
+option will ignore the SHA256 digest from each directory specified in
 .IR pathname \ ...
 and provided the
 .B \-n
diff --git a/policycoreutils/setfiles/restorecon_xattr.8 b/policycoreutils/setfiles/restorecon_xattr.8
index 51d12a4dbb80..09bfd8c40ab4 100644
--- a/policycoreutils/setfiles/restorecon_xattr.8
+++ b/policycoreutils/setfiles/restorecon_xattr.8
@@ -23,7 +23,7 @@ or
 
 .SH "DESCRIPTION"
 .B restorecon_xattr
-will display the SHA1 digests added to extended attributes
+will display the SHA256 digests added to extended attributes
 .I security.sehash
 or delete the attribute completely. These attributes are set by
 .BR restorecon (8)
@@ -48,12 +48,12 @@ extended attribute and are automatically excluded from searches.
 .sp
 By default
 .B restorecon_xattr
-will display the SHA1 digests with "Match" appended if they match the default
+will display the SHA256 digests with "Match" appended if they match the default
 specfile set or the
 .I specfile
 set used with the
 .B \-f
-option. Non-matching SHA1 digests will be displayed with "No Match" appended.
+option. Non-matching SHA256 digests will be displayed with "No Match" appended.
 This feature can be disabled by the
 .B \-n
 option.
@@ -87,7 +87,7 @@ Do not append "Match" or "No Match" to displayed digests.
 recursively descend directories.
 .TP
 .B \-v
-display SHA1 digest generated by specfile set (Note that this digest is not
+display SHA256 digest generated by specfile set (Note that this digest is not
 used to match the
 .I security.sehash
 directory digest entries, and is shown for reference only).
diff --git a/policycoreutils/setfiles/restorecon_xattr.c b/policycoreutils/setfiles/restorecon_xattr.c
index e8604ec63c29..738319edb4a4 100644
--- a/policycoreutils/setfiles/restorecon_xattr.c
+++ b/policycoreutils/setfiles/restorecon_xattr.c
@@ -38,7 +38,7 @@ int main(int argc, char **argv)
 	unsigned int xattr_flags = 0, delete_digest = 0, recurse = 0;
 	unsigned int delete_all_digests = 0, ignore_mounts = 0;
 	bool display_digest = false;
-	char *sha1_buf, **specfiles, *fc_file = NULL, *pathname = NULL;
+	char *sha256_buf, **specfiles, *fc_file = NULL, *pathname = NULL;
 	unsigned char *fc_digest = NULL;
 	size_t i, fc_digest_len = 0, num_specfiles;
 
@@ -134,8 +134,8 @@ int main(int argc, char **argv)
 			exit(-1);
 		}
 
-		sha1_buf = malloc(fc_digest_len * 2 + 1);
-		if (!sha1_buf) {
+		sha256_buf = malloc(fc_digest_len * 2 + 1);
+		if (!sha256_buf) {
 			fprintf(stderr, "Error allocating digest buffer: %s\n",
 				strerror(errno));
 			selabel_close(hnd);
@@ -143,16 +143,16 @@ int main(int argc, char **argv)
 		}
 
 		for (i = 0; i < fc_digest_len; i++)
-			sprintf((&sha1_buf[i * 2]), "%02x", fc_digest[i]);
+			sprintf((&sha256_buf[i * 2]), "%02x", fc_digest[i]);
 
-		printf("specfiles SHA1 digest: %s\n", sha1_buf);
+		printf("specfiles SHA256 digest: %s\n", sha256_buf);
 
 		printf("calculated using the following specfile(s):\n");
 		if (specfiles) {
 			for (i = 0; i < num_specfiles; i++)
 				printf("%s\n", specfiles[i]);
 		}
-		free(sha1_buf);
+		free(sha256_buf);
 		printf("\n");
 	}
 
diff --git a/policycoreutils/setfiles/setfiles.8 b/policycoreutils/setfiles/setfiles.8
index 88f4ecefcde7..fe7aa17f05c7 100644
--- a/policycoreutils/setfiles/setfiles.8
+++ b/policycoreutils/setfiles/setfiles.8
@@ -106,14 +106,14 @@ display usage information and exit.
 ignore files that do not exist.
 .TP
 .B \-I
-ignore digest to force checking of labels even if the stored SHA1 digest
-matches the specfiles SHA1 digest. The digest will then be updated provided
+ignore digest to force checking of labels even if the stored SHA256 digest
+matches the specfiles SHA256 digest. The digest will then be updated provided
 there are no errors. See the
 .B NOTES
 section for further details.
 .TP
 .B \-D
-Set or update any directory SHA1 digests. Use this option to
+Set or update any directory SHA256 digests. Use this option to
 enable usage of the
 .IR security.sehash
 extended attribute.
@@ -298,7 +298,7 @@ the
 .B \-D
 option to
 .B setfiles
-will cause it to store a SHA1 digest of the
+will cause it to store a SHA256 digest of the
 .B spec_file
 set in an extended attribute named
 .IR security.sehash
@@ -319,7 +319,7 @@ for further details.
 .sp
 The
 .B \-I
-option will ignore the SHA1 digest from each directory specified in
+option will ignore the SHA256 digest from each directory specified in
 .IR pathname \ ...
 and provided the
 .B \-n
-- 
2.55.0

