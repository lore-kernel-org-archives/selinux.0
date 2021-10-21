Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32C3C433F5
	for <selinux@archiver.kernel.org>; Thu, 21 Oct 2021 14:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BCAB611CB
	for <selinux@archiver.kernel.org>; Thu, 21 Oct 2021 14:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbhJUOsG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Oct 2021 10:48:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:49691 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230390AbhJUOsG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 Oct 2021 10:48:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634827549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=nV4X8z5kTR7nBGjih1v8kd3sFcM9QqaMwHDpUYd/838=;
        b=Ado7tyCSXNKEO20IjiAIsJahPup6SN/ZvxCC191SBwjmXe+5OQl5f/EKYR9Uk4f4kd8xGd
        algeVUYtSOp4TF4lf42ZE+4/C3jvPHb5y2usMIm1PoirCXeKK250YdQJ/v0H3feBcvYLPX
        NwpkPXKxQbBMmSIfN+B5wrHQbUGXa6E=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-f_FB8hoGMx-ayyZTn2vtnA-1; Thu, 21 Oct 2021 10:45:48 -0400
X-MC-Unique: f_FB8hoGMx-ayyZTn2vtnA-1
Received: by mail-ed1-f69.google.com with SMTP id z1-20020a05640235c100b003dcf0fbfbd8so602670edc.6
        for <selinux@vger.kernel.org>; Thu, 21 Oct 2021 07:45:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nV4X8z5kTR7nBGjih1v8kd3sFcM9QqaMwHDpUYd/838=;
        b=a6tEVL7xTLoNXC9vNO8I4RUHCFWK+5bmcxerda+yaB+mlyx1zqNIR8J+es1d6GGY/5
         XgYB6HVdhj4yUAUubhMVe28+qAXrMttq3nHUXFQSi1+NuTaebPrJv1glaZ1/FO3+Ws3S
         oXX+v49BN8PsGiWWckd7OJWXqw1lLqTCyX3Nhwi/BnR1tdNXoZauE//3khz9kF9q6eBJ
         O2C7h4Pv3gzfleIJXGx8W9H+gzWayTEkesE3cdpGx5IDRKjXQR83Dk6lYWJRRzx9tICo
         V2BRaNcZ1dI7C2Xq8xmscmBy6aZt3DWfvssxRdUc+YQQXEBmjsoprkO8I0nUQorcX9ot
         2iQQ==
X-Gm-Message-State: AOAM532n0pu3+RHAX6kZOmvFCzSa13Va2ItMW/Z6v96MotpWTURro8ic
        aervsE2/jKze4qFKM3oAgXiDqBsSBJpmb9wSI8P+kUmSgKVzyJtf15YC0yXKPGUmaeA1h1uriBC
        a+CSCgP9Xz7xRneK0kkrCTkkPYBhMulZKQLeMiJE8LCWhkEuarCmo6WFVI0CwFVZvdCUQeA==
X-Received: by 2002:a17:906:c0d:: with SMTP id s13mr7826949ejf.309.1634827546393;
        Thu, 21 Oct 2021 07:45:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyRvMbUSR5j7T/qltlV+iwZuk6fnd0jXJ31a1kDnb4sTkAolb2WIpOuqxpz/jn8OnV3DwbCMA==
X-Received: by 2002:a17:906:c0d:: with SMTP id s13mr7826727ejf.309.1634827544486;
        Thu, 21 Oct 2021 07:45:44 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 91sm2920165ede.56.2021.10.21.07.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 07:45:43 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH testsuite] tests/sctp: add client peeloff tests
Date:   Thu, 21 Oct 2021 16:45:43 +0200
Message-Id: <20211021144543.740762-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Currently the testsuite only verifies that SCTP peeloff works on the
server side. However, it can just as well be used on the client side as
well, which isn't being tested (and actually is buggy at the time of
writing).

To correct this, add a simple SCTP peeloff client and a couple tests
that verify that the client-side peeloff works well with SELinux.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---

