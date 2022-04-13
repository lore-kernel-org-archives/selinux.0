Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE99C433F5
	for <selinux@archiver.kernel.org>; Wed, 13 Apr 2022 11:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbiDMLuD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Apr 2022 07:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiDMLuC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Apr 2022 07:50:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6B4435AEE3
        for <selinux@vger.kernel.org>; Wed, 13 Apr 2022 04:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649850459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=fgZ9OdKDXtKKsvrNIcCBLJQpnsSPahWPFPmgioMC17I=;
        b=fAxW8dUVl9LVtvaOrWNdWeL9lqRYXgwtDO/NaPIQFUTd6ofEoclj7FewciZQ6gM9XGJeM1
        iOuJdn7IWAzWELbc11GWYbQiRjrO2TnZp7wH/gLhl3fPef0EEM91alHrcylBeQ1spjefdk
        ybbGFsri340DVtOkT70lIvZzlAxi/uU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-14-ExvHz644O5yU0an9iWEwVQ-1; Wed, 13 Apr 2022 07:47:38 -0400
X-MC-Unique: ExvHz644O5yU0an9iWEwVQ-1
Received: by mail-wr1-f71.google.com with SMTP id 105-20020adf82f2000000b002079aba50b9so291345wrc.18
        for <selinux@vger.kernel.org>; Wed, 13 Apr 2022 04:47:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fgZ9OdKDXtKKsvrNIcCBLJQpnsSPahWPFPmgioMC17I=;
        b=k07zT5MPbgLUgH1fG5GBvrLJHFGS7bXv8H37uTTV2mKPXw4yCJOQlAcTlmhXTFMzRW
         NzFlsdxt0GlS8u0Pik0hZu5LP2N4YXX7Jv+2sVYvPz5zflJZhp/RL4pe5K3fe38ScQjm
         A8HugvHkq+AMHIIaqJPD84eIK6wXRT+luubkC0WBO9pKDPeLZH66iidnrt88Df8cMB6p
         VSZU4vVFbI8pnfwwiZL7iU/f7hOFi5CsEJlOkX8ggsi5GGa4C1clwwOjCBy7pbvkEocv
         4AKlC0tv7s0Nzoitx/4zYzoWccGTy8OJuT4Y5v4BjWMiei+v7g9THY9R9j98QGJrh9rF
         Iuvw==
X-Gm-Message-State: AOAM5332R9aDL+3BWtdsLiJJVHo8zc3Uz/7BXb2XFNHFLu7YQ4v2l55x
        ZLBylDewH/Onpwh7+r7TZrRpcWrpacT4oYX1qCxx1fhyb4q5DAlDlMqt1+bds7YGyivNPkIQy1O
        xRkyJD+OaQKML+QvJhLo8+5YfbuMyYt//L9iQrMx9Zm/HgVI6ErBO/XXvObPlJQzaJQ64rg==
X-Received: by 2002:adf:fad2:0:b0:207:9d7e:174 with SMTP id a18-20020adffad2000000b002079d7e0174mr17093042wrs.265.1649850456330;
        Wed, 13 Apr 2022 04:47:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzpRtG9LQnZLsS6jjkFEO3GZAWcttia1ISz5S9kI+DJzD1sG2/ZJgPPtwAHe7OVHKfOrb/dmw==
X-Received: by 2002:adf:fad2:0:b0:207:9d7e:174 with SMTP id a18-20020adffad2000000b002079d7e0174mr17093007wrs.265.1649850455607;
        Wed, 13 Apr 2022 04:47:35 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b106:e300:32b0:6ebb:8ca4:d4d3])
        by smtp.gmail.com with ESMTPSA id h9-20020a05600c350900b0038cbcbcf994sm2476967wmq.36.2022.04.13.04.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 04:47:34 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH testsuite v4] tests/sctp: add client peeloff tests
