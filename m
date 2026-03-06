Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DAA399015
	for <selinux@vger.kernel.org>; Fri,  6 Mar 2026 13:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772803761; cv=none; b=SAhWtfeciyXtMJBz3SAZWx5kvZNOE64kuEXQMJe4turlkEraWgB3TeE9DpsETxjbKQ8lTrSsJkbSN7lL0O4WNrHWSZxbgyJ7CE+50JBXnt+j9YmEQS07KfaN0N+l/sOSpdzfcjWi5FwdGwY/AgXKfBkD8zDh8V7qDGg1t5rlB5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772803761; c=relaxed/simple;
	bh=Xfeyqo4FHEIIbagpq7QeW1UVPQMmqriSpIC+HerRBGo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fX7QbcIW4Ox69FxUwyGuJ3LI1evJHE1Y9ElqzS9xv2J6mtpi7SSDOlWhbyE9zHDTUd3qQqQeGxC2YoY9jvJ9Wq2WZUGXKHdMaWnw0Z1E96eVy0z/3vHnvze2HAAf6tkK+Nsy/42XFbn4LSSC/UCjJ88+Lv5aSFyJHq7lEW3KkRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=KZzxdD+s; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="KZzxdD+s"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1772803187;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=qrbzkxq7hvMnPFAx79BEiPnpqVlIPtktXkGrkiVwmMs=;
	b=KZzxdD+sZVAqV5OAiRLVCQXGk8uvIKBkN3un8gNP8+OUAkExraAng46Xo8ZxYL10y1s2TM
	JOqENv6acMPEnE2Ph5ogP4fwPtF8NSiULjVqRSLtWo8l0fbvmU++bydPS5vrhOEfmB4NVU
	DfgL4hmc0V8cZuEQBKVoacLgp1elcd3V7ci8gDSoi3RURrTzL01XrWVLf/LqQ19Um1BzLh
	pSqjR/Yzqn6iQoLU+jQrDsjE15rV34cG79dsFUfhzOo8TLRqHmy0jT1aOW9uc7CADgUSfJ
	vudhL0foUsvmhHL1ASBqcVfI6krKFQEYkREdnV8BdDET1Hd8C1SMu6h4HQ/Z8Q==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	=?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>
Subject: [PATCH] libselinux: correctly find partial matches
Date: Fri,  6 Mar 2026 14:19:41 +0100
Message-ID: <20260306131941.106248-1-cgoettsche@seltendoof.de>
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
parent of the root node).  Non-partial lookups don't care about the
child nodes "dev" and "devices" but partial lookup does.

Fixes: 92306daf521 ("libselinux: rework selabel_file(5) database")
Reported-by: Thiébaud Weksteen <tweek@google.com>
---
 libselinux/src/label_file.c | 150 ++++++++++++++++++++++++++++++++++--
 1 file changed, 142 insertions(+), 8 deletions(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index b785eab6..24b2c765 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -1599,6 +1599,103 @@ FUZZ_EXTERN void free_lookup_result(struct lookup_result *result)
 	}
 }
 
+/**
+ * all_node_specs() - Return all definitions in the given node and all transitive children.
+ * @node:      The top level node to return all definitions for.
+ * @file_kind: The kind of the file to look up (translated from file type into LABEL_FILE_KIND_*).
+ * @find_all:  Whether to find all file context definitions or just the most specific.
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
+		struct lookup_result *r;
+
+		r = all_node_specs(child, file_kind, find_all);
+		if (!r)
+			continue;
+
+		if (!find_all)
+			return r;
+
+		*next = r;
+		next = &r->next;
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
@@ -1808,32 +1905,41 @@ static struct spec_node* search_child_node(struct spec_node *array, uint32_t siz
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
@@ -1882,7 +1988,7 @@ FUZZ_EXTERN struct lookup_result *lookup_all(struct selabel_handle *rec,
 	size_t len;
 	uint8_t file_kind = mode_to_file_kind(type);
 	char *clean_key = NULL;
-	const char *prev_slash, *next_slash;
+	const char *prev_slash, *next_slash, *rest_key;
 	unsigned int sofar = 0;
 	char *sub = NULL;
 
@@ -1938,10 +2044,38 @@ FUZZ_EXTERN struct lookup_result *lookup_all(struct selabel_handle *rec,
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
+			const struct spec_node *child = &node->children[i];
+			struct lookup_result *r;
+
+			if (strncmp(child->stem, rest_key, strlen(rest_key)) != 0)
+				continue;
+
+			r = all_node_specs(node, file_kind, find_all);
+			if (!r)
+				continue;
+
+			if (result != NULL)
+				result->next = r;
+			else
+				result = r;
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