Note: Current kernels will fail these new tests due to a kernel bug.
Fix is coming shortly...

 tests/sctp/.gitignore            |   1 +
 tests/sctp/Makefile              |   3 +-
 tests/sctp/sctp_peeloff_client.c | 253 +++++++++++++++++++++++++++++++
 tests/sctp/test                  | 132 +++++++++++++++-
 4 files changed, 382 insertions(+), 7 deletions(-)
 create mode 100644 tests/sctp/sctp_peeloff_client.c

diff --git a/tests/sctp/.gitignore b/tests/sctp/.gitignore
index c022b11..58e8c53 100644
--- a/tests/sctp/.gitignore
+++ b/tests/sctp/.gitignore
@@ -4,5 +4,6 @@ sctp_bind
 sctp_bindx
 sctp_client
 sctp_connectx
+sctp_peeloff_client
 sctp_peeloff_server
 sctp_server
diff --git a/tests/sctp/Makefile b/tests/sctp/Makefile
index dd151fb..5e03650 100644
--- a/tests/sctp/Makefile
+++ b/tests/sctp/Makefile
@@ -1,5 +1,6 @@
 TARGETS = sctp_client sctp_server sctp_bind sctp_bindx sctp_connectx \
-	sctp_asconf_params_client sctp_asconf_params_server sctp_peeloff_server
+	sctp_asconf_params_client sctp_asconf_params_server \
+	sctp_peeloff_client sctp_peeloff_server
 
 DEPS = sctp_common.c sctp_common.h
 CFLAGS ?= -Wall
