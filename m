Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793624758;
	b=kuXCIU4YyBqy1WVGdiTDQT3oBJSKHVgd6PnHfm6xmxHBXIHx5Ihr2Vuyui8KoL7OUJvJ
	 kowLk2yUOSmloHWnn9WHgr6UetxC6iNuJnxvzVQ8F+Y0Jb+91ygUIsA7MRggkp4y2/2HK
	 CEl1rPkzZn54MdxuC3cONMVlwQpe1MT404+Jp/crncWPWrwg8KtEyrfZ5V7voWCOprGQ/
	 LtZ2izIIpETo7UAKgWGsHDal3vcKTwkUGjO92rHNo5TedGheBHHr49+X+cOeY1p/hQQUu
	 3E0zFug52CgG2jbPBUMKNrTsxDtR/kQkdNqOD2iy49Mbch8bi4XDTAO4VRDT13d7OPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793624758;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=WDU537OIp/WiCEkq9wRU/qY596rnBA2iyvYvS55MwSA=;
	b=2FP7WW42s3lLT3iExKq10sNTXOtCzdFjlK/szptS3Tb0uX86LjkIiydTxxN07zoY0OaA
	 R8P0A/XYqF/9wJRInPOKnyp3dsTb+7KGDQHkLOtzDPwZxONDF5aPXSZvb5RjawFzJt92w
	 aQh4qEG4dalEzszDtSL8Y2Cehi29CoCY7ZTB8NgMUEeGeUWDuqU3GCLrt2dN+hB+MJtNt
	 9Khor+tXXeeLK0sgqGGYWju3vOpWI6EvJbgKSqCTLZjARA81/DPb8UENZFj5Ai16k/M8w
	 29HPRXrkSJE59N4Eo5b77QoOuIRxjniDm4Pc/E/xkEP13gYQiZ1rKFKO6mkVoZa35og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XCwHDDpV;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9054E606A324
	for <selinux@vger.kernel.org>; Mon,  2 Nov 2026 13:05:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9054E606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XCwHDDpV
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48c4d99c32bso2060647f8f.1
        for <selinux@vger.kernel.org>; Mon, 02 Nov 2026 05:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793624756; x=1794229556; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WDU537OIp/WiCEkq9wRU/qY596rnBA2iyvYvS55MwSA=;
        b=XCwHDDpVCsA2GL0D6qB5AJIZho+hltAoHijb+N+7+dqgvgwM/y6kgyI3Pp1Ihvl6lS
         +ONF1U05Fq5XzAE5KYtK1RRAIxhsxoHNECqlmYJc7sgIQABmIDfAQc7am/k2JVoiGLaC
         lpn+k2qlNff2GzGTykjg3WUI0b6dTniXLHFcOE0071jsNYUTGYHbtS6sviQfD38dDVf6
         EXqHRodgD4GhBUUFjbFztruLFOiOFbx7en5wjIaonDolb9EUr+3KChEieiDhL2DpgAe3
         OXKilf/lio6eJaNGZLZ/9RJwogNgl1MgYqdZAnpCr637kDZQDcwMy6S76tOJcMpo7hBx
         tjCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793624756; x=1794229556;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WDU537OIp/WiCEkq9wRU/qY596rnBA2iyvYvS55MwSA=;
        b=vwyjrGODmaNYhWDvdm1Px2ImdPNzF67OCOwA8TotxrBW1Y3ROvqXuvl+NJ7uudtDYN
         SI8ROulWsixa/BL+wErYGRGg9VTcjqpMzY6m3cVz6KrLPT5haQGJRIRbaLMMHhBboZUD
         mv6Y1bPPO5I0713bm+ylEpBKEo9aTlheXGIUXtR8GunvmtGAaHAJPCTzkz8cevXv2y2l
         R/bf7URgaWUxScx8rOUxIMPBhIcJc+Zx99SlricWE8NfiO7o7Esz3uQfJoe+4tUrP3IT
         1dc49y0WNFzN6jf+fmbcm3HbeRzc4kR0DZWLJzVBJ90OQpYQ6jbq6UNg3+KUAnmKc+Y2
         yRHw==
X-Gm-Message-State: AFq9FYLuJfe8NZ4bRUOI3f1bLSU93JJHgOuEWkD1n9ln6a4GtrH7qism
	4xKMwmnkt2mqqkWBDZ/4+a1qXt3NUVTC/RU0es7dB1agHKLzKLibM9BBIec2f/pp
X-Gm-Gg: AYBFou1koau8Dbsw7rtxXcZPMGBCwP8ODv4offEB1C21YC0iuMqwqQuRTCIvRI4ecwq
	6pg7/V+1G90QkMB3Do0pGyhYH0R1QU0/faygQ/pfBokfSUqXAC/LUA4BH4LNNEszOUAKfnwzNvM
	zASAAB3WO8xO7iTMjQubgnjgIKKwqB4CTtQ21gs/YC2KmgeG9ncHwTcc+gWn7QmLf0uJAne5biJ
	WzOWMU/vHWC20rJibsmsw49/x7Jw78jYoheLur8X9FJzmUCxOf5kXZdM5yj2GEQsmsOi0WzRXlL
	bYhEJbBWD9pIVMMIb6b8C7SdjeCqQUMTcDoUpB1Drszs3TZY/ViDtAzHhHqH39ikzbqx+hGbEna
	7ZfA858QoeVWNuWmE3BJTs9UlFwORKCUWRfnKFokWazHuXRC4/WRzOhs+8FcanHBR0+ZBnqypjo
	manayJ3MSIMrJ2e9og4mkIWwpcQbEkovg3+EJbbPL1VGyVHxot8kS9HDeGUhVb03UMkCyVnz2ti
	iKOgNVJdPqMeZ9HTcL9L9+0MrnUb74PzrIqs4sC5SmOQbTOmwdn21F8zaZYvUXSKnkPGrRY08fA
	H69U3LqsTIwLQvFLwNqZGm5640Dbv9qxd9Fuuw38KYZGQCQFukKVjEROtpLrcUNVzbQKzoO2zhw
	0d++FIanJ
X-Received: by 2002:a05:600c:19d2:b0:4a6:4d6b:a840 with SMTP id 5b1f17b1804b1-4ac1932a12fmr223775125e9.31.1793624754232;
        Mon, 02 Nov 2026 05:05:54 -0800 (PST)
Received: from omos-acer.lan (109-81-86-162.rct.o2.cz. [109.81.86.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ac09bcc967sm204846215e9.3.2026.11.02.05.05.52
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 05:05:52 -0800 (PST)
From: =?UTF-8?q?Ondrej=20Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>
To: selinux@vger.kernel.org
Subject: [RFC PATCH testsuite 2/2] tests/unix_socket: add test for MSG_CMSG_SEALED
Date: Mon,  2 Nov 2026 14:05:49 +0100
Message-ID: <20261102130549.252935-2-omosnacek@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261102130549.252935-1-omosnacek@gmail.com>
References: <20261102130549.252935-1-omosnacek@gmail.com>
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

