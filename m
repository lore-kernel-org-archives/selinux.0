Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o35J1WuM023809
	for <selinux@tycho.nsa.gov>; Mon, 5 Apr 2010 15:01:32 -0400
Received: from g6t0184.atlanta.hp.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o35J2KYj029242
	for <selinux@tycho.nsa.gov>; Mon, 5 Apr 2010 19:02:20 GMT
Received: from g5t0030.atlanta.hp.com (g5t0030.atlanta.hp.com [16.228.8.142])
	by g6t0184.atlanta.hp.com (Postfix) with ESMTP id A0649C301
	for <selinux@tycho.nsa.gov>; Mon,  5 Apr 2010 19:01:31 +0000 (UTC)
Subject: [PATCH] selinux: UNIX domain socket fixes
To: selinux@tycho.nsa.gov
From: Paul Moore <paul.moore@hp.com>
Date: Mon, 05 Apr 2010 15:01:24 -0400
Message-ID: <20100405190124.6015.72502.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Correct a problem where we weren't setting the peer label correctly on
connected UNIX domain sockets and do some other general fixup while we
are messing with the code.

Signed-off-by: Paul Moore <paul.moore@hp.com>

---

This patch has now been tested on 2.6.34-rc3 without any visible problems.
---
 security/selinux/hooks.c |   45 +++++++++++++++++----------------------------
 1 files changed, 17 insertions(+), 28 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 5feecb4..326e014 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4002,56 +4002,45 @@ static int selinux_socket_unix_stream_connect(struct socket *sock,
 					      struct socket *other,
 					      struct sock *newsk)
 {
-	struct sk_security_struct *ssec;
-	struct inode_security_struct *isec;
-	struct inode_security_struct *other_isec;
+	struct sk_security_struct *s_sksec = sock->sk->sk_security;
+	struct sk_security_struct *o_sksec = other->sk->sk_security;
+	struct sk_security_struct *n_sksec = newsk->sk_security;
 	struct common_audit_data ad;
 	int err;
 
-	isec = SOCK_INODE(sock)->i_security;
-	other_isec = SOCK_INODE(other)->i_security;
-
 	COMMON_AUDIT_DATA_INIT(&ad, NET);
 	ad.u.net.sk = other->sk;
 
-	err = avc_has_perm(isec->sid, other_isec->sid,
-			   isec->sclass,
+	err = avc_has_perm(s_sksec->sid, o_sksec->sid, o_sksec->sclass,
 			   UNIX_STREAM_SOCKET__CONNECTTO, &ad);
 	if (err)
 		return err;
 
-	/* connecting socket */
-	ssec = sock->sk->sk_security;
-	ssec->peer_sid = other_isec->sid;
-
 	/* server child socket */
-	ssec = newsk->sk_security;
-	ssec->peer_sid = isec->sid;
-	err = security_sid_mls_copy(other_isec->sid, ssec->peer_sid, &ssec->sid);
+	n_sksec->peer_sid = s_sksec->sid;
+	err = security_sid_mls_copy(o_sksec->sid, s_sksec->peer_sid,
+				    &n_sksec->sid);
+	if (err)
+		return err;
 
-	return err;
+	/* connecting socket */
+	s_sksec->peer_sid = n_sksec->sid;
+
+	return 0;
 }
 
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


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
