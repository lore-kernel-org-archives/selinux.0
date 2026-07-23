Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F244347BA7
	for <selinux@vger.kernel.org>; Thu, 23 Jul 2026 03:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784776411; cv=none; b=Oby7cHwmV+tAmBeqUNV7noF4oj0oHklnBcK+7lgYKGERrodyeENhbCH9bLN7Kt4A67s1rA4w/3IabdlzNM9H/eDEskQRw8x7YFod0qt9WNvuAkveE9JUi1z/jcQ88ehvbeJ1Gq58FWZUvvuT1MerkcGYu2Z9mxNMzEjjLGTbBKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784776411; c=relaxed/simple;
	bh=iE5beRI1bAmrgnSw+Ulveq8UumcXfiuvlnGHWndR2cs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tmLBch6lU1Rr8nmkjfeufSTMAtOL30TBYqUbRVbu8FfnReS3n55c2ZiivADOzefEbSjT7grEppcs4jNKmIiK+O1lD7QAnay3hu7LOSYze0IwfEncMUeHv5RITBmBjG+lYzHZMQGcH+drGeYFA7UAtL5o3gtbLrqkAMc6Ol1dmjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eBoRscyp; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eBoRscyp"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c856470fe9fso187125a12.2
        for <selinux@vger.kernel.org>; Wed, 22 Jul 2026 20:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784776408; x=1785381208; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=r3YG8qlq7fn6Y6iiz2hIvSAXoxr4XvTBoKztU6ZnyR4=;
        b=eBoRscypoCT/XO0cC7K5y9taH8sfsLXI+Z0RfM60UqP8b3X1QxLT7b8YESqfecgOEG
         LTvy+QioPQFB5eBRi0xLC/vQDmhP8ZwHNVcU1XLDdAkog0l3r58hdV0lp6hfo6T+xhXR
         bf5KAmMih9Pccy4khQDFnMYh+sifrkiFoOdPf/W4PFkXgGZ1bduzA6rWlx4/fWmZpvHa
         UsFEG341uYWDBq7qb56ZIS9MjL8G7dpUhnnnkOKQAWUYwzrUMTYHzLW5tCCweY/fUJKr
         YIX29MCzfqtmaIsMO2NTyjajTQoJT2O/xs0sv2vQdcFZKkL6VYc09yHTEMUztz1386wU
         yv6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784776408; x=1785381208;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=r3YG8qlq7fn6Y6iiz2hIvSAXoxr4XvTBoKztU6ZnyR4=;
        b=YC+nBiTdYTuQcS5xIQ42zTKnqiIs/vGgRyYbcCrtjDM/+kBrIMjIog4bret3J5Ui+j
         n4hHFHtQpEY+1YZuBKmh3TegjH7Uo+Pfy3EvihVjqoZqIcU7LliVu+S9qWpqohKwcu7C
         EWgFB4DgUc+DKx/RmlzqIP6C5JsDgVyPbFEo+ZN06+IYypoqpwywiSvwMw18im7S1y8A
         kKdN+k68tLbg85EBogA5p64GFX6X6jdR+e1kKuEl81rA++gEYRCvpU67aGyzGRmL6FSD
         wWmYUmn+Z9zkqHp9394RgvS0EgxczJgE0cWIXNmKL36SAmRvSWEg/DzUwCtl8ytAi5U2
         e/PA==
X-Gm-Message-State: AOJu0YzbRyx8Tj4pB05Nmd6ZpIQ4EURBWkzHDmBwFOmmX5Gm2XacULv1
	4K5ZMSKhFSUz2kRKwZtLtSbXKGy/zpjO1PiJMp4Uol86hPLNaJV/4s3n39YvZTRJnby8YFA+qJO
	PuuMWElwaDdHqeI5AtJYoA8MIsUBycqByo1WSDVR0a9fOX/pbx3dUODzVcgpz1ywkWimCOPyqE2
	mM/0CtBHWaoL2WKrBYcd8opyL2+8Je30JA
