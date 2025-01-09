Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF6C20551B
	for <selinux@vger.kernel.org>; Thu,  9 Jan 2025 12:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736424943; cv=none; b=L8q9sWOChc6xrln4homlurhx368BiyxWg0ML3AoI4/RYSvtzA3wOMUFPS/2QyHQ29AMdp6H/6rp7R8QiS4toDlXWxshHKL+RJFfpuwyl4j0SZOxmzevbUsvUE9p0wkTi51+72oihruUlqi8pEZU1GSi+gFrrFl+uRCM5nRCWsrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736424943; c=relaxed/simple;
	bh=r0ytzMEHCnbGYWc3ohVOExh6UcGNWkhuQQBwJfoiXQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qv+vVLkYkn1nHZBvTEn2qWu5ui/TRR0miNsqPtHpdJqurOjLH5XHDQWcbfcUZ8dTwq0pDaFG6NdiXnQjVj1OxDvcgDENdBEx8R7zJrZWDz1AepfIXykQ28K8MX/4szLvWieDmqV7vnJpG6RJGqRGyfNo+g7uLKgiQW2wlbicDD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=A8ZSJwN0; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="A8ZSJwN0"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1736424936;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=xzXdfnaaNbmymrNNKg6Kq1CLRQh8fsIZ5daw0E/zZLI=;
	b=A8ZSJwN0a7M546zvavxiFnmi5oSJysow6g2C/PAeo/dzNpvelIXhZJgx/o2v/sgMHHZnOv
	LLqCwaFqbu/eSeeb+IlxssQibsMN9ZTLrQCcOq1/18RZVw+54vc/jA8wei1cbTsx/364nD
	FWeuOw3xPCyEKvf0JW8B5KbiFzig3Lftyvs47v8yXU3gzr93Vdk3QqzDBAd0oECh6yaAXk
	V4sTayoSVnd++KPVLmETUrUMDU2CtLWQkPDfHHIuZMXDmfgM8lBqfx6VY6nQvl7mWxqfu8
	mQBMCQ5OybMtQcMwWgO2LxPD+/na4E+4KiuJbN+3ekuhqOaYmRhh+FBWzqQ91g==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH] libselinux: limit node depth while parsing compiled fcontexts
Date: Thu,  9 Jan 2025 13:15:30 +0100
Message-ID: <20250109121530.21728-1-cgoettsche@seltendoof.de>
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
 libselinux/src/label_file.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 56e20949..125eb601 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -674,12 +674,16 @@ static int load_mmap_regex_spec(struct mmap_area *mmap_area, bool validating, bo
 }
 
 static int load_mmap_spec_node(struct mmap_area *mmap_area, const char *path, bool validating, bool do_load_precompregex,
-			       struct spec_node *node, bool is_root, uint8_t inputno, const struct context_array *ctx_array)
+			       struct spec_node *node, const unsigned depth, uint8_t inputno, const struct context_array *ctx_array)
 {
 	uint32_t data_u32, lspec_num, rspec_num, children_num;
 	uint16_t data_u16, stem_len;
+	const bool is_root = (depth == 0);
 	int rc;
 
+	if (depth >= 32)
+		return -1;
+
 	node->from_mmap = true;
 
 
@@ -794,7 +798,7 @@ static int load_mmap_spec_node(struct mmap_area *mmap_area, const char *path, bo
 		node->children_alloc = children_num;
 
 		for (uint32_t i = 0; i < children_num; i++) {
-			rc = load_mmap_spec_node(mmap_area, path, validating, do_load_precompregex, &node->children[i], false, inputno, ctx_array);
+			rc = load_mmap_spec_node(mmap_area, path, validating, do_load_precompregex, &node->children[i], depth + 1, inputno, ctx_array);
 			if (rc)
 				return -1;
 
@@ -969,7 +973,7 @@ end_arch_check:
 
 	rc = load_mmap_spec_node(mmap_area, path, rec->validating,
 				 reg_version_matches && reg_arch_matches,
-				 root, true,
+				 root, 0,
 				 inputno,
 				 &ctx_array);
 	if (rc)
-- 
2.47.1

