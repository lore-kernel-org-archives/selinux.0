From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH] selinux-testsuite: unix_socket: Add tests for file namespace.
Date: Wed,  8 Jul 2015 13:13:55 -0400
Message-Id: <1436375635-17367-1-git-send-email-sds@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Add tests for Unix sockets in the file namespace.
The original tests only exercised the abstract namespace.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 ToDo                       |  1 -
 policy/test_unix_socket.te | 31 ++++++++++++++++++++---
 tests/unix_socket/client.c | 53 +++++++++++++++++++++++++++++++---------
 tests/unix_socket/server.c | 39 +++++++++++++++++++++++------
 tests/unix_socket/test     | 61 ++++++++++++++++++++++++++++++++++++++++------
 5 files changed, 154 insertions(+), 31 deletions(-)

diff --git a/ToDo b/ToDo
index 06f8aaf..3f4cb29 100644
--- a/ToDo
+++ b/ToDo
@@ -1,6 +1,5 @@
 unix_socket, inet_socket: test individual failure (denial) of common socket permissions (create, bind, ...).
 unix_socket, inet_socket: test setsockcreatecon.
-unix_socket: generalize tests to cover file namespace as well as abstract.
 inet_socket: generalize tests to cover INET6 as well as INET.
 inet_socket: test individual failure of netif ingress/egress.
 inet_socket: test individual failure of node recvfrom/sendto.
diff --git a/policy/test_unix_socket.te b/policy/test_unix_socket.te
index cf3df35..c6e06cc 100644
--- a/policy/test_unix_socket.te
+++ b/policy/test_unix_socket.te
@@ -12,13 +12,29 @@ unconfined_runs_test(test_unix_server_t)
 typeattribute test_unix_server_t testdomain;
 typeattribute test_unix_server_t unixsocketdomain;
 
+# Socket file for the server process.
+type test_unix_server_sockfile_t;
+files_type(test_unix_server_sockfile_t)
+type_transition test_unix_server_t test_file_t:sock_file test_unix_server_sockfile_t;
+allow test_unix_server_t test_file_t:dir rw_dir_perms;
+allow test_unix_server_t test_unix_server_sockfile_t:sock_file { create unlink };
+
 # Domain for stream client process.
 type test_unix_stream_client_t;
 domain_type(test_unix_stream_client_t)
 unconfined_runs_test(test_unix_stream_client_t)
 typeattribute test_unix_stream_client_t testdomain;
 typeattribute test_unix_stream_client_t unixsocketdomain;
-# It can connectto the server.
+
+# Socket file for the client process.
+type test_unix_client_sockfile_t;
+files_type(test_unix_client_sockfile_t)
+type_transition test_unix_stream_client_t test_file_t:sock_file test_unix_client_sockfile_t;
+allow test_unix_stream_client_t test_file_t:dir rw_dir_perms;
+allow test_unix_stream_client_t test_unix_client_sockfile_t:sock_file { create unlink };
+
+# client can connect to the server via the socket file or via abstract sockets.
+allow test_unix_stream_client_t test_unix_server_sockfile_t:sock_file write;
 allow test_unix_stream_client_t test_unix_server_t:unix_stream_socket connectto;
 
 # Domain for dgram client process.
@@ -27,9 +43,18 @@ domain_type(test_unix_dgram_client_t)
 unconfined_runs_test(test_unix_dgram_client_t)
 typeattribute test_unix_dgram_client_t testdomain;
 typeattribute test_unix_dgram_client_t unixsocketdomain;
-# It can sendto the server.
+
+# Reuse the same type for its socket file.
+type_transition test_unix_dgram_client_t test_file_t:sock_file test_unix_client_sockfile_t;
+allow test_unix_dgram_client_t test_file_t:dir rw_dir_perms;
+allow test_unix_dgram_client_t test_unix_client_sockfile_t:sock_file { create unlink };
+
+# client can send to the server via the socket file or via abstract sockets.
+allow test_unix_dgram_client_t test_unix_server_sockfile_t:sock_file write;
 allow test_unix_dgram_client_t test_unix_server_t:unix_dgram_socket sendto;
-# And the server can sendto it in order to reply.
+
+# And the server can send back to it in order to reply.
+allow test_unix_server_t test_unix_client_sockfile_t:sock_file write;
 allow test_unix_server_t test_unix_dgram_client_t:unix_dgram_socket sendto;
 
 # Allow all of these domains to be entered from the sysadm domain.
diff --git a/tests/unix_socket/client.c b/tests/unix_socket/client.c
index 565e71b..e937bf9 100644
--- a/tests/unix_socket/client.c
+++ b/tests/unix_socket/client.c
@@ -3,6 +3,7 @@
 #include <sys/un.h>
 #include <stdlib.h>
 #include <stdio.h>
+#include <stdbool.h>
 #include <stddef.h>
 #include <string.h>
 #include <unistd.h>
