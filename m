Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id AAA05792
	for <selinux@tycho.nsa.gov>; Fri, 24 Aug 2001 00:23:25 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id EAA04995
	for <selinux@tycho.nsa.gov>; Fri, 24 Aug 2001 04:22:09 GMT
Received: from blackbird.intercode.com.au (blackbird.intercode.com.au [203.32.101.10])
	by jazzswing.ncsc.mil  with ESMTP id EAA04991
	for <selinux@tycho.nsa.gov>; Fri, 24 Aug 2001 04:22:06 GMT
Date: Fri, 24 Aug 2001 14:22:14 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: <linux-security-module@wirex.com>
cc: <selinux@tycho.nsa.gov>
Subject: [PATCH] minor fix for ip_queue
Message-ID: <Pine.LNX.4.31.0108241416250.13690-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Below is a patch which removes a spurious bracket in the current LSM code.

- James
-- 
James Morris
<jmorris@intercode.com.au>

--- kernel.orig/net/ipv4/netfilter/ip_queue.c	Wed Aug 22 14:38:52 2001
+++ lsm/net/ipv4/netfilter/ip_queue.c	Fri Aug 24 13:55:04 2001
@@ -516,7 +516,7 @@
 		RCV_SKB_FAIL(-EINVAL);
 	if (type <= IPQM_BASE)
 		return;
-	if (security_ops->netlink_recv(skb)) {
+	if (security_ops->netlink_recv(skb))
 		RCV_SKB_FAIL(-EPERM);
 	if (nlq->peer.pid && !nlq->peer.died
 	    && (nlq->peer.pid != nlh->nlmsg_pid)) {



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
