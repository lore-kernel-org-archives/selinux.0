Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id rB3GYXNY017802
	for <selinux@tycho.nsa.gov>; Tue, 3 Dec 2013 11:34:33 -0500
Subject: [PATCH 2/2] selinux: handle TCP SYN-ACK packets correctly in
 selinux_ip_postroute()
To: selinux@tycho.nsa.gov
From: Paul Moore <pmoore@redhat.com>
Cc: Janak.Desai@gtri.gatech.edu
Date: Tue, 03 Dec 2013 11:34:27 -0500
Message-ID: <20131203163427.4743.11976.stgit@localhost>
In-Reply-To: <20131203163012.4743.26970.stgit@localhost>
References: <20131203163012.4743.26970.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

In selinux_ip_postroute() we perform access checks based on the
packet's security label.  For locally generated traffic we get the
packet's security label from the associated socket; this works in all
cases except for TCP SYN-ACK packets.  In the case of SYN-ACK packet's
the correct security label is stored in the connection's request_sock,
not the server's socket.  Unfortunately, at the point in time when
selinux_ip_postroute() is called we can't query the request_sock
directly, we need to recreate the label using the same logic that
originally labeled the associated request_sock.

See the inline comments for more explanation.

Reported-by: Janak Desai <Janak.Desai@gtri.gatech.edu>
Tested-by: Janak Desai <Janak.Desai@gtri.gatech.edu>
Signed-off-by: Paul Moore <pmoore@redhat.com>
---
 security/selinux/hooks.c |   68 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 53 insertions(+), 15 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 877bab7..cc076a9 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3847,6 +3847,30 @@ static int selinux_skb_peerlbl_sid(struct sk_buff *skb, u16 family, u32 *sid)
 	return 0;
 }
 
+/**
+ * selinux_conn_sid - Determine the child socket label for a connection
+ * @sk_sid: the parent socket's SID
+ * @skb_sid: the packet's SID
+ * @conn_sid: the resulting connection SID
+ *
+ * If @skb_sid is valid then the user:role:type information from @sk_sid is
+ * combined with the MLS information from @skb_sid in order to create
+ * @conn_sid.  If @skb_sid is not valid then then @conn_sid is simply a copy
+ * of @sk_sid.  Returns zero on success, negative values on failure.
+ *
+ */
+static int selinux_conn_sid(u32 sk_sid, u32 skb_sid, u32 *conn_sid)
+{
+	int err = 0;
+
+	if (skb_sid != SECSID_NULL)
+		err = security_sid_mls_copy(sk_sid, skb_sid, conn_sid);
+	else
+		*conn_sid = sk_sid;
+
+	return err;
+}
+
 /* socket security operations */
 
 static int socket_sockcreate_sid(const struct task_security_struct *tsec,
@@ -4453,7 +4477,7 @@ static int selinux_inet_conn_request(struct sock *sk, struct sk_buff *skb,
 	struct sk_security_struct *sksec = sk->sk_security;
 	int err;
 	u16 family = sk->sk_family;
-	u32 newsid;
+	u32 connsid;
 	u32 peersid;
 
 	/* handle mapped IPv4 packets arriving via IPv6 sockets */
@@ -4463,16 +4487,11 @@ static int selinux_inet_conn_request(struct sock *sk, struct sk_buff *skb,
 	err = selinux_skb_peerlbl_sid(skb, family, &peersid);
 	if (err)
 		return err;
-	if (peersid == SECSID_NULL) {
-		req->secid = sksec->sid;
-		req->peer_secid = SECSID_NULL;
-	} else {
-		err = security_sid_mls_copy(sksec->sid, peersid, &newsid);
-		if (err)
-			return err;
-		req->secid = newsid;
-		req->peer_secid = peersid;
-	}
+	err = selinux_conn_sid(sksec->sid, peersid, &connsid);
+	if (err)
+		return err;
+	req->secid = connsid;
+	req->peer_secid = peersid;
 
 	return selinux_netlbl_inet_conn_request(req, family);
 }
@@ -4846,12 +4865,12 @@ static unsigned int selinux_ip_postroute(struct sk_buff *skb, int ifindex,
 	if (!secmark_active && !peerlbl_active)
 		return NF_ACCEPT;
 
-	/* if the packet is being forwarded then get the peer label from the
-	 * packet itself; otherwise check to see if it is from a local
-	 * application or the kernel, if from an application get the peer label
-	 * from the sending socket, otherwise use the kernel's sid */
 	sk = skb->sk;
 	if (sk == NULL) {
+		/* Without an associated socket the packet is either coming
+		 * from the kernel or it is being forwarded; check the packet
+		 * to determine which and if the packet is being forwarded
+		 * query the packet directly to determine the security label. */
 		if (skb->skb_iif) {
 			secmark_perm = PACKET__FORWARD_OUT;
 			if (selinux_skb_peerlbl_sid(skb, family, &peer_sid))
@@ -4860,7 +4879,26 @@ static unsigned int selinux_ip_postroute(struct sk_buff *skb, int ifindex,
 			secmark_perm = PACKET__SEND;
 			peer_sid = SECINITSID_KERNEL;
 		}
+	} else if (sk->sk_state == TCP_LISTEN) {
+		/* Locally generated packet but the associated socket is in the
+		 * listening state which means this is a SYN-ACK packet.  In
+		 * this particular case the correct security label is assigned
+		 * to the connection/request_sock but unfortunately we can't
+		 * query the request_sock as it isn't queued on the parent
+		 * socket until after the SYN-ACK packet is sent; the only
+		 * viable choice is to regenerate the label like we do in
+		 * selinux_inet_conn_request().  See also selinux_ip_output()
+		 * for similar problems. */
+		u32 skb_sid;
+		struct sk_security_struct *sksec = sk->sk_security;
+		if (selinux_skb_peerlbl_sid(skb, family, &skb_sid))
+			return NF_DROP;
+		if (selinux_conn_sid(sksec->sid, skb_sid, &peer_sid))
+			return NF_DROP;
+		secmark_perm = PACKET__SEND;
 	} else {
+		/* Locally generated packet, fetch the security label from the
+		 * associated socket. */
 		struct sk_security_struct *sksec = sk->sk_security;
 		peer_sid = sksec->sid;
 		secmark_perm = PACKET__SEND;


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
