From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH v2] selinux-testsuite:  add inet_socket tests
Date: Tue, 16 Jun 2015 13:33:39 -0400
Message-Id: <1434476019-23295-1-git-send-email-sds@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Add a set of tests for INET sockets that exercise the SO_PEERSEC
and SCM_SECURITY functionality and test the peer recv permission check.
Load a NetLabel configuration during testing to enable full SELinux
labeling over loopback.

Other candidates for future tests:
- Test other INET socket permission checks, such as socket name_bind,
node_bind, name_connect, netif ingress/egress, and node recvfrom/sendto,
- Test SECMARK packet labeling and packet permission checks,
- Test labeled IPSEC peer labeling (over loopback possible?),
- Optionally test cross-machine peer labeling via NetLabel or labeled IPSEC
(requires more complex test setup).

Presently this test does not work on F22 due to a problem with
netlabel_tools, but it did pass on F21 for me.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---

Changes from V1:
Fixed a comment.
Fixed a couple of compiler warnings.

 policy/Makefile                  |   2 +-
 policy/test_inet_socket.te       |  60 ++++++++++++++
 tests/Makefile                   |   2 +-
 tests/inet_socket/Makefile       |   7 ++
 tests/inet_socket/client.c       | 102 +++++++++++++++++++++++
 tests/inet_socket/netlabel-flush |   8 ++
 tests/inet_socket/netlabel-load  |  11 +++
 tests/inet_socket/server.c       | 174 +++++++++++++++++++++++++++++++++++++++
 tests/inet_socket/test           |  50 +++++++++++
 tests/unix_socket/server.c       |   1 -
 10 files changed, 414 insertions(+), 3 deletions(-)
 create mode 100644 policy/test_inet_socket.te
 create mode 100644 tests/inet_socket/Makefile
 create mode 100644 tests/inet_socket/client.c
 create mode 100755 tests/inet_socket/netlabel-flush
 create mode 100755 tests/inet_socket/netlabel-load
 create mode 100644 tests/inet_socket/server.c
 create mode 100755 tests/inet_socket/test

diff --git a/policy/Makefile b/policy/Makefile
index 25777bb..742fd03 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -19,7 +19,7 @@ TARGETS = \
 	test_setnice.te test_sigkill.te test_stat.te test_sysctl.te \
 	test_task_create.te test_task_getpgid.te test_task_getsched.te \
 	test_task_getsid.te test_task_setpgid.te test_task_setsched.te \
-	test_transition.te test_unix_socket.te test_wait.te
+	test_transition.te test_inet_socket.te test_unix_socket.te test_wait.te
 
 ifeq ($(shell [ $(POL_VERS) -ge 24 ] && echo true),true)
 TARGETS += test_bounds.te
