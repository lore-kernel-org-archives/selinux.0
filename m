Return-Path: <SRS0=r6Mn=CE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DD3C433DF
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 12:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B09C20707
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 12:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="jlf5Wfb/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729391AbgHZMl2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Aug 2020 08:41:28 -0400
Received: from mailomta3-re.btinternet.com ([213.120.69.96]:27026 "EHLO
        re-prd-fep-048.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729617AbgHZMlY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Aug 2020 08:41:24 -0400
Received: from re-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.54.5])
          by re-prd-fep-048.btinternet.com with ESMTP
          id <20200826124117.XBKT4701.re-prd-fep-048.btinternet.com@re-prd-rgout-002.btmx-prd.synchronoss.net>;
          Wed, 26 Aug 2020 13:41:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1598445677; 
        bh=XV70GJjxaERZp5oW+ZkNCIc0CZhqJ+LlI3PW/jLukQk=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=jlf5Wfb/Q8LVWvi1ZvT3RoZph5BleIrIzFfBkthhqU1IwHiNd55x5cCPs30wao1FZVpz7CVhNbinUIrLFUWq4AfYNYEw9DK9UATkXgX0PRYH6oxJMmhlooYNdeu4s+zWRus9NLk/VlJdNxEOkjSHnfsAlVGShYtIJ7dF5sIdl2v9IrIsrqv9RXUn6krOBsXhnp1TSje4WO/iznMKZNROzJMAomcfdDJTkXPMF0itNg8jwjWQOSBzbE/serITgeo+BvgXg8kgguxfNEXJenvVOkFwG3g7aupn6grl0Djr2I3bXej22ICCKylPTl/IHz7/v71iJrEyilONdh/6mTmEeg==
Authentication-Results: btinternet.com; none
X-Originating-IP: [86.155.83.250]
X-OWM-Source-IP: 86.155.83.250 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedruddvvddghedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpeeutddtleelheeugefgiefhiedtheeukeffveeitdffgeffieeugeeljeegvefgieenucfkphepkeeirdduheehrdekfedrvdehtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirdduheehrdekfedrvdehtddpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuqfftvefrvfeprhhftgekvddvnehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (86.155.83.250) by re-prd-rgout-002.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9C0CC0DAFBEB4; Wed, 26 Aug 2020 13:41:17 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [RFC V2 PATCH 2/2] selinux-testsuite: Run SCTP tests using remote server
Date:   Wed, 26 Aug 2020 13:40:54 +0100
Message-Id: <20200826124054.26302-3-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200826124054.26302-1-richard_c_haines@btinternet.com>
References: <20200826124054.26302-1-richard_c_haines@btinternet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This version updates the sctp tests to run their server components
on the remote system controlled by ncat(1).

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 policy/test_sctp.te                      |   3 +
 tests/sctp/calipso-load                  |   2 +-
 tests/sctp/{cipso-load-t1 => cipso-load} |   4 +-
 tests/sctp/cipso-load-t2                 |   7 -
 tests/sctp/cipso-load-t5                 |   7 -
 tests/sctp/start_remote_svr              |   4 +
 tests/sctp/stop_remote_svr               |   3 +
 tests/sctp/test                          | 706 +++++++++++++++++------
 8 files changed, 549 insertions(+), 187 deletions(-)
 rename tests/sctp/{cipso-load-t1 => cipso-load} (58%)
 delete mode 100644 tests/sctp/cipso-load-t2
 delete mode 100644 tests/sctp/cipso-load-t5
 create mode 100644 tests/sctp/start_remote_svr
 create mode 100644 tests/sctp/stop_remote_svr

diff --git a/policy/test_sctp.te b/policy/test_sctp.te
index 793f451..62dc5f2 100644
--- a/policy/test_sctp.te
+++ b/policy/test_sctp.te
@@ -4,6 +4,9 @@
 
 attribute sctpsocketdomain;
 
+# SCTP is a loadable module
+kernel_request_load_module(sctpsocketdomain)
+
 #
 ######################## NetLabel labels ############################
 #
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
diff --git a/tests/sctp/cipso-load-t1 b/tests/sctp/cipso-load
similarity index 58%
rename from tests/sctp/cipso-load-t1
rename to tests/sctp/cipso-load
index 6e9a161..9c43519 100644
--- a/tests/sctp/cipso-load-t1
+++ b/tests/sctp/cipso-load
@@ -1,7 +1,7 @@
 #!/bin/sh
 
