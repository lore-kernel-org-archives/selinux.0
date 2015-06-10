From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH] selinux-testsuite: update socket tests
Date: Wed, 10 Jun 2015 10:37:29 -0400
Message-Id: <1433947049-11929-1-git-send-email-sds@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The socket, unix_socket, and unix_secure tests were all
for the original SELinux implementation (before Linux 2.6.0),
and never worked for SELinux in mainline.
Delete these legacy tests and their associated policy as they
neither build nor work and embody many assumptions that are no
longer true of SELinux (e.g. permissions that are no longer used,
automatic propagation of security contexts for INET over loopback).

Add a new set of unix_socket tests that exercise the Unix domain
socket connectto (stream) and sendto (datagram) permission checks
and the SO_PEERSEC (stream) and SCM_SECURITY (datagram) functionality.
These tests use the abstract name space as the purpose is to test the
socket layer hooks, not the file/inode hooks.  We currently only
test SCM_SECURITY for datagram sockets but this can be extended to
also test with stream sockets if/when that functionality is accepted
into the kernel.

Possibly we could add similar tests for INET over loopback if we
were to also add support for loading netlabel configuration in addition
to policy configuration, but that is left to a future change.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 policy/Makefile                   |   2 +-
 policy/test_socket.te             |  92 ---------------------
 policy/test_unix_socket.te        |  37 +++++++++
 tests/Makefile                    |   2 +-
 tests/socket/Makefile             |   4 -
 tests/socket/noaccept.c           |  91 ---------------------
 tests/socket/options.c            | 104 -----------------------
 tests/socket/sink.c               | 120 ---------------------------
 tests/socket/source.c             |  95 ---------------------
 tests/socket/test                 |  88 --------------------
 tests/unix_secure/Makefile        |  11 ---
 tests/unix_secure/checksyscalls.c |  28 -------
 tests/unix_secure/client.c        | 126 ----------------------------
 tests/unix_secure/client.pl       |  68 ---------------
 tests/unix_secure/client2.pl      |  79 ------------------
 tests/unix_secure/server.c        | 168 --------------------------------------
 tests/unix_secure/test            |  64 ---------------
 tests/unix_socket/Makefile        |   9 +-
 tests/unix_socket/client.c        | 105 ++++++++++++++++++++++++
 tests/unix_socket/server.c        | 164 +++++++++++++++++++++++++++++++++++++
 tests/unix_socket/test            |  64 +++++----------
 tests/unix_socket/unix_options.c  | 106 ------------------------
 tests/unix_socket/unix_sink.c     | 126 ----------------------------
 tests/unix_socket/unix_source.c   |  99 ----------------------
 24 files changed, 336 insertions(+), 1516 deletions(-)
 delete mode 100644 policy/test_socket.te
 create mode 100644 policy/test_unix_socket.te
 delete mode 100644 tests/socket/Makefile
 delete mode 100644 tests/socket/noaccept.c
 delete mode 100644 tests/socket/options.c
 delete mode 100644 tests/socket/sink.c
 delete mode 100644 tests/socket/source.c
 delete mode 100755 tests/socket/test
 delete mode 100644 tests/unix_secure/Makefile
 delete mode 100644 tests/unix_secure/checksyscalls.c
 delete mode 100644 tests/unix_secure/client.c
 delete mode 100644 tests/unix_secure/client.pl
 delete mode 100644 tests/unix_secure/client2.pl
 delete mode 100644 tests/unix_secure/server.c
 delete mode 100755 tests/unix_secure/test
 create mode 100644 tests/unix_socket/client.c
 create mode 100644 tests/unix_socket/server.c
 delete mode 100644 tests/unix_socket/unix_options.c
 delete mode 100644 tests/unix_socket/unix_sink.c
 delete mode 100644 tests/unix_socket/unix_source.c

diff --git a/policy/Makefile b/policy/Makefile
index 683f454..25777bb 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -19,7 +19,7 @@ TARGETS = \
 	test_setnice.te test_sigkill.te test_stat.te test_sysctl.te \
 	test_task_create.te test_task_getpgid.te test_task_getsched.te \
 	test_task_getsid.te test_task_setpgid.te test_task_setsched.te \
-	test_transition.te test_wait.te
+	test_transition.te test_unix_socket.te test_wait.te
 
 ifeq ($(shell [ $(POL_VERS) -ge 24 ] && echo true),true)
 TARGETS += test_bounds.te
diff --git a/policy/test_socket.te b/policy/test_socket.te
deleted file mode 100644
index 1ee91d0..0000000
--- a/policy/test_socket.te
+++ /dev/null
@@ -1,92 +0,0 @@
-#################################
-# 
-# Policy for testing socket permissions
-#
-
-# Base domain for socket tests; has just about all socket permissions
-type test_socket_base_t, domain, socketdomain, testdomain;
-type test_socket_secondary_t, domain, socketdomain, testdomain;
-can_network(test_socket_base_t)
-allow test_socket_base_t port_t:{ tcp_socket udp_socket } name_bind;
-can_network(test_socket_secondary_t)
-
-allow test_socket_base_t test_socket_base_t:tcp_socket { relabelfrom relabelto };
-can_tcp_connect(test_socket_base_t,test_socket_base_t)
-can_unix_connect(test_socket_base_t,test_socket_base_t)
-can_udp_send(test_socket_base_t,test_socket_base_t)
-
-allow test_socket_secondary_t test_socket_base_t:tcp_socket { relabelfrom relabelto };
-can_tcp_connect(test_socket_secondary_t,test_socket_base_t)
-can_unix_connect(test_socket_secondary_t,test_socket_base_t)
-
-allow test_socket_base_t test_socket_secondary_t:tcp_socket {newconn acceptfrom recvfrom read};
-allow test_socket_secondary_t self:tcp_socket {recvfrom connectto acceptfrom read};
-
-# for xxx_secure() socket calls
-allow test_socket_base_t test_socket_secondary_t:tcp_socket create_stream_socket_perms;
-allow test_socket_base_t test_socket_secondary_t:unix_stream_socket create_stream_socket_perms;
-allow test_socket_base_t node_lo_t:node {enforce_dest};
-
-allow test_socket_base_t test_socket_noconnect_t:tcp_socket { recvfrom acceptfrom };
-allow test_socket_base_t test_socket_norecv_t:tcp_socket { recvfrom acceptfrom };
-
-# Domain that doesn't have recvfrom permission
-type test_socket_norecv_t, domain, socketdomain, testdomain;
-allow test_socket_norecv_t self:udp_socket create_socket_perms;
-allow test_socket_norecv_t self:tcp_socket create_stream_socket_perms;
-allow test_socket_norecv_t netif_type:netif packet_perms;
-allow test_socket_norecv_t netmsg_type:tcp_socket { connectto acceptfrom };
-allow test_socket_norecv_t node_type:node packet_perms;
-
-# Domain that without connect permission
-type test_socket_noconnect_t, domain, socketdomain, testdomain;
-allow test_socket_noconnect_t self:udp_socket create_socket_perms;
-allow test_socket_noconnect_t self:tcp_socket create_stream_socket_perms;
-allow test_socket_noconnect_t netif_type:netif packet_perms;
-allow test_socket_noconnect_t netmsg_type:{ udp_socket tcp_socket rawip_socket } recvfrom;
-allow test_socket_noconnect_t node_type:node packet_perms;
-allow test_socket_noconnect_t port_t:tcp_socket name_bind;
-
-# A domain that has acceptfrom permission, but not accept permission
-type test_socket_noaccept_t, domain, socketdomain, testdomain;
-allow test_socket_noaccept_t self:udp_socket create_socket_perms;
-allow test_socket_noaccept_t self:tcp_socket create_stream_socket_perms;
-allow test_socket_noaccept_t netif_type:netif packet_perms;
-allow test_socket_noaccept_t netmsg_type:{ udp_socket tcp_socket rawip_socket } recvfrom;
-allow test_socket_noaccept_t netmsg_type:tcp_socket { connectto acceptfrom };
-allow test_socket_noaccept_t node_type:node packet_perms;
-allow test_socket_noaccept_t port_t:tcp_socket name_bind;
-
-# allow socket to be labeled back and forth (with fchsid call)
-allow test_socket_base_t test_socket_noaccept_t:tcp_socket { relabelfrom relabelto };
-allow test_socket_noaccept_t test_socket_base_t:tcp_socket { relabelfrom relabelto };
-allow test_socket_noaccept_t fs_t:filesystem associate;
-allow test_socket_base_t fs_t:filesystem associate;
-
-
-# Another socket type, that can't talk to base domain
-type test_socket_minimal_t, domain, socketdomain, testdomain;
-allow test_socket_minimal_t self:udp_socket create_socket_perms;
-allow test_socket_minimal_t self:tcp_socket create_stream_socket_perms;
-
-# Another socket type, that can't use the network at all
-type test_socket_none_t, domain, socketdomain, testdomain;
-allow test_socket_none_t self:udp_socket create_socket_perms;
-allow test_socket_none_t self:tcp_socket create_stream_socket_perms;
-
-# Test domains can create unix domain sockets in the test directory
-allow socketdomain test_file_t:dir rw_dir_perms;
-allow socketdomain test_file_t:sock_file create_file_perms;
-allow socketdomain test_file_t:sock_file rw_file_perms;
-
-# Allow all of these domains to be entered from user domains.
-# via a shell script in the test directory.
-domain_trans(sysadm_t, test_file_t, socketdomain)
-
-# Also allow entry via some other programs.
-domain_trans(sysadm_t, bin_t, socketdomain)
-
-# Allow the user shell to read the /proc/PID entries for these domains.
-allow sysadm_t socketdomain:dir r_dir_perms;
-allow sysadm_t socketdomain:file r_file_perms;
-
diff --git a/policy/test_unix_socket.te b/policy/test_unix_socket.te
new file mode 100644
index 0000000..cf3df35
--- /dev/null
+++ b/policy/test_unix_socket.te
@@ -0,0 +1,37 @@
+#################################
+#
+# Policy for testing Unix/local domain sockets.
+#
+
+attribute unixsocketdomain;
+
+# Domain for server process.
+type test_unix_server_t;
+domain_type(test_unix_server_t)
+unconfined_runs_test(test_unix_server_t)
+typeattribute test_unix_server_t testdomain;
+typeattribute test_unix_server_t unixsocketdomain;
+
+# Domain for stream client process.
+type test_unix_stream_client_t;
+domain_type(test_unix_stream_client_t)
+unconfined_runs_test(test_unix_stream_client_t)
+typeattribute test_unix_stream_client_t testdomain;
+typeattribute test_unix_stream_client_t unixsocketdomain;
+# It can connectto the server.
+allow test_unix_stream_client_t test_unix_server_t:unix_stream_socket connectto;
+
+# Domain for dgram client process.
+type test_unix_dgram_client_t;
+domain_type(test_unix_dgram_client_t)
+unconfined_runs_test(test_unix_dgram_client_t)
+typeattribute test_unix_dgram_client_t testdomain;
+typeattribute test_unix_dgram_client_t unixsocketdomain;
+# It can sendto the server.
+allow test_unix_dgram_client_t test_unix_server_t:unix_dgram_socket sendto;
+# And the server can sendto it in order to reply.
+allow test_unix_server_t test_unix_dgram_client_t:unix_dgram_socket sendto;
+
+# Allow all of these domains to be entered from the sysadm domain.
+miscfiles_domain_entry_test_files(unixsocketdomain)
+userdom_sysadm_entry_spec_domtrans_to(unixsocketdomain)
diff --git a/tests/Makefile b/tests/Makefile
index b679137..5e45bf9 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -3,7 +3,7 @@ export CFLAGS+=-g -O0 -Wall -D_GNU_SOURCE
 
 DISTRO=$(shell ./os_detect)
 
