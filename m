Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o43MBnhK018974
	for <selinux@tycho.nsa.gov>; Mon, 3 May 2010 18:11:49 -0400
Received: from g4t0017.houston.hp.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o43MBCQB021415
	for <selinux@tycho.nsa.gov>; Mon, 3 May 2010 22:11:12 GMT
Received: from g4t0009.houston.hp.com (g4t0009.houston.hp.com [16.234.32.26])
	by g4t0017.houston.hp.com (Postfix) with ESMTP id 471B8380BB
	for <selinux@tycho.nsa.gov>; Mon,  3 May 2010 22:11:48 +0000 (UTC)
Subject: [RFC PATCH v1 5/6] selinux: Convert socket related access controls to
	use socket labels
To: selinux@tycho.nsa.gov
From: Paul Moore <paul.moore@hp.com>
Date: Mon, 03 May 2010 18:11:46 -0400
Message-ID: <20100503221146.8177.84024.stgit@flek.lan>
In-Reply-To: <20100503220455.8177.91177.stgit@flek.lan>
References: <20100503220455.8177.91177.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

At present, the socket related access controls use a mix of inode and
socket labels; while there should be no practical difference (they
_should_ always be the same), it makes the code more confusing.  This
patch attempts to convert all of the socket related access control
points (with the exception of some of the inode/fd based controls) to
use the socket's own label.  In the process, I also converted the
socket_has_perm() function to take a 'sock' argument instead of a
'socket' since that was adding a bit more overhead in some cases.

Signed-off-by: XXX
---
 security/selinux/hooks.c |  121 +++++++++++++++++-----------------------------
 1 files changed, 46 insertions(+), 75 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index ce6c017..4f2c9ec 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3710,26 +3710,19 @@ static u32 socket_sockcreate_sid(const struct task_security_struct *tsec)
 	return tsec->sockcreate_sid ? tsec->sockcreate_sid : tsec->sid;
 }
 
