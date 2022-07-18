Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A493C433EF
	for <selinux@archiver.kernel.org>; Mon, 18 Jul 2022 22:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiGRW3u (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 18 Jul 2022 18:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbiGRW3u (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 18 Jul 2022 18:29:50 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92138F0A
        for <selinux@vger.kernel.org>; Mon, 18 Jul 2022 15:29:46 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id r24so3255849qtx.6
        for <selinux@vger.kernel.org>; Mon, 18 Jul 2022 15:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=8cSQ965Jvz9Yw40e2OT5AVZAObh7xbEIvfBW/bswQLo=;
        b=I2+ij5hWt9Juq/D6xlHaV7n4S/ZObyabLyUlLGbuLr4E1Y6w9j7mQd4rTX1v7JqTgN
         KMOqflkH8Hl0U916LQvtUBRdVE7mR6UplcWUUda72AnYm5q0mmxzqbyz1gkXqpj1t+MS
         aHFj8OGcndRrpglnShN95h22TRaoTdkgScl5wM+6i8UR2moLbbsPtZr1sNQAW5OjCEoD
         n4qjFM5AyzikI1V3ChQRmiR+weW0Uvc888Utx74KzQ1nij0PdMxfQIkMxzHkdAq1ZSTR
         B5/bqZyDSTgauf5EAs2I1v8Otp27FFjTISp077ulUStOV1ZjmBa/wVCAexXN3/yMp5jP
         B8Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=8cSQ965Jvz9Yw40e2OT5AVZAObh7xbEIvfBW/bswQLo=;
        b=XvMHxdsOwjL1h/RKr/gO3uVkpYKCc4aBpCvaeyoTb9R4GouHa+d7nAzkHDbY8p3iFF
         M1GxgRaXgVVwwYxgCs/5UN7Dh0eW+62iIl6uHzT2TeVGxord82Fi38shnEKAFKsOnRaW
         guKdi/ErIuVW5OQbxr2E9YpOUvqlZT1PVKtL0pswhACPC0V0fCVVnYyVveyMvzdyBUD4
         s2tCRskIzWMt88c8//RzmXxh1NyiLUUYki3ttoS3rPkCsIM3mQB0sz1uE36nH55/GRk1
         wmw6/XatEYg68m7HgVZG+tm47l7R6mTm26HCpLCGNJR3krmcpv4x1LZfMHJqcH8CVS4b
         HsdA==
X-Gm-Message-State: AJIora+j5doS9Sy/4KlLLihI2L8NqVbcygSvEvW4felG7KhrGLryoGip
        TN5Ys1m2aERGtnlx0gOxmwRJ2pdWsl3w
X-Google-Smtp-Source: AGRyM1tBuTSwC2UUHTF23zL3fHKxWfSR5fVwFphp+XeS6W8t5+n5uFSO82R/EZzl8cg15Tz23NiIAA==
X-Received: by 2002:ac8:59c5:0:b0:31d:4bfe:fd5a with SMTP id f5-20020ac859c5000000b0031d4bfefd5amr22631779qtf.59.1658183384272;
        Mon, 18 Jul 2022 15:29:44 -0700 (PDT)
Received: from localhost (pool-96-237-52-46.bstnma.fios.verizon.net. [96.237.52.46])
        by smtp.gmail.com with ESMTPSA id q9-20020ac84509000000b0031eb3af3ffesm9884765qtn.52.2022.07.18.15.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 15:29:43 -0700 (PDT)
Subject: [PATCH] tests/sctp: remove assumptions in the SCTP tests
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Date:   Mon, 18 Jul 2022 18:29:43 -0400
Message-ID: <165818338297.423746.2325119921845739520.stgit@olly>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Rework the SCTP tests slightly to remove two assumptions which are
not always guaranteed to be true (below).  This should have not any
affect on the current test suite or released kernels, but it will
help ensure that the test suite continues to work with upcoming
kernel releases.

 * Do not rely on IP options attached to a socket.  Depending on the
   kernel configuration, the on-the-wire packet labels may be
   generated on a per-packet basis as opposed to a per-socket basis.

 * Ensure the kernel's SCTP association state is properly reset by
   restarting the SCTP test server between tests which require it.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 tests/sctp/sctp_client.c         |   22 +-
 tests/sctp/sctp_common.c         |   42 +++++
 tests/sctp/sctp_common.h         |    2 
 tests/sctp/sctp_peeloff_client.c |   21 +-
 tests/sctp/sctp_peeloff_server.c |   20 +-
 tests/sctp/sctp_server.c         |   28 +--
 tests/sctp/test                  |  352 ++++++++++++++++++++++++++++----------
 7 files changed, 332 insertions(+), 155 deletions(-)

diff --git a/tests/sctp/sctp_client.c b/tests/sctp/sctp_client.c
index 2f527ed..2b2f4b6 100644
--- a/tests/sctp/sctp_client.c
+++ b/tests/sctp/sctp_client.c
@@ -22,22 +22,20 @@ static void usage(char *progname)
 int main(int argc, char **argv)
 {
 	int opt, sock, result, save_errno;
-	socklen_t opt_len;
 	struct addrinfo hints, *serverinfo;
 	char byte = 0x41, label[1024], *expected = NULL;
 	bool verbose = false, connectx = false, no_connects = false;
-	bool ipv4 = false, expect_ipopt = false;
+	bool ipv4 = false;
+	bool expected_flg = false;
 	char *context;
 	struct timeval tm;
 
-	while ((opt = getopt(argc, argv, "e:vxmni")) != -1) {
+	while ((opt = getopt(argc, argv, "e:vxmn")) != -1) {
 		switch (opt) {
 		case 'e':
+			expected_flg = true;
 			expected = optarg;
 			break;
-		case 'i':
-			expect_ipopt = true;
-			break;
 		case 'v':
 			verbose = true;
 			break;
@@ -165,8 +163,6 @@ int main(int argc, char **argv)
 			print_context(sock, "Client STREAM read");
 			print_ip_option(sock, ipv4, "Client STREAM read");
 		}
-		if (expect_ipopt)
-			expected = get_ip_option(sock, ipv4, &opt_len);
 
 	} else { /* hints.ai_socktype == SOCK_SEQPACKET */
 
@@ -193,14 +189,12 @@ int main(int argc, char **argv)
 			close(sock);
 			exit(13);
 		}
-		if (expect_ipopt)
-			expected = get_ip_option(sock, ipv4, &opt_len);
 	}
 
 	label[result] = 0;
 	close(sock);
 
-	if (!expected && !expect_ipopt) {
+	if (!expected) {
 		result = getcon(&expected);
 		if (result < 0) {
 			perror("Client getcon");
@@ -208,7 +202,11 @@ int main(int argc, char **argv)
 		}
 	}
 
-	if (strcmp(expected, label)) {
+	if (!expected_flg && cmp_context_mls(expected, label)) {
+		fprintf(stderr, "Client expected %s, got %s\n",
+			expected, label);
+		exit(15);
+	} else if (expected_flg && cmp_context_type_mls(expected, label)) {
 		fprintf(stderr, "Client expected %s, got %s\n",
 			expected, label);
 		exit(15);
diff --git a/tests/sctp/sctp_common.c b/tests/sctp/sctp_common.c
index 8b65870..02bbf5d 100644
--- a/tests/sctp/sctp_common.c
+++ b/tests/sctp/sctp_common.c
@@ -3,6 +3,48 @@
 #define member_size(type, member) sizeof(((type *)0)->member)
 #define sizeof_up_to(type, member) (offsetof(type, member) + member_size(type, member))
 
+static int __cmp_context(int skip_fields, const char *a, const char *b)
+{
+	int i;
+	const char *aptr = a;
+	const char *bptr = b;
+
+	/* we only support skipping at most the user:role:type */
+	if (skip_fields > 3)
+		goto malformed;
+
+	/* skip past the specified number of fields */
+	for (i=0; i < skip_fields; i++) {
+		aptr = strchr(aptr, ':');
+		if (!aptr)
+			goto malformed;
+		if (*(++aptr) == '\0')
+			goto malformed;
+		bptr = strchr(bptr, ':');
+		if (!bptr)
+			goto malformed;
+		if (*(++bptr) == '\0')
+			goto malformed;
+	}
+
+	return strcmp(aptr, bptr);
+
+malformed:
+	return strcmp(a, b);
+}
+
+int cmp_context_mls(const char *a, const char *b)
+{
+	/* skip user:role:type */
+	return __cmp_context(3, a, b);
+}
+
+int cmp_context_type_mls(const char *a, const char *b)
+{
+	/* skip user:role */
+	return __cmp_context(2, a, b);
+}
+
 void print_context(int fd, char *text)
 {
 	char *context;
diff --git a/tests/sctp/sctp_common.h b/tests/sctp/sctp_common.h
index cb69f70..3a2545a 100644
--- a/tests/sctp/sctp_common.h
+++ b/tests/sctp/sctp_common.h
@@ -27,6 +27,8 @@ enum event_ret {
 	EVENT_NO_AUTH
 };
 
+int cmp_context_mls(const char *a, const char *b);
+int cmp_context_type_mls(const char *a, const char *b);
 void print_context(int fd, char *text);
 void print_addr_info(struct sockaddr *sin, char *text);
 char *get_ip_option(int fd, bool ipv4, socklen_t *opt_len);
diff --git a/tests/sctp/sctp_peeloff_client.c b/tests/sctp/sctp_peeloff_client.c
index bc719a5..8597b81 100644
--- a/tests/sctp/sctp_peeloff_client.c
+++ b/tests/sctp/sctp_peeloff_client.c
@@ -22,23 +22,22 @@ int main(int argc, char **argv)
 	int opt, sock, result, save_errno, peeloff_sk = 0, flags;
 	int on = 1, off = 0;
 	sctp_assoc_t assoc_id = 0;
-	socklen_t sinlen, opt_len;
+	socklen_t sinlen;
 	struct sockaddr_storage sin;
 	struct addrinfo hints, *serverinfo;
 	char byte = 0x41, label[1024], *expected = NULL;
 	bool verbose = false, connectx = false, no_connects = false;
-	bool ipv4 = false, expect_ipopt = false;
+	bool ipv4 = false;
+	bool expected_flg = false;
 	char *context;
 	struct timeval tm;
 
-	while ((opt = getopt(argc, argv, "e:vxmni")) != -1) {
+	while ((opt = getopt(argc, argv, "e:vxmn")) != -1) {
 		switch (opt) {
 		case 'e':
+			expected_flg = true;
 			expected = optarg;
 			break;
-		case 'i':
-			expect_ipopt = true;
-			break;
 		case 'v':
 			verbose = true;
 			break;
@@ -227,14 +226,12 @@ int main(int argc, char **argv)
 		close(sock);
 		exit(13);
 	}
-	if (expect_ipopt)
-		expected = get_ip_option(peeloff_sk, ipv4, &opt_len);
 
 	label[result] = 0;
 	close(peeloff_sk);
 	close(sock);
 
-	if (!expected && !expect_ipopt) {
+	if (!expected) {
 		result = getcon(&expected);
 		if (result < 0) {
 			perror("Client getcon");
@@ -242,7 +239,11 @@ int main(int argc, char **argv)
 		}
 	}
 
-	if (strcmp(expected, label)) {
+	if (!expected_flg && cmp_context_mls(expected, label)) {
+		fprintf(stderr, "Client expected %s, got %s\n",
+			expected, label);
+		exit(15);
+	} else if (expected_flg && cmp_context_type_mls(expected, label)) {
 		fprintf(stderr, "Client expected %s, got %s\n",
 			expected, label);
 		exit(15);
diff --git a/tests/sctp/sctp_peeloff_server.c b/tests/sctp/sctp_peeloff_server.c
index bd797f2..3e48df7 100644
--- a/tests/sctp/sctp_peeloff_server.c
+++ b/tests/sctp/sctp_peeloff_server.c
@@ -3,11 +3,10 @@
 static void usage(char *progname)
 {
 	fprintf(stderr,
-		"usage:  %s [-4] [-f file] [-i] [-n] [-v] port\n"
+		"usage:  %s [-4] [-f file] [-n] [-v] port\n"
 		"\nWhere:\n\t"
 		"-4      Listen on IPv4 addresses only.\n\t"
 		"-f      Write a line to the file when listening starts.\n\t"
-		"-i      Send IP Options as msg (default is peer label).\n\t"
 		"-n      No peer context will be available therefore send\n\t"
 		"        \"nopeer\" message to client, otherwise the peer context\n\t"
 		"        will be retrieved and sent to client.\n\t"
@@ -20,14 +19,14 @@ int main(int argc, char **argv)
 {
 	int opt, sock, result, peeloff_sk = 0, flags, on = 1, off = 0;
 	sctp_assoc_t assoc_id = 0;
-	socklen_t sinlen, opt_len;
+	socklen_t sinlen;
 	struct sockaddr_storage sin;
 	struct addrinfo hints, *res;
 	char *peerlabel, *context, *flag_file = NULL, msglabel[256];
-	bool nopeer = false,  verbose = false, ipv4 = false, snd_opt = false;
+	bool nopeer = false,  verbose = false, ipv4 = false;
 	unsigned short port;
 
-	while ((opt = getopt(argc, argv, "4f:inv")) != -1) {
+	while ((opt = getopt(argc, argv, "4f:nv")) != -1) {
 		switch (opt) {
 		case '4':
 			ipv4 = true;
@@ -35,9 +34,6 @@ int main(int argc, char **argv)
 		case 'f':
 			flag_file = optarg;
 			break;
-		case 'i':
-			snd_opt = true;
-			break;
 		case 'n':
 			nopeer = true;
 			break;
@@ -201,11 +197,6 @@ int main(int argc, char **argv)
 
 		if (nopeer) {
 			peerlabel = strdup("nopeer");
-		} else if (snd_opt) {
-			peerlabel = get_ip_option(sock, ipv4, &opt_len);
-
-			if (!peerlabel)
-				peerlabel = strdup("no_ip_options");
 		} else {
 			result = getpeercon(peeloff_sk, &peerlabel);
 			if (result < 0) {
@@ -216,8 +207,7 @@ int main(int argc, char **argv)
 			}
 		}
 
-		printf("Server PEELOFF %s: %s\n",
-		       snd_opt ? "sock_opt" : "peer label", peerlabel);
+		printf("Server PEELOFF peer label: %s\n", peerlabel);
 
 		result = sctp_sendmsg(peeloff_sk, peerlabel,
 				      strlen(peerlabel),
diff --git a/tests/sctp/sctp_server.c b/tests/sctp/sctp_server.c
index c53f46f..a7832eb 100644
--- a/tests/sctp/sctp_server.c
+++ b/tests/sctp/sctp_server.c
@@ -3,7 +3,7 @@
 static void usage(char *progname)
 {
 	fprintf(stderr,
-		"usage:  %s [-4] [-b ipv4_addr] [-f file] [-h addr] [-i] [-n] [-v] stream|seq port\n"
+		"usage:  %s [-4] [-b ipv4_addr] [-f file] [-h addr] [-n] [-v] stream|seq port\n"
 		"\nWhere:\n\t"
 		"-4      Listen on IPv4 addresses only (used for CIPSO tests).\n\t"
 		"-b      Call sctp_bindx(3) with the supplied IPv4 address.\n\t"
@@ -11,7 +11,6 @@ static void usage(char *progname)
 		"-h      IPv4 or IPv6 listen address. If IPv6 link-local address,\n\t"
 		"        then requires the %%<if_name> to obtain scopeid. e.g.\n\t"
 		"            fe80::7629:afff:fe0f:8e5d%%wlp6s0\n\t"
-		"-i      Send IP Options as msg (default is peer label).\n\t"
 		"-n      No peer label or IP option will be available therefore\n\t"
 		"        send \"nopeer\" message to client.\n\t"
 		"-v      Print context and ip options information.\n\t"
@@ -24,19 +23,19 @@ static void usage(char *progname)
 int main(int argc, char **argv)
 {
 	int opt, sock, newsock, result, if_index = 0, on = 1, off = 0;
-	socklen_t sinlen, opt_len;
+	socklen_t sinlen;
 	struct sockaddr_storage sin;
 	struct addrinfo hints, *res;
 	struct sctp_sndrcvinfo sinfo;
 	struct pollfd poll_fd;
 	char getsockopt_peerlabel[1024];
 	char byte, *peerlabel, msglabel[1024], if_name[30];
-	bool nopeer = false,  verbose = false,  ipv4 = false, snd_opt = false;
+	bool nopeer = false,  verbose = false,  ipv4 = false;
 	char *context, *host_addr = NULL, *bindx_addr = NULL, *flag_file = NULL;
 	struct sockaddr_in ipv4_addr;
 	unsigned short port;
 
-	while ((opt = getopt(argc, argv, "4b:f:h:inv")) != -1) {
+	while ((opt = getopt(argc, argv, "4b:f:h:nv")) != -1) {
 		switch (opt) {
 		case '4':
 			ipv4 = true;
@@ -50,9 +49,6 @@ int main(int argc, char **argv)
 		case 'h':
 			host_addr = optarg;
 			break;
-		case 'i':
-			snd_opt = true;
-			break;
 		case 'n':
 			nopeer = true;
 			break;
@@ -212,11 +208,6 @@ int main(int argc, char **argv)
 
 			if (nopeer) {
 				peerlabel = strdup("nopeer");
-			} else if (snd_opt) {
-				peerlabel = get_ip_option(newsock, ipv4,
-							  &opt_len);
-				if (!peerlabel)
-					peerlabel = strdup("no_ip_options");
 			} else {
 				result = getpeercon(newsock, &peerlabel);
 				if (result < 0) {
@@ -241,8 +232,7 @@ int main(int argc, char **argv)
 					printf("Server STREAM SO_PEERSEC peer label: %s\n",
 					       getsockopt_peerlabel);
 			}
-			printf("Server STREAM %s: %s\n",
-			       snd_opt ? "sock_opt" : "peer label", peerlabel);
+			printf("Server STREAM peer label: %s\n", peerlabel);
 
 			result = read(newsock, &byte, 1);
 			if (result < 0) {
@@ -307,11 +297,6 @@ int main(int argc, char **argv)
 
 			if (nopeer) {
 				peerlabel = strdup("nopeer");
-			} else if (snd_opt) {
-				peerlabel = get_ip_option(sock, ipv4, &opt_len);
-
-				if (!peerlabel)
-					peerlabel = strdup("no_ip_options");
 			} else {
 				result = getpeercon(sock, &peerlabel);
 				if (result < 0) {
@@ -320,8 +305,7 @@ int main(int argc, char **argv)
 					exit(1);
 				}
 			}
-			printf("Server SEQPACKET %s: %s\n",
-			       snd_opt ? "sock_opt" : "peer label", peerlabel);
+			printf("Server SEQPACKET peer label: %s\n", peerlabel);
 
 			if (sin.ss_family == AF_INET6 && host_addr)
 				((struct sockaddr_in6 *)&sin)->sin6_scope_id = if_index;
diff --git a/tests/sctp/test b/tests/sctp/test
index a0db527..51c812f 100755
--- a/tests/sctp/test
+++ b/tests/sctp/test
@@ -409,34 +409,34 @@ system "/bin/sh $basedir/fb-deny-label-flush";
 #
 ############################## CIPSO/IPv4 TAG 1 ###############################
 #
-print "# Testing CIPSO/IPv4 - TAG 1 using socket ip_option data\n";
+print "# Testing CIPSO/IPv4 - TAG 1\n";
 system "/bin/sh $basedir/cipso-load-t1";
 
 # Start the stream server for IPv4 only.
 $pid = server_start(
     "-t test_sctp_server_t -l s0:c182.c192",
     "sctp_server",
-    "$v -4 -i stream 1035"
+    "$v -4 stream 1035"
 );
 
 # Verify that authorized client can communicate with the server STREAM->STREAM with client using sctp_connectx(3).
 $result = system
-"runcon -t test_sctp_client_t -l s0:c182.c192 $basedir/sctp_client $v -x -i stream 127.0.0.1 1035";
+"runcon -t test_sctp_client_t -l s0:c182.c192 $basedir/sctp_client $v -x stream 127.0.0.1 1035";
 ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server STREAM->STREAM with client using connect(2).
 $result = system
-"runcon -t test_sctp_client_t -l s0:c182.c192 $basedir/sctp_client $v -i stream 127.0.0.1 1035";
+"runcon -t test_sctp_client_t -l s0:c182.c192 $basedir/sctp_client $v stream 127.0.0.1 1035";
 ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server using different valid level STREAM->STREAM.
 $result = system
-"runcon -t test_sctp_client_t -l s0:c182,c187,c190 $basedir/sctp_client $v -i stream 127.0.0.1 1035";
+"runcon -t test_sctp_client_t -l s0:c182,c187,c190 $basedir/sctp_client $v stream 127.0.0.1 1035";
 ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server using different valid level SEQ->STREAM
 $result = system
-"runcon -t test_sctp_client_t -l s0:c189,c192 $basedir/sctp_client $v -i seq 127.0.0.1 1035";
+"runcon -t test_sctp_client_t -l s0:c189,c192 $basedir/sctp_client $v seq 127.0.0.1 1035";
 ok( $result eq 0 );
 
 # Verify that authorized client cannot communicate with the server using invalid level STREAM->STREAM.
@@ -449,17 +449,17 @@ if ($test_clpeeloff) {
 
 # Verify that authorized client can communicate with the server peeloff->SEQ->STREAM with client using connect(2).
     $result = system
-"runcon -t test_sctp_client_t -l s0:c182.c192 $basedir/sctp_peeloff_client $v -i 127.0.0.1 1035";
+"runcon -t test_sctp_client_t -l s0:c182.c192 $basedir/sctp_peeloff_client $v 127.0.0.1 1035";
     ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server peeloff->SEQ->STREAM with client using sctp_connectx(3).
     $result = system
-"runcon -t test_sctp_client_t -l s0:c182.c192 $basedir/sctp_peeloff_client $v -x -i 127.0.0.1 1035";
+"runcon -t test_sctp_client_t -l s0:c182.c192 $basedir/sctp_peeloff_client $v -x 127.0.0.1 1035";
     ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server peeloff->SEQ->STREAM with no client connect(2).
     $result = system
-"runcon -t test_sctp_client_t -l s0:c182.c192 $basedir/sctp_peeloff_client $v -n -i 127.0.0.1 1035";
+"runcon -t test_sctp_client_t -l s0:c182.c192 $basedir/sctp_peeloff_client $v -n 127.0.0.1 1035";
     ok( $result eq 0 );
 }
 
@@ -470,77 +470,117 @@ server_end($pid);
 $pid = server_start(
     "-t test_sctp_server_t -l s0:c20.c300",
     "sctp_server",
-    "$v -4 -i seq 1035"
+    "$v -4 seq 1035"
 );
 
 # Verify that authorized client can communicate with the server. SEQ->SEQ
 $result = system
-"runcon -t test_sctp_client_t -l s0:c27.c28 $basedir/sctp_client $v -i seq 127.0.0.1 1035";
+"runcon -t test_sctp_client_t -l s0:c27,c28 $basedir/sctp_client $v seq 127.0.0.1 1035";
 ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server using STREAM->SEQ.
 $result = system
-"runcon -t test_sctp_client_t -l s0:c20.c30 $basedir/sctp_client $v -i stream 127.0.0.1 1035";
+"runcon -t test_sctp_client_t -l s0:c27,c28 $basedir/sctp_client $v stream 127.0.0.1 1035";
 ok( $result eq 0 );
 
+# Restart the seq server to reset the SCTP state and labels
+server_end($pid);
+$pid = server_start(
+    "-t test_sctp_server_t -l s0:c20.c300",
+    "sctp_server",
+    "$v -4 seq 1035"
+);
+
 # Verify that authorized client can communicate with the server using SEQ->SEQ with diff valid level.
 $result = system
-"runcon -t test_sctp_client_t -l s0:c20.c24,c26,c27.c29 $basedir/sctp_client $v -i seq 127.0.0.1 1035";
+"runcon -t test_sctp_client_t -l s0:c20.c24,c26.c29 $basedir/sctp_client $v seq 127.0.0.1 1035";
 ok( $result eq 0 );
 
+# Restart the seq server to reset the SCTP state and labels
+server_end($pid);
+$pid = server_start(
+    "-t test_sctp_server_t -l s0:c20.c300",
+    "sctp_server",
+    "$v -4 seq 1035"
+);
+
 # Verify that client cannot communicate with the server using SEQ->SEQ with invalid level.
 $result = system
-"runcon -t test_sctp_client_t -l s0:c19.c100 -- $basedir/sctp_client $v -i seq 127.0.0.1 1035 2>&1";
+"runcon -t test_sctp_client_t -l s0:c19.c100 -- $basedir/sctp_client $v seq 127.0.0.1 1035 2>&1";
 ok( $result >> 8 eq 6 );
 
-# TAG 1 allows categories 0 to 239 to be sent, if greater then ENOSPC (No space left on device)
+# Restart the seq server to reset the SCTP state and labels
+server_end($pid);
+$pid = server_start(
+    "-t test_sctp_server_t -l s0:c20.c300",
+    "sctp_server",
+    "$v -4 seq 1035"
+);
+
+# TAG 1 allows categories 0 to 239 to be sent
 $result = system
-"runcon -t test_sctp_client_t -l s0:c20.c300 -- $basedir/sctp_client $v -i seq 127.0.0.1 1035 2>&1";
+"runcon -t test_sctp_client_t -l s0:c20.c300 -- $basedir/sctp_client $v seq 127.0.0.1 1035 2>&1";
 ok( $result >> 8 eq 7 );
 
 if ($test_clpeeloff) {
 
+# Restart the seq server to reset the SCTP state and labels
+    server_end($pid);
+    $pid = server_start(
+        "-t test_sctp_server_t -l s0:c20.c300",
+        "sctp_server",
+        "$v -4 seq 1035"
+    );
+
 # Verify that authorized client can communicate with the server peeloff->SEQ->SEQ with client using connect(2).
     $result = system
-"runcon -t test_sctp_client_t -l s0:c20.c30 $basedir/sctp_peeloff_client $v -i 127.0.0.1 1035";
+"runcon -t test_sctp_client_t -l s0:c20.c30 $basedir/sctp_peeloff_client $v 127.0.0.1 1035";
     ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server peeloff->SEQ->SEQ with client using sctp_connectx(3).
     $result = system
-"runcon -t test_sctp_client_t -l s0:c20.c30 $basedir/sctp_peeloff_client $v -x -i 127.0.0.1 1035";
+"runcon -t test_sctp_client_t -l s0:c20.c30 $basedir/sctp_peeloff_client $v -x 127.0.0.1 1035";
     ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server peeloff->SEQ->SEQ with no client connect(2).
     $result = system
-"runcon -t test_sctp_client_t -l s0:c20.c30 $basedir/sctp_peeloff_client $v -n -i 127.0.0.1 1035";
+"runcon -t test_sctp_client_t -l s0:c20.c30 $basedir/sctp_peeloff_client $v -n 127.0.0.1 1035";
     ok( $result eq 0 );
 }
 
 # Kill server.
 server_end($pid);
 
-print "# Testing CIPSO/IPv4 - TAG 1 PEELOFF using socket ip_option data\n";
+print "# Testing CIPSO/IPv4 - TAG 1 PEELOFF\n";
 
 # Test sctp_peeloff(3) server using 1 to Many SOCK_SEQPACKET
 $pid = server_start(
     "-t test_sctp_server_t -l s0:c0.c10",
     "sctp_peeloff_server",
-    "$v -4 -i 1035"
+    "$v -4 1035"
 );
 
 # Verify that authorized client can communicate with the server using SEQ->SEQ->Peeloff with same level.
 $result = system
-"runcon -t test_sctp_client_t -l s0:c0.c10 $basedir/sctp_client $v -i seq 127.0.0.1 1035";
+"runcon -t test_sctp_client_t -l s0:c0.c10 $basedir/sctp_client $v seq 127.0.0.1 1035";
 ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server using STREAM->SEQ->peeloff with same level.
 $result = system
-"runcon -t test_sctp_client_t -l s0:c0.c10 $basedir/sctp_client $v -x -i stream 127.0.0.1 1035";
+"runcon -t test_sctp_client_t -l s0:c0.c10 $basedir/sctp_client $v -x stream 127.0.0.1 1035";
 ok( $result eq 0 );
 
+# Restart the seq server to reset the SCTP state and labels
+server_end($pid);
+$pid = server_start(
+    "-t test_sctp_server_t -l s0:c0.c10",
+    "sctp_peeloff_server",
+    "$v -4 1035"
+);
+
 # Verify that client cannot communicate with the server using STREAM->SEQ->peeloff with invalid level.
 $result = system
-"runcon -t test_sctp_client_t -l s0:c0.c11 -- $basedir/sctp_client $v -x -i stream 127.0.0.1 1035 2>&1";
+"runcon -t test_sctp_client_t -l s0:c0.c11 -- $basedir/sctp_client $v -x stream 127.0.0.1 1035 2>&1";
 ok( $result >> 8 eq 6 );
 
 # Kill the seq server.
@@ -551,32 +591,32 @@ system "/bin/sh $basedir/cipso-flush";
 #
 ############################## CIPSO/IPv4 TAG 2 ###############################
 #
-print "# Testing CIPSO/IPv4 - TAG 2 using socket ip_option data\n";
+print "# Testing CIPSO/IPv4 - TAG 2\n";
 system "/bin/sh $basedir/cipso-load-t2";
 
 # Start the stream server for IPv4 only.
 $pid = server_start(
     "-t test_sctp_server_t -l s0:c782,c714,c769,c788,c803,c842,c864",
-    "sctp_server", "$v -4 -i stream 1035" );
+    "sctp_server", "$v -4 stream 1035" );
 
 # Verify that authorized client can communicate with the server STREAM->STREAM with client using sctp_connectx(3).
 $result = system
-"runcon -t test_sctp_client_t -l s0:c782,c714,c769,c788,c803,c842,c864 $basedir/sctp_client $v -x -i stream 127.0.0.1 1035";
+"runcon -t test_sctp_client_t -l s0:c782,c714,c769,c788,c803,c842,c864 $basedir/sctp_client $v -x stream 127.0.0.1 1035";
 ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server STREAM->STREAM with client using connect(2).
 $result = system
-"runcon -t test_sctp_client_t -l s0:c782,c714,c769,c788,c803,c842,c864 $basedir/sctp_client $v -i stream 127.0.0.1 1035";
+"runcon -t test_sctp_client_t -l s0:c782,c714,c769,c788,c803,c842,c864 $basedir/sctp_client $v stream 127.0.0.1 1035";
 ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server using different valid level STREAM->STREAM.
 $result = system
-"runcon -t test_sctp_client_t -l s0:c769,c788,c803,c842,c864 $basedir/sctp_client $v -i stream 127.0.0.1 1035";
+"runcon -t test_sctp_client_t -l s0:c769,c788,c803,c842,c864 $basedir/sctp_client $v stream 127.0.0.1 1035";
 ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server using different valid level SEQ->STREAM
 $result = system
-"runcon -t test_sctp_client_t -l s0:c769,c788,c803 $basedir/sctp_client $v -i seq 127.0.0.1 1035";
+"runcon -t test_sctp_client_t -l s0:c769,c788,c803 $basedir/sctp_client $v seq 127.0.0.1 1035";
 ok( $result eq 0 );
 
 # Verify that authorized client cannot communicate with the server using invalid level STREAM->STREAM.
@@ -588,17 +628,17 @@ if ($test_clpeeloff) {
 
 # Verify that authorized client can communicate with the server peeloff->SEQ->STREAM with client using connect(2).
     $result = system
-"runcon -t test_sctp_client_t -l s0:c782,c714,c769,c788,c803,c842,c864 $basedir/sctp_peeloff_client $v -i 127.0.0.1 1035";
+"runcon -t test_sctp_client_t -l s0:c782,c714,c769,c788,c803,c842,c864 $basedir/sctp_peeloff_client $v 127.0.0.1 1035";
     ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server peeloff->SEQ->STREAM with client using sctp_connectx(3).
     $result = system
-"runcon -t test_sctp_client_t -l s0:c782,c714,c769,c788,c803,c842,c864 $basedir/sctp_peeloff_client $v -x -i 127.0.0.1 1035";
+"runcon -t test_sctp_client_t -l s0:c782,c714,c769,c788,c803,c842,c864 $basedir/sctp_peeloff_client $v -x 127.0.0.1 1035";
     ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server peeloff->SEQ->STREAM with no client connect(2).
     $result = system
-"runcon -t test_sctp_client_t -l s0:c782,c714,c769,c788,c803,c842,c864 $basedir/sctp_peeloff_client $v -n -i 127.0.0.1 1035";
+"runcon -t test_sctp_client_t -l s0:c782,c714,c769,c788,c803,c842,c864 $basedir/sctp_peeloff_client $v -n 127.0.0.1 1035";
     ok( $result eq 0 );
 }
 
@@ -609,77 +649,117 @@ server_end($pid);
 $pid = server_start(
     "-t test_sctp_server_t -l s0:c20.c335",
     "sctp_server",
-    "$v -4 -i seq 1035"
+    "$v -4 seq 1035"
 );
 
 # Verify that authorized client can communicate with the server. SEQ->SEQ
 $result = system
-"runcon -t test_sctp_client_t -l s0:c328.c333 $basedir/sctp_client $v -i seq 127.0.0.1 1035";
+"runcon -t test_sctp_client_t -l s0:c328.c333 $basedir/sctp_client $v seq 127.0.0.1 1035";
 ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server using STREAM->SEQ.
 $result = system
-"runcon -t test_sctp_client_t -l s0:c20.c34 $basedir/sctp_client $v -i stream 127.0.0.1 1035";
+"runcon -t test_sctp_client_t -l s0:c328.c333 $basedir/sctp_client $v stream 127.0.0.1 1035";
 ok( $result eq 0 );
 
+# Restart the seq server to reset the SCTP state and labels
+server_end($pid);
+$pid = server_start(
+    "-t test_sctp_server_t -l s0:c20.c335",
+    "sctp_server",
+    "$v -4 seq 1035"
+);
+
 # Verify that authorized client can communicate with the server using SEQ->SEQ with diff valid level.
 $result = system
-"runcon -t test_sctp_client_t -l s0:c20.c30,c31,c335 $basedir/sctp_client $v -i seq 127.0.0.1 1035";
+"runcon -t test_sctp_client_t -l s0:c20.c30,c31,c335 $basedir/sctp_client $v seq 127.0.0.1 1035";
 ok( $result eq 0 );
 
+# Restart the seq server to reset the SCTP state and labels
+server_end($pid);
+$pid = server_start(
+    "-t test_sctp_server_t -l s0:c20.c335",
+    "sctp_server",
+    "$v -4 seq 1035"
+);
+
 # Verify that client cannot communicate with the server using SEQ->SEQ with invalid level.
 $result = system
-"runcon -t test_sctp_client_t -l s0:c19.c30 -- $basedir/sctp_client $v -i seq 127.0.0.1 1035 2>&1";
+"runcon -t test_sctp_client_t -l s0:c19.c30 -- $basedir/sctp_client $v seq 127.0.0.1 1035 2>&1";
 ok( $result >> 8 eq 6 );
 
-# TAG 2 allows a maximum of 15 categories in exchange, if greater then ENOSPC (No space left on device)
+# Restart the seq server to reset the SCTP state and labels
+server_end($pid);
+$pid = server_start(
+    "-t test_sctp_server_t -l s0:c20.c335",
+    "sctp_server",
+    "$v -4 seq 1035"
+);
+
+# TAG 2 allows a maximum of 15 categories in exchange
 $result = system
-"runcon -t test_sctp_client_t -l s0:c200.c216 -- $basedir/sctp_client $v -i seq 127.0.0.1 1035 2>&1";
+"runcon -t test_sctp_client_t -l s0:c200.c216 -- $basedir/sctp_client $v seq 127.0.0.1 1035 2>&1";
 ok( $result >> 8 eq 7 );
 
 if ($test_clpeeloff) {
 
+# Restart the seq server to reset the SCTP state and labels
+    server_end($pid);
+    $pid = server_start(
+        "-t test_sctp_server_t -l s0:c20.c335",
+        "sctp_server",
+        "$v -4 seq 1035"
+    );
+
 # Verify that authorized client can communicate with the server peeloff->SEQ->SEQ with client using connect(2).
     $result = system
-"runcon -t test_sctp_client_t -l s0:c20.c30 $basedir/sctp_peeloff_client $v -i 127.0.0.1 1035";
+"runcon -t test_sctp_client_t -l s0:c20.c30 $basedir/sctp_peeloff_client $v 127.0.0.1 1035";
     ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server peeloff->SEQ->SEQ with client using sctp_connectx(3).
     $result = system
-"runcon -t test_sctp_client_t -l s0:c20.c30 $basedir/sctp_peeloff_client $v -x -i 127.0.0.1 1035";
+"runcon -t test_sctp_client_t -l s0:c20.c30 $basedir/sctp_peeloff_client $v -x 127.0.0.1 1035";
     ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server peeloff->SEQ->SEQ with no client connect(2).
     $result = system
-"runcon -t test_sctp_client_t -l s0:c20.c30 $basedir/sctp_peeloff_client $v -n -i 127.0.0.1 1035";
+"runcon -t test_sctp_client_t -l s0:c20.c30 $basedir/sctp_peeloff_client $v -n 127.0.0.1 1035";
     ok( $result eq 0 );
 }
 
 # Kill server.
 server_end($pid);
 
-print "# Testing CIPSO/IPv4 - TAG 2 PEELOFF using socket ip_option data\n";
+print "# Testing CIPSO/IPv4 - TAG 2 PEELOFF\n";
 
 # Test sctp_peeloff(3) server using 1 to Many SOCK_SEQPACKET
 $pid = server_start(
     "-t test_sctp_server_t -l s0:c0.c10",
     "sctp_peeloff_server",
-    "$v -4 -i 1035"
+    "$v -4 1035"
 );
 
 # Verify that authorized client can communicate with the server using SEQ->SEQ->Peeloff with same level.
 $result = system
-"runcon -t test_sctp_client_t -l s0:c0.c10 $basedir/sctp_client $v -i seq 127.0.0.1 1035";
+"runcon -t test_sctp_client_t -l s0:c0.c10 $basedir/sctp_client $v seq 127.0.0.1 1035";
 ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server using STREAM->SEQ->peeloff with same level.
 $result = system
-"runcon -t test_sctp_client_t -l s0:c0.c10 $basedir/sctp_client $v -x -i stream 127.0.0.1 1035";
+"runcon -t test_sctp_client_t -l s0:c0.c10 $basedir/sctp_client $v -x stream 127.0.0.1 1035";
 ok( $result eq 0 );
 
+# Restart the seq server to reset the SCTP state and labels
+server_end($pid);
+$pid = server_start(
+    "-t test_sctp_server_t -l s0:c0.c10",
+    "sctp_peeloff_server",
+    "$v -4 1035"
+);
+
 # Verify that client cannot communicate with the server using STREAM->SEQ->peeloff with invalid level.
 $result = system
-"runcon -t test_sctp_client_t -l s0:c0.c11 -- $basedir/sctp_client $v -x -i stream 127.0.0.1 1035 2>&1";
+"runcon -t test_sctp_client_t -l s0:c0.c11 -- $basedir/sctp_client $v -x stream 127.0.0.1 1035 2>&1";
 ok( $result >> 8 eq 6 );
 
 # Kill the seq server.
@@ -690,32 +770,32 @@ system "/bin/sh $basedir/cipso-flush";
 #
 ############################## CIPSO/IPv4 TAG 5 ###############################
 #
-print "# Testing CIPSO/IPv4 - TAG 5 using socket ip_option data\n";
+print "# Testing CIPSO/IPv4 - TAG 5\n";
 system "/bin/sh $basedir/cipso-load-t5";
 
 # Start the stream server for IPv4 only.
 $pid = server_start(
     "-t test_sctp_server_t -l s0:c782,c714,c769,c788,c803,c842,c864",
-    "sctp_server", "$v -4 -i stream 1035" );
+    "sctp_server", "$v -4 stream 1035" );
 
 # Verify that authorized client can communicate with the server STREAM->STREAM with client using sctp_connectx(3).
 $result = system
-"runcon -t test_sctp_client_t -l s0:c782,c714,c769,c788,c803,c842,c864 $basedir/sctp_client $v -x -i stream 127.0.0.1 1035";
+"runcon -t test_sctp_client_t -l s0:c782,c714,c769,c788,c803,c842,c864 $basedir/sctp_client $v -x stream 127.0.0.1 1035";
 ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server STREAM->STREAM with client using connect(2).
 $result = system
-"runcon -t test_sctp_client_t -l s0:c782,c714,c769,c788,c803,c842,c864 $basedir/sctp_client $v -i stream 127.0.0.1 1035";
+"runcon -t test_sctp_client_t -l s0:c782,c714,c769,c788,c803,c842,c864 $basedir/sctp_client $v stream 127.0.0.1 1035";
 ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server using different valid level STREAM->STREAM.
 $result = system
-"runcon -t test_sctp_client_t -l s0:c769,c788,c803,c842,c864 $basedir/sctp_client $v -i stream 127.0.0.1 1035";
+"runcon -t test_sctp_client_t -l s0:c769,c788,c803,c842,c864 $basedir/sctp_client $v stream 127.0.0.1 1035";
 ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server using different valid level SEQ->STREAM
 $result = system
-"runcon -t test_sctp_client_t -l s0:c769,c788,c803 $basedir/sctp_client $v -i seq 127.0.0.1 1035";
+"runcon -t test_sctp_client_t -l s0:c769,c788,c803 $basedir/sctp_client $v seq 127.0.0.1 1035";
 ok( $result eq 0 );
 
 # Verify that authorized client cannot communicate with the server using invalid level STREAM->STREAM.
@@ -727,17 +807,17 @@ if ($test_clpeeloff) {
 
 # Verify that authorized client can communicate with the server peeloff->SEQ->STREAM with client using connect(2).
     $result = system
-"runcon -t test_sctp_client_t -l s0:c782,c714,c769,c788,c803,c842,c864 $basedir/sctp_peeloff_client $v -i 127.0.0.1 1035";
+"runcon -t test_sctp_client_t -l s0:c782,c714,c769,c788,c803,c842,c864 $basedir/sctp_peeloff_client $v 127.0.0.1 1035";
     ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server peeloff->SEQ->STREAM with client using sctp_connectx(3).
     $result = system
-"runcon -t test_sctp_client_t -l s0:c782,c714,c769,c788,c803,c842,c864 $basedir/sctp_peeloff_client $v -x -i 127.0.0.1 1035";
+"runcon -t test_sctp_client_t -l s0:c782,c714,c769,c788,c803,c842,c864 $basedir/sctp_peeloff_client $v -x 127.0.0.1 1035";
     ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server peeloff->SEQ->STREAM with no client connect(2).
     $result = system
-"runcon -t test_sctp_client_t -l s0:c782,c714,c769,c788,c803,c842,c864 $basedir/sctp_peeloff_client $v -n -i 127.0.0.1 1035";
+"runcon -t test_sctp_client_t -l s0:c782,c714,c769,c788,c803,c842,c864 $basedir/sctp_peeloff_client $v -n 127.0.0.1 1035";
     ok( $result eq 0 );
 }
 
@@ -748,77 +828,117 @@ server_end($pid);
 $pid = server_start(
     "-t test_sctp_server_t -l s0:c20.c50",
     "sctp_server",
-    "$v -4 -i seq 1035"
+    "$v -4 seq 1035"
 );
 
 # Verify that authorized client can communicate with the server. SEQ->SEQ
 $result = system
-"runcon -t test_sctp_client_t -l s0:c28.c48 $basedir/sctp_client $v -i seq 127.0.0.1 1035";
+"runcon -t test_sctp_client_t -l s0:c28.c48 $basedir/sctp_client $v seq 127.0.0.1 1035";
 ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server using STREAM->SEQ.
 $result = system
-"runcon -t test_sctp_client_t -l s0:c20.c50 $basedir/sctp_client $v -i stream 127.0.0.1 1035";
+"runcon -t test_sctp_client_t -l s0:c28.c48 $basedir/sctp_client $v stream 127.0.0.1 1035";
 ok( $result eq 0 );
 
+# Restart the seq server to reset the SCTP state and labels
+server_end($pid);
+$pid = server_start(
+    "-t test_sctp_server_t -l s0:c20.c50",
+    "sctp_server",
+    "$v -4 seq 1035"
+);
+
 # Verify that authorized client can communicate with the server using SEQ->SEQ with diff valid level.
 $result = system
-"runcon -t test_sctp_client_t -l s0:c20.c30,c31,c35,c40.c45 $basedir/sctp_client $v -i seq 127.0.0.1 1035";
+"runcon -t test_sctp_client_t -l s0:c20.c30,c31,c35,c40.c45 $basedir/sctp_client $v seq 127.0.0.1 1035";
 ok( $result eq 0 );
 
+# Restart the seq server to reset the SCTP state and labels
+server_end($pid);
+$pid = server_start(
+    "-t test_sctp_server_t -l s0:c20.c50",
+    "sctp_server",
+    "$v -4 seq 1035"
+);
+
 # Verify that client cannot communicate with the server using SEQ->SEQ with invalid level.
 $result = system
-"runcon -t test_sctp_client_t -l s0:c20.c51 -- $basedir/sctp_client $v -i seq 127.0.0.1 1035 2>&1";
+"runcon -t test_sctp_client_t -l s0:c20.c51 -- $basedir/sctp_client $v seq 127.0.0.1 1035 2>&1";
 ok( $result >> 8 eq 6 );
 
-# TAG 2 allows a maximum of 7 ranges in exchange, if greater then ENOSPC (No space left on device)
+# Restart the seq server to reset the SCTP state and labels
+server_end($pid);
+$pid = server_start(
+    "-t test_sctp_server_t -l s0:c20.c50",
+    "sctp_server",
+    "$v -4 seq 1035"
+);
+
+# TAG 2 allows a maximum of 7 ranges in exchange
 $result = system
-"runcon -t test_sctp_client_t -l s0:c20,c22,c24,c30.c33,c38,c42.c45,c48,c50 -- $basedir/sctp_client $v -i seq 127.0.0.1 1035 2>&1";
+"runcon -t test_sctp_client_t -l s0:c20,c22,c24,c30.c33,c38,c42.c45,c48,c50 -- $basedir/sctp_client $v seq 127.0.0.1 1035 2>&1";
 ok( $result >> 8 eq 7 );
 
 if ($test_clpeeloff) {
 
+# Restart the seq server to reset the SCTP state and labels
+    server_end($pid);
+    $pid = server_start(
+        "-t test_sctp_server_t -l s0:c20.c50",
+        "sctp_server",
+        "$v -4 seq 1035"
+    );
+
 # Verify that authorized client can communicate with the server peeloff->SEQ->SEQ with client using connect(2).
     $result = system
-"runcon -t test_sctp_client_t -l s0:c20.c50 $basedir/sctp_peeloff_client $v -i 127.0.0.1 1035";
+"runcon -t test_sctp_client_t -l s0:c20.c50 $basedir/sctp_peeloff_client $v 127.0.0.1 1035";
     ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server peeloff->SEQ->SEQ with client using sctp_connectx(3).
     $result = system
-"runcon -t test_sctp_client_t -l s0:c20.c50 $basedir/sctp_peeloff_client $v -x -i 127.0.0.1 1035";
+"runcon -t test_sctp_client_t -l s0:c20.c50 $basedir/sctp_peeloff_client $v -x 127.0.0.1 1035";
     ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server peeloff->SEQ->SEQ with no client connect(2).
     $result = system
-"runcon -t test_sctp_client_t -l s0:c20.c50 $basedir/sctp_peeloff_client $v -n -i 127.0.0.1 1035";
+"runcon -t test_sctp_client_t -l s0:c20.c50 $basedir/sctp_peeloff_client $v -n 127.0.0.1 1035";
     ok( $result eq 0 );
 }
 
 # Kill server.
 server_end($pid);
 
-print "# Testing CIPSO/IPv4 - TAG 5 PEELOFF using socket ip_option data\n";
+print "# Testing CIPSO/IPv4 - TAG 5 PEELOFF\n";
 
 # Test sctp_peeloff(3) server using 1 to Many SOCK_SEQPACKET
 $pid = server_start(
     "-t test_sctp_server_t -l s0:c0.c10",
     "sctp_peeloff_server",
-    "$v -4 -i 1035"
+    "$v -4 1035"
 );
 
 # Verify that authorized client can communicate with the server using SEQ->SEQ->Peeloff with same level.
 $result = system
-"runcon -t test_sctp_client_t -l s0:c0.c10 $basedir/sctp_client $v -i seq 127.0.0.1 1035";
+"runcon -t test_sctp_client_t -l s0:c0.c10 $basedir/sctp_client $v seq 127.0.0.1 1035";
 ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server using STREAM->SEQ->peeloff with same level.
 $result = system
-"runcon -t test_sctp_client_t -l s0:c0.c10 $basedir/sctp_client $v -x -i stream 127.0.0.1 1035";
+"runcon -t test_sctp_client_t -l s0:c0.c10 $basedir/sctp_client $v -x stream 127.0.0.1 1035";
 ok( $result eq 0 );
 
+# Restart the seq server to reset the SCTP state and labels
+server_end($pid);
+$pid = server_start(
+    "-t test_sctp_server_t -l s0:c0.c10",
+    "sctp_peeloff_server",
+    "$v -4 1035"
+);
+
 # Verify that client cannot communicate with the server using STREAM->SEQ->peeloff with invalid level.
 $result = system
-"runcon -t test_sctp_client_t -l s0:c0.c11 -- $basedir/sctp_client $v -x -i stream 127.0.0.1 1035 2>&1";
+"runcon -t test_sctp_client_t -l s0:c0.c11 -- $basedir/sctp_client $v -x stream 127.0.0.1 1035 2>&1";
 ok( $result >> 8 eq 6 );
 
 # Kill the seq server.
@@ -874,56 +994,56 @@ system "/bin/sh $basedir/cipso-fl-flush";
 #
 
 if ($test_calipso) {
-    print "# Testing CALIPSO/IPv6 using socket ip_option data\n";
+    print "# Testing CALIPSO/IPv6\n";
     system "/bin/sh $basedir/calipso-load";
 
     # Start the stream server.
     $pid = server_start(
 "-t test_sctp_server_t -l  s0:c0,c12,c24,c36,c28,c610,c712,c414,c516,c318,c820,c622,c924,c726,c128,c330,c832,c534,c936,c138,c740,c42,c44,c246,c648,c950,c152,c354,c856,c158,c960,c662,c634,c686,c368,c570,c782,c714,c769,c788,c803,c842,c864,c986,c788,c290,c392,c594,c896,c698,c1023",
         "sctp_server",
-        "$v -i stream 1035"
+        "$v stream 1035"
     );
 
 # Verify that authorized client can communicate with the server STREAM->STREAM with client using sctp_connectx(3).
     $result = system
-"runcon -t test_sctp_client_t -l s0:c0,c12,c24,c36,c28,c610,c712,c414,c516,c318,c820,c622,c924,c726,c128,c330,c832,c534,c936,c138,c740,c42,c44,c246,c648,c950,c152,c354,c856,c158,c960,c662,c634,c686,c368,c570,c782,c714,c769,c788,c803,c842,c864,c986,c788,c290,c392,c594,c896,c698,c1023  $basedir/sctp_client $v -x -i stream ::1 1035";
+"runcon -t test_sctp_client_t -l s0:c0,c12,c24,c36,c28,c610,c712,c414,c516,c318,c820,c622,c924,c726,c128,c330,c832,c534,c936,c138,c740,c42,c44,c246,c648,c950,c152,c354,c856,c158,c960,c662,c634,c686,c368,c570,c782,c714,c769,c788,c803,c842,c864,c986,c788,c290,c392,c594,c896,c698,c1023  $basedir/sctp_client $v -x stream ::1 1035";
     ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server STREAM->STREAM with client using connect(2).
     $result = system
-"runcon -t test_sctp_client_t -l s0:c0,c12,c24,c36,c28,c610,c712,c414,c516,c318,c820,c622,c924,c726,c128,c330,c832,c534,c936,c138,c740,c42,c44,c246,c648,c950,c152,c354,c856,c158,c960,c662,c634,c686,c368,c570,c782,c714,c769,c788,c803,c842,c864,c986,c788,c290,c392,c594,c896,c698,c1023  $basedir/sctp_client $v -i stream ::1 1035";
+"runcon -t test_sctp_client_t -l s0:c0,c12,c24,c36,c28,c610,c712,c414,c516,c318,c820,c622,c924,c726,c128,c330,c832,c534,c936,c138,c740,c42,c44,c246,c648,c950,c152,c354,c856,c158,c960,c662,c634,c686,c368,c570,c782,c714,c769,c788,c803,c842,c864,c986,c788,c290,c392,c594,c896,c698,c1023  $basedir/sctp_client $v stream ::1 1035";
     ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server using different valid level STREAM->STREAM.
     $result = system
-"runcon -t test_sctp_client_t -l s0:c924,c726,c128,c330,c832,c534,c936,c138,c740,c42 $basedir/sctp_client $v -i stream ::1 1035";
+"runcon -t test_sctp_client_t -l s0:c924,c726,c128,c330,c832,c534,c936,c138,c740,c42 $basedir/sctp_client $v stream ::1 1035";
     ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server using different valid level SEQ->STREAM
     $result = system
-"runcon -t test_sctp_client_t -l s0:c924,c726,c128,c330,c832,c534,c936,c138,c740,c42 $basedir/sctp_client $v -i seq ::1 1035";
+"runcon -t test_sctp_client_t -l s0:c924,c726,c128,c330,c832,c534,c936,c138,c740,c42 $basedir/sctp_client $v seq ::1 1035";
     ok( $result eq 0 );
 
 # Verify that authorized client cannot communicate with the server using invalid level STREAM->STREAM.
     $result = system
-"runcon -t test_sctp_client_t -l s0:c8.c12 -- $basedir/sctp_client $v -i stream ::1 1035 2>&1";
+"runcon -t test_sctp_client_t -l s0:c8.c12 -- $basedir/sctp_client $v stream ::1 1035 2>&1";
     ok( $result >> 8 eq 6 );
 
     if ($test_clpeeloff) {
 
 # Verify that authorized client can communicate with the server peeloff->SEQ->STREAM with client using connect(2).
         $result = system
-"runcon -t test_sctp_client_t -l s0:c0,c12,c24,c36,c28,c610,c712,c414,c516,c318,c820,c622,c924,c726,c128,c330,c832,c534,c936,c138,c740,c42,c44,c246,c648,c950,c152,c354,c856,c158,c960,c662,c634,c686,c368,c570,c782,c714,c769,c788,c803,c842,c864,c986,c788,c290,c392,c594,c896,c698,c1023 $basedir/sctp_peeloff_client $v -i ::1 1035";
+"runcon -t test_sctp_client_t -l s0:c0,c12,c24,c36,c28,c610,c712,c414,c516,c318,c820,c622,c924,c726,c128,c330,c832,c534,c936,c138,c740,c42,c44,c246,c648,c950,c152,c354,c856,c158,c960,c662,c634,c686,c368,c570,c782,c714,c769,c788,c803,c842,c864,c986,c788,c290,c392,c594,c896,c698,c1023 $basedir/sctp_peeloff_client $v ::1 1035";
         ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server peeloff->SEQ->STREAM with client using sctp_connectx(3).
         $result = system
-"runcon -t test_sctp_client_t -l s0:c0,c12,c24,c36,c28,c610,c712,c414,c516,c318,c820,c622,c924,c726,c128,c330,c832,c534,c936,c138,c740,c42,c44,c246,c648,c950,c152,c354,c856,c158,c960,c662,c634,c686,c368,c570,c782,c714,c769,c788,c803,c842,c864,c986,c788,c290,c392,c594,c896,c698,c1023 $basedir/sctp_peeloff_client $v -x -i ::1 1035";
+"runcon -t test_sctp_client_t -l s0:c0,c12,c24,c36,c28,c610,c712,c414,c516,c318,c820,c622,c924,c726,c128,c330,c832,c534,c936,c138,c740,c42,c44,c246,c648,c950,c152,c354,c856,c158,c960,c662,c634,c686,c368,c570,c782,c714,c769,c788,c803,c842,c864,c986,c788,c290,c392,c594,c896,c698,c1023 $basedir/sctp_peeloff_client $v -x ::1 1035";
         ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server peeloff->SEQ->STREAM with no client connect(2).
         $result = system
-"runcon -t test_sctp_client_t -l s0:c0,c12,c24,c36,c28,c610,c712,c414,c516,c318,c820,c622,c924,c726,c128,c330,c832,c534,c936,c138,c740,c42,c44,c246,c648,c950,c152,c354,c856,c158,c960,c662,c634,c686,c368,c570,c782,c714,c769,c788,c803,c842,c864,c986,c788,c290,c392,c594,c896,c698,c1023 $basedir/sctp_peeloff_client $v -n -i ::1 1035";
+"runcon -t test_sctp_client_t -l s0:c0,c12,c24,c36,c28,c610,c712,c414,c516,c318,c820,c622,c924,c726,c128,c330,c832,c534,c936,c138,c740,c42,c44,c246,c648,c950,c152,c354,c856,c158,c960,c662,c634,c686,c368,c570,c782,c714,c769,c788,c803,c842,c864,c986,c788,c290,c392,c594,c896,c698,c1023 $basedir/sctp_peeloff_client $v -n ::1 1035";
         ok( $result eq 0 );
     }
 
@@ -934,77 +1054,117 @@ if ($test_calipso) {
     $pid = server_start(
         "-t test_sctp_server_t -l s0:c20.c50",
         "sctp_server",
-        "$v -i seq 1035"
+        "$v seq 1035"
     );
 
     # Verify that authorized client can communicate with the server. SEQ->SEQ
     $result = system
-"runcon -t test_sctp_client_t -l s0:c28.c48 $basedir/sctp_client $v -i seq ::1 1035";
+"runcon -t test_sctp_client_t -l s0:c28.c48 $basedir/sctp_client $v seq ::1 1035";
     ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server using STREAM->SEQ.
     $result = system
-"runcon -t test_sctp_client_t -l s0:c20.c50 $basedir/sctp_client $v -i stream ::1 1035";
+"runcon -t test_sctp_client_t -l s0:c28.c48 $basedir/sctp_client $v stream ::1 1035";
     ok( $result eq 0 );
 
+# Restart the seq server to reset the SCTP state and labels
+    server_end($pid);
+    $pid = server_start(
+        "-t test_sctp_server_t -l s0:c20.c50",
+        "sctp_server",
+        "$v seq 1035"
+    );
+
 # Verify that authorized client can communicate with the server using SEQ->SEQ with diff valid level.
     $result = system
-"runcon -t test_sctp_client_t -l s0:c20.c30,c31,c35,c40.c45 $basedir/sctp_client $v -i seq ::1 1035";
+"runcon -t test_sctp_client_t -l s0:c20.c30,c31,c35,c40.c45 $basedir/sctp_client $v seq ::1 1035";
     ok( $result eq 0 );
 
+# Restart the seq server to reset the SCTP state and labels
+    server_end($pid);
+    $pid = server_start(
+        "-t test_sctp_server_t -l s0:c20.c50",
+        "sctp_server",
+        "$v seq 1035"
+    );
+
 # Verify that client cannot communicate with the server using SEQ->SEQ with invalid level.
     $result = system
-"runcon -t test_sctp_client_t -l s0:c20.c51 $basedir/sctp_client $v -i seq ::1 1035 2>&1";
+"runcon -t test_sctp_client_t -l s0:c20.c51 $basedir/sctp_client $v seq ::1 1035 2>&1";
     ok( $result >> 8 eq 6 );
 
+# Restart the seq server to reset the SCTP state and labels
+    server_end($pid);
+    $pid = server_start(
+        "-t test_sctp_server_t -l s0:c20.c50",
+        "sctp_server",
+        "$v seq 1035"
+    );
+
 # Verify that client cannot communicate with the server using SEQ->SEQ with invalid level.
     $result = system
-"runcon -t test_sctp_client_t -l s0:c19.c50 -- $basedir/sctp_client $v -i seq ::1 1035 2>&1";
+"runcon -t test_sctp_client_t -l s0:c19.c50 -- $basedir/sctp_client $v seq ::1 1035 2>&1";
     ok( $result >> 8 eq 6 );
 
     if ($test_clpeeloff) {
 
+# Restart the seq server to reset the SCTP state and labels
+        server_end($pid);
+        $pid = server_start(
+            "-t test_sctp_server_t -l s0:c20.c50",
+            "sctp_server",
+            "$v seq 1035"
+        );
+
 # Verify that authorized client can communicate with the server peeloff->SEQ->SEQ with client using connect(2).
         $result = system
-"runcon -t test_sctp_client_t -l s0:c20.c50 $basedir/sctp_peeloff_client $v -i ::1 1035";
+"runcon -t test_sctp_client_t -l s0:c20.c50 $basedir/sctp_peeloff_client $v ::1 1035";
         ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server peeloff->SEQ->SEQ with client using sctp_connectx(3).
         $result = system
-"runcon -t test_sctp_client_t -l s0:c20.c50 $basedir/sctp_peeloff_client $v -x -i ::1 1035";
+"runcon -t test_sctp_client_t -l s0:c20.c50 $basedir/sctp_peeloff_client $v -x ::1 1035";
         ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server peeloff->SEQ->SEQ with no client connect(2).
         $result = system
-"runcon -t test_sctp_client_t -l s0:c20.c50 $basedir/sctp_peeloff_client $v -n -i ::1 1035";
+"runcon -t test_sctp_client_t -l s0:c20.c50 $basedir/sctp_peeloff_client $v -n ::1 1035";
         ok( $result eq 0 );
     }
 
     # Kill server.
     server_end($pid);
 
-    print "# Testing CALIPSO/IPv6 PEELOFF using socket ip_option data\n";
+    print "# Testing CALIPSO/IPv6 PEELOFF\n";
 
     # Test sctp_peeloff(3) server using 1 to Many SOCK_SEQPACKET
     $pid = server_start(
         "-t test_sctp_server_t -l s0:c0.c10",
         "sctp_peeloff_server",
-        "$v -i 1035"
+        "$v 1035"
     );
 
 # Verify that authorized client can communicate with the server using SEQ->SEQ->Peeloff with same level.
     $result = system
-"runcon -t test_sctp_client_t -l s0:c0.c10 $basedir/sctp_client $v -i seq ::1 1035";
+"runcon -t test_sctp_client_t -l s0:c0.c10 $basedir/sctp_client $v seq ::1 1035";
     ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server using STREAM->SEQ->peeloff with same level.
     $result = system
-"runcon -t test_sctp_client_t -l s0:c0.c10 $basedir/sctp_client $v -x -i stream ::1 1035";
+"runcon -t test_sctp_client_t -l s0:c0.c10 $basedir/sctp_client $v -x stream ::1 1035";
     ok( $result eq 0 );
 
+# Restart the seq server to reset the SCTP state and labels
+    server_end($pid);
+    $pid = server_start(
+        "-t test_sctp_server_t -l s0:c0.c10",
+        "sctp_peeloff_server",
+        "$v 1035"
+    );
+
 # Verify that client cannot communicate with the server using STREAM->SEQ->peeloff with invalid level.
     $result = system
-"runcon -t test_sctp_client_t -l s0:c0.c11 -- $basedir/sctp_client $v -x -i stream ::1 1035 2>&1";
+"runcon -t test_sctp_client_t -l s0:c0.c11 -- $basedir/sctp_client $v -x stream ::1 1035 2>&1";
     ok( $result >> 8 eq 6 );
 
     # Kill the seq server.

