Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794840870;
	b=NR6/e4ghAgnX01J63bcRgPUmY0jGKv3uCfrmWT/iYIR4BrlaUiyVH4i21mqkuOCvFuAd
	 DrchFwYo0GlVZPeyE5MWuZ6i2KwwNBjHjBy1pQpmPzoYAKzi9CG6RziZp6D9RDXTcj26I
	 z+nX/WUWTmH3vtE1sbvdiULvxIkmt4grAC+sFIK/6ktc2Hkw6+pYW34omPzxXeYWZGF+N
	 Op8Y1gpech2NkpA4ZoD6Kjsf17vZvNgBjZ7VnDlx756knVMHbXYqnDo9G5NWYJW9LC/Zy
	 gtaXfpj7X6sb2emhFw0IF+6MVWRyuFT9+LNmSUpSEoR7Oju31CgZJlaKHv1CxVgZfVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794840870;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=uuXCo1sAlP1tFF94DnaEuYA1IFAHU7dxFoxZmyTqWXg=;
	b=03gM969MVeREj9GZEoSfBKdzhdAncxcFNMX4vP31a8wu4yGhfX5K1QIUjY/PsYTtxUsQ
	 TuwU6u4ejGHuumfNHw7fbhWgh10zcWeIXIep80nS9emUVMgTJf81bCPwIzIUPvqyXo9ln
	 JW+w4BC8xJ29TvZ7jHwypTF2K1nW/kLoF90dkf3YNNrUW48iB1w6jEE0YHwHHwWb67pWH
	 AB4GStF52qPlMKV0E31yDCeDywRpPytrdbxNp871pvwm4FNO6bwhNVv5kvkdwosVGzcmZ
	 TVaA0lMngtCLe8cZqDzGyGOpawvswhAXQf3YcdXAOmmIXDGbNzmJEzhLy36+ymtVocw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jBuLBtDJ;
	arc=none smtp.remote-ip=209.85.219.45
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590A2606A31C
	for <selinux@vger.kernel.org>; Mon, 16 Nov 2026 14:54:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 590A2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jBuLBtDJ
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-91c11468b5fso42850466d6.0
        for <selinux@vger.kernel.org>; Mon, 16 Nov 2026 06:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794840869; x=1795445669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uuXCo1sAlP1tFF94DnaEuYA1IFAHU7dxFoxZmyTqWXg=;
        b=jBuLBtDJ+GmMM/tbGRE39INBwiGKq6IJj48z/PCR/7eFTjtv/jeUv3wbB3xg27a56j
         4MPPPf9F/NMLxy+GfeukXTf4Y9M2287ZJ8/Mos9u8/3dQOt4FKLUiLyX2iydD7rLvaSD
         P4ApdWh6rQtBZNFvhM8WmQAdmuLIy/aXRQGv3x0QA1KSM4LOLkmlwV9uPcCGMjgsia4B
         wdmLoZNzEJsuUW/Kwjfk1aI1tnfH8WKByG+w9mXf1RTR/c5LxnAJatWCnhetVHVb4sMa
         W0rLSF7WuWXOk3yDs30I0feksGYF8N4WAxtntMd0tnVSX6COB7EF4GiFFht/LBgOgmXm
         PKXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794840869; x=1795445669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uuXCo1sAlP1tFF94DnaEuYA1IFAHU7dxFoxZmyTqWXg=;
        b=MCdAO7s4Ald/vgwZFShDtImY+7MX78skqA15lMLcLsswi1+nt1v1mHqxgpb35tmAei
         x4zzLYNhS156ttrgRRkpGopcd8h2Fy0v59lPcrgqCn9dzBcHM4uXrK/BVRLlN4T8QssB
         WJIg6Ooki4z6rembOirwzF3gZVj9/58L8aQS36+T5SymoI3jK7m7nd3Z6k/djLzfUUee
         MZ5qPOd0J/hxR5r+J6S41bYv3xTanWwMuF0/E4SjsvfbYdzX/IKGXjpdw+48iJ0a3PnO
         KlqXlUyfHko1D/5+BLJGF288uATi59j65d60Sg3sS31msFF9u30z+xkaXkQtJTKDwIdj
         fZ+Q==
X-Gm-Message-State: APuU4Z+kyJFyDAFJo7+tqVyBSjaPRlvlE4S6o2ShTwnhqYSyKs9gyWE3
	xLiLJBsb7LmlH/82dnzuQ/S37LECNXtzkOPlAdOOpl+frVP+vcC72YgieApLiap4
