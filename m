Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n61MD9Cx007861
	for <selinux@tycho.nsa.gov>; Wed, 1 Jul 2009 18:13:09 -0400
Received: from g1t0029.austin.hp.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n61MCrU8011297
	for <selinux@tycho.nsa.gov>; Wed, 1 Jul 2009 22:12:53 GMT
Received: from g4t0009.houston.hp.com (g4t0009.houston.hp.com [16.234.32.26])
	by g1t0029.austin.hp.com (Postfix) with ESMTP id 2CEA838229
	for <selinux@tycho.nsa.gov>; Wed,  1 Jul 2009 22:13:08 +0000 (UTC)
From: Paul Moore <paul.moore@hp.com>
Subject: [RFC PATCH v1] There is a problem where packets being sent by the TUN
	driver are not
To: selinux@tycho.nsa.gov
Date: Wed, 01 Jul 2009 18:12:58 -0400
Message-ID: <20090701221257.7590.75518.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

correctly handled by SELinux in the postrouting code.  The issue is that
the SELinux network access controls rely on a packet's associated sock, when
present, for it's security label.  The TUN driver does create a sock to send
network traffic but it only calls into the LSM/SELinux code once via the
security_sk_alloc() hook which never fully initializes the sock's label.  This
patch attempts to correct this problem by adding additional checks in the
SELinux security_sk_alloc() alloc code to determine if the TUN driver is
allocating a socket and if so, set the socket's label.

NOTE: this is an RFC patch intended to demonstrate a possible solution not
discussed earlier; it is crude, untested and only deals with SELinux.  Please
take a look and see if this approach is even worth pursuing ... thanks.
---

 include/linux/security.h |    7 ++++---
 net/core/sock.c          |    2 +-
 security/capability.c    |    2 +-
 security/security.c      |    4 ++--
 security/selinux/hooks.c |   43 ++++++++++++++++++++++++-------------------
 5 files changed, 32 insertions(+), 26 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 5eff459..3b9ea6e 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -44,6 +44,7 @@
 
 struct ctl_table;
 struct audit_krule;
+struct proto;
 
 /*
  * These functions are in security/capability.c and are used
@@ -1562,7 +1563,7 @@ struct security_operations {
 	int (*socket_sock_rcv_skb) (struct sock *sk, struct sk_buff *skb);
 	int (*socket_getpeersec_stream) (struct socket *sock, char __user *optval, int __user *optlen, unsigned len);
 	int (*socket_getpeersec_dgram) (struct socket *sock, struct sk_buff *skb, u32 *secid);
-	int (*sk_alloc_security) (struct sock *sk, int family, gfp_t priority);
+	int (*sk_alloc_security) (struct sock *sk, int family, const struct proto *prot, gfp_t priority);
 	void (*sk_free_security) (struct sock *sk);
 	void (*sk_clone_security) (const struct sock *sk, struct sock *newsk);
 	void (*sk_getsecid) (struct sock *sk, u32 *secid);
@@ -2545,7 +2546,7 @@ int security_sock_rcv_skb(struct sock *sk, struct sk_buff *skb);
 int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
 				      int __user *optlen, unsigned len);
 int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u32 *secid);
-int security_sk_alloc(struct sock *sk, int family, gfp_t priority);
+int security_sk_alloc(struct sock *sk, int family, const struct proto *prot, gfp_t priority);
 void security_sk_free(struct sock *sk);
 void security_sk_clone(const struct sock *sk, struct sock *newsk);
 void security_sk_classify_flow(struct sock *sk, struct flowi *fl);
@@ -2667,7 +2668,7 @@ static inline int security_socket_getpeersec_dgram(struct socket *sock, struct s
 	return -ENOPROTOOPT;
 }
 
-static inline int security_sk_alloc(struct sock *sk, int family, gfp_t priority)
+static inline int security_sk_alloc(struct sock *sk, int family, const struct proto *prot, gfp_t priority)
 {
 	return 0;
 }
diff --git a/net/core/sock.c b/net/core/sock.c
index b0ba569..327513c 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -947,7 +947,7 @@ static struct sock *sk_prot_alloc(struct proto *prot, gfp_t priority,
 	if (sk != NULL) {
 		kmemcheck_annotate_bitfield(sk, flags);
 
-		if (security_sk_alloc(sk, family, priority))
+		if (security_sk_alloc(sk, family, prot, priority))
 			goto out_free;
 
 		if (!try_module_get(prot->owner))
diff --git a/security/capability.c b/security/capability.c
index 21b6cea..a57eb88 100644
--- a/security/capability.c
+++ b/security/capability.c
@@ -674,7 +674,7 @@ static int cap_socket_getpeersec_dgram(struct socket *sock,
 	return -ENOPROTOOPT;
 }
 
-static int cap_sk_alloc_security(struct sock *sk, int family, gfp_t priority)
+static int cap_sk_alloc_security(struct sock *sk, int family, const struct proto *prot, gfp_t priority)
 {
 	return 0;
 }
diff --git a/security/security.c b/security/security.c
index dc7674f..17c5419 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1060,9 +1060,9 @@ int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u
 }
 EXPORT_SYMBOL(security_socket_getpeersec_dgram);
 
-int security_sk_alloc(struct sock *sk, int family, gfp_t priority)
+int security_sk_alloc(struct sock *sk, int family, const struct proto *prot, gfp_t priority)
 {
-	return security_ops->sk_alloc_security(sk, family, priority);
+	return security_ops->sk_alloc_security(sk, family, prot, priority);
 }
 
 void security_sk_free(struct sock *sk)
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 15c2a08..dde57d1 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -298,16 +298,21 @@ static void superblock_free_security(struct super_block *sb)
 	kfree(sbsec);
 }
 
-static int sk_alloc_security(struct sock *sk, int family, gfp_t priority)
+static int sk_alloc_security(struct sock *sk, int family, const struct proto *prot, gfp_t priority)
 {
 	struct sk_security_struct *ssec;
+	const struct task_security_struct *tsec = current_security();
 
 	ssec = kzalloc(sizeof(*ssec), priority);
 	if (!ssec)
 		return -ENOMEM;
 
+	if (strcmp(prot->name, "tun") == 0) {
+		ssec->sid = (tsec->sockcreate_sid ? : tsec->sid);
+		/* XXX - probably want to label the socket here too */
+	} else
+		ssec->sid = SECINITSID_UNLABELED;
 	ssec->peer_sid = SECINITSID_UNLABELED;
