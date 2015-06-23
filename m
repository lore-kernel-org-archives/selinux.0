From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH] selinux-testsuite: Add tests for
 name_bind/node_bind/name_connect.
Date: Tue, 23 Jun 2015 16:13:52 -0400
Message-Id: <1435090432-21972-1-git-send-email-sds@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Add individual tests for the name_bind and node_bind permission
checks performed during bind(2) for UDP and TCP, and the name_connect
permission check performed during connect(2) for TCP.  Although these
permission checks were exercised by the existing inet_socket client/server
tests, they were not individually tested for failure by those tests and
they are independent of the peer labeling functionality and peer
recv permission check being tested by those tests.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 policy/test_inet_socket.te  | 58 +++++++++++++++++++++++++++++
 tests/inet_socket/Makefile  |  2 +-
 tests/inet_socket/bind.c    | 69 ++++++++++++++++++++++++++++++++++
 tests/inet_socket/connect.c | 91 +++++++++++++++++++++++++++++++++++++++++++++
 tests/inet_socket/test      | 34 ++++++++++++++++-
 5 files changed, 252 insertions(+), 2 deletions(-)
 create mode 100644 tests/inet_socket/bind.c
 create mode 100644 tests/inet_socket/connect.c

diff --git a/policy/test_inet_socket.te b/policy/test_inet_socket.te
index 9e01a8c..f652925 100644
--- a/policy/test_inet_socket.te
+++ b/policy/test_inet_socket.te
@@ -55,6 +55,64 @@ corenet_tcp_connect_generic_port(test_inet_bad_client_t)
 corenet_inout_generic_if(test_inet_bad_client_t)
 corenet_inout_generic_node(test_inet_bad_client_t)
 
+# Domain for a process allowed to bind(2).
+type test_inet_bind_t;
+domain_type(test_inet_bind_t)
+unconfined_runs_test(test_inet_bind_t)
+typeattribute test_inet_bind_t testdomain;
+typeattribute test_inet_bind_t inetsocketdomain;
+allow test_inet_bind_t self:tcp_socket create_stream_socket_perms;
+allow test_inet_bind_t self:udp_socket create_socket_perms;
+corenet_tcp_bind_generic_port(test_inet_bind_t)
+corenet_udp_bind_generic_port(test_inet_bind_t)
+corenet_tcp_bind_all_nodes(test_inet_bind_t)
+corenet_udp_bind_all_nodes(test_inet_bind_t)
+
+# Domain for a process not allowed name_bind permission to the port.
+type test_inet_no_name_bind_t;
+domain_type(test_inet_no_name_bind_t)
+unconfined_runs_test(test_inet_no_name_bind_t)
+typeattribute test_inet_no_name_bind_t testdomain;
+typeattribute test_inet_no_name_bind_t inetsocketdomain;
+allow test_inet_no_name_bind_t self:tcp_socket create_stream_socket_perms;
+allow test_inet_no_name_bind_t self:udp_socket create_socket_perms;
+corenet_tcp_bind_all_nodes(test_inet_no_name_bind_t)
+corenet_udp_bind_all_nodes(test_inet_no_name_bind_t)
+
+# Domain for a process not allowed node_bind permission to the node.
+type test_inet_no_node_bind_t;
+domain_type(test_inet_no_node_bind_t)
+unconfined_runs_test(test_inet_no_node_bind_t)
+typeattribute test_inet_no_node_bind_t testdomain;
+typeattribute test_inet_no_node_bind_t inetsocketdomain;
+allow test_inet_no_node_bind_t self:tcp_socket create_stream_socket_perms;
+allow test_inet_no_node_bind_t self:udp_socket create_socket_perms;
+corenet_tcp_bind_generic_port(test_inet_no_node_bind_t)
+corenet_udp_bind_generic_port(test_inet_no_node_bind_t)
+
+# Domain for a process allowed to connect(2).
+type test_inet_connect_t;
+domain_type(test_inet_connect_t)
+unconfined_runs_test(test_inet_connect_t)
+typeattribute test_inet_connect_t testdomain;
+typeattribute test_inet_connect_t inetsocketdomain;
+allow test_inet_connect_t self:tcp_socket create_stream_socket_perms;
+allow test_inet_connect_t self:udp_socket create_socket_perms;
+corenet_tcp_connect_generic_port(test_inet_connect_t)
+corenet_tcp_bind_generic_port(test_inet_connect_t)
+corenet_tcp_bind_all_nodes(test_inet_connect_t)
+
+# Domain for a process not allowed name_connect permission.
+type test_inet_no_name_connect_t;
+domain_type(test_inet_no_name_connect_t)
+unconfined_runs_test(test_inet_no_name_connect_t)
+typeattribute test_inet_no_name_connect_t testdomain;
+typeattribute test_inet_no_name_connect_t inetsocketdomain;
+allow test_inet_no_name_connect_t self:tcp_socket create_stream_socket_perms;
+allow test_inet_no_name_connect_t self:udp_socket create_socket_perms;
+corenet_tcp_bind_generic_port(test_inet_no_name_connect_t)
+corenet_tcp_bind_all_nodes(test_inet_no_name_connect_t)
+
 # Allow all of these domains to be entered from the sysadm domain.
 miscfiles_domain_entry_test_files(inetsocketdomain)
 userdom_sysadm_entry_spec_domtrans_to(inetsocketdomain)
