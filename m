Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C6682C60
	for <selinux@vger.kernel.org>; Thu,  5 Dec 2024 19:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733427610; cv=none; b=oEAdTtZOe/uAqHbYbmF/VUGu9tmHZUcPk1aG1WQOZT6AXr7CAjKdzRyWj5QMvP+psmv3Kaywo/W+jyZRMAtCZBzUGnboHwDArtK11laeyuyl8S5jg4H2BWLlWDCFNj8CJq5e6ZxBvUoIEyNnALyp82lJoPsTtcsxZ84MOqVG6/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733427610; c=relaxed/simple;
	bh=VGsJSbCtwi/7op2cpGuyuwUQnK8TuR8qASiR/j21Obs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nRkwBbXqe02pwa4zM7ozoItV5mxtJO8MR3slm/BDe/+m7GmM7A0LaUuksZvPu1S1ng3FvWZjA5KfDbncLMRQkz0+cwmgrcsOUSITy0m9R+oFQwXqcAjm+PbFI3BS+1UTy45R3Xxlgafu671JqYDHHXsnU8CkI63tQl3YShMKH08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=Tp1LatN/; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="Tp1LatN/"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1733427009;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=sJDRrVa66mAKKQw0cQngJ3C6Kgoxxv0kLZjdBEX362Q=;
	b=Tp1LatN/45f00kb1kofdbvZw8Pz+vlXVb9fIowFQ/ngvIgf04X/11SpZ6z1+B5Wq3w1FNF
	lGxy+JbATnX3lGonoPzJj86V40XT+5JGGAN2dTS7pDC2BObO8TeFRKHFqEVzkeSwyqO/7d
	2oaWM5yfnRlu0BIYyy80IzUg++/949/evyIveW9y4MB6Umy9BHbY9KfdQp28+P9BJDEOD4
	0sWGI9+bf9WWkSHwI3mFQBf7+z2DAR2vmV09f6NVecaj/q8Pu094Ozgh0GwzVKuAPl+8Br
	kgf97GyVY8d47wS4mnFErOG4XHqKXmgOl9goSI6fD8GYz808yLUYZ1mq/0Xi1Q==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH] libselinux/fuzz: update for lookup_all() change
Date: Thu,  5 Dec 2024 20:30:05 +0100
Message-ID: <20241205193005.20532-1-cgoettsche@seltendoof.de>
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

Commit 89dd0b23 ("libselinux: avoid memory allocation in common file
label lookup") added an additional parameter to lookup_all() for an
optional buffer the return value might be placed into.  Update the
fuzzing related code accordingly.

Fixes: 89dd0b23 ("libselinux: avoid memory allocation in common file label lookup")
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/fuzz/selabel_file_compiled-fuzzer.c | 2 +-
 libselinux/fuzz/selabel_file_text-fuzzer.c     | 2 +-
 libselinux/src/label_file.h                    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/libselinux/fuzz/selabel_file_compiled-fuzzer.c b/libselinux/fuzz/selabel_file_compiled-fuzzer.c
index cf0710ad..d1249a76 100644
--- a/libselinux/fuzz/selabel_file_compiled-fuzzer.c
+++ b/libselinux/fuzz/selabel_file_compiled-fuzzer.c
@@ -232,7 +232,7 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 	assert(cmp(&rec, &rec) == SELABEL_EQUAL);
 
 	errno = 0;
-	result = lookup_all(&rec, key, mode, partial, find_all);
+	result = lookup_all(&rec, key, mode, partial, find_all, NULL);
 
 	if (!result)
 		assert(errno != 0);
diff --git a/libselinux/fuzz/selabel_file_text-fuzzer.c b/libselinux/fuzz/selabel_file_text-fuzzer.c
index 5d851de1..ed67ea25 100644
--- a/libselinux/fuzz/selabel_file_text-fuzzer.c
+++ b/libselinux/fuzz/selabel_file_text-fuzzer.c
@@ -178,7 +178,7 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 	assert(cmp(&rec, &rec) == SELABEL_EQUAL);
 
 	errno = 0;
-	result = lookup_all(&rec, key, mode, partial, find_all);
+	result = lookup_all(&rec, key, mode, partial, find_all, NULL);
 
 	if (!result)
 		assert(errno != 0);
diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index c7fe3a48..562c3da6 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -63,7 +63,7 @@ struct lookup_result {
 extern int load_mmap(FILE *fp, const size_t len, struct selabel_handle *rec, const char *path);
 extern int process_text_file(FILE *fp, const char *prefix, struct selabel_handle *rec, const char *path);
 extern void free_lookup_result(struct lookup_result *result);
-extern struct lookup_result *lookup_all(struct selabel_handle *rec, const char *key, int type, bool partial, bool find_all);
+extern struct lookup_result *lookup_all(struct selabel_handle *rec, const char *key, int type, bool partial, bool find_all, struct lookup_result *buf);
 extern enum selabel_cmp_result cmp(const struct selabel_handle *h1, const struct selabel_handle *h2);
 #endif  /* FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION */
 
-- 
2.45.2

