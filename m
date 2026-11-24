Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795561242;
	b=4QLAhXKSgPtgYuj60B6o39VtSBehJ+2lIK+s8bXgDUSb5olYugzLLkhn2brtgP7RMfA2
	 gsqLBGPmhQqZEsM5R89RgsC8gcc5NKefeqAL4MqI1wsnP7oU/iSsepQAq9SVZOWIBVhw2
	 M5rONoaUrcrLkrURpyNqNrUgZ2aGaHik7iyXf0oC9Z+MLjJDDHvxCrqqsutDKRrqlGnmc
	 HU2U3Wjz3fE1CkvrmEGQeHs9i4qSLhFCihR5XvAQzvrcHJxrRkC3zf5tXHzFYD35O85QL
	 aSXYZWQisEYif0lsSqqoh1RIvxv1JkTNIKXAFBrFSoZrY0TFxa5/YOst8zlqvoZRVzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795561242;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=ygA0Yd5X995bialEzx8ph89vbNS4OBjVFHHzxvAT62g=;
	b=CfOdgLVAMwCLrG4oAKkauGGOTFVYlqtg8PevBOwNFxlKwncGCsWFB5zqBw5BVjuA5jpv
	 yMVaVBkYF54W8BOt5+eWvByJT+pY+/isJrDZTT54RDE77V42KNs8G+lpmx/VcoJuuMuXB
	 acx9tXyyLL2sltk8or53y39psWgm8jw3gnXorCzBBFKM8AK5fJ+ilwwNZOkDcVA4N6DKS
	 i+QBz2JQYQcOVwyW7xAELUfFgj8Vk1va4a7uGfbI2XABeiinBU0eRT0VxeDwk1q6GZQsp
	 O0fC6pQa0ibPLbLyOPeJsj3L/wmC0W3W8y4ocpNBc4e9ov3HQJO1TXDdaa7glK4HX6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f5jCebnE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A558606A321;
	Tue, 24 Nov 2026 23:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f5jCebnE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B75721F0093E;
	Tue, 24 Nov 2026 23:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795561241;
	bh=ygA0Yd5X995bialEzx8ph89vbNS4OBjVFHHzxvAT62g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=f5jCebnEhbqXaTHxAeFw3ecgVwpAFmn9cbYjBd4tKLNU3UPDj3a7ISD5l2MFpkoFu
	 TI//e9PLV4D4bSuUEEeSeCiEEthjXPMpsJb6pVvzYCyL3aAH4tEyRr8UnbIQ/r971r
	 bOAIRFZ7wRvFhjWuYVOr09Zmgx+rui8BDAL8wEA/1gwLpg6/jHcjrQh0Bce55Af/aq
	 QBZWfQwoJBNAUCejGhSnNL2LC1DgHeFJWSt49UfOwpSBRihZF+Yf3kTpoY4byVYFTw
	 G7gZQau9G7RsjBePu7VYvZt91cZpN0y2DK775Hz41a5AeO002ABTFFQRaxBZL5a8Uc
	 mB7mIwZwLGiJA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 24 Nov 2026 23:58:42 +0100
Subject: [PATCH RFC 19/19] selftests/exec: test when a vfork() parent is
 woken up
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
Message-Id: <20261124-work-exec-update_lock-v1-19-e489035395b8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=12235; i=brauner@kernel.org;
 h=from:subject:message-id; bh=GmT4sHxTP/A7S4IU26xSgSWBzeaKz2RMQhkeZET1OPQ=;
 b=kA0DAAoWkcYbwGV43KIByyZiAGsGFsugFPbORXABfWEG7AK0viSfw4y5YXethbiY8xPFcp9uM
 Yh1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmsGFssACgkQkcYbwGV43KJp6AD/SVAq
 /vsoIIuO2HFmO7u5m04z3aEAxT+ygO4eOMSMiPEBAO37mYKnlpsSvX5+godnjIhpDKUxR3BnKP6
 MtwLA+9MN
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test that a task which called vfork() only runs again once the child has
left the mm:

- when the child execs

- when the child is killed in the middle of the exec

- when the child exits

A parent that is woken up too early only has a few instructions to catch
the child on the mm. So the parent runs in a realtime scheduling class
on the cpu of the child and preempts it as soon as it's woken up. That
takes a kernel with preemption. The tests are skipped without it and
without the right to use a realtime class.

To kill the child between the release of the old mm and the switch to
the new one it has to wait for exec_update_lock there. So there are more
readers of its /proc/<pid>/stat than the cpu they share can run and some
of them are preempted with the lock held.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 tools/testing/selftests/exec/.gitignore |   1 +
 tools/testing/selftests/exec/Makefile   |   1 +
 tools/testing/selftests/exec/vfork-mm.c | 363 ++++++++++++++++++++++++++++++++
 3 files changed, 365 insertions(+)

