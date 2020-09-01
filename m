Return-Path: <SRS0=Zo7G=CK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410E5C433E6
	for <selinux@archiver.kernel.org>; Tue,  1 Sep 2020 11:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1043D206EF
	for <selinux@archiver.kernel.org>; Tue,  1 Sep 2020 11:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="PhSb0x0i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgIAL6w (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 1 Sep 2020 07:58:52 -0400
Received: from m12-16.163.com ([220.181.12.16]:55271 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727962AbgIAL6k (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 1 Sep 2020 07:58:40 -0400
X-Greylist: delayed 909 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Sep 2020 07:58:36 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=uz+vWgkneJvayCRdUt
        rEIlcvqkS38TA6Owmq/NMJuGg=; b=PhSb0x0igcICmqwNVThWj2JrwXWDA26vHG
        tR+A2/YKEHOskDT8AJ3Is/lzutRvSyslNKskoZJuvIYzEWuNl7O7u7jzrgN0XN/x
        C67srNHd4idSw1FCzjDhIi0jvCsdHd4PzDP5SB7RiJ1rDYRQY+Er5htjJuDsf9vE
        3jnNZmII8=
Received: from mi-OptiPlex-9020.mioffice.cn (unknown [106.37.187.137])
        by smtp12 (Coremail) with SMTP id EMCowAAH5PC2M05fckyETg--.41113S2;
        Tue, 01 Sep 2020 19:42:53 +0800 (CST)
From:   liwugang <liwugang@163.com>
To:     selinux@vger.kernel.org
Cc:     liwugang <liwugang@163.com>
Subject: [PATCH] Optimize the calculation of security.sehash
Date:   Tue,  1 Sep 2020 19:42:45 +0800
Message-Id: <20200901114245.3657-1-liwugang@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: EMCowAAH5PC2M05fckyETg--.41113S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3GF48Zr4rCr4kAFyxXrW8WFg_yoWfCF43p3
        yDGwnrJry8GF1xCwn7Ca4DAFyavr409F17G3y7G34F9rWkZr1Fqa92kFWYvF1DXr45XFya
        9F4YqFWkCa1UJa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pisNVkUUUUU=
X-Originating-IP: [106.37.187.137]
X-CM-SenderInfo: 5olz3wxdqjqiywtou0bp/1tbiLB2Ss1spYkCl-AAAsZ
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The hash of each directory should be determined by the file contexts of
the current directory and subdirectories, but the existing logic also
includes the ancestor directories. The first optimization is to exclude
them. So it should be break When the first complete match found in function
lookup_all.

If the current directory has corresponding file contexts and subdirectories
have not, subdirectories will use the current direcorty's. There is no need
to calculate the hash for the subdirectories. It will save time, espacially
for user data(/data/media/0/). The second optimization is not to check the
hash of the subdirectories.

Example:
/data/(.*)?           u:object_r:system_data_file:s0
/data/backup(/.*)?    u:object_r:backup_data_file:s0

If the file context of "/data/(.*)?" changes and "/data/backup(/.*)?" does not
change, directory(/data/backup) and the subdirectories will restorecon because of
hash changed. But actually there is no need the restorecon.

Signed-off-by: liwugang <liwugang@163.com>
---
 libselinux/include/selinux/label.h            |  5 +--
 libselinux/src/label.c                        | 11 +++---
 libselinux/src/label_file.c                   | 17 +++++++---
 libselinux/src/label_internal.h               |  6 ++--
 libselinux/src/selinux_restorecon.c           | 34 ++++++++++++++-----
 .../selabel_get_digests_all_partial_matches.c |  3 +-
 6 files changed, 55 insertions(+), 21 deletions(-)

diff --git a/libselinux/include/selinux/label.h b/libselinux/include/selinux/label.h
index e8983606..d91ceb6f 100644
--- a/libselinux/include/selinux/label.h
+++ b/libselinux/include/selinux/label.h
@@ -110,9 +110,10 @@ extern bool selabel_get_digests_all_partial_matches(struct selabel_handle *rec,
 						    const char *key,
 						    uint8_t **calculated_digest,
 						    uint8_t **xattr_digest,
-						    size_t *digest_len);
+						    size_t *digest_len,
+						    size_t *num_matches);
 extern bool selabel_hash_all_partial_matches(struct selabel_handle *rec,
-					     const char *key, uint8_t* digest);
+					     const char *key, uint8_t* digest, size_t *num_matches);
 
 extern int selabel_lookup_best_match(struct selabel_handle *rec, char **con,
 				     const char *key, const char **aliases, int type);
