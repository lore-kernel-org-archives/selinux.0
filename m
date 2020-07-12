Return-Path: <SRS0=GtrK=AX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6EAC433E1
	for <selinux@archiver.kernel.org>; Sun, 12 Jul 2020 16:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 396DE2065F
	for <selinux@archiver.kernel.org>; Sun, 12 Jul 2020 16:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="En11eU4Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbgGLQAd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 12 Jul 2020 12:00:33 -0400
Received: from mailomta3-re.btinternet.com ([213.120.69.96]:32418 "EHLO
        re-prd-fep-049.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728854AbgGLQAb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 12 Jul 2020 12:00:31 -0400
Received: from re-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.54.7])
          by re-prd-fep-049.btinternet.com with ESMTP
          id <20200712160026.FFNN4131.re-prd-fep-049.btinternet.com@re-prd-rgout-004.btmx-prd.synchronoss.net>;
          Sun, 12 Jul 2020 17:00:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1594569626; 
        bh=GOOwM2v3CSKPlDQn4T5LSwNYExkdESO+/c5a+9Sy07k=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=En11eU4YBflchhxp5mzjAv9FSoW2VQteMYTr6LIF8wkFWtay17m1sxvulqTdn8TvE61XBxJw0xhK90kCKxUW7HI1i4C7K4613RNMm7n13DLHjmvk2xnM81fRKCtyP7lqev1u4x9M0lVWaXv0075/OPgF9X+lat2xoJChNUC3GrI180OlbyhCaVbY1L3LoIcuUQblawsWqrr3sQ8UV3TMZduAX3UA22rWb3g8pDz98fV4YsyuRZx3TO02NH/2odrEMLlcO0g8BG67qTcrQQh6TiI4R48cJtMbKVbZGdMZy2Ar7otVNB87TAZFlDQXJ8F+o1H3m5rWXiUcoqBpjHa+ug==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [86.177.31.109]
X-OWM-Source-IP: 86.177.31.109 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrvdeigdellecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepueeffeduffefteejveehtedvkeeuueevffdtgfekgfetgfekgeeiheevueehvdffnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepkeeirddujeejrdefuddruddtleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddujeejrdefuddruddtledpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuqfftvefrvfeprhhftgekvddvnehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (86.177.31.109) by re-prd-rgout-004.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9C50606731B8A; Sun, 12 Jul 2020 17:00:26 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH] selinux-testsuite: Review and update SCTP tests
Date:   Sun, 12 Jul 2020 17:00:20 +0100
Message-Id: <20200712160020.17385-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Reviewed the tests using kernel tree: Documentation/security/SCTP.rst

Added tests and policy for connectx(3) handling deny and
SCTP_SENDMSG_CONNECT
Added test and policy for bindx(3) deny
Clarified the server test for ports < 1024
Added comments regarding kernel net/sctp code locations to relevant tests
Corrected policy for test_sctp_deny_peer_client_t
Corrected ip/nf tables comment to deny read packet { recv }
Added MCS-constrained type as suggested in [1]

[1] https://lore.kernel.org/selinux/20200508154138.24217-7-stephen.smalley.work@gmail.com/

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 policy/test_sctp.te        | 43 +++++++++++++++++++++-----
 tests/sctp/sctp_bindx.c    |  8 ++---
 tests/sctp/sctp_connectx.c | 47 +++++++++++++++++++++--------
 tests/sctp/test            | 62 +++++++++++++++++++++++++++++++-------
 4 files changed, 126 insertions(+), 34 deletions(-)

diff --git a/policy/test_sctp.te b/policy/test_sctp.te
index 3b16db1..5f6553f 100644
--- a/policy/test_sctp.te
+++ b/policy/test_sctp.te
@@ -59,6 +59,13 @@ allow test_sctp_server_t netlabel_sctp_peer_t:peer { recv };
 corenet_sctp_bind_all_nodes(test_sctp_server_t)
 corenet_inout_generic_node(test_sctp_server_t)
 corenet_inout_generic_if(test_sctp_server_t)
+mcs_constrained(test_sctp_server_t)
+
+#### Verify that the server cannot start when using port < 1024 ####
+# neverallow test_sctp_server_t reserved_port_t:sctp_socket { name_bind };
+# Stop clutter in audit log for this test:
+dontaudit test_sctp_server_t self:netlink_route_socket { create getattr bind };
+dontaudit test_sctp_server_t self:udp_socket { getattr connect };
 
 #
 ############################### Client #################################
