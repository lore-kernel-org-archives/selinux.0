Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v9JHX1L1029278
 for <selinux@tycho.nsa.gov>; Thu, 19 Oct 2017 13:33:01 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC05.oob.disa.mil (Postfix) with SMTP id 3yHvSx4DrNzrKb7
 for <selinux@tycho.nsa.gov>; Thu, 19 Oct 2017 16:26:41 +0000 (UTC)
Received: from UPBD19PA12.eemsg.mil (unknown [192.168.18.16])
 by UPDCF3IC05.oob.disa.mil (Postfix) with ESMTP id 3yHvSx347lzrKb4
 for <selinux@tycho.nsa.gov>; Thu, 19 Oct 2017 16:26:41 +0000 (UTC)
From: Richard Haines <richard_c_haines@btinternet.com>
To: selinux@tycho.nsa.gov
Date: Thu, 19 Oct 2017 16:57:47 +0100
Message-Id: <20171019155747.26673-1-richard_c_haines@btinternet.com>
Subject: [RFC PATCH 1/1] selinux-testsuite: Add CALIPSO/IPv6 tests
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Add CALIPSO tests to inet_socket.

Note the CALIPSO/IPv6 datagram tests check whether the kernel patch
described in "Add SCM_SECURITY support to IPv6" [1] is installed.

[1] https://github.com/SELinuxProject/selinux-kernel/issues/24

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 tests/inet_socket/Makefile      |   3 +
 tests/inet_socket/calipso-flush |   5 ++
 tests/inet_socket/calipso-load  |   7 +++
 tests/inet_socket/server.c      |  67 +++++++++++++++++------
 tests/inet_socket/test          | 118 ++++++++++++++++++++++++++++++++++++----
 5 files changed, 173 insertions(+), 27 deletions(-)
 create mode 100644 tests/inet_socket/calipso-flush
 create mode 100644 tests/inet_socket/calipso-load

diff --git a/tests/inet_socket/Makefile b/tests/inet_socket/Makefile
index 5bfd561..a0a0d47 100644
--- a/tests/inet_socket/Makefile
+++ b/tests/inet_socket/Makefile
@@ -3,5 +3,8 @@ TARGETS=client server bind connect
 LDLIBS+= -lselinux
 
 all: $(TARGETS)
+	chmod +x *-load
+	chmod +x *-flush
+
 clean:
 	rm -f $(TARGETS)
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
diff --git a/tests/inet_socket/server.c b/tests/inet_socket/server.c
index 2801397..f7e38c8 100644
--- a/tests/inet_socket/server.c
+++ b/tests/inet_socket/server.c
@@ -10,6 +10,9 @@
 #include <stdio.h>
 #include <stdbool.h>
 
+ /* Defines IPV6_PASSSEC if kernel supports IPV6 cmsg_type */
+#include <linux/in6.h>
+
 #ifndef SO_PEERSEC
 #define SO_PEERSEC 31
 #endif
@@ -79,11 +82,25 @@ int main(int argc, char **argv)
 		perror("socket");
 		exit(1);
 	}
