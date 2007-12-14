Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBELsu4n028208
	for <selinux@tycho.nsa.gov>; Fri, 14 Dec 2007 16:54:56 -0500
Received: from QMTA05.westchester.pa.mail.comcast.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id lBELsrj8019566
	for <selinux@tycho.nsa.gov>; Fri, 14 Dec 2007 21:54:54 GMT
From: Paul Moore <paul.moore@hp.com>
Subject: [RFC PATCH v8 09/18] SELinux: Only store the network interface's
	ifindex
To: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Cc: vyekkirala@TrustedCS.com, chanson@TrustedCS.com
Date: Fri, 14 Dec 2007 16:50:41 -0500
Message-ID: <20071214215041.10069.63711.stgit@flek.lan>
In-Reply-To: <20071214213548.10069.59135.stgit@flek.lan>
References: <20071214213548.10069.59135.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Instead of storing the packet's network interface name store the ifindex.  This
allows us to defer the need to lookup the net_device structure until the audit
record is generated meaning that in the majority of cases we never need to
bother with this at all.
---

 security/selinux/avc.c         |   15 ++++++++++++---
 security/selinux/hooks.c       |    4 ++--
 security/selinux/include/avc.h |    7 +++++--
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 81b3dff..8ecfab9 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -661,9 +661,18 @@ void avc_audit(u32 ssid, u32 tsid,
 						    "daddr", "dest");
 				break;
 			}
-			if (a->u.net.netif)
-				audit_log_format(ab, " netif=%s",
-					a->u.net.netif);
+			if (a->u.net.netif >= 0) {
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
index 2ca8dfb..e429a8c 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3691,7 +3691,7 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 		family = PF_INET;
 
 	AVC_AUDIT_DATA_INIT(&ad, NET);
-	ad.u.net.netif = skb->dev ? skb->dev->name : "[unknown]";
+	ad.u.net.netif = skb->iif;
 	ad.u.net.family = family;
 
 	err = selinux_parse_skb(skb, &ad, &addrp, &len, 1, NULL);
@@ -4023,7 +4023,7 @@ static unsigned int selinux_ip_postroute_last(unsigned int hooknum,
 	sksec = sk->sk_security;
 
 	AVC_AUDIT_DATA_INIT(&ad, NET);
-	ad.u.net.netif = dev->name;
+	ad.u.net.netif = dev->ifindex;
 	ad.u.net.family = family;
 
 	err = selinux_parse_skb(skb, &ad, &addrp, &len, 0, &proto);
diff --git a/security/selinux/include/avc.h b/security/selinux/include/avc.h
index 553607a..5185152 100644
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
@@ -77,7 +77,10 @@ struct avc_audit_data {
 
 /* Initialize an AVC audit data structure. */
 #define AVC_AUDIT_DATA_INIT(_d,_t) \
-        { memset((_d), 0, sizeof(struct avc_audit_data)); (_d)->type = AVC_AUDIT_DATA_##_t; }
+        { memset((_d), 0, sizeof(struct avc_audit_data)); \
+	  (_d)->type = AVC_AUDIT_DATA_##_t; \
+	  if ((_d)->type == AVC_AUDIT_DATA_NET) \
+		  (_d)->u.net.netif = -1; }
 
 /*
  * AVC statistics


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
