Return-Path: <SRS0=Lh2G=7C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B40C433E0
	for <selinux@archiver.kernel.org>; Wed, 20 May 2020 12:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFE1E207C4
	for <selinux@archiver.kernel.org>; Wed, 20 May 2020 12:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="oxIa6dB1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgETMZy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 20 May 2020 08:25:54 -0400
Received: from mailomta18-sa.btinternet.com ([213.120.69.24]:34713 "EHLO
        sa-prd-fep-047.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726224AbgETMZy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 20 May 2020 08:25:54 -0400
Received: from sa-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.38.7])
          by sa-prd-fep-047.btinternet.com with ESMTP
          id <20200520122549.GZP4071.sa-prd-fep-047.btinternet.com@sa-prd-rgout-004.btmx-prd.synchronoss.net>;
          Wed, 20 May 2020 13:25:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1589977549; 
        bh=A5P3n7G7k5ZJXw12fsN3XdiijNrlzqHhwa1UQYJAMn0=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=oxIa6dB1ScK5L+ekoDuON9z59rFecCY3GDp9OSnCKoytjgE6EaqdMd9lLvYMttnViPNbHchLFAlNXb3O7DpfnXtTj2FkEiqqY32Hww+/C3Bnuseh0kxDm3UraO9kcw1ae+2t20kwLqksF9/PcNXShx0DKn1ds5voOlnPBkp+JqYHzLx0DsBqWZdF3NZJg9Ab/DcSI9XTuHQxqfSbIUqUtKZ3mI9CXsE1p6L+2SuWopz5Kod34Ooz5XUFEAGklDRTbsubEQWGY5QE7g6HRdJ/THrlfW3Pn+d1OnydJiBJ6hq5qyevFw/x9FuWhAiTuqBAkazv0CE1PbShwluycH4PvA==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [109.148.83.52]
X-OWM-Source-IP: 109.148.83.52 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduhedruddtledgheduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpeelteffgeevveejheevhfetgfeuveduteetuddtffdvjeekieetgeehveefjedtfeenucfkphepuddtledrudegkedrkeefrdehvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepuddtledrudegkedrkeefrdehvddpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehomhhoshhnrggtvgesrhgvughhrghtrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequcfqtfevrffvpehrfhgtkedvvdenrhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (109.148.83.52) by sa-prd-rgout-004.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5E3A27DB11B16BC1; Wed, 20 May 2020 13:25:49 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     omosnace@redhat.com, selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH V4] selinux-testsuite: Add nftables to inet_socket and sctp tests
Date:   Wed, 20 May 2020 13:25:46 +0100
Message-Id: <20200520122546.30442-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.25.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Support secmark tests that require nftables version 9.3 or greater and
kernel 4.20 or greater.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
V2 Change:
Use common tests for iptables/nftables
V3 Change:
Use function
V4 Changes:
Add nftables to README for Debian
Use nft -c to determine if SECMARK supported

 README.md                        |  7 ++-
 tests/inet_socket/nftables-flush |  2 +
 tests/inet_socket/nftables-load  | 74 ++++++++++++++++++++++++
 tests/inet_socket/test           | 99 ++++++++++++++++++++------------
 tests/sctp/nftables-flush        |  2 +
 tests/sctp/nftables-load         | 68 ++++++++++++++++++++++
 tests/sctp/test                  | 90 ++++++++++++++++++-----------
 7 files changed, 270 insertions(+), 72 deletions(-)
 create mode 100644 tests/inet_socket/nftables-flush
 create mode 100644 tests/inet_socket/nftables-load
 create mode 100644 tests/sctp/nftables-flush
 create mode 100644 tests/sctp/nftables-load

diff --git a/README.md b/README.md
index 1f7e5d9..81475d7 100644
--- a/README.md
+++ b/README.md
@@ -57,6 +57,7 @@ similar dependencies):
 * keyutils-libs-devel _(tools used by the keys tests)_
 * kernel-devel _(used by the kernel module tests)_
 * quota, xfsprogs-devel and libuuid-devel _(used by the filesystem tests)_
