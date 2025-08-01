Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com [209.85.160.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E93B1D7E37
	for <selinux@vger.kernel.org>; Fri,  1 Aug 2025 15:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754063456; cv=none; b=VxvpiwzdmEzN8lnQcdp3QawwS/2/7WtLE93WTOt3QHB3rzNcedUftUoVtZVK2l6nSKnNSuqZe6jWdCNsjZb5HWYcvQZnQOoPOqBE1A40gYirIDUwqxh9oIH3K2wtZvbtykFgHZ5LERIjoFC0WSdpUwxyQG4qqiVfw/MPKoFpVbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754063456; c=relaxed/simple;
	bh=zm1/AKHZlU9FaKTO3KcixLBiNBcnKrU8JaT99fSl5hw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ulZK10ntsACLX7pooWwNOkF2OQQhAvTX1DGb/rPrEDP3hh/aftNwr6wE0fcyc6fBPq6KQt60n+DNhFfNsPhrRkzbFQwrH4CL6fJOylhdEcjH76hO8M9VkG9gtjR3bdcLAk5Y6wYS52IxtHZPaPCSO78+cYCZDdzQFHx7teLBXW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K9az2oWW; arc=none smtp.client-ip=209.85.160.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9az2oWW"
Received: by mail-qt1-f193.google.com with SMTP id d75a77b69052e-4aeb2edce3dso8715861cf.2
        for <selinux@vger.kernel.org>; Fri, 01 Aug 2025 08:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754063453; x=1754668253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bkFyaoq+837D5G6xQH49HZoEnl2dnqoU+tYJqxt1K7A=;
        b=K9az2oWWsLMszuPxDso7B0bZdWDLmd3iY9FNEKqSIm3evQu2ISWWyyra+MEWPPnx9Q
         msPbwKdTtCHayaoLIcZGDAjYV0OMCkoOzT9GbfY1bO8vBbKi+LgtXO3Lqk0S0DTgzA3f
         QDtqGi0mZz3fIsomAOrqR8A7FsSlazgbax0bYaswIyh2wu2S2v9GzifironVJYLyx2lr
         CPUfXjBTf0qCL8yK4k4nsWDDm2EMbRVWcsL29v0z/tnQVnYIG7X7/YkzhX1s0ZXfZJeH
         bEz6Tag02U2P7UIxrTSY75s1VNNZ8KkTPkesNAEpcQn05ZOHysXvBr872lXUcI4uiCgv
         P50Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754063453; x=1754668253;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bkFyaoq+837D5G6xQH49HZoEnl2dnqoU+tYJqxt1K7A=;
        b=X2dKGYdzNwznmGpnP3DziTaS7LEv+RcyJacu3LvwqgwNPcCRjPYfgulGjGEOkPnx+Z
         +w8QgvcTcTKrSXmmexG4z1L1kAFsf83sxid9bznBimFIxdNjMDt5J8urnEU7fyj47T2J
         r1yfmQRrg6cMUBSUwrcQ/vgmKLzEITEKNLe/4VK2WPQE1CVZZIfaQOmhyVHMFuyL6hXY
         kDmn0Gh2RnO47eUD9VOy5OzpTnvl0OHmNURG1krwINg7NFwZRZg75ClFIDqzKJlOy5nw
         wlFU6if+X+s48DE4wP/2v51JwjdfpH25Hf0ka5PzMMZBOIdLVFHyGYy4FbZrePoefyTw
         GiMA==
X-Gm-Message-State: AOJu0YxWuA5XIAKkffq1InlVmbRZRC2n60CjYeCttwC/M7Ac/4MAhV7n
	PYujGWUzD1G079i7F9CjmLA9JhcQ6JXxMsZo4gqV77pK14b8PhtG57tTaHMNRLER
X-Gm-Gg: ASbGncvzBddVo/g1IJ429wYcR3rLxj6ziTLAg1+jpgko7NpmZ2NNKCxTjITPg46dtkF
	bN/Rmb714eLBrOSmBDjZhuEn0LoBToQjFXgSO3GyAbLbL41/twpsHhdg8eIPwq7hQEFM5gZKj2f
	jkpAykhNyFhGA1+uH1KFCN7jYcGACcc+ICRKYkTD5juPIUrGVJ4NpcL3JBBY5BKHht90+OoMVyV
	mOfLAFVgDpKxzHHaTnKfdsBCa6IezJqqLwcqPRr/8+1KfwGCrl9gQRPwoKA6yhHekrKPHCGPuGj
	Qo1fln2ikR4wMaAxnjCW3/opqKB/g9vAvnHIfy6eSZqceybgOTxzCL7ALick6UeKWpOHvMjHxdg
	YCROwUnm3LGOiOAp/pvqnkieEhOWXqaAmAT0wBdEYjkYvSXIgn0klHG9hfC7cH/NKo15G/tZa5e
	pFDLPh9EjFSApU9B/PQ+OiF/M=
X-Google-Smtp-Source: AGHT+IGvkNdZk6QaDk6RlVkFbrPJqRTVuhZtt9zkUvg2qjPha1Ql9EKbEuqCa2mS4VK6LELL/vv6yw==
X-Received: by 2002:a05:622a:82:b0:4ae:6b72:2ae2 with SMTP id d75a77b69052e-4af10a88a0bmr3880351cf.40.1754063452657;
        Fri, 01 Aug 2025 08:50:52 -0700 (PDT)
Received: from localhost (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e67f5cd509sm232313685a.40.2025.08.01.08.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 08:50:52 -0700 (PDT)
From: danieldurning.work@gmail.com
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	stephen.smalley.work@gmail.com,
	omosnace@redhat.com
Subject: [PATCH testsuite] tests/bpf: add tests for bpf token
Date: Fri,  1 Aug 2025 15:50:25 +0000
Message-ID: <20250801155025.144118-1-danieldurning.work@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Durning <danieldurning.work@gmail.com>

Added two tests using BPF tokens which will test the bpf_token_capable and bpf_token_cmd LSM hooks.

Signed-off-by: Daniel Durning <danieldurning.work@gmail.com>
---
 policy/test_bpf.te     |  40 ++++
 tests/bpf/Makefile     |   1 +
 tests/bpf/bpf_common.c |  35 ++++
 tests/bpf/bpf_common.h |   6 +
 tests/bpf/bpf_test.c   |  42 +++-
 tests/bpf/bpf_token.c  | 459 +++++++++++++++++++++++++++++++++++++++++
 tests/bpf/test         |  20 +-
 7 files changed, 594 insertions(+), 9 deletions(-)
 create mode 100644 tests/bpf/bpf_token.c

diff --git a/policy/test_bpf.te b/policy/test_bpf.te
index 5eab0bd..c62d6b0 100644
--- a/policy/test_bpf.te
+++ b/policy/test_bpf.te
@@ -5,6 +5,9 @@
 attribute bpfdomain;
 
 ################################### Main ###################################
+require {
+    type bpf_t;
+}
 type test_bpf_t;
 testsuite_domain_type(test_bpf_t)
 typeattribute test_bpf_t bpfdomain;
@@ -12,6 +15,13 @@ typeattribute test_bpf_t bpfdomain;
 allow test_bpf_t self:process { setrlimit };
 allow test_bpf_t self:capability { sys_resource sys_admin };
 allow test_bpf_t self:bpf { map_create map_read map_write prog_load prog_run };
+allow test_bpf_t self:cap2_userns bpf;
+files_mounton_rootfs(test_bpf_t)
+fs_list_bpf_dirs(test_bpf_t)
+allow test_bpf_t self:cap_userns { setgid setuid sys_admin };
+allow test_bpf_t self:user_namespace create;
+allow test_bpf_t bpf_t:filesystem mount;
+allow test_bpf_t self:cap_userns net_admin;
 
 ############################## Deny map_create #############################
 type test_bpf_deny_map_create_t;
@@ -57,3 +67,33 @@ typeattribute test_bpf_deny_prog_run_t bpfdomain;
 allow test_bpf_deny_prog_run_t self:process { setrlimit };
 allow test_bpf_deny_prog_run_t self:capability { sys_resource sys_admin };
 allow test_bpf_deny_prog_run_t self:bpf { map_create map_read map_write prog_load };
+
+############################# Deny token_cap ###############################
+type test_bpf_deny_token_cap_t;
+testsuite_domain_type(test_bpf_deny_token_cap_t)
+typeattribute test_bpf_deny_token_cap_t bpfdomain;
+
+allow test_bpf_deny_token_cap_t self:process { setrlimit };
+allow test_bpf_deny_token_cap_t self:capability { sys_resource sys_admin };
+allow test_bpf_deny_token_cap_t self:cap2_userns bpf;
+allow test_bpf_deny_token_cap_t self:bpf { map_create map_read map_write prog_load prog_run };
+files_mounton_rootfs(test_bpf_deny_token_cap_t)
+fs_list_bpf_dirs(test_bpf_deny_token_cap_t)
+allow test_bpf_deny_token_cap_t self:cap_userns { setgid setuid sys_admin };
+allow test_bpf_deny_token_cap_t self:user_namespace create;
+allow test_bpf_deny_token_cap_t bpf_t:filesystem mount;
+
+############################# Deny token_cmd ###############################
+type test_bpf_deny_token_cmd_t;
+testsuite_domain_type(test_bpf_deny_token_cmd_t)
+typeattribute test_bpf_deny_token_cmd_t bpfdomain;
+
+allow test_bpf_deny_token_cmd_t self:process { setrlimit };
+allow test_bpf_deny_token_cmd_t self:capability { sys_resource sys_admin };
+allow test_bpf_deny_token_cmd_t self:cap2_userns bpf;
+allow test_bpf_deny_token_cmd_t self:bpf { map_read map_write prog_load prog_run };
+files_mounton_rootfs(test_bpf_deny_token_cmd_t)
+fs_list_bpf_dirs(test_bpf_deny_token_cmd_t)
+allow test_bpf_deny_token_cmd_t self:cap_userns { setgid setuid sys_admin };
+allow test_bpf_deny_token_cmd_t self:user_namespace create;
+allow test_bpf_deny_token_cmd_t bpf_t:filesystem mount;
diff --git a/tests/bpf/Makefile b/tests/bpf/Makefile
index 1ae8ce9..610a420 100644
--- a/tests/bpf/Makefile
+++ b/tests/bpf/Makefile
@@ -4,6 +4,7 @@ LDLIBS += -lselinux -lbpf
 
 # export so that BPF_ENABLED entries get built correctly on local build
 export CFLAGS += -DHAVE_BPF
+export CFLAGS += -D_GNU_SOURCE
 
 BPF_ENABLED = ../fdreceive ../binder
 
diff --git a/tests/bpf/bpf_common.c b/tests/bpf/bpf_common.c
index 2d97299..97c4d2d 100644
--- a/tests/bpf/bpf_common.c
+++ b/tests/bpf/bpf_common.c
@@ -1,4 +1,6 @@
+#include <sched.h>
 #include "bpf_common.h"
+#include "bpf_token.c"
 
 /*
  * v0.7 deprecates some functions in favor of a new API (introduced in v0.6).
@@ -58,6 +60,39 @@ int create_bpf_prog(void)
 	return prog_fd;
 }
 
+/*
+ * BPF tokens did not exist in the old API - just return 0 if on an older version.
+ */
+int test_bpf_token_capable(void)
+{
+#ifdef USE_NEW_API
+	struct bpffs_opts opts = {
+		.cmds_str = "map_create",
+		.maps_str = "xskmap",
+	};
+
+	return create_bpf_token(&opts, map_test_bpf_token_capable);
+
+#else
+	return 0;
+#endif
+}
+
+int test_bpf_token_cmd(void)
+{
+#ifdef USE_NEW_API
+	struct bpffs_opts opts = {
+		.cmds_str = "map_create",
+		.maps_str = "stack",
+	};
+
+	return create_bpf_token(&opts, map_test_bpf_token_cmd);
+
+#else
+	return 0;
+#endif
+}
+
 /*
  * The default RLIMIT_MEMLOCK is normally 64K, however BPF map/prog requires
  * more than this (the actual threshold varying across arches) so set it to
diff --git a/tests/bpf/bpf_common.h b/tests/bpf/bpf_common.h
index 44ac28f..ed34ab6 100644
--- a/tests/bpf/bpf_common.h
+++ b/tests/bpf/bpf_common.h
@@ -8,9 +8,15 @@
 #include <bpf/bpf.h>
 #include <linux/bpf.h>
 #include <sys/resource.h>
+#include <sys/syscall.h>
+#include <linux/unistd.h>
+#include <sys/mount.h>
+#include <fcntl.h>
 
 extern int create_bpf_map(void);
 extern int create_bpf_prog(void);
+extern int test_bpf_token_capable(void);
+extern int test_bpf_token_cmd(void);
 extern void bpf_setrlimit(void);
 
 /* edited eBPF instruction library */
diff --git a/tests/bpf/bpf_test.c b/tests/bpf/bpf_test.c
index 3c6a29c..ea7c02b 100644
--- a/tests/bpf/bpf_test.c
+++ b/tests/bpf/bpf_test.c
@@ -7,22 +7,27 @@ static void usage(char *progname)
 		"Where:\n\t"
 		"-m    Create BPF map fd\n\t"
 		"-p    Create BPF prog fd\n\t"
+		"-c    Test BPF token capable\n\t"
+		"-d    Test BPF token cmd\n\t"
 		"-v Print information.\n", progname);
 	exit(-1);
 }
 
 int main(int argc, char *argv[])
 {
-	int opt, result, fd;
+	int opt, result, ret;
+	bool isFd = true;
 	bool verbose = false;
 	char *context;
 
 	enum {
 		MAP_FD = 1,
-		PROG_FD
+		PROG_FD,
+		TOKEN_CAP,
+		TOKEN_CMD
 	} bpf_fd_type;
 
-	while ((opt = getopt(argc, argv, "mpv")) != -1) {
+	while ((opt = getopt(argc, argv, "mpvcd")) != -1) {
 		switch (opt) {
 		case 'm':
 			bpf_fd_type = MAP_FD;
@@ -30,6 +35,12 @@ int main(int argc, char *argv[])
 		case 'p':
 			bpf_fd_type = PROG_FD;
 			break;
+		case 'c':
+			bpf_fd_type = TOKEN_CAP;
+			break;
+		case 'd':
+			bpf_fd_type = TOKEN_CMD;
+			break;
 		case 'v':
 			verbose = true;
 			break;
@@ -57,21 +68,36 @@ int main(int argc, char *argv[])
 		if (verbose)
 			printf("Creating BPF map\n");
 
-		fd = create_bpf_map();
+		ret = create_bpf_map();
 		break;
 	case PROG_FD:
 		if (verbose)
 			printf("Creating BPF prog\n");
 
-		fd = create_bpf_prog();
+		ret = create_bpf_prog();
+		break;
+	case TOKEN_CAP:
+		isFd = false;
+		if (verbose)
+			printf("Creating token and testing bpf_token_capable\n");
+
+		ret = test_bpf_token_capable();
+		break;
+	case TOKEN_CMD:
+		isFd = false;
+		if (verbose)
+			printf("Creating token and testing bpf_token_cmd\n");
+
+		ret = test_bpf_token_cmd();
 		break;
 	default:
 		usage(argv[0]);
 	}
 
-	if (fd < 0)
-		return fd;
+	if (ret < 0)
+		return ret;
+	else if (isFd)
+		close(ret);
 
-	close(fd);
 	return 0;
 }
diff --git a/tests/bpf/bpf_token.c b/tests/bpf/bpf_token.c
new file mode 100644
index 0000000..8e33383
--- /dev/null
+++ b/tests/bpf/bpf_token.c
@@ -0,0 +1,459 @@
+// Code derived from: linux/source/tools/testing/selftests/bpf/prog_tests/token.c
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+
+#include "bpf_common.h"
+#include <sys/socket.h>
+#include <signal.h>
+#include <sys/wait.h>
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
+static inline int sys_fsopen(const char *fsname, unsigned flags)
+{
+	return syscall(__NR_fsopen, fsname, flags);
+}
+
+static inline int sys_fsconfig(int fs_fd, unsigned cmd, const char *key,
+			       const void *val, int aux)
+{
+	return syscall(__NR_fsconfig, fs_fd, cmd, key, val, aux);
+}
+
+static inline int sys_fsmount(int fs_fd, unsigned flags, unsigned ms_flags)
+{
+	return syscall(__NR_fsmount, fs_fd, flags, ms_flags);
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
+	if (err < 0) {
+		err = -errno;
+		return err;
+	}
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
+	if (err < 0) {
+		err = -errno;
+		return err;
+	}
+
+	cmsg = CMSG_FIRSTHDR(&msg);
+
+	memcpy(fds, CMSG_DATA(cmsg), sizeof(fds));
+	*fd = fds[0];
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
+int set_delegate_mask(int fs_fd, const char *key, __u64 mask,
+		      const char *mask_str)
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
+int create_bpffs_fd(void)
+{
+	int fs_fd;
+
+	fs_fd = sys_fsopen("bpf", 0);
+
+	return fs_fd;
+}
+
+int materialize_bpffs_fd(int fs_fd, struct bpffs_opts *opts)
+{
+	int mnt_fd, err;
+
+	/* set up token delegation mount options */
+	err = set_delegate_mask(fs_fd, "delegate_cmds", opts->cmds, opts->cmds_str);
+	if (err < 0) {
+		fprintf(stderr, "Failed to set delegate dms: %s\n",
+			strerror(errno));
+		return -errno;
+	}
+	err = set_delegate_mask(fs_fd, "delegate_maps", opts->maps, opts->maps_str);
+	if (err < 0) {
+		fprintf(stderr, "Failed to set delegate maps: %s\n",
+			strerror(errno));
+		return -errno;
+	}
+	err = set_delegate_mask(fs_fd, "delegate_progs", opts->progs, opts->progs_str);
+	if (err < 0) {
+		fprintf(stderr, "Failed to set delegate progs: %s\n",
+			strerror(errno));
+		return -errno;
+	}
+	err = set_delegate_mask(fs_fd, "delegate_attachs", opts->attachs,
+				opts->attachs_str);
+	if (err < 0) {
+		fprintf(stderr, "Failed to set delegate attachs: %s\n",
+			strerror(errno));
+		return -errno;
+	}
+
+	err = sys_fsconfig(fs_fd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
+	if (err < 0) {
+		fprintf(stderr, "Failed fsconfig: %s\n",
+			strerror(errno));
+		return -errno;
+	}
+
+	mnt_fd = sys_fsmount(fs_fd, 0, 0);
+	if (mnt_fd < 0) {
+		fprintf(stderr, "Failed fsmount: %s\n",
+			strerror(errno));
+		return -errno;
+	}
+
+	return mnt_fd;
+}
+
+typedef int (*child_callback_fn)(int token_fd);
+
+static int token_child(int sock_fd, struct bpffs_opts *opts,
+		       child_callback_fn callback)
+{
+	int fs_fd, mnt_fd, bpffs_fd, token_fd, err;
+
+	err = create_and_enter_userns();
+	if (err < 0) {
+		fprintf(stderr, "Failed enter_userns: %s\n",
+			strerror(errno));
+		goto cleanup;
+	}
+
+	err = unshare(CLONE_NEWNS);
+	if (err < 0) {
+		fprintf(stderr, "Failed unshare: %s\n",
+			strerror(errno));
+		goto cleanup;
+	}
+
+	err = mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0);
+	if (err < 0) {
+		fprintf(stderr, "Failed mount: %s\n",
+			strerror(errno));
+		goto cleanup;
+	}
+
+	fs_fd = create_bpffs_fd();
+	if (fs_fd < 0) {
+		fprintf(stderr, "Failed create bpffs_fd: %s\n",
+			strerror(errno));
+		goto cleanup;
+	}
+
+	err = sendfd(sock_fd, fs_fd);
+	if (err < 0) {
+		fprintf(stderr, "Failed to send to parent over socket: %s\n",
+			strerror(errno));
+		goto cleanup;
+	}
+
+	err = recvfd(sock_fd, &mnt_fd);
+	if (err < 0) {
+		fprintf(stderr, "Failed to receive from parent over socket: %s\n",
+			strerror(errno));
+		goto cleanup;
+	}
+
+	bpffs_fd = openat(mnt_fd, ".", 0, O_RDWR);
+	if (bpffs_fd < 0) {
+		fprintf(stderr, "Failed openat: %s\n",
+			strerror(errno));
+		goto cleanup;
+	}
+
+	token_fd = bpf_token_create(bpffs_fd, NULL);
+	if (token_fd < 0) {
+		fprintf(stderr, "Failed bpf_token_create: %s\n",
+			strerror(errno));
+		goto cleanup;
+	}
+
+	err = callback(token_fd);
+
+cleanup:
+	close(sock_fd);
+	close(mnt_fd);
+	close(fs_fd);
+	close(bpffs_fd);
+	close(token_fd);
+	if (err < 0)
+		exit(err);
+	exit(0);
+}
+
+static int token_parent(int child_pid, struct bpffs_opts *bpffs_opts,
+			int sock_fd)
+{
+	int fs_fd = -1, mnt_fd = -1, err;
+
+	err = recvfd(sock_fd, &fs_fd);
+	if (err < 0) {
+		fprintf(stderr, "Failed to receive from child: %s\n",
+			strerror(errno));
+		goto cleanup;
+	}
+
+	mnt_fd = materialize_bpffs_fd(fs_fd, bpffs_opts);
+	if (mnt_fd < 0) {
+		fprintf(stderr, "Failed materialize bpffs_fd: %s\n",
+			strerror(errno));
+		err = mnt_fd;
+		goto cleanup;
+	}
+	close(fs_fd);
+
+	/* pass BPF FS context object to parent */
+	err = sendfd(sock_fd, mnt_fd);
+	if (err < 0) {
+		fprintf(stderr, "Failed to send to child: %s\n",
+			strerror(errno));
+		goto cleanup;
+	}
+
+cleanup:
+	close(sock_fd);
+	close(fs_fd);
+	close(mnt_fd);
+	return err;
+}
+
+int map_test_bpf_token_capable(int token_fd)
+{
+	int map_fd;
+
+	LIBBPF_OPTS(bpf_map_create_opts, optslib);
+	optslib.map_flags = BPF_F_TOKEN_FD;
+	optslib.token_fd = token_fd;
+	map_fd = bpf_map_create(BPF_MAP_TYPE_XSKMAP, NULL,
+				4, 4, 16, &optslib);
+
+	if (map_fd < 0) {
+		fprintf(stderr, "Failed to create BPF map: %s\n",
+			strerror(errno));
+	}
+
+	return map_fd;
+}
+
+int map_test_bpf_token_cmd(int token_fd)
+{
+	int map_fd;
+
+	LIBBPF_OPTS(bpf_map_create_opts, optslib);
+	optslib.map_flags = BPF_F_TOKEN_FD;
+	optslib.token_fd = token_fd;
+	map_fd = bpf_map_create(BPF_MAP_TYPE_STACK, NULL,
+				0, 8, 1, &optslib);
+
+	if (map_fd < 0) {
+		fprintf(stderr, "Failed to create BPF map: %s\n",
+			strerror(errno));
+	}
+
+	return map_fd;
+}
+
+int create_bpf_token(struct bpffs_opts *opts, child_callback_fn child_callback)
+{
+	int err, child_pid = 0;
+	int sock_fds[2] = { -1, -1 };
+
+	err = socketpair(AF_UNIX, SOCK_STREAM, 0, sock_fds);
+	if (err < 0) {
+		fprintf(stderr, "Failed to create sockets: %s\n",
+			strerror(errno));
+		goto cleanup;
+	}
+
+	child_pid = fork();
+	if (child_pid < 0) {
+		fprintf(stderr, "Failed fork: %s\n",
+			strerror(errno));
+		err = child_pid;
+		goto cleanup;
+	}
+
+	if (child_pid == 0) {
+		close(sock_fds[0]);
+		err = token_child(sock_fds[1], opts, child_callback);
+		if (err < 0) {
+			fprintf(stderr, "Child failed: %s\n",
+				strerror(errno));
+		}
+	} else {
+		close(sock_fds[1]);
+		err = token_parent(child_pid, opts, sock_fds[0]);
+		if (err < 0) {
+			fprintf(stderr, "Parent failed: %s\n",
+				strerror(errno));
+			goto cleanup;
+		}
+		err = -(wait_for_pid(child_pid));
+	}
+
+cleanup:
+	close(sock_fds[0]);
+	close(sock_fds[1]);
+
+	if (child_pid > 0)
+		(void)kill(child_pid, SIGKILL);
+
+	return err;
+}
diff --git a/tests/bpf/test b/tests/bpf/test
index a3fd856..5220700 100755
--- a/tests/bpf/test
+++ b/tests/bpf/test
@@ -7,7 +7,7 @@ BEGIN {
     $fdr_basedir    = "$basedir/../fdreceive";
     $binder_basedir = "$basedir/../binder";
 
-    $test_bpf_count       = 7;
+    $test_bpf_count       = 11;
     $test_fdreceive_count = 4;
 
     $test_count = $test_bpf_count + $test_fdreceive_count;
@@ -67,6 +67,14 @@ ok( $result eq 0 );
 $result = system "runcon -t test_bpf_t $basedir/bpf_test -p $v";
 ok( $result eq 0 );
 
+# BPF map with token - checks bpf_token_capable
+$result = system "runcon -t test_bpf_t $basedir/bpf_test -c $v";
+ok( $result eq 0 );
+
+# BPF map with token - checks bpf_token_cmd
+$result = system "runcon -t test_bpf_t $basedir/bpf_test -d $v";
+ok( $result eq 0 );
+
 # Deny map_create permission
 $result =
   system "runcon -t test_bpf_deny_map_create_t $basedir/bpf_test -m $v 2>&1";
@@ -92,6 +100,16 @@ $result =
   system "runcon -t test_bpf_deny_prog_run_t $basedir/bpf_test -p $v 2>&1";
 ok($result);
 
+# Deny token_cap permission
+$result =
+  system "runcon -t test_bpf_deny_token_cap_t $basedir/bpf_test -c $v 2>&1";
+ok($result);
+
+# Deny token_cmd permission
+$result =
+  system "runcon -t test_bpf_deny_token_cmd_t $basedir/bpf_test -d $v 2>&1";
+ok($result);
+
 #
 ################ BPF Tests for fdreceive #######################
 #
-- 
2.50.1

