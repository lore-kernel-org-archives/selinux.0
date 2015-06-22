From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH] selinux-testsuite: fix unix/inet socket tests
Date: Mon, 22 Jun 2015 16:40:08 -0400
Message-Id: <1435005608-25931-1-git-send-email-sds@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

There was a bug in the unix and inet socket tests:
the server program would exit as soon as it finished
responding to the legitimate client, so the unauthorized
client tests were "succeeding" due to the server socket
not even existing rather than a permission denial.  Fix
the server to stay around until it is explicitly killed by
the test scripts.  This fix then revealed a problem with the
last inet_socket test: although the permission denial correctly
prevents the server from receiving the datagram message, the
client gets no notification of this failure and hangs on its
subsequent attempt to read a reply from the server.  Remove
that last test until we come up with a suitable way of testing.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 tests/inet_socket/server.c | 134 +++++++++++++++++++++++----------------------
 tests/inet_socket/test     |   6 +-
 tests/unix_socket/server.c | 132 ++++++++++++++++++++++----------------------
 3 files changed, 138 insertions(+), 134 deletions(-)

diff --git a/tests/inet_socket/server.c b/tests/inet_socket/server.c
index f7f4fdd..630d988 100644
--- a/tests/inet_socket/server.c
+++ b/tests/inet_socket/server.c
@@ -80,46 +80,48 @@ main(int argc, char **argv)
 	}
 
 	if (type == SOCK_STREAM) {
-		int newsock;
-		char peerlabel[256];
-		socklen_t labellen = sizeof(peerlabel);
-
 		if (listen(sock, SOMAXCONN)) {
 			perror("listen");
 			close(sock);
 			exit(1);
 		}
 
-		sinlen = sizeof(sin);
-		newsock = accept(sock, (struct sockaddr *)&sin,
-				 &sinlen);
-		if (newsock < 0) {
-			perror("accept");
-			close(sock);
-			exit(1);
-		}
+		do {
+			int newsock;
+			char peerlabel[256];
+			socklen_t labellen = sizeof(peerlabel);
+
+			sinlen = sizeof(sin);
+			newsock = accept(sock, (struct sockaddr *)&sin,
+					 &sinlen);
+			if (newsock < 0) {
+				perror("accept");
+				close(sock);
+				exit(1);
+			}
 
-		peerlabel[0] = 0;
-		result = getsockopt(newsock, SOL_SOCKET, SO_PEERSEC, peerlabel,
-				    &labellen);
-		if (result < 0) {
-			perror("getsockopt: SO_PEERSEC");
-			exit(1);
-		}
-		printf("%s:  Got peer label=%s\n", argv[0], peerlabel);
+			peerlabel[0] = 0;
+			result = getsockopt(newsock, SOL_SOCKET, SO_PEERSEC, peerlabel,
+					    &labellen);
+			if (result < 0) {
+				perror("getsockopt: SO_PEERSEC");
+				exit(1);
+			}
+			printf("%s:  Got peer label=%s\n", argv[0], peerlabel);
 
-		result = read(newsock, &byte, 1);
-		if (result < 0) {
-			perror("read");
-			exit(1);
-		}
+			result = read(newsock, &byte, 1);
+			if (result < 0) {
+				perror("read");
+				exit(1);
+			}
 
-		result = write(newsock, peerlabel, strlen(peerlabel));
-		if (result < 0) {
-			perror("write");
-			exit(1);
-		}
-		close(newsock);
+			result = write(newsock, peerlabel, strlen(peerlabel));
+			if (result < 0) {
+				perror("write");
+				exit(1);
+			}
+			close(newsock);
+		} while (1);
 	} else {
 		struct iovec iov;
 		struct msghdr msg;
@@ -130,43 +132,45 @@ main(int argc, char **argv)
 			char buf[CMSG_SPACE(sizeof(msglabel))];
 		} control;
 