+* nftables _(used by inet_socket and sctp tests if ver >= 9.3 for secmark testing )_
 
 On a modern Fedora system you can install these dependencies with the
 following command:
@@ -77,7 +78,8 @@ following command:
 		kernel-devel \
 		quota \
 		xfsprogs-devel \
-		libuuid-devel
+		libuuid-devel \
+		nftables
 
 #### Debian
 
@@ -118,7 +120,8 @@ command:
 		quota \
 		xfsprogs \
 		xfslibs-dev \
-		uuid-dev
+		uuid-dev \
+		nftables
 
 On Debian, you need to build and install netlabel_tools manually since
 it is not yet packaged for Debian
diff --git a/tests/inet_socket/nftables-flush b/tests/inet_socket/nftables-flush
new file mode 100644
index 0000000..7d62b8d
--- /dev/null
+++ b/tests/inet_socket/nftables-flush
@@ -0,0 +1,2 @@
+delete table ip security
+delete table ip6 security
diff --git a/tests/inet_socket/nftables-load b/tests/inet_socket/nftables-load
new file mode 100644
index 0000000..11ec382
--- /dev/null
+++ b/tests/inet_socket/nftables-load
@@ -0,0 +1,74 @@
+# Based on NFT project example. Requires kernel >= 4.20 and nft >= 0.9.3
+
+add table ip security
+add table ip6 security
+
+table ip security {
+
+	secmark inet_server {
+		"system_u:object_r:test_server_packet_t:s0"
+	}
+
+	map secmapping_in_out {
+		type inet_service : secmark
+		elements = { 65535 : "inet_server" }
+	}
+
+	chain input {
+		type filter hook input priority 0;
+
+		# label new incoming packets and add to connection
+		ct state new meta secmark set tcp dport map @secmapping_in_out
+		ct state new meta secmark set udp dport map @secmapping_in_out
+		ct state new ct secmark set meta secmark
+
+		# set label for est/rel packets from connection
+		ct state established,related meta secmark set ct secmark
+	}
+
+	chain output {
+		type filter hook output priority 0;
+
+		# label new outgoing packets and add to connection
+		ct state new meta secmark set tcp dport map @secmapping_in_out
+		# 'established' is used here so that the error return is the
+		# same as the 'iptables-load' tests (no reply from server)
+		ct state established meta secmark set udp dport map @secmapping_in_out
+		ct state new ct secmark set meta secmark
+
+		# set label for est/rel packets from connection
+		ct state established,related meta secmark set ct secmark
+	}
+}
+
+table ip6 security {
+
+	secmark inet_server {
+		"system_u:object_r:test_server_packet_t:s0"
+	}
+
+	map secmapping_in_out {
+		type inet_service : secmark
+		elements = { 65535 : "inet_server" }
+	}
+
+	chain input {
+		type filter hook input priority 0;
+
+		ct state new meta secmark set tcp dport map @secmapping_in_out
+		ct state new meta secmark set udp dport map @secmapping_in_out
+		ct state new ct secmark set meta secmark
+
+		ct state established,related meta secmark set ct secmark
+	}
+
+	chain output {
+		type filter hook output priority 0;
+
+		ct state new meta secmark set tcp dport map @secmapping_in_out
+		ct state established meta secmark set udp dport map @secmapping_in_out
+		ct state new ct secmark set meta secmark
+
+		ct state established,related meta secmark set ct secmark
+	}
+}
diff --git a/tests/inet_socket/test b/tests/inet_socket/test
index 47ce106..6c82719 100755
--- a/tests/inet_socket/test
+++ b/tests/inet_socket/test
@@ -27,6 +27,19 @@ BEGIN {
         $test_calipso_stream = 1;
     }
 
+    # Determine if nftables has secmark support and kernel >= 4.20
+    $test_nft = 0;
+
+    $rc = system("nft -c -f $basedir/nftables-load 2>/dev/null");
+    if ( $rc == 0 ) {
+        $kverminstream = "4.20";
+        $rc            = `$basedir/../kvercmp $kvercur $kverminstream`;
+        if ( $rc > 0 ) {
+            $test_count += 8;
+            $test_nft = 1;
+        }
+    }
+
     plan tests => $test_count;
 }
 
