Message-Id: <20060829144445.819396000@hp.com>
References: <20060829144251.452774000@hp.com>
Date: Tue, 29 Aug 2006 10:42:54 -0400
From: paul.moore@hp.com
To: netdev@vger.kernel.org, selinux@tycho.nsa.gov
Cc: jmorris@namei.org, sds@tycho.nsa.gov, akpm@osdl.org,
        Paul Moore <paul.moore@hp.com>
Subject: [PATCH 3/6] NetLabel: comment corrections
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Fix some incorrect comments.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---
 security/selinux/ss/services.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: net-2.6.19/security/selinux/ss/services.c
===================================================================
--- net-2.6.19.orig/security/selinux/ss/services.c
+++ net-2.6.19/security/selinux/ss/services.c
@@ -2617,7 +2617,7 @@ int selinux_netlbl_sock_rcv_skb(struct s
 }
 
 /**
- * selinux_netlbl_socket_peersid - Return the peer SID of a connected socket
+ * selinux_netlbl_socket_getpeersec_stream - Return the connected peer's SID
  * @sock: the socket
  *
  * Description:

--
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
