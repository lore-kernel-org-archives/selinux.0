Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9QKbM2W012485
	for <selinux@tycho.nsa.gov>; Thu, 26 Oct 2006 16:37:22 -0400
Received: from atlrel8.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9QKZoW7000455
	for <selinux@tycho.nsa.gov>; Thu, 26 Oct 2006 20:35:50 GMT
Message-ID: <45411C79.70405@hp.com>
Date: Thu, 26 Oct 2006 16:37:13 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>, James Morris <jmorris@redhat.com>
Cc: selinux@tycho.nsa.gov
Subject: [RFC] protect NetLabel options from setsockopt (was: socket options
 ... again)
References: <4540E083.2030304@hp.com> <1161881175.16681.239.camel@moss-spartans.epoch.ncsc.mil> <45410778.5040302@hp.com>
In-Reply-To: <45410778.5040302@hp.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Paul Moore wrote:
> 
> Ungh.  I really wanted to believe it was that simple, but upon further
> inspection it looks like simply adding CAP_NET_RAW only prevents applications
> from setting their own CIPSO option it does not prevent users from replacing a
> CIPSO option with another option like source routing.  With this in mind I think
> adding the CAP_NET_RAW check and going with option #2 (see above) is the best
> choice ... thoughts?
> 

Below is a quick patch which adds both the CAP_NET_RAW check and option #2 check
(see the rest of the thread for details).  You will also notice some slight
locking changes in selinux_netlbl_inode_permission(); I believe these are
necessary to prevent a race condition with the checks in
selinux_netlbl_socket_setsockopt().

I haven't had much chance to test this code yet (all I know is it compiles and
boots) but I won't be in a position where I can do much testing this Friday or
over the weekend so I thought it might be a good idea to at least throw this out
as a RFC patch to let people comment.  If there are no objections and nothing
pops up during testing I'll post this for inclusion early next week.

(My apologies for the whitespace issues in the diff below but I wasn't sure how
to post a patch w/o losing the threading any other way)

