Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CE3611E
	for <selinux@vger.kernel.org>; Mon, 15 Sep 2025 17:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757958903; cv=none; b=gT/eQcNNyR8SgDxaEN7AZicv//qBOV+Fg+PLSEDgJoJKF8YleIrbzGJ4lpY3ZBz+PcLQ6j30FNJ345rrSuzPGG7RVGnegvx7R3RTa07VN9R4tnUFeRojaXqfN4HVtBJU4slFXuN2+3TMJ6fqgm62deg3cPXPgN5H+aSDpQXoHS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757958903; c=relaxed/simple;
	bh=kpMPmE5i/djICx61EVs9ColvLZe0QrI6gdaiI2JRFSk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SHWWicAn7Yp9xYzGdMPi3LyTxiufui6pPe26ShvAsBHq8AFwcXDf8Cdo/mT7bZmL0o/NelPjJtsup+ji/UTML0E/nw9svyKQBzCreRyFK4o0abyTLdgZc9RGJiOaFQru/C1YchHrxjeS+qca0WmjaU4KT++4vih2DdUoWzmJvSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=WHM0Y4aQ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="WHM0Y4aQ"
Received: from ericsu-dev1 (unknown [131.107.1.202])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4EF2D212328D;
	Mon, 15 Sep 2025 10:54:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4EF2D212328D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1757958899;
	bh=DD6wd/A7Mq9PxzpdFe7j7P/WSIzEYJYj01zoa9WqEZw=;
	h=From:To:Cc:Subject:Date:From;
	b=WHM0Y4aQYuOrtnZQrZruiKXKFYobSJ1DdKLbSSENGBxV+DXhiICRqP6MBCNgIPvHr
	 OiLUQm9bm+e/EFPtqJvtNe3Za2FIWg8nuC17ghFNtk5ys6OcboFYBjcxdGGNrFQIhV
	 K/zcX5hkDQuuflW0ygnbs7D7PJwXD/XPGNE5o3PU=
From: Eric Suen <ericsu@linux.microsoft.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	stephen.smalley.work@gmail.com,
	omosnace@redhat.com,
	danieldurning.work@gmail.com
Subject: [PATCH testsuite v6] tests/bpf: Add tests for SELinux BPF token access control
Date: Mon, 15 Sep 2025 10:54:56 -0700
Message-ID: <20250915175456.1991-1-ericsu@linux.microsoft.com>
X-Mailer: git-send-email 2.51.0.windows.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds new tests to verify the SELinux support for BPF token
access control, as introduced in the corresponding kernel patch:
  https://lore.kernel.org/selinux/20250816201420.197-1-ericsu@linux.microsoft.com/

Note that new tests require changes in libsepol which is covered in
  https://lore.kernel.org/selinux/20250808183506.665-1-ericsu@linux.microsoft.com/

Four new tests are added to cover both positive and negative scenarios,
ensuring that the SELinux policy enforcement on BPF token usage behaves
as expected.
  - Successful map_create and prog_load when SELinux permissions are
    granted.
  - Enforcement of SELinux policy restrictions when access is denied.

For testing purposes, you can update the base policy by manually
modifying your base module and tweaking /usr/share/selinux/devel as
follows:
  sudo semodule -c -E base
  sudo sed -i.orig "s/map_create/map_create map_create_as/" base.cil
  sudo sed -i "s/prog_load/prog_load prog_load_as/" base.cil
  sudo semodule -i base.cil
  echo "(policycap bpf_token_perms)" > bpf_token_perms.cil
  sudo semodule -i bpf_token_perms.cil
  sudo cp /usr/share/selinux/devel/include/support/all_perms.spt \
      /usr/share/selinux/devel/include/support/all_perms.spt.orig
  sudo sed -i "s/map_create/map_create map_create_as/" \
      /usr/share/selinux/devel/include/support/all_perms.spt
  sudo sed -i "s/prog_load/prog_load prog_load_as/" \
      /usr/share/selinux/devel/include/support/all_perms.spt

When finished testing, you can semodule -r base bpf_token_perms to
undo the two module changes and restore your all_perms.spt file from
the saved .orig file.

Signed-off-by: Eric Suen <ericsu@linux.microsoft.com>
Tested-by: Daniel Durning <danieldurning.work@gmail.com>
Reviewed-by: Daniel Durning <danieldurning.work@gmail.com>

---
Changes in v2:
- Removed allow rule for 'kernel_t' in test_bpf.te which was added due
  to a bug in the kernel
- Cleaned up other unnecessary rules in test_bpf.te
- Added token_test.c which was missing from previous patch

