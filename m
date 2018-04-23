From: David Herrmann <dh.herrmann@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: James Morris <jmorris@namei.org>, Paul Moore <paul@paul-moore.com>,
 teg@jklm.no, Stephen Smalley <sds@tycho.nsa.gov>,
 selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
 Eric Paris <eparis@parisplace.org>, serge@hallyn.com,
 davem@davemloft.net, netdev@vger.kernel.org,
 David Herrmann <dh.herrmann@gmail.com>
Date: Mon, 23 Apr 2018 15:30:13 +0200
Message-Id: <20180423133015.5455-2-dh.herrmann@gmail.com>
In-Reply-To: <20180423133015.5455-1-dh.herrmann@gmail.com>
References: <20180423133015.5455-1-dh.herrmann@gmail.com>
Subject: [PATCH 1/3] security: add hook for socketpair(AF_UNIX, ...)
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

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 include/linux/lsm_hooks.h | 8 ++++++++
 include/linux/security.h  | 7 +++++++
 security/security.c       | 6 ++++++
 3 files changed, 21 insertions(+)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 9d0b286f3dba..2a23c75c1541 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -717,6 +717,12 @@
  *	@other contains the peer sock structure.
  *	@newsk contains the new sock structure.
  *	Return 0 if permission is granted.
+ * @unix_stream_socketpair:
+ *	Check permissions before establishing a Unix domain stream connection
+ *	for a fresh pair of sockets.
+ *	@socka contains the first sock structure.
+ *	@sockb contains the second sock structure.
+ *	Return 0 if permission is granted and the connection was established.
  * @unix_may_send:
  *	Check permissions before connecting or sending datagrams from @sock to
  *	@other.
@@ -1651,6 +1657,7 @@ union security_list_options {
 #ifdef CONFIG_SECURITY_NETWORK
 	int (*unix_stream_connect)(struct sock *sock, struct sock *other,
 					struct sock *newsk);
+	int (*unix_stream_socketpair)(struct sock *socka, struct sock *sockb);
 	int (*unix_may_send)(struct socket *sock, struct socket *other);
 
 	int (*socket_create)(int family, int type, int protocol, int kern);
@@ -1919,6 +1926,7 @@ struct security_hook_heads {
 	struct hlist_head inode_getsecctx;
 #ifdef CONFIG_SECURITY_NETWORK
 	struct hlist_head unix_stream_connect;
+	struct hlist_head unix_stream_socketpair;
 	struct hlist_head unix_may_send;
 	struct hlist_head socket_create;
 	struct hlist_head socket_post_create;
diff --git a/include/linux/security.h b/include/linux/security.h
index 200920f521a1..be275deeda10 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1187,6 +1187,7 @@ static inline int security_inode_getsecctx(struct inode *inode, void **ctx, u32
 #ifdef CONFIG_SECURITY_NETWORK
 
 int security_unix_stream_connect(struct sock *sock, struct sock *other, struct sock *newsk);
+int security_unix_stream_socketpair(struct sock *socka, struct sock *sockb);
 int security_unix_may_send(struct socket *sock,  struct socket *other);
 int security_socket_create(int family, int type, int protocol, int kern);
 int security_socket_post_create(struct socket *sock, int family,
@@ -1242,6 +1243,12 @@ static inline int security_unix_stream_connect(struct sock *sock,
 	return 0;
 }
 
+static inline int security_unix_stream_socketpair(struct sock *socka,
+						  struct sock *sockb)
+{
+	return 0;
+}
+
 static inline int security_unix_may_send(struct socket *sock,
 					 struct socket *other)
 {
diff --git a/security/security.c b/security/security.c
index 7bc2fde023a7..3dfd374e84e5 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1340,6 +1340,12 @@ int security_unix_stream_connect(struct sock *sock, struct sock *other, struct s
 }
 EXPORT_SYMBOL(security_unix_stream_connect);
 
+int security_unix_stream_socketpair(struct sock *socka, struct sock *sockb)
+{
+	return call_int_hook(unix_stream_socketpair, 0, socka, sockb);
+}
+EXPORT_SYMBOL(security_unix_stream_socketpair);
+
 int security_unix_may_send(struct socket *sock,  struct socket *other)
 {
 	return call_int_hook(unix_may_send, 0, sock, other);
-- 
2.17.0
