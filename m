Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450731361
	for <selinux@vger.kernel.org>; Fri,  8 Aug 2025 18:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754678834; cv=none; b=klkABlJ/pLMmMJcd9SW1hOYu3SBVq8zm23damci48Be8sl10OZWHBInLp15HuMXSnlXqd6qWk7bkGXC3Jw8M3RfCZh2wSaM/eYKCtsP2Cj6qy6378gfWxqe2egpUJfMYIpivUmdxov9El3anth3pwe7VXfBM63U0GOZLMSzqrJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754678834; c=relaxed/simple;
	bh=p62ZOIR3A6qPgtH0j8c55svRdivBnQYLHU9a8Hghb8I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z2P/VCbrktjHjG86biSGm6OZiHOMHRLtHPVr5R/5EypX2UP/zgG7yQ+7LsiPP2T6K4TE7uUUL4Fl06i0DV38MfiQ2CNYORWwEI4pjkpBqVJ37diOKkcrFea0HV5i4napzc5qVh9EJIBt1xQYZkSLE0hzthv8fvfL+b5jV9qyUIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=UrmalLTF; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="UrmalLTF"
Received: from ericsu-dev1 (unknown [131.107.160.74])
	by linux.microsoft.com (Postfix) with ESMTPSA id 59B48201BC95;
	Fri,  8 Aug 2025 11:47:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 59B48201BC95
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1754678831;
	bh=6VbCLcyk9OXpBLWjbAKBVS16u0zFNx8ddk/0jmo8Wj4=;
	h=From:To:Cc:Subject:Date:From;
	b=UrmalLTFEoZR43d9a9HDgfYRAMNF9b9DcT4AgaNv771UglgWa45Y6lJCyM6bHLtq+
	 hRlG5vn64jUwEHGlChMRsrlFb3uJDzruLrWEInf/yZI9WDoufyhGfUn7VX60P6DO9R
	 WgX4TKDp01VOO5diI+/T1YGG2sXjAqs2xc37uBhg=
From: Eric Suen <ericsu@linux.microsoft.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	stephen.smalley.work@gmail.com,
	omosnace@redhat.com
Subject: [PATCH testsuite] tests/bpf: Add tests for SELinux BPF token access control
Date: Fri,  8 Aug 2025 11:47:11 -0700
Message-ID: <20250808184711.291-1-ericsu@linux.microsoft.com>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds new tests to verify the SELinux support for BPF token
access control, as introduced in the corresponding kernel patch:
  https://lore.kernel.org/selinux/20250806180149.1995-1-ericsu@linux.microsoft.com/

Four new tests are added to cover both positive and negative scenarios,
ensuring that the SELinux policy enforcement on BPF token usage behaves
as expected.
  - Successful map_create and prog_load when SELinux permissions are
    granted.
  - Enforcement of SELinux policy restrictions when access is denied.

These tests are located under the tests/bpf directory and can be run
using the standard SELinux testsuite workflow.

Signed-off-by: Eric Suen <ericsu@linux.microsoft.com>
---
 policy/test_bpf.te     | 48 ++++++++++++++++++++++++++++++++++
 tests/bpf/Makefile     |  5 ++--
 tests/bpf/bpf_common.h | 10 +++++++
 tests/bpf/bpf_test.c   | 59 ++++++++++++++++++++++++++++++------------
 tests/bpf/test         | 21 ++++++++++++++-
 5 files changed, 124 insertions(+), 19 deletions(-)

diff --git a/policy/test_bpf.te b/policy/test_bpf.te
index 5eab0bd..ef226a8 100644
--- a/policy/test_bpf.te
+++ b/policy/test_bpf.te
@@ -57,3 +57,51 @@ typeattribute test_bpf_deny_prog_run_t bpfdomain;
 allow test_bpf_deny_prog_run_t self:process { setrlimit };
 allow test_bpf_deny_prog_run_t self:capability { sys_resource sys_admin };
 allow test_bpf_deny_prog_run_t self:bpf { map_create map_read map_write prog_load };
