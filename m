Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id rB3GYO4Y017776
	for <selinux@tycho.nsa.gov>; Tue, 3 Dec 2013 11:34:26 -0500
Subject: [PATCH 1/2] selinux: handle TCP SYN-ACK packets correctly in
 selinux_ip_output()
To: selinux@tycho.nsa.gov
From: Paul Moore <pmoore@redhat.com>
Cc: Janak.Desai@gtri.gatech.edu
Date: Tue, 03 Dec 2013 11:34:20 -0500
Message-ID: <20131203163420.4743.86913.stgit@localhost>
In-Reply-To: <20131203163012.4743.26970.stgit@localhost>
References: <20131203163012.4743.26970.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

In selinux_ip_output() we always label packets based on the parent
socket.  While this approach works in almost all cases, it doesn't
work in the case of TCP SYN-ACK packets when the correct label is not
the label of the parent socket, but rather the label of the larval
socket represented by the request_sock struct.

Unfortunately, since the request_sock isn't queued on the parent
socket until *after* the SYN-ACK packet is sent, we can't lookup the
request_sock to determine the correct label for the packet; at this
point in time the best we can do is simply pass/NF_ACCEPT the packet.
It must be said that simply passing the packet without any explicit
labeling action, while far from ideal, is not terrible as the SYN-ACK
packet will inherit any IP option based labeling from the initial
connection request so the label *should* be correct and all our
access controls remain in place so we shouldn't have to worry about
information leaks.

Reported-by: Janak Desai <Janak.Desai@gtri.gatech.edu>
Tested-by: Janak Desai <Janak.Desai@gtri.gatech.edu>
Signed-off-by: Paul Moore <pmoore@redhat.com>
---
 security/selinux/hooks.c |   25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 777ee98..877bab7 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -53,6 +53,7 @@
 #include <net/ip.h>		/* for local_port_range[] */
 #include <net/sock.h>
 #include <net/tcp.h>		/* struct or_callable used in sock_rcv_skb */
+#include <net/inet_connection_sock.h>
 #include <net/net_namespace.h>
 #include <net/netlabel.h>
 #include <linux/uaccess.h>
@@ -4731,6 +4732,7 @@ static unsigned int selinux_ipv6_forward(unsigned int hooknum,
 static unsigned int selinux_ip_output(struct sk_buff *skb,
 				      u16 family)
 {
+	struct sock *sk;
 	u32 sid;
 
 	if (!netlbl_enabled())
@@ -4739,8 +4741,27 @@ static unsigned int selinux_ip_output(struct sk_buff *skb,
 	/* we do this in the LOCAL_OUT path and not the POST_ROUTING path
 	 * because we want to make sure we apply the necessary labeling
 	 * before IPsec is applied so we can leverage AH protection */
-	if (skb->sk) {
-		struct sk_security_struct *sksec = skb->sk->sk_security;
+	sk = skb->sk;
+	if (sk) {
+		struct sk_security_struct *sksec;
+
+		if (sk->sk_state == TCP_LISTEN)
+			/* if the socket is the listening state then this
+			 * packet is a SYN-ACK packet which means it needs to
+			 * be labeled based on the connection/request_sock and
+			 * not the parent socket.  unfortunately, we can't
+			 * lookup the request_sock yet as it isn't queued on
+			 * the parent socket until after the SYN-ACK is sent.
+			 * the "solution" is to simply pass the packet as-is
+			 * as any IP option based labeling should be copied
+			 * from the initial connection request (in the IP
+			 * layer).  it is far from ideal, but until we get a
+			 * security label in the packet itself this is the
+			 * best we can do. */
+			return NF_ACCEPT;
+
+		/* standard practice, label using the parent socket */
+		sksec = sk->sk_security;
 		sid = sksec->sid;
 	} else
 		sid = SECINITSID_KERNEL;


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