diff --git a/tools/testing/selftests/exec/.gitignore b/tools/testing/selftests/exec/.gitignore
index b27f4db42f87b..24f8f80543df1 100644
--- a/tools/testing/selftests/exec/.gitignore
+++ b/tools/testing/selftests/exec/.gitignore
@@ -18,6 +18,7 @@ null-argv
 /set-exec
 /unshare-sighand
 /update-lock-fault
+/vfork-mm
 xxxxxxxx*
 pipe
 S_I*.test
diff --git a/tools/testing/selftests/exec/Makefile b/tools/testing/selftests/exec/Makefile
index 70f090a5f7648..7d61203d6547b 100644
--- a/tools/testing/selftests/exec/Makefile
+++ b/tools/testing/selftests/exec/Makefile
@@ -22,6 +22,7 @@ TEST_GEN_PROGS += null-argv
 TEST_GEN_PROGS += check-exec
 TEST_GEN_PROGS += update-lock-fault
 TEST_GEN_PROGS += unshare-sighand
+TEST_GEN_PROGS += vfork-mm
 
 # binfmt_misc must not be reachable as an exec source or as a stacking layer,
 # or an 'F' entry can pin the instance that owns it. Unprivileged, no bpf.
diff --git a/tools/testing/selftests/exec/vfork-mm.c b/tools/testing/selftests/exec/vfork-mm.c
new file mode 100644
index 0000000000000..43cdae8e1e7b3
--- /dev/null
+++ b/tools/testing/selftests/exec/vfork-mm.c
@@ -0,0 +1,363 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test that a task which called vfork() only runs again once the child has
+ * left the mm, i.e. once it has switched to its new mm in exec or has dropped
+ * the mm in exit, also when it is killed in the middle of an exec.
+ *
+ * The first field of /proc/<pid>/statm is the size of the mm a task is on.
+ * The parent has a mapping that is larger than anything the child ends up
+ * with: an exec'd image of this program is a lot smaller and a task that has
+ * dropped its mm shows 0.
+ *
+ * A parent that is woken up too early only has a few instructions to look
+ * before the child is gone. So it runs in a realtime scheduling class and the
+ * child, which is on the same cpu, doesn't. On a kernel with preemption the
+ * parent runs as soon as it's woken up and the child doesn't get any further
+ * meanwhile. Without preemption the child gets too far for the parent to see
+ * anything so the tests are skipped there.
+ */
+#define _GNU_SOURCE
+#include <fcntl.h>
+#include <linux/futex.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <sys/prctl.h>
+#include <sys/syscall.h>
+#include <sys/utsname.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include "kselftest_harness.h"
+
+/* 32 bit architectures that only have the time64 system calls. */
+#if !defined(SYS_futex) && defined(SYS_futex_time64)
+#define SYS_futex SYS_futex_time64
+#endif
+
+/* Makes the exec'd image wait to be killed. */
+#define EXECED_ARG	"execed"
+
+/* Exit status of a child that never made it into the exec'd image. */
+#define EXIT_NO_EXEC	127
+
+/* How often the parent looks at a child. */
+#define ROUNDS		16
+
+/* What only the mm of the parent has. */
+#define MAPPING_SIZE	(1UL << 30)
+
+/* How many readers of /proc/<pid>/stat share one cpu. */
+#define READERS		8
+
+/* Size in pages of the mm @pid is on, 0 if it has none. */
+static long mm_size(pid_t pid)
+{
+	char path[64], buf[128];
+	ssize_t len;
+	int fd;
+
+	snprintf(path, sizeof(path), "/proc/%d/statm", pid);
+	fd = open(path, O_RDONLY | O_CLOEXEC);
+	if (fd < 0)
+		return -1;
+	len = read(fd, buf, sizeof(buf) - 1);
+	close(fd);
+	if (len <= 0)
+		return -1;
+	buf[len] = '\0';
+	return strtol(buf, NULL, 10);
+}
+
+/* A kernel that preempts kernel code says so in its version string. */
+static bool kernel_preempts(void)
+{
+	struct utsname u;
+
+	return !uname(&u) && strstr(u.version, "PREEMPT");
+}
+
+/* The child only gets to call exec and _exit(). */
+static pid_t vfork_exec(void)
+{
+	pid_t pid = vfork();
+
+	if (pid == 0) {
+		execl("/proc/self/exe", "vfork-mm", EXECED_ARG, (char *)NULL);
+		_exit(EXIT_NO_EXEC);
+	}
+	return pid;
+}
+
+/*
+ * Same, but the child tells whoever reads from @tell who it is and waits to
+ * be told on @go. The kernel clears *@tid when the child releases the mm.
+ */
+static pid_t vfork_exec_tid(int tell, int go, int *tid)
+{
+	pid_t pid = vfork();
+
+	if (pid == 0) {
+		pid_t self = getpid();
+		char c;
+
+		*tid = self;
+		syscall(SYS_set_tid_address, tid);
+		if (write(tell, &self, sizeof(self)) == sizeof(self) &&
+		    read(go, &c, 1) == 1)
+			execl("/proc/self/exe", "vfork-mm", EXECED_ARG,
+			      (char *)NULL);
+		_exit(EXIT_NO_EXEC);
+	}
+	return pid;
+}
+
+static pid_t vfork_exit(void)
+{
+	pid_t pid = vfork();
+
+	if (pid == 0)
+		_exit(EXIT_SUCCESS);
+	return pid;
+}
+
+FIXTURE(vfork_mm)
+{
+	char *map;
+	long pages;
+	/* The clear_child_tid word of a child, shared with the helper. */
+	int *tid;
+	/* The cpu the parent and its children are on. */
+	int cpu;
+	/* The cpus the test was started on. */
+	cpu_set_t allowed;
+};
+
+FIXTURE_SETUP(vfork_mm)
+{
+	struct sched_param param = { .sched_priority = 1 };
+	cpu_set_t cpus;
+	long size;
+
+	if (!kernel_preempts())
+		SKIP(return, "Needs a kernel with preemption");
+
+	self->pages = MAPPING_SIZE / sysconf(_SC_PAGESIZE);
+	self->map = mmap(NULL, MAPPING_SIZE, PROT_NONE,
+			 MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE, -1, 0);
+	if (self->map == MAP_FAILED)
+		SKIP(return, "Can't map %lu bytes", MAPPING_SIZE);
+	size = mm_size(getpid());
+	if (size < 0)
+		SKIP(return, "Can't read /proc/self/statm");
+	ASSERT_GE(size, self->pages);
+
+	self->tid = mmap(NULL, sizeof(*self->tid), PROT_READ | PROT_WRITE,
+			 MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+	ASSERT_NE(self->tid, MAP_FAILED);
+
+	/* Too many cpus for the mask: the helper takes any cpu it can get. */
+	if (sched_getaffinity(0, sizeof(self->allowed), &self->allowed))
+		memset(&self->allowed, 0xff, sizeof(self->allowed));
+
+	/* The policy isn't inherited, the cpu is. */
+	self->cpu = sched_getcpu();
+	CPU_ZERO(&cpus);
+	CPU_SET(self->cpu, &cpus);
+	if (sched_setaffinity(0, sizeof(cpus), &cpus) ||
+	    sched_setscheduler(0, SCHED_FIFO | SCHED_RESET_ON_FORK, &param))
+		SKIP(return, "Can't make the parent preempt the child");
+}
+
+FIXTURE_TEARDOWN(vfork_mm)
+{
+	munmap(self->map, MAPPING_SIZE);
+	munmap(self->tid, sizeof(*self->tid));
+}
+
+TEST_F(vfork_mm, exec)
+{
+	int status;
+	pid_t pid;
+	long size;
+	int i;
+
+	for (i = 0; i < ROUNDS; i++) {
+		pid = vfork_exec();
+		/* Look before anything else. */
+		size = mm_size(pid);
+		ASSERT_GT(pid, 0);
+		kill(pid, SIGKILL);
+		ASSERT_EQ(waitpid(pid, &status, 0), pid);
+		/* It didn't exit on its own so the exec didn't fail. */
+		ASSERT_TRUE(WIFSIGNALED(status));
+		ASSERT_GE(size, 0);
+		ASSERT_LT(size, self->pages) {
+			TH_LOG("round %d: vfork() returned with the child still on the mm", i);
+		}
+	}
+}
+
+/* Take exec_update_lock of @pid for reading until it's gone. */
+static void stat_reader(pid_t pid, int ready)
+{
+	char path[64], buf[1024];
+	int fd;
+
+	snprintf(path, sizeof(path), "/proc/%d/stat", pid);
+	fd = open(path, O_RDONLY | O_CLOEXEC);
+	if (fd < 0 || pread(fd, buf, sizeof(buf), 0) <= 0 ||
+	    write(ready, "", 1) != 1)
+		_exit(EXIT_FAILURE);
+	while (pread(fd, buf, sizeof(buf), 0) > 0)
+		;
+	_exit(EXIT_SUCCESS);
+}
+
+/*
+ * Kill whoever shows up on @tell right when it has released its mm in exec.
+ * It only stops there if it has to wait for exec_update_lock. So there are
+ * more readers of its /proc/<pid>/stat than the one cpu they share can run:
+ * most of them are preempted at any time, some of them with the lock held.
+ */
+static void killer(FIXTURE_DATA(vfork_mm) *self, pid_t parent, int tell,
+		   int go)
+{
+	struct sched_param param = { .sched_priority = 1 };
+	pid_t helper = getpid();
+	cpu_set_t cpus;
+	int ready[2];
+	int cpu, tid;
+	pid_t pid;
+	char c;
+	int i;
+
+	prctl(PR_SET_PDEATHSIG, SIGKILL);
+	if (getppid() != parent)
+		_exit(EXIT_FAILURE);
+
+	/* Any cpu the test may use but the one of the child. */
+	for (cpu = 0; cpu < CPU_SETSIZE; cpu++) {
+		if (cpu == self->cpu || !CPU_ISSET(cpu, &self->allowed))
+			continue;
+		CPU_ZERO(&cpus);
+		CPU_SET(cpu, &cpus);
+		if (!sched_setaffinity(0, sizeof(cpus), &cpus))
+			break;
+	}
+
+	if (read(tell, &pid, sizeof(pid)) != sizeof(pid) ||
+	    pipe2(ready, O_CLOEXEC))
+		_exit(EXIT_FAILURE);
+
+	for (i = 0; i < READERS; i++) {
+		pid_t reader = fork();
+
+		if (reader < 0)
+			_exit(EXIT_FAILURE);
+		if (reader == 0) {
+			prctl(PR_SET_PDEATHSIG, SIGKILL);
+			if (getppid() != helper)
+				_exit(EXIT_FAILURE);
+			stat_reader(pid, ready[1]);
+		}
+	}
+	for (i = 0; i < READERS; i++) {
+		if (read(ready[0], &c, 1) != 1)
+			_exit(EXIT_FAILURE);
+	}
+
+	/* The kernel wakes us up when it has cleared the word. */
+	if (sched_setscheduler(0, SCHED_FIFO, &param) || write(go, "", 1) != 1)
+		_exit(EXIT_FAILURE);
+	while ((tid = __atomic_load_n(self->tid, __ATOMIC_RELAXED)))
+		syscall(SYS_futex, self->tid, FUTEX_WAIT, tid, NULL, NULL, 0);
+	kill(pid, SIGKILL);
+
+	/* The readers go when we do. */
+	for (;;)
+		pause();
+}
+
+/*
+ * A child that is killed in exec after it has released the mm doesn't get to
+ * switch to a new one. It leaves the mm when it exits.
+ */
+TEST_F(vfork_mm, exec_killed)
+{
+	pid_t parent = getpid();
+	int tell[2], go[2];
+	pid_t pid, helper;
+	int nomm = 0;
+	int status;
+	long size;
+	int i;
+
+	for (i = 0; i < ROUNDS; i++) {
+		ASSERT_EQ(pipe2(tell, O_CLOEXEC), 0);
+		ASSERT_EQ(pipe2(go, O_CLOEXEC), 0);
+		*self->tid = 1;
+
+		helper = fork();
+		ASSERT_GE(helper, 0);
+		if (helper == 0) {
+			close(tell[1]);
+			close(go[0]);
+			killer(self, parent, tell[0], go[1]);
+		}
+		close(tell[0]);
+		close(go[1]);
+
+		pid = vfork_exec_tid(tell[1], go[0], self->tid);
+		/* Look before anything else. */
+		size = mm_size(pid);
+		ASSERT_GT(pid, 0);
+		kill(pid, SIGKILL);
+		ASSERT_EQ(waitpid(pid, &status, 0), pid);
+		kill(helper, SIGKILL);
+		ASSERT_EQ(waitpid(helper, NULL, 0), helper);
+		close(tell[1]);
+		close(go[0]);
+		ASSERT_TRUE(WIFSIGNALED(status));
+		ASSERT_GE(size, 0);
+		ASSERT_LT(size, self->pages) {
+			TH_LOG("round %d: vfork() returned with the child still on the mm", i);
+		}
+		if (!size)
+			nomm++;
+	}
+	if (!nomm)
+		SKIP(return, "The child was never killed before it got to the new mm");
+}
+
+TEST_F(vfork_mm, exit)
+{
+	int status;
+	pid_t pid;
+	long size;
+	int i;
+
+	for (i = 0; i < ROUNDS; i++) {
+		pid = vfork_exit();
+		/* Look before anything else. */
+		size = mm_size(pid);
+		ASSERT_GT(pid, 0);
+		ASSERT_EQ(waitpid(pid, &status, 0), pid);
+		ASSERT_TRUE(WIFEXITED(status));
+		ASSERT_EQ(size, 0) {
+			TH_LOG("round %d: vfork() returned with the child still on the mm", i);
+		}
+	}
+}
+
+int main(int argc, char **argv)
+{
+	if (argc == 2 && !strcmp(argv[1], EXECED_ARG)) {
+		for (;;)
+			pause();
+	}
+	return test_harness_run(argc, argv);
+}

-- 
2.53.0

