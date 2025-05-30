Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D7622ACDA
	for <selinux@vger.kernel.org>; Fri, 30 May 2025 12:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748608256; cv=none; b=N53127BCuJvPhksTTo6MKnnMZSHFOs/UVsoTjUltUCsIbCaZxrAnpaPywun6HGKDqTHEHJDuNPzfK/7xMnUh/uDkYkgqVYDCN1/1yYC9ljBDidiPkIQcCrwgehYEIx9YbN/ClrCbIXXSE/LlsrnZHO99fFwYpJippeYSVhsyb8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748608256; c=relaxed/simple;
	bh=U93380oiGceapD4HAu1/NUhqb8omNvdzyAlm291BQ7s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fRIf/bN+bkiysZAifjUNXEFix8freEYfsVv+WONM/Mb1R+chBvCDrhWmtFRciyjBY9ZK2ZG6I9wROKNvFM4fXkimrSH9Lkg1483yYcUVyGiNqOhmrWxdY8zEtUbI0wxs9TDuJI14VZJBTYmHsIdEiLTFcT1gU0G7yzMAYZ1tZVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=nRS6oQWw; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="nRS6oQWw"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1748608251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KDEgq6VSTDbnez1Ete8xOhwP8ZBsBv4/uaRqy4JoiRo=;
	b=nRS6oQWwnThURjfWdSekW6gyB3a6liONGTdcG+0fRPDOgp4y7wqHZlkiQEj2jYYdAXEO4V
	DeBFdQPc58CGxcIk6Lf8bb8zZdWHcEm4GpMQddW0NOjaKIqZLpeq+NzKQD7cfX/t11rbAd
	KKIF29dK8iD7gi+pyxMmfsZtSuESNqs6x9BgiF6XtgdTm9ah4hYdffl1jRFr9l/ShIcrRy
	ZFDbhMWLPyxJQH7ECSaDmoWH371W8dPRlb8UIP6FCYb5oLC8SAzSCj+9Bs6m3+mR+YHZU9
	J/VI6mpIhqLcAoF5feE15b05U5Brf5OM23rQ5KIEbfZaB0iwFgkgXDtUvSEaBQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH v2 1/2] libselinux: prioritize local literal fcontext definitions
Date: Fri, 30 May 2025 14:30:47 +0200
Message-ID: <20250530123048.53419-1-cgoettsche@seltendoof.de>
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

Also retain the order regarding the file kind for backward
compatibility.

Fixes: 92306daf ("libselinux: rework selabel_file(5) database")
Reported-by: Paul Holzinger
Link: https://bugzilla.redhat.com/show_bug.cgi?id=2360183
Suggested-by: James Carter <jwcart2@gmail.com>
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2: drop ordering based in file type, thanks Jim
---
 libselinux/src/label_file.c       | 5 +++--
 libselinux/src/label_file.h       | 7 +++++--
 libselinux/src/selinux_internal.h | 2 ++
 3 files changed, 10 insertions(+), 4 deletions(-)

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
index 67db78e5..d1a0713a 100644
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
@@ -367,8 +368,9 @@ static inline int compare_literal_spec(const void *p1, const void *p2)
 	if (ret)
 		return ret;
 
-	/* Order wildcard mode (0) last */
-	return (l1->file_kind < l2->file_kind) - (l1->file_kind > l2->file_kind);
+	/* Order by input number (higher number means added later, means higher priority) */
+	ret = spaceship_cmp(l1->inputno, l2->inputno);
+	return -ret;
 }
 
 static inline int compare_spec_node(const void *p1, const void *p2)
@@ -754,6 +756,7 @@ static int insert_spec(const struct selabel_handle *rec, struct saved_data *data
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

