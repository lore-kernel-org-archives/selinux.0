Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.125.25.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794910741;
	b=0h+lkcCKBESA7WEb8OCt+lXEv8/HfEZ1/NUlgPdlwl/oPgz6O+2tSL0PLPEeHmNIABQ1
	 X30ZbyEmzYRPvzno8/8lurwG50gCuaNGGIWw2iZ22kJxJDw5738sQF8351j0ol1axIkt3
	 VYDmB9w6E+Jewbrawd0hahiHZqBThieT4vvl2onaohYiZoENLtmFCOI1txMt4fEj/iTRN
	 wvcUDhzFa5w4iD9it++4wTqSio7Jf/cqlqHk/ZYNcLSB5ow8+Wc3g0yz1hL/9CyC558fL
	 ztDoG57v8SmcINMZ9jwFwx+VzCLAeJfOIxGrbyRhbNwrFUnNzVvqekPn4xXM6UW9UhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794910741;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Infomaniak-Routing;
	bh=/FVkAVmysI3nzoI1x0oBDOLXOnkIo/vEal3TNCx8hmg=;
	b=mesoUUBAEMHY9oYbjeUJpdzXHbJdQ8MkYGF9ayuDu17WRY/Z2d1Vq4SALlpwEO1RSfW8
	 h1bU75xgWfGZDfmA0dp6DztBlKs9IYQrTE95vOZ7eMGNNo/bs/0hRGYJJRcY231EB2ItA
	 B4R92GkKCArbR66fKxm8HGhGFQkz3Z03VM1L3hsMKOZkg9mRkEM2358typOn5az5itrAc
	 WJwlstmxE0AjkCUAg0op6vFacKNqjneoS4w7gv1ht/63+kzgfLUIA7Xdmn5UwmB48Gr7P
	 +RCOrnv9iKF3qjnMknKKoqquvf5J/5DhAhYpVE3zSctBU+XOhN996THXT+ywYF+kjVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=digikod.net;
	spf=pass smtp.mailfrom=digikod.net;
	dkim=pass header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=KLx8nqUb;
	arc=none smtp.remote-ip=185.125.25.9
Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch [185.125.25.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CE8606A889;
	Tue, 17 Nov 2026 10:19:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9CE8606A889
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=KLx8nqUb
Received: from smtp-4-0001 (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jTLLC0vC6zWDZ;
	Tue, 17 Nov 2026 11:18:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1794910738;
	bh=/FVkAVmysI3nzoI1x0oBDOLXOnkIo/vEal3TNCx8hmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KLx8nqUbJ5b6/SD7u7R0jjlglg9nHy5Srtf0Bh08xz10YPmlg9tH5uXgzcBujJeGz
	 bIsv7DRbEWmLLDl9+YbhPpnaSwWg8mkjFwso+XkgCFLyphidorUPDgczkBPRewK1Wv
	 2St/KHBtmt5/7DcRZl/GNunHgKiUWpjcdQ0qipyY=
Received: from unknown by smtp-4-0001 (Postfix) with ESMTPA id 4jTLL93Xg8zVBq;
	Tue, 17 Nov 2026 11:18:57 +0100 (CET)
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
Subject: [PATCH v2 6/6] selftests/landlock: Test capabilities guarding other LSMs' policies
Date: Tue, 17 Nov 2026 11:18:43 +0100
Message-ID: <20261117101845.2523770-7-mic@digikod.net>
In-Reply-To: <20261117101845.2523770-1-mic@digikod.net>
References: <20261117101845.2523770-1-mic@digikod.net>
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

Cc: Casey Schaufler <casey@schaufler-ca.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Günther Noack <gnoack@google.com>
Cc: John Johansen <john.johansen@canonical.com>
Cc: Paul Moore <paul@paul-moore.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v1:
https://patch.msgid.link/20261110203042.2410140-7-mic@digikod.net
- Switch to EUID 0 before loading AppArmor policy, which also requires
  the root UID or GID (reported by Sashiko).
---
 tools/testing/selftests/landlock/cap_test.c | 240 +++++++++++++++++++-
 tools/testing/selftests/landlock/common.h   |   2 +
 2 files changed, 237 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/landlock/cap_test.c b/tools/testing/selftests/landlock/cap_test.c
index 144ae866c3bd..a84a1b5d82aa 100644
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
@@ -976,6 +981,190 @@ TEST_F(cap_other_hooks, capset_inheritable)
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
+/* Switching to EUID 0 raises all permitted capabilities, so drop them again. */
+static void set_root_euid(struct __test_metadata *const _metadata)
+{
+	set_cap(_metadata, CAP_SETUID);
+	ASSERT_EQ(0, seteuid(0));
+	disable_caps(_metadata);
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
+	/* AppArmor also requires the root UID or GID to manage policy. */
+	set_root_euid(_metadata);
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
  * cap_vm_enough_memory() lets CAP_SYS_ADMIN use the vm.admin_reserve_kbytes
  * reserve, but only with vm.overcommit_memory=2.  The Landlock check of this
@@ -1233,6 +1422,47 @@ TEST_F(cap_audit, other_hooks_allowed)
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

