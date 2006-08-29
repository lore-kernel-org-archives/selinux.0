Message-Id: <20060829144446.837714000@hp.com>
References: <20060829144251.452774000@hp.com>
Date: Tue, 29 Aug 2006 10:42:56 -0400
From: paul.moore@hp.com
To: netdev@vger.kernel.org, selinux@tycho.nsa.gov
Cc: jmorris@namei.org, sds@tycho.nsa.gov, akpm@osdl.org,
        Paul Moore <paul.moore@hp.com>
Subject: [PATCH 5/6] NetLabel: uninline selinux_netlbl_inode_permission()
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Uninline the selinux_netlbl_inode_permission() at the request of Andrew Morton.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---
 security/selinux/include/selinux_netlabel.h |   35 ----------------------------
 security/selinux/ss/services.c              |   33 +++++++++++++++++++-------
 2 files changed, 25 insertions(+), 43 deletions(-)

Index: net-2.6.19/security/selinux/include/selinux_netlabel.h
===================================================================
--- net-2.6.19.orig/security/selinux/include/selinux_netlabel.h
+++ net-2.6.19/security/selinux/include/selinux_netlabel.h
@@ -43,40 +43,7 @@ void selinux_netlbl_sk_security_init(str
 				     int family);
 void selinux_netlbl_sk_clone_security(struct sk_security_struct *ssec,
 				      struct sk_security_struct *newssec);
-
-int __selinux_netlbl_inode_permission(struct inode *inode, int mask);
-/**
- * selinux_netlbl_inode_permission - Verify the socket is NetLabel labeled
- * @inode: the file descriptor's inode
- * @mask: the permission mask
- *
- * Description:
- * Looks at a file's inode and if it is marked as a socket protected by
- * NetLabel then verify that the socket has been labeled, if not try to label
- * the socket now with the inode's SID.  Returns zero on success, negative
- * values on failure.
- *
- */
-static inline int selinux_netlbl_inode_permission(struct inode *inode,
-						  int mask)
-{
-	int rc = 0;
-	struct inode_security_struct *isec;
-	struct sk_security_struct *sksec;
-
-	if (!S_ISSOCK(inode->i_mode))
-		return 0;
-
-	isec = inode->i_security;
-	sksec = SOCKET_I(inode)->sk->sk_security;
-	down(&isec->sem);
-	if (unlikely(sksec->nlbl_state == NLBL_REQUIRE &&
-		     (mask & (MAY_WRITE | MAY_APPEND))))
-		rc = __selinux_netlbl_inode_permission(inode, mask);
-	up(&isec->sem);
-
-	return rc;
-}
+int selinux_netlbl_inode_permission(struct inode *inode, int mask);
 #else
 static inline void selinux_netlbl_cache_invalidate(void)
 {
Index: net-2.6.19/security/selinux/ss/services.c
===================================================================
--- net-2.6.19.orig/security/selinux/ss/services.c
+++ net-2.6.19/security/selinux/ss/services.c
@@ -2544,24 +2544,39 @@ u32 selinux_netlbl_inet_conn_request(str
 }
 
 /**
- * __selinux_netlbl_inode_permission - Label a socket using NetLabel
+ * selinux_netlbl_inode_permission - Verify the socket is NetLabel labeled
  * @inode: the file descriptor's inode
  * @mask: the permission mask
  *
  * Description:
- * Try to label a socket with the inode's SID using NetLabel.  Returns zero on
- * success, negative values on failure.
+ * Looks at a file's inode and if it is marked as a socket protected by
+ * NetLabel then verify that the socket has been labeled, if not try to label
+ * the socket now with the inode's SID.  Returns zero on success, negative
+ * values on failure.
  *
  */
-int __selinux_netlbl_inode_permission(struct inode *inode, int mask)
+int selinux_netlbl_inode_permission(struct inode *inode, int mask)
 {
 	int rc;
-	struct socket *sock = SOCKET_I(inode);
-	struct sk_security_struct *sksec = sock->sk->sk_security;
+	struct inode_security_struct *isec;
+	struct sk_security_struct *sksec;
+	struct socket *sock;
+
+	if (!S_ISSOCK(inode->i_mode))
+		return 0;
 
-	lock_sock(sock->sk);
-	rc = selinux_netlbl_socket_setsid(sock, sksec->sid);
-	release_sock(sock->sk);
+	sock = SOCKET_I(inode);
+	isec = inode->i_security;
+	sksec = sock->sk->sk_security;
+	down(&isec->sem);
+	if (unlikely(sksec->nlbl_state == NLBL_REQUIRE &&
+		     (mask & (MAY_WRITE | MAY_APPEND)))) {
+		lock_sock(sock->sk);
+		rc = selinux_netlbl_socket_setsid(sock, sksec->sid);
+		release_sock(sock->sk);
+	} else
+		rc = 0;
+	up(&isec->sem);
 
 	return rc;
 }

--
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
