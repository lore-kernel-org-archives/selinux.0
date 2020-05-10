Return-Path: <SRS0=2ovD=6Y=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A82C38A2A
	for <selinux@archiver.kernel.org>; Sun, 10 May 2020 13:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92CB1206D7
	for <selinux@archiver.kernel.org>; Sun, 10 May 2020 13:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="sSQpwoJ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbgEJN03 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 10 May 2020 09:26:29 -0400
Received: from mailomta27-re.btinternet.com ([213.120.69.120]:38208 "EHLO
        re-prd-fep-043.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726630AbgEJN02 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 10 May 2020 09:26:28 -0400
Received: from re-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.54.4])
          by re-prd-fep-043.btinternet.com with ESMTP
          id <20200510132624.UFHU31563.re-prd-fep-043.btinternet.com@re-prd-rgout-001.btmx-prd.synchronoss.net>;
          Sun, 10 May 2020 14:26:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1589117184; 
        bh=sllfmsTaW9nie8hGqfZ0zEHtxcU7fkLkynTrpJyOz4k=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=sSQpwoJ8lAl0Q3vboQUps7DfK+1zZ31Ow15ecctCQuntUiVDrvO8052OLSudmqfUprrnCl4K2REBQ9s9QQCfRWsJF7OiwPjkiKaW5MNvebM184+idmfySoMKHeTouqpGEjjOoGLk+P3vBkuNzLWU3p5xtRuaVvtkPYptFC09g7wm51P2WIoHF6leb68fQc/Om3BjM/FCvVBli7SXR7TNtwprwlm/rRQSdf/KVjL2Mv/dpY1fMt1bY1NEtmlyjb0OF29KX7nHgcC+InsQrj1q6376OEe1gSQg0hC1LsGc8RjEKdml+ctBArHZ4O3d/PoxkRaaHEL1++MY19NpBqGsrw==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [81.154.227.227]
X-OWM-Source-IP: 81.154.227.227 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduhedrkeekgdeihecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepleetffegveevjeehvefhtefgueevudettedutdffvdejkeeiteegheevfeejtdefnecukfhppeekuddrudehgedrvddvjedrvddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkedurdduheegrddvvdejrddvvdejpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequcfqtfevrffvpehrfhgtkedvvdenrhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (81.154.227.227) by re-prd-rgout-001.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5E3A147D0FC1C5F3; Sun, 10 May 2020 14:26:24 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH] selinux-testsuite: Add nftables to inet_socket and sctp tests
Date:   Sun, 10 May 2020 14:26:20 +0100
Message-Id: <20200510132620.39873-1-richard_c_haines@btinternet.com>
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
 README.md                        |  4 +-
 tests/inet_socket/nftables-flush |  2 +
 tests/inet_socket/nftables-load  | 74 ++++++++++++++++++++++++++++++++
 tests/inet_socket/test           | 72 +++++++++++++++++++++++++++++++
 tests/sctp/nftables-flush        |  2 +
 tests/sctp/nftables-load         | 68 +++++++++++++++++++++++++++++
 tests/sctp/test                  | 74 ++++++++++++++++++++++++++++++++
 7 files changed, 295 insertions(+), 1 deletion(-)
 create mode 100644 tests/inet_socket/nftables-flush
 create mode 100644 tests/inet_socket/nftables-load
 create mode 100644 tests/sctp/nftables-flush
 create mode 100644 tests/sctp/nftables-load

diff --git a/README.md b/README.md
index b36494e..392c073 100644
--- a/README.md
+++ b/README.md
@@ -55,6 +55,7 @@ similar dependencies):
 * keyutils-libs-devel _(tools used by the keys tests)_
 * kernel-devel _(used by the kernel module tests)_
 * quota, xfsprogs-devel and libuuid-devel _(used by the filesystem tests)_
+* nftables _(used by inet_socket and sctp tests if ver >= 9.3 for secmark testing )_
 
 On a modern Fedora system you can install these dependencies with the
 following command:
@@ -75,7 +76,8 @@ following command:
 		kernel-devel \
 		quota \
 		xfsprogs-devel \
-		libuuid-devel
+		libuuid-devel \
+		nftables
 
 The testsuite requires a pre-existing base policy configuration of SELinux,
 using either the old example policy or the reference policy as the baseline.
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
index 47ce106..b551961 100755
--- a/tests/inet_socket/test
+++ b/tests/inet_socket/test
@@ -27,6 +27,19 @@ BEGIN {
         $test_calipso_stream = 1;
     }
 
+    # Determine nftables version, must be >= 0.9.3 for secmark support
+    # with kernel >= 4.20
+    $test_nft = 0;
+    $nft      = `nft -v`;
+    $nft =~ s/\D//g;
+    $kverminstream = "4.20";
+
+    $rc = `$basedir/../kvercmp $kvercur $kverminstream`;
+    if ( $nft gt "092" and $rc > 0 ) {
+        $test_count += 8;
+        $test_nft = 1;
+    }
+
     plan tests => $test_count;
 }
 
@@ -406,6 +419,65 @@ server_end($pid);
 # Flush iptables configuration.
 system "/bin/sh $basedir/iptables-flush";
 
