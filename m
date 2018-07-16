Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w6GIbHQK023517
 for <selinux@tycho.nsa.gov>; Mon, 16 Jul 2018 14:37:17 -0400
To: LSM <linux-security-module@vger.kernel.org>,
 LKLM <linux-kernel@vger.kernel.org>, Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>,
 "SMACK-discuss@lists.01.org" <SMACK-discuss@lists.01.org>,
 John Johansen <john.johansen@canonical.com>,
 Kees Cook <keescook@chromium.org>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 James Morris <jmorris@namei.org>
Cc: "Schaufler, Casey" <casey.schaufler@intel.com>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <8a325db8-e7eb-9581-2b77-fc987a165df7@schaufler-ca.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <ac4a4408-5c69-4b87-b57d-537dba588b18@schaufler-ca.com>
Date: Mon, 16 Jul 2018 11:24:42 -0700
MIME-Version: 1.0
In-Reply-To: <8a325db8-e7eb-9581-2b77-fc987a165df7@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Subject: [PATCH v1 20/22] Move common usercopy into security_getpeersec_stream
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

[PATCH 20/22] Move common usercopy into security_getpeersec_stream

The modules implementing hook for getpeersec_stream
don't need to be duplicating the copy-to-user checks.
Moving the user copy part into the infrastructure makes
the security module code simpler and reduces the places
where user copy code may go awry.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h  | 10 ++++------
 include/linux/security.h   |  6 ++++--
 security/apparmor/lsm.c    | 28 ++++++++++------------------
 security/security.c        | 17 +++++++++++++++--
 security/selinux/hooks.c   | 22 +++++++---------------
 security/smack/smack_lsm.c | 19 ++++++++-----------
 6 files changed, 48 insertions(+), 54 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 7c321d11d994..8d247e7ce2fb 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -846,9 +846,8 @@
  *	SO_GETPEERSEC.  For tcp sockets this can be meaningful if the
  *	socket is associated with an ipsec SA.
  *	@sock is the local socket.
- *	@optval userspace memory where the security state is to be copied.
- *	@optlen userspace int where the module should copy the actual length
- *	of the security state.
+ *	@optval the security state.
+ *	@optlen the actual length of the security state.
  *	@len as input is the maximum length to copy to userspace provided
  *	by the caller.
  *	Return 0 if all is well, otherwise, typical getsockopt return
@@ -1680,9 +1679,8 @@ union security_list_options {
 	int (*socket_setsockopt)(struct socket *sock, int level, int optname);
 	int (*socket_shutdown)(struct socket *sock, int how);
 	int (*socket_sock_rcv_skb)(struct sock *sk, struct sk_buff *skb);
-	int (*socket_getpeersec_stream)(struct socket *sock,
-					char __user *optval,
-					int __user *optlen, unsigned int len);
+	int (*socket_getpeersec_stream)(struct socket *sock, char **optval,
+					int *optlen, unsigned int len);
 	int (*socket_getpeersec_dgram)(struct socket *sock,
 					struct sk_buff *skb,
 					struct secids *secid);
diff --git a/include/linux/security.h b/include/linux/security.h
index 9095f63c65a9..7d3300d34f25 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1377,8 +1377,10 @@ static inline int security_sock_rcv_skb(struct sock *sk,
 	return 0;
 }
 
-static inline int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
-						    int __user *optlen, unsigned len)
+static inline int security_socket_getpeersec_stream(struct socket *sock,
+						    char __user *optval,
+						    int __user *optlen,
+						    unsigned int len)
 {
 	return -ENOPROTOOPT;
 }
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index b0200481c811..7a2a8d0efa09 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1026,10 +1026,8 @@ static struct aa_label *sk_peer_label(struct sock *sk)
  *
  * Note: for tcp only valid if using ipsec or cipso on lan
  */
