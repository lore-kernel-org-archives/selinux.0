Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D24205AD8
	for <selinux@vger.kernel.org>; Fri, 21 Feb 2025 09:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740130767; cv=none; b=WFCrcLSjhAm1NY5czylwe+Slr321X3sVpLxDPhoDw7yplF58JkRxcmxX5vm3bEfJbpBKMFdyLej3n5TdJ9kT3lsIvzAcMCbxS9h13G3erxWYUGnxTgwI9fy08y27P9/Bip97Q+2jdqZk8OOiLdXsWYXwO4J9ZhEYcTvN0VwgCs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740130767; c=relaxed/simple;
	bh=fpEwVHshg7qtpYYguLHzdf+nyf/hVNTF3Ua2H4HBJMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bOvLYlUHwOXsHRgDeiLTyBgXundmPiraVXyl/7BU8yX3Y9DkiqlCxHwqBLWmv9LqJMD6lAF4gHekQh+cT/qnhJNMQHyqC91ZkJDrg25YeQYE90SFD7FkC1BXIucrbkDxRRiXmEsnRjyMQ6nKqMtobsUSSjpfeheKYs6w2JBUI3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LK+paus5; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LK+paus5"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-439a2780b44so11732365e9.1
        for <selinux@vger.kernel.org>; Fri, 21 Feb 2025 01:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740130764; x=1740735564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZKzRUOjhOHx60W22j8GJRf7AUxscxfJzP2Zr+ZGOGek=;
        b=LK+paus5xaxfT9AoS5dOuwDua5SRnTzEA1rohQaiubw9qlvwu6QtbumjLNe+rRu5+F
         3DetT8L4AcQEQ94ASqFSi52irRrb9kua4b80tQKEPJwEtWqZfb+3W2EPuopJ1ZPpXMCz
         pgOKv9r4fnxx7l3oUI0Tm68fRleQngGNlG4mPXjNsrK5WZiZBXYirULEOisoA6cWlf36
         1yTT8Mh3vu0dHbWp3fFd1FNS3C46oC0h9+I0RJi978Zg/D6tQNloetg+Ruap04ds8T+v
         2nazBSL/doBgaoSiK2dA7RdjhJSG5Yv5zPukG/ZeZbxT22SrBd28h04T4KIsVu41+yKL
         P6ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740130764; x=1740735564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZKzRUOjhOHx60W22j8GJRf7AUxscxfJzP2Zr+ZGOGek=;
        b=lkhA1WmG1WcsPcRpwu8Pxxa181wqjsKllhTILT0sFQYeA5lXSuW/GpLLzTetKVfEn9
         UfGUX6tGUqIyIFSKx7xXSa3EwHIu79ldns+epjHtb+M/XJxhjPgAZj/HJ4QWFe8xdTQm
         T0kvr/UWyjxetQ/fUlLjaW3N2GMUP+Q2e1RNw0ag0NYUhzdr5y0+jHH9sc63TAoGjQUs
         lLYwsHcIkYaSCMqdnMJhVKsrpATdlKGkanEsLD84MoQKYPNKcoyXH1ebxuLA4M53Dp05
         oLHt+GMbL4iFWVkrlFbapqciooD/qkGdbglJmTBSNB7sMSoYtsv24i4/aIihIfLYCy3M
         E42Q==
X-Gm-Message-State: AOJu0YygwpFku74SHIrZGdhvAn3trPkOhLp7tiDhVdDTUKGbRG+e2d1E
	u8z0OyOchhlADlmZh/mqHLwziT+vgP4OjusDJtvrNUp9kjyPYI3hz2rvRfI4
X-Gm-Gg: ASbGncuIZ78OkFvN3cDaf3Zv6e18woMiOXFULxlN0Xw5S4FYKcLU6LgX88KNUKm23f3
	j6evzQVIhKwisKFJc294Gs5dHvgzqx8dxfwXMGUPbCbaemRtqj+t87g9GPXk5ISYJV0BMtI4yOu
	RmZb0oAWzvWxPhs9/naTwlVSibBZ+MBL3PX4Z/TPMLEKgU4CgHk5P6FELiYn+rHJ4vsizt3daej
	o2/BP/2g7wZ+V74BaLHYx1ECfgMuYKF4gN6ZGK4lRcY9uY0i/7arXz9XJ/90z0mELWo1bQoE0ck
	W4o6RhhIEOzjyJg/IeRi7wm3JN+RQx6x