X-Gm-Gg: AZFdTZc9EWSXrm+myw9JT8/F4+x9CwDPHFzTKHS1uXkaJsQO8JhGWT/U0L09TgXsyJ0
	en7A7xjFU5J5IeZU993+CYnlh0jjjuvkfvbyWVFBQKpKIRSKL8pZkhK386mpkeommwwFBSROlo4
	kebFoqMYEcQmYHPiNvcXn2NWUySfwxQIJD0IP2NmVyBKgjSwD8QJvk2LNdAwYKB6nrRa/WGhEEm
	Paab/xwTXqKJMpfOrgj2sHnksdLPcMhiYv9uSmMrEyjOuAxmlBzTrktWwImbslwSyPBHTJvQyE/
	RJM5HeeCt6pp0p/ylfCyIVBnrLBRi6V/zN35kfFpuRQqPpKcUgxvnJuZdYhhfN9m/nWLOO8GzZc
	CHQhjXIjuLeft+ih5JrsywrbEFNSPLae5M/WnrkGKE0RgiVkfBM2nqUMhEoGs49/MUIVONTtpOY
	qc7diTWT4ztKaeuJyHJ54vS9xRy+by1iqiWClyKAlw7sQAaRem8njci1YSXz/QRezb3XaWfM/YL
	wQNcrUtxgHBBRzVY35mPBVP0cUVvw7UepW1Z+pDS4fKif7aedzd3nNX/K0KhMwnKZq8bTFDjCFs
	t7jUlATXs+7JUbk+E0OcRKZiNqMPmfFNM/oBUF5/Q3RYoXLzqGXQjYtmvWGdH4sERbgvNNPFyll
	TxpOdp8WjbuF7J/AY6HQX8Go0+TWmxy50/veU5SHkZuGaJG322PPu+rfb3jlJngw004gtoj2xjr
	AoOAfdDZ3/91CdTw3jpm2Us3Yl6fI/8hK/mV6KVyP0xOXIBQUWzfsYII7YdmexDbFg0l7xlYM1
X-Received: by 2002:a05:6214:2d45:b0:91f:25ad:5c89 with SMTP id 6a1803df08f44-91f25bcc2a8mr165663776d6.44.1794840869285;
        Mon, 16 Nov 2026 06:54:29 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d952fesm86406956d6.32.2026.11.16.06.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 06:54:28 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	jwcart2@gmail.com,
	cahu@suse.de,
	jsegitz@suse.de,
	tweek@google.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 1/2] libsemanage: accept empty local file contexts when sorting
Date: Mon, 16 Nov 2026 09:53:51 -0500
Message-ID: <20261116145351.132137-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A zero-byte file_contexts.local specifies no overrides. With local
sorting enabled, the raw-file fallback attempts to mmap zero bytes and
aborts even an unrelated transaction. Treat an empty regular file as
empty input in the sorter and publish the usual header, just as for a
comment-only file.

Use the size of the opened file and keep the existing mapping semantics
for module readers. Test the contents of the published file.

Fixes: ee7e4e1e4e97 ("libsemanage: optionally sort file_contexts.local by specificity")
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v2 adds a Fixes tag.

 libsemanage/src/compressed_file.c       | 27 +++++++++++++++++----
 libsemanage/src/compressed_file.h       |  4 ++++
 libsemanage/src/semanage_store.c        |  2 +-
 libsemanage/tests/test_semanage_store.c | 32 +++++++++++++++++++++++++
 4 files changed, 59 insertions(+), 6 deletions(-)

diff --git a/libsemanage/src/compressed_file.c b/libsemanage/src/compressed_file.c
index 367ad685..749a56e3 100644
--- a/libsemanage/src/compressed_file.c
+++ b/libsemanage/src/compressed_file.c
@@ -187,8 +187,8 @@ exit:
 	return ret;
 }
 
