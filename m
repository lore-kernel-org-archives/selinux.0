Return-Path: <SRS0=faga=6E=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1A4C3A5A0
	for <selinux@archiver.kernel.org>; Mon, 20 Apr 2020 13:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35BEF2070B
	for <selinux@archiver.kernel.org>; Mon, 20 Apr 2020 13:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="YpUaUNxa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgDTNVw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Apr 2020 09:21:52 -0400
Received: from mailomta5-sa.btinternet.com ([213.120.69.11]:25185 "EHLO
        sa-prd-fep-044.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726049AbgDTNVv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Apr 2020 09:21:51 -0400
Received: from sa-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.38.7])
          by sa-prd-fep-044.btinternet.com with ESMTP
          id <20200420132138.WQX17767.sa-prd-fep-044.btinternet.com@sa-prd-rgout-004.btmx-prd.synchronoss.net>;
          Mon, 20 Apr 2020 14:21:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1587388898; 
        bh=c7cFc7Z7LCDNvqVSMY1px5GpstLt0X/Bu1aqH1c49Q0=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=YpUaUNxaPFreLXcMTaL41WejefHGPy4tMCOYJfKr38bszcGnOXuADBUDnsY/QORYpvUHmauj1NigH9J1EqhSrM5GxoPb2mtTrG/roxZtxmD0rY+x1jO60R3Hd/Fjn4jvKbua+IC9mYDOuf7n2Cmoxz69Ks3WqRLXkGhVYdNtbI67Skrh0s/U4Ta0+/q6E9mmlfLqn1y0ABfUQsmVtYQuJvpDBZKNWbUfP2R9cWgUYVNtehVg5mvGm4T+3qsBZpABbyTZn4jgPbz+qkJimm/r+Z5ZwLlluFLPfRcBh/LUqmNoz+YWC1/m6vFYL/bJRwxDYB6qn22vFQWfhotmBq8OYw==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [86.184.99.33]
X-OWM-Source-IP: 86.184.99.33 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=49/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduhedrgeefgdeifecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucgoufhushhpvggtthffohhmrghinhculdegledmnecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucffohhmrghinheplhhivhgvjhhouhhrnhgrlhdrtghomhenucfkphepkeeirddukeegrdelledrfeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudekgedrleelrdeffedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuqfftvefrvfeprhhftgekvddvnehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqe
X-RazorGate-Vade-Verdict: clean 49
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.184.99.33) by sa-prd-rgout-004.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5E3A27DB0C5FCA42; Mon, 20 Apr 2020 14:21:37 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [RFC PATCH] selinux-testsuite: Run tests using remote server
Date:   Mon, 20 Apr 2020 14:21:32 +0100
Message-Id: <20200420132132.36942-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This RFC patch will allow another server with the testsuite installed to
act as a remote server. The main tests will be run on the client system,
with the remotely enabled server components running on the remote server.

This version updates the inet_socket and sctp tests to run their server
components on the remote system controlled by ncat(1).

The README.md contains instructions for setting up & running.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 README.md                                     | 132 ++++
 policy/test_inet_socket.te                    |   2 +
 policy/test_sctp.te                           |   2 +
 tests/inet_socket/calipso-load                |   3 +-
 tests/inet_socket/cipso-fl-load               |   2 +-
 .../inet_socket/{cipso-load-t1 => cipso-load} |   4 +-
 tests/inet_socket/cipso-load-t2               |  11 -
 tests/inet_socket/cipso-load-t5               |  11 -
 tests/inet_socket/client.c                    |  11 +-
 tests/inet_socket/ipsec-load                  |  20 +-
 tests/inet_socket/start_remote_svr            |   3 +
 tests/inet_socket/stop_remote_svr             |   3 +
 tests/inet_socket/test                        | 444 +++++++++---
 tests/sctp/calipso-load                       |   2 +-
 tests/sctp/{cipso-load-t2 => cipso-load}      |   4 +-
 tests/sctp/cipso-load-t1                      |   7 -
 tests/sctp/cipso-load-t5                      |   7 -
 tests/sctp/sctp_asconf_params_client.c        |  10 +-
 tests/sctp/sctp_asconf_params_server.c        |   2 +-
 tests/sctp/start_remote_svr                   |   3 +
 tests/sctp/stop_remote_svr                    |   3 +
 tests/sctp/test                               | 671 +++++++++++++-----
 tools/remote.cfg                              |  27 +
 tools/remote.sh                               |  92 +++
 24 files changed, 1166 insertions(+), 310 deletions(-)
 rename tests/inet_socket/{cipso-load-t1 => cipso-load} (72%)
 delete mode 100644 tests/inet_socket/cipso-load-t2
 delete mode 100644 tests/inet_socket/cipso-load-t5
 create mode 100644 tests/inet_socket/start_remote_svr
 create mode 100644 tests/inet_socket/stop_remote_svr
 rename tests/sctp/{cipso-load-t2 => cipso-load} (58%)
 delete mode 100644 tests/sctp/cipso-load-t1
 delete mode 100644 tests/sctp/cipso-load-t5
 create mode 100644 tests/sctp/start_remote_svr
 create mode 100644 tests/sctp/stop_remote_svr
 create mode 100644 tools/remote.cfg
 create mode 100755 tools/remote.sh

diff --git a/README.md b/README.md
index 27c9d56..89722cf 100644
--- a/README.md
+++ b/README.md
@@ -282,3 +282,135 @@ directory (based on the path of the script executable).  This won't always be
 accurate, but will work for this test harness/configuration.
 
 	$basedir = $0;  $basedir =~ s|(.*)/[^/]*|$1|;
+
+
+# REMOTE SERVER TESTING
+
+It is possible to run tests with remotely enabled server components on a
+remote server using `ncat`. The currently enabled tests are `inet_socket`
+and `sctp`. The requirements are a client system that would run the complete
+test-suite and a server that runs the test server components under the
+control of `ncat`. The IP address setup requirements are:
+
+The mandatory Client addresses are:
+
+1. One IPv4 address for IPv4 network tests.
+
+2. One IPv6 address for IPv6 network tests - This must not (currently) be a
+local link address as there are issues with these on some IPSEC/CALIPSO tests.
+
+
+The mandatory Server addresses are:
+
+1. One IPv4 or IPv6 address for the `ncat` client/server control session. This
+must not be used for test traffic that consists of IPSEC, CIPSO and CALIPSO
+streams.
+
+2. One IPv4 address for IPv4 network tests.
+
+3. One IPv6 address for IPv6 network tests - This must not (currently) be a
+local link address.
+
+If SCTP/ASCONF testing is required, then a second server IPv6 address needs
+to be configured. This maybe a local link address, however it must have the
+interface name appended, e.g. `addr%ifname`.
+
+The following diagram shows the setup that is configured via a common
+`remote.cfg` configuration file that is installed on both servers.
+
+```
+                               ncat(1) Control Link
+                +------------------------------------------+
+                |                                          |
+        +-------+-------+                          +-------+-------+
+        |               +--- IPv4/6 Test Link 1 ---+               |
+        |    Client     |                          |     Server    |
+        |               +---  IPv6 Test Link 2  ---+               |
+        +---------------+                          +---------------+
+```
+
+## Installation
+
+Both Client and Server systems should have all the standard packages installed
+for the selinux-testsuite. While both should be the at same level, only the
+kernel version is checked that it supports the SCTP tests.
+
+On Fedora the `nmap-ncat` package must be installed with the following
+command:
+
+	# dnf install nmap-ncat
+
+Other Linux distributions should have a similar package.
+
+The common `tools/remote.cfg` file must be configured with the mandatory
+IP addresses and installed on both systems as described in the next section.
+
+
+## `remote.cfg` Configuration File
+
+Below is an example `remote.cfg` configuration file that shows the information
+required. Edit the `tools/remote.cfg` file to suit the test setup and install
+on both systems.
+
+```
+# Client -> Server address. Do not use the same ncat_host address for any
+# test server traffic as IPSEC, CIPSO & CALIPSO will cause protocol errors.
+ncat_host=193.168.1.65
+ncat_port=9999
+
+###########################################################################
+# NOTE: The c_ipv6_1 and s_ipv6_1 MUST be full IPv6 addresses. Using local
+# link addresses work for some tests, however IPSEC & CALIPSO fail for some
+# as yet unknown reason.
+###########################################################################
+
+# Client side MUST have one of each IPv4 and IPv6 addresses
+c_ipv4_1=192.168.1.198
+c_ipv6_1=2a00:23c6:278e:c901:3bf7:29c9:2139:91d0
+# The ifname is ONLY required for Client side if the Server side s_ipv6_1 is
+# an IPv6 local link address, as the client will use 's_ipv6_1%c_ifname' for
+# the server address (however see above note).
+c_ifname=
+
+# Server side MUST have one of each IPv4 and IPv6 addresses.
+# If testing SCTP for add/remove bindx addresses and inform the client
+# side via ASCONF chunks test, then an additional IPv6 address is required.
+# If it is a local link address, it MUST have the server side ifname
+# associated to it.
+s_ipv4_1=192.168.1.148
+s_ipv6_1=2a00:23c6:278e:c901:ff65:b87b:a84d:29a8
+s_ipv6_2=fe80::7f74:f41a:3c70:d333%enp9s0
+```
+
+## Running The Tests
+
+Once both systems are configured and the test-suite has been successfully
+run locally on each system, on the Remote Server run:
+
+       # cd selinux-testsuite
+       # ./tools/remote.sh -l
+
+The `remote.sh` script will load the policy, make the executables, then
+run any additional commands to allow the server side tests to complete (for
+example IPSEC and SCTP require additional firewall rules). Finally it runs
+`ncat` to listen on the configured port.
+
+To run the complete test-suite on the Client Server run:
+
+       # cd selinux-testsuite
+       # ./tools/remote.sh
+
+The `remote.sh` script will load the policy, make the executables, then
+run any additional commands to allow the server side tests to complete (for
+example SCTP requires additional firewall rules).
+
+Optionally any single test can be run, however `inet_socket` and `sctp` are
+the only relevant ones enabled. To run `inet_socket`:
+
+       # cd selinux-testsuite
+       # ./tools/remote.sh inet_socket
+
+`sctp` can also be run with the `-v` option.
+
+Note that the test policy must be loaded if individual tests are run as the
+script only runs `make` for these.
diff --git a/policy/test_inet_socket.te b/policy/test_inet_socket.te
index bf839df..39e003b 100644
--- a/policy/test_inet_socket.te
+++ b/policy/test_inet_socket.te
@@ -35,6 +35,8 @@ corenet_inout_generic_node(test_inet_server_t)
 
 # For writing to flag file:
 allow test_inet_server_t test_file_t:fifo_file rw_file_perms;
+# Remote tests on client side for flag file:
+userdom_search_user_home_content(test_inet_server_t)
 
 # We need to ensure that the test domain is MCS constrained.
 ## newer systems, e.g. Fedora and RHEL >= 7.x
diff --git a/policy/test_sctp.te b/policy/test_sctp.te
index df8606e..ba7d590 100644
--- a/policy/test_sctp.te
+++ b/policy/test_sctp.te
@@ -152,6 +152,8 @@ corenet_sctp_bind_all_nodes(test_sctp_set_peer_addr_t)
 corenet_inout_generic_node(test_sctp_set_peer_addr_t)
 corenet_inout_generic_if(test_sctp_set_peer_addr_t)
 
+allow test_sctp_set_peer_addr_t test_sctp_client_t:sctp_socket { connect };
+
 #
 ######################### SECMARK-specific policy ############################
 #
diff --git a/tests/inet_socket/calipso-load b/tests/inet_socket/calipso-load
index 4bb9c7f..253b0b1 100644
--- a/tests/inet_socket/calipso-load
+++ b/tests/inet_socket/calipso-load
@@ -4,4 +4,5 @@ netlabelctl calipso add pass doi:16
 netlabelctl map del default
 netlabelctl map add default address:0.0.0.0/0 protocol:unlbl
 netlabelctl map add default address:::/0 protocol:unlbl
-netlabelctl map add default address:::1 protocol:calipso,16
+netlabelctl map add default address:$1 protocol:calipso,16
+#netlabelctl -p map list
diff --git a/tests/inet_socket/cipso-fl-load b/tests/inet_socket/cipso-fl-load
index 3fbc928..fb62577 100644
--- a/tests/inet_socket/cipso-fl-load
+++ b/tests/inet_socket/cipso-fl-load
@@ -12,4 +12,4 @@ netlabelctl cipsov4 add local doi:1
 netlabelctl map del default
 netlabelctl map add default address:0.0.0.0/0 protocol:unlbl
 netlabelctl map add default address:::/0 protocol:unlbl
-netlabelctl map add default address:127.0.0.1 protocol:cipsov4,1
+netlabelctl map add default address:$1 protocol:cipsov4,1
diff --git a/tests/inet_socket/cipso-load-t1 b/tests/inet_socket/cipso-load
similarity index 72%
rename from tests/inet_socket/cipso-load-t1
rename to tests/inet_socket/cipso-load
index 974e746..e877796 100644
--- a/tests/inet_socket/cipso-load-t1
+++ b/tests/inet_socket/cipso-load
@@ -4,8 +4,8 @@
 # Modifications:
 # - Defined a doi for testing loopback for CIPSOv4.
 
-netlabelctl cipsov4 add pass doi:16 tags:1
+netlabelctl cipsov4 add pass doi:16 tags:$1
 netlabelctl map del default
 netlabelctl map add default address:0.0.0.0/0 protocol:unlbl
 netlabelctl map add default address:::/0 protocol:unlbl