X-Google-Smtp-Source: AGHT+IHUplyJebvaACQQnZrgpDTfH/2IeL2WNKlrK+b6cCpu/TiGorCJeDUNvINYCMuH06HdYYc/gg==
X-Received: by 2002:a05:600c:4f13:b0:439:98ca:e3a4 with SMTP id 5b1f17b1804b1-439ae2128f9mr19664255e9.19.1740130763330;
        Fri, 21 Feb 2025 01:39:23 -0800 (PST)
Received: from localhost.localdomain ([81.79.13.113])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38f258ddbbdsm23036707f8f.37.2025.02.21.01.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 01:39:23 -0800 (PST)
From: Rahul Sandhu <nvraxn@gmail.com>
To: selinux@vger.kernel.org,
	nvraxn@gmail.com
Cc: bill.c.roberts@gmail.com
Subject: [PATCH v2] libsemanage: create semanage_basename to ensure posix compliance
Date: Fri, 21 Feb 2025 09:39:10 +0000
Message-ID: <20250221093910.657484-1-nvraxn@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <D7Y03RIRQTEH.1SUBF6LGYYEM6@gmail.com>
References: <D7Y03RIRQTEH.1SUBF6LGYYEM6@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Passing a const char * to basename(3) is a glibc-specific extension, so
create our own basename implementation. As it's a trivial 2 LOC, always
use our implementation of basename even if glibc is available to avoid
the complications of attaining the non-posix glibc implementation of
basename(3) as _GNU_SOURCE needs to be defined, but libgen.h also needs
to have not been included.

Also fix a missing check for selinux_policy_root(3). From the man page:
On failure, selinux_policy_root returns NULL.

As the glibc basename(3) (unlike posix basename(3)) does not support
having a nullptr passed to it, only pass the policy_root to basename(3)
if it is non-null.

Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
---
 libsemanage/src/conf-parse.y       | 13 ++++++++++---
 libsemanage/src/direct_api.c       |  1 +
 libsemanage/src/utilities.c        |  9 +++++++++
 libsemanage/src/utilities.h        | 13 +++++++++++++
 libsemanage/tests/test_utilities.c | 26 ++++++++++++++++++++++++++
 5 files changed, 59 insertions(+), 3 deletions(-)

