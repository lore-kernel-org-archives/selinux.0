Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F34E3A8734
	for <selinux@vger.kernel.org>; Mon, 27 Jul 2026 02:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785120743; cv=none; b=vDnMoUPNtt0ap+carwRLoyP08ypzo08nvAhE0NUpkh+DtY9vDEpiNXTTLs78wWmB6jTxDi93ErLs/m3EbA8JonjQaRvwQ3MbMhAeGDtE722HBmL/WZ8LLvqSxGVdzPRSFN/yjJwhamgUGr6IlLMprFRT92TMMuVnkc/FLm33LuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785120743; c=relaxed/simple;
	bh=L68AH2jEV9zVCWMpm+l0sVQ+DwUAQgGQE27L0I41qiw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=U4632xGs8HuYWKLJj5thDrpDbfQDvKZDx7m9HHrH/R093DZCZ7Ib0jLH+4yxVU24IcS+0i7JxC7qWjJfP+nKRyPh7xbKnaVvGiazJKqeqn/Dw84EGjC5rKjhny38QtK4M7OzrBXEUWnUS2eLncY/lZT+q3dCi8EjguBDvZHRP6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mXwXskok; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mXwXskok"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cfca8558d2so32546525ad.2
        for <selinux@vger.kernel.org>; Sun, 26 Jul 2026 19:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785120738; x=1785725538; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=W+9Eq9UX1BVglsHIK4ZIEkZ4sULusG99H4qlxmKKf5s=;
        b=mXwXskokHlDNUpdmAHcDouz9jO5mPcReJrLLDWpxUBqetDDo5sIQ5d/003ENx7ZNE3
         kYJuM+yPa2sEWIHCtukbX8nj84WSoUacuU9CcUkX3kHrCa7V9vbuTALfuHhw+yBHHHqq
         1HjIRVrYgYNu66fdEhWi77QvvgzAy8GXRlZtt+F7lfmQzJslKxxGeYrxT9VBHZWzheXc
         doJXP4r9+8y6uDQSpQO5Tf0yv2nKOz87yildmcc3HoTM9hbCyB8sxa6JTgvAruWUEthD
         ocpFSudyWL0fc8UCX9GIeStxIcGYCZ9w/UJ+4DxENPlrqHmWgogqS4Xlh8iEc14hr/6w
         sVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785120738; x=1785725538;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W+9Eq9UX1BVglsHIK4ZIEkZ4sULusG99H4qlxmKKf5s=;
        b=Zp3/UgWhLP2NsYy+d8pJ2y3F3BwNIUGZEhiUDD91Xv5zvfAqDZIr3lOmcFlWp7+xCG
         KUdXe5HW0af9y1hKO9515+ukwrG9miS/Mmkc4icHV5kMb1TwwQx6FqJZAOHKnmiSoKPG
         hocPFGRYrlZEWRgW3N//+Fk2n4/3lpRRN2z9M8jEDcrL55QAiLpiGv7ycE4miYvjl2Sq
         KvLIqP04YbGkTBwm4RZRiErDQ1DrPqNNTF0sqPZphxARXmaT19kJfEGB1uPZOKC74aO8
         KUv7xmbGTZV887T7IqMgziYioUXXZ4IxJyciHGhFt6n7Fm+De2xgojFnLoIroWesyDP1
         zDMw==
X-Gm-Message-State: AOJu0Yx3Z6cwYBRGCawsH++lUUvBtWHpVEGaPkK6qpgDU9huSdnfrlQ+
	m3B4Ws+aSX20hImh1EIgm46YYXHafyyFjHy81DP5gH7ItYDds0Pzy4g2VDeMNg2FbjNfo2E6ylv
	4HDLVSZnY46ADjb0q0scC66h2vYJFUXBakCK3AbQtO2FLc0XUR6yGffmckgfzPRSrpLDY/9K+hn
	KYZfVfHO58dRqhKSyVAl/oGiknBC71HK0V
X-Received: from pjbbj3.prod.google.com ([2002:a17:90b:883:b0:38e:b8e0:d97d])
 (user=tweek job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:58a7:b0:38f:5869:387a
 with SMTP id 98e67ed59e1d1-38f58693b44mr354003a91.8.1785120737590; Sun, 26
 Jul 2026 19:52:17 -0700 (PDT)
Date: Mon, 27 Jul 2026 12:52:13 +1000
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260727025214.2534071-1-tweek@google.com>
Subject: [PATCH testsuite v3 1/2] tests/file_contexts: refactor existing tests
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
Changes since v2:
- Call test functions in test_validate.c

 tests/file_contexts/internal.c       | 16 ++---
 tests/file_contexts/internal.h       | 20 +++++-
 tests/file_contexts/test_lookup.c    | 60 ++++++++++++------
 tests/file_contexts/test_open.c      | 94 +++++++++++++++++-----------
 tests/file_contexts/test_open_base.c | 46 ++++++++++----
 tests/file_contexts/test_validate.c  | 40 +++++++-----
 6 files changed, 181 insertions(+), 95 deletions(-)

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
index 8abefed..4d9e920 100644
--- a/tests/file_contexts/test_validate.c
+++ b/tests/file_contexts/test_validate.c
@@ -1,6 +1,5 @@
 #include <stdio.h>
 #include <stdlib.h>
-#include <string.h>
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <unistd.h>
@@ -10,47 +9,58 @@
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
+
+	test_validate_unknown_fails(argv[1]);
+	test_validate_known_succeeds(argv[1]);
=20
 	return 0;
 }
--=20
2.55.0.229.g6434b31f56-goog