-	result = setsockopt(sock, SOL_IP, IP_PASSSEC, &on, sizeof(on));
-	if (result < 0) {
-		perror("setsockopt: SO_PASSSEC");
-		close(sock);
-		exit(1);
+
+	/* Allow retrival of IPv4 and IPv6 UDP/Datagram security contexts */
+	if (hints.ai_socktype == SOCK_DGRAM) {
+		result = setsockopt(sock, SOL_IP, IP_PASSSEC, &on, sizeof(on));
+		if (result < 0) {
+			perror("setsockopt: IP_PASSSEC");
+			close(sock);
+			exit(1);
+		}
+
+#ifdef IPV6_PASSSEC
+		result = setsockopt(sock, SOL_IPV6, IPV6_PASSSEC, &on,
+				    sizeof(on));
+		if (result < 0) {
+			perror("setsockopt: IPV6_PASSSEC");
+			close(sock);
+			exit(1);
+		}
+#endif
 	}
 
 	result = setsockopt(sock, SOL_SOCKET, SO_REUSEADDR, &on, sizeof(on));
@@ -176,18 +193,34 @@ int main(int argc, char **argv)
 			}
 			if (nopeer) {
 				strcpy(msglabel, "nopeer");
-			}
-			for (cmsg = CMSG_FIRSTHDR(&msg); cmsg;
-			     cmsg = CMSG_NXTHDR(&msg, cmsg)) {
-				if (cmsg->cmsg_level == SOL_IP &&
-				    cmsg->cmsg_type == SCM_SECURITY) {
-					size_t len = cmsg->cmsg_len - CMSG_LEN(0);
-
-					if (len > 0 && len < sizeof(msglabel)) {
-						memcpy(msglabel, CMSG_DATA(cmsg), len);
-						msglabel[len] = 0;
-						printf("%s: Got SCM_SECURITY=%s\n",
-						       argv[0], msglabel);
+			} else {
+				for (cmsg = CMSG_FIRSTHDR(&msg); cmsg;
+				     cmsg = CMSG_NXTHDR(&msg, cmsg)) {
+#ifdef IPV6_PASSSEC
+					if ((cmsg->cmsg_level == SOL_IP &&
+					    cmsg->cmsg_type == SCM_SECURITY) ||
+					    (cmsg->cmsg_level == SOL_IPV6 &&
+					    cmsg->cmsg_type == IPV6_PASSSEC)) {
+#else
+					if (cmsg->cmsg_level == SOL_IP &&
+					    cmsg->cmsg_type == SCM_SECURITY) {
+#endif
+						size_t len = cmsg->cmsg_len - CMSG_LEN(0);
+
+						if (len > 0 && len < sizeof(msglabel)) {
+							memcpy(msglabel, CMSG_DATA(cmsg), len);
+							msglabel[len] = 0;
+#ifdef IPV6_PASSSEC
+							printf("%s: Got %s=%s\n",
+							       argv[0],
+							       cmsg->cmsg_type == SCM_SECURITY ?
+							       "SCM_SECURITY" : "IPV6_PASSSEC",
+							       msglabel);
+#else
+							printf("%s: Got SCM_SECURITY=%s\n",
+							       argv[0], msglabel);
+#endif
+						}
 					}
 				}
 			}
diff --git a/tests/inet_socket/test b/tests/inet_socket/test
index 81d0959..736e064 100755
--- a/tests/inet_socket/test
+++ b/tests/inet_socket/test
@@ -2,19 +2,53 @@
 use Test::More;
 
 BEGIN {
-    # check if ip xfrm supports ctx parameter
-    if ( system("ip xfrm policy help 2>&1 | grep -q ctx") != 0 ) {
-        plan skip_all => "ctx not supported in ip xfrm policy";
+    $basedir = $0;
+    $basedir =~ s|(.*)/[^/]*|$1|;
+
+    $test_count = 25;
+
+    $test_ipsec = 0;
+    if (system("ip xfrm policy help 2>&1 | grep -q ctx") != 0) {
+        print "ctx not supported in ip xfrm policy";
+    } else {
+        $test_count += 8;
+        $test_ipsec = 1;
     }
-    else {
-        plan tests => 33;
+
+    # Determine if CALIPSO supported by netlabelctl(8) and kernel.
+    $test_calipso_stream = 0;
+    $test_calipso_dgram = 0;
+    $netlabelctl = `netlabelctl -V`;
+    $netlabelctl =~ s/\D//g;
+    $kvercur = `uname -r`;
+    chomp($kvercur);
+    $kverminstream = "4.8";
+
+    $rc = `$basedir/../kvercmp $kvercur $kverminstream`;
+    if ($netlabelctl gt "021" and $rc > 0) {
+        $test_count += 4;
+        $test_calipso_stream = 1;
+
+        # Check if socket option IPV6_PASSSEC defined for datagram support
+        my $filename = '/usr/include/linux/in6.h';
+        $entry = 'IPV6_PASSSEC';
+        if (open(my $fh, '<:encoding(UTF-8)', $filename)) {
+            while (defined(my $row = <$fh>) and $test_calipso_dgram eq 0) {
+                chomp $row;
+                if ($row =~ /\b$entry\b/){
+	            $test_calipso_dgram = 1;
+                    $test_count += 4;
+                }
+            }
+        }
+    } else {
+        print "calipso not supported\n";
     }
-}
 
-$basedir = $0;
-$basedir =~ s|(.*)/[^/]*|$1|;
+    plan tests => $test_count;
+}
 
-# Load NetLabel configuration for full CIPSO4 labeling over loopback.
+# Load NetLabel configuration for full CIPSO/IPv4 labeling over loopback.
 system "$basedir/cipso-fl-load";
 
 # Start the stream server.
@@ -60,7 +94,7 @@ kill TERM, $pid;
 # Flush NetLabel configuration.
 system "$basedir/cipso-fl-flush";
 
-# Load NetLabel configuration for CIPSO4 over loopback.
+# Load NetLabel configuration for CIPSO/IPv4 over loopback.
 system "$basedir/cipso-load";
 
 # Start the stream server with a defined level.
@@ -293,4 +327,68 @@ kill TERM, $pid;
 # Flush iptables configuration.
 system "$basedir/iptables-flush";
 
+if ($test_calipso_stream) {
+    # Load NetLabel configuration for CALIPSO/IPv6 labeling over loopback.
+    system "$basedir/calipso-load";
+
+    # Start the stream server.
+    if (($pid = fork()) == 0) {
+        exec "runcon -t test_inet_server_t -l s0:c0.c10 $basedir/server stream 65535";
+    }
+
+    sleep 1; # Give it a moment to initialize.
+    # Verify that authorized client can communicate with the server.
+    $result = system "runcon -t test_inet_client_t -l s0:c0.c10 $basedir/client -e system_u:object_r:netlabel_peer_t:s0:c0.c10 stream ::1 65535";
+    ok($result eq 0);
+
+    # Verify that authorized client can communicate with the server using different valid level.
+    $result = system "runcon -t test_inet_client_t -l s0:c8.c10 $basedir/client -e  system_u:object_r:netlabel_peer_t:s0:c8.c10 stream ::1 65535";
+    ok($result eq 0);
+
+    # Verify that authorized client cannot communicate with the server using invalid level.
+    $result = system "runcon -t test_inet_client_t -l s0:c8.c12 -- $basedir/client stream ::1 65535 2>&1";
+    ok($result);
+
+    # CALIPSO does not support mixed DGRAM->STREAM.
+    $result = system "runcon -t test_inet_client_t -l s0:c8.c10 $basedir/client -e  system_u:object_r:netlabel_peer_t:s0:c8.c10 dgram ::1 65535 2>&1";
+    ok($result);
+
+    # Kill the stream server.
+    kill TERM, $pid;
+
+    system "$basedir/calipso-flush";
+}
+
+if ($test_calipso_dgram) {
+    system "$basedir/calipso-load";
+
+    # Start the dgram server.
+    if (($pid = fork()) == 0) {
+        exec "runcon -t test_inet_server_t -l s0:c20.c50 $basedir/server dgram 65535";
+    }
+
+    sleep 1; # Give it a moment to initialize
+
+    # Verify that authorized client can communicate with the server using same levels.
+    $result = system "runcon -t test_inet_client_t -l s0:c20.c50 $basedir/client -e system_u:object_r:netlabel_peer_t:s0:c20.c50 dgram ::1 65535";
+    ok($result eq 0);
+
+    # CALIPSO does not allow client to communicate with server using different valid levels.
+    $result = system "runcon -t test_inet_client_t -l s0:c22.c30 $basedir/client -e  system_u:object_r:netlabel_peer_t:s0:c22.c30 dgram ::1 65535 2>&1";
+    ok($result);
+
+    # Verify that authorized client cannot communicate with the server using invalid level.
+    $result = system "runcon -t test_inet_client_t -l s0:c40.c51 -- $basedir/client dgram ::1 65535 2>&1";
+    ok($result);
+
+    # CALIPSO does not support mixed STREAM->DGRAM.
+    $result = system "runcon -t test_inet_client_t -l s0:c20.c50 $basedir/client -e system_u:object_r:netlabel_peer_t:s0:c20.c50 stream ::1 65535 2>&1";
+    ok($result);
+
+    # Kill the dgram server.
+    kill TERM, $pid;
+
+    system "$basedir/calipso-flush";
+}
+
 exit;
-- 
2.13.6
