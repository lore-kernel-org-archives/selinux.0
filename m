Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4E5303A18
	for <selinux@vger.kernel.org>; Tue, 10 Mar 2026 01:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773107713; cv=none; b=Zws4IXfCIwhmNl/mLfK06fYlBzGrBrssk+8ZOP+KEnDv67oKtvtmpb2G/O3faoSN5VZL8oIW9S5Z24QVfk08EGluXh+eOScPR+RTZ5VmVfMgAcDtEFYT/KToaC9uDx2tEq3ILDbeAsGJ8Bf1F243Ssvf2ExUlT6gXgausMX/B+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773107713; c=relaxed/simple;
	bh=n6dkxvgnNQw19HnbZvy2PRtBnBGQ5adEXgGHBER1hs0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nTLlgU9ItkPgLwZ8bZ3YFzIkUqFGP4US2D6ba6FIKoar3Ff7m7TkKDzyMy3H3y79M79thzAVORBLyQCA+Thb3mV0z/MQVgVz25UEu0IFbQoGiG3ZDsWQwzbITkJrghatC9vqbpPUZpdiuILk9HLV91S7gvpGuHmhQkeF3iqivT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yTBFZgOH; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yTBFZgOH"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c738662b963so3478373a12.0
        for <selinux@vger.kernel.org>; Mon, 09 Mar 2026 18:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773107706; x=1773712506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VmrS/WCqsOsYbR/mhEwjI+rSEHSa3cBWLgjuR1fKT1w=;
        b=yTBFZgOHD9oIWozvn2ITJkhWi9K4cx8StuygehrBfL8NvkQKH+FUP951piBQBuY1rK
         t61PhNVFgwMh8DsWUGyvbZvaVsjMJgl7bLxZf4Ira+u3PjrJkSTE3hZZkDRp903V6L7J
         MJevIUJdB6knvmTEl8dR7wtaWzJOYj1Yd9UyRa/KzW8gnCviBcfKB77A8UGTeyZJNZOK
         NdgR3wTJl25jixJEjHD6NGVLo43VcjsOonW5jZxbyrkO9FPl4EcKkNDiL1m1iK5c3kZ4
         NG3SvzCiTSNuLKYA4m2MoFL+OgOJz61hPgihFAe13rdifLh7fT+gHcXE6o7tmUTslZEp
         QyFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773107706; x=1773712506;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VmrS/WCqsOsYbR/mhEwjI+rSEHSa3cBWLgjuR1fKT1w=;
        b=vVNVJ6nWsGmhmRJ1ZhsyeBy1GVzLqyS1ckcbj3GvgZM5v8WemqUIoacZs3shXcRcMM
         +mjG9Zm3dgawENoPnTEseN5Q8clwtjZP3rUQcQGgm/tY2YWgEI7wInjvlytwpC9N1NJX
         1xUZeP5eFrFfV/8R6hFvTXGBHso3eXkbypm7kjw4eIB2KbyqZlp5g3l6Uoli0KtoI9DU
         mrmzjXLE70JZzQ7uElICmaoCOJ6cH6YYbm90GZKGm97TcDwyXy+dH6GvsPL6GzKiFDbb
         opNYqrl/ql9miQ0HRO1AldU5SaOQTuDaNuqfzr1a35vDMuiz1IUJpn/V7nb2z9YQuMul
         THnw==
X-Gm-Message-State: AOJu0Yxygc8pX/UFZeYMazsHKAmEsXq/dRtryeRLz8YS1Wox0zu/fI4M
	Ulj4vjF7RtrcbHDz3yq1Jzbw+qvrSL+CvfjPZQAzvC/TFKAAs6uiDQ/r2U5OehH1keQ4+EX9YBx
	TQRNM3RKSkAqBU+Fzv1jGKy1ClWgSOyoMwRuAmhDjDVphXNMw6g6JSXlNUEVtuC772E5RveNtte
	ChKh4lYNBRF+B2KifUgAjHgGHZ5IdCRCfs
