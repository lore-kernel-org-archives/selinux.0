Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o43MBVTw018929
	for <selinux@tycho.nsa.gov>; Mon, 3 May 2010 18:11:31 -0400
Received: from g4t0014.houston.hp.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o43MCZbl004906
	for <selinux@tycho.nsa.gov>; Mon, 3 May 2010 22:12:35 GMT
Received: from g4t0009.houston.hp.com (g4t0009.houston.hp.com [16.234.32.26])
	by g4t0014.houston.hp.com (Postfix) with ESMTP id 06D7724020
	for <selinux@tycho.nsa.gov>; Mon,  3 May 2010 22:11:30 +0000 (UTC)
Subject: [RFC PATCH v1 2/6] selinux: Set the peer label correctly on connected
	UNIX domain sockets
To: selinux@tycho.nsa.gov
From: Paul Moore <paul.moore@hp.com>
Date: Mon, 03 May 2010 18:11:28 -0400
Message-ID: <20100503221128.8177.97693.stgit@flek.lan>
In-Reply-To: <20100503220455.8177.91177.stgit@flek.lan>
References: <20100503220455.8177.91177.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Correct a problem where we weren't setting the peer label correctly on
the client end of a pair of connected UNIX sockets.

Signed-off-by: XXX
---
 security/selinux/hooks.c |   28 ++++++++++++----------------
 1 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index f9545c8..09973e2 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4039,34 +4039,30 @@ static int selinux_socket_unix_stream_connect(struct socket *sock,
 					      struct socket *other,
 					      struct sock *newsk)
 {
-	struct sk_security_struct *ssec;
-	struct inode_security_struct *isec;
-	struct inode_security_struct *other_isec;
+	struct sk_security_struct *sksec_s = sock->sk->sk_security;
+	struct sk_security_struct *sksec_o = other->sk->sk_security;
+	struct sk_security_struct *sksec_n = newsk->sk_security;
 	struct common_audit_data ad;
 	int err;
 
-	isec = SOCK_INODE(sock)->i_security;
-	other_isec = SOCK_INODE(other)->i_security;
-
 	COMMON_AUDIT_DATA_INIT(&ad, NET);
 	ad.u.net.sk = other->sk;
 
-	err = avc_has_perm(isec->sid, other_isec->sid,
-			   isec->sclass,
+	err = avc_has_perm(sksec_s->sid, sksec_o->sid, sksec_o->sclass,
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
+	sksec_n->peer_sid = sksec_s->sid;
+	err = security_sid_mls_copy(sksec_o->sid, sksec_s->sid, &sksec_n->sid);
+	if (err)
+		return err;
 
-	return err;
+	/* connecting socket */
+	sksec_s->peer_sid = sksec_n->sid;
+
+	return 0;
 }
 
 static int selinux_socket_unix_may_send(struct socket *sock,


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