-SUBDIRS_COMMON:=domain_trans entrypoint execshare exectrace execute_no_trans fdreceive inherit link mkdir msg open ptrace readlink relabel rename rxdir sem setattr setnice shm sigkill stat sysctl task_create task_setnice task_setscheduler task_getscheduler task_getsid task_getpgid task_setpgid wait file ioctl capable_file capable_net capable_sys
+SUBDIRS_COMMON:=domain_trans entrypoint execshare exectrace execute_no_trans fdreceive inherit link mkdir msg open ptrace readlink relabel rename rxdir sem setattr setnice shm sigkill stat sysctl task_create task_setnice task_setscheduler task_getscheduler task_getsid task_getpgid task_setpgid wait file ioctl capable_file capable_net capable_sys unix_socket
 
 SUBDIRS:= $(SUBDIRS_COMMON) dyntrans dyntrace bounds nnp
 
diff --git a/tests/socket/Makefile b/tests/socket/Makefile
deleted file mode 100644
index fd017cf..0000000
--- a/tests/socket/Makefile
+++ /dev/null
@@ -1,4 +0,0 @@
-CFLAGS+=-Wall
-all: $(ctargets)
-clean:
-	rm -f $(ctargets) *.o *~
diff --git a/tests/socket/noaccept.c b/tests/socket/noaccept.c
deleted file mode 100644
index 7223621..0000000
--- a/tests/socket/noaccept.c
+++ /dev/null
@@ -1,91 +0,0 @@
-#include <sys/types.h>
-#include <sys/socket.h>
-#include <netinet/in.h>
-#include <arpa/inet.h>		/* for inet_aton() */
-#include <sys/poll.h>
-#include <stdlib.h>
-#include <string.h>
-#include <unistd.h>
-#include <stdio.h>
-#include <fcntl.h>
-#include <errno.h>
-#include<fs_secure.h>		/* for SELinux extended syscalls */
-
-static const char *hostname = "127.0.0.1";
-static const u_short port = 4000;
-static const int on = 1;
-
-int
-main(int argc, char **argv)
-{
-	struct sockaddr_in saddr, raddr;
-	socklen_t rsize = sizeof (raddr);
-	int sock;
-	int result;
-	int remote;
-	security_id_t sid = -1;
-	struct stat statbuf;
-	security_id_t outsid;
-
-	if (argc != 2) {
-		printf("%s <sid>\n", argv[0]);
-		return -1;
-	}
-	sid = atoi(argv[1]);
-
-	bzero(&saddr, sizeof (struct sockaddr_in));
-	if (!inet_aton(hostname, &saddr.sin_addr)) {
-		printf("error converting address\n");
-		return -1;
-	}
-
-
-	saddr.sin_family = AF_INET;
-	saddr.sin_port = htons(port);
-
-	if ((sock = socket(saddr.sin_family, SOCK_STREAM, 0)) < 0) {
-		perror("socket");
-		return -1;
-	}
-
-	if ((result = setsockopt(sock, SOL_SOCKET, SO_REUSEADDR,
-				 &on, sizeof (on)))) {
-		perror("setsockopt: ");
-		close(sock);
-		return -1;
-	}
-	if (bind(sock, (struct sockaddr *) &saddr, sizeof (saddr)) < 0) {
-		perror("bind");
-		close(sock);
-		return -1;
-	}
-
-	if (listen(sock, SOMAXCONN)) {
-		close(sock);
-		return -1;
-	}
-
-	if ((result = fcntl(sock, F_SETFL, O_NONBLOCK))) {
-		perror("fcntl: ");
-		return -1;
-	}
-
-	(void)fstat_secure(sock, &statbuf, &outsid);
-	printf("Changing socket sid from %d to %d\n", outsid, sid);
-	(void)fchsid(sock, sid);
-
-	remote = accept(sock, (struct sockaddr *) &raddr, &rsize);
-
-	printf("Changing socket sid back to %d\n", outsid);
-	(void)fchsid(sock, outsid);
-
-	printf("remote == %d\n", remote);
-
-	shutdown(sock, 2);
-	close(sock);
-
-	if (remote == -1)
-		return 1;
-
-	return (0);
-}
diff --git a/tests/socket/options.c b/tests/socket/options.c
deleted file mode 100644
index 6f85b9b..0000000
--- a/tests/socket/options.c
+++ /dev/null
@@ -1,104 +0,0 @@
-#include <sys/types.h>
-#include <sys/socket.h>
-#include <netinet/in.h>
-#include <arpa/inet.h>		/* for inet_aton() */
-#include <sys/poll.h>
-#include <stdlib.h>
-#include <stdio.h>
-#include <string.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <errno.h>
-
-static const char *hostname = "127.0.0.1";
-static const u_short port = 4000;
-static const int sendbytes = 100;	/* Send this much data */
-
-int
-main(int argc, char **argv)
-{
-	struct sockaddr_in saddr;
-	struct sockaddr_in raddr;
-	socklen_t rsize = sizeof (raddr);
-	int protocol;
-	int sock;
-	int result;
-	int on;
-	int optlen = sizeof(int);
-	struct pollfd fdset;
-
-	if (argc < 2) {
-		printf("%s <protocol>\n", argv[0]);
-		return -1;
-	}
-
-	if (strcmp(argv[1], "stream") == 0)
-		protocol = SOCK_STREAM;
-	else
-		protocol = SOCK_DGRAM;
-
-	bzero(&saddr, sizeof (struct sockaddr_in));
-
-	if (!inet_aton(hostname, &saddr.sin_addr)) {
-		printf("error converting address\n");
-		return -1;
-	}
-
-	saddr.sin_family = AF_INET;
-	saddr.sin_port = htons(port);
-
-	if ((sock = socket(saddr.sin_family, protocol, 0)) < 0) {
-		perror("socket");
-		return -1;
-	}
-
-	if ((result = fcntl(sock, F_SETFL, O_NONBLOCK))) {
-		perror("fcntl: ");
-		return -1;
-	}
-
-	result = connect(sock, (struct sockaddr *) &saddr, sizeof (saddr));
-	if (result < 0) {
-		if (errno == EINPROGRESS) {
-			fdset.fd = sock;
-			fdset.events = POLLIN | POLLOUT;
-			result = poll(&fdset, 1, 1000);
-			if (result < 0) {
-				perror("poll: ");
-				return -1;
-			} else if (result == 0) {
-				/*
-				 * connect is taking too long,
-				 * it's probably not going to work
-				 */
-				printf("poll: no events are ready\n");
-				return -1;
-			} else if (result == 1 && fdset.revents & POLLHUP) {
-				printf("poll: connection closed\n");
-				return -1;
-			}
-		} else {
-			perror("connect");
-			close(sock);
-			return -1;
-		}
-	}
-	// We now have an open connection ...
-
-	result = getsockname(sock, (struct sockaddr *)&raddr, &rsize);
-	printf("%d", result);
-
-	result = getpeername(sock, (struct sockaddr *)&raddr, &rsize);
-	printf(" %d", result);
-
-	result = getsockopt(sock, SOL_SOCKET, SO_REUSEADDR, &on, &optlen);
-	printf(" %d", result);
-
-	result = setsockopt(sock, SOL_SOCKET, SO_REUSEADDR, &on, sizeof (on));
-	printf(" %d\n", result);
-
-	shutdown(sock, 2);
-	close(sock);
-
-	return (0);
-}
diff --git a/tests/socket/sink.c b/tests/socket/sink.c
deleted file mode 100644
index acca6bf..0000000
--- a/tests/socket/sink.c
+++ /dev/null
@@ -1,120 +0,0 @@
-#include <sys/types.h>
-#include <sys/socket.h>
-#include <netinet/in.h>
-#include <arpa/inet.h>		/* for inet_aton() */
-#include <stdlib.h>
-#include <string.h>
-#include <unistd.h>
-#include <stdio.h>
-#include<fs_secure.h>		/* for SELinux extended syscalls */
-
-static const char *hostname = "127.0.0.1";
-static const u_short port = 4000;
-static const int readbytes = 100;
-static const int on = 1;
-
-int
-main(int argc, char **argv)
-{
-	char buff[65536];
-	struct sockaddr_in saddr, raddr;
-	socklen_t rsize = sizeof (raddr);
-	int currentbytes = 0;
-	int sock;
-	int protocol;
-	int result;
-	security_id_t sid = -1;
-
-	if (argc < 2) {
-		printf("%s <protocol>\n", argv[0]);
-		return -1;
-	}
-
-	if (strcmp(argv[1], "stream") == 0)
-		protocol = SOCK_STREAM;
-	else
-		protocol = SOCK_DGRAM;
-
-	if (argc == 3)
-		sid = atoi(argv[2]);
-
-	bzero(&saddr, sizeof (struct sockaddr_in));
-	if (!inet_aton(hostname, &saddr.sin_addr)) {
-		printf("error converting address\n");
-		return -1;
-	}
-
-	saddr.sin_family = AF_INET;
-	saddr.sin_port = htons(port);
-
-	if ((sock = socket(saddr.sin_family, protocol, 0)) < 0) {
-		perror("socket");
-		return -1;
-	}
-
-	if ((result = setsockopt(sock, SOL_SOCKET, SO_REUSEADDR,
-				 &on, sizeof (on)))) {
-		perror("setsockopt: ");
-		close(sock);
-		return -1;
-	}
-	if (bind(sock, (struct sockaddr *) &saddr, sizeof (saddr)) < 0) {
-		perror("bind");
-		close(sock);
-		return -1;
-	}
-
-	if (sid != -1) {
-		struct stat statbuf;
-		security_id_t outsid;
-		(void)fstat_secure(sock, &statbuf, &outsid);
-		printf("Changing socket sid from %d to %d\n", outsid, sid);
-		(void)fchsid(sock, sid);
-	}
-
-	if (protocol == SOCK_STREAM) {
-		int remote;
-		if (listen(sock, SOMAXCONN)) {
-			close(sock);
-			return -1;
-		}
-		while (readbytes > currentbytes) {
-			remote =
-				accept(sock, (struct sockaddr *) &raddr, &rsize);
-			if (remote < 0) {
-				perror("accept: ");
-				close(sock);
-				return -1;
-			}
-			for (;;) {
-				result = read(remote, buff, 65536);
-				if (result == 0)	// EOF
-					break;
-				if (result < 0) {
-					perror("stream read failed: ");
-					close(sock);
-					return -1;
-				}
-				currentbytes += result;
-				printf("recv: %5d bytes, %5d total\n", result,
-				       currentbytes);
-				if (currentbytes >= readbytes)
-					break;
-			}
-		}
-	} else {
-		for (;;) {
-			result = recvfrom(sock, buff, 65536, 0,
-					  (struct sockaddr *) &raddr, &rsize);
-			currentbytes += result;
-			printf("recv: %5d bytes, %5d total\n", result,
-			       currentbytes);
-			if (currentbytes >= readbytes)
-				break;
-		}
-	}
-
-	shutdown(sock, 2);
-	close(sock);
-	return (0);
-}
diff --git a/tests/socket/source.c b/tests/socket/source.c
deleted file mode 100644
index 412d2a9..0000000
--- a/tests/socket/source.c
+++ /dev/null
@@ -1,95 +0,0 @@
-#include <sys/types.h>
-#include <sys/socket.h>
-#include <netinet/in.h>
-#include <arpa/inet.h>		/* for inet_aton() */
-#include <sys/poll.h>
-#include <stdlib.h>
-#include <stdio.h>
-#include <string.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <errno.h>
-
-static const char *hostname = "127.0.0.1";
-static const u_short port = 4000;
-static const int sendbytes = 100;	/* Send this much data */
-
-int
-main(int argc, char **argv)
-{
-	char data[sendbytes];
-	struct sockaddr_in saddr;
-	int protocol;
-	int sock;
-	int result;
-	struct pollfd fdset;
-
-	memset(data, 'X', sendbytes);
-
-	if (argc < 2) {
-		printf("%s <protocol>\n", argv[0]);
-		return -1;
-	}
-
-	if (strcmp(argv[1], "stream") == 0)
-		protocol = SOCK_STREAM;
-	else
-		protocol = SOCK_DGRAM;
-
-	bzero(&saddr, sizeof (struct sockaddr_in));
-
-	if (!inet_aton(hostname, &saddr.sin_addr)) {
-		printf("error converting address\n");
-		return -1;
-	}
-
-	saddr.sin_family = AF_INET;
-	saddr.sin_port = htons(port);
-
-	if ((sock = socket(saddr.sin_family, protocol, 0)) < 0) {
-		perror("socket");
-		return -1;
-	}
-
-	if ((result = fcntl(sock, F_SETFL, O_NONBLOCK))) {
-		perror("fcntl: ");
-		return -1;
-	}
-	result = connect(sock, (struct sockaddr *) &saddr, sizeof (saddr));
-	if (result < 0) {
-		if (errno == EINPROGRESS) {
-			fdset.fd = sock;
-			fdset.events = POLLIN | POLLOUT;
-			result = poll(&fdset, 1, 1000);
-			if (result < 0) {
-				perror("poll: ");
-				return -1;
-			} else if (result == 0) {
-				/*
-				 * connect is taking too long,
-				 * it's probably not going to work
-				 */
-				printf("poll: no events are ready\n");
-				return -1;
-			} else if (result == 1 && fdset.revents & POLLHUP) {
-				printf("poll: connection closed\n");
-				return -1;
-			}
-		} else {
-			perror("connect");
-			close(sock);
-			return -1;
-		}
-	}
-
-	result = write(sock, data, sendbytes);
-	if (result != sendbytes) {
-		printf("Bad write %d of %d\n", result, sendbytes);
-		return -1;
-	}
-	printf("sent %5d bytes\n", result);
-	shutdown(sock, 2);
-	close(sock);
-
-	return (0);
-}
diff --git a/tests/socket/test b/tests/socket/test
deleted file mode 100755
index c0530f9..0000000
--- a/tests/socket/test
+++ /dev/null
@@ -1,88 +0,0 @@
-#!/usr/bin/perl
-
-use Test;
-BEGIN { plan tests => 11}
-
-$basedir = $0;  $basedir =~ s|(.*)/[^/]*|$1|;
-
-if (($pid = fork()) == 0) {
-    $result = system "runas -t test_socket_base_t $basedir/sink stream";
-    exit;
-}
-
-sleep 1; # Need to slow down and give the server time to start...
-
-# Check permissions for basic socket operations
-$output = `runas -t test_socket_base_t -- $basedir/options stream`;
-&reformat_results($output, 0);
-
-# Try to connect to the server from a domain that doesn't have recvfrom
-# permission (this should fail).
-$result = system "runas -t test_socket_norecv_t -- $basedir/source stream";
-ok($result);
-
-# Try to connect to the server from a domain that doesn't have connectto
-# permission (this should fail).
-$result = system "runas -t test_socket_noconnect_t -- $basedir/source stream";
-ok($result);
-
-# Default policy allows domains to perform any access on 
-# sockets that they created.
-$result = system "runas -t test_socket_base_t -- $basedir/source stream";
-ok($result, 0);
-
-if (($pid = fork()) == 0) {
-    $result = system "runas -t test_socket_base_t $basedir/sink udp";
-    exit;
-}
-
-sleep 1; # Need to slow down and give the server time to start...
-
-# Domain can't create socket
-$result = system "runas -t test_socket_none_t -- $basedir/source udp";
-ok($result);
-
-$result = system "runas -t test_socket_base_t -- $basedir/source udp";
-ok($result, 0);
-#print "test1: $result\n";
-
-# Test the acceptfrom permission.  The server process does not have the
-# acceptfrom permission, so the sending process will fail.
-if (($pid = fork()) == 0) {
-    exec "runas -t test_socket_noconnect_t $basedir/sink stream";
-}
-
-sleep 1; # Need to slow down and give the server time to start...
-
-$result = system "runas -t test_socket_base_t -- $basedir/source stream";
-ok($result);
-# Kill the child server to clean up after the test.
-#print "Kill process $pid\n";
-kill 9, $pid;
-
-#
-# Get the SID to transition to after opening the socket
-#
-$output = `id`;
-$output =~ /uid=\d+\((\w+)\).*context=(\w+):(\w+):(\w+)/ || die ("Can't determine user's id\n");
-$user = $2;
-$role = $3;
-$new_sid = `context_to_sid $user:$role:test_socket_noaccept_t`;
-chop($new_sid);
-
-$result = system "runas -t test_socket_base_t $basedir/noaccept $new_sid";
-ok($result);
-
-
-exit;
-
-# ================================================================= #
-# Miscellaneous Routines                                            #
-# ================================================================= #
-sub reformat_results {
-	$list = shift;
-	$expected = shift;
-	for (split (' ', $list)) {
-		ok($_, $expected);
-	}
-}
diff --git a/tests/unix_secure/Makefile b/tests/unix_secure/Makefile
deleted file mode 100644
index 630c0b2..0000000
--- a/tests/unix_secure/Makefile
+++ /dev/null
@@ -1,11 +0,0 @@
-ctargets = server client checksyscalls
-
-selinuxhome = /usr/local/selinux
-LDFLAGS = -L$(selinuxhome)/lib
-LDLIBS = -lsecure
-CFLAGS = -I$(selinuxhome)/include
-CFLAGS+=-Wall
-
-all: $(ctargets)
-clean:
-	rm -f $(ctargets) *.o *~
diff --git a/tests/unix_secure/checksyscalls.c b/tests/unix_secure/checksyscalls.c
deleted file mode 100644
index face8c4..0000000
--- a/tests/unix_secure/checksyscalls.c
+++ /dev/null
@@ -1,28 +0,0 @@
-#include <sys/types.h>
-#include <sys/socket.h>
-#include <unistd.h>
-#include <errno.h>
-#include <stdio.h>
-
-#include <socket_secure.h>
-
-int
-main(int argc, char **argv)
-{
-	int sock;
-	security_id_t socket_sid = 0;
-
-	sock = socket_secure(AF_INET, SOCK_STREAM, 0, socket_sid);
-
-	if (sock < 0) {
-		perror("socket");
-		if (errno == ENOSYS) {
-			printf("Extended socket system calls are unimplemented\n");
-			return -1;
-		}
-		return -2;
-	}
-	close(sock);
-	printf("Extended socket syscalls present.\n");
-	return (0);
-}
diff --git a/tests/unix_secure/client.c b/tests/unix_secure/client.c
deleted file mode 100644
index 755fd93..0000000
--- a/tests/unix_secure/client.c
+++ /dev/null
@@ -1,126 +0,0 @@
-#include <sys/types.h>
-#include <sys/socket.h>
-#include <sys/un.h>
-#include <netinet/in.h>
-#include <arpa/inet.h>		/* for inet_aton() */
-#include <sys/poll.h>
-#include <stdlib.h>
-#include <stdio.h>
-#include <string.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <errno.h>
-
-#include <socket_secure.h>
-#include <ss.h>
-
-static const char *filename = "unix_test_socket";
-static const int sendbytes = 100;	/* Send this much data */
-
-int
-main(int argc, char **argv)
-{
-	char data[sendbytes];
-	struct sockaddr_un sun, raddr;
-	int rsize;
-	int bad = 0;
-	int sunlen, sock, result;
-	struct pollfd fdset;
-	security_id_t socket_sid = 0;
-	security_id_t peer_sid = 0;
-	security_id_t client_sid, read_sid;
-
-	memset(data, 'X', sendbytes);
-
-	if (argc > 1)
-		socket_sid = atoi(argv[1]);
-	if (argc > 2)
-		peer_sid = atoi(argv[2]);
-
-	if (socket_sid)
-		sock = socket_secure(AF_UNIX, SOCK_STREAM, 0, socket_sid);
-	else
-		sock = socket(AF_UNIX, SOCK_STREAM, 0);
-
-	if (sock < 0) {
-		perror("socket");
-		return -1;
-	}
-
-	rsize = sizeof (struct sockaddr_un);
-	result = getsockname_secure(sock, (struct sockaddr *) &raddr,
-				    &rsize, &client_sid);
-	if (result) {
-		perror("getsockname_secure");
-		exit(1);
-	}
-
-	bzero(&sun, sizeof (struct sockaddr_un));
-	sun.sun_family = AF_UNIX;
-	strcpy(sun.sun_path, filename);
-	sunlen = strlen(sun.sun_path) + 1 + sizeof (short);
-
-	if (peer_sid) {
-		result = connect_secure(sock, (struct sockaddr *) &sun,
-					sunlen, peer_sid);
-		/* printf("connect_secure with peer sid %d\n", peer_sid); */
-	} else {
-		result =
-			connect(sock, (struct sockaddr *) &sun, sunlen);
-	}
-	if (result < 0) {
-		if (errno == EINPROGRESS) {
-			fdset.fd = sock;
-			fdset.events = POLLIN | POLLOUT;
-			result = poll(&fdset, 1, 3000);
-			if (result < 0) {
-				perror("poll: ");
-				return -1;
-			} else if (result == 0) {
-				/*
-				 * connect is taking too long,
-				 * it's probably not going to work
-				 */
-				printf("poll: no events are ready\n");
-				return -1;
-			} else if (result == 1 && fdset.revents & POLLHUP) {
-				printf("poll: connection closed\n");
-				return -1;
-			}
-		} else {
-			perror("connect");
-			close(sock);
-			return -1;
-		}
-	}
-
-	result = write(sock, data, sendbytes);
-	if (result != sendbytes) {
-		printf("Bad write %d of %d\n", result, sendbytes);
-		return -1;
-	}
-
-	result = read(sock, data, 65536);
-	if (result <= 0) {
-		perror("stream read failed: ");
-		close(sock);
-		return -1;
-	}
-
-	read_sid = atoi(data);
-	if (read_sid != client_sid) {
-		bad++;
-		/* printf("client sid %d, read back sid %d\n",
-		   client_sid, read_sid); */
-	}
-
-	shutdown(sock, 2);
-	close(sock);
-
-	/*
-	 * Return the number of bad connections, where the server
-	 * returned something other than the sid of this client's
-	 * socket
-	 */
-	return (bad);
-}
diff --git a/tests/unix_secure/client.pl b/tests/unix_secure/client.pl
deleted file mode 100644
index 055ce35..0000000
--- a/tests/unix_secure/client.pl
+++ /dev/null
@@ -1,68 +0,0 @@
-#!/usr/bin/perl
-
-$basedir = $0;  $basedir =~ s|(.*)/[^/]*|$1|;
-$count = shift @ARGV;
-
-if (($pid = fork()) == 0) {
-    $bad = 0;
-    for ($i = 0; $i < $count; $i++) {
-	#print "A";
-	$result = system "runas -t test_socket_base_t -- $basedir/client";
-	if ($result != 0) { $bad++; }
-    }
-    print "ok($bad,0);\n";
-    exit;
-}
-
-if (($pid = fork()) == 0) {
-    $bad = 0;
-    for ($i = 0; $i < $count; $i++) {
-	#print "B";
-	$result = system "runas -t test_socket_secondary_t -- $basedir/client";
-	if ($result != 0) { $bad++; }
-    }
-    print "ok($bad,0);\n";
-    exit;
-}
-
-if (($pid = fork()) == 0) {
-    $bad = 0;
-    for ($i = 0; $i < $count; $i++) {
-	#print "C";
-	$result = system "runas -t test_socket_base_t -- $basedir/client";
-	if ($result != 0) { $bad++; }
-    }
-    print "ok($bad,0);\n";
-    exit;
-}
-
-if (($pid = fork()) == 0) {
-    $bad = 0;
-    for ($i = 0; $i < $count; $i++) {
-	#print "D";
-	$result = system "runas -t test_socket_secondary_t -- $basedir/client";
-	if ($result != 0) { $bad++; }
-    }
-    print "ok($bad,0);\n";
-    exit;
-}
-
-if (($pid = fork()) == 0) {
-    $bad = 0;
-    for ($i = 0; $i < $count; $i++) {
-	#print "E";
-	$result = system "runas -t test_socket_base_t -- $basedir/client";
-	if ($result != 0) { $bad++; }
-    }
-    print "ok($bad,0);\n";
-    exit;
-}
-
-for ($i = 0; $i < $count; $i++) {
-    $bad = 0;
-    #print "F";
-    $result = system "runas -t test_socket_secondary_t -- $basedir/client";
-    if ($result != 0) { $bad++; }
-}
-print "ok($bad,0);\n";
-exit;
diff --git a/tests/unix_secure/client2.pl b/tests/unix_secure/client2.pl
deleted file mode 100644
index 4be9d07..0000000
--- a/tests/unix_secure/client2.pl
+++ /dev/null
@@ -1,79 +0,0 @@
-#!/usr/bin/perl
-
-$basedir = $0;  $basedir =~ s|(.*)/[^/]*|$1|;
-$output = `id`;
-$output =~ /uid=\d+\((\w+)\).*context=(\w+):(\w+):(\w+)/ || die ("Can't determine user's id\n");
-$user = $2;
-$role = $3;
-
-$socket_sid = `context_to_sid $user:$role:test_socket_base_t`;
-$second_sid = `context_to_sid $user:$role:test_socket_secondary_t`;
-chop($socket_sid);
-chop($second_sid);
-
-$count = shift @ARGV;
-
-
-if (($pid = fork()) == 0) {
-    $bad = 0;
-    for ($i = 0; $i < $count; $i++) {
-	#print "A";
-	$result = system "runas -t test_socket_base_t -- $basedir/client $second_sid $socket_sid";
-	if ($result != 0) { $bad++; }
-    }
-    print "ok($bad,0);\n";
-    exit;
-}
-
-if (($pid = fork()) == 0) {
-    $bad = 0;
-    for ($i = 0; $i < $count; $i++) {
-	#print "B";
-	$result = system "runas -t test_socket_base_t -- $basedir/client $socket_sid $socket_sid";
-	if ($result != 0) { $bad++; }
-    }
-    print "ok($bad,0);\n";
-    exit;
-}
-
-if (($pid = fork()) == 0) {
-    $bad = 0;
-    for ($i = 0; $i < $count; $i++) {
-	#print "C";
-	$result = system "runas -t test_socket_base_t -- $basedir/client $second_sid $socket_sid";
-	if ($result != 0) { $bad++; }
-    }
-    print "ok($bad,0);\n";
-    exit;
-}
-
-if (($pid = fork()) == 0) {
-    $bad = 0;
-    for ($i = 0; $i < $count; $i++) {
-	#print "D";
-	$result = system "runas -t test_socket_base_t -- $basedir/client $socket_sid $socket_sid";
-	if ($result != 0) { $bad++; }
-    }
-    print "ok($bad,0);\n";
-    exit;
-}
-
-if (($pid = fork()) == 0) {
-    $bad = 0;
-    for ($i = 0; $i < $count; $i++) {
-	#print "E";
-	$result = system "runas -t test_socket_base_t -- $basedir/client $second_sid $socket_sid";
-	if ($result != 0) { $bad++; }
-    }
-    print "ok($bad,0);\n";
-    exit;
-}
-
-for ($i = 0; $i < $count; $i++) {
-    $bad = 0;
-    #print "F";
-	$result = system "runas -t test_socket_base_t -- $basedir/client $socket_sid $socket_sid";
-    if ($result != 0) { $bad++; }
-}
-print "ok($bad,0);\n";
-exit;
diff --git a/tests/unix_secure/server.c b/tests/unix_secure/server.c
deleted file mode 100644
index 1e45af6..0000000
--- a/tests/unix_secure/server.c
+++ /dev/null
@@ -1,168 +0,0 @@
-#include <sys/types.h>
-#include <sys/socket.h>
-#include <sys/un.h>
-#include <netinet/in.h>
-#include <arpa/inet.h>		/* for inet_aton() */
-#include <stdlib.h>
-#include <string.h>
-#include <unistd.h>
-#include <stdio.h>
-
-#include <socket_secure.h>
-#include <ss.h>
-
-static const char *filename = "unix_test_socket";
-static const int readbytes = 2000;
-static const int on = 1;
-
-#define MAXSTAT 10
-static security_id_t sids[MAXSTAT];
-static unsigned int conncount[MAXSTAT];
-
-void
-initStats()
-{
-	memset(sids, '\0', MAXSTAT * sizeof (security_id_t));
-	memset(conncount, '\0', MAXSTAT * sizeof (unsigned int));
-}
-
-static inline void
-updateStats(security_id_t sid)
-{
-	int i;
-	for (i = 0; i < MAXSTAT; i++) {
-		if (sids[i] == sid) {
-			conncount[i]++;
-			return;
-		}
-	}
-	/* not found */
-	for (i = 0; i < MAXSTAT; i++) {
-		if (sids[i] == 0) {
-			sids[i] = sid;
-			conncount[i]++;
-			return;
-		}
-	}
-	printf("sid table out of space\n");
-}
-
-void
-printStats()
-{
-	int i;
-	char context[255];
-	int contextlen;
-
-	/* First the script-parseable output */
-	for (i = 0; i < MAXSTAT; i++) {
-		if (sids[i] != 0) {
-			printf("(%d,%d) ", sids[i], conncount[i]);
-		}
-	}
-	printf("\nServer connection statistics:\n");
-	printf("  count    SID  Context\n");
-	for (i = 0; i < MAXSTAT; i++) {
-		if (sids[i] != 0) {
-			contextlen = sizeof (context);
-			if (security_sid_to_context
-			    (sids[i], context, &contextlen)) {
-				perror("security_sid_to_context");
-				exit(1);
-			}
-			printf("%7d  %5d  %s\n", conncount[i], sids[i],
-			       context);
-		}
-	}
-}
-
-int
-main(int argc, char **argv)
-{
-	char buff[65536], context[255];
-	int maxcons = 100;
-	int sunlen, rsize, remote, sock, result, contextlen, connections;
-	security_id_t socket_sid = 0;
-	security_id_t peer_sid;
-	struct sockaddr_un sun, raddr;
-
-	initStats();
-	if (argc > 1)
-		maxcons = atoi(argv[1]);
-	if (argc > 2)
-		socket_sid = atoi(argv[2]);
-
-	if (socket_sid)
-		sock = socket_secure(AF_UNIX, SOCK_STREAM, 0, socket_sid);
-	else
-		sock = socket(AF_UNIX, SOCK_STREAM, 0);
-
-	if (sock < 0) {
-		perror("socket");
-		return -1;
-	}
-
-	if ((result = setsockopt(sock, SOL_SOCKET, SO_REUSEADDR,
-				 &on, sizeof (on)))) {
-		perror("setsockopt: ");
-		close(sock);
-		return -1;
-	}
-
-	bzero(&sun, sizeof (struct sockaddr_un));
-	sun.sun_family = AF_UNIX;
-	strcpy(sun.sun_path, filename);
-	sunlen = strlen(sun.sun_path) + 1 + sizeof (short);
-
-	if (bind(sock, (struct sockaddr *) &sun, sunlen) < 0) {
-		perror("bind");
-		close(sock);
-		return -1;
-	}
-
-	if (listen(sock, SOMAXCONN)) {
-		close(sock);
-		return -1;
-	}
-
-	connections = 0;
-	while (connections < maxcons) {
-		connections++;
-		rsize = sizeof (raddr);
-		remote = accept_secure(sock, (struct sockaddr *) &raddr,
-				       &rsize, &peer_sid);
-		if (remote < 0) {
-			perror("accept: ");
-			close(sock);
-			return -1;
-		}
-		contextlen = sizeof (context);
-		result = security_sid_to_context(peer_sid, context,
-						 &contextlen);
-		if (result) {
-			perror("security_sid_to_context");
-			exit(1);
-		}
-
-		updateStats(peer_sid);
-		for (;;) {
-			result = read(remote, buff, 65536);
-			if (result == 0)	// EOF
-				break;
-			if (result < 0) {
-				perror("stream read failed: ");
-				close(sock);
-				return -1;
-			}
-			result = snprintf(buff, 65536, "%d", peer_sid);
-			result = write(remote, buff, result + 1);
-		}
-		close(remote);
-		/* usleep (100000); */
-	}
-
-	shutdown(sock, 2);
-	close(sock);
-	printStats();
-	return (0);
-}
diff --git a/tests/unix_secure/test b/tests/unix_secure/test
deleted file mode 100755
index 6e931be..0000000
--- a/tests/unix_secure/test
+++ /dev/null
@@ -1,64 +0,0 @@
-#!/usr/bin/perl
-
-use Test;
-BEGIN { plan tests => 12}
-$basedir = $0;  $basedir =~ s|(.*)/[^/]*|$1|;
-
-$result = system "$basedir/checksyscalls";
-if ($result != 0) {
-    print "Secure sockets not implemented, skipping tests\n";
-    for ($i = 0; $i < 12; $i++) {
-	ok(1);
-    }
-    exit;
-}
-
-$output = `id`;
-$output =~ /uid=\d+\((\w+)\).*context=(\w+):(\w+):(\w+)/ || die ("Can't determine user's id\n");
-$user = $2;
-$role = $3;
-
-$socket_sid = `context_to_sid $user:$role:test_socket_base_t`;
-$second_sid = `context_to_sid $user:$role:test_socket_secondary_t`;
-chop($socket_sid);
-chop($second_sid);
-
-$basedir = $0;  $basedir =~ s|(.*)/[^/]*|$1|;
-$count = 100;
-$servercount = $count * 6;
-if (($pid = fork()) == 0) {
-    unlink unix_test_socket;
-    $output = `runas -t test_socket_base_t -- $basedir/server $servercount`;
-    exit;
-}
-
-$output = `$basedir/client.pl $count`;
-eval $output;
-
-kill 9, $pid; # just in case :)
-unlink unix_test_socket;
-
-#
-# Do the same thing, but use explicit SIDs
-#
-if (($pid = fork()) == 0) {
-    $output = `runas -t test_socket_base_t -- $basedir/server $servercount $socket_sid`;
-    exit;
-}
-$output = `$basedir/client2.pl $count`;
-kill 9, $pid; # just in case :)
-eval $output;
-
-unlink unix_test_socket;
-
-exit;
-
-# In addition to testing socket listen queues and peer labeling, it
-# tests for successful operation of the following secure socket system
-# calls:
-#       socket_secure
-#       getsockname_secure
-#       connect_secure
-#       getpeername_secure
-#       accept_secure
-
diff --git a/tests/unix_socket/Makefile b/tests/unix_socket/Makefile
index fd017cf..5266096 100644
--- a/tests/unix_socket/Makefile
+++ b/tests/unix_socket/Makefile
@@ -1,4 +1,7 @@
-CFLAGS+=-Wall
-all: $(ctargets)
+TARGETS=client server
+
+LDLIBS+= -lselinux
+
+all: $(TARGETS)
 clean:
