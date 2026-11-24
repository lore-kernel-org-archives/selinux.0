Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795561201;
	b=kOzHm5G5R2USPXHQonqB90b1QgcZx0JFmvAIILbLT8FHq8nKjjBVu8JglPd/NpOwq/rj
	 sFeRi4ifdFIJdpA6HnJ0iErHFml7r5GgPUtgdjuxTyuFePphAJnLDRN3RQHeAMWZzzSX+
	 f1ZKcO0Bxj4R67pXcMsfc7dDJUWez6dWgz82jQSHNe3rUvQ9lIhHVOIfwrjJeAO6dE2cB
	 03rea/teBKBQUfGYH+9Fvf4IfuTb8zHNPJ7M3gZBqprcYfwudT+Jedx9pLgw5mfZBQlSA
	 Xr9VoiwCTvuwiw2ehPSGoWBLR26UVzPpmYMkdKXLjiTIpasYWmHUVpFAWswVlxTy08Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795561201;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=2C+rk0NMFrbNe0MIF80ZOVKYf9Ba1s/rRNRNQryPHiI=;
	b=YRyMPKDEwDdzfGuJ7No80GL0/VyOebyJrjnsxoq9Rl89CvAGMW3Mk3+jpxfvzPoBd+lN
	 UQihrwfCeQwelxjc4uTVJ0X644vansUrAxGYIebHOscHl9MyKp2WkM7nnG/bAZdk0odzI
	 efGDgWB1misFSCNAObNsEAuBXAxN+gjwXErQU9T3HaoNlq/I3aAO/Mm5OySX/Djtwrn6+
	 2z1KMUQhJGR8e4TpO1Kmkl9jnabLN9CBxLx0QmkSY2a0Ad25R3dS+F9z4rDDoONFus8Do
	 MiGQN/C3DnczZn+7QezU4HsD63TBF2be63g5MDJAoHVL8UCBixYHlXblPF2/iEmg13A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hoYetZWl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C35606A323;
	Tue, 24 Nov 2026 23:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hoYetZWl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAAFD1F00A03;
	Tue, 24 Nov 2026 22:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795561200;
	bh=2C+rk0NMFrbNe0MIF80ZOVKYf9Ba1s/rRNRNQryPHiI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=hoYetZWllIRpmPQF74b7ybaKlEXv909X9hNNs3Vh3+uUBNryWcSAREVRtA2X8aGQK
	 R+B58C1v8sVQBTKcBmlfOmtFmKAHG8mh+5r4Z1GT4jzelIBRvs9r+JQwOOl6BVrJJ7
	 DNthuig7J98GenpKv0/mReuEIadEb9NPzjLLg+wYCQiMIZVDMBr9do2cKIK3toXV3P
	 56Y5TToG+R5vWWB67rigS/Cgv+m3XyBNFZ5qXSvLJD+gSQ4AD4pq+ECkfedjLOIYzQ
	 ZKCFxfnRWVYUFVURfD2npzjWd3OurLpzmkAlvrSy807UQlFpMqYch4YAvz20Pv9nai
	 V4uxt/vinYcXA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 24 Nov 2026 23:58:31 +0100
Subject: [PATCH RFC 08/19] selftests/exec: test exec with a shared signal
 table
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-work-exec-update_lock-v1-8-e489035395b8@kernel.org>
References: <20261124-work-exec-update_lock-v1-0-e489035395b8@kernel.org>
In-Reply-To: <20261124-work-exec-update_lock-v1-0-e489035395b8@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-fsdevel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
 selinux@vger.kernel.org, Kees Cook <kees@kernel.org>, linux-mm@kvack.org, 
 linux-security-module@vger.kernel.org, apparmor@lists.ubuntu.com, 
 David Hildenbrand <david@kernel.org>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-04696
X-Developer-Signature: v=1; a=openpgp-sha256; l=9968; i=brauner@kernel.org;
 h=from:subject:message-id; bh=llT2zgJ1sk7ce873wnC1YeARhaC2FQU0cnTsE6LZXFk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSzie2PE47dV/bx2BTe7uYVVjOtjOQW+3rzuSy5uYXN+
 ZnNvIb7HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPx28nw3ydz64Pc7LnzDSJ9
 invWGixn/rbaOTqXLWnfQ7/X340zdzL803h4stxgCf+RQykSz4xL93x6o3ZwVzeP286ePu1pMYs
 EWQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test that exec gives a task that shares its signal table with another
