Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A4FEB64D9
	for <selinux@archiver.kernel.org>; Mon, 19 Jun 2023 08:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjFSIvF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 19 Jun 2023 04:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjFSIuc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 19 Jun 2023 04:50:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E38197
        for <selinux@vger.kernel.org>; Mon, 19 Jun 2023 01:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687164497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=b2JRcbIXudSSCqIMZzmYk1ek3lqIy1U3fO3EfNdwUTc=;
        b=OtmmwFbn9kHMeFSGW3y47Pl1WAzwGTV+bxiqos4MkmW2dKXLvhY6BC+yHhbKWTY4fsDdCE
        cp0gaMadDW7RCCN/pPn1sHEepBcJDrBa/2w1Cy3QlDoDmkOUGCmqDvxVicynee73j14Umh
        EV0cQA5uKJv6ct/VDqJX4XGfeqUPXaU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-zPg2ECwVMFuZ0UaFLtgGpQ-1; Mon, 19 Jun 2023 04:48:15 -0400
X-MC-Unique: zPg2ECwVMFuZ0UaFLtgGpQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3111a458cfbso1257371f8f.2
        for <selinux@vger.kernel.org>; Mon, 19 Jun 2023 01:48:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687164494; x=1689756494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b2JRcbIXudSSCqIMZzmYk1ek3lqIy1U3fO3EfNdwUTc=;
        b=G19jF9BFuvndvfyvh2kXT5RdvUl2XrudbPKqD2s8la3vMLt+91yWXamVVq4b4RSRwD
         M+oOFKylE7ggX075JlBHb2QtI0R9npBEduRSZWHVVtxcB1oAWWogAqThyhCtoMCZBzIY
         FR6dKj3qTlS0reb+2nDXQAvnfV/iZSJ5Sca7ElUhEwr1NUTRd0grN0omI2/tc1gSMEcn
         9+4w/npRHVUo3Ou7d3TMW6pUKmzFp3SANy0nUgD++OqZyK1kS1vypuEpoHFLLXudxkeP
         F9Qf50DrDo5s3Kbc4e594DQf6HmhvaLqC9sxqLSTJEmCR01JH48g80dYr7dTO3idzkb+
         I1zQ==
X-Gm-Message-State: AC+VfDzloopMdqyOcHvG3bzILbkiYmRVui+VVuUA2Tu9sIsrF2jGGdY9
        URmyWbFw53KoMbyshyWhcRK32hyd8VZwx9dydj9GzaVOWcYYHhpgLTEJhzexr8wQXYtxIquI34W
        t0j5uVGjuWqxWoWs2hWpGJrlGmDB3J79nYaArQllTfkHfkmM3WtSGxjLT0pGI7M0QJsLRbIDNw6
        FiOTpB
X-Received: by 2002:adf:e447:0:b0:311:1c14:3e43 with SMTP id t7-20020adfe447000000b003111c143e43mr7158640wrm.20.1687164492971;
        Mon, 19 Jun 2023 01:48:12 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5q6KG+rx+uaNM8GEr4gvy7gunVO2FxR2oyf3IhZSt91KBRnzdHJdx7e73pvulv/gAxnlSadw==
X-Received: by 2002:adf:e447:0:b0:311:1c14:3e43 with SMTP id t7-20020adfe447000000b003111c143e43mr7158603wrm.20.1687164491744;
        Mon, 19 Jun 2023 01:48:11 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id t9-20020a5d6a49000000b003113ed02080sm2375112wrw.95.2023.06.19.01.48.10
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 01:48:10 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite] tests/inet_socket: cover the MPTCP protocol
Date:   Mon, 19 Jun 2023 10:48:09 +0200
Message-ID: <20230619084809.19794-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

As of kernel 6.5 MPTCP should work as a drop-in replacement for TCP
w.r.t. SELinux, so test it in addition to TCP using the same tests.

This requires modifying the inet_socket test to test each protocol
separately, using the same subdirectory symlink trick as in the
[fs_]filesystem tests. After that, an mptcp subtest can be added easily
by extending the programs to support it and adding a new subdirectory
symlink for it.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 tests/Makefile              |  10 +-
 tests/inet_socket/bind.c    |  22 +-
 tests/inet_socket/client.c  |  33 ++-
 tests/inet_socket/connect.c |  27 ++-
 tests/inet_socket/mptcp     |   1 +
 tests/inet_socket/server.c  |  33 ++-
 tests/inet_socket/tcp       |   1 +
 tests/inet_socket/test      | 430 +++++++++++++++++-------------------
 tests/inet_socket/udp       |   1 +
 9 files changed, 292 insertions(+), 266 deletions(-)
 create mode 120000 tests/inet_socket/mptcp
 create mode 120000 tests/inet_socket/tcp
 create mode 120000 tests/inet_socket/udp

diff --git a/tests/Makefile b/tests/Makefile
index 74df247..db4cb38 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -27,8 +27,8 @@ SUBDIRS:= domain_trans entrypoint execshare exectrace execute_no_trans \
 	task_setnice task_setscheduler task_getscheduler task_getsid \
 	task_getpgid task_setpgid file ioctl capable_file capable_net \
 	capable_sys dyntrans dyntrace bounds nnp_nosuid mmap unix_socket \
-	inet_socket overlay checkreqprot mqueue mac_admin atsecure \
-	infiniband_endport infiniband_pkey
+	inet_socket/tcp inet_socket/udp overlay checkreqprot mqueue \
+	mac_admin atsecure infiniband_endport infiniband_pkey
 
 ifeq ($(shell grep -q cap_userns $(POLDEV)/include/support/all_perms.spt && echo true),true)
 ifneq ($(shell ./kvercmp $$(uname -r) 4.7),-1)
@@ -147,6 +147,12 @@ SUBDIRS += secretmem
 endif
 endif
 
