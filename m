Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D6F10F1
	for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 02:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784599940; cv=none; b=Tnh3+1Ry1NA/AXl/eVWK96eFhizy8KUr7/hFVp/3pnwtw73ZepnFHwc9he6rdxWtE1hx3Oh2ZZMVlTYOaVhaNTWGwmrrvTwYgqioyBSuMqsudV2oogwIL4GKJbcV08j/nY9yMhBsTFs3xsGZs0iPhHSvSOfEo/Ae7MH7SCPWWyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784599940; c=relaxed/simple;
	bh=SyAQAcoZOiGdeKHhULsG3p+acl+C4zloYwZGcGTcqCk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rJqyVAjvAZux3htUuHUMkl63VYY37Ykt2DEPSAJG2h42ldsgmy+JQDRrri9eytk2/2HBlghbnF8pRNo4gunzLlsNuhZn8bovbAdGQOF71kCOj+LJ6ehRETdFM0+GLSg1h3v8RmkLa9TQWFAwPQMD6iyc5HmDSHwugwA18swDphE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DFkT43wO; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DFkT43wO"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cc73f47bdcso199125785ad.3
        for <selinux@vger.kernel.org>; Mon, 20 Jul 2026 19:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784599938; x=1785204738; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CYoELBlsTKrhKJ89xRo0JcqWCxCQXV0EshtpBrc4YcQ=;
        b=DFkT43wO4cHPNH5nMebrN+QG2erpCzUOSM1FkLl5WBIwK82VFLjE6Mt7kbRFX0oPNv
         Us3d0kyvIeQ8CAMIdeqSRXwao7Wcg3m5mnXA81l2G8f6GHgGwHWv2AqZGDwFIYZVE8Nh
         dHr/BzXuP0WeoDKsjXu+tfJOSFrfdyITVfvhxkmdfEN0NnK5X+L63vZ7FoO6Oibc/PzX
         XgePASfJqfazmI7wbj8Rc67m7CDGKi998xO/FSKEvbgjqHwZoNUPOEaJhtvVg6QbZGdK
         EhiIU8R7dJ5v+xSw8qSLhobVBJ3pOPEfWhJKQKDY/uoexJuQl4VTMVUrNstdgZQcp/YR
         KXBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784599938; x=1785204738;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CYoELBlsTKrhKJ89xRo0JcqWCxCQXV0EshtpBrc4YcQ=;
        b=g1UkL8/x7sYRajfLZwhc/vPkLpFTafHs1nS9FiRFX0Lg9j9u2cHd+MSzKVshBmbADt
         W1Ie0QgA/Iz1RurRuzHm8aTkl+RnVlhfhER17OliiY0NMyqK+cz2GbZ1iKqydgtP3yi6
         N9O3GoRenIwq0g+G2Pj9+uY4aJORbl+oBlR79UdIzpc5dO/PJLX5RQp04KlPHxEJDy9d
         GMnpDZ0groBDNM8QM+BeWmixdOejucdZLKqCy1ELhzrwHNMPua9KHjCYvgBYmA3idQ9D
         mG1PP8ewAAWSjCGPnxnbj6kaQXWLZlS87FG5aBnAATRVYQhUH2wDci63eQDM2EuxQvm3
         t5/g==
X-Gm-Message-State: AOJu0YyBVFJxN3lJR44CeptCDdIRpoIrcKTW4kLwg5ol/ckHlOofLIwg
	LqorAFJst9ZyUk8/zmLTLEluSjQlCAlOvDtyo2ljTtfxQTkmPrnvmplKku9RaJop17XZspaAQe6
	2zUxgLfprQmwoOrvOq5iUy85SsWQLRMLbHJvCrjUVAwyhl0YgduyrccqGCdndYL+oDn2rvDMvkK
	Q4sZFc0TPKZ4WVWS8R2390PEXoc2Jk/OwP
