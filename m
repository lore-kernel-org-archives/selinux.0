Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E23B1C32
	for <selinux@vger.kernel.org>; Mon, 30 Dec 2024 14:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735567410; cv=none; b=VnksWuFxzyx2YDDUR0i/x5SPsluhzz6BWwDgkBMjlxt/LCmHn+dfeKApCKuzQAgBUGmsZmG1K/QFtuTLojHrFrQ953GrYD31vMaIZNFdt86AIkWV+raO03VnVEzQHxnB4btM1WYKOOsbsJh4KopNgXBVoNG49TkhnmMvz8+nO90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735567410; c=relaxed/simple;
	bh=NpGmlg4qh8VMjoGMygMrH+p1VXQzg7p+VcYhCSVLN5s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HHyxHYG2JsvFaMu7Sle/VzwSKzKZwqclmlO0utkqSTxsKo4V0RIelxF0xcW54eGp8wz+VY6HIZQA3uwkihSwxoQX7Xmmv00FoSbZKjR8tpLjXWyGIRg3c0I8LPNStiNpRQ3I9kfGfPvkUY8i2RdZvzzCHWbSE01awNoivtfAtK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=M69fLe9j; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="M69fLe9j"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1735567406;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=1y7RLvvicEQVmkVOATy0lwg5RfIlmB6PpV+Qj7euyTA=;
	b=M69fLe9j6na4uXmyxg0wZ+r7Mp7U0/TThOrs8HJluGmrblOQ/PF39GBUsF54xjVln7xTpe
	czBhVVi4JZaezpjlAH2yPnXGYlk0zoFmy/GvtOZSiqvxvXDhUcPKMgeLH+EZQHgyfdV9Wa
	+qTV84jOc3wb2MtABuHAdaH1FyyLkTSPboaBoovXl50uaPkJqlgK/SMw+kb0O7G2ZrWNQ4
	JSTC/w9yMwV3j6+a7VWGKVFFS4AuwGSEGlwATRH7a/oNg+AGDf9mEyyb7WEPQw80o4rCSb
	+HzCxuwgorS4kgYeWOvtGxOjWMFyF/MyHXLfKs00GSwu+RjYBuFYTYZlnJWZCQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH] libselinux: avoid quadratic complexity for many regex specs validation
Date: Mon, 30 Dec 2024 15:03:23 +0100
Message-ID: <20241230140323.58852-1-cgoettsche@seltendoof.de>
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

In the degenerate case of many regular expression specifications in a
single node switch to a n*log(n) algorithm (with allocation) instead of
the default n^2 (without allocation) one.

See 2c7b71db ("libselinux: performance optimization for duplicate detection")
for a predecessor.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/label_file.c | 85 +++++++++++++++++++++++++++++++++++--
 1 file changed, 82 insertions(+), 3 deletions(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 56e20949..b1884e80 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -102,6 +102,38 @@ void sort_spec_node(struct spec_node *node, struct spec_node *parent)
 		sort_spec_node(&node->children[i], node);
 }
 
+static inline int compare_regex_spec(const void *p1, const void *p2)
+{
+	const struct regex_spec *r1 = p1;
+	const struct regex_spec *r2 = p2;
+	size_t regex_len1, regex_len2;
+	int ret;
+
+	/* Order from high prefix length to low */
+	ret = (r1->prefix_len < r2->prefix_len) - (r1->prefix_len > r2->prefix_len);
+	if (ret)
+		return ret;
+
+	/* Order from long total regex length to short */
+	regex_len1 = strlen(r1->regex_str);
+	regex_len2 = strlen(r2->regex_str);
+	ret = (regex_len1 < regex_len2) - (regex_len1 > regex_len2);
+	if (ret)
+		return ret;
+
+	/*
+	 * Order for no-duplicates check.
+	 * Use reverse alphabetically order to retain the Fedora ordering of
+	 * `/usr/(.* /)?lib(/.*)?` before `/usr/(.* /)?bin(/.*)?`.
+	 */
+	ret = strcmp(r1->regex_str, r2->regex_str);
+	if (ret)
+		return -ret;
+
+	/* Order wildcard mode (0) last */
+	return (r1->file_kind < r2->file_kind) - (r1->file_kind > r2->file_kind);
+}
+
 /*
  * Warn about duplicate specifications.
  */
@@ -143,10 +175,18 @@ static int nodups_spec_node(const struct spec_node *node, const char *path)
 	}
 
 	if (node->regex_specs_num > 1) {
-		for (uint32_t i = 0; i < node->regex_specs_num - 1; i++) {
-			for (uint32_t j = i; j < node->regex_specs_num - 1; j++) {
+		if (node->regex_specs_num > 512) {
+			uint32_t num = node->regex_specs_num;
+			struct regex_spec *copy = malloc(num * sizeof(struct regex_spec));
+			if (!copy)
+				goto default_algo;
+
+			memcpy(copy, node->regex_specs, num * sizeof(struct regex_spec));
+			qsort(copy, num, sizeof(struct regex_spec), compare_regex_spec);
+
+			for (uint32_t i = 0; i < node->regex_specs_num - 1; i++) {
 				const struct regex_spec *node1 = &node->regex_specs[i];
-				const struct regex_spec *node2 = &node->regex_specs[j + 1];
+				const struct regex_spec *node2 = &node->regex_specs[i + 1];
 
 				if (node1->prefix_len != node2->prefix_len)
 					continue;
@@ -177,6 +217,45 @@ static int nodups_spec_node(const struct spec_node *node, const char *path)
 							node1->regex_str);
 				}
 			}
+
+			free(copy);
+		} else {
+			default_algo:
+			for (uint32_t i = 0; i < node->regex_specs_num - 1; i++) {
+				for (uint32_t j = i; j < node->regex_specs_num - 1; j++) {
+					const struct regex_spec *node1 = &node->regex_specs[i];
+					const struct regex_spec *node2 = &node->regex_specs[j + 1];
+
+					if (node1->prefix_len != node2->prefix_len)
+						continue;
+
+					if (strcmp(node1->regex_str, node2->regex_str) != 0)
+						continue;
+
+					if (node1->file_kind != LABEL_FILE_KIND_ALL && node2->file_kind != LABEL_FILE_KIND_ALL && node1->file_kind != node2->file_kind)
+						continue;
+
+					rc = -1;
+					errno = EINVAL;
+					if (strcmp(node1->lr.ctx_raw, node2->lr.ctx_raw) != 0) {
+						COMPAT_LOG
+							(SELINUX_ERROR,
+								"%s: Multiple different specifications for %s %s  (%s and %s).\n",
+								path,
+								file_kind_to_string(node1->file_kind),
+								node1->regex_str,
+								node1->lr.ctx_raw,
+								node2->lr.ctx_raw);
+					} else {
+						COMPAT_LOG
+							(SELINUX_ERROR,
+								"%s: Multiple same specifications for %s %s.\n",
+								path,
+								file_kind_to_string(node1->file_kind),
+								node1->regex_str);
+					}
+				}
+			}
 		}
 	}
 
-- 
2.45.2

