Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5G2pErT029975
	for <selinux@tycho.nsa.gov>; Tue, 15 Jun 2004 22:51:14 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5G2p3RK021132
	for <selinux@tycho.nsa.gov>; Wed, 16 Jun 2004 02:51:05 GMT
Date: Tue, 15 Jun 2004 22:51:09 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
To: Andrew Morton <akpm@osdl.org>
cc: "David S. Miller" <davem@redhat.com>, Stephen Smalley <sds@epoch.ncsc.mil>,
   Chris Wright <chrisw@osdl.org>, <linux-kernel@vger.kernel.org>,
   <selinux@tycho.nsa.gov>
Subject: [SELINUX][PATCH 2/4] Fine-grained Netlink support - move
 security_netlink_send() hook.
In-Reply-To: <Xine.LNX.4.44.0406152226150.30562@thoron.boston.redhat.com>
Message-ID: <Xine.LNX.4.44.0406152228190.30562-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch moves the security_netlink_send() LSM hook after the user copy,
so that LSM modules can safely examine skb payload content.  For SELinux,
we need to look at the Netlink message type.

Please apply.

Signed-off-by: James Morris <jmorris@redhat.com>

 net/netlink/af_netlink.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff -purN -X dontdiff linux-2.6.7-rc3.p/net/netlink/af_netlink.c linux-2.6.7-rc3.w/net/netlink/af_netlink.c
--- linux-2.6.7-rc3.p/net/netlink/af_netlink.c	2004-06-07 18:54:14.000000000 -0400
+++ linux-2.6.7-rc3.w/net/netlink/af_netlink.c	2004-06-09 10:44:25.682210736 -0400
@@ -728,14 +728,14 @@ static int netlink_sendmsg(struct kiocb 
 	   to corresponding kernel module.   --ANK (980802)
 	 */
 
-	err = security_netlink_send(skb);
-	if (err) {
+	err = -EFAULT;
+	if (memcpy_fromiovec(skb_put(skb,len), msg->msg_iov, len)) {
 		kfree_skb(skb);
 		goto out;
 	}
 
-	err = -EFAULT;
-	if (memcpy_fromiovec(skb_put(skb,len), msg->msg_iov, len)) {
+	err = security_netlink_send(skb);
+	if (err) {
 		kfree_skb(skb);
 		goto out;
 	}





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
