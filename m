Message-ID: <45253511.9030203@hp.com>
Date: Thu, 05 Oct 2006 12:38:41 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: selinux list <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Cc: Venkat Yekkirala <vyekkirala@TrustedCS.com>,
        James Morris <jmorris@redhat.com>, Eric Paris <eparis@redhat.com>
Subject: Re: [RFC] NetLabel: shift to using SECINITSID_UNLABLED as a base
References: <45250AF3.1020304@hp.com> <452525C1.7010304@hp.com>
In-Reply-To: <452525C1.7010304@hp.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Paul Moore wrote:
> Paul Moore wrote:
> 
>>This patch changes NetLabel from using SECINITSID_NETMSG and the parent socket's
>>SID as the for the TE portion of the NetLabel context to now use
>>SECINITSID_UNLABELED.  This should address the issues brought up yesterday.
>>Please take a look and let me know if this what you had in mind; if it is
>>acceptable I'll repost this for inclusion.
>>
>>This patch is independent of the secid patches and should be treated as a bugfix
>>for 2.6.19.  A similar patch to deal with the secid case will be coming later today.
> 
> Testing has shown that this patch is still missing a few pieces.  I'll have an
> updated version later.  Sorry about that.
> 

Below is the corrected patch, note the additional changes to
selinux_netlbl_socket_getpeersec_dgram().

Index: net-2.6_bugfix/security/selinux/ss/services.c
===================================================================
--- net-2.6_bugfix.orig/security/selinux/ss/services.c
+++ net-2.6_bugfix/security/selinux/ss/services.c
@@ -2331,7 +2331,7 @@ static int selinux_netlbl_secattr_to_sid
                        selinux_netlbl_cache_add(skb, &ctx_new);
                ebitmap_destroy(&ctx_new.range.level[0].cat);
        } else {
-               *sid = SECINITSID_UNLABELED;
+               *sid = SECSID_NULL;
                rc = 0;
        }

@@ -2514,7 +2514,7 @@ void selinux_netlbl_sock_graft(struct so
        if (netlbl_sock_getattr(sk, &secattr) == 0 &&
            selinux_netlbl_secattr_to_sid(NULL,
                                          &secattr,
-                                         sksec->sid,
+                                         SECINITSID_UNLABELED,
                                          &nlbl_peer_sid) == 0)
                sksec->peer_sid = nlbl_peer_sid;
        netlbl_secattr_destroy(&secattr, 0);
@@ -2547,9 +2547,6 @@ u32 selinux_netlbl_inet_conn_request(str
        if (rc != 0)
                return SECSID_NULL;

-       if (peer_sid == SECINITSID_UNLABELED)
-               return SECSID_NULL;
-
        return peer_sid;
 }

@@ -2611,11 +2608,13 @@ int selinux_netlbl_sock_rcv_skb(struct s
        u32 netlbl_sid;
        u32 recv_perm;

-       rc = selinux_netlbl_skbuff_getsid(skb, SECINITSID_NETMSG, &netlbl_sid);
+       rc = selinux_netlbl_skbuff_getsid(skb,
+                                         SECINITSID_UNLABELED,
+                                         &netlbl_sid);
        if (rc != 0)
                return rc;

-       if (netlbl_sid == SECINITSID_UNLABELED)
+       if (netlbl_sid == SECSID_NULL)
                return 0;

        switch (sksec->sclass) {
@@ -2653,10 +2652,6 @@ int selinux_netlbl_sock_rcv_skb(struct s
 u32 selinux_netlbl_socket_getpeersec_stream(struct socket *sock)
 {
        struct sk_security_struct *sksec = sock->sk->sk_security;
-
-       if (sksec->peer_sid == SECINITSID_UNLABELED)
-               return SECSID_NULL;
-
        return sksec->peer_sid;
 }

@@ -2672,16 +2667,10 @@ u32 selinux_netlbl_socket_getpeersec_str
 u32 selinux_netlbl_socket_getpeersec_dgram(struct sk_buff *skb)
 {
        int peer_sid;
-       struct sock *sk = skb->sk;
-       struct inode_security_struct *isec;
-
-       if (sk == NULL || sk->sk_socket == NULL)
-               return SECSID_NULL;

-       isec = SOCK_INODE(sk->sk_socket)->i_security;
-       if (selinux_netlbl_skbuff_getsid(skb, isec->sid, &peer_sid) != 0)
-               return SECSID_NULL;
-       if (peer_sid == SECINITSID_UNLABELED)
+       if (selinux_netlbl_skbuff_getsid(skb,
+                                        SECINITSID_UNLABELED,
+                                        &peer_sid) != 0)
                return SECSID_NULL;

        return peer_sid;

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
