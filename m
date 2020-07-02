Return-Path: <SRS0=m4lG=AN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B62B4C433DF
	for <selinux@archiver.kernel.org>; Thu,  2 Jul 2020 14:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6403E2065F
	for <selinux@archiver.kernel.org>; Thu,  2 Jul 2020 14:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="bm61Tuph"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729556AbgGBOfR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 2 Jul 2020 10:35:17 -0400
Received: from mailomta21-re.btinternet.com ([213.120.69.114]:63558 "EHLO
        re-prd-fep-048.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729835AbgGBOfQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 2 Jul 2020 10:35:16 -0400
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
          by re-prd-fep-048.btinternet.com with ESMTP
          id <20200702143512.DTYM4701.re-prd-fep-048.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
          Thu, 2 Jul 2020 15:35:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1593700512; 
        bh=7vT1kRgsg8syRcoRQT3GylJ0tEKdkG0BvZnzbsrSxsc=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=bm61Tuph+VojX21TYhhZ8rUFQxjbGZWGQlRyrIbgN6zPbMfyYHuVp05lpupFqprleynueJU3miJnLRwa3LyFkwYvvtP8jNHyfPqUMV2HW3wRqou75Z7i98NZ6bmpmJOrOX403Ds/LWqNjUQAlA1UpZPvT9fMYfA2qLRkLfpYF1i3H8vrQj7A1u2wqHcJCyqRfhk2JSEtmHMXbEOwOqS1b9K45iq5APEqTCff5BW289Rm4pQ4OkWmwmSB6AUcDKSlnZca5zzyduvbCceOqXximDDi488VZxdnHwtGXRb5v6eLExqndHqOBTrnYavHWVbKXwO+UxDZ7KH1A8Ol3A/jXQ==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [86.147.197.33]
X-OWM-Source-IP: 86.147.197.33 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrtdeggdejfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepleetffegveevjeehvefhtefgueevudettedutdffvdejkeeiteegheevfeejtdefnecukfhppeekiedrudegjedrudeljedrfeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudegjedrudeljedrfeefpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequcfqtfevrffvpehrfhgtkedvvdenrhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (86.147.197.33) by re-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9C2FD04E8FEDD; Thu, 2 Jul 2020 15:35:12 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH] selinux-testsuite: Remove unused sctp code
Date:   Thu,  2 Jul 2020 15:35:08 +0100
Message-Id: <20200702143508.24143-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Removed obsolete code that was used to test permissions that never made it
to the final commit.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 tests/sctp/.gitignore          |   2 -
 tests/sctp/Makefile            |   2 +-
 tests/sctp/sctp_set_params.c   | 205 ---------------------------------
 tests/sctp/sctp_set_pri_addr.c | 135 ----------------------
 4 files changed, 1 insertion(+), 343 deletions(-)
 delete mode 100644 tests/sctp/sctp_set_params.c
 delete mode 100644 tests/sctp/sctp_set_pri_addr.c

diff --git a/tests/sctp/.gitignore b/tests/sctp/.gitignore
index d0633fe..8671c27 100644
--- a/tests/sctp/.gitignore
+++ b/tests/sctp/.gitignore
@@ -6,6 +6,4 @@ sctp_client
 sctp_connectx
 sctp_peeloff_server
 sctp_server
-sctp_set_params
 sctp_set_peer_addr
-sctp_set_pri_addr
diff --git a/tests/sctp/Makefile b/tests/sctp/Makefile
index 1debf82..f5dfdae 100644
--- a/tests/sctp/Makefile
+++ b/tests/sctp/Makefile
@@ -1,4 +1,4 @@
-TARGETS = sctp_client sctp_server sctp_bind sctp_bindx sctp_connectx sctp_set_params sctp_set_peer_addr sctp_set_pri_addr sctp_asconf_params_client sctp_asconf_params_server sctp_peeloff_server
+TARGETS = sctp_client sctp_server sctp_bind sctp_bindx sctp_connectx sctp_set_peer_addr sctp_asconf_params_client sctp_asconf_params_server sctp_peeloff_server
 
 DEPS = sctp_common.c sctp_common.h
 CFLAGS ?= -Wall
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
-- 
2.26.2

