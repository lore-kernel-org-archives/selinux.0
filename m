From: Eric Paris <eparis@redhat.com>
Subject: [PATCH] selinux: always call sk_security_struct sksec
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org, paul.moore@hp.com
Date: Wed, 07 Apr 2010 15:08:46 -0400
Message-ID: <20100407190846.7076.36760.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

trying to grep everything that messes with a sk_security_struct isn't easy
since we don't always call it sksec.  Just rename everything sksec.

Signed-off-by: Eric Paris <eparis@redhat.com>
---

 security/selinux/hooks.c            |   50 ++++++++++++++++++-----------------
 security/selinux/include/netlabel.h |    8 +++---
 security/selinux/netlabel.c         |   14 +++++-----
 3 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 473119b..15533c3 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -294,28 +294,28 @@ static void superblock_free_security(struct super_block *sb)
 
 static int sk_alloc_security(struct sock *sk, int family, gfp_t priority)
 {
-	struct sk_security_struct *ssec;
+	struct sk_security_struct *sksec;
 
-	ssec = kzalloc(sizeof(*ssec), priority);
-	if (!ssec)
+	sksec = kzalloc(sizeof(*sksec), priority);
+	if (!sksec)
 		return -ENOMEM;
 
-	ssec->peer_sid = SECINITSID_UNLABELED;
-	ssec->sid = SECINITSID_UNLABELED;
-	sk->sk_security = ssec;
+	sksec->peer_sid = SECINITSID_UNLABELED;
+	sksec->sid = SECINITSID_UNLABELED;
+	sk->sk_security = sksec;
 
-	selinux_netlbl_sk_security_reset(ssec);
+	selinux_netlbl_sk_security_reset(sksec);
 
 	return 0;
 }
 
 static void sk_free_security(struct sock *sk)
 {
-	struct sk_security_struct *ssec = sk->sk_security;
+	struct sk_security_struct *sksec = sk->sk_security;
 
 	sk->sk_security = NULL;
-	selinux_netlbl_sk_security_free(ssec);
-	kfree(ssec);
+	selinux_netlbl_sk_security_free(sksec);
+	kfree(sksec);
 }
 
 /* The security server must be initialized before
@@ -4069,7 +4069,7 @@ static int selinux_socket_unix_stream_connect(struct socket *sock,
 					      struct socket *other,
 					      struct sock *newsk)
 {
-	struct sk_security_struct *ssec;
+	struct sk_security_struct *sksec;
 	struct inode_security_struct *isec;
 	struct inode_security_struct *other_isec;
 	struct common_audit_data ad;
@@ -4088,13 +4088,13 @@ static int selinux_socket_unix_stream_connect(struct socket *sock,
 		return err;
 
 	/* connecting socket */
-	ssec = sock->sk->sk_security;
-	ssec->peer_sid = other_isec->sid;
+	sksec = sock->sk->sk_security;
+	sksec->peer_sid = other_isec->sid;
 
 	/* server child socket */
-	ssec = newsk->sk_security;
-	ssec->peer_sid = isec->sid;
-	err = security_sid_mls_copy(other_isec->sid, ssec->peer_sid, &ssec->sid);
+	sksec = newsk->sk_security;
+	sksec->peer_sid = isec->sid;
+	err = security_sid_mls_copy(other_isec->sid, sksec->peer_sid, &sksec->sid);
 
 	return err;
 }