-	ssec->sid = SECINITSID_UNLABELED;
 	sk->sk_security = ssec;
 
 	selinux_netlbl_sk_security_reset(ssec);
@@ -3673,32 +3678,32 @@ out:
 static int selinux_socket_post_create(struct socket *sock, int family,
 				      int type, int protocol, int kern)
 {
-	const struct cred *cred = current_cred();
-	const struct task_security_struct *tsec = cred->security;
-	struct inode_security_struct *isec;
+	const struct task_security_struct *tsec = current_security();
+	struct inode_security_struct *isec = SOCK_INODE(sock)->i_security;
 	struct sk_security_struct *sksec;
-	u32 sid, newsid;
+	u32 sid;
 	int err = 0;
 
-	sid = tsec->sid;
-	newsid = tsec->sockcreate_sid;
-
-	isec = SOCK_INODE(sock)->i_security;
+	if (sock->sk)
+		sksec = sock->sk->sk_security;
+	else
+		sksec = NULL;
 
 	if (kern)
-		isec->sid = SECINITSID_KERNEL;
-	else if (newsid)
-		isec->sid = newsid;
+		sid = SECINITSID_KERNEL;
+	else if (sksec && sksec->sid != SECINITSID_UNLABELED)
+		sid = sksec->sid;
 	else
-		isec->sid = sid;
+		sid = (tsec->sockcreate_sid ? : tsec->sid);
 
 	isec->sclass = socket_type_to_security_class(family, type, protocol);
 	isec->initialized = 1;
 
-	if (sock->sk) {
-		sksec = sock->sk->sk_security;
-		sksec->sid = isec->sid;
+	if (sksec) {
+		/* XXX - end up changing this if kern is true - problem? */
+		sksec->sid = sid;
 		sksec->sclass = isec->sclass;
+		/* XXX - this will be tricky depending on how things work out */
 		err = selinux_netlbl_socket_post_create(sock->sk, family);
 	}
 
@@ -4187,9 +4192,9 @@ out:
 	return 0;
 }
 
-static int selinux_sk_alloc_security(struct sock *sk, int family, gfp_t priority)
+static int selinux_sk_alloc_security(struct sock *sk, int family, const struct proto *prot, gfp_t priority)
 {
-	return sk_alloc_security(sk, family, priority);
+	return sk_alloc_security(sk, family, prot, priority);
 }
 
 static void selinux_sk_free_security(struct sock *sk)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
