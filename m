Return-Path: <SRS0=r6Mn=CE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6027C433E1
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 12:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E1A7208E4
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 12:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="DZ6QeaPJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729617AbgHZMl3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Aug 2020 08:41:29 -0400
Received: from mailomta4-re.btinternet.com ([213.120.69.97]:50889 "EHLO
        re-prd-fep-044.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729401AbgHZMlY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Aug 2020 08:41:24 -0400
Received: from re-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.54.5])
          by re-prd-fep-044.btinternet.com with ESMTP
          id <20200826124116.KPSP21348.re-prd-fep-044.btinternet.com@re-prd-rgout-002.btmx-prd.synchronoss.net>;
          Wed, 26 Aug 2020 13:41:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1598445676; 
        bh=gxpqyfEltkRmckt8oCrRxWo1rGm6fSWJFbmp8x6dlHI=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=DZ6QeaPJ44nKSrgLSITIy43pcUiyLHOdB6nzz1rQU8mVBLJoWymEib/UYnjZhlrvA/ZQoXsRddin6JHxjQJXhhrES1GwlQLxE/dEwZ7HPaHhLbMxw8Qn1w1DltPmNd4zfmPzsl9xR2u5ODFTaro+5cw38nDaL/aQ0nnJnsJK2tE3w6/hQmnu2ejiQIncGNxzly0RgPB3dyZ44usAXQI8sA64UwBqqVzr/Kdb0/+vnnfNK1SRRddAEgAP5u+taexTcLd8PHWvclQnCfgbBr59BngLDEa0ahyYDq2WMCSh5WF/iV6D5VCxZmWiPW0XlMC4Uqje7xegrl2VwhAzV74dHA==
Authentication-Results: btinternet.com; none
X-Originating-IP: [86.155.83.250]
X-OWM-Source-IP: 86.155.83.250 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=49/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedruddvvddghedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecuogfuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepteeihefgjeeluefgteeuudduteeifffgieehteegffeuhfelteeghfekueetkeefnecuffhomhgrihhnpehlihhvvghjohhurhhnrghlrdgtohhmnecukfhppeekiedrudehhedrkeefrddvhedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudehhedrkeefrddvhedtpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequcfqtfevrffvpehrfhgtkedvvdenrhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdr
        ohhrgheq
X-RazorGate-Vade-Verdict: clean 49
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (86.155.83.250) by re-prd-rgout-002.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9C0CC0DAFBE7F; Wed, 26 Aug 2020 13:41:15 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [RFC V2 PATCH 1/2] selinux-testsuite: Run tests using remote server
Date:   Wed, 26 Aug 2020 13:40:53 +0100
Message-Id: <20200826124054.26302-2-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200826124054.26302-1-richard_c_haines@btinternet.com>
References: <20200826124054.26302-1-richard_c_haines@btinternet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This RFC patch will allow another server with the testsuite installed to
act as a remote server. The main tests will be run on the client system,
with the remotely enabled server components running on the remote server.

This version updates the inet_socket tests to run its server
components on the remote system controlled by ncat(1).

See the README.md - 'Remote System Testing' section for configuration
details.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 README.md                                     | 156 +++++++
 policy/test_inet_socket.te                    |   2 +
 tests/inet_socket/calipso-load                |   3 +-
 tests/inet_socket/cipso-fl-load               |   2 +-
 .../inet_socket/{cipso-load-t1 => cipso-load} |   4 +-
 tests/inet_socket/cipso-load-t2               |  11 -
 tests/inet_socket/cipso-load-t5               |  11 -
 tests/inet_socket/ipsec-load                  |  22 +-
 tests/inet_socket/start_remote_svr            |   4 +
 tests/inet_socket/stop_remote_svr             |   3 +
 tests/inet_socket/test                        | 436 ++++++++++++++----
 tools/remote.sh                               | 121 +++++
 tools/remote_cfg/client_cmds.sh               |  20 +
 tools/remote_cfg/remote.cfg                   |  22 +
 tools/remote_cfg/server_cmds.sh               |  13 +
 15 files changed, 706 insertions(+), 124 deletions(-)
 rename tests/inet_socket/{cipso-load-t1 => cipso-load} (72%)
 delete mode 100644 tests/inet_socket/cipso-load-t2
 delete mode 100644 tests/inet_socket/cipso-load-t5
 create mode 100644 tests/inet_socket/start_remote_svr
 create mode 100644 tests/inet_socket/stop_remote_svr
 create mode 100755 tools/remote.sh
 create mode 100755 tools/remote_cfg/client_cmds.sh
 create mode 100644 tools/remote_cfg/remote.cfg
 create mode 100755 tools/remote_cfg/server_cmds.sh

