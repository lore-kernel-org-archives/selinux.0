Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E3FC433EF
	for <selinux@archiver.kernel.org>; Sun,  7 Nov 2021 14:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC642610A1
	for <selinux@archiver.kernel.org>; Sun,  7 Nov 2021 14:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbhKGOXv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 7 Nov 2021 09:23:51 -0500
Received: from mailomta11-sa.btinternet.com ([213.120.69.17]:53820 "EHLO
        sa-prd-fep-042.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229889AbhKGOXv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 7 Nov 2021 09:23:51 -0500
Received: from sa-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.38.8])
          by sa-prd-fep-042.btinternet.com with ESMTP
          id <20211107142107.LYXS14747.sa-prd-fep-042.btinternet.com@sa-prd-rgout-005.btmx-prd.synchronoss.net>;
          Sun, 7 Nov 2021 14:21:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1636294867; 
        bh=i6MpvVzG1+MDOgf7HpKH/l/8y7Z8nENb1rAVYqyrP8U=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=gCLq5ixx9D/4QvsiHfLZMoPrinlBDGfue6q4J65RzojhmXk+xLH3bv+DJ4u3qFRFv7d6LuriCaWT9yw5+RJ43faXK6+wBEsqaO/ihhN2xqrn4zwC4OEpuSrMpvRS+C60ifY5QgrY0B0gfyotSwboLaIwZY43pyYapk6PRBRDRDWXatgLREvysik3l9XlN6Q3SAbThCGuG0sxlDXDOXobCnAB2zCbcizY3/Gf8B1OuCsPpELdnhz7q4q3JU5vDWFZMZW2w+0sF5ImDBdH6N10HgVM0ar8LBmsk9wJ3zkrG92OXXS+GoqWUKr6WRx/IrhI1B0C67DB7MX4GXPyrFhmxg==
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 6139452E08A64490
X-Originating-IP: [109.155.32.146]
X-OWM-Source-IP: 109.155.32.146 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvuddruddtgdeivdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepuedttdelleehueeggfeihfeitdehueekffeviedtffegffeiueegleejgeevgfeinecukfhppedutdelrdduheehrdefvddrudegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepuddtledrudehhedrfedvrddugeeipdhmrghilhhfrhhomheprhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopehomhhoshhnrggtvgesrhgvughhrghtrdgtohhmpdhrtghpthhtohepphgruhhlsehprghulhdqmhhoohhrvgdrtghomhdprhgtphhtthhopehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (109.155.32.146) by sa-prd-rgout-005.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as richard_c_haines@btinternet.com)
        id 6139452E08A64490; Sun, 7 Nov 2021 14:21:06 +0000
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     omosnace@redhat.com, paul@paul-moore.com,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: [RFC PATCH 1/1] testsuite sctp: Add tests for sctp_socket transition rules
Date:   Sun,  7 Nov 2021 14:20:47 +0000
Message-Id: <20211107142047.32727-2-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211107142047.32727-1-richard_c_haines@btinternet.com>
References: <20211107142047.32727-1-richard_c_haines@btinternet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add tests for sctp_socket type_transition rules and also using
setsockcreatecon(3)

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 policy/test_sctp.te              | 57 ++++++++++++++++++++++++++++++++
 tests/sctp/sctp_client.c         | 19 +++++++++--
 tests/sctp/sctp_common.c         | 51 ++++++++++++++++++++++++++++
 tests/sctp/sctp_common.h         |  2 ++
 tests/sctp/sctp_peeloff_client.c | 21 +++++++++---
 tests/sctp/sctp_peeloff_server.c | 18 ++++++++--
 tests/sctp/sctp_server.c         | 18 ++++++++--
 tests/sctp/test                  | 57 +++++++++++++++++++++++++++++++-
 8 files changed, 231 insertions(+), 12 deletions(-)

diff --git a/policy/test_sctp.te b/policy/test_sctp.te
index 363e3c5..de82906 100644
--- a/policy/test_sctp.te
+++ b/policy/test_sctp.te
@@ -67,6 +67,11 @@ mcs_constrained(test_sctp_server_t)
 dontaudit test_sctp_server_t self:netlink_route_socket { create getattr bind };
 dontaudit test_sctp_server_t self:udp_socket { getattr connect };
 
