Return-Path: <SRS0=XO28=EK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67A5C2D0A3
	for <selinux@archiver.kernel.org>; Wed,  4 Nov 2020 16:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 743C1206CA
	for <selinux@archiver.kernel.org>; Wed,  4 Nov 2020 16:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="lMBEk1R6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730154AbgKDQtX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Nov 2020 11:49:23 -0500
Received: from mailomta14-sa.btinternet.com ([213.120.69.20]:50335 "EHLO
        sa-prd-fep-044.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730912AbgKDQtW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 Nov 2020 11:49:22 -0500
Received: from sa-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.38.8])
          by sa-prd-fep-044.btinternet.com with ESMTP
          id <20201104164917.ZEGI11685.sa-prd-fep-044.btinternet.com@sa-prd-rgout-005.btmx-prd.synchronoss.net>;
          Wed, 4 Nov 2020 16:49:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1604508557; 
        bh=oD9TwdDeH9WfCQIQz1OD/UUvRIW1ELLMxJqVdFLgaE8=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=lMBEk1R6Ysl+6BJMmXGkZDqYP7NP50bB81cP0Bz5ZZeWk2qe/mF+MPqFCY6ZPDmns36EMPhPKwntG0NpLNWaAyuWzmVijksODq+5qN2Wu84RzN5q5V1bu2IswOUUSNTUoX4XpOuWYeThUjq1II75o4S6VnmxTVHHjm9HfNj9kw+Ai8NyNaefCkWyOhLpA3evVvEzGPiZkuyGdxd1s5tcQdY0Tl0nVAKG4TsC+vhTcMXZydY6/QoIg2ZMd4pPF8xQD0hFWpmF0qZbG0CT1EDyafA0fiAd01sGs+yjWVFDyAgO9/J15slpY02pTGhNfiv3hLYYtRZrMoE2jUnzxVViPQ==
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 5ED9B8A7190E1F76
X-Originating-IP: [213.122.112.63]
X-OWM-Source-IP: 213.122.112.63 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedruddthedgleegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpeeutddtleelheeugefgiefhiedtheeukeffveeitdffgeffieeugeeljeegvefgieenucfkphepvddufedruddvvddrudduvddrieefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpedvudefrdduvddvrdduuddvrdeifedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuqfftvefrvfeprhhftgekvddvnehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (213.122.112.63) by sa-prd-rgout-005.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9B8A7190E1F76; Wed, 4 Nov 2020 16:49:17 +0000
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [RFC PATCH 1/1] selinux-testsuite: Reduce sctp test runtime
Date:   Wed,  4 Nov 2020 16:49:13 +0000
Message-Id: <20201104164913.11536-2-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201104164913.11536-1-richard_c_haines@btinternet.com>
References: <20201104164913.11536-1-richard_c_haines@btinternet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Use the Linux audit services to look for specific events and trigger
the correct test exit code.

This is useful for tests that fail on a socket timeout where they
hang around for x seconds before exiting. The audit service will detect
the event as it occurred based on AVC entry scontext= and optionally, a
regex (e.g. "denied.*\\{ recv \\}") entry.

Without this patch sctp tests take ~2.6 min, with patch ~4 secs.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 README.md                              |  5 +-
 policy/test_sctp.te                    |  1 +
 tests/sctp/Makefile                    |  2 +-
 tests/sctp/sctp_asconf_params_client.c | 51 ++++++++++++-
 tests/sctp/sctp_client.c               | 52 ++++++++++++--
 tests/sctp/sctp_common.c               | 99 ++++++++++++++++++++++++++
 tests/sctp/sctp_common.h               | 11 +++
 tests/sctp/test                        | 50 ++++++-------
 travis-ci/run-testsuite.sh             |  1 +
 9 files changed, 237 insertions(+), 35 deletions(-)

diff --git a/README.md b/README.md
index 4a22389..7d8d567 100644
--- a/README.md
+++ b/README.md
@@ -62,6 +62,7 @@ similar dependencies):
 * jfsutils _(used by the jfs filesystem tests)_
 * dosfstools _(used by the vfat filesystem tests)_
 * nftables _(used by inet_socket and sctp tests if ver >= 9.3 for secmark testing )_
