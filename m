Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F423AA4E8
	for <selinux@vger.kernel.org>; Mon, 27 Jul 2026 02:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785120745; cv=none; b=nWT8Nxe9eVyfRqHFeSmj/eQdct0ZHT4IrXR38d3wGMhrh1JN/E5MWncN5WWqEgUD6jHyjts0itRSkzy2Hnr0qfWxR2Dal1GtQGNf2o5AfkBPXajmIBfpHATooMxcHdTI0gCEZq3IKeqYV6ll8UllLRhqhpWbvQS+rHymOefyziA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785120745; c=relaxed/simple;
	bh=gd0+ROBJzkD+d0LOXwBdEbgEIh3XOQW9TvlV1e2EuMw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hT8g5gtOtdqBX2tNvghyLwJN4vzjRbBNPHC9WaS+K6C4z6nwORZwYVSxfDki8vhzH/NwDPWJLZfZ5sckQ03cnz6Ym8Mu8qQuxhoegwXwzBXzXpRcUL7kucHOrlBQbgd6L6LP+I5SHNZIXY+MN7m3zHTm9ke2e686yoxltGVzkZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YzKnCkHW; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YzKnCkHW"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-ca860baea9fso5140036a12.2
        for <selinux@vger.kernel.org>; Sun, 26 Jul 2026 19:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785120740; x=1785725540; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gKyGzP+nK++w2HciQhO9d75A/1VViFoW3Qh6+tFEzLo=;
        b=YzKnCkHW+grKy6vhiZIb9MAQh1L9ylzC3jjRWU5aBJgW/3venDI0t2oeaGiLo8iV/w
         T/mjkICFqBMCEx/6O8Ix+vaaLca2Rb9cyw+ONtHV7j/dBQ6FcK8ncTjMnSdEdcUdrvfb
         QkaV1lYnNEOTeScqQHDicd6PvIawwPZP9/0BlguFkeNDiUXB+b4LZDhmy7Ht5LmC4s77
         RubgguWuYrdO456194ALH+npIBKN2c1DIdjWelfeWmdogM5DJtr2T5O/Rm+HRpF+a6PE
         hK3UYo6kJZiP5TD8T/J6oAn9mgMvbBdN0MaY2Fa55xSQSLYfsTDjraj/HHkuw5ozMdN5
         jOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785120740; x=1785725540;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gKyGzP+nK++w2HciQhO9d75A/1VViFoW3Qh6+tFEzLo=;
        b=BsvoDW6g6hXhfWk+khLjWU8TUnWPaoDPVs/CG4Lv/77gkN2MVg3d8GoE5YWv7hSf9U
         I9L73LPwZ9pB7JWP2nEkKVdTP/PxCGk0xsDi9/Ol0quzEcWKpkSv5YpAPfUEdF+LWBSM
         zcVM9/UX20fpQ5RUl5rqiX/o6qt0cyDvVG275dD978MeQ0AMm3vUIZKGe4XrLFvqevxR
         B3Hvw3Mf6sngVilyLEPHRansHgb3f2fElymizUUvvcJiOdwN5nICUfeXfo/Bd0ohy644
         jhNVlwVWUd8mQYNEVST1F5C9GGCvYqfqztCWE/U176Q0s+umzcSwW/s/XLbynMrNvOxj
         jPdg==
X-Gm-Message-State: AOJu0YziIFhntEl28nEmk8xEMmNqpVERDNcJjPeJ9gNobOUfUv1O5Cpg
	/NpFiplrgyVXjpn4URSGuJLHo0Ga6xAxt+/1kzG4GRS3EYsBMIkal4WnokcupxQjsBBCBFXG3zs
	eXrqLqtZGGB69xsq4la2dD2fam+JuTqyAZCgzfUWe8JZPMlgQmD4NanVvBKWseD3jdtJTkSvePy
	h1O5dI7ULU7jfwMhs+U8FGn5FzbEkjzGzw
