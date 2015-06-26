From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH] selinux-testsuite: add secmark tests
Date: Fri, 26 Jun 2015 08:51:58 -0400
Message-Id: <1435323118-25548-1-git-send-email-sds@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Add tests for SECMARK.  To support this, we add a -n option to
the client and server test programs to disable the testing of
SO_PEERSEC and SCM_SECURITY since SECMARK does not provide peer
labeling, only internal packet labeling.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 README                           | 11 +++++++---
 policy/test_inet_socket.te       |  9 ++++++++
 tests/inet_socket/client.c       | 42 +++++++++++++++++++++++++++++---------
 tests/inet_socket/iptables-flush |  4 ++++
 tests/inet_socket/iptables-load  | 29 ++++++++++++++++++++++++++
 tests/inet_socket/server.c       | 44 +++++++++++++++++++++++++++++-----------
 tests/inet_socket/test           | 44 +++++++++++++++++++++++++++++++++++++++-
 7 files changed, 157 insertions(+), 26 deletions(-)
 create mode 100755 tests/inet_socket/iptables-flush
 create mode 100755 tests/inet_socket/iptables-load

diff --git a/README b/README
index 6d54fcc..568ebb8 100644
--- a/README
+++ b/README
@@ -21,6 +21,10 @@ CONFIG_SECURITY_NETWORK=y
 CONFIG_SECURITY_NETWORK_XFRM=y
 CONFIG_SECURITY_SELINUX=y
 CONFIG_NETLABEL=y
+CONFIG_NETWORK_SECMARK=y
+CONFIG_NF_CONNTRACK_SECMARK=y
+CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
+CONFIG_NETFILTER_XT_TARGET_SECMARK=m
 
 # Filesystem security labeling support.
 # Only need to enable the ones for the filesystems on which you are testing.
@@ -70,9 +74,10 @@ rely upon the SELinux extensions being integrated into the coreutils
 package, with support for the chcon and runcon commands as well as the
 SELinux options to existing utilities such as ls and mkdir.
 
-The inet_socket tests depend on netlabel_tools being installed in
-order to load NetLabel configuration, and on ipsec-tools being installed
-in order to load labeled IPSEC configuration.
+The inet_socket tests depend on netlabel_tools, ipsec-tools, and
+iptables in order to load the relevant configurations for testing
+netlabel peer labeling, labeled IPSEC peer labeling, and SECMARK
+packet labeling.
 
 In addition to the libselinux shared library, the libselinux headers
 are required in order to build certain testcases.  These can be found in 
diff --git a/policy/test_inet_socket.te b/policy/test_inet_socket.te
index 25b4f34..9a35c99 100644
--- a/policy/test_inet_socket.te
+++ b/policy/test_inet_socket.te
@@ -139,6 +139,15 @@ allow test_inet_client_t test_spd_t:association polmatch;
 allow test_inet_bad_client_t test_spd_t:association polmatch;
 
 #
+# SECMARK-specific policy
+#
+
+type test_server_packet_t;
+allow unconfined_t test_server_packet_t:packet relabelto;
+allow test_inet_server_t test_server_packet_t:packet { send recv };
+allow test_inet_client_t test_server_packet_t:packet { send recv };
+
+#
 # Common rules for all inet socket test domains.
 #
 
diff --git a/tests/inet_socket/client.c b/tests/inet_socket/client.c
index bb721c5..cf274cf 100644
--- a/tests/inet_socket/client.c
+++ b/tests/inet_socket/client.c
@@ -12,12 +12,13 @@
 #include <fcntl.h>
 #include <errno.h>
 #include <poll.h>
+#include <stdbool.h>
 #include <selinux/selinux.h>
 
 void usage(char *progname)
 {
 	fprintf(stderr,
-		"usage:  %s [stream|dgram] port\n",
+		"usage:  %s [-n] [stream|dgram] port\n",
 		progname);
 	exit(1);
 }
@@ -34,18 +35,30 @@ main(int argc, char **argv)
 	char *mycon;
 	unsigned short port;
 	struct timeval tm;
+	int opt;
+	bool nopeer = false;
+
+	while ((opt = getopt(argc, argv, "n")) != -1) {
+		switch (opt) {
+		case 'n':
+			nopeer = true;
+			break;
+		default:
+			usage(argv[0]);
+		}
+	}
 
