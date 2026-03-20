Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697B73CD8C3
	for <selinux@vger.kernel.org>; Fri, 20 Mar 2026 17:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774027496; cv=none; b=RdFUAUSR16h1OsI5CzSPPyQILXezIgWD+MM0YHZor1LkX/ebVE8gyDsi8FQA81A8WDzJ4ZCyu1NCUDvcvy4MtX3wO/V47T07dAbRNfVFCjumfwsRH6OKd8C/kIjf7ETLZLln2CcC1QQG24YwqUHdZuXkfGvMZKpy/B7xxuYmjxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774027496; c=relaxed/simple;
	bh=fbHdWEXVl4dSx96Ry7N9SwsNx+5EIKA7Am8pynq5Sek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W2V0mNa5NPZcZm9n1sWz2tSvkz3Bu2twzwm4jxs4m+pu5A18QzvzSz6xbpbGVfjJpUfS5pzwaZfKse6hW4DBGWSPkyH9QA7v1aOuVhHdh9zArxKfqwDh6WIlp82cGg5wiH3p09PcGu+7fFo7MdyWDJtoxqE3lHQ6ieHcgOCw6e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=ChiTztwV; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="ChiTztwV"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1774027490;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=BZ4s8utpjzCOpnNBYMwYHj8cUoBpTB1VK9LOWid1YK0=;
	b=ChiTztwVHj8EDpUCGqcyCV4k3EbJfNmdkECeCJqttMJIK0kcZ0hA4fQLBO+R6hWIe1pMSd
	qxxEHSRw6q2I8fKyvV4mp6FSZ9OXYMqcMj/FJXh5KA4utwlLhU74DZAlyxQ+mm4LQx6S3A
	fxLnPA2leJMDsAVFdzMtW7odSl12jxZnmHj/ldxct5xUWbIb9k05hLEnDBkf0rWgfH+8o2
	Oh37FDGHgqswX/YorPfJqZHl5QPnItRkdVrHsrOHs9oE/0Y+FKE/Fc4vHoMuJDUubY30X4
	HSai0Tp/fSRdMARuaJvj7v94bfNEwMk1Vjosuc2fPFQ2rf+rSH/MlaDci7Q0ug==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	=?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>
Subject: [PATCH v2] libselinux: correctly find partial matches
Date: Fri, 20 Mar 2026 18:24:46 +0100
Message-ID: <20260320172446.96634-1-cgoettsche@seltendoof.de>
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
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2:
 - fix documentation of find_all parameter
 - fix linked-list handling: always add at the end
 - pass child to the root call of all_node_specs() not node
 - continue on <<none>> context definitions in partial mode
 - add Signed-off-by
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

