Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w3DAEZwr020488
 for <selinux@tycho.nsa.gov>; Fri, 13 Apr 2018 06:14:36 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC12.oob.disa.mil (Postfix) with SMTP id 40MttG2rwsz1pFV5
 for <selinux@tycho.nsa.gov>; Fri, 13 Apr 2018 10:14:30 +0000 (UTC)
Received: from UPBD19PA03.eemsg.mil (unknown [192.168.18.4])
 by UPDCF3IC12.oob.disa.mil (Postfix) with ESMTP id 40MttG0VMfz1pFTd
 for <selinux@tycho.nsa.gov>; Fri, 13 Apr 2018 10:14:30 +0000 (UTC)
From: Richard Haines <richard_c_haines@btinternet.com>
To: selinux@tycho.nsa.gov
Date: Fri, 13 Apr 2018 11:13:15 +0100
Message-Id: <20180413101315.21749-1-richard_c_haines@btinternet.com>
Subject: [PATCH] selinux-testsuite: Enhance inet_socket tests
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Enhance the tests as follows:
1) Determine number of tests to run with current config.
2) Add CALIPSO STREAM tests (DGRAM not supported in kernel. See [1]).
3) Add support for CIPSO TAGS 1 & 2. Closes [2].
4) Run scripts using /bin/sh.
5) Shorten sleep time as more tests.

[1] https://github.com/SELinuxProject/selinux-kernel/issues/24
[2] https://github.com/SELinuxProject/selinux-testsuite/issues/1

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 tests/inet_socket/calipso-flush                 |   5 +
 tests/inet_socket/calipso-load                  |   7 +
 tests/inet_socket/cipso-fl-flush                |   0
 tests/inet_socket/cipso-fl-load                 |   0
 tests/inet_socket/cipso-flush                   |   0
 tests/inet_socket/cipso-load-t1                 |  11 +
 tests/inet_socket/cipso-load-t2                 |  11 +
 tests/inet_socket/{cipso-load => cipso-load-t5} |   0
 tests/inet_socket/ipsec-flush                   |   0
 tests/inet_socket/ipsec-load                    |   0
 tests/inet_socket/iptables-flush                |   0
 tests/inet_socket/iptables-load                 |   0
 tests/inet_socket/server.c                      |  16 +-
 tests/inet_socket/test                          | 348 ++++++++++++++++++------
 14 files changed, 310 insertions(+), 88 deletions(-)
 create mode 100644 tests/inet_socket/calipso-flush
 create mode 100644 tests/inet_socket/calipso-load
 mode change 100755 => 100644 tests/inet_socket/cipso-fl-flush
 mode change 100755 => 100644 tests/inet_socket/cipso-fl-load
 mode change 100755 => 100644 tests/inet_socket/cipso-flush
 create mode 100644 tests/inet_socket/cipso-load-t1
 create mode 100644 tests/inet_socket/cipso-load-t2
 rename tests/inet_socket/{cipso-load => cipso-load-t5} (100%)
 mode change 100755 => 100644
 mode change 100755 => 100644 tests/inet_socket/ipsec-flush
 mode change 100755 => 100644 tests/inet_socket/ipsec-load
 mode change 100755 => 100644 tests/inet_socket/iptables-flush
 mode change 100755 => 100644 tests/inet_socket/iptables-load
 mode change 100755 => 100644 tests/inet_socket/test

