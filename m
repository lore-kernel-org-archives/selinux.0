Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793624919;
	b=M71+HnXABKoKr5I10nFl5MMcGpSqD+HLK6t+WYN1wC3jYKD7vRpXEsANcb/j51VJaPXY
	 59+cwnK16qjmqjyvCcvzcFe6kRARf8vVGQaAGGfB2NtqX/nHKnqDiNvmfHQYhNlmt/0Y8
	 6Z8/SKJUtwuAoVTzS9iYOX8dBK8rmK0D1bRh20+yytvKu7YamZ/PXT9j6lLu17UmQ9TXL
	 b0Ue/Cn50oztzh7boWpuyI5W9M6Egc1LBd4RqCD7c3PXzEhuTCAPUxk5ENG3j3H9ESqbl
	 eWsEPACJnKGiotRrc41VGr+iIIJoquM7PP5hTmXkdLP6T7Kuhqv3BB+DCV0b6SIk/dA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793624919;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=GvBXtaS3P8kam8knTHFZhwR8CuREyXaBIKvDrF+C8Tk=;
	b=AqnkPD4qAtu4qFjaGfC5kkQbT+SihY4ci2XXpyoX6XXhgbXue/jOVwZosEZznCoZfOSv
	 3fCwesM83jg/RlItGvosyf+lSHkVCtJXfhovnVpq31gPZ5Q2ivz3v8eHmBD+5P+/0XSHp
	 aiFyAaBXo0GW63oXcQDVdFltkRkLZD4jUx9eL+j/X03pe8NxyqPYxArx8yADmfJUPDgFL
	 Oz5grNETZ4dprtQC2T5qp3WkNdRwDLyjql/XQZhwxdEXkJqSwu36ZDbHAQiHgTd2pSErb
	 C1LaDNjU0sCT/foSwNne1B1UDiaCcoTiE3JxnBCJ3Nl/XTsZD8fTG1HlFMIvktM2pXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="HF/Mq85M";
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F054606A326
	for <selinux@vger.kernel.org>; Mon,  2 Nov 2026 13:08:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F054606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HF/Mq85M
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48dfb76b304so244824f8f.2
        for <selinux@vger.kernel.org>; Mon, 02 Nov 2026 05:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793624917; x=1794229717; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GvBXtaS3P8kam8knTHFZhwR8CuREyXaBIKvDrF+C8Tk=;
        b=HF/Mq85MT47/gD7peCkjHfXKYeJchZZNJf/G7PfQ3Pz4Kt2AlBr3wk6ul2jXCHg/Fb
         8t+2gfha3Z9DAn21XLGYJgZ57PyIg+IZduNZwOuSlNAuU3L3h3h7fohS8Jq9flAMvuTh
         vAi8VA/QgC3vg8NkE6r0pgVosu4uB4kak/R3MsQTeqhOnvzbedfhbiWZray1neOvay+4
         g3OMFWNeV/lQcnRkFj4gCB0hZdPVoTj8yfVGFAJ5VQd7rm+TSWQYPTy9V2of0kPcdhp0
         /kk2Yb7rQE40DqLin7hFSeFOpxILQMoKztnpQlkTpXehCB1ZktRGc/MOTRY05pDEkoNF
         v9pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793624917; x=1794229717;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GvBXtaS3P8kam8knTHFZhwR8CuREyXaBIKvDrF+C8Tk=;
        b=KWldPHMvGYWuski/Dh89xAtjssqnpRVKTYQ3qxAXzadElVHTpkr//VVcHQlD5HYHrf
         2/NCSy5LF5wWr1b+DnN4NALWoWrQX5O6rqOnxAj1HRt9Fi9YZdK5WmVFdhFq81Ta+cGg
         hoFHU+BnndQQu6aNioIeVLPaxcQ4AMEuDZq5gmamWhtt+xuhoTrWU8HLLhc9JpF7yqpk
         yVFDesd4hKLQoIK46RHlzmq39weMF73c1hAOX+omTgoiD6dTd6G/rMQlAYiCKdV/18o0
         7TEwdr7MUC3PD2J25q6brKcVgrddQ4aAfdcvaYK3BgBjipGsURzKTUxpK4UoB5PyiyL5
         l/Bg==
