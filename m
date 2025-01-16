Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2898F19539F
	for <selinux@vger.kernel.org>; Thu, 16 Jan 2025 10:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737024884; cv=none; b=nhQ2CcuvlesxfME1eLW+w8tyKlwrFJGEzOohDc5PTogCON2r+CRNHHY966qIaWYSHFe7GaudQ0Z8JaicAtUq+O41fv1lPWYzlcx+GQCfzHpA7ZDBPzktWtIpLn77aQSxbROAi4+4ACBbZ2yftgauFxZan67pqOC0O324QzZ+ay0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737024884; c=relaxed/simple;
	bh=Un9QANz5cVU8gVy4d1HQH2tjG/8HFInk0Hlt93dNBTw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ipq6oMrqTWQPMNlGMBtIsPgDfl/FLhmktgx651C+KAKo+ve8wQW0G2Rqi1IHlPPufyHKDhtL64+yQ1yzmGF3i/aGE2xvYGEiXyBi2AW6vUxmd/BDlmJ28Q+50BewHnCPoQPb3zl9tBgmPAK1QZAVrT7yYPX2DnoeyUC8eAT2CFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=Qwubk2LH; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="Qwubk2LH"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1737024872;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=jfr5MT4CcImXe2AnUci0SLEjE7WE5v5kOTe1e0xl7Ug=;
	b=Qwubk2LHL9CXleBatV7XeWkhhHkkqlZBpHW0C662Phj7ThpDnhFUTL1dDHHV2nGCZH2F3x
	QBZ36FAQp0RBhX13Tegf99knCWPivC23Iv0v4PNRwuDPDU9BcoVr3nEhPBPsv1SSxhQikP
	h4VPhbqqDeaseF9R02xZL8w1QD2RmnYqjuFq0AfDjBeZfi5tt1vizMa7wUGQEsrJdCwgbR
	0GrmZP+hfMNzqLNpDgt+o96PLQBJr5xYidKJjzm6COt/NvUh66YoB3RTj1mJIoFhkiehPI
	86ed2JvrfwT78IvdarsAeTCyuB4AMow7Ef9Yw0AypDi/glj8fRulqvI4UyWK2A==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v2] libselinux: limit node depth while parsing compiled fcontexts
Date: Thu, 16 Jan 2025 11:54:27 +0100
Message-ID: <20250116105427.22307-1-cgoettsche@seltendoof.de>
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

Limit the node depth while parsing a pre-compiled fcontext definition to
avoid unlimited recursions causing stack overflows.

Use a sufficiently high value of 32, instead of the node depth of
currently 3 for generating a database, to not unnecessarily limit
custom changes.

Fixes: 92306daf ("libselinux: rework selabel_file(5) database")
Reported-by: oss-fuzz (issues 388615595 and 388592303)
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2: add code comment
---
 libselinux/src/label_file.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 56e20949..507ce0d3 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -674,12 +674,22 @@ static int load_mmap_regex_spec(struct mmap_area *mmap_area, bool validating, bo
 }
 
 static int load_mmap_spec_node(struct mmap_area *mmap_area, const char *path, bool validating, bool do_load_precompregex,
-			       struct spec_node *node, bool is_root, uint8_t inputno, const struct context_array *ctx_array)
+			       struct spec_node *node, const unsigned depth, uint8_t inputno, const struct context_array *ctx_array)
 {
 	uint32_t data_u32, lspec_num, rspec_num, children_num;
 	uint16_t data_u16, stem_len;
+	const bool is_root = (depth == 0);
 	int rc;
 
+	/*
+	 * Guard against deep recursion by malicious pre-compiled fcontext
+	 * definitions. The limit of 32 is chosen intuitively and should
+	 * suffice for any real world scenario. See the macro
+	 * SPEC_NODE_MAX_DEPTH for the current value used for tree building.
+	 */
+	if (depth >= 32)
+		return -1;
+
 	node->from_mmap = true;
 
 
@@ -794,7 +804,7 @@ static int load_mmap_spec_node(struct mmap_area *mmap_area, const char *path, bo
 		node->children_alloc = children_num;
 
 		for (uint32_t i = 0; i < children_num; i++) {
-			rc = load_mmap_spec_node(mmap_area, path, validating, do_load_precompregex, &node->children[i], false, inputno, ctx_array);
+			rc = load_mmap_spec_node(mmap_area, path, validating, do_load_precompregex, &node->children[i], depth + 1, inputno, ctx_array);
 			if (rc)
 				return -1;
 
@@ -969,7 +979,7 @@ end_arch_check:
 
 	rc = load_mmap_spec_node(mmap_area, path, rec->validating,
 				 reg_version_matches && reg_arch_matches,
-				 root, true,
+				 root, 0,
 				 inputno,
 				 &ctx_array);
 	if (rc)
-- 
2.47.1

