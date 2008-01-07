Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m07HtjNi030184
	for <selinux@tycho.nsa.gov>; Mon, 7 Jan 2008 12:55:45 -0500
Received: from g1t0029.austin.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m07Hthfn028039
	for <selinux@tycho.nsa.gov>; Mon, 7 Jan 2008 17:55:43 GMT
Received: from g1t0029.austin.hp.com (localhost.localdomain [127.0.0.1])
	by receive-from-antispam-filter (Postfix) with SMTP id 4BC563871C
	for <selinux@tycho.nsa.gov>; Mon,  7 Jan 2008 17:55:43 +0000 (UTC)
Received: from smtp2.fc.hp.com (smtp.fc.hp.com [15.11.136.114])
	by g1t0029.austin.hp.com (Postfix) with ESMTP id 3EA1D3871B
	for <selinux@tycho.nsa.gov>; Mon,  7 Jan 2008 17:55:43 +0000 (UTC)
From: Paul Moore <paul.moore@hp.com>
Subject: [RFC PATCH v11 09/19] SELinux: Only store the network interface's
	ifindex
To: selinux@tycho.nsa.gov
Date: Mon, 07 Jan 2008 12:55:39 -0500
Message-ID: <20080107175539.13733.77695.stgit@flek.americas.hpqcorp.net>
In-Reply-To: <20080107174952.13733.68074.stgit@flek.americas.hpqcorp.net>
References: <20080107174952.13733.68074.stgit@flek.americas.hpqcorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Instead of storing the packet's network interface name store the ifindex.  This
allows us to defer the need to lookup the net_device structure until the audit
record is generated meaning that in the majority of cases we never need to
bother with this at all.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---

 security/selinux/avc.c         |   15 ++++++++++++---
 security/selinux/hooks.c       |    4 ++--
 security/selinux/include/avc.h |    2 +-
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 81b3dff..e8529e2 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -661,9 +661,18 @@ void avc_audit(u32 ssid, u32 tsid,
 						    "daddr", "dest");
 				break;
 			}
-			if (a->u.net.netif)
-				audit_log_format(ab, " netif=%s",
-					a->u.net.netif);
+			if (a->u.net.netif > 0) {
+				struct net_device *dev;
+
+				/* NOTE: we always use init's namespace */
+				dev = dev_get_by_index(&init_net,
+						       a->u.net.netif);
+				if (dev) {
+					audit_log_format(ab, " netif=%s",
+							 dev->name);
+					dev_put(dev);
+				}
+			}
 			break;
 		}
 	}
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 8336c93..b451b4c 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3691,7 +3691,7 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 		family = PF_INET;
 
 	AVC_AUDIT_DATA_INIT(&ad, NET);
-	ad.u.net.netif = skb->dev ? skb->dev->name : "[unknown]";
+	ad.u.net.netif = skb->iif;
 	ad.u.net.family = family;
 
 	err = selinux_parse_skb(skb, &ad, &addrp, &len, 1, NULL);
@@ -4022,7 +4022,7 @@ static unsigned int selinux_ip_postroute_last(unsigned int hooknum,
 	sksec = sk->sk_security;
 
 	AVC_AUDIT_DATA_INIT(&ad, NET);
-	ad.u.net.netif = dev->name;
+	ad.u.net.netif = dev->ifindex;
 	ad.u.net.family = family;
 
 	err = selinux_parse_skb(skb, &ad, &addrp, &len, 0, &proto);
diff --git a/security/selinux/include/avc.h b/security/selinux/include/avc.h
index 553607a..80c28fa 100644
--- a/security/selinux/include/avc.h
+++ b/security/selinux/include/avc.h
@@ -51,7 +51,7 @@ struct avc_audit_data {
 			struct inode *inode;
 		} fs;
 		struct {
-			char *netif;
+			int netif;
 			struct sock *sk;
 			u16 family;
 			__be16 dport;


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
