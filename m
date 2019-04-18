Return-Path: <SRS0=jmdh=SU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29617C10F0B
	for <selinux@archiver.kernel.org>; Thu, 18 Apr 2019 08:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBEDD20821
	for <selinux@archiver.kernel.org>; Thu, 18 Apr 2019 08:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="rqjCo1+6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388238AbfDRI1H (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 04:27:07 -0400
Received: from rgout0603.bt.lon5.cpcloud.co.uk ([65.20.0.130]:7510 "EHLO
        rgout06.bt.lon5.cpcloud.co.uk" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726873AbfDRI1H (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 04:27:07 -0400
X-OWM-Source-IP: 31.49.61.120 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade-Verdict: clean 0
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-SNCR-VADESECURE: CLEAN
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduuddrfeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucfkphepfedurdegledriedurdduvddtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepfedurdegledriedurdduvddtpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqeenucevlhhushhtvghrufhiiigvpedt
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade-Verdict: clean 0
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-SNCR-VADESECURE: CLEAN
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduuddrfeehgddtvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecukfhppeefuddrgeelrdeiuddruddvtdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeefuddrgeelrdeiuddruddvtddpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqeenucevlhhushhtvghrufhiiigvpedt
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade-Verdict: clean 0
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-SNCR-VADESECURE: CLEAN
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduuddrfeehgddtfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecukfhppeefuddrgeelrdeiuddruddvtdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeefuddrgeelrdeiuddruddvtddpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqeenucevlhhushhtvghrufhiiigvpedt
Received: from localhost.localdomain (31.49.61.120) by rgout06.bt.lon5.cpcloud.co.uk (9.0.019.26-1) (authenticated as richard_c_haines@btinternet.com)
        id 5C3942FB093B9E70; Thu, 18 Apr 2019 09:08:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btcpcloud; t=1555576021; 
        bh=qpc8y8YDSt8EW7k2Tar4GDCeeGSlQU3ScQAHfuKs5UM=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=rqjCo1+6f6q1nL5BUyKzEYAcXxKcA8N8lqegqxWwCUs2rzZU6e0BurYWPTdP2rhug/PUzt+JL1/wsxvPiNLcOTasT9OSwq6Iu97sm2t08LvAXwVcMgqG2AWTeW0dOxZIt1lQB57Hnd36gPnZv+CTNx4x1H+6pFbHY54sRpcfhjI=
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [RFC PATCH 1/1] libselinux: Save digest of all partial matches for directory
Date:   Thu, 18 Apr 2019 09:08:19 +0100
Message-Id: <20190418080819.2890-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

We used to hash the file_context and skip the restorecon on the top
level directory if the hash doesn't change. But the file_context
might change after an OTA update; and some users experienced long
restorecon time as they have lots of files under directories like
/data/media.

This CL tries to hash all the partial match entries in the
file_context for each directory; and skips the restorecon if that
digest stays the same, regardless of the changes to the other parts
of file_context.

This is a version ported from Android that was originally written by:
xunchang <xunchang@google.com>

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 libselinux/include/selinux/label.h            |   5 +
 .../selabel_get_digests_all_partial_matches.3 |  69 ++++++
 libselinux/src/label.c                        |  15 ++
 libselinux/src/label_file.c                   |  51 +++++
 libselinux/src/label_file.h                   |   4 +
 libselinux/src/label_internal.h               |   5 +
 libselinux/src/selinux_restorecon.c           | 204 +++++++++++++-----
 libselinux/utils/.gitignore                   |   2 +
 .../selabel_get_digests_all_partial_matches.c | 171 +++++++++++++++
 .../utils/selabel_hash_all_partial_matches.c  | 126 +++++++++++
 10 files changed, 595 insertions(+), 57 deletions(-)
 create mode 100644 libselinux/man/man3/selabel_get_digests_all_partial_matches.3
 create mode 100644 libselinux/utils/selabel_get_digests_all_partial_matches.c
 create mode 100644 libselinux/utils/selabel_hash_all_partial_matches.c

diff --git a/libselinux/include/selinux/label.h b/libselinux/include/selinux/label.h
index e537aa1..9628263 100644
--- a/libselinux/include/selinux/label.h
+++ b/libselinux/include/selinux/label.h
@@ -106,6 +106,11 @@ int selabel_lookup_raw(struct selabel_handle *handle, char **con,
 
 bool selabel_partial_match(struct selabel_handle *handle, const char *key);
 
+bool selabel_get_digests_all_partial_matches(struct selabel_handle *rec,
+					     const char *key,
+					     uint8_t **calculated_digest,
+					     uint8_t **xattr_digest,
+					     size_t *digest_len);
 bool selabel_hash_all_partial_matches(struct selabel_handle *rec,
                                       const char *key, uint8_t* digest);
 
diff --git a/libselinux/man/man3/selabel_get_digests_all_partial_matches.3 b/libselinux/man/man3/selabel_get_digests_all_partial_matches.3
new file mode 100644
index 0000000..f30e998
--- /dev/null
+++ b/libselinux/man/man3/selabel_get_digests_all_partial_matches.3
@@ -0,0 +1,69 @@
+.TH "selabel_get_digests_all_partial_matches" "3" "14 April 2019" "SELinux API documentation"
+
+.SH "NAME"
+selabel_get_digests_all_partial_matches \- retrieve the partial matches digest
+and the xattr digest that applies to the supplied path \- Only supported
+on file backend.
+.
+.SH "SYNOPSIS"
+.B #include <stdbool.h>
+.br
+.B #include <selinux/selinux.h>
+.br
+.B #include <selinux/label.h>
+.sp
+.BI "bool selabel_get_digests_all_partial_matches("
+.in +\w'selabel_get_digests_all_partial_matches('u
+.BI "struct selabel_handle *" hnd ,
+.br
+.BI "const char *" key ,
+.br
+.BI "uint8_t **" calculated_digest ,
+.br
+.BI "uint8_t **" xattr_digest ,
+.br
+.BI "size_t *" digest_len ");"
+.in
+.
+.SH "DESCRIPTION"
+.BR selabel_get_digests_all_partial_matches ()
+retrieves the file_contexts partial matches digest and the xattr digest that
+applies to the supplied path on the handle
+.IR hnd .
+.br
+The
+.IR key
+parameter is the path to retrieve the digests.
+.br
+The
+.IR calculated_digest
+is a pointer to the
+.IR key
+calculated file_contexts digest of all applicable partial matches, or NULL if
+none exist. The caller must
+.BR free (3)
+the buffer.
+.br
+The
+.IR xattr_digest
+is a pointer to the
+.IR key
+.BR xattr (7)
+stored digest, or NULL if it does not exist.
+The caller must
+.BR free (3)
+the buffer.
+.br
+The
+.IR digest_len
+is the length of the digests that will always be returned (even if both are
+NULL). Note that if both digests are returned, they will always be the same length.
+.sp
+.SH "RETURN VALUE"
+TRUE if the digests match or FALSE if they do not or either or both are missing.
+.sp
+.SH "SEE ALSO"
+.BR selabel_partial_match (3),
+.BR selabel_open (3),
+.BR selinux (8),
+.BR selabel_file (5)
diff --git a/libselinux/src/label.c b/libselinux/src/label.c
index 1d16f68..a03192e 100644
--- a/libselinux/src/label.c
+++ b/libselinux/src/label.c
@@ -274,6 +274,21 @@ bool selabel_partial_match(struct selabel_handle *rec, const char *key)
 	return rec->func_partial_match(rec, key);
 }
 
+bool selabel_get_digests_all_partial_matches(struct selabel_handle *rec,
+					     const char *key,
+					     uint8_t **calculated_digest,
+					     uint8_t **xattr_digest,
+					     size_t *digest_len)
+{
+	if (!rec->func_get_digests_all_partial_matches)
+		return false;
+
+	return rec->func_get_digests_all_partial_matches(rec, key,
+							 calculated_digest,
+							 xattr_digest,
+							 digest_len);
+}
+
 bool selabel_hash_all_partial_matches(struct selabel_handle *rec,
                                       const char *key, uint8_t *digest) {
 	if (!rec->func_hash_all_partial_matches) {
diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 90cbd66..5405bb3 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -975,6 +975,55 @@ static struct spec *lookup_common(struct selabel_handle *rec,
 	return result;
 }
 
+/*
+ * Returns true if the digest of all partial matched contexts is the same as
+ * the one saved by setxattr, otherwise returns false. The length of the SHA1
+ * digest will always be returned. The caller must free any returned digests.
+ */
+static bool get_digests_all_partial_matches(struct selabel_handle *rec,
+					    const char *pathname,
+					    uint8_t **calculated_digest,
+					    uint8_t **xattr_digest,
+					    size_t *digest_len)
+{
+	uint8_t read_digest[SHA1_HASH_SIZE];
+	ssize_t read_size = getxattr(pathname, RESTORECON_PARTIAL_MATCH_DIGEST,
+				     read_digest, SHA1_HASH_SIZE);
+	uint8_t hash_digest[SHA1_HASH_SIZE];
+	bool status = selabel_hash_all_partial_matches(rec, pathname,
+						       hash_digest);
+
+	*xattr_digest = NULL;
+	*calculated_digest = NULL;
+	*digest_len = SHA1_HASH_SIZE;
+
+	if (read_size == SHA1_HASH_SIZE) {
+		*xattr_digest = calloc(1, sizeof(SHA1_HASH_SIZE + 1));
+		if (!*xattr_digest)
+			goto oom;
+
+		memcpy(*xattr_digest, read_digest, SHA1_HASH_SIZE);
+	}
+
+	if (status) {
+		*calculated_digest = calloc(1, sizeof(SHA1_HASH_SIZE + 1));
+		if (!*calculated_digest)
+			goto oom;
+
+		memcpy(*calculated_digest, hash_digest, SHA1_HASH_SIZE);
+	}
+
+	if (status && read_size == SHA1_HASH_SIZE &&
+	    memcmp(read_digest, hash_digest, SHA1_HASH_SIZE) == 0)
+		return true;
+
+	return false;
+
+oom:
+	selinux_log(SELINUX_ERROR, "SELinux: %s: Out of memory\n", __func__);
+	return false;
+}
+
 static bool hash_all_partial_matches(struct selabel_handle *rec, const char *key, uint8_t *digest)
 {
 	assert(digest);
@@ -1203,6 +1252,8 @@ int selabel_file_init(struct selabel_handle *rec,
 	rec->func_stats = &stats;
 	rec->func_lookup = &lookup;
 	rec->func_partial_match = &partial_match;
+	rec->func_get_digests_all_partial_matches =
+					&get_digests_all_partial_matches;
 	rec->func_hash_all_partial_matches = &hash_all_partial_matches;
 	rec->func_lookup_best_match = &lookup_best_match;
 	rec->func_cmp = &cmp;
diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index 47859ba..3af7377 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -6,6 +6,7 @@
 #include <string.h>
 
 #include <sys/stat.h>
+#include <sys/xattr.h>
 
 /*
  * regex.h/c were introduced to hold all dependencies on the regular
@@ -31,6 +32,9 @@
 #define SELINUX_COMPILED_FCONTEXT_MAX_VERS \
 	SELINUX_COMPILED_FCONTEXT_REGEX_ARCH
 
+/* Required selinux_restorecon and selabel_get_digests_all_partial_matches() */
+#define RESTORECON_PARTIAL_MATCH_DIGEST  "security.sehash"
+
 struct selabel_sub {
 	char *src;
 	int slen;
diff --git a/libselinux/src/label_internal.h b/libselinux/src/label_internal.h
index 1fa5ade..7ed2a43 100644
--- a/libselinux/src/label_internal.h
+++ b/libselinux/src/label_internal.h
@@ -87,6 +87,11 @@ struct selabel_handle {
 	void (*func_close) (struct selabel_handle *h);
 	void (*func_stats) (struct selabel_handle *h);
 	bool (*func_partial_match) (struct selabel_handle *h, const char *key);
+	bool (*func_get_digests_all_partial_matches) (struct selabel_handle *h,
+						      const char *key,
+						      uint8_t **calculated_digest,
+						      uint8_t **xattr_digest,
+						      size_t *digest_len);
 	bool (*func_hash_all_partial_matches) (struct selabel_handle *h,
 	                                       const char *key, uint8_t *digest);
 	struct selabel_lookup_rec *(*func_lookup_best_match)
diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index 5f18923..ce62372 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -36,8 +36,8 @@
 
 #include "callbacks.h"
 #include "selinux_internal.h"
-
-#define RESTORECON_LAST "security.restorecon_last"
+#include "label_file.h"
+#include "sha1.h"
 
 #define SYS_PATH "/sys"
 #define SYS_PREFIX SYS_PATH "/"
@@ -299,57 +299,60 @@ static int add_xattr_entry(const char *directory, bool delete_nonmatch,
 			   bool delete_all)
 {
 	char *sha1_buf = NULL;
-	unsigned char *xattr_value = NULL;
-	ssize_t xattr_size;
-	size_t i;
+	size_t i, digest_len = 0;
 	int rc, digest_result;
 	struct dir_xattr *new_entry;
+	uint8_t *xattr_digest = NULL;
+	uint8_t *calculated_digest = NULL;
 
 	if (!directory) {
 		errno = EINVAL;
 		return -1;
 	}
 
-	xattr_value = malloc(fc_digest_len);
-	if (!xattr_value)
-		goto oom;
+	selabel_get_digests_all_partial_matches(fc_sehandle, directory,
+						&calculated_digest,
+						&xattr_digest, &digest_len);
 
-	xattr_size = getxattr(directory, RESTORECON_LAST, xattr_value,
-			      fc_digest_len);
-	if (xattr_size < 0) {
-		free(xattr_value);
+	if (!xattr_digest) {
+		free(calculated_digest);
 		return 1;
 	}
 
 	/* Convert entry to a hex encoded string. */
-	sha1_buf = malloc(xattr_size * 2 + 1);
+	sha1_buf = malloc(digest_len * 2 + 1);
 	if (!sha1_buf) {
-		free(xattr_value);
+		free(xattr_digest);
+		free(calculated_digest);
 		goto oom;
 	}
 
-	for (i = 0; i < (size_t)xattr_size; i++)
-		sprintf((&sha1_buf[i * 2]), "%02x", xattr_value[i]);
+	for (i = 0; i < digest_len; i++)
+		sprintf((&sha1_buf[i * 2]), "%02x", xattr_digest[i]);
 
-	rc = memcmp(fc_digest, xattr_value, fc_digest_len);
+	rc = memcmp(calculated_digest, xattr_digest, digest_len);
 	digest_result = rc ? NOMATCH : MATCH;
 
 	if ((delete_nonmatch && rc != 0) || delete_all) {
 		digest_result = rc ? DELETED_NOMATCH : DELETED_MATCH;
-		rc = removexattr(directory, RESTORECON_LAST);
+		rc = removexattr(directory, RESTORECON_PARTIAL_MATCH_DIGEST);
 		if (rc) {
 			selinux_log(SELINUX_ERROR,
 				  "Error: %s removing xattr \"%s\" from: %s\n",
-				  strerror(errno), RESTORECON_LAST, directory);
+				  strerror(errno),
+				  RESTORECON_PARTIAL_MATCH_DIGEST, directory);
 			digest_result = ERROR;
 		}
 	}
-	free(xattr_value);
+	free(xattr_digest);
+	free(calculated_digest);
 
 	/* Now add entries to link list. */
 	new_entry = malloc(sizeof(struct dir_xattr));
-	if (!new_entry)
+	if (!new_entry) {
+		free(sha1_buf);
 		goto oom;
+	}
 	new_entry->next = NULL;
 
 	new_entry->directory = strdup(directory);
@@ -736,6 +739,69 @@ err:
 	goto out1;
 }
 
+struct dir_hash_node {
+	char *path;
+	uint8_t digest[SHA1_HASH_SIZE];
+	struct dir_hash_node *next;
+};
+/*
+ * Returns true if the digest of all partial matched contexts is the same as
+ * the one saved by setxattr. Otherwise returns false and constructs a
+ * dir_hash_node with the newly calculated digest.
+ */
+static bool check_context_match_for_dir(const char *pathname,
+					struct dir_hash_node **new_node,
+					int error)
+{
+	bool status, rc = false;
+	size_t digest_len = 0;
+	uint8_t *read_digest = NULL;
+	uint8_t *calculated_digest = NULL;
+
+	if (!new_node)
+		return false;
+
+	*new_node = NULL;
+
+	status = selabel_get_digests_all_partial_matches(fc_sehandle, pathname,
+							 &calculated_digest,
+							 &read_digest,
+							 &digest_len);
+
+	if (status) { /* The digests match */
+		rc = true;
+		goto free;
+	}
+
+	/* Save digest of all matched contexts for the current directory. */
+	if (!error && calculated_digest) {
+		*new_node = calloc(1, sizeof(struct dir_hash_node));
+
+		if (!*new_node)
+			goto oom;
+
+		(*new_node)->path = strdup(pathname);
+
+		if (!(*new_node)->path) {
+			free(*new_node);
+			*new_node = NULL;
+			goto oom;
+		}
+		memcpy((*new_node)->digest, calculated_digest, digest_len);
+		(*new_node)->next = NULL;
+	}
+
+free:
+	free(calculated_digest);
+	free(read_digest);
+	return rc;
+
+oom:
+	selinux_log(SELINUX_ERROR, "%s: Out of memory\n", __func__);
+	goto free;
+}
+
+
 /*
  * Public API
  */
@@ -779,7 +845,8 @@ int selinux_restorecon(const char *pathname_orig,
 		   SELINUX_RESTORECON_IGNORE_MOUNTS) ? true : false;
 
 	bool issys;
-	bool setrestoreconlast = true; /* TRUE = set xattr RESTORECON_LAST
+	bool setrestoreconlast = true; /* TRUE = set xattr
+					*      RESTORECON_PARTIAL_MATCH_DIGEST
 					* FALSE = don't use xattr */
 	struct stat sb;
 	struct statfs sfsb;
@@ -788,9 +855,9 @@ int selinux_restorecon(const char *pathname_orig,
 	char *pathname = NULL, *pathdnamer = NULL, *pathdname, *pathbname;
 	char *paths[2] = { NULL, NULL };
 	int fts_flags, error, sverrno;
-	char *xattr_value = NULL;
-	ssize_t size;
 	dev_t dev_num = 0;
+	struct dir_hash_node *current = NULL;
+	struct dir_hash_node *head = NULL;
 
 	if (flags.verbose && flags.progress)
 		flags.verbose = false;
@@ -800,12 +867,6 @@ int selinux_restorecon(const char *pathname_orig,
 	if (!fc_sehandle)
 		return -1;
 
-	if (fc_digest_len) {
-		xattr_value = malloc(fc_digest_len);
-		if (!xattr_value)
-			return -1;
-	}
-
 	/*
 	 * Convert passed-in pathname to canonical pathname by resolving
 	 * realpath of containing dir, then appending last component name.
@@ -859,7 +920,6 @@ int selinux_restorecon(const char *pathname_orig,
 
 	if (lstat(pathname, &sb) < 0) {
 		if (flags.ignore_noent && errno == ENOENT) {
-			free(xattr_value);
 			free(pathdnamer);
 			free(pathname);
 			return 0;
@@ -896,21 +956,6 @@ int selinux_restorecon(const char *pathname_orig,
 			setrestoreconlast = false;
 	}
 
-	if (setrestoreconlast) {
-		size = getxattr(pathname, RESTORECON_LAST, xattr_value,
-							    fc_digest_len);
-
-		if (!flags.ignore_digest && (size_t)size == fc_digest_len &&
-			    memcmp(fc_digest, xattr_value, fc_digest_len)
-								    == 0) {
-			selinux_log(SELINUX_INFO,
-			    "Skipping restorecon as matching digest on: %s\n",
-				    pathname);
-			error = 0;
-			goto cleanup;
-		}
-	}
-
 	if (flags.set_xdev)
 		fts_flags = FTS_PHYSICAL | FTS_NOCHDIR | FTS_XDEV;
 	else
@@ -983,6 +1028,30 @@ int selinux_restorecon(const char *pathname_orig,
 				fts_set(fts, ftsent, FTS_SKIP);
 				continue;
 			}
+
+			if (setrestoreconlast) {
+				struct dir_hash_node *new_node = NULL;
+
+				if (check_context_match_for_dir(ftsent->fts_path,
+								&new_node,
+								error)) {
+					selinux_log(SELINUX_INFO,
+						    "Skipping restorecon on directory(%s)\n",
+						    ftsent->fts_path);
+					fts_set(fts, ftsent, FTS_SKIP);
+					continue;
+				}
+
+				if (new_node && !error) {
+					if (!current) {
+						current = new_node;
+						head = current;
+					} else {
+						current->next = new_node;
+						current = current->next;
+					}
+				}
+			}
 			/* fall through */
 		default:
 			error |= restorecon_sb(ftsent->fts_path,
@@ -995,13 +1064,24 @@ int selinux_restorecon(const char *pathname_orig,
 		}
 	} while ((ftsent = fts_read(fts)) != NULL);
 
-	/* Labeling successful. Mark the top level directory as completed. */
-	if (setrestoreconlast && !flags.nochange && !error && fc_digest) {
-		error = setxattr(pathname, RESTORECON_LAST, fc_digest,
-						    fc_digest_len, 0);
-		if (!error && flags.verbose)
-			selinux_log(SELINUX_INFO,
-				   "Updated digest for: %s\n", pathname);
+	/*
+	 * Labeling successful. Write partial match digests for subdirectories.
+	 * TODO: Write digest upon FTS_DP if no error occurs in its descents.
+	 */
+	if (setrestoreconlast && !flags.nochange && !error) {
+		current = head;
+		while (current != NULL) {
+			if (setxattr(current->path,
+			    RESTORECON_PARTIAL_MATCH_DIGEST,
+			    current->digest,
+			    SHA1_HASH_SIZE, 0) < 0) {
+				selinux_log(SELINUX_ERROR,
+					    "setxattr failed: %s: %s\n",
+					    current->path,
+					    strerror(errno));
+			}
+			current = current->next;
+		}
 	}
 
 out:
@@ -1019,7 +1099,15 @@ cleanup:
 	}
 	free(pathdnamer);
 	free(pathname);
-	free(xattr_value);
+
+	current = head;
+	while (current != NULL) {
+		struct dir_hash_node *next = current->next;
+
+		free(current->path);
+		free(current);
+		current = next;
+	}
 	return error;
 
 oom:
@@ -1134,9 +1222,11 @@ int selinux_restorecon_set_alt_rootpath(const char *alt_rootpath)
 	return 0;
 }
 
-/* selinux_restorecon_xattr(3) - Find RESTORECON_LAST entries. */
+/* selinux_restorecon_xattr(3)
+ * Find RESTORECON_PARTIAL_MATCH_DIGEST entries.
+ */
 int selinux_restorecon_xattr(const char *pathname, unsigned int xattr_flags,
-					    struct dir_xattr ***xattr_list)
+			     struct dir_xattr ***xattr_list)
 {
 	bool recurse = (xattr_flags &
 	    SELINUX_RESTORECON_XATTR_RECURSE) ? true : false;
@@ -1157,7 +1247,7 @@ int selinux_restorecon_xattr(const char *pathname, unsigned int xattr_flags,
 
 	__selinux_once(fc_once, restorecon_init);
 
-	if (!fc_sehandle || !fc_digest_len)
+	if (!fc_sehandle)
 		return -1;
 
 	if (lstat(pathname, &sb) < 0) {
diff --git a/libselinux/utils/.gitignore b/libselinux/utils/.gitignore
index aba18a3..05847a7 100644
--- a/libselinux/utils/.gitignore
+++ b/libselinux/utils/.gitignore
@@ -15,6 +15,8 @@ matchpathcon
 policyvers
 sefcontext_compile
 selabel_digest
+selabel_get_digests_all_partial_matches
+selabel_hash_all_partial_matches
 selabel_lookup
 selabel_lookup_best_match
 selabel_partial_match
diff --git a/libselinux/utils/selabel_get_digests_all_partial_matches.c b/libselinux/utils/selabel_get_digests_all_partial_matches.c
new file mode 100644
index 0000000..2323759
--- /dev/null
+++ b/libselinux/utils/selabel_get_digests_all_partial_matches.c
@@ -0,0 +1,171 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <getopt.h>
+#include <errno.h>
+#include <stdbool.h>
+#include <fts.h>
+#include <selinux/selinux.h>
+#include <selinux/label.h>
+
+#include "../src/label_file.h"
+
+static __attribute__ ((__noreturn__)) void usage(const char *progname)
+{
+	fprintf(stderr,
+		"usage:  %s [-vrh] [-f file] path\n\n"
+		"Where:\n\t"
+		"-v  Validate file_contxts entries against loaded policy.\n\t"
+		"-r  Recursively descend directories.\n\t"
+		"-f  Optional file_contexts file (defaults to current policy).\n\t"
+		"path  Path to check current SHA1 digest against file_contexts entries.\n\n"
+		"This will check the directory selinux.sehash SHA1 digest for "
+		"<path> against\na newly generated digest based on the "
+		"file_context entries for that node\n(using the regx, mode "
+		"and path entries).\n", progname);
+	exit(1);
+}
+
+int main(int argc, char **argv)
+{
+	int opt, fts_flags;
+	size_t i, digest_len;
+	bool status, recurse = false;
+	FTS *fts;
+	FTSENT *ftsent;
+	char *validate = NULL, *file = NULL;
+	char *paths[2] = { NULL, NULL };
+	uint8_t *xattr_digest = NULL;
+	uint8_t *calculated_digest = NULL;
+	char *sha1_buf = NULL;
+
+	struct selabel_handle *hnd;
+	struct selinux_opt selabel_option[] = {
+		{ SELABEL_OPT_PATH, file },
+		{ SELABEL_OPT_VALIDATE, validate }
+	};
+
+	if (argc < 2)
+		usage(argv[0]);
+
+	while ((opt = getopt(argc, argv, "f:rvh")) > 0) {
+		switch (opt) {
+		case 'f':
+			file = optarg;
+			break;
+		case 'r':
+			recurse = true;
+			break;
+		case 'v':
+			validate = (char *)1;
+			break;
+		case 'h':
+		default:
+			usage(argv[0]);
+		}
+	}
+
+	if (optind >= argc) {
+		fprintf(stderr, "No pathname specified\n");
+		exit(-1);
+	}
+
+	paths[0] = argv[optind];
+
+	selabel_option[0].value = file;
+	selabel_option[1].value = validate;
+
+	hnd = selabel_open(SELABEL_CTX_FILE, selabel_option, 2);
+	if (!hnd) {
+		fprintf(stderr, "ERROR: selabel_open - Could not obtain "
+							     "handle.\n");
+		return -1;
+	}
+
+	fts_flags = FTS_PHYSICAL | FTS_NOCHDIR;
+	fts = fts_open(paths, fts_flags, NULL);
+	if (!fts) {
+		printf("fts error on %s: %s\n",
+		       paths[0], strerror(errno));
+		return -1;
+	}
+
+	while ((ftsent = fts_read(fts)) != NULL) {
+		switch (ftsent->fts_info) {
+		case FTS_DP:
+			continue;
+		case FTS_D: {
+
+			xattr_digest = NULL;
+			calculated_digest = NULL;
+			digest_len = 0;
+
+			status = selabel_get_digests_all_partial_matches(hnd,
+							 ftsent->fts_path,
+							 &calculated_digest,
+							 &xattr_digest,
+							 &digest_len);
+
+			sha1_buf = calloc(1, digest_len * 2 + 1);
+			if (!sha1_buf) {
+				fprintf(stderr, "Could not calloc buffer ERROR: %s\n",
+					    strerror(errno));
+				return -1;
+			}
+
+			if (status) { /* They match */
+				printf("xattr and file_contexts SHA1 digests match for: %s\n",
+				       ftsent->fts_path);
+
+				if (calculated_digest) {
+					for (i = 0; i < digest_len; i++)
+						sprintf((&sha1_buf[i * 2]),
+							"%02x",
+							calculated_digest[i]);
+					printf("SHA1 digest: %s\n", sha1_buf);
+				}
+			} else {
+				if (!calculated_digest) {
+					printf("No SHA1 digest available for: %s\n",
+					       ftsent->fts_path);
+					printf("as file_context entry is \"<<none>>\"\n");
+					break;
+				}
+
+				printf("The file_context entries for: %s\n",
+				       ftsent->fts_path);
+
+				for (i = 0; i < digest_len; i++)
+					sprintf((&sha1_buf[i * 2]), "%02x",
+						calculated_digest[i]);
+				printf("generated SHA1 digest: %s\n", sha1_buf);
+
+				if (!xattr_digest) {
+					printf("however there is no selinux.sehash xattr entry.\n");
+				} else {
+					printf("however it does NOT match the current entry of:\n");
+					for (i = 0; i < digest_len; i++)
+						sprintf((&sha1_buf[i * 2]),
+							"%02x",
+							xattr_digest[i]);
+					printf("%s\n", sha1_buf);
+				}
+
+				free(xattr_digest);
+				free(calculated_digest);
+				free(sha1_buf);
+			}
+			break;
+		}
+		default:
+			break;
+		}
+
+		if (!recurse)
+			break;
+	}
+
+	(void) fts_close(fts);
+	selabel_close(hnd);
+	return 0;
+}
diff --git a/libselinux/utils/selabel_hash_all_partial_matches.c b/libselinux/utils/selabel_hash_all_partial_matches.c
new file mode 100644
index 0000000..f4c25c4
--- /dev/null
+++ b/libselinux/utils/selabel_hash_all_partial_matches.c
@@ -0,0 +1,126 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <getopt.h>
+#include <errno.h>
+#include <stdbool.h>
+#include <fts.h>
+#include <selinux/selinux.h>
+#include <selinux/label.h>
+
+#include "../src/sha1.h"
+
+static __attribute__ ((__noreturn__)) void usage(const char *progname)
+{
+	fprintf(stderr,
+		"usage:  %s [-vrh] [-f file] path\n\n"
+		"Where:\n\t"
+		"-v  Validate file_contxts entries against loaded policy.\n\t"
+		"-r  Recursively descend directories.\n\t"
+		"-f  Optional file_contexts file (defaults to current policy).\n\t"
+		"path  Path to generate SHA1 digest against file_contexts entries.\n\n"
+		"This will generate an SHA1 digest for <path> based on the "
+		"file_context\nentries for that node (using the regx, mode "
+		"and path entries). It will\nnot add or update any current "
+		"selinux.sehash entries.\n", progname);
+	exit(1);
+}
+
+int main(int argc, char **argv)
+{
+	int opt, fts_flags;
+	size_t i;
+	bool status = -1, recurse = false;
+	FTS *fts;
+	FTSENT *ftsent;
+	char *validate = NULL, *file = NULL;
+	char *paths[2] = { NULL, NULL };
+	uint8_t calculated_digest[SHA1_HASH_SIZE];
+	char sha1_buf[SHA1_HASH_SIZE * 2 + 1];
+	struct selabel_handle *hnd;
+	struct selinux_opt selabel_option[] = {
+		{ SELABEL_OPT_PATH, file },
+		{ SELABEL_OPT_VALIDATE, validate }
+	};
+
+	if (argc < 2)
+		usage(argv[0]);
+
+	while ((opt = getopt(argc, argv, "f:rvh")) > 0) {
+		switch (opt) {
+		case 'f':
+			file = optarg;
+			break;
+		case 'r':
+			recurse = true;
+			break;
+		case 'v':
+			validate = (char *)1;
+			break;
+		case 'h':
+		default:
+			usage(argv[0]);
+		}
+	}
+
+	if (optind >= argc) {
+		fprintf(stderr, "No pathname specified\n");
+		exit(-1);
+	}
+
+	paths[0] = argv[optind];
+
+	selabel_option[0].value = file;
+	selabel_option[1].value = validate;
+
+	hnd = selabel_open(SELABEL_CTX_FILE, selabel_option, 2);
+	if (!hnd) {
+		fprintf(stderr, "ERROR: selabel_open - Could not obtain "
+							     "handle.\n");
+		return -1;
+	}
+
+	fts_flags = FTS_PHYSICAL | FTS_NOCHDIR;
+	fts = fts_open(paths, fts_flags, NULL);
+	if (!fts) {
+		printf("fts error on %s: %s\n",
+		       paths[0], strerror(errno));
+		return -1;
+	}
+
+	while ((ftsent = fts_read(fts)) != NULL) {
+		switch (ftsent->fts_info) {
+		case FTS_DP:
+			continue;
+		case FTS_D:
+			status = selabel_hash_all_partial_matches(hnd,
+							 ftsent->fts_path,
+							 calculated_digest);
+
+			if (status) {
+				printf("The file_context entries for: %s\n",
+				       ftsent->fts_path);
+
+				for (i = 0; i < SHA1_HASH_SIZE; i++)
+					sprintf((&sha1_buf[i * 2]), "%02x",
+						calculated_digest[i]);
+
+				printf("generated SHA1 digest: %s\n", sha1_buf);
+			} else {
+				printf("No SHA1 digest generated for: %s\n",
+				       ftsent->fts_path);
+				printf("as file_context entry is \"<<none>>\"\n");
+			}
+			break;
+		default:
+			break;
+		}
+
+		if (!recurse)
+			break;
+	}
+
+	(void) fts_close(fts);
+	selabel_close(hnd);
+	return 0;
+}
-- 
2.20.1