-static int socket_has_perm(struct task_struct *task, struct socket *sock,
-			   u32 perms)
+static int socket_has_perm(struct task_struct *task, struct sock *sk, u32 perms)
 {
-	struct inode_security_struct *isec;
+	struct sk_security_struct *sksec = sk->sk_security;
 	struct common_audit_data ad;
-	u32 sid;
-	int err = 0;
+	u32 tsid = task_sid(task);
 
-	isec = SOCK_INODE(sock)->i_security;
-
-	if (isec->sid == SECINITSID_KERNEL)
-		goto out;
-	sid = task_sid(task);
+	if (sksec->sid == SECINITSID_KERNEL)
+		return 0;
 
 	COMMON_AUDIT_DATA_INIT(&ad, NET);
-	ad.u.net.sk = sock->sk;
-	err = avc_has_perm(sid, isec->sid, isec->sclass, perms, &ad);
+	ad.u.net.sk = sk;
 
-out:
-	return err;
+	return avc_has_perm(tsid, sksec->sid, sksec->sclass, perms, &ad);
 }
 
 static int selinux_socket_create(int family, int type,
@@ -3781,10 +3774,11 @@ static int selinux_socket_post_create(struct socket *sock, int family,
 
 static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, int addrlen)
 {
+	struct sock *sk = sock->sk;
 	u16 family;
 	int err;
 
-	err = socket_has_perm(current, sock, SOCKET__BIND);
+	err = socket_has_perm(current, sk, SOCKET__BIND);
 	if (err)
 		goto out;
 
@@ -3793,19 +3787,16 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
 	 * Multiple address binding for SCTP is not supported yet: we just
 	 * check the first address now.
 	 */
-	family = sock->sk->sk_family;
+	family = sk->sk_family;
 	if (family == PF_INET || family == PF_INET6) {
 		char *addrp;
-		struct inode_security_struct *isec;
+		struct sk_security_struct *sksec = sk->sk_security;
 		struct common_audit_data ad;
 		struct sockaddr_in *addr4 = NULL;
 		struct sockaddr_in6 *addr6 = NULL;
 		unsigned short snum;
-		struct sock *sk = sock->sk;
 		u32 sid, node_perm;
 
-		isec = SOCK_INODE(sock)->i_security;
-
 		if (family == PF_INET) {
 			addr4 = (struct sockaddr_in *)address;
 			snum = ntohs(addr4->sin_port);
@@ -3829,15 +3820,15 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
 				COMMON_AUDIT_DATA_INIT(&ad, NET);
 				ad.u.net.sport = htons(snum);
 				ad.u.net.family = family;
-				err = avc_has_perm(isec->sid, sid,
-						   isec->sclass,
+				err = avc_has_perm(sksec->sid, sid,
+						   sksec->sclass,
 						   SOCKET__NAME_BIND, &ad);
 				if (err)
 					goto out;
 			}
 		}
 
-		switch (isec->sclass) {
+		switch (sksec->sclass) {
 		case SECCLASS_TCP_SOCKET:
 			node_perm = TCP_SOCKET__NODE_BIND;
 			break;
@@ -3868,8 +3859,8 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
 		else
 			ipv6_addr_copy(&ad.u.net.v6info.saddr, &addr6->sin6_addr);
 
-		err = avc_has_perm(isec->sid, sid,
-				   isec->sclass, node_perm, &ad);
+		err = avc_has_perm(sksec->sid, sid,
+				   sksec->sclass, node_perm, &ad);
 		if (err)
 			goto out;
 	}
@@ -3880,19 +3871,18 @@ out:
 static int selinux_socket_connect(struct socket *sock, struct sockaddr *address, int addrlen)
 {
 	struct sock *sk = sock->sk;
-	struct inode_security_struct *isec;
+	struct sk_security_struct *sksec = sk->sk_security;
 	int err;
 
-	err = socket_has_perm(current, sock, SOCKET__CONNECT);
+	err = socket_has_perm(current, sk, SOCKET__CONNECT);
 	if (err)
 		return err;
 
 	/*
 	 * If a TCP or DCCP socket, check name_connect permission for the port.
 	 */
-	isec = SOCK_INODE(sock)->i_security;
-	if (isec->sclass == SECCLASS_TCP_SOCKET ||
-	    isec->sclass == SECCLASS_DCCP_SOCKET) {
+	if (sksec->sclass == SECCLASS_TCP_SOCKET ||
+	    sksec->sclass == SECCLASS_DCCP_SOCKET) {
 		struct common_audit_data ad;
 		struct sockaddr_in *addr4 = NULL;
 		struct sockaddr_in6 *addr6 = NULL;
@@ -3915,13 +3905,13 @@ static int selinux_socket_connect(struct socket *sock, struct sockaddr *address,
 		if (err)
 			goto out;
 
-		perm = (isec->sclass == SECCLASS_TCP_SOCKET) ?
+		perm = (sksec->sclass == SECCLASS_TCP_SOCKET) ?
 		       TCP_SOCKET__NAME_CONNECT : DCCP_SOCKET__NAME_CONNECT;
 
 		COMMON_AUDIT_DATA_INIT(&ad, NET);
 		ad.u.net.dport = htons(snum);
 		ad.u.net.family = sk->sk_family;
-		err = avc_has_perm(isec->sid, sid, isec->sclass, perm, &ad);
+		err = avc_has_perm(sksec->sid, sid, sksec->sclass, perm, &ad);
 		if (err)
 			goto out;
 	}
@@ -3934,7 +3924,7 @@ out:
 
 static int selinux_socket_listen(struct socket *sock, int backlog)
 {
-	return socket_has_perm(current, sock, SOCKET__LISTEN);
+	return socket_has_perm(current, sock->sk, SOCKET__LISTEN);
 }
 
 static int selinux_socket_accept(struct socket *sock, struct socket *newsock)
@@ -3943,7 +3933,7 @@ static int selinux_socket_accept(struct socket *sock, struct socket *newsock)
 	struct inode_security_struct *isec;
 	struct inode_security_struct *newisec;
 
-	err = socket_has_perm(current, sock, SOCKET__ACCEPT);
+	err = socket_has_perm(current, sock->sk, SOCKET__ACCEPT);
 	if (err)
 		return err;
 
@@ -3960,30 +3950,30 @@ static int selinux_socket_accept(struct socket *sock, struct socket *newsock)
 static int selinux_socket_sendmsg(struct socket *sock, struct msghdr *msg,
 				  int size)
 {
-	return socket_has_perm(current, sock, SOCKET__WRITE);
+	return socket_has_perm(current, sock->sk, SOCKET__WRITE);
 }
 
 static int selinux_socket_recvmsg(struct socket *sock, struct msghdr *msg,
 				  int size, int flags)
 {
-	return socket_has_perm(current, sock, SOCKET__READ);
+	return socket_has_perm(current, sock->sk, SOCKET__READ);
 }
 
 static int selinux_socket_getsockname(struct socket *sock)
 {
-	return socket_has_perm(current, sock, SOCKET__GETATTR);
+	return socket_has_perm(current, sock->sk, SOCKET__GETATTR);
 }
 
 static int selinux_socket_getpeername(struct socket *sock)
 {
-	return socket_has_perm(current, sock, SOCKET__GETATTR);
+	return socket_has_perm(current, sock->sk, SOCKET__GETATTR);
 }
 
 static int selinux_socket_setsockopt(struct socket *sock, int level, int optname)
 {
 	int err;
 
-	err = socket_has_perm(current, sock, SOCKET__SETOPT);
+	err = socket_has_perm(current, sock->sk, SOCKET__SETOPT);
 	if (err)
 		return err;
 
@@ -3993,12 +3983,12 @@ static int selinux_socket_setsockopt(struct socket *sock, int level, int optname
 static int selinux_socket_getsockopt(struct socket *sock, int level,
 				     int optname)
 {
-	return socket_has_perm(current, sock, SOCKET__GETOPT);
+	return socket_has_perm(current, sock->sk, SOCKET__GETOPT);
 }
 
 static int selinux_socket_shutdown(struct socket *sock, int how)
 {
-	return socket_has_perm(current, sock, SOCKET__SHUTDOWN);
+	return socket_has_perm(current, sock->sk, SOCKET__SHUTDOWN);
 }
 
 static int selinux_socket_unix_stream_connect(struct socket *sock,
@@ -4034,23 +4024,15 @@ static int selinux_socket_unix_stream_connect(struct socket *sock,
 static int selinux_socket_unix_may_send(struct socket *sock,
 					struct socket *other)
 {
-	struct inode_security_struct *isec;
-	struct inode_security_struct *other_isec;
+	struct sk_security_struct *ssec = sock->sk->sk_security;
+	struct sk_security_struct *osec = other->sk->sk_security;
 	struct common_audit_data ad;
-	int err;
-
-	isec = SOCK_INODE(sock)->i_security;
-	other_isec = SOCK_INODE(other)->i_security;
 
 	COMMON_AUDIT_DATA_INIT(&ad, NET);
 	ad.u.net.sk = other->sk;
 
-	err = avc_has_perm(isec->sid, other_isec->sid,
-			   isec->sclass, SOCKET__SENDTO, &ad);
-	if (err)
-		return err;
-
-	return 0;
+	return avc_has_perm(ssec->sid, osec->sid, osec->sclass, SOCKET__SENDTO,
+			    &ad);
 }
 
 static int selinux_inet_sys_rcv_skb(int ifindex, char *addrp, u16 family,
@@ -4189,26 +4171,18 @@ static int selinux_socket_getpeersec_stream(struct socket *sock, char __user *op
 	int err = 0;
 	char *scontext;
 	u32 scontext_len;
-	struct sk_security_struct *ssec;
-	struct inode_security_struct *isec;
+	struct sk_security_struct *sksec = sock->sk->sk_security;
 	u32 peer_sid = SECSID_NULL;
 
-	isec = SOCK_INODE(sock)->i_security;
-
-	if (isec->sclass == SECCLASS_UNIX_STREAM_SOCKET ||
-	    isec->sclass == SECCLASS_TCP_SOCKET) {
-		ssec = sock->sk->sk_security;
-		peer_sid = ssec->peer_sid;
-	}
-	if (peer_sid == SECSID_NULL) {
-		err = -ENOPROTOOPT;
-		goto out;
-	}
+	if (sksec->sclass == SECCLASS_UNIX_STREAM_SOCKET ||
+	    sksec->sclass == SECCLASS_TCP_SOCKET)
+		peer_sid = sksec->peer_sid;
+	if (peer_sid == SECSID_NULL)
+		return -ENOPROTOOPT;
 
 	err = security_sid_to_context(peer_sid, &scontext, &scontext_len);
-
 	if (err)
-		goto out;
+		return err;
 
 	if (scontext_len > len) {
 		err = -ERANGE;
@@ -4221,9 +4195,7 @@ static int selinux_socket_getpeersec_stream(struct socket *sock, char __user *op
 out_len:
 	if (put_user(scontext_len, optlen))
 		err = -EFAULT;
-
 	kfree(scontext);
-out:
 	return err;
 }
 
@@ -4435,8 +4407,7 @@ static int selinux_nlmsg_perm(struct sock *sk, struct sk_buff *skb)
 	int err = 0;
 	u32 perm;
 	struct nlmsghdr *nlh;
-	struct socket *sock = sk->sk_socket;
-	struct inode_security_struct *isec = SOCK_INODE(sock)->i_security;
+	struct sk_security_struct *sksec = sk->sk_security;
 
 	if (skb->len < NLMSG_SPACE(0)) {
 		err = -EINVAL;
@@ -4444,13 +4415,13 @@ static int selinux_nlmsg_perm(struct sock *sk, struct sk_buff *skb)
 	}
 	nlh = nlmsg_hdr(skb);
 
-	err = selinux_nlmsg_lookup(isec->sclass, nlh->nlmsg_type, &perm);
+	err = selinux_nlmsg_lookup(sksec->sclass, nlh->nlmsg_type, &perm);
 	if (err) {
 		if (err == -EINVAL) {
 			audit_log(current->audit_context, GFP_KERNEL, AUDIT_SELINUX_ERR,
 				  "SELinux:  unrecognized netlink message"
 				  " type=%hu for sclass=%hu\n",
-				  nlh->nlmsg_type, isec->sclass);
+				  nlh->nlmsg_type, sksec->sclass);
 			if (!selinux_enforcing || security_get_allow_unknown())
 				err = 0;
 		}
@@ -4461,7 +4432,7 @@ static int selinux_nlmsg_perm(struct sock *sk, struct sk_buff *skb)
 		goto out;
 	}
 
-	err = socket_has_perm(current, sock, perm);
+	err = socket_has_perm(current, sk, perm);
 out:
 	return err;
 }


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
