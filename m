Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDEA282F35
	for <selinux@vger.kernel.org>; Mon,  2 Mar 2026 23:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772493944; cv=none; b=JLpU76EDOPwpvjVduMw2T80RvtaEac1axbciiAu+6+ckiSllE8MErfWY2By0Idr4YSg7dsIBQbK64lpT02o1jsCNIouVYLYzPSZr340bImUfr02n2POoXXW/A4eKsaUz6XgM6VPnKhO2bkAISraO3rYKsBtQ01Hfh4jjArqOq4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772493944; c=relaxed/simple;
	bh=80Zd56D2wAPpLQevYHuU39EgENJb4zbWBzleXz/9PTQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=BhAhWGPS4LFHjFoHmMH+gqfjuRJpvQRcVppZx++d8Q4yHUdQyZlhef+iMvbZiTYMF0P6j4O5tBqhLyXd69RbRP7tnh2q3kH3R2/3okzxijz5SRQcCcDpmWKGCbVNsx/fJSv3RVj6hVS7zbCbXY1kEhAZh/fFImwpyoruFn8rqSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vZ1u4Y1C; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vZ1u4Y1C"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2adef9d486bso45228345ad.2
        for <selinux@vger.kernel.org>; Mon, 02 Mar 2026 15:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772493942; x=1773098742; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mvy5Z6sYzx19OO36u86AKgB5UQZlG/Ztb6kPEweMngo=;
        b=vZ1u4Y1CLjwT6Fl+qh+ajVudhEWa569Zs9CkxBAUkGIr2OpZRG7fcmOfimFNCrvObS
         7qycSgiGn8QfdIqwbraQxVOoy23dJjxhTrlXr/OWw+RChumTpRsCG4jro8PmzjMMcDub
         /JZdpM+SeFhQ52bOk7njMwCeID13h2Cf16A974WCPTWJ4ji6lzOU88ySndRFj8q66X3J
         pitgledDUJ1Y+7imQAdPIP2XGG9WtORJSdRvEZUWigO5qUj5S4GjN+HtrNTob3UOdCoN
         dKF5n4IpZ7PoQg4vR731yW4S9kZw8qRzMyyUu+09iuWrBYzqhyzS7rs/YmLD+GUQkDkC
         x+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772493942; x=1773098742;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mvy5Z6sYzx19OO36u86AKgB5UQZlG/Ztb6kPEweMngo=;
        b=aL1NJql+LPqXbTwnZ3lJYvTqxGdFo5uBlGrcUVNFUzHDlcdrpGsOvNkA1BSMJk7MRg
         Xqn2TAues+E9FC1k09QOI6e//b5Na8J3yiGd+h8EjQEL5OBq+sZoQwEZBfpx6C62uFz0
         XppS6pGHehk4oOvzk3U403EYaeP5l6jTX7ZFV9PXrr8qdjFCl4wxmv5leOl6+qrjj/lI
         DQnbwamDy1S47OR4XFAUHY7i0L5nsqu+OFVZREzeaumRUirR5DmGT5ePA1MzuuXZ5yp/
         3GF/qTu4sIZrroudXTtJPisTyHFceoXoKfIyNAjwv4Yvo34CXOhN/zpSTnrEn2yHXdqp
         qFrA==
X-Gm-Message-State: AOJu0YwcGQFZuiHFN3K5GB8ESZO8ypLWPMXq7KN2OqNYJI1OnnQaXwrj
	UfHO82Fg1g3rmfzN+/z0Gm1qQ5K0vcYb5QEBC0afuQjNHkVpn81a/HiBcCDkAHU3tQrO9pOfWc8
	W4fq9Stt4wgbZ1bVI8IMOcZ0xvtl+zhribORSJorsoIs4kUXlQAHwyHreNW4q2zHcNxkPPgu9ck
	L7WYWhPSejo9zc9Fv+rVvjDzdoDLwrLKj+