diff --git a/tests/inet_socket/Makefile b/tests/inet_socket/Makefile
index 5266096..5bfd561 100644
--- a/tests/inet_socket/Makefile
+++ b/tests/inet_socket/Makefile
@@ -1,4 +1,4 @@
-TARGETS=client server
+TARGETS=client server bind connect
 
 LDLIBS+= -lselinux
 
diff --git a/tests/inet_socket/bind.c b/tests/inet_socket/bind.c
new file mode 100644
index 0000000..e16e117
--- /dev/null
+++ b/tests/inet_socket/bind.c
@@ -0,0 +1,69 @@
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <netinet/in.h>
+#include <arpa/inet.h>
+#include <stdlib.h>
+#include <stddef.h>
+#include <string.h>
+#include <unistd.h>
+#include <stdio.h>
+
+void usage(char *progname)
+{
+	fprintf(stderr, "usage:  %s [stream|dgram] port\n", progname);
+	exit(1);
+}
+
+static const int on = 1;
+
+int
+main(int argc, char **argv)
+{
+	int sock;
+	int result;
+	struct sockaddr_in sin;
+	socklen_t sinlen;
+	int type;
+	unsigned short port;
+
+	if (argc != 3)
+		usage(argv[0]);
+
+	if (!strcmp(argv[1], "stream"))
+		type = SOCK_STREAM;
+	else if (!strcmp(argv[1], "dgram"))
+		type = SOCK_DGRAM;
+	else
+		usage(argv[0]);
+
+	port = atoi(argv[2]);
+	if (!port)
+		usage(argv[0]);
+
+	sock = socket(AF_INET, type, 0);
+	if (sock < 0) {
+		perror("socket");
+		exit(1);
+	}
+
+	result = setsockopt(sock, SOL_SOCKET, SO_REUSEADDR, &on, sizeof(on));
+	if (result < 0) {
+		perror("setsockopt: SO_PASSSEC");
+		close(sock);
+		exit(1);
+	}
+
+	bzero(&sin, sizeof(struct sockaddr_in));
+	sin.sin_family = AF_INET;
+	sin.sin_addr.s_addr = INADDR_ANY;
+	sin.sin_port = htons(port);
+	sinlen = sizeof(sin);
+	if (bind(sock, (struct sockaddr *) &sin, sinlen) < 0) {
+		perror("bind");
+		close(sock);
+		exit(1);
+	}
+
+	close(sock);
+	exit(0);
+}
diff --git a/tests/inet_socket/connect.c b/tests/inet_socket/connect.c
new file mode 100644
index 0000000..0abadc9
--- /dev/null
+++ b/tests/inet_socket/connect.c
@@ -0,0 +1,91 @@
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <netinet/in.h>
+#include <arpa/inet.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <stddef.h>
+#include <string.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <poll.h>
+
+void usage(char *progname)
+{
+	fprintf(stderr,
+		"usage:  %s port\n", progname);
+	exit(1);
+}
+
+static const int on = 1;
+
+int
+main(int argc, char **argv)
+{
+	int csock, ssock;
+	int result;
+	struct sockaddr_in sin;
+	socklen_t sinlen;
+	unsigned short port;
+
+	if (argc != 2)
+		usage(argv[0]);
+
+	port = atoi(argv[1]);
+	if (!port)
+		usage(argv[0]);
+
+	ssock = socket(AF_INET, SOCK_STREAM, 0);
+	if (ssock < 0) {
+		perror("socket");
+		exit(1);
+	}
+
+	bzero(&sin, sizeof(struct sockaddr_in));
+	sin.sin_family = AF_INET;
+	sin.sin_port = htons(port);
+	if (inet_aton("127.0.0.1", &sin.sin_addr) == 0) {
+		fprintf(stderr, "%s: inet_ntoa: invalid address\n", argv[0]);
+		close(ssock);
+		exit(1);
+	}
+
+	result = setsockopt(ssock, SOL_SOCKET, SO_REUSEADDR, &on, sizeof(on));
+	if (result < 0) {
+		perror("setsockopt: SO_PASSSEC");
+		close(ssock);
+		exit(1);
+	}
+
+	sinlen = sizeof(sin);
+	if (bind(ssock, (struct sockaddr *) &sin, sinlen) < 0) {
+		perror("bind");
+		close(ssock);
+		exit(1);
+	}
+
+	if (listen(ssock, SOMAXCONN)) {
+		perror("listen");
+		close(ssock);
+		exit(1);
+	}
+
+	csock = socket(AF_INET, SOCK_STREAM, 0);
+	if (csock < 0) {
+		perror("socket");
+		close(ssock);
+		exit(1);
+	}
+
+	result = connect(csock, (struct sockaddr *) &sin, sinlen);
+	if (result < 0) {
+		perror("connect");
+		close(ssock);
+		close(csock);
+		exit(1);
+	}
+	close(ssock);
+	close(csock);
+	exit(0);
+}
diff --git a/tests/inet_socket/test b/tests/inet_socket/test
index 58debd9..8d1f3c8 100755
--- a/tests/inet_socket/test
+++ b/tests/inet_socket/test
@@ -1,7 +1,7 @@
 #!/usr/bin/perl
 
 use Test;