+# MPTCP is supported since kernel 5.6, but only works with SELinux
+# since 6.5
+ifneq ($(shell ./kvercmp $$(uname -r) 6.5),-1)
+SUBDIRS += inet_socket/mptcp
+endif
+
 ifeq ($(DISTRO),RHEL4)
     SUBDIRS:=$(filter-out bounds dyntrace dyntrans inet_socket mmap nnp_nosuid overlay unix_socket, $(SUBDIRS))
 endif
diff --git a/tests/inet_socket/bind.c b/tests/inet_socket/bind.c
index e16e117..389ca20 100644
--- a/tests/inet_socket/bind.c
+++ b/tests/inet_socket/bind.c
@@ -8,9 +8,13 @@
 #include <unistd.h>
 #include <stdio.h>
 
+#ifndef IPPROTO_MPTCP
+#define IPPROTO_MPTCP 262
+#endif
+
 void usage(char *progname)
 {
-	fprintf(stderr, "usage:  %s [stream|dgram] port\n", progname);
+	fprintf(stderr, "usage:  %s protocol port\n", progname);
 	exit(1);
 }
 
@@ -23,24 +27,30 @@ main(int argc, char **argv)
 	int result;
 	struct sockaddr_in sin;
 	socklen_t sinlen;
-	int type;
+	int type, protocol;
 	unsigned short port;
 
 	if (argc != 3)
 		usage(argv[0]);
 
-	if (!strcmp(argv[1], "stream"))
+	if (!strcmp(argv[1], "tcp")) {
+		type = SOCK_STREAM;
+		protocol = IPPROTO_TCP;
+	} else if (!strcmp(argv[1], "mptcp")) {
 		type = SOCK_STREAM;
-	else if (!strcmp(argv[1], "dgram"))
+		protocol = IPPROTO_MPTCP;
+	} else if (!strcmp(argv[1], "udp")) {
 		type = SOCK_DGRAM;
-	else
+		protocol = IPPROTO_UDP;
+	} else {
 		usage(argv[0]);
+	}
 
 	port = atoi(argv[2]);
 	if (!port)
 		usage(argv[0]);
 
