Message-ID: <44F8B50E.3060303@hp.com>
Date: Fri, 01 Sep 2006 18:32:46 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: Paul Moore <paul.moore@hp.com>
Cc: Venkat Yekkirala <vyekkirala@TrustedCS.com>,
        Joy Latten <latten@austin.ibm.com>, latten@us.ibm.com,
        jbrindle@tresys.com, sds@tycho.nsa.gov, selinux@tycho.nsa.gov
Subject: Re: ipsec and getpeercon()
References: <36282A1733C57546BE392885C061859201512DD1@chaos.tcs.tcs-sec.com> <44F89F0C.6030402@hp.com>
In-Reply-To: <44F89F0C.6030402@hp.com>
Content-Type: multipart/mixed;
 boundary="------------080801040302010701050903"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080801040302010701050903
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Paul Moore wrote:
> Venkat Yekkirala wrote:
> 
>>>Unfortunately, the fix
>>>is not immediately obvious.
>>
>>You would use the xfrm_sid and in it's absence the node
>>sid as the base sid.
> 
> 
> That is not the issue I am dealing with right now.
> 
> I now have a solution in mind, however, it is doubtful I will have a
> chance to do any sort of testing on it before I leave tonight.  Once I
> can give it a quick test to verify that it doesn't break anything I'll
> post a patch for you and Joy to verify.
> 

Sorry for attaching the patch as an attachment but I'm in a rush to get
out of here ...

This patch is against David Miller's net-2.6.19 tree from a day or two
ago, depending on your kernel you may have some fuzz when applying this
patch.  I've only done some quick functional tests, but it seems to
solve this problem.

Joy, Venkat if you are able to test this and let me know the results I
would appreciate it.

Thanks.

-- 
paul moore
linux security @ hp

--------------080801040302010701050903
Content-Type: text/plain;
 name="netlabel-bug_peersec"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="netlabel-bug_peersec"

Subject: NetLabel: correct improper handling on non-NetLabel peer contexts
From: Paul Moore <paul.moore@hp.com>

Fix a problem where NetLabel would always set the value of 
sk_security_struct->peer_sid in selinux_netlbl_sock_graft() to the context of
the socket, causing problems when users would query the context of the
connection.  This patch fixes this so that the value in
sk_security_struct->peer_sid is only set when the connection is NetLabel based,
otherwise the value is untouched.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---
 include/net/cipso_ipv4.h       |    7 +++++
 include/net/netlabel.h         |    8 ++++++
 net/ipv4/cipso_ipv4.c          |   48 ++++++++++++++++++++++++++++-------------
 net/netlabel/netlabel_kapi.c   |   23 +++++++++++++++++++
 security/selinux/ss/services.c |   12 +++++++++-
 5 files changed, 82 insertions(+), 16 deletions(-)