-BEGIN { plan tests => 4}
+BEGIN { plan tests => 12}
 
 $basedir = $0;  $basedir =~ s|(.*)/[^/]*|$1|;
 
@@ -47,4 +47,36 @@ kill TERM, $pid;
 # Flush NetLabel configuration.
 system "$basedir/netlabel-flush";
 
+# Verify that authorized domain can bind UDP sockets.
+$result = system "runcon -t test_inet_bind_t -- $basedir/bind dgram 65535 2>&1";
+ok($result, 0);
+
+# Verify that authorized domain can bind TCP sockets.
+$result = system "runcon -t test_inet_bind_t -- $basedir/bind stream 65535 2>&1";
+ok($result, 0);
+
+# Verify that domain without name_bind cannot bind UDP sockets.
+$result = system "runcon -t test_inet_no_name_bind_t -- $basedir/bind dgram 65535 2>&1";
+ok($result);
+
+# Verify that domain without name_bind cannot bind TCP sockets.
+$result = system "runcon -t test_inet_no_name_bind_t -- $basedir/bind stream 65535 2>&1";
+ok($result);
+
+# Verify that domain without node_bind cannot bind UDP sockets.
+$result = system "runcon -t test_inet_no_node_bind_t -- $basedir/bind dgram 65535 2>&1";
+ok($result);
+
+# Verify that domain without node_bind cannot bind TCP sockets.
+$result = system "runcon -t test_inet_no_node_bind_t -- $basedir/bind stream 65535 2>&1";
+ok($result);
+
+# Verify that authorized domain can connect to TCP socket.
+$result = system "runcon -t test_inet_connect_t -- $basedir/connect 65535 2>&1";
+ok($result, 0);
+
+# Verify that domain without name_connect cannot connect to TCP socket.
+$result = system "runcon -t test_inet_no_name_connect_t -- $basedir/connect 65535 2>&1";
+ok($result);
+
 exit;
-- 
2.1.0