diff --git a/README.md b/README.md
index 838a082..e12b8d5 100644
--- a/README.md
+++ b/README.md
@@ -364,3 +364,159 @@ directory (based on the path of the script executable).  This won't always be
 accurate, but will work for this test harness/configuration.
 
 	$basedir = $0;  $basedir =~ s|(.*)/[^/]*|$1|;
+
+
+# Remote System Testing
+
+It is possible to run tests with remotely enabled server components on a
+system using `ncat`. The `inet_socket` and `sctp` tests are currently enabled,
+however some tests such as nf/iptables, CIPSO loopback etc. are still run
+locally.
+
+The requirements are a 'client' system that runs the complete test-suite and
+a remote 'server' system that runs the test server components under the
+control of `ncat`.
+
+Mandatory Client system addresses:
+
+1. One IPv4 address `$c_ipv4_1`.
+2. One IPv6 address `$c_ipv6_1` - This must not be a local link address.
+
+
+Mandatory Server system addresses:
+
+1. One IPv4 or IPv6 address for the `ncat` client/server control session
+   (`$ncat_host` with `$ncat_port`. This must not be used for test traffic
+   that consists of IPSEC, CIPSO and CALIPSO streams.
+2. One IPv4 address `$s_ipv4_1`.
+3. One IPv6 address `$s_ipv6_1` - This must not be a local link address.
+
+If SCTP/ASCONF testing is required, then a second server IPv6 address needs
+to be configured `$s_ipv6_2`. This maybe a local link address with its
+interface name appended, e.g. `addr%ifname`. This address is only used to test
+the SCTP Dynamic Address Reconfiguration.
+
+The following diagram shows the systems that are configured via a common
+`remote.cfg` configuration file installed on both systems.
+
+```
+                               ncat(1) Control Link
+                +------------------------------------------+
+                |                                          | $ncat_host
+                |                                          | $ncat_port
+        +-------+-------+                          +-------+-------+
+        |     $c_ipv4_1 +----- IPv4 Test Link -----+ $s_ipv4_1     |
+        |               |                          |               |
+        |     $c_ipv6_1 +----- IPv6 Test Link -----+ $s_ipv6_1     |
+        |               |                          |               |
+        |               |             IPv6 Addr ---+ $s_ipv6_2     |
+        +---------------+                          +---------------+
+             Client                                     Server
+```
+
+## Installation
+
+Both Client and Server systems should have all the standard packages installed
+for the selinux-testsuite. While both should ideally be at the same level and
+with the same kernel version/configuration, no checks are carried out.
+
+On Fedora the `nmap-ncat` package must be installed with the following
+command:
+
+	# dnf install nmap-ncat
+
+Other Linux distributions should have a similar package.
+
+## Configuration Files
+
+There is one mandatory configuration file containing the IP addresses, also as
+each client/server system may have specific configuration requirements to allow
+network connectivity, there are two further optional configuration files.
+Their default location is `tools/remote_cfg` and the file names are:
+
+`remote.cfg` -  Contains the mandatory IP addresses and must be installed on
+both systems. Its contents are described in the next section.
+
+`client_cmds.sh` - This will run any user defined commands to allow
+client/server connectivity, for example Fedora WS requires SCTP configuration
+parameters set via `firewall-cmd(8)`.
+
+`server_cmds.sh` - This will run any user defined commands to allow
+server/client connectivity, for example Fedora WS requires IPSEC and SCTP
+configuration parameters set via `firewall-cmd(8)`.
+
+To allow multiple configuration files to exist, the '-c <config_dir>' command
+line option is provided. The configuration file names must be as defined above,
+however their location may change, for example:
+
+* `tools/remote_test_1` contains `remote.cfg` and `client_cmds.sh`
+  * Start remote server: `tools/remote.sh -r -c tools/remote_test_1`
+  * Run tests from client: `tools/remote.sh -c tools/remote_test_1`
+
+### `remote.cfg` Configuration File
+
+Below is an example `remote.cfg` configuration file that shows the information
+required. Edit the `tools/remote_cfg/remote.cfg` file to suit the test setup
+and install on both systems. Note: the Server side only requires the
+`ncat_port` entry, the remainder are used by the Client.
+
+```
+# Client -> Server address. Do NOT use the same ncat_host address for any
+# test server traffic as IPSEC, CIPSO & CALIPSO will cause protocol errors.
+ncat_host=193.168.1.65
+ncat_port=9999
+
+###########################################################################
+# NOTE: c_ipv6_1 and s_ipv6_1 must not be local link addresses.
+###########################################################################
+
+# Client side MUST have one of each IPv4 and IPv6 addresses
+c_ipv4_1=192.168.1.198
+c_ipv6_1=2a00:23c6:278e:c901:3bf7:29c9:2139:91d0
+
+# Server side MUST have one of each IPv4 and IPv6 addresses.
+s_ipv4_1=192.168.1.148
+s_ipv6_1=2a00:23c6:278e:c901:ff65:b87b:a84d:29a8
+
+# If testing SCTP Dynamic Address Reconfiguration (ASCONF chunks test),
+# then an additional IPv6 address is required. If it is a local link address,
+# it MUST have the server side ifname associated to it.
+s_ipv6_2=fe80::7f74:f41a:3c70:d333%enp9s0
+```
+
+## Running the Tests
+
+Once both systems are configured and the test-suite has been successfully
+run locally on each system, on the Remote Server:
+
+       # cd selinux-testsuite
+       # ./tools/remote.sh -r [-c config_dir] [-l log_file]
+
+The `remote.sh` script will load the policy, make the executables, then
+run any additional commands to allow the server side tests to complete.
+Finally it runs `ncat` to listen on the configured port.
+
+A log file is always generated to show activity on the server side terminal.
+If not specified a temp file is generated, then removed when `ncat` exits.
+The log contains `ncat` commands received from the client. Any output
+generated by the servers (including the 'sctp -v' option text), will only be
+seen on the terminal.
+
+To run the complete test-suite on the Client system:
+
+       # cd selinux-testsuite
+       # ./tools/remote.sh [-c config_dir]
+
+The `remote.sh` script will load the policy, make the executables, then
+run any additional commands to allow the server side tests to complete.
+
+Optionally any single test can be run, however `inet_socket` and `sctp` are
+the only relevant ones enabled. To run `inet_socket`:
+
+       # cd selinux-testsuite
+       # ./tools/remote.sh  [-c config_dir] inet_socket
+
+`sctp` can also be run with the `-v` option.
+
+Note that the test policy must be loaded if individual tests are run as the
+script only runs `make` for those specific tests.
diff --git a/policy/test_inet_socket.te b/policy/test_inet_socket.te
index 0fff2da..2f104e5 100644
--- a/policy/test_inet_socket.te
+++ b/policy/test_inet_socket.te
@@ -35,6 +35,8 @@ corenet_inout_generic_node(test_inet_server_t)
 
 # For writing to flag file:
 allow test_inet_server_t test_file_t:fifo_file rw_file_perms;
+# Remote tests on client side for flag file:
+userdom_search_user_home_content(test_inet_server_t)
 
 # We need to ensure that the test domain is MCS constrained.
 ## newer systems, e.g. Fedora and RHEL >= 7.x
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
diff --git a/tests/inet_socket/ipsec-load b/tests/inet_socket/ipsec-load
index 21e2dfe..10507cc 100644
--- a/tests/inet_socket/ipsec-load
+++ b/tests/inet_socket/ipsec-load
@@ -1,17 +1,17 @@
 #!/bin/sh
+
+SPD_CTX="system_u:object_r:test_spd_t:s0"
 echo 0 > /proc/sys/net/ipv4/conf/lo/disable_xfrm
 echo 0 > /proc/sys/net/ipv4/conf/lo/disable_policy
+
 ip xfrm policy flush
 ip xfrm state flush
-goodclientcon=`secon -u --pid $$`:`secon -r --pid $$`:test_inet_client_t:`secon -m --pid $$`
-badclientcon=`secon -u --pid $$`:`secon -r --pid $$`:test_inet_bad_client_t:`secon -m --pid $$`
-ip xfrm state add src 127.0.0.1 dst 127.0.0.1 proto ah spi 0x200 ctx $goodclientcon auth sha1 0123456789012345
-ip xfrm state add src 127.0.0.1 dst 127.0.0.1 proto ah spi 0x250 ctx $badclientcon auth sha1 0123456789012345
-ip xfrm policy add src 127.0.0.1 dst 127.0.0.1 proto tcp dir out ctx "system_u:object_r:test_spd_t:s0" tmpl proto ah mode transport level required
-ip xfrm policy add src 127.0.0.1 dst 127.0.0.1 proto udp dir out ctx "system_u:object_r:test_spd_t:s0" tmpl proto ah mode transport level required
+ip -4 xfrm state add src $3 dst $4 proto ah spi 0x200 ctx $1 auth sha1 0123456789012345
+ip -4 xfrm state add src $3 dst $4 proto ah spi 0x250 ctx $2 auth sha1 0123456789012345
+ip -4 xfrm policy add src $3 dst $4 proto tcp dir out ctx $SPD_CTX tmpl proto ah mode transport level required
+ip -4 xfrm policy add src $3 dst $4 proto udp dir out ctx $SPD_CTX tmpl proto ah mode transport level required
 
-# IPv6 loopback
-ip xfrm state add src ::1 dst ::1 proto ah spi 0x200 ctx $goodclientcon auth sha1 0123456789012345
-ip xfrm state add src ::1 dst ::1 proto ah spi 0x250 ctx $badclientcon auth sha1 0123456789012345
-ip xfrm policy add src ::1 dst ::1 proto tcp dir out ctx "system_u:object_r:test_spd_t:s0" tmpl proto ah mode transport level required
-ip xfrm policy add src ::1 dst ::1 proto udp dir out ctx "system_u:object_r:test_spd_t:s0" tmpl proto ah mode transport level required
+ip -6 xfrm state add src $5 dst $6 proto ah spi 0x200 ctx $1 auth sha1 0123456789012345
+ip -6 xfrm state add src $5 dst $6 proto ah spi 0x250 ctx $2 auth sha1 0123456789012345
+ip -6 xfrm policy add src $5 dst $6 proto tcp dir out ctx $SPD_CTX tmpl proto ah mode transport level required
+ip -6 xfrm policy add src $5 dst $6 proto udp dir out ctx $SPD_CTX tmpl proto ah mode transport level required
diff --git a/tests/inet_socket/start_remote_svr b/tests/inet_socket/start_remote_svr
new file mode 100644
index 0000000..e2e0177
--- /dev/null
+++ b/tests/inet_socket/start_remote_svr
@@ -0,0 +1,4 @@
+#!/bin/sh
+
+# Redirect stdout for log file
+$1 1>&2 &
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
index 56a947b..1cae03b 100755
--- a/tests/inet_socket/test
+++ b/tests/inet_socket/test
@@ -39,8 +39,34 @@ BEGIN {
     plan tests => $test_count;
 }
 
+# Note the ncat address must NOT be used for tests as
+# CIPSO/CALIPSO/IPSEC will cause protocol errors.
+$s_basedir = "tests/inet_socket";
+$ncat_host = $ENV{'NCAT_HOST'};
+$ncat_port = $ENV{'NCAT_PORT'};
+if ( defined $ncat_host and defined $ncat_port ) {
+
+    # Remote tests can be followed using tshark(1):
+    #     tshark -O tcp,udp,ipv6,ip,cipso,calipso -P -x -i any
+    print "Running remote servers on IP addr: $ncat_host\n";
+
+    # Get ipv4/6 addrs
+    $c_ipv4_1 = $ENV{'C_IPV4_1'};
+    $c_ipv6_1 = $ENV{'C_IPV6_1'};
+    $s_ipv4_1 = $ENV{'S_IPV4_1'};
+    $s_ipv6_1 = $ENV{'S_IPV6_1'};
+
+    $ncat = "ncat $ncat_host $ncat_port 2>&1";
+}
+else {
+    $c_ipv4_1 = "127.0.0.1";
+    $c_ipv6_1 = "::1";
+    $s_ipv4_1 = "127.0.0.1";
+    $s_ipv6_1 = "::1";
+}
+
 sub server_start {
-    my ( $runcon_args, $args ) = @_;
+    my ( $runcon_args, $args, $text ) = @_;
     my $pid;
 
     system("mkfifo $basedir/flag");
@@ -51,6 +77,7 @@ sub server_start {
 
     # Wait for it to initialize.
     system("read -t 5 <>$basedir/flag");
+    print "Started $text server\n";
     return $pid;
 }
 
@@ -62,36 +89,70 @@ sub server_end {
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
@@ -100,95 +161,168 @@ server_end($pid);
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
+"runcon -t test_inet_client_t -l s0:c61.c239 $basedir/client -e system_u:object_r:netlabel_peer_t:s0:c61.c239 stream $s_ipv4_1 65535";
 ok( $result eq 0 );
 
 # Verify that authorized client cannot communicate with the server using different level.
 $result = system
-"runcon -t test_inet_client_t -l s0:c19,c120 $basedir/client stream 127.0.0.1 65535 2>&1";
+"runcon -t test_inet_client_t -l s0:c19,c120 $basedir/client stream $s_ipv4_1 65535 2>&1";
 ok( $result >> 8 eq 5 );
 
 # TAG 1 allows categories 0 to 239 to be sent, if greater then ENOSPC (No space left on device)
 $result = system
-"runcon -t test_inet_client_t -l s0:c0.c240 $basedir/client stream 127.0.0.1 65535 2>&1";
+"runcon -t test_inet_client_t -l s0:c0.c240 $basedir/client stream $s_ipv4_1 65535 2>&1";
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
+"runcon -t test_inet_client_t -l s0:c20.c50 $basedir/client -e system_u:object_r:netlabel_peer_t:s0:c20.c50 dgram $s_ipv4_1 65535";
 ok( $result eq 0 );
 
 # Verify that authorized client cannot communicate with the server using levels dominating the server.
 $result = system
-"runcon -t test_inet_client_t -l s0:c40.c51 $basedir/client dgram 127.0.0.1 65535 2>&1";
+"runcon -t test_inet_client_t -l s0:c40.c51 $basedir/client dgram $s_ipv4_1 65535 2>&1";
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
+"runcon -t test_inet_client_t -l s0:c90.c100 $basedir/client -e system_u:object_r:netlabel_peer_t:s0:c90.c100 stream $s_ipv4_1 65535";
 ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server using level.
 $result = system
-"runcon -t test_inet_client_t -l s0:c0.c14 $basedir/client -e system_u:object_r:netlabel_peer_t:s0:c0.c14 stream 127.0.0.1 65535";
+"runcon -t test_inet_client_t -l s0:c0.c14 $basedir/client -e system_u:object_r:netlabel_peer_t:s0:c0.c14 stream $s_ipv4_1 65535";
 ok( $result eq 0 );
 
 # Verify that authorized client cannot communicate with the server using different level.
 $result = system
-"runcon -t test_inet_client_t -l s0:c101 $basedir/client stream 127.0.0.1 65535 2>&1";
+"runcon -t test_inet_client_t -l s0:c101 $basedir/client stream $s_ipv4_1 65535 2>&1";
 ok( $result >> 8 eq 5 );
 
 # TAG 2 allows a maximum of 15 categories in exchange, if greater then ENOSPC (No space left on device)
 $result = system
-"runcon -t test_inet_client_t -l s0:c0.c16 -- $basedir/client dgram 127.0.0.1 65535 2>&1";
+"runcon -t test_inet_client_t -l s0:c0.c16 -- $basedir/client dgram $s_ipv4_1 65535 2>&1";
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
+"runcon -t test_inet_client_t -l s0:c0.c14 $basedir/client -e system_u:object_r:netlabel_peer_t:s0:c0.c14 dgram $s_ipv4_1 65535";
 ok( $result eq 0 );
 
 # Verify that authorized client cannot communicate with the server using levels dominating the server.
 $result = system
-"runcon -t test_inet_client_t -l s0:c15 $basedir/client dgram 127.0.0.1 65535 2>&1";
+"runcon -t test_inet_client_t -l s0:c15 $basedir/client dgram $s_ipv4_1 65535 2>&1";
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
@@ -198,56 +332,93 @@ system "/bin/sh $basedir/cipso-flush";
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
+"runcon -t test_inet_client_t -l s0:c0.c100 $basedir/client -e system_u:object_r:netlabel_peer_t:s0:c0.c100 stream $s_ipv4_1 65535";
 ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server using level.
 $result = system
-"runcon -t test_inet_client_t -l s0:c8.c100 $basedir/client -e system_u:object_r:netlabel_peer_t:s0:c8.c100 stream 127.0.0.1 65535";
+"runcon -t test_inet_client_t -l s0:c8.c100 $basedir/client -e system_u:object_r:netlabel_peer_t:s0:c8.c100 stream $s_ipv4_1 65535";
 ok( $result eq 0 );
 
 # Verify that authorized client cannot communicate with the server using different level.
 $result = system
-"runcon -t test_inet_client_t -l s0:c8.c101 $basedir/client stream 127.0.0.1 65535 2>&1";
+"runcon -t test_inet_client_t -l s0:c8.c101 $basedir/client stream $s_ipv4_1 65535 2>&1";
 ok( $result >> 8 eq 5 );
 
 # Verify ok with the 8 entries when cat c0:
 $result = system
-"runcon -t test_inet_client_t -l s0:c0.c3,c20.c25,c30.c36,c40.c45,c50.c55,c60.c66,c70.c78,c80.c88 $basedir/client -e system_u:object_r:netlabel_peer_t:s0:c0.c3,c20.c25,c30.c36,c40.c45,c50.c55,c60.c66,c70.c78,c80.c88 stream 127.0.0.1 65535";
+"runcon -t test_inet_client_t -l s0:c0.c3,c20.c25,c30.c36,c40.c45,c50.c55,c60.c66,c70.c78,c80.c88 $basedir/client -e system_u:object_r:netlabel_peer_t:s0:c0.c3,c20.c25,c30.c36,c40.c45,c50.c55,c60.c66,c70.c78,c80.c88 stream $s_ipv4_1 65535";
 ok( $result eq 0 );
 
 # Verify fail with the 8 entries when cat !c0:
 $result = system
-"runcon -t test_inet_client_t -l s0:c20.c25,c30.c36,c40.c45,c50.c55,c60.c66,c70.c78,c80.c88,c90.c99 $basedir/client stream 127.0.0.1 65535 2>&1";
+"runcon -t test_inet_client_t -l s0:c20.c25,c30.c36,c40.c45,c50.c55,c60.c66,c70.c78,c80.c88,c90.c99 $basedir/client stream $s_ipv4_1 65535 2>&1";
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
+"runcon -t test_inet_client_t -l s0:c0.c100 $basedir/client -e system_u:object_r:netlabel_peer_t:s0:c0.c100 dgram $s_ipv4_1 65535";
 ok( $result eq 0 );
 
 # Verify that authorized client cannot communicate with the server using levels dominating the server.
 $result = system
-"runcon -t test_inet_client_t -l s0:c40.c101 $basedir/client dgram 127.0.0.1 65535 2>&1";
+"runcon -t test_inet_client_t -l s0:c40.c101 $basedir/client dgram $s_ipv4_1 65535 2>&1";
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
@@ -291,79 +462,147 @@ ok($result);
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
+      "runcon -t test_inet_client_t $basedir/client stream $s_ipv4_1 65535";
     ok( $result eq 0 );
 
     # Verify that unauthorized client cannot communicate with the server.
     $result = system
-"runcon -t test_inet_bad_client_t -- $basedir/client stream 127.0.0.1 65535 2>&1";
+"runcon -t test_inet_bad_client_t -- $basedir/client stream $s_ipv4_1 65535 2>&1";
     ok( $result >> 8 eq 5 );
 
     # Verify that authorized client can communicate with the server.
     $result =
-      system "runcon -t test_inet_client_t $basedir/client stream ::1 65535";
+      system
+      "runcon -t test_inet_client_t $basedir/client stream $s_ipv6_1 65535";
     ok( $result eq 0 );
 
     # Verify that unauthorized client cannot communicate with the server.
     $result = system
-"runcon -t test_inet_bad_client_t -- $basedir/client stream ::1 65535 2>&1";
+"runcon -t test_inet_bad_client_t -- $basedir/client stream $s_ipv6_1 65535 2>&1";
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
+      "runcon -t test_inet_client_t $basedir/client dgram $s_ipv4_1 65535";
     ok( $result eq 0 );
 
     # Verify that unauthorized client cannot communicate with the server.
     $result = system
-"runcon -t test_inet_bad_client_t -- $basedir/client dgram 127.0.0.1 65535 2>&1";
+"runcon -t test_inet_bad_client_t -- $basedir/client dgram $s_ipv4_1 65535 2>&1";
     ok( $result >> 8 eq 8 );
 
     # Verify that unauthorized client cannot communicate with the server.
     $result = system
-"runcon -t test_inet_bad_client_t -- $basedir/client dgram ::1 65535 2>&1";
+"runcon -t test_inet_bad_client_t -- $basedir/client dgram $s_ipv6_1 65535 2>&1";
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
+"runcon -t test_inet_client_t $basedir/client -e nopeer dgram $s_ipv6_1 65535";
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
-
 #
-################## Test iptables/nftables configuration ######################
+############ Test iptables/nftables configuration - local only ##############
 #
 sub test_tables {
 
     # Start the stream server.
-    $pid = server_start( "-t test_inet_server_t", "-n stream 65535" );
+    $pid = server_start(
+        "-t test_inet_server_t",
+        "-n stream 65535",
+        "local nf/iptables - stream"
+    );
 
     # Verify that authorized client can communicate with the server.
     $result = system
@@ -389,7 +628,11 @@ sub test_tables {
     server_end($pid);
 
     # Start the dgram server.
-    $pid = server_start( "-t test_inet_server_t", "-n dgram 65535" );
+    $pid = server_start(
+        "-t test_inet_server_t",
+        "-n dgram 65535",
+        "local nf/iptables dgram"
+    );
 
     # Verify that authorized client can communicate with the server.
     $result = system
@@ -429,30 +672,49 @@ if ($test_nft) {
 
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
+"runcon -t test_inet_client_t -l s0:c0.c10 $basedir/client -e system_u:object_r:netlabel_peer_t:s0:c0.c10 stream $s_ipv6_1 65535";
     ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server using different valid level.
     $result = system
-"runcon -t test_inet_client_t -l s0:c8.c10 $basedir/client -e  system_u:object_r:netlabel_peer_t:s0:c8.c10 stream ::1 65535";
+"runcon -t test_inet_client_t -l s0:c8.c10 $basedir/client -e  system_u:object_r:netlabel_peer_t:s0:c8.c10 stream $s_ipv6_1 65535";
     ok( $result eq 0 );
 
 # Verify that authorized client cannot communicate with the server using invalid level.
     $result = system
-"runcon -t test_inet_client_t -l s0:c8.c12 -- $basedir/client stream ::1 65535 2>&1";
+"runcon -t test_inet_client_t -l s0:c8.c12 -- $basedir/client stream $s_ipv6_1 65535 2>&1";
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
 
diff --git a/tools/remote.sh b/tools/remote.sh
new file mode 100755
index 0000000..792d102
--- /dev/null
+++ b/tools/remote.sh
@@ -0,0 +1,121 @@
+#!/bin/sh -e
+
+function usage() {
+    echo "Usage: $0 [-c CONFIG_DIR] [-r] Run as Remote Server with: [-l LOG_FILE]"
+    exit 1
+}
+
+function err_exit() {
+    echo "Error on line: $1 - exiting"
+    if [ "$TMP_FILE" ]; then
+        rm $TMP_FILE
+    fi
+    exit 1
+}
+
+function trap_ctrlc() {
+    if [ "$TMP_FILE" ]; then
+        rm $TMP_FILE
+    fi
+    exit 1
+}
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
+trap 'trap_ctrlc' 2
+trap 'err_exit $LINENO' ERR
+
+CONFIG_DIR=tools/remote_cfg
+
+while getopts "c:l:rh" opt
+do
+    case $opt in
+        c) CONFIG_DIR=$OPTARG ;;
+        l) LOG_FILE=$OPTARG ;;
+        r) REMOTE_SVR=1 ;;
+        h|?) usage ;;
+    esac
+done
+
+source $CONFIG_DIR/remote.cfg
+
+shift $((OPTIND-1))
+RUN_TEST=$1
+RUN_OPT=$2
+
+STATUS=`getenforce`
+if [ "$STATUS" != "Enforcing" ]; then
+    echo "This script must be run in enforcing mode"
+    exit 1
+fi
+
+if [ $REMOTE_SVR ]; then	#### Remote server listen for ncat cmds ####
+    export NCAT_PORT=$ncat_port
+    # Ensure policy and tests are ready
+    make -C policy load
+    make -C tests all
+    chcon -R -t test_file_t ./tests
+
+    # Call server_cmds.sh for platform specific requirements
+    if [ -x "$CONFIG_DIR/server_cmds.sh" ]; then
+        $CONFIG_DIR/server_cmds.sh
+    fi
+
+    if [ "$LOG_FILE" ]; then # Create / truncate log file
+        > $LOG_FILE
+    else
+        TMP_FILE=$(mktemp /tmp/netcat-log.XXXXXX)
+        LOG_FILE=$TMP_FILE
+    fi
+
+    echo -e "\nncat listening on port $NCAT_PORT for server commands"
+    echo "with logfile at: $LOG_FILE"
+    # The remote ncat listener is run from ./selinux-testsuite. This allows
+    # tests to use relative paths to their specific location (e.g. tests/sctp)
+    # when executing commands on the remote system.
+    #
+    ncat -l -k -e /bin/sh -p $NCAT_PORT -o $LOG_FILE | tail -f $LOG_FILE
+
+else	#### Client system running tests ####
+    export NCAT_HOST=$ncat_host
+    export NCAT_PORT=$ncat_port
+    export C_IPV4_1=$c_ipv4_1
+    export C_IPV6_1=$c_ipv6_1
+    export S_IPV4_1=$s_ipv4_1
+    export S_IPV6_1=$s_ipv6_1
+    if [ "$s_ipv6_2" ]; then
+        export S_IPV6_2=$s_ipv6_2
+    fi
+
+    # Call client_cmds.sh for platform specific requirements
+    if [ -x "$CONFIG_DIR/client_cmds.sh" ]; then
+        $CONFIG_DIR/client_cmds.sh
+    fi
+
+    echo "Set ncat remote host IP: $NCAT_HOST port: $NCAT_PORT"
+    read -r -p "Is the remote system ready? [y/N]" ans
+    if [ "$ans" == "N" ] || [ "$ans" == "n" ]; then
+        echo "No tests run"
+        exit 1
+    fi
+
+    if [ "$RUN_TEST" ]; then
+        run_test $RUN_TEST $RUN_OPT
+    else
+        make -C policy load
+        make -C tests test
+    fi
+    echo "All local and remote tests completed"
+fi
diff --git a/tools/remote_cfg/client_cmds.sh b/tools/remote_cfg/client_cmds.sh
new file mode 100755
index 0000000..353f1dc
--- /dev/null
+++ b/tools/remote_cfg/client_cmds.sh
@@ -0,0 +1,20 @@
+#!/bin/sh
+
+#
+# Insert any commands required to allow the Client to run tests
+#
+
+# These are required for Fedora 32 - Workstation
+#
+# The sctp tests require iptable or nft rules for client/server testing.
+# firewalld configurations handle either case.
+#
+firewall-cmd --add-port=1035/sctp &>/dev/null
+
+# Required for SCTP Dynamic Address Reconfiguration tests
+if [ "$S_IPV6_2" ]; then
+    # Remove the if_name entry if present
+    S_ADDR=`echo $S_IPV6_2 | cut -f1 -d '%'`
+    firewall-cmd --add-rich-rule="rule family=ipv6 source address=$S_ADDR \
+    destination address=$C_IPV6_1 accept" &>/dev/null
+fi
diff --git a/tools/remote_cfg/remote.cfg b/tools/remote_cfg/remote.cfg
new file mode 100644
index 0000000..b255004
--- /dev/null
+++ b/tools/remote_cfg/remote.cfg
@@ -0,0 +1,22 @@
+# Client -> Server address. Do NOT use the same ncat_host address for any
+# test server traffic as IPSEC, CIPSO & CALIPSO will cause protocol errors.
+ncat_host=193.168.1.65
+ncat_port=9999
+
+###########################################################################
+# NOTE: c_ipv6_1 and s_ipv6_1 must not be local link addresses.
+###########################################################################
+
+# Client side MUST have one of each IPv4 and IPv6 addresses
+c_ipv4_1=192.168.1.198
+c_ipv6_1=2a00:23c6:278e:c901:dab9:2fa8:e7bc:f9b
+
+# Server side MUST have one of each IPv4 and IPv6 addresses.
+s_ipv4_1=192.168.1.148
+s_ipv6_1=2a00:23c6:278e:c901:ff65:b87b:a84d:29a8
+
+# If testing SCTP Dynamic Address Reconfiguration (ASCONF chunks test),
+# then an additional IPv6 address is required. If it is a local link address,
+# it MUST have the server side ifname associated to it.
+s_ipv6_2=fe80::7f74:f41a:3c70:d333%enp9s0
+#s_ipv6_2=2000::1
diff --git a/tools/remote_cfg/server_cmds.sh b/tools/remote_cfg/server_cmds.sh
new file mode 100755
index 0000000..8607e29
--- /dev/null
+++ b/tools/remote_cfg/server_cmds.sh
@@ -0,0 +1,13 @@
+#!/bin/sh -e
+
+#
+# Insert any commands required to allow the Remote Server to run tests
+#
+
+# These are required for Fedora 32 - Workstation
+#
+# The inet_socket (IPSEC) and sctp tests require iptable or nft rules for
+# client/server testing. firewalld configurations handle either case.
+#
+firewall-cmd --add-service ipsec &>/dev/null
+firewall-cmd --add-port=1035/sctp &>/dev/null
-- 
2.26.2

