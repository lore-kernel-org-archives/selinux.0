Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDAE3D349F
	for <selinux@vger.kernel.org>; Fri, 20 Mar 2026 17:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774027557; cv=none; b=cP4EHAVvCuLDAaljA2cq7Pu241cWkGEqZjK285jz9wDHuXNjy2F0+4dIWn2lYgBhKYOVN7JaIrsrOu8BIIgdg5n+VnRjbT2QxRd6LbTTuvDVHOyGjlv/qKQKdQLXtlfVgprWlNoVf4pRh5fLmP3YbEChZKv36e5fiGi8nIE5pnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774027557; c=relaxed/simple;
	bh=ZgGFTV+9iIXytfnilD5u8n7l7+vRSzf7oBhVer5PBs4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k8dfgIMQxagP+nQkYeeZJ7anBWbYVMt/yID1xsMXPProQYRpxHPjVeIRe5QgCR7NNuXdthYyHxMXPNl7f0GlQUYQnZDyA7dFKjgZVod27ROlDiOVA4makYim/phhx6pUZtKgCRUCTKNW3DdpVOwN/h2VNtS7UsMXz9olhU4qXyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=JbHR80cQ; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="JbHR80cQ"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1774027189;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=F3z1qjzfVgEVsIUBYDEli5Fx8q3YjAcFhmbHramuRq8=;
	b=JbHR80cQm1Wu7CA7UbxDbpzkvEdPMNoADm+nTSzSt1PjVYRmv41+Pmy1ch0mA9AzPxYr/9
	MbnnOzBfWDZ55aeIO3PHNiDPyfRmcr3Cg/Hv1dsEiAFgpqvR4Gow/SIpmbEteksMmJFDjX
	ZnpJoyJpBfs0R7b2K9oDxCXiOycsvSng9IyZ7zRlNH4+lumCoDqAc5a0oR2i5vzfEhdUfk
	qDs/V4xyBDYrQWkpMu3CIWzLJqaI53l0sDPjxxB99OqCawIpkPubES2rXYiQzStQQAeZ07
	shEebw0XKhFwLXb/2Bro+WrF2KKJaSIQ83/qwlm9S3Gc3HFpjEVZREeN9s3ZNg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	=?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>
Subject: [PATCH v2] libselinux: correctly find partial matches
Date: Fri, 20 Mar 2026 18:19:43 +0100
Message-ID: <20260320171943.93088-1-cgoettsche@seltendoof.de>
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

The current lookup for file labels first searches for the deepest node
matching the lookup-key.  Then all definitions of that node and its
parents are considered.
For partial lookups also consider child nodes matching the lookup-key
portion that did not match any node-stem.

Example:
The lookup-key "/sys/de" will result in the deepest node being "sys" (a
child of the root node).  Non-partial lookups don't care about the "sys"
child nodes "dev" and "devices" but partial lookup does.

Fixes: 92306daf521 ("libselinux: rework selabel_file(5) database")
Reported-by: Thiébaud Weksteen <tweek@google.com>
---
v2:
 - fix documentation of find_all parameter
 - fix linked-list handling: always add at the end
 - pass child to the root call of all_node_specs() not node
 - continue on <<none>> context definitions in partial mode
---
 libselinux/src/label_file.c | 162 ++++++++++++++++++++++++++++++++++--
 1 file changed, 154 insertions(+), 8 deletions(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index b785eab6..31f134f9 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -1599,6 +1599,107 @@ FUZZ_EXTERN void free_lookup_result(struct lookup_result *result)
 	}
 }
 
