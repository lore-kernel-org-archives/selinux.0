Message-Id: <20070314025023.115872483@hp.com>
Date: Tue, 13 Mar 2007 22:50:06 -0400
From: Paul Moore <paul.moore@hp.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org
Subject: [RFC] SELinux: use SECINITSID_NETMSG instead of SECINITSID_UNLABELED for NetLabel
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

A long time ago, before the secid reconciliation "fun" the SELinux/NetLabel glue
code made use of SECINITSID_NETMSG as the basis for the TE portion of
the context when there was none to be had in the incoming packet's security
attributes (i.e. when using CIPSO).  This worked well enough, but then the
secid reconciliation effort came along and it wanted to use the NETMSG initial
SID so NetLabel was changed to use the UNLABELED initial SID (there were other
arguments as well, search the archives if interested).  This change was
invisibile to users since policy by default assigns both the NETMSG and
UNLABELED intitial SIDs the "unlabeled_t" type.

Well, the secid reconciliation effort died a painful death but the SELinux
NetLabel support continued to use the UNLABELED initial SID.  At first glance
this may not appear to be a very big deal but it does have some implications
which are not very pretty.  The main problem is that it is currently impossible
to have a SELinux access check for an unlabeled packet using the 
{tcp,udp,rawip}_socket:recvfrom permission.  Why is that?  The reason is that
the SELinux/NetLabel glue code has to use SECINITSID_UNLABELED as a base which
means that NetLabel'd packets look exactly like normal unlabeled objects on the
system (although they have different MLS sensitivity labels).  Using
SECINITSID_UNLABELED does not give us any alternate type to use for packets
without NetLabel security attributes since we already using that type for
packets with NetLabel security attributes.  As a result the NetLabel access
check is only done when NetLabel security attributes are present.

I'm proposing two changes to the existing SELinux/NetLabel glue code:

1. Switch to using SECINITSID_NETMSG for packets with NetLabel security
   attributes
2. Add a unlabeled check for packets without NetLabel security attributes
   using SECINITSID_UNLABELED

These two changes will make NetLabel behave like labeled IPsec where there is
an access check for both labeled and unlabeled packets as well as providing us
with the ability to restrict domains to receiving only labeled packets when
NetLabel is in use.  The changes to the policy would be straight forward with
the following necessary to receive labeled traffic (assuming SECINITSID_NETMSG
is defined to use "netlabel_t"):

 allow mydomain_t netlabel_t:{ tcp_socket udp_socket rawip_socket } recvfrom;

The policy for unlabeled traffic would be:

 allow mydomain_t unlabeled_t:{ tcp_socket udp_socket rawip_socket } recvfrom;

NOTE: The patch below is backed against a current-ish snapshot of the net-2.6
git tree, there are patched pending that would require this to be rebased.
Also, this really, truly is a RFC patch, I've only compile-tested these
changes.  Please feel free to comment on them but don't try to apply them and
expect everything to work ;)

---
 security/selinux/hooks.c            |    8 +++-----
 security/selinux/include/security.h |    2 +-
 security/selinux/ss/services.c      |   11 +++++------
 3 files changed, 9 insertions(+), 12 deletions(-)

Index: net-2.6_netmsg/security/selinux/hooks.c
===================================================================
--- net-2.6_netmsg.orig/security/selinux/hooks.c
+++ net-2.6_netmsg/security/selinux/hooks.c
@@ -3664,9 +3664,7 @@ static int selinux_socket_getpeersec_dgr
 	if (sock && sock->sk->sk_family == PF_UNIX)
 		selinux_get_inode_sid(SOCK_INODE(sock), &peer_secid);
 	else if (skb)
-		security_skb_extlbl_sid(skb,
-					SECINITSID_UNLABELED,
-					&peer_secid);
+		security_skb_extlbl_sid(skb, &peer_secid);
 
 	if (peer_secid == SECSID_NULL)
 		err = -EINVAL;