process a private one:

- handlers the processes shared are reset in the new image

- an ignored signal stays ignored in the new image

- the other process keeps all of its handlers

- a signal the other process ignores right after vfork() returned isn't
  ignored in the new image

The task is created with CLONE_SIGHAND but without CLONE_THREAD so it
isn't taken care of by de_thread(). For the last one the parent runs in
a realtime scheduling class on the cpu of the task so that it gets to
ignore the signal as soon as it's woken up.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 tools/testing/selftests/exec/.gitignore        |   1 +
 tools/testing/selftests/exec/Makefile          |   2 +
 tools/testing/selftests/exec/unshare-sighand.c | 236 +++++++++++++++++++++++++
 3 files changed, 239 insertions(+)

diff --git a/tools/testing/selftests/exec/.gitignore b/tools/testing/selftests/exec/.gitignore
index 4613c68537395..b27f4db42f87b 100644
--- a/tools/testing/selftests/exec/.gitignore
+++ b/tools/testing/selftests/exec/.gitignore
@@ -16,6 +16,7 @@ null-argv
 !load_address.c
 /recursion-depth
 /set-exec
+/unshare-sighand
 /update-lock-fault
 xxxxxxxx*
 pipe
diff --git a/tools/testing/selftests/exec/Makefile b/tools/testing/selftests/exec/Makefile
index 3756a250f9591..70f090a5f7648 100644
--- a/tools/testing/selftests/exec/Makefile
+++ b/tools/testing/selftests/exec/Makefile
@@ -21,6 +21,7 @@ TEST_GEN_PROGS += recursion-depth
 TEST_GEN_PROGS += null-argv
 TEST_GEN_PROGS += check-exec
 TEST_GEN_PROGS += update-lock-fault
+TEST_GEN_PROGS += unshare-sighand
 
 # binfmt_misc must not be reachable as an exec source or as a stacking layer,
 # or an 'F' entry can pin the instance that owns it. Unprivileged, no bpf.
@@ -117,6 +118,7 @@ $(OUTPUT)/binfmt_misc_interplimit: CFLAGS += $(TOOLS_INCLUDES)
 $(OUTPUT)/binfmt_misc_interplimit: ../filesystems/utils.c
 
 $(OUTPUT)/update-lock-fault: LDLIBS += -lpthread
+$(OUTPUT)/unshare-sighand: LDLIBS += -lpthread
 
 # --- binfmt_misc bpf ('B') handler test ---------------------------------
 # The struct_ops bpf objects are compiled against the running kernel's BTF.
