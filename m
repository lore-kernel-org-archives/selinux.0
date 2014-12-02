Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sB2EFvcA009954
 for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2014 09:15:57 -0500
From: Richard Haines <richard_c_haines@btinternet.com>
To: selinux@tycho.nsa.gov, linux-sctp@vger.kernel.org
Subject: [RFC-PATCH 2/3] net: Extend security get/setsockopt entries
Date: Tue,  2 Dec 2014 14:15:47 +0000
Message-Id: <1417529747-2643-1-git-send-email-richard_c_haines@btinternet.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Extend security_socket_getsockopt and security_socket_setsockopt to support
optname and optval parameters.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 net/compat.c | 6 ++++--
 net/socket.c | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/compat.c b/net/compat.c
index bc8aeef..6341f04 100644
--- a/net/compat.c
+++ b/net/compat.c
@@ -392,7 +392,8 @@ COMPAT_SYSCALL_DEFINE5(setsockopt, int, fd, int, level, int, optname,
 	struct socket *sock = sockfd_lookup(fd, &err);
 
 	if (sock) {
-		err = security_socket_setsockopt(sock, level, optname);
+		err = security_socket_setsockopt(sock, level, optname, optval,
+					    optlen);
 		if (err) {
 			sockfd_put(sock);
 			return err;
@@ -512,7 +513,8 @@ COMPAT_SYSCALL_DEFINE5(getsockopt, int, fd, int, level, int, optname,
 	struct socket *sock = sockfd_lookup(fd, &err);
 
 	if (sock) {
-		err = security_socket_getsockopt(sock, level, optname);
+		err = security_socket_getsockopt(sock, level, optname,
+					optval, optlen);
 		if (err) {
 			sockfd_put(sock);
 			return err;
diff --git a/net/socket.c b/net/socket.c
index 4cdbc10..12ee18e 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1910,7 +1910,8 @@ SYSCALL_DEFINE5(setsockopt, int, fd, int, level, int, optname,
 
 	sock = sockfd_lookup_light(fd, &err, &fput_needed);
 	if (sock != NULL) {
-		err = security_socket_setsockopt(sock, level, optname);
+		err = security_socket_setsockopt(sock, level, optname, optval,
+					    optlen);
 		if (err)
 			goto out_put;
 
@@ -1941,7 +1942,8 @@ SYSCALL_DEFINE5(getsockopt, int, fd, int, level, int, optname,
 
 	sock = sockfd_lookup_light(fd, &err, &fput_needed);
 	if (sock != NULL) {
-		err = security_socket_getsockopt(sock, level, optname);
+		err = security_socket_getsockopt(sock, level, optname, optval,
+						  optlen);
 		if (err)
 			goto out_put;
 
-- 
1.9.3