X-Received: from pldb18.prod.google.com ([2002:a17:902:ed12:b0:2ae:3e34:8024])
 (user=tweek job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:350d:b0:2ae:5ec4:2f80
 with SMTP id d9443c01a7336-2ae5ec43552mr7853795ad.47.1772493941903; Mon, 02
 Mar 2026 15:25:41 -0800 (PST)
Date: Tue,  3 Mar 2026 10:24:39 +1100
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260302232439.1930003-1-tweek@google.com>
Subject: [PATCH testsuite] Add tests for selabel_file backend
From: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
To: selinux@vger.kernel.org
Cc: "=?UTF-8?q?Christian=20G=C3=B6ttsche?=" <cgzones@googlemail.com>, James Carter <jwcart2@gmail.com>, 
	Paul Moore <paul@paul-moore.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Jeffrey Vander Stoep <jeffv@google.com>, 
	"=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
Content-Type: text/plain; charset="UTF-8"

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
---
Some more context on this change: we are currently trying to upstream
some of our internal changes to libselinux. A major difference is our
support for multiple SELABEL_OPT_PATH options which was discussed in
[1]. The intent is to follow up with an updated patch and tests which
will build on this commit.

It is not clear to me if this is the best location for these tests. Some
could be implemented directly in libselinux, but the ability to load a
test policy was required to confirm the behaviour of
SELABEL_OPT_VALIDATE.

[1] https://lore.kernel.org/selinux/20171017163328.117702-1-dcashman@android.com/

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
@@ -29,7 +29,8 @@ TARGETS = \
 	test_task_getsid.te test_task_setpgid.te test_task_setsched.te \
 	test_transition.te test_unix_socket.te \
 	test_mmap.te test_overlayfs.te test_mqueue.te \
-	test_ibpkey.te test_atsecure.te test_cgroupfs.te
+	test_ibpkey.te test_atsecure.te test_cgroupfs.te \
+	test_file_contexts.te
 
 ifeq (x$(DISTRO),$(filter x$(DISTRO),xRHEL4 xRHEL5 xRHEL6))
 SUPPORTS_CIL = n
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
@@ -28,7 +28,7 @@ SUBDIRS:= domain_trans entrypoint execshare exectrace execute_no_trans \
 	task_getpgid task_setpgid file ioctl capable_file capable_net \
 	capable_sys dyntrans dyntrace bounds nnp_nosuid mmap unix_socket \
 	inet_socket/tcp inet_socket/udp overlay checkreqprot mqueue \
-	mac_admin atsecure infiniband_endport infiniband_pkey
+	mac_admin atsecure infiniband_endport infiniband_pkey file_contexts
 
 ifeq ($(shell grep -q cap_userns $(POLDEV)/include/support/all_perms.spt && echo true),true)
 ifneq ($(shell ./kvercmp $$(uname -r) 4.7),-1)
diff --git a/tests/file_contexts/Makefile b/tests/file_contexts/Makefile
new file mode 100644
index 0000000..592a65f
--- /dev/null
+++ b/tests/file_contexts/Makefile
@@ -0,0 +1,10 @@
+TARGETS=test_open test_lookup test_open_base test_validate
+CFLAGS += -O2 -Werror -Wall
+LDLIBS += -lselinux
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
diff --git a/tests/file_contexts/f3.fc.homedirs b/tests/file_contexts/f3.fc.homedirs
new file mode 100644
index 0000000..d1878ce
--- /dev/null
+++ b/tests/file_contexts/f3.fc.homedirs
@@ -0,0 +1 @@
+/homedirs  system_u:object_r:test_homedirs:s0
diff --git a/tests/file_contexts/f3.fc.local b/tests/file_contexts/f3.fc.local
new file mode 100644
index 0000000..96e432b
--- /dev/null
+++ b/tests/file_contexts/f3.fc.local
@@ -0,0 +1 @@
+/local    system_u:object_r:test_local:s0
diff --git a/tests/file_contexts/f3.fc.subs b/tests/file_contexts/f3.fc.subs
new file mode 100644
index 0000000..922ed96
--- /dev/null
+++ b/tests/file_contexts/f3.fc.subs
@@ -0,0 +1 @@
+/sub /subbed
diff --git a/tests/file_contexts/f3.fc.subs_dist b/tests/file_contexts/f3.fc.subs_dist
new file mode 100644
index 0000000..abe31fe
--- /dev/null
+++ b/tests/file_contexts/f3.fc.subs_dist
@@ -0,0 +1 @@
+/sub_dist /subbed
diff --git a/tests/file_contexts/internal.c b/tests/file_contexts/internal.c
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
+	for (int i = 0; i < n; i++) {
+		char *context = NULL;
+		struct test_t test = tests[i];
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
diff --git a/tests/file_contexts/internal.h b/tests/file_contexts/internal.h
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
+/* Structure to capture a test. The |path| will be resolved and expected to
+ * match the |context|. If |context| is NULL, the lookup is expected to fail. */
+struct test_t {
+	const char *path;
+	const char *context;
+};
+
+/* Assert that all paths described in |tests| resolve appropriately. |hnd| must
+ * be opened. |n| is the number of tests in |tests|. */
+void assertContextsMatch(struct selabel_handle *hnd, struct test_t *tests,
+			 size_t n);
diff --git a/tests/file_contexts/test b/tests/file_contexts/test
new file mode 100755
index 0000000..0f698e9
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
+BEGIN { plan tests => 4; }
+
+$basedir = $0;
+$basedir =~ s|(.*)/[^/]*|$1|;
+
+$result = system "$basedir/test_open $basedir";
+ok( $result, 0 );
+
+$result = system "$basedir/test_lookup $basedir";
+ok( $result, 0 );
+
+$result = system "$basedir/test_open_base $basedir";
+ok( $result, 0 );
+
+$result = system "$basedir/test_validate $basedir";
+ok( $result, 0 );
+
+exit;
diff --git a/tests/file_contexts/test_lookup.c b/tests/file_contexts/test_lookup.c
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
+	if (argc != 2) {
+		fprintf(stderr, "basedir not provided\n");
+		exit(1);
+	}
+
+	char *path;
+	asprintf(&path, "%s/f2.fc", argv[1]);
+	struct selinux_opt f2_opts[] = {
+		{ .type = SELABEL_OPT_PATH, .value = path }
+	};
+
+	hnd = selabel_open(SELABEL_CTX_FILE, f2_opts, ARRAY_SIZE(f2_opts));
+
+	free(path);
+
+	if (!hnd) {
+		perror("file_context:f2_options");
+		exit(2);
+	}
+
+	struct test_t tests[] = {
+		{ .path = "/base", .context = "system_u:object_r:test_base_t:s0" },
+		{ .path = "/base/unkown", .context = "system_u:object_r:test_base_wildcard_t:s0" },
+		{ .path = "/base/sub", .context = "system_u:object_r:test_base_sub_t:s0" },
+		{ .path = "/base/file.list", .context = "system_u:object_r:test_file_list_t:s0" },
+		{ .path = "/base/file_list", .context = "system_u:object_r:test_base_wildcard_t:s0" },
+	};
+	assertContextsMatch(hnd, tests, ARRAY_SIZE(tests));
+
+	return 0;
+}
diff --git a/tests/file_contexts/test_open.c b/tests/file_contexts/test_open.c
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
+	bool has_default_path = false;
+	struct selabel_handle *hnd;
+	struct stat default_stat;
+
+	if (argc != 2) {
+		fprintf(stderr, "basedir not provided\n");
+		exit(1);
+	}
+
+	const char *default_path = selinux_file_context_path();
+	if (!stat(default_path, &default_stat)) {
+		has_default_path = true;
+	}
+
+	if (has_default_path) {
+		/* Empty options */
+		hnd = selabel_open(SELABEL_CTX_FILE, /* options= */ NULL, /* nopt= */ 0);
+
+		if (!hnd) {
+			perror("file_context:no_options");
+			exit(2);
+		}
+		selabel_close(hnd);
+
+		/* Default options */
+		struct selinux_opt null_opts[] = {
+			{ .type = SELABEL_OPT_PATH, .value = NULL }
+		};
+
+		hnd = selabel_open(SELABEL_CTX_FILE, /* options= */ null_opts, /* nopt= */ 1);
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
+	struct selinux_opt f1_opts[] = {
+		{ .type = SELABEL_OPT_PATH, .value = path }
+	};
+
+	hnd = selabel_open(SELABEL_CTX_FILE, /* options= */ f1_opts, /* nopt= */ 1);
+	free(path);
+
+	if (!hnd) {
+		perror("file_context:f1_options");
+		exit(2);
+	}
+
+	char *context = NULL;
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
diff --git a/tests/file_contexts/test_open_base.c b/tests/file_contexts/test_open_base.c
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
+ * Validate the behaviour of the SELABEL_OPT_BASEONLY option. That is, if set,
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
+	struct selinux_opt f3_opts[] = {
+		{ .type = SELABEL_OPT_PATH, .value = path }
+	};
+
+	hnd = selabel_open(SELABEL_CTX_FILE, f3_opts, ARRAY_SIZE(f3_opts));
+	free(path);
+
+	if (!hnd) {
+		perror("file_context:f3_default_options");
+		exit(2);
+	}
+
+	struct test_t tests[] = {
+		{ .path = "/", .context = "system_u:object_r:rootfs:s0" },
+		{ .path = "/local", .context = "system_u:object_r:test_local:s0" },
+		{ .path = "/homedirs", .context = "system_u:object_r:test_homedirs:s0" },
+		{ .path = "/sub", .context = "system_u:object_r:test_subbed:s0" },
+		{ .path = "/sub_dist", .context = "system_u:object_r:test_subbed:s0" },
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
+	struct selinux_opt f3_with_base_only_opts[] = {
+		{ .type = SELABEL_OPT_PATH, .value = path },
+		{ .type = SELABEL_OPT_BASEONLY, .value = "1" }
+	};
+
+	hnd = selabel_open(SELABEL_CTX_FILE, f3_with_base_only_opts,
+			   ARRAY_SIZE(f3_with_base_only_opts));
+	free(path);
+
+	if (!hnd) {
+		perror("file_context:f3_base_only_options");
+		exit(2);
+	}
+
+	struct test_t tests[] = {
+		{ .path = "/", .context = "system_u:object_r:rootfs:s0" },
+		{ .path = "/local", .context = NULL },
+		{ .path = "/homedirs", .context = NULL },
+		{ .path = "/sub", .context = "system_u:object_r:test_subbed:s0" },
+		{ .path = "/sub_dist", .context = "system_u:object_r:test_subbed:s0" },
+	};
+	assertContextsMatch(hnd, tests, ARRAY_SIZE(tests));
+
+	selabel_close(hnd);
+}
+
+int main(int argc, char **argv)
+{
+	if (argc != 2) {
+		fprintf(stderr, "basedir not provided\n");
+		exit(1);
+	}
+
+	test_default_options(argv[1]);
+	test_base_only_option(argv[1]);
+
+	return 0;
+}
diff --git a/tests/file_contexts/test_validate.c b/tests/file_contexts/test_validate.c
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
+	if (argc != 2) {
+		fprintf(stderr, "basedir not provided\n");
+		exit(1);
+	}
+
+	asprintf(&path, "%s/f1.fc", argv[1]);
+	struct selinux_opt f1_opts[] = {
+		{ .type = SELABEL_OPT_PATH, .value = path },
+		{ .type = SELABEL_OPT_VALIDATE, .value = "1" }
+	};
+
+	/* f1 types are not defined in the test policy. */
+	hnd = selabel_open(SELABEL_CTX_FILE, f1_opts, ARRAY_SIZE(f1_opts));
+	free(path);
+
+	if (hnd) {
+		fprintf(stderr, "The validation of f1 should have failed.\n");
+		exit(2);
+	}
+
+	asprintf(&path, "%s/f2.fc", argv[1]);
+	struct selinux_opt f2_opts[] = {
+		{ .type = SELABEL_OPT_PATH, .value = path },
+		{ .type = SELABEL_OPT_VALIDATE, .value = "1" }
+	};
+
+	/* f2 types are defined in the test policy. */
+	hnd = selabel_open(SELABEL_CTX_FILE, f2_opts, ARRAY_SIZE(f2_opts));
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
-- 
2.53.0.473.g4a7958ca14-goog