@@ -348,64 +361,76 @@ if ($test_ipsec) {
     system "/bin/sh $basedir/ipsec-flush";
 }
 
-# Load iptables (IPv4 & IPv6) configuration.
-system "/bin/sh $basedir/iptables-load";
+#
+################## Test iptables/nftables configuration ######################
+#
+sub test_tables {
 
-# Start the stream server.
-$pid = server_start( "-t test_inet_server_t", "-n stream 65535" );
+    # Start the stream server.
+    $pid = server_start( "-t test_inet_server_t", "-n stream 65535" );
 
-# Verify that authorized client can communicate with the server.
-$result = system
+    # Verify that authorized client can communicate with the server.
+    $result = system
 "runcon -t test_inet_client_t -- $basedir/client -e nopeer stream 127.0.0.1 65535";
-ok( $result eq 0 );
+    ok( $result eq 0 );
 
-# Verify that unauthorized client cannot communicate with the server.
-$result = system
+    # Verify that unauthorized client cannot communicate with the server.
+    $result = system
 "runcon -t test_inet_bad_client_t -- $basedir/client -e nopeer stream 127.0.0.1 65535 2>&1";
-ok( $result >> 8 eq 5 );
+    ok( $result >> 8 eq 5 );
 
-# Verify that authorized client can communicate with the server.
-$result = system
-  "runcon -t test_inet_client_t -- $basedir/client -e nopeer stream ::1 65535";
-ok( $result eq 0 );
+    # Verify that authorized client can communicate with the server.
+    $result = system
+"runcon -t test_inet_client_t -- $basedir/client -e nopeer stream ::1 65535";
+    ok( $result eq 0 );
 
-# Verify that unauthorized client cannot communicate with the server.
-$result = system
+    # Verify that unauthorized client cannot communicate with the server.
+    $result = system
 "runcon -t test_inet_bad_client_t -- $basedir/client -e nopeer stream ::1 65535 2>&1";
-ok( $result >> 8 eq 5 );
+    ok( $result >> 8 eq 5 );
 
-# Kill the server.
-server_end($pid);
+    # Kill the server.
+    server_end($pid);
 
-# Start the dgram server.
-$pid = server_start( "-t test_inet_server_t", "-n dgram 65535" );
+    # Start the dgram server.
+    $pid = server_start( "-t test_inet_server_t", "-n dgram 65535" );
 
-# Verify that authorized client can communicate with the server.
-$result = system
+    # Verify that authorized client can communicate with the server.
+    $result = system
 "runcon -t test_inet_client_t $basedir/client -e nopeer dgram 127.0.0.1 65535";
-ok( $result eq 0 );
+    ok( $result eq 0 );
 
-# Verify that unauthorized client cannot communicate with the server.
-$result = system
+    # Verify that unauthorized client cannot communicate with the server.
+    $result = system
 "runcon -t test_inet_bad_client_t -- $basedir/client -e nopeer dgram 127.0.0.1 65535 2>&1";
-ok( $result >> 8 eq 8 );
+    ok( $result >> 8 eq 8 );
 
-# Verify that authorized client can communicate with the server.
-$result = system
-  "runcon -t test_inet_client_t $basedir/client -e nopeer dgram ::1 65535";
-ok( $result eq 0 );
+    # Verify that authorized client can communicate with the server.
+    $result = system
+      "runcon -t test_inet_client_t $basedir/client -e nopeer dgram ::1 65535";
+    ok( $result eq 0 );
 
-# Verify that unauthorized client cannot communicate with the server.
-$result = system
+    # Verify that unauthorized client cannot communicate with the server.
+    $result = system
 "runcon -t test_inet_bad_client_t -- $basedir/client -e nopeer dgram ::1 65535 2>&1";
-ok( $result >> 8 eq 8 );
+    ok( $result >> 8 eq 8 );
 
-# Kill the server.
-server_end($pid);
+    # Kill the server.
+    server_end($pid);
+}
 
-# Flush iptables configuration.
+print "Testing iptables (IPv4/IPv6).\n";
+system "/bin/sh $basedir/iptables-load";
+test_tables();
 system "/bin/sh $basedir/iptables-flush";
 
