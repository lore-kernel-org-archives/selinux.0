Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9861A1DED57
	for <selinux@vger.kernel.org>; Tue,  2 Sep 2025 05:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756792447; cv=none; b=oqwLtAYPoGdkGly9jHGcVthf++LRwaGhprpn5/4bjhW6u1AztRN5ZHcQjkFKSn8Vr35PwM0LEd+vef941zOiZBj4GFNA8D7VyBMn+BApmHVgitTigEmvL5YoTlFc74rLWlex0KHnZOvEMoLY1xEIjmSFkuqaULds1xrMnM+zAHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756792447; c=relaxed/simple;
	bh=YBhoNsz73E81IZnKKTFEx6cs/D8OtfpgynCyISt+sEw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=D46Tpnjb1M09MiYYRboSkCsh4Qqw5h0TdtgElF/09u1nbzipHyOV3dKlrJ3IhK2S+0btzP0LXD7fDONZ/GBIVGrFfyDTUmWKIbL4KpqOzh/SpFQ7mnOh+MBBqadGoDvGAcB6025uvTUe5zGSivqC3hsiytIhOa+F0Un3ptmG6so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rsWaZXn6; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rsWaZXn6"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b4f93fe3831so911659a12.0
        for <selinux@vger.kernel.org>; Mon, 01 Sep 2025 22:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756792445; x=1757397245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Qykh9QD57dxn4AwwRkgUDtr3Jtznvh8YF8X9E2gIjk=;
        b=rsWaZXn6e1MZsuhKCP4yG9Ce2G9oG+yVVAq/2K+QbeAiayOBF0LnkEAwJCp23zf7XR
         0bFDGZqQSD4S8E7FfhyBGkEHshYJFyFCAebyR91Pan4o7e8OZCnpuImNmNxJg015II0N
         DOETNfkJr+uUgyUpKhWnHXszXgFz3zknBwJUtoDvWpeGhIZvYBZnLvdAj2+8mpkYURvv
         urK9BBj/oSCU1rP2kWFtUaieuwcA8KAJfIIexVta6/0wNGNVZ4FTbf2ncUCysd48pG68
         vMroZVq6UETDARyzUoUNGcOIsxFDeMso2UUEWjhRB+gl6lUjvnaGkTnnN6AuoqOM22g7
         toUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756792445; x=1757397245;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Qykh9QD57dxn4AwwRkgUDtr3Jtznvh8YF8X9E2gIjk=;
        b=ApdOvyNnM0obvjO7b0fk7pNRKg5NaLMOMeBwhstZhBcOyPbV0UE9G60gAd46itA4gJ
         WgcTIrInKc8t7Eo6v63E657qVY6/VWbWaBp8A8dOQIeyIGq3VugxKxd3VQyJ0C++Rqia
         RDJ813VPh+E3e/Eg/pz/M5/IiwlVam6opibaOWT61Pygj9yingkwqDrsvi9to8yZW+ro
         adWt63sCxBEIbx0NxUErbleLQ3pYf2qTWNGjL7K2wqE/pG09Tfx00d/kpCiM81s5fjIS
         Ni3MPIFCoTF587FhJdHtvf8yRWput+Zt301JTvBNRA3dewDvCaoz12kTrOO0kKAjzGPw
         HLng==
X-Forwarded-Encrypted: i=1; AJvYcCUAriFPktOyRMI4qlZ20pR1tU9mhFru2R2+uvnznHzXJOKYx/z0W6EluGvjnXppsgI6k98IycnG@vger.kernel.org
X-Gm-Message-State: AOJu0YzDCpFTdeJ+QVgBp+bVQQ0NAnOw3a8YngnYUmTBSmNvRVDUdnEu
	7+pWXrUd+Ze6+x7/EVWRH35DJgeTkNCCrlphU5voAnTVzF5Fq6ick/EEfvgLGqTDTkXbiRQ1GNe
	tPw==
