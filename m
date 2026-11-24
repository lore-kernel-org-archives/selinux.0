Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795561197;
	b=Zhh/zU0PDhEVohRImzMSDCr1IePEPqLDwpFaX7aDybmeAmmtxtMx7wg1nFC3a0Jf/NqJ
	 xR/XIJoGiVrH0wZRvLOfRCoQr9K5RflJ1JDh2/VRleowAtCvsQBF5A6Dic1mKgjkTl06o
	 eZpIitth1+RjVSFx+g+FQiMPWwyWPKMbM3QOxMwfASgxm0VXeJXM/LXsp7xL4bStKaK9Q
	 wzIs9sIOZ9L4n8x2D9GoKft3qod25HFfkMLzqcgOAmh+Ri85bsw8rY/MJYA4Dnec6OAW7
	 nj2hSMJ0In63RLiN1EKF7662QBiQ8HIGz+QrDbrpFfVytJRnWq7c1AGShDiqG6oU13Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795561197;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=4cVmVLc7LIrrISjKw5rHBFfP0JBi3KzEHbPZEXJ6OYI=;
	b=WUGo2QFipefX/QrqFClfuqTH/Qarvr3Kg/4Fbtr/wSio+cWn5sRXFnsH8jTL1SBsEymr
	 BqdpK0PJYugBQo5pkY+PC9oyszXzUklOz0o30tvmwVwNi1PBEvLQE9iYJ4ywYnoJEvZpl
	 v7B2KE46mY40Ruspn/YIIs8nDB+/zXgDu2COZHfxTiZu3/8FU2FVjyYjFlpJ8xK4lYXrT
	 k622Y1Qt7ClZE7vhrMcLy9CiVu0+Ymgr9pCf+VPWD7WtE4FhpVpWG1+9kyRHWdO4xbUG4
	 4effDXY8OwItSj8tSBllL/XXXNYXVusQb8sN6sQzKkXv7ZOwZGOxJTtnZLKzRxNQrkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cTeA4PBN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A049606A326;
	Tue, 24 Nov 2026 22:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cTeA4PBN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8DD81F000EF;
	Tue, 24 Nov 2026 22:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795561196;
	bh=4cVmVLc7LIrrISjKw5rHBFfP0JBi3KzEHbPZEXJ6OYI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=cTeA4PBNItkZ7SQes+vsoK0eNpJ0yPAnVhFCNUNkMAkRaqAmTKfo4gsEJ0QxBGe4j
	 XKS3KI+fwvBHNQafCwctoxrWbPATIJSHSSWNqrthhioKSgTMvEcs04qxgoWyjMVlcU
	 ClW5I1wPY/7JcBUdUlQU6nvixoxVT0g5RAZ7hyN8jSpVVkfhsZp98srtgAyFzYP7pJ
	 8i7DpLGfF5lpnIYYHiApUtlcMUPmjkSrzCxBOYBMcCPZQBflw3lPSgnMEd364vjv4d
	 rB1D8Lc1M2RXjUVO8c+vQMNGg+hrlo0DMImTzZ7ZCOunr4x4Wozbn9neAOnPXFAR7D
	 iKwOkkQddtDxQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 24 Nov 2026 23:58:30 +0100
Subject: [PATCH RFC 07/19] selftests/exec: test exec with a task sleeping
 in a page fault
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
Message-Id: <20261124-work-exec-update_lock-v1-7-e489035395b8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=18544; i=brauner@kernel.org;
 h=from:subject:message-id; bh=sKQKF1p5Z+U1LORuNBMx17a0qZShiW21dJdzsNJJzL8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSzie3jn/RjouDZtZKZErZMNqE7y28wrAz/fn3pmpYPF
 dtlMl5s6yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjI9RRGhj/xtQdZV5xUZqr7
 xZ+2aO6kvUUvPr2qerKtWrg1Y+lKgVyG/zUO6xQ60leuPTN/jkJGjeqxXy4BL99Jz4qbc3A3qx6
 LFycA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test that a task which sleeps in a page fault while it looks at another