diff --git a/tests/inet_socket/calipso-flush b/tests/inet_socket/calipso-flush
new file mode 100644
index 0000000..5143962
--- /dev/null
+++ b/tests/inet_socket/calipso-flush
@@ -0,0 +1,5 @@
+#!/bin/sh
+# Reset NetLabel configuration to unlabeled after CALIPSO/IPv6 tests.
+netlabelctl map del default
+netlabelctl calipso del doi:16
+netlabelctl map add default protocol:unlbl
diff --git a/tests/inet_socket/calipso-load b/tests/inet_socket/calipso-load
new file mode 100644
index 0000000..4bb9c7f
--- /dev/null
+++ b/tests/inet_socket/calipso-load
@@ -0,0 +1,7 @@
+#!/bin/sh
+# Define a doi for testing loopback for CALIPSO/IPv6.
+netlabelctl calipso add pass doi:16
+netlabelctl map del default
+netlabelctl map add default address:0.0.0.0/0 protocol:unlbl
+netlabelctl map add default address:::/0 protocol:unlbl
+netlabelctl map add default address:::1 protocol:calipso,16
diff --git a/tests/inet_socket/cipso-fl-flush b/tests/inet_socket/cipso-fl-flush
old mode 100755
new mode 100644
diff --git a/tests/inet_socket/cipso-fl-load b/tests/inet_socket/cipso-fl-load
old mode 100755
new mode 100644
diff --git a/tests/inet_socket/cipso-flush b/tests/inet_socket/cipso-flush
old mode 100755
new mode 100644
diff --git a/tests/inet_socket/cipso-load-t1 b/tests/inet_socket/cipso-load-t1
new file mode 100644
index 0000000..974e746
--- /dev/null
+++ b/tests/inet_socket/cipso-load-t1
@@ -0,0 +1,11 @@
+#!/bin/sh
+# Based on http://paulmoore.livejournal.com/7234.html.
+#
+# Modifications:
+# - Defined a doi for testing loopback for CIPSOv4.
+
+netlabelctl cipsov4 add pass doi:16 tags:1
+netlabelctl map del default
+netlabelctl map add default address:0.0.0.0/0 protocol:unlbl
+netlabelctl map add default address:::/0 protocol:unlbl
+netlabelctl map add default address:127.0.0.1 protocol:cipsov4,16
diff --git a/tests/inet_socket/cipso-load-t2 b/tests/inet_socket/cipso-load-t2
new file mode 100644
index 0000000..9892f81
--- /dev/null
+++ b/tests/inet_socket/cipso-load-t2
@@ -0,0 +1,11 @@
+#!/bin/sh
+# Based on http://paulmoore.livejournal.com/7234.html.
+#
+# Modifications:
+# - Defined a doi for testing loopback for CIPSOv4.
+
+netlabelctl cipsov4 add pass doi:16 tags:2
+netlabelctl map del default
+netlabelctl map add default address:0.0.0.0/0 protocol:unlbl
+netlabelctl map add default address:::/0 protocol:unlbl
+netlabelctl map add default address:127.0.0.1 protocol:cipsov4,16
diff --git a/tests/inet_socket/cipso-load b/tests/inet_socket/cipso-load-t5
old mode 100755
new mode 100644
similarity index 100%
rename from tests/inet_socket/cipso-load
rename to tests/inet_socket/cipso-load-t5
diff --git a/tests/inet_socket/ipsec-flush b/tests/inet_socket/ipsec-flush
old mode 100755
new mode 100644
diff --git a/tests/inet_socket/ipsec-load b/tests/inet_socket/ipsec-load
old mode 100755
new mode 100644
diff --git a/tests/inet_socket/iptables-flush b/tests/inet_socket/iptables-flush
old mode 100755
new mode 100644
diff --git a/tests/inet_socket/iptables-load b/tests/inet_socket/iptables-load
old mode 100755
new mode 100644
diff --git a/tests/inet_socket/server.c b/tests/inet_socket/server.c
index 2801397..c8383b4 100644
--- a/tests/inet_socket/server.c
+++ b/tests/inet_socket/server.c
@@ -79,11 +79,17 @@ int main(int argc, char **argv)
 		perror("socket");
 		exit(1);
 	}