Index: net-2.6.19/include/net/cipso_ipv4.h
===================================================================
--- net-2.6.19.orig/include/net/cipso_ipv4.h
+++ net-2.6.19/include/net/cipso_ipv4.h
@@ -205,6 +205,7 @@ void cipso_v4_error(struct sk_buff *skb,
 int cipso_v4_socket_setattr(const struct socket *sock,
 			    const struct cipso_v4_doi *doi_def,
 			    const struct netlbl_lsm_secattr *secattr);
+int cipso_v4_sock_getattr(struct sock *sk, struct netlbl_lsm_secattr *secattr);
 int cipso_v4_socket_getattr(const struct socket *sock,
 			    struct netlbl_lsm_secattr *secattr);
 int cipso_v4_skbuff_getattr(const struct sk_buff *skb,
@@ -225,6 +226,12 @@ static inline int cipso_v4_socket_setatt
 	return -ENOSYS;
 }
 
+static inline int cipso_v4_sock_getattr(struct sock *sk,
+					struct netlbl_lsm_secattr *secattr)
+{
+	return -ENOSYS;
+}
+
 static inline int cipso_v4_socket_getattr(const struct socket *sock,
 					  struct netlbl_lsm_secattr *secattr)
 {
Index: net-2.6.19/include/net/netlabel.h
===================================================================
--- net-2.6.19.orig/include/net/netlabel.h
+++ net-2.6.19/include/net/netlabel.h
@@ -238,6 +238,8 @@ static inline void netlbl_secattr_free(s
 #ifdef CONFIG_NETLABEL
 int netlbl_socket_setattr(const struct socket *sock,
 			  const struct netlbl_lsm_secattr *secattr);
+int netlbl_sock_getattr(struct sock *sk,
+			struct netlbl_lsm_secattr *secattr);
 int netlbl_socket_getattr(const struct socket *sock,
 			  struct netlbl_lsm_secattr *secattr);
 int netlbl_skbuff_getattr(const struct sk_buff *skb,
@@ -250,6 +252,12 @@ static inline int netlbl_socket_setattr(
 	return -ENOSYS;
 }
 
+static inline int netlbl_sock_getattr(struct sock *sk,
+				      struct netlbl_lsm_secattr *secattr)
+{
+	return -ENOSYS;
+}
+
 static inline int netlbl_socket_getattr(const struct socket *sock,
 					struct netlbl_lsm_secattr *secattr)
 {
Index: net-2.6.19/net/ipv4/cipso_ipv4.c
===================================================================
--- net-2.6.19.orig/net/ipv4/cipso_ipv4.c
+++ net-2.6.19/net/ipv4/cipso_ipv4.c
@@ -1486,43 +1486,40 @@ socket_setattr_failure:
 }
 
 /**
- * cipso_v4_socket_getattr - Get the security attributes from a socket
- * @sock: the socket
+ * cipso_v4_sock_getattr - Get the security attributes from a sock
+ * @sk: the sock
  * @secattr: the security attributes
  *
  * Description:
- * Query @sock to see if there is a CIPSO option attached to the socket and if
- * there is return the CIPSO security attributes in @secattr.  Returns zero on
- * success and negative values on failure.
+ * Query @sk to see if there is a CIPSO option attached to the sock and if
+ * there is return the CIPSO security attributes in @secattr.  This function
+ * requires that @sk be locked, or privately held, but it does not do any
+ * locking itself.  Returns zero on success and negative values on failure.
  *
  */
-int cipso_v4_socket_getattr(const struct socket *sock,
-			    struct netlbl_lsm_secattr *secattr)
+int cipso_v4_sock_getattr(struct sock *sk, struct netlbl_lsm_secattr *secattr)
 {
 	int ret_val = -ENOMSG;
-	struct sock *sk;
 	struct inet_sock *sk_inet;
 	unsigned char *cipso_ptr;
 	u32 doi;
 	struct cipso_v4_doi *doi_def;
 
-	sk = sock->sk;
-	lock_sock(sk);
 	sk_inet = inet_sk(sk);
 	if (sk_inet->opt == NULL || sk_inet->opt->cipso == 0)
-		goto socket_getattr_return;
+		return -ENOMSG;
 	cipso_ptr = sk_inet->opt->__data + sk_inet->opt->cipso -
 		sizeof(struct iphdr);
 	ret_val = cipso_v4_cache_check(cipso_ptr, cipso_ptr[1], secattr);
 	if (ret_val == 0)
-		goto socket_getattr_return;
+		return ret_val;
 
 	doi = ntohl(*(u32 *)&cipso_ptr[2]);
 	rcu_read_lock();
 	doi_def = cipso_v4_doi_getdef(doi);
 	if (doi_def == NULL) {
 		rcu_read_unlock();
-		goto socket_getattr_return;
+		return -ENOMSG;
 	}
 	switch (cipso_ptr[6]) {
 	case CIPSO_V4_TAG_RBITMAP:
@@ -1533,8 +1530,29 @@ int cipso_v4_socket_getattr(const struct
 	}
 	rcu_read_unlock();
 
-socket_getattr_return:
-	release_sock(sk);
+	return ret_val;
+}
+
+/**
+ * cipso_v4_socket_getattr - Get the security attributes from a socket
+ * @sock: the socket
+ * @secattr: the security attributes
+ *
+ * Description:
+ * Query @sock to see if there is a CIPSO option attached to the socket and if
+ * there is return the CIPSO security attributes in @secattr.  Returns zero on
+ * success and negative values on failure.
+ *
+ */
+int cipso_v4_socket_getattr(const struct socket *sock,
+			    struct netlbl_lsm_secattr *secattr)
+{
+	int ret_val;
+
+	lock_sock(sock->sk);
+	ret_val = cipso_v4_sock_getattr(sock->sk, secattr);
+	release_sock(sock->sk);
+
 	return ret_val;
 }
 
Index: net-2.6.19/net/netlabel/netlabel_kapi.c
===================================================================
--- net-2.6.19.orig/net/netlabel/netlabel_kapi.c
+++ net-2.6.19/net/netlabel/netlabel_kapi.c
@@ -85,6 +85,29 @@ socket_setattr_return:
 }
 
 /**
+ * netlbl_sock_getattr - Determine the security attributes of a sock
+ * @sk: the sock
+ * @secattr: the security attributes
+ *
+ * Description:
+ * Examines the given sock to see any NetLabel style labeling has been
+ * applied to the sock, if so it parses the socket label and returns the
+ * security attributes in @secattr.  Returns zero on success, negative values
+ * on failure.
+ *
+ */
+int netlbl_sock_getattr(struct sock *sk, struct netlbl_lsm_secattr *secattr)
+{
+	int ret_val;
+
+	ret_val = cipso_v4_sock_getattr(sk, secattr);
+	if (ret_val == 0)
+		return 0;
+
+	return netlbl_unlabel_getattr(secattr);
+}
+
+/**
  * netlbl_socket_getattr - Determine the security attributes of a socket
  * @sock: the socket
  * @secattr: the security attributes
Index: net-2.6.19/security/selinux/ss/services.c
===================================================================
--- net-2.6.19.orig/security/selinux/ss/services.c
+++ net-2.6.19/security/selinux/ss/services.c
@@ -2502,14 +2502,24 @@ void selinux_netlbl_sock_graft(struct so
 {
 	struct inode_security_struct *isec = SOCK_INODE(sock)->i_security;
 	struct sk_security_struct *sksec = sk->sk_security;
+	struct netlbl_lsm_secattr secattr;
+	u32 nlbl_peer_sid;
 
 	sksec->sclass = isec->sclass;
 
 	if (sk->sk_family != PF_INET)
 		return;
 
+	netlbl_secattr_init(&secattr);
+	if (netlbl_sock_getattr(sk, &secattr) == 0 &&
+	    selinux_netlbl_secattr_to_sid(NULL,
+					  &secattr,
+					  sksec->sid,
+					  &nlbl_peer_sid) == 0)
+		sksec->peer_sid = nlbl_peer_sid;
+	netlbl_secattr_destroy(&secattr, 0);
+
 	sksec->nlbl_state = NLBL_REQUIRE;
-	sksec->peer_sid = sksec->sid;
 
 	/* Try to set the NetLabel on the socket to save time later, if we fail
 	 * here we will pick up the pieces in later calls to

--------------080801040302010701050903--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
