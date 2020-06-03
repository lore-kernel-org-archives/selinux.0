Return-Path: <SRS0=TAN+=7Q=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92684C433DF
	for <selinux@archiver.kernel.org>; Wed,  3 Jun 2020 11:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E9FC2067B
	for <selinux@archiver.kernel.org>; Wed,  3 Jun 2020 11:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="NhONTBIg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbgFCLBG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 3 Jun 2020 07:01:06 -0400
Received: from mailomta3-re.btinternet.com ([213.120.69.96]:38938 "EHLO
        re-prd-fep-041.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725828AbgFCLBE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 3 Jun 2020 07:01:04 -0400
Received: from re-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.54.4])
          by re-prd-fep-041.btinternet.com with ESMTP
          id <20200603110053.GWSI30588.re-prd-fep-041.btinternet.com@re-prd-rgout-001.btmx-prd.synchronoss.net>;
          Wed, 3 Jun 2020 12:00:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1591182053; 
        bh=wrArSJBi+zjt/qRVgtnx605Pp5J47jfX1P/AwK13gFc=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=NhONTBIgMM0MJ5KcplCQ0sTewQdBXzBpOD5gq1IcKd9aGyPiQAuwY6uCcq6NBGgstaKFl09wzuaVD1bgin7q9R4pWv1Veg2LOSO8hfrmbp8ydlMr1Abev7hy50koakNFf81dq0dzpGOGMfaINYKc4KppnAKkERG0uijSazcnh95WTFwLp4DQrRU2kXW0MrjpMtn778T/KP0gdVCxjHG9REvXMoRNVA5/e5998SwxrrmL8WwuheE62IrIMDBbw0F4Vg6irhuP5R3/bGZVeqiuD2U6YBu9tYmOhBSSBMjdjeeeV4ipXLLXQRylWkQsIveuxxZg1kc//d1L9In9E8xXdg==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [86.190.32.74]
X-OWM-Source-IP: 86.190.32.74 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduhedrudefledgvdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpeelteffgeevveejheevhfetgfeuveduteetuddtffdvjeekieetgeehveefjedtfeenucfkphepkeeirdduledtrdefvddrjeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudeltddrfedvrdejgedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuqfftvefrvfeprhhftgekvddvnehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (86.190.32.74) by re-prd-rgout-001.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5E3A147D13DE71BB; Wed, 3 Jun 2020 12:00:52 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH] selinux-testsuite: Review and rework sctp tests
Date:   Wed,  3 Jun 2020 12:00:48 +0100
Message-Id: <20200603110048.19293-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.25.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The main changes have been to sctp_asconf_params_client.c and
sctp_asconf_params_server.c to make them more reliable for running the
client and server on different systems.

Updated common code in sctp_common.c

Removed obsolete code that was used to test permissions that never made it
to the final commit.

Also reviewed and updated tests to check policy rules for denying
access to all possible net/sctp kernel hooks as described in the kernel
Documentation/security/SCTP.rst

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 policy/test_sctp.te                    |  98 ++++--
 tests/sctp/.gitignore                  |   3 -
 tests/sctp/Makefile                    |   2 +-
 tests/sctp/sctp_asconf_params_client.c | 320 ++++++++-----------
 tests/sctp/sctp_asconf_params_server.c | 269 +++++++++-------
 tests/sctp/sctp_client.c               |   4 +-
 tests/sctp/sctp_common.c               | 189 ++++++++++-
 tests/sctp/sctp_common.h               |  12 +-
 tests/sctp/sctp_connectx.c             |  33 +-
 tests/sctp/sctp_peeloff_server.c       |  42 +--
 tests/sctp/sctp_server.c               |   4 +-
 tests/sctp/sctp_set_params.c           | 205 ------------
 tests/sctp/sctp_set_peer_addr.c        | 415 -------------------------
 tests/sctp/sctp_set_pri_addr.c         | 135 --------
 tests/sctp/test                        |  95 +++++-
 15 files changed, 688 insertions(+), 1138 deletions(-)
 delete mode 100644 tests/sctp/sctp_set_params.c
 delete mode 100644 tests/sctp/sctp_set_peer_addr.c
 delete mode 100644 tests/sctp/sctp_set_pri_addr.c

diff --git a/policy/test_sctp.te b/policy/test_sctp.te
index 3b16db1..380e442 100644
--- a/policy/test_sctp.te
+++ b/policy/test_sctp.te
@@ -60,6 +60,12 @@ corenet_sctp_bind_all_nodes(test_sctp_server_t)
 corenet_inout_generic_node(test_sctp_server_t)
 corenet_inout_generic_if(test_sctp_server_t)
 
+# Don't allow ports < 1024
+# neverallow test_sctp_server_t self:capability net_bind_service
+# neverallow test_sctp_server_t reserved_port_t:sctp_socket name_bind;
+dontaudit test_sctp_server_t self:netlink_route_socket { create getattr bind };
+dontaudit test_sctp_server_t self:udp_socket { getattr connect };
+
 #
 ############################### Client #################################
 #
@@ -85,7 +91,11 @@ typeattribute test_sctp_deny_peer_client_t testdomain;
 typeattribute test_sctp_deny_peer_client_t sctpsocketdomain;
 allow test_sctp_deny_peer_client_t self:sctp_socket create_stream_socket_perms;
 corenet_inout_generic_node(test_sctp_deny_peer_client_t)
-corenet_inout_generic_if(deny_assoc_sctp_peer_t)
+corenet_inout_generic_if(test_sctp_deny_peer_client_t)
+allow test_sctp_deny_peer_client_t test_sctp_server_packet_t:packet { send };
+allow test_sctp_server_t test_sctp_deny_peer_client_t:peer { recv };
+# neverallow test_sctp_deny_peer_client_t netlabel_sctp_peer_t:peer { recv };
+# neverallow test_sctp_deny_peer_client_t test_sctp_server_packet_t:packet { recv };
 
 #
 ####################### Deny association permission #########################
@@ -117,11 +127,20 @@ unconfined_runs_test(test_sctp_connectx_t)
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
@@ -132,27 +151,68 @@ unconfined_runs_test(test_sctp_bindx_t)
 typeattribute test_sctp_bindx_t testdomain;
 typeattribute test_sctp_bindx_t sctpsocketdomain;
 allow test_sctp_bindx_t self:sctp_socket create_stream_socket_perms;
-allow test_sctp_server_t test_sctp_bindx_t:peer { recv };
-allow test_sctp_bindx_t test_sctp_server_t:peer { recv };
 corenet_sctp_bind_all_nodes(test_sctp_bindx_t)
 corenet_inout_generic_node(test_sctp_bindx_t)
-corenet_inout_generic_if(test_sctp_bindx_t)
 
 #
-########## SET_PRI_ADDR + SET_PEER ADDR for ASCONF process testing ##########
+############################## Deny Bindx ###################################
 #
-type test_sctp_set_peer_addr_t;
-domain_type(test_sctp_set_peer_addr_t)
-unconfined_runs_test(test_sctp_set_peer_addr_t)
-typeattribute test_sctp_set_peer_addr_t testdomain;
-typeattribute test_sctp_set_peer_addr_t sctpsocketdomain;
-allow test_sctp_set_peer_addr_t self:sctp_socket create_stream_socket_perms;
-allow test_sctp_server_t test_sctp_set_peer_addr_t:peer { recv };
-allow test_sctp_set_peer_addr_t test_sctp_server_t:peer { recv };
-corenet_sctp_bind_all_nodes(test_sctp_set_peer_addr_t)
-corenet_inout_generic_node(test_sctp_set_peer_addr_t)
-corenet_inout_generic_if(test_sctp_set_peer_addr_t)
+type test_sctp_deny_bindx_t;
+domain_type(test_sctp_deny_bindx_t)
+unconfined_runs_test(test_sctp_deny_bindx_t)
+typeattribute test_sctp_deny_bindx_t testdomain;
+typeattribute test_sctp_deny_bindx_t sctpsocketdomain;
+allow test_sctp_deny_bindx_t self:sctp_socket { create ioctl read getattr write getopt setopt };
+corenet_sctp_bind_all_nodes(test_sctp_deny_bindx_t)
+corenet_inout_generic_node(test_sctp_deny_bindx_t)
 
+#
+########## SET_PRI_ADDR + SET_PEER ADDR for ASCONF process testing ##########
+#
+type sctp_asconf_params_server_t;
+domain_type(sctp_asconf_params_server_t)
+unconfined_runs_test(sctp_asconf_params_server_t)
+typeattribute sctp_asconf_params_server_t testdomain;
+typeattribute sctp_asconf_params_server_t sctpsocketdomain;
+allow sctp_asconf_params_server_t self:sctp_socket { create listen bind ioctl read getattr write getopt setopt };
+corenet_sctp_bind_all_nodes(sctp_asconf_params_server_t)
+corenet_inout_generic_node(sctp_asconf_params_server_t)
+
+#
+############################# ASCONF Client ##############################
+#
+type sctp_asconf_params_client_t;
+domain_type(sctp_asconf_params_client_t)
+unconfined_runs_test(sctp_asconf_params_client_t)
+typeattribute sctp_asconf_params_client_t testdomain;
+typeattribute sctp_asconf_params_client_t sctpsocketdomain;
+allow sctp_asconf_params_client_t self:sctp_socket { create connect ioctl read getattr write getopt setopt };
+corenet_inout_generic_node(sctp_asconf_params_client_t)
+corenet_sctp_bind_generic_node(sctp_asconf_params_client_t)
+corenet_inout_generic_if(sctp_asconf_params_client_t)
+
+# net/sctp/sm_make_chunk.c sctp_process_asconf_param() SCTP_PARAM_ADD_IP and SCTP_PARAM_SET_PRIMARY
+allow sctp_asconf_params_server_t sctp_asconf_params_client_t:sctp_socket { connect };
+# net/sctp/socket.c sctp_setsockopt_primary_addr() SCTP_PRIMARY_ADDR
+allow sctp_asconf_params_client_t self:sctp_socket bind;
+
+#
+################## ASCONF Client - Deny SCTP_PRIMARY_ADDR ####################
+#
+type sctp_asconf_deny_pri_addr_client_t;
+domain_type(sctp_asconf_deny_pri_addr_client_t)
+unconfined_runs_test(sctp_asconf_deny_pri_addr_client_t)
+typeattribute sctp_asconf_deny_pri_addr_client_t testdomain;
+typeattribute sctp_asconf_deny_pri_addr_client_t sctpsocketdomain;
+allow sctp_asconf_deny_pri_addr_client_t self:sctp_socket { create connect ioctl read getattr write getopt setopt };
+corenet_inout_generic_node(sctp_asconf_deny_pri_addr_client_t)
+corenet_sctp_bind_generic_node(sctp_asconf_deny_pri_addr_client_t)
+corenet_inout_generic_if(sctp_asconf_deny_pri_addr_client_t)
+
+# net/sctp/sm_make_chunk.c sctp_process_asconf_param() SCTP_PARAM_ADD_IP and SCTP_PARAM_SET_PRIMARY
+allow sctp_asconf_params_server_t sctp_asconf_deny_pri_addr_client_t:sctp_socket { connect };
+# net/sctp/socket.c sctp_setsockopt_primary_addr() SCTP_PRIMARY_ADDR
+# neverallow sctp_asconf_deny_pri_addr_client_t self:sctp_socket bind;
 #
 ######################### SECMARK-specific policy ############################
 #
diff --git a/tests/sctp/.gitignore b/tests/sctp/.gitignore
index d0633fe..c022b11 100644
--- a/tests/sctp/.gitignore
+++ b/tests/sctp/.gitignore
@@ -6,6 +6,3 @@ sctp_client
 sctp_connectx
 sctp_peeloff_server
 sctp_server
