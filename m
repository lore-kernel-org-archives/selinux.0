Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FB5282F05
	for <selinux@vger.kernel.org>; Thu, 23 Jul 2026 03:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784776430; cv=none; b=s0B/uZprG8mBp5OMhNDunux0/ICcgP3b3bS3EjUDt0tit7yBtZb9MA+OwlICyHJEcbqfHwug3EV/WOwu66ptZgSejIEe8hiyL2cs3C7zlJS1GiMWRTjhFrzji/NieWWbvaMYh5uyu4M8wKNYIrXUZFjg2hECRUBWI7Oed6Sn5F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784776430; c=relaxed/simple;
	bh=olIlvGjfCyeH2+n8lc+PxVppfb+n3vxM9PFkRxcfSeY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iSXaefaBLa/4hMg5KdGj9tZYr9qh7Qfpx7we/LToCLngC8p09iV8XeqKNtPnta/+eldNWCZXG5B7Ql9Tjuq6x2pmErZgWJS82SjU6r4yoUD0BAbxlmBKoIyAFUxWQl4GZTRpfnAAe8ZwDoEI5H8KtmPShOzR3/J0UMFFAm6g23U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mglDmgcm; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mglDmgcm"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-381250979d5so223205a91.0
        for <selinux@vger.kernel.org>; Wed, 22 Jul 2026 20:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784776428; x=1785381228; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1kyA+HAt81BIQAhFsSMRhf+ju5gssRcc2EZaqlyT4WA=;
        b=mglDmgcmkL0hxljr7CgQurTHRV94yWoV55x+K/iplVCLjaJQQI5M1ScdcQymV13i4L
         3kAQ4ME+5jWpmKCSYitKhbaXIvkeJFpl2ay39pCnPwl4HzWP/yu+QjxqbzTm43WOrKzO
         JBUeHLG6Jeox7dv1RoO7Fc1jw1hDfTLg1vO1lOGHKmGYZKRfxusKmOCOzeW4WXNoRwbQ
         tShan9rZzcYnwfIK/8vbEV+XH8e1AqbAJ/nEkJh0i0YtA10RwzPOvpce/smUNUs9ZHsd
         I3ujFBKgbg0FaB3jZjG/88iE2AuMewiPaiisiTIo1+bcJpwI/fEbVFbUqIeezXzt3kWc
         7ZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784776428; x=1785381228;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1kyA+HAt81BIQAhFsSMRhf+ju5gssRcc2EZaqlyT4WA=;
        b=OiqjW3rEvFoY7e1oZsU6aYx6mbfpjI3uNNStZQMK0NvKBOhdZi6JSufUWEQaUwaLjG
         ylOsdkNL3siTvDfRvQZdxv/1PSMuTIQ4kLHdORTAiUs1wz3Fe2kQGOChkYw/nR2LZ5Fc
         0/a+4OKv+VO9koD2Sg+Y5e4idJB5g0b8pizF5clI5ukTPdJXJWKPAOZKQkiNbH6zORsi
         9wG6HPOSzPHyzHZ2B/ELvBE3yfNMGj1Y6XWSTv+rYvPwqXemZLLdvUd0w9M9UudFQ4W0
         Hr4AchvDxsBHOOMsfThBYEoZj9tjqSmwethAc2vyT5Du4fmDr9kezB7FcoEI5tpcvQXm
         ncrQ==
X-Gm-Message-State: AOJu0YyIiw9zrM6S4zoZlLy3npH6JlgR9atsUAHzWnH5mtmx7EqNxfWE
	bFzmpOnqseR2mW6ZCHtCTtZgOfyJXJF7sf/Btv5vRBoJFz7BN7YJFJwdBpVzyGfkCYq1/eyKEC2
	ALjdgy1Z9MwQjVFIID9Vla2j5X5OvDVCywhuEwe7/YTh3IJKC7AzWTQn7FXRKAHnft9ZyYVvJzy
	kwaXk6HkEifWZ/Ix58beaInSUonYm10UU2
X-Received: from pjyr15.prod.google.com ([2002:a17:90a:e18f:b0:38e:b851:fec5])
 (user=tweek job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c07:b0:38e:7168:281
 with SMTP id 98e67ed59e1d1-38ec64e2bd8mr1450604a91.10.1784776427801; Wed, 22
 Jul 2026 20:13:47 -0700 (PDT)
Date: Thu, 23 Jul 2026 13:13:16 +1000
In-Reply-To: <20260723031316.2720083-1-tweek@google.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260723031316.2720083-1-tweek@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260723031316.2720083-2-tweek@google.com>
Subject: [PATCH testsuite v2 2/2] tests/file_contexts: add tests for multiple SELABEL_OPT_PATH
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

Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
---
 tests/file_contexts/Makefile        |   2 +-
 tests/file_contexts/test            |   5 +-
 tests/file_contexts/test_multiple.c | 233 ++++++++++++++++++++++++++++
 3 files changed, 238 insertions(+), 2 deletions(-)
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
index 0000000..65fb726
--- /dev/null
+++ b/tests/file_contexts/test_multiple.c
@@ -0,0 +1,233 @@
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
+int main(int argc, char **argv)
+{
+	if (argc !=3D 2) {
+		log_err("basedir not provided");
+		exit(1);
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