-netlabelctl cipsov4 add pass doi:16 tags:1
+netlabelctl cipsov4 add pass doi:16 tags:$1
 netlabelctl map del default
 netlabelctl map add default address:0.0.0.0/0 protocol:unlbl
 netlabelctl map add default address:::/0 protocol:unlbl
-netlabelctl map add default address:127.0.0.1 protocol:cipsov4,16
+netlabelctl map add default address:$2 protocol:cipsov4,16
diff --git a/tests/sctp/cipso-load-t2 b/tests/sctp/cipso-load-t2
deleted file mode 100644
index 3227ba5..0000000
--- a/tests/sctp/cipso-load-t2
+++ /dev/null
@@ -1,7 +0,0 @@
-#!/bin/sh
-
-netlabelctl cipsov4 add pass doi:16 tags:2
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
diff --git a/tests/sctp/start_remote_svr b/tests/sctp/start_remote_svr
new file mode 100644
index 0000000..ab2536a
--- /dev/null
+++ b/tests/sctp/start_remote_svr
@@ -0,0 +1,4 @@
+#!/bin/sh
+
+# Redirect stdout for test $v option for log file
+$1 1>&2 &
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
index eede42f..c017bc3 100755
--- a/tests/sctp/test
+++ b/tests/sctp/test
@@ -81,8 +81,38 @@ BEGIN {
     plan tests => $test_count;
 }
 