@@ -85,7 +92,11 @@ typeattribute test_sctp_deny_peer_client_t testdomain;
 typeattribute test_sctp_deny_peer_client_t sctpsocketdomain;
 allow test_sctp_deny_peer_client_t self:sctp_socket create_stream_socket_perms;
 corenet_inout_generic_node(test_sctp_deny_peer_client_t)
-corenet_inout_generic_if(deny_assoc_sctp_peer_t)
+corenet_inout_generic_if(test_sctp_deny_peer_client_t)
+
+allow test_sctp_deny_peer_client_t test_sctp_server_packet_t:packet { send };
+allow test_sctp_server_t test_sctp_deny_peer_client_t:peer { recv };
+allow test_sctp_client_t test_sctp_deny_peer_client_t:sctp_socket { association };
 
 #
 ####################### Deny association permission #########################
@@ -117,11 +128,20 @@ unconfined_runs_test(test_sctp_connectx_t)
 typeattribute test_sctp_connectx_t testdomain;
 typeattribute test_sctp_connectx_t sctpsocketdomain;
 allow test_sctp_connectx_t self:sctp_socket create_stream_socket_perms;
-allow test_sctp_server_t test_sctp_connectx_t:peer { recv };
-allow test_sctp_connectx_t test_sctp_server_t:peer { recv };
 corenet_sctp_bind_all_nodes(test_sctp_connectx_t)
 corenet_inout_generic_node(test_sctp_connectx_t)
-corenet_inout_generic_if(test_sctp_connectx_t)
+
+#
+############################# Deny Connectx #################################
+#
+type test_sctp_deny_connectx_t;
+domain_type(test_sctp_deny_connectx_t)
+unconfined_runs_test(test_sctp_deny_connectx_t)
+typeattribute test_sctp_deny_connectx_t testdomain;
+typeattribute test_sctp_deny_connectx_t sctpsocketdomain;
+allow test_sctp_deny_connectx_t self:sctp_socket { create listen accept bind ioctl read getattr write getopt setopt };
+corenet_sctp_bind_all_nodes(test_sctp_deny_connectx_t)
+corenet_inout_generic_node(test_sctp_deny_connectx_t)
 
 #
 ############################## Bindx #####################################
@@ -132,11 +152,20 @@ unconfined_runs_test(test_sctp_bindx_t)
 typeattribute test_sctp_bindx_t testdomain;
 typeattribute test_sctp_bindx_t sctpsocketdomain;
 allow test_sctp_bindx_t self:sctp_socket create_stream_socket_perms;
-allow test_sctp_server_t test_sctp_bindx_t:peer { recv };
-allow test_sctp_bindx_t test_sctp_server_t:peer { recv };
 corenet_sctp_bind_all_nodes(test_sctp_bindx_t)
 corenet_inout_generic_node(test_sctp_bindx_t)
-corenet_inout_generic_if(test_sctp_bindx_t)
+
+#
+############################## Deny Bindx ###################################
+#
+type test_sctp_deny_bindx_t;
+domain_type(test_sctp_deny_bindx_t)
+unconfined_runs_test(test_sctp_deny_bindx_t)
+typeattribute test_sctp_deny_bindx_t testdomain;
+typeattribute test_sctp_deny_bindx_t sctpsocketdomain;
+allow test_sctp_deny_bindx_t self:sctp_socket { create ioctl read getattr write getopt setopt };
+corenet_sctp_bind_all_nodes(test_sctp_deny_bindx_t)
+corenet_inout_generic_node(test_sctp_deny_bindx_t)
 
 #
 ########## SET_PRI_ADDR + SET_PEER ADDR for ASCONF process testing ##########
diff --git a/tests/sctp/sctp_bindx.c b/tests/sctp/sctp_bindx.c
index 7634bab..74bf985 100644
--- a/tests/sctp/sctp_bindx.c
+++ b/tests/sctp/sctp_bindx.c
@@ -11,7 +11,7 @@ static void usage(char *progname)
 		"stream  Use SCTP 1-to-1 style or:\n\t"
 		"seq     use SCTP 1-to-Many style.\n\t"
 		"port    port.\n", progname);
