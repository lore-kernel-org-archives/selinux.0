Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D4615667D
	for <selinux@vger.kernel.org>; Mon,  8 Sep 2025 01:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757295352; cv=none; b=EgeDFh4MxrLHkz20wOEB3w/cqxDqkKZS9lqrI8gmbzNhs/NcfCnvbAW1E2R9GY2UEtGqgiChfV2t7jLxlPfINEKFOKCjHYTEngctdkaWCdnFJzCQWgqbGaqgSNdLjrNGHAPUmOV+iz4TP3p+VpNu/gk5+NHGqGdysqv7MY844Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757295352; c=relaxed/simple;
	bh=o/LaU5a3n+NJSG7OOjqZS9VJzoCzkskjxIMbXrWjrkc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qh+hMMCUknm4OLtj85u8ZR5BsJql7MofmLSFbIibiPhVRcWiMr8ev804XYZi9glveMAh77HDGeGBFw17WrbpYHZRBQEW6oA4E5gjy63tDf9TQCLymUeO+o/hd84uuaQHCr0sNNe5xYhgsEUxGW/P8MZiGw4raY9HxIlaV0ILF/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wZ+mmLT+; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wZ+mmLT+"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b47174bdce2so3043691a12.2
        for <selinux@vger.kernel.org>; Sun, 07 Sep 2025 18:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757295350; x=1757900150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WRmfAlepPh9QExmHTYBjow3NBeGfFMvyVF9526GPyN0=;
        b=wZ+mmLT+NcSIJNEV26+BT5HXZpyGfnoGoC7qC9Gh7W98D98TFy2bYWHqVDsUxD2EJ6
         Adj9gh7a/c1OXOkS9J1/tD8bAFX4DHp7NDXC7LmhA+ggyGpUvTwMsRYDchlt4J+31Cot
         bF2Phw4kA2wZslxu4IiuYncy3L3wt4ig83v36XK76Y487aRco3Rq1qrtGDIiWHVkG+CN
         YPMWuY95iglYBG2dLmOc0XeEM8fNKPBbeZq6DlmPO9i+fqh/texprYLGmI1cLspaK/IH
         NrXv1L4Wq6h7mBRoxeGifCsVfmchguzMpUpX6ANUFO63s74T9QzLhU7NGewmk98iawee
         xnmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757295350; x=1757900150;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WRmfAlepPh9QExmHTYBjow3NBeGfFMvyVF9526GPyN0=;
        b=aCr6aAwC+XC/Rb6XV8EZR49g7QtShT3DXjM4qV6DXh4ai/GLwjsGhEc+IH6fe5HYpo
         ar6wmo+wAgeVjOkFfm3qM/h4Ou39SgVtYz4YZBxWY9Pfuz4wOfcQuksuGf+AleU972+G
         yHe7dK2Tdf53vIUyUTU4KSCjXdP6UuS9k0c9T2Ml0Frl0qncTRl10Mbf9gORQVu+TPVC
         YsvpMj0KPhHx+5wgrl9W7xVxsCQr9z17dgMAMB6vhQ//8lmJbvqJ+s09JGYYMFYauxCc
         ilWihTpQ/WT0pWG8lLEEMSueopodEtjF0heh52wt+xynnR6iAEU65mioQ2O339XITn0f
         LeVw==
X-Forwarded-Encrypted: i=1; AJvYcCX6a/TwqyJBYk+BW6c40I/9j31dpMpQV6CisqC3G61XwwORRk4mXz7h6yaBACEAJtUYdpalVGGG@vger.kernel.org
X-Gm-Message-State: AOJu0YwtjWByJVg9XJJbhvULKPfXaEAC3S9Rc0V8yopFLQIDdHk2dPKc
	h7g3G1a7X1vg6nvt0yvrQAxmwpTJ9Ow5dgJxBJrA49GEzLvc641J2BBnME1JSrtT4aPoSyM8Nka
	9ow==