-	if (argc != 3)
+	if ((argc - optind) != 2)
 		usage(argv[0]);
 
-	if (!strcmp(argv[1], "stream"))
+	if (!strcmp(argv[optind], "stream"))
 		type = SOCK_STREAM;
-	else if (!strcmp(argv[1], "dgram"))
+	else if (!strcmp(argv[optind], "dgram"))
 		type = SOCK_DGRAM;
 	else
 		usage(argv[0]);
 
-	port = atoi(argv[2]);
+	port = atoi(argv[optind + 1]);
 	if (!port)
 		usage(argv[0]);
 
@@ -112,11 +125,20 @@ main(int argc, char **argv)
 	}
 	label[result] = 0;
 
-	result = getcon(&mycon);
-	if (result < 0) {
-		perror("getcon");
-		close(sock);
-		exit(1);
+	if (nopeer) {
+		mycon = strdup("nopeer");
+		if (!mycon) {
+			perror("strdup");
+			close(sock);
+			exit(1);
+		}
+	} else {
+		result = getcon(&mycon);
+		if (result < 0) {
+			perror("getcon");
+			close(sock);
+			exit(1);
+		}
 	}
 
 	if (strcmp(mycon, label)) {
diff --git a/tests/inet_socket/iptables-flush b/tests/inet_socket/iptables-flush
new file mode 100755
index 0000000..8371648
--- /dev/null
+++ b/tests/inet_socket/iptables-flush
@@ -0,0 +1,4 @@
+#!/bin/sh
+# Flush the security table.
+iptables -t security -F
+iptables -t security -X NEWCONN
diff --git a/tests/inet_socket/iptables-load b/tests/inet_socket/iptables-load
new file mode 100755
index 0000000..c55e427
--- /dev/null
+++ b/tests/inet_socket/iptables-load
@@ -0,0 +1,29 @@
+#!/bin/sh
+# Based on http://james-morris.livejournal.com/11010.html.
+#
+# Modifications:
+# - Changed to use the security table, which was created for SECMARK to
+#   avoid conflicts with other users of the mangle table.
+# - Added entries for udp traffic for testing udp as well.
+# - Specified the interface since the tests are only performed over loopback.
+# - Set the port number and context to the values used by the test script and policy.
+
+# Flush the security table.
+iptables -t security -F
+
+# Create a chain for new connection marking.
+iptables -t security -N NEWCONN
+
+# Accept incoming connections, label SYN packets, and copy labels to connections.
+iptables -t security -A INPUT -i lo -p tcp --dport 65535 -m state --state NEW -j NEWCONN
+iptables -t security -A NEWCONN -j SECMARK --selctx system_u:object_r:test_server_packet_t:s0
+iptables -t security -A NEWCONN -j CONNSECMARK --save
+iptables -t security -A NEWCONN -j ACCEPT
+
+# Common rules which copy connection labels to established and related packets.
+iptables -t security -A INPUT -m state --state ESTABLISHED,RELATED -j CONNSECMARK --restore
+iptables -t security -A OUTPUT -m state --state ESTABLISHED,RELATED -j CONNSECMARK --restore
+
+# Label UDP packets similarly.
+iptables -t security -A INPUT -i lo -p udp --dport 65535 -j SECMARK --selctx system_u:object_r:test_server_packet_t:s0
+iptables -t security -A OUTPUT -o lo -p udp --sport 65535 -j SECMARK --selctx system_u:object_r:test_server_packet_t:s0
diff --git a/tests/inet_socket/server.c b/tests/inet_socket/server.c
index 630d988..a53e346 100644
--- a/tests/inet_socket/server.c
+++ b/tests/inet_socket/server.c
@@ -6,6 +6,7 @@
 #include <string.h>
 #include <unistd.h>
 #include <stdio.h>
+#include <stdbool.h>
 
 #ifndef SO_PEERSEC
 #define SO_PEERSEC 31
@@ -17,7 +18,7 @@
 
 void usage(char *progname)
 {
-	fprintf(stderr, "usage:  %s [stream|dgram] port\n", progname);
+	fprintf(stderr, "usage:  %s [-n] [stream|dgram] port\n", progname);
 	exit(1);
 }
 
@@ -33,18 +34,30 @@ main(int argc, char **argv)
 	int type;
 	char byte;
 	unsigned short port;
+	int opt;
+	bool nopeer = false;
+
+	while ((opt = getopt(argc, argv, "n")) != -1) {
+		switch (opt) {
+		case 'n':
+			nopeer = true;
+			break;
+		default:
+			usage(argv[0]);
+		}
+	}
 
-	if (argc != 3)
+	if ((argc - optind) != 2)
 		usage(argv[0]);
 
-	if (!strcmp(argv[1], "stream"))
+	if (!strcmp(argv[optind], "stream"))
 		type = SOCK_STREAM;
-	else if (!strcmp(argv[1], "dgram"))
+	else if (!strcmp(argv[optind], "dgram"))
 		type = SOCK_DGRAM;
 	else
 		usage(argv[0]);
 
-	port = atoi(argv[2]);
+	port = atoi(argv[optind + 1]);
 	if (!port)
 		usage(argv[0]);
 
@@ -100,14 +113,18 @@ main(int argc, char **argv)
 				exit(1);
 			}
 
-			peerlabel[0] = 0;
-			result = getsockopt(newsock, SOL_SOCKET, SO_PEERSEC, peerlabel,
-					    &labellen);
-			if (result < 0) {
-				perror("getsockopt: SO_PEERSEC");
-				exit(1);
+			if (nopeer) {
+				strcpy(peerlabel, "nopeer");
+			} else {
+				peerlabel[0] = 0;
+				result = getsockopt(newsock, SOL_SOCKET, SO_PEERSEC, peerlabel,
+						    &labellen);
+				if (result < 0) {
+					perror("getsockopt: SO_PEERSEC");
+					exit(1);
+				}
+				printf("%s:  Got peer label=%s\n", argv[0], peerlabel);
 			}
-			printf("%s:  Got peer label=%s\n", argv[0], peerlabel);
 
 			result = read(newsock, &byte, 1);
 			if (result < 0) {
@@ -149,6 +166,9 @@ main(int argc, char **argv)
 				perror("recvmsg");
 				exit(1);
 			}
+			if (nopeer) {
+				strcpy(msglabel, "nopeer");
+			}
 			for (cmsg = CMSG_FIRSTHDR(&msg); cmsg;
 			     cmsg = CMSG_NXTHDR(&msg, cmsg)) {
 				if (cmsg->cmsg_level == SOL_IP &&
diff --git a/tests/inet_socket/test b/tests/inet_socket/test
index f5f71a1..4652a97 100755
--- a/tests/inet_socket/test
+++ b/tests/inet_socket/test
@@ -1,7 +1,7 @@
 #!/usr/bin/perl
 
 use Test;
-BEGIN { plan tests => 16}
+BEGIN { plan tests => 20}
 
 $basedir = $0;  $basedir =~ s|(.*)/[^/]*|$1|;
 
@@ -121,4 +121,46 @@ kill TERM, $pid;
 # Flush IPSEC configuration.
 system "$basedir/ipsec-flush";
 
+# Load iptables configuration.
+system "$basedir/iptables-load";
+
+# Start the stream server.
+if (($pid = fork()) == 0) {
+    exec "runcon -t test_inet_server_t -- $basedir/server -n stream 65535";
+}
+
+sleep 1; # Give it a moment to initialize.
+
+# Verify that authorized client can communicate with the server.
+$result = system "runcon -t test_inet_client_t -- $basedir/client -n stream 65535";
+ok($result, 0);
+
+# Verify that unauthorized client cannot communicate with the server.
+$result = system "runcon -t test_inet_bad_client_t -- $basedir/client -n stream 65535 2>&1";
+ok($result);
+
+# Kill the server.
+kill TERM, $pid;
+
+# Start the dgram server.
+if (($pid = fork()) == 0) {
+    exec "runcon -t test_inet_server_t $basedir/server -n dgram 65535";
+}
+
+sleep 1; # Give it a moment to initialize
+
+# Verify that authorized client can communicate with the server.
+$result = system "runcon -t test_inet_client_t $basedir/client -n dgram 65535";
+ok($result, 0);
+
+# Verify that unauthorized client cannot communicate with the server.
+$result = system "runcon -t test_inet_bad_client_t -- $basedir/client -n dgram 65535 2>&1";
+ok($result);
+
+# Kill the server.
+kill TERM, $pid;
+
+# Flush iptables configuration.
+system "$basedir/iptables-flush";
+
 exit;
-- 
2.1.0