-sctp_set_params
-sctp_set_peer_addr
-sctp_set_pri_addr
diff --git a/tests/sctp/Makefile b/tests/sctp/Makefile
index 1debf82..b96a1e9 100644
--- a/tests/sctp/Makefile
+++ b/tests/sctp/Makefile
@@ -1,4 +1,4 @@
-TARGETS = sctp_client sctp_server sctp_bind sctp_bindx sctp_connectx sctp_set_params sctp_set_peer_addr sctp_set_pri_addr sctp_asconf_params_client sctp_asconf_params_server sctp_peeloff_server
+TARGETS = sctp_client sctp_server sctp_bind sctp_bindx sctp_connectx sctp_asconf_params_client sctp_asconf_params_server sctp_peeloff_server
 
 DEPS = sctp_common.c sctp_common.h
 CFLAGS ?= -Wall
diff --git a/tests/sctp/sctp_asconf_params_client.c b/tests/sctp/sctp_asconf_params_client.c
index 12522f3..537cd71 100644
--- a/tests/sctp/sctp_asconf_params_client.c
+++ b/tests/sctp/sctp_asconf_params_client.c
@@ -29,11 +29,9 @@
 static void usage(char *progname)
 {
 	fprintf(stderr,
-		"usage:  %s [-v] [-n] addr port\n"
+		"usage:  %s [-v] addr port\n"
 		"\nWhere:\n\t"
 		"-v     Print status information.\n\t"
-		"-n     No bindx_rem will be received from server. This happens\n\t"
-		"       when the client and server are on different systems.\n\t"
 		"addr   IPv4 or IPv6 address (MUST NOT be loopback address).\n\t"
 		"port   port.\n", progname);
 
@@ -46,75 +44,88 @@ static void usage(char *progname)
 	exit(1);
 }
 