-		memset(&iov, 0, sizeof(iov));
-		iov.iov_base = &byte;
-		iov.iov_len = 1;
-		memset(&msg, 0, sizeof(msg));
-		msglabel[0] = 0;
-		msg.msg_name = &sin;
-		msg.msg_namelen = sizeof(sin);
-		msg.msg_iov = &iov;
-		msg.msg_iovlen = 1;
-		msg.msg_control = &control;
-		msg.msg_controllen = sizeof(control);
-		result = recvmsg(sock, &msg, 0);
-		if (result < 0) {
-			perror("recvmsg");
-			exit(1);
-		}
-		for (cmsg = CMSG_FIRSTHDR(&msg); cmsg;
-		     cmsg = CMSG_NXTHDR(&msg, cmsg)) {
-			if (cmsg->cmsg_level == SOL_IP &&
-			    cmsg->cmsg_type == SCM_SECURITY) {
-				size_t len = cmsg->cmsg_len - CMSG_LEN(0);
-
-				if (len > 0 && len < sizeof(msglabel)) {
-					memcpy(msglabel, CMSG_DATA(cmsg), len);
-					msglabel[len] = 0;
-					printf("%s: Got SCM_SECURITY=%s\n",
-					       argv[0], msglabel);
+		do {
+			memset(&iov, 0, sizeof(iov));
+			iov.iov_base = &byte;
+			iov.iov_len = 1;
+			memset(&msg, 0, sizeof(msg));
+			msglabel[0] = 0;
+			msg.msg_name = &sin;
+			msg.msg_namelen = sizeof(sin);
+			msg.msg_iov = &iov;
+			msg.msg_iovlen = 1;
+			msg.msg_control = &control;
+			msg.msg_controllen = sizeof(control);
+			result = recvmsg(sock, &msg, 0);
+			if (result < 0) {
+				perror("recvmsg");
+				exit(1);
+			}
+			for (cmsg = CMSG_FIRSTHDR(&msg); cmsg;
+			     cmsg = CMSG_NXTHDR(&msg, cmsg)) {
+				if (cmsg->cmsg_level == SOL_IP &&
+				    cmsg->cmsg_type == SCM_SECURITY) {
+					size_t len = cmsg->cmsg_len - CMSG_LEN(0);
+
+					if (len > 0 && len < sizeof(msglabel)) {
+						memcpy(msglabel, CMSG_DATA(cmsg), len);
+						msglabel[len] = 0;
+						printf("%s: Got SCM_SECURITY=%s\n",
+						       argv[0], msglabel);
+					}
 				}
 			}
-		}
 
-		result = sendto(sock, msglabel, strlen(msglabel), 0,
-				msg.msg_name, msg.msg_namelen);
-		if (result < 0) {
-			perror("sendto");
-			exit(1);
-		}
+			result = sendto(sock, msglabel, strlen(msglabel), 0,
+					msg.msg_name, msg.msg_namelen);
+			if (result < 0) {
+				perror("sendto");
+				exit(1);
+			}
+		} while (1);
 	}
 
 	close(sock);
diff --git a/tests/inet_socket/test b/tests/inet_socket/test
index 58debd9..1e9204f 100755
--- a/tests/inet_socket/test
+++ b/tests/inet_socket/test
@@ -1,7 +1,7 @@
 #!/usr/bin/perl
 
 use Test;
-BEGIN { plan tests => 4}
+BEGIN { plan tests => 3}
 
 $basedir = $0;  $basedir =~ s|(.*)/[^/]*|$1|;
 
@@ -37,10 +37,6 @@ sleep 1; # Give it a moment to initialize
 $result = system "runcon -t test_inet_client_t $basedir/client dgram 65535";
 ok($result, 0);
 
-# Verify that unauthorized client cannot communicate with the server.
-$result = system "runcon -t test_inet_bad_client_t -- $basedir/client dgram 65535 2>&1";
-ok($result);
-
 # Kill the server.
 kill TERM, $pid;
 
diff --git a/tests/unix_socket/server.c b/tests/unix_socket/server.c
index 89bfdb3..e8958dd 100644
--- a/tests/unix_socket/server.c
+++ b/tests/unix_socket/server.c
@@ -70,45 +70,47 @@ main(int argc, char **argv)
 	}
 
 	if (type == SOCK_STREAM) {
-		int newsock;
-		char peerlabel[256];
-		socklen_t labellen = sizeof(peerlabel);
-
 		if (listen(sock, SOMAXCONN)) {
 			perror("listen");
 			close(sock);
 			exit(1);
 		}
 
-		newsock = accept(sock, (struct sockaddr *)&remotesun,
-				 &remotesunlen);
-		if (newsock < 0) {
-			perror("accept");
-			close(sock);
-			exit(1);
-		}
+		do {
+			int newsock;
+			char peerlabel[256];
+			socklen_t labellen = sizeof(peerlabel);
+
+			newsock = accept(sock, (struct sockaddr *)&remotesun,
+					 &remotesunlen);
+			if (newsock < 0) {
+				perror("accept");
+				close(sock);
+				exit(1);
+			}
 
-		peerlabel[0] = 0;
-		result = getsockopt(newsock, SOL_SOCKET, SO_PEERSEC, peerlabel,
-				    &labellen);
-		if (result < 0) {
-			perror("getsockopt: SO_PEERSEC");
-			exit(1);
-		}
-		printf("%s:  Got peer label=%s\n", argv[0], peerlabel);
+			peerlabel[0] = 0;
+			result = getsockopt(newsock, SOL_SOCKET, SO_PEERSEC, peerlabel,
+					    &labellen);
+			if (result < 0) {
+				perror("getsockopt: SO_PEERSEC");
+				exit(1);
+			}
+			printf("%s:  Got peer label=%s\n", argv[0], peerlabel);
 
-		result = read(newsock, &byte, 1);
-		if (result < 0) {
-			perror("read");
-			exit(1);
-		}
+			result = read(newsock, &byte, 1);
+			if (result < 0) {
+				perror("read");
+				exit(1);
+			}
 
-		result = write(newsock, peerlabel, strlen(peerlabel));
-		if (result < 0) {
-			perror("write");
-			exit(1);
-		}
-		close(newsock);
+			result = write(newsock, peerlabel, strlen(peerlabel));
+			if (result < 0) {
+				perror("write");
+				exit(1);
+			}
+			close(newsock);
+		} while (1);
 	} else {
 		struct iovec iov;
 		struct msghdr msg;
@@ -119,43 +121,45 @@ main(int argc, char **argv)
 			char buf[CMSG_SPACE(sizeof(msglabel))];
 		} control;
 
