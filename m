Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1533C1F29
	for <selinux@vger.kernel.org>; Tue, 19 May 2026 16:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779207299; cv=none; b=adpbFNkjWHk4a2uEBk2N6kcKO0Zp8DE2Ywj+VDY8ZLaI5VN76DBrbSHxXzHmBjEykjZuHurnBvqjBvbFpwKFzIz2VVhNwZHhVN6yHdOW2AXWHSrgUB0rCInruIAYrO6n7kFOmeIQnfRGcW21p3VzX/wiqoUoIxon1lsf22p//Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779207299; c=relaxed/simple;
	bh=aX9eUINn9StJslyv64CU3L1gTLvOalkW9kU6Sj0Rcnc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dNACS3lxl8znjYWGC1BhK+2hwgQmO5+h0r80jV74BFuMnENFjSueGwCGBGhAM4HlQrUoIY7DRNL07tv7WAs6xzfW29NN+vwSywqm8jhP4IYt3oKs0Ck/ITnVhTlEBW2eMf458k2Yf05K4iCPp0WUROaiFoL9HXZ+FCWEsWdmV/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=FmCy1016; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="FmCy1016"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1779207295;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=huTTkXI1BRn4k8VleJFT0KLnrQ56msRk/UOaAB7egGQ=;
	b=FmCy10169yedCIlVgP4fTL87VCnahUIU8h1INCmD4MqV7DK9ZL9cU4A1QGdxBFEVWUJgdt
	VsQ8pg8jjT/v7db4Ll4JstHQbrwMwd88p9XUdY+psrMRRZ4GR8gtQJPItR7uj5OeRR8LkB
	H+vLZbU13/z8EcJWGIDSGg86tJ9Yt1uWtlKUzXehJ/IlsLqWaOtRto6xIBa/MFnFPANEIK
	SEmsgGeMnpy5sFHWhDerWS3hAsxiVLOLpC7YPdflnJXr5ih1vjF/FU7hhoqK6z0JdLqpGV
	JajPQADV1J3fJR0ll50P7/cWrq0MnqOOvyK5wie6MtOXK2geAOLO43nmb8fKdA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH] libselinux: avoid heap allocation in partial_match() leak path
Date: Tue, 19 May 2026 18:14:40 +0200
Message-ID: <20260519161440.420035-1-cgoettsche@seltendoof.de>
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

partial_match() hands a stack lookup_result to lookup_common() and
discards the return value with a `!!`.  For the non-partial paths
that always works -- lookup_check_node() either fills the caller's
buffer or returns NULL -- but in partial mode, when the key matches
a child stem prefix, lookup_all() falls into its children loop and
calls all_node_specs(), which unconditionally malloc()s the
returned lookup_result.  With partial_match() ignoring the pointer
and find_all=false ensuring at most one entry comes back, that
single malloc'd entry leaks every time.

Fixes: 33930961 ("libselinux: correctly find partial matches")
Assisted-by: Claude:claude-4.7-opus
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/label_file.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 31f134f9..bb866075 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -1604,15 +1604,20 @@ FUZZ_EXTERN void free_lookup_result(struct lookup_result *result)
  * @node:      The top level node to return all definitions for.
  * @file_kind: The kind of the file to look up (translated from file type into LABEL_FILE_KIND_*).
  * @find_all:  Whether return all file context definitions or just any.
+ * @buf:       A pre-allocated buffer for a potential result to avoid allocating it on the heap or
+ *             NULL. Mutual exclusive with @find_all.
  *
  * Return: A linked list of all file context definitions if a match was found.
  *         NULL is returned in case of no match found, or an allocation failure.
  */
-static struct lookup_result *all_node_specs(struct spec_node *node, uint8_t file_kind, bool find_all)
+static struct lookup_result *all_node_specs(struct spec_node *node, uint8_t file_kind, bool find_all,
+					    struct lookup_result *buf)
 {
 	struct lookup_result *result = NULL;
 	struct lookup_result **next = &result;
 
+	assert(!(find_all && buf != NULL));
+
 	for (uint32_t i = 0; i < node->literal_specs_num; i++) {
 		struct literal_spec *lspec = &node->literal_specs[i];
 		struct lookup_result *r;
@@ -1623,9 +1628,13 @@ static struct lookup_result *all_node_specs(struct spec_node *node, uint8_t file
 		if (strcmp(lspec->lr.ctx_raw, "<<none>>") == 0)
 			continue;
 
-		r = malloc(sizeof(*r));
-		if (!r)
-			goto fail;
+		if (likely(!find_all && buf)) {
+			r = buf;
+		} else {
+			r = malloc(sizeof(*r));
+			if (!r)
+				goto fail;
+		}
 
 		*r = (struct lookup_result) {
 			.regex_str = lspec->regex_str,
@@ -1653,9 +1662,13 @@ static struct lookup_result *all_node_specs(struct spec_node *node, uint8_t file
 		if (strcmp(rspec->lr.ctx_raw, "<<none>>") == 0)
 			continue;
 
-		r = malloc(sizeof(*r));
-		if (!r)
-			goto fail;
+		if (likely(!find_all && buf)) {
+			r = buf;
+		} else {
+			r = malloc(sizeof(*r));
+			if (!r)
+				goto fail;
+		}
 
 		*r = (struct lookup_result) {
 			.regex_str = rspec->regex_str,
@@ -1677,7 +1690,7 @@ static struct lookup_result *all_node_specs(struct spec_node *node, uint8_t file
 		struct spec_node *child = &node->children[i];
 		struct lookup_result *r, *last;
 
-		r = all_node_specs(child, file_kind, find_all);
+		r = all_node_specs(child, file_kind, find_all, buf);
 		if (!r)
 			continue;
 
@@ -1709,7 +1722,7 @@ fail:
  * @partial:   Whether to partially match the given file path or completely.
  * @find_all:  Whether to find all file context definitions or just the most specific.
  * @buf:       A pre-allocated buffer for a potential result to avoid allocating it on the heap or
- *             NULL. Mututal exclusive with @find_all.
+ *             NULL. Mutual exclusive with @find_all.
  *
  * Return: A pointer to a file context definition if a match was found. If @find_all was specified
  *         its a linked list of all results. If @buf was specified it is returned on a match found.
@@ -2072,7 +2085,7 @@ FUZZ_EXTERN struct lookup_result *lookup_all(struct selabel_handle *rec,
 			if (strncmp(child->stem, rest_key, strlen(rest_key)) != 0)
 				continue;
 
-			r = all_node_specs(child, file_kind, find_all);
+			r = all_node_specs(child, file_kind, find_all, buf);
 			if (!r)
 				continue;
 
-- 
2.53.0