Date:   Wed, 13 Apr 2022 13:47:34 +0200
Message-Id: <20220413114734.1704750-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.35.1
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

The new tests are enabled on kernels 5.18+, where the fixes were
introduced. While the fixes are now queued also for some stable streams,
it's much simpler to just check the version against 5.18 and skip the
test for all older kernels.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---

v4: added a kernel version check
v3: fixed uninitialized "sinlen" variable in sctp_peeloff_client.c
v2: rebased and resolved a conflict

 tests/sctp/.gitignore            |   1 +
 tests/sctp/Makefile              |   3 +-
 tests/sctp/sctp_peeloff_client.c | 254 +++++++++++++++++++++++++++++++
 tests/sctp/test                  | 170 ++++++++++++++++++++-
 4 files changed, 419 insertions(+), 9 deletions(-)
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
index 0000000..bc719a5
--- /dev/null
+++ b/tests/sctp/sctp_peeloff_client.c
@@ -0,0 +1,254 @@
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
+	sinlen = sizeof(sin);
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
index 0f017e8..cb5dfc9 100755
--- a/tests/sctp/test
+++ b/tests/sctp/test
@@ -44,6 +44,7 @@ BEGIN {
         # asconf parameter tests require two local non-loopback addresses.
         $ipaddress_list = `ip -o addr show up scope global`;
         $test_asconf    = 0;
+        $test_clpeeloff = 0;
         $count          = 0;
         $ipaddress[0]   = 0;
         $ipaddress[1]   = 0;
@@ -60,17 +61,26 @@ BEGIN {
             $test_asconf = 1;
         }
 
+        # SCTP client peeloff has been fixed in kernel 5.18+
+        $kvercur = `uname -r`;
+        chomp($kvercur);
+
+        if ( `$basedir/../kvercmp $kvercur 5.18` > 0 ) {
+            $test_clpeeloff = 1;
+            $test_count += 18;
+        }
+
         # Determine if CALIPSO supported by netlabelctl(8) and kernel.
         $test_calipso = 0;
         $netlabelctl  = `netlabelctl -V`;
         $netlabelctl =~ s/\D//g;
-        $kvercur = `uname -r`;
-        chomp($kvercur);
-        $kvermincalipso = "4.8";
 
-        $rc = `$basedir/../kvercmp $kvercur $kvermincalipso`;
+        $rc = `$basedir/../kvercmp $kvercur 4.8`;
         if ( $netlabelctl gt "021" && $rc > 0 ) {
             $test_count += 13;
+            if ($test_clpeeloff) {
+                $test_count += 6;
+            }
             $test_calipso = 1;
         }
 
@@ -428,6 +438,24 @@ $result = system
 "runcon -t test_sctp_client_t -l s0:c182.c193 -- $basedir/sctp_client $v stream 127.0.0.1 1035 2>&1";
 ok( $result >> 8 eq 6 );
 
+if ($test_clpeeloff) {
+
+# Verify that authorized client can communicate with the server peeloff->SEQ->STREAM with client using connect(2).
+    $result = system
+"runcon -t test_sctp_client_t -l s0:c182.c192 $basedir/sctp_peeloff_client $v -i 127.0.0.1 1035";
+    ok( $result eq 0 );
+
+# Verify that authorized client can communicate with the server peeloff->SEQ->STREAM with client using sctp_connectx(3).
+    $result = system
+"runcon -t test_sctp_client_t -l s0:c182.c192 $basedir/sctp_peeloff_client $v -x -i 127.0.0.1 1035";
+    ok( $result eq 0 );
+
+# Verify that authorized client can communicate with the server peeloff->SEQ->STREAM with no client connect(2).
+    $result = system
+"runcon -t test_sctp_client_t -l s0:c182.c192 $basedir/sctp_peeloff_client $v -n -i 127.0.0.1 1035";
+    ok( $result eq 0 );
+}
+
 # Kill the stream server.
 server_end($pid);
 
@@ -463,12 +491,30 @@ $result = system
 "runcon -t test_sctp_client_t -l s0:c20.c300 -- $basedir/sctp_client $v -i seq 127.0.0.1 1035 2>&1";
 ok( $result >> 8 eq 7 );
 
+if ($test_clpeeloff) {
+
+# Verify that authorized client can communicate with the server peeloff->SEQ->SEQ with client using connect(2).
+    $result = system
+"runcon -t test_sctp_client_t -l s0:c20.c30 $basedir/sctp_peeloff_client $v -i 127.0.0.1 1035";
+    ok( $result eq 0 );
+
+# Verify that authorized client can communicate with the server peeloff->SEQ->SEQ with client using sctp_connectx(3).
+    $result = system
+"runcon -t test_sctp_client_t -l s0:c20.c30 $basedir/sctp_peeloff_client $v -x -i 127.0.0.1 1035";
+    ok( $result eq 0 );
+
+# Verify that authorized client can communicate with the server peeloff->SEQ->SEQ with no client connect(2).
+    $result = system
+"runcon -t test_sctp_client_t -l s0:c20.c30 $basedir/sctp_peeloff_client $v -n -i 127.0.0.1 1035";
+    ok( $result eq 0 );
+}
+
 # Kill server.
 server_end($pid);
 
 print "# Testing CIPSO/IPv4 - TAG 1 PEELOFF using socket ip_option data\n";
 
-# Test sctp_peeloff(3) using 1 to Many SOCK_SEQPACKET
+# Test sctp_peeloff(3) server using 1 to Many SOCK_SEQPACKET
 $pid = server_start(
     "-t test_sctp_server_t -l s0:c0.c10",
     "sctp_peeloff_server",
@@ -531,6 +577,24 @@ $result = system
 "runcon -t test_sctp_client_t -l s0:c1023 -- $basedir/sctp_client $v stream 127.0.0.1 1035 2>&1";
 ok( $result >> 8 eq 6 );
 
+if ($test_clpeeloff) {
+
+# Verify that authorized client can communicate with the server peeloff->SEQ->STREAM with client using connect(2).
+    $result = system
+"runcon -t test_sctp_client_t -l s0:c782,c714,c769,c788,c803,c842,c864 $basedir/sctp_peeloff_client $v -i 127.0.0.1 1035";
+    ok( $result eq 0 );
+
+# Verify that authorized client can communicate with the server peeloff->SEQ->STREAM with client using sctp_connectx(3).
+    $result = system
+"runcon -t test_sctp_client_t -l s0:c782,c714,c769,c788,c803,c842,c864 $basedir/sctp_peeloff_client $v -x -i 127.0.0.1 1035";
+    ok( $result eq 0 );
+
+# Verify that authorized client can communicate with the server peeloff->SEQ->STREAM with no client connect(2).
+    $result = system
+"runcon -t test_sctp_client_t -l s0:c782,c714,c769,c788,c803,c842,c864 $basedir/sctp_peeloff_client $v -n -i 127.0.0.1 1035";
+    ok( $result eq 0 );
+}
+
 # Kill the stream server.
 server_end($pid);
 
@@ -566,12 +630,30 @@ $result = system
 "runcon -t test_sctp_client_t -l s0:c200.c216 -- $basedir/sctp_client $v -i seq 127.0.0.1 1035 2>&1";
 ok( $result >> 8 eq 7 );
 
+if ($test_clpeeloff) {
+
+# Verify that authorized client can communicate with the server peeloff->SEQ->SEQ with client using connect(2).
+    $result = system
+"runcon -t test_sctp_client_t -l s0:c20.c30 $basedir/sctp_peeloff_client $v -i 127.0.0.1 1035";
+    ok( $result eq 0 );
+
+# Verify that authorized client can communicate with the server peeloff->SEQ->SEQ with client using sctp_connectx(3).
+    $result = system
+"runcon -t test_sctp_client_t -l s0:c20.c30 $basedir/sctp_peeloff_client $v -x -i 127.0.0.1 1035";
+    ok( $result eq 0 );
+
+# Verify that authorized client can communicate with the server peeloff->SEQ->SEQ with no client connect(2).
+    $result = system
+"runcon -t test_sctp_client_t -l s0:c20.c30 $basedir/sctp_peeloff_client $v -n -i 127.0.0.1 1035";
+    ok( $result eq 0 );
+}
+
 # Kill server.
 server_end($pid);
 
 print "# Testing CIPSO/IPv4 - TAG 2 PEELOFF using socket ip_option data\n";
 
-# Test sctp_peeloff(3) using 1 to Many SOCK_SEQPACKET
+# Test sctp_peeloff(3) server using 1 to Many SOCK_SEQPACKET
 $pid = server_start(
     "-t test_sctp_server_t -l s0:c0.c10",
     "sctp_peeloff_server",
@@ -634,6 +716,24 @@ $result = system
 "runcon -t test_sctp_client_t -l s0:c1023 -- $basedir/sctp_client $v stream 127.0.0.1 1035 2>&1";
 ok( $result >> 8 eq 6 );
 
+if ($test_clpeeloff) {
+
+# Verify that authorized client can communicate with the server peeloff->SEQ->STREAM with client using connect(2).
+    $result = system
+"runcon -t test_sctp_client_t -l s0:c782,c714,c769,c788,c803,c842,c864 $basedir/sctp_peeloff_client $v -i 127.0.0.1 1035";
+    ok( $result eq 0 );
+
+# Verify that authorized client can communicate with the server peeloff->SEQ->STREAM with client using sctp_connectx(3).
+    $result = system
+"runcon -t test_sctp_client_t -l s0:c782,c714,c769,c788,c803,c842,c864 $basedir/sctp_peeloff_client $v -x -i 127.0.0.1 1035";
+    ok( $result eq 0 );
+
+# Verify that authorized client can communicate with the server peeloff->SEQ->STREAM with no client connect(2).
+    $result = system
+"runcon -t test_sctp_client_t -l s0:c782,c714,c769,c788,c803,c842,c864 $basedir/sctp_peeloff_client $v -n -i 127.0.0.1 1035";
+    ok( $result eq 0 );
+}
+
 # Kill the stream server.
 server_end($pid);
 
@@ -669,12 +769,30 @@ $result = system
 "runcon -t test_sctp_client_t -l s0:c20,c22,c24,c30.c33,c38,c42.c45,c48,c50 -- $basedir/sctp_client $v -i seq 127.0.0.1 1035 2>&1";
 ok( $result >> 8 eq 7 );
 
+if ($test_clpeeloff) {
+
+# Verify that authorized client can communicate with the server peeloff->SEQ->SEQ with client using connect(2).
+    $result = system
+"runcon -t test_sctp_client_t -l s0:c20.c50 $basedir/sctp_peeloff_client $v -i 127.0.0.1 1035";
+    ok( $result eq 0 );
+
+# Verify that authorized client can communicate with the server peeloff->SEQ->SEQ with client using sctp_connectx(3).
+    $result = system
+"runcon -t test_sctp_client_t -l s0:c20.c50 $basedir/sctp_peeloff_client $v -x -i 127.0.0.1 1035";
+    ok( $result eq 0 );
+
+# Verify that authorized client can communicate with the server peeloff->SEQ->SEQ with no client connect(2).
+    $result = system
+"runcon -t test_sctp_client_t -l s0:c20.c50 $basedir/sctp_peeloff_client $v -n -i 127.0.0.1 1035";
+    ok( $result eq 0 );
+}
+
 # Kill server.
 server_end($pid);
 
 print "# Testing CIPSO/IPv4 - TAG 5 PEELOFF using socket ip_option data\n";
 
-# Test sctp_peeloff(3) using 1 to Many SOCK_SEQPACKET
+# Test sctp_peeloff(3) server using 1 to Many SOCK_SEQPACKET
 $pid = server_start(
     "-t test_sctp_server_t -l s0:c0.c10",
     "sctp_peeloff_server",
@@ -784,6 +902,24 @@ if ($test_calipso) {
 "runcon -t test_sctp_client_t -l s0:c8.c12 -- $basedir/sctp_client $v -i stream ::1 1035 2>&1";
     ok( $result >> 8 eq 6 );
 
+    if ($test_clpeeloff) {
+
+# Verify that authorized client can communicate with the server peeloff->SEQ->STREAM with client using connect(2).
+        $result = system
+"runcon -t test_sctp_client_t -l s0:c0,c12,c24,c36,c28,c610,c712,c414,c516,c318,c820,c622,c924,c726,c128,c330,c832,c534,c936,c138,c740,c42,c44,c246,c648,c950,c152,c354,c856,c158,c960,c662,c634,c686,c368,c570,c782,c714,c769,c788,c803,c842,c864,c986,c788,c290,c392,c594,c896,c698,c1023 $basedir/sctp_peeloff_client $v -i ::1 1035";
+        ok( $result eq 0 );
+
+# Verify that authorized client can communicate with the server peeloff->SEQ->STREAM with client using sctp_connectx(3).
+        $result = system
+"runcon -t test_sctp_client_t -l s0:c0,c12,c24,c36,c28,c610,c712,c414,c516,c318,c820,c622,c924,c726,c128,c330,c832,c534,c936,c138,c740,c42,c44,c246,c648,c950,c152,c354,c856,c158,c960,c662,c634,c686,c368,c570,c782,c714,c769,c788,c803,c842,c864,c986,c788,c290,c392,c594,c896,c698,c1023 $basedir/sctp_peeloff_client $v -x -i ::1 1035";
+        ok( $result eq 0 );
+
+# Verify that authorized client can communicate with the server peeloff->SEQ->STREAM with no client connect(2).
+        $result = system
+"runcon -t test_sctp_client_t -l s0:c0,c12,c24,c36,c28,c610,c712,c414,c516,c318,c820,c622,c924,c726,c128,c330,c832,c534,c936,c138,c740,c42,c44,c246,c648,c950,c152,c354,c856,c158,c960,c662,c634,c686,c368,c570,c782,c714,c769,c788,c803,c842,c864,c986,c788,c290,c392,c594,c896,c698,c1023 $basedir/sctp_peeloff_client $v -n -i ::1 1035";
+        ok( $result eq 0 );
+    }
+
     # Kill the stream server.
     server_end($pid);
 
@@ -819,12 +955,30 @@ if ($test_calipso) {
 "runcon -t test_sctp_client_t -l s0:c19.c50 -- $basedir/sctp_client $v -i seq ::1 1035 2>&1";
     ok( $result >> 8 eq 6 );
 
+    if ($test_clpeeloff) {
+
+# Verify that authorized client can communicate with the server peeloff->SEQ->SEQ with client using connect(2).
+        $result = system
+"runcon -t test_sctp_client_t -l s0:c20.c50 $basedir/sctp_peeloff_client $v -i ::1 1035";
+        ok( $result eq 0 );
+
+# Verify that authorized client can communicate with the server peeloff->SEQ->SEQ with client using sctp_connectx(3).
+        $result = system
+"runcon -t test_sctp_client_t -l s0:c20.c50 $basedir/sctp_peeloff_client $v -x -i ::1 1035";
+        ok( $result eq 0 );
+
+# Verify that authorized client can communicate with the server peeloff->SEQ->SEQ with no client connect(2).
+        $result = system
+"runcon -t test_sctp_client_t -l s0:c20.c50 $basedir/sctp_peeloff_client $v -n -i ::1 1035";
+        ok( $result eq 0 );
+    }
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
2.35.1