-int map_compressed_file(semanage_handle_t *sh, const char *path,
-			struct file_contents *contents)
+static int map_file(semanage_handle_t *sh, const char *path,
+		    struct file_contents *contents, bool allow_empty)
 {
 	ssize_t size = -1;
 	void *uncompress;
@@ -214,9 +214,14 @@ int map_compressed_file(semanage_handle_t *sh, const char *path,
 		contents->compressed = 1;
 	} else {
 		struct stat sb;
-		if (fstat(fd, &sb) == -1 ||
-		    (uncompress = mmap(NULL, sb.st_size, PROT_READ, MAP_PRIVATE,
-				       fd, 0)) == MAP_FAILED) {
+		if (fstat(fd, &sb) == -1) {
+			ret = -1;
+		} else if (allow_empty && S_ISREG(sb.st_mode) &&
+			   sb.st_size == 0 && !ferror(file)) {
+			*contents = (struct file_contents){ 0 };
+		} else if ((uncompress = mmap(NULL, sb.st_size, PROT_READ,
+					      MAP_PRIVATE, fd, 0)) ==
+			   MAP_FAILED) {
 			ret = -1;
 		} else {
 			contents->data = uncompress;
@@ -228,6 +233,18 @@ int map_compressed_file(semanage_handle_t *sh, const char *path,
 	return ret;
 }
 
+int map_compressed_file(semanage_handle_t *sh, const char *path,
+			struct file_contents *contents)
+{
+	return map_file(sh, path, contents, false);
+}
+
+int map_compressed_file_allow_empty(semanage_handle_t *sh, const char *path,
+				    struct file_contents *contents)
+{
+	return map_file(sh, path, contents, true);
+}
+
 void unmap_compressed_file(struct file_contents *contents)
 {
 	if (!contents->data)
diff --git a/libsemanage/src/compressed_file.h b/libsemanage/src/compressed_file.h
index 76a0e783..0f8056ed 100644
--- a/libsemanage/src/compressed_file.h
+++ b/libsemanage/src/compressed_file.h
@@ -52,6 +52,10 @@ struct file_contents {
 int map_compressed_file(semanage_handle_t *sh, const char *path,
 			struct file_contents *contents);
 
+/* Also accept an empty regular file, returning zeroed contents. */
+int map_compressed_file_allow_empty(semanage_handle_t *sh, const char *path,
+				    struct file_contents *contents);
+
 /**
  * Destroy a previously mapped possibly-compressed file.
  *
diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index d904e698..2ada797b 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -1766,7 +1766,7 @@ int semanage_sort_fc_file(semanage_handle_t *sh, const char *src,
 	if (access(src, F_OK) != 0)
 		return (errno == ENOENT) ? 0 : -1;
 
-	if (map_compressed_file(sh, src, &contents) < 0) {
+	if (map_compressed_file_allow_empty(sh, src, &contents) < 0) {
 		ERR(sh, "Could not read %s.", src);
 		return -1;
 	}
diff --git a/libsemanage/tests/test_semanage_store.c b/libsemanage/tests/test_semanage_store.c
index 490e1eb0..f6d19332 100644
--- a/libsemanage/tests/test_semanage_store.c
+++ b/libsemanage/tests/test_semanage_store.c
@@ -52,6 +52,32 @@ static const char *const translockpath =
 static const char *const actpath = "./test-policy/store/active";
 static const char *const modpath = "./test-policy/store/active/modules";
 
+static void test_sort_empty_fc_file(void)
+{
+	const char *src = "./test-policy/empty.local";
+	const char *dst = "./test-policy/sorted.local";
+	const char expected[] = "# This file is auto-generated by libsemanage\n"
+				"# Do not edit directly.\n\n";
+	char buf[sizeof(expected)];
+	FILE *f = fopen(src, "w");
+
+	CU_ASSERT_PTR_NOT_NULL_FATAL(f);
+	CU_ASSERT_EQUAL(fclose(f), 0);
+	CU_ASSERT_EQUAL(semanage_sort_fc_file(sh, src, dst, 0600), 0);
+	f = fopen(dst, "r");
+	CU_ASSERT_PTR_NOT_NULL(f);
+	if (f) {
+		size_t n = fread(buf, 1, sizeof(buf), f);
+
+		CU_ASSERT_EQUAL(n, sizeof(expected) - 1);
+		if (n == sizeof(expected) - 1)
+			CU_ASSERT_EQUAL(memcmp(buf, expected, n), 0);
+		CU_ASSERT_EQUAL(fclose(f), 0);
+		unlink(dst);
+	}
+	unlink(src);
+}
+
 /* The suite initialization function.
  * Returns zero on success, non-zero otherwise.
  */
@@ -147,6 +173,12 @@ int semanage_store_add_tests(CU_pSuite suite)
 		return CU_get_error();
 	}
 
+	if (!CU_add_test(suite, "sort_empty_fc_file",
+			 test_sort_empty_fc_file)) {
+		CU_cleanup_registry();
+		return CU_get_error();
+	}
+
 	return 0;
 }
 
-- 
2.56.0