-netlabelctl map add default address:127.0.0.1 protocol:cipsov4,16
+netlabelctl map add default address:$2 protocol:cipsov4,16
diff --git a/tests/inet_socket/cipso-load-t2 b/tests/inet_socket/cipso-load-t2
deleted file mode 100644
index 9892f81..0000000
--- a/tests/inet_socket/cipso-load-t2
+++ /dev/null
@@ -1,11 +0,0 @@
-#!/bin/sh
-# Based on http://paulmoore.livejournal.com/7234.html.
-#
-# Modifications:
-# - Defined a doi for testing loopback for CIPSOv4.
-
-netlabelctl cipsov4 add pass doi:16 tags:2
-netlabelctl map del default
-netlabelctl map add default address:0.0.0.0/0 protocol:unlbl
-netlabelctl map add default address:::/0 protocol:unlbl
-netlabelctl map add default address:127.0.0.1 protocol:cipsov4,16
diff --git a/tests/inet_socket/cipso-load-t5 b/tests/inet_socket/cipso-load-t5
deleted file mode 100644
index 662747d..0000000
--- a/tests/inet_socket/cipso-load-t5
+++ /dev/null
@@ -1,11 +0,0 @@
-#!/bin/sh
-# Based on http://paulmoore.livejournal.com/7234.html.
-#
-# Modifications:
-# - Defined a doi for testing loopback for CIPSOv4.
-
-netlabelctl cipsov4 add pass doi:16 tags:5
-netlabelctl map del default
-netlabelctl map add default address:0.0.0.0/0 protocol:unlbl
-netlabelctl map add default address:::/0 protocol:unlbl
-netlabelctl map add default address:127.0.0.1 protocol:cipsov4,16
diff --git a/tests/inet_socket/client.c b/tests/inet_socket/client.c
index f8780d9..fa153ab 100644
--- a/tests/inet_socket/client.c
+++ b/tests/inet_socket/client.c
@@ -19,11 +19,12 @@
 void usage(char *progname)
 {
 	fprintf(stderr,
-		"usage:  %s [-e expected_msg] [stream|dgram] addr port\n"
+		"usage:  %s [-e expected_msg] [-r] [stream|dgram] addr port\n"
 		"\nWhere:\n\t"
 		"-e      Optional expected message from server e.g. \"nopeer\".\n\t"
 		"        If not present the client context will be used as a\n\t"
 		"        comparison with the servers reply.\n\t"
+		"-r      When running remote tests client prints server response\n\t"
 		"stream  Use TCP protocol or:\n\t"
 		"dgram   use UDP protocol.\n\t"
 		"addr    IPv4 or IPv6 address (e.g. 127.0.0.1 or ::1)\n\t"
@@ -37,12 +38,16 @@ int main(int argc, char **argv)
 	int sock, result, opt;
 	struct addrinfo hints, *serverinfo;
 	struct timeval tm;
+	bool remote = false;
 
-	while ((opt = getopt(argc, argv, "e:")) != -1) {
+	while ((opt = getopt(argc, argv, "e:r")) != -1) {
 		switch (opt) {
 		case 'e':
 			expected = optarg;
 			break;
+		case 'r':
+			remote = true;
+			break;
 		default:
 			usage(argv[0]);
 		}
@@ -137,6 +142,8 @@ int main(int argc, char **argv)
 		fprintf(stderr, "%s:  expected %s, got %s\n",
 			argv[0], expected, label);
 		exit(11);
+	} else if (remote) {
+		printf("Server sent: %s\n", label);
 	}
 
 	close(sock);
diff --git a/tests/inet_socket/ipsec-load b/tests/inet_socket/ipsec-load
index 21e2dfe..e0a050d 100644
--- a/tests/inet_socket/ipsec-load
+++ b/tests/inet_socket/ipsec-load
@@ -3,15 +3,13 @@ echo 0 > /proc/sys/net/ipv4/conf/lo/disable_xfrm
 echo 0 > /proc/sys/net/ipv4/conf/lo/disable_policy
 ip xfrm policy flush
 ip xfrm state flush
-goodclientcon=`secon -u --pid $$`:`secon -r --pid $$`:test_inet_client_t:`secon -m --pid $$`
-badclientcon=`secon -u --pid $$`:`secon -r --pid $$`:test_inet_bad_client_t:`secon -m --pid $$`
-ip xfrm state add src 127.0.0.1 dst 127.0.0.1 proto ah spi 0x200 ctx $goodclientcon auth sha1 0123456789012345
-ip xfrm state add src 127.0.0.1 dst 127.0.0.1 proto ah spi 0x250 ctx $badclientcon auth sha1 0123456789012345
-ip xfrm policy add src 127.0.0.1 dst 127.0.0.1 proto tcp dir out ctx "system_u:object_r:test_spd_t:s0" tmpl proto ah mode transport level required
-ip xfrm policy add src 127.0.0.1 dst 127.0.0.1 proto udp dir out ctx "system_u:object_r:test_spd_t:s0" tmpl proto ah mode transport level required
 
-# IPv6 loopback
-ip xfrm state add src ::1 dst ::1 proto ah spi 0x200 ctx $goodclientcon auth sha1 0123456789012345
-ip xfrm state add src ::1 dst ::1 proto ah spi 0x250 ctx $badclientcon auth sha1 0123456789012345
-ip xfrm policy add src ::1 dst ::1 proto tcp dir out ctx "system_u:object_r:test_spd_t:s0" tmpl proto ah mode transport level required
-ip xfrm policy add src ::1 dst ::1 proto udp dir out ctx "system_u:object_r:test_spd_t:s0" tmpl proto ah mode transport level required
+ip -4 xfrm state add src $3 dst $4 proto ah spi 0x200 ctx $1 auth sha1 0123456789012345
+ip -4 xfrm state add src $3 dst $4 proto ah spi 0x250 ctx $2 auth sha1 0123456789012345
+ip -4 xfrm policy add src $3 dst $4 proto tcp dir out ctx "system_u:object_r:test_spd_t:s0" tmpl proto ah mode transport level required
+ip -4 xfrm policy add src $3 dst $4 proto udp dir out ctx "system_u:object_r:test_spd_t:s0" tmpl proto ah mode transport level required
+
+ip -6 xfrm state add src $5 dst $6 proto ah spi 0x200 ctx $1 auth sha1 0123456789012345
+ip -6 xfrm state add src $5 dst $6 proto ah spi 0x250 ctx $2 auth sha1 0123456789012345
+ip -6 xfrm policy add src $5 dst $6 proto tcp dir out ctx "system_u:object_r:test_spd_t:s0" tmpl proto ah mode transport level required
+ip -6 xfrm policy add src $5 dst $6 proto udp dir out ctx "system_u:object_r:test_spd_t:s0" tmpl proto ah mode transport level required
diff --git a/tests/inet_socket/start_remote_svr b/tests/inet_socket/start_remote_svr
new file mode 100644
index 0000000..57d2774
--- /dev/null
+++ b/tests/inet_socket/start_remote_svr
@@ -0,0 +1,3 @@
+#!/bin/sh
+
+$1 & disown
diff --git a/tests/inet_socket/stop_remote_svr b/tests/inet_socket/stop_remote_svr
new file mode 100644
index 0000000..2846277
--- /dev/null
+++ b/tests/inet_socket/stop_remote_svr
@@ -0,0 +1,3 @@
+#!/bin/sh
+
+kill $1 >/dev/null 2>&1
diff --git a/tests/inet_socket/test b/tests/inet_socket/test
index 47ce106..75e7baf 100755
--- a/tests/inet_socket/test
+++ b/tests/inet_socket/test
@@ -30,8 +30,43 @@ BEGIN {
     plan tests => $test_count;
 }
 
+# Note the ncat address must NOT be used for tests as
+# CIPSO/CALIPSO/IPSEC will cause protocol errors.
+$s_basedir = "tests/inet_socket";
+$ncat_host = $ENV{'NCAT_HOST'};
+$ncat_port = $ENV{'NCAT_PORT'};
+if ( defined $ncat_host and defined $ncat_port ) {
+    print "Running remote servers on IP addr: $ncat_host\n";
+
+    # Get ipv4/6 addrs
+    $c_ipv4_1 = $ENV{'C_IPV4_1'};
+    $c_ipv6_1 = $ENV{'C_IPV6_1'};
+    $c_ifname = $ENV{'C_IFNAME'};
+    $s_ipv4_1 = $ENV{'S_IPV4_1'};
+    $s_ipv6_1 = $ENV{'S_IPV6_1'};
+
+    # IPv6 tests require ifname for local link address
+    if ( defined $c_ifname ) {
+        $s_ipv6_ifn_1 = "$s_ipv6_1\%$c_ifname";
+    }
+    else {
+        $s_ipv6_ifn_1 = $s_ipv6_1;
+    }
+
+    $r    = "-r";                                # Print server response
+    $ncat = "ncat $ncat_host $ncat_port 2>&1";
+}
+else {
+    $c_ipv4_1     = "127.0.0.1";
+    $c_ipv6_1     = "::1";
+    $s_ipv4_1     = "127.0.0.1";
+    $s_ipv6_1     = "::1";
+    $s_ipv6_ifn_1 = "::1";
+    $r            = " ";
+}
+
 sub server_start {
-    my ( $runcon_args, $args ) = @_;
+    my ( $runcon_args, $args, $text ) = @_;
     my $pid;
 
     system("mkfifo $basedir/flag");
@@ -42,6 +77,7 @@ sub server_start {
 
     # Wait for it to initialize.
     system("read -t 5 <>$basedir/flag");
+    print "Started $text server\n";
     return $pid;
 }
 
@@ -53,36 +89,70 @@ sub server_end {
     system("rm -f $basedir/flag");
 }
 
-# Load NetLabel configuration for full CIPSO/IPv4 labeling over loopback.
-system "/bin/sh $basedir/cipso-fl-load";
+sub remote_server_start {
+    my ( $runcon_args, $args, $text ) = @_;
+    my $pid;
+
+    # Start remote server and retrieve process ID to check if ready
+
+`echo "/bin/sh $s_basedir/start_remote_svr 'runcon $runcon_args $s_basedir/server $args'" | $ncat`;
+
+    $pid = $pid = `(echo 'pidof $s_basedir/server'; read -t 2) | $ncat`;
+    chomp($pid);
+    if ( not $pid ) {
+        print "Could not obtain remote server PID\n";
+    }
+    else {
+        print "Started $text server - PID: $pid\n";
+    }
+
+    return $pid;
+}
+
+sub remote_server_end {
+    my ($pid) = @_;
+
+    `echo "/bin/sh $s_basedir/stop_remote_svr $pid" | $ncat`;
+}
+
+# Load NetLabel configuration for full CIPSO/IPv4 labeling.
+system "/bin/sh $basedir/cipso-fl-load $c_ipv4_1";
 
 # Start the stream server.
-$pid = server_start( "-t test_inet_server_t", "stream 65535" );
+$pid = server_start(
+    "-t test_inet_server_t",
+    "stream 65535",
+    "local full CIPSO labeling - stream"
+);
 
 # Verify that authorized client can communicate with the server.
 $result =
-  system "runcon -t test_inet_client_t $basedir/client stream 127.0.0.1 65535";
+  system "runcon -t test_inet_client_t $basedir/client stream $c_ipv4_1 65535";
 ok( $result eq 0 );
 
 # Verify that unauthorized client cannot communicate with the server.
 $result = system
-"runcon -t test_inet_bad_client_t -- $basedir/client stream 127.0.0.1 65535 2>&1";
+"runcon -t test_inet_bad_client_t -- $basedir/client stream $c_ipv4_1 65535 2>&1";
 ok( $result >> 8 eq 5 );
 
 # Kill the server.
 server_end($pid);
 
 # Start the dgram server.
-$pid = server_start( "-t test_inet_server_t", "dgram 65535" );
+$pid = server_start(
+    "-t test_inet_server_t",
+    "dgram 65535",
+    "local full CIPSO labeling - dgram"
+);
 
 # Verify that authorized client can communicate with the server.
 $result =
-  system "runcon -t test_inet_client_t $basedir/client dgram 127.0.0.1 65535";
+  system "runcon -t test_inet_client_t $basedir/client dgram $c_ipv4_1 65535";
 ok( $result eq 0 );
 
 # Verify that unauthorized client cannot communicate with the server.
 $result = system
-"runcon -t test_inet_bad_client_t -- $basedir/client dgram 127.0.0.1 65535 2>&1";
+"runcon -t test_inet_bad_client_t -- $basedir/client dgram $c_ipv4_1 65535 2>&1";
 ok( $result >> 8 eq 9 );
 
 # Kill the server.
@@ -91,95 +161,168 @@ server_end($pid);
 # Flush NetLabel configuration.
 system "/bin/sh $basedir/cipso-fl-flush";
 
-# Load NetLabel configuration for CIPSO/IPv4 using TAG 1 over loopback.
-system "/bin/sh $basedir/cipso-load-t1";
-
-# Start the stream server with a defined level.
-$pid = server_start( "-t test_inet_server_t -l s0:c20.c250", "stream 65535" );
+# Load NetLabel configuration for CIPSO/IPv4 using TAG 1
+$tag = "1";
+system "/bin/sh $basedir/cipso-load $tag $s_ipv4_1";
+
+if ( defined $ncat_host ) {    # Set remote cipso config + start server
+    `echo "/bin/sh $s_basedir/cipso-load $tag $c_ipv4_1" | $ncat`;
+    $pid = remote_server_start(
+        "-t test_inet_server_t -l s0:c20.c250",
+        "stream 65535",
+        "remote TAG 1 CIPSO - stream"
+    );
+}
+else {
+    $pid = server_start(
+        "-t test_inet_server_t -l s0:c20.c250",
+        "stream 65535",
+        "local TAG 1 CIPSO - stream"
+    );
+}
 
 # Verify that authorized client can communicate with the server using level within T1 range.
 $result = system
-"runcon -t test_inet_client_t -l s0:c61.c239 $basedir/client -e system_u:object_r:netlabel_peer_t:s0:c61.c239 stream 127.0.0.1 65535";
+"runcon -t test_inet_client_t -l s0:c61.c239 $basedir/client $r -e system_u:object_r:netlabel_peer_t:s0:c61.c239 stream $s_ipv4_1 65535";
 ok( $result eq 0 );
 
 # Verify that authorized client cannot communicate with the server using different level.
 $result = system
-"runcon -t test_inet_client_t -l s0:c19,c120 $basedir/client stream 127.0.0.1 65535 2>&1";
+"runcon -t test_inet_client_t -l s0:c19,c120 $basedir/client $r stream $s_ipv4_1 65535 2>&1";
 ok( $result >> 8 eq 5 );
 
 # TAG 1 allows categories 0 to 239 to be sent, if greater then ENOSPC (No space left on device)
 $result = system
-"runcon -t test_inet_client_t -l s0:c0.c240 $basedir/client stream 127.0.0.1 65535 2>&1";
+"runcon -t test_inet_client_t -l s0:c0.c240 $basedir/client $r stream $s_ipv4_1 65535 2>&1";
 ok( $result >> 8 eq 5 );
 
-# Kill the server.
-server_end($pid);
+# kill server.
+if ( defined $ncat_host ) {
+    remote_server_end($pid);
+}
+else {
+    server_end($pid);
+}
 
 # Start the dgram server with a defined level.
-$pid = server_start( "-t test_inet_server_t -l s0:c20.c50", "dgram 65535" );
+if ( defined $ncat_host ) {
+    $pid = remote_server_start(
+        "-t test_inet_server_t -l s0:c20.c50",
+        "dgram 65535",
+        "remote TAG 1 CIPSO - dgram"
+    );
+}
+else {
+    $pid = server_start(
+        "-t test_inet_server_t -l s0:c20.c50",
+        "dgram 65535",
+        "local TAG 1 CIPSO - dgram"
+    );
+}
 
 # Verify that authorized client can communicate with the server using same levels.
 $result = system
-"runcon -t test_inet_client_t -l s0:c20.c50 $basedir/client -e system_u:object_r:netlabel_peer_t:s0:c20.c50 dgram 127.0.0.1 65535";
+"runcon -t test_inet_client_t -l s0:c20.c50 $basedir/client $r -e system_u:object_r:netlabel_peer_t:s0:c20.c50 dgram $s_ipv4_1 65535";
 ok( $result eq 0 );
 
 # Verify that authorized client cannot communicate with the server using levels dominating the server.
 $result = system
-"runcon -t test_inet_client_t -l s0:c40.c51 $basedir/client dgram 127.0.0.1 65535 2>&1";
+"runcon -t test_inet_client_t -l s0:c40.c51 $basedir/client $r dgram $s_ipv4_1 65535 2>&1";
 ok( $result >> 8 eq 9 );
 
-# Kill the server.
-server_end($pid);
-
-# Flush NetLabel configuration.
+# Kill server and flush NetLabel configuration.
+if ( defined $ncat_host ) {
+    remote_server_end($pid);
+    `echo "/bin/sh $s_basedir/cipso-flush" | $ncat`;
+}
+else {
+    server_end($pid);
+}
 system "/bin/sh $basedir/cipso-flush";
 
-# Load NetLabel configuration for CIPSO/IPv4 using TAG 2 over loopback.
-system "/bin/sh $basedir/cipso-load-t2";
+# Load NetLabel configuration for CIPSO/IPv4 using TAG 2.
+$tag = "2";
+system "/bin/sh $basedir/cipso-load $tag $s_ipv4_1";
 
 # Start the stream server with a defined level.
-$pid = server_start( "-t test_inet_server_t -l s0:c0.c100", "stream 65535" );
+if ( defined $ncat_host ) {
+    `echo "/bin/sh $s_basedir/cipso-load $tag $c_ipv4_1" | $ncat`;
+    $pid = remote_server_start(
+        "-t test_inet_server_t -l s0:c0.c100",
+        "stream 65535",
+        "remote TAG 2 CIPSO - stream"
+    );
+}
+else {
+    $pid = server_start(
+        "-t test_inet_server_t -l s0:c0.c100",
+        "stream 65535",
+        "local TAG 2 CIPSO - stream"
+    );
+}
 
 # Verify that authorized client can communicate with the server using level.
 $result = system
-"runcon -t test_inet_client_t -l s0:c90.c100 $basedir/client -e system_u:object_r:netlabel_peer_t:s0:c90.c100 stream 127.0.0.1 65535";
+"runcon -t test_inet_client_t -l s0:c90.c100 $basedir/client $r -e system_u:object_r:netlabel_peer_t:s0:c90.c100 stream $s_ipv4_1 65535";
 ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server using level.
 $result = system
-"runcon -t test_inet_client_t -l s0:c0.c14 $basedir/client -e system_u:object_r:netlabel_peer_t:s0:c0.c14 stream 127.0.0.1 65535";
+"runcon -t test_inet_client_t -l s0:c0.c14 $basedir/client $r -e system_u:object_r:netlabel_peer_t:s0:c0.c14 stream $s_ipv4_1 65535";
 ok( $result eq 0 );
 
 # Verify that authorized client cannot communicate with the server using different level.
 $result = system
-"runcon -t test_inet_client_t -l s0:c101 $basedir/client stream 127.0.0.1 65535 2>&1";
+"runcon -t test_inet_client_t -l s0:c101 $basedir/client $r stream $s_ipv4_1 65535 2>&1";
 ok( $result >> 8 eq 5 );
 
 # TAG 2 allows a maximum of 15 categories in exchange, if greater then ENOSPC (No space left on device)
 $result = system
-"runcon -t test_inet_client_t -l s0:c0.c16 -- $basedir/client dgram 127.0.0.1 65535 2>&1";
+"runcon -t test_inet_client_t -l s0:c0.c16 -- $basedir/client $r dgram $s_ipv4_1 65535 2>&1";
 ok( $result >> 8 eq 5 );
 
 # Kill the server.
-server_end($pid);
+if ( defined $ncat_host ) {
+    remote_server_end($pid);
+}
+else {
+    server_end($pid);
+}
 
 # Start the dgram server with a defined level.
-$pid = server_start( "-t test_inet_server_t -l s0:c0.c14", "dgram 65535" );
+if ( defined $ncat_host ) {
+    $pid = remote_server_start(
+        "-t test_inet_server_t -l s0:c0.c14",
+        "dgram 65535",
+        "remote TAG 2 CIPSO - dgram"
+    );
+}
+else {
+    $pid = server_start(
+        "-t test_inet_server_t -l s0:c0.c14",
+        "dgram 65535",
+        "local TAG 2 CIPSO - dgram"
+    );
+}
 
 # Verify that authorized client can communicate with the server using same levels.
 $result = system
-"runcon -t test_inet_client_t -l s0:c0.c14 $basedir/client -e system_u:object_r:netlabel_peer_t:s0:c0.c14 dgram 127.0.0.1 65535";
+"runcon -t test_inet_client_t -l s0:c0.c14 $basedir/client $r -e system_u:object_r:netlabel_peer_t:s0:c0.c14 dgram $s_ipv4_1 65535";
 ok( $result eq 0 );
 
 # Verify that authorized client cannot communicate with the server using levels dominating the server.
 $result = system
-"runcon -t test_inet_client_t -l s0:c15 $basedir/client dgram 127.0.0.1 65535 2>&1";
+"runcon -t test_inet_client_t -l s0:c15 $basedir/client $r dgram $s_ipv4_1 65535 2>&1";
 ok( $result >> 8 eq 9 );
 
-# Kill the server.
-server_end($pid);
-
-# Flush NetLabel configuration.
+# Kill server and flush NetLabel configuration.
+if ( defined $ncat_host ) {
+    remote_server_end($pid);
+    `echo "/bin/sh $s_basedir/cipso-flush" | $ncat`;
+}
+else {
+    server_end($pid);
+}
 system "/bin/sh $basedir/cipso-flush";
 
 # Load NetLabel configuration for CIPSO/IPv4 using TAG 5 over loopback.
@@ -189,56 +332,93 @@ system "/bin/sh $basedir/cipso-flush";
 # * of category ranges is 7, but if the low end of the last category range is
 # * zero then it is possible to fit 8 category ranges because the zero should
 # * be omitted. */
-system "/bin/sh $basedir/cipso-load-t5";
+$tag = "5";
+system "/bin/sh $basedir/cipso-load $tag $s_ipv4_1";
 
 # Start the stream server with a defined level.
-$pid = server_start( "-t test_inet_server_t -l s0:c0.c100", "stream 65535" );
+if ( defined $ncat_host ) {
+    `echo "/bin/sh $s_basedir/cipso-load $tag $c_ipv4_1" | $ncat`;
+    $pid = remote_server_start(
+        "-t test_inet_server_t -l s0:c0.c100",
+        "stream 65535",
+        "remote TAG 5 CIPSO - stream"
+    );
+}
+else {
+    $pid = server_start(
+        "-t test_inet_server_t -l s0:c0.c100",
+        "stream 65535",
+        "local TAG 5 CIPSO - stream"
+    );
+}
 
 # Verify that authorized client can communicate with the server using level.
 $result = system
-"runcon -t test_inet_client_t -l s0:c0.c100 $basedir/client -e system_u:object_r:netlabel_peer_t:s0:c0.c100 stream 127.0.0.1 65535";
+"runcon -t test_inet_client_t -l s0:c0.c100 $basedir/client $r -e system_u:object_r:netlabel_peer_t:s0:c0.c100 stream $s_ipv4_1 65535";
 ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server using level.
 $result = system
-"runcon -t test_inet_client_t -l s0:c8.c100 $basedir/client -e system_u:object_r:netlabel_peer_t:s0:c8.c100 stream 127.0.0.1 65535";
+"runcon -t test_inet_client_t -l s0:c8.c100 $basedir/client $r -e system_u:object_r:netlabel_peer_t:s0:c8.c100 stream $s_ipv4_1 65535";
 ok( $result eq 0 );
 
 # Verify that authorized client cannot communicate with the server using different level.
 $result = system
-"runcon -t test_inet_client_t -l s0:c8.c101 $basedir/client stream 127.0.0.1 65535 2>&1";
+"runcon -t test_inet_client_t -l s0:c8.c101 $basedir/client $r stream $s_ipv4_1 65535 2>&1";
 ok( $result >> 8 eq 5 );
 
 # Verify ok with the 8 entries when cat c0:
 $result = system
-"runcon -t test_inet_client_t -l s0:c0.c3,c20.c25,c30.c36,c40.c45,c50.c55,c60.c66,c70.c78,c80.c88 $basedir/client -e system_u:object_r:netlabel_peer_t:s0:c0.c3,c20.c25,c30.c36,c40.c45,c50.c55,c60.c66,c70.c78,c80.c88 stream 127.0.0.1 65535";
+"runcon -t test_inet_client_t -l s0:c0.c3,c20.c25,c30.c36,c40.c45,c50.c55,c60.c66,c70.c78,c80.c88 $basedir/client $r -e system_u:object_r:netlabel_peer_t:s0:c0.c3,c20.c25,c30.c36,c40.c45,c50.c55,c60.c66,c70.c78,c80.c88 stream $s_ipv4_1 65535";
 ok( $result eq 0 );
 
 # Verify fail with the 8 entries when cat !c0:
 $result = system
-"runcon -t test_inet_client_t -l s0:c20.c25,c30.c36,c40.c45,c50.c55,c60.c66,c70.c78,c80.c88,c90.c99 $basedir/client stream 127.0.0.1 65535 2>&1";
+"runcon -t test_inet_client_t -l s0:c20.c25,c30.c36,c40.c45,c50.c55,c60.c66,c70.c78,c80.c88,c90.c99 $basedir/client $r stream $s_ipv4_1 65535 2>&1";
 ok( $result >> 8 eq 5 );
 
 # Kill the server.
-server_end($pid);
+if ( defined $ncat_host ) {
+    remote_server_end($pid);
+}
+else {
+    server_end($pid);
+}
 
 # Start the dgram server with a defined level.
-$pid = server_start( "-t test_inet_server_t -l s0:c0.c100", "dgram 65535" );
+if ( defined $ncat_host ) {
+    $pid = remote_server_start(
+        "-t test_inet_server_t -l s0:c0.c100",
+        "dgram 65535",
+        "remote TAG 5 CIPSO - dgram"
+    );
+}
+else {
+    $pid = server_start(
+        "-t test_inet_server_t -l s0:c0.c100",
+        "dgram 65535",
+        "local TAG 5 CIPSO - dgram"
+    );
+}
 
 # Verify that authorized client can communicate with the server using same levels.
 $result = system
-"runcon -t test_inet_client_t -l s0:c0.c100 $basedir/client -e system_u:object_r:netlabel_peer_t:s0:c0.c100 dgram 127.0.0.1 65535";
+"runcon -t test_inet_client_t -l s0:c0.c100 $basedir/client $r -e system_u:object_r:netlabel_peer_t:s0:c0.c100 dgram $s_ipv4_1 65535";
 ok( $result eq 0 );
 
 # Verify that authorized client cannot communicate with the server using levels dominating the server.
 $result = system
-"runcon -t test_inet_client_t -l s0:c40.c101 $basedir/client dgram 127.0.0.1 65535 2>&1";
+"runcon -t test_inet_client_t -l s0:c40.c101 $basedir/client $r dgram $s_ipv4_1 65535 2>&1";
 ok( $result >> 8 eq 9 );
 
-# Kill the server.
-server_end($pid);
-
-# Flush NetLabel configuration.
+# Kill server and flush NetLabel configuration.
+if ( defined $ncat_host ) {
+    remote_server_end($pid);
+    `echo "/bin/sh $s_basedir/cipso-flush" | $ncat`;
+}
+else {
+    server_end($pid);
+}
 system "/bin/sh $basedir/cipso-flush";
 
 # Verify that authorized domain can bind UDP sockets.
@@ -282,77 +462,146 @@ ok($result);
 if ($test_ipsec) {
 
     # Load IPSEC configuration.
-    system "/bin/sh $basedir/ipsec-load";
+    $user = `secon -u --pid $$`;
+    chomp($user);
+    $role = `secon -r --pid $$`;
+    chomp($role);
+    $level = `secon -m --pid $$`;
+    chomp($level);
+    $goodclientcon = "$user:$role:test_inet_client_t:$level";
+    $badclientcon  = "$user:$role:test_inet_bad_client_t:$level";
+
+    system
+"/bin/sh $basedir/ipsec-load $goodclientcon $badclientcon $c_ipv4_1 $s_ipv4_1 $c_ipv6_1 $s_ipv6_1";
 
     # Start the stream server.
-    $pid = server_start( "-t test_inet_server_t", "stream 65535" );
+    if ( defined $ncat_host ) {
+`echo "/bin/sh $s_basedir/ipsec-load $goodclientcon $badclientcon $c_ipv4_1 $s_ipv4_1 $c_ipv6_1 $s_ipv6_1" | $ncat`;
+        $pid = remote_server_start(
+            "-t test_inet_server_t",
+            "stream 65535",
+            "remote IPSEC - stream"
+        );
+    }
+    else {
+        $pid = server_start(
+            "-t test_inet_server_t",
+            "stream 65535",
+            "local IPSEC - stream"
+        );
+    }
 
     # Verify that authorized client can communicate with the server.
     $result =
       system
-      "runcon -t test_inet_client_t $basedir/client stream 127.0.0.1 65535";
+      "runcon -t test_inet_client_t $basedir/client $r stream $s_ipv4_1 65535";
     ok( $result eq 0 );
 
     # Verify that unauthorized client cannot communicate with the server.
     $result = system
-"runcon -t test_inet_bad_client_t -- $basedir/client stream 127.0.0.1 65535 2>&1";
+"runcon -t test_inet_bad_client_t -- $basedir/client $r stream $s_ipv4_1 65535 2>&1";
     ok( $result >> 8 eq 5 );
 
     # Verify that authorized client can communicate with the server.
     $result =
-      system "runcon -t test_inet_client_t $basedir/client stream ::1 65535";
+      system
+"runcon -t test_inet_client_t $basedir/client $r stream $s_ipv6_ifn_1 65535";
     ok( $result eq 0 );
 
     # Verify that unauthorized client cannot communicate with the server.
     $result = system
-"runcon -t test_inet_bad_client_t -- $basedir/client stream ::1 65535 2>&1";
+"runcon -t test_inet_bad_client_t -- $basedir/client $r stream $s_ipv6_ifn_1 65535 2>&1";
     ok( $result >> 8 eq 5 );
 
     # Kill the server.
-    server_end($pid);
+    if ( defined $ncat_host ) {
+        remote_server_end($pid);
+    }
+    else {
+        server_end($pid);
+    }
 
     # Start the dgram server.
-    $pid = server_start( "-t test_inet_server_t", "dgram 65535" );
+    if ( defined $ncat_host ) {
+        $pid = remote_server_start(
+            "-t test_inet_server_t",
+            "dgram 65535",
+            "remote IPSEC - dgram"
+        );
+    }
+    else {
+        $pid = server_start(
+            "-t test_inet_server_t",
+            "dgram 65535",
+            "local IPSEC - dgram"
+        );
+    }
 
     # Verify that authorized client can communicate with the server.
     $result =
       system
-      "runcon -t test_inet_client_t $basedir/client dgram 127.0.0.1 65535";
+      "runcon -t test_inet_client_t $basedir/client $r dgram $s_ipv4_1 65535";
     ok( $result eq 0 );
 
     # Verify that unauthorized client cannot communicate with the server.
     $result = system
-"runcon -t test_inet_bad_client_t -- $basedir/client dgram 127.0.0.1 65535 2>&1";
+"runcon -t test_inet_bad_client_t -- $basedir/client $r dgram $s_ipv4_1 65535 2>&1";
     ok( $result >> 8 eq 8 );
 
     # Verify that unauthorized client cannot communicate with the server.
     $result = system
-"runcon -t test_inet_bad_client_t -- $basedir/client dgram ::1 65535 2>&1";
+"runcon -t test_inet_bad_client_t -- $basedir/client $r dgram $s_ipv6_ifn_1 65535 2>&1";
     ok( $result >> 8 eq 8 );
 
     # Kill the server.
-    server_end($pid);
+    if ( defined $ncat_host ) {
+        remote_server_end($pid);
+    }
+    else {
+        server_end($pid);
+    }
 
 # Start the dgram server for IPSEC test using IPv6 but do not request peer context.
-    $pid = server_start( "-t test_inet_server_t", "-n dgram 65535" );
+    if ( defined $ncat_host ) {
+        $pid = remote_server_start(
+            "-t test_inet_server_t",
+            "-n dgram 65535",
+            "remote IPSEC - dgram"
+        );
+    }
+    else {
+        $pid = server_start(
+            "-t test_inet_server_t",
+            "-n dgram 65535",
+            "local IPSEC - dgram"
+        );
+    }
 
     # This test now passes.
     $result = system
-      "runcon -t test_inet_client_t $basedir/client -e nopeer dgram ::1 65535";
+"runcon -t test_inet_client_t $basedir/client $r -e nopeer dgram $s_ipv6_ifn_1 65535";
     ok( $result eq 0 );
 
-    # Kill the server.
-    server_end($pid);
-
-    # Flush IPSEC configuration.
+    # Kill server and flush IPSEC configuration.
+    if ( defined $ncat_host ) {
+        remote_server_end($pid);
+        `echo "/bin/sh $s_basedir/ipsec-flush" | $ncat`;
+    }
+    else {
+        server_end($pid);
+    }
     system "/bin/sh $basedir/ipsec-flush";
 }
 
-# Load iptables (IPv4 & IPv6) configuration.
+# Load iptables (IPv4 & IPv6) configuration. Test local only
 system "/bin/sh $basedir/iptables-load";
 
 # Start the stream server.
-$pid = server_start( "-t test_inet_server_t", "-n stream 65535" );
+$pid = server_start(
+    "-t test_inet_server_t",
+    "-n stream 65535",
+    "local iptables - stream"
+);
 
 # Verify that authorized client can communicate with the server.
 $result = system
@@ -378,7 +627,11 @@ ok( $result >> 8 eq 5 );
 server_end($pid);
 
 # Start the dgram server.
-$pid = server_start( "-t test_inet_server_t", "-n dgram 65535" );
+$pid = server_start(
+    "-t test_inet_server_t",
+    "-n dgram 65535",
+    "local iptables dgram"
+);
 
 # Verify that authorized client can communicate with the server.
 $result = system
@@ -408,30 +661,49 @@ system "/bin/sh $basedir/iptables-flush";
 
 if ($test_calipso_stream) {
 
-    # Load NetLabel configuration for CALIPSO/IPv6 labeling over loopback.
-    system "/bin/sh $basedir/calipso-load";
+    # Load NetLabel configuration for CALIPSO/IPv6 labeling.
+    system "/bin/sh $basedir/calipso-load $s_ipv6_1";
 
     # Start the stream server.
-    $pid = server_start( "-t test_inet_server_t -l s0:c0.c10", "stream 65535" );
+    if ( defined $ncat_host ) {
+        `echo "/bin/sh $s_basedir/calipso-load $c_ipv6_1" | $ncat`;
+        $pid = remote_server_start(
+            "-t test_inet_server_t -l s0:c0.c10",
+            "stream 65535",
+            "remote CALIPSO - stream"
+        );
+    }
+    else {
+        $pid = server_start(
+            "-t test_inet_server_t -l s0:c0.c10",
+            "stream 65535",
+            "local CALIPSO - stream"
+        );
+    }
 
     # Verify that authorized client can communicate with the server.
     $result = system
-"runcon -t test_inet_client_t -l s0:c0.c10 $basedir/client -e system_u:object_r:netlabel_peer_t:s0:c0.c10 stream ::1 65535";
+"runcon -t test_inet_client_t -l s0:c0.c10 $basedir/client $r -e system_u:object_r:netlabel_peer_t:s0:c0.c10 stream $s_ipv6_ifn_1 65535";
     ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server using different valid level.
     $result = system
-"runcon -t test_inet_client_t -l s0:c8.c10 $basedir/client -e  system_u:object_r:netlabel_peer_t:s0:c8.c10 stream ::1 65535";
+"runcon -t test_inet_client_t -l s0:c8.c10 $basedir/client $r -e  system_u:object_r:netlabel_peer_t:s0:c8.c10 stream $s_ipv6_ifn_1 65535";
     ok( $result eq 0 );
 
 # Verify that authorized client cannot communicate with the server using invalid level.
     $result = system
-"runcon -t test_inet_client_t -l s0:c8.c12 -- $basedir/client stream ::1 65535 2>&1";
+"runcon -t test_inet_client_t -l s0:c8.c12 -- $basedir/client $r stream $s_ipv6_ifn_1 65535 2>&1";
     ok( $result >> 8 eq 5 );
 
-    # Kill the stream server.
-    server_end($pid);
-
+    # Kill server and flush netlabels.
+    if ( defined $ncat_host ) {
+        remote_server_end($pid);
+        `echo "/bin/sh $s_basedir/calipso-flush" | $ncat`;
+    }
+    else {
+        server_end($pid);
+    }
     system "/bin/sh $basedir/calipso-flush";
 }
 
diff --git a/tests/sctp/calipso-load b/tests/sctp/calipso-load
index 4bb9c7f..fd29640 100644
--- a/tests/sctp/calipso-load
+++ b/tests/sctp/calipso-load
@@ -4,4 +4,4 @@ netlabelctl calipso add pass doi:16
 netlabelctl map del default
 netlabelctl map add default address:0.0.0.0/0 protocol:unlbl
 netlabelctl map add default address:::/0 protocol:unlbl
-netlabelctl map add default address:::1 protocol:calipso,16
+netlabelctl map add default address:$1 protocol:calipso,16
diff --git a/tests/sctp/cipso-load-t2 b/tests/sctp/cipso-load
similarity index 58%
rename from tests/sctp/cipso-load-t2
rename to tests/sctp/cipso-load
index 3227ba5..9c43519 100644
--- a/tests/sctp/cipso-load-t2
+++ b/tests/sctp/cipso-load
@@ -1,7 +1,7 @@
 #!/bin/sh
 
-netlabelctl cipsov4 add pass doi:16 tags:2
+netlabelctl cipsov4 add pass doi:16 tags:$1
 netlabelctl map del default
 netlabelctl map add default address:0.0.0.0/0 protocol:unlbl
 netlabelctl map add default address:::/0 protocol:unlbl
-netlabelctl map add default address:127.0.0.1 protocol:cipsov4,16
+netlabelctl map add default address:$2 protocol:cipsov4,16
diff --git a/tests/sctp/cipso-load-t1 b/tests/sctp/cipso-load-t1
deleted file mode 100644
index 6e9a161..0000000
--- a/tests/sctp/cipso-load-t1
+++ /dev/null
@@ -1,7 +0,0 @@
-#!/bin/sh
-
-netlabelctl cipsov4 add pass doi:16 tags:1
-netlabelctl map del default
-netlabelctl map add default address:0.0.0.0/0 protocol:unlbl
-netlabelctl map add default address:::/0 protocol:unlbl
-netlabelctl map add default address:127.0.0.1 protocol:cipsov4,16
diff --git a/tests/sctp/cipso-load-t5 b/tests/sctp/cipso-load-t5
deleted file mode 100644
index 661afb8..0000000
--- a/tests/sctp/cipso-load-t5
+++ /dev/null
@@ -1,7 +0,0 @@
-#!/bin/sh
-
-netlabelctl cipsov4 add pass doi:16 tags:5
-netlabelctl map del default
-netlabelctl map add default address:0.0.0.0/0 protocol:unlbl
-netlabelctl map add default address:::/0 protocol:unlbl
-netlabelctl map add default address:127.0.0.1 protocol:cipsov4,16
diff --git a/tests/sctp/sctp_asconf_params_client.c b/tests/sctp/sctp_asconf_params_client.c
index 12522f3..5e01b0e 100644
--- a/tests/sctp/sctp_asconf_params_client.c
+++ b/tests/sctp/sctp_asconf_params_client.c
@@ -135,11 +135,6 @@ int main(int argc, char **argv)
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
@@ -211,6 +206,11 @@ int main(int argc, char **argv)
 		exit(1);
 	}
 
+	/*
+	 * Sleep a sec to ensure client gets info.
+	 * FIXME - rewrite all this one day to fix remote timing problems
+	 */
+	sleep(1);
 	/* Now get the new primary address from the client */
 	signal(SIGALRM, getprimaddr_alarm);
 	alarm(2);
diff --git a/tests/sctp/sctp_asconf_params_server.c b/tests/sctp/sctp_asconf_params_server.c
index ff7473b..9cf460f 100644
--- a/tests/sctp/sctp_asconf_params_server.c
+++ b/tests/sctp/sctp_asconf_params_server.c
@@ -200,7 +200,7 @@ int main(int argc, char **argv)
 		result = 1;
 		goto err1;
 	}
-	/* Sleep a sec to ensure client get info. */
+
 	result = read(new_sock, &buffer, sizeof(buffer));
 	if (result < 0) {
 		perror("read");
diff --git a/tests/sctp/start_remote_svr b/tests/sctp/start_remote_svr
new file mode 100644
index 0000000..57d2774
--- /dev/null
+++ b/tests/sctp/start_remote_svr
@@ -0,0 +1,3 @@
+#!/bin/sh
+
+$1 & disown
diff --git a/tests/sctp/stop_remote_svr b/tests/sctp/stop_remote_svr
new file mode 100644
index 0000000..2846277
--- /dev/null
+++ b/tests/sctp/stop_remote_svr
@@ -0,0 +1,3 @@
+#!/bin/sh
+
+kill $1 >/dev/null 2>&1
diff --git a/tests/sctp/test b/tests/sctp/test
index 6631da4..9d82157 100755
--- a/tests/sctp/test
+++ b/tests/sctp/test
@@ -60,8 +60,45 @@ BEGIN {
     }
 }
 
+$s_basedir = "tests/sctp";
+$ncat_host = $ENV{'NCAT_HOST'};
+$ncat_port = $ENV{'NCAT_PORT'};
+if ( defined $ncat_host and defined $ncat_port ) {
+    print "Running remote servers on IP addr: $ncat_host\n";
+
+    # Get ipv4/6 addrs
+    $c_ipv4_1 = $ENV{'C_IPV4_1'};
+    $c_ipv6_1 = $ENV{'C_IPV6_1'};
+    $c_ifname = $ENV{'C_IFNAME'};
+    $s_ipv4_1 = $ENV{'S_IPV4_1'};
+    $s_ipv6_1 = $ENV{'S_IPV6_1'};
+    $s_ipv6_2 = $ENV{'S_IPV6_2'};
+
+    # IPv6 tests require ifname for local link address
+    if ( defined $c_ifname ) {
+        $s_ipv6_ifn_1 = "$s_ipv6_1\%$c_ifname";
+    }
+    else {
+        $s_ipv6_ifn_1 = $s_ipv6_1;
+    }
+
+    $test_asconf_remote = 0;
+    if ( defined $s_ipv6_2 and $test_asconf ) {
+        $test_asconf_remote = 1;
+    }
+
+    $ncat = "ncat $ncat_host $ncat_port 2>&1";
+}
+else {
+    $c_ipv4_1     = "127.0.0.1";
+    $c_ipv6_1     = "::1";
+    $s_ipv4_1     = "127.0.0.1";
+    $s_ipv6_1     = "::1";
+    $s_ipv6_ifn_1 = "::1";
+}
+
 sub server_start {
-    my ( $runcon_args, $prog, $args ) = @_;
+    my ( $runcon_args, $prog, $args, $text ) = @_;
     my $pid;
 
     system("mkfifo $basedir/flag");
@@ -72,6 +109,7 @@ sub server_start {
 
     # Wait for it to initialize.
     system("read -t 5 <>$basedir/flag");
+    print "Started $text server\n";
     return $pid;
 }
 
@@ -83,6 +121,32 @@ sub server_end {
     system("rm -f $basedir/flag");
 }
 
+sub remote_server_start {
+    my ( $runcon_args, $prog, $args, $text ) = @_;
+    my $pid;
+
+    # Start remote server and retrieve process ID to check if ready
+
+`echo "/bin/sh $s_basedir/start_remote_svr 'runcon $runcon_args $s_basedir/$prog $args'" | $ncat`;
+
+    $pid = `(echo 'pidof $prog'; read -t 2) | $ncat`;
+    chomp($pid);
+    if ( not $pid ) {
+        print "Could not obtain remote server PID\n";
+    }
+    else {
+        print "Started $text server - PID: $pid\n";
+    }
+
+    return $pid;
+}
+
+sub remote_server_end {
+    my ($pid) = @_;
+
+    `echo "/bin/sh $s_basedir/stop_remote_svr $pid" | $ncat`;
+}
+
 #
 # NOTE: direction flow is given as Client->Server (STREAM->SEQ)
 #
@@ -93,38 +157,57 @@ sub server_end {
 print "# Testing base configuration.\n";
 
 # Start the stream server.
-$pid =
-  server_start( "-t test_sctp_server_t", "sctp_server", "$v -n stream 1035" );
+if ( defined $ncat_host ) {
+    $pid = remote_server_start(
+        "-t test_sctp_server_t",
+        "sctp_server",
+        "-n stream 1035",
+        "remote - stream"
+    );
+}
+else {
+    $pid = server_start(
+        "-t test_sctp_server_t",
+        "sctp_server",
+        "$v -n stream 1035",
+        "local - stream"
+    );
+}
 
 # Verify that authorized client can communicate with the server STREAM->STREAM with client using connect(2).
 $result = system
-"runcon -t test_sctp_client_t $basedir/sctp_client $v -e nopeer stream 127.0.0.1 1035";
+"runcon -t test_sctp_client_t $basedir/sctp_client $v -e nopeer stream $s_ipv4_1 1035";
 ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server STREAM->STREAM with client using sctp_connectx(3).
 $result = system
-"runcon -t test_sctp_client_t $basedir/sctp_client $v -x -e nopeer stream 127.0.0.1 1035";
+"runcon -t test_sctp_client_t $basedir/sctp_client $v -x -e nopeer stream $s_ipv4_1 1035";
 ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server SEQ->STREAM with no client connect(2).
 $result = system
-"runcon -t test_sctp_client_t $basedir/sctp_client $v -n -e nopeer seq 127.0.0.1 1035";
+"runcon -t test_sctp_client_t $basedir/sctp_client $v -n -e nopeer seq $s_ipv4_1 1035";
 ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server SEQ->STREAM.
 $result = system
-  "runcon -t test_sctp_client_t $basedir/sctp_client $v -e nopeer seq ::1 1035";
+"runcon -t test_sctp_client_t $basedir/sctp_client $v -e nopeer seq $s_ipv6_ifn_1 1035";
 ok( $result eq 0 );
 
 ######## This test requires setting a portcon statement in policy ###########
 # Verify that the client cannot communicate with server when using port not allowed STREAM->STREAM.
 # Note that the sctp_test policy only allows ports 1024-65535
 $result = system
-"runcon -t test_sctp_client_t -- $basedir/sctp_client $v -e nopeer stream ::1 1023 2>&1";
+"runcon -t test_sctp_client_t -- $basedir/sctp_client $v -e nopeer stream $s_ipv6_ifn_1 1023 2>&1";
 ok( $result >> 8 eq 8 );
 
 # Kill the stream server.
-server_end($pid);
+if ( defined $ncat_host ) {
+    remote_server_end($pid);
+}
+else {
+    server_end($pid);
+}
 
 ######## This test requires setting a portcon statement in policy ###########
 # Verify that the server cannot start when using port not allowed STREAM->STREAM.
@@ -164,13 +247,17 @@ ok( $result eq 0 );
 ######################### SET_PRI_ADDR SET_PEER_ADDR ########################
 #
 
-# These tests require two local non-loopback addresses.
+# These tests require two addresses.
 if ($test_asconf) {
     print "# Testing asconf parameter chunk processing.\n";
 
     # To enable processing of incoming ASCONF parameters:
     # SCTP_PARAM_SET_PRIMARY, SCTP_PARAM_ADD_IP and SCTP_PARAM_DEL_IP,
     # need to set:
+    if ( defined $ncat_host and $test_asconf_remote ) {
+        `echo "echo 1 > /proc/sys/net/sctp/addip_enable" | $ncat`;
+        `echo "echo 1 > /proc/sys/net/sctp/addip_noauth_enable" | $ncat`;
+    }
     system("echo 1 > /proc/sys/net/sctp/addip_enable");
     system("echo 1 > /proc/sys/net/sctp/addip_noauth_enable");
 
@@ -179,21 +266,46 @@ if ($test_asconf) {
 "runcon -t test_sctp_set_peer_addr_t $basedir/sctp_set_peer_addr $v $ipaddress[0] $ipaddress[1] 1035";
     ok( $result eq 0 );
 
-    # Start the asconf server.
-    $pid = server_start(
-        "-t test_sctp_set_peer_addr_t",
-        "sctp_asconf_params_server",
-        "$v $ipaddress[0] $ipaddress[1] 1035"
-    );
+    if ( defined $ncat_host and $test_asconf_remote ) {
+        $pid = remote_server_start(
+            "-t test_sctp_set_peer_addr_t",
+            "sctp_asconf_params_server",
+            "$s_ipv6_ifn_1 $s_ipv6_2 1035",
+            "remote asconf params - stream"
+        );
+    }
+    else {
+        $pid = server_start(
+            "-t test_sctp_set_peer_addr_t",
+            "sctp_asconf_params_server",
+            "$v $ipaddress[0] $ipaddress[1] 1035",
+            "local asconf params - stream"
+        );
+    }
 
-# This should fail connect permission attempting to send SCTP_PARAM_ADD_IP to client.
-    $result = system
+    print "Starting: asconf client\n";
+    if ( defined $ncat_host and $test_asconf_remote ) {
+        $result = system
+"runcon -t test_sctp_client_t -- $basedir/sctp_asconf_params_client $v $s_ipv6_ifn_1 1035 2>&1";
+    }
+    else {
+        $result = system
 "runcon -t test_sctp_client_t -- $basedir/sctp_asconf_params_client $v $ipaddress[0] 1035 2>&1";
-    ok($result);
+    }
+    ok( $result eq 0 );
 
     # The server should automatically exit.
-    server_end($pid);
+    if ( defined $ncat_host and $test_asconf_remote ) {
+        remote_server_end($pid);
+    }
+    else {
+        server_end($pid);
+    }
 
+    if ( defined $ncat_host and $test_asconf_remote ) {
+        `echo "echo 0 > /proc/sys/net/sctp/addip_enable" | $ncat`;
+        `echo "echo 0 > /proc/sys/net/sctp/addip_noauth_enable" | $ncat`;
+    }
     system("echo 0 > /proc/sys/net/sctp/addip_enable");
     system("echo 0 > /proc/sys/net/sctp/addip_noauth_enable");
 }
@@ -209,7 +321,12 @@ print "# Testing NetLabel fallback peer labeling.\n";
 system "/bin/sh $basedir/fb-label-load";
 
 # Start stream server.
-$pid = server_start( "-t test_sctp_server_t", "sctp_server", "$v stream 1035" );
+$pid = server_start(
+    "-t test_sctp_server_t",
+    "sctp_server",
+    "$v stream 1035",
+    "local fallback peer labeling - stream"
+);
 
 # Verify that authorized client can communicate with the server STREAM->STREAM.
 $result = system
@@ -230,7 +347,12 @@ ok( $result >> 8 eq 6 );
 server_end($pid);
 
 # Start seq server.
-$pid = server_start( "-t test_sctp_server_t", "sctp_server", "$v seq 1035" );
+$pid = server_start(
+    "-t test_sctp_server_t",
+    "sctp_server",
+    "$v seq 1035",
+    "local fallback peer labeling - seq"
+);
 
 # Verify that authorized client can communicate with the server SEQ->SEQ.
 $result = system
@@ -268,7 +390,12 @@ system "/bin/sh $basedir/fb-label-flush";
 print "# Testing deny association.\n";
 system "/bin/sh $basedir/fb-deny-label-load";
 
-$pid = server_start( "-t test_sctp_server_t", "sctp_server", "$v stream 1035" );
+$pid = server_start(
+    "-t test_sctp_server_t",
+    "sctp_server",
+    "$v stream 1035",
+    "local fallback peer labeling - stream"
+);
 
 # Verify that authorized client can communicate with the server STREAM->STREAM.
 # This sets the servers initial peer context to netlabel_sctp_peer_t:s0
@@ -290,323 +417,480 @@ system "/bin/sh $basedir/fb-deny-label-flush";
 ############################## CIPSO/IPv4 TAG 1 ###############################
 #
 print "# Testing CIPSO/IPv4 - TAG 1 using socket ip_option data\n";
-system "/bin/sh $basedir/cipso-load-t1";
+$tag = "1";
+system "/bin/sh $basedir/cipso-load $tag $s_ipv4_1";
 
 # Start the stream server for IPv4 only.
-$pid = server_start(
-    "-t test_sctp_server_t -l s0:c182.c192",
-    "sctp_server",
-    "$v -4 -i stream 1035"
-);
+if ( defined $ncat_host ) {
+    `echo "/bin/sh $s_basedir/cipso-load $tag $c_ipv4_1" | $ncat`;
+    $pid = remote_server_start(
+        "-t test_sctp_server_t -l s0:c182.c192",
+        "sctp_server",
+        "-4 -i stream 1035",
+        "remote TAG 1 CIPSO - stream"
+    );
+}
+else {
+    $pid = server_start(
+        "-t test_sctp_server_t -l s0:c182.c192",
+        "sctp_server",
+        "$v -4 -i stream 1035",
+        "local TAG 1 CIPSO - stream"
+    );
+}
 
 # Verify that authorized client can communicate with the server STREAM->STREAM with client using sctp_connectx(3).
 $result = system
-"runcon -t test_sctp_client_t -l s0:c182.c192 $basedir/sctp_client $v -x -i stream 127.0.0.1 1035";
+"runcon -t test_sctp_client_t -l s0:c182.c192 $basedir/sctp_client $v -x -i stream $s_ipv4_1 1035";
 ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server STREAM->STREAM with client using connect(2).
 $result = system
-"runcon -t test_sctp_client_t -l s0:c182.c192 $basedir/sctp_client $v -i stream 127.0.0.1 1035";
+"runcon -t test_sctp_client_t -l s0:c182.c192 $basedir/sctp_client $v -i stream $s_ipv4_1 1035";
 ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server using different valid level STREAM->STREAM.
 $result = system
-"runcon -t test_sctp_client_t -l s0:c182,c187,c190 $basedir/sctp_client $v -i stream 127.0.0.1 1035";
+"runcon -t test_sctp_client_t -l s0:c182,c187,c190 $basedir/sctp_client $v -i stream $s_ipv4_1 1035";
 ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server using different valid level SEQ->STREAM
 $result = system
-"runcon -t test_sctp_client_t -l s0:c189,c192 $basedir/sctp_client $v -i seq 127.0.0.1 1035";
+"runcon -t test_sctp_client_t -l s0:c189,c192 $basedir/sctp_client $v -i seq $s_ipv4_1 1035";
 ok( $result eq 0 );
 
 # Verify that authorized client cannot communicate with the server using invalid level STREAM->STREAM.
 $result = system
-"runcon -t test_sctp_client_t -l s0:c182.c193 -- $basedir/sctp_client $v stream 127.0.0.1 1035 2>&1";
+"runcon -t test_sctp_client_t -l s0:c182.c193 -- $basedir/sctp_client $v stream $s_ipv4_1 1035 2>&1";
 ok( $result >> 8 eq 6 );
 
 # Kill the stream server.
-server_end($pid);
+if ( defined $ncat_host ) {
+    remote_server_end($pid);
+}
+else {
+    server_end($pid);
+}
 
 # Start the seq server.
-$pid = server_start(
-    "-t test_sctp_server_t -l s0:c20.c300",
-    "sctp_server",
-    "$v -4 -i seq 1035"
-);
+if ( defined $ncat_host ) {
+    $pid = remote_server_start(
+        "-t test_sctp_server_t -l s0:c20.c300",
+        "sctp_server",
+        "-4 -i seq 1035",
+        "remote TAG 1 CIPSO - seq"
+    );
+}
+else {
+    $pid = server_start(
+        "-t test_sctp_server_t -l s0:c20.c300",
+        "sctp_server",
+        "$v -4 -i seq 1035",
+        "local TAG 1 CIPSO - seq"
+    );
+}
 
 # Verify that authorized client can communicate with the server. SEQ->SEQ
 $result = system
-"runcon -t test_sctp_client_t -l s0:c27.c28 $basedir/sctp_client $v -i seq 127.0.0.1 1035";
+"runcon -t test_sctp_client_t -l s0:c27.c28 $basedir/sctp_client $v -i seq $s_ipv4_1 1035";
 ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server using STREAM->SEQ.
 $result = system
-"runcon -t test_sctp_client_t -l s0:c20.c30 $basedir/sctp_client $v -i stream 127.0.0.1 1035";
+"runcon -t test_sctp_client_t -l s0:c20.c30 $basedir/sctp_client $v -i stream $s_ipv4_1 1035";
 ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server using SEQ->SEQ with diff valid level.
 $result = system
-"runcon -t test_sctp_client_t -l s0:c20.c24,c26,c27.c29 $basedir/sctp_client $v -i seq 127.0.0.1 1035";
+"runcon -t test_sctp_client_t -l s0:c20.c24,c26,c27.c29 $basedir/sctp_client $v -i seq $s_ipv4_1 1035";
 ok( $result eq 0 );
 
 # Verify that client cannot communicate with the server using SEQ->SEQ with invalid level.
 $result = system
-"runcon -t test_sctp_client_t -l s0:c19.c100 -- $basedir/sctp_client $v -i seq 127.0.0.1 1035 2>&1";
+"runcon -t test_sctp_client_t -l s0:c19.c100 -- $basedir/sctp_client $v -i seq $s_ipv4_1 1035 2>&1";
 ok( $result >> 8 eq 6 );
 
 # TAG 1 allows categories 0 to 239 to be sent, if greater then ENOSPC (No space left on device)
 $result = system
-"runcon -t test_sctp_client_t -l s0:c20.c300 -- $basedir/sctp_client $v -i seq 127.0.0.1 1035 2>&1";
+"runcon -t test_sctp_client_t -l s0:c20.c300 -- $basedir/sctp_client $v -i seq $s_ipv4_1 1035 2>&1";
 ok( $result >> 8 eq 7 );
 
 # Kill server.
-server_end($pid);
+if ( defined $ncat_host ) {
+    remote_server_end($pid);
+}
+else {
+    server_end($pid);
+}
 
 print "# Testing CIPSO/IPv4 - TAG 1 PEELOFF using socket ip_option data\n";
 
 # Test sctp_peeloff(3) using 1 to Many SOCK_SEQPACKET
-$pid = server_start(
-    "-t test_sctp_server_t -l s0:c0.c10",
-    "sctp_peeloff_server",
-    "$v -4 -i 1035"
-);
+if ( defined $ncat_host ) {
+    $pid = remote_server_start(
+        "-t test_sctp_server_t -l s0:c0.c10",
+        "sctp_peeloff_server",
+        "-4 -i 1035",
+        "remote TAG 1 CIPSO - peeloff"
+    );
+}
+else {
+    $pid = server_start(
+        "-t test_sctp_server_t -l s0:c0.c10",
+        "sctp_peeloff_server",
+        "$v -4 -i 1035",
+        "local TAG 1 CIPSO - peeloff"
+    );
+}
 
 # Verify that authorized client can communicate with the server using SEQ->SEQ->Peeloff with same level.
 $result = system
-"runcon -t test_sctp_client_t -l s0:c0.c10 $basedir/sctp_client $v -i seq 127.0.0.1 1035";
+"runcon -t test_sctp_client_t -l s0:c0.c10 $basedir/sctp_client $v -i seq $s_ipv4_1 1035";
 ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server using STREAM->SEQ->peeloff with same level.
 $result = system
-"runcon -t test_sctp_client_t -l s0:c0.c10 $basedir/sctp_client $v -x -i stream 127.0.0.1 1035";
+"runcon -t test_sctp_client_t -l s0:c0.c10 $basedir/sctp_client $v -x -i stream $s_ipv4_1 1035";
 ok( $result eq 0 );
 
 # Verify that client cannot communicate with the server using STREAM->SEQ->peeloff with invalid level.
 $result = system
-"runcon -t test_sctp_client_t -l s0:c0.c11 -- $basedir/sctp_client $v -x -i stream 127.0.0.1 1035 2>&1";
+"runcon -t test_sctp_client_t -l s0:c0.c11 -- $basedir/sctp_client $v -x -i stream $s_ipv4_1 1035 2>&1";
 ok( $result >> 8 eq 6 );
 
-# Kill the seq server.
+# Kill the peeloff server.
 server_end($pid);
-
+if ( defined $ncat_host ) {
+    remote_server_end($pid);
+    `echo "/bin/sh $s_basedir/cipso-flush" | $ncat`;
+}
+else {
+    server_end($pid);
+}
 system "/bin/sh $basedir/cipso-flush";
 
 #
 ############################## CIPSO/IPv4 TAG 2 ###############################
 #
 print "# Testing CIPSO/IPv4 - TAG 2 using socket ip_option data\n";
-system "/bin/sh $basedir/cipso-load-t2";
+$tag = "2";
+system "/bin/sh $basedir/cipso-load $tag $s_ipv4_1";
 
 # Start the stream server for IPv4 only.
-$pid = server_start(
-    "-t test_sctp_server_t -l s0:c782,c714,c769,c788,c803,c842,c864",
-    "sctp_server", "$v -4 -i stream 1035" );
+if ( defined $ncat_host ) {
+    `echo "/bin/sh $s_basedir/cipso-load $tag $c_ipv4_1" | $ncat`;
+    $pid = remote_server_start(
+        "-t test_sctp_server_t -l s0:c782,c714,c769,c788,c803,c842,c864",
+        "sctp_server",
+        "-4 -i stream 1035",
+        "remote TAG 2 CIPSO - stream"
+    );
+}
+else {
+    $pid = server_start(
+        "-t test_sctp_server_t -l s0:c782,c714,c769,c788,c803,c842,c864",
+        "sctp_server",
+        "$v -4 -i stream 1035",
+        "local TAG 2 CIPSO - stream"
+    );
+}
 
 # Verify that authorized client can communicate with the server STREAM->STREAM with client using sctp_connectx(3).
 $result = system
-"runcon -t test_sctp_client_t -l s0:c782,c714,c769,c788,c803,c842,c864 $basedir/sctp_client $v -x -i stream 127.0.0.1 1035";
+"runcon -t test_sctp_client_t -l s0:c782,c714,c769,c788,c803,c842,c864 $basedir/sctp_client $v -x -i stream $s_ipv4_1 1035";
 ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server STREAM->STREAM with client using connect(2).
 $result = system
-"runcon -t test_sctp_client_t -l s0:c782,c714,c769,c788,c803,c842,c864 $basedir/sctp_client $v -i stream 127.0.0.1 1035";
+"runcon -t test_sctp_client_t -l s0:c782,c714,c769,c788,c803,c842,c864 $basedir/sctp_client $v -i stream $s_ipv4_1 1035";
 ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server using different valid level STREAM->STREAM.
 $result = system
-"runcon -t test_sctp_client_t -l s0:c769,c788,c803,c842,c864 $basedir/sctp_client $v -i stream 127.0.0.1 1035";
+"runcon -t test_sctp_client_t -l s0:c769,c788,c803,c842,c864 $basedir/sctp_client $v -i stream $s_ipv4_1 1035";
 ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server using different valid level SEQ->STREAM
 $result = system
-"runcon -t test_sctp_client_t -l s0:c769,c788,c803 $basedir/sctp_client $v -i seq 127.0.0.1 1035";
+"runcon -t test_sctp_client_t -l s0:c769,c788,c803 $basedir/sctp_client $v -i seq $s_ipv4_1 1035";
 ok( $result eq 0 );
 
 # Verify that authorized client cannot communicate with the server using invalid level STREAM->STREAM.
 $result = system
-"runcon -t test_sctp_client_t -l s0:c1023 -- $basedir/sctp_client $v stream 127.0.0.1 1035 2>&1";
+"runcon -t test_sctp_client_t -l s0:c1023 -- $basedir/sctp_client $v stream $s_ipv4_1 1035 2>&1";
 ok( $result >> 8 eq 6 );
 
-# Kill the stream server.
-server_end($pid);
+if ( defined $ncat_host ) {
+    remote_server_end($pid);
+}
+else {
+    server_end($pid);
+}
 
 # Start the seq server.
-$pid = server_start(
-    "-t test_sctp_server_t -l s0:c20.c335",
-    "sctp_server",
-    "$v -4 -i seq 1035"
-);
+if ( defined $ncat_host ) {
+    $pid = remote_server_start(
+        "-t test_sctp_server_t -l s0:c20.c335",
+        "sctp_server",
+        "-4 -i seq 1035",
+        "remote TAG 2 CIPSO - seq"
+    );
+}
+else {
+    $pid = server_start(
+        "-t test_sctp_server_t -l s0:c20.c335",
+        "sctp_server",
+        "$v -4 -i seq 1035",
+        "local TAG 2 CIPSO - seq"
+    );
+}
 
 # Verify that authorized client can communicate with the server. SEQ->SEQ
 $result = system
-"runcon -t test_sctp_client_t -l s0:c328.c333 $basedir/sctp_client $v -i seq 127.0.0.1 1035";
+"runcon -t test_sctp_client_t -l s0:c328.c333 $basedir/sctp_client $v -i seq $s_ipv4_1 1035";
 ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server using STREAM->SEQ.
 $result = system
-"runcon -t test_sctp_client_t -l s0:c20.c34 $basedir/sctp_client $v -i stream 127.0.0.1 1035";
+"runcon -t test_sctp_client_t -l s0:c20.c34 $basedir/sctp_client $v -i stream $s_ipv4_1 1035";
 ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server using SEQ->SEQ with diff valid level.
 $result = system
-"runcon -t test_sctp_client_t -l s0:c20.c30,c31,c335 $basedir/sctp_client $v -i seq 127.0.0.1 1035";
+"runcon -t test_sctp_client_t -l s0:c20.c30,c31,c335 $basedir/sctp_client $v -i seq $s_ipv4_1 1035";
 ok( $result eq 0 );
 
 # Verify that client cannot communicate with the server using SEQ->SEQ with invalid level.
 $result = system
-"runcon -t test_sctp_client_t -l s0:c19.c30 -- $basedir/sctp_client $v -i seq 127.0.0.1 1035 2>&1";
+"runcon -t test_sctp_client_t -l s0:c19.c30 -- $basedir/sctp_client $v -i seq $s_ipv4_1 1035 2>&1";
 ok( $result >> 8 eq 6 );
 
 # TAG 2 allows a maximum of 15 categories in exchange, if greater then ENOSPC (No space left on device)
 $result = system
-"runcon -t test_sctp_client_t -l s0:c200.c216 -- $basedir/sctp_client $v -i seq 127.0.0.1 1035 2>&1";
+"runcon -t test_sctp_client_t -l s0:c200.c216 -- $basedir/sctp_client $v -i seq $s_ipv4_1 1035 2>&1";
 ok( $result >> 8 eq 7 );
 
 # Kill server.
-server_end($pid);
+if ( defined $ncat_host ) {
+    remote_server_end($pid);
+}
+else {
+    server_end($pid);
+}
 
 print "# Testing CIPSO/IPv4 - TAG 2 PEELOFF using socket ip_option data\n";
 
 # Test sctp_peeloff(3) using 1 to Many SOCK_SEQPACKET
-$pid = server_start(
-    "-t test_sctp_server_t -l s0:c0.c10",
-    "sctp_peeloff_server",
-    "$v -4 -i 1035"
-);
+if ( defined $ncat_host ) {
+    $pid = remote_server_start(
+        "-t test_sctp_server_t -l s0:c0.c10",
+        "sctp_peeloff_server",
+        "-4 -i 1035",
+        "remote TAG 2 CIPSO - peeloff"
+    );
+}
+else {
+    $pid = server_start(
+        "-t test_sctp_server_t -l s0:c0.c10",
+        "sctp_peeloff_server",
+        "$v -4 -i 1035",
+        "local TAG 2 CIPSO - peeloff"
+    );
+}
 
 # Verify that authorized client can communicate with the server using SEQ->SEQ->Peeloff with same level.
 $result = system
-"runcon -t test_sctp_client_t -l s0:c0.c10 $basedir/sctp_client $v -i seq 127.0.0.1 1035";
+"runcon -t test_sctp_client_t -l s0:c0.c10 $basedir/sctp_client $v -i seq $s_ipv4_1 1035";
 ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server using STREAM->SEQ->peeloff with same level.
 $result = system
-"runcon -t test_sctp_client_t -l s0:c0.c10 $basedir/sctp_client $v -x -i stream 127.0.0.1 1035";
+"runcon -t test_sctp_client_t -l s0:c0.c10 $basedir/sctp_client $v -x -i stream $s_ipv4_1 1035";
 ok( $result eq 0 );
 
 # Verify that client cannot communicate with the server using STREAM->SEQ->peeloff with invalid level.
 $result = system
-"runcon -t test_sctp_client_t -l s0:c0.c11 -- $basedir/sctp_client $v -x -i stream 127.0.0.1 1035 2>&1";
+"runcon -t test_sctp_client_t -l s0:c0.c11 -- $basedir/sctp_client $v -x -i stream $s_ipv4_1 1035 2>&1";
 ok( $result >> 8 eq 6 );
 
 # Kill the seq server.
-server_end($pid);
-
+if ( defined $ncat_host ) {
+    remote_server_end($pid);
+    `echo "/bin/sh $s_basedir/cipso-flush" | $ncat`;
+}
+else {
+    server_end($pid);
+}
 system "/bin/sh $basedir/cipso-flush";
 
 #
 ############################## CIPSO/IPv4 TAG 5 ###############################
 #
 print "# Testing CIPSO/IPv4 - TAG 5 using socket ip_option data\n";
-system "/bin/sh $basedir/cipso-load-t5";
+$tag = "5";
+system "/bin/sh $basedir/cipso-load $tag $s_ipv4_1";
 
 # Start the stream server for IPv4 only.
-$pid = server_start(
-    "-t test_sctp_server_t -l s0:c782,c714,c769,c788,c803,c842,c864",
-    "sctp_server", "$v -4 -i stream 1035" );
+if ( defined $ncat_host ) {
+    `echo "/bin/sh $s_basedir/cipso-load $tag $c_ipv4_1" | $ncat`;
+    $pid = remote_server_start(
+        "-t test_sctp_server_t -l s0:c782,c714,c769,c788,c803,c842,c864",
+        "sctp_server",
+        "-4 -i stream 1035",
+        "remote TAG 5 CIPSO - stream"
+    );
+}
+else {
+    $pid = server_start(
+        "-t test_sctp_server_t -l s0:c782,c714,c769,c788,c803,c842,c864",
+        "sctp_server",
+        "$v -4 -i stream 1035",
+        "local TAG 5 CIPSO - stream"
+    );
+}
 
 # Verify that authorized client can communicate with the server STREAM->STREAM with client using sctp_connectx(3).
 $result = system
-"runcon -t test_sctp_client_t -l s0:c782,c714,c769,c788,c803,c842,c864 $basedir/sctp_client $v -x -i stream 127.0.0.1 1035";
+"runcon -t test_sctp_client_t -l s0:c782,c714,c769,c788,c803,c842,c864 $basedir/sctp_client $v -x -i stream $s_ipv4_1 1035";
 ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server STREAM->STREAM with client using connect(2).
 $result = system
-"runcon -t test_sctp_client_t -l s0:c782,c714,c769,c788,c803,c842,c864 $basedir/sctp_client $v -i stream 127.0.0.1 1035";
+"runcon -t test_sctp_client_t -l s0:c782,c714,c769,c788,c803,c842,c864 $basedir/sctp_client $v -i stream $s_ipv4_1 1035";
 ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server using different valid level STREAM->STREAM.
 $result = system
-"runcon -t test_sctp_client_t -l s0:c769,c788,c803,c842,c864 $basedir/sctp_client $v -i stream 127.0.0.1 1035";
+"runcon -t test_sctp_client_t -l s0:c769,c788,c803,c842,c864 $basedir/sctp_client $v -i stream $s_ipv4_1 1035";
 ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server using different valid level SEQ->STREAM
 $result = system
-"runcon -t test_sctp_client_t -l s0:c769,c788,c803 $basedir/sctp_client $v -i seq 127.0.0.1 1035";
+"runcon -t test_sctp_client_t -l s0:c769,c788,c803 $basedir/sctp_client $v -i seq $s_ipv4_1 1035";
 ok( $result eq 0 );
 
 # Verify that authorized client cannot communicate with the server using invalid level STREAM->STREAM.
 $result = system
-"runcon -t test_sctp_client_t -l s0:c1023 -- $basedir/sctp_client $v stream 127.0.0.1 1035 2>&1";
+"runcon -t test_sctp_client_t -l s0:c1023 -- $basedir/sctp_client $v stream $s_ipv4_1 1035 2>&1";
 ok( $result >> 8 eq 6 );
 
 # Kill the stream server.
-server_end($pid);
+if ( defined $ncat_host ) {
+    remote_server_end($pid);
+}
+else {
+    server_end($pid);
+}
 
 # Start the seq server.
-$pid = server_start(
-    "-t test_sctp_server_t -l s0:c20.c50",
-    "sctp_server",
-    "$v -4 -i seq 1035"
-);
+if ( defined $ncat_host ) {
+    $pid = remote_server_start(
+        "-t test_sctp_server_t -l s0:c20.c50",
+        "sctp_server",
+        "-4 -i seq 1035",
+        "remote TAG 5 CIPSO - seq"
+    );
+}
+else {
+    $pid = server_start(
+        "-t test_sctp_server_t -l s0:c20.c50",
+        "sctp_server",
+        "$v -4 -i seq 1035",
+        "local TAG 5 CIPSO - seq"
+    );
+}
 
 # Verify that authorized client can communicate with the server. SEQ->SEQ
 $result = system
-"runcon -t test_sctp_client_t -l s0:c28.c48 $basedir/sctp_client $v -i seq 127.0.0.1 1035";
+"runcon -t test_sctp_client_t -l s0:c28.c48 $basedir/sctp_client $v -i seq $s_ipv4_1 1035";
 ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server using STREAM->SEQ.
 $result = system
-"runcon -t test_sctp_client_t -l s0:c20.c50 $basedir/sctp_client $v -i stream 127.0.0.1 1035";
+"runcon -t test_sctp_client_t -l s0:c20.c50 $basedir/sctp_client $v -i stream $s_ipv4_1 1035";
 ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server using SEQ->SEQ with diff valid level.
 $result = system
-"runcon -t test_sctp_client_t -l s0:c20.c30,c31,c35,c40.c45 $basedir/sctp_client $v -i seq 127.0.0.1 1035";
+"runcon -t test_sctp_client_t -l s0:c20.c30,c31,c35,c40.c45 $basedir/sctp_client $v -i seq $s_ipv4_1 1035";
 ok( $result eq 0 );
 
 # Verify that client cannot communicate with the server using SEQ->SEQ with invalid level.
 $result = system
-"runcon -t test_sctp_client_t -l s0:c20.c51 -- $basedir/sctp_client $v -i seq 127.0.0.1 1035 2>&1";
+"runcon -t test_sctp_client_t -l s0:c20.c51 -- $basedir/sctp_client $v -i seq $s_ipv4_1 1035 2>&1";
 ok( $result >> 8 eq 6 );
 
-# TAG 2 allows a maximum of 7 ranges in exchange, if greater then ENOSPC (No space left on device)
+# TAG 5 allows a maximum of 7 ranges in exchange, if greater then ENOSPC (No space left on device)
 $result = system
-"runcon -t test_sctp_client_t -l s0:c20,c22,c24,c30.c33,c38,c42.c45,c48,c50 -- $basedir/sctp_client $v -i seq 127.0.0.1 1035 2>&1";
+"runcon -t test_sctp_client_t -l s0:c20,c22,c24,c30.c33,c38,c42.c45,c48,c50 -- $basedir/sctp_client $v -i seq $s_ipv4_1 1035 2>&1";
 ok( $result >> 8 eq 7 );
 
 # Kill server.
-server_end($pid);
+if ( defined $ncat_host ) {
+    remote_server_end($pid);
+}
+else {
+    server_end($pid);
+}
 
 print "# Testing CIPSO/IPv4 - TAG 5 PEELOFF using socket ip_option data\n";
 
 # Test sctp_peeloff(3) using 1 to Many SOCK_SEQPACKET
-$pid = server_start(
-    "-t test_sctp_server_t -l s0:c0.c10",
-    "sctp_peeloff_server",
-    "$v -4 -i 1035"
-);
+if ( defined $ncat_host ) {
+    $pid = remote_server_start(
+        "-t test_sctp_server_t -l s0:c0.c10",
+        "sctp_peeloff_server",
+        "-4 -i 1035",
+        "remote TAG 5 CIPSO - peeloff"
+    );
+}
+else {
+    $pid = server_start(
+        "-t test_sctp_server_t -l s0:c0.c10",
+        "sctp_peeloff_server",
+        "$v -4 -i 1035",
+        "local TAG 5 CIPSO - peeloff"
+    );
+}
 
 # Verify that authorized client can communicate with the server using SEQ->SEQ->Peeloff with same level.
 $result = system
-"runcon -t test_sctp_client_t -l s0:c0.c10 $basedir/sctp_client $v -i seq 127.0.0.1 1035";
+"runcon -t test_sctp_client_t -l s0:c0.c10 $basedir/sctp_client $v -i seq $s_ipv4_1 1035";
 ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server using STREAM->SEQ->peeloff with same level.
 $result = system
-"runcon -t test_sctp_client_t -l s0:c0.c10 $basedir/sctp_client $v -x -i stream 127.0.0.1 1035";
+"runcon -t test_sctp_client_t -l s0:c0.c10 $basedir/sctp_client $v -x -i stream $s_ipv4_1 1035";
 ok( $result eq 0 );
 
 # Verify that client cannot communicate with the server using STREAM->SEQ->peeloff with invalid level.
 $result = system
-"runcon -t test_sctp_client_t -l s0:c0.c11 -- $basedir/sctp_client $v -x -i stream 127.0.0.1 1035 2>&1";
+"runcon -t test_sctp_client_t -l s0:c0.c11 -- $basedir/sctp_client $v -x -i stream $s_ipv4_1 1035 2>&1";
 ok( $result >> 8 eq 6 );
 
 # Kill the seq server.
-server_end($pid);
-
+if ( defined $ncat_host ) {
+    remote_server_end($pid);
+    `echo "/bin/sh $s_basedir/cipso-flush" | $ncat`;
+}
+else {
+    server_end($pid);
+}
 system "/bin/sh $basedir/cipso-flush";
 
 #
 ################## CIPSO/IPv4 Full Labeling over Loopback ####################
 #
-
 print "# Testing CIPSO/IPv4 full labeling over loopback.\n";
 system "/bin/sh $basedir/cipso-fl-load";
 
 # Start the stream server for IPv4 only.
-$pid =
-  server_start( "-t test_sctp_server_t", "sctp_server", "$v -4 stream 1035" );
+$pid = server_start(
+    "-t test_sctp_server_t",
+    "sctp_server",
+    "$v -4 stream 1035",
+    "local full CIPSO labeling - stream"
+);
 
 # Verify that authorized client can communicate with the server STREAM->STREAM.
 $result = system
@@ -622,7 +906,12 @@ ok( $result >> 8 eq 6 );
 server_end($pid);
 
 # Start the seq server for IPv4 only.
-$pid = server_start( "-t test_sctp_server_t", "sctp_server", "$v -4 seq 1035" );
+$pid = server_start(
+    "-t test_sctp_server_t",
+    "sctp_server",
+    "$v -4 seq 1035",
+    "local full CIPSO labeling - seq"
+);
 
 # Verify that authorized client can communicate with the server SEQ->STREAM.
 $result =
@@ -646,117 +935,170 @@ system "/bin/sh $basedir/cipso-fl-flush";
 
 if ($test_calipso) {
     print "# Testing CALIPSO/IPv6 using socket ip_option data\n";
-    system "/bin/sh $basedir/calipso-load";
+    system "/bin/sh $basedir/calipso-load $s_ipv6_1";
 
     # Start the stream server.
-    $pid = server_start(
-"-t test_sctp_server_t -l  s0:c0,c12,c24,c36,c28,c610,c712,c414,c516,c318,c820,c622,c924,c726,c128,c330,c832,c534,c936,c138,c740,c42,c44,c246,c648,c950,c152,c354,c856,c158,c960,c662,c634,c686,c368,c570,c782,c714,c769,c788,c803,c842,c864,c986,c788,c290,c392,c594,c896,c698,c1023",
-        "sctp_server",
-        "$v -i stream 1035"
-    );
+    if ( defined $ncat_host ) {
+        `echo "/bin/sh $s_basedir/calipso-load $c_ipv6_1" | $ncat`;
+        $pid = remote_server_start(
+"-t test_sctp_server_t -l s0:c0,c12,c24,c36,c28,c610,c712,c414,c516,c318,c820,c622,c924,c726,c128,c330,c832,c534,c936,c138,c740,c42,c44,c246,c648,c950,c152,c354,c856,c158,c960,c662,c634,c686,c368,c570,c782,c714,c769,c788,c803,c842,c864,c986,c788,c290,c392,c594,c896,c698,c1023",
+            "sctp_server",
+            "-i stream 1035",
+            "remote CALIPSO - stream"
+        );
+    }
+    else {
+        $pid = server_start(
+"-t test_sctp_server_t -l s0:c0,c12,c24,c36,c28,c610,c712,c414,c516,c318,c820,c622,c924,c726,c128,c330,c832,c534,c936,c138,c740,c42,c44,c246,c648,c950,c152,c354,c856,c158,c960,c662,c634,c686,c368,c570,c782,c714,c769,c788,c803,c842,c864,c986,c788,c290,c392,c594,c896,c698,c1023",
+            "sctp_server",
+            "$v -i stream 1035",
+            "local CALIPSO - stream"
+        );
+    }
 
 # Verify that authorized client can communicate with the server STREAM->STREAM with client using sctp_connectx(3).
     $result = system
-"runcon -t test_sctp_client_t -l s0:c0,c12,c24,c36,c28,c610,c712,c414,c516,c318,c820,c622,c924,c726,c128,c330,c832,c534,c936,c138,c740,c42,c44,c246,c648,c950,c152,c354,c856,c158,c960,c662,c634,c686,c368,c570,c782,c714,c769,c788,c803,c842,c864,c986,c788,c290,c392,c594,c896,c698,c1023  $basedir/sctp_client $v -x -i stream ::1 1035";
+"runcon -t test_sctp_client_t -l s0:c0,c12,c24,c36,c28,c610,c712,c414,c516,c318,c820,c622,c924,c726,c128,c330,c832,c534,c936,c138,c740,c42,c44,c246,c648,c950,c152,c354,c856,c158,c960,c662,c634,c686,c368,c570,c782,c714,c769,c788,c803,c842,c864,c986,c788,c290,c392,c594,c896,c698,c1023  $basedir/sctp_client $v -x -i stream $s_ipv6_ifn_1 1035";
     ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server STREAM->STREAM with client using connect(2).
     $result = system
-"runcon -t test_sctp_client_t -l s0:c0,c12,c24,c36,c28,c610,c712,c414,c516,c318,c820,c622,c924,c726,c128,c330,c832,c534,c936,c138,c740,c42,c44,c246,c648,c950,c152,c354,c856,c158,c960,c662,c634,c686,c368,c570,c782,c714,c769,c788,c803,c842,c864,c986,c788,c290,c392,c594,c896,c698,c1023  $basedir/sctp_client $v -i stream ::1 1035";
+"runcon -t test_sctp_client_t -l s0:c0,c12,c24,c36,c28,c610,c712,c414,c516,c318,c820,c622,c924,c726,c128,c330,c832,c534,c936,c138,c740,c42,c44,c246,c648,c950,c152,c354,c856,c158,c960,c662,c634,c686,c368,c570,c782,c714,c769,c788,c803,c842,c864,c986,c788,c290,c392,c594,c896,c698,c1023  $basedir/sctp_client $v -i stream $s_ipv6_ifn_1 1035";
     ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server using different valid level STREAM->STREAM.
     $result = system
-"runcon -t test_sctp_client_t -l s0:c924,c726,c128,c330,c832,c534,c936,c138,c740,c42 $basedir/sctp_client $v -i stream ::1 1035";
+"runcon -t test_sctp_client_t -l s0:c924,c726,c128,c330,c832,c534,c936,c138,c740,c42 $basedir/sctp_client $v -i stream $s_ipv6_ifn_1 1035";
     ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server using different valid level SEQ->STREAM
     $result = system
-"runcon -t test_sctp_client_t -l s0:c924,c726,c128,c330,c832,c534,c936,c138,c740,c42 $basedir/sctp_client $v -i seq ::1 1035";
+"runcon -t test_sctp_client_t -l s0:c924,c726,c128,c330,c832,c534,c936,c138,c740,c42 $basedir/sctp_client $v -i seq $s_ipv6_ifn_1 1035";
     ok( $result eq 0 );
 
 # Verify that authorized client cannot communicate with the server using invalid level STREAM->STREAM.
     $result = system
-"runcon -t test_sctp_client_t -l s0:c8.c12 -- $basedir/sctp_client $v -i stream ::1 1035 2>&1";
+"runcon -t test_sctp_client_t -l s0:c8.c12 -- $basedir/sctp_client $v -i stream $s_ipv6_ifn_1 1035 2>&1";
     ok( $result >> 8 eq 6 );
 
     # Kill the stream server.
-    server_end($pid);
+    if ( defined $ncat_host ) {
+        remote_server_end($pid);
+    }
+    else {
+        server_end($pid);
+    }
 
     # Start the seq server.
-    $pid = server_start(
-        "-t test_sctp_server_t -l s0:c20.c50",
-        "sctp_server",
-        "$v -i seq 1035"
-    );
+    if ( defined $ncat_host ) {
+        $pid = remote_server_start(
+            "-t test_sctp_server_t -l s0:c20.c50",
+            "sctp_server",
+            "-i seq 1035",
+            "remote CALIPSO - seq"
+        );
+    }
+    else {
+        $pid = server_start(
+            "-t test_sctp_server_t -l s0:c20.c50",
+            "sctp_server",
+            "$v -i seq 1035",
+            "local CALIPSO - seq"
+        );
+    }
 
     # Verify that authorized client can communicate with the server. SEQ->SEQ
     $result = system
-"runcon -t test_sctp_client_t -l s0:c28.c48 $basedir/sctp_client $v -i seq ::1 1035";
+"runcon -t test_sctp_client_t -l s0:c28.c48 $basedir/sctp_client $v -i seq $s_ipv6_ifn_1 1035";
     ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server using STREAM->SEQ.
     $result = system
-"runcon -t test_sctp_client_t -l s0:c20.c50 $basedir/sctp_client $v -i stream ::1 1035";
+"runcon -t test_sctp_client_t -l s0:c20.c50 $basedir/sctp_client $v -i stream $s_ipv6_ifn_1 1035";
     ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server using SEQ->SEQ with diff valid level.
     $result = system
-"runcon -t test_sctp_client_t -l s0:c20.c30,c31,c35,c40.c45 $basedir/sctp_client $v -i seq ::1 1035";
+"runcon -t test_sctp_client_t -l s0:c20.c30,c31,c35,c40.c45 $basedir/sctp_client $v -i seq $s_ipv6_ifn_1 1035";
     ok( $result eq 0 );
 
 # Verify that client cannot communicate with the server using SEQ->SEQ with invalid level.
     $result = system
-"runcon -t test_sctp_client_t -l s0:c20.c51 $basedir/sctp_client $v -i seq ::1 1035 2>&1";
+"runcon -t test_sctp_client_t -l s0:c20.c51 $basedir/sctp_client $v -i seq $s_ipv6_ifn_1 1035 2>&1";
     ok( $result >> 8 eq 6 );
 
 # Verify that client cannot communicate with the server using SEQ->SEQ with invalid level.
     $result = system
-"runcon -t test_sctp_client_t -l s0:c19.c50 -- $basedir/sctp_client $v -i seq ::1 1035 2>&1";
+"runcon -t test_sctp_client_t -l s0:c19.c50 -- $basedir/sctp_client $v -i seq $s_ipv6_ifn_1 1035 2>&1";
     ok( $result >> 8 eq 6 );
 
     # Kill server.
-    server_end($pid);
+    if ( defined $ncat_host ) {
+        remote_server_end($pid);
+    }
+    else {
+        server_end($pid);
+    }
 
     print "# Testing CALIPSO/IPv6 PEELOFF using socket ip_option data\n";
 
     # Test sctp_peeloff(3) using 1 to Many SOCK_SEQPACKET
-    $pid = server_start(
-        "-t test_sctp_server_t -l s0:c0.c10",
-        "sctp_peeloff_server",
-        "$v -i 1035"
-    );
+    if ( defined $ncat_host ) {
+        $pid = remote_server_start(
+            "-t test_sctp_server_t -l s0:c0.c10",
+            "sctp_peeloff_server",
+            "-i 1035",
+            "remote CALIPSO - peeloff"
+        );
+    }
+    else {
+        $pid = server_start(
+            "-t test_sctp_server_t -l s0:c0.c10",
+            "sctp_peeloff_server",
+            "$v -i 1035",
+            "local CALIPSO - peeloff"
+        );
+    }
 
 # Verify that authorized client can communicate with the server using SEQ->SEQ->Peeloff with same level.
     $result = system
-"runcon -t test_sctp_client_t -l s0:c0.c10 $basedir/sctp_client $v -i seq ::1 1035";
+"runcon -t test_sctp_client_t -l s0:c0.c10 $basedir/sctp_client $v -i seq $s_ipv6_ifn_1 1035";
     ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server using STREAM->SEQ->peeloff with same level.
     $result = system
-"runcon -t test_sctp_client_t -l s0:c0.c10 $basedir/sctp_client $v -x -i stream ::1 1035";
+"runcon -t test_sctp_client_t -l s0:c0.c10 $basedir/sctp_client $v -x -i stream $s_ipv6_ifn_1 1035";
     ok( $result eq 0 );
 
 # Verify that client cannot communicate with the server using STREAM->SEQ->peeloff with invalid level.
     $result = system
-"runcon -t test_sctp_client_t -l s0:c0.c11 -- $basedir/sctp_client $v -x -i stream ::1 1035 2>&1";
+"runcon -t test_sctp_client_t -l s0:c0.c11 -- $basedir/sctp_client $v -x -i stream $s_ipv6_ifn_1 1035 2>&1";
     ok( $result >> 8 eq 6 );
 
-    # Kill the seq server.
-    server_end($pid);
-
+    # Kill the peeloff server.
+    if ( defined $ncat_host ) {
+        remote_server_end($pid);
+        `echo "/bin/sh $s_basedir/calipso-flush" | $ncat`;
+    }
+    else {
+        server_end($pid);
+    }
     system "/bin/sh $basedir/calipso-flush";
 }
 
 #
-##################### Test iptables configuration ############################
+############## Test iptables configuration (Local only) #####################
 #
 print "# Testing iptables (IPv4/IPv6).\n";
 system "/bin/sh $basedir/iptables-load";
 
 # Start the stream server.
-$pid =
-  server_start( "-t test_sctp_server_t", "sctp_server", "$v -n stream 1035" );
+$pid = server_start(
+    "-t test_sctp_server_t",
+    "sctp_server",
+    "$v -n stream 1035",
+    "local iptables - stream"
+);
 
 # Verify that authorized client can communicate with the server STREAM->STREAM.
 $result = system
@@ -782,7 +1124,12 @@ ok( $result >> 8 eq 6 );
 server_end($pid);
 
 # Start the seq server.
-$pid = server_start( "-t test_sctp_server_t", "sctp_server", "$v -n seq 1035" );
+$pid = server_start(
+    "-t test_sctp_server_t",
+    "sctp_server",
+    "$v -n seq 1035",
+    "local iptables - seq"
+);
 
 # Verify that authorized client can communicate with the server SEQ->SEQ.
 $result = system
diff --git a/tools/remote.cfg b/tools/remote.cfg
new file mode 100644
index 0000000..7e57ae6
--- /dev/null
+++ b/tools/remote.cfg
@@ -0,0 +1,27 @@
+# Client -> Server address. Do not use the same ncat_host address for any
+# test server traffic as IPSEC, CIPSO & CALIPSO will cause protocol errors.
+ncat_host=193.168.1.65
+ncat_port=9999
+
+###########################################################################
+# NOTE: The c_ipv6_1 and s_ipv6_1 MUST be full IPv6 addresses. Using local
+# link addresses work for some tests, however IPSEC & CALIPSO fail for some
+# as yet unknown reason.
+###########################################################################
+
+# Client side MUST have one of each IPv4 and IPv6 addresses
+c_ipv4_1=192.168.1.198
+c_ipv6_1=2a00:23c6:278e:c901:3bf7:29c9:2139:91d0
+# The ifname is ONLY required for Client side if the Server side s_ipv6_1 is
+# an IPv6 local link address, as the client will use 's_ipv6_1%c_ifname' for
+# the server address (however see above note).
+c_ifname=
+
+# Server side MUST have one of each IPv4 and IPv6 addresses.
+# If testing SCTP for add/remove bindx addresses and inform the client
+# side via ASCONF chunks test, then an additional IPv6 address is required.
+# If it is a local link address, it MUST have the server side ifname
+# associated to it.
+s_ipv4_1=192.168.1.148
+s_ipv6_1=2a00:23c6:278e:c901:ff65:b87b:a84d:29a8
+s_ipv6_2=fe80::7f74:f41a:3c70:d333%enp9s0
diff --git a/tools/remote.sh b/tools/remote.sh
new file mode 100755
index 0000000..2849ced
--- /dev/null
+++ b/tools/remote.sh
@@ -0,0 +1,92 @@
+#!/bin/sh -e
+
+RUN=$1
+V=$2
+
+if [ "$(tests/kvercmp $(uname -r) 4.20.17)" -lt 0 ]; then
+    echo "Kernel must be 4.20.17 or greater to run SCTP tests"
+    exit 1
+fi
+
+STATUS=`getenforce`
+if [ "$STATUS" != "Enforcing" ]; then
+    echo "This script must be run in enforcing mode"
+    exit 1
+fi
+
+source ./tools/remote.cfg
+
+function err_exit() {
+    echo "Error on line: $1 - exiting"
+    exit 1
+}
+
+trap 'err_exit $LINENO' ERR
+
+function run_test() {
+    trap 'err_exit $LINENO' ERR
+    make -C tests/$1
+    cd tests/$1
+    if [ "$2" ]; then
+        ./test $2
+    else
+        ./test
+    fi
+    cd ../../
+    echo "Remote test for $1 complete"
+    exit 0
+}
+
+if [ "$RUN" == "-l" ]; then	#### Remote server listen ####
+    export NCAT_PORT=$ncat_port
+    # Ensure policy and tests are ready
+    make -C policy load
+    make -C tests all
+
+    # The inet_socket IPSEC tests require this on the server side:
+    iptables -I INPUT 1 -p ah -j ACCEPT
+    # The sctp tests require these on the server side:
+    iptables -I INPUT 1 -p sctp -j ACCEPT
+    ip6tables -I INPUT 1 -p sctp -j ACCEPT
+
+    echo -e "\nncat listening on port $NCAT_PORT for test server commands\n"
+    # The remote ncat listener is run from selinux-testsuite. This allows
+    # tests to use relative paths to their specific location (e.g. tests/sctp)
+    # when executing commands on the remote system.
+    ncat -l -k -e /bin/sh -p $NCAT_PORT
+
+else	#### Client server to run tests ####
+    #
+    # The sctp tests require these on client side for ASCONF tests:
+    iptables -I INPUT 1 -p sctp -j ACCEPT
+    ip6tables -I INPUT 1 -p sctp -j ACCEPT
+
+    export NCAT_HOST=$ncat_host
+    export NCAT_PORT=$ncat_port
+    export C_IPV4_1=$c_ipv4_1
+    export C_IPV6_1=$c_ipv6_1
+    if [ "$c_ifname" ]; then
+        export C_IFNAME=$c_ifname
+    fi
+
+    export S_IPV4_1=$s_ipv4_1
+    export S_IPV6_1=$s_ipv6_1
+    if [ "$s_ipv6_2" ]; then
+        export S_IPV6_2=$s_ipv6_2
+    fi
+
+    echo "Set ncat remote host IP: $NCAT_HOST port: $NCAT_PORT"
+    read -r -p "Is the remote system ready? [y/N]" ans
+    if [[ $ans == "N" || $ans == "n" ]]; then
+        echo "No tests run"
+        exit 1
+    fi
+
+    if [ "$RUN" ]; then
+        run_test $RUN $V
+    else
+        make -C policy load
+        make -C tests test
+    fi
+    echo "All local and remote tests completed"
+fi
-- 
2.25.2