@@ -4257,7 +4257,7 @@ static int selinux_socket_getpeersec_stream(struct socket *sock, char __user *op
 	int err = 0;
 	char *scontext;
 	u32 scontext_len;
-	struct sk_security_struct *ssec;
+	struct sk_security_struct *sksec;
 	struct inode_security_struct *isec;
 	u32 peer_sid = SECSID_NULL;
 
@@ -4265,8 +4265,8 @@ static int selinux_socket_getpeersec_stream(struct socket *sock, char __user *op
 
 	if (isec->sclass == SECCLASS_UNIX_STREAM_SOCKET ||
 	    isec->sclass == SECCLASS_TCP_SOCKET) {
-		ssec = sock->sk->sk_security;
-		peer_sid = ssec->peer_sid;
+		sksec = sock->sk->sk_security;
+		peer_sid = sksec->peer_sid;
 	}
 	if (peer_sid == SECSID_NULL) {
 		err = -ENOPROTOOPT;
@@ -4333,14 +4333,14 @@ static void selinux_sk_free_security(struct sock *sk)
 
 static void selinux_sk_clone_security(const struct sock *sk, struct sock *newsk)
 {
-	struct sk_security_struct *ssec = sk->sk_security;
-	struct sk_security_struct *newssec = newsk->sk_security;
+	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *newsksec = newsk->sk_security;
 
-	newssec->sid = ssec->sid;
-	newssec->peer_sid = ssec->peer_sid;
-	newssec->sclass = ssec->sclass;
+	newsksec->sid = sksec->sid;
+	newsksec->peer_sid = sksec->peer_sid;
+	newsksec->sclass = sksec->sclass;
 
-	selinux_netlbl_sk_security_reset(newssec);
+	selinux_netlbl_sk_security_reset(newsksec);
 }
 
 static void selinux_sk_getsecid(struct sock *sk, u32 *secid)
diff --git a/security/selinux/include/netlabel.h b/security/selinux/include/netlabel.h
index 8d73842..cf2f628 100644
--- a/security/selinux/include/netlabel.h
+++ b/security/selinux/include/netlabel.h
@@ -42,8 +42,8 @@ void selinux_netlbl_cache_invalidate(void);
 
 void selinux_netlbl_err(struct sk_buff *skb, int error, int gateway);
 
-void selinux_netlbl_sk_security_free(struct sk_security_struct *ssec);
-void selinux_netlbl_sk_security_reset(struct sk_security_struct *ssec);
+void selinux_netlbl_sk_security_free(struct sk_security_struct *sksec);
+void selinux_netlbl_sk_security_reset(struct sk_security_struct *sksec);
 
 int selinux_netlbl_skbuff_getsid(struct sk_buff *skb,
 				 u16 family,
@@ -79,13 +79,13 @@ static inline void selinux_netlbl_err(struct sk_buff *skb,
 }
 
 static inline void selinux_netlbl_sk_security_free(
-					       struct sk_security_struct *ssec)
+					       struct sk_security_struct *sksec)
 {
 	return;
 }
 
 static inline void selinux_netlbl_sk_security_reset(
-					       struct sk_security_struct *ssec)
+					       struct sk_security_struct *sksec)
 {
 	return;
 }
diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
index 628da72..1c2fc46 100644
--- a/security/selinux/netlabel.c
+++ b/security/selinux/netlabel.c
@@ -132,21 +132,21 @@ void selinux_netlbl_err(struct sk_buff *skb, int error, int gateway)
 
 /**
  * selinux_netlbl_sk_security_free - Free the NetLabel fields
- * @sssec: the sk_security_struct
+ * @sksec: the sk_security_struct
  *
  * Description:
  * Free all of the memory in the NetLabel fields of a sk_security_struct.
  *
  */
-void selinux_netlbl_sk_security_free(struct sk_security_struct *ssec)
+void selinux_netlbl_sk_security_free(struct sk_security_struct *sksec)
 {
-	if (ssec->nlbl_secattr != NULL)
-		netlbl_secattr_free(ssec->nlbl_secattr);
+	if (sksec->nlbl_secattr != NULL)
+		netlbl_secattr_free(sksec->nlbl_secattr);
 }
 
 /**
  * selinux_netlbl_sk_security_reset - Reset the NetLabel fields
- * @ssec: the sk_security_struct
+ * @sksec: the sk_security_struct
  * @family: the socket family
  *
  * Description:
@@ -154,9 +154,9 @@ void selinux_netlbl_sk_security_free(struct sk_security_struct *ssec)
  * The caller is responsibile for all the NetLabel sk_security_struct locking.
  *
  */
-void selinux_netlbl_sk_security_reset(struct sk_security_struct *ssec)
+void selinux_netlbl_sk_security_reset(struct sk_security_struct *sksec)
 {
-	ssec->nlbl_state = NLBL_UNSET;
+	sksec->nlbl_state = NLBL_UNSET;
 }
 
 /**


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