+$s_basedir = "tests/sctp";
+$ncat_host = $ENV{'NCAT_HOST'};
+$ncat_port = $ENV{'NCAT_PORT'};
+if ( defined $ncat_host and defined $ncat_port ) {
+
+    # Remote tests can be followed using tshark(1):
+    #     tshark -O sctp,ipv6,ip,cipso,calipso -P -x -i any
+    print "Running remote servers on IP addr: $ncat_host\n";
+
+    # Get ipv4/6 addrs
+    $c_ipv4_1 = $ENV{'C_IPV4_1'};
+    $c_ipv6_1 = $ENV{'C_IPV6_1'};
+    $s_ipv4_1 = $ENV{'S_IPV4_1'};
+    $s_ipv6_1 = $ENV{'S_IPV6_1'};
+    $s_ipv6_2 = $ENV{'S_IPV6_2'};
+
+    $test_asconf_remote = 0;
+    if ( defined $s_ipv6_2 and $test_asconf ) {
+        $test_asconf_remote = 1;
+    }
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
-    my ( $runcon_args, $prog, $args ) = @_;
+    my ( $runcon_args, $prog, $args, $text ) = @_;
     my $pid;
 
     system("mkfifo $basedir/flag");
@@ -93,6 +123,7 @@ sub server_start {
 
     # Wait for it to initialize.
     system("read -t 5 <>$basedir/flag");
+    print "Started $text server\n";
     return $pid;
 }
 
@@ -104,6 +135,32 @@ sub server_end {
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
@@ -114,42 +171,62 @@ sub server_end {
 print "# Testing base configuration.\n";
 
 # Start the stream server.
-$pid =
-  server_start( "-t test_sctp_server_t", "sctp_server", "$v -n stream 1035" );
+if ( defined $ncat_host ) {
+    $pid = remote_server_start(
+        "-t test_sctp_server_t",
+        "sctp_server",
+        "$v -n stream 1035",
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
+"runcon -t test_sctp_client_t $basedir/sctp_client $v -e nopeer seq $s_ipv6_1 1035";
 ok( $result eq 0 );
 
 # Verify that the client cannot communicate with server when using port < 1024 STREAM->STREAM.
 # deny sctp_socket { name_connect }
 $result = system
-"runcon -t test_sctp_client_t -- $basedir/sctp_client $v -e nopeer stream ::1 1023 2>&1";
+"runcon -t test_sctp_client_t -- $basedir/sctp_client $v -e nopeer stream $s_ipv6_1 1023 2>&1";
 ok( $result >> 8 eq 8 );
 
 # Kill the stream server.
-server_end($pid);
+if ( defined $ncat_host ) {
+    remote_server_end($pid);
+}
+else {
+    server_end($pid);
+}
 
 # Verify that the server cannot start when using port < 1024.
 # deny sctp_socket { name_bind }
 $result =
-  system "runcon -t test_sctp_server_t -- $basedir/sctp_bind $v stream 80 2>&1";
+  system
+  "runcon -t test_sctp_server_t -- $basedir/sctp_bind $v stream 1023 2>&1";
 ok($result);
 
 #
@@ -226,41 +303,92 @@ ok( $result >> 8 eq 2 );
 #    net/sctp/socket.c sctp_setsockopt_peer_primary_addr(setsockopt(SCTP_PRIMARY_ADDR))
 # This requires the 'bind' permission, if not granted client exits with 51.
 #
+# The local tests use IPv4 addresses, the remote IPv6.
+#
 
 if ($test_asconf) {
 
     # To enable processing of ASCONF parameters SCTP_PARAM_SET_PRIMARY
     # and SCTP_PARAM_ADD_IP need to set:
+    if ( defined $ncat_host and $test_asconf_remote ) {
+        `echo "echo 1 > /proc/sys/net/sctp/addip_enable" | $ncat`;
+        `echo "echo 1 > /proc/sys/net/sctp/addip_noauth_enable" | $ncat`;
+    }
     system("echo 1 > /proc/sys/net/sctp/addip_enable");
     system("echo 1 > /proc/sys/net/sctp/addip_noauth_enable");
 
     print "Testing Dynamic Address Reconfiguration\n";
 
     # Server should automatically exit after each test
-    $pid = server_start(
-        "-t sctp_asconf_params_server_t",
-        "sctp_asconf_params_server",
-        "$v $ipaddress[0] $ipaddress[1] 1035"
-    );
+    if ( defined $ncat_host and $test_asconf_remote ) {
+        $pid = remote_server_start(
+            "-t sctp_asconf_params_server_t",
+            "sctp_asconf_params_server",
+            "$v $s_ipv6_1 $s_ipv6_2 1035",
+            "remote asconf params chunk processing - seq"
+        );
+    }
+    else {
+        $pid = server_start(
+            "-t sctp_asconf_params_server_t",
+            "sctp_asconf_params_server",
+            "$v $ipaddress[0] $ipaddress[1] 1035",
+            "local asconf params chunk processing - seq"
+        );
+    }
 
-    $result = system
+    if ( defined $ncat_host and $test_asconf_remote ) {
+        $result = system
+"runcon -t sctp_asconf_params_client_t $basedir/sctp_asconf_params_client $v $s_ipv6_1 1035";
+    }
+    else {
+        $result = system
 "runcon -t sctp_asconf_params_client_t $basedir/sctp_asconf_params_client $v $ipaddress[0] 1035";
+    }
     ok( $result eq 0 );
 
-    server_end($pid);
+    if ( defined $ncat_host and $test_asconf_remote ) {
+        remote_server_end($pid);
+    }
+    else {
+        server_end($pid);
+    }
 
-    $pid = server_start(
-        "-t sctp_asconf_params_server_t",
-        "sctp_asconf_params_server",
-        "$v $ipaddress[0] $ipaddress[1] 1035"
-    );
+    # The SCTP_PRIMARY_ADDR denial can be tested local or remote
+    if ( defined $ncat_host and $test_asconf_remote ) {
+        $pid = remote_server_start(
+            "-t sctp_asconf_params_server_t",
+            "sctp_asconf_params_server",
+            "$v $s_ipv6_1 $s_ipv6_2 1035",
+            "remote asconf params chunk processing - seq"
+        );
+    }
+    else {
+        $pid = server_start(
+            "-t sctp_asconf_params_server_t",
+            "sctp_asconf_params_server",
+            "$v $ipaddress[0] $ipaddress[1] 1035",
+            "local asconf params chunk processing - seq"
+        );
+    }
 
-    print "Testing deny SCTP_PRIMARY_ADDR\n";
-    $result = system
+    print "Testing deny setting SCTP_PRIMARY_ADDR\n";
+    if ( defined $ncat_host and $test_asconf_remote ) {
+        $result = system
+"runcon -t sctp_asconf_deny_pri_addr_client_t $basedir/sctp_asconf_params_client $v $s_ipv6_1 1035 2>&1";
+    }
+    else {
+        $result = system
 "runcon -t sctp_asconf_deny_pri_addr_client_t $basedir/sctp_asconf_params_client $v $ipaddress[0] 1035 2>&1";
+    }
     ok( $result >> 8 eq 51 );    # setsockopt(2) failed
 
-    server_end($pid);
+    if ( defined $ncat_host and $test_asconf_remote ) {
+        remote_server_end($pid);
+    }
+    else {
+        server_end($pid);
+    }
 
     #
     # This is a local only test as it's the neverallow rule that stops:
@@ -271,7 +399,8 @@ if ($test_asconf) {
     $pid = server_start(
         "-t sctp_asconf_params_server_t",
         "sctp_asconf_params_server",
-        "$v $ipaddress[0] $ipaddress[1] 1035"
+        "$v $ipaddress[0] $ipaddress[1] 1035",
+        "local asconf params chunk processing - seq"
     );
 
     print "Testing deny SCTP_PARAM_ADD_IP/SCTP_PARAM_SET_PRIMARY\n";
@@ -281,6 +410,10 @@ if ($test_asconf) {
 
     server_end($pid);
 
+    if ( defined $ncat_host and $test_asconf_remote ) {
+        `echo "echo 0 > /proc/sys/net/sctp/addip_enable" | $ncat`;
+        `echo "echo 0 > /proc/sys/net/sctp/addip_noauth_enable" | $ncat`;
+    }
     system("echo 0 > /proc/sys/net/sctp/addip_enable");
     system("echo 0 > /proc/sys/net/sctp/addip_noauth_enable");
 }
@@ -296,7 +429,12 @@ print "# Testing NetLabel fallback peer labeling.\n";
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
@@ -317,7 +455,12 @@ ok( $result >> 8 eq 6 );
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
@@ -356,7 +499,12 @@ system "/bin/sh $basedir/fb-label-flush";
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
@@ -378,324 +526,480 @@ system "/bin/sh $basedir/fb-deny-label-flush";
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
+        "$v -4 -i stream 1035",
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
-# Fails with mlsconstrain peer { recv }
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
+        "$v -4 -i seq 1035",
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
+        "$v -4 -i 1035",
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
+        "$v -4 -i stream 1035",
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
+        "$v -4 -i seq 1035",
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
+        "$v -4 -i 1035",
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
+        "$v -4 -i stream 1035",
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
+        "$v -4 -i seq 1035",
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
+        "$v -4 -i 1035",
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
@@ -711,7 +1015,12 @@ ok( $result >> 8 eq 6 );
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
@@ -735,116 +1044,169 @@ system "/bin/sh $basedir/cipso-fl-flush";
 
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
+            "$v -i stream 1035",
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
+"runcon -t test_sctp_client_t -l s0:c0,c12,c24,c36,c28,c610,c712,c414,c516,c318,c820,c622,c924,c726,c128,c330,c832,c534,c936,c138,c740,c42,c44,c246,c648,c950,c152,c354,c856,c158,c960,c662,c634,c686,c368,c570,c782,c714,c769,c788,c803,c842,c864,c986,c788,c290,c392,c594,c896,c698,c1023  $basedir/sctp_client $v -x -i stream $s_ipv6_1 1035";
     ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server STREAM->STREAM with client using connect(2).
     $result = system
-"runcon -t test_sctp_client_t -l s0:c0,c12,c24,c36,c28,c610,c712,c414,c516,c318,c820,c622,c924,c726,c128,c330,c832,c534,c936,c138,c740,c42,c44,c246,c648,c950,c152,c354,c856,c158,c960,c662,c634,c686,c368,c570,c782,c714,c769,c788,c803,c842,c864,c986,c788,c290,c392,c594,c896,c698,c1023  $basedir/sctp_client $v -i stream ::1 1035";
+"runcon -t test_sctp_client_t -l s0:c0,c12,c24,c36,c28,c610,c712,c414,c516,c318,c820,c622,c924,c726,c128,c330,c832,c534,c936,c138,c740,c42,c44,c246,c648,c950,c152,c354,c856,c158,c960,c662,c634,c686,c368,c570,c782,c714,c769,c788,c803,c842,c864,c986,c788,c290,c392,c594,c896,c698,c1023  $basedir/sctp_client $v -i stream $s_ipv6_1 1035";
     ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server using different valid level STREAM->STREAM.
     $result = system
-"runcon -t test_sctp_client_t -l s0:c924,c726,c128,c330,c832,c534,c936,c138,c740,c42 $basedir/sctp_client $v -i stream ::1 1035";
+"runcon -t test_sctp_client_t -l s0:c924,c726,c128,c330,c832,c534,c936,c138,c740,c42 $basedir/sctp_client $v -i stream $s_ipv6_1 1035";
     ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server using different valid level SEQ->STREAM
     $result = system
-"runcon -t test_sctp_client_t -l s0:c924,c726,c128,c330,c832,c534,c936,c138,c740,c42 $basedir/sctp_client $v -i seq ::1 1035";
+"runcon -t test_sctp_client_t -l s0:c924,c726,c128,c330,c832,c534,c936,c138,c740,c42 $basedir/sctp_client $v -i seq $s_ipv6_1 1035";
     ok( $result eq 0 );
 
 # Verify that authorized client cannot communicate with the server using invalid level STREAM->STREAM.
     $result = system
-"runcon -t test_sctp_client_t -l s0:c8.c12 -- $basedir/sctp_client $v -i stream ::1 1035 2>&1";
+"runcon -t test_sctp_client_t -l s0:c8.c12 -- $basedir/sctp_client $v -i stream $s_ipv6_1 1035 2>&1";
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
+            "$v -i seq 1035",
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
+"runcon -t test_sctp_client_t -l s0:c28.c48 $basedir/sctp_client $v -i seq $s_ipv6_1 1035";
     ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server using STREAM->SEQ.
     $result = system
-"runcon -t test_sctp_client_t -l s0:c20.c50 $basedir/sctp_client $v -i stream ::1 1035";
+"runcon -t test_sctp_client_t -l s0:c20.c50 $basedir/sctp_client $v -i stream $s_ipv6_1 1035";
     ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server using SEQ->SEQ with diff valid level.
     $result = system
-"runcon -t test_sctp_client_t -l s0:c20.c30,c31,c35,c40.c45 $basedir/sctp_client $v -i seq ::1 1035";
+"runcon -t test_sctp_client_t -l s0:c20.c30,c31,c35,c40.c45 $basedir/sctp_client $v -i seq $s_ipv6_1 1035";
     ok( $result eq 0 );
 
 # Verify that client cannot communicate with the server using SEQ->SEQ with invalid level.
     $result = system
-"runcon -t test_sctp_client_t -l s0:c20.c51 $basedir/sctp_client $v -i seq ::1 1035 2>&1";
+"runcon -t test_sctp_client_t -l s0:c20.c51 $basedir/sctp_client $v -i seq $s_ipv6_1 1035 2>&1";
     ok( $result >> 8 eq 6 );
 
 # Verify that client cannot communicate with the server using SEQ->SEQ with invalid level.
     $result = system
-"runcon -t test_sctp_client_t -l s0:c19.c50 -- $basedir/sctp_client $v -i seq ::1 1035 2>&1";
+"runcon -t test_sctp_client_t -l s0:c19.c50 -- $basedir/sctp_client $v -i seq $s_ipv6_1 1035 2>&1";
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
+            "$v -i 1035",
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
+"runcon -t test_sctp_client_t -l s0:c0.c10 $basedir/sctp_client $v -i seq $s_ipv6_1 1035";
     ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server using STREAM->SEQ->peeloff with same level.
     $result = system
-"runcon -t test_sctp_client_t -l s0:c0.c10 $basedir/sctp_client $v -x -i stream ::1 1035";
+"runcon -t test_sctp_client_t -l s0:c0.c10 $basedir/sctp_client $v -x -i stream $s_ipv6_1 1035";
     ok( $result eq 0 );
 
 # Verify that client cannot communicate with the server using STREAM->SEQ->peeloff with invalid level.
     $result = system
-"runcon -t test_sctp_client_t -l s0:c0.c11 -- $basedir/sctp_client $v -x -i stream ::1 1035 2>&1";
+"runcon -t test_sctp_client_t -l s0:c0.c11 -- $basedir/sctp_client $v -x -i stream $s_ipv6_1 1035 2>&1";
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
-################## Test iptables/nftables configuration ######################
+########## Test iptables/nftables configuration - local only ###############
 #
 sub test_tables {
 
     # Start the stream server.
-    $pid = server_start( "-t test_sctp_server_t",
-        "sctp_server", "$v -n stream 1035" );
+    $pid = server_start(
+        "-t test_sctp_server_t",
+        "sctp_server",
+        "$v -n stream 1035",
+        "local nf/iptables - stream"
+    );
 
  # Verify that authorized client can communicate with the server STREAM->STREAM.
     $result = system
@@ -870,8 +1232,12 @@ sub test_tables {
     server_end($pid);
 
     # Start the seq server.
-    $pid =
-      server_start( "-t test_sctp_server_t", "sctp_server", "$v -n seq 1035" );
+    $pid = server_start(
+        "-t test_sctp_server_t",
+        "sctp_server",
+        "$v -n seq 1035",
+        "local nf/iptables - seq"
+    );
 
     # Verify that authorized client can communicate with the server SEQ->SEQ.
     $result = system
-- 
2.26.2

