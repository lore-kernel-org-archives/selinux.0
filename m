Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uB5GEJAa014898
 for <selinux@tycho.nsa.gov>; Mon, 5 Dec 2016 11:14:19 -0500
From: Richard Haines <richard_c_haines@btinternet.com>
To: selinux@tycho.nsa.gov
Subject: [RFC PATCH 1/1] selinux-testsuite: Add IPv6 client/server support
 plus tests
Date: Mon,  5 Dec 2016 16:14:03 +0000
Message-Id: <20161205161403.9253-1-richard_c_haines@btinternet.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Split the Netlabel tests into two, one for full labeling and the
other for plain CIPSO4.

Added comments to tests where required to explain pass/fail as
there is no support for retrieving UDP peer labels on IPv6 stack.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 README                                             |   1 +
 .../inet_socket/{netlabel-flush => cipso-fl-flush} |   0
 tests/inet_socket/{netlabel-load => cipso-fl-load} |   2 +-
 tests/inet_socket/cipso-flush                      |   5 +
 tests/inet_socket/cipso-load                       |  11 ++
 tests/inet_socket/client.c                         |  91 +++++++-------
 tests/inet_socket/ipsec-load                       |   6 +
 tests/inet_socket/iptables-flush                   |   2 +
 tests/inet_socket/iptables-load                    |  20 +++
 tests/inet_socket/server.c                         |  67 +++++-----
 tests/inet_socket/test                             | 140 ++++++++++++++++++---
 11 files changed, 251 insertions(+), 94 deletions(-)
 rename tests/inet_socket/{netlabel-flush => cipso-fl-flush} (100%)
 rename tests/inet_socket/{netlabel-load => cipso-fl-load} (89%)
 create mode 100755 tests/inet_socket/cipso-flush
 create mode 100755 tests/inet_socket/cipso-load

diff --git a/README b/README
index 69b4839..8dbbbda 100644
--- a/README
+++ b/README
@@ -16,6 +16,7 @@ test SELinux:
 CONFIG_AUDIT=y
 CONFIG_NET=y
 CONFIG_INET=y
+CONFIG_IPV6=y
 CONFIG_SECURITY=y
 CONFIG_SECURITY_NETWORK=y
 CONFIG_SECURITY_NETWORK_XFRM=y
diff --git a/tests/inet_socket/netlabel-flush b/tests/inet_socket/cipso-fl-flush
similarity index 100%
rename from tests/inet_socket/netlabel-flush
rename to tests/inet_socket/cipso-fl-flush
diff --git a/tests/inet_socket/netlabel-load b/tests/inet_socket/cipso-fl-load
similarity index 89%
rename from tests/inet_socket/netlabel-load
rename to tests/inet_socket/cipso-fl-load
index 35898d3..3fbc928 100755
--- a/tests/inet_socket/netlabel-load
+++ b/tests/inet_socket/cipso-fl-load
@@ -7,7 +7,7 @@
 #   CIPSOv4 only supports passing MLS labels across the network).
 
 # Define a localhost/loopback doi and apply it to the loopback address
-# so that we get full SELinux labels over loopback connections.
+# so that we get full SELinux labels over IPv4 loopback connections.
 netlabelctl cipsov4 add local doi:1
 netlabelctl map del default
 netlabelctl map add default address:0.0.0.0/0 protocol:unlbl
