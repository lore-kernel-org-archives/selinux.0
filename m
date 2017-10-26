From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: paul@paul-moore.com, Stephen Smalley <sds@tycho.nsa.gov>
Date: Thu, 26 Oct 2017 09:43:47 -0400
Message-Id: <20171026134347.599-1-sds@tycho.nsa.gov>
Subject: [PATCH] selinux-testsuite: inet_socket: tighten checking
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

As demonstrated by https://github.com/SELinuxProject/selinux-kernel/issues/36,
the inet_socket tests can "pass" for the wrong reasons.  Change the
client program to use different exit codes for different failures,
and change the test script to check the expected exit code for all tests.
With this change, getting an unexpected peer label causes a test failure
rather than being treated identically to a permission denial.

NB This could make the tests more fragile, e.g. it appears that we encounter
permission denial failures at different points for different tests, so we
may need to relax the checking somewhat based on testing a wider range of
older kernels.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 tests/inet_socket/client.c | 20 ++++++++++----------
 tests/inet_socket/test     | 24 ++++++++++++------------
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/tests/inet_socket/client.c b/tests/inet_socket/client.c
index 5c471f0..f8780d9 100644
--- a/tests/inet_socket/client.c
+++ b/tests/inet_socket/client.c
@@ -67,14 +67,14 @@ int main(int argc, char **argv)
 			     &serverinfo);
 	if (result < 0) {
 		fprintf(stderr, "getaddrinfo: %s\n", gai_strerror(result));
-		exit(1);
+		exit(2);
 	}
 
 	sock = socket(serverinfo->ai_family, serverinfo->ai_socktype,
 		      serverinfo->ai_protocol);
 	if (sock < 0) {
 		perror("socket");
-		exit(1);
+		exit(3);
 	}
 
 	tm.tv_sec = 5;
@@ -82,14 +82,14 @@ int main(int argc, char **argv)
 	result = setsockopt(sock, SOL_SOCKET, SO_SNDTIMEO, &tm, sizeof(tm));
 	if (result < 0) {
 		perror("setsockopt: SO_SNDTIMEO");
-		exit(1);
+		exit(4);
 	}
 
 	result = connect(sock, serverinfo->ai_addr, serverinfo->ai_addrlen);
 	if (result < 0) {
 		perror("connect");
 		close(sock);
-		exit(1);
+		exit(5);
 	}
 
 	byte = 0;
@@ -97,7 +97,7 @@ int main(int argc, char **argv)
 	if (result < 0) {
 		perror("write");
 		close(sock);
-		exit(1);
+		exit(6);
 	}
 
 	if (hints.ai_socktype == SOCK_DGRAM) {
@@ -109,10 +109,10 @@ int main(int argc, char **argv)
 		if (result < 0) {
 			perror("poll");
 			close(sock);
-			exit(1);
+			exit(7);
 		} else if (result == 0) {
 			fprintf(stderr, "%s: no reply from server\n", argv[0]);
-			exit(1);
+			exit(8);
 		}
 	}
 
@@ -120,7 +120,7 @@ int main(int argc, char **argv)
 	if (result < 0) {
 		perror("read");
 		close(sock);
-		exit(1);
+		exit(9);
 	}
 	label[result] = 0;
 
@@ -129,14 +129,14 @@ int main(int argc, char **argv)
 		if (result < 0) {
 			perror("getcon");
 			close(sock);
-			exit(1);
+			exit(10);
 		}
 	}
 
 	if (strcmp(expected, label)) {
 		fprintf(stderr, "%s:  expected %s, got %s\n",
 			argv[0], expected, label);
-		exit(1);
+		exit(11);
 	}
 
 	close(sock);
diff --git a/tests/inet_socket/test b/tests/inet_socket/test
index 81d0959..0bda2a4 100755
--- a/tests/inet_socket/test
+++ b/tests/inet_socket/test
@@ -32,7 +32,7 @@ ok( $result eq 0 );
 # Verify that unauthorized client cannot communicate with the server.
 $result = system
 "runcon -t test_inet_bad_client_t -- $basedir/client stream 127.0.0.1 65535 2>&1";
-ok($result);
+ok( $result >> 8 eq 5 );
 
 # Kill the server.
 kill TERM, $pid;