X-Gm-Message-State: APuU4Z84W47OvA+dXiOzMFknasWWhbccr7aI55xJy7YqoZ6juzfbybeQ
	DbebEd/NkYTxZ6w9O+5a1qnRTVouIkrzEANxyxzq/37i21OwEQZtbr3r816uo9ti
X-Gm-Gg: AYBFou3QLhZHAevDeBHv9sWX1wDpZf6lfRNCTt1BGz+APvqremxjw34W2YBZxliL1W7
	i9LllDr4x2oqsUN3bI2OThZeAaN4mNeXcQgpHJfMEK9QWu2siueCA+Tn1Z6ZaddYtRf/Qyc75Sa
	NoPBvJC08mCX93MoIRhg51Ltga/dN5KF2+vAFOa7s2R7QAKaWtWZ1wBcZF4IhkmdQA64Z/bBuWq
	HKlNsA9PBZqMUW/c45djU0dYE34dL95mMsDZQkWQOSoCEMDZ/wln+na/h1warKDduC+UJTNxbuX
	4OmWQ8D9JoUN+3YLQAXtkFBJARsGMolopq3e+xEzcPcWIHyM1r7Ef22DV1bHzZOugcwbEcNlhxF
	GFSHBbnIvdVcfh+uo3fIUH7gCK7P4Wh2KiHLzpBZT60hdQQjB7/w5ZoAfG80YdJHStXSkpxzjGZ
	f/5wtqgB+OO4pxwraX2CF3xM55bBQgXKc7pZFPJU6JUPgMb2ryCU8D8/EiTrvCvxsLeWDY/P284
	4C0va/cotZqD+pvSbZtgqxP6fsWoUKY1I/aEZvb0NwSUcFDEjZRapD/qsG/CsWurFUillse70el
	kX3BFpuJ1/D3U39uAfG1u3H21vgc51L42HmFkuJUWILFJy02niWFek2bZKiId85iBGJKKoEBLPU
	i4WjfTIj6
X-Received: by 2002:a05:6000:186c:b0:48e:7a19:7aad with SMTP id ffacd0b85a97d-48e7a197e64mr15761288f8f.6.1793624916772;
        Mon, 02 Nov 2026 05:08:36 -0800 (PST)