-	rm -f $(ctargets) *.o *~
+	rm -f $(TARGETS)
diff --git a/tests/unix_socket/client.c b/tests/unix_socket/client.c
new file mode 100644
index 0000000..565e71b
--- /dev/null
+++ b/tests/unix_socket/client.c
@@ -0,0 +1,105 @@
+#include <sys/types.h>
+#include <sys/socket.h>
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
+		"usage:  %s [stream|dgram] local-socket-name remote-socket-name\n",
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
+	struct sockaddr_un sun, remotesun;
+	socklen_t sunlen, remotesunlen;
+	int type;
+	char *mycon;
+
+	if (argc != 4)
+		usage(argv[0]);
+
+	if (!strcmp(argv[1], "stream"))
+		type = SOCK_STREAM;
+	else if (!strcmp(argv[1], "dgram"))
+		type = SOCK_DGRAM;
+	else
+		usage(argv[0]);
+
+	sock = socket(AF_UNIX, type, 0);
+	if (sock < 0) {
+		perror("socket");
+		exit(1);
+	}
+
+	bzero(&sun, sizeof(struct sockaddr_un));
+	sun.sun_family = AF_UNIX;
+	sun.sun_path[0] = 0;
+	strcpy(&sun.sun_path[1], argv[2]);
+	sunlen = offsetof(struct sockaddr_un, sun_path) +
+		 strlen(&sun.sun_path[1]) + 1;
+
+	if (bind(sock, (struct sockaddr *) &sun, sunlen) < 0) {
+		perror("bind");
+		close(sock);
+		exit(1);
+	}
+
+	bzero(&remotesun, sizeof(struct sockaddr_un));
+	remotesun.sun_family = AF_UNIX;
+	remotesun.sun_path[0] = 0;
+	strcpy(&remotesun.sun_path[1], argv[3]);
+	remotesunlen = offsetof(struct sockaddr_un,
+				sun_path) + strlen(&remotesun.sun_path[1]) + 1;
+
+	result = connect(sock, (struct sockaddr *) &remotesun, remotesunlen);
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
diff --git a/tests/unix_socket/server.c b/tests/unix_socket/server.c
new file mode 100644
index 0000000..2532de7
--- /dev/null
+++ b/tests/unix_socket/server.c
@@ -0,0 +1,164 @@
+#define _GNU_SOURCE
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <sys/un.h>
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
+	fprintf(stderr, "usage:  %s [stream|dgram] socket-name\n", progname);
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
+	struct sockaddr_un sun, remotesun;
+	socklen_t sunlen, remotesunlen;
+	int type;
+	char byte;
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
+	sock = socket(AF_UNIX, type, 0);
+	if (sock < 0) {
+		perror("socket");
+		exit(1);
+	}
+
+	result = setsockopt(sock, SOL_SOCKET, SO_PASSSEC, &on, sizeof(on));
+	if (result < 0) {
+		perror("setsockopt: SO_PASSSEC");
+		close(sock);
+		exit(1);
+	}
+
+	bzero(&sun, sizeof(struct sockaddr_un));
+	sun.sun_family = AF_UNIX;
+	sun.sun_path[0] = 0;
+	strcpy(&sun.sun_path[1], argv[2]);
+	sunlen = offsetof(struct sockaddr_un, sun_path) +
+		 strlen(&sun.sun_path[1]) + 1;
+
+	if (bind(sock, (struct sockaddr *) &sun, sunlen) < 0) {
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
+		newsock = accept(sock, (struct sockaddr *)&remotesun,
+				 &remotesunlen);
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
+		msg.msg_name = &remotesun;
+		msg.msg_namelen = remotesunlen;
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
+			if (cmsg->cmsg_level == SOL_SOCKET &&
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
diff --git a/tests/unix_socket/test b/tests/unix_socket/test
index 04a11a0..0badf63 100755
--- a/tests/unix_socket/test
+++ b/tests/unix_socket/test
@@ -1,64 +1,44 @@
 #!/usr/bin/perl
 
 use Test;
-BEGIN { plan tests => 8}
-
-$UNIX_SOCKET_NAME = "unix_test_socket";
+BEGIN { plan tests => 4}
 
 $basedir = $0;  $basedir =~ s|(.*)/[^/]*|$1|;
 
-# Just in case, remove any old files.
-unlink $UNIX_SOCKET_NAME;
-
+# Start the stream server.
 if (($pid = fork()) == 0) {
-    $result = system "runas -t test_socket_base_t $basedir/unix_sink stream";
-    exit;
+    exec "runcon -t test_unix_server_t $basedir/server stream test_server_sock";
 }
 
-sleep 1; # Need to slow down and give the server time to start...
+sleep 1; # Give it a moment to initialize.
 
-# Check permissions for basic socket operations
-$output = `runas -t test_socket_base_t -- $basedir/unix_options stream`;
-&reformat_results($output, 0);
+# Verify that stream client can connectto server.
+$result = system "runcon -t test_unix_stream_client_t $basedir/client stream test_client_sock test_server_sock";
+ok($result, 0);
 
-# Try to connect to the server from a domain that doesn't have connectto
-# permission (this should fail).
-$result = system "runas -t test_socket_noconnect_t -- $basedir/unix_source stream";
+# Verify that dgram client cannot connectto to server.
+$result = system "runcon -t test_unix_dgram_client_t -- $basedir/client stream test_client_sock test_server_sock 2>&1";
 ok($result);
 
-# Default policy allows domains to perform any access on 
-# sockets that they created.
-$result = system "runas -t test_socket_base_t -- $basedir/unix_source stream";
-ok($result, 0);
-
-unlink $UNIX_SOCKET_NAME;
+# Kill the server.
+kill TERM, $pid;
 
+# Start the dgram server.
 if (($pid = fork()) == 0) {
-    $result = system "runas -t test_socket_base_t $basedir/unix_sink udp";
-    exit;
+    exec "runcon -t test_unix_server_t $basedir/server dgram test_server_sock";
 }
 
-sleep 1; # Need to slow down and give the server time to start...
+sleep 1; # Give it a moment to initialize
 
-# Domain can't send messages socket; fails sendto check
-$result = system "runas -t test_socket_none_t -- $basedir/unix_source udp";
-ok($result);
-
-$result = system "runas -t test_socket_base_t -- $basedir/unix_source udp";
+# Verify that dgram client can sendto server.
+$result = system "runcon -t test_unix_dgram_client_t $basedir/client dgram test_client_sock test_server_sock";
 ok($result, 0);
-#print "test1: $result\n";
 
-unlink $UNIX_SOCKET_NAME;
+# Verify that stream client cannot sendto server.
+$result = system "runcon -t test_unix_stream_client_t -- $basedir/client dgram test_client_sock test_server_sock 2>&1";
+ok($result);
 
-exit;
+# Kill the server.
+kill TERM, $pid;
 
-# ================================================================= #
-# Miscellaneous Routines                                            #
-# ================================================================= #
-sub reformat_results {
-	$list = shift;
-	$expected = shift;
-	for (split (' ', $list)) {
-		ok($_, $expected);
-	}
-}
+exit;
diff --git a/tests/unix_socket/unix_options.c b/tests/unix_socket/unix_options.c
deleted file mode 100644
index dc1d4c9..0000000
--- a/tests/unix_socket/unix_options.c
+++ /dev/null
@@ -1,106 +0,0 @@
-#include <sys/types.h>
-#include <sys/socket.h>
-#include <sys/un.h>
-#include <netinet/in.h>
-#include <arpa/inet.h>		/* for inet_aton() */
-#include <sys/poll.h>
-#include <stdlib.h>
-#include <stdio.h>
-#include <string.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <errno.h>
-
-static const char *filename = "unix_test_socket";
-static const int sendbytes = 100;	/* Send this much data */
-
-int
-main(int argc, char **argv)
-{
-	struct sockaddr_un sun;
-	struct sockaddr_in raddr;
-	socklen_t rsize = sizeof (raddr);
-	int sunlen;
-	int protocol;
-	int sock;
-	int result;
-	int on;
-	int abstract = 0;
-	int optlen = sizeof (int);
-	struct pollfd fdset;
-
-	if (argc < 2) {
-		printf("%s <protocol>\n", argv[0]);
-		return -1;
-	}
-
-	if (strcmp(argv[1], "stream") == 0)
-		protocol = SOCK_STREAM;
-	else
-		protocol = SOCK_DGRAM;
-
-	if ((sock = socket(AF_UNIX, protocol, 0)) < 0) {
-		perror("socket");
-		return -1;
-	}
-
-	if ((result = fcntl(sock, F_SETFL, O_NONBLOCK))) {
-		perror("fcntl: ");
-		return -1;
-	}
-
-	bzero(&sun, sizeof (struct sockaddr_un));
-	sun.sun_family = AF_UNIX;
-	if (abstract) {
-		sun.sun_path[0] = 0;
-		strcpy(sun.sun_path + 1, filename);
-		sunlen = strlen(sun.sun_path + 1) + 1 + sizeof (short);
-	} else {
-		strcpy(sun.sun_path, filename);
-		sunlen = strlen(sun.sun_path) + 1 + sizeof (short);
-	}
-
-	result = connect(sock, (struct sockaddr *) &sun, sunlen);
-	if (result < 0) {
-		if (errno == EINPROGRESS) {
-			fdset.fd = sock;
-			fdset.events = POLLIN | POLLOUT;
-			result = poll(&fdset, 1, 1000);
-			if (result < 0) {
-				perror("poll: ");
-				return -1;
-			} else if (result == 0) {
-				/*
-				 * connect is taking too long,
-				 * it's probably not going to work
-				 */
-				printf("poll: no events are ready\n");
-				return -1;
-			} else if (result == 1 && fdset.revents & POLLHUP) {
-				printf("poll: connection closed\n");
-				return -1;
-			}
-		} else {
-			perror("connect");
-			close(sock);
-			return -1;
-		}
-	}
-	// We now have an open connection ...
-	result = getsockname(sock, (struct sockaddr *) &raddr, &rsize);
-	printf("%d", result);
-
-	result = getpeername(sock, (struct sockaddr *) &raddr, &rsize);
-	printf(" %d", result);
-
-	result = getsockopt(sock, SOL_SOCKET, SO_REUSEADDR, &on, &optlen);
-	printf(" %d", result);
-
-	result = setsockopt(sock, SOL_SOCKET, SO_REUSEADDR, &on, sizeof (on));
-	printf(" %d\n", result);
-
-	shutdown(sock, 2);
-	close(sock);
-
-	return (0);
-}
diff --git a/tests/unix_socket/unix_sink.c b/tests/unix_socket/unix_sink.c
deleted file mode 100644
index f7b9718..0000000
--- a/tests/unix_socket/unix_sink.c
+++ /dev/null
@@ -1,126 +0,0 @@
-#include <sys/types.h>
-#include <sys/socket.h>
-#include <sys/un.h>
-#include <netinet/in.h>
-#include <arpa/inet.h>		/* for inet_aton() */
-#include <stdlib.h>
-#include <string.h>
-#include <unistd.h>
-#include <stdio.h>
-#include<fs_secure.h>		/* for SELinux extended syscalls */
-
-static const char *filename = "unix_test_socket";
-static const int readbytes = 100;
-static const int on = 1;
-
-int
-main(int argc, char **argv)
-{
-	char buff[65536];
-	struct sockaddr_in saddr, raddr;
-	socklen_t rsize = sizeof (raddr);
-	int currentbytes = 0;
-	int sock;
-	int protocol;
-	int result;
-	int sunlen;
-	security_id_t sid = -1;
-	struct sockaddr_un sun;
-	int abstract = 0;
-
-	if (argc < 2) {
-		printf("%s <protocol>\n", argv[0]);
-		return -1;
-	}
-
-	if (strcmp(argv[1], "stream") == 0)
-		protocol = SOCK_STREAM;
-	else
-		protocol = SOCK_DGRAM;
-
-	if (argc == 3)
-		sid = atoi(argv[2]);
-
-	if ((sock = socket(AF_UNIX, protocol, 0)) < 0) {
-		perror("socket");
-		return -1;
-	}
-
-	if ((result = setsockopt(sock, SOL_SOCKET, SO_REUSEADDR,
-				 &on, sizeof (on)))) {
-		perror("setsockopt: ");
-		close(sock);
-		return -1;
-	}
-
-	bzero(&sun, sizeof (struct sockaddr_un));
-	sun.sun_family = AF_UNIX;
-	if (abstract) {
-		sun.sun_path[0] = 0;
-		strcpy(sun.sun_path + 1, filename);
-		sunlen = strlen(sun.sun_path + 1) + 1 + sizeof (short);
-	} else {
-		strcpy(sun.sun_path, filename);
-		sunlen = strlen(sun.sun_path) + 1 + sizeof (short);
-	}
-
-	if (bind(sock, (struct sockaddr *) &sun, sunlen) < 0) {
-		perror("bind");
-		close(sock);
-		return -1;
-	}
-
-	if (sid != -1) {
-		struct stat statbuf;
-		security_id_t outsid;
-		(void) fstat_secure(sock, &statbuf, &outsid);
-		printf("Changing socket sid from %d to %d\n", outsid, sid);
-		(void) fchsid(sock, sid);
-	}
-
-	if (protocol == SOCK_STREAM) {
-		int remote;
-		if (listen(sock, SOMAXCONN)) {
-			close(sock);
-			return -1;
-		}
-		while (readbytes > currentbytes) {
-			remote =
-				accept(sock, (struct sockaddr *) &raddr, &rsize);
-			if (remote < 0) {
-				perror("accept: ");
-				close(sock);
-				return -1;
-			}
-			for (;;) {
-				result = read(remote, buff, 65536);
-				if (result == 0)	// EOF
-					break;
-				if (result < 0) {
-					perror("stream read failed: ");
-					close(sock);
-					return -1;
-				}
-				currentbytes += result;
-				printf("recv: %5d bytes, %5d total\n", result,
-				       currentbytes);
-				if (currentbytes >= readbytes)
-					break;
-			}
-		}
-	} else {
-		for (;;) {
-			result = recvfrom(sock, buff, 65536, 0,
-					  (struct sockaddr *) &raddr, &rsize);
-			currentbytes += result;
-			printf("recv: %5d bytes, %5d total\n", result,
-			       currentbytes);
-			if (currentbytes >= readbytes)
-				break;
-		}
-	}
-
-	shutdown(sock, 2);
-	close(sock);
-	return (0);
-}
diff --git a/tests/unix_socket/unix_source.c b/tests/unix_socket/unix_source.c
deleted file mode 100644
index 09bf381..0000000
--- a/tests/unix_socket/unix_source.c
+++ /dev/null
@@ -1,99 +0,0 @@
-#include <sys/types.h>
-#include <sys/socket.h>
-#include <sys/un.h>
-#include <netinet/in.h>
-#include <arpa/inet.h>		/* for inet_aton() */
-#include <sys/poll.h>
-#include <stdlib.h>
-#include <stdio.h>
-#include <string.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <errno.h>
-
-static const char *filename = "unix_test_socket";
-static const int sendbytes = 100;	/* Send this much data */
-
-int
-main(int argc, char **argv)
-{
-	char data[sendbytes];
-	int protocol;
-	int sock;
-	int result;
-	struct pollfd fdset;
-	struct sockaddr_un sun;
-	int sunlen;
-	int abstract = 0;
-
-	memset(data, 'X', sendbytes);
-
-	if (argc < 2) {
-		printf("%s <protocol>\n", argv[0]);
-		return -1;
-	}
-
-	if (strcmp(argv[1], "stream") == 0)
-		protocol = SOCK_STREAM;
-	else
-		protocol = SOCK_DGRAM;
-
-	if ((sock = socket(AF_UNIX, protocol, 0)) < 0) {
-		perror("socket");
-		return -1;
-	}
-
-	if ((result = fcntl(sock, F_SETFL, O_NONBLOCK))) {
-		perror("fcntl: ");
-		return -1;
-	}
-
-	bzero(&sun, sizeof (struct sockaddr_un));
-	sun.sun_family = AF_UNIX;
-	if (abstract) {
-		sun.sun_path[0] = 0;
-		strcpy(sun.sun_path + 1, filename);
-		sunlen = strlen(sun.sun_path + 1) + 1 + sizeof (short);
-	} else {
-		strcpy(sun.sun_path, filename);
-		sunlen = strlen(sun.sun_path) + 1 + sizeof (short);
-	}
-
-	result = connect(sock, (struct sockaddr *) &sun, sunlen);
-	if (result < 0) {
-		if (errno == EINPROGRESS) {
-			fdset.fd = sock;
-			fdset.events = POLLIN | POLLOUT;
-			result = poll(&fdset, 1, 1000);
-			if (result < 0) {
-				perror("poll: ");
-				return -1;
-			} else if (result == 0) {
-				/*
-				 * connect is taking too long,
-				 * it's probably not going to work
-				 */
-				printf("poll: no events are ready\n");
-				return -1;
-			} else if (result == 1 && fdset.revents & POLLHUP) {
-				printf("poll: connection closed\n");
-				return -1;
-			}
-		} else {
-			/* perror("connect"); */
-			close(sock);
-			return -1;
-		}
-	}
-
-	result = write(sock, data, sendbytes);
-	if (result != sendbytes) {
-		printf("Bad write %d of %d\n", result, sendbytes);
-		return -1;
-	}
-	printf("sent %5d bytes\n", result);
-	shutdown(sock, 2);
-	close(sock);
-
-	return (0);
-}
-- 
2.1.0
