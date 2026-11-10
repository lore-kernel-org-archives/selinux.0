Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=84.16.66.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794342659;
	b=imeyk/Nw1YgBshHo+Faf3f0sQXaHZa1X1ErAy0lucVb41hPNR1b62RD3LyyvUL7PiQ4T
	 444TX4bxY/AkzWED72LlRdSJnrO6r+QOSQ424mudnF2rabWGr1Oe6qNZKHyziXKVdk6r9
	 jFQRk8iG2Lr3kWkiwBnAfDx61qD3g802MY0JokxmTqcsI+HPGjzIlfDT41zI5swX67t5t
	 Ml57b+RI+qkTXRMzoTPsXbRlkVDDrHCK1Tsuc63D1+YyGVyBdb3TiIVB9x3WepT/uR4ga
	 2X/peiT1JXgLHgLSNDxjkbN7mgY+fTBfsI76hf9Ye4MkQnEiu+b/JM3Pt+P21UKF5LA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342659;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Infomaniak-Routing;
	bh=gfuupJbALZD+q1BFqL8+mKjX6fPsKBJ1ASODJI4cCsU=;
	b=VZsylhXqoasw3vzL3t1LVK2dyURAgJRWTu2Vu+JFwx8qyRq3tt6Kx5Vxt5sDALSndAN2
	 OXEsvWyApjoybNoh1LE+F0MDCBjH7qkL4Tt6lhPNjqkk6UKEG/wT+HWyDORH793HVIz4J
	 psSouLkGh0hLqXyxI+ibRWZFHnhf1Lp1NcrJcWNwQrb2LLH5SYpP/YJTpUXulJwyNkSW2
	 sQiXboAYR7wNUUKNfFyvstd/Q8eC1b0nSBNeRvb0jO7X6W9UxTJ97XDqM64Y7yl5xS+rz
	 BQMXh6Iu4IaAAudRA8Wv3lQMoPUaq3VtjElrEp3HoxScUBcs8osC/ijF2D3oKPfBYXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=digikod.net;
	spf=pass smtp.mailfrom=digikod.net;
	dkim=pass header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=gfe3b7Pb;
	arc=none smtp.remote-ip=84.16.66.171
Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch [84.16.66.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE67607251D
	for <selinux@vger.kernel.org>; Tue, 10 Nov 2026 20:30:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BE67607251D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=gfe3b7Pb
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jPJFX6rzDz2tJ;
	Tue, 10 Nov 2026 21:30:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1794342656;
	bh=gfuupJbALZD+q1BFqL8+mKjX6fPsKBJ1ASODJI4cCsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gfe3b7PbrK1pwxlTCEigGYxsIcmWXZwT8Ad9jzQ5qFilWGNYvB89XEcBukEca2Qj9
	 2Uba4CpIAn6cuCaLr/U8lunpukVt/AfyoXi6MvQnEUeVMBzT+Q5y3x0ClkpDIP8TPG
	 a/TwhXuXeiMSkpWs2elLSMCS/mid6RjUP4Cl+jqs=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4jPJFW2pGSzxC2;
	Tue, 10 Nov 2026 21:30:55 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Casey Schaufler <casey@schaufler-ca.com>,
	Georgia Garcia <georgia.garcia@canonical.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	James Morris <jmorris@namei.org>,
	John Johansen <john.johansen@canonical.com>,
	=?UTF-8?q?Ondrej=20Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	Serge Hallyn <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Christian Brauner <brauner@kernel.org>,
	KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <matt@bobrowski.net>,
	apparmor@lists.ubuntu.com,
	bpf@vger.kernel.org,
	kernel-team@cloudflare.com,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org
Subject: [PATCH 6/6] selftests/landlock: Test capabilities guarding other LSMs' policies
Date: Tue, 10 Nov 2026 21:30:40 +0100
Message-ID: <20261110203042.2410140-7-mic@digikod.net>
In-Reply-To: <20261110203042.2410140-1-mic@digikod.net>
References: <20261110203042.2410140-1-mic@digikod.net>
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Check that a domain denying CAP_MAC_ADMIN prevents a process from
changing a file's Smack label and from loading AppArmor policy.  Also
check that denying CAP_MAC_OVERRIDE prevents a process from bypassing
Smack rules between sockets with distinct labels.  The allowed,
unhandled and unsandboxed variants retain each capability, and an audit
test checks both Smack denials.

Smack and AppArmor are optional and are not added to the test
configuration: each test is skipped if its LSM is not active according
to lsm_list_modules(2), and fails if this syscall fails.  The default
test configuration has no other LSM, so these tests skip there and the
capable_lsm hook is not exercised.

The cap_other_hooks fixture now covers more than commoncap's checks, so
update its description, and add CAP_MAC_ADMIN and CAP_MAC_OVERRIDE to
the capabilities that the tests may raise.

Without the previous commits, the denied variants and the audit test
fail with Smack (boot with lsm=landlock,smack), and the denied variants
fail with AppArmor (lsm=landlock,apparmor).

Test coverage for security/landlock is 91.7% of 2844 lines according to
LLVM 18.

Cc: Casey Schaufler <casey@schaufler-ca.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Günther Noack <gnoack@google.com>
Cc: John Johansen <john.johansen@canonical.com>
Cc: Paul Moore <paul@paul-moore.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 tools/testing/selftests/landlock/cap_test.c | 230 +++++++++++++++++++-
 tools/testing/selftests/landlock/common.h   |   2 +
 2 files changed, 227 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/landlock/cap_test.c b/tools/testing/selftests/landlock/cap_test.c
index 741567c5ab41..7f9b7fb2bade 100644
--- a/tools/testing/selftests/landlock/cap_test.c
+++ b/tools/testing/selftests/landlock/cap_test.c
@@ -10,12 +10,16 @@
 #include <fcntl.h>
 #include <linux/capability.h>
 #include <linux/landlock.h>
+#include <linux/lsm.h>
+#include <linux/xattr.h>
 #include <sched.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 #include <sys/mman.h>
 #include <sys/mount.h>
+#include <sys/socket.h>
+#include <sys/syscall.h>
 #include <sys/wait.h>
 #include <sys/xattr.h>
 #include <unistd.h>
@@ -741,11 +745,12 @@ TEST(cap_target_userns_independent)
 }
 
 /*
- * Capability checks that commoncap makes from hooks other than the capable
- * hook.  Each test first checks that the operation needs the capability, then
- * checks it with the capability effective.  Variants cover an unsandboxed
- * baseline, a domain that denies the capability, a domain that allows it, and a
- * domain that does not handle capabilities.
+ * Capability checks that do not go through the capable hook: commoncap's checks
+ * from other hooks, and other LSMs' checks for their own policy.  Each test
+ * first checks that the operation needs the capability, then checks it with the
+ * capability effective.  Variants cover an unsandboxed baseline, a domain that
+ * denies the capability, a domain that allows it, and a domain that does not
+ * handle capabilities.
  */
 /* clang-format off */
 FIXTURE(cap_other_hooks) {};
