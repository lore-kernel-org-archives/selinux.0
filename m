Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8PI6i8G021626
	for <selinux@tycho.nsa.gov>; Mon, 25 Sep 2006 14:06:44 -0400
Received: from atlrel8.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8PI5fAk023397
	for <selinux@tycho.nsa.gov>; Mon, 25 Sep 2006 18:05:41 GMT
Message-Id: <20060925180640.679073000@hp.com>
References: <20060925180412.715069000@hp.com>
Date: Mon, 25 Sep 2006 14:04:15 -0400
From: paul.moore@hp.com
To: netdev@vger.kernel.org, selinux@tycho.nsa.gov
Cc: tgraf@suug.ch, jmorris@redhat.com, sds@epoch.ncsc.mil
Subject: [PATCH v2 3/8] NetLabel: change the SELinux permissions
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