Changes in v3:
- Added original license in 'token_test.c'
- Updated patch description to
    - replace 'base.sil' with 'base.cil'
    - Remove extra quotation mark in 'sudo 'sed -i "s/"map_create'

Changes in v4:
- Updated 'token_test.c' to write error messages only when DEBUG
  is defined

Changes in v5:
- Created test_bpf_token.te which gets loaded when required bpf
  permissions (i.e. map_create_as, prog_load_as) are available, and
  policy capability (i.e. bpf_token_perms) is defined
- Added condition in tests/bpf/test to run new tests when policy
  capability bpf_token_perms is defined

Changes in v6:
- Updated commit description per review feedback
- Update comment in policy/Makefile
- Fixed missing new line in tests/bpf/Makefile

 policy/Makefile          |   7 +
 policy/test_bpf_token.te |  42 +++
 tests/bpf/Makefile       |   6 +-
 tests/bpf/bpf_common.h   |  10 +
 tests/bpf/bpf_test.c     |  59 +++--
 tests/bpf/test           |  35 +++
 tests/bpf/token_test.c   | 559 +++++++++++++++++++++++++++++++++++++++
 7 files changed, 700 insertions(+), 18 deletions(-)
 create mode 100644 policy/test_bpf_token.te
 create mode 100644 tests/bpf/token_test.c

diff --git a/policy/Makefile b/policy/Makefile
index ffd774d..915555c 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -105,6 +105,13 @@ ifeq ($(shell grep -q bpf $(POLDEV)/include/support/all_perms.spt && echo true),
 TARGETS += test_bpf.te test_fdreceive_bpf.te test_binder_bpf.te
 endif
 
+# bpf token test dependencies: bpf permission, bpf_token capability
+ifeq ($(shell [ -f /sys/fs/selinux/class/bpf/perms/map_create_as ] && [ -f /sys/fs/selinux/class/bpf/perms/prog_load_as ] && echo true),true)
+ifeq ($(shell [ -f $(SELINUXFS)/policy_capabilities/bpf_token_perms ] && grep -q 1 $(SELINUXFS)/policy_capabilities/bpf_token_perms && echo true),true)
+TARGETS += test_bpf_token.te
+endif
+endif
+
 ifeq ($(shell grep -q all_key_perms $(POLDEV)/include/support/all_perms.spt && echo true),true)
 TARGETS += test_keys.te test_watchkey.te
 endif
diff --git a/policy/test_bpf_token.te b/policy/test_bpf_token.te
new file mode 100644
index 0000000..4d209ba
--- /dev/null
+++ b/policy/test_bpf_token.te
@@ -0,0 +1,42 @@
+########################################
+#
+# Policy for testing BPF map create and program load with BPF token
+
+################### Allow map_create_as and prog_load_as ###################
+fs_list_bpf_dirs(test_bpf_t)
+allow test_bpf_t bpf_t:filesystem mount;
+allow test_bpf_t root_t:dir mounton;
+allow test_bpf_t self:bpf { map_create_as prog_load_as };
+allow test_bpf_t self:cap2_userns { bpf perfmon };
+allow test_bpf_t self:cap_userns { net_admin setgid setuid sys_admin };
+allow test_bpf_t self:user_namespace create;
+
+############################ Deny map_create_as ############################
+type test_bpf_deny_map_create_as_t;
+testsuite_domain_type(test_bpf_deny_map_create_as_t)
+typeattribute test_bpf_deny_map_create_as_t bpfdomain;
+allow test_bpf_deny_map_create_as_t self:process { setrlimit };
+allow test_bpf_deny_map_create_as_t self:capability { sys_resource sys_admin };
+
+fs_list_bpf_dirs(test_bpf_deny_map_create_as_t)
+allow test_bpf_deny_map_create_as_t bpf_t:filesystem mount;
+allow test_bpf_deny_map_create_as_t root_t:dir mounton;
+allow test_bpf_deny_map_create_as_t self:bpf { map_create map_read map_write prog_load prog_load_as };
+allow test_bpf_deny_map_create_as_t self:cap2_userns { bpf };
+allow test_bpf_deny_map_create_as_t self:cap_userns { setgid setuid sys_admin };
+allow test_bpf_deny_map_create_as_t self:user_namespace create;
+
+############################ Deny prog_load_as #############################
+type test_bpf_deny_prog_load_as_t;
+testsuite_domain_type(test_bpf_deny_prog_load_as_t)
+typeattribute test_bpf_deny_prog_load_as_t bpfdomain;
+allow test_bpf_deny_prog_load_as_t self:process { setrlimit };
+allow test_bpf_deny_prog_load_as_t self:capability { sys_resource sys_admin };
+
+fs_list_bpf_dirs(test_bpf_deny_prog_load_as_t)
+allow test_bpf_deny_prog_load_as_t bpf_t:filesystem mount;
+allow test_bpf_deny_prog_load_as_t root_t:dir mounton;
+allow test_bpf_deny_prog_load_as_t self:bpf { map_create map_create_as map_read map_write prog_load };
+allow test_bpf_deny_prog_load_as_t self:cap2_userns { bpf perfmon };
+allow test_bpf_deny_prog_load_as_t self:cap_userns { net_admin setgid setuid sys_admin };
+allow test_bpf_deny_prog_load_as_t self:user_namespace create;
diff --git a/tests/bpf/Makefile b/tests/bpf/Makefile
index 1ae8ce9..aff51f4 100644
--- a/tests/bpf/Makefile
+++ b/tests/bpf/Makefile
@@ -1,5 +1,5 @@
 TARGETS = bpf_test
-DEPS = bpf_common.c bpf_common.h
+SRCS = bpf_test.c bpf_common.c token_test.c
 LDLIBS += -lselinux -lbpf
 
 # export so that BPF_ENABLED entries get built correctly on local build
@@ -14,4 +14,6 @@ clean:
 	rm -f $(TARGETS) test_sock flag *_flag
 	@set -e; for i in $(BPF_ENABLED); do $(MAKE) -C $$i clean ; done
 
-$(TARGETS): $(DEPS)
+$(TARGETS): $(SRCS)
+	$(CC) $(CFLAGS) -o $@ $^ $(LDLIBS)
+
diff --git a/tests/bpf/bpf_common.h b/tests/bpf/bpf_common.h
index 44ac28f..adba522 100644
--- a/tests/bpf/bpf_common.h
+++ b/tests/bpf/bpf_common.h
@@ -12,6 +12,8 @@
 extern int create_bpf_map(void);
 extern int create_bpf_prog(void);
 extern void bpf_setrlimit(void);
+extern int test_bpf_map_create(void);
+extern int test_bpf_prog_load(void);
 
 /* edited eBPF instruction library */
 /* Short form of mov, dst_reg = imm32 */
@@ -32,3 +34,11 @@ extern void bpf_setrlimit(void);
 					       .off   = 0,			\
 							.imm   = 0 })
 