@@ -13,7 +14,7 @@
 void usage(char *progname)
 {
 	fprintf(stderr,
-		"usage:  %s [stream|dgram] local-socket-name remote-socket-name\n",
+		"usage:  %s [-a] [stream|dgram] local-socket-name remote-socket-name\n",
 		progname);
 	exit(1);
 }
@@ -28,13 +29,26 @@ main(int argc, char **argv)
 	socklen_t sunlen, remotesunlen;
 	int type;
 	char *mycon;
+	int opt;
+	bool abstract = false;
 
-	if (argc != 4)
+	while ((opt = getopt(argc, argv, "a")) != -1) {
+		switch (opt) {
+		case 'a':
+			abstract = true;
+			break;
+		default:
+			usage(argv[0]);
+			break;
+		}
+	}
+
+	if ((argc - optind) != 3)
 		usage(argv[0]);
 
-	if (!strcmp(argv[1], "stream"))
+	if (!strcmp(argv[optind], "stream"))
 		type = SOCK_STREAM;
-	else if (!strcmp(argv[1], "dgram"))
+	else if (!strcmp(argv[optind], "dgram"))
 		type = SOCK_DGRAM;
 	else
 		usage(argv[0]);
@@ -47,10 +61,17 @@ main(int argc, char **argv)
 
 	bzero(&sun, sizeof(struct sockaddr_un));
 	sun.sun_family = AF_UNIX;
-	sun.sun_path[0] = 0;
-	strcpy(&sun.sun_path[1], argv[2]);
-	sunlen = offsetof(struct sockaddr_un, sun_path) +
-		 strlen(&sun.sun_path[1]) + 1;
+	if (abstract) {
+		sun.sun_path[0] = 0;
+		strcpy(&sun.sun_path[1], argv[optind+1]);
+		sunlen = offsetof(struct sockaddr_un, sun_path) +
+			strlen(&sun.sun_path[1]) + 1;
+	} else {
+		strcpy(sun.sun_path, argv[optind+1]);
+		unlink(sun.sun_path);
+		sunlen = offsetof(struct sockaddr_un, sun_path) +
+			strlen(sun.sun_path) + 1;
+	}
 
 	if (bind(sock, (struct sockaddr *) &sun, sunlen) < 0) {
 		perror("bind");
@@ -60,10 +81,16 @@ main(int argc, char **argv)
 
 	bzero(&remotesun, sizeof(struct sockaddr_un));
 	remotesun.sun_family = AF_UNIX;
-	remotesun.sun_path[0] = 0;
-	strcpy(&remotesun.sun_path[1], argv[3]);
-	remotesunlen = offsetof(struct sockaddr_un,
-				sun_path) + strlen(&remotesun.sun_path[1]) + 1;
+	if (abstract) {
+		remotesun.sun_path[0] = 0;
+		strcpy(&remotesun.sun_path[1], argv[optind+2]);
+		remotesunlen = offsetof(struct sockaddr_un,
+					sun_path) + strlen(&remotesun.sun_path[1]) + 1;
+	} else {
+		strcpy(remotesun.sun_path, argv[optind+2]);
+		remotesunlen = offsetof(struct sockaddr_un, sun_path) +
+			strlen(remotesun.sun_path) + 1;
+	}
 
 	result = connect(sock, (struct sockaddr *) &remotesun, remotesunlen);
 	if (result < 0) {
@@ -101,5 +128,7 @@ main(int argc, char **argv)
 	}
 
 	close(sock);
+	if (!abstract)
+		unlink(sun.sun_path);
 	exit(0);
 }
diff --git a/tests/unix_socket/server.c b/tests/unix_socket/server.c
index e8958dd..7cbebe3 100644
--- a/tests/unix_socket/server.c
+++ b/tests/unix_socket/server.c
@@ -2,6 +2,7 @@
 #include <sys/socket.h>
 #include <sys/un.h>
 #include <stdlib.h>
+#include <stdbool.h>
 #include <stddef.h>
 #include <string.h>
 #include <unistd.h>
@@ -17,7 +18,7 @@
 
 void usage(char *progname)
 {
-	fprintf(stderr, "usage:  %s [stream|dgram] socket-name\n", progname);
+	fprintf(stderr, "usage:  %s [-a] [stream|dgram] socket-name\n", progname);
 	exit(1);
 }
 
@@ -32,13 +33,26 @@ main(int argc, char **argv)
 	socklen_t sunlen, remotesunlen;
 	int type;
 	char byte;