X-Received: from pfll9.prod.google.com ([2002:a05:6a00:1589:b0:829:8a2d:1907])
 (user=tweek job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1783:b0:829:822e:cdce
 with SMTP id d2e1a72fcca58-829a2d8ac70mr12449777b3a.6.1773107705330; Mon, 09
 Mar 2026 18:55:05 -0700 (PDT)
Date: Tue, 10 Mar 2026 12:54:53 +1100
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260310015453.1978412-1-tweek@google.com>
Subject: [PATCH testsuite v2] Add tests for selabel_file backend
From: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
To: selinux@vger.kernel.org
Cc: "=?UTF-8?q?Christian=20G=C3=B6ttsche?=" <cgzones@googlemail.com>, James Carter <jwcart2@gmail.com>, 
	Paul Moore <paul@paul-moore.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Jeffrey Vander Stoep <jeffv@google.com>, 
	"=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Add basic set of tests to validate the behaviour of the selabel_file
backend. The parsing and usage of file_contexts is confirmed, in the
following scenarios:

 - selabel_open with no options,
 - selabel_open with a NULL SELABEL_OPT_PATH,
 - selabel_open with a valid SELABEL_OPT_PATH,
 - selabel_open with a valid SELABEL_OPT_PATH and SELABEL_OPT_BASEONLY,
 - selabel_open with SELABEL_OPT_VALIDATE and known types,
 - selabel_open with SELABEL_OPT_VALIDATE and unknown types.

Validate that substitutions and local customizations are loaded
according to selabel_file(5).

Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
---
Changes since v1:
- Redirect stderr to stdout in test

 policy/Makefile                      |  3 +-
 policy/test_file_contexts.te         |  6 ++
 tests/Makefile                       |  2 +-
 tests/file_contexts/Makefile         | 10 +++
 tests/file_contexts/f1.fc            |  1 +
 tests/file_contexts/f2.fc            |  4 ++
 tests/file_contexts/f3.fc            |  2 +
 tests/file_contexts/f3.fc.homedirs   |  1 +
 tests/file_contexts/f3.fc.local      |  1 +
 tests/file_contexts/f3.fc.subs       |  1 +
 tests/file_contexts/f3.fc.subs_dist  |  1 +
 tests/file_contexts/internal.c       | 41 +++++++++++++
 tests/file_contexts/internal.h       | 16 +++++
 tests/file_contexts/test             | 25 ++++++++
 tests/file_contexts/test_lookup.c    | 46 ++++++++++++++
 tests/file_contexts/test_open.c      | 82 +++++++++++++++++++++++++
 tests/file_contexts/test_open_base.c | 92 ++++++++++++++++++++++++++++
 tests/file_contexts/test_validate.c  | 56 +++++++++++++++++
 18 files changed, 388 insertions(+), 2 deletions(-)
 create mode 100644 policy/test_file_contexts.te
 create mode 100644 tests/file_contexts/Makefile
 create mode 100644 tests/file_contexts/f1.fc
 create mode 100644 tests/file_contexts/f2.fc
 create mode 100644 tests/file_contexts/f3.fc
 create mode 100644 tests/file_contexts/f3.fc.homedirs
 create mode 100644 tests/file_contexts/f3.fc.local
 create mode 100644 tests/file_contexts/f3.fc.subs
 create mode 100644 tests/file_contexts/f3.fc.subs_dist
 create mode 100644 tests/file_contexts/internal.c
 create mode 100644 tests/file_contexts/internal.h
 create mode 100755 tests/file_contexts/test
 create mode 100644 tests/file_contexts/test_lookup.c
 create mode 100644 tests/file_contexts/test_open.c
 create mode 100644 tests/file_contexts/test_open_base.c
 create mode 100644 tests/file_contexts/test_validate.c

diff --git a/policy/Makefile b/policy/Makefile
index 40bf393..bf1ea76 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -29,7 +29,8 @@ TARGETS =3D \
 	test_task_getsid.te test_task_setpgid.te test_task_setsched.te \
 	test_transition.te test_unix_socket.te \
 	test_mmap.te test_overlayfs.te test_mqueue.te \
-	test_ibpkey.te test_atsecure.te test_cgroupfs.te
+	test_ibpkey.te test_atsecure.te test_cgroupfs.te \
+	test_file_contexts.te
=20
 ifeq (x$(DISTRO),$(filter x$(DISTRO),xRHEL4 xRHEL5 xRHEL6))
 SUPPORTS_CIL =3D n
diff --git a/policy/test_file_contexts.te b/policy/test_file_contexts.te
new file mode 100644
index 0000000..c61f3b1
--- /dev/null
+++ b/policy/test_file_contexts.te
@@ -0,0 +1,6 @@
+####### Policy for testing file_contexts #########
+
+type test_base_t;
+type test_base_wildcard_t;
+type test_base_sub_t;
+type test_file_list_t;
diff --git a/tests/Makefile b/tests/Makefile
index 6df220c..07403be 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -28,7 +28,7 @@ SUBDIRS:=3D domain_trans entrypoint execshare exectrace e=
xecute_no_trans \
 	task_getpgid task_setpgid file ioctl capable_file capable_net \
 	capable_sys dyntrans dyntrace bounds nnp_nosuid mmap unix_socket \
 	inet_socket/tcp inet_socket/udp overlay checkreqprot mqueue \
-	mac_admin atsecure infiniband_endport infiniband_pkey
+	mac_admin atsecure infiniband_endport infiniband_pkey file_contexts
=20
 ifeq ($(shell grep -q cap_userns $(POLDEV)/include/support/all_perms.spt &=
& echo true),true)
 ifneq ($(shell ./kvercmp $$(uname -r) 4.7),-1)
diff --git a/tests/file_contexts/Makefile b/tests/file_contexts/Makefile
new file mode 100644
index 0000000..592a65f
--- /dev/null
+++ b/tests/file_contexts/Makefile
@@ -0,0 +1,10 @@
+TARGETS=3Dtest_open test_lookup test_open_base test_validate
+CFLAGS +=3D -O2 -Werror -Wall
+LDLIBS +=3D -lselinux
+
+all: $(TARGETS)
+
+$(TARGETS): internal.o
+
+clean:
+	rm -f $(TARGETS) *.o
diff --git a/tests/file_contexts/f1.fc b/tests/file_contexts/f1.fc
new file mode 100644
index 0000000..6672a49
--- /dev/null
+++ b/tests/file_contexts/f1.fc
@@ -0,0 +1 @@
+/       system_u:object_r:rootfs:s0
diff --git a/tests/file_contexts/f2.fc b/tests/file_contexts/f2.fc
new file mode 100644
index 0000000..0d8c087
--- /dev/null
+++ b/tests/file_contexts/f2.fc
@@ -0,0 +1,4 @@
+/base             system_u:object_r:test_base_t:s0
+/base(/.*)?       system_u:object_r:test_base_wildcard_t:s0
+/base/sub         system_u:object_r:test_base_sub_t:s0
+/base/file\.list  system_u:object_r:test_file_list_t:s0
diff --git a/tests/file_contexts/f3.fc b/tests/file_contexts/f3.fc
new file mode 100644
index 0000000..a7361cd
--- /dev/null
+++ b/tests/file_contexts/f3.fc
@@ -0,0 +1,2 @@
+/        system_u:object_r:rootfs:s0
+/subbed  system_u:object_r:test_subbed:s0
diff --git a/tests/file_contexts/f3.fc.homedirs b/tests/file_contexts/f3.fc=
.homedirs
new file mode 100644
index 0000000..d1878ce
--- /dev/null
+++ b/tests/file_contexts/f3.fc.homedirs
@@ -0,0 +1 @@
+/homedirs  system_u:object_r:test_homedirs:s0
diff --git a/tests/file_contexts/f3.fc.local b/tests/file_contexts/f3.fc.lo=
cal
new file mode 100644
index 0000000..96e432b
--- /dev/null
+++ b/tests/file_contexts/f3.fc.local
@@ -0,0 +1 @@
+/local    system_u:object_r:test_local:s0
diff --git a/tests/file_contexts/f3.fc.subs b/tests/file_contexts/f3.fc.sub=
s
new file mode 100644
index 0000000..922ed96
--- /dev/null
+++ b/tests/file_contexts/f3.fc.subs
@@ -0,0 +1 @@
+/sub /subbed
diff --git a/tests/file_contexts/f3.fc.subs_dist b/tests/file_contexts/f3.f=
c.subs_dist
new file mode 100644
index 0000000..abe31fe
--- /dev/null
+++ b/tests/file_contexts/f3.fc.subs_dist
@@ -0,0 +1 @@
+/sub_dist /subbed
diff --git a/tests/file_contexts/internal.c b/tests/file_contexts/internal.=
c
new file mode 100644
index 0000000..22b5790
--- /dev/null
+++ b/tests/file_contexts/internal.c
@@ -0,0 +1,41 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+#include <selinux/label.h>
+#include <selinux/selinux.h>
+
+#include "internal.h"
+
+void assertContextsMatch(struct selabel_handle *hnd, struct test_t *tests,
+			 size_t n)
+{
+	for (int i =3D 0; i < n; i++) {
+		char *context =3D NULL;
+		struct test_t test =3D tests[i];
+
+		if (selabel_lookup(hnd, &context, test.path, S_IFREG)) {
+			if (test.context) {
+				perror("file_contexts:selabel_lookup");
+				fprintf(stderr, "Lookup for %s failed\n", test.path);
+				exit(2);
+			}
+			// Expected failure. Continue to the next test.
+			continue;
+		} else if (!test.context) {
+			fprintf(stderr, "Lookup for %s was supposed to failed\n", test.path);
+			exit(2);
+		}
+
+		if (strcmp(context, tests[i].context)) {
+			fprintf(stderr, "Lookup for %s returned %s, expected %s\n",
+				tests[i].path, context, tests[i].context);
+			exit(2);
+		}
+
+		free(context);
+	}
+}
diff --git a/tests/file_contexts/internal.h b/tests/file_contexts/internal.=
h
new file mode 100644
index 0000000..a07548f
--- /dev/null
+++ b/tests/file_contexts/internal.h
@@ -0,0 +1,16 @@
+#include <selinux/label.h>
+#include <selinux/selinux.h>
+
+#define ARRAY_SIZE(a) (sizeof(a) / sizeof((a)[0]))
+
+/* Structure to capture a test. The |path| will be resolved and expected t=
o
+ * match the |context|. If |context| is NULL, the lookup is expected to fa=
il. */
+struct test_t {
+	const char *path;
+	const char *context;
+};
+
+/* Assert that all paths described in |tests| resolve appropriately. |hnd|=
 must
+ * be opened. |n| is the number of tests in |tests|. */
+void assertContextsMatch(struct selabel_handle *hnd, struct test_t *tests,
+			 size_t n);
diff --git a/tests/file_contexts/test b/tests/file_contexts/test
new file mode 100755
index 0000000..1534925
--- /dev/null
+++ b/tests/file_contexts/test
@@ -0,0 +1,25 @@
+#!/usr/bin/perl
+#
+# This test validates the parsing of file_contexts.
+#
+
+use Test;
+
+BEGIN { plan tests =3D> 4; }
+
+$basedir =3D $0;
+$basedir =3D~ s|(.*)/[^/]*|$1|;
+
+$result =3D system "$basedir/test_open $basedir 2>&1";
+ok( $result, 0 );
+
+$result =3D system "$basedir/test_lookup $basedir 2>&1";
+ok( $result, 0 );
+
+$result =3D system "$basedir/test_open_base $basedir 2>&1";
+ok( $result, 0 );
+
+$result =3D system "$basedir/test_validate $basedir 2>&1";
+ok( $result, 0 );
+
+exit;
diff --git a/tests/file_contexts/test_lookup.c b/tests/file_contexts/test_l=
ookup.c
new file mode 100644
index 0000000..9a54d1d
--- /dev/null
+++ b/tests/file_contexts/test_lookup.c
@@ -0,0 +1,46 @@
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
+int main(int argc, char **argv)
+{
+	struct selabel_handle *hnd;
+
+	if (argc !=3D 2) {
+		fprintf(stderr, "basedir not provided\n");
+		exit(1);
+	}
+
+	char *path;
+	asprintf(&path, "%s/f2.fc", argv[1]);
+	struct selinux_opt f2_opts[] =3D {
+		{ .type =3D SELABEL_OPT_PATH, .value =3D path }
+	};
+
+	hnd =3D selabel_open(SELABEL_CTX_FILE, f2_opts, ARRAY_SIZE(f2_opts));
+
+	free(path);
+
+	if (!hnd) {
+		perror("file_context:f2_options");
+		exit(2);
+	}
+
+	struct test_t tests[] =3D {
+		{ .path =3D "/base", .context =3D "system_u:object_r:test_base_t:s0" },
+		{ .path =3D "/base/unkown", .context =3D "system_u:object_r:test_base_wi=
ldcard_t:s0" },
+		{ .path =3D "/base/sub", .context =3D "system_u:object_r:test_base_sub_t=
:s0" },
+		{ .path =3D "/base/file.list", .context =3D "system_u:object_r:test_file=
_list_t:s0" },
+		{ .path =3D "/base/file_list", .context =3D "system_u:object_r:test_base=
_wildcard_t:s0" },
+	};
+	assertContextsMatch(hnd, tests, ARRAY_SIZE(tests));
+
+	return 0;
+}
diff --git a/tests/file_contexts/test_open.c b/tests/file_contexts/test_ope=
n.c
new file mode 100644
index 0000000..eae5691
--- /dev/null
+++ b/tests/file_contexts/test_open.c
@@ -0,0 +1,82 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+#include <selinux/label.h>
+#include <selinux/selinux.h>
+
+int main(int argc, char **argv)
+{
+	bool has_default_path =3D false;
+	struct selabel_handle *hnd;
+	struct stat default_stat;
+
+	if (argc !=3D 2) {
+		fprintf(stderr, "basedir not provided\n");
+		exit(1);
+	}
+
+	const char *default_path =3D selinux_file_context_path();
+	if (!stat(default_path, &default_stat)) {
+		has_default_path =3D true;
+	}
+
+	if (has_default_path) {
+		/* Empty options */
+		hnd =3D selabel_open(SELABEL_CTX_FILE, /* options=3D */ NULL, /* nopt=3D=
 */ 0);
+
+		if (!hnd) {
+			perror("file_context:no_options");
+			exit(2);
+		}
+		selabel_close(hnd);
+
+		/* Default options */
+		struct selinux_opt null_opts[] =3D {
+			{ .type =3D SELABEL_OPT_PATH, .value =3D NULL }
+		};
+
+		hnd =3D selabel_open(SELABEL_CTX_FILE, /* options=3D */ null_opts, /* no=
pt=3D */ 1);
+
+		if (!hnd) {
+			perror("file_context:default_options");
+			exit(2);
+		}
+		selabel_close(hnd);
+	}
+
+	/* f1.fc file */
+	char *path;
+	asprintf(&path, "%s/f1.fc", argv[1]);
+	struct selinux_opt f1_opts[] =3D {
+		{ .type =3D SELABEL_OPT_PATH, .value =3D path }
+	};
+
+	hnd =3D selabel_open(SELABEL_CTX_FILE, /* options=3D */ f1_opts, /* nopt=
=3D */ 1);
+	free(path);
+
+	if (!hnd) {
+		perror("file_context:f1_options");
+		exit(2);
+	}
+
+	char *context =3D NULL;
+	if (selabel_lookup(hnd, &context, "/", S_IFREG)) {
+		perror("file_contexts:f1_lookup");
+		exit(2);
+	}
+
+	if (strcmp(context, "system_u:object_r:rootfs:s0")) {
+		perror("file_contexts:f1_strcmp");
+		exit(2);
+	}
+
+	free(context);
+
+	selabel_close(hnd);
+
+	return 0;
+}
diff --git a/tests/file_contexts/test_open_base.c b/tests/file_contexts/tes=
t_open_base.c
new file mode 100644
index 0000000..33b0cac
--- /dev/null
+++ b/tests/file_contexts/test_open_base.c
@@ -0,0 +1,92 @@
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
+/*
+ * Validate the behaviour of the SELABEL_OPT_BASEONLY option. That is, if =
set,
+ * the .local and .homedirs part of the policy should not be loaded.
+ *
+ * Also validates the path substitutions (.subs and .subs_dist).
+ */
+
+void test_default_options(const char *basedir)
+{
+	struct selabel_handle *hnd;
+
+	char *path;
+	asprintf(&path, "%s/f3.fc", basedir);
+	struct selinux_opt f3_opts[] =3D {
+		{ .type =3D SELABEL_OPT_PATH, .value =3D path }
+	};
+
+	hnd =3D selabel_open(SELABEL_CTX_FILE, f3_opts, ARRAY_SIZE(f3_opts));
+	free(path);
+
+	if (!hnd) {
+		perror("file_context:f3_default_options");
+		exit(2);
+	}
+
+	struct test_t tests[] =3D {
+		{ .path =3D "/", .context =3D "system_u:object_r:rootfs:s0" },
+		{ .path =3D "/local", .context =3D "system_u:object_r:test_local:s0" },
+		{ .path =3D "/homedirs", .context =3D "system_u:object_r:test_homedirs:s=
0" },
+		{ .path =3D "/sub", .context =3D "system_u:object_r:test_subbed:s0" },
+		{ .path =3D "/sub_dist", .context =3D "system_u:object_r:test_subbed:s0"=
 },
+	};
+	assertContextsMatch(hnd, tests, ARRAY_SIZE(tests));
+
+	selabel_close(hnd);
+}
+
+void test_base_only_option(const char *basedir)
+{
+	struct selabel_handle *hnd;
+
+	char *path;
+	asprintf(&path, "%s/f3.fc", basedir);
+	struct selinux_opt f3_with_base_only_opts[] =3D {
+		{ .type =3D SELABEL_OPT_PATH, .value =3D path },
+		{ .type =3D SELABEL_OPT_BASEONLY, .value =3D "1" }
+	};
+
+	hnd =3D selabel_open(SELABEL_CTX_FILE, f3_with_base_only_opts,
+			   ARRAY_SIZE(f3_with_base_only_opts));
+	free(path);
+
+	if (!hnd) {
+		perror("file_context:f3_base_only_options");
+		exit(2);
+	}
+
+	struct test_t tests[] =3D {
+		{ .path =3D "/", .context =3D "system_u:object_r:rootfs:s0" },
+		{ .path =3D "/local", .context =3D NULL },
+		{ .path =3D "/homedirs", .context =3D NULL },
+		{ .path =3D "/sub", .context =3D "system_u:object_r:test_subbed:s0" },
+		{ .path =3D "/sub_dist", .context =3D "system_u:object_r:test_subbed:s0"=
 },
+	};
+	assertContextsMatch(hnd, tests, ARRAY_SIZE(tests));
+
+	selabel_close(hnd);
+}
+
+int main(int argc, char **argv)
+{
+	if (argc !=3D 2) {
+		fprintf(stderr, "basedir not provided\n");
+		exit(1);
+	}
+
+	test_default_options(argv[1]);
+	test_base_only_option(argv[1]);
+
+	return 0;
+}
diff --git a/tests/file_contexts/test_validate.c b/tests/file_contexts/test=
_validate.c
new file mode 100644
index 0000000..8abefed
--- /dev/null
+++ b/tests/file_contexts/test_validate.c
@@ -0,0 +1,56 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+#include <selinux/label.h>
+#include <selinux/selinux.h>
+
+#include "internal.h"
+
+int main(int argc, char **argv)
+{
+	char *path;
+	struct selabel_handle *hnd;
+
+	if (argc !=3D 2) {
+		fprintf(stderr, "basedir not provided\n");
+		exit(1);
+	}
+
+	asprintf(&path, "%s/f1.fc", argv[1]);
+	struct selinux_opt f1_opts[] =3D {
+		{ .type =3D SELABEL_OPT_PATH, .value =3D path },
+		{ .type =3D SELABEL_OPT_VALIDATE, .value =3D "1" }
+	};
+
+	/* f1 types are not defined in the test policy. */
+	hnd =3D selabel_open(SELABEL_CTX_FILE, f1_opts, ARRAY_SIZE(f1_opts));
+	free(path);
+
+	if (hnd) {
+		fprintf(stderr, "The validation of f1 should have failed.\n");
+		exit(2);
+	}
+
+	asprintf(&path, "%s/f2.fc", argv[1]);
+	struct selinux_opt f2_opts[] =3D {
+		{ .type =3D SELABEL_OPT_PATH, .value =3D path },
+		{ .type =3D SELABEL_OPT_VALIDATE, .value =3D "1" }
+	};
+
+	/* f2 types are defined in the test policy. */
+	hnd =3D selabel_open(SELABEL_CTX_FILE, f2_opts, ARRAY_SIZE(f2_opts));
+	free(path);
+
+	if (!hnd) {
+		perror("Unable to read valid file_contexts");
+		exit(2);
+	}
+
+	selabel_close(hnd);
+
+	return 0;
+}
--=20
2.53.0.473.g4a7958ca14-goog

