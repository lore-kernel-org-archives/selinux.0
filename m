Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m07Hv21u030777
	for <selinux@tycho.nsa.gov>; Mon, 7 Jan 2008 12:57:02 -0500
Received: from g5t0007.atlanta.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m07Huwfn028431
	for <selinux@tycho.nsa.gov>; Mon, 7 Jan 2008 17:56:59 GMT
Received: from g5t0007.atlanta.hp.com (localhost.localdomain [127.0.0.1])
	by receive-from-antispam-filter (Postfix) with SMTP id B5E27146CB
	for <selinux@tycho.nsa.gov>; Mon,  7 Jan 2008 17:56:58 +0000 (UTC)
Received: from smtp1.fc.hp.com (smtp.cnd.hp.com [15.15.136.127])
	by g5t0007.atlanta.hp.com (Postfix) with ESMTP id 9A16A14693
	for <selinux@tycho.nsa.gov>; Mon,  7 Jan 2008 17:56:58 +0000 (UTC)
From: Paul Moore <paul.moore@hp.com>
Subject: [RFC PATCH v11 19/19] SELinux: Add warning messages on network denial
	due to error
To: selinux@tycho.nsa.gov
Date: Mon, 07 Jan 2008 12:56:42 -0500
Message-ID: <20080107175642.13733.45719.stgit@flek.americas.hpqcorp.net>
In-Reply-To: <20080107174952.13733.68074.stgit@flek.americas.hpqcorp.net>
References: <20080107174952.13733.68074.stgit@flek.americas.hpqcorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Currently network traffic can be sliently dropped due to non-avc errors which
can lead to much confusion when trying to debug the problem.  This patch adds
warning messages so that when these events occur there is a user visible
notification.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---

 security/selinux/hooks.c   |   29 ++++++++++++++++++++++++-----
 security/selinux/netif.c   |   13 +++++++++++--
 security/selinux/netnode.c |    6 +++++-
 3 files changed, 40 insertions(+), 8 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 1d7eed7..ece46ce 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3206,6 +3206,11 @@ static int selinux_parse_skb(struct sk_buff *skb, struct avc_audit_data *ad,
 		break;
 	}
 
+	if (unlikely(ret))
+		printk(KERN_WARNING
+		       "SELinux: failure in selinux_parse_skb(),"
+		       " unable to parse packet\n");
+
 	return ret;
 }
 
@@ -3226,6 +3231,7 @@ static int selinux_parse_skb(struct sk_buff *skb, struct avc_audit_data *ad,
  */
 static int selinux_skb_peerlbl_sid(struct sk_buff *skb, u16 family, u32 *sid)
 {
+	int err;
 	u32 xfrm_sid;
 	u32 nlbl_sid;
 	u32 nlbl_type;
@@ -3233,10 +3239,13 @@ static int selinux_skb_peerlbl_sid(struct sk_buff *skb, u16 family, u32 *sid)
 	selinux_skb_xfrm_sid(skb, &xfrm_sid);
 	selinux_netlbl_skbuff_getsid(skb, family, &nlbl_type, &nlbl_sid);
 
-	if (security_net_peersid_resolve(nlbl_sid, nlbl_type,
-					 xfrm_sid,
-					 sid) != 0)
+	err = security_net_peersid_resolve(nlbl_sid, nlbl_type, xfrm_sid, sid);
+	if (unlikely(err)) {
+		printk(KERN_WARNING
+		       "SELinux: failure in selinux_skb_peerlbl_sid(),"
+		       " unable to determine packet's peer label\n");
 		return -EACCES;
+	}
 
 	return 0;
 }
@@ -3688,8 +3697,13 @@ static int selinux_sock_rcv_skb_iptables_compat(struct sock *sk,
 	err = security_port_sid(sk->sk_family, sk->sk_type,
 				sk->sk_protocol, ntohs(ad->u.net.sport),
 				&port_sid);
-	if (err)
+	if (unlikely(err)) {
+		printk(KERN_WARNING
+		       "SELinux: failure in"
+		       " selinux_sock_rcv_skb_iptables_compat(),"
+		       " network port label not found\n");
 		return err;
+	}
 	return avc_has_perm(sk_sid, port_sid, sk_class, recv_perm, ad);
 }
 
@@ -4094,8 +4108,13 @@ static int selinux_ip_postroute_iptables_compat(struct sock *sk,
 	err = security_port_sid(sk->sk_family, sk->sk_type,
 				sk->sk_protocol, ntohs(ad->u.net.dport),
 				&port_sid);
-	if (err)
+	if (unlikely(err)) {
+		printk(KERN_WARNING
+		       "SELinux: failure in"
+		       " selinux_ip_postroute_iptables_compat(),"
+		       " network port label not found\n");
 		return err;
+	}
 	return avc_has_perm(sk_sid, port_sid, sk_class, send_perm, ad);
 }
 
diff --git a/security/selinux/netif.c b/security/selinux/netif.c
index ee49a73..013d311 100644
--- a/security/selinux/netif.c
+++ b/security/selinux/netif.c
@@ -157,8 +157,12 @@ static int sel_netif_sid_slow(int ifindex, u32 *sid)
 	 * currently support containers */
 
 	dev = dev_get_by_index(&init_net, ifindex);
-	if (dev == NULL)
+	if (unlikely(dev == NULL)) {
+		printk(KERN_WARNING
+		       "SELinux: failure in sel_netif_sid_slow(),"
+		       " invalid network interface (%d)\n", ifindex);
 		return -ENOENT;
+	}
 
 	spin_lock_bh(&sel_netif_lock);
 	netif = sel_netif_find(ifindex);
@@ -184,8 +188,13 @@ static int sel_netif_sid_slow(int ifindex, u32 *sid)
 out:
 	spin_unlock_bh(&sel_netif_lock);
 	dev_put(dev);
-	if (ret != 0)
+	if (unlikely(ret)) {
+		printk(KERN_WARNING
+		       "SELinux: failure in sel_netif_sid_slow(),"
+		       " unable to determine network interface label (%d)\n",
+		       ifindex);
 		kfree(new);
+	}
 	return ret;
 }
 
diff --git a/security/selinux/netnode.c b/security/selinux/netnode.c
index 49c5277..f3c526f 100644
--- a/security/selinux/netnode.c
+++ b/security/selinux/netnode.c
@@ -264,8 +264,12 @@ static int sel_netnode_sid_slow(void *addr, u16 family, u32 *sid)
 
 out:
 	spin_unlock_bh(&sel_netnode_lock);
-	if (ret != 0)
+	if (unlikely(ret)) {
+		printk(KERN_WARNING
+		       "SELinux: failure in sel_netnode_sid_slow(),"
+		       " unable to determine network node label\n");
 		kfree(new);
+	}
 	return ret;
 }
 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