+	int opt;
+	bool abstract = false;
+
+	while ((opt = getopt(argc, argv, "a")) != -1) {
+		switch (opt) {
+		case 'a':
+			abstract = true;
+			break;
+		default:
+			usage(argv[0]);
+			break;
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
@@ -58,10 +72,17 @@ main(int argc, char **argv)
 
 	bzero(&sun, sizeof(struct sockaddr_un));
 	sun.sun_family = AF_UNIX;
-	sun.sun_path[0] = 0;
-	strcpy(&sun.sun_path[1], argv[2]);
-	sunlen = offsetof(struct sockaddr_un, sun_path) +
-		 strlen(&sun.sun_path[1]) + 1;
+	if (abstract) {
+		sun.sun_path[0] = 0;
+		strcpy(&sun.sun_path[1], argv[optind+1]);
+		sunlen = offsetof(struct sockaddr_un, sun_path) +
+			strlen(&sun.sun_path[1]) + 1;
+	} else {
+		strcpy(sun.sun_path, argv[optind+1]);
+		unlink(sun.sun_path);
+		sunlen = offsetof(struct sockaddr_un, sun_path) +
+			strlen(sun.sun_path) + 1;
+	}
 
 	if (bind(sock, (struct sockaddr *) &sun, sunlen) < 0) {
 		perror("bind");
@@ -163,5 +184,7 @@ main(int argc, char **argv)
 	}
 
 	close(sock);
+	if (!abstract)
+		unlink(sun.sun_path);
 	exit(0);
 }
diff --git a/tests/unix_socket/test b/tests/unix_socket/test
index 0badf63..6538226 100755
--- a/tests/unix_socket/test
+++ b/tests/unix_socket/test
@@ -1,23 +1,27 @@
 #!/usr/bin/perl
 
 use Test;
-BEGIN { plan tests => 4}
+BEGIN { plan tests => 8}
 
 $basedir = $0;  $basedir =~ s|(.*)/[^/]*|$1|;
 
+#
+# Tests for sockets in the abstract namespace.
+#
+
 # Start the stream server.
 if (($pid = fork()) == 0) {
-    exec "runcon -t test_unix_server_t $basedir/server stream test_server_sock";
+    exec "runcon -t test_unix_server_t $basedir/server -a stream test_server_sock";
 }
 
 sleep 1; # Give it a moment to initialize.
 
 # Verify that stream client can connectto server.
-$result = system "runcon -t test_unix_stream_client_t $basedir/client stream test_client_sock test_server_sock";
+$result = system "runcon -t test_unix_stream_client_t $basedir/client -a stream test_client_sock test_server_sock";
 ok($result, 0);
 
 # Verify that dgram client cannot connectto to server.
-$result = system "runcon -t test_unix_dgram_client_t -- $basedir/client stream test_client_sock test_server_sock 2>&1";
+$result = system "runcon -t test_unix_dgram_client_t -- $basedir/client -a stream test_client_sock test_server_sock 2>&1";
 ok($result);
 
 # Kill the server.
@@ -25,20 +29,63 @@ kill TERM, $pid;
 
 # Start the dgram server.
 if (($pid = fork()) == 0) {
-    exec "runcon -t test_unix_server_t $basedir/server dgram test_server_sock";
+    exec "runcon -t test_unix_server_t $basedir/server -a dgram test_server_sock";
 }
 
 sleep 1; # Give it a moment to initialize
 
 # Verify that dgram client can sendto server.
-$result = system "runcon -t test_unix_dgram_client_t $basedir/client dgram test_client_sock test_server_sock";
+$result = system "runcon -t test_unix_dgram_client_t $basedir/client -a dgram test_client_sock test_server_sock";
 ok($result, 0);
 
 # Verify that stream client cannot sendto server.
-$result = system "runcon -t test_unix_stream_client_t -- $basedir/client dgram test_client_sock test_server_sock 2>&1";
+$result = system "runcon -t test_unix_stream_client_t -- $basedir/client -a dgram test_client_sock test_server_sock 2>&1";
+ok($result);
+
+# Kill the server.
+kill TERM, $pid;
+
+#
+# Tests for sockets in the file namespace.
+#
+
+# Start the stream server.
+if (($pid = fork()) == 0) {
+    exec "runcon -t test_unix_server_t $basedir/server stream $basedir/test_server_sock";
+}
+
+sleep 1; # Give it a moment to initialize.
+
+# Verify that stream client can connectto server.
+$result = system "runcon -t test_unix_stream_client_t $basedir/client stream $basedir/test_client_sock $basedir/test_server_sock";
+ok($result, 0);
+
+# Verify that dgram client cannot connectto to server.
+$result = system "runcon -t test_unix_dgram_client_t -- $basedir/client stream $basedir/test_client_sock $basedir/test_server_sock 2>&1";
 ok($result);
 
 # Kill the server.
 kill TERM, $pid;
 
+# Start the dgram server.
+if (($pid = fork()) == 0) {
+    exec "runcon -t test_unix_server_t $basedir/server dgram $basedir/test_server_sock";
+}
+
+sleep 1; # Give it a moment to initialize
+
+# Verify that dgram client can sendto server.
+$result = system "runcon -t test_unix_dgram_client_t $basedir/client dgram $basedir/test_client_sock $basedir/test_server_sock";
+ok($result, 0);
+
+# Verify that stream client cannot sendto server.
+$result = system "runcon -t test_unix_stream_client_t -- $basedir/client dgram $basedir/test_client_sock $basedir/test_server_sock 2>&1";
+ok($result);
+
+# Kill the server.
+kill TERM, $pid;
+
+# Clean up.
+system "rm -f $basedir/test_client_sock $basedir/test_server_sock";
+
 exit;
-- 
2.1.0