Received: from omos-acer.lan (109-81-86-162.rct.o2.cz. [109.81.86.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71bae25dsm18086557f8f.59.2026.11.02.05.08.35
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 05:08:36 -0800 (PST)
From: =?UTF-8?q?Ondrej=20Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>
To: selinux@vger.kernel.org
Subject: [RFC PATCH testsuite v2] tests/unix_socket: add test for MSG_CMSG_SEALED
Date: Mon,  2 Nov 2026 14:08:34 +0100
Message-ID: <20261102130834.253605-1-omosnacek@gmail.com>
X-Mailer: git-send-email 2.54.0
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

Test the new MSG_CMSG_SEALED flag for UNIX sockets. This flag allows
forwarding file descriptors via SCM_RIGHTS without having read/write
access to the file handle being transported. The file descriptor
received with this flag is an opaque anon inode that doesn't allow
accessing the original file handle - it can only be passed further
via SCM_RIGHTS again and then received normally by the destination
process. The LSM checks for a received "sealed" file are skipped and
only performed when the file is eventually received "unsealed".

The test verifies that a domain using this mechanism to forward a file
handle doesn't need to have access to the file to do so and that the
final recipient does.

The test is automatically skipped when the kernel doesn't support this
feature, which is determined using the SO_RIGHTS_SEALED_SUPPORTED socket
option on a dummy UNIX socket.

Signed-off-by: Ondrej Mosnáček <omosnacek@gmail.com>
---

v2: drop unintended debug patch

 policy/test_unix_socket.te          |  50 +++++++++
 tests/unix_socket/.gitignore        |   4 +
 tests/unix_socket/Makefile          |   2 +-
 tests/unix_socket/fd_forwarder.c    | 158 ++++++++++++++++++++++++++++
 tests/unix_socket/fd_receiver.c     |  98 +++++++++++++++++
 tests/unix_socket/fd_sealed_check.c |  26 +++++
 tests/unix_socket/fd_sender.c       |  88 ++++++++++++++++
 tests/unix_socket/test              |  83 +++++++++++++--
 8 files changed, 500 insertions(+), 9 deletions(-)
 create mode 100644 tests/unix_socket/fd_forwarder.c
 create mode 100644 tests/unix_socket/fd_receiver.c
 create mode 100644 tests/unix_socket/fd_sealed_check.c
 create mode 100644 tests/unix_socket/fd_sender.c

diff --git a/policy/test_unix_socket.te b/policy/test_unix_socket.te
index f4e9e41..4d0f758 100644
--- a/policy/test_unix_socket.te
+++ b/policy/test_unix_socket.te
@@ -58,3 +58,53 @@ allow test_unix_server_t test_unix_dgram_client_t:unix_dgram_socket sendto;
 type test_socketpair_t;
 testsuite_domain_type(test_socketpair_t)
 typeattribute test_socketpair_t unixsocketdomain;
+
+#
+# Domains for MSG_CMSG_SEALED tests.
+#
+type test_unix_payload_t;
+files_type(test_unix_payload_t)
+
+# Forwarder domain (can't rw payload; only pass it along)
+type test_unix_fd_forwarder_t;
+testsuite_domain_type(test_unix_fd_forwarder_t)
+typeattribute test_unix_fd_forwarder_t unixsocketdomain;
+
+type_transition test_unix_fd_forwarder_t test_file_t:sock_file test_unix_server_sockfile_t;
+allow test_unix_fd_forwarder_t test_file_t:dir rw_dir_perms;
+allow test_unix_fd_forwarder_t test_unix_server_sockfile_t:sock_file { create unlink };
+
+# For writing to flag file:
+allow test_unix_fd_forwarder_t test_file_t:fifo_file rw_file_perms;
+
+neverallow test_unix_fd_forwarder_t test_unix_payload_t:file { read write };
+
+# Sender domain
+type test_unix_fd_sender_t;
+testsuite_domain_type(test_unix_fd_sender_t)
+typeattribute test_unix_fd_sender_t unixsocketdomain;
+
+allow test_unix_fd_sender_t test_unix_fd_forwarder_t:unix_stream_socket connectto;
+allow test_unix_fd_sender_t test_unix_server_sockfile_t:sock_file write;
+
+allow test_unix_fd_sender_t test_unix_payload_t:file rw_file_perms;
+
+# Receiver domain (can rw payload)
+type test_unix_fd_receiver_t;
+testsuite_domain_type(test_unix_fd_receiver_t)
+typeattribute test_unix_fd_receiver_t unixsocketdomain;
+
+allow test_unix_fd_receiver_t test_unix_fd_forwarder_t:unix_stream_socket connectto;
+allow test_unix_fd_receiver_t test_unix_server_sockfile_t:sock_file write;
+
+allow test_unix_fd_receiver_t test_unix_payload_t:file rw_inherited_file_perms;
+
+# Bad receiver domain (can't rw payload - should fail receiving it)
+type test_unix_fd_bad_receiver_t;
+testsuite_domain_type(test_unix_fd_bad_receiver_t)
+typeattribute test_unix_fd_bad_receiver_t unixsocketdomain;
+
+allow test_unix_fd_bad_receiver_t test_unix_fd_forwarder_t:unix_stream_socket connectto;
+allow test_unix_fd_bad_receiver_t test_unix_server_sockfile_t:sock_file write;
+
+neverallow test_unix_fd_bad_receiver_t test_unix_payload_t:file { read write };
diff --git a/tests/unix_socket/.gitignore b/tests/unix_socket/.gitignore
index 05ed268..f3eb70d 100644
--- a/tests/unix_socket/.gitignore
+++ b/tests/unix_socket/.gitignore
@@ -1,3 +1,7 @@
 client
 server
 socketpair
+fd_sealed_check
+fd_forwarder
+fd_receiver
+fd_sender
diff --git a/tests/unix_socket/Makefile b/tests/unix_socket/Makefile
index f8db20b..f8b892d 100644
--- a/tests/unix_socket/Makefile
+++ b/tests/unix_socket/Makefile
@@ -1,4 +1,4 @@
-TARGETS=client server socketpair
+TARGETS=client server socketpair fd_sealed_check fd_forwarder fd_receiver fd_sender
 
 LDLIBS+= -lselinux
 
diff --git a/tests/unix_socket/fd_forwarder.c b/tests/unix_socket/fd_forwarder.c
new file mode 100644
index 0000000..ec68919
--- /dev/null
+++ b/tests/unix_socket/fd_forwarder.c
@@ -0,0 +1,158 @@
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <stddef.h>
+#include <string.h>
+#include <unistd.h>
+#include <stdio.h>
+
+#ifndef MSG_CMSG_SEALED
+#define MSG_CMSG_SEALED 0x10000000
+#endif
+
+void usage(char *progname)
+{
+	fprintf(stderr,
+		"usage:  %s [-f file] socket-name\n",
+		progname);
+	exit(1);
+}
+
+int main(int argc, char **argv)
+{
+	int opt, sock, newsock, payload_fd;
+	char *flag_file = NULL;
+	struct sockaddr_un sun = { .sun_family = AF_UNIX };
+	socklen_t sunlen;
+	struct iovec iov;
+	struct msghdr msg;
+	struct cmsghdr *cmsg;
+	char cmsgbuf[CMSG_SPACE(sizeof(int))];
+	char databuf[1];
+
+	while ((opt = getopt(argc, argv, "f:")) != -1) {
+		switch (opt) {
+		case 'f':
+			flag_file = optarg;
+			break;
+		default:
+			usage(argv[0]);
+			break;
+		}
+	}
+
+	if ((argc - optind) != 1)
+		usage(argv[0]);
+
+	/* Part 0: Set up the socket */
+	sock = socket(AF_UNIX, SOCK_STREAM, 0);
+	if (sock < 0) {
+		perror("socket");
+		exit(1);
+	}
+
+	strcpy(sun.sun_path, argv[optind]);
+	sunlen = offsetof(struct sockaddr_un, sun_path) + strlen(sun.sun_path) + 1;
+
+	if (bind(sock, (struct sockaddr *)&sun, sunlen) < 0) {
+		perror("bind");
+		close(sock);
+		exit(1);
+	}
+
+	if (listen(sock, SOMAXCONN)) {
+		perror("listen");
+		close(sock);
+		exit(1);
+	}
+
+	if (flag_file) {
+		FILE *f = fopen(flag_file, "w");
+		if (!f) {
+			perror("Flag file open");
+			close(sock);
+			exit(1);
+		}
+		fprintf(f, "listening\n");
+		fclose(f);
+	}
+
+	/* Part 1: Receive a file from the sender */
+	newsock = accept(sock, NULL, NULL);
+	if (newsock < 0) {
+		perror("accept");
+		close(sock);
+		exit(1);
+	}
+
+	iov = (struct iovec) {
+		.iov_base = databuf,
+		.iov_len = 1
+	};
+	msg = (struct msghdr) {
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+		.msg_control = cmsgbuf,
+		.msg_controllen = sizeof(cmsgbuf),
+	};
+	if (recvmsg(newsock, &msg, MSG_CMSG_SEALED) < 0) {
+		perror("recvmsg");
+		close(newsock);
+		close(sock);
+		exit(1);
+	}
+
+	payload_fd = -1;
+	for (cmsg = CMSG_FIRSTHDR(&msg); cmsg; cmsg = CMSG_NXTHDR(&msg, cmsg)) {
+		if (cmsg->cmsg_level == SOL_SOCKET &&
+		    cmsg->cmsg_type == SCM_RIGHTS) {
+			if (cmsg->cmsg_len - CMSG_LEN(0) != sizeof(int))
+				continue;
+			payload_fd = *(int *)CMSG_DATA(cmsg);
+		}
+	}
+	close(newsock);
+	if (payload_fd < 0) {
+		fprintf(stderr, "error: no file received!\n");
+		close(sock);
+		exit(1);
+	}
+
+	/* Part 2: Verify that we CAN'T read/write the file */
+	if (write(payload_fd, databuf, sizeof(databuf)) >= 0) {
+		fprintf(stderr, "FAIL: write to payload file succeeded!\n");
+		close(payload_fd);
+		close(sock);
+		exit(1);
+	}
+
+	if (read(payload_fd, databuf, sizeof(databuf)) >= 0) {
+		fprintf(stderr, "FAIL: read from payload file succeeded!\n");
+		close(payload_fd);
+		close(sock);
+		exit(1);
+	}
+
+	/* Part 3: Send the file to the receiver */
+	newsock = accept(sock, NULL, NULL);
+	if (newsock < 0) {
+		perror("accept");
+		close(sock);
+		exit(1);
+	}
+
+	/* Just re-send the whole msg unchanged */
+	if (sendmsg(newsock, &msg, MSG_CMSG_SEALED) < 0) {
+		perror("sendmsg");
+		close(newsock);
+		close(sock);
+		exit(1);
+	}
+
+	/* Cleanup */
+	close(newsock);
+	close(sock);
+	return 0;
+}
diff --git a/tests/unix_socket/fd_receiver.c b/tests/unix_socket/fd_receiver.c
new file mode 100644
index 0000000..a060efd
--- /dev/null
+++ b/tests/unix_socket/fd_receiver.c
@@ -0,0 +1,98 @@
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <stddef.h>
+#include <string.h>
+#include <unistd.h>
+#include <stdio.h>
+
+void usage(char *progname)
+{
+	fprintf(stderr,
+		"usage:  %s socket-name\n",
+		progname);
+	exit(1);
+}
+
+int main(int argc, char **argv)
+{
+	int sock, payload_fd;
+	struct sockaddr_un sun = { .sun_family = AF_UNIX };
+	socklen_t sunlen;
+	struct iovec iov;
+	struct msghdr msg;
+	struct cmsghdr *cmsg;
+	char cmsgbuf[CMSG_SPACE(sizeof(int))];
+	char databuf[1];
+
+	if (argc != 2)
+		usage(argv[0]);
+
+	/* Part 0: Set up the socket */
+	sock = socket(AF_UNIX, SOCK_STREAM, 0);
+	if (sock < 0) {
+		perror("socket");
+		exit(1);
+	}
+
+	strcpy(sun.sun_path, argv[optind]);
+	sunlen = offsetof(struct sockaddr_un, sun_path) + strlen(sun.sun_path) + 1;
+
+	if (connect(sock, &sun, sunlen) < 0) {
+		perror("connect");
+		close(sock);
+		exit(1);
+	}
+
+	/* Part 1: Receive a file from the forwarder */
+	iov = (struct iovec) {
+		.iov_base = databuf,
+		.iov_len = 1
+	};
+	msg = (struct msghdr) {
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+		.msg_control = cmsgbuf,
+		.msg_controllen = sizeof(cmsgbuf),
+	};
+	if (recvmsg(sock, &msg, 0) < 0) {
+		perror("recvmsg");
+		close(sock);
+		exit(1);
+	}
+
+	payload_fd = -1;
+	for (cmsg = CMSG_FIRSTHDR(&msg); cmsg; cmsg = CMSG_NXTHDR(&msg, cmsg)) {
+		if (cmsg->cmsg_level == SOL_SOCKET &&
+		    cmsg->cmsg_type == SCM_RIGHTS) {
+			if (cmsg->cmsg_len - CMSG_LEN(0) != sizeof(int))
+				continue;
+			payload_fd = *(int *)CMSG_DATA(cmsg);
+		}
+	}
+	close(sock);
+
+	if (payload_fd < 0) {
+		fprintf(stderr, "error: no file received!\n");
+		exit(2);
+	}
+
+	/* Part 2: Verify that we can read/write the file */
+	if (write(payload_fd, databuf, sizeof(databuf)) < 0) {
+		perror("write");
+		close(payload_fd);
+		exit(1);
+	}
+
+	if (read(payload_fd, databuf, sizeof(databuf)) < 0) {
+		perror("read");
+		close(payload_fd);
+		exit(1);
+	}
+
+	/* Cleanup */
+	close(payload_fd);
+	return 0;
+}
diff --git a/tests/unix_socket/fd_sealed_check.c b/tests/unix_socket/fd_sealed_check.c
new file mode 100644
index 0000000..cf7b47b
--- /dev/null
+++ b/tests/unix_socket/fd_sealed_check.c
@@ -0,0 +1,26 @@
+#include <sys/socket.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdio.h>
+
+#ifndef SO_RIGHTS_SEALED_SUPPORTED
+#define SO_RIGHTS_SEALED_SUPPORTED 88
+#endif
+
+int main(int argc, char **argv)
+{
+    int sock, ret;
+    socklen_t optlen = 0;
+
+    sock = socket(AF_UNIX, SOCK_STREAM, 0);
+    if (sock < 0) {
+        perror("socket");
+        exit(2);
+    }
+
+    ret = getsockopt(sock, SOL_SOCKET, SO_RIGHTS_SEALED_SUPPORTED,
+                     NULL, &optlen);
+    close(sock);
+
+    return ret == 0 ? 0 : 1;
+}
diff --git a/tests/unix_socket/fd_sender.c b/tests/unix_socket/fd_sender.c
new file mode 100644
index 0000000..a159579
--- /dev/null
+++ b/tests/unix_socket/fd_sender.c
@@ -0,0 +1,88 @@
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <stddef.h>
+#include <string.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <stdio.h>
+
+void usage(char *progname)
+{
+	fprintf(stderr,
+		"usage:  %s socket-name file-to-send\n",
+		progname);
+	exit(1);
+}
+
+int main(int argc, char **argv)
+{
+	int sock, payload_fd;
+	struct sockaddr_un sun = { .sun_family = AF_UNIX };
+	socklen_t sunlen;
+	struct iovec iov;
+	struct msghdr msg;
+	struct cmsghdr *cmsg;
+	char cmsgbuf[CMSG_SPACE(sizeof(payload_fd))];
+	char databuf[1];
+
+	if (argc != 3)
+		usage(argv[0]);
+
+	/* Part 0: Open the file */
+	payload_fd = open(argv[2], O_RDWR);
+	if (payload_fd < 0) {
+		perror("open");
+		exit(1);
+	}
+
+	/* Part 1: Set up the socket */
+	sock = socket(AF_UNIX, SOCK_STREAM, 0);
+	if (sock < 0) {
+		perror("socket");
+		exit(1);
+	}
+
+	strcpy(sun.sun_path, argv[1]);
+	sunlen = offsetof(struct sockaddr_un, sun_path) + strlen(sun.sun_path) + 1;
+
+	if (connect(sock, &sun, sunlen) < 0) {
+		perror("connect");
+		close(sock);
+		exit(1);
+	}
+
+	/* Part 2: Send the file handle */
+	iov = (struct iovec) {
+		.iov_base = databuf,
+		.iov_len = 1
+	};
+	databuf[0] = 42;
+
+	msg = (struct msghdr) {
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+		.msg_control = cmsgbuf,
+		.msg_controllen = sizeof(cmsgbuf),
+	};
+	cmsg = CMSG_FIRSTHDR(&msg);
+	*cmsg = (struct cmsghdr) {
+		.cmsg_level = SOL_SOCKET,
+		.cmsg_type = SCM_RIGHTS,
+		.cmsg_len = CMSG_LEN(sizeof(payload_fd)),
+	};
+	memcpy(CMSG_DATA(cmsg), &payload_fd, sizeof(payload_fd));
+
+	if (sendmsg(sock, &msg, 0) < 0) {
+		perror("sendmsg");
+		close(sock);
+		exit(1);
+	}
+
+	/* Cleanup */
+	close(payload_fd);
+	close(sock);
+	return 0;
+}
diff --git a/tests/unix_socket/test b/tests/unix_socket/test
index bb06103..f0d729d 100755
--- a/tests/unix_socket/test
+++ b/tests/unix_socket/test
@@ -8,6 +8,7 @@ BEGIN {
 
     $test_count = 8;
     $socketpair = 0;
+    $sealed_fds = 0;
 
     $kvercur = `uname -r`;
     chomp($kvercur);
@@ -20,6 +21,13 @@ BEGIN {
         $socketpair = 1;
     }
 
+    # Test MSG_CMSG_SEALED (for forwarding fds over unix sockets)
+    $result = system("$basedir/fd_sealed_check");
+    if ( $result == 0 ) {
+        $test_count += 4;
+        $sealed_fds = 1;
+    }
+
     plan tests => $test_count;
 }
 
@@ -28,13 +36,13 @@ BEGIN {
 #
 
 sub server_start {
-    my ( $runcon_args, $args ) = @_;
+    my ( $exe, $runcon_args, $args ) = @_;
     my $pid;
 
     system("mkfifo $basedir/flag");
 
     if ( ( $pid = fork() ) == 0 ) {
-        exec "runcon $runcon_args $basedir/server -f $basedir/flag $args";
+        exec "runcon $runcon_args $basedir/$exe -f $basedir/flag $args";
     }
 
     # Wait for it to initialize.
@@ -55,7 +63,11 @@ sub server_end {
 }
 
 # Start the stream server.
-$pid = server_start( "-t test_unix_server_t", "-a stream test_server_sock" );
+$pid = server_start(
+    "server",
+    "-t test_unix_server_t",
+    "-a stream test_server_sock"
+);
 
 # Verify that stream client can connectto server.
 $result = system
@@ -71,7 +83,8 @@ ok($result);
 server_end($pid);
 
 # Start the dgram server.
-$pid = server_start( "-t test_unix_server_t", "-a dgram test_server_sock" );
+$pid = server_start( "server", "-t test_unix_server_t",
+    "-a dgram test_server_sock" );
 
 # Verify that dgram client can sendto server.
 $result = system
@@ -91,8 +104,11 @@ server_end($pid);
 #
 
 # Start the stream server.
-$pid =
-  server_start( "-t test_unix_server_t", "stream $basedir/test_server_sock" );
+$pid = server_start(
+    "server",
+    "-t test_unix_server_t",
+    "stream $basedir/test_server_sock"
+);
 
 # Verify that stream client can connectto server.
 $result = system
@@ -108,8 +124,11 @@ ok($result);
 server_end($pid);
 
 # Start the dgram server.
-$pid =
-  server_start( "-t test_unix_server_t", "dgram $basedir/test_server_sock" );
+$pid = server_start(
+    "server",
+    "-t test_unix_server_t",
+    "dgram $basedir/test_server_sock"
+);
 
 # Verify that dgram client can sendto server.
 $result = system
@@ -136,4 +155,52 @@ if ($socketpair) {
     ok( $result, 0 );
 }
 
+if ($sealed_fds) {
+    #### Test file handle forwarding without needing access to the forwarded file.
+
+    # Create and label the payload file.
+    system "touch $basedir/payload_file";
+    system "chcon -t test_unix_payload_t $basedir/payload_file";
+
+    # Start the forwarder.
+    $pid = server_start( "fd_forwarder", "-t test_unix_fd_forwarder_t",
+        "$basedir/test_server_sock" );
+
+    # Run the sender.
+    $result = system
+"runcon -t test_unix_fd_sender_t $basedir/fd_sender $basedir/test_server_sock $basedir/payload_file";
+    ok( $result, 0 );
+
+    # Run the receiver.
+    $result = system
+"runcon -t test_unix_fd_receiver_t $basedir/fd_receiver $basedir/test_server_sock";
+    ok( $result, 0 );
+
+    # Kill the forwarder.
+    server_end($pid);
+
+    # Clean up.
+    system "rm -f $basedir/test_server_sock";
+
+    # Start the forwarder again.
+    $pid = server_start( "fd_forwarder", "-t test_unix_fd_forwarder_t",
+        "$basedir/test_server_sock" );
+
+    # Run the sender again.
+    $result = system
+"runcon -t test_unix_fd_sender_t $basedir/fd_sender $basedir/test_server_sock $basedir/payload_file";
+    ok( $result, 0 );
+
+    # Run the _bad_ receiver - should fail when receiving the fd.
+    $result = system
+"runcon -t test_unix_fd_bad_receiver_t $basedir/fd_receiver $basedir/test_server_sock 2>/dev/null";
+    ok( $result >> 8, 2 );
+
+    # Kill the forwarder.
+    server_end($pid);
+
+    # Clean up.
+    system "rm -f $basedir/test_server_sock";
+}
+
 exit;
-- 
2.54.0

