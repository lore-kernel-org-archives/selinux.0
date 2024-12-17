Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD881DD54C
	for <selinux@vger.kernel.org>; Tue, 17 Dec 2024 21:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734470889; cv=none; b=rVGDsP3xBdSQYkKCpjxRpB3l+Bw1xVzAYv0hiInGtb2m6yzroojgY9aOU9vv//1adFipWmPjZGxIlwaC6uq6gbR2p4siznkKLfSLN1Y4ATjbJpUlvrnt1LHC0MkbNdJAZZL1o1XH8dIXreaK4Vz3kircfXRCcLqaJaPa1qnJSDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734470889; c=relaxed/simple;
	bh=mw+T4iDOZbSW6nC6qziOag+FDEyAJJ9L1gHv+2pVU/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iUJZKrYwzeMVJZQqMtX6cChra93PRDhrbQR/5sBlPQsR8Lz0N6VI/rf2P0wv9yBLI3SO8bvvWnQadUcjJG8Nbr8AztRFXc5KHQx61fvHZO9YlFVRjTKM9ZBNU8z4w8fQo4xmLLNd53NNKrUcjgxeXDOQRbgs2GDTqtGgRitINqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=Fuy9qSZb; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="Fuy9qSZb"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1734470876;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=8yTthlNOTzhROiYX5RKeMzOzWnV6F6qE8ZKLlwqqheM=;
	b=Fuy9qSZb4xPUxiA83FIDdDujqjRcwb5vxiKXB7346Aw8JHsNp4JEhQFtLtScK7rAhaX1/w
	Zyplwl59u8DQSfeD25lF34cAWlQFUqov15OZa50Sb7TpTEM5xJnPxGj7DyzKdtwlwYo5wq
	wcQR9Xv6/8aqRLhyoGp4BY304D3EzH9qrkrMIuA0AF+19UlDTiAx3e+XZ9AxD+hL9lLJPO
	8FkjZ7nkwLXc3fvYFv64ExLMychFLSv73qDNpLVUynrodbPWWy/D82Z5xyFXwTTGczbKq5
	nMGuaq01oaUOtvBoTx3gkugLvZoCI+J2tugi4eZ7aaGgzteY/0UyMxeNixy0tw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH] libselinux/fuzz: readjust load_mmap() update
Date: Tue, 17 Dec 2024 22:27:52 +0100
Message-ID: <20241217212752.23866-1-cgoettsche@seltendoof.de>
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

Update the fuzzers for the input number parameter addition.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/fuzz/selabel_file_compiled-fuzzer.c | 6 +++---
 libselinux/fuzz/selabel_file_text-fuzzer.c     | 2 +-
 libselinux/src/label_file.h                    | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/libselinux/fuzz/selabel_file_compiled-fuzzer.c b/libselinux/fuzz/selabel_file_compiled-fuzzer.c
index d1249a76..09fbddd1 100644
--- a/libselinux/fuzz/selabel_file_compiled-fuzzer.c
+++ b/libselinux/fuzz/selabel_file_compiled-fuzzer.c
@@ -195,7 +195,7 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 		goto cleanup;
 
 	errno = 0;
-	rc = load_mmap(fp, fcontext_data1_len, &rec, MEMFD_FILE_NAME);
+	rc = load_mmap(fp, fcontext_data1_len, &rec, MEMFD_FILE_NAME, 0);
 	if (rc) {
 		assert(errno != 0);
 		goto cleanup;
@@ -208,7 +208,7 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 		goto cleanup;
 
 	errno = 0;
-	rc = load_mmap(fp, fcontext_data2_len, &rec, MEMFD_FILE_NAME);
+	rc = load_mmap(fp, fcontext_data2_len, &rec, MEMFD_FILE_NAME, 1);
 	if (rc) {
 		assert(errno != 0);
 		goto cleanup;
@@ -221,7 +221,7 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 		goto cleanup;
 
 	errno = 0;
-	rc = load_mmap(fp, fcontext_data3_len, &rec, MEMFD_FILE_NAME);
+	rc = load_mmap(fp, fcontext_data3_len, &rec, MEMFD_FILE_NAME, 2);
 	if (rc) {
 		assert(errno != 0);
 		goto cleanup;
diff --git a/libselinux/fuzz/selabel_file_text-fuzzer.c b/libselinux/fuzz/selabel_file_text-fuzzer.c
index ed67ea25..1f8942dd 100644
--- a/libselinux/fuzz/selabel_file_text-fuzzer.c
+++ b/libselinux/fuzz/selabel_file_text-fuzzer.c
@@ -167,7 +167,7 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 		goto cleanup;
 
 	errno = 0;
-	rc = process_text_file(fp, /*prefix=*/ NULL, &rec, MEMFD_FILE_NAME);
+	rc = process_text_file(fp, /*prefix=*/ NULL, &rec, MEMFD_FILE_NAME, 0);
 	if (rc) {
 		assert(errno != 0);
 		goto cleanup;
diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index 597b756e..60ebbb47 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -60,7 +60,7 @@ struct lookup_result {
 	struct lookup_result *next;
 };
 #ifdef FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION
-extern int load_mmap(FILE *fp, const size_t len, struct selabel_handle *rec, const char *path);
+extern int load_mmap(FILE *fp, const size_t len, struct selabel_handle *rec, const char *path, uint8_t inputno);
 extern int process_text_file(FILE *fp, const char *prefix, struct selabel_handle *rec, const char *path, uint8_t inputno);
 extern void free_lookup_result(struct lookup_result *result);
 extern struct lookup_result *lookup_all(struct selabel_handle *rec, const char *key, int type, bool partial, bool find_all, struct lookup_result *buf);
-- 
2.45.2

