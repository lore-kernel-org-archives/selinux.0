Date: Thu, 12 Jun 2008 02:00:59 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: selinux@tycho.nsa.gov
cc: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>
Subject: [PATCH] SELinux: remove unused and shadowed addrlen variable
Message-ID: <Xine.LNX.4.64.0806120158580.5379@us.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Please review.

----
Remove unused and shadowed addrlen variable.  Picked up by sparse.

Signed-off-by: James Morris <jmorris@namei.org>
---
 security/selinux/hooks.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index f530008..6e8d0e9 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3669,7 +3669,7 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
 		struct sockaddr_in6 *addr6 = NULL;
 		unsigned short snum;
 		struct sock *sk = sock->sk;
-		u32 sid, node_perm, addrlen;
+		u32 sid, node_perm;
 
 		tsec = current->security;
 		isec = SOCK_INODE(sock)->i_security;
@@ -3677,12 +3677,10 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
 		if (family == PF_INET) {
 			addr4 = (struct sockaddr_in *)address;
 			snum = ntohs(addr4->sin_port);
-			addrlen = sizeof(addr4->sin_addr.s_addr);
 			addrp = (char *)&addr4->sin_addr.s_addr;
 		} else {
 			addr6 = (struct sockaddr_in6 *)address;
 			snum = ntohs(addr6->sin6_port);
-			addrlen = sizeof(addr6->sin6_addr.s6_addr);
 			addrp = (char *)&addr6->sin6_addr.s6_addr;
 		}
 
-- 
1.5.5.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