X-Received: from plgb1.prod.google.com ([2002:a17:902:d501:b0:2cc:7044:4346])
 (user=tweek job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d588:b0:2c9:e86e:a9f5
 with SMTP id d9443c01a7336-2cf348669c4mr193030005ad.18.1784599937678; Mon, 20
 Jul 2026 19:12:17 -0700 (PDT)
Date: Tue, 21 Jul 2026 12:11:57 +1000
In-Reply-To: <20260721021157.1314051-1-tweek@google.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260721021157.1314051-1-tweek@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260721021157.1314051-2-tweek@google.com>
Subject: [PATCH testsuite 2/2] tests/file_contexts: add tests for multiple SELABEL_OPT_PATH
From: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
To: selinux@vger.kernel.org
Cc: James Carter <jwcart2@gmail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
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
- Verifies identical contexts across multiple paths validate successfully.
- Verifies conflicting contexts across multiple paths fail validation.
- Verifies extra files (.subs, .local, .homedirs) are processed only for
  the primary path.
- Verifies context lookups when providing three distinct
  SELABEL_OPT_PATH options.

Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
---
 tests/file_contexts/Makefile        |   2 +-
 tests/file_contexts/f2_conflict.fc  |   1 +
 tests/file_contexts/f2_same.fc      |   1 +
 tests/file_contexts/test            |   5 +-
 tests/file_contexts/test_multiple.c | 241 ++++++++++++++++++++++++++++
 5 files changed, 248 insertions(+), 2 deletions(-)
 create mode 100644 tests/file_contexts/f2_conflict.fc
 create mode 100644 tests/file_contexts/f2_same.fc
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
diff --git a/tests/file_contexts/f2_conflict.fc b/tests/file_contexts/f2_co=
nflict.fc
new file mode 100644
index 0000000..8cc388a
--- /dev/null
+++ b/tests/file_contexts/f2_conflict.fc
@@ -0,0 +1 @@
+/base             system_u:object_r:test_file_list:s0
diff --git a/tests/file_contexts/f2_same.fc b/tests/file_contexts/f2_same.f=
c
new file mode 100644
index 0000000..61a994f
--- /dev/null
+++ b/tests/file_contexts/f2_same.fc
@@ -0,0 +1 @@
+/base             system_u:object_r:test_base_t:s0
diff --git a/tests/file_contexts/test b/tests/file_contexts/test
index 1534925..cd7849b 100755
--- a/tests/file_contexts/test
+++ b/tests/file_contexts/test
@@ -5,7 +5,7 @@
=20
 use Test;
=20
-BEGIN { plan tests =3D> 4; }
+BEGIN { plan tests =3D> 5; }
=20
 $basedir =3D $0;
 $basedir =3D~ s|(.*)/[^/]*|$1|;
@@ -22,4 +22,7 @@ ok( $result, 0 );
 $result =3D system "$basedir/test_validate $basedir 2>&1";
 ok( $result, 0 );
=20
+$result =3D system "$basedir/test_multiple $basedir 2>&1";
+ok( $result, 0 );
+
 exit;
diff --git a/tests/file_contexts/test_multiple.c b/tests/file_contexts/test=
_multiple.c
new file mode 100644
index 0000000..d64c5c4
--- /dev/null
+++ b/tests/file_contexts/test_multiple.c
@@ -0,0 +1,241 @@
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
+		{ .path =3D "/base",
+		  .context =3D "system_u:object_r:test_base_t:s0" },
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
+void test_multiple_same_spec_validation(const char *basedir)
+{
+	struct selabel_handle *hnd;
+
+	/* f2.fc and f2_same.fc contain identical specs for /base. A warning will=
 be emitted, but no failure is expected */
+	char *f2_path, *same_path;
+	asprintf(&f2_path, "%s/f2.fc", basedir);
+	asprintf(&same_path, "%s/f2_same.fc", basedir);
+	struct selinux_opt opts[] =3D {
+		{ .type =3D SELABEL_OPT_PATH, .value =3D f2_path },
+		{ .type =3D SELABEL_OPT_PATH, .value =3D same_path },
+		{ .type =3D SELABEL_OPT_VALIDATE, .value =3D "1" }
+	};
+
+	hnd =3D selabel_open(SELABEL_CTX_FILE, opts, ARRAY_SIZE(opts));
+	free(f2_path);
+	free(same_path);
+
+	if (!hnd) {
+		log_errno("Unable to open file backend");
+		exit(2);
+	}
+
+	struct test_t tests[] =3D {
+		{ .path =3D "/base",
+		  .context =3D "system_u:object_r:test_base_t:s0" },
+	};
+	assertContextsMatch(hnd, __func__, tests, ARRAY_SIZE(tests));
+
+	selabel_close(hnd);
+}
+
+void test_multiple_different_spec_validation(const char *basedir)
+{
+	struct selabel_handle *hnd;
+
+	/* f2.fc and f2_conflict.fc contain conflicting contexts for /base */
+	char *f2_path, *conflict_path;
+	asprintf(&f2_path, "%s/f2.fc", basedir);
+	asprintf(&conflict_path, "%s/f2_conflict.fc", basedir);
+	struct selinux_opt opts[] =3D {
+		{ .type =3D SELABEL_OPT_PATH, .value =3D f2_path },
+		{ .type =3D SELABEL_OPT_PATH, .value =3D conflict_path },
+		{ .type =3D SELABEL_OPT_VALIDATE, .value =3D "1" }
+	};
+
+	hnd =3D selabel_open(SELABEL_CTX_FILE, opts, ARRAY_SIZE(opts));
+	free(f2_path);
+	free(conflict_path);
+
+	if (hnd) {
+		log_err("Validation of f2 and f2_conflict should have failed");
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
+		{ .path =3D "/sub",
+		  .context =3D "system_u:object_r:test_subbed:s0" },
+		{ .path =3D "/local",
+		  .context =3D "system_u:object_r:test_local:s0" },
+		{ .path =3D "/homedirs",
+		  .context =3D "system_u:object_r:test_homedirs:s0" },
+		{ .path =3D "/base",
+		  .context =3D "system_u:object_r:test_base_t:s0" },
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
+		{ .path =3D "/base",
+		  .context =3D "system_u:object_r:test_base_t:s0" },
+		{ .path =3D "/", .context =3D "system_u:object_r:rootfs:s0" },
+		{ .path =3D "/subbed",
+		  .context =3D "system_u:object_r:test_subbed:s0" },
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
+		{ .path =3D "/base",
+		  .context =3D "system_u:object_r:test_base_t:s0" },
+		{ .path =3D "/subbed",
+		  .context =3D "system_u:object_r:test_subbed:s0" },
+	};
+	assertContextsMatch(hnd, __func__, tests, ARRAY_SIZE(tests));
+	selabel_close(hnd);
+}
+
+int main(int argc, char **argv)
+{
+	if (argc !=3D 2) {
+		log_err("basedir not provided");
+		exit(1);
+	}
+
+	test_multiple_no_validation(argv[1]);
+	test_multiple_with_validation(argv[1]);
+	test_multiple_same_spec_validation(argv[1]);
+	test_multiple_different_spec_validation(argv[1]);
+	test_multiple_with_extras(argv[1]);
+	test_multiple_three_paths(argv[1]);
+
+	return 0;
+}
--=20
2.55.0.229.g6434b31f56-goog