+# Set new socket context with setsockcreatecon(3):
+type server_setsockcreatecon_newcon_t;
+unconfined_runs_test(server_setsockcreatecon_newcon_t)
+allow test_sctp_server_t server_setsockcreatecon_newcon_t:sctp_socket { create setopt write read };
+
 #
 ############################### Client #################################
 #
@@ -252,6 +257,58 @@ allow sctpsocketdomain sysctl_net_t:dir { search };
 allow sctpsocketdomain self:udp_socket { create };
 allow sctpsocketdomain self:unix_dgram_socket { create ioctl };
 
+#
+##### Test type_transition rule for sctp_socket and setsockcreatecon(3) #####
+#
+type test_sctp_new_type_client_t;
+domain_type(test_sctp_new_type_client_t)
+unconfined_runs_test(test_sctp_new_type_client_t)
+typeattribute test_sctp_new_type_client_t testdomain;
+typeattribute test_sctp_new_type_client_t sctpsocketdomain;
+allow test_sctp_new_type_client_t self:sctp_socket create_stream_socket_perms;
+allow test_sctp_server_t test_sctp_new_type_client_t:peer { recv };
+allow test_sctp_new_type_client_t test_sctp_server_t:peer { recv };
+allow test_sctp_new_type_client_t netlabel_sctp_peer_t:peer { recv };
+corenet_inout_generic_node(test_sctp_new_type_client_t)
+corenet_inout_generic_if(test_sctp_new_type_client_t)
+
+# Set new socket context with type_transition rule:
+type client_type_transition_newcon_t;
+unconfined_runs_test(client_type_transition_newcon_t)
+type_transition test_sctp_new_type_client_t test_sctp_new_type_client_t:sctp_socket client_type_transition_newcon_t;
+allow test_sctp_new_type_client_t client_type_transition_newcon_t:sctp_socket { create getopt setopt connect write read };
+corenet_sctp_connect_generic_port(client_type_transition_newcon_t)
+allow client_type_transition_newcon_t netlabel_peer_t:peer recv;
+corenet_inout_generic_node(client_type_transition_newcon_t)
+corenet_inout_generic_if(client_type_transition_newcon_t)
+
+# Set new socket context with setsockcreatecon(3):
+type client_setsockcreatecon_newcon_t;
+unconfined_runs_test(client_setsockcreatecon_newcon_t)
+allow test_sctp_new_type_client_t client_setsockcreatecon_newcon_t:sctp_socket { create getopt setopt connect write read };
+corenet_sctp_connect_generic_port(client_setsockcreatecon_newcon_t)
+
+############# Deny sctp_socket { create } tests ####################
+type test_sctp_new_type_deny_client_t;
+domain_type(test_sctp_new_type_deny_client_t)
+unconfined_runs_test(test_sctp_new_type_deny_client_t)
+typeattribute test_sctp_new_type_deny_client_t testdomain;
+typeattribute test_sctp_new_type_deny_client_t sctpsocketdomain;
+allow test_sctp_new_type_deny_client_t self:sctp_socket create_stream_socket_perms;
+allow test_sctp_server_t test_sctp_new_type_deny_client_t:peer { recv };
+allow test_sctp_new_type_deny_client_t test_sctp_server_t:peer { recv };
+
+# Deny with type_transition rule:
+type client_type_transition_newcon_deny_t;
+unconfined_runs_test(client_type_transition_newcon_deny_t)
+type_transition test_sctp_new_type_deny_client_t test_sctp_new_type_deny_client_t:sctp_socket client_type_transition_newcon_deny_t;
+allow test_sctp_new_type_deny_client_t client_type_transition_newcon_deny_t:sctp_socket { getopt setopt };
+
+# Deny with setsockcreatecon(3):
+type client_setsockcreatecon_newcon_deny_t;
+unconfined_runs_test(client_setsockcreatecon_newcon_deny_t)
+allow test_sctp_new_type_client_t client_setsockcreatecon_newcon_deny_t:sctp_socket { getopt setopt };
+
 #
 ############ Allow these domains to be entered from sysadm domain ############
 #