+if ($test_nft) {
+    print "Testing nftables (IPv4/IPv6).\n";
+    system "nft -f $basedir/nftables-load";
+    test_tables();
+    system "nft -f $basedir/nftables-flush";
+}
+
 if ($test_calipso_stream) {
 
     # Load NetLabel configuration for CALIPSO/IPv6 labeling over loopback.
diff --git a/tests/sctp/nftables-flush b/tests/sctp/nftables-flush
new file mode 100644
index 0000000..7d62b8d
--- /dev/null
+++ b/tests/sctp/nftables-flush
@@ -0,0 +1,2 @@
+delete table ip security
+delete table ip6 security
diff --git a/tests/sctp/nftables-load b/tests/sctp/nftables-load
new file mode 100644
index 0000000..2cac3bb
--- /dev/null
+++ b/tests/sctp/nftables-load
@@ -0,0 +1,68 @@
+# Based on NFT project example. Requires kernel >= 4.20 and nft >= 0.9.3
+
+add table ip security
+add table ip6 security
+
+table ip security {
+
+	secmark sctp_server {
+		"system_u:object_r:test_sctp_server_packet_t:s0"
+	}
+
+	map secmapping_in_out {
+		type inet_service : secmark
+		elements = { 1035 : "sctp_server" }
+	}
+
+	chain input {
+		type filter hook input priority 0;
+
+		# label new incoming packets and add to connection
+		ct state new meta secmark set sctp dport map @secmapping_in_out
+		ct state new ct secmark set meta secmark
+
+		# set label for est/rel packets from connection
+		ct state established,related meta secmark set ct secmark
+	}
+
+	chain output {
+		type filter hook output priority 0;
+
+		# label new outgoing packets and add to connection
+		ct state new meta secmark set sctp dport map @secmapping_in_out
+		ct state new ct secmark set meta secmark
+
+		# set label for est/rel packets from connection
+		ct state established,related meta secmark set ct secmark
+	}
+}
+
+table ip6 security {
+
+	secmark sctp_server {
+		"system_u:object_r:test_sctp_server_packet_t:s0"
+	}
+
+	map secmapping_in_out {
+		type inet_service : secmark
+		elements = { 1035 : "sctp_server" }
+	}
+
+	chain input {
+		type filter hook input priority 0;
+
+		ct state new meta secmark set sctp dport map @secmapping_in_out
+		ct state new ct secmark set meta secmark
+
+		ct state established,related meta secmark set ct secmark
+	}
+
+	chain output {
+		type filter hook output priority 0;
+
+		ct state new meta secmark set sctp dport map @secmapping_in_out
+		ct state new ct secmark set meta secmark
+
+		ct state established,related meta secmark set ct secmark
+	}
+}
diff --git a/tests/sctp/test b/tests/sctp/test
index 6631da4..fa401fb 100755
--- a/tests/sctp/test
+++ b/tests/sctp/test
@@ -56,6 +56,19 @@ BEGIN {
             $test_calipso = 1;
         }
 
+        # Determine if nftables has secmark support and kernel >= 4.20
+        $test_nft = 0;
+
+        $rc = system("nft -c -f $basedir/nftables-load 2>/dev/null");
+        if ( $rc == 0 ) {
+            $kverminstream = "4.20";
+            $rc            = `$basedir/../kvercmp $kvercur $kverminstream`;
+            if ( $rc > 0 ) {
+                $test_count += 8;
+                $test_nft = 1;
+            }
+        }
+
         plan tests => $test_count;
     }
 }
@@ -749,64 +762,75 @@ if ($test_calipso) {
 }
 
 #
-##################### Test iptables configuration ############################
+################## Test iptables/nftables configuration ######################
 #