-		memset(&iov, 0, sizeof(iov));
-		iov.iov_base = &byte;
-		iov.iov_len = 1;
-		memset(&msg, 0, sizeof(msg));
-		msglabel[0] = 0;
-		msg.msg_name = &remotesun;
-		msg.msg_namelen = remotesunlen;
-		msg.msg_iov = &iov;
-		msg.msg_iovlen = 1;
-		msg.msg_control = &control;
-		msg.msg_controllen = sizeof(control);
-		result = recvmsg(sock, &msg, 0);
-		if (result < 0) {
-			perror("recvmsg");
-			exit(1);
-		}
-		for (cmsg = CMSG_FIRSTHDR(&msg); cmsg;
-		     cmsg = CMSG_NXTHDR(&msg, cmsg)) {
-			if (cmsg->cmsg_level == SOL_SOCKET &&
-			    cmsg->cmsg_type == SCM_SECURITY) {
-				size_t len = cmsg->cmsg_len - CMSG_LEN(0);
-
-				if (len > 0 && len < sizeof(msglabel)) {
-					memcpy(msglabel, CMSG_DATA(cmsg), len);
-					msglabel[len] = 0;
-					printf("%s: Got SCM_SECURITY=%s\n",
-					       argv[0], msglabel);
+		do {
+			memset(&iov, 0, sizeof(iov));
+			iov.iov_base = &byte;
+			iov.iov_len = 1;
+			memset(&msg, 0, sizeof(msg));
+			msglabel[0] = 0;
+			msg.msg_name = &remotesun;
+			msg.msg_namelen = remotesunlen;
+			msg.msg_iov = &iov;
+			msg.msg_iovlen = 1;
+			msg.msg_control = &control;
+			msg.msg_controllen = sizeof(control);
+			result = recvmsg(sock, &msg, 0);
+			if (result < 0) {
+				perror("recvmsg");
+				exit(1);
+			}
+			for (cmsg = CMSG_FIRSTHDR(&msg); cmsg;
+			     cmsg = CMSG_NXTHDR(&msg, cmsg)) {
+				if (cmsg->cmsg_level == SOL_SOCKET &&
+				    cmsg->cmsg_type == SCM_SECURITY) {
+					size_t len = cmsg->cmsg_len - CMSG_LEN(0);
+
+					if (len > 0 && len < sizeof(msglabel)) {
+						memcpy(msglabel, CMSG_DATA(cmsg), len);
+						msglabel[len] = 0;
+						printf("%s: Got SCM_SECURITY=%s\n",
+						       argv[0], msglabel);
+					}
 				}
 			}
-		}
 
-		result = sendto(sock, msglabel, strlen(msglabel), 0,
-				msg.msg_name, msg.msg_namelen);
-		if (result < 0) {
-			perror("sendto");
-			exit(1);
-		}
+			result = sendto(sock, msglabel, strlen(msglabel), 0,
+					msg.msg_name, msg.msg_namelen);
+			if (result < 0) {
+				perror("sendto");
+				exit(1);
+			}
+		} while (1);
 	}
 
 	close(sock);
-- 
2.1.0