+
+################### Allow map_create_as and prog_load_as ###################
+fs_list_bpf_dirs(test_bpf_t);
+allow kernel_t test_bpf_t:bpf map_create;
+allow test_bpf_t bpf_t:dir { ioctl open read search };
+allow test_bpf_t bpf_t:filesystem mount;
+allow test_bpf_t root_t:dir mounton;
+allow test_bpf_t self:bpf { map_create_as prog_load_as };
+allow test_bpf_t self:cap2_userns { bpf perfmon };
+allow test_bpf_t self:cap_userns { net_admin setgid setuid sys_admin };
+allow test_bpf_t self:user_namespace create;
+allow test_bpf_t unlabeled_t:dir search;
+
+############################ Deny map_create_as ############################
+type test_bpf_deny_map_create_as_t;
+testsuite_domain_type(test_bpf_deny_map_create_as_t)
+typeattribute test_bpf_deny_map_create_as_t bpfdomain;
+allow test_bpf_deny_map_create_as_t self:process { setrlimit };
+allow test_bpf_deny_map_create_as_t self:capability { sys_resource sys_admin };
+
+fs_list_bpf_dirs(test_bpf_deny_map_create_as_t);
+allow kernel_t test_bpf_deny_map_create_as_t:bpf map_create;
+allow test_bpf_deny_map_create_as_t bpf_t:dir { ioctl open read search };
+allow test_bpf_deny_map_create_as_t bpf_t:filesystem mount;
+allow test_bpf_deny_map_create_as_t root_t:dir mounton;
+allow test_bpf_deny_map_create_as_t self:bpf { prog_load_as };
+allow test_bpf_deny_map_create_as_t self:cap2_userns { bpf perfmon };
+allow test_bpf_deny_map_create_as_t self:cap_userns { net_admin setgid setuid sys_admin };
+allow test_bpf_deny_map_create_as_t self:user_namespace create;
+allow test_bpf_deny_map_create_as_t unlabeled_t:dir search;
+
+############################ Deny prog_load_as #############################
+type test_bpf_deny_prog_load_as_t;
+testsuite_domain_type(test_bpf_deny_prog_load_as_t)
+typeattribute test_bpf_deny_prog_load_as_t bpfdomain;
+allow test_bpf_deny_prog_load_as_t self:process { setrlimit };
+allow test_bpf_deny_prog_load_as_t self:capability { sys_resource sys_admin };
+
+fs_list_bpf_dirs(test_bpf_deny_prog_load_as_t);
+allow kernel_t test_bpf_deny_prog_load_as_t:bpf map_create;
+allow test_bpf_deny_prog_load_as_t bpf_t:dir { ioctl open read search };
+allow test_bpf_deny_prog_load_as_t bpf_t:filesystem mount;
+allow test_bpf_deny_prog_load_as_t root_t:dir mounton;
+allow test_bpf_deny_prog_load_as_t self:bpf { map_create_as };
+allow test_bpf_deny_prog_load_as_t self:cap2_userns { bpf perfmon };
+allow test_bpf_deny_prog_load_as_t self:cap_userns { net_admin setgid setuid sys_admin };
+allow test_bpf_deny_prog_load_as_t self:user_namespace create;
+allow test_bpf_deny_prog_load_as_t unlabeled_t:dir search;
diff --git a/tests/bpf/Makefile b/tests/bpf/Makefile
index 1ae8ce9..cacefbe 100644
--- a/tests/bpf/Makefile
+++ b/tests/bpf/Makefile
@@ -1,5 +1,5 @@
 TARGETS = bpf_test
-DEPS = bpf_common.c bpf_common.h
+SRCS = bpf_test.c bpf_common.c token_test.c
 LDLIBS += -lselinux -lbpf
 
 # export so that BPF_ENABLED entries get built correctly on local build
@@ -14,4 +14,5 @@ clean:
 	rm -f $(TARGETS) test_sock flag *_flag
 	@set -e; for i in $(BPF_ENABLED); do $(MAKE) -C $$i clean ; done
 
-$(TARGETS): $(DEPS)
+$(TARGETS): $(SRCS)
+	$(CC) $(CFLAGS) -o $@ $^ $(LDLIBS)
\ No newline at end of file
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
index a3fd856..aefc70c 100755
--- a/tests/bpf/test
+++ b/tests/bpf/test
@@ -9,8 +9,10 @@ BEGIN {
 
     $test_bpf_count       = 7;
     $test_fdreceive_count = 4;
+    $test_bpf_token_count = 4;
 
-    $test_count = $test_bpf_count + $test_fdreceive_count;
+    $test_count = $test_bpf_count + $test_fdreceive_count +
+                  $test_bpf_token_count;
 
     # allow info to be shown during tests
     $v = $ARGV[0];
@@ -67,6 +69,13 @@ ok( $result eq 0 );
 $result = system "runcon -t test_bpf_t $basedir/bpf_test -p $v";
 ok( $result eq 0 );
 
+# BPF token - BPF_MAP_CREATE_AS, BPF_PROG_LOAD_AS
+$result = system "runcon -t test_bpf_t $basedir/bpf_test -c $v";
+ok ( $result eq 0 );
+
+$result = system "runcon -t test_bpf_t $basedir/bpf_test -l $v";
+ok ( $result eq 0 );
+
 # Deny map_create permission
 $result =
   system "runcon -t test_bpf_deny_map_create_t $basedir/bpf_test -m $v 2>&1";
@@ -92,6 +101,16 @@ $result =
   system "runcon -t test_bpf_deny_prog_run_t $basedir/bpf_test -p $v 2>&1";
 ok($result);
 
+# BPF token - deny BPF_MAP_CREATE_AS
+$result =
+  system "runcon -t test_bpf_deny_map_create_as_t $basedir/bpf_test -c $v 2>&1";
+ok($result);
+
+# BPF token - deny BPF_PROG_LOAD_AS
+$result =
+  system "runcon -t test_bpf_deny_prog_load_as_t $basedir/bpf_test -l $v 2>&1";
+ok($result);
+
 #
 ################ BPF Tests for fdreceive #######################
 #
-- 
2.50.1.windows.1