X-Google-Smtp-Source: AGHT+IFMJF/X7c79vDOkyGk5ZPZabHkpKBBUdCtHG+uge+JSlmHJTHf1z+ooJFXq56wUPNZYsSDciG4F+A==
X-Received: from pjg4.prod.google.com ([2002:a17:90b:3f44:b0:327:e021:e61d])
 (user=tweek job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e847:b0:250:c893:6cc1
 with SMTP id d9443c01a7336-2516c8957d3mr69446245ad.8.1757295350143; Sun, 07
 Sep 2025 18:35:50 -0700 (PDT)
Date: Mon,  8 Sep 2025 11:35:42 +1000
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250908013542.4187488-1-tweek@google.com>
Subject: [PATCH v2] policy,tests: add tests for memfd_file class
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

This can be tested by modifying the policy with:

  semodule -c -E base
  sed -i \
    -e 's/\((class user_namespace (create ))\)/\1\n(class memfd_file (execu=
te_no_trans entrypoint ))\n(classcommon memfd_file file)/' \
    -e 's/\(anon_inode socket\)/memfd_file \1/' \
    base.cil
  echo "(policycap memfd_class)" >>base.cil
  semodule -X 456 -i base.cil
  rm -f base.cil

  sed -i.orig \
    -e 's/\(define(`all_file_perms'\'',\)\(.*\)$/\1\2\ndefine(`all_memfd_fi=
le_perms'\'',\2/' \
    -e 's/\(class file all_file_perms;\)/\1\nclass memfd_file all_memfd_fil=
e_perms;/' \
    /usr/share/selinux/devel/include/support/all_perms.spt

[1] https://lore.kernel.org/selinux/20250826031824.1227551-1-tweek@google.c=
om/

Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
---
Changelog since v1:
- Add commands to test the policy to the commit message.
- Only check for class and capability to include the new tests.
- Ran check-syntax.

 policy/Makefile             |  5 ++++
 policy/test_memfd.te        | 25 +++++++++++++++++
 tests/Makefile              |  5 ++++
 tests/memfd/Makefile        |  5 ++++
 tests/memfd/memfd.c         | 24 +++++++++++++++++
 tests/memfd/memfd_fexecve.c | 53 +++++++++++++++++++++++++++++++++++++
 tests/memfd/nothing.c       |  6 +++++
 tests/memfd/test            | 41 ++++++++++++++++++++++++++++
 8 files changed, 164 insertions(+)
 create mode 100644 policy/test_memfd.te
 create mode 100644 tests/memfd/Makefile
 create mode 100644 tests/memfd/memfd.c
 create mode 100644 tests/memfd/memfd_fexecve.c
 create mode 100644 tests/memfd/nothing.c
 create mode 100755 tests/memfd/test

diff --git a/policy/Makefile b/policy/Makefile
index ffd774d..520f891 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -163,6 +163,11 @@ ifeq ($(shell [ $(MOD_POL_VERS) -ge 18 -a $(MAX_KERNEL=
_POLICY) -ge 30 ] && [ -f
 TARGETS +=3D test_nlmsg.te
 endif
=20
+# memfd_file test dependencies: memfd_file class, memfd_class capability
+ifeq ($(shell [ -d /sys/fs/selinux/class/memfd_file ] && grep -q 1 $(SELIN=
UXFS)/policy_capabilities/memfd_class && echo true),true)
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
index 7a6aace..903ab11 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -158,6 +158,11 @@ ifeq ($(shell [ $(MOD_POL_VERS) -ge 18 -a $(MAX_KERNEL=
_POLICY) -ge 30 ] && [ -f
 SUBDIRS +=3D nlmsg
 endif
=20
+# memfd_file test dependencies: memfd_file class, memfd_class capability
+ifeq ($(shell [ -d /sys/fs/selinux/class/memfd_file ] && grep -q 1 $(SELIN=
UXFS)/policy_capabilities/memfd_class && echo true),true)
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
index 0000000..1b1e75f
--- /dev/null
+++ b/tests/memfd/test
@@ -0,0 +1,41 @@
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
+$result =3D system
+"runcon -t test_memfd_with_exec_t -- $basedir/memfd_fexecve $basedir/nothi=
ng 2>&1";
+ok( $result, 0 );
+
+#
+# Attempt to fexecve() on a memfd_create() fd from the not-allowed domain.
+#
+$result =3D system
+"runcon -t test_memfd_with_noexec_t -- $basedir/memfd_fexecve $basedir/not=
hing 2>&1";
+ok($result);
+exit;
--=20
2.51.0.384.g4c02a37b29-goog

