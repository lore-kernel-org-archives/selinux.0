Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o4TLroIK025249
	for <selinux@tycho.nsa.gov>; Sat, 29 May 2010 17:53:50 -0400
Received: from g1t0027.austin.hp.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o4TLqllY001145
	for <selinux@tycho.nsa.gov>; Sat, 29 May 2010 21:52:47 GMT
Received: from g1t0039.austin.hp.com (g1t0039.austin.hp.com [16.236.32.45])
	by g1t0027.austin.hp.com (Postfix) with ESMTP id 424F1380F8
	for <selinux@tycho.nsa.gov>; Sat, 29 May 2010 21:53:32 +0000 (UTC)
Subject: [PATCH 2/6] selinux: Set the peer label correctly on connected UNIX
	domain sockets
To: selinux@tycho.nsa.gov
From: Paul Moore <paul.moore@hp.com>
Date: Sat, 29 May 2010 17:53:30 -0400
Message-ID: <20100529215330.4042.97263.stgit@flek.lan>
In-Reply-To: <20100529214628.4042.88276.stgit@flek.lan>
References: <20100529214628.4042.88276.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Correct a problem where we weren't setting the peer label correctly on
the client end of a pair of connected UNIX sockets.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---
 security/selinux/hooks.c |   30 ++++++++++++++----------------
 1 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index f29f376..ead0984 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4021,34 +4021,32 @@ static int selinux_socket_unix_stream_connect(struct socket *sock,
 					      struct socket *other,
 					      struct sock *newsk)
 {
-	struct sk_security_struct *sksec;
-	struct inode_security_struct *isec;
-	struct inode_security_struct *other_isec;
+	struct sk_security_struct *sksec_sock = sock->sk->sk_security;
+	struct sk_security_struct *sksec_other = other->sk->sk_security;
+	struct sk_security_struct *sksec_new = newsk->sk_security;
 	struct common_audit_data ad;
 	int err;
 
-	isec = SOCK_INODE(sock)->i_security;
-	other_isec = SOCK_INODE(other)->i_security;
-
 	COMMON_AUDIT_DATA_INIT(&ad, NET);
 	ad.u.net.sk = other->sk;
 
-	err = avc_has_perm(isec->sid, other_isec->sid,
-			   isec->sclass,
+	err = avc_has_perm(sksec_sock->sid, sksec_other->sid,
+			   sksec_other->sclass,
 			   UNIX_STREAM_SOCKET__CONNECTTO, &ad);
 	if (err)
 		return err;
 
-	/* connecting socket */
-	sksec = sock->sk->sk_security;
-	sksec->peer_sid = other_isec->sid;
-
 	/* server child socket */
-	sksec = newsk->sk_security;
-	sksec->peer_sid = isec->sid;
-	err = security_sid_mls_copy(other_isec->sid, sksec->peer_sid, &sksec->sid);
+	sksec_new->peer_sid = sksec_sock->sid;
+	err = security_sid_mls_copy(sksec_other->sid, sksec_sock->sid,
+				    &sksec_new->sid);
+	if (err)
+		return err;
 
-	return err;
+	/* connecting socket */
+	sksec_sock->peer_sid = sksec_new->sid;
+
+	return 0;
 }
 
 static int selinux_socket_unix_may_send(struct socket *sock,


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