+* audit-libs-devel _(used by inet_socket and sctp tests to reduce run time )_
 
 On a modern Fedora system you can install these dependencies with the
 following command (NOTE: On Fedora 32 and below you need to remove
@@ -88,6 +89,7 @@ following command (NOTE: On Fedora 32 and below you need to remove
 		jfsutils \
 		dosfstools \
 		nftables \
+		audit-libs-devel \
 		kernel-devel-$(uname -r) \
 		kernel-modules-$(uname -r)
 
@@ -134,7 +136,8 @@ command:
 		e2fsprogs \
 		jfsutils \
 		dosfstools \
-		nftables
+		nftables \
+		audit-libs-devel
 
 On Debian, you need to build and install netlabel_tools manually since
 it is not yet packaged for Debian
diff --git a/policy/test_sctp.te b/policy/test_sctp.te
index 363e3c5..c691db9 100644
--- a/policy/test_sctp.te
+++ b/policy/test_sctp.te
@@ -4,6 +4,7 @@
 
 attribute sctpsocketdomain;
 
+logging_read_audit_log(sctpsocketdomain)
 #
 ######################## NetLabel labels ############################
 #
diff --git a/tests/sctp/Makefile b/tests/sctp/Makefile
index dd151fb..bd8ba72 100644
--- a/tests/sctp/Makefile
+++ b/tests/sctp/Makefile
@@ -4,7 +4,7 @@ TARGETS = sctp_client sctp_server sctp_bind sctp_bindx sctp_connectx \
 DEPS = sctp_common.c sctp_common.h
 CFLAGS ?= -Wall
 
-LDLIBS += -lselinux -lsctp
+LDLIBS += -lselinux -lsctp -lauparse -pthread
 
 all: $(TARGETS)
 
diff --git a/tests/sctp/sctp_asconf_params_client.c b/tests/sctp/sctp_asconf_params_client.c
index 48403ae..d85b337 100644
--- a/tests/sctp/sctp_asconf_params_client.c
+++ b/tests/sctp/sctp_asconf_params_client.c
@@ -41,6 +41,12 @@ static void usage(char *progname)
 		"   same type (IPv4 or IPv6).\n\t"
 		"2) IPv6 link-local addresses require the %%<if_name> to\n\t"
 		"   obtain scopeid. e.g. fe80::7629:afff:fe0f:8e5d%%wlp6s0\n");
+
+	fprintf(stderr, "\nTo use the audit system to detect an AVC entry:\n\t"
+		"-s      A specific 'scontext=' AVC entry to search for.\n\t"
+		"        If not present the client context will be used.\n\t"
+		"-r      An optional regex entry to be used in the search.\n\t"
+		"-z      Mandatory exit code, called when a match is found.\n");
 	exit(1);
 }
 
@@ -119,14 +125,30 @@ int main(int argc, char **argv)
 	socklen_t sinlen = sizeof(sin);
 	struct timeval tm;
 	bool verbose = false;
-	char buffer[512];
+	char buffer[512], *context;
 	char msg[] = "Send peer address";
 	char *rcv_new_addr_buf = NULL;
+	pthread_t thread;
+
+	audit_verbose = false;
+	event_scontext = NULL;
+	event_regex = NULL;
+	event_exit = 0;
 