-static int peer_count, peer_count_err;
-static void getpaddrs_alarm(int sig)
-{
-	fprintf(stderr,
-		"Get peer address count timer expired - carry on test\n");
-	peer_count += 1;
-	peer_count_err = true;
-}
-
-static void getprimaddr_alarm(int sig)
-{
-	fprintf(stderr, "Get primary address timer expired - end test.\n");
-	exit(1);
-}
-
-static void get_primaddr(char *addr_buf, int socket)
+static int get_set_primaddr(int socket, sctp_assoc_t id, bool verbose)
 {
 	int result;
-	struct sctp_prim prim;
-	struct sockaddr_in *in_addr;
-	struct sockaddr_in6 *in6_addr;
-	struct sockaddr *paddr;
+	struct sctp_prim prim;	/* Defined in linux/sctp.t */
 	socklen_t prim_len;
-	const char *addr_ptr = NULL;
 
 	memset(&prim, 0, sizeof(struct sctp_prim));
 	prim_len = sizeof(struct sctp_prim);
+	prim.ssp_assoc_id = id;
 
 	result = getsockopt(socket, IPPROTO_SCTP, SCTP_PRIMARY_ADDR,
 			    &prim, &prim_len);
 	if (result < 0) {
-		perror("getsockopt: SCTP_PRIMARY_ADDR");
-		exit(1);
+		perror("Client getsockopt: SCTP_PRIMARY_ADDR");
+		return 50;
 	}
 
-	paddr = (struct sockaddr *)&prim.ssp_addr;
-	if (paddr->sa_family == AF_INET) {
-		in_addr = (struct sockaddr_in *)&prim.ssp_addr;
-		addr_ptr = inet_ntop(AF_INET, &in_addr->sin_addr, addr_buf,
-				     INET6_ADDRSTRLEN);
-	} else if (paddr->sa_family == AF_INET6) {
-		in6_addr = (struct sockaddr_in6 *)&prim.ssp_addr;
-		addr_ptr = inet_ntop(AF_INET6, &in6_addr->sin6_addr, addr_buf,
-				     INET6_ADDRSTRLEN);
+	if (verbose)
+		print_addr_info((struct sockaddr *)&prim.ssp_addr,
+				"Client getsockopt - SCTP_PRIMARY_ADDR:");
+
+	/*
+	 * If the new primary address is an IPv6 local link address, it will
+	 * have been received by the DAR process with a scope id of '0'.
+	 * Therefore when the setsockopt is called it will error with EINVAL.
+	 * To resolve this add a scope id '1' before the call. As the test
+	 * exits after this point and the address is never used, not an issue.
+	 * Note: sin6_scope_id for local links is a network interface index
+	 * returned by if_nametoindex(3).
+	 */
+	struct sockaddr_in6 *addr6;
+	struct sockaddr *sin;
+
+	sin = (struct sockaddr *)&prim.ssp_addr;
+
+	if (sin->sa_family == AF_INET6) {
+		addr6 = (struct sockaddr_in6 *)sin;
+		if (IN6_IS_ADDR_LINKLOCAL(&addr6->sin6_addr) &&
+		    ((struct sockaddr_in6 *)addr6)->sin6_scope_id == 0)
+			((struct sockaddr_in6 *)addr6)->sin6_scope_id = 1;
+
+		if (verbose)
+			printf("Client set new primary address scope_id=1\n");
 	}
-	if (!addr_ptr) {
-		perror("inet_ntop");
-		exit(1);
+
+	/*
+	 * This tests the net/sctp/socket.c sctp_setsockopt_primary_addr()
+	 * SCTP_PRIMARY_ADDR function by setting policy to:
+	 *   allow sctp_asconf_params_client_t self:sctp_socket { bind };
+	 * or:
+	 *   neverallow sctp_asconf_params_client_t self:sctp_socket { bind };
+	 */
+	result = setsockopt(socket, IPPROTO_SCTP, SCTP_PRIMARY_ADDR,
+			    &prim, prim_len);
+	if (result < 0) {
+		perror("Client setsockopt: SCTP_PRIMARY_ADDR");
+		return 51;
 	}
+	if (verbose)
+		print_addr_info((struct sockaddr *)&prim.ssp_addr,
+				"Client set SCTP_PRIMARY_ADDR to:");
+	return 0;
 }
 
 int main(int argc, char **argv)
 {
-	int opt, client_sock, result, len;
+	int opt, client_sock, result, flags = 0, on = 1;
 	struct addrinfo client_hints, *client_res;
-	struct sockaddr *paddrs;
-	bool verbose = false, no_bindx_rem = false;
-	char client_prim_addr1[INET6_ADDRSTRLEN];
-	char client_prim_addr2[INET6_ADDRSTRLEN];
-	char buffer[1024];
-
-	while ((opt = getopt(argc, argv, "vn")) != -1) {
+	struct sctp_sndrcvinfo sinfo;
+	struct sockaddr_storage sin;
+	socklen_t sinlen = sizeof(sin);
+	struct timeval tm;
+	bool verbose = false;
+	char buffer[512];
+	char msg[] = "Send peer address";
+	char *rcv_new_addr_buf = NULL;
+
+	while ((opt = getopt(argc, argv, "v")) != -1) {
 		switch (opt) {
 		case 'v':
 			verbose = true;
 			break;
-		case 'n':
-			no_bindx_rem = true;
-			break;
 		default:
 			usage(argv[0]);
 		}
@@ -123,176 +134,117 @@ int main(int argc, char **argv)
 	if ((argc - optind) != 2)
 		usage(argv[0]);
 
-	/* Set up client side and connect */
 	memset(&client_hints, 0, sizeof(struct addrinfo));
-	client_hints.ai_socktype = SOCK_STREAM;
+	client_hints.ai_socktype = SOCK_SEQPACKET;
 	client_hints.ai_protocol = IPPROTO_SCTP;
 	result = getaddrinfo(argv[optind], argv[optind + 1],
 			     &client_hints, &client_res);
 	if (result < 0) {
-		fprintf(stderr, "getaddrinfo - client: %s\n",
+		fprintf(stderr, "Client getaddrinfo err: %s\n",
 			gai_strerror(result));
 		exit(1);
 	}
 
-
-	/* printf("Client scopeID: %d\n",
-	 *        ((struct sockaddr_in6 *)client_res->ai_addr)->sin6_scope_id);
-	 */
-
 	client_sock = socket(client_res->ai_family, client_res->ai_socktype,
 			     client_res->ai_protocol);
 	if (client_sock < 0) {
-		perror("socket");
+		perror("Client socket");
+		freeaddrinfo(client_res);
 		exit(1);
 	}
 
-	result = connect(client_sock, client_res->ai_addr,
-			 client_res->ai_addrlen);
+	/* Need to set a timeout if no reply from server */
+	memset(&tm, 0, sizeof(struct timeval));
+	tm.tv_sec = 1;
+	result = setsockopt(client_sock, SOL_SOCKET, SO_RCVTIMEO, &tm, sizeof(tm));
 	if (result < 0) {
-		if (errno != EINPROGRESS)
-			perror("connect");
-		else
-			fprintf(stderr, "connect timeout\n");
-
-		close(client_sock);
-		exit(1);
+		perror("Client setsockopt: SO_RCVTIMEO");
+		goto err1;
 	}
 
-	/* Get number of peer addresses on CLIENT (should be 1) for a check
-	 * later as sctp_bindx SERVER -> CLIENT is non-blocking.
-	 */
-	peer_count = sctp_getpaddrs(client_sock, 0, &paddrs);
-	sctp_freepaddrs(paddrs);
-	len = sprintf(buffer, "Client peer address count: %d", peer_count);
-	if (verbose)
-		printf("%s\n", buffer);
-
-
-	/* Get initial CLIENT primary address (that should be ADDR1). */
-	get_primaddr(client_prim_addr1, client_sock);
-
-	/* server waiting for write before sending BINDX_ADD */
-	result = write(client_sock, buffer, len);
+	result = setsockopt(client_sock, SOL_SOCKET, SO_SNDTIMEO, &tm, sizeof(tm));
 	if (result < 0) {
-		perror("write");
-		close(client_sock);
-		exit(1);
+		perror("Client setsockopt: SO_SNDVTIMEO");
+		goto err1;
 	}
 
-	/* Sleep a while as server pings us the new address */
-	sleep(1);
-	/* then set an alarm and check number of peer addresses for CLIENT */
-	signal(SIGALRM, getpaddrs_alarm);
-	alarm(2);
-	peer_count_err = false;
-	result = 0;
-
-	while (result != peer_count + 1) {
-		result = sctp_getpaddrs(client_sock, 0, &paddrs);
-		if (result > 0)
-			sctp_freepaddrs(paddrs);
-
-		if (peer_count_err)
-			break;
+	result = connect(client_sock, client_res->ai_addr,
+			 client_res->ai_addrlen);
+	if (result < 0) {
+		perror("Client connect");
+		goto err1;
 	}
-	alarm(0);
-	peer_count = result;
 
-	len = sprintf(buffer, "Client peer address count: %d", result);
-	if (verbose)
-		printf("%s\n", buffer);
-
-	/* server waiting for write before send SCTP_SET_PEER_PRIMARY_ADDR */
-	result = write(client_sock, buffer, len);
+	result = set_subscr_events(client_sock, on, on, on, on);
 	if (result < 0) {
-		perror("write");
-		close(client_sock);
-		exit(1);
+		perror("Client setsockopt SCTP_EVENTS");
+		goto err1;
 	}
 
-	/* Now get the new primary address from the client */
-	signal(SIGALRM, getprimaddr_alarm);
-	alarm(2);
-	memcpy(client_prim_addr2, client_prim_addr1, INET6_ADDRSTRLEN);
-
-	while (!strcmp(client_prim_addr1, client_prim_addr2))
-		get_primaddr(client_prim_addr2, client_sock);
-
-	alarm(0);
-	len = sprintf(buffer,
-		      "Client initial SCTP_PRIMARY_ADDR: %s\nClient current SCTP_PRIMARY_ADDR: %s",
-		      client_prim_addr1, client_prim_addr2);
-	if (verbose)
-		printf("%s\n", buffer);
+	/* Send msg to form an association with server */
+	result = sctp_sendmsg(client_sock, msg, sizeof(msg),
+			      client_res->ai_addr,
+			      client_res->ai_addrlen,
+			      0, 0, 0, 0, 0);
+	if (result < 0) {
+		perror("Client sctp_sendmsg-1");
+		goto err1;
+	}
 
-	if (!no_bindx_rem) {
-		/* Let server send bindx_rem */
-		result = write(client_sock, buffer, len);
-		if (result < 0) {
-			perror("write");
-			close(client_sock);
-			exit(1);
+	rcv_new_addr_buf = NULL;
+	memset(&sinfo, 0, sizeof(struct sctp_sndrcvinfo));
+	/*
+	 * Should receive notifications for initial addr change, then
+	 * the address to match against from the server, then change to new
+	 * peer addr and finally exit.
+	 */
+	while (1) {
+		memset(buffer, 0, sizeof(buffer));
+
+		result = sctp_recvmsg(client_sock, buffer,
+				      sizeof(buffer),
+				      (struct sockaddr *)&sin,
+				      &sinlen, &sinfo, &flags);
+		if (result < 0 && errno == EAGAIN) {
+			result = EAGAIN;
+			fprintf(stderr, "Client error 'Dynamic Address Reconfiguration'\n");
+			goto end;
+		} else if (result < 0) {
+			perror("Client sctp_recvmsg-1");
+			goto err1;
 		}
 
-		/* Then delete addr that checks ASCONF - SCTP_PARAM_DEL_IP */
-		if (!peer_count_err) {
-			signal(SIGALRM, getprimaddr_alarm);
-			alarm(2);
-			result = 0;
-			while (result != peer_count - 1) {
-				result = sctp_getpaddrs(client_sock,
-							0, &paddrs);
-				if (result > 0)
-					sctp_freepaddrs(paddrs);
-
-				if (peer_count_err)
-					break;
-			}
-			alarm(0);
-			sprintf(buffer, "Client peer address count: %d",
-				result);
+		if (sinfo.sinfo_assoc_id) {
 			if (verbose)
-				printf("%s\n", buffer);
+				printf("Client assoc_id: %d\n",
+				       sinfo.sinfo_assoc_id);
 		}
-	}
-
-	/* server waiting for client peer address count */
-	result = write(client_sock, buffer, len);
-	if (result < 0) {
-		perror("write");
-		close(client_sock);
-		exit(1);
-	}
-
-	/* Compare the client primary addresses, they should be different. */
-	if (!strcmp(client_prim_addr1, client_prim_addr2)) {
-		len = sprintf(buffer,
-			      "Client ADDR1: %s same as ADDR2: %s - SCTP_SET_PEER_PRIMARY_ADDR failed",
-			      client_prim_addr1, client_prim_addr2);
-		fprintf(stderr, "%s\n", buffer);
+		if (flags & MSG_NOTIFICATION && flags & MSG_EOR) {
+			result = handle_event(buffer, rcv_new_addr_buf,
+					      NULL, verbose, "Client");
+			if (result == EVENT_ADDR_MATCH) /* Have new primary addr */
+				break;
+		} else { /* Should receive only one buffer from server */
+			if (verbose)
+				printf("Client received new pri addr: %s\n",
+				       buffer);
 
-		/* server waiting for write to finish */
-		result = write(client_sock, buffer, len);
-		if (result < 0) {
-			perror("write");
-			close(client_sock);
+			rcv_new_addr_buf = strdup(buffer);
 		}
-		exit(1);
 	}
 
-	len = sprintf(buffer, "Client primary address changed successfully\n");
-	if (verbose)
-		printf("%s\n", buffer);
-
-	/* server waiting for write to finish */
-	result = write(client_sock, buffer, len);
-	if (result < 0) {
-		perror("write");
-		close(client_sock);
-		exit(1);
-	}
+	/* Get new CLIENT primary address */
+	result = get_set_primaddr(client_sock, sinfo.sinfo_assoc_id, verbose);
+	if (result > 0)
+		goto end;
 
+	result = 0;
+end:
 	close(client_sock);
-	exit(0);
+	freeaddrinfo(client_res);
+	free(rcv_new_addr_buf);
+	return result;
+err1:
+	result = -1;
+	goto end;
 }
diff --git a/tests/sctp/sctp_asconf_params_server.c b/tests/sctp/sctp_asconf_params_server.c
index ff7473b..da12d8b 100644
--- a/tests/sctp/sctp_asconf_params_server.c
+++ b/tests/sctp/sctp_asconf_params_server.c
@@ -22,16 +22,18 @@ static void usage(char *progname)
 
 int main(int argc, char **argv)
 {
-	int opt, srv_sock, new_sock, result, on = 1;
+	int opt, srv_sock, result, on = 1, flags = 0, if_index = 0;
+	size_t new_len;
 	struct addrinfo srv_hints, *srv_res;
 	struct addrinfo *new_pri_addr_res;
 	struct sockaddr *sa_ptr;
-	socklen_t sinlen;
 	struct sockaddr_storage sin;
+	socklen_t sinlen = sizeof(sin);
 	struct sctp_setpeerprim setpeerprim;
+	struct sctp_sndrcvinfo sinfo;
 	bool verbose = false, is_ipv6 = false;
-	char buffer[128];
-	char *flag_file = NULL;
+	char buffer[512];
+	char *flag_file = NULL, *ptr, if_name[30], *new_pri_addr = NULL;
 
 	while ((opt = getopt(argc, argv, "f:v")) != -1) {
 		switch (opt) {
@@ -62,191 +64,226 @@ int main(int argc, char **argv)
 
 	memset(&srv_hints, 0, sizeof(struct addrinfo));
 	srv_hints.ai_flags = AI_PASSIVE;
-	srv_hints.ai_socktype = SOCK_STREAM;
+	srv_hints.ai_socktype = SOCK_SEQPACKET;
 	srv_hints.ai_protocol = IPPROTO_SCTP;
 
+	/* If local link, get if_name & if_index */
+	if (is_ipv6) {
+		ptr = strpbrk(argv[optind], "%");
+		if (ptr) {
+			strcpy(if_name, ptr + 1);
+			if_index = if_nametoindex(if_name);
+			if (!if_index) {
+				perror("Server if_nametoindex");
+				exit(1);
+			}
+			if (verbose)
+				printf("if_name: %s if_index: %d\n",
+				       if_name, if_index);
+		}
+	}
+
+	/* Now remove % if on new peer */
+	new_len = strcspn(argv[optind + 1], "%");
+	new_pri_addr = strndup(argv[optind + 1], new_len);
+
 	/* Set up server side */
 	result = getaddrinfo(argv[optind], argv[optind + 2],
 			     &srv_hints, &srv_res);
 	if (result < 0) {
-		fprintf(stderr, "getaddrinfo - server: %s\n",
+		fprintf(stderr, "Server getaddrinfo err: %s\n",
 			gai_strerror(result));
 		exit(1);
 	}
 	if (is_ipv6 && verbose)
-		printf("Server scopeID: %d\n",
+		printf("Server address: %s has scopeID: %d\n", argv[optind],
 		       ((struct sockaddr_in6 *)
 			srv_res->ai_addr)->sin6_scope_id);
 
 	srv_sock = socket(srv_res->ai_family, srv_res->ai_socktype,
 			  srv_res->ai_protocol);
 	if (srv_sock < 0) {
-		perror("socket - server");
+		perror("Server socket");
+		freeaddrinfo(srv_res);
 		exit(1);
 	}
 
 	result = setsockopt(srv_sock, SOL_SOCKET, SO_REUSEADDR, &on,
 			    sizeof(on));
 	if (result < 0) {
-		perror("setsockopt: SO_REUSEADDR");
-		close(srv_sock);
-		exit(1);
+		perror("Server setsockopt: SO_REUSEADDR");
+		goto err1;
 	}
 
-	result = bind(srv_sock, srv_res->ai_addr, srv_res->ai_addrlen);
+	result = sctp_bindx(srv_sock, srv_res->ai_addr, 1, SCTP_BINDX_ADD_ADDR);
 	if (result < 0) {
-		perror("bind");
-		close(srv_sock);
-		exit(1);
+		perror("Server bind");
+		goto err1;
 	}
 
-	listen(srv_sock, 1);
+	listen(srv_sock, SOMAXCONN);
 
 	if (flag_file) {
 		FILE *f = fopen(flag_file, "w");
 		if (!f) {
-			perror("Flag file open");
-			exit(1);
+			perror("Server Flag file open");
+			goto err1;
 		}
 		fprintf(f, "listening\n");
 		fclose(f);
 	}
 
-	sinlen = sizeof(sin);
-	new_sock = accept(srv_sock, (struct sockaddr *)&sin, &sinlen);
-	if (new_sock < 0) {
-		perror("accept");
-		result = 1;
-		goto err2;
-	}
-
-	/* This waits for a client message before continuing. */
-	result = read(new_sock, &buffer, sizeof(buffer));
-	if (result < 0) {
-		perror("read");
-		exit(1);
-	}
-	buffer[result] = 0;
-	if (verbose)
-		printf("%s\n", buffer);
-
-	/* Obtain address info for the BINDX_ADD and new SCTP_PRIMARY_ADDR. */
-	result = getaddrinfo(argv[optind + 1], argv[optind + 2],
-			     &srv_hints, &new_pri_addr_res);
+	result = set_subscr_events(srv_sock, on, on, on, on);
 	if (result < 0) {
-		fprintf(stderr, "getaddrinfo - new SCTP_PRIMARY_ADDR: %s\n",
-			gai_strerror(result));
-		close(srv_sock);
-		exit(1);
+		perror("Server setsockopt SCTP_EVENTS");
+		goto err1;
 	}
-	if (is_ipv6 && verbose)
-		printf("new_pri_addr scopeID: %d\n",
-		       ((struct sockaddr_in6 *)
-			new_pri_addr_res->ai_addr)->sin6_scope_id);
-
 
-	/* Now call sctp_bindx to add ADDR2, this will cause an
-	 * ASCONF - SCTP_PARAM_ADD_IP chunk to be sent to the CLIENT.
-	 * This is non-blocking so there maybe a delay before the CLIENT
-	 * receives the asconf chunk.
+	/*
+	 * Receive notifications for initial addr changes, then a request for
+	 * the 'new_pri_addr' from the client.
 	 */
-	if (verbose)
-		printf("Calling sctp_bindx ADD: %s\n", argv[optind + 1]);
-
-	result = sctp_bindx(new_sock,
-			    (struct sockaddr *)new_pri_addr_res->ai_addr,
-			    1, SCTP_BINDX_ADD_ADDR);
-	if (result < 0) {
-		if (errno == EACCES) {
-			perror("sctp_bindx ADD");
-		} else {
-			perror("sctp_bindx ADD");
-			result = 1;
+	memset(&sinfo, 0, sizeof(struct sctp_sndrcvinfo));
+	while (1) {
+		result = sctp_recvmsg(srv_sock, buffer, sizeof(buffer),
+				      (struct sockaddr *)&sin, &sinlen,
+				      &sinfo, &flags);
+		if (result < 0) {
+			perror("Server sctp_recvmsg-1");
 			goto err1;
 		}
-	}
 
-	/* This waits for a client message before continuing. */
-	result = read(new_sock, &buffer, sizeof(buffer));
-	if (result < 0) {
-		perror("read");
-		exit(1);
+		if (flags & MSG_NOTIFICATION && flags & MSG_EOR) {
+			result = handle_event(buffer, NULL, NULL, verbose,
+					      "Server");
+			if (result == EVENT_SHUTDOWN)
+				goto err1;
+		} else {
+			if (verbose)
+				printf("Server received: %s\n", buffer);
+			break;
+		}
 	}
-	buffer[result] = 0;
-	if (verbose)
-		printf("%s\n", buffer);
 
-	/* Now that the CLIENT has the new primary address ensure they use
-	 * it by SCTP_SET_PEER_PRIMARY_ADDR.
+	/*
+	 * Before sending 'new_pri_addr', request the peer sets curent 'addr'
+	 * as association primary using SCTP_SET_PEER_PRIMARY_ADDR. This uses
+	 * Dynamic Address Reconfiguration by sending an asconf chunk with
+	 * SCTP_PARAM_SET_PRIMARY set to the client.
 	 */
 	memset(&setpeerprim, 0, sizeof(struct sctp_setpeerprim));
+	setpeerprim.sspp_assoc_id = sinfo.sinfo_assoc_id;
 	sa_ptr = (struct sockaddr *)&setpeerprim.sspp_addr;
 	if (is_ipv6)
-		memcpy(sa_ptr, new_pri_addr_res->ai_addr,
+		memcpy(sa_ptr, srv_res->ai_addr,
 		       sizeof(struct sockaddr_in6));
 	else
-		memcpy(sa_ptr, new_pri_addr_res->ai_addr,
+		memcpy(sa_ptr, srv_res->ai_addr,
 		       sizeof(struct sockaddr_in));
 
+	result = setsockopt(srv_sock, IPPROTO_SCTP,
+			    SCTP_SET_PEER_PRIMARY_ADDR,
+			    &setpeerprim,
+			    sizeof(struct sctp_setpeerprim));
+	if (result < 0) {
+		perror("Server setsockopt: SCTP_SET_PEER_PRIMARY_ADDR");
+		goto err1;
+	}
 	if (verbose)
-		printf("Calling setsockopt SCTP_SET_PEER_PRIMARY_ADDR: %s\n",
+		printf("Server setsockopt: SCTP_SET_PEER_PRIMARY_ADDR with:\n\t%s\n",
 		       argv[optind + 1]);
 
-	result = setsockopt(new_sock, IPPROTO_SCTP,
-			    SCTP_SET_PEER_PRIMARY_ADDR,
-			    &setpeerprim, sizeof(struct sctp_setpeerprim));
+	if (sin.ss_family == AF_INET6) /* Set scope_id for local link */
+		((struct sockaddr_in6 *)&sin)->sin6_scope_id = if_index;
+
+	/* Send client the new primary address */
+	result = sctp_sendmsg(srv_sock, new_pri_addr, new_len,
+			      (struct sockaddr *)&sin,
+			      sinlen, 0, 0, 0, 0, 0);
+	free(new_pri_addr);
 	if (result < 0) {
-		perror("setsockopt: SCTP_SET_PEER_PRIMARY_ADDR");
-		result = 1;
+		perror("Server sctp_sendmsg");
 		goto err1;
 	}
-	/* Sleep a sec to ensure client get info. */
-	result = read(new_sock, &buffer, sizeof(buffer));
+
+	/* Obtain address info for the BINDX_ADD */
+	result = getaddrinfo(argv[optind + 1], argv[optind + 2],
+			     &srv_hints, &new_pri_addr_res);
 	if (result < 0) {
-		perror("read");
-		exit(1);
+		fprintf(stderr, "Server getaddrinfo - new SCTP_PRIMARY_ADDR: %s\n",
+			gai_strerror(result));
+		goto err1;
 	}
-	buffer[result] = 0;
-	if (verbose)
-		printf("%s\n", buffer);
 
-	/* Then delete addr that checks ASCONF - SCTP_PARAM_DEL_IP. */
-	if (verbose)
-		printf("Calling sctp_bindx REM: %s\n", argv[optind]);
+	if (is_ipv6 && verbose)
+		printf("Server new_pri_addr: %s has scopeID: %d\n",
+		       argv[optind + 1],
+		       ((struct sockaddr_in6 *)
+			new_pri_addr_res->ai_addr)->sin6_scope_id);
 
-	result = sctp_bindx(new_sock, (struct sockaddr *)srv_res->ai_addr,
-			    1, SCTP_BINDX_REM_ADDR);
+	/*
+	 * Now call sctp_bindx to add 'new_pri_addr'. This uses Dynamic Address
+	 * Reconfiguration by sending an asconf chunk with SCTP_PARAM_ADD_IP
+	 * set to the client.
+	 */
+	result = sctp_bindx(srv_sock,
+			    (struct sockaddr *)new_pri_addr_res->ai_addr,
+			    1, SCTP_BINDX_ADD_ADDR);
 	if (result < 0) {
-		perror("sctp_bindx - REM");
-		result = 1;
+		perror("Server sctp_bindx ADD");
 		goto err1;
 	}
+	if (verbose)
+		printf("Server sctp_bindx(3) SCTP_BINDX_ADD_ADDR:\n\t%s\n",
+		       argv[optind + 1]);
 
-	result = read(new_sock, &buffer, sizeof(buffer));
-	if (result <= 0) {
-		if (errno != 0)
-			perror("read");
-		result = 1;
+	/* Then delete 'addr' that DAR's - SCTP_PARAM_DEL_IP. */
+	result = sctp_bindx(srv_sock, (struct sockaddr *)srv_res->ai_addr,
+			    1, SCTP_BINDX_REM_ADDR);
+	if (result < 0) {
+		perror("Server sctp_bindx - REM");
 		goto err1;
 	}
-	buffer[result] = 0;
 	if (verbose)
-		printf("%s\n", buffer);
+		printf("Server sctp_bindx(3) SCTP_BINDX_REM_ADDR:\n\t%s\n",
+		       argv[optind]);
 
-	result = read(new_sock, &buffer, sizeof(buffer));
-	if (result < 0) {
-		perror("read");
-		exit(1);
+	/*
+	 * End of test - The 'new_pri_addr' is not used for any sessions as
+	 * the objective was to only exercise Dynamic Address Reconfiguration
+	 * so wait for client to complete before closing otherwise it
+	 * errors with ENOTCONN
+	 */
+	while (1) {
+		result = sctp_recvmsg(srv_sock, buffer, sizeof(buffer),
+				      (struct sockaddr *)&sin, &sinlen,
+				      &sinfo, &flags);
+		if (result < 0) {
+			perror("Server sctp_recvmsg-2");
+			goto err1;
+		}
+
+		if (verbose)
+			printf("Client assoc_id: %d\n", sinfo.sinfo_assoc_id);
+
+		if (flags & MSG_NOTIFICATION) {
+			result = handle_event(buffer, NULL, NULL, verbose, "Server");
+			if (result == EVENT_SHUTDOWN)
+				break;
+		} else {
+			if (verbose)
+				printf("Server received: %s\n", buffer);
+			break;
+		}
 	}
-	buffer[result] = 0;
-	if (verbose)
-		printf("%s\n", buffer);
 
 	result = 0;
-
-err1:
-	close(new_sock);
-err2:
+end:
 	close(srv_sock);
-	exit(result);
+	freeaddrinfo(srv_res);
+	freeaddrinfo(new_pri_addr_res);
+	return result;
+err1:
+	result = -1;
+	goto end;
 }
diff --git a/tests/sctp/sctp_client.c b/tests/sctp/sctp_client.c
index 595da75..8160034 100644
--- a/tests/sctp/sctp_client.c
+++ b/tests/sctp/sctp_client.c
@@ -9,9 +9,9 @@ static void usage(char *progname)
 		"-e      Optional expected message from server e.g. \"nopeer\".\n\t"
 		"        If not present the client context will be used as a\n\t"
 		"        comparison with the servers reply.\n\t"
-		"-n      Do NOT call connect(3) or connectx(3).\n\t"
+		"-n      Do NOT call connect(2), connectx(3) - test SCTP_SENDMSG_CONNECT.\n\t"
 		"-v      Print context and ip options information.\n\t"
-		"-x      Use sctp_connectx(3) instead of connect(3).\n\t"
+		"-x      Use sctp_connectx(3) instead of connect(2).\n\t"
 		"stream  Use SCTP 1-to-1 style or:\n\t"
 		"seq     use SCTP 1-to-Many style.\n\t"
 		"addr    IPv4 or IPv6 address (e.g. 127.0.0.1 or ::1).\n\t"
diff --git a/tests/sctp/sctp_common.c b/tests/sctp/sctp_common.c
index 089af2a..8b65870 100644
--- a/tests/sctp/sctp_common.c
+++ b/tests/sctp/sctp_common.c
@@ -40,6 +40,13 @@ void print_addr_info(struct sockaddr *sin, char *text)
 				  addr_str, INET6_ADDRSTRLEN + 1);
 			printf("%s IPv6->IPv4 MAPPED addr %s\n",
 			       text, addr_str);
+		} else if (IN6_IS_ADDR_LINKLOCAL(&addr6->sin6_addr)) {
+			inet_ntop(sin->sa_family,
+				  (void *)&addr6->sin6_addr,
+				  addr_str, INET6_ADDRSTRLEN + 1);
+			printf("%s IPv6 local link addr %s scope_id %d\n",
+			       text, addr_str,
+			       ((struct sockaddr_in6 *)addr6)->sin6_scope_id);
 		} else {
 			inet_ntop(sin->sa_family,
 				  (void *)&addr6->sin6_addr,
@@ -48,6 +55,9 @@ void print_addr_info(struct sockaddr *sin, char *text)
 			       addr_str);
 		}
 		break;
+	default:
+		printf("%s Unknown IP family %d\n", text, sin->sa_family);
+		break;
 	}
 }
 
@@ -103,13 +113,15 @@ void print_ip_option(int fd, bool ipv4, char *text)
 	}
 }
 
-int set_subscr_events(int fd, int data_io, int association)
+int set_subscr_events(int fd, int data_io, int assoc, int addr, int shutd)
 {
 	struct sctp_event_subscribe subscr_events;
 
 	memset(&subscr_events, 0, sizeof(subscr_events));
 	subscr_events.sctp_data_io_event = data_io;
-	subscr_events.sctp_association_event = association;
+	subscr_events.sctp_association_event = assoc;
+	subscr_events.sctp_address_event = addr;
+	subscr_events.sctp_shutdown_event = shutd;
 
 	/*
 	 * Truncate optlen to just the fields we touch to avoid errors when
@@ -117,5 +129,176 @@ int set_subscr_events(int fd, int data_io, int association)
 	 */
 	return setsockopt(fd, IPPROTO_SCTP, SCTP_EVENTS, &subscr_events,
 			  sizeof_up_to(struct sctp_event_subscribe,
-				       sctp_association_event));
+				       sctp_shutdown_event));
+}
+
+/*
+ * Currently only SCTP_ASSOC_CHANGE, SCTP_PEER_ADDR_CHANGE and
+ * SCTP_SHUTDOWN_EVENT are enabled via set_subscr_events().
+ */
+int handle_event(void *buf, char *cmp_addr, sctp_assoc_t *assoc_id,
+		 bool verbose, char *text)
+{
+	union sctp_notification *snp = buf;
+	char addrbuf[INET6_ADDRSTRLEN];
+	struct sockaddr_in *sin;
+	struct sockaddr_in6 *sin6;
+	const char *ap;
+	struct sctp_paddr_change *spc;
+	struct sctp_assoc_change *sac;
+	struct sctp_remote_error *sre;
+	struct sctp_send_failed *ssf;
+	struct sctp_authkey_event *auth_event;
+
+	switch (snp->sn_header.sn_type) {
+	case SCTP_ASSOC_CHANGE:
+		sac = &snp->sn_assoc_change;
+
+		if (verbose)
+			printf("%s SCTP_ASSOC_CHANGE event for assoc_id: %d ERR: 0x%x\n",
+			       text, sac->sac_assoc_id, sac->sac_error);
+
+		if (assoc_id)
+			*assoc_id = sac->sac_assoc_id;
+		break;
+	case SCTP_PEER_ADDR_CHANGE:
+		spc = &snp->sn_paddr_change;
+
+		if (verbose)
+			/*
+			 * Not all spc_error codes are errors - linux/sctp.h
+			 * (e.g. SCTP_HEARTBEAT_SUCCESS = 0x02)
+			 */
+			printf("%s SCTP_PEER_ADDR_CHANGE event for assoc_id: %d ERR: 0x%x\n",
+			       text, spc->spc_assoc_id, spc->spc_error);
+
+		if (spc->spc_aaddr.ss_family == AF_INET) {
+			sin = (struct sockaddr_in *) &spc->spc_aaddr;
+			ap = inet_ntop(AF_INET, &sin->sin_addr, addrbuf,
+				       INET6_ADDRSTRLEN);
+		} else {
+			sin6 = (struct sockaddr_in6 *) &spc->spc_aaddr;
+			ap = inet_ntop(AF_INET6, &sin6->sin6_addr, addrbuf,
+				       INET6_ADDRSTRLEN);
+		}
+		if (verbose) /* Print additional address details */
+			print_addr_info((struct sockaddr *)&spc->spc_aaddr,
+					"Peer Address change:\n\t");
+
+		switch (spc->spc_state) {
+		case SCTP_ADDR_AVAILABLE:
+			if (verbose)
+				printf("\t%s is available\n", text);
+			break;
+		case SCTP_ADDR_UNREACHABLE:
+			if (verbose)
+				printf("\t%s is not available - Error: 0x%x\n",
+				       text, spc->spc_error);
+			break;
+		case SCTP_ADDR_REMOVED:
+			if (verbose)
+				printf("\t%s was removed\n", text);
+			break;
+		case SCTP_ADDR_ADDED:
+			if (verbose)
+				printf("\t%s was added\n", text);
+			break;
+		case SCTP_ADDR_MADE_PRIM:
+			if (verbose)
+				printf("\t%s is primary\n", text);
+			if (cmp_addr) {
+				if (!strcmp(ap, cmp_addr)) {
+					if (verbose)
+						printf("\t%s and is now the new primary\n", text);
+
+					return EVENT_ADDR_MATCH;
+				}
+			}
+			break;
+		case SCTP_ADDR_CONFIRMED:
+			if (verbose)
+				printf("\t%s is confirmed\n", text);
+			break;
+		default:
+			if (verbose)
+				printf("%s unknown state: %d\n", text,
+				       spc->spc_state);
+			break;
+		}
+		break;
+	case SCTP_SEND_FAILED:
+		ssf = &snp->sn_send_failed;
+
+		if (verbose)
+			printf("%s SCTP_SEND_FAILED event assoc_id: %d ERR: 0x%x\n",
+			       text, ssf->ssf_assoc_id, ssf->ssf_error);
+		break;
+	case SCTP_REMOTE_ERROR:
+		sre = &snp->sn_remote_error;
+		if (verbose) /* Error in network byte order - linux/sctp.h */
+			printf("%s SCTP_REMOTE_ERROR event ERR: 0x%x\n",
+			       text, ntohs(sre->sre_error));
+		break;
+	case SCTP_SHUTDOWN_EVENT:
+		if (verbose)
+			printf("%s SCTP_SHUTDOWN_EVENT\n", text);
+
+		return EVENT_SHUTDOWN;
+	case SCTP_PARTIAL_DELIVERY_EVENT:
+		if (verbose)
+			printf("%s SCTP_PARTIAL_DELIVERY_EVENT\n", text);
+		break;
+	case SCTP_ADAPTATION_INDICATION:
+		if (verbose)
+			printf("%s SCTP_ADAPTATION_INDICATION event\n", text);
+		break;
+	case SCTP_AUTHENTICATION_INDICATION:
+		auth_event = &snp->sn_authkey_event;
+
+		if (verbose) {
+			printf("%s SCTP_AUTHENTICATION_INDICATION event\n"
+			       "\tauth_event->auth_type:       0x%x\n"
+			       "\tauth_event->auth_flags:      0x%x\n"
+			       "\tauth_event->auth_length:     0x%x\n"
+			       "\tauth_event->auth_keynumber:  0x%x\n"
+			       "\tauth_event->auth_indication: 0x%x\n"
+			       "\tauth_event->auth_assoc_id:   %d\n",
+			       text, auth_event->auth_type,
+			       auth_event->auth_flags,
+			       auth_event->auth_length,
+			       auth_event->auth_keynumber,
+			       auth_event->auth_indication,
+			       auth_event->auth_assoc_id);
+		}
+		/* SCTP_AUTH_NO_AUTH defined in linux/sctp.h */
+		if (auth_event->auth_indication == SCTP_AUTH_NO_AUTH)
+			return EVENT_NO_AUTH;
+		break;
+	case SCTP_SENDER_DRY_EVENT:
+		if (verbose)
+			printf("%s SCTP_SENDER_DRY_EVENT\n", text);
+		break;
+	case SCTP_STREAM_RESET_EVENT:
+		if (verbose)
+			printf("%s SCTP_STREAM_RESET_EVENT\n", text);
+		break;
+	case SCTP_ASSOC_RESET_EVENT:
+		if (verbose)
+			printf("%s SCTP_ASSOC_RESET_EVENT\n", text);
+		break;
+	case SCTP_STREAM_CHANGE_EVENT:
+		if (verbose)
+			printf("%s SCTP_STREAM_CHANGE_EVENT\n", text);
+		break;
+	case SCTP_SEND_FAILED_EVENT:
+		if (verbose)
+			printf("%s SCTP_SEND_FAILED_EVENT\n", text);
+		break;
+	default:
+		fprintf(stderr, "%s unknown event: 0x%x\n", text,
+			snp->sn_header.sn_type);
+		break;
+	}
+
+	return EVENT_OK;
 }
diff --git a/tests/sctp/sctp_common.h b/tests/sctp/sctp_common.h
index 351ee37..cb69f70 100644
--- a/tests/sctp/sctp_common.h
+++ b/tests/sctp/sctp_common.h
@@ -18,11 +18,19 @@
 #include <stdio.h>
 #include <stdbool.h>
 #include <errno.h>
-#include <signal.h>
 #include <selinux/selinux.h>
 
+enum event_ret {
+	EVENT_OK,
+	EVENT_ADDR_MATCH,
+	EVENT_SHUTDOWN,
+	EVENT_NO_AUTH
+};
+
 void print_context(int fd, char *text);
 void print_addr_info(struct sockaddr *sin, char *text);
 char *get_ip_option(int fd, bool ipv4, socklen_t *opt_len);
 void print_ip_option(int fd, bool ipv4, char *text);
-int set_subscr_events(int fd, int data_io, int association);
+int set_subscr_events(int fd, int data_io, int assoc, int addr, int shutd);
+int handle_event(void *buf, char *cmp_addr, sctp_assoc_t *assoc_id,
+		 bool verbose, char *text);
diff --git a/tests/sctp/sctp_connectx.c b/tests/sctp/sctp_connectx.c
index 18d133d..edf8c8f 100644
--- a/tests/sctp/sctp_connectx.c
+++ b/tests/sctp/sctp_connectx.c
@@ -3,8 +3,9 @@
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
@@ -17,11 +18,15 @@ int main(int argc, char **argv)
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
@@ -110,9 +119,23 @@ int main(int argc, char **argv)
 	if (verbose)
 		print_context(client_sock, "Client");
 
-	result = sctp_connectx(client_sock, client_res->ai_addr, 1, NULL);
+	if (!no_connx) {
+		result = sctp_connectx(client_sock, client_res->ai_addr, 1, NULL);
+		if (result < 0) {
+			perror("connectx");
+			close(srv_sock);
+			close(client_sock);
+			exit(1);
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
 		exit(1);
diff --git a/tests/sctp/sctp_peeloff_server.c b/tests/sctp/sctp_peeloff_server.c
index 8350cb4..bd797f2 100644
--- a/tests/sctp/sctp_peeloff_server.c
+++ b/tests/sctp/sctp_peeloff_server.c
@@ -16,36 +16,10 @@ static void usage(char *progname)
 	exit(1);
 }
 
-static sctp_assoc_t handle_event(void *buf)
-{
-	union sctp_notification *snp = buf;
-	struct sctp_assoc_change *sac;
-
-	switch (snp->sn_header.sn_type) {
-	case SCTP_ASSOC_CHANGE:
-		sac = &snp->sn_assoc_change;
-		return sac->sac_assoc_id;
-	case SCTP_PEER_ADDR_CHANGE:
-	case SCTP_SEND_FAILED:
-	case SCTP_REMOTE_ERROR:
-	case SCTP_SHUTDOWN_EVENT:
-	case SCTP_PARTIAL_DELIVERY_EVENT:
-	case SCTP_ADAPTATION_INDICATION:
-	case SCTP_AUTHENTICATION_INDICATION:
-	case SCTP_SENDER_DRY_EVENT:
-		printf("Unrequested event: %x\n", snp->sn_header.sn_type);
-		break;
-	default:
-		printf("Unknown event: %x\n", snp->sn_header.sn_type);
-		break;
-	}
-	return -1;
-}
-
 int main(int argc, char **argv)
 {
-	int opt, sock, result, peeloff_sk = 0, flags, on = 1;
-	sctp_assoc_t assoc_id;
+	int opt, sock, result, peeloff_sk = 0, flags, on = 1, off = 0;
+	sctp_assoc_t assoc_id = 0;
 	socklen_t sinlen, opt_len;
 	struct sockaddr_storage sin;
 	struct addrinfo hints, *res;
@@ -149,7 +123,7 @@ int main(int argc, char **argv)
 
 	do {
 		/* Get assoc_id for sctp_peeloff() */
-		result = set_subscr_events(sock, 0, 1);
+		result = set_subscr_events(sock, off, on, off, off);
 		if (result < 0) {
 			perror("Server setsockopt: SCTP_EVENTS");
 			close(sock);
@@ -172,7 +146,8 @@ int main(int argc, char **argv)
 					"Server SEQPACKET recvmsg");
 
 		if (flags & MSG_NOTIFICATION && flags & MSG_EOR) {
-			assoc_id = handle_event(msglabel);
+			handle_event(msglabel, NULL, &assoc_id,
+				     verbose, "Peeloff Server");
 			if (assoc_id <= 0) {
 				printf("Server Invalid association ID: %d\n",
 				       assoc_id);
@@ -180,7 +155,7 @@ int main(int argc, char **argv)
 				exit(1);
 			}
 			/* No more notifications */
-			result = set_subscr_events(sock, 0, 0);
+			result = set_subscr_events(sock, off, off, off, off);
 			if (result < 0) {
 				perror("Server setsockopt: SCTP_EVENTS");
 				close(sock);
@@ -210,9 +185,12 @@ int main(int argc, char **argv)
 				exit(1);
 			}
 
-			if (verbose)
+			if (verbose) {
 				print_addr_info((struct sockaddr *)&sin,
 						"Server SEQPACKET peeloff recvmsg");
+				printf("peeloff association ID: %d\n",
+				       assoc_id);
+			}
 		} else {
 			printf("Invalid sctp_recvmsg response FLAGS: %x\n",
 			       flags);
diff --git a/tests/sctp/sctp_server.c b/tests/sctp/sctp_server.c
index 7f2cd20..c53f46f 100644
--- a/tests/sctp/sctp_server.c
+++ b/tests/sctp/sctp_server.c
@@ -23,7 +23,7 @@ static void usage(char *progname)
 
 int main(int argc, char **argv)
 {
-	int opt, sock, newsock, result, if_index = 0, on = 1;
+	int opt, sock, newsock, result, if_index = 0, on = 1, off = 0;
 	socklen_t sinlen, opt_len;
 	struct sockaddr_storage sin;
 	struct addrinfo hints, *res;
@@ -134,7 +134,7 @@ int main(int argc, char **argv)
 	}
 
 	/* Enables sctp_data_io_events for sctp_recvmsg(3) for assoc_id. */
-	result = set_subscr_events(sock, on, 0);
+	result = set_subscr_events(sock, on, off, off, off);
 	if (result < 0) {
 		perror("Server setsockopt: SCTP_EVENTS");
 		close(sock);
diff --git a/tests/sctp/sctp_set_params.c b/tests/sctp/sctp_set_params.c
deleted file mode 100644
index d4914bb..0000000
--- a/tests/sctp/sctp_set_params.c
+++ /dev/null
@@ -1,205 +0,0 @@
-#include "sctp_common.h"
-
-static void usage(char *progname)
-{
-	fprintf(stderr,
-		"usage:  %s [-v] [-o aci|pap|pat] stream|seq addr port\n"
-		"\nWhere:\n\t"
-		"-v      Print information.\n\t"
-		"-o      Test setsockoption(3) using one of the following\n\t"
-		"        options:\n\t\t"
-		"        aci = SCTP_ASSOCINFO\n\t\t"
-		"        pap = SCTP_PEER_ADDR_PARAMS\n\t\t"
-		"        pat = SCTP_PEER_ADDR_THLDS\n\t\t"
-		"stream  SCTP 1-to-1 style or:\n\t"
-		"seq     SCTP 1-to-Many style.\n\t"
-		"addr    Servers IPv4 or IPv6 address.\n\t"
-		"port    port.\n", progname);
-	exit(1);
-}
-
-/* Test set_param permission for SCTP_ASSOCINFO */
-static void sctp_associnfo(int sk, int option)
-{
-	int result;
-	socklen_t len;
-	struct sctp_assocparams assocparams;
-
-	memset(&assocparams, 0, sizeof(struct sctp_assocparams));
-
-	len = sizeof(struct sctp_assocparams);
-	result = getsockopt(sk, IPPROTO_SCTP, option, &assocparams, &len);
-	if (result < 0) {
-		perror("getsockopt: SCTP_ASSOCINFO");
-		close(sk);
-		exit(1);
-	}
-
-	assocparams.sasoc_asocmaxrxt += 5;
-	assocparams.sasoc_cookie_life += 15;
-
-	result = setsockopt(sk, IPPROTO_SCTP, option, &assocparams, len);
-	if (result < 0) {
-		perror("setsockopt: SCTP_ASSOCINFO");
-		close(sk);
-		exit(1);
-	}
-}
-
-
-/* Test set_param permission for SCTP_PEER_ADDR_PARAMS */
-static void sctp_peer_addr_params(int sk, int option)
-{
-	int result;
-	struct sctp_paddrparams heartbeat;
-
-	memset(&heartbeat, 0, sizeof(struct sctp_paddrparams));
-	heartbeat.spp_flags = SPP_HB_ENABLE;
-	heartbeat.spp_hbinterval = 100;
-	heartbeat.spp_pathmaxrxt = 1;
-
-	result = setsockopt(sk, IPPROTO_SCTP, option,
-			    &heartbeat, sizeof(heartbeat));
-	if (result < 0) {
-		perror("setsockopt: SCTP_PEER_ADDR_PARAMS");
-		close(sk);
-		exit(1);
-	}
-}
-
-int main(int argc, char **argv)
-{
-	int opt, type, srv_sock, client_sock, result, sockoption = 0;
-	struct addrinfo srv_hints, client_hints, *srv_res, *client_res;
-	bool verbose = false;
-	char *context;
-
-	while ((opt = getopt(argc, argv, "o:v")) != -1) {
-		switch (opt) {
-		case 'o':
-			if (!strcmp(optarg, "aci"))
-				sockoption = SCTP_ASSOCINFO;
-			else if (!strcmp(optarg, "pap"))
-				sockoption = SCTP_PEER_ADDR_PARAMS;
-			else if (!strcmp(optarg, "pat")) {
-				printf("SCTP_PEER_ADDR_THLDS not currently supported by userspace\n");
-				exit(1);
-			} else
-				usage(argv[0]);
-			break;
-		case 'v':
-			verbose = true;
-			break;
-		default:
-			usage(argv[0]);
-		}
-	}
-
-	if ((argc - optind) != 3)
-		usage(argv[0]);
-
-	if (!strcmp(argv[optind], "stream"))
-		type = SOCK_STREAM;
-	else if (!strcmp(argv[optind], "seq"))
-		type = SOCK_SEQPACKET;
-	else
-		usage(argv[0]);
-
-	if (verbose) {
-		if (getcon(&context) < 0)
-			context = strdup("unavailable");
-
-		printf("Process context: %s\n", context);
-		free(context);
-	}
-
-	memset(&srv_hints, 0, sizeof(struct addrinfo));
-	srv_hints.ai_flags = AI_PASSIVE;
-	srv_hints.ai_family = AF_INET6;
-
-	srv_hints.ai_socktype = type;
-	srv_hints.ai_protocol = IPPROTO_SCTP;
-
-	/* Set up server side */
-	result = getaddrinfo(NULL, argv[optind + 2], &srv_hints, &srv_res);
-	if (result < 0) {
-		printf("getaddrinfo - server: %s\n", gai_strerror(result));
-		exit(1);
-	}
-
-	srv_sock = socket(srv_res->ai_family, srv_res->ai_socktype,
-			  srv_res->ai_protocol);
-	if (srv_sock < 0) {
-		perror("socket - server");
-		exit(1);
-	}
-
-	if (verbose)
-		print_context(srv_sock, "Server");
-
-	if (bind(srv_sock, srv_res->ai_addr, srv_res->ai_addrlen) < 0) {
-		perror("bind");
-		close(srv_sock);
-		exit(1);
-	}
-
-	listen(srv_sock, 1);
-
-	/* Set up client side */
-	memset(&client_hints, 0, sizeof(struct addrinfo));
-	client_hints.ai_socktype = type;
-	client_hints.ai_protocol = IPPROTO_SCTP;
-	result = getaddrinfo(argv[optind + 1], argv[optind + 2],
-			     &client_hints, &client_res);
-	if (result < 0) {
-		fprintf(stderr, "getaddrinfo - client: %s\n",
-			gai_strerror(result));
-		exit(1);
-	}
-
-	client_sock = socket(client_res->ai_family, client_res->ai_socktype,
-			     client_res->ai_protocol);
-	if (client_sock < 0) {
-		perror("socket - client");
-		exit(1);
-	}
-
-	if (verbose)
-		print_context(client_sock, "Client");
-
-	result = sctp_connectx(client_sock, client_res->ai_addr, 1, NULL);
-	if (result < 0) {
-		perror("connectx");
-		close(client_sock);
-		exit(1);
-	}
-
-	if (sockoption) {
-		switch (sockoption) {
-		case SCTP_ASSOCINFO:
-			if (verbose)
-				printf("Testing: SCTP_ASSOCINFO\n");
-			sctp_associnfo(srv_sock, sockoption);
-			break;
-		case SCTP_PEER_ADDR_PARAMS:
-			if (verbose)
-				printf("Testing: SCTP_PEER_ADDR_PARAMS\n");
-			sctp_peer_addr_params(client_sock, sockoption);
-			break;
-		}
-	} else {
-
-		if (verbose)
-			printf("Testing: SCTP_ASSOCINFO\n");
-		sctp_associnfo(srv_sock, SCTP_ASSOCINFO);
-
-		if (verbose)
-			printf("Testing: SCTP_PEER_ADDR_PARAMS\n");
-		sctp_peer_addr_params(client_sock, SCTP_PEER_ADDR_PARAMS);
-
-	}
-
-	close(srv_sock);
-	close(client_sock);
-	exit(0);
-}
diff --git a/tests/sctp/sctp_set_peer_addr.c b/tests/sctp/sctp_set_peer_addr.c
deleted file mode 100644
index c35b518..0000000
--- a/tests/sctp/sctp_set_peer_addr.c
+++ /dev/null
@@ -1,415 +0,0 @@
-/*
- * This test will allow the server side to add/remove bindx addresses and
- * inform the client side via ASCONF chunks. It will also allow the server
- * side to inform the client that the peer primary address is being updated.
- * The code for checking these parameters are in net/sctp/sm_make_chunk.c
- * sctp_process_asconf_param().
- *
- * To enable the processing of these incoming ASCONF parameters for:
- *      SCTP_PARAM_SET_PRIMARY, SCTP_PARAM_ADD_IP and SCTP_PARAM_DEL_IP
- * the following options must be enabled:
- *	echo 1 > /proc/sys/net/sctp/addip_enable
- *	echo 1 > /proc/sys/net/sctp/addip_noauth_enable
- *
- * If these are not enabled the SCTP_SET_PEER_PRIMARY_ADDR setsockopt
- * fails with EPERM "Operation not permitted", however the bindx calls
- * will complete but the client side will not be informed.
- *
- * NOTES:
- *   1) SCTP_SET_PEER_PRIMARY_ADDR requires a non-loopback IP address.
- *   2) Both addresses MUST be the same type (i.e. IPv4 or IPv6).
- */
-
-#include "sctp_common.h"
-
-static void usage(char *progname)
-{
-	fprintf(stderr,
-		"usage:  %s -v addr new_pri_addr port\n"
-		"\nWhere:\n\t"
-		"-v           Print status information.\n\t"
-		"addr         IPv4/IPv6 address for initial connection.\n\t"
-		"new_pri_addr IPv4/IPv6 address that the server will bindx\n\t"
-		"             then set to the new SCTP_PRIMARY_ADDR.\n\t"
-		"port         port.\n", progname);
-	fprintf(stderr,
-		"Notes:\n\t"
-		"1) addr and new_pri_addr MUST NOT be loopback addresses.\n\t"
-		"2) addr and new_pri_addr MUST be same type (IPv4 or IPv6).\n\t"
-		"3) IPv6 link-local addresses require the %%<if_name> to\n\t"
-		"   obtain scopeid. e.g. fe80::7629:afff:fe0f:8e5d%%wlp6s0\n");
-	exit(1);
-}
-
-static int peer_count, peer_count_err;
-
-static void getpaddrs_alarm(int sig)
-{
-	fprintf(stderr, "Get peer address count timer expired - carry on test\n");
-	peer_count += 1;
-	peer_count_err = true;
-}
-
-static void getprimaddr_alarm(int sig)
-{
-	fprintf(stderr, "Get primary address timer expired - end test.\n");
-	exit(1);
-}
-
-static void print_primaddr(char *msg, int socket)
-{
-	int result;
-	struct sctp_prim prim;
-	struct sockaddr_in *in_addr;
-	struct sockaddr_in6 *in6_addr;
-	struct sockaddr *paddr;
-	socklen_t prim_len;
-	char addr_buf[INET6_ADDRSTRLEN];
-	const char *addr_ptr = NULL;
-
-	memset(&prim, 0, sizeof(struct sctp_prim));
-
-	prim_len = sizeof(struct sctp_prim);
-	result = getsockopt(socket, IPPROTO_SCTP, SCTP_PRIMARY_ADDR,
-			    &prim, &prim_len);
-	if (result < 0) {
-		perror("getsockopt: SCTP_PRIMARY_ADDR");
-		exit(1);
-	}
-
-	paddr = (struct sockaddr *)&prim.ssp_addr;
-	if (paddr->sa_family == AF_INET) {
-		in_addr = (struct sockaddr_in *)&prim.ssp_addr;
-		addr_ptr = inet_ntop(AF_INET, &in_addr->sin_addr, addr_buf,
-				     INET6_ADDRSTRLEN);
-	} else if (paddr->sa_family == AF_INET6) {
-		in6_addr = (struct sockaddr_in6 *)&prim.ssp_addr;
-		addr_ptr = inet_ntop(AF_INET6, &in6_addr->sin6_addr, addr_buf,
-				     INET6_ADDRSTRLEN);
-	}
-
-	if (!addr_ptr) {
-		perror("inet_ntop");
-		exit(1);
-	}
-
-	printf("%s SCTP_PRIMARY_ADDR: %s\n", msg, addr_ptr);
-}
-
-static void get_primaddr(char *addr_buf, int socket)
-{
-	int result;
-	struct sctp_prim prim;
-	struct sockaddr_in *in_addr;
-	struct sockaddr_in6 *in6_addr;
-	struct sockaddr *paddr;
-	socklen_t prim_len;
-	const char *addr_ptr = NULL;
-
-	memset(&prim, 0, sizeof(struct sctp_prim));
-	prim_len = sizeof(struct sctp_prim);
-	result = getsockopt(socket, IPPROTO_SCTP, SCTP_PRIMARY_ADDR,
-			    &prim, &prim_len);
-	if (result < 0) {
-		perror("getsockopt: SCTP_PRIMARY_ADDR");
-		exit(1);
-	}
-
-	paddr = (struct sockaddr *)&prim.ssp_addr;
-	if (paddr->sa_family == AF_INET) {
-		in_addr = (struct sockaddr_in *)&prim.ssp_addr;
-		addr_ptr = inet_ntop(AF_INET, &in_addr->sin_addr, addr_buf,
-				     INET6_ADDRSTRLEN);
-	} else if (paddr->sa_family == AF_INET6) {
-		in6_addr = (struct sockaddr_in6 *)&prim.ssp_addr;
-		addr_ptr = inet_ntop(AF_INET6, &in6_addr->sin6_addr, addr_buf,
-				     INET6_ADDRSTRLEN);
-	}
-	if (!addr_ptr) {
-		perror("inet_ntop");
-		exit(1);
-	}
-}
-
-int main(int argc, char **argv)
-{
-	int opt, srv_sock, client_sock, new_sock, result, on = 1;
-	struct addrinfo srv_hints, client_hints, *srv_res, *client_res;
-	struct addrinfo *new_pri_addr_res;
-	struct sockaddr *sa_ptr, *paddrs;
-	socklen_t sinlen;
-	struct sockaddr_storage sin;
-	struct sctp_setpeerprim setpeerprim;
-	bool verbose = false, is_ipv6 = false;
-	char client_prim_addr[INET6_ADDRSTRLEN];
-	char client_prim_new_pri_addr[INET6_ADDRSTRLEN];
-
-	while ((opt = getopt(argc, argv, "v")) != -1) {
-		switch (opt) {
-		case 'v':
-			verbose = true;
-			break;
-		default:
-			usage(argv[0]);
-		}
-	}
-
-	if ((argc - optind) != 3)
-		usage(argv[0]);
-
-	if (strchr(argv[optind], ':') && strchr(argv[optind + 1], ':')) {
-		is_ipv6 = true;
-		srv_hints.ai_family = AF_INET6;
-	} else if (strchr(argv[optind], '.') &&
-		   strchr(argv[optind + 1], '.')) {
-		is_ipv6 = false;
-		srv_hints.ai_family = AF_INET;
-	} else {
-		usage(argv[0]);
-	}
-
-	memset(&srv_hints, 0, sizeof(struct addrinfo));
-	srv_hints.ai_flags = AI_PASSIVE;
-	srv_hints.ai_socktype = SOCK_STREAM;
-	srv_hints.ai_protocol = IPPROTO_SCTP;
-
-	/* Set up server side */
-	result = getaddrinfo(argv[optind], argv[optind + 2],
-			     &srv_hints, &srv_res);
-	if (result < 0) {
-		fprintf(stderr, "getaddrinfo - server: %s\n",
-			gai_strerror(result));
-		exit(1);
-	}
-
-	result = getaddrinfo(argv[optind], argv[optind + 2],
-			     &srv_hints, &srv_res);
-	if (result < 0) {
-		fprintf(stderr, "getaddrinfo - server: %s\n",
-			gai_strerror(result));
-		exit(1);
-	}
-	if (is_ipv6 && verbose)
-		printf("Server scopeID: %d\n",
-		       ((struct sockaddr_in6 *)
-			srv_res->ai_addr)->sin6_scope_id);
-
-	srv_sock = socket(srv_res->ai_family, srv_res->ai_socktype,
-			  srv_res->ai_protocol);
-	if (srv_sock < 0) {
-		perror("socket - server");
-		exit(1);
-	}
-
-	result = setsockopt(srv_sock, SOL_SOCKET, SO_REUSEADDR,
-			    &on, sizeof(on));
-	if (result < 0) {
-		perror("setsockopt: SO_REUSEADDR");
-		close(srv_sock);
-		exit(1);
-	}
-
-	result = bind(srv_sock, srv_res->ai_addr, srv_res->ai_addrlen);
-	if (result < 0) {
-		perror("bind");
-		close(srv_sock);
-		exit(1);
-	}
-
-	listen(srv_sock, 1);
-
-	/* Set up client side and connect */
-	memset(&client_hints, 0, sizeof(struct addrinfo));
-	client_hints.ai_socktype = SOCK_STREAM;
-	client_hints.ai_protocol = IPPROTO_SCTP;
-	result = getaddrinfo(argv[optind], argv[optind + 2],
-			     &client_hints, &client_res);
-	if (result < 0) {
-		fprintf(stderr, "getaddrinfo - client: %s\n",
-			gai_strerror(result));
-		close(srv_sock);
-		exit(1);
-	}
-	if (is_ipv6 && verbose)
-		printf("Client scopeID: %d\n",
-		       ((struct sockaddr_in6 *)
-			client_res->ai_addr)->sin6_scope_id);
-
-	client_sock = socket(client_res->ai_family, client_res->ai_socktype,
-			     client_res->ai_protocol);
-	if (client_sock < 0) {
-		perror("socket - client");
-		close(srv_sock);
-		exit(1);
-	}
-
-	result = connect(client_sock, client_res->ai_addr,
-			 client_res->ai_addrlen);
-	if (result < 0) {
-		if (errno != EINPROGRESS)
-			perror("connect");
-		else
-			fprintf(stderr, "connect timeout\n");
-		result = 1;
-		goto err2;
-	}
-
-	/* Obtain address info for the BINDX_ADD and new SCTP_PRIMARY_ADDR. */
-	result = getaddrinfo(argv[optind + 1], argv[optind + 2],
-			     &client_hints, &new_pri_addr_res);
-	if (result < 0) {
-		fprintf(stderr, "getaddrinfo - new SCTP_PRIMARY_ADDR: %s\n",
-			gai_strerror(result));
-		close(srv_sock);
-		exit(1);
-	}
-	if (is_ipv6 && verbose)
-		printf("new_pri_addr scopeID: %d\n",
-		       ((struct sockaddr_in6 *)
-			new_pri_addr_res->ai_addr)->sin6_scope_id);
-
-	/* Get number of peer addresses on CLIENT (should be 1) for a check
-	 * later as sctp_bindx SERVER -> CLIENT is non-blocking.
-	 */
-	peer_count = sctp_getpaddrs(client_sock, 0, &paddrs);
-	sctp_freepaddrs(paddrs);
-	if (verbose)
-		printf("Client peer address count: %d\n", peer_count);
-
-	/* Client and server now set so accept new socket on server side. */
-	sinlen = sizeof(sin);
-	new_sock = accept(srv_sock, (struct sockaddr *)&sin, &sinlen);
-	if (new_sock < 0) {
-		perror("accept");
-		result = 1;
-		goto err2;
-	}
-
-	/* Get initial CLIENT primary address (that should be ADDR1). */
-	get_primaddr(client_prim_addr, client_sock);
-
-	/* Now call sctp_bindx to add new_pri_addr, this will cause an
-	 * ASCONF - SCTP_PARAM_ADD_IP chunk to be sent to the CLIENT.
-	 * This is non-blocking so there maybe a delay before the CLIENT
-	 * receives the asconf chunk.
-	 */
-	if (verbose)
-		printf("Calling sctp_bindx ADD: %s\n", argv[optind + 1]);
-
-	result = sctp_bindx(new_sock,
-			    (struct sockaddr *)new_pri_addr_res->ai_addr,
-			    1, SCTP_BINDX_ADD_ADDR);
-	if (result < 0) {
-		if (errno == EACCES) {
-			perror("sctp_bindx ADD");
-		} else {
-			perror("sctp_bindx ADD");
-			result = 1;
-			goto err1;
-		}
-	}
-	/* so set an alarm and check number of peer addresses for CLIENT. */
-	signal(SIGALRM, getpaddrs_alarm);
-	alarm(2);
-	peer_count_err = false;
-	result = 0;
-
-	while (result != peer_count + 1) {
-		result = sctp_getpaddrs(client_sock, 0, &paddrs);
-		sctp_freepaddrs(paddrs);
-
-		if (peer_count_err)
-			break;
-	}
-	peer_count = result;
-
-	if (verbose)
-		printf("Client peer address count: %d\n", result);
-
-	/* Now that the CLIENT has the new primary address ensure they use
-	 * it by SCTP_SET_PEER_PRIMARY_ADDR.
-	 */
-	memset(&setpeerprim, 0, sizeof(struct sctp_setpeerprim));
-	sa_ptr = (struct sockaddr *)&setpeerprim.sspp_addr;
-	if (is_ipv6)
-		memcpy(sa_ptr, new_pri_addr_res->ai_addr,
-		       sizeof(struct sockaddr_in6));
-	else
-		memcpy(sa_ptr, new_pri_addr_res->ai_addr,
-		       sizeof(struct sockaddr_in));
-
-	if (verbose)
-		printf("Calling setsockopt SCTP_SET_PEER_PRIMARY_ADDR: %s\n",
-		       argv[optind + 1]);
-
-	result = setsockopt(new_sock, IPPROTO_SCTP,
-			    SCTP_SET_PEER_PRIMARY_ADDR,
-			    &setpeerprim, sizeof(struct sctp_setpeerprim));
-	if (result < 0) {
-		perror("setsockopt: SCTP_SET_PEER_PRIMARY_ADDR");
-		result = 1;
-		goto err1;
-	}
-
-	/* Now get the new primary address from the client */
-	signal(SIGALRM, getprimaddr_alarm);
-	alarm(2);
-	memcpy(client_prim_new_pri_addr, client_prim_addr, INET6_ADDRSTRLEN);
-
-	while (!strcmp(client_prim_addr, client_prim_new_pri_addr))
-		get_primaddr(client_prim_new_pri_addr, client_sock);
-
-	if (verbose) {
-		printf("Client initial SCTP_PRIMARY_ADDR: %s\n",
-		       client_prim_addr);
-		print_primaddr("Server", new_sock);
-		printf("Client current SCTP_PRIMARY_ADDR: %s\n",
-		       client_prim_new_pri_addr);
-	}
-
-	/* Then delete addr1 that checks ASCONF - SCTP_PARAM_DEL_IP. */
-	if (verbose)
-		printf("Calling sctp_bindx REM: %s\n", argv[optind]);
-
-	result = sctp_bindx(new_sock, (struct sockaddr *)client_res->ai_addr,
-			    1, SCTP_BINDX_REM_ADDR);
-	if (result < 0) {
-		perror("sctp_bindx - REM");
-		result = 1;
-		goto err1;
-	}
-
-	if (!peer_count_err) {
-		alarm(2);
-		result = 0;
-
-		while (result != peer_count - 1) {
-			result = sctp_getpaddrs(client_sock, 0, &paddrs);
-			sctp_freepaddrs(paddrs);
-		}
-
-		if (verbose)
-			printf("Client peer address count: %d\n", result);
-	}
-
-	/* Compare the client primary addresses, they should be different. */
-	if (!strcmp(client_prim_addr, client_prim_new_pri_addr)) {
-		fprintf(stderr,
-			"Client addr: %s same as new_pri_addr: %s - SCTP_SET_PEER_PRIMARY_ADDR failed\n",
-			client_prim_addr, client_prim_new_pri_addr);
-		result = 1;
-		goto err1;
-	}
-
-	if (verbose)
-		printf("Client primary address changed successfully.\n");
-
-	result = 0;
-
-err1:
-	close(new_sock);
-err2:
-	close(srv_sock);
-	close(client_sock);
-	exit(result);
-}
diff --git a/tests/sctp/sctp_set_pri_addr.c b/tests/sctp/sctp_set_pri_addr.c
deleted file mode 100644
index 5122001..0000000
--- a/tests/sctp/sctp_set_pri_addr.c
+++ /dev/null
@@ -1,135 +0,0 @@
-#include "sctp_common.h"
-
-static void usage(char *progname)
-{
-	fprintf(stderr,
-		"usage:  %s [-v] addr port\n"
-		"\nWhere:\n\t"
-		"-v      Print information.\n\t"
-		"addr    Servers IPv4 or IPv6 address.\n\t"
-		"port    port.\n", progname);
-	exit(1);
-}
-
-static void sctp_primary_addr(int sk, int option)
-{
-	int result;
-	socklen_t len;
-	struct sctp_prim primaddr;
-
-	memset(&primaddr, 0, sizeof(struct sctp_prim));
-
-	len = sizeof(struct sctp_prim);
-	result = getsockopt(sk, IPPROTO_SCTP, option,
-			    &primaddr, &len);
-	if (result < 0) {
-		perror("getsockopt: SCTP_PRIMARY_ADDR");
-		close(sk);
-		exit(1);
-	}
-
-	result = setsockopt(sk, IPPROTO_SCTP, option, &primaddr, len);
-	if (result < 0) {
-		perror("setsockopt: SCTP_PRIMARY_ADDR");
-		close(sk);
-		exit(1);
-	}
-}
-
-int main(int argc, char **argv)
-{
-	int opt, srv_sock, client_sock, result;
-	struct addrinfo srv_hints, client_hints, *srv_res, *client_res;
-	bool verbose = false;
-	char *context;
-
-	while ((opt = getopt(argc, argv, "v")) != -1) {
-		switch (opt) {
-		case 'v':
-			verbose = true;
-			break;
-		default:
-			usage(argv[0]);
-		}
-	}
-
-	if ((argc - optind) != 2)
-		usage(argv[0]);
-
-	if (verbose) {
-		if (getcon(&context) < 0)
-			context = strdup("unavailable");
-
-		printf("Process context: %s\n", context);
-		free(context);
-	}
-
-	memset(&srv_hints, 0, sizeof(struct addrinfo));
-	srv_hints.ai_flags = AI_PASSIVE;
-	srv_hints.ai_family = AF_INET6;
-
-	srv_hints.ai_socktype = SOCK_STREAM;
-	srv_hints.ai_protocol = IPPROTO_SCTP;
-
-	/* Set up server side */
-	result = getaddrinfo(NULL, argv[optind + 1], &srv_hints, &srv_res);
-	if (result < 0) {
-		printf("getaddrinfo - server: %s\n", gai_strerror(result));
-		exit(1);
-	}
-
-	srv_sock = socket(srv_res->ai_family, srv_res->ai_socktype,
-			  srv_res->ai_protocol);
-	if (srv_sock < 0) {
-		perror("socket - server");
-		exit(1);
-	}
-
-	if (verbose)
-		print_context(srv_sock, "Server");
-
-	if (bind(srv_sock, srv_res->ai_addr, srv_res->ai_addrlen) < 0) {
-		perror("bind");
-		close(srv_sock);
-		exit(1);
-	}
-
-	listen(srv_sock, 1);
-
-	/* Set up client side */
-	memset(&client_hints, 0, sizeof(struct addrinfo));
-	client_hints.ai_socktype = SOCK_STREAM;
-	client_hints.ai_protocol = IPPROTO_SCTP;
-	result = getaddrinfo(argv[optind], argv[optind + 1], &client_hints,
-			     &client_res);
-	if (result < 0) {
-		fprintf(stderr, "getaddrinfo - client: %s\n",
-			gai_strerror(result));
-		exit(1);
-	}
-
-	client_sock = socket(client_res->ai_family, client_res->ai_socktype,
-			     client_res->ai_protocol);
-	if (client_sock < 0) {
-		perror("socket - client");
-		exit(1);
-	}
-
-	if (verbose)
-		print_context(client_sock, "Client");
-
-	result = sctp_connectx(client_sock, client_res->ai_addr, 1, NULL);
-	if (result < 0) {
-		perror("connectx");
-		close(client_sock);
-		exit(1);
-	}
-
-	if (verbose)
-		printf("Testing: SCTP_PRIMARY_ADDR\n");
-	sctp_primary_addr(client_sock, SCTP_PRIMARY_ADDR);
-
-	close(srv_sock);
-	close(client_sock);
-	exit(0);
-}
diff --git a/tests/sctp/test b/tests/sctp/test
index c87ee14..8d83043 100755
--- a/tests/sctp/test
+++ b/tests/sctp/test
@@ -1,6 +1,18 @@
 #!/usr/bin/perl
 use Test::More;
 
+#
+# These tests cover all net/sctp security hooks as discussed in kernel tree:
+#     Documentation/security/SCTP.rst
+# The only two places in SCTP code not tested (as they need unusual sctp
+# packets to be sent) are:
+#   net/sctp/sm_statefuns.c sctp_sf_do_unexpected_init - assoc_request
+#   net/sctp/sm_statefuns.c sctp_sf_do_5_2_4_dupcook - assoc_request
+#
+# Tests can be followed using tshark(1):
+#     tshark -O sctp,ipv6,ip,cipso,calipso -P -x -i any
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
@@ -135,9 +147,8 @@ ok( $result >> 8 eq 8 );
 # Kill the stream server.
 server_end($pid);
 
-######## This test requires setting a portcon statement in policy ###########
-# Verify that the server cannot start when using port not allowed STREAM->STREAM.
-# Note that the sctp_test policy only allows ports 1024-65535
+######## Deny capability net_bind_service ###########
+# Verify that the server cannot start when using port < 1024.
 $result =
   system "runcon -t test_sctp_server_t -- $basedir/sctp_bind $v stream 80 2>&1";
 ok($result);
@@ -145,6 +156,7 @@ ok($result);
 #
 ############################### CONNECTX #####################################
 #
+# net/sctp/socket.c sctp_setsockopt_connectx() SCTP_SOCKOPT_CONNECTX
 print "# Testing connectx.\n";
 
 $result = system
@@ -156,9 +168,31 @@ $result =
   "runcon -t test_sctp_connectx_t $basedir/sctp_connectx $v seq ::1 1035";
 ok( $result eq 0 );
 
+$result =
+  system
+"runcon -t test_sctp_deny_connectx_t $basedir/sctp_connectx $v seq ::1 1035 2>&1";
+ok($result);
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
+ok($result);
+
 #
 ################################ BINDX #######################################
 #
+# net/sctp/socket.c sctp_setsockopt_bindx() SCTP_SOCKOPT_BINDX_ADD
 print "# Testing bindx.\n";
 
 $result =
@@ -169,11 +203,34 @@ $result =
   system "runcon -t test_sctp_bindx_t $basedir/sctp_bindx $v -r seq 1035";
 ok( $result eq 0 );
 
+$result =
+  system
+  "runcon -t test_sctp_deny_bindx_t $basedir/sctp_bindx $v -r seq 1035 2>&1";
+ok($result);
+
+#
+##################### Dynamic Address Reconfiguration #####################
+#
+# net/sctp/sm_make_chunk.c sctp_process_asconf_param() SCTP_PARAM_ADD_IP
+#                                                     SCTP_PARAM_SET_PRIMARY
+# These are detected on the client side and requires the 'connect' permission,
+# however when running with a remote server, the denial cannot be tested as
+# the client requires 'connect' to initiate the association (there was no
+# use-case for finer control).
 #
-######################### SET_PRI_ADDR SET_PEER_ADDR ########################
+# net/sctp/socket.c sctp_setsockopt_peer_primary_addr() SET_PEER_PRIMARY_ADDR
+# This is detected on the server side, however as it requires the 'bind'
+# permission, the denial cannot be tested as need 'bind' to start the
+# association.
+#
+# The net/sctp/socket.c sctp_setsockopt_primary_addr() SCTP_PRIMARY_ADDR
+# function is tested by setting policy to:
+#    allow sctp_asconf_params_client_t self:sctp_socket { bind };
+# or:
+#    neverallow sctp_asconf_params_client_t self:sctp_socket { bind };
 #
 
-# These tests require two local non-loopback addresses.
+# These tests require two non-loopback addresses.
 if ($test_asconf) {
     print "# Testing asconf parameter chunk processing.\n";
 
@@ -183,24 +240,33 @@ if ($test_asconf) {
     system("echo 1 > /proc/sys/net/sctp/addip_enable");
     system("echo 1 > /proc/sys/net/sctp/addip_noauth_enable");
 
-    # Verify ASCONF params.
+    print "Testing Dynamic Address Reconfiguration\n";
+
+    $pid = server_start(
+        "-t sctp_asconf_params_server_t",
+        "sctp_asconf_params_server",
+        "$v $ipaddress[0] $ipaddress[1] 1035"
+    );
+
+    print "Starting: asconf client\n";
     $result = system
-"runcon -t test_sctp_set_peer_addr_t $basedir/sctp_set_peer_addr $v $ipaddress[0] $ipaddress[1] 1035";
+"runcon -t sctp_asconf_params_client_t $basedir/sctp_asconf_params_client $v $ipaddress[0] 1035";
     ok( $result eq 0 );
 
-    # Start the asconf server.
+    server_end($pid);
+
+    # The SCTP_PRIMARY_ADDR denial can be tested local/remote
     $pid = server_start(
-        "-t test_sctp_set_peer_addr_t",
+        "-t sctp_asconf_params_server_t",
         "sctp_asconf_params_server",
         "$v $ipaddress[0] $ipaddress[1] 1035"
     );
 
-# This should fail connect permission attempting to send SCTP_PARAM_ADD_IP to client.
+    print "Testing deny setting SCTP_PRIMARY_ADDR\n";
     $result = system
-"runcon -t test_sctp_client_t -- $basedir/sctp_asconf_params_client $v $ipaddress[0] 1035 2>&1";
-    ok($result);
+"runcon -t sctp_asconf_deny_pri_addr_client_t $basedir/sctp_asconf_params_client $v $ipaddress[0] 1035 2>&1";
+    ok( $result >> 8 eq 51 );    # setsockopt(2) failed
 
-    # The server should automatically exit.
     server_end($pid);
 
     system("echo 0 > /proc/sys/net/sctp/addip_enable");
@@ -274,6 +340,7 @@ system "/bin/sh $basedir/fb-label-flush";
 #
 #################### Test deny association permission ########################
 #
+# net/sctp/sm_statefuns.c sctp_sf_do_5_1B_init() assoc_request
 print "# Testing deny association.\n";
 system "/bin/sh $basedir/fb-deny-label-load";
 
-- 
2.25.3

