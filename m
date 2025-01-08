Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BED1F0E37
	for <selinux@vger.kernel.org>; Wed,  8 Jan 2025 16:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736353924; cv=none; b=JlMiTNysr9fO0m8FAGOgyHUChsvqKbcQxGPaZz04QqGiDFQNsncanXf/t1uVjgNgYHETgHOrb5jxjrSkNFCzvrIDSytTFADSj/7SpSrYBtPk/o7PfFwjq13NMVnFQBkqhToJPm/uY7AKDA6zWIu7F4rZu2eS7hu3BmhM3Kkdo40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736353924; c=relaxed/simple;
	bh=MszvDhfUkVuWixWeXzHMCC26KOY+6fTKeEh85HPdTyE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T3/C9Gzkv79tZu0gDvcNZDyQ0PVxK89Sasu68ARN99TVsUY8VXZOBkjun4cjz53mBCjk8brsC13dnXecRDHwgP6Wi465Dp//ITTHmjba5oJrG5OwJFCnd5e0aRklOFuM/bcHJ7j6ySiG9JkTFznWl8AufwBZu5M5VkTKunCrRBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=nhw3rWs8; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="nhw3rWs8"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1736353913;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=kQp8TRoklno6SAEPb6jPy/JB0YjLjYDiSRZQduLFV98=;
	b=nhw3rWs8V0qY9TLODsci+Ucj40HMK7gZH69NPreg4HNhCPDoJSRpxlN1MIzal+VUgn5piw
	AJV2bhx+6Pa7iE9YbiTEJxVAjNTTKgpyiNOCnwnSc3/N3bWcO+YZ5ZrHMpOXQ9exKTuwPA
	hJobl3OHxK+vgrlbzwfHzgKiaJ3sqLz4sJUD4kyd86VDxzzQ1ap+hAwvuggVQjFFtfw5L4
	iVL40XELq1xdT7ElbrScBc32PXwNxDuT0b8to57oFchCgNJjBM0fPpoP3TA58H6Uvr8aS/
	hYuMRaVdipUlPL6nO/xiMMUsR7pc5k++riJxI4+2PHqLnGNsCjnxIqHoCxO9QA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 2/2] libselinux/fuzz: handle inputs with trailing data
Date: Wed,  8 Jan 2025 17:31:48 +0100
Message-ID: <20250108163149.104958-1-cgoettsche@seltendoof.de>
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

Handle the case where either separated trailing input is empty or non-
existent by initializing the size to 0 and only call related code on
non-zero size.

Fixes: 8997f543 ("libselinux: add selabel_file(5) fuzzer")
Reported-by: oss-fuzz (issue 388319478)
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 .../fuzz/selabel_file_compiled-fuzzer.c       | 67 ++++++++++++-------
 1 file changed, 41 insertions(+), 26 deletions(-)

diff --git a/libselinux/fuzz/selabel_file_compiled-fuzzer.c b/libselinux/fuzz/selabel_file_compiled-fuzzer.c
index 09fbddd1..51fffcda 100644
--- a/libselinux/fuzz/selabel_file_compiled-fuzzer.c
+++ b/libselinux/fuzz/selabel_file_compiled-fuzzer.c
@@ -95,7 +95,7 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 	uint8_t control;
 	uint8_t *fcontext_data1 = NULL, *fcontext_data2 = NULL, *fcontext_data3 = NULL;
 	char *key = NULL;
-	size_t fcontext_data1_len, fcontext_data2_len, fcontext_data3_len, key_len;
+	size_t fcontext_data1_len, fcontext_data2_len = 0, fcontext_data3_len = 0, key_len;
 	bool partial, find_all;
 	mode_t mode;
 	int rc;
@@ -141,11 +141,14 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 	sep = memmem(data, size, separator, 4);
 	if (sep) {
 		fcontext_data2_len = sep - data;
-		fcontext_data2 = malloc(fcontext_data2_len);
-		if (!fcontext_data2)
-			goto cleanup;
+		if (fcontext_data2_len) {
+			fcontext_data2 = malloc(fcontext_data2_len);
+			if (!fcontext_data2)
+				goto cleanup;
+
+			memcpy(fcontext_data2, data, fcontext_data2_len);
+		}
 
-		memcpy(fcontext_data2, data, fcontext_data2_len);
 		data += fcontext_data2_len + 4;
 		size -= fcontext_data2_len + 4;
 	}
@@ -153,11 +156,14 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 	sep = memmem(data, size, separator, 4);
 	if (sep) {
 		fcontext_data3_len = sep - data;
-		fcontext_data3 = malloc(fcontext_data3_len);
-		if (!fcontext_data3)
-			goto cleanup;
+		if (fcontext_data3_len) {
+			fcontext_data3 = malloc(fcontext_data3_len);
+			if (!fcontext_data3)
+				goto cleanup;
+
+			memcpy(fcontext_data3, data, fcontext_data3_len);
+		}
 
-		memcpy(fcontext_data3, data, fcontext_data3_len);
 		data += fcontext_data3_len + 4;
 		size -= fcontext_data3_len + 4;
 	}
@@ -202,29 +208,38 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 	}
 
 	fclose(fp);
+	fp = NULL;
 
-	fp = convert_data(fcontext_data2, fcontext_data2_len);
-	if (!fp)
-		goto cleanup;
+	if (fcontext_data2_len) {
+		fp = convert_data(fcontext_data2, fcontext_data2_len);
+		if (!fp)
+			goto cleanup;
 
-	errno = 0;
-	rc = load_mmap(fp, fcontext_data2_len, &rec, MEMFD_FILE_NAME, 1);
-	if (rc) {
-		assert(errno != 0);
-		goto cleanup;
+		errno = 0;
+		rc = load_mmap(fp, fcontext_data2_len, &rec, MEMFD_FILE_NAME, 1);
+		if (rc) {
+			assert(errno != 0);
+			goto cleanup;
+		}
+
+		fclose(fp);
+		fp = NULL;
 	}
 
-	fclose(fp);
+	if (fcontext_data3_len) {
+		fp = convert_data(fcontext_data3, fcontext_data3_len);
+		if (!fp)
+			goto cleanup;
 
-	fp = convert_data(fcontext_data3, fcontext_data3_len);
-	if (!fp)
-		goto cleanup;
+		errno = 0;
+		rc = load_mmap(fp, fcontext_data3_len, &rec, MEMFD_FILE_NAME, 2);
+		if (rc) {
+			assert(errno != 0);
+			goto cleanup;
+		}
 
-	errno = 0;
-	rc = load_mmap(fp, fcontext_data3_len, &rec, MEMFD_FILE_NAME, 2);
-	if (rc) {
-		assert(errno != 0);
-		goto cleanup;
+		fclose(fp);
+		fp = NULL;
 	}
 
 	sort_specs(&sdata);
-- 
2.47.1