task doesn't block an exec of that task:

- readlink() on /proc/<pid>/ns/mnt with a buffer that faults

- kcmp() with KCMP_EPOLL_TFD and a slot that faults

- kcmp() with KCMP_EPOLL_TFD while another thread faults in epoll_wait()
  on the same epoll file

- read() on a perf event of the task with a buffer that faults

- ioctl() on a perf event of the task with an argument that faults, for
  each command that copies to or from userspace

The buffer is registered with userfaultfd so the fault only completes
after the exec had its chance.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 tools/testing/selftests/exec/.gitignore          |   1 +
 tools/testing/selftests/exec/Makefile            |   3 +
 tools/testing/selftests/exec/config              |   3 +
 tools/testing/selftests/exec/update-lock-fault.c | 547 +++++++++++++++++++++++
 4 files changed, 554 insertions(+)

diff --git a/tools/testing/selftests/exec/.gitignore b/tools/testing/selftests/exec/.gitignore
index e42ecd4c908d1..4613c68537395 100644
--- a/tools/testing/selftests/exec/.gitignore
+++ b/tools/testing/selftests/exec/.gitignore
@@ -16,6 +16,7 @@ null-argv
 !load_address.c
 /recursion-depth
 /set-exec
+/update-lock-fault
 xxxxxxxx*
 pipe
 S_I*.test
diff --git a/tools/testing/selftests/exec/Makefile b/tools/testing/selftests/exec/Makefile
index 91decfa8ff2c1..3756a250f9591 100644
--- a/tools/testing/selftests/exec/Makefile
+++ b/tools/testing/selftests/exec/Makefile
@@ -20,6 +20,7 @@ TEST_FILES := Makefile
 TEST_GEN_PROGS += recursion-depth
 TEST_GEN_PROGS += null-argv
 TEST_GEN_PROGS += check-exec
+TEST_GEN_PROGS += update-lock-fault
 
 # binfmt_misc must not be reachable as an exec source or as a stacking layer,
 # or an 'F' entry can pin the instance that owns it. Unprivileged, no bpf.
@@ -115,6 +116,8 @@ $(OUTPUT)/binfmt_misc_selfpin: ../filesystems/utils.c
 $(OUTPUT)/binfmt_misc_interplimit: CFLAGS += $(TOOLS_INCLUDES)
 $(OUTPUT)/binfmt_misc_interplimit: ../filesystems/utils.c
 
+$(OUTPUT)/update-lock-fault: LDLIBS += -lpthread
+
 # --- binfmt_misc bpf ('B') handler test ---------------------------------
 # The struct_ops bpf objects are compiled against the running kernel's BTF.
 # CLANG/BPFTOOL/VMLINUX_BTF are set above next to the toolchain check;
diff --git a/tools/testing/selftests/exec/config b/tools/testing/selftests/exec/config
index ea359a929ae82..2b7563a234112 100644
--- a/tools/testing/selftests/exec/config
+++ b/tools/testing/selftests/exec/config
@@ -4,9 +4,12 @@ CONFIG_BINFMT_MISC=y
 CONFIG_BINFMT_MISC_BPF=y
 CONFIG_BPF_JIT=y
 CONFIG_BPF_SYSCALL=y
+CONFIG_CHECKPOINT_RESTORE=y
 CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_INFO_BTF=y
 CONFIG_DEBUG_INFO_DWARF4=y
 CONFIG_OVERLAY_FS=y
+CONFIG_PERF_EVENTS=y
 CONFIG_TMPFS=y
+CONFIG_USERFAULTFD=y
 CONFIG_USER_NS=y
