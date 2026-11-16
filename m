Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794840130;
	b=IgASXqRyCO/2s0Hzyyhqiehlt6qoz5ceIcd7VLYApKWz3NAI6QCorhS0zla1+VRO1N+i
	 PvOqs8vP/OcSzCPNmxWzqc0PqtNdy9gcQ6NeB6cdvygFhz7Vnu0dGXtGnGko8YKMYJX4z
	 F5c2hXPwKYRLLqYYQVBEBIWoORAKZ23gbtClKMBsjKBnxlhabiusndlcjxi4ESPxSUy6y
	 4R8sEeJCzsySXBPqMgm6LAbo3uZtdnZ67kDVFcRrvgHSDZAB6LTHXAwt0BAuDswHZ+RHS
	 5QqilXkUHpZ39d46tG/yv/uNHDRYnzPKJXDX5ZBaQjzQt9LwR4NkqV1I2xitp4u4wqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794840130;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=NL3V8kA1Oo1zV3y4lSYgRYzOiCbAhVCGJOiIY9Qk4Z4=;
	b=UbSQa7RuK6/5fX4cOaVXs5ub+H/95+4wzkN7xr1eBg5ONRPy8yTDVnidBALnuDqF8eUZ
	 FjnkxGx3dhLHlCxjiwNFFVVaak/5ZfJOPY+Zkz9itCULnS0S09pno4imcmN9h/aeVnZAu
	 QLZrRU7KUJ+c3hDmWZ/BdiKMGH+TlMhFxyLvLhap4CH2qftYzxYurlwYQm4p0IGCJhbzV
	 TaiPIZWXeSZCgljabXGlu2IX22Q1AI5uCz+eNYHFHKfsyHzu6NQNekaty6E7048fvASIX
	 H/Ia44uB3HUAgBtvJCnAO6W1x59mAr+8zC/8QHFGIH88cZibtbj+T+h6mrZAMekHEcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nTi4uhMT;
	arc=none smtp.remote-ip=209.85.219.45
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C52606A31C
	for <selinux@vger.kernel.org>; Mon, 16 Nov 2026 14:42:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5C52606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nTi4uhMT
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-91f332a4b2eso25975546d6.0
        for <selinux@vger.kernel.org>; Mon, 16 Nov 2026 06:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794840129; x=1795444929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NL3V8kA1Oo1zV3y4lSYgRYzOiCbAhVCGJOiIY9Qk4Z4=;
        b=nTi4uhMToKNNL4SRDtO6I7zdKoupBKqpnK4qWvqWZ1hlFhZsnFL+UaOuph+F6kdNxx
         1/owdQq3hBcO7uSVWiT4UjwzZD1LWPWUAiWSP3mShcSiXAGMNRf8pAFZFQ9xuNNyBocO
         ruuNkcybmja5bWtzKi6ZSS0HWFUtE0mSxmn+rFa4uwt2vOSPvEfGkThJVvfyBJDMrVA3
         x8I3buTLMifXWnGC3zSb+/y5pGxbVKZwjIjVz/tQfB8hNQPPCYkVEADmfSlMLpg5UlPL
         MMcD6eo/5Y0+JYZsgQbM946NdT6xGcL/L+QD18O5fIU7TU/MFwNAYGIw3DtPS4E5tmb4
         G1pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794840129; x=1795444929;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NL3V8kA1Oo1zV3y4lSYgRYzOiCbAhVCGJOiIY9Qk4Z4=;
        b=e3gnoYomQKSbqTODsn4NeLzvDhMgTJyT7yvUl/e83KGRuFG0Ay913D0/Kr94EOsMtG
         3ntBN9XXY5vx2ZrchrC0vQJMKXPSErffaMYqR7Ladmdcs4lN1I5olnsfnS1YGfpToqU9
         tCS7w/I73zHRk9HaQ7u4syODr5NB+U/HJTlTwWw8s25EwDKKoYWvgxAL7nieQ0cSvCA1
         90VVPNyrR9Y1s7jDLNvG9O+WBattB2H6wfloFOCPcJKTCbG5YLp83qtuSji/QdvGaI1q
         C6hEFToywH+MVRuBwe/P/P1va4TyxnQBBVDIBJ9aFkTkWTExB0Ax6Vu2GcCJhySxuaur
         K1AQ==
X-Gm-Message-State: APuU4Z+t/DtCjQIKVB8/krIyQ3RKx89xD3ONZ9EWDaX+xxIBgOqooCsw
	T55B4+yLN04Oitj2B3joWadHtp3nYjgKoSCOUhLZP3QdNaRG7zOsgoFT+8H6STfw
X-Gm-Gg: AZFdTZcRcPvSJCcRObmVwllvJA1uvqnIWDi6bV29J9jcCJpuzTTQyymaR2umXDJYGS9
	gxtTgT7aMyoU4HAImWBaul9n2/XIUB4X7UjCHoMfCrom09eHWpgLzyx+4ZwmdnkcV0+nZtOK7yO
	bNKJWBd/Vq7TFF4Q98os5LmIpknSt3olmLFan8fYZJWUpGtV6bEZb8LZR+sx+6LHjvJqzxI7Htr
	mP+yXaRGfGLUqHfoDY0+SloWEuJ7/dEL+gJPCKQLX/wL7lwzQe7H43WTTP4ztXZlBDiNa+MusTa
	67gBYHw0U7fef9kdR6j/pHkEy6HVE3JUyG03XIj0y9yStLNfwRCwcy6aFNRG2rrspV4KAZ6gKc9
	O787xiFjh/I5uFfdfhhuOGx7BdAwo9HZN5GubrPgjKjVuzPe2KT8oiS4lQe11WO+6Sn4sNGKzbE
	Nz5qqdbOu3bYG+BZ4N1Knd0L/iJ611i/lSxP+hUqYBiWQ9/5ti8AMJlZTCYEeqMYAosVnWVyPh6
	TvxxwvKiIyGNaFwJEMb50Y8YwI5XfSufzhyCBKpsUWLSTywSAA8/se/EvG7OLgQa4ZKxw6aZ90X
	pK3WgnjSd9e7LbcfDbZod3EMEuWO6YtNJaIH5vI0GwrFQJGulM3Z8lgYFb3f7nCJKwz5a76VsqQ
	4EReluYzntv0b/1KmAUUWrb+gaG7+DAsJL84xKN/iLkL47+ZJSYbS3s3NvOSP9upxN/hPXbsG/8
	wKfOceGXDyXp8iYc4cyBCjZ/x5fAjugl0caxnWhzMjetL6Spk0ZWk=
X-Received: by 2002:a05:6214:8009:b0:91e:792d:22ab with SMTP id 6a1803df08f44-91f242035bdmr143652756d6.28.1794840128612;
        Mon, 16 Nov 2026 06:42:08 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d94190sm86302496d6.31.2026.11.16.06.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 06:42:08 -0800 (PST)
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
Subject: [PATCH 1/2] libsemanage: accept empty local file contexts when sorting
Date: Mon, 16 Nov 2026 09:41:49 -0500
Message-ID: <20261116144150.131996-1-stephen.smalley.work@gmail.com>
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

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
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