-	result = setsockopt(sock, SOL_IP, IP_PASSSEC, &on, sizeof(on));
-	if (result < 0) {
-		perror("setsockopt: SO_PASSSEC");
-		close(sock);
-		exit(1);
+
+	/* Allow retrieval of UDP/Datagram security contexts for IPv4 as
+	 * IPv6 is not currently supported.
+	 */
+	if (hints.ai_socktype == SOCK_DGRAM) {
+		result = setsockopt(sock, SOL_IP, IP_PASSSEC, &on, sizeof(on));
+		if (result < 0) {
+			perror("setsockopt: IP_PASSSEC");
+			close(sock);
+			exit(1);
+		}
 	}
 
 	result = setsockopt(sock, SOL_SOCKET, SO_REUSEADDR, &on, sizeof(on));
diff --git a/tests/inet_socket/test b/tests/inet_socket/test
old mode 100755
new mode 100644
index 0bda2a4..6684260
--- a/tests/inet_socket/test
+++ b/tests/inet_socket/test
@@ -2,27 +2,43 @@
 use Test::More;
 
 BEGIN {
-    # check if ip xfrm supports ctx parameter
-    if ( system("ip xfrm policy help 2>&1 | grep -q ctx") != 0 ) {
-        plan skip_all => "ctx not supported in ip xfrm policy";
+    $basedir = $0;
+    $basedir =~ s|(.*)/[^/]*|$1|;
+
+    $test_count = 38;
+
+    $test_ipsec = 0;
+    if ( system("ip xfrm policy help 2>&1 | grep -q ctx") eq 0 ) {
+        $test_count += 8;
+        $test_ipsec = 1;
     }
-    else {
-        plan tests => 33;
+
+    # Determine if CALIPSO supported by netlabelctl(8) and kernel.
+    $test_calipso_stream = 0;
+    $netlabelctl         = `netlabelctl -V`;
+    $netlabelctl =~ s/\D//g;
+    $kvercur = `uname -r`;
+    chomp($kvercur);
+    $kverminstream = "4.8";
+
+    $rc = `$basedir/../kvercmp $kvercur $kverminstream`;
+    if ( $netlabelctl gt "021" and $rc > 0 ) {
+        $test_count += 3;
+        $test_calipso_stream = 1;
     }
-}
 
-$basedir = $0;
-$basedir =~ s|(.*)/[^/]*|$1|;
+    plan tests => $test_count;
+}
 
-# Load NetLabel configuration for full CIPSO4 labeling over loopback.
-system "$basedir/cipso-fl-load";
+# Load NetLabel configuration for full CIPSO/IPv4 labeling over loopback.
+system "/bin/sh $basedir/cipso-fl-load";
 
 # Start the stream server.
 if ( ( $pid = fork() ) == 0 ) {
     exec "runcon -t test_inet_server_t $basedir/server stream 65535";
 }
 
-sleep 1;    # Give it a moment to initialize.
+select( undef, undef, undef, 0.25 );    # Give it a moment to initialize.
 
 # Verify that authorized client can communicate with the server.
 $result =
@@ -42,7 +58,7 @@ if ( ( $pid = fork() ) == 0 ) {
     exec "runcon -t test_inet_server_t $basedir/server dgram 65535";
 }
 
-sleep 1;    # Give it a moment to initialize
+select( undef, undef, undef, 0.25 );    # Give it a moment to initialize
 
 # Verify that authorized client can communicate with the server.
 $result =
@@ -58,32 +74,90 @@ ok( $result >> 8 eq 9 );
 kill TERM, $pid;
 
 # Flush NetLabel configuration.
-system "$basedir/cipso-fl-flush";
+system "/bin/sh $basedir/cipso-fl-flush";
+
+# Load NetLabel configuration for CIPSO/IPv4 using TAG 1 over loopback.
+system "/bin/sh $basedir/cipso-load-t1";
+
+# Start the stream server with a defined level.
+if ( ( $pid = fork() ) == 0 ) {
+    exec
+"runcon -t test_inet_server_t -l s0:c20.c250 $basedir/server stream 65535";
+}
+
+select( undef, undef, undef, 0.25 );    # Give it a moment to initialize.
+
+# Verify that authorized client can communicate with the server using level within T1 range.
+$result = system
+"runcon -t test_inet_client_t -l s0:c61.c239 $basedir/client -e system_u:object_r:netlabel_peer_t:s0:c61.c239 stream 127.0.0.1 65535";
+ok( $result eq 0 );
+
+# Verify that authorized client cannot communicate with the server using different level.
+$result = system
+"runcon -t test_inet_client_t -l s0:c19,c120 $basedir/client stream 127.0.0.1 65535 2>&1";
+ok( $result >> 8 eq 5 );
+
+# TAG 1 allows categories 0 to 239 to be sent, if greater then ENOSPC (No space left on device)
+$result = system
+"runcon -t test_inet_client_t -l s0:c0.c240 $basedir/client stream 127.0.0.1 65535 2>&1";
+ok( $result >> 8 eq 5 );
+
+# Kill the server.
+kill TERM, $pid;
+
+# Start the dgram server with a defined level.
+if ( ( $pid = fork() ) == 0 ) {
+    exec
+      "runcon -t test_inet_server_t -l s0:c20.c50 $basedir/server dgram 65535";
+}
+
+select( undef, undef, undef, 0.25 );    # Give it a moment to initialize.
+
+# Verify that authorized client can communicate with the server using same levels.
+$result = system
+"runcon -t test_inet_client_t -l s0:c20.c50 $basedir/client -e system_u:object_r:netlabel_peer_t:s0:c20.c50 dgram 127.0.0.1 65535";
+ok( $result eq 0 );
+
+# Verify that authorized client cannot communicate with the server using levels dominating the server.
+$result = system
+"runcon -t test_inet_client_t -l s0:c40.c51 $basedir/client dgram 127.0.0.1 65535 2>&1";
+ok( $result >> 8 eq 9 );
+
+# Kill the server.
+kill TERM, $pid;
+
+# Flush NetLabel configuration.
+system "/bin/sh $basedir/cipso-flush";
 
-# Load NetLabel configuration for CIPSO4 over loopback.
-system "$basedir/cipso-load";
+# Load NetLabel configuration for CIPSO/IPv4 using TAG 2 over loopback.
+system "/bin/sh $basedir/cipso-load-t2";
 
 # Start the stream server with a defined level.
 if ( ( $pid = fork() ) == 0 ) {
     exec
-      "runcon -t test_inet_server_t -l s0:c0.c10 $basedir/server stream 65535";
+      "runcon -t test_inet_server_t -l s0:c0.c100 $basedir/server stream 65535";
 }
 
-sleep 1;    # Give it a moment to initialize.
+select( undef, undef, undef, 0.25 );    # Give it a moment to initialize.
 
 # Verify that authorized client can communicate with the server using level.
 $result = system
-"runcon -t test_inet_client_t -l s0:c0.c10 $basedir/client -e system_u:object_r:netlabel_peer_t:s0:c0.c10 stream 127.0.0.1 65535";
+"runcon -t test_inet_client_t -l s0:c90.c100 $basedir/client -e system_u:object_r:netlabel_peer_t:s0:c90.c100 stream 127.0.0.1 65535";
 ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server using level.
 $result = system
-"runcon -t test_inet_client_t -l s0:c8.c10 $basedir/client -e system_u:object_r:netlabel_peer_t:s0:c8.c10 stream 127.0.0.1 65535";
+"runcon -t test_inet_client_t -l s0:c0.c14 $basedir/client -e system_u:object_r:netlabel_peer_t:s0:c0.c14 stream 127.0.0.1 65535";
 ok( $result eq 0 );
 
 # Verify that authorized client cannot communicate with the server using different level.
 $result = system
-"runcon -t test_inet_client_t -l s0:c8.c12 $basedir/client stream 127.0.0.1 65535 2>&1";
+"runcon -t test_inet_client_t -l s0:c101 $basedir/client stream 127.0.0.1 65535 2>&1";
+ok( $result >> 8 eq 5 );
+
+# TAG 2 allows a maximum of 15 categories in exchange, if greater then ENOSPC (No space left on device)
+$result = system
+"runcon -t test_inet_client_t -l s0:c0.c16 -- $basedir/client dgram 127.0.0.1 65535 2>&1";
 ok( $result >> 8 eq 5 );
 
 # Kill the server.
@@ -92,26 +166,95 @@ kill TERM, $pid;
 # Start the dgram server with a defined level.
 if ( ( $pid = fork() ) == 0 ) {
     exec
-      "runcon -t test_inet_server_t -l s0:c20.c50 $basedir/server dgram 65535";
+      "runcon -t test_inet_server_t -l s0:c0.c14 $basedir/server dgram 65535";
 }
 
-sleep 1;    # Give it a moment to initialize.
+select( undef, undef, undef, 0.25 );    # Give it a moment to initialize.
 
 # Verify that authorized client can communicate with the server using same levels.
 $result = system
-"runcon -t test_inet_client_t -l s0:c20.c50 $basedir/client -e system_u:object_r:netlabel_peer_t:s0:c20.c50 dgram 127.0.0.1 65535";
+"runcon -t test_inet_client_t -l s0:c0.c14 $basedir/client -e system_u:object_r:netlabel_peer_t:s0:c0.c14 dgram 127.0.0.1 65535";
 ok( $result eq 0 );
 
 # Verify that authorized client cannot communicate with the server using levels dominating the server.
 $result = system
-"runcon -t test_inet_client_t -l s0:c40.c51 $basedir/client dgram 127.0.0.1 65535 2>&1";
+"runcon -t test_inet_client_t -l s0:c15 $basedir/client dgram 127.0.0.1 65535 2>&1";
 ok( $result >> 8 eq 9 );
 
 # Kill the server.
 kill TERM, $pid;
 
 # Flush NetLabel configuration.
-system "$basedir/cipso-flush";
+system "/bin/sh $basedir/cipso-flush";
+
+# Load NetLabel configuration for CIPSO/IPv4 using TAG 5 over loopback.
+# TAG 5 allows a maximum of 7 ranges in exchange, if greater then ENOSPC (No space left on device), however
+# note from kernel net/ipv4/cipso_ipv4.c comments:
+# * You may note that the IETF draft states that the maximum number
+# * of category ranges is 7, but if the low end of the last category range is
+# * zero then it is possible to fit 8 category ranges because the zero should
+# * be omitted. */
+system "/bin/sh $basedir/cipso-load-t5";
+
+# Start the stream server with a defined level.
+if ( ( $pid = fork() ) == 0 ) {
+    exec
+      "runcon -t test_inet_server_t -l s0:c0.c100 $basedir/server stream 65535";
+}
+
+select( undef, undef, undef, 0.25 );    # Give it a moment to initialize.
+
+# Verify that authorized client can communicate with the server using level.
+$result = system
+"runcon -t test_inet_client_t -l s0:c0.c100 $basedir/client -e system_u:object_r:netlabel_peer_t:s0:c0.c100 stream 127.0.0.1 65535";
+ok( $result eq 0 );
+
+# Verify that authorized client can communicate with the server using level.
+$result = system
+"runcon -t test_inet_client_t -l s0:c8.c100 $basedir/client -e system_u:object_r:netlabel_peer_t:s0:c8.c100 stream 127.0.0.1 65535";
+ok( $result eq 0 );
+
+# Verify that authorized client cannot communicate with the server using different level.
+$result = system
+"runcon -t test_inet_client_t -l s0:c8.c101 $basedir/client stream 127.0.0.1 65535 2>&1";
+ok( $result >> 8 eq 5 );
+
+# Verify ok with the 8 entries when cat c0:
+$result = system
+"runcon -t test_inet_client_t -l s0:c0.c3,c20.c25,c30.c36,c40.c45,c50.c55,c60.c66,c70.c78,c80.c88 $basedir/client -e system_u:object_r:netlabel_peer_t:s0:c0.c3,c20.c25,c30.c36,c40.c45,c50.c55,c60.c66,c70.c78,c80.c88 stream 127.0.0.1 65535";
+ok( $result eq 0 );
+
+# Verify fail with the 8 entries when cat !c0:
+$result = system
+"runcon -t test_inet_client_t -l s0:c20.c25,c30.c36,c40.c45,c50.c55,c60.c66,c70.c78,c80.c88,c90.c99 $basedir/client stream 127.0.0.1 65535 2>&1";
+ok( $result >> 8 eq 5 );
+
+# Kill the server.
+kill TERM, $pid;
+
+# Start the dgram server with a defined level.
+if ( ( $pid = fork() ) == 0 ) {
+    exec
+      "runcon -t test_inet_server_t -l s0:c0.c100 $basedir/server dgram 65535";
+}
+
+select( undef, undef, undef, 0.25 );    # Give it a moment to initialize.
+
+# Verify that authorized client can communicate with the server using same levels.
+$result = system
+"runcon -t test_inet_client_t -l s0:c0.c100 $basedir/client -e system_u:object_r:netlabel_peer_t:s0:c0.c100 dgram 127.0.0.1 65535";
+ok( $result eq 0 );
+
+# Verify that authorized client cannot communicate with the server using levels dominating the server.
+$result = system
+"runcon -t test_inet_client_t -l s0:c40.c101 $basedir/client dgram 127.0.0.1 65535 2>&1";
+ok( $result >> 8 eq 9 );
+
+# Kill the server.
+kill TERM, $pid;
+
+# Flush NetLabel configuration.
+system "/bin/sh $basedir/cipso-flush";
 
 # Verify that authorized domain can bind UDP sockets.
 $result = system "runcon -t test_inet_bind_t -- $basedir/bind dgram 65535 2>&1";
@@ -151,91 +294,96 @@ $result =
   system "runcon -t test_inet_no_name_connect_t -- $basedir/connect 65535 2>&1";
 ok($result);
 
-# Load IPSEC configuration.
-system "$basedir/ipsec-load";
+if ($test_ipsec) {
 
-# Start the stream server.
-if ( ( $pid = fork() ) == 0 ) {
-    exec "runcon -t test_inet_server_t $basedir/server stream 65535";
-}
+    # Load IPSEC configuration.
+    system "/bin/sh $basedir/ipsec-load";
 
-sleep 1;    # Give it a moment to initialize.
+    # Start the stream server.
+    if ( ( $pid = fork() ) == 0 ) {
+        exec "runcon -t test_inet_server_t $basedir/server stream 65535";
+    }
 
-# Verify that authorized client can communicate with the server.
-$result =
-  system "runcon -t test_inet_client_t $basedir/client stream 127.0.0.1 65535";
-ok( $result eq 0 );
+    select( undef, undef, undef, 0.25 );    # Give it a moment to initialize.
 
-# Verify that unauthorized client cannot communicate with the server.
-$result = system
+    # Verify that authorized client can communicate with the server.
+    $result =
+      system
+      "runcon -t test_inet_client_t $basedir/client stream 127.0.0.1 65535";
+    ok( $result eq 0 );
+
+    # Verify that unauthorized client cannot communicate with the server.
+    $result = system
 "runcon -t test_inet_bad_client_t -- $basedir/client stream 127.0.0.1 65535 2>&1";
-ok( $result >> 8 eq 5 );
+    ok( $result >> 8 eq 5 );
 
-# Verify that authorized client can communicate with the server.
-$result =
-  system "runcon -t test_inet_client_t $basedir/client stream ::1 65535";
-ok( $result eq 0 );
+    # Verify that authorized client can communicate with the server.
+    $result =
+      system "runcon -t test_inet_client_t $basedir/client stream ::1 65535";
+    ok( $result eq 0 );
 
-# Verify that unauthorized client cannot communicate with the server.
-$result = system
-  "runcon -t test_inet_bad_client_t -- $basedir/client stream ::1 65535 2>&1";
-ok( $result >> 8 eq 5 );
+    # Verify that unauthorized client cannot communicate with the server.
+    $result = system
+"runcon -t test_inet_bad_client_t -- $basedir/client stream ::1 65535 2>&1";
+    ok( $result >> 8 eq 5 );
 
-# Kill the server.
-kill TERM, $pid;
+    # Kill the server.
+    kill TERM, $pid;
 
-# Start the dgram server.
-if ( ( $pid = fork() ) == 0 ) {
-    exec "runcon -t test_inet_server_t $basedir/server dgram 65535";
-}
+    # Start the dgram server.
+    if ( ( $pid = fork() ) == 0 ) {
+        exec "runcon -t test_inet_server_t $basedir/server dgram 65535";
+    }
 
-sleep 1;    # Give it a moment to initialize
+    select( undef, undef, undef, 0.25 );    # Give it a moment to initialize
 
-# Verify that authorized client can communicate with the server.
-$result =
-  system "runcon -t test_inet_client_t $basedir/client dgram 127.0.0.1 65535";
-ok( $result eq 0 );
+    # Verify that authorized client can communicate with the server.
+    $result =
+      system
+      "runcon -t test_inet_client_t $basedir/client dgram 127.0.0.1 65535";
+    ok( $result eq 0 );
 
-# Verify that unauthorized client cannot communicate with the server.
-$result = system
+    # Verify that unauthorized client cannot communicate with the server.
+    $result = system
 "runcon -t test_inet_bad_client_t -- $basedir/client dgram 127.0.0.1 65535 2>&1";
-ok( $result >> 8 eq 8 );
+    ok( $result >> 8 eq 8 );
 
-# Verify that unauthorized client cannot communicate with the server.
-$result = system
-  "runcon -t test_inet_bad_client_t -- $basedir/client dgram ::1 65535 2>&1";
-ok( $result >> 8 eq 8 );
+    # Verify that unauthorized client cannot communicate with the server.
+    $result = system
+"runcon -t test_inet_bad_client_t -- $basedir/client dgram ::1 65535 2>&1";
+    ok( $result >> 8 eq 8 );
 
-# Kill the server.
-kill TERM, $pid;
+    # Kill the server.
+    kill TERM, $pid;
 
 # Start the dgram server for IPSEC test using IPv6 but do not request peer context.
-if ( ( $pid = fork() ) == 0 ) {
-    exec "runcon -t test_inet_server_t $basedir/server -n dgram 65535";
-}
+    if ( ( $pid = fork() ) == 0 ) {
+        exec "runcon -t test_inet_server_t $basedir/server -n dgram 65535";
+    }
 
-sleep 1;    # Give it a moment to initialize
+    select( undef, undef, undef, 0.25 );    # Give it a moment to initialize
 
-# This test now passes.
-$result = system
-  "runcon -t test_inet_client_t $basedir/client -e nopeer dgram ::1 65535";
-ok( $result eq 0 );
+    # This test now passes.
+    $result = system
+      "runcon -t test_inet_client_t $basedir/client -e nopeer dgram ::1 65535";
+    ok( $result eq 0 );
 
-# Kill the server.
-kill TERM, $pid;
+    # Kill the server.
+    kill TERM, $pid;
 
-# Flush IPSEC configuration.
-system "$basedir/ipsec-flush";
+    # Flush IPSEC configuration.
+    system "/bin/sh $basedir/ipsec-flush";
+}
 
 # Load iptables (IPv4 & IPv6) configuration.
-system "$basedir/iptables-load";
+system "/bin/sh $basedir/iptables-load";
 
 # Start the stream server.
 if ( ( $pid = fork() ) == 0 ) {
     exec "runcon -t test_inet_server_t -- $basedir/server -n stream 65535";
 }
 
-sleep 1;    # Give it a moment to initialize.
+select( undef, undef, undef, 0.25 );    # Give it a moment to initialize.
 
 # Verify that authorized client can communicate with the server.
 $result = system
@@ -265,7 +413,7 @@ if ( ( $pid = fork() ) == 0 ) {
     exec "runcon -t test_inet_server_t $basedir/server -n dgram 65535";
 }
 
-sleep 1;    # Give it a moment to initialize
+select( undef, undef, undef, 0.25 );    # Give it a moment to initialize
 
 # Verify that authorized client can communicate with the server.
 $result = system
@@ -291,6 +439,40 @@ ok( $result >> 8 eq 8 );
 kill TERM, $pid;
 
 # Flush iptables configuration.
-system "$basedir/iptables-flush";
+system "/bin/sh $basedir/iptables-flush";
+
+if ($test_calipso_stream) {
+
+    # Load NetLabel configuration for CALIPSO/IPv6 labeling over loopback.
+    system "/bin/sh $basedir/calipso-load";
+
+    # Start the stream server.
+    if ( ( $pid = fork() ) == 0 ) {
+        exec
+"runcon -t test_inet_server_t -l s0:c0.c10 $basedir/server stream 65535";
+    }
+
+    select( undef, undef, undef, 0.25 );    # Give it a moment to initialize.
+
+    # Verify that authorized client can communicate with the server.
+    $result = system
+"runcon -t test_inet_client_t -l s0:c0.c10 $basedir/client -e system_u:object_r:netlabel_peer_t:s0:c0.c10 stream ::1 65535";
+    ok( $result eq 0 );
+
+# Verify that authorized client can communicate with the server using different valid level.
+    $result = system
+"runcon -t test_inet_client_t -l s0:c8.c10 $basedir/client -e  system_u:object_r:netlabel_peer_t:s0:c8.c10 stream ::1 65535";
+    ok( $result eq 0 );
+
+# Verify that authorized client cannot communicate with the server using invalid level.
+    $result = system
+"runcon -t test_inet_client_t -l s0:c8.c12 -- $basedir/client stream ::1 65535 2>&1";
+    ok( $result >> 8 eq 5 );
+
+    # Kill the stream server.
+    kill TERM, $pid;
+
+    system "/bin/sh $basedir/calipso-flush";
+}
 
 exit;
-- 
2.14.3
