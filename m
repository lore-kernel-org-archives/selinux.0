From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] selinux-testsuite: unix_socket: fix uninitialized sockaddr
 len arguments
Date: Tue, 27 Oct 2015 08:59:49 -0400
Message-Id: <1445950789-7356-1-git-send-email-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 tests/unix_socket/server.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/unix_socket/server.c b/tests/unix_socket/server.c
index 7cbebe3..f882930 100644
--- a/tests/unix_socket/server.c
+++ b/tests/unix_socket/server.c
@@ -102,6 +102,7 @@ main(int argc, char **argv)
 			char peerlabel[256];
 			socklen_t labellen = sizeof(peerlabel);
 
+			remotesunlen = sizeof(remotesun);
 			newsock = accept(sock, (struct sockaddr *)&remotesun,
 					 &remotesunlen);
 			if (newsock < 0) {
@@ -149,7 +150,7 @@ main(int argc, char **argv)
 			memset(&msg, 0, sizeof(msg));
 			msglabel[0] = 0;
 			msg.msg_name = &remotesun;
-			msg.msg_namelen = remotesunlen;
+			msg.msg_namelen = sizeof(remotesun);
 			msg.msg_iov = &iov;
 			msg.msg_iovlen = 1;
 			msg.msg_control = &control;
-- 
2.4.3
