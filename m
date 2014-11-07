Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sA7DqdHx023226
 for <selinux@tycho.nsa.gov>; Fri, 7 Nov 2014 08:52:40 -0500
From: Richard Haines <richard_c_haines@btinternet.com>
To: selinux@tycho.nsa.gov, vyasevic@redhat.com, dborkman@redhat.com
Subject: [PATCH] selinux: Support SCTP protocol
Date: Fri,  7 Nov 2014 13:52:09 +0000
Message-Id: <1415368329-2670-1-git-send-email-richard_c_haines@btinternet.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an RFC patch.

I thought I would do this piece of SCTP work that was on the original
to-do list following the of work items listed in:
http://marc.info/?l=selinux&m=124342862804578&w=2

I noticed that there have been discussions regarding supporting other
socket types on the new to-do list and discussions on the email list.

If this patch is a reasonable way to support others such as Bluetooth
let me know and I'll add them for the final patch.

I've tested this on Fedora 20 using kernel kernel-3.16.4-200.fc20.x86_64

Notes:
1) This patch adds some missing dccp checks but mainly adds support for SCTP
   to SELinux. The permissions { read write create getattr bind connect
   listen accept getopt setopt name_bind node_bind name_connect
   bindx_add_addr bindx_rem_addr } have been tested.

   There are patches for libsepol-2.4-rc5 that I'll send out enabling
   new "sctp" and "dccp" keywords for portcon statements:

portcon sctp 19000 system_u:object_r:sctp_port_t:s0
portcon dccp 19001 system_u:object_r:dccp_port_t:s0

   I'll do remaining userspace patches if the kernel patch is accepted as
   some require extensive updates (all those 100+ *.po files).

2) The context returned using getpeercon(3) before setting a peer label with
   netlabelctl is "unlabeled_t" (using the targeted policy) for SCTP and
   DCCP.

   However for SCTP, after running netlabelctl to set a peer context as
   follows:

netlabelctl unlbl add interface:lo address:127.0.0.1 label:unconfined_u:object_r:netlabel_peer_t:s0

   The test program always returned the process context, not the
   peer context as do TCP and DCCP test programs when receiving data.

   After some poking around it appears that SCTP does not call
   inet_conn_request, therefore the peer context is not set for the
   socket (I think this is what is happening). I've therefore worked
   around this by setting the peer context in:
    hooks.c - selinux_socket_sock_rcv_skb for network_peer_controls = 1
    netlabel.c - selinux_netlbl_sock_rcv_skb for network_peer_controls = 0

   I'm not sure it's the right thing to do but does work.

   For Information: SCTP seems to be UDP based which is why it probably does
   not use inet_conn_request. If this is so, then it should be possible to
   obtain the peer context using the 'cmsghdr' struct and setting:

int one = 1;
setsockopt(fd, SOL_IP, IP_PASSSEC, &one, sizeof(one));

   However there are currently two obstacles to this:
      a) The code in net/sctp/socket.c - sctp_recvmsg() to process this
         is commented out with a TODO. I did patch this with:
		if (inet_sk(sk)->cmsg_flags)
			ip_cmsg_recv(msg, skb);

         I could then see the peer context via hooks.c 
         selinux_socket_getpeersec_dgram().
     b) The current implementation of the SCTP library will not process
        this, it will require the new rfc6458 sctp_recvv() function that
        has not been implemented yet.

3) In selinux_socket_bind(), the comment regarding SCTP binding to
   multiple addresses has been removed. This is because the address stuct
   passed over for SCTP only has the one address as in any bind. The
   sctp_bindx call does not come through here, it actually calls a
   setsockopt feature to add/remove other addresses from an internal list
   used by SCTP. 

   This adding or deleting of additional addresses with sctp_bindx is
   controlled by adding two permissions to sctp_socket:
       bindx_add_addr and bindx_rem_addr.