-static int apparmor_socket_getpeersec_stream(struct socket *sock,
-					     char __user *optval,
-					     int __user *optlen,
-					     unsigned int len)
+static int apparmor_socket_getpeersec_stream(struct socket *sock, char **optval,
+					     int *optlen, unsigned int len)
 {
 	char *name;
 	int slen, error = 0;
@@ -1046,22 +1044,16 @@ static int apparmor_socket_getpeersec_stream(struct socket *sock,
 				 FLAG_SHOW_MODE | FLAG_VIEW_SUBNS |
 				 FLAG_HIDDEN_UNCONFINED, GFP_KERNEL);
 	/* don't include terminating \0 in slen, it breaks some apps */
-	if (slen < 0) {
+	if (slen < 0)
 		error = -ENOMEM;
-	} else {
-		if (slen > len) {
-			error = -ERANGE;
-		} else if (copy_to_user(optval, name, slen)) {
-			error = -EFAULT;
-			goto out;
-		}
-		if (put_user(slen, optlen))
-			error = -EFAULT;
-out:
-		kfree(name);
-
+	else if (slen > len)
+		error = -ERANGE;
+	else {
+		*optlen = slen;
+		*optval = name;
 	}
-
+	if (error)
+		kfree(name);
 done:
 	end_current_label_crit_section(label);
 
diff --git a/security/security.c b/security/security.c
index 90e741db0a42..521afa12293e 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1930,8 +1930,21 @@ EXPORT_SYMBOL(security_sock_rcv_skb);
 int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
 				      int __user *optlen, unsigned len)
 {
-	return call_int_hook(socket_getpeersec_stream, -ENOPROTOOPT, sock,
-				optval, optlen, len);
+	char *tval = NULL;
+	u32 tlen;
+	int rc;
+
+	rc = call_int_hook(socket_getpeersec_stream, -ENOPROTOOPT, sock,
+			   &tval, &tlen, len);
+	if (rc == 0) {
+		tlen = strlen(tval) + 1;
+		if (put_user(tlen, optlen))
+			rc = -EFAULT;
+		else if (copy_to_user(optval, tval, tlen))
+			rc = -EFAULT;
+		kfree(tval);
+	}
+	return rc;
 }
 
 int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index c12c36f72258..6614d46feac4 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4986,10 +4986,8 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 	return err;
 }
 
-static int selinux_socket_getpeersec_stream(struct socket *sock,
-					    __user char *optval,
-					    __user int *optlen,
-					    unsigned int len)
+static int selinux_socket_getpeersec_stream(struct socket *sock, char **optval,
+					    int *optlen, unsigned int len)
 {
 	int err = 0;
 	char *scontext;
@@ -5010,18 +5008,12 @@ static int selinux_socket_getpeersec_stream(struct socket *sock,
 		return err;
 
 	if (scontext_len > len) {
-		err = -ERANGE;
-		goto out_len;
+		kfree(scontext);
+		return -ERANGE;
 	}
-
-	if (copy_to_user(optval, scontext, scontext_len))
-		err = -EFAULT;
-
-out_len:
-	if (put_user(scontext_len, optlen))
-		err = -EFAULT;
-	kfree(scontext);
-	return err;
+	*optval = scontext;
+	*optlen = scontext_len;
+	return 0;
 }
 
 static int selinux_socket_getpeersec_dgram(struct socket *sock,
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 157c6a731305..d4552b2286bc 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3895,14 +3895,12 @@ static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
  *
  * returns zero on success, an error code otherwise
  */
-static int smack_socket_getpeersec_stream(struct socket *sock,
-					  char __user *optval,
-					  int __user *optlen, unsigned len)
+static int smack_socket_getpeersec_stream(struct socket *sock, char **optval,
+					  int *optlen, unsigned int len)
 {
 	struct socket_smack *ssp;
 	char *rcp = "";
 	int slen = 1;
-	int rc = 0;
 
 	ssp = smack_sock(sock->sk);
 	if (ssp->smk_packet != NULL) {
@@ -3911,14 +3909,13 @@ static int smack_socket_getpeersec_stream(struct socket *sock,
 	}
 
 	if (slen > len)
-		rc = -ERANGE;
-	else if (copy_to_user(optval, rcp, slen) != 0)
-		rc = -EFAULT;
-
-	if (put_user(slen, optlen) != 0)
-		rc = -EFAULT;
+		return -ERANGE;
 
-	return rc;
+	*optval = kstrdup(rcp, GFP_ATOMIC);
+	if (*optval == NULL)
+		return -ENOMEM;
+	*optlen = slen;
+	return 0;
 }
 
 
-- 
2.17.1