diff --git a/policy/test_inet_socket.te b/policy/test_inet_socket.te
new file mode 100644
index 0000000..9e01a8c
--- /dev/null
+++ b/policy/test_inet_socket.te
@@ -0,0 +1,60 @@
+#################################
+#
+# Policy for testing INET domain sockets.
+#
+
+attribute inetsocketdomain;
+
+# Do not break NFS when we load NetLabel configuration.
+gen_require(`
+	type kernel_t;
+')
+corenet_all_recvfrom_unlabeled(kernel_t)
+
+# Domain for server process.
+type test_inet_server_t;
+domain_type(test_inet_server_t)
+unconfined_runs_test(test_inet_server_t)
+typeattribute test_inet_server_t testdomain;
+typeattribute test_inet_server_t inetsocketdomain;
+allow test_inet_server_t self:tcp_socket create_stream_socket_perms;
+allow test_inet_server_t self:udp_socket create_socket_perms;
+corenet_tcp_bind_generic_port(test_inet_server_t)
+corenet_udp_bind_generic_port(test_inet_server_t)
+corenet_tcp_bind_all_nodes(test_inet_server_t)
+corenet_udp_bind_all_nodes(test_inet_server_t)
+corenet_inout_generic_if(test_inet_server_t)
+corenet_inout_generic_node(test_inet_server_t)
+
+# Domain for client process.
+type test_inet_client_t;
+domain_type(test_inet_client_t)
+unconfined_runs_test(test_inet_client_t)
+typeattribute test_inet_client_t testdomain;
+typeattribute test_inet_client_t inetsocketdomain;
+allow test_inet_client_t self:tcp_socket create_stream_socket_perms;
+allow test_inet_client_t self:udp_socket create_socket_perms;
+corenet_tcp_connect_generic_port(test_inet_client_t)
+corenet_inout_generic_if(test_inet_client_t)
+corenet_inout_generic_node(test_inet_client_t)
+
+# The server can receive labeled packets from the client.
+allow test_inet_server_t test_inet_client_t:peer recv;
+# And vice versa.
+allow test_inet_client_t test_inet_server_t:peer recv;
+
+# Domain for a client process not authorized to communicate with the server.
+type test_inet_bad_client_t;
+domain_type(test_inet_bad_client_t)
+unconfined_runs_test(test_inet_bad_client_t)
+typeattribute test_inet_bad_client_t testdomain;
+typeattribute test_inet_bad_client_t inetsocketdomain;
+allow test_inet_bad_client_t self:tcp_socket create_stream_socket_perms;
+allow test_inet_bad_client_t self:udp_socket create_socket_perms;
+corenet_tcp_connect_generic_port(test_inet_bad_client_t)
+corenet_inout_generic_if(test_inet_bad_client_t)
+corenet_inout_generic_node(test_inet_bad_client_t)
+
+# Allow all of these domains to be entered from the sysadm domain.
+miscfiles_domain_entry_test_files(inetsocketdomain)
+userdom_sysadm_entry_spec_domtrans_to(inetsocketdomain)
diff --git a/tests/Makefile b/tests/Makefile
index 5e45bf9..507123b 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -5,7 +5,7 @@ DISTRO=$(shell ./os_detect)
 
 SUBDIRS_COMMON:=domain_trans entrypoint execshare exectrace execute_no_trans fdreceive inherit link mkdir msg open ptrace readlink relabel rename rxdir sem setattr setnice shm sigkill stat sysctl task_create task_setnice task_setscheduler task_getscheduler task_getsid task_getpgid task_setpgid wait file ioctl capable_file capable_net capable_sys unix_socket
 
-SUBDIRS:= $(SUBDIRS_COMMON) dyntrans dyntrace bounds nnp
+SUBDIRS:= $(SUBDIRS_COMMON) dyntrans dyntrace bounds nnp inet_socket
 
 ifeq ($(DISTRO),RHEL4)
     SUBDIRS:=$(SUBDIRS_COMMON)
diff --git a/tests/inet_socket/Makefile b/tests/inet_socket/Makefile
new file mode 100644
index 0000000..5266096
--- /dev/null
+++ b/tests/inet_socket/Makefile
@@ -0,0 +1,7 @@
+TARGETS=client server
+
+LDLIBS+= -lselinux
+
+all: $(TARGETS)
+clean:
+	rm -f $(TARGETS)
diff --git a/tests/inet_socket/client.c b/tests/inet_socket/client.c
new file mode 100644
index 0000000..ffc154c
--- /dev/null
+++ b/tests/inet_socket/client.c
@@ -0,0 +1,102 @@
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <netinet/in.h>
+#include <arpa/inet.h>
+#include <sys/un.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <stddef.h>
+#include <string.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <selinux/selinux.h>
+
+void usage(char *progname)
+{
+	fprintf(stderr,
+		"usage:  %s [stream|dgram] port\n",
+		progname);
+	exit(1);
+}
+
+int
+main(int argc, char **argv)
+{
+	char byte, label[256];
+	int sock;
+	int result;
+	struct sockaddr_in sin;
+	socklen_t sinlen;
+	int type;
+	char *mycon;
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
+	bzero(&sin, sizeof(struct sockaddr_in));
+	sin.sin_family = AF_INET;
+	sin.sin_port = htons(port);
+	if (inet_aton("127.0.0.1", &sin.sin_addr) == 0) {
+		fprintf(stderr, "%s: inet_ntoa: invalid address\n", argv[0]);
+		close(sock);
+		exit(1);
+	}
+
+	sinlen = sizeof(sin);
+	result = connect(sock, (struct sockaddr *) &sin, sinlen);
+	if (result < 0) {
+		perror("connect");
+		close(sock);
+		exit(1);
+	}
+
+	byte = 0;
+	result = write(sock, &byte, 1);
+	if (result < 0) {
+		perror("write");
+		close(sock);
+		exit(1);
+	}
+	result = read(sock, label, sizeof(label));
+	if (result < 0) {
+		perror("read");
+		close(sock);
+		exit(1);
+	}
+	label[result] = 0;
+
+	result = getcon(&mycon);
+	if (result < 0) {
+		perror("getcon");
+		close(sock);
+		exit(1);
+	}
+
+	if (strcmp(mycon, label)) {
+		fprintf(stderr, "%s:  expected %s, got %s\n",
+			argv[0], mycon, label);
+		exit(1);
+	}
+
+	close(sock);
+	exit(0);
+}
diff --git a/tests/inet_socket/netlabel-flush b/tests/inet_socket/netlabel-flush
new file mode 100755
index 0000000..32a5b73
--- /dev/null
+++ b/tests/inet_socket/netlabel-flush
@@ -0,0 +1,8 @@
+#!/bin/sh
+# Reset NetLabel configuration to unlabeled for all.
+netlabelctl map del default
+netlabelctl cipsov4 del doi:1
+netlabelctl map add default protocol:unlbl
+# Display the configuration.
+netlabelctl -p map list
+netlabelctl -p cipsov4 list
diff --git a/tests/inet_socket/netlabel-load b/tests/inet_socket/netlabel-load
new file mode 100755
index 0000000..8110d18
--- /dev/null
+++ b/tests/inet_socket/netlabel-load
@@ -0,0 +1,11 @@
+#!/bin/sh
+# Define a localhost/loopback doi and apply it to the loopback address
+# so that we get full SELinux labels over loopback connections.
+netlabelctl cipsov4 add local doi:1
+netlabelctl map del default
+netlabelctl map add default address:0.0.0.0/0 protocol:unlbl
+netlabelctl map add default address:::/0 protocol:unlbl
+netlabelctl map add default address:127.0.0.1 protocol:cipsov4,1
+# Display the configuration.
+netlabelctl -p cipsov4 list
+netlabelctl -p map list
diff --git a/tests/inet_socket/server.c b/tests/inet_socket/server.c
new file mode 100644
index 0000000..f7f4fdd
--- /dev/null
+++ b/tests/inet_socket/server.c
@@ -0,0 +1,174 @@
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <netinet/in.h>
+#include <stdlib.h>
+#include <stddef.h>
+#include <string.h>
+#include <unistd.h>
+#include <stdio.h>
+
+#ifndef SO_PEERSEC
+#define SO_PEERSEC 31
+#endif
+
+#ifndef SCM_SECURITY
+#define SCM_SECURITY 0x03
+#endif
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
+	char byte;
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
+	result = setsockopt(sock, SOL_IP, IP_PASSSEC, &on, sizeof(on));
+	if (result < 0) {
+		perror("setsockopt: SO_PASSSEC");
+		close(sock);
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
+	sin.sin_port = htons(port);
+	sin.sin_addr.s_addr = INADDR_ANY;
+	sinlen = sizeof(sin);
+	if (bind(sock, (struct sockaddr *) &sin, sinlen) < 0) {
+		perror("bind");
+		close(sock);
+		exit(1);
+	}
+
+	if (type == SOCK_STREAM) {
+		int newsock;
+		char peerlabel[256];
+		socklen_t labellen = sizeof(peerlabel);
+
+		if (listen(sock, SOMAXCONN)) {
+			perror("listen");
+			close(sock);
+			exit(1);
+		}
+
+		sinlen = sizeof(sin);
+		newsock = accept(sock, (struct sockaddr *)&sin,
+				 &sinlen);
+		if (newsock < 0) {
+			perror("accept");
+			close(sock);
+			exit(1);
+		}
+
+		peerlabel[0] = 0;
+		result = getsockopt(newsock, SOL_SOCKET, SO_PEERSEC, peerlabel,
+				    &labellen);
+		if (result < 0) {
+			perror("getsockopt: SO_PEERSEC");
+			exit(1);
+		}
+		printf("%s:  Got peer label=%s\n", argv[0], peerlabel);
+
+		result = read(newsock, &byte, 1);
+		if (result < 0) {
+			perror("read");
+			exit(1);
+		}
+
+		result = write(newsock, peerlabel, strlen(peerlabel));
+		if (result < 0) {
+			perror("write");
+			exit(1);
+		}
+		close(newsock);
+	} else {
+		struct iovec iov;
+		struct msghdr msg;
+		struct cmsghdr *cmsg;
+		char msglabel[256];
+		union {
+			struct cmsghdr cmsghdr;
+			char buf[CMSG_SPACE(sizeof(msglabel))];
+		} control;
+
+		memset(&iov, 0, sizeof(iov));
+		iov.iov_base = &byte;
+		iov.iov_len = 1;
+		memset(&msg, 0, sizeof(msg));
+		msglabel[0] = 0;
+		msg.msg_name = &sin;
+		msg.msg_namelen = sizeof(sin);
+		msg.msg_iov = &iov;
+		msg.msg_iovlen = 1;
+		msg.msg_control = &control;
+		msg.msg_controllen = sizeof(control);
+		result = recvmsg(sock, &msg, 0);
+		if (result < 0) {
+			perror("recvmsg");
+			exit(1);
+		}
+		for (cmsg = CMSG_FIRSTHDR(&msg); cmsg;
+		     cmsg = CMSG_NXTHDR(&msg, cmsg)) {
+			if (cmsg->cmsg_level == SOL_IP &&
+			    cmsg->cmsg_type == SCM_SECURITY) {
+				size_t len = cmsg->cmsg_len - CMSG_LEN(0);
+
+				if (len > 0 && len < sizeof(msglabel)) {
+					memcpy(msglabel, CMSG_DATA(cmsg), len);
+					msglabel[len] = 0;
+					printf("%s: Got SCM_SECURITY=%s\n",
+					       argv[0], msglabel);
+				}
+			}
+		}
+
+		result = sendto(sock, msglabel, strlen(msglabel), 0,
+				msg.msg_name, msg.msg_namelen);
+		if (result < 0) {
+			perror("sendto");
+			exit(1);
+		}
+	}
+
+	close(sock);
+	exit(0);
+}
diff --git a/tests/inet_socket/test b/tests/inet_socket/test
new file mode 100755
index 0000000..58debd9
--- /dev/null
+++ b/tests/inet_socket/test
@@ -0,0 +1,50 @@
+#!/usr/bin/perl
+
+use Test;
+BEGIN { plan tests => 4}
+
+$basedir = $0;  $basedir =~ s|(.*)/[^/]*|$1|;
+
+# Load NetLabel configuration.
+system "$basedir/netlabel-load";
+
+# Start the stream server.
+if (($pid = fork()) == 0) {
+    exec "runcon -t test_inet_server_t $basedir/server stream 65535";
+}
+
+sleep 1; # Give it a moment to initialize.
+
+# Verify that authorized client can communicate with the server.
+$result = system "runcon -t test_inet_client_t $basedir/client stream 65535";
+ok($result, 0);
+
+# Verify that unauthorized client cannot communicate with the server.
+$result = system "runcon -t test_inet_bad_client_t -- $basedir/client stream 65535 2>&1";
+ok($result);
+
+# Kill the server.
+kill TERM, $pid;
+
+# Start the dgram server.
+if (($pid = fork()) == 0) {
+    exec "runcon -t test_inet_server_t $basedir/server dgram 65535";
+}
+
+sleep 1; # Give it a moment to initialize
+
+# Verify that authorized client can communicate with the server.
+$result = system "runcon -t test_inet_client_t $basedir/client dgram 65535";
+ok($result, 0);
+
+# Verify that unauthorized client cannot communicate with the server.
+$result = system "runcon -t test_inet_bad_client_t -- $basedir/client dgram 65535 2>&1";
+ok($result);
+
+# Kill the server.
+kill TERM, $pid;
+
+# Flush NetLabel configuration.
+system "$basedir/netlabel-flush";
+
+exit;
diff --git a/tests/unix_socket/server.c b/tests/unix_socket/server.c
index 2532de7..89bfdb3 100644
--- a/tests/unix_socket/server.c
+++ b/tests/unix_socket/server.c
@@ -1,4 +1,3 @@
-#define _GNU_SOURCE
 #include <sys/types.h>
 #include <sys/socket.h>
 #include <sys/un.h>
-- 
2.1.0