diff --git a/tests/inet_socket/cipso-flush b/tests/inet_socket/cipso-flush
new file mode 100755
index 0000000..2ac8523
--- /dev/null
+++ b/tests/inet_socket/cipso-flush
@@ -0,0 +1,5 @@
+#!/bin/sh
+# Reset NetLabel configuration to unlabeled for all.
+netlabelctl map del default
+netlabelctl cipsov4 del doi:16
+netlabelctl map add default protocol:unlbl
diff --git a/tests/inet_socket/cipso-load b/tests/inet_socket/cipso-load
new file mode 100755
index 0000000..662747d
--- /dev/null
+++ b/tests/inet_socket/cipso-load
@@ -0,0 +1,11 @@
+#!/bin/sh
+# Based on http://paulmoore.livejournal.com/7234.html.
+#
+# Modifications:
+# - Defined a doi for testing loopback for CIPSOv4.
+
+netlabelctl cipsov4 add pass doi:16 tags:5
+netlabelctl map del default
+netlabelctl map add default address:0.0.0.0/0 protocol:unlbl
+netlabelctl map add default address:::/0 protocol:unlbl
+netlabelctl map add default address:127.0.0.1 protocol:cipsov4,16
diff --git a/tests/inet_socket/client.c b/tests/inet_socket/client.c
index cf274cf..f104b0d 100644
--- a/tests/inet_socket/client.c
+++ b/tests/inet_socket/client.c
@@ -2,6 +2,7 @@
 #include <sys/time.h>
 #include <sys/socket.h>
 #include <netinet/in.h>
+#include <netdb.h>
 #include <arpa/inet.h>
 #include <sys/un.h>
 #include <stdlib.h>
@@ -18,51 +19,62 @@
 void usage(char *progname)
 {
 	fprintf(stderr,
-		"usage:  %s [-n] [stream|dgram] port\n",
-		progname);
+		"usage:  %s [-e expected_msg] [stream|dgram] addr port\n"
+		"\nWhere:\n\t"
+		"-e      Optional expected message from server e.g. \"nopeer\".\n\t"
+		"        If not present the client context will be used as a\n\t"
+		"        comparison with the servers the reply.\n\t"
+		"stream  Use TCP protocol or:\n\t"
+		"dgram   use UDP protocol.\n\t"
+		"addr    IPv4 or IPv6 address (e.g. 127.0.0.1 or ::1)\n\t"
+		"port    Port for accessing server.\n", progname);
 	exit(1);
 }
 