diff --git a/tests/sctp/sctp_client.c b/tests/sctp/sctp_client.c
index 2f527ed..ee6068a 100644
--- a/tests/sctp/sctp_client.c
+++ b/tests/sctp/sctp_client.c
@@ -3,13 +3,14 @@
 static void usage(char *progname)
 {
 	fprintf(stderr,
-		"usage:  %s [-e expected_msg] [-v] [-n] [-x] stream|seq addr port\n"
+		"usage:  %s [-e expected_msg] [-v] [-n] [-t type] [-x] stream|seq addr port\n"
 		"\nWhere:\n\t"
 
 		"-e      Optional expected message from server e.g. \"nopeer\".\n\t"
 		"        If not present the client context will be used as a\n\t"
 		"        comparison with the servers reply.\n\t"
 		"-n      Do NOT call connect(3) or connectx(3).\n\t"
+		"-t      New type for setsockcreatecon(3) test.\n\t"
 		"-v      Print context and ip options information.\n\t"
 		"-x      Use sctp_connectx(3) instead of connect(3).\n\t"
 		"stream  Use SCTP 1-to-1 style or:\n\t"
@@ -27,10 +28,10 @@ int main(int argc, char **argv)
 	char byte = 0x41, label[1024], *expected = NULL;
 	bool verbose = false, connectx = false, no_connects = false;
 	bool ipv4 = false, expect_ipopt = false;
-	char *context;
+	char *context, *sock_type = NULL;
 	struct timeval tm;
 
-	while ((opt = getopt(argc, argv, "e:vxmni")) != -1) {
+	while ((opt = getopt(argc, argv, "e:vt:xmni")) != -1) {
 		switch (opt) {
 		case 'e':
 			expected = optarg;
@@ -44,6 +45,9 @@ int main(int argc, char **argv)
 		case 'n':
 			no_connects = true;
 			break;
+		case 't':
+			sock_type = optarg;
+			break;
 		case 'x':
 			connectx = true;
 			break;
@@ -83,6 +87,15 @@ int main(int argc, char **argv)
 	if (serverinfo->ai_family == AF_INET)
 		ipv4 = true;
 
+	/* If -t option set new context for socket */
+	if (sock_type) {
+		result = set_newsock_con(sock_type, "Client");
+		if (result < 0) {
+			fprintf(stderr, "Failed setsockcreatecon(3)\n");
+			exit(2);
+		}
+	}
+
 	sock = socket(serverinfo->ai_family, serverinfo->ai_socktype,
 		      serverinfo->ai_protocol);
 	if (sock < 0) {
diff --git a/tests/sctp/sctp_common.c b/tests/sctp/sctp_common.c
index 8b65870..4b25435 100644
--- a/tests/sctp/sctp_common.c
+++ b/tests/sctp/sctp_common.c
@@ -113,6 +113,57 @@ void print_ip_option(int fd, bool ipv4, char *text)
 	}
 }
 
+/* Build new context for socket and set using setsockcreatecon(3) */
+int set_newsock_con(char *type, char *text)
+{
+	int result;
+	char *context, *newcon = NULL;
+	context_t con_t;
+
+	result = getcon(&context);
+	if (result < 0) {
+		fprintf(stderr, "Failed to get %s context\n", text);
+		return -1;
+	}
+
+	con_t = context_new(context);
+	if (!con_t) {
+		fprintf(stderr, "Unable to create context structure\n");
+		free(context);
+		return -1;
+	}
+
+	if (context_type_set(con_t, type)) {
+		fprintf(stderr, "Unable to set new socket type\n");
+		free(context);
+		free(con_t);
+		return -1;
+	}
+
+	newcon = context_str(con_t);
+	free(context);
+	free(con_t);
+	if (!newcon) {
+		fprintf(stderr, "Unable to obtain new socket context string\n");
+		return -1;
+	}
+
+	result = setsockcreatecon_raw(newcon);
+	if (result < 0) {
+		fprintf(stderr, "Failed to set new %s socket context: %s\n",
+			text, newcon);
+		free(newcon);
+		return -1;
+	}
+
+	result = getsockcreatecon_raw(&context);
+	printf("%s new socket context: %s\n", text, context);
+	free(newcon);
+	free(context);
+
+	return 0;
+}
+
 int set_subscr_events(int fd, int data_io, int assoc, int addr, int shutd)
 {
 	struct sctp_event_subscribe subscr_events;
diff --git a/tests/sctp/sctp_common.h b/tests/sctp/sctp_common.h
index cb69f70..6547dca 100644
--- a/tests/sctp/sctp_common.h
+++ b/tests/sctp/sctp_common.h
@@ -19,6 +19,7 @@
 #include <stdbool.h>
 #include <errno.h>
 #include <selinux/selinux.h>
+#include <selinux/context.h>
 
 enum event_ret {
 	EVENT_OK,
@@ -31,6 +32,7 @@ void print_context(int fd, char *text);
 void print_addr_info(struct sockaddr *sin, char *text);
 char *get_ip_option(int fd, bool ipv4, socklen_t *opt_len);
 void print_ip_option(int fd, bool ipv4, char *text);
+int set_newsock_con(char *type, char *text);
 int set_subscr_events(int fd, int data_io, int assoc, int addr, int shutd);
 int handle_event(void *buf, char *cmp_addr, sctp_assoc_t *assoc_id,
 		 bool verbose, char *text);
diff --git a/tests/sctp/sctp_peeloff_client.c b/tests/sctp/sctp_peeloff_client.c
index 2d42c72..5470494 100644
--- a/tests/sctp/sctp_peeloff_client.c
+++ b/tests/sctp/sctp_peeloff_client.c
@@ -3,13 +3,14 @@
 static void usage(char *progname)
 {
 	fprintf(stderr,
-		"usage:  %s [-e expected_msg] [-v] [-n] [-x] addr port\n"
+		"usage:  %s [-e expected_msg] [-v] [-n] [-t type] [-x] addr port\n"
 		"\nWhere:\n\t"
 
 		"-e      Optional expected message from server e.g. \"nopeer\".\n\t"
 		"        If not present the client context will be used as a\n\t"
 		"        comparison with the servers reply.\n\t"
 		"-n      Do NOT call connect(3) or connectx(3).\n\t"
+		"-t      New type for setsockcreatecon(3) test.\n\t"
 		"-v      Print context and ip options information.\n\t"
 		"-x      Use sctp_connectx(3) instead of connect(3).\n\t"
 		"addr    IPv4 or IPv6 address (e.g. 127.0.0.1 or ::1).\n\t"
@@ -28,10 +29,10 @@ int main(int argc, char **argv)
 	char byte = 0x41, label[1024], *expected = NULL;
 	bool verbose = false, connectx = false, no_connects = false;
 	bool ipv4 = false, expect_ipopt = false;
-	char *context;
+	char *context, *sock_type = NULL;
 	struct timeval tm;
 
-	while ((opt = getopt(argc, argv, "e:vxmni")) != -1) {
+	while ((opt = getopt(argc, argv, "e:t:vxmni")) != -1) {
 		switch (opt) {
 		case 'e':
 			expected = optarg;
@@ -45,6 +46,9 @@ int main(int argc, char **argv)
 		case 'n':
 			no_connects = true;
 			break;
+		case 't':
+			sock_type = optarg;
+			break;
 		case 'x':
 			connectx = true;
 			break;
@@ -187,11 +191,20 @@ int main(int argc, char **argv)
 		exit(1);
 	}
 
+	/* If -t option set new context for peeled off socket */
+	if (sock_type) {
+		result = set_newsock_con(sock_type, "Peeloff Client");
+		if (result < 0) {
+			fprintf(stderr, "Failed setsockcreatecon(3)\n");
+			exit(20);
+		}
+	}
+
 	peeloff_sk = sctp_peeloff(sock, assoc_id);
 	if (peeloff_sk < 0) {
 		perror("Client sctp_peeloff");
 		close(sock);
-		exit(1);
+		exit(21);
 	}
 	if (verbose) {
 		printf("Client sctp_peeloff(3) on sk: %d with association ID: %d\n",
diff --git a/tests/sctp/sctp_peeloff_server.c b/tests/sctp/sctp_peeloff_server.c
index bd797f2..f4347e1 100644
--- a/tests/sctp/sctp_peeloff_server.c
+++ b/tests/sctp/sctp_peeloff_server.c
@@ -3,12 +3,13 @@
 static void usage(char *progname)
 {
 	fprintf(stderr,
-		"usage:  %s [-4] [-f file] [-i] [-n] [-v] port\n"
+		"usage:  %s [-4] [-f file] [-i] [-n] [-t type] [-v] port\n"
 		"\nWhere:\n\t"
 		"-4      Listen on IPv4 addresses only.\n\t"
 		"-f      Write a line to the file when listening starts.\n\t"
 		"-i      Send IP Options as msg (default is peer label).\n\t"
 		"-n      No peer context will be available therefore send\n\t"
+		"-t      New type for setsockcreatecon(3) test.\n\t"
 		"        \"nopeer\" message to client, otherwise the peer context\n\t"
 		"        will be retrieved and sent to client.\n\t"
 		"-v      Print context and ip options information.\n\t"
@@ -24,10 +25,11 @@ int main(int argc, char **argv)
 	struct sockaddr_storage sin;
 	struct addrinfo hints, *res;
 	char *peerlabel, *context, *flag_file = NULL, msglabel[256];
+	char *sock_type = NULL;
 	bool nopeer = false,  verbose = false, ipv4 = false, snd_opt = false;
 	unsigned short port;
 
-	while ((opt = getopt(argc, argv, "4f:inv")) != -1) {
+	while ((opt = getopt(argc, argv, "4f:int:v")) != -1) {
 		switch (opt) {
 		case '4':
 			ipv4 = true;
@@ -41,6 +43,9 @@ int main(int argc, char **argv)
 		case 'n':
 			nopeer = true;
 			break;
+		case 't':
+			sock_type = optarg;
+			break;
 		case 'v':
 			verbose = true;
 			break;
@@ -162,6 +167,15 @@ int main(int argc, char **argv)
 				exit(1);
 			}
 
+			/* If -t option set new context for peeled off socket */
+			if (sock_type) {
+				result = set_newsock_con(sock_type, "Peeloff Server");
+				if (result < 0) {
+					fprintf(stderr, "Failed setsockcreatecon(3)\n");
+					exit(1);
+				}
+			}
+
 			peeloff_sk = sctp_peeloff(sock, assoc_id);
 			if (peeloff_sk < 0) {
 				perror("Server sctp_peeloff");
diff --git a/tests/sctp/sctp_server.c b/tests/sctp/sctp_server.c
index c53f46f..2a99dd0 100644
--- a/tests/sctp/sctp_server.c
+++ b/tests/sctp/sctp_server.c
@@ -3,7 +3,7 @@
 static void usage(char *progname)
 {
 	fprintf(stderr,
-		"usage:  %s [-4] [-b ipv4_addr] [-f file] [-h addr] [-i] [-n] [-v] stream|seq port\n"
+		"usage:  %s [-4] [-b ipv4_addr] [-f file] [-h addr] [-i] [-n] [-t type] [-v] stream|seq port\n"
 		"\nWhere:\n\t"
 		"-4      Listen on IPv4 addresses only (used for CIPSO tests).\n\t"
 		"-b      Call sctp_bindx(3) with the supplied IPv4 address.\n\t"
@@ -14,6 +14,7 @@ static void usage(char *progname)
 		"-i      Send IP Options as msg (default is peer label).\n\t"
 		"-n      No peer label or IP option will be available therefore\n\t"
 		"        send \"nopeer\" message to client.\n\t"
+		"-t      New type for setsockcreatecon(3) test.\n\t"
 		"-v      Print context and ip options information.\n\t"
 		"stream  Use SCTP 1-to-1 style or:\n\t"
 		"seq     use SCTP 1-to-Many style.\n\t"
@@ -33,10 +34,11 @@ int main(int argc, char **argv)
 	char byte, *peerlabel, msglabel[1024], if_name[30];
 	bool nopeer = false,  verbose = false,  ipv4 = false, snd_opt = false;
 	char *context, *host_addr = NULL, *bindx_addr = NULL, *flag_file = NULL;
+	char *sock_type = NULL;
 	struct sockaddr_in ipv4_addr;
 	unsigned short port;
 
-	while ((opt = getopt(argc, argv, "4b:f:h:inv")) != -1) {
+	while ((opt = getopt(argc, argv, "4b:f:h:int:v")) != -1) {
 		switch (opt) {
 		case '4':
 			ipv4 = true;
@@ -56,6 +58,9 @@ int main(int argc, char **argv)
 		case 'n':
 			nopeer = true;
 			break;
+		case 't':
+			sock_type = optarg;
+			break;
 		case 'v':
 			verbose = true;
 			break;
@@ -120,6 +125,15 @@ int main(int argc, char **argv)
 		exit(1);
 	}
 
+	/* If -t option set new context for socket */
+	if (sock_type) {
+		result = set_newsock_con(sock_type, "Server");
+		if (result < 0) {
+			fprintf(stderr, "Failed setsockcreatecon(3)\n");
+			exit(2);
+		}
+	}
+
 	sock = socket(res->ai_family, res->ai_socktype, res->ai_protocol);
 	if (sock < 0) {
 		perror("Server socket");
diff --git a/tests/sctp/test b/tests/sctp/test
index d4357ed..53111c1 100755
--- a/tests/sctp/test
+++ b/tests/sctp/test
@@ -33,7 +33,7 @@ BEGIN {
         plan skip_all => "SCTP not supported";
     }
     else {
-        $test_count = 85;
+        $test_count = 90;
 
         # Set up a GRE tunnel over loopback to ensure we have enough addresses
         # for the ASCONF tests.
@@ -1046,6 +1046,61 @@ if ($test_nft) {
     system "nft -f $basedir/nftables-flush";
 }
 
+#
+## Tests for 'sctp_socket' using type_transition rule and setsockcreatecon(3)
+#
+print "# Testing type_transition rule and setsockcreatecon(3)\n";
+
+# Start the stream server.
+$pid =
+  server_start( "-t test_sctp_server_t", "sctp_server", "$v -n stream 1035" );
+
+# Set a new context on the socket using setsockcreatecon(3):
+$result = system
+"runcon -t test_sctp_new_type_client_t $basedir/sctp_client $v -t client_setsockcreatecon_newcon_t -e nopeer stream 127.0.0.1 1035";
+ok( $result eq 0 );
+
+# Kill the stream server.
+server_end($pid);
+
+$pid =
+  server_start( "-t test_sctp_server_t", "sctp_server", "$v -n -4 seq 1035" );
+
+# Set a new context on the peeled off socket using setsockcreatecon(3):
+$result = system
+"runcon -t test_sctp_new_type_client_t $basedir/sctp_peeloff_client $v -t client_setsockcreatecon_newcon_t -e nopeer 127.0.0.1 1035";
+ok( $result eq 0 );
+
+# Deny sctp_socket { create } using setsockcreatecon(3) on the peeled off socket.
+$result = system
+"runcon -t test_sctp_new_type_client_t $basedir/sctp_peeloff_client $v -t client_setsockcreatecon_newcon_deny_t -e nopeer 127.0.0.1 1035";
+ok( $result >> 8 eq 21 );
+
+# Deny sctp_socket { create } for the type_transition rule.
+$result = system
+"runcon -t test_sctp_new_type_deny_client_t $basedir/sctp_peeloff_client $v -t client_setsockcreatecon_newcon_deny_t -e nopeer 127.0.0.1 1035";
+ok( $result >> 8 eq 3 );
+
+# Kill the stream server.
+server_end($pid);
+
+# Set a new context on the server peeled off socket using setsockcreatecon(3)
+# Note: to check that the peeled off context has changed, run locally that
+# will show socket contexts.
+$pid = server_start(
+    "-t test_sctp_server_t",
+    "sctp_peeloff_server",
+    "$v -t server_setsockcreatecon_newcon_t -n -4 1035",
+);
+
+# Verify that client can communicate with the server.
+$result = system
+"runcon -t test_sctp_new_type_client_t $basedir/sctp_client $v -e nopeer seq 127.0.0.1 1035";
+ok( $result eq 0 );
+
+# Kill the seq server.
+server_end($pid);
+
 system "ip link del mygre";
 
 exit;
-- 
2.33.1