@@ -52,7 +52,7 @@ ok( $result eq 0 );
 # Verify that unauthorized client cannot communicate with the server.
 $result = system
 "runcon -t test_inet_bad_client_t -- $basedir/client dgram 127.0.0.1 65535 2>&1";
-ok($result);
+ok( $result >> 8 eq 9 );
 
 # Kill the server.
 kill TERM, $pid;
@@ -84,7 +84,7 @@ ok( $result eq 0 );
 # Verify that authorized client cannot communicate with the server using different level.
 $result = system
 "runcon -t test_inet_client_t -l s0:c8.c12 $basedir/client stream 127.0.0.1 65535 2>&1";
-ok($result);
+ok( $result >> 8 eq 5 );
 
 # Kill the server.
 kill TERM, $pid;
@@ -105,7 +105,7 @@ ok( $result eq 0 );
 # Verify that authorized client cannot communicate with the server using levels dominating the server.
 $result = system
 "runcon -t test_inet_client_t -l s0:c40.c51 $basedir/client dgram 127.0.0.1 65535 2>&1";
-ok($result);
+ok( $result >> 8 eq 9 );
 
 # Kill the server.
 kill TERM, $pid;
@@ -169,7 +169,7 @@ ok( $result eq 0 );
 # Verify that unauthorized client cannot communicate with the server.
 $result = system
 "runcon -t test_inet_bad_client_t -- $basedir/client stream 127.0.0.1 65535 2>&1";
-ok($result);
+ok( $result >> 8 eq 5 );
 
 # Verify that authorized client can communicate with the server.
 $result =
@@ -179,7 +179,7 @@ ok( $result eq 0 );
 # Verify that unauthorized client cannot communicate with the server.
 $result = system
   "runcon -t test_inet_bad_client_t -- $basedir/client stream ::1 65535 2>&1";
-ok($result);
+ok( $result >> 8 eq 5 );
 
 # Kill the server.
 kill TERM, $pid;
@@ -199,12 +199,12 @@ ok( $result eq 0 );
 # Verify that unauthorized client cannot communicate with the server.
 $result = system
 "runcon -t test_inet_bad_client_t -- $basedir/client dgram 127.0.0.1 65535 2>&1";
-ok($result);
+ok( $result >> 8 eq 8 );
 
 # Verify that unauthorized client cannot communicate with the server.
 $result = system
   "runcon -t test_inet_bad_client_t -- $basedir/client dgram ::1 65535 2>&1";
-ok($result);
+ok( $result >> 8 eq 8 );
 
 # Kill the server.
 kill TERM, $pid;
@@ -245,7 +245,7 @@ ok( $result eq 0 );
 # Verify that unauthorized client cannot communicate with the server.
 $result = system
 "runcon -t test_inet_bad_client_t -- $basedir/client -e nopeer stream 127.0.0.1 65535 2>&1";
-ok($result);
+ok( $result >> 8 eq 5 );
 
 # Verify that authorized client can communicate with the server.
 $result = system
@@ -255,7 +255,7 @@ ok( $result eq 0 );
 # Verify that unauthorized client cannot communicate with the server.
 $result = system
 "runcon -t test_inet_bad_client_t -- $basedir/client -e nopeer stream ::1 65535 2>&1";
-ok($result);
+ok( $result >> 8 eq 5 );
 
 # Kill the server.
 kill TERM, $pid;
@@ -275,7 +275,7 @@ ok( $result eq 0 );
 # Verify that unauthorized client cannot communicate with the server.
 $result = system
 "runcon -t test_inet_bad_client_t -- $basedir/client -e nopeer dgram 127.0.0.1 65535 2>&1";
-ok($result);
+ok( $result >> 8 eq 8 );
 
 # Verify that authorized client can communicate with the server.
 $result = system
@@ -285,7 +285,7 @@ ok( $result eq 0 );
 # Verify that unauthorized client cannot communicate with the server.
 $result = system
 "runcon -t test_inet_bad_client_t -- $basedir/client -e nopeer dgram ::1 65535 2>&1";
-ok($result);
+ok( $result >> 8 eq 8 );
 
 # Kill the server.
 kill TERM, $pid;
-- 
2.9.5