-int
-main(int argc, char **argv)
+int main(int argc, char **argv)
 {
-	char byte, label[256];
-	int sock;
-	int result;
-	struct sockaddr_in sin;
-	socklen_t sinlen;
-	int type;
-	char *mycon;
+	char byte, label[256], *expected = NULL;
+	int sock, result, opt;
+	struct addrinfo hints, *serverinfo;
 	unsigned short port;
 	struct timeval tm;
-	int opt;
-	bool nopeer = false;
 
-	while ((opt = getopt(argc, argv, "n")) != -1) {
+	while ((opt = getopt(argc, argv, "e:")) != -1) {
 		switch (opt) {
-		case 'n':
-			nopeer = true;
+		case 'e':
+			expected = optarg;
 			break;
 		default:
 			usage(argv[0]);
 		}
 	}
 
-	if ((argc - optind) != 2)
+	if ((argc - optind) != 3)
 		usage(argv[0]);
 
-	if (!strcmp(argv[optind], "stream"))
-		type = SOCK_STREAM;
-	else if (!strcmp(argv[optind], "dgram"))
-		type = SOCK_DGRAM;
-	else
+	memset(&hints, 0, sizeof(struct addrinfo));
+
+	if (!strcmp(argv[optind], "stream")) {
+		hints.ai_socktype = SOCK_STREAM;
+		hints.ai_protocol = IPPROTO_TCP;
+	} else if (!strcmp(argv[optind], "dgram")) {
+		hints.ai_socktype = SOCK_DGRAM;
+		hints.ai_protocol = IPPROTO_UDP;
+	} else {
 		usage(argv[0]);
+	}
 
-	port = atoi(argv[optind + 1]);
+	port = atoi(argv[optind + 2]);
 	if (!port)
 		usage(argv[0]);
 
-	sock = socket(AF_INET, type, 0);
+	result = getaddrinfo(argv[optind + 1], argv[optind + 2], &hints, &serverinfo);
+	if (result < 0) {
+		fprintf(stderr, "getaddrinfo: %s\n", gai_strerror(result));
+		exit(1);
+	}
+
+	sock = socket(serverinfo->ai_family, serverinfo->ai_socktype, serverinfo->ai_protocol);
 	if (sock < 0) {
 		perror("socket");
 		exit(1);
@@ -70,23 +82,13 @@ main(int argc, char **argv)
 
 	tm.tv_sec = 5;
 	tm.tv_usec = 0;
-	result = setsockopt(sock, SOL_SOCKET, SO_SNDTIMEO, &tm, sizeof tm);
+	result = setsockopt(sock, SOL_SOCKET, SO_SNDTIMEO, &tm, sizeof(tm));
 	if (result < 0) {
 		perror("setsockopt: SO_SNDTIMEO");
 		exit(1);
 	}
 
-	bzero(&sin, sizeof(struct sockaddr_in));
-	sin.sin_family = AF_INET;
-	sin.sin_port = htons(port);
-	if (inet_aton("127.0.0.1", &sin.sin_addr) == 0) {
-		fprintf(stderr, "%s: inet_ntoa: invalid address\n", argv[0]);
-		close(sock);
-		exit(1);
-	}
-
-	sinlen = sizeof(sin);
-	result = connect(sock, (struct sockaddr *) &sin, sinlen);
+	result = connect(sock, serverinfo->ai_addr, serverinfo->ai_addrlen);
 	if (result < 0) {
 		perror("connect");
 		close(sock);
@@ -101,7 +103,7 @@ main(int argc, char **argv)
 		exit(1);
 	}
 
-	if (type == SOCK_DGRAM) {
+	if (hints.ai_socktype == SOCK_DGRAM) {
 		struct pollfd fds;
 
 		fds.fd = sock;
@@ -125,15 +127,8 @@ main(int argc, char **argv)
 	}
 	label[result] = 0;
 
-	if (nopeer) {
-		mycon = strdup("nopeer");
-		if (!mycon) {
-			perror("strdup");
-			close(sock);
-			exit(1);
-		}
-	} else {
-		result = getcon(&mycon);
+	if (!expected) {
+		result = getcon(&expected);
 		if (result < 0) {
 			perror("getcon");
 			close(sock);
@@ -141,9 +136,9 @@ main(int argc, char **argv)
 		}
 	}
 
-	if (strcmp(mycon, label)) {
+	if (strcmp(expected, label)) {
 		fprintf(stderr, "%s:  expected %s, got %s\n",
-			argv[0], mycon, label);
+			argv[0], expected, label);
 		exit(1);
 	}
 
diff --git a/tests/inet_socket/ipsec-load b/tests/inet_socket/ipsec-load
index c72d4b9..21e2dfe 100755
--- a/tests/inet_socket/ipsec-load
+++ b/tests/inet_socket/ipsec-load
@@ -9,3 +9,9 @@ ip xfrm state add src 127.0.0.1 dst 127.0.0.1 proto ah spi 0x200 ctx $goodclient
 ip xfrm state add src 127.0.0.1 dst 127.0.0.1 proto ah spi 0x250 ctx $badclientcon auth sha1 0123456789012345
 ip xfrm policy add src 127.0.0.1 dst 127.0.0.1 proto tcp dir out ctx "system_u:object_r:test_spd_t:s0" tmpl proto ah mode transport level required
 ip xfrm policy add src 127.0.0.1 dst 127.0.0.1 proto udp dir out ctx "system_u:object_r:test_spd_t:s0" tmpl proto ah mode transport level required
+
+# IPv6 loopback
+ip xfrm state add src ::1 dst ::1 proto ah spi 0x200 ctx $goodclientcon auth sha1 0123456789012345
+ip xfrm state add src ::1 dst ::1 proto ah spi 0x250 ctx $badclientcon auth sha1 0123456789012345
+ip xfrm policy add src ::1 dst ::1 proto tcp dir out ctx "system_u:object_r:test_spd_t:s0" tmpl proto ah mode transport level required
+ip xfrm policy add src ::1 dst ::1 proto udp dir out ctx "system_u:object_r:test_spd_t:s0" tmpl proto ah mode transport level required
diff --git a/tests/inet_socket/iptables-flush b/tests/inet_socket/iptables-flush
index 8371648..c168d89 100755
--- a/tests/inet_socket/iptables-flush
+++ b/tests/inet_socket/iptables-flush
@@ -2,3 +2,5 @@
 # Flush the security table.
 iptables -t security -F
 iptables -t security -X NEWCONN
+ip6tables -t security -F
+ip6tables -t security -X NEWCONN
diff --git a/tests/inet_socket/iptables-load b/tests/inet_socket/iptables-load
index c55e427..5be94f4 100755
--- a/tests/inet_socket/iptables-load
+++ b/tests/inet_socket/iptables-load
@@ -27,3 +27,23 @@ iptables -t security -A OUTPUT -m state --state ESTABLISHED,RELATED -j CONNSECMA
 # Label UDP packets similarly.
 iptables -t security -A INPUT -i lo -p udp --dport 65535 -j SECMARK --selctx system_u:object_r:test_server_packet_t:s0
 iptables -t security -A OUTPUT -o lo -p udp --sport 65535 -j SECMARK --selctx system_u:object_r:test_server_packet_t:s0
+
+##### IPv6 entries
+ip6tables -t security -F
+
+# Create a chain for new connection marking.
+ip6tables -t security -N NEWCONN
+
+# Accept incoming connections, label SYN packets, and copy labels to connections.
+ip6tables -t security -A INPUT -i lo -p tcp --dport 65535 -m state --state NEW -j NEWCONN
+ip6tables -t security -A NEWCONN -j SECMARK --selctx system_u:object_r:test_server_packet_t:s0
+ip6tables -t security -A NEWCONN -j CONNSECMARK --save
+ip6tables -t security -A NEWCONN -j ACCEPT
+
+# Common rules which copy connection labels to established and related packets.
+ip6tables -t security -A INPUT -m state --state ESTABLISHED,RELATED -j CONNSECMARK --restore
+ip6tables -t security -A OUTPUT -m state --state ESTABLISHED,RELATED -j CONNSECMARK --restore
+
+# Label UDP packets similarly.
+ip6tables -t security -A INPUT -i lo -p udp --dport 65535 -j SECMARK --selctx system_u:object_r:test_server_packet_t:s0
+ip6tables -t security -A OUTPUT -o lo -p udp --sport 65535 -j SECMARK --selctx system_u:object_r:test_server_packet_t:s0
diff --git a/tests/inet_socket/server.c b/tests/inet_socket/server.c
index a53e346..09ddfb3 100644
--- a/tests/inet_socket/server.c
+++ b/tests/inet_socket/server.c
@@ -1,6 +1,8 @@
 #include <sys/types.h>
 #include <sys/socket.h>
 #include <netinet/in.h>
+#include <arpa/inet.h>
+#include <netdb.h>
 #include <stdlib.h>
 #include <stddef.h>
 #include <string.h>
@@ -18,23 +20,26 @@
 
 void usage(char *progname)
 {
-	fprintf(stderr, "usage:  %s [-n] [stream|dgram] port\n", progname);
+	fprintf(stderr,
+		"usage:  %s [-n] [stream|dgram] port\n"
+		"\nWhere:\n\t"
+		"-n      No peer context will be available therefore send\n\t"
+		"        \"nopeer\" to client, otherwise the peer context\n\t"
+		"        will be retrieved and sent to client.\n\t"
+		"stream  Use TCP protocol or:\n\t"
+		"dgram   use UDP protocol.\n\t"
+		"port    Listening port\n", progname);
 	exit(1);
 }
 
-static const int on = 1;
-
-int
-main(int argc, char **argv)
+int main(int argc, char **argv)
 {
-	int sock;
-	int result;
-	struct sockaddr_in sin;
+	int sock, result, opt, on = 1;
 	socklen_t sinlen;
-	int type;
+	struct sockaddr_storage sin;
+	struct addrinfo hints, *res;
 	char byte;
 	unsigned short port;
-	int opt;
 	bool nopeer = false;
 
 	while ((opt = getopt(argc, argv, "n")) != -1) {
@@ -50,23 +55,35 @@ main(int argc, char **argv)
 	if ((argc - optind) != 2)
 		usage(argv[0]);
 
-	if (!strcmp(argv[optind], "stream"))
-		type = SOCK_STREAM;
-	else if (!strcmp(argv[optind], "dgram"))
-		type = SOCK_DGRAM;
-	else
+	memset(&hints, 0, sizeof(struct addrinfo));
+	hints.ai_flags = AI_PASSIVE;
+	hints.ai_family = AF_INET6;
+
+	if (!strcmp(argv[optind], "stream")) {
+		hints.ai_socktype = SOCK_STREAM;
+		hints.ai_protocol = IPPROTO_TCP;
+	} else if (!strcmp(argv[optind], "dgram")) {
+		hints.ai_socktype = SOCK_DGRAM;
+		hints.ai_protocol = IPPROTO_UDP;
+	} else {
 		usage(argv[0]);
+	}
 
 	port = atoi(argv[optind + 1]);
 	if (!port)
 		usage(argv[0]);
 
-	sock = socket(AF_INET, type, 0);
+	result = getaddrinfo(NULL, argv[optind + 1], &hints, &res);
+	if (result < 0) {
+		printf("getaddrinfo: %s\n", gai_strerror(result));
+		exit(1);
+	}
+
+	sock = socket(res->ai_family, res->ai_socktype, res->ai_protocol);
 	if (sock < 0) {
 		perror("socket");
 		exit(1);
 	}
-
 	result = setsockopt(sock, SOL_IP, IP_PASSSEC, &on, sizeof(on));
 	if (result < 0) {
 		perror("setsockopt: SO_PASSSEC");
@@ -76,23 +93,18 @@ main(int argc, char **argv)
 
 	result = setsockopt(sock, SOL_SOCKET, SO_REUSEADDR, &on, sizeof(on));
 	if (result < 0) {
-		perror("setsockopt: SO_PASSSEC");
+		perror("setsockopt: SO_REUSEADDR");
 		close(sock);
 		exit(1);
 	}
 
-	bzero(&sin, sizeof(struct sockaddr_in));
-	sin.sin_family = AF_INET;
-	sin.sin_port = htons(port);
-	sin.sin_addr.s_addr = INADDR_ANY;
-	sinlen = sizeof(sin);
-	if (bind(sock, (struct sockaddr *) &sin, sinlen) < 0) {
+	if (bind(sock, res->ai_addr, res->ai_addrlen) < 0) {
 		perror("bind");
 		close(sock);
 		exit(1);
 	}
 
-	if (type == SOCK_STREAM) {
+	if (hints.ai_socktype == SOCK_STREAM) {
 		if (listen(sock, SOMAXCONN)) {
 			perror("listen");
 			close(sock);
@@ -105,8 +117,7 @@ main(int argc, char **argv)
 			socklen_t labellen = sizeof(peerlabel);
 
 			sinlen = sizeof(sin);
-			newsock = accept(sock, (struct sockaddr *)&sin,
-					 &sinlen);
+			newsock = accept(sock, (struct sockaddr *)&sin, &sinlen);
 			if (newsock < 0) {
 				perror("accept");
 				close(sock);
@@ -123,6 +134,7 @@ main(int argc, char **argv)
 					perror("getsockopt: SO_PEERSEC");
 					exit(1);
 				}
+
 				printf("%s:  Got peer label=%s\n", argv[0], peerlabel);
 			}
 
@@ -183,7 +195,6 @@ main(int argc, char **argv)
 					}
 				}
 			}
-
 			result = sendto(sock, msglabel, strlen(msglabel), 0,
 					msg.msg_name, msg.msg_namelen);
 			if (result < 0) {
diff --git a/tests/inet_socket/test b/tests/inet_socket/test
index e97151e..8d20eb6 100755
--- a/tests/inet_socket/test
+++ b/tests/inet_socket/test
@@ -6,14 +6,14 @@ BEGIN {
     if (system("ip xfrm policy help 2>&1 | grep -q ctx") != 0) {
         plan skip_all => "ctx not supported in ip xfrm policy";
     } else {
-        plan tests => 20;
+        plan tests => 35;
     }
 }
 
 $basedir = $0;  $basedir =~ s|(.*)/[^/]*|$1|;
 
-# Load NetLabel configuration.
-system "$basedir/netlabel-load";
+# Load NetLabel configuration for full CIPSO4 labeling over loopback.
+system "$basedir/cipso-fl-load";
 
 # Start the stream server.
 if (($pid = fork()) == 0) {
@@ -23,11 +23,11 @@ if (($pid = fork()) == 0) {
 sleep 1; # Give it a moment to initialize.
 
 # Verify that authorized client can communicate with the server.
-$result = system "runcon -t test_inet_client_t $basedir/client stream 65535";
+$result = system "runcon -t test_inet_client_t $basedir/client stream 127.0.0.1 65535";
 ok($result eq 0);
 
 # Verify that unauthorized client cannot communicate with the server.
-$result = system "runcon -t test_inet_bad_client_t -- $basedir/client stream 65535 2>&1";
+$result = system "runcon -t test_inet_bad_client_t -- $basedir/client stream 127.0.0.1 65535 2>&1";
 ok($result);
 
 # Kill the server.
@@ -41,18 +41,75 @@ if (($pid = fork()) == 0) {
 sleep 1; # Give it a moment to initialize
 
 # Verify that authorized client can communicate with the server.
-$result = system "runcon -t test_inet_client_t $basedir/client dgram 65535";
+$result = system "runcon -t test_inet_client_t $basedir/client dgram 127.0.0.1 65535";
 ok($result eq 0);
 
 # Verify that unauthorized client cannot communicate with the server.
-$result = system "runcon -t test_inet_bad_client_t -- $basedir/client dgram 65535 2>&1";
+$result = system "runcon -t test_inet_bad_client_t -- $basedir/client dgram 127.0.0.1 65535 2>&1";
 ok($result);
 
 # Kill the server.
 kill TERM, $pid;
 
 # Flush NetLabel configuration.
-system "$basedir/netlabel-flush";
+system "$basedir/cipso-fl-flush";
+
+# Load NetLabel configuration for CIPSO4 over loopback.
+system "$basedir/cipso-load";
+
+# Start the stream server with a defined level.
+if (($pid = fork()) == 0) {
+    exec "runcon -t test_inet_server_t -l s0:c0.c10 $basedir/server stream 65535";
+}
+
+sleep 1; # Give it a moment to initialize.
+
+# Verify that authorized client can communicate with the server using level.
+$result = system "runcon -t test_inet_client_t -l s0:c0.c10 $basedir/client -e system_u:object_r:netlabel_peer_t:s0:c0.c10 stream 127.0.0.1 65535";
+ok($result eq 0);
+
+# Verify that authorized client can communicate with the server using level.
+$result = system "runcon -t test_inet_client_t -l s0:c8.c10 $basedir/client -e system_u:object_r:netlabel_peer_t:s0:c8.c10 stream 127.0.0.1 65535";
+ok($result eq 0);
+
+# Verify that authorized client cannot communicate with the server using different level.
+$result = system "runcon -t test_inet_client_t -l s0:c8.c12 $basedir/client stream 127.0.0.1 65535 2>&1";
+ok($result);
+
+# Kill the server.
+kill TERM, $pid;
+
+# Start the dgram server with a defined level.
+if (($pid = fork()) == 0) {
+    exec "runcon -t test_inet_server_t -l s0:c20.c50 $basedir/server dgram 65535";
+}
+
+sleep 1; # Give it a moment to initialize.
+
+# Verify that authorized client can communicate with the server using same levels.
+$result = system "runcon -t test_inet_client_t -l s0:c20.c50 $basedir/client -e system_u:object_r:netlabel_peer_t:s0:c20.c50 dgram 127.0.0.1 65535";
+ok($result eq 0);
+
+# This looks like it should pass as the client levels are dominated by the server, however
+# because this is UDP, the server uses the same socket for sending (whereas the TCP version
+# uses a new socket that inherits the clients MLS levels). This test fails as there is an
+# MLS constraint in the Fedora "targeted" policy:
+# mlsconstrain peer recv l1 dom l2 or ( t1 != mcs_constrained_type ) and ( t2 != mcs_constrained_type )
+# This causes the following denial as l1 = s0:c21.c49 and l2 = s0:c20.c50, giving the
+# following AVC entry:
+# avc:  denied  { recv } for  pid=8298 comm="server" saddr=127.0.0.1 src=65535 daddr=127.0.0.1 dest=50511 netif=lo scontext=unconfined_u:unconfined_r:test_inet_client_t:s0:c21.c49 tcontext=system_u:object_r:netlabel_peer_t:s0:c20.c50 tclass=peer permissive=0
+$result = system "runcon -t test_inet_client_t -l s0:c21.c49 $basedir/client -e system_u:object_r:netlabel_peer_t:s0:c21.c49 dgram 127.0.0.1 65535 2>&1";
+ok($result);
+
+# Verify that authorized client cannot communicate with the server using levels dominating the server.
+$result = system "runcon -t test_inet_client_t -l s0:c40.c51 $basedir/client dgram 127.0.0.1 65535 2>&1";
+ok($result);
+
+# Kill the server.
+kill TERM, $pid;
+
+# Flush NetLabel configuration.
+system "$basedir/cipso-flush";
 
 # Verify that authorized domain can bind UDP sockets.
 $result = system "runcon -t test_inet_bind_t -- $basedir/bind dgram 65535 2>&1";
@@ -97,11 +154,19 @@ if (($pid = fork()) == 0) {
 sleep 1; # Give it a moment to initialize.
 
 # Verify that authorized client can communicate with the server.
-$result = system "runcon -t test_inet_client_t $basedir/client stream 65535";
+$result = system "runcon -t test_inet_client_t $basedir/client stream 127.0.0.1 65535";
 ok($result eq 0);
 
 # Verify that unauthorized client cannot communicate with the server.
-$result = system "runcon -t test_inet_bad_client_t -- $basedir/client stream 65535 2>&1";
+$result = system "runcon -t test_inet_bad_client_t -- $basedir/client stream 127.0.0.1 65535 2>&1";
+ok($result);
+
+# Verify that authorized client can communicate with the server.
+$result = system "runcon -t test_inet_client_t $basedir/client stream ::1 65535";
+ok($result eq 0);
+
+# Verify that unauthorized client cannot communicate with the server.
+$result = system "runcon -t test_inet_bad_client_t -- $basedir/client stream ::1 65535 2>&1";
 ok($result);
 
 # Kill the server.
@@ -115,20 +180,45 @@ if (($pid = fork()) == 0) {
 sleep 1; # Give it a moment to initialize
 
 # Verify that authorized client can communicate with the server.
-$result = system "runcon -t test_inet_client_t $basedir/client dgram 65535";
+$result = system "runcon -t test_inet_client_t $basedir/client dgram 127.0.0.1 65535";
 ok($result eq 0);
 
 # Verify that unauthorized client cannot communicate with the server.
-$result = system "runcon -t test_inet_bad_client_t -- $basedir/client dgram 65535 2>&1";
+$result = system "runcon -t test_inet_bad_client_t -- $basedir/client dgram 127.0.0.1 65535 2>&1";
+ok($result);
+
+# This would be expected to pass, however the kernel IPv6 stack does not currently
+# support retrieving peer labels for UDP using cmsg_level SOL_IP/cmsg_type SCM_SECURITY.
+# Therefore nothing is sent back to the client.
+### See the test below where the server does not request peer context ####
+$result = system "runcon -t test_inet_client_t $basedir/client dgram ::1 65535 2>&1";
+ok($result);
+
+# Verify that unauthorized client cannot communicate with the server.
+$result = system "runcon -t test_inet_bad_client_t -- $basedir/client dgram ::1 65535 2>&1";
 ok($result);
 
 # Kill the server.
 kill TERM, $pid;
 
+# Start the dgram server for IPSEC test using IPv6 but do not request peer context.
+if (($pid = fork()) == 0) {
+    exec "runcon -t test_inet_server_t $basedir/server -n dgram 65535";
+}
+
+sleep 1; # Give it a moment to initialize
+
+# This test now passes.
+$result = system "runcon -t test_inet_client_t $basedir/client -e nopeer dgram ::1 65535";
+ok($result eq 0);
+
+# Kill the server.
+kill TERM, $pid;
+
 # Flush IPSEC configuration.
 system "$basedir/ipsec-flush";
 
-# Load iptables configuration.
+# Load iptables (IPv4 & IPv6) configuration.
 system "$basedir/iptables-load";
 
 # Start the stream server.
@@ -139,11 +229,19 @@ if (($pid = fork()) == 0) {
 sleep 1; # Give it a moment to initialize.
 
 # Verify that authorized client can communicate with the server.
-$result = system "runcon -t test_inet_client_t -- $basedir/client -n stream 65535";
+$result = system "runcon -t test_inet_client_t -- $basedir/client -e nopeer stream 127.0.0.1 65535";
+ok($result eq 0);
+
+# Verify that unauthorized client cannot communicate with the server.
+$result = system "runcon -t test_inet_bad_client_t -- $basedir/client -e nopeer stream 127.0.0.1 65535 2>&1";
+ok($result);
+
+# Verify that authorized client can communicate with the server.
+$result = system "runcon -t test_inet_client_t -- $basedir/client -e nopeer stream ::1 65535";
 ok($result eq 0);
 
 # Verify that unauthorized client cannot communicate with the server.
-$result = system "runcon -t test_inet_bad_client_t -- $basedir/client -n stream 65535 2>&1";
+$result = system "runcon -t test_inet_bad_client_t -- $basedir/client -e nopeer stream ::1 65535 2>&1";
 ok($result);
 
 # Kill the server.
@@ -157,11 +255,19 @@ if (($pid = fork()) == 0) {
 sleep 1; # Give it a moment to initialize
 
 # Verify that authorized client can communicate with the server.
-$result = system "runcon -t test_inet_client_t $basedir/client -n dgram 65535";
+$result = system "runcon -t test_inet_client_t $basedir/client -e nopeer dgram 127.0.0.1 65535";
+ok($result eq 0);
+
+# Verify that unauthorized client cannot communicate with the server.
+$result = system "runcon -t test_inet_bad_client_t -- $basedir/client -e nopeer dgram 127.0.0.1 65535 2>&1";
+ok($result);
+
+# Verify that authorized client can communicate with the server.
+$result = system "runcon -t test_inet_client_t $basedir/client -e nopeer dgram ::1 65535";
 ok($result eq 0);
 
 # Verify that unauthorized client cannot communicate with the server.
-$result = system "runcon -t test_inet_bad_client_t -- $basedir/client -n dgram 65535 2>&1";
+$result = system "runcon -t test_inet_bad_client_t -- $basedir/client -e nopeer dgram ::1 65535 2>&1";
 ok($result);
 
 # Kill the server.
-- 
2.9.3