diff --git a/tests/sctp/sctp_peeloff_client.c b/tests/sctp/sctp_peeloff_client.c
new file mode 100644
index 0000000..2d42c72
--- /dev/null
+++ b/tests/sctp/sctp_peeloff_client.c
@@ -0,0 +1,253 @@
+#include "sctp_common.h"
+
+static void usage(char *progname)
+{
+	fprintf(stderr,
+		"usage:  %s [-e expected_msg] [-v] [-n] [-x] addr port\n"
+		"\nWhere:\n\t"
+
+		"-e      Optional expected message from server e.g. \"nopeer\".\n\t"
+		"        If not present the client context will be used as a\n\t"
+		"        comparison with the servers reply.\n\t"
+		"-n      Do NOT call connect(3) or connectx(3).\n\t"
+		"-v      Print context and ip options information.\n\t"
+		"-x      Use sctp_connectx(3) instead of connect(3).\n\t"
+		"addr    IPv4 or IPv6 address (e.g. 127.0.0.1 or ::1).\n\t"
+		"port    Port for accessing server.\n", progname);
+	exit(1);
+}
+
+int main(int argc, char **argv)
+{
+	int opt, sock, result, save_errno, peeloff_sk = 0, flags;
+	int on = 1, off = 0;
+	sctp_assoc_t assoc_id = 0;
+	socklen_t sinlen, opt_len;
+	struct sockaddr_storage sin;
+	struct addrinfo hints, *serverinfo;
+	char byte = 0x41, label[1024], *expected = NULL;
+	bool verbose = false, connectx = false, no_connects = false;
+	bool ipv4 = false, expect_ipopt = false;
+	char *context;
+	struct timeval tm;
+
+	while ((opt = getopt(argc, argv, "e:vxmni")) != -1) {
+		switch (opt) {
+		case 'e':
+			expected = optarg;
+			break;
+		case 'i':
+			expect_ipopt = true;
+			break;
+		case 'v':
+			verbose = true;
+			break;
+		case 'n':
+			no_connects = true;
+			break;
+		case 'x':
+			connectx = true;
+			break;
+		default:
+			usage(argv[0]);
+		}
+	}
+
+	if ((argc - optind) != 2)
+		usage(argv[0]);
+
+	memset(&hints, 0, sizeof(struct addrinfo));
+	hints.ai_protocol = IPPROTO_SCTP;
+	hints.ai_socktype = SOCK_SEQPACKET;
+	if (verbose) {
+		if (getcon(&context) < 0)
+			context = strdup("unavailable");
+		printf("Client process context: %s\n", context);
+		free(context);
+	}
+
+	result = getaddrinfo(argv[optind], argv[optind + 1], &hints,
+			     &serverinfo);
+	if (result < 0) {
+		fprintf(stderr, "Client getaddrinfo: %s\n",
+			gai_strerror(result));
+		exit(2);
+	}
+
+	if (serverinfo->ai_family == AF_INET)
+		ipv4 = true;
+
+	sock = socket(serverinfo->ai_family, serverinfo->ai_socktype,
+		      serverinfo->ai_protocol);
+	if (sock < 0) {
+		perror("Client socket");
+		exit(3);
+	}
+
+	/*
+	 * These timeouts are set to test whether the peer { recv } completes
+	 * or not when the permission is denied.
+	 */
+	tm.tv_sec = 4;
+	tm.tv_usec = 0;
+	result = setsockopt(sock, SOL_SOCKET, SO_SNDTIMEO, &tm, sizeof(tm));
+	if (result < 0) {
+		perror("Client setsockopt: SO_SNDTIMEO");
+		exit(4);
+	}
+
+	result = setsockopt(sock, SOL_SOCKET, SO_RCVTIMEO, &tm, sizeof(tm));
+	if (result < 0) {
+		perror("Client setsockopt: SO_RCVTIMEO");
+		exit(5);
+	}
+
+	/* Subscribe to assoc_id events */
+	result = set_subscr_events(sock, off, on, off, off);
+	if (result < 0) {
+		perror("Client setsockopt: SCTP_EVENTS");
+		close(sock);
+		exit(1);
+	}
+
+	if (!no_connects) {
+		if (connectx)
+			result = sctp_connectx(sock, serverinfo->ai_addr, 1, NULL);
+		else
+			result = connect(sock, serverinfo->ai_addr,
+					 serverinfo->ai_addrlen);
+		if (result < 0) {
+			save_errno = errno;
+			close(sock);
+			perror("Client connect");
+			switch (save_errno) {
+			case EINPROGRESS:
+				exit(6);
+				break;
+			case ENOSPC:
+				exit(7);
+				break;
+			case EACCES:
+				exit(8);
+				break;
+			default:
+				exit(9);
+			}
+		}
+		if (verbose) {
+			print_context(sock, "Client connect");
+			print_ip_option(sock, ipv4, "Client connect");
+		}
+	} else {
+		/* First send a message to get an association. */
+		result = sctp_sendmsg(sock, &byte, 1,
+				      serverinfo->ai_addr,
+				      serverinfo->ai_addrlen,
+				      0, 0, 0, 0, 0);
+		if (result < 0) {
+			perror("Client sctp_sendmsg");
+			close(sock);
+			exit(12);
+		}
+
+		if (verbose) {
+			print_context(sock, "Client SEQPACKET sctp_sendmsg");
+			print_ip_option(sock, ipv4,
+					"Client SEQPACKET sctp_sendmsg");
+		}
+	}
+
+	/* Get assoc_id for sctp_peeloff() */
+	flags = 0;
+	result = sctp_recvmsg(sock, label, sizeof(label),
+			      (struct sockaddr *)&sin, &sinlen,
+			      NULL, &flags);
+	if (result < 0) {
+		perror("Client sctp_recvmsg-1");
+		close(sock);
+		exit(1);
+	}
+
+	if ((flags & (MSG_NOTIFICATION | MSG_EOR)) != (MSG_NOTIFICATION | MSG_EOR)) {
+		printf("Invalid sctp_recvmsg response FLAGS: %x\n", flags);
+		close(sock);
+		exit(1);
+	}
+	handle_event(label, NULL, &assoc_id, verbose, "Peeloff Client");
+	if (assoc_id <= 0) {
+		printf("Client Invalid association ID: %d\n", assoc_id);
+		close(sock);
+		exit(1);
+	}
+	/* No more notifications */
+	result = set_subscr_events(sock, off, off, off, off);
+	if (result < 0) {
+		perror("Client setsockopt: SCTP_EVENTS");
+		close(sock);
+		exit(1);
+	}
+
+	peeloff_sk = sctp_peeloff(sock, assoc_id);
+	if (peeloff_sk < 0) {
+		perror("Client sctp_peeloff");
+		close(sock);
+		exit(1);
+	}
+	if (verbose) {
+		printf("Client sctp_peeloff(3) on sk: %d with association ID: %d\n",
+		       peeloff_sk, assoc_id);
+		print_context(peeloff_sk, "Client PEELOFF");
+	}
+
+	if (!no_connects) {
+		result = sctp_sendmsg(peeloff_sk, &byte, 1,
+				      (struct sockaddr *)&sin, sinlen,
+				      0, 0, 0, 0, 0);
+		if (result < 0) {
+			perror("Client sctp_sendmsg");
+			close(peeloff_sk);
+			close(sock);
+			exit(12);
+		}
+
+		if (verbose) {
+			print_context(peeloff_sk,
+				      "Client SEQPACKET peeloff sctp_sendmsg");
+			print_ip_option(peeloff_sk, ipv4,
+					"Client SEQPACKET peeloff sctp_sendmsg");
+		}
+	}
+
+	result = sctp_recvmsg(peeloff_sk, label, sizeof(label),
+			      NULL, 0, NULL, NULL);
+	if (result < 0) {
+		perror("Client sctp_recvmsg");
+		close(peeloff_sk);
+		close(sock);
+		exit(13);
+	}
+	if (expect_ipopt)
+		expected = get_ip_option(peeloff_sk, ipv4, &opt_len);
+
+	label[result] = 0;
+	close(peeloff_sk);
+	close(sock);
+
+	if (!expected && !expect_ipopt) {
+		result = getcon(&expected);
+		if (result < 0) {
+			perror("Client getcon");
+			exit(14);
+		}
+	}
+
+	if (strcmp(expected, label)) {
+		fprintf(stderr, "Client expected %s, got %s\n",
+			expected, label);
+		exit(15);
+	} else if (verbose) {
+		printf("Client received %s\n", label);
+	}
+
+	exit(0);
+}
diff --git a/tests/sctp/test b/tests/sctp/test
index 1170921..bf7c30e 100755
--- a/tests/sctp/test
+++ b/tests/sctp/test
@@ -33,7 +33,7 @@ BEGIN {
         plan skip_all => "SCTP not supported";
     }
     else {
-        $test_count = 75;
+        $test_count = 93;
 
         # Set up a GRE tunnel over loopback to ensure we have enough addresses
         # for the ASCONF tests.
@@ -70,7 +70,7 @@ BEGIN {
 
         $rc = `$basedir/../kvercmp $kvercur $kvermincalipso`;
         if ( $netlabelctl gt "021" && $rc > 0 ) {
-            $test_count += 13;
+            $test_count += 19;
             $test_calipso = 1;
         }
 
@@ -419,6 +419,21 @@ $result = system
 "runcon -t test_sctp_client_t -l s0:c182.c193 -- $basedir/sctp_client $v stream 127.0.0.1 1035 2>&1";
 ok( $result >> 8 eq 6 );
 
+# Verify that authorized client can communicate with the server peeloff->SEQ->STREAM with client using connect(2).
+$result = system
+"runcon -t test_sctp_client_t -l s0:c182.c192 $basedir/sctp_peeloff_client $v -i 127.0.0.1 1035";
+ok( $result eq 0 );
+
+# Verify that authorized client can communicate with the server peeloff->SEQ->STREAM with client using sctp_connectx(3).
+$result = system
+"runcon -t test_sctp_client_t -l s0:c182.c192 $basedir/sctp_peeloff_client $v -x -i 127.0.0.1 1035";
+ok( $result eq 0 );
+
+# Verify that authorized client can communicate with the server peeloff->SEQ->STREAM with no client connect(2).
+$result = system
+"runcon -t test_sctp_client_t -l s0:c182.c192 $basedir/sctp_peeloff_client $v -n -i 127.0.0.1 1035";
+ok( $result eq 0 );
+
 # Kill the stream server.
 server_end($pid);
 
@@ -454,12 +469,27 @@ $result = system
 "runcon -t test_sctp_client_t -l s0:c20.c300 -- $basedir/sctp_client $v -i seq 127.0.0.1 1035 2>&1";
 ok( $result >> 8 eq 7 );
 
+# Verify that authorized client can communicate with the server peeloff->SEQ->SEQ with client using connect(2).
+$result = system
+"runcon -t test_sctp_client_t -l s0:c20.c30 $basedir/sctp_peeloff_client $v -i 127.0.0.1 1035";
+ok( $result eq 0 );
+
+# Verify that authorized client can communicate with the server peeloff->SEQ->SEQ with client using sctp_connectx(3).
+$result = system
+"runcon -t test_sctp_client_t -l s0:c20.c30 $basedir/sctp_peeloff_client $v -x -i 127.0.0.1 1035";
+ok( $result eq 0 );
+
+# Verify that authorized client can communicate with the server peeloff->SEQ->SEQ with no client connect(2).
+$result = system
+"runcon -t test_sctp_client_t -l s0:c20.c30 $basedir/sctp_peeloff_client $v -n -i 127.0.0.1 1035";
+ok( $result eq 0 );
+
 # Kill server.
 server_end($pid);
 
 print "# Testing CIPSO/IPv4 - TAG 1 PEELOFF using socket ip_option data\n";
 
-# Test sctp_peeloff(3) using 1 to Many SOCK_SEQPACKET
+# Test sctp_peeloff(3) server using 1 to Many SOCK_SEQPACKET
 $pid = server_start(
     "-t test_sctp_server_t -l s0:c0.c10",
     "sctp_peeloff_server",
@@ -522,6 +552,21 @@ $result = system
 "runcon -t test_sctp_client_t -l s0:c1023 -- $basedir/sctp_client $v stream 127.0.0.1 1035 2>&1";
 ok( $result >> 8 eq 6 );
 
+# Verify that authorized client can communicate with the server peeloff->SEQ->STREAM with client using connect(2).
+$result = system
+"runcon -t test_sctp_client_t -l s0:c782,c714,c769,c788,c803,c842,c864 $basedir/sctp_peeloff_client $v -i 127.0.0.1 1035";
+ok( $result eq 0 );
+
+# Verify that authorized client can communicate with the server peeloff->SEQ->STREAM with client using sctp_connectx(3).
+$result = system
+"runcon -t test_sctp_client_t -l s0:c782,c714,c769,c788,c803,c842,c864 $basedir/sctp_peeloff_client $v -x -i 127.0.0.1 1035";
+ok( $result eq 0 );
+
+# Verify that authorized client can communicate with the server peeloff->SEQ->STREAM with no client connect(2).
+$result = system
+"runcon -t test_sctp_client_t -l s0:c782,c714,c769,c788,c803,c842,c864 $basedir/sctp_peeloff_client $v -n -i 127.0.0.1 1035";
+ok( $result eq 0 );
+
 # Kill the stream server.
 server_end($pid);
 
@@ -557,12 +602,27 @@ $result = system
 "runcon -t test_sctp_client_t -l s0:c200.c216 -- $basedir/sctp_client $v -i seq 127.0.0.1 1035 2>&1";
 ok( $result >> 8 eq 7 );
 
+# Verify that authorized client can communicate with the server peeloff->SEQ->SEQ with client using connect(2).
+$result = system
+"runcon -t test_sctp_client_t -l s0:c20.c30 $basedir/sctp_peeloff_client $v -i 127.0.0.1 1035";
+ok( $result eq 0 );
+
+# Verify that authorized client can communicate with the server peeloff->SEQ->SEQ with client using sctp_connectx(3).
+$result = system
+"runcon -t test_sctp_client_t -l s0:c20.c30 $basedir/sctp_peeloff_client $v -x -i 127.0.0.1 1035";
+ok( $result eq 0 );
+
+# Verify that authorized client can communicate with the server peeloff->SEQ->SEQ with no client connect(2).
+$result = system
+"runcon -t test_sctp_client_t -l s0:c20.c30 $basedir/sctp_peeloff_client $v -n -i 127.0.0.1 1035";
+ok( $result eq 0 );
+
 # Kill server.
 server_end($pid);
 
 print "# Testing CIPSO/IPv4 - TAG 2 PEELOFF using socket ip_option data\n";
 
-# Test sctp_peeloff(3) using 1 to Many SOCK_SEQPACKET
+# Test sctp_peeloff(3) server using 1 to Many SOCK_SEQPACKET
 $pid = server_start(
     "-t test_sctp_server_t -l s0:c0.c10",
     "sctp_peeloff_server",
@@ -625,6 +685,21 @@ $result = system
 "runcon -t test_sctp_client_t -l s0:c1023 -- $basedir/sctp_client $v stream 127.0.0.1 1035 2>&1";
 ok( $result >> 8 eq 6 );
 
+# Verify that authorized client can communicate with the server peeloff->SEQ->STREAM with client using connect(2).
+$result = system
+"runcon -t test_sctp_client_t -l s0:c782,c714,c769,c788,c803,c842,c864 $basedir/sctp_peeloff_client $v -i 127.0.0.1 1035";
+ok( $result eq 0 );
+
+# Verify that authorized client can communicate with the server peeloff->SEQ->STREAM with client using sctp_connectx(3).
+$result = system
+"runcon -t test_sctp_client_t -l s0:c782,c714,c769,c788,c803,c842,c864 $basedir/sctp_peeloff_client $v -x -i 127.0.0.1 1035";
+ok( $result eq 0 );
+
+# Verify that authorized client can communicate with the server peeloff->SEQ->STREAM with no client connect(2).
+$result = system
+"runcon -t test_sctp_client_t -l s0:c782,c714,c769,c788,c803,c842,c864 $basedir/sctp_peeloff_client $v -n -i 127.0.0.1 1035";
+ok( $result eq 0 );
+
 # Kill the stream server.
 server_end($pid);
 
@@ -660,12 +735,27 @@ $result = system
 "runcon -t test_sctp_client_t -l s0:c20,c22,c24,c30.c33,c38,c42.c45,c48,c50 -- $basedir/sctp_client $v -i seq 127.0.0.1 1035 2>&1";
 ok( $result >> 8 eq 7 );
 
+# Verify that authorized client can communicate with the server peeloff->SEQ->SEQ with client using connect(2).
+$result = system
+"runcon -t test_sctp_client_t -l s0:c20.c50 $basedir/sctp_peeloff_client $v -i 127.0.0.1 1035";
+ok( $result eq 0 );
+
+# Verify that authorized client can communicate with the server peeloff->SEQ->SEQ with client using sctp_connectx(3).
+$result = system
+"runcon -t test_sctp_client_t -l s0:c20.c50 $basedir/sctp_peeloff_client $v -x -i 127.0.0.1 1035";
+ok( $result eq 0 );
+
+# Verify that authorized client can communicate with the server peeloff->SEQ->SEQ with no client connect(2).
+$result = system
+"runcon -t test_sctp_client_t -l s0:c20.c50 $basedir/sctp_peeloff_client $v -n -i 127.0.0.1 1035";
+ok( $result eq 0 );
+
 # Kill server.
 server_end($pid);
 
 print "# Testing CIPSO/IPv4 - TAG 5 PEELOFF using socket ip_option data\n";
 
-# Test sctp_peeloff(3) using 1 to Many SOCK_SEQPACKET
+# Test sctp_peeloff(3) server using 1 to Many SOCK_SEQPACKET
 $pid = server_start(
     "-t test_sctp_server_t -l s0:c0.c10",
     "sctp_peeloff_server",
@@ -775,6 +865,21 @@ if ($test_calipso) {
 "runcon -t test_sctp_client_t -l s0:c8.c12 -- $basedir/sctp_client $v -i stream ::1 1035 2>&1";
     ok( $result >> 8 eq 6 );
 
+# Verify that authorized client can communicate with the server peeloff->SEQ->STREAM with client using connect(2).
+    $result = system
+"runcon -t test_sctp_client_t -l s0:c0,c12,c24,c36,c28,c610,c712,c414,c516,c318,c820,c622,c924,c726,c128,c330,c832,c534,c936,c138,c740,c42,c44,c246,c648,c950,c152,c354,c856,c158,c960,c662,c634,c686,c368,c570,c782,c714,c769,c788,c803,c842,c864,c986,c788,c290,c392,c594,c896,c698,c1023 $basedir/sctp_peeloff_client $v -i ::1 1035";
+    ok( $result eq 0 );
+
+# Verify that authorized client can communicate with the server peeloff->SEQ->STREAM with client using sctp_connectx(3).
+    $result = system
+"runcon -t test_sctp_client_t -l s0:c0,c12,c24,c36,c28,c610,c712,c414,c516,c318,c820,c622,c924,c726,c128,c330,c832,c534,c936,c138,c740,c42,c44,c246,c648,c950,c152,c354,c856,c158,c960,c662,c634,c686,c368,c570,c782,c714,c769,c788,c803,c842,c864,c986,c788,c290,c392,c594,c896,c698,c1023 $basedir/sctp_peeloff_client $v -x -i ::1 1035";
+    ok( $result eq 0 );
+
+# Verify that authorized client can communicate with the server peeloff->SEQ->STREAM with no client connect(2).
+    $result = system
+"runcon -t test_sctp_client_t -l s0:c0,c12,c24,c36,c28,c610,c712,c414,c516,c318,c820,c622,c924,c726,c128,c330,c832,c534,c936,c138,c740,c42,c44,c246,c648,c950,c152,c354,c856,c158,c960,c662,c634,c686,c368,c570,c782,c714,c769,c788,c803,c842,c864,c986,c788,c290,c392,c594,c896,c698,c1023 $basedir/sctp_peeloff_client $v -n -i ::1 1035";
+    ok( $result eq 0 );
+
     # Kill the stream server.
     server_end($pid);
 
@@ -810,12 +915,27 @@ if ($test_calipso) {
 "runcon -t test_sctp_client_t -l s0:c19.c50 -- $basedir/sctp_client $v -i seq ::1 1035 2>&1";
     ok( $result >> 8 eq 6 );
 
+# Verify that authorized client can communicate with the server peeloff->SEQ->SEQ with client using connect(2).
+    $result = system
+"runcon -t test_sctp_client_t -l s0:c20.c50 $basedir/sctp_peeloff_client $v -i ::1 1035";
+    ok( $result eq 0 );
+
+# Verify that authorized client can communicate with the server peeloff->SEQ->SEQ with client using sctp_connectx(3).
+    $result = system
+"runcon -t test_sctp_client_t -l s0:c20.c50 $basedir/sctp_peeloff_client $v -x -i ::1 1035";
+    ok( $result eq 0 );
+
+# Verify that authorized client can communicate with the server peeloff->SEQ->SEQ with no client connect(2).
+    $result = system
+"runcon -t test_sctp_client_t -l s0:c20.c50 $basedir/sctp_peeloff_client $v -n -i ::1 1035";
+    ok( $result eq 0 );
+
     # Kill server.
     server_end($pid);
 
     print "# Testing CALIPSO/IPv6 PEELOFF using socket ip_option data\n";
 
-    # Test sctp_peeloff(3) using 1 to Many SOCK_SEQPACKET
+    # Test sctp_peeloff(3) server using 1 to Many SOCK_SEQPACKET
     $pid = server_start(
         "-t test_sctp_server_t -l s0:c0.c10",
         "sctp_peeloff_server",
-- 
2.31.1