X-Received: from pgch9.prod.google.com ([2002:a05:6a02:5089:b0:c94:9604:c8da])
 (user=tweek job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:d50b:b0:3c0:9c1b:d0bf
 with SMTP id adf61e73a8af0-3c67e0b1d30mr6593869637.74.1785120740152; Sun, 26
 Jul 2026 19:52:20 -0700 (PDT)
Date: Mon, 27 Jul 2026 12:52:14 +1000
In-Reply-To: <20260727025214.2534071-1-tweek@google.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260727025214.2534071-1-tweek@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260727025214.2534071-2-tweek@google.com>
Subject: [PATCH testsuite v3 2/2] tests/file_contexts: add tests for multiple SELABEL_OPT_PATH
From: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
To: selinux@vger.kernel.org, Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: James Carter <jwcart2@gmail.com>, 
	"=?UTF-8?q?Christian=20G=C3=B6ttsche?=" <cgzones@googlemail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	"=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Add unit tests in test_multiple.c to exercise opening the file contexts
backend with multiple SELABEL_OPT_PATH options under various validation
and path configuration scenarios.

The following test functions were added:
- Verifies opening multiple file contexts without validation.
- Verifies validation failure when contexts contain undefined types.
- Verifies extra files (.subs, .local, .homedirs) are processed only for
  the primary path.
- Verifies multiple files with the same definition, no error is raised.
- Verifies context lookups when providing three distinct
  SELABEL_OPT_PATH options.

These tests are skipped if libselinux does not support that feature.

Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
---
Changes since v2:
- Add subcommand "check" to skip test_multiple when not supported by
  libselinux.

 tests/file_contexts/Makefile        |   2 +-
 tests/file_contexts/test            |  35 +++-
 tests/file_contexts/test_multiple.c | 275 ++++++++++++++++++++++++++++
 3 files changed, 301 insertions(+), 11 deletions(-)
 create mode 100644 tests/file_contexts/test_multiple.c

diff --git a/tests/file_contexts/Makefile b/tests/file_contexts/Makefile
index 592a65f..083ef25 100644
--- a/tests/file_contexts/Makefile
+++ b/tests/file_contexts/Makefile
@@ -1,4 +1,4 @@
-TARGETS=3Dtest_open test_lookup test_open_base test_validate
+TARGETS=3Dtest_open test_lookup test_open_base test_validate test_multiple
 CFLAGS +=3D -O2 -Werror -Wall
 LDLIBS +=3D -lselinux
=20
diff --git a/tests/file_contexts/test b/tests/file_contexts/test
index 1534925..6d97597 100755
--- a/tests/file_contexts/test
+++ b/tests/file_contexts/test
@@ -3,23 +3,38 @@
 # This test validates the parsing of file_contexts.
 #
=20
-use Test;
-
-BEGIN { plan tests =3D> 4; }
-
-$basedir =3D $0;
-$basedir =3D~ s|(.*)/[^/]*|$1|;
+use Test::More;
+
+BEGIN {
+    $basedir =3D $0;
+    $basedir =3D~ s|(.*)/[^/]*|$1|;
+
+    $test_multiple =3D 0;
+    $result        =3D system "$basedir/test_multiple $basedir check 2>/de=
v/null";
+    if ( $result eq 0 ) {
+        $test_multiple =3D 1;
+        plan tests =3D> 5;
+    }
+    else {
+        plan tests =3D> 4;
+    }
+}
=20
 $result =3D system "$basedir/test_open $basedir 2>&1";
-ok( $result, 0 );
+ok( $result eq 0 );
=20
 $result =3D system "$basedir/test_lookup $basedir 2>&1";
-ok( $result, 0 );
+ok( $result eq 0 );
=20
 $result =3D system "$basedir/test_open_base $basedir 2>&1";
-ok( $result, 0 );
+ok( $result eq 0 );
=20
 $result =3D system "$basedir/test_validate $basedir 2>&1";
-ok( $result, 0 );
+ok( $result eq 0 );
+
+if ($test_multiple) {
+    $result =3D system "$basedir/test_multiple $basedir 2>&1";
+    ok( $result eq 0 );
+}
=20
 exit;
diff --git a/tests/file_contexts/test_multiple.c b/tests/file_contexts/test=
_multiple.c
new file mode 100644
index 0000000..88b4cc8
--- /dev/null
+++ b/tests/file_contexts/test_multiple.c
@@ -0,0 +1,275 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+#include <selinux/label.h>
+#include <selinux/selinux.h>
+
+#include "internal.h"
+
+void test_multiple_no_validation(const char *basedir)
+{
+	struct selabel_handle *hnd;
+
+	/* f1.fc and f2.fc file */
+	char *f1_path, *f2_path;
+	asprintf(&f1_path, "%s/f1.fc", basedir);
+	asprintf(&f2_path, "%s/f2.fc", basedir);
+	struct selinux_opt opts[] =3D {
+		{ .type =3D SELABEL_OPT_PATH, .value =3D f1_path },
+		{ .type =3D SELABEL_OPT_PATH, .value =3D f2_path }
+	};
+
+	hnd =3D selabel_open(SELABEL_CTX_FILE, opts, ARRAY_SIZE(opts));
+	free(f1_path);
+	free(f2_path);
+
+	if (!hnd) {
+		log_errno("Unable to open file backend");
+		exit(2);
+	}
+
+	struct test_t tests[] =3D {
+		{ .path =3D "/", .context =3D "system_u:object_r:rootfs:s0" },
+		{
+			.path =3D "/base",
+			.context =3D "system_u:object_r:test_base_t:s0"
+		},
+	};
+	assertContextsMatch(hnd, __func__, tests, ARRAY_SIZE(tests));
+
+	selabel_close(hnd);
+}
+
+void test_multiple_with_validation(const char *basedir)
+{
+	struct selabel_handle *hnd;
+
+	/* f1.fc and f2.fc file - f1 has undefined type rootfs in test policy */
+	char *f1_path, *f2_path;
+	asprintf(&f1_path, "%s/f1.fc", basedir);
+	asprintf(&f2_path, "%s/f2.fc", basedir);
+	struct selinux_opt opts[] =3D {
+		{ .type =3D SELABEL_OPT_PATH, .value =3D f1_path },
+		{ .type =3D SELABEL_OPT_PATH, .value =3D f2_path },
+		{ .type =3D SELABEL_OPT_VALIDATE, .value =3D "1" }
+	};
+
+	hnd =3D selabel_open(SELABEL_CTX_FILE, opts, ARRAY_SIZE(opts));
+	free(f1_path);
+	free(f2_path);
+
+	if (hnd) {
+		log_err("Validation of f1 and f2 should have failed");
+		selabel_close(hnd);
+		exit(2);
+	}
+}
+
+void test_multiple_with_extras(const char *basedir)
+{
+	struct selabel_handle *hnd;
+	char *f2_path, *f3_path;
+	asprintf(&f2_path, "%s/f2.fc", basedir);
+	asprintf(&f3_path, "%s/f3.fc", basedir);
+
+	/* 1. f3.fc is the first path: extras (.subs, .local, .homedirs) of f3 AR=
E processed */
+	struct selinux_opt opts_f3_first[] =3D {
+		{ .type =3D SELABEL_OPT_PATH, .value =3D f3_path },
+		{ .type =3D SELABEL_OPT_PATH, .value =3D f2_path }
+	};
+	hnd =3D selabel_open(SELABEL_CTX_FILE, opts_f3_first,
+			   ARRAY_SIZE(opts_f3_first));
+	if (!hnd) {
+		log_errno("Unable to open file backend");
+		exit(2);
+	}
+
+	struct test_t tests_f3_first[] =3D {
+		{ .path =3D "/", .context =3D "system_u:object_r:rootfs:s0" },
+		{
+			.path =3D "/sub",
+			.context =3D "system_u:object_r:test_subbed:s0"
+		},
+		{
+			.path =3D "/local",
+			.context =3D "system_u:object_r:test_local:s0"
+		},
+		{
+			.path =3D "/homedirs",
+			.context =3D "system_u:object_r:test_homedirs:s0"
+		},
+		{
+			.path =3D "/base",
+			.context =3D "system_u:object_r:test_base_t:s0"
+		},
+	};
+	assertContextsMatch(hnd, __func__, tests_f3_first,
+			    ARRAY_SIZE(tests_f3_first));
+	selabel_close(hnd);
+
+	/* 2. f2.fc is the first path, f3.fc is second: extras from f3 are NOT pr=
ocessed */
+	struct selinux_opt opts_f2_first[] =3D {
+		{ .type =3D SELABEL_OPT_PATH, .value =3D f2_path },
+		{ .type =3D SELABEL_OPT_PATH, .value =3D f3_path }
+	};
+	hnd =3D selabel_open(SELABEL_CTX_FILE, opts_f2_first,
+			   ARRAY_SIZE(opts_f2_first));
+	if (!hnd) {
+		log_errno("Unable to open file backend");
+		exit(2);
+	}
+
+	struct test_t tests_f2_first[] =3D {
+		{
+			.path =3D "/base",
+			.context =3D "system_u:object_r:test_base_t:s0"
+		},
+		{ .path =3D "/", .context =3D "system_u:object_r:rootfs:s0" },
+		{
+			.path =3D "/subbed",
+			.context =3D "system_u:object_r:test_subbed:s0"
+		},
+		/* /sub, /local, /homedirs should NOT match the f3 extra contexts */
+		{ .path =3D "/sub", .context =3D NULL },
+		{ .path =3D "/local", .context =3D NULL },
+		{ .path =3D "/homedirs", .context =3D NULL },
+	};
+	assertContextsMatch(hnd, __func__, tests_f2_first,
+			    ARRAY_SIZE(tests_f2_first));
+	selabel_close(hnd);
+
+	free(f2_path);
+	free(f3_path);
+}
+
+void test_multiple_three_paths(const char *basedir)
+{
+	struct selabel_handle *hnd;
+	char *f1_path, *f2_path, *f3_path;
+	asprintf(&f1_path, "%s/f1.fc", basedir);
+	asprintf(&f2_path, "%s/f2.fc", basedir);
+	asprintf(&f3_path, "%s/f3.fc", basedir);
+
+	struct selinux_opt opts[] =3D {
+		{ .type =3D SELABEL_OPT_PATH, .value =3D f1_path },
+		{ .type =3D SELABEL_OPT_PATH, .value =3D f2_path },
+		{ .type =3D SELABEL_OPT_PATH, .value =3D f3_path }
+	};
+
+	hnd =3D selabel_open(SELABEL_CTX_FILE, opts, ARRAY_SIZE(opts));
+	free(f1_path);
+	free(f2_path);
+	free(f3_path);
+
+	if (!hnd) {
+		log_errno("Unable to open file backend");
+		exit(2);
+	}
+
+	struct test_t tests[] =3D {
+		{ .path =3D "/", .context =3D "system_u:object_r:rootfs:s0" },
+		{
+			.path =3D "/base",
+			.context =3D "system_u:object_r:test_base_t:s0"
+		},
+		{
+			.path =3D "/subbed",
+			.context =3D "system_u:object_r:test_subbed:s0"
+		},
+	};
+	assertContextsMatch(hnd, __func__, tests, ARRAY_SIZE(tests));
+	selabel_close(hnd);
+}
+
+void test_multiple_duplicate_validation(const char *basedir)
+{
+	struct selabel_handle *hnd;
+
+	/* Two copies of f2.fc to provide duplicate specifications */
+	char *f2_path;
+	asprintf(&f2_path, "%s/f2.fc", basedir);
+	struct selinux_opt opts[] =3D {
+		{ .type =3D SELABEL_OPT_PATH, .value =3D f2_path },
+		{ .type =3D SELABEL_OPT_PATH, .value =3D f2_path },
+		{ .type =3D SELABEL_OPT_VALIDATE, .value =3D "1" }
+	};
+
+	hnd =3D selabel_open(SELABEL_CTX_FILE, opts, ARRAY_SIZE(opts));
+	free(f2_path);
+
+	if (!hnd) {
+		log_errno("Unable to open file backend");
+		exit(2);
+	}
+
+	struct test_t tests[] =3D {
+		{
+			.path =3D "/base",
+			.context =3D "system_u:object_r:test_base_t:s0"
+		},
+	};
+	assertContextsMatch(hnd, __func__, tests, ARRAY_SIZE(tests));
+
+	selabel_close(hnd);
+}
+
+/* Check if multiple paths are supported. Returns 0 if they are; 1 otherwi=
se */
+static int check_multiple_path_support(const char *basedir)
+{
+	struct selabel_handle *hnd;
+	char *f1_path, *f2_path;
+	char *context1 =3D NULL, *context2 =3D NULL;
+	bool supported =3D false;
+
+	asprintf(&f1_path, "%s/f1.fc", basedir);
+	asprintf(&f2_path, "%s/f2.fc", basedir);
+
+	struct selinux_opt opts[] =3D {
+		{ .type =3D SELABEL_OPT_PATH, .value =3D f1_path },
+		{ .type =3D SELABEL_OPT_PATH, .value =3D f2_path }
+	};
+
+	hnd =3D selabel_open(SELABEL_CTX_FILE, opts, ARRAY_SIZE(opts));
+	free(f1_path);
+	free(f2_path);
+
+	if (!hnd) {
+		/* On older libselinux releases, the second file_context would
+		 * be ignored but selabel_open should not fail. */
+		log_err("Unable to open file backend");
+		exit(2);
+	}
+
+	if (selabel_lookup(hnd, &context1, "/", S_IFREG) =3D=3D 0 &&
+	    selabel_lookup(hnd, &context2, "/base", S_IFREG) =3D=3D 0) {
+		supported =3D true;
+	}
+
+	free(context1);
+	free(context2);
+	selabel_close(hnd);
+	return supported ? 0 : 1;
+}
+
+int main(int argc, char **argv)
+{
+	if (argc < 2 || argc > 3) {
+		log_err("usage: %s <basedir> [check]", argv[0]);
+		exit(1);
+	}
+
+	if (argc =3D=3D 3 && strcmp(argv[2], "check") =3D=3D 0) {
+		return check_multiple_path_support(argv[1]);
+	}
+
+	test_multiple_no_validation(argv[1]);
+	test_multiple_with_validation(argv[1]);
+	test_multiple_duplicate_validation(argv[1]);
+	test_multiple_with_extras(argv[1]);
+	test_multiple_three_paths(argv[1]);
+
+	return 0;
+}
--=20
2.55.0.229.g6434b31f56-goog