@@ -3727,7 +3725,7 @@ static int selinux_inet_conn_request(str
 	u32 newsid;
 	u32 peersid;
 
-	security_skb_extlbl_sid(skb, SECINITSID_UNLABELED, &peersid);
+	security_skb_extlbl_sid(skb, &peersid);
 	if (peersid == SECSID_NULL) {
 		req->secid = sksec->sid;
 		req->peer_secid = SECSID_NULL;
@@ -3765,7 +3763,7 @@ static void selinux_inet_conn_establishe
 {
 	struct sk_security_struct *sksec = sk->sk_security;
 
-	security_skb_extlbl_sid(skb, SECINITSID_UNLABELED, &sksec->peer_sid);
+	security_skb_extlbl_sid(skb, &sksec->peer_sid);
 }
 
 static void selinux_req_classify_flow(const struct request_sock *req,
Index: net-2.6_netmsg/security/selinux/include/security.h
===================================================================
--- net-2.6_netmsg.orig/security/selinux/include/security.h
+++ net-2.6_netmsg/security/selinux/include/security.h
@@ -82,7 +82,7 @@ int security_netif_sid(char *name, u32 *
 int security_node_sid(u16 domain, void *addr, u32 addrlen,
 	u32 *out_sid);
 
-void security_skb_extlbl_sid(struct sk_buff *skb, u32 base_sid, u32 *sid);
+void security_skb_extlbl_sid(struct sk_buff *skb, u32 *sid);
 
 int security_validate_transition(u32 oldsid, u32 newsid, u32 tasksid,
                                  u16 tclass);
Index: net-2.6_netmsg/security/selinux/ss/services.c
===================================================================
--- net-2.6_netmsg.orig/security/selinux/ss/services.c
+++ net-2.6_netmsg/security/selinux/ss/services.c
@@ -2201,7 +2201,6 @@ void selinux_audit_set_callback(int (*ca
 /**
  * security_skb_extlbl_sid - Determine the external label of a packet
  * @skb: the packet
- * @base_sid: the SELinux SID to use as a context for MLS only external labels
  * @sid: the packet's SID
  *
  * Description:
@@ -2209,7 +2208,7 @@ void selinux_audit_set_callback(int (*ca
  * the external SID for the packet.
  *
  */
-void security_skb_extlbl_sid(struct sk_buff *skb, u32 base_sid, u32 *sid)
+void security_skb_extlbl_sid(struct sk_buff *skb, u32 *sid)
 {
 	u32 xfrm_sid;
 	u32 nlbl_sid;
@@ -2217,7 +2216,7 @@ void security_skb_extlbl_sid(struct sk_b
 	selinux_skb_xfrm_sid(skb, &xfrm_sid);
 	if (selinux_netlbl_skbuff_getsid(skb,
 					 (xfrm_sid == SECSID_NULL ?
-					  base_sid : xfrm_sid),
+					  SECINITSID_NETMSG : xfrm_sid),
 					 &nlbl_sid) != 0)
 		nlbl_sid = SECSID_NULL;
 
@@ -2623,7 +2622,7 @@ void selinux_netlbl_sock_graft(struct so
 	    secattr.flags != NETLBL_SECATTR_NONE &&
 	    selinux_netlbl_secattr_to_sid(NULL,
 					  &secattr,
-					  SECINITSID_UNLABELED,
+					  SECINITSID_NETMSG,
 					  &nlbl_peer_sid) == 0)
 		sksec->peer_sid = nlbl_peer_sid;
 	netlbl_secattr_destroy(&secattr);
@@ -2696,13 +2695,13 @@ int selinux_netlbl_sock_rcv_skb(struct s
 	u32 recv_perm;
 
 	rc = selinux_netlbl_skbuff_getsid(skb,
-					  SECINITSID_UNLABELED,
+					  SECINITSID_NETMSG,
 					  &netlbl_sid);
 	if (rc != 0)
 		return rc;
 
 	if (netlbl_sid == SECSID_NULL)
-		return 0;
+		netlbl_sid = SECINITSID_UNLABELED;
 
 	switch (sksec->sclass) {
 	case SECCLASS_UDP_SOCKET:

--
paul moore
linux security @ hp


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