-	sock = socket(AF_INET, type, 0);
+	sock = socket(AF_INET, type, protocol);
 	if (sock < 0) {
 		perror("socket");
 		exit(1);
diff --git a/tests/inet_socket/client.c b/tests/inet_socket/client.c
index f8780d9..d3fedf4 100644
--- a/tests/inet_socket/client.c
+++ b/tests/inet_socket/client.c
@@ -16,25 +16,28 @@
 #include <stdbool.h>
 #include <selinux/selinux.h>
 
+#ifndef IPPROTO_MPTCP
+#define IPPROTO_MPTCP 262
+#endif
+
 void usage(char *progname)
 {
 	fprintf(stderr,
-		"usage:  %s [-e expected_msg] [stream|dgram] addr port\n"
+		"usage:  %s [-e expected_msg] protocol addr port\n"
 		"\nWhere:\n\t"
-		"-e      Optional expected message from server e.g. \"nopeer\".\n\t"
-		"        If not present the client context will be used as a\n\t"
-		"        comparison with the servers reply.\n\t"
-		"stream  Use TCP protocol or:\n\t"
-		"dgram   use UDP protocol.\n\t"
-		"addr    IPv4 or IPv6 address (e.g. 127.0.0.1 or ::1)\n\t"
-		"port    Port for accessing server.\n", progname);
+		"-e        Optional expected message from server e.g. \"nopeer\".\n\t"
+		"          If not present the client context will be used as a\n\t"
+		"          comparison with the servers reply.\n\t"
+		"protocol  Protocol to use (tcp, udp, or mptcp)\n\t"
+		"addr      IPv4 or IPv6 address (e.g. 127.0.0.1 or ::1)\n\t"
+		"port      Port for accessing server.\n", progname);
 	exit(1);
 }
 
 int main(int argc, char **argv)
 {
 	char byte, label[256], *expected = NULL;
-	int sock, result, opt;
+	int sock, result, sockprotocol, opt;
 	struct addrinfo hints, *serverinfo;
 	struct timeval tm;
 
@@ -53,12 +56,18 @@ int main(int argc, char **argv)
 
 	memset(&hints, 0, sizeof(struct addrinfo));
 
-	if (!strcmp(argv[optind], "stream")) {
+	if (!strcmp(argv[optind], "tcp")) {
+		hints.ai_socktype = SOCK_STREAM;
+		hints.ai_protocol = IPPROTO_TCP;
+		sockprotocol      = IPPROTO_TCP;
+	} else if (!strcmp(argv[optind], "mptcp")) {
 		hints.ai_socktype = SOCK_STREAM;
 		hints.ai_protocol = IPPROTO_TCP;
-	} else if (!strcmp(argv[optind], "dgram")) {
+		sockprotocol      = IPPROTO_MPTCP;
+	} else if (!strcmp(argv[optind], "udp")) {
 		hints.ai_socktype = SOCK_DGRAM;
 		hints.ai_protocol = IPPROTO_UDP;
+		sockprotocol      = IPPROTO_UDP;
 	} else {
 		usage(argv[0]);
 	}
@@ -71,7 +80,7 @@ int main(int argc, char **argv)
 	}
 
 	sock = socket(serverinfo->ai_family, serverinfo->ai_socktype,
-		      serverinfo->ai_protocol);
+		      sockprotocol);
 	if (sock < 0) {
 		perror("socket");
 		exit(3);
diff --git a/tests/inet_socket/connect.c b/tests/inet_socket/connect.c
index 0abadc9..e2d02da 100644
--- a/tests/inet_socket/connect.c
+++ b/tests/inet_socket/connect.c
@@ -11,10 +11,13 @@
 #include <errno.h>
 #include <poll.h>
 
+#ifndef IPPROTO_MPTCP
+#define IPPROTO_MPTCP 262
+#endif
+
 void usage(char *progname)
 {
-	fprintf(stderr,
-		"usage:  %s port\n", progname);
+	fprintf(stderr, "usage:  %s protocol port\n", progname);
 	exit(1);
 }
 
@@ -27,16 +30,30 @@ main(int argc, char **argv)
 	int result;
 	struct sockaddr_in sin;
 	socklen_t sinlen;
+	int type, protocol;
 	unsigned short port;
 
-	if (argc != 2)
+	if (argc != 3)
+		usage(argv[0]);
+
+	if (!strcmp(argv[1], "tcp")) {
+		type = SOCK_STREAM;
+		protocol = IPPROTO_TCP;
+	} else if (!strcmp(argv[1], "mptcp")) {
+		type = SOCK_STREAM;
+		protocol = IPPROTO_MPTCP;
+	} else if (!strcmp(argv[1], "udp")) {
+		type = SOCK_DGRAM;
+		protocol = IPPROTO_UDP;
+	} else {
 		usage(argv[0]);
+	}
 
-	port = atoi(argv[1]);
+	port = atoi(argv[2]);
 	if (!port)
 		usage(argv[0]);
 
-	ssock = socket(AF_INET, SOCK_STREAM, 0);
+	ssock = socket(AF_INET, type, protocol);
 	if (ssock < 0) {
 		perror("socket");
 		exit(1);
diff --git a/tests/inet_socket/mptcp b/tests/inet_socket/mptcp
new file mode 120000
index 0000000..945c9b4
--- /dev/null
+++ b/tests/inet_socket/mptcp
@@ -0,0 +1 @@
+.
\ No newline at end of file
diff --git a/tests/inet_socket/server.c b/tests/inet_socket/server.c
index 234c2d6..63b6849 100644
--- a/tests/inet_socket/server.c
+++ b/tests/inet_socket/server.c
@@ -18,24 +18,27 @@
 #define SCM_SECURITY 0x03
 #endif
 
+#ifndef IPPROTO_MPTCP
+#define IPPROTO_MPTCP 262
+#endif
+
 void usage(char *progname)
 {
 	fprintf(stderr,
-		"usage:  %s [-f file] [-n] [stream|dgram] port\n"
+		"usage:  %s [-f file] [-n] protocol port\n"
 		"\nWhere:\n\t"
-		"-f      Write a line to the file when listening starts.\n\t"
-		"-n      No peer context will be available therefore send\n\t"
-		"        \"nopeer\" message to client, otherwise the peer context\n\t"
-		"        will be retrieved and sent to client.\n\t"
-		"stream  Use TCP protocol or:\n\t"
-		"dgram   use UDP protocol.\n\t"
-		"port    Listening port\n", progname);
+		"-f        Write a line to the file when listening starts.\n\t"
+		"-n        No peer context will be available therefore send\n\t"
+		"          \"nopeer\" message to client, otherwise the peer context\n\t"
+		"          will be retrieved and sent to client.\n\t"
+		"protocol  Protocol to use (tcp, udp, or mptcp)\n\t"
+		"port      Listening port\n", progname);
 	exit(1);
 }
 
 int main(int argc, char **argv)
 {
-	int sock, result, opt, on = 1;
+	int sock, result, opt, sockprotocol, on = 1;
 	socklen_t sinlen;
 	struct sockaddr_storage sin;
 	struct addrinfo hints, *res;
@@ -63,12 +66,18 @@ int main(int argc, char **argv)
 	hints.ai_flags = AI_PASSIVE;
 	hints.ai_family = AF_INET6;
 
-	if (!strcmp(argv[optind], "stream")) {
+	if (!strcmp(argv[optind], "tcp")) {
+		hints.ai_socktype = SOCK_STREAM;
+		hints.ai_protocol = IPPROTO_TCP;
+		sockprotocol      = IPPROTO_TCP;
+	} else if (!strcmp(argv[optind], "mptcp")) {
 		hints.ai_socktype = SOCK_STREAM;
 		hints.ai_protocol = IPPROTO_TCP;
-	} else if (!strcmp(argv[optind], "dgram")) {
+		sockprotocol      = IPPROTO_MPTCP;
+	} else if (!strcmp(argv[optind], "udp")) {
 		hints.ai_socktype = SOCK_DGRAM;
 		hints.ai_protocol = IPPROTO_UDP;
+		sockprotocol      = IPPROTO_UDP;
 	} else {
 		usage(argv[0]);
 	}
@@ -79,7 +88,7 @@ int main(int argc, char **argv)
 		exit(1);
 	}
 
-	sock = socket(res->ai_family, res->ai_socktype, res->ai_protocol);
+	sock = socket(res->ai_family, res->ai_socktype, sockprotocol);
 	if (sock < 0) {
 		perror("socket");
 		exit(1);
diff --git a/tests/inet_socket/tcp b/tests/inet_socket/tcp
new file mode 120000
index 0000000..945c9b4
--- /dev/null
+++ b/tests/inet_socket/tcp
@@ -0,0 +1 @@
+.
\ No newline at end of file
diff --git a/tests/inet_socket/test b/tests/inet_socket/test
index b21c440..0b1cb78 100755
--- a/tests/inet_socket/test
+++ b/tests/inet_socket/test
@@ -1,30 +1,49 @@
 #!/usr/bin/perl
 use Test::More;
+use File::Basename qw(dirname basename);
 
 BEGIN {
-    $basedir = $0;
-    $basedir =~ s|(.*)/[^/]*|$1|;
-
-    $test_count = 30;
+    $basedir = dirname($0);
+    $basedir = `cd $basedir && pwd`;
+    chomp($basedir);
+    $proto = basename($basedir);
+
+    if ( $proto eq "tcp" or $proto eq "mptcp" ) {
+        $is_stream   = 1;
+        $fail_value1 = 5;
+        $fail_value2 = 5;
+        $test_count  = 19;
+    }
+    elsif ( $proto eq "udp" ) {
+        $is_stream   = 0;
+        $fail_value1 = 9;
+        $fail_value2 = 8;
+        $test_count  = 11;
+    }
+    else {
+        plan skip => "unknown protocol name \'$proto\'";
+    }
 
     $test_ipsec = 0;
     if ( system("ip xfrm policy help 2>&1 | grep -q ctx") eq 0 ) {
-        $test_count += 8;
+        $test_count += 4;
         $test_ipsec = 1;
     }
 
     # Determine if CALIPSO supported by netlabelctl(8) and kernel.
     $test_calipso_stream = 0;
-    $netlabelctl         = `netlabelctl -V`;
-    $netlabelctl =~ s/\D//g;
-    $kvercur = `uname -r`;
-    chomp($kvercur);
-    $kverminstream = "4.8";
-
-    $rc = `$basedir/../kvercmp $kvercur $kverminstream`;
-    if ( $netlabelctl gt "021" and $rc > 0 ) {
-        $test_count += 3;
-        $test_calipso_stream = 1;
+    if ($is_stream) {
+        $netlabelctl = `netlabelctl -V`;
+        $netlabelctl =~ s/\D//g;
+        $kvercur = `uname -r`;
+        chomp($kvercur);
+        $kverminstream = "4.8";
+
+        $rc = `$basedir/../kvercmp $kvercur $kverminstream`;
+        if ( $netlabelctl gt "021" and $rc > 0 ) {
+            $test_count += 3;
+            $test_calipso_stream = 1;
+        }
     }
 
     # Determine if kernel has legacy iptables support
@@ -32,7 +51,7 @@ BEGIN {
 
     $rc = system("modprobe ip_tables 2>/dev/null");
     if ( $rc == 0 ) {
-        $test_count += 8;
+        $test_count += 4;
         $test_iptables = 1;
     }
 
@@ -41,7 +60,7 @@ BEGIN {
 
     $rc = system("nft -c -f $basedir/nftables-load 2>/dev/null");
     if ( $rc == 0 ) {
-        $test_count += 8;
+        $test_count += 4;
         $test_nft = 1;
     }
 
@@ -78,34 +97,18 @@ sub server_end {
 # Load NetLabel configuration for full CIPSO/IPv4 labeling over loopback.
 system "/bin/sh $basedir/cipso-fl-load";
 
-# Start the stream server.
-$pid = server_start( "-t test_inet_server_t", "stream 65535" );
+# Start the server.
+$pid = server_start( "-t test_inet_server_t", "$proto 65535" );
 
 # Verify that authorized client can communicate with the server.
 $result =
-  system "runcon -t test_inet_client_t $basedir/client stream 127.0.0.1 65535";
+  system "runcon -t test_inet_client_t $basedir/client $proto 127.0.0.1 65535";
 ok( $result eq 0 );
 
 # Verify that unauthorized client cannot communicate with the server.
 $result = system
-"runcon -t test_inet_bad_client_t -- $basedir/client stream 127.0.0.1 65535 2>&1";
-ok( $result >> 8 eq 5 );
-
-# Kill the server.
-server_end($pid);
-
-# Start the dgram server.
-$pid = server_start( "-t test_inet_server_t", "dgram 65535" );
-
-# Verify that authorized client can communicate with the server.
-$result =
-  system "runcon -t test_inet_client_t $basedir/client dgram 127.0.0.1 65535";
-ok( $result eq 0 );
-
-# Verify that unauthorized client cannot communicate with the server.
-$result = system
-"runcon -t test_inet_bad_client_t -- $basedir/client dgram 127.0.0.1 65535 2>&1";
-ok( $result >> 8 eq 9 );
+"runcon -t test_inet_bad_client_t -- $basedir/client $proto 127.0.0.1 65535 2>&1";
+ok( $result >> 8 eq $fail_value1 );
 
 # Kill the server.
 server_end($pid);
@@ -116,42 +119,48 @@ system "/bin/sh $basedir/cipso-fl-flush";
 # Load NetLabel configuration for CIPSO/IPv4 using TAG 1 over loopback.
 system "/bin/sh $basedir/cipso-load-t1";
 
-# Start the stream server with a defined level.
-$pid = server_start( "-t test_inet_server_t -l s0:c20.c250", "stream 65535" );
+if ($is_stream) {
+
+    # Start the server with a defined level.
+    $pid =
+      server_start( "-t test_inet_server_t -l s0:c20.c250", "$proto 65535" );
 
 # Verify that authorized client can communicate with the server using level within T1 range.
-$result = system
-"runcon -t test_inet_client_t -l s0:c61.c239 $basedir/client -e system_u:object_r:netlabel_peer_t:s0:c61.c239 stream 127.0.0.1 65535";
-ok( $result eq 0 );
+    $result = system
+"runcon -t test_inet_client_t -l s0:c61.c239 $basedir/client -e system_u:object_r:netlabel_peer_t:s0:c61.c239 $proto 127.0.0.1 65535";
+    ok( $result eq 0 );
 
 # Verify that authorized client cannot communicate with the server using different level.
-$result = system
-"runcon -t test_inet_client_t -l s0:c19,c120 $basedir/client stream 127.0.0.1 65535 2>&1";
-ok( $result >> 8 eq 5 );
+    $result = system
+"runcon -t test_inet_client_t -l s0:c19,c120 $basedir/client $proto 127.0.0.1 65535 2>&1";
+    ok( $result >> 8 eq $fail_value1 );
 
 # TAG 1 allows categories 0 to 239 to be sent, if greater then ENOSPC (No space left on device)
-$result = system
-"runcon -t test_inet_client_t -l s0:c0.c240 $basedir/client stream 127.0.0.1 65535 2>&1";
-ok( $result >> 8 eq 5 );
-
-# Kill the server.
-server_end($pid);
+    $result = system
+"runcon -t test_inet_client_t -l s0:c0.c240 $basedir/client $proto 127.0.0.1 65535 2>&1";
+    ok( $result >> 8 eq $fail_value1 );
 
-# Start the dgram server with a defined level.
-$pid = server_start( "-t test_inet_server_t -l s0:c20.c50", "dgram 65535" );
+    # Kill the server.
+    server_end($pid);
+}
+else {
+    # Start the server with a defined level.
+    $pid =
+      server_start( "-t test_inet_server_t -l s0:c20.c50", "$proto 65535" );
 
 # Verify that authorized client can communicate with the server using same levels.
-$result = system
-"runcon -t test_inet_client_t -l s0:c20.c50 $basedir/client -e system_u:object_r:netlabel_peer_t:s0:c20.c50 dgram 127.0.0.1 65535";
-ok( $result eq 0 );
+    $result = system
+"runcon -t test_inet_client_t -l s0:c20.c50 $basedir/client -e system_u:object_r:netlabel_peer_t:s0:c20.c50 $proto 127.0.0.1 65535";
+    ok( $result eq 0 );
 
 # Verify that authorized client cannot communicate with the server using levels dominating the server.
-$result = system
-"runcon -t test_inet_client_t -l s0:c40.c51 $basedir/client dgram 127.0.0.1 65535 2>&1";
-ok( $result >> 8 eq 9 );
+    $result = system
+"runcon -t test_inet_client_t -l s0:c40.c51 $basedir/client $proto 127.0.0.1 65535 2>&1";
+    ok( $result >> 8 eq $fail_value1 );
 
-# Kill the server.
-server_end($pid);
+    # Kill the server.
+    server_end($pid);
+}
 
 # Flush NetLabel configuration.
 system "/bin/sh $basedir/cipso-flush";
@@ -159,47 +168,52 @@ system "/bin/sh $basedir/cipso-flush";
 # Load NetLabel configuration for CIPSO/IPv4 using TAG 2 over loopback.
 system "/bin/sh $basedir/cipso-load-t2";
 
-# Start the stream server with a defined level.
-$pid = server_start( "-t test_inet_server_t -l s0:c0.c100", "stream 65535" );
+if ($is_stream) {
 
-# Verify that authorized client can communicate with the server using level.
-$result = system
-"runcon -t test_inet_client_t -l s0:c90.c100 $basedir/client -e system_u:object_r:netlabel_peer_t:s0:c90.c100 stream 127.0.0.1 65535";
-ok( $result eq 0 );
+    # Start the server with a defined level.
+    $pid =
+      server_start( "-t test_inet_server_t -l s0:c0.c100", "$proto 65535" );
 
-# Verify that authorized client can communicate with the server using level.
-$result = system
-"runcon -t test_inet_client_t -l s0:c0.c14 $basedir/client -e system_u:object_r:netlabel_peer_t:s0:c0.c14 stream 127.0.0.1 65535";
-ok( $result eq 0 );
+    # Verify that authorized client can communicate with the server using level.
+    $result = system
+"runcon -t test_inet_client_t -l s0:c90.c100 $basedir/client -e system_u:object_r:netlabel_peer_t:s0:c90.c100 $proto 127.0.0.1 65535";
+    ok( $result eq 0 );
+
+    # Verify that authorized client can communicate with the server using level.
+    $result = system
+"runcon -t test_inet_client_t -l s0:c0.c14 $basedir/client -e system_u:object_r:netlabel_peer_t:s0:c0.c14 $proto 127.0.0.1 65535";
+    ok( $result eq 0 );
 
 # Verify that authorized client cannot communicate with the server using different level.
-$result = system
-"runcon -t test_inet_client_t -l s0:c101 $basedir/client stream 127.0.0.1 65535 2>&1";
-ok( $result >> 8 eq 5 );
+    $result = system
+"runcon -t test_inet_client_t -l s0:c101 $basedir/client $proto 127.0.0.1 65535 2>&1";
+    ok( $result >> 8 eq $fail_value1 );
 
 # TAG 2 allows a maximum of 15 categories in exchange, if greater then ENOSPC (No space left on device)
-$result = system
-"runcon -t test_inet_client_t -l s0:c0.c16 -- $basedir/client dgram 127.0.0.1 65535 2>&1";
-ok( $result >> 8 eq 5 );
-
-# Kill the server.
-server_end($pid);
+    $result = system
+"runcon -t test_inet_client_t -l s0:c0.c16 -- $basedir/client $proto 127.0.0.1 65535 2>&1";
+    ok( $result >> 8 eq $fail_value1 );
 
-# Start the dgram server with a defined level.
-$pid = server_start( "-t test_inet_server_t -l s0:c0.c14", "dgram 65535" );
+    # Kill the server.
+    server_end($pid);
+}
+else {
+    # Start the server with a defined level.
+    $pid = server_start( "-t test_inet_server_t -l s0:c0.c14", "$proto 65535" );
 
 # Verify that authorized client can communicate with the server using same levels.
-$result = system
-"runcon -t test_inet_client_t -l s0:c0.c14 $basedir/client -e system_u:object_r:netlabel_peer_t:s0:c0.c14 dgram 127.0.0.1 65535";
-ok( $result eq 0 );
+    $result = system
+"runcon -t test_inet_client_t -l s0:c0.c14 $basedir/client -e system_u:object_r:netlabel_peer_t:s0:c0.c14 $proto 127.0.0.1 65535";
+    ok( $result eq 0 );
 
 # Verify that authorized client cannot communicate with the server using levels dominating the server.
-$result = system
-"runcon -t test_inet_client_t -l s0:c15 $basedir/client dgram 127.0.0.1 65535 2>&1";
-ok( $result >> 8 eq 9 );
+    $result = system
+"runcon -t test_inet_client_t -l s0:c15 $basedir/client $proto 127.0.0.1 65535 2>&1";
+    ok( $result >> 8 eq $fail_value1 );
 
-# Kill the server.
-server_end($pid);
+    # Kill the server.
+    server_end($pid);
+}
 
 # Flush NetLabel configuration.
 system "/bin/sh $basedir/cipso-flush";
@@ -213,158 +227,142 @@ system "/bin/sh $basedir/cipso-flush";
 # * be omitted. */
 system "/bin/sh $basedir/cipso-load-t5";
 
-# Start the stream server with a defined level.
-$pid = server_start( "-t test_inet_server_t -l s0:c0.c100", "stream 65535" );
+if ($is_stream) {
 
-# Verify that authorized client can communicate with the server using level.
-$result = system
-"runcon -t test_inet_client_t -l s0:c0.c100 $basedir/client -e system_u:object_r:netlabel_peer_t:s0:c0.c100 stream 127.0.0.1 65535";
-ok( $result eq 0 );
+    # Start the server with a defined level.
+    $pid =
+      server_start( "-t test_inet_server_t -l s0:c0.c100", "$proto 65535" );
 
-# Verify that authorized client can communicate with the server using level.
-$result = system
-"runcon -t test_inet_client_t -l s0:c8.c100 $basedir/client -e system_u:object_r:netlabel_peer_t:s0:c8.c100 stream 127.0.0.1 65535";
-ok( $result eq 0 );
+    # Verify that authorized client can communicate with the server using level.
+    $result = system
+"runcon -t test_inet_client_t -l s0:c0.c100 $basedir/client -e system_u:object_r:netlabel_peer_t:s0:c0.c100 $proto 127.0.0.1 65535";
+    ok( $result eq 0 );
 
-# Verify that authorized client cannot communicate with the server using different level.
-$result = system
-"runcon -t test_inet_client_t -l s0:c8.c101 $basedir/client stream 127.0.0.1 65535 2>&1";
-ok( $result >> 8 eq 5 );
+    # Verify that authorized client can communicate with the server using level.
+    $result = system
+"runcon -t test_inet_client_t -l s0:c8.c100 $basedir/client -e system_u:object_r:netlabel_peer_t:s0:c8.c100 $proto 127.0.0.1 65535";
+    ok( $result eq 0 );
 
-# Verify ok with the 8 entries when cat c0:
-$result = system
-"runcon -t test_inet_client_t -l s0:c0.c3,c20.c25,c30.c36,c40.c45,c50.c55,c60.c66,c70.c78,c80.c88 $basedir/client -e system_u:object_r:netlabel_peer_t:s0:c0.c3,c20.c25,c30.c36,c40.c45,c50.c55,c60.c66,c70.c78,c80.c88 stream 127.0.0.1 65535";
-ok( $result eq 0 );
+# Verify that authorized client cannot communicate with the server using different level.
+    $result = system
+"runcon -t test_inet_client_t -l s0:c8.c101 $basedir/client $proto 127.0.0.1 65535 2>&1";
+    ok( $result >> 8 eq $fail_value1 );
 
-# Verify fail with the 8 entries when cat !c0:
-$result = system
-"runcon -t test_inet_client_t -l s0:c20.c25,c30.c36,c40.c45,c50.c55,c60.c66,c70.c78,c80.c88,c90.c99 $basedir/client stream 127.0.0.1 65535 2>&1";
-ok( $result >> 8 eq 5 );
+    # Verify ok with the 8 entries when cat c0:
+    $result = system
+"runcon -t test_inet_client_t -l s0:c0.c3,c20.c25,c30.c36,c40.c45,c50.c55,c60.c66,c70.c78,c80.c88 $basedir/client -e system_u:object_r:netlabel_peer_t:s0:c0.c3,c20.c25,c30.c36,c40.c45,c50.c55,c60.c66,c70.c78,c80.c88 $proto 127.0.0.1 65535";
+    ok( $result eq 0 );
 
-# Kill the server.
-server_end($pid);
+    # Verify fail with the 8 entries when cat !c0:
+    $result = system
+"runcon -t test_inet_client_t -l s0:c20.c25,c30.c36,c40.c45,c50.c55,c60.c66,c70.c78,c80.c88,c90.c99 $basedir/client $proto 127.0.0.1 65535 2>&1";
+    ok( $result >> 8 eq $fail_value1 );
 
-# Start the dgram server with a defined level.
-$pid = server_start( "-t test_inet_server_t -l s0:c0.c100", "dgram 65535" );
+    # Kill the server.
+    server_end($pid);
+}
+else {
+    # Start the server with a defined level.
+    $pid =
+      server_start( "-t test_inet_server_t -l s0:c0.c100", "$proto 65535" );
 
 # Verify that authorized client can communicate with the server using same levels.
-$result = system
-"runcon -t test_inet_client_t -l s0:c0.c100 $basedir/client -e system_u:object_r:netlabel_peer_t:s0:c0.c100 dgram 127.0.0.1 65535";
-ok( $result eq 0 );
+    $result = system
+"runcon -t test_inet_client_t -l s0:c0.c100 $basedir/client -e system_u:object_r:netlabel_peer_t:s0:c0.c100 $proto 127.0.0.1 65535";
+    ok( $result eq 0 );
 
 # Verify that authorized client cannot communicate with the server using levels dominating the server.
-$result = system
-"runcon -t test_inet_client_t -l s0:c40.c101 $basedir/client dgram 127.0.0.1 65535 2>&1";
-ok( $result >> 8 eq 9 );
+    $result = system
+"runcon -t test_inet_client_t -l s0:c40.c101 $basedir/client $proto 127.0.0.1 65535 2>&1";
+    ok( $result >> 8 eq $fail_value1 );
 
-# Kill the server.
-server_end($pid);
+    # Kill the server.
+    server_end($pid);
+}
 
 # Flush NetLabel configuration.
 system "/bin/sh $basedir/cipso-flush";
 
-# Verify that authorized domain can bind UDP sockets.
-$result = system "runcon -t test_inet_bind_t -- $basedir/bind dgram 65535 2>&1";
-ok( $result eq 0 );
-
-# Verify that authorized domain can bind TCP sockets.
+# Verify that authorized domain can bind.
 $result =
-  system "runcon -t test_inet_bind_t -- $basedir/bind stream 65535 2>&1";
+  system "runcon -t test_inet_bind_t -- $basedir/bind $proto 65535 2>&1";
 ok( $result eq 0 );
 
-# Verify that domain without name_bind cannot bind UDP sockets.
+# Verify that domain without name_bind cannot bind.
 $result =
-  system "runcon -t test_inet_no_name_bind_t -- $basedir/bind dgram 65535 2>&1";
-ok($result);
-
-# Verify that domain without name_bind cannot bind TCP sockets.
-$result = system
-  "runcon -t test_inet_no_name_bind_t -- $basedir/bind stream 65535 2>&1";
+  system
+  "runcon -t test_inet_no_name_bind_t -- $basedir/bind $proto 65535 2>&1";
 ok($result);
 
-# Verify that domain without node_bind cannot bind UDP sockets.
+# Verify that domain without node_bind cannot bind.
 $result =
-  system "runcon -t test_inet_no_node_bind_t -- $basedir/bind dgram 65535 2>&1";
+  system
+  "runcon -t test_inet_no_node_bind_t -- $basedir/bind $proto 65535 2>&1";
 ok($result);
 
-# Verify that domain without node_bind cannot bind TCP sockets.
-$result = system
-  "runcon -t test_inet_no_node_bind_t -- $basedir/bind stream 65535 2>&1";
-ok($result);
+if ($is_stream) {
 
-# Verify that authorized domain can connect to TCP socket.
-$result = system "runcon -t test_inet_connect_t -- $basedir/connect 65535 2>&1";
-ok( $result eq 0 );
+    # Verify that authorized domain can connect to TCP socket.
+    $result = system
+      "runcon -t test_inet_connect_t -- $basedir/connect $proto 65535 2>&1";
+    ok( $result eq 0 );
 
-# Verify that domain without name_connect cannot connect to TCP socket.
-$result =
-  system "runcon -t test_inet_no_name_connect_t -- $basedir/connect 65535 2>&1";
-ok($result);
+    # Verify that domain without name_connect cannot connect to TCP socket.
+    $result =
+      system
+"runcon -t test_inet_no_name_connect_t -- $basedir/connect $proto 65535 2>&1";
+    ok($result);
+}
 
 if ($test_ipsec) {
 
     # Load IPSEC configuration.
     system "/bin/sh $basedir/ipsec-load";
 
-    # Start the stream server.
-    $pid = server_start( "-t test_inet_server_t", "stream 65535" );
+    # Start the server.
+    $pid = server_start( "-t test_inet_server_t", "$proto 65535" );
 
     # Verify that authorized client can communicate with the server.
     $result =
       system
-      "runcon -t test_inet_client_t $basedir/client stream 127.0.0.1 65535";
-    ok( $result eq 0 );
-
-    # Verify that unauthorized client cannot communicate with the server.
-    $result = system
-"runcon -t test_inet_bad_client_t -- $basedir/client stream 127.0.0.1 65535 2>&1";
-    ok( $result >> 8 eq 5 );
-
-    # Verify that authorized client can communicate with the server.
-    $result =
-      system "runcon -t test_inet_client_t $basedir/client stream ::1 65535";
+      "runcon -t test_inet_client_t $basedir/client $proto 127.0.0.1 65535";
     ok( $result eq 0 );
 
     # Verify that unauthorized client cannot communicate with the server.
     $result = system
-"runcon -t test_inet_bad_client_t -- $basedir/client stream ::1 65535 2>&1";
-    ok( $result >> 8 eq 5 );
+"runcon -t test_inet_bad_client_t -- $basedir/client $proto 127.0.0.1 65535 2>&1";
+    ok( $result >> 8 eq $fail_value2 );
 
-    # Kill the server.
-    server_end($pid);
+    if ($is_stream) {
 
-    # Start the dgram server.
-    $pid = server_start( "-t test_inet_server_t", "dgram 65535" );
-
-    # Verify that authorized client can communicate with the server.
-    $result =
-      system
-      "runcon -t test_inet_client_t $basedir/client dgram 127.0.0.1 65535";
-    ok( $result eq 0 );
-
-    # Verify that unauthorized client cannot communicate with the server.
-    $result = system
-"runcon -t test_inet_bad_client_t -- $basedir/client dgram 127.0.0.1 65535 2>&1";
-    ok( $result >> 8 eq 8 );
+        # Verify that authorized client can communicate with the server.
+        $result =
+          system
+          "runcon -t test_inet_client_t $basedir/client $proto ::1 65535";
+        ok( $result eq 0 );
+    }
 
     # Verify that unauthorized client cannot communicate with the server.
     $result = system
-"runcon -t test_inet_bad_client_t -- $basedir/client dgram ::1 65535 2>&1";
-    ok( $result >> 8 eq 8 );
+"runcon -t test_inet_bad_client_t -- $basedir/client $proto ::1 65535 2>&1";
+    ok( $result >> 8 eq $fail_value2 );
 
     # Kill the server.
     server_end($pid);
 
-# Start the dgram server for IPSEC test using IPv6 but do not request peer context.
-    $pid = server_start( "-t test_inet_server_t", "-n dgram 65535" );
+    if ( not $is_stream ) {
 
-    # This test now passes.
-    $result = system
-      "runcon -t test_inet_client_t $basedir/client -e nopeer dgram ::1 65535";
-    ok( $result eq 0 );
+   # Start the server for IPSEC test using IPv6 but do not request peer context.
+        $pid = server_start( "-t test_inet_server_t", "-n $proto 65535" );
 
-    # Kill the server.
-    server_end($pid);
+        # This test now passes.
+        $result = system
+"runcon -t test_inet_client_t $basedir/client -e nopeer $proto ::1 65535";
+        ok( $result eq 0 );
+
+        # Kill the server.
+        server_end($pid);
+    }
 
     # Flush IPSEC configuration.
     system "/bin/sh $basedir/ipsec-flush";
@@ -375,54 +373,28 @@ if ($test_ipsec) {
 #
 sub test_tables {
 
-    # Start the stream server.
-    $pid = server_start( "-t test_inet_server_t", "-n stream 65535" );
-
-    # Verify that authorized client can communicate with the server.
-    $result = system
-"runcon -t test_inet_client_t -- $basedir/client -e nopeer stream 127.0.0.1 65535";
-    ok( $result eq 0 );
-
-    # Verify that unauthorized client cannot communicate with the server.
-    $result = system
-"runcon -t test_inet_bad_client_t -- $basedir/client -e nopeer stream 127.0.0.1 65535 2>&1";
-    ok( $result >> 8 eq 5 );
-
-    # Verify that authorized client can communicate with the server.
-    $result = system
-"runcon -t test_inet_client_t -- $basedir/client -e nopeer stream ::1 65535";
-    ok( $result eq 0 );
-
-    # Verify that unauthorized client cannot communicate with the server.
-    $result = system
-"runcon -t test_inet_bad_client_t -- $basedir/client -e nopeer stream ::1 65535 2>&1";
-    ok( $result >> 8 eq 5 );
-
-    # Kill the server.
-    server_end($pid);
-
-    # Start the dgram server.
-    $pid = server_start( "-t test_inet_server_t", "-n dgram 65535" );
+    # Start the server.
+    $pid = server_start( "-t test_inet_server_t", "-n $proto 65535" );
 
     # Verify that authorized client can communicate with the server.
     $result = system
-"runcon -t test_inet_client_t $basedir/client -e nopeer dgram 127.0.0.1 65535";
+"runcon -t test_inet_client_t -- $basedir/client -e nopeer $proto 127.0.0.1 65535";
     ok( $result eq 0 );
 
     # Verify that unauthorized client cannot communicate with the server.
     $result = system
-"runcon -t test_inet_bad_client_t -- $basedir/client -e nopeer dgram 127.0.0.1 65535 2>&1";
-    ok( $result >> 8 eq 8 );
+"runcon -t test_inet_bad_client_t -- $basedir/client -e nopeer $proto 127.0.0.1 65535 2>&1";
+    ok( $result >> 8 eq $fail_value2 );
 
     # Verify that authorized client can communicate with the server.
     $result = system
-      "runcon -t test_inet_client_t $basedir/client -e nopeer dgram ::1 65535";
+"runcon -t test_inet_client_t -- $basedir/client -e nopeer $proto ::1 65535";
     ok( $result eq 0 );
 
     # Verify that unauthorized client cannot communicate with the server.
     $result = system
-"runcon -t test_inet_bad_client_t -- $basedir/client -e nopeer dgram ::1 65535 2>&1";
-    ok( $result >> 8 eq 8 );
+"runcon -t test_inet_bad_client_t -- $basedir/client -e nopeer $proto ::1 65535 2>&1";
+    ok( $result >> 8 eq $fail_value2 );
 
     # Kill the server.
     server_end($pid);
@@ -448,21 +420,21 @@ if ($test_calipso_stream) {
     system "/bin/sh $basedir/calipso-load";
 
     # Start the stream server.
-    $pid = server_start( "-t test_inet_server_t -l s0:c0.c10", "stream 65535" );
+    $pid = server_start( "-t test_inet_server_t -l s0:c0.c10", "$proto 65535" );
 
     # Verify that authorized client can communicate with the server.
     $result = system
-"runcon -t test_inet_client_t -l s0:c0.c10 $basedir/client -e system_u:object_r:netlabel_peer_t:s0:c0.c10 stream ::1 65535";
+"runcon -t test_inet_client_t -l s0:c0.c10 $basedir/client -e system_u:object_r:netlabel_peer_t:s0:c0.c10 $proto ::1 65535";
     ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server using different valid level.
     $result = system
-"runcon -t test_inet_client_t -l s0:c8.c10 $basedir/client -e  system_u:object_r:netlabel_peer_t:s0:c8.c10 stream ::1 65535";
+"runcon -t test_inet_client_t -l s0:c8.c10 $basedir/client -e  system_u:object_r:netlabel_peer_t:s0:c8.c10 $proto ::1 65535";
     ok( $result eq 0 );
 
 # Verify that authorized client cannot communicate with the server using invalid level.
     $result = system
-"runcon -t test_inet_client_t -l s0:c8.c12 -- $basedir/client stream ::1 65535 2>&1";
+"runcon -t test_inet_client_t -l s0:c8.c12 -- $basedir/client $proto ::1 65535 2>&1";
     ok( $result >> 8 eq 5 );
 
     # Kill the stream server.
diff --git a/tests/inet_socket/udp b/tests/inet_socket/udp
new file mode 120000
index 0000000..945c9b4
--- /dev/null
+++ b/tests/inet_socket/udp
@@ -0,0 +1 @@
+.
\ No newline at end of file
-- 
2.41.0