Index: net-2.6_sockopt/net/ipv4/cipso_ipv4.c
===================================================================
--- net-2.6_sockopt.orig/net/ipv4/cipso_ipv4.c
+++ net-2.6_sockopt/net/ipv4/cipso_ipv4.c
@@ -1307,7 +1307,8 @@ int cipso_v4_socket_setattr(const struct

        /* We can't use ip_options_get() directly because it makes a call to
         * ip_options_get_alloc() which allocates memory with GFP_KERNEL and
-        * we can't block here. */
+        * we won't always have CAP_NET_RAW even though we _always_ want to
+        * set the IPOPT_CIPSO option. */
        opt_len = (buf_len + 3) & ~3;
        opt = kzalloc(sizeof(*opt) + opt_len, GFP_ATOMIC);
        if (opt == NULL) {
@@ -1317,11 +1318,9 @@ int cipso_v4_socket_setattr(const struct
        memcpy(opt->__data, buf, buf_len);
        opt->optlen = opt_len;
        opt->is_data = 1;
+       opt->cipso = sizeof(struct iphdr);
        kfree(buf);
        buf = NULL;
-       ret_val = ip_options_compile(opt, NULL);
-       if (ret_val != 0)
-               goto socket_setattr_failure;

        sk_inet = inet_sk(sk);
        if (sk_inet->is_icsk) {
Index: net-2.6_sockopt/net/ipv4/ip_options.c
===================================================================
--- net-2.6_sockopt.orig/net/ipv4/ip_options.c
+++ net-2.6_sockopt/net/ipv4/ip_options.c
@@ -443,7 +443,7 @@ int ip_options_compile(struct ip_options
                                opt->router_alert = optptr - iph;
                        break;
                      case IPOPT_CIPSO:
-                       if (opt->cipso) {
+                       if ((!skb && !capable(CAP_NET_RAW)) || opt->cipso) {
                                pp_ptr = optptr;
                                goto error;
                        }
Index: net-2.6_sockopt/security/selinux/hooks.c
===================================================================
--- net-2.6_sockopt.orig/security/selinux/hooks.c
+++ net-2.6_sockopt/security/selinux/hooks.c
@@ -3313,7 +3313,13 @@ static int selinux_socket_getpeername(st

 static int selinux_socket_setsockopt(struct socket *sock,int level,int optname) {
-       return socket_has_perm(current, sock, SOCKET__SETOPT);
+       int err;
+
+       err = socket_has_perm(current, sock, SOCKET__SETOPT);
+       if (err)
+               return err;
+
+       return selinux_netlbl_socket_setsockopt(sock, level, optname);
 }

 static int selinux_socket_getsockopt(struct socket *sock, int level,
Index: net-2.6_sockopt/security/selinux/include/selinux_netlabel.h
===================================================================
--- net-2.6_sockopt.orig/security/selinux/include/selinux_netlabel.h
+++ net-2.6_sockopt/security/selinux/include/selinux_netlabel.h
@@ -53,6 +53,9 @@ void selinux_netlbl_sk_security_init(str
 void selinux_netlbl_sk_clone_security(struct sk_security_struct *ssec,
                                      struct sk_security_struct *newssec);
 int selinux_netlbl_inode_permission(struct inode *inode, int mask);
+int selinux_netlbl_socket_setsockopt(struct socket *sock,
+                                    int level,
+                                    int optname);
 #else
 static inline void selinux_netlbl_cache_invalidate(void)
 {
@@ -114,6 +117,13 @@ static inline int selinux_netlbl_inode_p
 {
        return 0;
 }
+
+static inline int selinux_netlbl_socket_setsockopt(struct socket *sock,
+                                                  int level,
+                                                  int optname)
+{
+       return 0;
+}
 #endif /* CONFIG_NETLABEL */

 #endif
Index: net-2.6_sockopt/security/selinux/ss/services.c
===================================================================
--- net-2.6_sockopt.orig/security/selinux/ss/services.c
+++ net-2.6_sockopt/security/selinux/ss/services.c
@@ -2576,20 +2576,19 @@ int selinux_netlbl_inode_permission(stru
        struct sk_security_struct *sksec;
        struct socket *sock;

-       if (!S_ISSOCK(inode->i_mode))
+       if (!S_ISSOCK(inode->i_mode) || !(mask & (MAY_WRITE | MAY_APPEND)))
                return 0;

        sock = SOCKET_I(inode);
        isec = inode->i_security;
        sksec = sock->sk->sk_security;
        mutex_lock(&isec->lock);
-       if (unlikely(sksec->nlbl_state == NLBL_REQUIRE &&
-                    (mask & (MAY_WRITE | MAY_APPEND)))) {
-               lock_sock(sock->sk);
+       lock_sock(sock->sk);
+       if (unlikely(sksec->nlbl_state == NLBL_REQUIRE))
                rc = selinux_netlbl_socket_setsid(sock, sksec->sid);
-               release_sock(sock->sk);
-       } else
+       else
                rc = 0;
+       release_sock(sock->sk);
        mutex_unlock(&isec->lock);

        return rc;
@@ -2682,4 +2681,39 @@ u32 selinux_netlbl_socket_getpeersec_dgr

        return peer_sid;
 }
+
+/**
+ * selinux_netlbl_socket_setsockopt - Do not allow users to remove a NetLabel
+ * @sock: the socket
+ * @level: the socket level or protocol
+ * @optname: the socket option name
+ *
+ * Description:
+ * Check the setsockopt() call and if the user is trying to replace the IP
+ * options on a socket and a NetLabel is in place for the socket deny the
+ * access; otherwise allow the access.  Returns zero when the access is
+ * allowed, -EACCES when denied, and other negative values on error.
+ *
+ */
+int selinux_netlbl_socket_setsockopt(struct socket *sock,
+                                    int level,
+                                    int optname)
+{
+       int rc = 0;
+       struct sk_security_struct *sksec = sock->sk->sk_security;
+       struct netlbl_lsm_secattr secattr;
+
+       lock_sock(sock->sk);
+       if (level == IPPROTO_IP && optname == IP_OPTIONS &&
+           sksec->nlbl_state == NLBL_LABELED) {
+               netlbl_secattr_init(&secattr);
+               rc = netlbl_socket_getattr(sock, &secattr);
+               if (rc == 0 && (secattr.cache || secattr.mls_lvl_vld))
+                       rc = -EACCES;
+               netlbl_secattr_destroy(&secattr);
+       }
+       release_sock(sock->sk);
+
+       return rc;
+}
 #endif /* CONFIG_NETLABEL */

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
