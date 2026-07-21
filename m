Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5727810F1
	for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 02:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784599935; cv=none; b=QtHhKtYrc7JX3Wo1P5mmObJ2lSZ1XEofR0R55UH7Y/SGipkCjPNtncWe9k6jqx3YPUgG1YQHxLWS6vQ3/mrI5rB/BWyQrpQoUFtsTBBtW7qnHlqmuP/jpH+kw6d6Oo/olnMdmyzdsh8aBcmtaCUfQfbcEZw32Rdzj3O6gYqnUbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784599935; c=relaxed/simple;
	bh=AbSGRwqMdQoBUZXbiDs2OAwFyKFg/0tI0kJrmjyfcdc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qOT42GKUSWlLgpkENn3A0nwYwkGPaVWaZsJ3+KQInUv+cwg/jXOGk95Z9anQYw2lcOAcMenAweCZypWc/4LTpgOqLdgWtjwGJwm3YYFFdGF6DuR6xe4xrEUomE9wr1pniO+eeO5pLa4uGn6A+LQb+0uHzZ0eeuEm+COHR3h9fdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S2i7RZGx; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S2i7RZGx"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c9667280edeso12384248a12.2
        for <selinux@vger.kernel.org>; Mon, 20 Jul 2026 19:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784599933; x=1785204733; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/LL0t8F43dAAm3MQu1CO0LPcvAmiGPJkS23Nhtd+EMo=;
        b=S2i7RZGxQc/JPSX+DOHTg746XzbR0tbywsDM0hvATM0Bv5wWo26O0o1CTFEWQ0UARA
         +5IRaGSl9EkLu0NAxgfeOtBLdjqjy+yFHUtpwNsVVwkPwvpvAwnl27V8R73BwnVUM93V
         3WU8kM0hF+qWqUQqEkDV8VC1lTNDwjJIUGWB+y+X3SEU4urAQVXSTBjkT1ZXW/qkKyft
         5un4xFAwdUdL1PNBCiPuLm/oE+MO2/FTDsERscaS2eucPMto74P+48bvVt4/gmHL7vYS
         2LYBfahm/xUNupTPuv3XD4KCH9RMRQft1IIDSlYvYNNbUXUxPOKlwvaOhA8v7oxXVVQc
         0K7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784599933; x=1785204733;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/LL0t8F43dAAm3MQu1CO0LPcvAmiGPJkS23Nhtd+EMo=;
        b=ARoZQw/rL5uODZ7mz0ytwxNb3ZDA0wsPgBqHFSnywIE5hIS+no9phCvZ6ZztpkhObK
         8m/I6HQ8MtPVqQQCm2yJSX+Vi+mWNGfWxglO+bPIx/wAnLpkkVsJUUjbs65mY9nNPoUY
         sKrQ71yJrFC924IhxPSKe5bDmhqaS34YtGmf2uPNUM6YKof/Nszk5xYsrYbCuJG4a+gC
         l2MQ4PUfooaJsrjvQNI0/tOktlr/hT9m1k0eC2QSvLukzxTW2jhFawfa5P9PKJUz8ssm
         uYxpcVoruqB1jrUanzXe+G+KUnsZSMtCKCGc1R3TafhjPJN0vNMkOUIpHG4TO3bTA7mt
         HYOw==
X-Gm-Message-State: AOJu0YwIpvaYMkFUQ0aYs7it/EWSO31gDxHvMfSzRewsGkpJvIIBJshA
	9twOs3vYj5LydrGpvEx6EmUvtOFM7DoOBsqHxuX/4M2wPwhpT39cWW32i3fTCqLE+XOFnDag2vX
	fSlDWZr93uApybS3HhSptq95NsiFba7lYyzR57dRuBfr3wb6d+3gBOS5krzWUi25dABHDbDnCIE
	jj0A2eRKMWUf0Gwu5rkJC9EtjrK6CKZFH4