@@ -969,6 +974,180 @@ TEST_F(cap_other_hooks, capset_inheritable)
 	clear_cap(_metadata, CAP_SETPCAP);
 }
 
+/* Much more than the number of LSMs that can be active at the same time. */
+#define LSM_IDS_MAX 64
+
+static bool is_lsm_active(struct __test_metadata *const _metadata,
+			  const __u64 lsm_id)
+{
+	__u64 ids[LSM_IDS_MAX];
+	__u32 size = sizeof(ids);
+	long count, i;
+
+	count = syscall(__NR_lsm_list_modules, ids, &size, 0);
+	ASSERT_LE(0, count)
+	{
+		TH_LOG("Failed to list LSMs: %s", strerror(errno));
+	}
+	for (i = 0; i < count; i++) {
+		if (ids[i] == lsm_id)
+			return true;
+	}
+	return false;
+}
+
+/*
+ * The following tests check capabilities that guard another LSM's policy, which
+ * that LSM checks with security_capable_lsm().  These LSMs are optional, and
+ * are not in the test configuration: each test is skipped if its LSM is not
+ * active (e.g., boot with lsm=landlock,smack).  Not tested here: SELinux only
+ * checks CAP_MAC_ADMIN this way when a policy is loaded, and AppArmor only
+ * checks CAP_MAC_OVERRIDE this way for unconfined profile changes when the
+ * kernel.apparmor_restrict_unprivileged_unconfined sysctl is set.
+ */
+
+/* Returns an FD to a new file on a private tmpfs. */
+static int create_private_file(struct __test_metadata *const _metadata)
+{
+	int fd;
+
+	set_cap(_metadata, CAP_SYS_ADMIN);
+	ASSERT_EQ(0, unshare(CLONE_NEWNS));
+	ASSERT_EQ(0, mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, NULL));
+	ASSERT_EQ(0, mount("test", "/tmp", "tmpfs", 0, NULL));
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+	fd = open("/tmp/f", O_CREAT | O_RDWR | O_CLOEXEC, 0600);
+	ASSERT_LE(0, fd);
+	return fd;
+}
+
+static const char smack_out_label[] = "landlock-out";
+static const char smack_in_label[] = "landlock-in";
+
+/* Creates connected sockets whose Smack labels deny writes. */
+static void create_smack_socketpair(struct __test_metadata *const _metadata,
+				    int socket_fds[2])
+{
+	ASSERT_EQ(0, socketpair(AF_UNIX, SOCK_DGRAM | SOCK_CLOEXEC, 0,
+				socket_fds));
+	set_cap(_metadata, CAP_MAC_ADMIN);
+	ASSERT_EQ(0,
+		  fsetxattr(socket_fds[0], XATTR_NAME_SMACKIPOUT,
+			    smack_out_label, sizeof(smack_out_label) - 1, 0));
+	ASSERT_EQ(0, fsetxattr(socket_fds[1], XATTR_NAME_SMACKIPIN,
+			       smack_in_label, sizeof(smack_in_label) - 1, 0));
+	clear_cap(_metadata, CAP_MAC_ADMIN);
+}
+
+/* Smack requires CAP_MAC_ADMIN to change a file's Smack label. */
+TEST_F(cap_other_hooks, smack_relabel)
+{
+	int fd;
+
+	if (!is_lsm_active(_metadata, LSM_ID_SMACK))
+		SKIP(return, "Smack is not active");
+
+	fd = create_private_file(_metadata);
+	enforce_cap_variant(_metadata, variant, CAP_MAC_ADMIN);
+
+	EXPECT_EQ(-1, fsetxattr(fd, "security.SMACK64", "_", 1, 0));
+	EXPECT_EQ(EPERM, errno);
+
+	set_cap(_metadata, CAP_MAC_ADMIN);
+	if (variant->is_allowed) {
+		EXPECT_EQ(0, fsetxattr(fd, "security.SMACK64", "_", 1, 0))
+		{
+			TH_LOG("Failed to set the Smack label: %s",
+			       strerror(errno));
+		}
+	} else {
+		EXPECT_EQ(-1, fsetxattr(fd, "security.SMACK64", "_", 1, 0));
+		EXPECT_EQ(EPERM, errno);
+	}
+	clear_cap(_metadata, CAP_MAC_ADMIN);
+	EXPECT_EQ(0, close(fd));
+}
+
+/* CAP_MAC_OVERRIDE bypasses Smack label rules. */
+TEST_F(cap_other_hooks, smack_override)
+{
+	int socket_fds[2];
+
+	if (!is_lsm_active(_metadata, LSM_ID_SMACK))
+		SKIP(return, "Smack is not active");
+
+	create_smack_socketpair(_metadata, socket_fds);
+
+	/* The distinct Smack labels deny writes without an override. */
+	EXPECT_EQ(-1, send(socket_fds[0], "x", 1, 0));
+	EXPECT_EQ(EACCES, errno);
+
+	enforce_cap_variant(_metadata, variant, CAP_MAC_OVERRIDE);
+	set_cap(_metadata, CAP_MAC_OVERRIDE);
+	if (variant->is_allowed) {
+		EXPECT_EQ(1, send(socket_fds[0], "x", 1, 0));
+	} else {
+		EXPECT_EQ(-1, send(socket_fds[0], "x", 1, 0));
+		EXPECT_EQ(EACCES, errno);
+	}
+	clear_cap(_metadata, CAP_MAC_OVERRIDE);
+
+	EXPECT_EQ(0, close(socket_fds[0]));
+	EXPECT_EQ(0, close(socket_fds[1]));
+}
+
+#define APPARMOR_LOAD_PATH "/sys/kernel/security/apparmor/.load"
+
+/*
+ * Returns the errno of writing to AppArmor's policy load interface, or 0 on
+ * success.  The written data is not a valid policy: a task that may not manage
+ * policy gets EACCES, and any other task gets EPROTONOSUPPORT.
+ */
+static int write_apparmor_load(struct __test_metadata *const _metadata)
+{
+	int fd, err = 0;
+
+	fd = open(APPARMOR_LOAD_PATH, O_WRONLY | O_CLOEXEC);
+	ASSERT_LE(0, fd)
+	{
+		TH_LOG("Failed to open %s: %s", APPARMOR_LOAD_PATH,
+		       strerror(errno));
+	}
+	if (write(fd, "x", 1) < 0)
+		err = errno;
+	EXPECT_EQ(0, close(fd));
+	return err;
+}
+
+/* AppArmor requires CAP_MAC_ADMIN to load policy. */
+TEST_F(cap_other_hooks, apparmor_policy_load)
+{
+	if (!is_lsm_active(_metadata, LSM_ID_APPARMOR))
+		SKIP(return, "AppArmor is not active");
+
+	if (access(APPARMOR_LOAD_PATH, F_OK)) {
+		set_cap(_metadata, CAP_SYS_ADMIN);
+		ASSERT_EQ(0, unshare(CLONE_NEWNS));
+		ASSERT_EQ(0, mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, NULL));
+		ASSERT_EQ(0, mount("securityfs", "/sys/kernel/security",
+				   "securityfs", 0, NULL));
+		clear_cap(_metadata, CAP_SYS_ADMIN);
+	}
+	ASSERT_EQ(0, access(APPARMOR_LOAD_PATH, F_OK));
+
+	enforce_cap_variant(_metadata, variant, CAP_MAC_ADMIN);
+
+	EXPECT_EQ(EACCES, write_apparmor_load(_metadata));
+
+	set_cap(_metadata, CAP_MAC_ADMIN);
+	if (variant->is_allowed) {
+		EXPECT_EQ(EPROTONOSUPPORT, write_apparmor_load(_metadata));
+	} else {
+		EXPECT_EQ(EACCES, write_apparmor_load(_metadata));
+	}
+	clear_cap(_metadata, CAP_MAC_ADMIN);
+}
+
 /*
  * With vm.overcommit_memory=2, cap_vm_enough_memory() lets CAP_SYS_ADMIN use
  * the vm.admin_reserve_kbytes reserve.  The test sets a commit limit that
@@ -1432,6 +1611,47 @@ TEST_F(cap_audit, other_hooks_allowed)
 	EXPECT_EQ(0, records.access);
 }
 
+/* Denials in the capable_lsm hook are audited like capable hook denials. */
+TEST_F(cap_audit, smack)
+{
+	struct audit_records records = {};
+	int ruleset_fd, fd, socket_fds[2];
+	__u64 domain_id;
+
+	if (!is_lsm_active(_metadata, LSM_ID_SMACK))
+		SKIP(return, "Smack is not active");
+
+	fd = create_private_file(_metadata);
+	create_smack_socketpair(_metadata, socket_fds);
+	ruleset_fd = create_cap_ruleset();
+	ASSERT_LE(0, ruleset_fd);
+	/* Allow CAP_AUDIT_CONTROL for child-side audit cleanup. */
+	ASSERT_EQ(0, add_cap_rule(ruleset_fd, CAP_AUDIT_CONTROL));
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	set_cap(_metadata, CAP_MAC_ADMIN);
+	EXPECT_EQ(-1, fsetxattr(fd, "security.SMACK64", "_", 1, 0));
+	EXPECT_EQ(EPERM, errno);
+	clear_cap(_metadata, CAP_MAC_ADMIN);
+	EXPECT_EQ(0, close(fd));
+
+	set_cap(_metadata, CAP_MAC_OVERRIDE);
+	EXPECT_EQ(-1, send(socket_fds[0], "x", 1, 0));
+	EXPECT_EQ(EACCES, errno);
+	clear_cap(_metadata, CAP_MAC_OVERRIDE);
+	EXPECT_EQ(0, close(socket_fds[0]));
+	EXPECT_EQ(0, close(socket_fds[1]));
+
+	EXPECT_EQ(0, matches_log_cap(self->audit_fd, CAP_MAC_ADMIN));
+	EXPECT_EQ(0, matches_log_domain_allocated(self->audit_fd, getpid(),
+						  &domain_id));
+	EXPECT_EQ(0, matches_log_cap(self->audit_fd, CAP_MAC_OVERRIDE));
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	EXPECT_EQ(0, records.access);
+	EXPECT_EQ(0, records.domain);
+}
+
 TEST_F(cap_audit, allowed)
 {
 	struct audit_records records = {};
diff --git a/tools/testing/selftests/landlock/common.h b/tools/testing/selftests/landlock/common.h
index a6fdfb422fad..77a8278fe89a 100644
--- a/tools/testing/selftests/landlock/common.h
+++ b/tools/testing/selftests/landlock/common.h
@@ -41,6 +41,8 @@ static void _init_caps(struct __test_metadata *const _metadata, bool drop_all)
 		/* clang-format off */
 		CAP_AUDIT_CONTROL,
 		CAP_DAC_OVERRIDE,
+		CAP_MAC_ADMIN,
+		CAP_MAC_OVERRIDE,
 		CAP_MKNOD,
 		CAP_NET_ADMIN,
 		CAP_NET_BIND_SERVICE,
-- 
2.56.0

