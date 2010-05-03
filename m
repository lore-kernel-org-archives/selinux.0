Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o43MBPeu018919
	for <selinux@tycho.nsa.gov>; Mon, 3 May 2010 18:11:25 -0400
Received: from g4t0015.houston.hp.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o43MCTbl004898
	for <selinux@tycho.nsa.gov>; Mon, 3 May 2010 22:12:29 GMT
Received: from g4t0018.houston.hp.com (g4t0018.houston.hp.com [16.234.32.27])
	by g4t0015.houston.hp.com (Postfix) with ESMTP id 2B9788036
	for <selinux@tycho.nsa.gov>; Mon,  3 May 2010 22:11:24 +0000 (UTC)
Subject: [RFC PATCH v1 1/6] selinux: Update socket's label alongside inode's
	label
To: selinux@tycho.nsa.gov
From: Paul Moore <paul.moore@hp.com>
Date: Mon, 03 May 2010 18:11:22 -0400
Message-ID: <20100503221122.8177.80352.stgit@flek.lan>
In-Reply-To: <20100503220455.8177.91177.stgit@flek.lan>
References: <20100503220455.8177.91177.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

We have always had a potential disconnect between the label on socket and
the label on the associated inode when a user calls fsetxattr() on a
socket.  The problem is that the fsetxattr() call would only relabel the
inode and not the corresponding socket; the good news is that the
mainstream SELinux policies have always prevented this, but better safe
than sorry ...

This patch fixes this problem by adding the necessary socket labeling code
to selinux_inode_setsecurity() so that if a user did relabel a socket via
fsetxattr() both the inode and socket would be relabeled.

Signed-off-by: XXX
---
 security/selinux/hooks.c            |   39 ++++++++++++++++++++++++++++++++++-
 security/selinux/include/netlabel.h |    5 ++--
 security/selinux/netlabel.c         |    8 +++++--
 3 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 5feecb4..f9545c8 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2920,6 +2920,43 @@ static int selinux_inode_setsecurity(struct inode *inode, const char *name,
 	if (rc)
 		return rc;
 
+	if (S_ISSOCK(inode->i_mode)) {
+		struct sock *sk = SOCKET_I(inode)->sk;
+		struct sk_security_struct *sksec = sk->sk_security;
+
+		/* XXX - In order to safely relabel a socket when labeled IPsec
+		 *       is in use we need to also change the corresponding
+		 *       flow secid (if any), if we don't change the flow's
+		 *       secid then we run the risk of mislabeling traffic which
+		 *       is not good.  Since the odds of us hitting this code
+		 *       are very low (actually zero given refpolicy circa 2010)
+		 *       we're not going to expend the effort in relabeling the
+		 *       flow, just cause the fsetxattr() operation to fail
+		 *       which should guarantee labeling safety. */
+		if (selinux_xfrm_enabled())
+			return -EPERM;
+
+		/* It is worth mentioning here that you could potentially see a
+		 * labeling race condition if the socket being relabeled is
+		 * undergoing lots of writes at the same time, as writes sent
+		 * before the fsetxattr() operation may not receive their
+		 * on-the-wire security label until after the fsetxattr()
+		 * completes resulting in pre-fsetxattr() data getting labeled
+		 * with a post-fsetxattr() security label.  However, we're just
+		 * going to assume that if someone is silly enough to try and
+		 * relabel a socket mid-stream then they should bear the
+		 * responsibility of dealing with the potential problems.  It
+		 * is also worth mentioning that this operation is forbidden by
+		 * the 2010 refpolicy for this very reason. */
+		lock_sock(sk);
+		sksec->sid = newsid;
+		selinux_netlbl_sk_security_reset(sksec);
+		rc = selinux_netlbl_socket_setsid(sk, sk->sk_family);
+		release_sock(sk);
+		if (rc)
+			return rc;
+	}
+
 	isec->sid = newsid;
 	isec->initialized = 1;
 	return 0;
@@ -3766,7 +3803,7 @@ static int selinux_socket_post_create(struct socket *sock, int family,
 		sksec = sock->sk->sk_security;
 		sksec->sid = isec->sid;
 		sksec->sclass = isec->sclass;
-		err = selinux_netlbl_socket_post_create(sock->sk, family);
+		err = selinux_netlbl_socket_setsid(sock->sk, family);
 	}
 
 	return err;
diff --git a/security/selinux/include/netlabel.h b/security/selinux/include/netlabel.h
index 8d73842..4edab04 100644
--- a/security/selinux/include/netlabel.h
+++ b/security/selinux/include/netlabel.h
@@ -55,7 +55,7 @@ int selinux_netlbl_skbuff_setsid(struct sk_buff *skb,
 
 int selinux_netlbl_inet_conn_request(struct request_sock *req, u16 family);
 void selinux_netlbl_inet_csk_clone(struct sock *sk, u16 family);
-int selinux_netlbl_socket_post_create(struct sock *sk, u16 family);
+int selinux_netlbl_socket_setsid(struct sock *sk, u16 family);
 int selinux_netlbl_sock_rcv_skb(struct sk_security_struct *sksec,
 				struct sk_buff *skb,
 				u16 family,
@@ -121,8 +121,7 @@ static inline void selinux_netlbl_inet_csk_clone(struct sock *sk, u16 family)
 {
 	return;
 }
-static inline int selinux_netlbl_socket_post_create(struct sock *sk,
-						    u16 family)
+static inline int selinux_netlbl_socket_setsid(struct sock *sk, u16 family)
 {
 	return 0;
 }
diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
index 628da72..694508e 100644
--- a/security/selinux/netlabel.c
+++ b/security/selinux/netlabel.c
@@ -157,6 +157,10 @@ void selinux_netlbl_sk_security_free(struct sk_security_struct *ssec)
 void selinux_netlbl_sk_security_reset(struct sk_security_struct *ssec)
 {
 	ssec->nlbl_state = NLBL_UNSET;
+	if (ssec->nlbl_secattr != NULL) {
+		netlbl_secattr_free(ssec->nlbl_secattr);
+		ssec->nlbl_secattr = NULL;
+	}
 }
 
 /**
@@ -292,7 +296,7 @@ void selinux_netlbl_inet_csk_clone(struct sock *sk, u16 family)
 }
 
 /**
- * selinux_netlbl_socket_post_create - Label a socket using NetLabel
+ * selinux_netlbl_socket_setsid - Label a socket using NetLabel
  * @sock: the socket to label
  * @family: protocol family
  *
@@ -301,7 +305,7 @@ void selinux_netlbl_inet_csk_clone(struct sock *sk, u16 family)
  * SID.  Returns zero values on success, negative values on failure.
  *
  */
-int selinux_netlbl_socket_post_create(struct sock *sk, u16 family)
+int selinux_netlbl_socket_setsid(struct sock *sk, u16 family)
 {
 	int rc;
 	struct sk_security_struct *sksec = sk->sk_security;


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
