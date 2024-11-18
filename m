Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E331C230E
	for <selinux@vger.kernel.org>; Mon, 18 Nov 2024 15:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731942200; cv=none; b=DcxDaSuTSs8C72P67q1Hwmo573Z+apiHkLm30NNtrgsBk3Zg62VW8JiblpRf3zKiEPrzErSk6N/Hj63k3Xb0MDdwy+Ki71sMATwgsFxYzAh4dH4iieMTSneXoVQrNNmLs2vktzxYFqvSA82Dz48lvlNklaKanPXg/EcP4vJGZ4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731942200; c=relaxed/simple;
	bh=tEpf1BnOJ8Zy92CVQQ5UvWLVvZaRUGA3LpjyS2sg8Ws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TJLl5kxuvhPaUoXxmhsqTWJKoqb1ErAvcCdyuNZX22mxN7zOkerNYbSOll1v4FSuQ0OonMkZuKu98UHKMW4qC3kbl68wkom5pLSuR30w2vh8yfyxfwh0U+cdRA64B4A37D/NzlD3QisXVu8MceDCK41jnyVRX4Sny7XbR/3QULA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=Zuch6llh; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="Zuch6llh"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731942185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NA+0OLOMurSuoC9pbDuxEz9JNJh6P5gAaH7nIkSniRg=;
	b=Zuch6llhcDrg3xvQ/L/28aIfRb8w4XrSIdiFfIJY+mvz1aGf1L03m1iJP6yFKAPsK2IOxk
	p43Ikjmhpe0qJe39t+2NOY9dj6O8n9yYjyBBLlTbvZrm1vYKPl0Dn7jYx0lNq+koLYtfEf
	+0x1ZlQe0UIb/SSfxxDTxUbl6JTJ+CPMPq7a3sCXHGRqTfXOcIcgG3LPnFaP0hkfp5ZVu8
	wqQfMIa4S7obkGYHt1QWGWfQUsnIabmCcoMljyyxm7UGXPIeCnRyDLmisXHDhntmAS01LE
	o+aR5yGHUZTGhsgrK04lyFVzwWueAGXE/6PLriFSmuBxkICr8EytK8vvM6JCyw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 15/17] tests: test code tweaks
Date: Mon, 18 Nov 2024 16:02:37 +0100
Message-ID: <20241118150256.135432-16-cgoettsche@seltendoof.de>
In-Reply-To: <20241118150256.135432-1-cgoettsche@seltendoof.de>
References: <20241118150256.135432-1-cgoettsche@seltendoof.de>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Be more cautious on unexpected failures and input:

  binder
    Avoid returning garbage value from binder_parse() in case of an
    unexpected (impossible?) empty buffer.
    Store create_bpf_*() results temporarily in an int to actually
    perform the error checks (they are currently no-ops on unsigned).

  bpf
    Initialize variable in case the program gets called without the
    associated option.

  cap_userns
    Use appropriate types and casts to avoid implicit conversions.

  execshare
    Avoid use of void pointer arithmetic.

  fdreceive
    Do not call non async-safe exit(3) in signal handler.
    Drop dead assignment.

  filesystem
    Initialize variables in case the programs get called without the
    associated options.

  inet_socket/unix_socket
    Declare usage() as noreturn to help compilers avoid issuing
    inaccurate warnings.

  inherit
    Use a large enough buffer for a potential huge PID.

  key_socket
    Avoid comparison of signed with unsigned integer.

  module_load
    Correctly check for an open(2) failure.

  nnp_nosuid
    Check if wait(2) succeeded before checking the child status.

  notify
    Check if opening file was successful.
    Use appropriate type for read(2) return value.

  prlimit
    Set all members of the new limit structure.

  sctp
    Use appropriate iterator type.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 tests/binder/client.c                |  2 +-
 tests/binder/manager.c               |  2 +-
 tests/binder/service_provider.c      | 12 +++++++-----
 tests/bpf/bpf_test.c                 |  2 +-
 tests/cap_userns/userns_child_exec.c |  6 +++---
 tests/execshare/parent.c             |  2 +-
 tests/fdreceive/server.c             |  3 +--
 tests/filesystem/fs_relabel.c        |  2 +-
 tests/filesystem/grim_reaper.c       |  2 +-
 tests/inet_socket/bind.c             |  1 +
 tests/inet_socket/connect.c          |  1 +
 tests/inherit/parent.c               |  2 +-
 tests/key_socket/key_sock.c          |  2 +-
 tests/module_load/init_load.c        |  2 +-
 tests/nnp_nosuid/execnnp.c           |  2 +-
 tests/notify/test_fanotify.c         |  8 ++++++--
 tests/prlimit/parent.c               |  2 ++
 tests/sctp/sctp_common.c             |  4 ++--
 tests/unix_socket/client.c           |  1 +
 tests/unix_socket/server.c           |  1 +
 tests/unix_socket/socketpair.c       |  1 +
 21 files changed, 36 insertions(+), 24 deletions(-)

