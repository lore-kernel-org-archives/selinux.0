Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8LH3fiG019094
	for <selinux@tycho.nsa.gov>; Thu, 21 Sep 2006 13:03:41 -0400
Received: from atlrel7.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8LH3AcD001842
	for <selinux@tycho.nsa.gov>; Thu, 21 Sep 2006 17:03:11 GMT
Message-Id: <20060921170336.334044000@hp.com>
References: <20060921165703.251871000@hp.com>
Date: Thu, 21 Sep 2006 12:57:06 -0400
From: paul.moore@hp.com
To: selinux@tycho.nsa.gov, netdev@vger.kernel.org
Cc: sds@epoch.ncsc.mil, jmorris@redhat.com, tgraf@suug.ch
Subject: [PATCH 3/6] NetLabel: change the SELinux permissions
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Change NetLabel to use the 'recvfrom' socket permission and the
SECINITSID_NETMSG SELinux SID as the NetLabel base SID for incoming packets.
This patch effectively makes the old, and currently unused, SELinux NETMSG
permissions NetLabel permissions.

Signed-of-by: Paul Moore <paul.moore@hp.com>
---
 security/selinux/ss/services.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

Index: net-2.6.19/security/selinux/ss/services.c
===================================================================
--- net-2.6.19.orig/security/selinux/ss/services.c
+++ net-2.6.19/security/selinux/ss/services.c
@@ -2611,7 +2611,7 @@ int selinux_netlbl_sock_rcv_skb(struct s
 	u32 netlbl_sid;
 	u32 recv_perm;
 
-	rc = selinux_netlbl_skbuff_getsid(skb, sksec->sid, &netlbl_sid);
+	rc = selinux_netlbl_skbuff_getsid(skb, SECINITSID_NETMSG, &netlbl_sid);
 	if (rc != 0)
 		return rc;
 
@@ -2620,13 +2620,13 @@ int selinux_netlbl_sock_rcv_skb(struct s
 
 	switch (sksec->sclass) {
 	case SECCLASS_UDP_SOCKET:
-		recv_perm = UDP_SOCKET__RECV_MSG;
+		recv_perm = UDP_SOCKET__RECVFROM;
 		break;
 	case SECCLASS_TCP_SOCKET:
-		recv_perm = TCP_SOCKET__RECV_MSG;
+		recv_perm = TCP_SOCKET__RECVFROM;
 		break;
 	default:
-		recv_perm = RAWIP_SOCKET__RECV_MSG;
+		recv_perm = RAWIP_SOCKET__RECVFROM;
 	}
 
 	rc = avc_has_perm(sksec->sid,

--
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