-	while ((opt = getopt(argc, argv, "v")) != -1) {
+	while ((opt = getopt(argc, argv, "vs:r:z:")) != -1) {
 		switch (opt) {
 		case 'v':
 			verbose = true;
+			audit_verbose = true;
+			break;
+		case 's':
+			event_scontext = optarg;
+			break;
+		case 'r':
+			event_regex = optarg;
+			break;
+		case 'z':
+			event_exit = atoi(optarg);
 			break;
 		default:
 			usage(argv[0]);
@@ -136,6 +158,31 @@ int main(int argc, char **argv)
 	if ((argc - optind) != 2)
 		usage(argv[0]);
 
+	if (!event_scontext || verbose) {
+		result = getcon(&context);
+		if (result < 0) {
+			fprintf(stderr, "Client getcon: %s\n",
+				strerror(result));
+			exit(1);
+		}
+		if (!event_scontext)
+			event_scontext = strdup(context);
+
+		if (verbose) {
+			printf("Client process context: %s\n", context);
+			free(context);
+		}
+	}
+
+	if (event_exit) {
+		result = pthread_create(&thread, NULL, &check_au_event, NULL);
+		if (result < 0) {
+			fprintf(stderr, "Client pthread_create: %s\n",
+				strerror(result));
+			exit(1);
+		}
+	}
+
 	memset(&client_hints, 0, sizeof(struct addrinfo));
 	client_hints.ai_socktype = SOCK_SEQPACKET;
 	client_hints.ai_protocol = IPPROTO_SCTP;
diff --git a/tests/sctp/sctp_client.c b/tests/sctp/sctp_client.c
index 2f527ed..5579970 100644
--- a/tests/sctp/sctp_client.c
+++ b/tests/sctp/sctp_client.c
@@ -16,6 +16,12 @@ static void usage(char *progname)
 		"seq     use SCTP 1-to-Many style.\n\t"
 		"addr    IPv4 or IPv6 address (e.g. 127.0.0.1 or ::1).\n\t"
 		"port    Port for accessing server.\n", progname);
+
+	fprintf(stderr, "\nTo use the audit system to detect an AVC entry:\n\t"
+		"-s      A specific 'scontext=' AVC entry to search for.\n\t"
+		"        If not present the client context will be used.\n\t"
+		"-r      An optional regex entry to be used in the search.\n\t"
+		"-z      Mandatory exit code, called when a match is found.\n");
 	exit(1);
 }
 
@@ -29,8 +35,14 @@ int main(int argc, char **argv)
 	bool ipv4 = false, expect_ipopt = false;
 	char *context;
 	struct timeval tm;
+	pthread_t thread;
+
+	audit_verbose = false;
+	event_scontext = NULL;
+	event_regex = NULL;
+	event_exit = 0;
 
-	while ((opt = getopt(argc, argv, "e:vxmni")) != -1) {
+	while ((opt = getopt(argc, argv, "e:vxmnis:r:z:")) != -1) {
 		switch (opt) {
 		case 'e':
 			expected = optarg;
@@ -40,6 +52,7 @@ int main(int argc, char **argv)
 			break;
 		case 'v':
 			verbose = true;
+			audit_verbose = true;
 			break;
 		case 'n':
 			no_connects = true;
@@ -47,6 +60,15 @@ int main(int argc, char **argv)
 		case 'x':
 			connectx = true;
 			break;
+		case 's':
+			event_scontext = optarg;
+			break;
+		case 'r':
+			event_regex = optarg;
+			break;
+		case 'z':
+			event_exit = atoi(optarg);
+			break;
 		default:
 			usage(argv[0]);
 		}
@@ -65,11 +87,29 @@ int main(int argc, char **argv)
 	else
 		usage(argv[0]);
 
-	if (verbose) {
-		if (getcon(&context) < 0)
-			context = strdup("unavailable");
-		printf("Client process context: %s\n", context);
-		free(context);
+	if (!event_scontext || verbose) {
+		result = getcon(&context);
+		if (result < 0) {
+			fprintf(stderr, "Client getcon: %s\n",
+				strerror(result));
+			exit(1);
+		}
+		if (!event_scontext)
+			event_scontext = strdup(context);
+
+		if (verbose) {
+			printf("Client process context: %s\n", context);
+			free(context);
+		}
+	}
+
+	if (event_exit) {
+		result = pthread_create(&thread, NULL, &check_au_event, NULL);
+		if (result < 0) {
+			fprintf(stderr, "Client pthread_create: %s\n",
+				strerror(result));
+			exit(1);
+		}
 	}
 
 	result = getaddrinfo(argv[optind + 1], argv[optind + 2], &hints,
diff --git a/tests/sctp/sctp_common.c b/tests/sctp/sctp_common.c
index 8b65870..82d28a4 100644
--- a/tests/sctp/sctp_common.c
+++ b/tests/sctp/sctp_common.c
@@ -302,3 +302,102 @@ int handle_event(void *buf, char *cmp_addr, sctp_assoc_t *assoc_id,
 
 	return EVENT_OK;
 }
+
+/*
+ * Audit Events
+ *
+ * These routines run in a thread started by the main test program and use
+ * the auparse/ausearch services to search for events. If the event is found,
+ * the program will exit with the specified event_exit code.
+ * The variables hold the following information:
+ *    event_scontext - Contains a mandatory 'scontext=' AVC entry to search for
+ *    event_regex    - Contains an optional regex entry to search for
+ *    event_exit     - Contains a mandatory exit code, executed on a successful
+ *                     search to end the test
+ *    audit_buf      - Holds the next set of audit events to be searched
+ *    audit_verbose  - Set if verbose output is required.
+ *
+ * Should the audit system fail at any point, the error will be reported,
+ * however it will continue to tun. This allows the test to proceed as normal,
+ * usually by a socket call timing out and exiting with the original exit code.
+ * See sctp_client.c for the calling process.
+ */
+char *event_scontext, *event_regex, audit_buf[1024];
+int event_exit;
+bool audit_verbose;
+
+void *check_au_event(void *arg)
+{
+	FILE *fp;
+	size_t len;
+	auparse_state_t *au;
+
+	au = auparse_init(AUSOURCE_FEED, 0);
+	if (!au)
+		perror("auparse_init");
+
+	auparse_add_callback(au, handle_audit_event, NULL, NULL);
+
+	fp = fopen(AUDIT_LOG, "r");
+	if (!fp)
+		fprintf(stderr, "Could not open: %s, %s\n",
+			AUDIT_LOG, strerror(errno));
+
+	if (fseek(fp, 0, SEEK_END) < 0)
+		perror("Audit Log fseek");
+
+	memset(&audit_buf, 0, sizeof(audit_buf));
+
+	while (1) {
+		clearerr(fp);
+		len = fread(audit_buf, 1, sizeof(audit_buf), fp);
+		if (len > 0) {
+			if (audit_verbose)
+				printf("Audit Entry:\n%s\n", audit_buf);
+			auparse_feed(au, audit_buf, len);
+			auparse_flush_feed(au);
+			memset(&audit_buf, 0, sizeof(audit_buf));
+		}
+		if (len < 0)
+			perror("Audit fread");
+	}
+	auparse_destroy(au);
+}
+
+void handle_audit_event(auparse_state_t *au,
+			auparse_cb_event_t cb_event_type,
+			void *user_data)
+{
+	int result;
+
+	if (cb_event_type != AUPARSE_CB_EVENT_READY)
+		return;
+
+	if (ausearch_add_item(au, "scontext", "=", event_scontext,
+			      AUSEARCH_RULE_CLEAR)) {
+		perror("ausearch_add_item");
+		exit(1);
+	}
+
+	if (event_regex) {
+		if (ausearch_add_regex(au, event_regex)) {
+			perror("ausearch_add_regex error");
+			exit(1);
+		}
+	}
+
+	result = ausearch_next_event(au);
+	switch (result) {
+	case -1:
+		perror("ausearch_next_event error");
+		return;
+	case 1:
+		if (audit_verbose)
+			printf("Found Event - Exit with: %d\n", event_exit);
+		exit(event_exit);
+	case 0:
+		if (audit_verbose)
+			printf("Not Requested Event\n");
+		return;
+	}
+}
diff --git a/tests/sctp/sctp_common.h b/tests/sctp/sctp_common.h
index cb69f70..8f98e9a 100644
--- a/tests/sctp/sctp_common.h
+++ b/tests/sctp/sctp_common.h
@@ -18,6 +18,8 @@
 #include <stdio.h>
 #include <stdbool.h>
 #include <errno.h>
+#include <pthread.h>
+#include <auparse.h>
 #include <selinux/selinux.h>
 
 enum event_ret {
@@ -34,3 +36,12 @@ void print_ip_option(int fd, bool ipv4, char *text);
 int set_subscr_events(int fd, int data_io, int assoc, int addr, int shutd);
 int handle_event(void *buf, char *cmp_addr, sctp_assoc_t *assoc_id,
 		 bool verbose, char *text);
+
+#define AUDIT_LOG "/var/log/audit/audit.log"
+extern char *event_scontext, *event_regex, audit_buf[1024];
+extern int event_exit;
+extern bool audit_verbose;
+void *check_au_event(void *arg);
+void handle_audit_event(auparse_state_t *au,
+			auparse_cb_event_t cb_event_type,
+			void *user_data);
diff --git a/tests/sctp/test b/tests/sctp/test
index 1170921..6f42a85 100755
--- a/tests/sctp/test
+++ b/tests/sctp/test
@@ -282,7 +282,7 @@ if ($test_asconf) {
 
     print "Testing deny SCTP_PARAM_ADD_IP/SCTP_PARAM_SET_PRIMARY\n";
     $result = system
-"runcon -t sctp_asconf_deny_param_add_client_t $basedir/sctp_asconf_params_client $v $ipaddress[0] 1035 2>&1";
+"runcon -t sctp_asconf_deny_param_add_client_t $basedir/sctp_asconf_params_client $v -s unconfined_u:unconfined_r:sctp_asconf_params_server_t:s0-s0:c0.c1023 -r \"denied.*\\{ connect \\}\" -z 11 $ipaddress[0] 1035 2>&1";
     ok( $result >> 8 eq 11 );   # Client error 'Dynamic Address Reconfiguration'
 
     server_end($pid);
@@ -316,7 +316,7 @@ ok( $result eq 0 );
 
 # Verify that a client without peer { recv } permission cannot communicate with the server STREAM->STREAM.
 $result = system
-"runcon -t test_sctp_deny_peer_client_t -- $basedir/sctp_client $v -e system_u:object_r:netlabel_sctp_peer_t:s0 stream 127.0.0.1 1035 2>&1";
+"runcon -t test_sctp_deny_peer_client_t -- $basedir/sctp_client $v -r \"denied.*\\{ recv \\}\" -z 6 -e system_u:object_r:netlabel_sctp_peer_t:s0 stream 127.0.0.1 1035 2>&1";
 ok( $result >> 8 eq 6 );
 
 # Kill the stream server.
@@ -337,17 +337,17 @@ ok( $result eq 0 );
 
 # Verify that a client using connect(2) without peer { recv } permission cannot communicate with the server SEQ->SEQ.
 $result = system
-"runcon -t test_sctp_deny_peer_client_t -- $basedir/sctp_client $v -e system_u:object_r:netlabel_sctp_peer_t:s0 seq ::1 1035 2>&1";
+"runcon -t test_sctp_deny_peer_client_t -- $basedir/sctp_client $v -r \"denied.*\\{ recv \\}\" -z 6 -e system_u:object_r:netlabel_sctp_peer_t:s0 seq ::1 1035 2>&1";
 ok( $result >> 8 eq 6 );
 
 # Verify that a client using sctp_connectx(3) without peer { recv } permission cannot communicate with the server SEQ->SEQ.
 $result = system
-"runcon -t test_sctp_deny_peer_client_t -- $basedir/sctp_client $v -x -e system_u:object_r:netlabel_sctp_peer_t:s0 seq ::1 1035 2>&1";
+"runcon -t test_sctp_deny_peer_client_t -- $basedir/sctp_client $v -r \"denied.*\\{ recv \\}\" -z 6 -x -e system_u:object_r:netlabel_sctp_peer_t:s0 seq ::1 1035 2>&1";
 ok( $result >> 8 eq 6 );
 
 # Verify that a client not using any connect without peer { recv } permission cannot communicate with the server SEQ->SEQ.
 $result = system
-"runcon -t test_sctp_deny_peer_client_t -- $basedir/sctp_client $v -n -e system_u:object_r:netlabel_sctp_peer_t:s0 seq ::1 1035 2>&1";
+"runcon -t test_sctp_deny_peer_client_t -- $basedir/sctp_client $v -r \"denied.*\\{ recv \\}\" -z 13 -n -e system_u:object_r:netlabel_sctp_peer_t:s0 seq ::1 1035 2>&1";
 ok( $result >> 8 eq 13 );
 
 # Kill the seq server.
@@ -372,7 +372,7 @@ ok( $result eq 0 );
 
 # Verify that the server is denied this association as the client will timeout on connect.
 $result = system
-"runcon -t test_sctp_client_t -- $basedir/sctp_client $v -e system_u:object_r:deny_assoc_sctp_peer_t:s0 stream ::1 1035 2>&1";
+"runcon -t test_sctp_client_t -- $basedir/sctp_client $v -s system_u:object_r:netlabel_sctp_peer_t:s0 -r \"denied.*\\{ association \\}\" -z 6 -e system_u:object_r:deny_assoc_sctp_peer_t:s0 stream ::1 1035 2>&1";
 ok( $result >> 8 eq 6 );
 
 # Kill the seq server.
@@ -416,7 +416,7 @@ ok( $result eq 0 );
 # Verify that authorized client cannot communicate with the server using invalid level STREAM->STREAM.
 # Fails with mlsconstrain peer { recv }
 $result = system
-"runcon -t test_sctp_client_t -l s0:c182.c193 -- $basedir/sctp_client $v stream 127.0.0.1 1035 2>&1";
+"runcon -t test_sctp_client_t -l s0:c182.c193 -- $basedir/sctp_client $v -s unconfined_u:unconfined_r:test_sctp_server_t:s0:c182.c192 -r \"denied.*\\{ recv \\}\" -z 6 stream 127.0.0.1 1035 2>&1";
 ok( $result >> 8 eq 6 );
 
 # Kill the stream server.
@@ -446,7 +446,7 @@ ok( $result eq 0 );
 
 # Verify that client cannot communicate with the server using SEQ->SEQ with invalid level.
 $result = system
-"runcon -t test_sctp_client_t -l s0:c19.c100 -- $basedir/sctp_client $v -i seq 127.0.0.1 1035 2>&1";
+"runcon -t test_sctp_client_t -l s0:c19.c100 -- $basedir/sctp_client $v -s unconfined_u:unconfined_r:test_sctp_server_t:s0:c20.c300 -r \"denied.*\\{ recv \\}\" -z 6 -i seq 127.0.0.1 1035 2>&1";
 ok( $result >> 8 eq 6 );
 
 # TAG 1 allows categories 0 to 239 to be sent, if greater then ENOSPC (No space left on device)
@@ -478,7 +478,7 @@ ok( $result eq 0 );
 
 # Verify that client cannot communicate with the server using STREAM->SEQ->peeloff with invalid level.
 $result = system
-"runcon -t test_sctp_client_t -l s0:c0.c11 -- $basedir/sctp_client $v -x -i stream 127.0.0.1 1035 2>&1";
+"runcon -t test_sctp_client_t -l s0:c0.c11 -- $basedir/sctp_client $v -s unconfined_u:unconfined_r:test_sctp_server_t:s0:c0.c10 -r \"denied.*\\{ recv \\}\" -z 6 -x -i stream 127.0.0.1 1035 2>&1";
 ok( $result >> 8 eq 6 );
 
 # Kill the seq server.
@@ -519,7 +519,7 @@ ok( $result eq 0 );
 
 # Verify that authorized client cannot communicate with the server using invalid level STREAM->STREAM.
 $result = system
-"runcon -t test_sctp_client_t -l s0:c1023 -- $basedir/sctp_client $v stream 127.0.0.1 1035 2>&1";
+"runcon -t test_sctp_client_t -l s0:c1023 -- $basedir/sctp_client $v -s unconfined_u:unconfined_r:test_sctp_server_t:s0:c714,c769,c782,c788,c803,c842,c864 -r \"denied.*\\{ recv \\}\" -z 6 stream 127.0.0.1 1035 2>&1";
 ok( $result >> 8 eq 6 );
 
 # Kill the stream server.
@@ -549,7 +549,7 @@ ok( $result eq 0 );
 
 # Verify that client cannot communicate with the server using SEQ->SEQ with invalid level.
 $result = system
-"runcon -t test_sctp_client_t -l s0:c19.c30 -- $basedir/sctp_client $v -i seq 127.0.0.1 1035 2>&1";
+"runcon -t test_sctp_client_t -l s0:c19.c30 -- $basedir/sctp_client $v -s unconfined_u:unconfined_r:test_sctp_server_t:s0:c20.c335 -r \"denied.*\\{ recv \\}\" -z 6 -i seq 127.0.0.1 1035 2>&1";
 ok( $result >> 8 eq 6 );
 
 # TAG 2 allows a maximum of 15 categories in exchange, if greater then ENOSPC (No space left on device)
@@ -581,7 +581,7 @@ ok( $result eq 0 );
 
 # Verify that client cannot communicate with the server using STREAM->SEQ->peeloff with invalid level.
 $result = system
-"runcon -t test_sctp_client_t -l s0:c0.c11 -- $basedir/sctp_client $v -x -i stream 127.0.0.1 1035 2>&1";
+"runcon -t test_sctp_client_t -l s0:c0.c11 -- $basedir/sctp_client $v -s unconfined_u:unconfined_r:test_sctp_server_t:s0:c0.c10 -r \"denied.*\\{ recv \\}\" -z 6 -x -i stream 127.0.0.1 1035 2>&1";
 ok( $result >> 8 eq 6 );
 
 # Kill the seq server.
@@ -622,7 +622,7 @@ ok( $result eq 0 );
 
 # Verify that authorized client cannot communicate with the server using invalid level STREAM->STREAM.
 $result = system
-"runcon -t test_sctp_client_t -l s0:c1023 -- $basedir/sctp_client $v stream 127.0.0.1 1035 2>&1";
+"runcon -t test_sctp_client_t -l s0:c1023 -- $basedir/sctp_client $v -s unconfined_u:unconfined_r:test_sctp_server_t:s0:c714,c769,c782,c788,c803,c842,c864 -r \"denied.*\\{ recv \\}\" -z 6 stream 127.0.0.1 1035 2>&1";
 ok( $result >> 8 eq 6 );
 
 # Kill the stream server.
@@ -652,7 +652,7 @@ ok( $result eq 0 );
 
 # Verify that client cannot communicate with the server using SEQ->SEQ with invalid level.
 $result = system
-"runcon -t test_sctp_client_t -l s0:c20.c51 -- $basedir/sctp_client $v -i seq 127.0.0.1 1035 2>&1";
+"runcon -t test_sctp_client_t -l s0:c20.c51 -- $basedir/sctp_client $v -s unconfined_u:unconfined_r:test_sctp_server_t:s0:c20.c50 -r \"denied.*\\{ recv \\}\" -z 6 -i seq 127.0.0.1 1035 2>&1";
 ok( $result >> 8 eq 6 );
 
 # TAG 2 allows a maximum of 7 ranges in exchange, if greater then ENOSPC (No space left on device)
@@ -684,7 +684,7 @@ ok( $result eq 0 );
 
 # Verify that client cannot communicate with the server using STREAM->SEQ->peeloff with invalid level.
 $result = system
-"runcon -t test_sctp_client_t -l s0:c0.c11 -- $basedir/sctp_client $v -x -i stream 127.0.0.1 1035 2>&1";
+"runcon -t test_sctp_client_t -l s0:c0.c11 -- $basedir/sctp_client $v -s unconfined_u:unconfined_r:test_sctp_server_t:s0:c0.c10 -r \"denied.*\\{ recv \\}\" -z 6 -x -i stream 127.0.0.1 1035 2>&1";
 ok( $result >> 8 eq 6 );
 
 # Kill the seq server.
@@ -710,7 +710,7 @@ ok( $result eq 0 );
 
 # Verify a client without peer { recv } for client/server process cannot communicate with server STREAM->STREAM.
 $result = system
-"runcon -t test_sctp_deny_peer_client_t -- $basedir/sctp_client $v stream 127.0.0.1 1035 2>&1";
+"runcon -t test_sctp_deny_peer_client_t -- $basedir/sctp_client $v -r \"denied.*\\{ recv \\}\" -z 6 stream 127.0.0.1 1035 2>&1";
 ok( $result >> 8 eq 6 );
 
 # Kill the stream server.
@@ -727,7 +727,7 @@ ok( $result eq 0 );
 
 # Verify that a client without peer { recv } permission cannot communicate with the server SEQ->SEQ.
 $result = system
-"runcon -t test_sctp_deny_peer_client_t -- $basedir/sctp_client $v seq 127.0.0.1 1035 2>&1";
+"runcon -t test_sctp_deny_peer_client_t -- $basedir/sctp_client $v -r \"denied.*\\{ recv \\}\" -z 6 seq 127.0.0.1 1035 2>&1";
 ok( $result >> 8 eq 6 );
 
 # Kill the seq server.
@@ -772,7 +772,7 @@ if ($test_calipso) {
 
 # Verify that authorized client cannot communicate with the server using invalid level STREAM->STREAM.
     $result = system
-"runcon -t test_sctp_client_t -l s0:c8.c12 -- $basedir/sctp_client $v -i stream ::1 1035 2>&1";
+"runcon -t test_sctp_client_t -l s0:c8.c12 -- $basedir/sctp_client $v -s unconfined_u:unconfined_r:test_sctp_server_t:s0:c0,c12,c24,c28,c36,c42,c44,c128,c138,c152,c158,c246,c290,c318,c330,c354,c368,c392,c414,c516,c534,c570,c594,c610,c622,c634,c648,c662,c686,c698,c712,c714,c726,c740,c769,c782,c788,c803,c820,c832,c842,c856,c864,c896,c924,c936,c950,c960,c986,c1023 -r \"denied.*\\{ recv \\}\" -z 6 -i stream ::1 1035 2>&1";
     ok( $result >> 8 eq 6 );
 
     # Kill the stream server.
@@ -802,12 +802,12 @@ if ($test_calipso) {
 
 # Verify that client cannot communicate with the server using SEQ->SEQ with invalid level.
     $result = system
-"runcon -t test_sctp_client_t -l s0:c20.c51 $basedir/sctp_client $v -i seq ::1 1035 2>&1";
+"runcon -t test_sctp_client_t -l s0:c20.c51 $basedir/sctp_client $v -s unconfined_u:unconfined_r:test_sctp_server_t:s0:c20.c50 -r \"denied.*\\{ recv \\}\" -z 6 -i seq ::1 1035 2>&1";
     ok( $result >> 8 eq 6 );
 
 # Verify that client cannot communicate with the server using SEQ->SEQ with invalid level.
     $result = system
-"runcon -t test_sctp_client_t -l s0:c19.c50 -- $basedir/sctp_client $v -i seq ::1 1035 2>&1";
+"runcon -t test_sctp_client_t -l s0:c19.c50 -- $basedir/sctp_client $v -s unconfined_u:unconfined_r:test_sctp_server_t:s0:c20.c50 -r \"denied.*\\{ recv \\}\" -z 6 -i seq ::1 1035 2>&1";
     ok( $result >> 8 eq 6 );
 
     # Kill server.
@@ -834,7 +834,7 @@ if ($test_calipso) {
 
 # Verify that client cannot communicate with the server using STREAM->SEQ->peeloff with invalid level.
     $result = system
-"runcon -t test_sctp_client_t -l s0:c0.c11 -- $basedir/sctp_client $v -x -i stream ::1 1035 2>&1";
+"runcon -t test_sctp_client_t -l s0:c0.c11 -- $basedir/sctp_client $v -s unconfined_u:unconfined_r:test_sctp_server_t:s0:c0.c10 -r \"denied.*\\{ recv \\}\" -z 6 -x -i stream ::1 1035 2>&1";
     ok( $result >> 8 eq 6 );
 
     # Kill the seq server.
@@ -859,7 +859,7 @@ sub test_tables {
 
 # Verify that a client without packet { recv } permission cannot communicate with the server STREAM->STREAM.
     $result = system
-"runcon -t test_sctp_deny_peer_client_t -- $basedir/sctp_client $v -e nopeer stream 127.0.0.1 1035 2>&1";
+"runcon -t test_sctp_deny_peer_client_t -- $basedir/sctp_client $v -r \"denied.*\\{ recv \\}\" -z 6 -e nopeer stream 127.0.0.1 1035 2>&1";
     ok( $result >> 8 eq 6 );
 
  # Verify that authorized client can communicate with the server STREAM->STREAM.
@@ -869,7 +869,7 @@ sub test_tables {
 
 # Verify that a client without packet { recv } permission cannot communicate with the server STREAM->STREAM.
     $result = system
-"runcon -t test_sctp_deny_peer_client_t -- $basedir/sctp_client $v -e nopeer stream ::1 1035 2>&1";
+"runcon -t test_sctp_deny_peer_client_t -- $basedir/sctp_client $v -r \"denied.*\\{ recv \\}\" -z 6 -e nopeer stream ::1 1035 2>&1";
     ok( $result >> 8 eq 6 );
 
     # Kill the stream server.
@@ -886,7 +886,7 @@ sub test_tables {
 
 # Verify that a client without packet { recv } permission cannot communicate with the server SEQ->SEQ.
     $result = system
-"runcon -t test_sctp_deny_peer_client_t -- $basedir/sctp_client $v -e nopeer seq 127.0.0.1 1035 2>&1";
+"runcon -t test_sctp_deny_peer_client_t -- $basedir/sctp_client $v -r \"denied.*\\{ recv \\}\" -z 6 -e nopeer seq 127.0.0.1 1035 2>&1";
     ok( $result >> 8 eq 6 );
 
     # Verify that authorized client can communicate with the server SEQ->SEQ.
@@ -896,7 +896,7 @@ sub test_tables {
 
 # Verify that a client without packet { recv } permission cannot communicate with the server SEQ->SEQ.
     $result = system
-"runcon -t test_sctp_deny_peer_client_t -- $basedir/sctp_client $v -e nopeer seq ::1 1035 2>&1";
+"runcon -t test_sctp_deny_peer_client_t -- $basedir/sctp_client $v -r \"denied.*\\{ recv \\}\" -z 6 -e nopeer seq ::1 1035 2>&1";
     ok( $result >> 8 eq 6 );
 
     # Kill the seq server.
diff --git a/travis-ci/run-testsuite.sh b/travis-ci/run-testsuite.sh
index bd9073c..ecc022f 100755
--- a/travis-ci/run-testsuite.sh
+++ b/travis-ci/run-testsuite.sh
@@ -41,6 +41,7 @@ dnf install -y \
     e2fsprogs \
     jfsutils \
     dosfstools \
+    audit-libs-devel \
     kernel-devel-"$(uname -r)" \
     kernel-modules-"$(uname -r)"
 
-- 
2.28.0