diff --git a/tools/testing/selftests/exec/update-lock-fault.c b/tools/testing/selftests/exec/update-lock-fault.c
new file mode 100644
index 0000000000000..d57a6703f56c5
--- /dev/null
+++ b/tools/testing/selftests/exec/update-lock-fault.c
@@ -0,0 +1,547 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test that a task which sleeps in a page fault while it looks at another
+ * task doesn't hold a lock that an exec in that task needs: the
+ * exec_update_lock of the task or the mutex of its perf context. Otherwise
+ * the exec hangs until the fault is resolved.
+ *
+ * The buffer handed to the kernel is registered with userfaultfd so the
+ * fault only completes once the test says so.
+ */
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <poll.h>
+#include <pthread.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/epoll.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+#include <sys/syscall.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include <linux/kcmp.h>
+#include <linux/perf_event.h>
+#include <linux/userfaultfd.h>
+
+#include "kselftest_harness.h"
+
+/* Makes the exec'd image exit right away. */
+#define EXECED_ARG	"execed"
+
+/* How long the exec'd image gets to exit before the exec counts as stuck. */
+#define EXEC_TIMEOUT_MS	5000
+
+/* A page that faults until fault_resolve() is called. */
+struct fault {
+	int uffd;
+	void *buf;
+	size_t size;
+};
+
+static bool fault_setup(struct __test_metadata *_metadata, struct fault *fault)
+{
+	struct uffdio_api api = { .api = UFFD_API };
+	struct uffdio_register reg = {};
+
+	/*
+	 * Faults from kernel mode need CAP_SYS_PTRACE or
+	 * vm.unprivileged_userfaultfd=1. poll() only works on a nonblocking
+	 * userfaultfd.
+	 */
+	fault->uffd = syscall(SYS_userfaultfd, O_CLOEXEC | O_NONBLOCK);
+	if (fault->uffd < 0)
+		SKIP(return false, "userfaultfd: %s", strerror(errno));
+	ASSERT_EQ(ioctl(fault->uffd, UFFDIO_API, &api), 0);
+
+	fault->size = sysconf(_SC_PAGESIZE);
+	fault->buf = mmap(NULL, fault->size, PROT_READ | PROT_WRITE,
+			  MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	ASSERT_NE(fault->buf, MAP_FAILED);
+	reg.range.start = (unsigned long)fault->buf;
+	reg.range.len = fault->size;
+	reg.mode = UFFDIO_REGISTER_MODE_MISSING;
+	ASSERT_EQ(ioctl(fault->uffd, UFFDIO_REGISTER, &reg), 0);
+	return true;
+}
+
+/* Someone sleeps in a fault on the page now. */
+static void fault_read(struct __test_metadata *_metadata, struct fault *fault)
+{
+	struct uffd_msg msg;
+
+	ASSERT_EQ(read(fault->uffd, &msg, sizeof(msg)), (ssize_t)sizeof(msg));
+	ASSERT_EQ(msg.event, UFFD_EVENT_PAGEFAULT);
+}
+
+static void fault_resolve(struct __test_metadata *_metadata,
+			  struct fault *fault)
+{
+	struct uffdio_zeropage zeropage = {};
+
+	zeropage.range.start = (unsigned long)fault->buf;
+	zeropage.range.len = fault->size;
+	ASSERT_EQ(ioctl(fault->uffd, UFFDIO_ZEROPAGE, &zeropage), 0);
+}
+
+static void fault_cleanup(struct __test_metadata *_metadata,
+			  struct fault *fault)
+{
+	EXPECT_EQ(munmap(fault->buf, fault->size), 0);
+	EXPECT_EQ(close(fault->uffd), 0);
+}
+
+/* A child that execs when it is told to. */
+struct child {
+	pid_t pid;
+	int pidfd;
+	int exec_fd;
+};
+
+static void child_start(struct __test_metadata *_metadata, struct child *child)
+{
+	int exec_pipe[2];
+	char c;
+
+	ASSERT_EQ(pipe2(exec_pipe, O_CLOEXEC), 0);
+	child->pid = fork();
+	ASSERT_GE(child->pid, 0);
+	if (child->pid == 0) {
+		close(exec_pipe[1]);
+		if (read(exec_pipe[0], &c, 1) == 1)
+			execl("/proc/self/exe", "update-lock-fault", EXECED_ARG,
+			      (char *)NULL);
+		_exit(EXIT_FAILURE);
+	}
+	ASSERT_EQ(close(exec_pipe[0]), 0);
+	child->exec_fd = exec_pipe[1];
+	child->pidfd = syscall(SYS_pidfd_open, child->pid, 0);
+	ASSERT_GE(child->pidfd, 0);
+}
+
+/* Whether the exec'd image ran and exited in time. */
+static bool child_exec(struct __test_metadata *_metadata, struct child *child)
+{
+	struct pollfd pfd = { .fd = child->pidfd, .events = POLLIN };
+	int ret;
+
+	ASSERT_EQ(write(child->exec_fd, "", 1), 1);
+	ret = poll(&pfd, 1, EXEC_TIMEOUT_MS);
+	ASSERT_GE(ret, 0);
+	return ret > 0;
+}
+
+static void child_reap(struct __test_metadata *_metadata, struct child *child,
+		       bool kill_it)
+{
+	int status;
+
+	if (kill_it)
+		ASSERT_EQ(kill(child->pid, SIGKILL), 0);
+	ASSERT_EQ(waitpid(child->pid, &status, 0), child->pid);
+	if (!kill_it) {
+		ASSERT_TRUE(WIFEXITED(status));
+		ASSERT_EQ(WEXITSTATUS(status), EXIT_SUCCESS);
+	}
+	EXPECT_EQ(close(child->pidfd), 0);
+	EXPECT_EQ(close(child->exec_fd), 0);
+}
+
+/* A thread that makes one system call. */
+struct caller {
+	long (*fn)(struct caller *caller);
+	pid_t pid;
+	void *buf;
+	unsigned long cmd;
+	int epfd;
+	int tfd;
+	pthread_t thread;
+	int pipe[2];
+	pid_t tid;
+	long ret;
+	int err;
+	bool skip;
+};
+
+/* The kernel copies the name of the namespace to the buffer. */
+static long do_ns_readlink(struct caller *caller)
+{
+	char path[64];
+
+	snprintf(path, sizeof(path), "/proc/%d/ns/mnt", caller->pid);
+	return readlink(path, caller->buf, 64);
+}
+
+/* The kernel copies a struct kcmp_epoll_slot from the buffer. */
+static long do_kcmp_epoll_tfd(struct caller *caller)
+{
+	return syscall(SYS_kcmp, getpid(), caller->pid, KCMP_EPOLL_TFD, 0,
+		       caller->buf);
+}
+
+/* The kernel copies an event to the buffer with the epoll mutex held. */
+static long do_epoll_wait(struct caller *caller)
+{
+	return epoll_wait(caller->epfd, caller->buf, 1, -1);
+}
+
+/* The kernel takes the epoll mutex to look up the target file. */
+static long do_kcmp_epoll_mutex(struct caller *caller)
+{
+	struct kcmp_epoll_slot slot = {
+		.efd = caller->epfd,
+		.tfd = caller->tfd,
+	};
+
+	return syscall(SYS_kcmp, getpid(), caller->pid, KCMP_EPOLL_TFD,
+		       caller->tfd, &slot);
+}
+
+static int tracepoint_id(void)
+{
+	static const char * const paths[] = {
+		"/sys/kernel/tracing/events/sched/sched_switch/id",
+		"/sys/kernel/debug/tracing/events/sched/sched_switch/id",
+	};
+	char buf[16];
+	ssize_t len;
+	size_t i;
+	int fd;
+
+	for (i = 0; i < ARRAY_SIZE(paths); i++) {
+		fd = open(paths[i], O_RDONLY | O_CLOEXEC);
+		if (fd < 0)
+			continue;
+		len = read(fd, buf, sizeof(buf) - 1);
+		close(fd);
+		if (len <= 0)
+			break;
+		buf[len] = '\0';
+		return atoi(buf);
+	}
+	return -1;
+}
+
+/*
+ * read() or an ioctl() on a perf event that counts for the other task. The
+ * kernel copies to or from the buffer.
+ */
+static long do_perf(struct caller *caller)
+{
+	struct perf_event_attr attr = {
+		.type		= PERF_TYPE_SOFTWARE,
+		.size		= sizeof(attr),
+		.config		= PERF_COUNT_SW_TASK_CLOCK,
+		.exclude_kernel	= 1,
+	};
+	int fd, err, id;
+	long ret;
+
+	/* Only a tracepoint can be asked for its bpf programs. */
+	if (caller->cmd == PERF_EVENT_IOC_QUERY_BPF) {
+		id = tracepoint_id();
+		if (id < 0) {
+			caller->skip = true;
+			return -1;
+		}
+		attr.type = PERF_TYPE_TRACEPOINT;
+		attr.config = id;
+		attr.exclude_kernel = 0;
+	}
+
+	fd = syscall(SYS_perf_event_open, &attr, caller->pid, -1, -1,
+		     PERF_FLAG_FD_CLOEXEC);
+	if (fd < 0) {
+		caller->skip = true;
+		return -1;
+	}
+
+	if (caller->cmd)
+		ret = ioctl(fd, caller->cmd, caller->buf);
+	else
+		ret = read(fd, caller->buf, sizeof(__u64));
+	err = errno;
+	close(fd);
+	/* The bpf programs can only be queried with CAP_PERFMON. */
+	if (caller->cmd == PERF_EVENT_IOC_QUERY_BPF && ret < 0 &&
+	    (err == EPERM || err == EACCES))
+		caller->skip = true;
+	errno = err;
+	return ret;
+}
+
+static void *caller_thread(void *arg)
+{
+	struct caller *caller = arg;
+
+	caller->tid = syscall(SYS_gettid);
+	if (write(caller->pipe[1], "", 1) != 1)
+		return NULL;
+	caller->ret = caller->fn(caller);
+	caller->err = caller->ret < 0 ? errno : 0;
+	if (write(caller->pipe[1], "", 1) != 1)
+		caller->err = EIO;
+	return NULL;
+}
+
+/* The pipe is readable again once the system call is back. */
+static void caller_start(struct __test_metadata *_metadata,
+			 struct caller *caller)
+{
+	char c;
+
+	ASSERT_EQ(pipe2(caller->pipe, O_CLOEXEC), 0);
+	ASSERT_EQ(pthread_create(&caller->thread, NULL, caller_thread, caller),
+		  0);
+	ASSERT_EQ(read(caller->pipe[0], &c, 1), 1);
+}
+
+static void caller_join(struct __test_metadata *_metadata,
+			struct caller *caller)
+{
+	ASSERT_EQ(pthread_join(caller->thread, NULL), 0);
+	EXPECT_EQ(close(caller->pipe[0]), 0);
+	EXPECT_EQ(close(caller->pipe[1]), 0);
+}
+
+/*
+ * Whether a thread of this process sleeps in system call @nr.
+ * /proc/<pid>/syscall only has the number for a task that isn't running.
+ * Returns -1 if that file can't be read.
+ */
+static int thread_sleeps_in(pid_t tid, long nr)
+{
+	char path[64], buf[64];
+	ssize_t len;
+	int fd;
+
+	snprintf(path, sizeof(path), "/proc/self/task/%d/syscall", tid);
+	fd = open(path, O_RDONLY | O_CLOEXEC);
+	if (fd < 0)
+		return -1;
+	len = read(fd, buf, sizeof(buf) - 1);
+	close(fd);
+	if (len <= 0)
+		return -1;
+	buf[len] = '\0';
+	/* "running" if it doesn't sleep, -1 if it sleeps outside of a syscall */
+	return strtol(buf, NULL, 10) == nr;
+}
+
+/*
+ * Wait until the thread sleeps in system call @nr. Returns 1 if it does, 0
+ * if the call is back already and -1 if there's no way to tell.
+ */
+static int caller_wait_sleeping(struct __test_metadata *_metadata,
+				struct caller *caller, long nr)
+{
+	struct pollfd pfd = { .fd = caller->pipe[0], .events = POLLIN };
+	int ret;
+
+	for (;;) {
+		ret = poll(&pfd, 1, 0);
+		ASSERT_GE(ret, 0);
+		if (ret > 0)
+			return 0;
+		ret = thread_sleeps_in(caller->tid, nr);
+		if (ret)
+			return ret;
+		sched_yield();
+	}
+}
+
+static bool not_supported(const struct caller *caller)
+{
+	return caller->skip || caller->err == ENOSYS ||
+	       caller->err == EOPNOTSUPP;
+}
+
+static void exec_with_reader_in_fault(struct __test_metadata *_metadata,
+				      long (*fn)(struct caller *caller),
+				      unsigned long cmd)
+{
+	struct caller reader = { .fn = fn, .cmd = cmd };
+	struct pollfd pfds[2];
+	struct fault fault;
+	struct child child;
+	bool exec_done;
+
+	if (!fault_setup(_metadata, &fault))
+		return;
+	child_start(_metadata, &child);
+
+	reader.pid = child.pid;
+	reader.buf = fault.buf;
+	caller_start(_metadata, &reader);
+
+	pfds[0].fd = fault.uffd;
+	pfds[0].events = POLLIN;
+	pfds[1].fd = reader.pipe[0];
+	pfds[1].events = POLLIN;
+	ASSERT_GT(poll(pfds, 2, -1), 0);
+	if (!(pfds[0].revents & POLLIN)) {
+		/* The reader came back without touching the buffer. */
+		caller_join(_metadata, &reader);
+		child_reap(_metadata, &child, true);
+		if (not_supported(&reader))
+			SKIP(return, "not supported: %s", strerror(reader.err));
+		ASSERT_TRUE(false) {
+			TH_LOG("reader returned %ld without a fault: %s",
+			       reader.ret, strerror(reader.err));
+		}
+	}
+	fault_read(_metadata, &fault);
+
+	/* The reader sleeps in the fault now. The exec must not wait for it. */
+	exec_done = child_exec(_metadata, &child);
+
+	/* Let the reader finish and with it an exec that waits for it. */
+	fault_resolve(_metadata, &fault);
+	caller_join(_metadata, &reader);
+	if (fn == do_ns_readlink)
+		EXPECT_GT(reader.ret, 0);
+	child_reap(_metadata, &child, false);
+
+	EXPECT_TRUE(exec_done) {
+		TH_LOG("exec waited for a task sleeping in a page fault");
+	}
+
+	fault_cleanup(_metadata, &fault);
+}
+
+/* readlink() on /proc/<pid>/ns/<name> */
+TEST(ns_readlink)
+{
+	exec_with_reader_in_fault(_metadata, do_ns_readlink, 0);
+}
+
+/* kcmp(KCMP_EPOLL_TFD) */
+TEST(kcmp_epoll_tfd)
+{
+	exec_with_reader_in_fault(_metadata, do_kcmp_epoll_tfd, 0);
+}
+
+/*
+ * kcmp(KCMP_EPOLL_TFD) with the mutex of the epoll file held by a thread
+ * that sleeps in a page fault in epoll_wait().
+ */
+TEST(kcmp_epoll_mutex)
+{
+	struct epoll_event ev = { .events = EPOLLIN };
+	struct caller waiter = { .fn = do_epoll_wait };
+	struct caller comparer = { .fn = do_kcmp_epoll_mutex };
+	struct pollfd pfd = { .events = POLLIN };
+	int epfd, ready[2], sleeping;
+	struct fault fault;
+	struct child child;
+	bool exec_done;
+
+	if (!fault_setup(_metadata, &fault))
+		return;
+
+	/* An epoll file with an event that is ready right away. */
+	epfd = epoll_create1(EPOLL_CLOEXEC);
+	if (epfd < 0 && errno == ENOSYS)
+		SKIP(return, "epoll: %s", strerror(errno));
+	ASSERT_GE(epfd, 0);
+	ASSERT_EQ(pipe2(ready, O_CLOEXEC), 0);
+	ASSERT_EQ(write(ready[1], "", 1), 1);
+	ASSERT_EQ(epoll_ctl(epfd, EPOLL_CTL_ADD, ready[0], &ev), 0);
+
+	/* The child inherits the epoll file. kcmp() looks it up there. */
+	child_start(_metadata, &child);
+
+	waiter.epfd = epfd;
+	waiter.buf = fault.buf;
+	caller_start(_metadata, &waiter);
+	pfd.fd = fault.uffd;
+	ASSERT_EQ(poll(&pfd, 1, -1), 1);
+	fault_read(_metadata, &fault);
+
+	/* epoll_wait() sleeps in the fault now. kcmp() waits for the mutex. */
+	comparer.pid = child.pid;
+	comparer.epfd = epfd;
+	comparer.tfd = ready[0];
+	caller_start(_metadata, &comparer);
+	sleeping = caller_wait_sleeping(_metadata, &comparer, SYS_kcmp);
+	if (sleeping < 0 || (!sleeping && comparer.err)) {
+		/* It can't be watched or it failed before it got anywhere. */
+		fault_resolve(_metadata, &fault);
+		caller_join(_metadata, &waiter);
+		caller_join(_metadata, &comparer);
+		child_reap(_metadata, &child, true);
+		if (sleeping < 0)
+			SKIP(return, "can't read /proc/<pid>/syscall");
+		if (not_supported(&comparer))
+			SKIP(return, "not supported: %s", strerror(comparer.err));
+		ASSERT_EQ(comparer.err, 0) {
+			TH_LOG("kcmp() failed: %s", strerror(comparer.err));
+		}
+	}
+
+	/* The exec must not wait for either of them. */
+	exec_done = child_exec(_metadata, &child);
+
+	/* Let epoll_wait() finish and with it kcmp() and the exec. */
+	fault_resolve(_metadata, &fault);
+	caller_join(_metadata, &waiter);
+	caller_join(_metadata, &comparer);
+	EXPECT_EQ(waiter.ret, 1);
+	child_reap(_metadata, &child, false);
+
+	EXPECT_TRUE(exec_done) {
+		TH_LOG("exec waited for a task sleeping on the epoll mutex");
+	}
+
+	EXPECT_EQ(close(ready[0]), 0);
+	EXPECT_EQ(close(ready[1]), 0);
+	EXPECT_EQ(close(epfd), 0);
+	fault_cleanup(_metadata, &fault);
+}
+
+/* read() on a perf event */
+TEST(perf_read)
+{
+	exec_with_reader_in_fault(_metadata, do_perf, 0);
+}
+
+/* The ioctls of a perf event that copy to or from userspace. */
+TEST(perf_ioctl_id)
+{
+	exec_with_reader_in_fault(_metadata, do_perf, PERF_EVENT_IOC_ID);
+}
+
+TEST(perf_ioctl_period)
+{
+	exec_with_reader_in_fault(_metadata, do_perf, PERF_EVENT_IOC_PERIOD);
+}
+
+TEST(perf_ioctl_set_filter)
+{
+	exec_with_reader_in_fault(_metadata, do_perf,
+				  PERF_EVENT_IOC_SET_FILTER);
+}
+
+TEST(perf_ioctl_modify_attributes)
+{
+	exec_with_reader_in_fault(_metadata, do_perf,
+				  PERF_EVENT_IOC_MODIFY_ATTRIBUTES);
+}
+
+/* Needs CAP_PERFMON and tracefs. */
+TEST(perf_ioctl_query_bpf)
+{
+	exec_with_reader_in_fault(_metadata, do_perf, PERF_EVENT_IOC_QUERY_BPF);
+}
+
+int main(int argc, char **argv)
+{
+	if (argc == 2 && !strcmp(argv[1], EXECED_ARG))
+		return EXIT_SUCCESS;
+	return test_harness_run(argc, argv);
+}

-- 
2.53.0