+# Load nftables (IPv4 & IPv6) configuration.
+if ($test_nft) {
+    system "nft -f $basedir/nftables-load";
+
+    # Start the stream server.
+    $pid = server_start( "-t test_inet_server_t", "-n stream 65535" );
+
+    # Verify that authorized client can communicate with the server.
+    $result = system
+"runcon -t test_inet_client_t -- $basedir/client -e nopeer stream 127.0.0.1 65535";
+    ok( $result eq 0 );
+
+    # Verify that unauthorized client cannot communicate with the server.
+    $result = system
+"runcon -t test_inet_bad_client_t -- $basedir/client -e nopeer stream 127.0.0.1 65535 2>&1";
+    ok( $result >> 8 eq 5 );
+
+    # Verify that authorized client can communicate with the server.
+    $result = system
+"runcon -t test_inet_client_t -- $basedir/client -e nopeer stream ::1 65535";
+    ok( $result eq 0 );
+
+    # Verify that unauthorized client cannot communicate with the server.
+    $result = system
+"runcon -t test_inet_bad_client_t -- $basedir/client -e nopeer stream ::1 65535 2>&1";
+    ok( $result >> 8 eq 5 );
+
+    # Kill the server.
+    server_end($pid);
+
+    # Start the dgram server.
+    $pid = server_start( "-t test_inet_server_t", "-n dgram 65535" );
+
+    # Verify that authorized client can communicate with the server.
+    $result = system
+"runcon -t test_inet_client_t $basedir/client -e nopeer dgram 127.0.0.1 65535";
+    ok( $result eq 0 );
+
+    # Verify that unauthorized client cannot communicate with the server.
+    $result = system
+"runcon -t test_inet_bad_client_t -- $basedir/client -e nopeer dgram 127.0.0.1 65535 2>&1";
+    ok( $result >> 8 eq 8 );
+
+    # Verify that authorized client can communicate with the server.
+    $result = system
+      "runcon -t test_inet_client_t $basedir/client -e nopeer dgram ::1 65535";
+    ok( $result eq 0 );
+
+    # Verify that unauthorized client cannot communicate with the server.
+    $result = system
+"runcon -t test_inet_bad_client_t -- $basedir/client -e nopeer dgram ::1 65535 2>&1";
+    ok( $result >> 8 eq 8 );
+
+    # Kill the server.
+    server_end($pid);
+
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
index 6631da4..afd28a1 100755
--- a/tests/sctp/test
+++ b/tests/sctp/test
@@ -56,6 +56,16 @@ BEGIN {
             $test_calipso = 1;
         }
 
+        # Determine nftables version, must be >= 0.9.3 for secmark support.
+        $test_nft = 0;
+        $nft      = `nft -v`;
+        $nft =~ s/\D//g;
+
+        if ( $nft gt "092" ) {
+            $test_count += 8;
+            $test_nft = 1;
+        }
+
         plan tests => $test_count;
     }
 }
@@ -809,4 +819,68 @@ server_end($pid);
 
 system "/bin/sh $basedir/iptables-flush";
 
+#
+##################### Test nftables configuration ############################
+#
+if ($test_nft) {
+    print "# Testing nftables (IPv4/IPv6).\n";
+    system "nft -f $basedir/nftables-load";
+
+    # Start the stream server.
+    $pid = server_start( "-t test_sctp_server_t",
+        "sctp_server", "$v -n stream 1035" );
+
+ # Verify that authorized client can communicate with the server STREAM->STREAM.
+    $result = system
+"runcon -t test_sctp_client_t $basedir/sctp_client $v -e nopeer stream 127.0.0.1 1035";
+    ok( $result eq 0 );
+
+# Verify that a client without peer { recv } permission cannot communicate with the server STREAM->STREAM.
+    $result = system
+"runcon -t test_sctp_deny_peer_client_t -- $basedir/sctp_client $v -e nopeer stream 127.0.0.1 1035 2>&1";
+    ok( $result >> 8 eq 6 );
+
+ # Verify that authorized client can communicate with the server STREAM->STREAM.
+    $result = system
+"runcon -t test_sctp_client_t $basedir/sctp_client $v -e nopeer stream ::1 1035";
+    ok( $result eq 0 );
+
+# Verify that a client without peer { recv } permission cannot communicate with the server STREAM->STREAM.
+    $result = system
+"runcon -t test_sctp_deny_peer_client_t -- $basedir/sctp_client $v -e nopeer stream ::1 1035 2>&1";
+    ok( $result >> 8 eq 6 );
+
+    # Kill the stream server.
+    server_end($pid);
+
+    # Start the seq server.
+    $pid =
+      server_start( "-t test_sctp_server_t", "sctp_server", "$v -n seq 1035" );
+
+    # Verify that authorized client can communicate with the server SEQ->SEQ.
+    $result = system
+"runcon -t test_sctp_client_t $basedir/sctp_client $v -e nopeer seq 127.0.0.1 1035";
+    ok( $result eq 0 );
+
+# Verify that a client without peer { recv } permission cannot communicate with the server SEQ->SEQ.
+    $result = system
+"runcon -t test_sctp_deny_peer_client_t -- $basedir/sctp_client $v -e nopeer seq 127.0.0.1 1035 2>&1";
+    ok( $result >> 8 eq 6 );
+
+    # Verify that authorized client can communicate with the server SEQ->SEQ.
+    $result = system
+"runcon -t test_sctp_client_t $basedir/sctp_client $v -e nopeer seq ::1 1035";
+    ok( $result eq 0 );
+
+# Verify that a client without peer { recv } permission cannot communicate with the server SEQ->SEQ.
+    $result = system
+"runcon -t test_sctp_deny_peer_client_t -- $basedir/sctp_client $v -e nopeer seq ::1 1035 2>&1";
+    ok( $result >> 8 eq 6 );
+
+    # Kill the seq server.
+    server_end($pid);
+
+    system "nft -f $basedir/nftables-flush";
+}
+
 exit;
-- 
2.25.3