X-Received: from pghd1.prod.google.com ([2002:a63:fd01:0:b0:c8a:5a4f:560f])
 (user=tweek job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3983:b0:3bc:5284:4859
 with SMTP id adf61e73a8af0-3c3ad5ae896mr17232472637.13.1784599932329; Mon, 20
 Jul 2026 19:12:12 -0700 (PDT)
Date: Tue, 21 Jul 2026 12:11:56 +1000
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260721021157.1314051-1-tweek@google.com>
Subject: [PATCH testsuite 1/2] tests/file_contexts: refactor existing tests
From: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
To: selinux@vger.kernel.org
Cc: James Carter <jwcart2@gmail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	"=?UTF-8?q?Christian=20G=C3=B6ttsche?=" <cgzones@googlemail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	"=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Change the logging format when reporting an error to better capture the
location and context of the error.

Split tests into functions to better isolate the tested behaviour.

Format tests using clang-format.

Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
---
 tests/file_contexts/internal.c       | 16 ++---
 tests/file_contexts/internal.h       | 20 +++++-
 tests/file_contexts/test_lookup.c    | 49 ++++++++-------
 tests/file_contexts/test_open.c      | 92 ++++++++++++++++------------
 tests/file_contexts/test_open_base.c | 33 +++++-----
 tests/file_contexts/test_validate.c  | 37 ++++++-----
 6 files changed, 148 insertions(+), 99 deletions(-)

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
index 9a54d1d..49bb18b 100644
--- a/tests/file_contexts/test_lookup.c
+++ b/tests/file_contexts/test_lookup.c
@@ -9,38 +9,45 @@
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
-	};
-
-	hnd =3D selabel_open(SELABEL_CTX_FILE, f2_opts, ARRAY_SIZE(f2_opts));
+	asprintf(&path, "%s/f2.fc", basedir);
+	struct selinux_opt f2_opts[] =3D { { .type =3D SELABEL_OPT_PATH,
+					   .value =3D path } };
=20
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
+		{ .path =3D "/base",
+		  .context =3D "system_u:object_r:test_base_t:s0" },
+		{ .path =3D "/base/unkown",
+		  .context =3D "system_u:object_r:test_base_wildcard_t:s0" },
+		{ .path =3D "/base/sub",
+		  .context =3D "system_u:object_r:test_base_sub_t:s0" },
+		{ .path =3D "/base/file.list",
+		  .context =3D "system_u:object_r:test_file_list_t:s0" },
+		{ .path =3D "/base/file_list",
+		  .context =3D "system_u:object_r:test_base_wildcard_t:s0" },
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
index eae5691..6bf046d 100644
--- a/tests/file_contexts/test_open.c
+++ b/tests/file_contexts/test_open.c
@@ -1,6 +1,5 @@
 #include <stdio.h>
 #include <stdlib.h>
-#include <string.h>
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <unistd.h>
@@ -8,75 +7,90 @@
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
+		SELABEL_CTX_FILE, /* options=3D */ NULL, /* nopt=3D */ 0);
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
-
-		if (!hnd) {
-			perror("file_context:no_options");
-			exit(2);
-		}
-		selabel_close(hnd);
+void test_null_path(void)
+{
+	struct stat default_stat;
+	if (stat(selinux_file_context_path(), &default_stat))
+		return;
=20
-		/* Default options */
-		struct selinux_opt null_opts[] =3D {
-			{ .type =3D SELABEL_OPT_PATH, .value =3D NULL }
-		};
+	/* Default options */
+	struct selinux_opt null_opts[] =3D { { .type =3D SELABEL_OPT_PATH,
+					     .value =3D NULL } };
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
-	};
+	asprintf(&path, "%s/f1.fc", basedir);
+	struct selinux_opt f1_opts[] =3D { { .type =3D SELABEL_OPT_PATH,
+					   .value =3D path } };
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
index 33b0cac..620b0a5 100644
--- a/tests/file_contexts/test_open_base.c
+++ b/tests/file_contexts/test_open_base.c
@@ -22,26 +22,29 @@ void test_default_options(const char *basedir)
=20
 	char *path;
 	asprintf(&path, "%s/f3.fc", basedir);
-	struct selinux_opt f3_opts[] =3D {
-		{ .type =3D SELABEL_OPT_PATH, .value =3D path }
-	};
+	struct selinux_opt f3_opts[] =3D { { .type =3D SELABEL_OPT_PATH,
+					   .value =3D path } };
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
+		{ .path =3D "/local",
+		  .context =3D "system_u:object_r:test_local:s0" },
+		{ .path =3D "/homedirs",
+		  .context =3D "system_u:object_r:test_homedirs:s0" },
+		{ .path =3D "/sub",
+		  .context =3D "system_u:object_r:test_subbed:s0" },
+		{ .path =3D "/sub_dist",
+		  .context =3D "system_u:object_r:test_subbed:s0" },
 	};
-	assertContextsMatch(hnd, tests, ARRAY_SIZE(tests));
+	assertContextsMatch(hnd, __func__, tests, ARRAY_SIZE(tests));
=20
 	selabel_close(hnd);
 }
@@ -62,7 +65,7 @@ void test_base_only_option(const char *basedir)
 	free(path);
=20
 	if (!hnd) {
-		perror("file_context:f3_base_only_options");
+		log_errno("Unable to open file backend");
 		exit(2);
 	}
=20
@@ -70,10 +73,12 @@ void test_base_only_option(const char *basedir)
 		{ .path =3D "/", .context =3D "system_u:object_r:rootfs:s0" },
 		{ .path =3D "/local", .context =3D NULL },
 		{ .path =3D "/homedirs", .context =3D NULL },
-		{ .path =3D "/sub", .context =3D "system_u:object_r:test_subbed:s0" },
-		{ .path =3D "/sub_dist", .context =3D "system_u:object_r:test_subbed:s0"=
 },
+		{ .path =3D "/sub",
+		  .context =3D "system_u:object_r:test_subbed:s0" },
+		{ .path =3D "/sub_dist",
+		  .context =3D "system_u:object_r:test_subbed:s0" },
 	};
-	assertContextsMatch(hnd, tests, ARRAY_SIZE(tests));
+	assertContextsMatch(hnd, __func__, tests, ARRAY_SIZE(tests));
=20
 	selabel_close(hnd);
 }
@@ -81,7 +86,7 @@ void test_base_only_option(const char *basedir)
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