+/**
+ * all_node_specs() - Return all definitions in the given node and all transitive children.
+ * @node:      The top level node to return all definitions for.
+ * @file_kind: The kind of the file to look up (translated from file type into LABEL_FILE_KIND_*).
+ * @find_all:  Whether return all file context definitions or just any.
+ *
+ * Return: A linked list of all file context definitions if a match was found.
+ *         NULL is returned in case of no match found, or an allocation failure.
+ */
+static struct lookup_result *all_node_specs(struct spec_node *node, uint8_t file_kind, bool find_all)
+{
+	struct lookup_result *result = NULL;
+	struct lookup_result **next = &result;
+
+	for (uint32_t i = 0; i < node->literal_specs_num; i++) {
+		struct literal_spec *lspec = &node->literal_specs[i];
+		struct lookup_result *r;
+
+		if (file_kind != LABEL_FILE_KIND_ALL && lspec->file_kind != LABEL_FILE_KIND_ALL && lspec->file_kind != file_kind)
+			continue;
+
+		if (strcmp(lspec->lr.ctx_raw, "<<none>>") == 0)
+			continue;
+
+		r = malloc(sizeof(*r));
+		if (!r)
+			goto fail;
+
+		*r = (struct lookup_result) {
+			.regex_str = lspec->regex_str,
+			.prefix_len = lspec->prefix_len,
+			.file_kind = lspec->file_kind,
+			.lr = &lspec->lr,
+			.has_meta_chars = false,
+			.next = NULL,
+		};
+
+		if (!find_all)
+			return r;
+
+		*next = r;
+		next = &r->next;
+	}
+
+	for (uint32_t i = 0; i < node->regex_specs_num; i++) {
+		struct regex_spec *rspec = &node->regex_specs[i];
+		struct lookup_result *r;
+
+		if (file_kind != LABEL_FILE_KIND_ALL && rspec->file_kind != LABEL_FILE_KIND_ALL && file_kind != rspec->file_kind)
+			continue;
+
+		if (strcmp(rspec->lr.ctx_raw, "<<none>>") == 0)
+			continue;
+
+		r = malloc(sizeof(*r));
+		if (!r)
+			goto fail;
+
+		*r = (struct lookup_result) {
+			.regex_str = rspec->regex_str,
+			.prefix_len = rspec->prefix_len,
+			.file_kind = rspec->file_kind,
+			.lr = &rspec->lr,
+			.has_meta_chars = true,
+			.next = NULL,
+		};
+
+		if (!find_all)
+			return r;
+
+		*next = r;
+		next = &r->next;
+	}
+
+	for (uint32_t i = 0; i < node->children_num; i++) {
+		struct spec_node *child = &node->children[i];
+		struct lookup_result *r, *last;
+
+		r = all_node_specs(child, file_kind, find_all);
+		if (!r)
+			continue;
+
+		if (!find_all)
+			return r;
+
+		last = r;
+		while (last->next)
+			last = last->next;
+
+		*next = r;
+		next = &last->next;
+	}
+
+	return result;
+
+fail:
+	free_lookup_result(result);
+
+	return NULL;
+}
+
 /**
  * lookup_check_node() - Try to find a file context definition in the given node or parents.
  * @node:      The deepest specification node to match against. Parent nodes are successively
@@ -1644,6 +1745,9 @@ static struct lookup_result *lookup_check_node(struct spec_node *node, const cha
 #endif
 
 						if (strcmp(lspec->lr.ctx_raw, "<<none>>") == 0) {
+							if (partial)
+								continue;
+
 							errno = ENOENT;
 							goto fail;
 						}
@@ -1712,6 +1816,9 @@ static struct lookup_result *lookup_check_node(struct spec_node *node, const cha
 				}
 
 				if (strcmp(rspec->lr.ctx_raw, "<<none>>") == 0) {
+					if (partial)
+						continue;
+
 					errno = ENOENT;
 					goto fail;
 				}
@@ -1808,32 +1915,41 @@ static struct spec_node* search_child_node(struct spec_node *array, uint32_t siz
 	return NULL;
 }
 
-static struct spec_node* lookup_find_deepest_node(struct spec_node *node, const char *key)
+static struct spec_node* lookup_find_deepest_node(struct spec_node *node, const char *key, const char **rest_key)
 {
 	/* Find the node matching the deepest stem */
 
 	struct spec_node *n = node;
 	const char *p = key;
 
+	*rest_key = NULL;
+
 	while (true) {
 		struct spec_node *child;
 		size_t length;
 		const char *q;
 
-		if (*p != '/')
+		if (unlikely(*p != '/'))
 			break;
 
 		q = strchr(p + 1, '/');
-		if (q == NULL)
+		if (q == NULL) {
+			*rest_key = (p + 1);
 			break;
+		}
 
 		length = q - p - 1;
-		if (length == 0)
-			break;
+		if (unlikely(length == 0)) {
+			/* double slash */
+			p = q;
+			continue;
+		}
 
 		child = search_child_node(n->children, n->children_num, p + 1, length);
-		if (!child)
+		if (!child) {
+			*rest_key = (p + 1);
 			break;
+		}
 
 		n = child;
 		p = q;
@@ -1882,7 +1998,7 @@ FUZZ_EXTERN struct lookup_result *lookup_all(struct selabel_handle *rec,
 	size_t len;
 	uint8_t file_kind = mode_to_file_kind(type);
 	char *clean_key = NULL;
-	const char *prev_slash, *next_slash;
+	const char *prev_slash, *next_slash, *rest_key;
 	unsigned int sofar = 0;
 	char *sub = NULL;
 
@@ -1938,10 +2054,40 @@ FUZZ_EXTERN struct lookup_result *lookup_all(struct selabel_handle *rec,
 	if (sub)
 		key = sub;
 
-	node = lookup_find_deepest_node(data->root, key);
+	node = lookup_find_deepest_node(data->root, key, &rest_key);
 
 	result = lookup_check_node(node, key, file_kind, partial, find_all, buf);
 
+	/* For partial lookup if the key matches a child node, recursively add all specs */
+	if (partial && rest_key) {
+		if (!find_all && result != NULL) {
+			/* found already a result, and only one result is wanted */
+			goto finish;
+		}
+
+		for (uint32_t i = 0; i < node->children_num; i++) {
+			struct spec_node *child = &node->children[i];
+			struct lookup_result *r, *last;
+
+			if (strncmp(child->stem, rest_key, strlen(rest_key)) != 0)
+				continue;
+
+			r = all_node_specs(child, file_kind, find_all);
+			if (!r)
+				continue;
+
+			last = r;
+			while (last->next)
+				last = last->next;
+
+			last->next = result;
+			result = r;
+
+			if (!find_all)
+				break;
+		}
+	}
+
 finish:
 	free(clean_key);
 	free(sub);
-- 
2.53.0

