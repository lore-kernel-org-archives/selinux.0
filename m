From: David Herrmann <dh.herrmann@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: James Morris <jmorris@namei.org>, Paul Moore <paul@paul-moore.com>,
 teg@jklm.no, Stephen Smalley <sds@tycho.nsa.gov>,
 selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
 Eric Paris <eparis@parisplace.org>, serge@hallyn.com,
 Casey Schaufler <casey@schaufler-ca.com>, davem@davemloft.net,
 netdev@vger.kernel.org, David Herrmann <dh.herrmann@gmail.com>
Date: Fri,  4 May 2018 16:28:19 +0200
Message-Id: <20180504142822.15233-2-dh.herrmann@gmail.com>
In-Reply-To: <20180504142822.15233-1-dh.herrmann@gmail.com>
References: <20180504142822.15233-1-dh.herrmann@gmail.com>
Subject: [PATCH v2 1/4] security: add hook for socketpair()
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Right now the LSM labels for socketpairs are always uninitialized,
since there is no security hook for the socketpair() syscall. This
patch adds the required hooks so LSMs can properly label socketpairs.
This allows SO_PEERSEC to return useful information on those sockets.

Note that the behavior of socketpair() can be emulated by creating a
listener socket, connecting to it, and then discarding the initial
listener socket. With this workaround, SO_PEERSEC would return the
caller's security context. However, with socketpair(), the uninitialized
context is returned unconditionally. This is unexpected and makes
socketpair() less useful in situations where the security context is
crucial to the application.

With the new socketpair-hook this disparity can be solved by making
socketpair() return the expected security context.

Acked-by: Serge Hallyn <serge@hallyn.com>
Signed-off-by: Tom Gundersen <teg@jklm.no>
Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 include/linux/lsm_hooks.h | 7 +++++++
 include/linux/security.h  | 7 +++++++
 security/security.c       | 6 ++++++
 3 files changed, 20 insertions(+)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 9d0b286f3dba..8f1131c8dd54 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -757,6 +757,11 @@
  *	@type contains the requested communications type.
  *	@protocol contains the requested protocol.
  *	@kern set to 1 if a kernel socket.
+ * @socket_socketpair:
+ *	Check permissions before creating a fresh pair of sockets.
+ *	@socka contains the first socket structure.
+ *	@sockb contains the second socket structure.
+ *	Return 0 if permission is granted and the connection was established.
  * @socket_bind:
  *	Check permission before socket protocol layer bind operation is
  *	performed and the socket @sock is bound to the address specified in the
@@ -1656,6 +1661,7 @@ union security_list_options {
 	int (*socket_create)(int family, int type, int protocol, int kern);
 	int (*socket_post_create)(struct socket *sock, int family, int type,
 					int protocol, int kern);
+	int (*socket_socketpair)(struct socket *socka, struct socket *sockb);
 	int (*socket_bind)(struct socket *sock, struct sockaddr *address,
 				int addrlen);
 	int (*socket_connect)(struct socket *sock, struct sockaddr *address,
@@ -1922,6 +1928,7 @@ struct security_hook_heads {
 	struct hlist_head unix_may_send;
 	struct hlist_head socket_create;
 	struct hlist_head socket_post_create;
+	struct hlist_head socket_socketpair;
 	struct hlist_head socket_bind;
 	struct hlist_head socket_connect;
 	struct hlist_head socket_listen;
diff --git a/include/linux/security.h b/include/linux/security.h
index 200920f521a1..4ff3ba457e56 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1191,6 +1191,7 @@ int security_unix_may_send(struct socket *sock,  struct socket *other);
 int security_socket_create(int family, int type, int protocol, int kern);
 int security_socket_post_create(struct socket *sock, int family,
 				int type, int protocol, int kern);
+int security_socket_socketpair(struct socket *socka, struct socket *sockb);
 int security_socket_bind(struct socket *sock, struct sockaddr *address, int addrlen);
 int security_socket_connect(struct socket *sock, struct sockaddr *address, int addrlen);
 int security_socket_listen(struct socket *sock, int backlog);
@@ -1262,6 +1263,12 @@ static inline int security_socket_post_create(struct socket *sock,
 	return 0;
 }
 
+static inline int security_socket_socketpair(struct socket *socka,
+					     struct socket *sockb)
+{
+	return 0;
+}
+
 static inline int security_socket_bind(struct socket *sock,
 				       struct sockaddr *address,
 				       int addrlen)
diff --git a/security/security.c b/security/security.c
index 7bc2fde023a7..68f46d849abe 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1358,6 +1358,12 @@ int security_socket_post_create(struct socket *sock, int family,
 						protocol, kern);
 }
 
+int security_socket_socketpair(struct socket *socka, struct socket *sockb)
+{
+	return call_int_hook(socket_socketpair, 0, socka, sockb);
+}
+EXPORT_SYMBOL(security_socket_socketpair);
+
 int security_socket_bind(struct socket *sock, struct sockaddr *address, int addrlen)
 {
 	return call_int_hook(socket_bind, 0, sock, address, addrlen);
-- 
2.17.0