diff --git a/libselinux/src/label.c b/libselinux/src/label.c
index a03192e5..cfa0464e 100644
--- a/libselinux/src/label.c
+++ b/libselinux/src/label.c
@@ -278,7 +278,8 @@ bool selabel_get_digests_all_partial_matches(struct selabel_handle *rec,
 					     const char *key,
 					     uint8_t **calculated_digest,
 					     uint8_t **xattr_digest,
-					     size_t *digest_len)
+					     size_t *digest_len,
+					     size_t *num_matches)
 {
 	if (!rec->func_get_digests_all_partial_matches)
 		return false;
@@ -286,16 +287,18 @@ bool selabel_get_digests_all_partial_matches(struct selabel_handle *rec,
 	return rec->func_get_digests_all_partial_matches(rec, key,
 							 calculated_digest,
 							 xattr_digest,
-							 digest_len);
+							 digest_len,
+							 num_matches);
 }
 
 bool selabel_hash_all_partial_matches(struct selabel_handle *rec,
-                                      const char *key, uint8_t *digest) {
+                                      const char *key, uint8_t *digest,
+                                      size_t *num_matches) {
 	if (!rec->func_hash_all_partial_matches) {
 		return false;
 	}
 
-	return rec->func_hash_all_partial_matches(rec, key, digest);
+	return rec->func_hash_all_partial_matches(rec, key, digest, num_matches);
 }
 
 int selabel_lookup_best_match(struct selabel_handle *rec, char **con,
diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 6eeeea68..c99eb251 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -955,7 +955,10 @@ static const struct spec **lookup_all(struct selabel_handle *rec,
 				if (match_count) {
 					result[*match_count] = spec;
 					*match_count += 1;
-					// Continue to find all the matches.
+					if (rc == REGEX_MATCH) {
+						break;
+					}
+					// Continue to find the matches until the first full match found.
 					continue;
 				}
 				result[0] = spec;
@@ -1005,7 +1008,8 @@ static bool get_digests_all_partial_matches(struct selabel_handle *rec,
 					    const char *pathname,
 					    uint8_t **calculated_digest,
 					    uint8_t **xattr_digest,
-					    size_t *digest_len)
+					    size_t *digest_len,
+					    size_t *num_matches)
 {
 	uint8_t read_digest[SHA1_HASH_SIZE];
 	ssize_t read_size = getxattr(pathname, RESTORECON_PARTIAL_MATCH_DIGEST,
@@ -1016,7 +1020,7 @@ static bool get_digests_all_partial_matches(struct selabel_handle *rec,
 				    );
 	uint8_t hash_digest[SHA1_HASH_SIZE];
 	bool status = selabel_hash_all_partial_matches(rec, pathname,
-						       hash_digest);
+						       hash_digest, num_matches);
 
 	*xattr_digest = NULL;
 	*calculated_digest = NULL;
@@ -1049,7 +1053,8 @@ oom:
 	return false;
 }
 
-static bool hash_all_partial_matches(struct selabel_handle *rec, const char *key, uint8_t *digest)
+static bool hash_all_partial_matches(struct selabel_handle *rec, const char *key,
+						uint8_t *digest, size_t *num_matches)
 {
 	assert(digest);
 
@@ -1076,6 +1081,10 @@ static bool hash_all_partial_matches(struct selabel_handle *rec, const char *key
 	Sha1Finalise(&context, &sha1_hash);
 	memcpy(digest, sha1_hash.bytes, SHA1_HASH_SIZE);
 
+	if (num_matches) {
+		*num_matches = total_matches;
+	}
+
 	free(matches);
 	return true;
 }
diff --git a/libselinux/src/label_internal.h b/libselinux/src/label_internal.h
index 361b443c..0ffe1318 100644
--- a/libselinux/src/label_internal.h
+++ b/libselinux/src/label_internal.h
@@ -90,9 +90,11 @@ struct selabel_handle {
 						      const char *key,
 						      uint8_t **calculated_digest,
 						      uint8_t **xattr_digest,
-						      size_t *digest_len);
+						      size_t *digest_len,
+						      size_t *num_matches);
 	bool (*func_hash_all_partial_matches) (struct selabel_handle *h,
-	                                       const char *key, uint8_t *digest);
+	                                       const char *key, uint8_t *digest,
+	                                       size_t *num_matches);
 	struct selabel_lookup_rec *(*func_lookup_best_match)
 						    (struct selabel_handle *h,
 						    const char *key,
diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index 6993be6f..417b619c 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -308,7 +308,7 @@ static int add_xattr_entry(const char *directory, bool delete_nonmatch,
 
 	selabel_get_digests_all_partial_matches(fc_sehandle, directory,
 						&calculated_digest,
-						&xattr_digest, &digest_len);
+						&xattr_digest, &digest_len, NULL);
 
 	if (!xattr_digest || !digest_len) {
 		free(calculated_digest);
@@ -753,7 +753,8 @@ struct dir_hash_node {
  */
 static bool check_context_match_for_dir(const char *pathname,
 					struct dir_hash_node **new_node,
-					int error)
+					int error,
+					size_t *num_matches)
 {
 	bool status;
 	size_t digest_len = 0;
@@ -769,7 +770,8 @@ static bool check_context_match_for_dir(const char *pathname,
 	status = selabel_get_digests_all_partial_matches(fc_sehandle, pathname,
 							 &calculated_digest,
 							 &read_digest,
-							 &digest_len);
+							 &digest_len,
+							 num_matches);
 
 	if (status)
 		goto free;
@@ -854,6 +856,7 @@ int selinux_restorecon(const char *pathname_orig,
 	FTSENT *ftsent;
 	char *pathname = NULL, *pathdnamer = NULL, *pathdname, *pathbname;
 	char *paths[2] = { NULL, NULL };
+	char *leafcontextpath = NULL;
 	int fts_flags, error, sverrno;
 	dev_t dev_num = 0;
 	struct dir_hash_node *current = NULL;
@@ -1042,11 +1045,16 @@ int selinux_restorecon(const char *pathname_orig,
 
 			if (setrestorecondigest) {
 				struct dir_hash_node *new_node = NULL;
-
-				if (check_context_match_for_dir(ftsent->fts_path,
-								&new_node,
-								error) &&
-								!ignore_digest) {
+				size_t num_matches = 0;
+				bool skip_check = leafcontextpath &&
+					strlen(ftsent->fts_path) > strlen(leafcontextpath) &&
+					!strncmp(ftsent->fts_path, leafcontextpath, strlen(leafcontextpath));
+
+				if (!skip_check && !ignore_digest
+					&& check_context_match_for_dir(ftsent->fts_path,
+							    &new_node,
+							    error,
+							    &num_matches)) {
 					selinux_log(SELINUX_INFO,
 						    "Skipping restorecon on directory(%s)\n",
 						    ftsent->fts_path);
@@ -1063,6 +1071,15 @@ int selinux_restorecon(const char *pathname_orig,
 						current = current->next;
 					}
 				}
+
+				if (1 == num_matches) {
+					free(leafcontextpath);
+					leafcontextpath = (char *) calloc(1, strlen(ftsent->fts_path) + 1 + 1);
+					if (!leafcontextpath)
+						goto oom;
+					strcpy(leafcontextpath, ftsent->fts_path);
+					strcat(leafcontextpath, "/");
+				}
 			}
 			/* fall through */
 		default:
@@ -1111,6 +1128,7 @@ cleanup:
 	}
 	free(pathdnamer);
 	free(pathname);
+	free(leafcontextpath);
 
 	current = head;
 	while (current != NULL) {
diff --git a/libselinux/utils/selabel_get_digests_all_partial_matches.c b/libselinux/utils/selabel_get_digests_all_partial_matches.c
index 0c2edc67..aa60ee9e 100644
--- a/libselinux/utils/selabel_get_digests_all_partial_matches.c
+++ b/libselinux/utils/selabel_get_digests_all_partial_matches.c
@@ -103,7 +103,8 @@ int main(int argc, char **argv)
 							 ftsent->fts_path,
 							 &calculated_digest,
 							 &xattr_digest,
-							 &digest_len);
+							 &digest_len,
+							 NULL);
 
 			sha1_buf = calloc(1, digest_len * 2 + 1);
 			if (!sha1_buf) {
-- 
2.17.1