+/* Raw code statement block */
+#define BPF_RAW_INSN(CODE, DST, SRC, OFF, IMM)			\
+	((struct bpf_insn) {					\
+		.code  = CODE,					\
+			.dst_reg = DST,					\
+				.src_reg = SRC,					\
+					.off   = OFF,					\
+						.imm   = IMM })
diff --git a/tests/bpf/bpf_test.c b/tests/bpf/bpf_test.c
index 3c6a29c..a8dc383 100644
--- a/tests/bpf/bpf_test.c
+++ b/tests/bpf/bpf_test.c
@@ -1,28 +1,38 @@
 #include "bpf_common.h"
 
+#define write_verbose(verbose, fmt, ...) \
+	do { \
+		if (verbose) \
+			printf(fmt "\n", ##__VA_ARGS__); \
+	} while (0)
+
 static void usage(char *progname)
 {
 	fprintf(stderr,
-		"usage:  %s -m|-p [-v]\n"
+		"usage:  %s -m|-p|-c|-l [-v]\n"
 		"Where:\n\t"
 		"-m    Create BPF map fd\n\t"
 		"-p    Create BPF prog fd\n\t"
+		"-c    Test BPF token map create\n\t"
+		"-l    Test BPF token program load\n\t"
 		"-v Print information.\n", progname);
 	exit(-1);
 }
 
 int main(int argc, char *argv[])
 {
-	int opt, result, fd;
-	bool verbose = false;
+	int opt, result, ret;
+	bool verbose = false, is_fd = true;
 	char *context;
 
 	enum {
 		MAP_FD = 1,
-		PROG_FD
+		PROG_FD,
+		MAP_CREATE,
+		PROG_LOAD,
 	} bpf_fd_type;
 
-	while ((opt = getopt(argc, argv, "mpv")) != -1) {
+	while ((opt = getopt(argc, argv, "mpclv")) != -1) {
 		switch (opt) {
 		case 'm':
 			bpf_fd_type = MAP_FD;
@@ -30,6 +40,12 @@ int main(int argc, char *argv[])
 		case 'p':
 			bpf_fd_type = PROG_FD;
 			break;
+		case 'c':
+			bpf_fd_type = MAP_CREATE;
+			break;
+		case 'l':
+			bpf_fd_type = PROG_LOAD;
+			break;
 		case 'v':
 			verbose = true;
 			break;
@@ -44,8 +60,7 @@ int main(int argc, char *argv[])
 		exit(-1);
 	}
 
-	if (verbose)
-		printf("Process context:\n\t%s\n", context);
+	write_verbose(verbose, "Process context:\n\n%s", context);
 
 	free(context);
 
@@ -54,24 +69,36 @@ int main(int argc, char *argv[])
 
 	switch (bpf_fd_type) {
 	case MAP_FD:
-		if (verbose)
-			printf("Creating BPF map\n");
+		write_verbose(verbose, "Creating BPF map");
 
-		fd = create_bpf_map();
+		ret = create_bpf_map();
 		break;
 	case PROG_FD:
-		if (verbose)
-			printf("Creating BPF prog\n");
+		write_verbose(verbose, "Creating BPF prog");
+
+		ret = create_bpf_prog();
+		break;
+	case MAP_CREATE:
+		is_fd = false;
+		write_verbose(verbose, "Testing BPF map create");
+
+		ret = test_bpf_map_create();
+		break;
+	case PROG_LOAD:
+		is_fd = false;
+		write_verbose(verbose, "Testing BPF prog load");
 
-		fd = create_bpf_prog();
+		ret = test_bpf_prog_load();
 		break;
 	default:
 		usage(argv[0]);
 	}
 
-	if (fd < 0)
-		return fd;
+	if (ret < 0)
+		return ret;
+
+	if (is_fd)
+		close(ret);
 
-	close(fd);
 	return 0;
 }
diff --git a/tests/bpf/test b/tests/bpf/test
index a3fd856..287576e 100755
--- a/tests/bpf/test
+++ b/tests/bpf/test
@@ -6,12 +6,25 @@ BEGIN {
     $basedir =~ s|(.*)/[^/]*|$1|;
     $fdr_basedir    = "$basedir/../fdreceive";
     $binder_basedir = "$basedir/../binder";
+    $test_bpf_token = 0;
 
     $test_bpf_count       = 7;
     $test_fdreceive_count = 4;
 
     $test_count = $test_bpf_count + $test_fdreceive_count;
 
+    if (
+        system(
+"grep -q 1 /sys/fs/selinux/policy_capabilities/bpf_token_perms 2> /dev/null"
+        ) == 0
+      )
+    {
+        $test_bpf_token = 1;
+
+        $test_bpf_token_count = 4;
+        $test_count += $test_bpf_token_count;
+    }
+
     # allow info to be shown during tests
     $v = $ARGV[0];
     if ($v) {
@@ -92,6 +105,28 @@ $result =
   system "runcon -t test_bpf_deny_prog_run_t $basedir/bpf_test -p $v 2>&1";
 ok($result);
 
+if ($test_bpf_token) {
+
+    # BPF token - BPF_MAP_CREATE_AS, BPF_PROG_LOAD_AS
+    $result = system "runcon -t test_bpf_t $basedir/bpf_test -c $v";
+    ok( $result eq 0 );
+
+    $result = system "runcon -t test_bpf_t $basedir/bpf_test -l $v";
+    ok( $result eq 0 );
+
+    # BPF token - deny BPF_MAP_CREATE_AS
+    $result =
+      system
+      "runcon -t test_bpf_deny_map_create_as_t $basedir/bpf_test -c $v 2>&1";
+    ok($result);
+
+    # BPF token - deny BPF_PROG_LOAD_AS
+    $result =
+      system
+      "runcon -t test_bpf_deny_prog_load_as_t $basedir/bpf_test -l $v 2>&1";
+    ok($result);
+}
+
 #
 ################ BPF Tests for fdreceive #######################
 #
diff --git a/tests/bpf/token_test.c b/tests/bpf/token_test.c
new file mode 100644
index 0000000..64f5222
--- /dev/null
+++ b/tests/bpf/token_test.c
@@ -0,0 +1,559 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Code derived from: linux/source/tools/testing/selftests/bpf/prog_tests/token.c
+ * Copyright (c) 2023 Meta Platforms, Inc. and affiliates.
+ */
+
+#include "bpf_common.h"
+#include "signal.h"
+#include "linux/mount.h"
+#include <linux/unistd.h>
+#include "sys/wait.h"
+#include "sys/socket.h"
+#include "fcntl.h"
+#include "sched.h"
+#include <bpf/btf.h>
+
+#define bit(n) (1ULL << (n))
+
+#define zclose(fd) do { if (fd >= 0) close(fd); fd = -1; } while (0)
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+
+#ifdef DEBUG
+#define _CHECK(condition, format...) ({    \
+	int __ret = !!(condition); \
+	int __save_errno = errno;   \
+	if (__ret) {    \
+		fprintf(stderr, ##format);   \
+	}   \
+	errno = __save_errno;   \
+	__ret;  \
+})
+#else
+#define _CHECK(condition, format...) ({    \
+	int __ret = !!(condition); \
+	__ret;  \
+})
+#endif
+
+#define ASSERT_OK(res, name) ({     \
+	long long ___res = (res);       \
+	bool ___ok = ___res == 0;       \
+	_CHECK(!___ok, \
+			"%s failed. unexpected error: %lld (errno %d)\n",  \
+			 name, ___res, errno);  \
+	___ok;                          \
+})
+
+#define ASSERT_GT(actual, expected, name) ({    \
+	typeof(actual) ___act = (actual);   \
+	typeof(expected) ___exp = (expected);   \
+	bool ___ok = ___act > ___exp;       \
+	_CHECK(!___ok,  \
+			"unexpected %s: actual %lld <= expected %lld (errno %d)\n",   \
+			(name), (long long)(___act), (long long)(___exp), errno);  \
+	___ok;  \
+})
+
+#define ASSERT_GE(actual, expected, name) ({    \
+	typeof(actual) ___act = (actual);       \
+	typeof(expected) ___exp = (expected);   \
+	bool ___ok = ___act >= ___exp;          \
+	_CHECK(!___ok,  \
+			"unexpected %s: actual %lld < expected %lld (errno %d)\n",   \
+			(name), (long long)(___act), (long long)(___exp), errno);          \
+	___ok;  \
+})
+
+#define ASSERT_EQ(actual, expected, name) ({    \
+	typeof(actual) ___act = (actual);           \
+	typeof(expected) ___exp = (expected);       \
+	bool ___ok = ___act == ___exp;              \
+	_CHECK(!___ok,   \
+			"unexpected %s: actual %lld != expected %lld (errno %d)\n",   \
+			(name), (long long)(___act), (long long)(___exp), errno);          \
+	___ok;  \
+})
+
+#define ASSERT_OK_PTR(ptr, name) ({     \
+	const void *___res = (ptr);         \
+	int ___err = libbpf_get_error(___res);  \
+	bool ___ok = ___err == 0;           \
+	_CHECK(!___ok,  \
+			"%s unexpected error: %d\n", name, ___err);  \
+	___ok;      \
+})
+
+struct bpffs_opts {
+	__u64 cmds;
+	__u64 maps;
+	__u64 progs;
+	__u64 attachs;
+	const char *cmds_str;
+	const char *maps_str;
+	const char *progs_str;
+	const char *attachs_str;
+};
+
+typedef int (*child_callback_fn)(int bpffs_fd);
+
+static inline int sys_mount(const char *dev_name, const char *dir_name,
+			    const char *type, unsigned long flags,
+			    const void *data)
+{
+	return syscall(__NR_mount, dev_name, dir_name, type, flags, data);
+}
+
+static inline int sys_fsopen(const char *fsname, unsigned int flags)
+{
+	return syscall(__NR_fsopen, fsname, flags);
+}
+
+static inline int sys_fsconfig(int fs_fd, unsigned int cmd, const char *key,
+			       const void *val, int aux)
+{
+	return syscall(__NR_fsconfig, fs_fd, cmd, key, val, aux);
+}
+
+static inline int sys_fsmount(int fs_fd, unsigned int flags,
+			      unsigned int ms_flags)
+{
+	return syscall(__NR_fsmount, fs_fd, flags, ms_flags);
+}
+
+static int set_delegate_mask(int fs_fd, const char *key, __u64 mask,
+			     const char *mask_str)
+{
+	char buf[32];
+	int err;
+
+	if (!mask_str) {
+		if (mask == ~0ULL) {
+			mask_str = "any";
+		} else {
+			snprintf(buf, sizeof(buf), "0x%llx", (unsigned long long)mask);
+			mask_str = buf;
+		}
+	}
+
+	err = sys_fsconfig(fs_fd, FSCONFIG_SET_STRING, key,
+			   mask_str, 0);
+	if (err < 0)
+		err = -errno;
+	return err;
+}
+
+static int create_bpffs_fd(void)
+{
+	int fs_fd;
+
+	/* create VFS context */
+	fs_fd = sys_fsopen("bpf", 0);
+	ASSERT_GE(fs_fd, 0, "fs_fd");
+
+	return fs_fd;
+}
+
+static int materialize_bpffs_fd(int fs_fd, struct bpffs_opts *opts)
+{
+	int mnt_fd, err;
+
+	/* set up token delegation mount options */
+	err = set_delegate_mask(fs_fd, "delegate_cmds", opts->cmds, opts->cmds_str);
+	if (!ASSERT_OK(err, "fs_cfg_cmd"))
+		return err;
+	err = set_delegate_mask(fs_fd, "delegate_maps", opts->maps, opts->maps_str);
+	if (!ASSERT_OK(err, "fs_cfg_maps"))
+		return err;
+	err = set_delegate_mask(fs_fd, "delegate_progs", opts->progs, opts->progs_str);
+	if (!ASSERT_OK(err, "fs_cfg_progs"))
+		return err;
+	err = set_delegate_mask(fs_fd, "delegate_attachs", opts->attachs,
+				opts->attachs_str);
+	if (!ASSERT_OK(err, "fs_cfg_attachs"))
+		return err;
+
+	/* instantiate FS object */
+	err = sys_fsconfig(fs_fd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
+	if (err < 0)
+		return -errno;
+
+	/* create O_PATH fd for detached mount */
+	mnt_fd = sys_fsmount(fs_fd, 0, 0);
+	if (err < 0)
+		return -errno;
+
+	return mnt_fd;
+}
+
+static ssize_t write_nointr(int fd, const void *buf, size_t count)
+{
+	ssize_t ret;
+
+	do {
+		ret = write(fd, buf, count);
+	} while (ret < 0 && errno == EINTR);
+
+	return ret;
+}
+
+static int write_file(const char *path, const void *buf, size_t count)
+{
+	int fd;
+	ssize_t ret;
+
+	fd = open(path, O_WRONLY | O_CLOEXEC | O_NOCTTY | O_NOFOLLOW);
+	if (fd < 0)
+		return -1;
+
+	ret = write_nointr(fd, buf, count);
+	close(fd);
+	if (ret < 0 || (size_t)ret != count)
+		return -1;
+
+	return 0;
+}
+
+static int create_and_enter_userns(void)
+{
+	uid_t uid;
+	gid_t gid;
+	char map[100];
+
+	uid = getuid();
+	gid = getgid();
+
+	if (unshare(CLONE_NEWUSER))
+		return -1;
+
+	if (write_file("/proc/self/setgroups", "deny", sizeof("deny") - 1) &&
+	    errno != ENOENT)
+		return -1;
+
+	snprintf(map, sizeof(map), "0 %d 1", uid);
+	if (write_file("/proc/self/uid_map", map, strlen(map)))
+		return -1;
+
+
+	snprintf(map, sizeof(map), "0 %d 1", gid);
+	if (write_file("/proc/self/gid_map", map, strlen(map)))
+		return -1;
+
+	if (setgid(0))
+		return -1;
+
+	if (setuid(0))
+		return -1;
+
+	return 0;
+}
+
+static int sendfd(int sockfd, int fd)
+{
+	struct msghdr msg = {};
+	struct cmsghdr *cmsg;
+	int fds[1] = { fd }, err;
+	char iobuf[1];
+	struct iovec io = {
+		.iov_base = iobuf,
+		.iov_len = sizeof(iobuf),
+	};
+	union {
+		char buf[CMSG_SPACE(sizeof(fds))];
+		struct cmsghdr align;
+	} u;
+
+	msg.msg_iov = &io;
+	msg.msg_iovlen = 1;
+	msg.msg_control = u.buf;
+	msg.msg_controllen = sizeof(u.buf);
+	cmsg = CMSG_FIRSTHDR(&msg);
+	cmsg->cmsg_level = SOL_SOCKET;
+	cmsg->cmsg_type = SCM_RIGHTS;
+	cmsg->cmsg_len = CMSG_LEN(sizeof(fds));
+	memcpy(CMSG_DATA(cmsg), fds, sizeof(fds));
+
+	err = sendmsg(sockfd, &msg, 0);
+	if (err < 0)
+		err = -errno;
+	if (!ASSERT_EQ(err, 1, "sendmsg"))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int recvfd(int sockfd, int *fd)
+{
+	struct msghdr msg = {};
+	struct cmsghdr *cmsg;
+	int fds[1], err;
+	char iobuf[1];
+	struct iovec io = {
+		.iov_base = iobuf,
+		.iov_len = sizeof(iobuf),
+	};
+	union {
+		char buf[CMSG_SPACE(sizeof(fds))];
+		struct cmsghdr align;
+	} u;
+
+	msg.msg_iov = &io;
+	msg.msg_iovlen = 1;
+	msg.msg_control = u.buf;
+	msg.msg_controllen = sizeof(u.buf);
+
+	err = recvmsg(sockfd, &msg, 0);
+	if (err < 0)
+		err = -errno;
+	if (!ASSERT_EQ(err, 1, "recvmsg"))
+		return -EINVAL;
+
+	cmsg = CMSG_FIRSTHDR(&msg);
+	if (!ASSERT_OK_PTR(cmsg, "cmsg_null") ||
+	    !ASSERT_EQ(cmsg->cmsg_len, CMSG_LEN(sizeof(fds)), "cmsg_len") ||
+	    !ASSERT_EQ(cmsg->cmsg_level, SOL_SOCKET, "cmsg_level") ||
+	    !ASSERT_EQ(cmsg->cmsg_type, SCM_RIGHTS, "cmsg_type"))
+		return -EINVAL;
+
+	memcpy(fds, CMSG_DATA(cmsg), sizeof(fds));
+	*fd = fds[0];
+
+	return 0;
+}
+
+static int wait_for_pid(pid_t pid)
+{
+	int status, ret;
+
+again:
+	ret = waitpid(pid, &status, 0);
+	if (ret == -1) {
+		if (errno == EINTR)
+			goto again;
+
+		return -1;
+	}
+
+	if (!WIFEXITED(status))
+		return -1;
+
+	return WEXITSTATUS(status);
+}
+
+static int child(int sock_fd, struct bpffs_opts *bpffs_opts,
+		 child_callback_fn callback)
+{
+	int mnt_fd = -1, fs_fd = -1, err = 0, bpffs_fd = -1, token_fd = -1;
+
+	err = create_and_enter_userns();
+	if (!ASSERT_OK(err, "create_and_enter_userns"))
+		goto cleanup;
+
+	err = unshare(CLONE_NEWNS);
+	if (!ASSERT_OK(err, "create_mountns"))
+		goto cleanup;
+
+	err = sys_mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0);
+	if (!ASSERT_OK(err, "remount_root"))
+		goto cleanup;
+
+	fs_fd = create_bpffs_fd();
+	if (!ASSERT_GE(fs_fd, 0, "create_bpffs_fd")) {
+		err = -EINVAL;
+		goto cleanup;
+	}
+
+	err = sendfd(sock_fd, fs_fd);
+	if (!ASSERT_OK(err, "send_fs_fd"))
+		goto cleanup;
+	zclose(fs_fd);
+
+	err = recvfd(sock_fd, &mnt_fd);
+	if (!ASSERT_OK(err, "recv_mnt_fd"))
+		goto cleanup;
+
+	bpffs_fd = openat(mnt_fd, ".", 0, O_RDWR);
+	if (!ASSERT_GE(bpffs_fd, 0, "bpffs_open")) {
+		err = -EINVAL;
+		goto cleanup;
+	}
+
+	err = callback(bpffs_fd);
+	if (!ASSERT_OK(err, "test_callback"))
+		goto cleanup;
+
+	err = 0;
+
+cleanup:
+	zclose(sock_fd);
+	zclose(mnt_fd);
+	zclose(fs_fd);
+	zclose(bpffs_fd);
+	zclose(token_fd);
+
+	exit(-err);
+}
+
+static int parent(int child_pid, struct bpffs_opts *bpffs_opts, int sock_fd)
+{
+	int fs_fd = -1, mnt_fd = -1, token_fd = -1, err;
+
+	err = recvfd(sock_fd, &fs_fd);
+	if (!ASSERT_OK(err, "recv_bpffs_fd"))
+		goto cleanup;
+
+	mnt_fd = materialize_bpffs_fd(fs_fd, bpffs_opts);
+	if (!ASSERT_GE(mnt_fd, 0, "materialize_bpffs_fd")) {
+		err = -EINVAL;
+		goto cleanup;
+	}
+	zclose(fs_fd);
+
+	err = sendfd(sock_fd, mnt_fd);
+	if (!ASSERT_OK(err, "send_mnt_fd"))
+		goto cleanup;
+	zclose(mnt_fd);
+
+	err = wait_for_pid(child_pid);
+	if (!ASSERT_OK(err, "waitpid_child")) {
+		err = -EINVAL;
+		goto cleanup;
+	}
+
+cleanup:
+	zclose(sock_fd);
+	zclose(fs_fd);
+	zclose(mnt_fd);
+	zclose(token_fd);
+
+	if (child_pid > 0)
+		(void)kill(child_pid, SIGKILL);
+
+	return err;
+}
+
+static int subtest(struct bpffs_opts *bpffs_opts, child_callback_fn child_cb)
+{
+	int sock_fds[2] = { -1, -1 };
+	int child_pid = 0, err;
+
+	err = socketpair(AF_UNIX, SOCK_STREAM, 0, sock_fds);
+	if (!ASSERT_OK(err, "socketpair"))
+		goto cleanup;
+
+	child_pid = fork();
+	if (!ASSERT_GE(child_pid, 0, "fork"))
+		goto cleanup;
+
+	if (child_pid == 0) {
+		zclose(sock_fds[0]);
+		return child(sock_fds[1], bpffs_opts, child_cb);
+	} else {
+		zclose(sock_fds[1]);
+		return parent(child_pid, bpffs_opts, sock_fds[0]);
+	}
+
+cleanup:
+	zclose(sock_fds[0]);
+	zclose(sock_fds[1]);
+	if (child_pid > 0)
+		(void)kill(child_pid, SIGKILL);
+
+	return -err;
+}
+
+static int userns_map_create(int mnt_fd)
+{
+	LIBBPF_OPTS(bpf_map_create_opts, map_opts);
+	int err = 0, token_fd = -1, map_fd = -1;
+
+	/* create BPF token from BPF FS mount */
+	token_fd = bpf_token_create(mnt_fd, NULL);
+	if (!ASSERT_GT(token_fd, 0, "userns_map_create/token_create")) {
+		err = -EINVAL;
+		goto cleanup;
+	}
+
+	map_opts.map_flags = BPF_F_TOKEN_FD;
+	map_opts.token_fd = token_fd;
+	map_fd = bpf_map_create(BPF_MAP_TYPE_STACK, "userns_map_create", 0, 8, 1,
+				&map_opts);
+	if (!ASSERT_GT(map_fd, 0, "userns_map_create/bpf_map_create")) {
+		err = -EINVAL;
+		goto cleanup;
+	}
+
+cleanup:
+	zclose(token_fd);
+	zclose(map_fd);
+
+	if (err)
+		fprintf(stderr, "Failed to create BPF map with BPF token enabled: %s\n",
+			strerror(errno));
+
+	return err;
+}
+
+static int userns_prog_load(int mnt_fd)
+{
+	LIBBPF_OPTS(bpf_prog_load_opts, prog_opts);
+	int err, token_fd = -1, prog_fd = -1;
+	struct bpf_insn insns[] = {
+		/* bpf_jiffies64() requires CAP_BPF */
+		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_jiffies64),
+		/* bpf_get_current_task() requires CAP_PERFMON */
+		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_current_task),
+		/* r0 = 0; exit; */
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	size_t insn_cnt = ARRAY_SIZE(insns);
+
+	token_fd = bpf_token_create(mnt_fd, NULL);
+	if (!ASSERT_GT(token_fd, 0, "userns_prog_load/token_create")) {
+		err = -EINVAL;
+		goto cleanup;
+	}
+
+	prog_opts.prog_flags = BPF_F_TOKEN_FD;
+	prog_opts.token_fd = token_fd;
+	prog_opts.expected_attach_type = BPF_XDP;
+	prog_fd = bpf_prog_load(BPF_PROG_TYPE_XDP, "token_prog", "GPL",
+				insns, insn_cnt, &prog_opts);
+	if (!ASSERT_GT(prog_fd, 0, "userns_prog_load/bpf_prog_load")) {
+		err = -EPERM;
+		goto cleanup;
+	}
+
+	err = 0;
+
+cleanup:
+	zclose(prog_fd);
+	zclose(token_fd);
+
+	if (err)
+		fprintf(stderr, "Failed to load BPF prog with token enabled: %s\n",
+			strerror(errno));
+
+	return err;
+}
+
+int test_bpf_map_create(void)
+{
+	struct bpffs_opts opts = {
+		.cmds_str = "map_create",
+		.maps_str = "stack"
+	};
+
+	return subtest(&opts, userns_map_create);
+}
+
+int test_bpf_prog_load(void)
+{
+	struct bpffs_opts opts = {
+		.cmds_str = "prog_load",
+		.progs_str = "XDP",
+		.attachs_str = "xdp",
+	};
+
+	return subtest(&opts, userns_prog_load);
+}
-- 
2.50.1

