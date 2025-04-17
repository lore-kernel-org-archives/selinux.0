Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4B7A926
	for <selinux@vger.kernel.org>; Thu, 17 Apr 2025 19:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744917492; cv=none; b=UnuYMTSouwBjGn/DYkIB3N4z4ITnRV2Y+wLkuKYg9HJ8IW/AQ20omMm9+UeyZ9as/PPM/NzsGRc7QgvkiNX7AP0WkbpAOKs3Gpls5SAIMeXgI55T+0ue1KGNLeTd6j93zwsmxIyEzr3QAcDw87NdTQ425fyKLae5JCYZabDT760=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744917492; c=relaxed/simple;
	bh=yhCc1OGwRM/niDMffMHW0jxxuXwdPC0LKYNt4/DY2kg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bkLjZM0lQ5n7naHOo9S+NNgrcd/JWmtmi+Q8LswECkVRKeLfQAUlBeD2aFGpm/zpHAWUgBDnQYgR3ePHti8awBwiSjYV3NoIrKGmNnkr0Q5ZUc16Qa/GY8kZAzFS9hBqRu2X8XZ+SIGGlwt8GDeh7szOUwGrg5IiqVXHnr1OlTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=V6qG1ofz; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="V6qG1ofz"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1744916896;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=S9C5sM6anUhm8JiGdOCB0uB2YvzRwsjhkW8Q/FUyZCw=;
	b=V6qG1ofz/X4WVBgg9/WI1W1FT5lgq1uC/5EnrfqQY+necD/+vB/Juc0WZN4qsVVTp1nndL
	6+R6hbsIsXx6kyS1Z/p4hHtX7Iccp9W7GmkDhs7x5L2XZLsOQAM1Ws/ad42+ohEmKym20Z
	qjZeiHnJ+jxq7Ue0NU9AR22wdZcdhvsEsJTDrPZifmnBaDuWUJ5qOIHT418pkiSGDul8hz
	nXGn0jZpG1T2J2fkgEGP5fI11KnYnTEEsL/0Xu48mEw/7hvnaAXXahuOnu1NuzjQKrz8DO
	QUCVo3weJu1aiFO45xnbmF3YEIulwTGmEIIL735o46tZxVjwbUe0ta+I3bCz3Q==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH] libselinux: prioritize local literal fcontext definitions
Date: Thu, 17 Apr 2025 21:08:11 +0200
Message-ID: <20250417190812.41263-1-cgoettsche@seltendoof.de>
Reply-To: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

For literal file context definitions respect overrides from homedirs or
local configurations by ordering them first.

Fixes: 92306daf ("libselinux: rework selabel_file(5) database")
Reported-by: Paul Holzinger
Link: https://bugzilla.redhat.com/show_bug.cgi?id=2360183
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/label_file.c       |  5 +++--
 libselinux/src/label_file.h       | 10 +++++++++-
 libselinux/src/selinux_internal.h |  2 ++
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 5d73fb84..61a9ddb6 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -480,7 +480,7 @@ static int load_mmap_ctxarray(struct mmap_area *mmap_area, const char *path, str
 	return 0;
 }
 
-static int load_mmap_literal_spec(struct mmap_area *mmap_area, bool validating,
+static int load_mmap_literal_spec(struct mmap_area *mmap_area, bool validating, uint8_t inputno,
 				  struct literal_spec *lspec, const struct context_array *ctx_array)
 {
 	uint32_t data_u32, ctx_id;
@@ -489,6 +489,7 @@ static int load_mmap_literal_spec(struct mmap_area *mmap_area, bool validating,
 	int rc;
 
 	lspec->from_mmap = true;
+	lspec->inputno = inputno;
 
 
 	/*
@@ -742,7 +743,7 @@ static int load_mmap_spec_node(struct mmap_area *mmap_area, const char *path, bo
 		node->literal_specs_alloc = lspec_num;
 
 		for (uint32_t i = 0; i < lspec_num; i++) {
-			rc = load_mmap_literal_spec(mmap_area, validating, &node->literal_specs[i], ctx_array);
+			rc = load_mmap_literal_spec(mmap_area, validating, inputno, &node->literal_specs[i], ctx_array);
 			if (rc)
 				return -1;
 		}
diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index 67db78e5..b7aed0bc 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -96,6 +96,7 @@ struct literal_spec {
 	char *regex_str;			/* original regular expression string for diagnostics */
 	char *literal_match;			/* simplified string from regular expression */
 	uint16_t prefix_len;			/* length of fixed path prefix, i.e. length of the literal match */
+	uint8_t inputno;			/* Input number of source file */
 	uint8_t file_kind;			/* file type */
 	bool any_matches;			/* whether any pathname match */
 	bool from_mmap;				/* whether this spec is from an mmap of the data */
@@ -368,7 +369,13 @@ static inline int compare_literal_spec(const void *p1, const void *p2)
 		return ret;
 
 	/* Order wildcard mode (0) last */
-	return (l1->file_kind < l2->file_kind) - (l1->file_kind > l2->file_kind);
+	ret = spaceship_cmp(l1->file_kind, l2->file_kind);
+	if (ret)
+		return -ret;
+
+	/* Order by input number (higher number means added later, means higher priority) */
+	ret = spaceship_cmp(l1->inputno, l2->inputno);
+	return -ret;
 }
 
 static inline int compare_spec_node(const void *p1, const void *p2)
@@ -754,6 +761,7 @@ static int insert_spec(const struct selabel_handle *rec, struct saved_data *data
 			.regex_str = regex,
 			.prefix_len = prefix_len,
 			.literal_match = literal_regex,
+			.inputno = inputno,
 			.file_kind = file_kind,
 			.any_matches = false,
 			.lr.ctx_raw = context,
diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux_internal.h
index 964b8418..3fe7d4c3 100644
--- a/libselinux/src/selinux_internal.h
+++ b/libselinux/src/selinux_internal.h
@@ -150,4 +150,6 @@ static inline void fclose_errno_safe(FILE *stream)
 # define unlikely(x)			(x)
 #endif /* __GNUC__ */
 
+#define spaceship_cmp(a, b)		(((a) > (b)) - ((a) < (b)))
+
 #endif /* SELINUX_INTERNAL_H_ */
-- 
2.49.0