-	exit(1);
+	exit(-1);
 }
 
 int main(int argc, char **argv)
@@ -77,7 +77,7 @@ int main(int argc, char **argv)
 	if (result < 0) {
 		perror("sctp_bindx ADD - ipv4");
 		close(sock);
-		exit(1);
+		exit(2);
 	}
 
 	if (verbose)
@@ -93,7 +93,7 @@ int main(int argc, char **argv)
 	if (result < 0) {
 		perror("sctp_bindx ADD - ipv6");
 		close(sock);
-		exit(1);
+		exit(3);
 	}
 
 	if (verbose)
@@ -105,7 +105,7 @@ int main(int argc, char **argv)
 		if (result < 0) {
 			perror("sctp_bindx - REM");
 			close(sock);
-			exit(1);
+			exit(4);
 		}
 		if (verbose)
 			printf("sctp_bindx REM - ipv6\n");
diff --git a/tests/sctp/sctp_connectx.c b/tests/sctp/sctp_connectx.c
index 18d133d..b2d8f82 100644
--- a/tests/sctp/sctp_connectx.c
+++ b/tests/sctp/sctp_connectx.c
@@ -3,25 +3,30 @@
 static void usage(char *progname)
 {
 	fprintf(stderr,
-		"usage:  %s [-v] stream|seq addr port\n"
+		"usage:  %s [-n] [-v] stream|seq addr port\n"
 		"\nWhere:\n\t"
+		"-n      No connectx for SCTP_SENDMSG_CONNECT test with 'seq' only.\n\t"
 		"-v      Print context information.\n\t"
 		"stream  Use SCTP 1-to-1 style or:\n\t"
 		"seq     use SCTP 1-to-Many style.\n\t"
 		"addr    Servers IPv4 or IPv6 address.\n\t"
 		"port    port.\n", progname);
-	exit(1);
+	exit(-1);
 }
 
 int main(int argc, char **argv)
 {
 	int opt, type, srv_sock, client_sock, result, on = 1;
 	struct addrinfo srv_hints, client_hints, *srv_res, *client_res;
-	bool verbose = false;
+	bool verbose = false, no_connx = false;
 	char *context;
+	char msg[] = "Hello";
 
-	while ((opt = getopt(argc, argv, "v")) != -1) {
+	while ((opt = getopt(argc, argv, "nv")) != -1) {
 		switch (opt) {
+		case 'n':
+			no_connx = true;
+			break;
 		case 'v':
 			verbose = true;
 			break;
@@ -40,6 +45,10 @@ int main(int argc, char **argv)
 	else
 		usage(argv[0]);
 
+	/* Testing SCTP_SENDMSG_CONNECT only valid on SEQ */
+	if (no_connx && type == SOCK_STREAM)
+		usage(argv[0]);
+
 	if (verbose) {
 		if (getcon(&context) < 0)
 			context = strdup("unavailable");
@@ -65,7 +74,7 @@ int main(int argc, char **argv)
 			  srv_res->ai_protocol);
 	if (srv_sock < 0) {
 		perror("socket - server");
-		exit(1);
+		exit(2);
 	}
 
 	if (verbose)
@@ -76,14 +85,14 @@ int main(int argc, char **argv)
 	if (result < 0) {
 		perror("setsockopt: SO_REUSEADDR");
 		close(srv_sock);
-		exit(1);
+		exit(3);
 	}
 
 	result = bind(srv_sock, srv_res->ai_addr, srv_res->ai_addrlen);
 	if (result < 0) {
 		perror("bind");
 		close(srv_sock);
-		exit(1);
+		exit(4);
 	}
 
 	listen(srv_sock, 1);
@@ -97,25 +106,39 @@ int main(int argc, char **argv)
 	if (result < 0) {
 		fprintf(stderr, "getaddrinfo - client: %s\n",
 			gai_strerror(result));
-		exit(1);
+		exit(5);
 	}
 
 	client_sock = socket(client_res->ai_family, client_res->ai_socktype,
 			     client_res->ai_protocol);
 	if (client_sock < 0) {
 		perror("socket - client");
-		exit(1);
+		exit(6);
 	}
 
 	if (verbose)
 		print_context(client_sock, "Client");
 
-	result = sctp_connectx(client_sock, client_res->ai_addr, 1, NULL);
+	if (!no_connx) {
+		result = sctp_connectx(client_sock, client_res->ai_addr, 1, NULL);
+		if (result < 0) {
+			perror("connectx");
+			close(srv_sock);
+			close(client_sock);
+			exit(7);
+		}
+	}
+
+	/* Send msg to form an association with server */
+	result = sctp_sendmsg(client_sock, msg, sizeof(msg),
+			      client_res->ai_addr,
+			      client_res->ai_addrlen,
+			      0, 0, 0, 0, 0);
 	if (result < 0) {
-		perror("connectx");
+		perror("sctp_sendmsg - SCTP_SENDMSG_CONNECT");
 		close(srv_sock);
 		close(client_sock);
-		exit(1);
+		exit(8);
 	}
 
 	close(srv_sock);
diff --git a/tests/sctp/test b/tests/sctp/test
index c87ee14..b4462c9 100755
--- a/tests/sctp/test
+++ b/tests/sctp/test
@@ -1,6 +1,18 @@
 #!/usr/bin/perl
 use Test::More;
 
+#
+# These tests cover the net/sctp security hooks as discussed in kernel tree:
+#     Documentation/security/SCTP.rst
+# The only two places in SCTP code not tested as they need unusual sctp
+# packets to be sent are:
+#   net/sctp/sm_statefuns.c sctp_sf_do_unexpected_init - assoc_request
+#   net/sctp/sm_statefuns.c sctp_sf_do_5_2_4_dupcook - assoc_request
+#
+# Network traffic can be followed using tshark(1):
+#        tshark -O sctp,ipv6,ip,cipso,calipso -P -x -i any
+#
+
 BEGIN {
     $basedir = $0;
     $basedir =~ s|(.*)/[^/]*|$1|;
@@ -21,7 +33,7 @@ BEGIN {
         plan skip_all => "SCTP not supported";
     }
     else {
-        $test_count = 71;
+        $test_count = 75;
 
         # asconf parameter tests require two local non-loopback addresses.
         $ipaddress_list = `ip -o addr show up scope global`;
@@ -125,9 +137,8 @@ $result = system
   "runcon -t test_sctp_client_t $basedir/sctp_client $v -e nopeer seq ::1 1035";
 ok( $result eq 0 );
 
-######## This test requires setting a portcon statement in policy ###########
-# Verify that the client cannot communicate with server when using port not allowed STREAM->STREAM.
-# Note that the sctp_test policy only allows ports 1024-65535
+# Verify that the client cannot communicate with server when using port < 1024 STREAM->STREAM.
+# deny sctp_socket { name_connect }
 $result = system
 "runcon -t test_sctp_client_t -- $basedir/sctp_client $v -e nopeer stream ::1 1023 2>&1";
 ok( $result >> 8 eq 8 );
@@ -135,9 +146,8 @@ ok( $result >> 8 eq 8 );
 # Kill the stream server.
 server_end($pid);
 
-######## This test requires setting a portcon statement in policy ###########
-# Verify that the server cannot start when using port not allowed STREAM->STREAM.
-# Note that the sctp_test policy only allows ports 1024-65535
+# Verify that the server cannot start when using port < 1024.
+# deny sctp_socket { name_bind }
 $result =
   system "runcon -t test_sctp_server_t -- $basedir/sctp_bind $v stream 80 2>&1";
 ok($result);
@@ -145,6 +155,7 @@ ok($result);
 #
 ############################### CONNECTX #####################################
 #
+# net/sctp/socket.c sctp_setsockopt_connectx() SCTP_SOCKOPT_CONNECTX
 print "# Testing connectx.\n";
 
 $result = system
@@ -156,9 +167,31 @@ $result =
   "runcon -t test_sctp_connectx_t $basedir/sctp_connectx $v seq ::1 1035";
 ok( $result eq 0 );
 
+$result =
+  system
+"runcon -t test_sctp_deny_connectx_t $basedir/sctp_connectx $v seq ::1 1035 2>&1";
+ok( $result >> 8 eq 7 );
+
+#
+########################### SCTP_SENDMSG_CONNECT #############################
+#
+# net/sctp/socket.c sctp_sendmsg_new_asoc() SCTP_SENDMSG_CONNECT
+print "# Testing SCTP_SENDMSG_CONNECT.\n";
+
+$result =
+  system
+"runcon -t test_sctp_connectx_t $basedir/sctp_connectx $v -n seq 127.0.0.1 1035";
+ok( $result eq 0 );
+
+$result =
+  system
+"runcon -t test_sctp_deny_connectx_t $basedir/sctp_connectx $v -n seq ::1 1035 2>&1";
+ok( $result >> 8 eq 8 );
+
 #
 ################################ BINDX #######################################
 #
+# net/sctp/socket.c sctp_setsockopt_bindx() SCTP_SOCKOPT_BINDX_ADD
 print "# Testing bindx.\n";
 
 $result =
@@ -169,6 +202,11 @@ $result =
   system "runcon -t test_sctp_bindx_t $basedir/sctp_bindx $v -r seq 1035";
 ok( $result eq 0 );
 
+$result =
+  system
+  "runcon -t test_sctp_deny_bindx_t $basedir/sctp_bindx $v -r seq 1035 2>&1";
+ok( $result >> 8 eq 2 );
+
 #
 ######################### SET_PRI_ADDR SET_PEER_ADDR ########################
 #
@@ -274,6 +312,7 @@ system "/bin/sh $basedir/fb-label-flush";
 #
 #################### Test deny association permission ########################
 #
+# net/sctp/sm_statefuns.c sctp_sf_do_5_1B_init() assoc_request
 print "# Testing deny association.\n";
 system "/bin/sh $basedir/fb-deny-label-load";
 
@@ -329,6 +368,7 @@ $result = system
 ok( $result eq 0 );
 
 # Verify that authorized client cannot communicate with the server using invalid level STREAM->STREAM.
+# Fails with mlsconstrain peer { recv }
 $result = system
 "runcon -t test_sctp_client_t -l s0:c182.c193 -- $basedir/sctp_client $v stream 127.0.0.1 1035 2>&1";
 ok( $result >> 8 eq 6 );
@@ -771,7 +811,7 @@ sub test_tables {
 "runcon -t test_sctp_client_t $basedir/sctp_client $v -e nopeer stream 127.0.0.1 1035";
     ok( $result eq 0 );
 
-# Verify that a client without peer { recv } permission cannot communicate with the server STREAM->STREAM.
+# Verify that a client without packet { recv } permission cannot communicate with the server STREAM->STREAM.
     $result = system
 "runcon -t test_sctp_deny_peer_client_t -- $basedir/sctp_client $v -e nopeer stream 127.0.0.1 1035 2>&1";
     ok( $result >> 8 eq 6 );
@@ -781,7 +821,7 @@ sub test_tables {
 "runcon -t test_sctp_client_t $basedir/sctp_client $v -e nopeer stream ::1 1035";
     ok( $result eq 0 );
 
-# Verify that a client without peer { recv } permission cannot communicate with the server STREAM->STREAM.
+# Verify that a client without packet { recv } permission cannot communicate with the server STREAM->STREAM.
     $result = system
 "runcon -t test_sctp_deny_peer_client_t -- $basedir/sctp_client $v -e nopeer stream ::1 1035 2>&1";
     ok( $result >> 8 eq 6 );
@@ -798,7 +838,7 @@ sub test_tables {
 "runcon -t test_sctp_client_t $basedir/sctp_client $v -e nopeer seq 127.0.0.1 1035";
     ok( $result eq 0 );
 
-# Verify that a client without peer { recv } permission cannot communicate with the server SEQ->SEQ.
+# Verify that a client without packet { recv } permission cannot communicate with the server SEQ->SEQ.
     $result = system
 "runcon -t test_sctp_deny_peer_client_t -- $basedir/sctp_client $v -e nopeer seq 127.0.0.1 1035 2>&1";
     ok( $result >> 8 eq 6 );
@@ -808,7 +848,7 @@ sub test_tables {
 "runcon -t test_sctp_client_t $basedir/sctp_client $v -e nopeer seq ::1 1035";
     ok( $result eq 0 );
 
-# Verify that a client without peer { recv } permission cannot communicate with the server SEQ->SEQ.
+# Verify that a client without packet { recv } permission cannot communicate with the server SEQ->SEQ.
     $result = system
 "runcon -t test_sctp_deny_peer_client_t -- $basedir/sctp_client $v -e nopeer seq ::1 1035 2>&1";
     ok( $result >> 8 eq 6 );
-- 
2.26.2