X-Google-Smtp-Source: AGHT+IFZuFl4ULOJvLg8d523YWJ5/vkuuL4WchcIPXFMrMKY1KS+78R8m7uWYzaW1xUEB/ASw/nfj2kOhg==
X-Received: from pfbdi11-n2.prod.google.com ([2002:a05:6a00:480b:20b0:76c:6ec8:ac2d])
 (user=tweek job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6d9a:b0:243:b0a9:f900
 with SMTP id adf61e73a8af0-243d6bca369mr13909871637.0.1756792444867; Mon, 01
 Sep 2025 22:54:04 -0700 (PDT)
Date: Tue,  2 Sep 2025 15:54:01 +1000
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250902055401.618729-1-tweek@google.com>
Subject: [PATCH testsuite] policy,tests: add tests for memfd_file class
From: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
To: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	James Morris <jmorris@namei.org>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Jeff Vander Stoep <jeffv@google.com>, Nick Kralevich <nnk@google.com>, Jeff Xu <jeffxu@google.com>
Cc: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

A new class "memfd_file" is introduced to the kernel in [1]. This class
is only used when the policy capability "memfd_class" is set. Add tests
to validate this new class:

  1. Validate that memfd_create() requires the "create" permission.
  2. Validate that fexecve() on a memfd requires the "execute_no_trans"
     permission.

[1] https://lore.kernel.org/selinux/20250826031824.1227551-1-tweek@google.c=
om/

Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
---
 policy/Makefile             |  5 ++++
 policy/test_memfd.te        | 25 +++++++++++++++++
 tests/Makefile              |  5 ++++
 tests/memfd/Makefile        |  5 ++++
 tests/memfd/memfd.c         | 24 +++++++++++++++++
 tests/memfd/memfd_fexecve.c | 53 +++++++++++++++++++++++++++++++++++++
 tests/memfd/nothing.c       |  6 +++++
 tests/memfd/test            | 39 +++++++++++++++++++++++++++
 8 files changed, 162 insertions(+)
 create mode 100644 policy/test_memfd.te
 create mode 100644 tests/memfd/Makefile
 create mode 100644 tests/memfd/memfd.c
 create mode 100644 tests/memfd/memfd_fexecve.c
 create mode 100644 tests/memfd/nothing.c
 create mode 100755 tests/memfd/test

diff --git a/policy/Makefile b/policy/Makefile
index ffd774d..d19f687 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -163,6 +163,11 @@ ifeq ($(shell [ $(MOD_POL_VERS) -ge 18 -a $(MAX_KERNEL=
_POLICY) -ge 30 ] && [ -f
 TARGETS +=3D test_nlmsg.te
 endif
=20
+# memfd_file test dependencies: policy >=3D 30, memfd_file class, memfd_cl=
ass capability
+ifeq ($(shell [ $(MOD_POL_VERS) -ge 18 -a $(MAX_KERNEL_POLICY) -ge 30 ] &&=
 [ -d /sys/fs/selinux/class/memfd_file ] && grep -q 1 $(SELINUXFS)/policy_c=
apabilities/memfd_class && echo true),true)
+TARGETS +=3D test_memfd.te
+endif
+
 ifeq (x$(DISTRO),$(filter x$(DISTRO),xRHEL4 xRHEL5 xRHEL6))
 TARGETS:=3D$(filter-out test_overlayfs.te test_mqueue.te test_ibpkey.te, $=
(TARGETS))
 endif
diff --git a/policy/test_memfd.te b/policy/test_memfd.te
new file mode 100644
index 0000000..5ca1348
--- /dev/null
+++ b/policy/test_memfd.te
@@ -0,0 +1,25 @@
+########################################
+#
+# Policy for testing memfd_file.
+
+attribute memfdtestdomain;
+
+type test_memfd_t;
+typeattribute test_memfd_t memfdtestdomain;
+testsuite_domain_type(test_memfd_t);
+allow test_memfd_t self:memfd_file { create mmap_rw_file_perms };
+
+type test_memfd_nocreate_t;
+typeattribute test_memfd_nocreate_t memfdtestdomain;
+testsuite_domain_type(test_memfd_nocreate_t);
+allow test_memfd_nocreate_t self:memfd_file mmap_rw_file_perms;
+
+type test_memfd_with_exec_t;
+typeattribute test_memfd_with_exec_t memfdtestdomain;
+testsuite_domain_type(test_memfd_with_exec_t);
+allow test_memfd_with_exec_t self:memfd_file { create mmap_rw_file_perms e=
xecute execute_no_trans };
+
+type test_memfd_with_noexec_t;
+typeattribute test_memfd_with_noexec_t memfdtestdomain;
+testsuite_domain_type(test_memfd_with_noexec_t);
+allow test_memfd_with_noexec_t self:memfd_file { create mmap_rw_file_perms=
 execute };
diff --git a/tests/Makefile b/tests/Makefile
index 7a6aace..e6fa76b 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -158,6 +158,11 @@ ifeq ($(shell [ $(MOD_POL_VERS) -ge 18 -a $(MAX_KERNEL=
_POLICY) -ge 30 ] && [ -f
 SUBDIRS +=3D nlmsg
 endif
=20
+# memfd_file test dependencies: policy >=3D 30, memfd_file class, memfd_cl=
ass capability
+ifeq ($(shell [ $(MOD_POL_VERS) -ge 18 -a $(MAX_KERNEL_POLICY) -ge 30 ] &&=
 [ -d /sys/fs/selinux/class/memfd_file ] && grep -q 1 $(SELINUXFS)/policy_c=
apabilities/memfd_class && echo true),true)
+SUBDIRS +=3D memfd
+endif
+
 ifeq ($(DISTRO),RHEL4)
     SUBDIRS:=3D$(filter-out bounds dyntrace dyntrans inet_socket mmap nnp_=
nosuid overlay unix_socket, $(SUBDIRS))
 endif
diff --git a/tests/memfd/Makefile b/tests/memfd/Makefile
new file mode 100644
index 0000000..471900f
--- /dev/null
+++ b/tests/memfd/Makefile
@@ -0,0 +1,5 @@
+TARGETS=3Dmemfd nothing memfd_fexecve
+
+all: $(TARGETS)
+clean:
+	rm -f $(TARGETS)
diff --git a/tests/memfd/memfd.c b/tests/memfd/memfd.c
new file mode 100644
index 0000000..0d6f838
--- /dev/null
+++ b/tests/memfd/memfd.c
@@ -0,0 +1,24 @@
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+#include <errno.h>
+#include <sys/mman.h>
+#include <unistd.h>
+
+int main(int argc, char *argv[])
+{
+	int fd;
+	char *name =3D "mymemfd";
+
+	fd =3D memfd_create(name, 0);
+	if (fd < 0) {
+		perror("memfd_create");
+		exit(-1);
+	}
+
+	close(fd);
+	exit(0);
+}
diff --git a/tests/memfd/memfd_fexecve.c b/tests/memfd/memfd_fexecve.c
new file mode 100644
index 0000000..977081e
--- /dev/null
+++ b/tests/memfd/memfd_fexecve.c
@@ -0,0 +1,53 @@
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
+#include <errno.h>
+#include <fcntl.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <unistd.h>
+
+int main(int argc, char *argv[])
+{
+	int memfd_fd, exec_fd;
+	int len, written, rc;
+	char *name =3D "mymemfd";
+
+	if (argc !=3D 2) {
+		printf("Usage: %s <fexec_binary>\n", argv[0]);
+		exit(-1);
+	}
+
+	memfd_fd =3D memfd_create(name, 0);
+	if (memfd_fd < 0) {
+		perror("memfd_create");
+		exit(-1);
+	}
+
+	exec_fd =3D open(argv[1], O_RDONLY);
+	if (exec_fd < 0) {
+		perror("open");
+		exit(-1);
+	}
+
+	char buf[8192];
+	while ((len =3D read(exec_fd, buf, sizeof(buf))) > 0) {
+		written =3D write(memfd_fd, buf, len);
+		if (len !=3D written) {
+			perror("read/write");
+			exit(-1);
+		}
+	}
+	close(exec_fd);
+
+	char *empty_env[] =3D {NULL};
+	char *nothing_argv[] =3D {argv[1], NULL};
+
+	rc =3D fexecve(memfd_fd, nothing_argv, empty_env);
+
+	perror("fexecve");
+	exit(rc);
+}
diff --git a/tests/memfd/nothing.c b/tests/memfd/nothing.c
new file mode 100644
index 0000000..fc53d37
--- /dev/null
+++ b/tests/memfd/nothing.c
@@ -0,0 +1,6 @@
+#include <stdlib.h>
+
+int main(int argc, char *argv[])
+{
+	return 0;
+}
diff --git a/tests/memfd/test b/tests/memfd/test
new file mode 100755
index 0000000..a88a0db
--- /dev/null
+++ b/tests/memfd/test
@@ -0,0 +1,39 @@
+#!/usr/bin/perl
+#
+# This test exercises the memfd_class support
+#
+
+use Test;
+
+BEGIN {
+    $test_count =3D 4;
+    plan tests =3D> $test_count;
+}
+
+$basedir =3D $0;
+$basedir =3D~ s|(.*)/[^/]*|$1|;
+
+#
+# Attempt to call memfd_create() from the allowed domain.
+#
+$result =3D system "runcon -t test_memfd_t -- $basedir/memfd 2>&1";
+ok( $result, 0 );
+
+#
+# Attempt to call memfd_create() from the not-allowed domain.
+#
+$result =3D system "runcon -t test_memfd_nocreate_t -- $basedir/memfd 2>&1=
";
+ok($result);
+
+#
+# Attempt to fexecve() on a memfd_create() fd from the allowed domain.
+#
+$result =3D system "runcon -t test_memfd_with_exec_t -- $basedir/memfd_fex=
ecve $basedir/nothing 2>&1";
+ok( $result, 0 );
+
+#
+# Attempt to fexecve() on a memfd_create() fd from the not-allowed domain.
+#
+$result =3D system "runcon -t test_memfd_with_noexec_t -- $basedir/memfd_f=
execve $basedir/nothing 2>&1";
+ok($result);
+exit;
--=20
2.51.0.338.gd7d06c2dae-goog