diff --git a/tools/testing/selftests/exec/unshare-sighand.c b/tools/testing/selftests/exec/unshare-sighand.c
new file mode 100644
index 0000000000000..425b46d4d5c9c
--- /dev/null
+++ b/tools/testing/selftests/exec/unshare-sighand.c
@@ -0,0 +1,236 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test exec in a task that shares its signal table with another process
+ * without being one of its threads, i.e. CLONE_SIGHAND without CLONE_THREAD.
+ * The exec has to give the task a private table before it resets the
+ * handlers so the other process keeps the table they shared. If the other
+ * process waits for the task in vfork() the task has to have its private
+ * table before that process runs again.
+ */
+#define _GNU_SOURCE
+#include <pthread.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdbool.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include "kselftest_harness.h"
+
+#define STACK_SIZE	(64 * 1024)
+
+/* Makes the exec'd image check its dispositions. */
+#define EXECED_ARG	"execed"
+/* Makes the exec'd image check the signal its vfork() parent ignored. */
+#define EXECED_VFORK_ARG	"execed-vfork"
+
+/* Exit status of a sharer that never made it into the exec'd image. */
+#define EXIT_NO_EXEC	127
+
+/* Handled before the clone. */
+static const int handled_signals[] = { SIGUSR1, SIGUSR2 };
+/* Handled by the sharer right before its exec. */
+#define SHARER_SIGNAL	SIGTERM
+/* Ignored before the clone. */
+#define IGNORED_SIGNAL	SIGHUP
+/* Ignored by a vfork() parent as soon as it runs again. */
+#define VFORK_SIGNAL	SIGINT
+
+/* How often a vfork() parent races with the exec of its child. */
+#define VFORK_ROUNDS	16
+
+/* How much the thread that holds the mmap lock has to work on. */
+#define WRITER_SIZE	(1UL << 30)
+
+static void handler(int sig)
+{
+}
+
+static int set_disposition(int sig, sighandler_t disposition)
+{
+	const struct sigaction sa = { .sa_handler = disposition };
+
+	return sigaction(sig, &sa, NULL);
+}
+
+static const char *disposition_name(sighandler_t disposition)
+{
+	if (disposition == SIG_DFL)
+		return "default";
+	if (disposition == SIG_IGN)
+		return "ignored";
+	return "handled";
+}
+
+static bool has_disposition(const char *who, int sig, sighandler_t disposition)
+{
+	struct sigaction sa;
+
+	if (sigaction(sig, NULL, &sa))
+		return false;
+	ksft_print_msg("%s: signal %d (%s) is %s\n", who, sig, strsignal(sig),
+		       disposition_name(sa.sa_handler));
+	return sa.sa_handler == disposition;
+}
+
+/* The signals with a handler must have @handled, the ignored one SIG_IGN. */
+static bool check_dispositions(const char *who, sighandler_t handled)
+{
+	bool ret = true;
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(handled_signals); i++)
+		ret &= has_disposition(who, handled_signals[i], handled);
+	ret &= has_disposition(who, SHARER_SIGNAL, handled);
+	ret &= has_disposition(who, IGNORED_SIGNAL, SIG_IGN);
+	return ret;
+}
+
+static int setup_dispositions(void)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(handled_signals); i++) {
+		if (set_disposition(handled_signals[i], handler))
+			return -1;
+	}
+	return set_disposition(IGNORED_SIGNAL, SIG_IGN);
+}
+
+static int sharer(void *arg)
+{
+	/* The parent only gets to see this if the table really is shared. */
+	if (!set_disposition(SHARER_SIGNAL, handler))
+		execl("/proc/self/exe", "unshare-sighand", EXECED_ARG,
+		      (char *)NULL);
+	_exit(EXIT_NO_EXEC);
+}
+
+TEST(exec_unshares_sighand)
+{
+	char *stack;
+	int status;
+	pid_t pid;
+
+	ASSERT_EQ(setup_dispositions(), 0);
+
+	stack = mmap(NULL, STACK_SIZE, PROT_READ | PROT_WRITE,
+		     MAP_PRIVATE | MAP_ANONYMOUS | MAP_STACK, -1, 0);
+	ASSERT_NE(stack, MAP_FAILED);
+
+	pid = clone(sharer, stack + STACK_SIZE,
+		    CLONE_VM | CLONE_SIGHAND | SIGCHLD, NULL);
+	ASSERT_GT(pid, 0);
+	ASSERT_EQ(waitpid(pid, &status, 0), pid);
+	ASSERT_TRUE(WIFEXITED(status));
+	/* The exec'd image has the handlers reset and SIG_IGN inherited. */
+	EXPECT_EQ(WEXITSTATUS(status), EXIT_SUCCESS);
+
+	/* The table was shared up to the exec and the exec left it alone. */
+	EXPECT_TRUE(check_dispositions("parent", handler));
+
+	EXPECT_EQ(munmap(stack, STACK_SIZE), 0);
+}
+
+struct mmap_writer {
+	pthread_t thread;
+	char *map;
+	bool stop;
+};
+
+/*
+ * Hold the mmap lock for writing most of the time. An exec that waits for
+ * the mmap lock of the old mm after it has woken up a vfork() parent gives
+ * that parent all the time it needs.
+ */
+static void *mmap_writer(void *arg)
+{
+	struct mmap_writer *writer = arg;
+
+	while (!__atomic_load_n(&writer->stop, __ATOMIC_RELAXED)) {
+		mprotect(writer->map, WRITER_SIZE, PROT_NONE);
+		mprotect(writer->map, WRITER_SIZE, PROT_READ);
+	}
+	return NULL;
+}
+
+static int vfork_sharer(void *arg)
+{
+	execl("/proc/self/exe", "unshare-sighand", EXECED_VFORK_ARG,
+	      (char *)NULL);
+	_exit(EXIT_NO_EXEC);
+}
+
+TEST(exec_unshares_sighand_before_vfork_returns)
+{
+	struct sched_param param = { .sched_priority = 1 };
+	struct mmap_writer writer = {};
+	cpu_set_t cpu;
+	char *stack;
+	int status;
+	pid_t pid;
+	int i;
+
+	stack = mmap(NULL, STACK_SIZE, PROT_READ | PROT_WRITE,
+		     MAP_PRIVATE | MAP_ANONYMOUS | MAP_STACK, -1, 0);
+	ASSERT_NE(stack, MAP_FAILED);
+
+	/* One page table entry per page, all of them the zero page. */
+	writer.map = mmap(NULL, WRITER_SIZE, PROT_READ,
+			  MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE, -1, 0);
+	ASSERT_NE(writer.map, MAP_FAILED);
+	madvise(writer.map, WRITER_SIZE, MADV_NOHUGEPAGE);
+	madvise(writer.map, WRITER_SIZE, MADV_POPULATE_READ);
+	ASSERT_EQ(pthread_create(&writer.thread, NULL, mmap_writer, &writer), 0);
+
+	/*
+	 * The task that is cloned below runs on our cpu and, as the policy
+	 * isn't inherited, not in a realtime scheduling class. On a kernel
+	 * with preemption we run as soon as it wakes us up and it doesn't get
+	 * any further meanwhile. Without the privilege for that only an exec
+	 * that sleeps after it has woken us up is caught.
+	 */
+	CPU_ZERO(&cpu);
+	CPU_SET(sched_getcpu(), &cpu);
+	if (!sched_setaffinity(0, sizeof(cpu), &cpu))
+		sched_setscheduler(0, SCHED_FIFO | SCHED_RESET_ON_FORK, &param);
+
+	for (i = 0; i < VFORK_ROUNDS; i++) {
+		ASSERT_EQ(set_disposition(VFORK_SIGNAL, SIG_DFL), 0);
+
+		pid = clone(vfork_sharer, stack + STACK_SIZE,
+			    CLONE_VM | CLONE_VFORK | CLONE_SIGHAND | SIGCHLD,
+			    NULL);
+		/* The task has its own table. This is none of its business. */
+		set_disposition(VFORK_SIGNAL, SIG_IGN);
+		ASSERT_GT(pid, 0);
+		ASSERT_EQ(waitpid(pid, &status, 0), pid);
+		ASSERT_TRUE(WIFEXITED(status));
+		ASSERT_EQ(WEXITSTATUS(status), EXIT_SUCCESS) {
+			TH_LOG("round %d: ignored after vfork(), ignored in the exec'd image", i);
+		}
+	}
+
+	__atomic_store_n(&writer.stop, true, __ATOMIC_RELAXED);
+	ASSERT_EQ(pthread_join(writer.thread, NULL), 0);
+	EXPECT_EQ(munmap(writer.map, WRITER_SIZE), 0);
+	EXPECT_EQ(munmap(stack, STACK_SIZE), 0);
+}
+
+int main(int argc, char **argv)
+{
+	struct sigaction sa;
+
+	if (argc == 2 && !strcmp(argv[1], EXECED_ARG))
+		return check_dispositions("exec'd image", SIG_DFL) ?
+		       EXIT_SUCCESS : EXIT_FAILURE;
+	if (argc == 2 && !strcmp(argv[1], EXECED_VFORK_ARG)) {
+		if (sigaction(VFORK_SIGNAL, NULL, &sa))
+			return EXIT_FAILURE;
+		return sa.sa_handler == SIG_DFL ? EXIT_SUCCESS : EXIT_FAILURE;
+	}
+	return test_harness_run(argc, argv);
+}

-- 
2.53.0