X-Received: from pflc16.prod.google.com ([2002:a05:6a00:ad0:b0:847:ac08:fdf6])
 (user=tweek job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:e0a:b0:845:31a6:d84d
 with SMTP id d2e1a72fcca58-84e2b7fc37bmr1702085b3a.7.1784776407965; Wed, 22
 Jul 2026 20:13:27 -0700 (PDT)
Date: Thu, 23 Jul 2026 13:13:15 +1000
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260723031316.2720083-1-tweek@google.com>
Subject: [PATCH testsuite v2 1/2] tests/file_contexts: refactor existing tests
From: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
To: selinux@vger.kernel.org, Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: James Carter <jwcart2@gmail.com>, 
	"=?UTF-8?q?Christian=20G=C3=B6ttsche?=" <cgzones@googlemail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	"=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Change the logging format when reporting an error to better capture the
location and context of the error.

Split tests into functions to better isolate the tested behaviour.

Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
---
 tests/file_contexts/internal.c       | 16 ++---
 tests/file_contexts/internal.h       | 20 +++++-
 tests/file_contexts/test_lookup.c    | 60 ++++++++++++------
 tests/file_contexts/test_open.c      | 94 +++++++++++++++++-----------
 tests/file_contexts/test_open_base.c | 46 ++++++++++----
 tests/file_contexts/test_validate.c  | 37 ++++++-----
 6 files changed, 178 insertions(+), 95 deletions(-)

diff --git a/tests/file_contexts/internal.c b/tests/file_contexts/internal.=
c
index 22b5790..ba45dd6 100644
--- a/tests/file_contexts/internal.c
+++ b/tests/file_contexts/internal.c
@@ -10,8 +10,8 @@
=20
 #include "internal.h"
=20
-void assertContextsMatch(struct selabel_handle *hnd, struct test_t *tests,
-			 size_t n)
+void assertContextsMatch(struct selabel_handle *hnd, const char *log_prefi=
x,
+			 struct test_t *tests, size_t n)
 {
 	for (int i =3D 0; i < n; i++) {
 		char *context =3D NULL;
@@ -19,20 +19,22 @@ void assertContextsMatch(struct selabel_handle *hnd, st=
ruct test_t *tests,
=20
 		if (selabel_lookup(hnd, &context, test.path, S_IFREG)) {
 			if (test.context) {
-				perror("file_contexts:selabel_lookup");
-				fprintf(stderr, "Lookup for %s failed\n", test.path);
+				log_errno("Lookup for %s from %s failed",
+					  test.path, log_prefix);
 				exit(2);
 			}
 			// Expected failure. Continue to the next test.
 			continue;
 		} else if (!test.context) {
-			fprintf(stderr, "Lookup for %s was supposed to failed\n", test.path);
+			log_err("Lookup for %s from %s was supposed to failed but got %s",
+				test.path, log_prefix, context);
 			exit(2);
 		}
=20
 		if (strcmp(context, tests[i].context)) {
-			fprintf(stderr, "Lookup for %s returned %s, expected %s\n",
-				tests[i].path, context, tests[i].context);
+			log_err("Lookup for %s from %s returned %s, expected %s",
+				tests[i].path, log_prefix, context,
+				tests[i].context);
 			exit(2);
 		}
=20
diff --git a/tests/file_contexts/internal.h b/tests/file_contexts/internal.=
h
index a07548f..c51bbc6 100644
--- a/tests/file_contexts/internal.h
+++ b/tests/file_contexts/internal.h
@@ -1,8 +1,21 @@
+#include <errno.h>
+#include <string.h>
+
 #include <selinux/label.h>
 #include <selinux/selinux.h>
=20
 #define ARRAY_SIZE(a) (sizeof(a) / sizeof((a)[0]))
=20
+/* Log an error message with the file name, function name and line */
+#define log_err(fmt, ...)                                                 =
   \
+	fprintf(stderr, "%s:%s:%d: " fmt "\n", __FILE__, __func__, __LINE__, \
+		##__VA_ARGS__)
+
+/* Log an error message as well as errno */
+#define log_errno(fmt, ...)                                            \
+	fprintf(stderr, "%s:%s:%d " fmt " (%s)\n", __FILE__, __func__, \
+		__LINE__, ##__VA_ARGS__, strerror(errno))
+
 /* Structure to capture a test. The |path| will be resolved and expected t=
o
  * match the |context|. If |context| is NULL, the lookup is expected to fa=
il. */
 struct test_t {
@@ -11,6 +24,7 @@ struct test_t {
 };
=20
 /* Assert that all paths described in |tests| resolve appropriately. |hnd|=
 must
- * be opened. |n| is the number of tests in |tests|. */
-void assertContextsMatch(struct selabel_handle *hnd, struct test_t *tests,
-			 size_t n);
+ * be opened. |n| is the number of tests in |tests|. |log_prefix| is added=
 to
+ * any log message */
+void assertContextsMatch(struct selabel_handle *hnd, const char *log_prefi=
x,
+			 struct test_t *tests, size_t n);
diff --git a/tests/file_contexts/test_lookup.c b/tests/file_contexts/test_l=
ookup.c
index 9a54d1d..5957db4 100644
--- a/tests/file_contexts/test_lookup.c
+++ b/tests/file_contexts/test_lookup.c
@@ -9,38 +9,58 @@
=20
 #include "internal.h"
=20
-int main(int argc, char **argv)
+void test_lookup(const char *basedir)
 {
-	struct selabel_handle *hnd;
-
-	if (argc !=3D 2) {
-		fprintf(stderr, "basedir not provided\n");
-		exit(1);
-	}
-
 	char *path;
-	asprintf(&path, "%s/f2.fc", argv[1]);
-	struct selinux_opt f2_opts[] =3D {
-		{ .type =3D SELABEL_OPT_PATH, .value =3D path }
+	asprintf(&path, "%s/f2.fc", basedir);
+	struct selinux_opt f2_opts[] =3D { {
+			.type =3D SELABEL_OPT_PATH,
+			.value =3D path
+		}
 	};
=20
-	hnd =3D selabel_open(SELABEL_CTX_FILE, f2_opts, ARRAY_SIZE(f2_opts));
-
+	struct selabel_handle *hnd =3D
+		selabel_open(SELABEL_CTX_FILE, f2_opts, ARRAY_SIZE(f2_opts));
 	free(path);
=20
 	if (!hnd) {
-		perror("file_context:f2_options");
+		log_errno("Unable to open file backend");
 		exit(2);
 	}
=20
 	struct test_t tests[] =3D {
-		{ .path =3D "/base", .context =3D "system_u:object_r:test_base_t:s0" },
-		{ .path =3D "/base/unkown", .context =3D "system_u:object_r:test_base_wi=
ldcard_t:s0" },
-		{ .path =3D "/base/sub", .context =3D "system_u:object_r:test_base_sub_t=
:s0" },
-		{ .path =3D "/base/file.list", .context =3D "system_u:object_r:test_file=
_list_t:s0" },
-		{ .path =3D "/base/file_list", .context =3D "system_u:object_r:test_base=
_wildcard_t:s0" },
+		{
+			.path =3D "/base",
+			.context =3D "system_u:object_r:test_base_t:s0"
+		},
+		{
+			.path =3D "/base/unkown",
+			.context =3D "system_u:object_r:test_base_wildcard_t:s0"
+		},
+		{
+			.path =3D "/base/sub",
+			.context =3D "system_u:object_r:test_base_sub_t:s0"
+		},
+		{
+			.path =3D "/base/file.list",
+			.context =3D "system_u:object_r:test_file_list_t:s0"
+		},
+		{
+			.path =3D "/base/file_list",
+			.context =3D "system_u:object_r:test_base_wildcard_t:s0"
+		},
 	};
-	assertContextsMatch(hnd, tests, ARRAY_SIZE(tests));
+	assertContextsMatch(hnd, __func__, tests, ARRAY_SIZE(tests));
+}
+
+int main(int argc, char **argv)
+{
+	if (argc !=3D 2) {
+		log_err("basedir not provided");
+		exit(1);
+	}
+
+	test_lookup(argv[1]);
=20
 	return 0;
 }
diff --git a/tests/file_contexts/test_open.c b/tests/file_contexts/test_ope=
n.c
index eae5691..4dd3300 100644
--- a/tests/file_contexts/test_open.c
+++ b/tests/file_contexts/test_open.c
@@ -1,6 +1,5 @@
 #include <stdio.h>
 #include <stdlib.h>
-#include <string.h>
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <unistd.h>
@@ -8,75 +7,96 @@
 #include <selinux/label.h>
 #include <selinux/selinux.h>
=20
-int main(int argc, char **argv)
+#include "internal.h"
+
+void test_no_options(void)
 {
-	bool has_default_path =3D false;
-	struct selabel_handle *hnd;
 	struct stat default_stat;
+	if (stat(selinux_file_context_path(), &default_stat))
+		return;
=20
-	if (argc !=3D 2) {
-		fprintf(stderr, "basedir not provided\n");
-		exit(1);
-	}
+	/* Empty options */
+	struct selabel_handle *hnd =3D selabel_open(
+					     SELABEL_CTX_FILE, /* options=3D */ NULL, /* nopt=3D */ 0);
=20
-	const char *default_path =3D selinux_file_context_path();
-	if (!stat(default_path, &default_stat)) {
-		has_default_path =3D true;
+	if (!hnd) {
+		log_errno("Unable to open default content file");
+		exit(2);
 	}
+	selabel_close(hnd);
+}
=20
-	if (has_default_path) {
-		/* Empty options */
-		hnd =3D selabel_open(SELABEL_CTX_FILE, /* options=3D */ NULL, /* nopt=3D=
 */ 0);
+void test_null_path(void)
+{
+	struct stat default_stat;
+	if (stat(selinux_file_context_path(), &default_stat))
+		return;
=20
-		if (!hnd) {
-			perror("file_context:no_options");
-			exit(2);
+	/* Default options */
+	struct selinux_opt null_opts[] =3D { {
+			.type =3D SELABEL_OPT_PATH,
+			.value =3D NULL
 		}
-		selabel_close(hnd);
-
-		/* Default options */
-		struct selinux_opt null_opts[] =3D {
-			{ .type =3D SELABEL_OPT_PATH, .value =3D NULL }
-		};
+	};
=20
-		hnd =3D selabel_open(SELABEL_CTX_FILE, /* options=3D */ null_opts, /* no=
pt=3D */ 1);
+	struct selabel_handle *hnd =3D selabel_open(SELABEL_CTX_FILE, null_opts,
+						  ARRAY_SIZE(null_opts));
=20
-		if (!hnd) {
-			perror("file_context:default_options");
-			exit(2);
-		}
-		selabel_close(hnd);
+	if (!hnd) {
+		log_errno("Unable to open default content file");
+		exit(2);
 	}
+	selabel_close(hnd);
+}
=20
+void test_valid_path(const char *basedir)
+{
 	/* f1.fc file */
 	char *path;
-	asprintf(&path, "%s/f1.fc", argv[1]);
-	struct selinux_opt f1_opts[] =3D {
-		{ .type =3D SELABEL_OPT_PATH, .value =3D path }
+	asprintf(&path, "%s/f1.fc", basedir);
+	struct selinux_opt f1_opts[] =3D { {
+			.type =3D SELABEL_OPT_PATH,
+			.value =3D path
+		}
 	};
=20
-	hnd =3D selabel_open(SELABEL_CTX_FILE, /* options=3D */ f1_opts, /* nopt=
=3D */ 1);
+	struct selabel_handle *hnd =3D
+		selabel_open(SELABEL_CTX_FILE, f1_opts, ARRAY_SIZE(f1_opts));
 	free(path);
=20
 	if (!hnd) {
-		perror("file_context:f1_options");
+		log_errno("Unable to open file backend");
 		exit(2);
 	}
=20
 	char *context =3D NULL;
 	if (selabel_lookup(hnd, &context, "/", S_IFREG)) {
-		perror("file_contexts:f1_lookup");
+		log_errno("Unable to lookup \"/\"");
 		exit(2);
 	}
=20
-	if (strcmp(context, "system_u:object_r:rootfs:s0")) {
-		perror("file_contexts:f1_strcmp");
+	const char *expected =3D "system_u:object_r:rootfs:s0";
+	if (strcmp(context, expected)) {
+		log_err("Incorrect context returned, expected %s got %s",
+			expected, context);
 		exit(2);
 	}
=20
 	free(context);
=20
 	selabel_close(hnd);
+}
+
+int main(int argc, char **argv)
+{
+	if (argc !=3D 2) {
+		log_err("basedir not provided");
+		exit(1);
+	}
+
+	test_no_options();
+	test_null_path();
+	test_valid_path(argv[1]);
=20
 	return 0;
 }
diff --git a/tests/file_contexts/test_open_base.c b/tests/file_contexts/tes=
t_open_base.c
index 33b0cac..3e4b4c6 100644
--- a/tests/file_contexts/test_open_base.c
+++ b/tests/file_contexts/test_open_base.c
@@ -22,26 +22,40 @@ void test_default_options(const char *basedir)
=20
 	char *path;
 	asprintf(&path, "%s/f3.fc", basedir);
-	struct selinux_opt f3_opts[] =3D {
-		{ .type =3D SELABEL_OPT_PATH, .value =3D path }
+	struct selinux_opt f3_opts[] =3D { {
+			.type =3D SELABEL_OPT_PATH,
+			.value =3D path
+		}
 	};
=20
 	hnd =3D selabel_open(SELABEL_CTX_FILE, f3_opts, ARRAY_SIZE(f3_opts));
 	free(path);
=20
 	if (!hnd) {
-		perror("file_context:f3_default_options");
+		log_errno("Unable to open file backend");
 		exit(2);
 	}
=20
 	struct test_t tests[] =3D {
 		{ .path =3D "/", .context =3D "system_u:object_r:rootfs:s0" },
-		{ .path =3D "/local", .context =3D "system_u:object_r:test_local:s0" },
-		{ .path =3D "/homedirs", .context =3D "system_u:object_r:test_homedirs:s=
0" },
-		{ .path =3D "/sub", .context =3D "system_u:object_r:test_subbed:s0" },
-		{ .path =3D "/sub_dist", .context =3D "system_u:object_r:test_subbed:s0"=
 },
+		{
+			.path =3D "/local",
+			.context =3D "system_u:object_r:test_local:s0"
+		},
+		{
+			.path =3D "/homedirs",
+			.context =3D "system_u:object_r:test_homedirs:s0"
+		},
+		{
+			.path =3D "/sub",
+			.context =3D "system_u:object_r:test_subbed:s0"
+		},
+		{
+			.path =3D "/sub_dist",
+			.context =3D "system_u:object_r:test_subbed:s0"
+		},
 	};
-	assertContextsMatch(hnd, tests, ARRAY_SIZE(tests));
+	assertContextsMatch(hnd, __func__, tests, ARRAY_SIZE(tests));
=20
 	selabel_close(hnd);
 }
@@ -62,7 +76,7 @@ void test_base_only_option(const char *basedir)
 	free(path);
=20
 	if (!hnd) {
-		perror("file_context:f3_base_only_options");
+		log_errno("Unable to open file backend");
 		exit(2);
 	}
=20
@@ -70,10 +84,16 @@ void test_base_only_option(const char *basedir)
 		{ .path =3D "/", .context =3D "system_u:object_r:rootfs:s0" },
 		{ .path =3D "/local", .context =3D NULL },
 		{ .path =3D "/homedirs", .context =3D NULL },
-		{ .path =3D "/sub", .context =3D "system_u:object_r:test_subbed:s0" },
-		{ .path =3D "/sub_dist", .context =3D "system_u:object_r:test_subbed:s0"=
 },
+		{
+			.path =3D "/sub",
+			.context =3D "system_u:object_r:test_subbed:s0"
+		},
+		{
+			.path =3D "/sub_dist",
+			.context =3D "system_u:object_r:test_subbed:s0"
+		},
 	};
-	assertContextsMatch(hnd, tests, ARRAY_SIZE(tests));
+	assertContextsMatch(hnd, __func__, tests, ARRAY_SIZE(tests));
=20
 	selabel_close(hnd);
 }
@@ -81,7 +101,7 @@ void test_base_only_option(const char *basedir)
 int main(int argc, char **argv)
 {
 	if (argc !=3D 2) {
-		fprintf(stderr, "basedir not provided\n");
+		log_err("basedir not provided");
 		exit(1);
 	}
=20
diff --git a/tests/file_contexts/test_validate.c b/tests/file_contexts/test=
_validate.c
index 8abefed..aa71c22 100644
--- a/tests/file_contexts/test_validate.c
+++ b/tests/file_contexts/test_validate.c
@@ -1,6 +1,5 @@
 #include <stdio.h>
 #include <stdlib.h>
-#include <string.h>
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <unistd.h>
@@ -10,47 +9,55 @@
=20
 #include "internal.h"
=20
-int main(int argc, char **argv)
+void test_validate_unknown_fails(const char *basedir)
 {
 	char *path;
-	struct selabel_handle *hnd;
-
-	if (argc !=3D 2) {
-		fprintf(stderr, "basedir not provided\n");
-		exit(1);
-	}
-
-	asprintf(&path, "%s/f1.fc", argv[1]);
+	asprintf(&path, "%s/f1.fc", basedir);
 	struct selinux_opt f1_opts[] =3D {
 		{ .type =3D SELABEL_OPT_PATH, .value =3D path },
 		{ .type =3D SELABEL_OPT_VALIDATE, .value =3D "1" }
 	};
=20
 	/* f1 types are not defined in the test policy. */
-	hnd =3D selabel_open(SELABEL_CTX_FILE, f1_opts, ARRAY_SIZE(f1_opts));
+	struct selabel_handle *hnd =3D
+		selabel_open(SELABEL_CTX_FILE, f1_opts, ARRAY_SIZE(f1_opts));
 	free(path);
=20
 	if (hnd) {
-		fprintf(stderr, "The validation of f1 should have failed.\n");
+		log_err("The validation of f1 should have failed");
+		selabel_close(hnd);
 		exit(2);
 	}
+}
=20
-	asprintf(&path, "%s/f2.fc", argv[1]);
+void test_validate_known_succeeds(const char *basedir)
+{
+	char *path;
+	asprintf(&path, "%s/f2.fc", basedir);
 	struct selinux_opt f2_opts[] =3D {
 		{ .type =3D SELABEL_OPT_PATH, .value =3D path },
 		{ .type =3D SELABEL_OPT_VALIDATE, .value =3D "1" }
 	};
=20
 	/* f2 types are defined in the test policy. */
-	hnd =3D selabel_open(SELABEL_CTX_FILE, f2_opts, ARRAY_SIZE(f2_opts));
+	struct selabel_handle *hnd =3D
+		selabel_open(SELABEL_CTX_FILE, f2_opts, ARRAY_SIZE(f2_opts));
 	free(path);
=20
 	if (!hnd) {
-		perror("Unable to read valid file_contexts");
+		log_errno("Unable to read valid file_contexts");
 		exit(2);
 	}
=20
 	selabel_close(hnd);
+}
+
+int main(int argc, char **argv)
+{
+	if (argc !=3D 2) {
+		log_err("basedir not provided");
+		exit(1);
+	}
=20
 	return 0;
 }
--=20
2.55.0.229.g6434b31f56-goog