diff --git a/tests/binder/client.c b/tests/binder/client.c
index 4965563..220d37a 100644
--- a/tests/binder/client.c
+++ b/tests/binder/client.c
@@ -231,7 +231,7 @@ static void extract_handle_and_acquire(int fd,
 static int binder_parse(int fd, binder_uintptr_t ptr, binder_size_t size)
 {
 	binder_uintptr_t end = ptr + size;
-	uint32_t cmd;
+	uint32_t cmd = BR_DEAD_REPLY;
 
 	while (ptr < end) {
 		cmd = *(uint32_t *)ptr;
diff --git a/tests/binder/manager.c b/tests/binder/manager.c
index 8e5f446..f7f1723 100644
--- a/tests/binder/manager.c
+++ b/tests/binder/manager.c
@@ -156,7 +156,7 @@ static void reply_with_handle(int fd, struct binder_transaction_data *txn_in)
 static int binder_parse(int fd, binder_uintptr_t ptr, binder_size_t size)
 {
 	binder_uintptr_t end = ptr + size;
-	uint32_t cmd;
+	uint32_t cmd = BR_DEAD_REPLY;
 
 	while (ptr < end) {
 		cmd = *(uint32_t *)ptr;
diff --git a/tests/binder/service_provider.c b/tests/binder/service_provider.c
index 97c59dd..1e6b490 100644
--- a/tests/binder/service_provider.c
+++ b/tests/binder/service_provider.c
@@ -76,14 +76,16 @@ static void request_service_provider_fd(int fd,
 		break;
 #if HAVE_BPF
 	case BPF_MAP_FD:
-		obj.fd = create_bpf_map();
-		if (obj.fd < 0)
+		result = create_bpf_map();
+		if (result < 0)
 			exit(70);
+		obj.fd = result;
 		break;
 	case BPF_PROG_FD:
-		obj.fd = create_bpf_prog();
-		if (obj.fd < 0)
+		result = create_bpf_prog();
+		if (result < 0)
 			exit(71);
+		obj.fd = result;
 		break;
 #else
 	case BPF_MAP_FD:
@@ -122,7 +124,7 @@ static void request_service_provider_fd(int fd,
 static int binder_parse(int fd, binder_uintptr_t ptr, binder_size_t size)
 {
 	binder_uintptr_t end = ptr + size;
-	uint32_t cmd;
+	uint32_t cmd = BR_DEAD_REPLY;
 
 	while (ptr < end) {
 		cmd = *(uint32_t *)ptr;
diff --git a/tests/bpf/bpf_test.c b/tests/bpf/bpf_test.c
index 3c6a29c..f43440a 100644
--- a/tests/bpf/bpf_test.c
+++ b/tests/bpf/bpf_test.c
@@ -20,7 +20,7 @@ int main(int argc, char *argv[])
 	enum {
 		MAP_FD = 1,
 		PROG_FD
-	} bpf_fd_type;
+	} bpf_fd_type = -1;
 
 	while ((opt = getopt(argc, argv, "mpv")) != -1) {
 		switch (opt) {
diff --git a/tests/cap_userns/userns_child_exec.c b/tests/cap_userns/userns_child_exec.c
index bfff944..a7ad7bb 100644
--- a/tests/cap_userns/userns_child_exec.c
+++ b/tests/cap_userns/userns_child_exec.c
@@ -89,8 +89,8 @@ usage(char *pname)
 static void
 update_map(char *mapping, char *map_file)
 {
-	int fd, j;
-	size_t map_len;     /* Length of 'mapping' */
+	int fd;
+	size_t j, map_len;     /* Length of 'mapping' */
 
 	/* Replace commas in mapping string with newlines */
 
@@ -106,7 +106,7 @@ update_map(char *mapping, char *map_file)
 		exit(EXIT_FAILURE);
 	}
 
-	if (write(fd, mapping, map_len) != map_len) {
+	if (write(fd, mapping, map_len) != (ssize_t)map_len) {
 		fprintf(stderr, "ERROR: write %s: %s\n", map_file,
 			strerror(errno));
 		exit(EXIT_FAILURE);
diff --git a/tests/execshare/parent.c b/tests/execshare/parent.c
index db2e127..a0e815b 100644
--- a/tests/execshare/parent.c
+++ b/tests/execshare/parent.c
@@ -43,7 +43,7 @@ int main(int argc, char **argv)
 		perror("malloc");
 		exit(-1);
 	}
-	clone_stack = page + pagesize;
+	clone_stack = (unsigned char *)page + pagesize;
 
 	rc = getcon(&context_tmp);
 	if (rc < 0) {
diff --git a/tests/fdreceive/server.c b/tests/fdreceive/server.c
index ff91532..bbe1c63 100644
--- a/tests/fdreceive/server.c
+++ b/tests/fdreceive/server.c
@@ -9,7 +9,7 @@
 #include <stdlib.h>
 
 char my_path[1024];
-#define CLEANUP_AND_EXIT do { unlink(my_path); exit(1); } while (0)
+#define CLEANUP_AND_EXIT do { unlink(my_path); _exit(1); } while (0)
 
 void handler(int sig)
 {
@@ -43,7 +43,6 @@ int main(int argc, char **argv)
 	}
 
 	sun.sun_family = AF_UNIX;
-	sunlen = sizeof(struct sockaddr_un);
 	strcpy(sun.sun_path, argv[2]);
 	sunlen = strlen(sun.sun_path) + 1 + sizeof(short);
 	strcpy(my_path, sun.sun_path);
diff --git a/tests/filesystem/fs_relabel.c b/tests/filesystem/fs_relabel.c
index 4daf70c..229fcb5 100644
--- a/tests/filesystem/fs_relabel.c
+++ b/tests/filesystem/fs_relabel.c
@@ -27,7 +27,7 @@ int main(int argc, char **argv)
 {
 	int opt, result, save_err;
 	const char *newcon;
-	char *context, *fs_con = NULL, *base_dir, *type;
+	char *context, *fs_con = NULL, *base_dir = NULL, *type = NULL;
 	char fs_mount[PATH_MAX];
 	bool verbose = false;
 	context_t con_t;
diff --git a/tests/filesystem/grim_reaper.c b/tests/filesystem/grim_reaper.c
index 340546a..167441d 100644
--- a/tests/filesystem/grim_reaper.c
+++ b/tests/filesystem/grim_reaper.c
@@ -26,7 +26,7 @@ int main(int argc, char *argv[])
 	size_t len;
 	ssize_t num;
 	int opt, index = 0, i, result = 0;
-	char *mount_info[2], *buf = NULL, *item, *tgt;
+	char *mount_info[2], *buf = NULL, *item, *tgt = NULL;
 	bool verbose = false;
 
 	while ((opt = getopt(argc, argv, "t:v")) != -1) {
diff --git a/tests/inet_socket/bind.c b/tests/inet_socket/bind.c
index 389ca20..51dae02 100644
--- a/tests/inet_socket/bind.c
+++ b/tests/inet_socket/bind.c
@@ -12,6 +12,7 @@
 #define IPPROTO_MPTCP 262
 #endif
 
+__attribute__((noreturn))
 void usage(char *progname)
 {
 	fprintf(stderr, "usage:  %s protocol port\n", progname);
diff --git a/tests/inet_socket/connect.c b/tests/inet_socket/connect.c
index e2d02da..c4defa6 100644
--- a/tests/inet_socket/connect.c
+++ b/tests/inet_socket/connect.c
@@ -15,6 +15,7 @@
 #define IPPROTO_MPTCP 262
 #endif
 
+__attribute__((noreturn))
 void usage(char *progname)
 {
 	fprintf(stderr, "usage:  %s protocol port\n", progname);
diff --git a/tests/inherit/parent.c b/tests/inherit/parent.c
index d37bcfe..c218b42 100644
--- a/tests/inherit/parent.c
+++ b/tests/inherit/parent.c
@@ -66,7 +66,7 @@ int main(int argc, char **argv)
 		fprintf(stderr, "%s:  out of memory\n", argv[0]);
 		exit(-1);
 	}
-	childargv[1] = malloc(6);
+	childargv[1] = malloc(11);
 	if (!childargv[1]) {
 		fprintf(stderr, "%s:  out of memory\n", argv[0]);
 		exit(-1);
diff --git a/tests/key_socket/key_sock.c b/tests/key_socket/key_sock.c
index 29beb0e..3333fa0 100644
--- a/tests/key_socket/key_sock.c
+++ b/tests/key_socket/key_sock.c
@@ -111,7 +111,7 @@ int main(int argc, char *argv[])
 	    r_msg.sadb_msg_type != w_msg.sadb_msg_type ||
 	    r_msg.sadb_msg_satype != w_msg.sadb_msg_satype ||
 	    r_msg.sadb_msg_seq != w_msg.sadb_msg_seq ||
-	    r_msg.sadb_msg_pid != getpid()) {
+	    (pid_t)r_msg.sadb_msg_pid != getpid()) {
 		fprintf(stderr, "Failed to read correct sadb_msg data:\n");
 		fprintf(stderr, "\tSent - ver: %d type: %d sa_type: %d seq: %d pid: %d\n",
 			w_msg.sadb_msg_version, w_msg.sadb_msg_type,
diff --git a/tests/module_load/init_load.c b/tests/module_load/init_load.c
index 0422c19..821c4bd 100644
--- a/tests/module_load/init_load.c
+++ b/tests/module_load/init_load.c
@@ -52,7 +52,7 @@ int main(int argc, char *argv[])
 	}
 
 	fd = open(file_name, O_RDONLY);
-	if (!fd) {
+	if (fd < 0) {
 		fprintf(stderr, "Failed to open %s: %s\n",
 			file_name, strerror(errno));
 		exit(-1);
diff --git a/tests/nnp_nosuid/execnnp.c b/tests/nnp_nosuid/execnnp.c
index 78b5ab5..b4e4928 100644
--- a/tests/nnp_nosuid/execnnp.c
+++ b/tests/nnp_nosuid/execnnp.c
@@ -67,7 +67,7 @@ int main(int argc, char **argv)
 	}
 
 	pid = wait(&status);
-	if (WIFEXITED(status)) {
+	if (pid >= 0 && WIFEXITED(status)) {
 		if (WEXITSTATUS(status) && nobounded) {
 			printf("%s:  Kernels < v3.18 do not support bounded transitions under NNP.\n",
 			       argv[0]);
diff --git a/tests/notify/test_fanotify.c b/tests/notify/test_fanotify.c
index fe89265..c771a8d 100644
--- a/tests/notify/test_fanotify.c
+++ b/tests/notify/test_fanotify.c
@@ -86,6 +86,10 @@ int main(int argc, char *argv[])
 			FILE *f;
 
 			f = fopen(argv[optind], "r");  // open file for reading
+			if (!f) {
+				perror("test_fanotify:bad listen file");
+				exit(1);
+			}
 			fgetc(f);                      // read char from file
 
 			fclose(f);
@@ -100,9 +104,9 @@ int main(int argc, char *argv[])
 					if (fds.revents & POLLIN) {
 						struct fanotify_event_metadata buff[200];
 
-						size_t len = read(fd, (void *)&buff, sizeof(buff));
+						ssize_t len = read(fd, (void *)&buff, sizeof(buff));
 						if (len == -1) {
-							perror("test_fanotify:can't open file");
+							perror("test_fanotify:can't read file");
 							exit(1);
 						} else {
 							listening = 0;
diff --git a/tests/prlimit/parent.c b/tests/prlimit/parent.c
index 649aecf..70daefb 100644
--- a/tests/prlimit/parent.c
+++ b/tests/prlimit/parent.c
@@ -138,12 +138,14 @@ int main(int argc, char **argv)
 		newrlimp = &newrlim;
 		if (soft) {
 			newrlim.rlim_max = oldrlim.rlim_max;
+			newrlim.rlim_cur = oldrlim.rlim_cur;
 			if (newrlim.rlim_cur == RLIM_INFINITY)
 				newrlim.rlim_cur = 1024;
 			else
 				newrlim.rlim_cur = oldrlim.rlim_cur / 2;
 		} else {
 			newrlim.rlim_cur = oldrlim.rlim_cur;
+			newrlim.rlim_max = oldrlim.rlim_max;
 			if (newrlim.rlim_max == RLIM_INFINITY)
 				newrlim.rlim_max = 1024;
 			else
diff --git a/tests/sctp/sctp_common.c b/tests/sctp/sctp_common.c
index d10225c..527cda3 100644
--- a/tests/sctp/sctp_common.c
+++ b/tests/sctp/sctp_common.c
@@ -105,9 +105,9 @@ void print_addr_info(struct sockaddr *sin, char *text)
 
 char *get_ip_option(int fd, bool ipv4, socklen_t *opt_len)
 {
-	int result, i;
+	int result;
 	unsigned char ip_options[1024];
-	socklen_t len = sizeof(ip_options);
+	socklen_t i, len = sizeof(ip_options);
 	char *ip_optbuf;
 
 	if (ipv4)
diff --git a/tests/unix_socket/client.c b/tests/unix_socket/client.c
index 093c319..eaf83ee 100644
--- a/tests/unix_socket/client.c
+++ b/tests/unix_socket/client.c
@@ -11,6 +11,7 @@
 #include <errno.h>
 #include <selinux/selinux.h>
 
+__attribute__((noreturn))
 void usage(char *progname)
 {
 	fprintf(stderr,
diff --git a/tests/unix_socket/server.c b/tests/unix_socket/server.c
index bd85e4c..1ec9db5 100644
--- a/tests/unix_socket/server.c
+++ b/tests/unix_socket/server.c
@@ -16,6 +16,7 @@
 #define SCM_SECURITY 0x03
 #endif
 
+__attribute__((noreturn))
 void usage(char *progname)
 {
 	fprintf(stderr,
diff --git a/tests/unix_socket/socketpair.c b/tests/unix_socket/socketpair.c
index d547d10..a9ac873 100644
--- a/tests/unix_socket/socketpair.c
+++ b/tests/unix_socket/socketpair.c
@@ -17,6 +17,7 @@
 #define SCM_SECURITY 0x03
 #endif
 
+__attribute__((noreturn))
 void print_usage(char *progname)
 {
 	fprintf(stderr,
-- 
2.45.2