4) I found that checks using 'TCP_LISTEN' were equivalent to the SCTP
   and DCCP socket states, for example:

       SCTP_SS_LISTENING and DCCP_LISTEN = TCP_LISTEN

    I've therefore just added a comment indicating this.

5) I did not add any new permissions (such as sctp_sendmsg, sctp_recvmsg)
   to the node or netif classes as most of the current ones are unused.

6) The main test program used was a modified version of the lksctp-tools
   sctp_test.c program that printed the process, peer and socket contexts.
   I'll send the patch in another email.



Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 security/selinux/hooks.c            | 94 ++++++++++++++++++++++++++++++++-----
 security/selinux/include/classmap.h |  3 ++
 security/selinux/netlabel.c         | 15 +++++-
 3 files changed, 99 insertions(+), 13 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 83d06db..700abb8 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -66,6 +66,8 @@
 #include <linux/tcp.h>
 #include <linux/udp.h>
 #include <linux/dccp.h>
+#include <linux/sctp.h>
+#include <uapi/linux/sctp.h>	/* For bindx setsocket option checks */
 #include <linux/quota.h>
 #include <linux/un.h>		/* for Unix socket types */
 #include <net/af_unix.h>	/* for Unix socket types */
@@ -1174,8 +1176,11 @@ static inline u16 socket_type_to_security_class(int family, int type, int protoc
 	case PF_INET6:
 		switch (type) {
 		case SOCK_STREAM:
+		case SOCK_SEQPACKET:
 			if (default_protocol_stream(protocol))
 				return SECCLASS_TCP_SOCKET;
+			else if (protocol == IPPROTO_SCTP)
+				return SECCLASS_SCTP_SOCKET;
 			else
 				return SECCLASS_RAWIP_SOCKET;
 		case SOCK_DGRAM:
@@ -3715,6 +3720,22 @@ static int selinux_parse_skb_ipv4(struct sk_buff *skb,
 		break;
 	}
 
+	case IPPROTO_SCTP: {
+		struct sctphdr _sctph, *sh;
+
+		if (ntohs(ih->frag_off) & IP_OFFSET)
+			break;
+
+		offset += ihlen;
+		sh = skb_header_pointer(skb, offset, sizeof(_sctph), &_sctph);
+		if (sh == NULL)
+			break;
+
+		ad->u.net->sport = sh->source;
+		ad->u.net->dport = sh->dest;
+		break;
+	}
+
 	default:
 		break;
 	}
@@ -3788,6 +3809,18 @@ static int selinux_parse_skb_ipv6(struct sk_buff *skb,
 		break;
 	}
 
+	case IPPROTO_SCTP: {
+		struct sctphdr _sctph, *sh;
+
+		sh = skb_header_pointer(skb, offset, sizeof(_sctph), &_sctph);
+		if (sh == NULL)
+			break;
+
+		ad->u.net->sport = sh->source;
+		ad->u.net->dport = sh->dest;
+		break;
+	}
+
 	/* includes fragments */
 	default:
 		break;
@@ -3848,7 +3881,7 @@ okay:
  * Description:
  * Check the various different forms of network peer labeling and determine
  * the peer label/SID for the packet; most of the magic actually occurs in
- * the security server function security_net_peersid_cmp().  The function
+ * the security server function security_net_peersid_resolve().  The function
  * returns zero if the value in @sid is valid (although it may be SECSID_NULL)
  * or -EACCES if @sid is invalid due to inconsistencies with the different
  * peer labels.
@@ -3997,11 +4030,7 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
 	if (err)
 		goto out;
 
-	/*
-	 * If PF_INET or PF_INET6, check name_bind permission for the port.
-	 * Multiple address binding for SCTP is not supported yet: we just
-	 * check the first address now.
-	 */
+	/* If PF_INET or PF_INET6, check name_bind permission for the port. */
 	family = sk->sk_family;
 	if (family == PF_INET || family == PF_INET6) {
 		char *addrp;
@@ -4058,6 +4087,10 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
 			node_perm = DCCP_SOCKET__NODE_BIND;
 			break;
 
+		case SECCLASS_SCTP_SOCKET:
+			node_perm = SCTP_SOCKET__NODE_BIND;
+			break;
+
 		default:
 			node_perm = RAWIP_SOCKET__NODE_BIND;
 			break;
@@ -4097,10 +4130,12 @@ static int selinux_socket_connect(struct socket *sock, struct sockaddr *address,
 		return err;
 
 	/*
-	 * If a TCP or DCCP socket, check name_connect permission for the port.
+	 * If a TCP, DCCP or SCTP socket, check name_connect permission
+	 * for the port.
 	 */
 	if (sksec->sclass == SECCLASS_TCP_SOCKET ||
-	    sksec->sclass == SECCLASS_DCCP_SOCKET) {
+	    sksec->sclass == SECCLASS_DCCP_SOCKET ||
+	    sksec->sclass == SECCLASS_SCTP_SOCKET) {
 		struct common_audit_data ad;
 		struct lsm_network_audit net = {0,};
 		struct sockaddr_in *addr4 = NULL;
@@ -4124,8 +4159,12 @@ static int selinux_socket_connect(struct socket *sock, struct sockaddr *address,
 		if (err)
 			goto out;
 
-		perm = (sksec->sclass == SECCLASS_TCP_SOCKET) ?
-		       TCP_SOCKET__NAME_CONNECT : DCCP_SOCKET__NAME_CONNECT;
+		if (sksec->sclass == SECCLASS_TCP_SOCKET)
+			perm = TCP_SOCKET__NAME_CONNECT;
+		else if (sksec->sclass == SECCLASS_DCCP_SOCKET)
+			perm = DCCP_SOCKET__NAME_CONNECT;
+		else if (sksec->sclass == SECCLASS_SCTP_SOCKET)
+			perm = SCTP_SOCKET__NAME_CONNECT;
 
 		ad.type = LSM_AUDIT_DATA_NET;
 		ad.u.net = &net;
@@ -4197,6 +4236,22 @@ static int selinux_socket_setsockopt(struct socket *sock, int level, int optname
 	if (err)
 		return err;
 
+	if (level == SOL_SCTP) {
+		switch (optname) {
+		case SCTP_SOCKOPT_BINDX_ADD:
+		case SCTP_SOCKOPT_BINDX_REM:
+			err = sock_has_perm(current, sock->sk,
+			    (optname == SCTP_SOCKOPT_BINDX_ADD ?
+			    SCTP_SOCKET__BINDX_ADD_ADDR :
+			    SCTP_SOCKET__BINDX_REM_ADDR));
+			if (err)
+				return err;
+			break;
+
+		default:
+			break;
+		}
+	}
 	return selinux_netlbl_socket_setsockopt(sock, level, optname);
 }
 
@@ -4374,6 +4429,13 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 			selinux_netlbl_err(skb, err, 0);
 			return err;
 		}
+		/* The peer label has been validated. If SCTP class then
+		 * update sksec->peer_sid with the new peer_sid so it can be
+		 * retrieved by getpeercon(3). This is required as the SCTP
+		 * code is basically UDP. */
+		if (sksec->sclass == SECCLASS_SCTP_SOCKET &&
+		    sksec->peer_sid != peer_sid)
+			sksec->peer_sid = peer_sid;
 	}
 
 	if (secmark_active) {
@@ -4396,7 +4458,9 @@ static int selinux_socket_getpeersec_stream(struct socket *sock, char __user *op
 	u32 peer_sid = SECSID_NULL;
 
 	if (sksec->sclass == SECCLASS_UNIX_STREAM_SOCKET ||
-	    sksec->sclass == SECCLASS_TCP_SOCKET)
+	    sksec->sclass == SECCLASS_TCP_SOCKET ||
+	    sksec->sclass == SECCLASS_DCCP_SOCKET ||
+	    sksec->sclass == SECCLASS_SCTP_SOCKET)
 		peer_sid = sksec->peer_sid;
 	if (peer_sid == SECSID_NULL)
 		return -ENOPROTOOPT;
@@ -4794,6 +4858,8 @@ static unsigned int selinux_ip_output(struct sk_buff *skb,
 	if (sk) {
 		struct sk_security_struct *sksec;
 
+		/* Note that TCP_LISTEN equates to SCTP_SS_LISTENING
+		 * and DCCP_LISTEN socket states */
 		if (sk->sk_state == TCP_LISTEN)
 			/* if the socket is the listening state then this
 			 * packet is a SYN-ACK packet which means it needs to
@@ -4899,7 +4965,9 @@ static unsigned int selinux_ip_postroute(struct sk_buff *skb, int ifindex,
 	 *       TCP listening state we cannot wait until the XFRM processing
 	 *       is done as we will miss out on the SA label if we do;
 	 *       unfortunately, this means more work, but it is only once per
-	 *       connection. */
+	 *       connection.
+	 * NOTE: that TCP_LISTEN equates to SCTP_SS_LISTENING and DCCP_LISTEN
+	 * socket states */
 	if (skb_dst(skb) != NULL && skb_dst(skb)->xfrm != NULL &&
 	    !(sk != NULL && sk->sk_state == TCP_LISTEN))
 		return NF_ACCEPT;
@@ -4918,6 +4986,8 @@ static unsigned int selinux_ip_postroute(struct sk_buff *skb, int ifindex,
 			secmark_perm = PACKET__SEND;
 			peer_sid = SECINITSID_KERNEL;
 		}
+	/* Note that TCP_LISTEN equates to SCTP_SS_LISTENING and DCCP_LISTEN
+	 * socket states */
 	} else if (sk->sk_state == TCP_LISTEN) {
 		/* Locally generated packet but the associated socket is in the
 		 * listening state which means this is a SYN-ACK packet.  In
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index be491a7..eaf3945 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -151,5 +151,8 @@ struct security_class_mapping secclass_map[] = {
 	{ "kernel_service", { "use_as_override", "create_files_as", NULL } },
 	{ "tun_socket",
 	  { COMMON_SOCK_PERMS, "attach_queue", NULL } },
+	{ "sctp_socket",
+	  { COMMON_SOCK_PERMS, "node_bind", "name_connect",
+	    "bindx_add_addr", "bindx_rem_addr", NULL } },
 	{ NULL }
   };
diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
index 0364120..55c7190 100644
--- a/security/selinux/netlabel.c
+++ b/security/selinux/netlabel.c
@@ -396,13 +396,26 @@ int selinux_netlbl_sock_rcv_skb(struct sk_security_struct *sksec,
 	case SECCLASS_TCP_SOCKET:
 		perm = TCP_SOCKET__RECVFROM;
 		break;
+	case SECCLASS_DCCP_SOCKET:
+		perm = DCCP_SOCKET__RECVFROM;
+		break;
+	case SECCLASS_SCTP_SOCKET:
+		perm = SCTP_SOCKET__RECVFROM;
+		break;
 	default:
 		perm = RAWIP_SOCKET__RECVFROM;
 	}
 
 	rc = avc_has_perm(sksec->sid, nlbl_sid, sksec->sclass, perm, ad);
-	if (rc == 0)
+	if (rc == 0) {
+		/* The peer label has been validated in compat mode.
+		 * If SCTP class then update sksec->peer_sid with the
+		 * nlbl_sid so it can be retrieved by getpeercon(3). */
+		if (sksec->sclass == SECCLASS_SCTP_SOCKET &&
+		    sksec->peer_sid != nlbl_sid)
+			sksec->peer_sid = nlbl_sid;
 		return 0;
+	}
 
 	if (nlbl_sid != SECINITSID_UNLABELED)
 		netlbl_skbuff_err(skb, rc, 0);
-- 
1.9.3