-print "# Testing iptables (IPv4/IPv6).\n";
-system "/bin/sh $basedir/iptables-load";
+sub test_tables {
 
-# Start the stream server.
-$pid =
-  server_start( "-t test_sctp_server_t", "sctp_server", "$v -n stream 1035" );
+    # Start the stream server.
+    $pid = server_start( "-t test_sctp_server_t",
+        "sctp_server", "$v -n stream 1035" );
 
-# Verify that authorized client can communicate with the server STREAM->STREAM.
-$result = system
+ # Verify that authorized client can communicate with the server STREAM->STREAM.
+    $result = system
 "runcon -t test_sctp_client_t $basedir/sctp_client $v -e nopeer stream 127.0.0.1 1035";
-ok( $result eq 0 );
+    ok( $result eq 0 );
 
 # Verify that a client without peer { recv } permission cannot communicate with the server STREAM->STREAM.
-$result = system
+    $result = system
 "runcon -t test_sctp_deny_peer_client_t -- $basedir/sctp_client $v -e nopeer stream 127.0.0.1 1035 2>&1";
-ok( $result >> 8 eq 6 );
+    ok( $result >> 8 eq 6 );
 
-# Verify that authorized client can communicate with the server STREAM->STREAM.
-$result = system
+ # Verify that authorized client can communicate with the server STREAM->STREAM.
+    $result = system
 "runcon -t test_sctp_client_t $basedir/sctp_client $v -e nopeer stream ::1 1035";
-ok( $result eq 0 );
+    ok( $result eq 0 );
 
 # Verify that a client without peer { recv } permission cannot communicate with the server STREAM->STREAM.
-$result = system
+    $result = system
 "runcon -t test_sctp_deny_peer_client_t -- $basedir/sctp_client $v -e nopeer stream ::1 1035 2>&1";
-ok( $result >> 8 eq 6 );
+    ok( $result >> 8 eq 6 );
 
-# Kill the stream server.
-server_end($pid);
+    # Kill the stream server.
+    server_end($pid);
 
-# Start the seq server.
-$pid = server_start( "-t test_sctp_server_t", "sctp_server", "$v -n seq 1035" );
+    # Start the seq server.
+    $pid =
+      server_start( "-t test_sctp_server_t", "sctp_server", "$v -n seq 1035" );
 
-# Verify that authorized client can communicate with the server SEQ->SEQ.
-$result = system
+    # Verify that authorized client can communicate with the server SEQ->SEQ.
+    $result = system
 "runcon -t test_sctp_client_t $basedir/sctp_client $v -e nopeer seq 127.0.0.1 1035";
-ok( $result eq 0 );
+    ok( $result eq 0 );
 
 # Verify that a client without peer { recv } permission cannot communicate with the server SEQ->SEQ.
-$result = system
+    $result = system
 "runcon -t test_sctp_deny_peer_client_t -- $basedir/sctp_client $v -e nopeer seq 127.0.0.1 1035 2>&1";
-ok( $result >> 8 eq 6 );
+    ok( $result >> 8 eq 6 );
 
-# Verify that authorized client can communicate with the server SEQ->SEQ.
-$result = system
-  "runcon -t test_sctp_client_t $basedir/sctp_client $v -e nopeer seq ::1 1035";
-ok( $result eq 0 );
+    # Verify that authorized client can communicate with the server SEQ->SEQ.
+    $result = system
+"runcon -t test_sctp_client_t $basedir/sctp_client $v -e nopeer seq ::1 1035";
+    ok( $result eq 0 );
 
 # Verify that a client without peer { recv } permission cannot communicate with the server SEQ->SEQ.
-$result = system
+    $result = system
 "runcon -t test_sctp_deny_peer_client_t -- $basedir/sctp_client $v -e nopeer seq ::1 1035 2>&1";
-ok( $result >> 8 eq 6 );
+    ok( $result >> 8 eq 6 );
 
-# Kill the seq server.
-server_end($pid);
+    # Kill the seq server.
+    server_end($pid);
+}
 
+print "# Testing iptables (IPv4/IPv6).\n";
+system "/bin/sh $basedir/iptables-load";
+test_tables();
 system "/bin/sh $basedir/iptables-flush";
 
+if ($test_nft) {
+    print "# Testing nftables (IPv4/IPv6).\n";
+    system "nft -f $basedir/nftables-load";
+    test_tables();
+    system "nft -f $basedir/nftables-flush";
+}
+
 exit;
-- 
2.25.3