diff --git a/libsemanage/src/conf-parse.y b/libsemanage/src/conf-parse.y
index 6cb8a598..d3ca5f1f 100644
--- a/libsemanage/src/conf-parse.y
+++ b/libsemanage/src/conf-parse.y
@@ -21,6 +21,7 @@
 %{
 
 #include "semanage_conf.h"
+#include "utilities.h"
 
 #include <sepol/policydb.h>
 #include <selinux/selinux.h>
@@ -382,7 +383,10 @@ external_opt:   PROG_PATH '=' ARG  { PASSIGN(new_external->path, $3); }
 static int semanage_conf_init(semanage_conf_t * conf)
 {
 	conf->store_type = SEMANAGE_CON_DIRECT;
-	conf->store_path = strdup(basename(selinux_policy_root()));
+	const char *policy_root = selinux_policy_root();
+	if (policy_root != NULL) {
+		conf->store_path = strdup(semanage_basename(policy_root));
+	}
 	conf->ignoredirs = NULL;
 	conf->store_root_path = strdup("/var/lib/selinux");
 	conf->compiler_directory_path = strdup("/usr/libexec/selinux/hll");
@@ -544,8 +548,11 @@ static int parse_module_store(char *arg)
 	free(current_conf->store_path);
 	if (strcmp(arg, "direct") == 0) {
 		current_conf->store_type = SEMANAGE_CON_DIRECT;
-		current_conf->store_path =
-		    strdup(basename(selinux_policy_root()));
+		const char *policy_root = selinux_policy_root();
+		if (policy_root != NULL) {
+			current_conf->store_path =
+			    strdup(semanage_basename(policy_root));
+		}
 		current_conf->server_port = -1;
 	} else if (*arg == '/') {
 		current_conf->store_type = SEMANAGE_CON_POLSERV_LOCAL;
diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index 99cba7f7..ce12ccaf 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -26,6 +26,7 @@
 
 #include <assert.h>
 #include <fcntl.h>
+#include <libgen.h>
 #include <stdio.h>
 #include <stdio_ext.h>
 #include <stdlib.h>
diff --git a/libsemanage/src/utilities.c b/libsemanage/src/utilities.c
index 70b5b677..004ffb62 100644
--- a/libsemanage/src/utilities.c
+++ b/libsemanage/src/utilities.c
@@ -349,3 +349,12 @@ int write_full(int fd, const void *buf, size_t len)
 
 	return 0;
 }
+
+#ifdef __GNUC__
+__attribute__((nonnull))
+#endif
+char *semanage_basename(const char *filename)
+{
+	char *p = strrchr(filename, '/');
+	return p ? p + 1 : (char *)filename;
+}
diff --git a/libsemanage/src/utilities.h b/libsemanage/src/utilities.h
index c2d484a7..7481077a 100644
--- a/libsemanage/src/utilities.h
+++ b/libsemanage/src/utilities.h
@@ -156,4 +156,17 @@ semanage_list_t *semanage_slurp_file_filter(FILE * file,
 
 int write_full(int fd, const void *buf, size_t len) WARN_UNUSED;
 
+/**
+ * Portable implementation of the glibc version of basename(3).
+ *
+ * @param filename  path to find basename of
+ *
+ * @return          basename of filename
+ */
+
+#ifdef __GNUC__
+__attribute__((nonnull))
+#endif
+char *semanage_basename(const char *filename);
+
 #endif
diff --git a/libsemanage/tests/test_utilities.c b/libsemanage/tests/test_utilities.c
index bbd5af30..70a76fe7 100644
--- a/libsemanage/tests/test_utilities.c
+++ b/libsemanage/tests/test_utilities.c
@@ -46,6 +46,7 @@ static void test_semanage_rtrim(void);
 static void test_semanage_str_replace(void);
 static void test_semanage_findval(void);
 static void test_slurp_file_filter(void);
+static void test_semanage_basename(void);
 
 static char fname[] = {
 	'T', 'E', 'S', 'T', '_', 'T', 'E', 'M', 'P', '_', 'X', 'X', 'X', 'X',
@@ -117,6 +118,10 @@ int semanage_utilities_add_tests(CU_pSuite suite)
 				test_slurp_file_filter)) {
 		goto err;
 	}
+	if (NULL == CU_add_test(suite, "semanage_basename",
+				test_semanage_basename)) {
+		goto err;
+	}
 	return 0;
       err:
 	CU_cleanup_registry();
@@ -346,3 +351,24 @@ static void test_slurp_file_filter(void)
 
 	semanage_list_destroy(&data);
 }
+
+static void test_semanage_basename(void)
+{
+	char *basename1 = semanage_basename("/foo/bar");
+	CU_ASSERT_STRING_EQUAL(basename1, "bar");
+
+	char *basename2 = semanage_basename("/foo/bar/");
+	CU_ASSERT_STRING_EQUAL(basename2, "");
+
+	char *basename3 = semanage_basename("/foo.bar");
+	CU_ASSERT_STRING_EQUAL(basename3, "foo.bar");
+
+	char *basename5 = semanage_basename(".");
+	CU_ASSERT_STRING_EQUAL(basename5, ".");
+
+	char *basename6 = semanage_basename("");
+	CU_ASSERT_STRING_EQUAL(basename6, "");
+
+	char *basename7 = semanage_basename("/");
+	CU_ASSERT_STRING_EQUAL(basename7, "");
+}
-- 
2.48.1

