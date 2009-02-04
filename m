Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n14LghTE021389
	for <selinux@tycho.nsa.gov>; Wed, 4 Feb 2009 16:42:44 -0500
Received: from g4t0016.houston.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n14LdYmj021095
	for <selinux@tycho.nsa.gov>; Wed, 4 Feb 2009 21:39:34 GMT
Received: from g5t0029.atlanta.hp.com (g5t0029.atlanta.hp.com [16.228.8.141])
	by g4t0016.houston.hp.com (Postfix) with ESMTP id DCA5814275
	for <selinux@tycho.nsa.gov>; Wed,  4 Feb 2009 21:42:41 +0000 (UTC)
From: Paul Moore <paul.moore@hp.com>
Subject: [RFC PATCH v1] selinux: Remove the "compat_net" compatibility code
To: selinux@tycho.nsa.gov
Date: Wed, 04 Feb 2009 16:42:36 -0500
Message-ID: <20090204214236.11992.20432.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The SELinux "compat_net" is marked as deprecated, the time has come to
finally remove it from the kernel.  Further code simplifications are
likely in the future, but this patch was intended to be a simple,
straight-up removal of the compat_net code.

[NOTE: I've lightly tested this on current 2.6.29-rcX kernels without
       problem, I'm posting this to solicit any comments.  I'm also
       going to push this to the lblnet-2.6_next tree so we should see
       this in linux-next in the next day (or two).]
---

 Documentation/feature-removal-schedule.txt |   12 --
 security/selinux/hooks.c                   |  153 +---------------------------
 security/selinux/selinuxfs.c               |   68 ------------
 3 files changed, 7 insertions(+), 226 deletions(-)

diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
index 5ddbe35..d6b6dc0 100644
--- a/Documentation/feature-removal-schedule.txt
+++ b/Documentation/feature-removal-schedule.txt
@@ -323,15 +323,3 @@ When:	June 2009
 Why:	Deprecated by the new fschmd driver.
 Who:	Hans de Goede <hdegoede@redhat.com>
 	Jean Delvare <khali@linux-fr.org>
-
----------------------------
-
-What:	SELinux "compat_net" functionality
-When:	2.6.30 at the earliest
-Why:	In 2.6.18 the Secmark concept was introduced to replace the "compat_net"
-	network access control functionality of SELinux.  Secmark offers both
-	better performance and greater flexibility than the "compat_net"
-	mechanism.  Now that the major Linux distributions have moved to
-	Secmark, it is time to deprecate the older mechanism and start the
-	process of removing the old code.
-Who:	Paul Moore <paul.moore@hp.com>
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 0081597..63854af 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -93,7 +93,6 @@
 
 extern unsigned int policydb_loaded_version;
 extern int selinux_nlmsg_lookup(u16 sclass, u16 nlmsg_type, u32 *perm);
-extern int selinux_compat_net;
 extern struct security_operations *security_ops;
 
 /* SECMARK reference count */
@@ -4120,72 +4119,6 @@ static int selinux_inet_sys_rcv_skb(int ifindex, char *addrp, u16 family,
 			    SECCLASS_NODE, NODE__RECVFROM, ad);
 }
 
-static int selinux_sock_rcv_skb_iptables_compat(struct sock *sk,
-						struct sk_buff *skb,
-						struct avc_audit_data *ad,
-						u16 family,
-						char *addrp)
-{
-	int err;
-	struct sk_security_struct *sksec = sk->sk_security;
-	u16 sk_class;
-	u32 netif_perm, node_perm, recv_perm;
-	u32 port_sid, node_sid, if_sid, sk_sid;
-
-	sk_sid = sksec->sid;
-	sk_class = sksec->sclass;
-
-	switch (sk_class) {
-	case SECCLASS_UDP_SOCKET:
-		netif_perm = NETIF__UDP_RECV;
-		node_perm = NODE__UDP_RECV;
-		recv_perm = UDP_SOCKET__RECV_MSG;
-		break;
-	case SECCLASS_TCP_SOCKET:
-		netif_perm = NETIF__TCP_RECV;
-		node_perm = NODE__TCP_RECV;
-		recv_perm = TCP_SOCKET__RECV_MSG;
-		break;
-	case SECCLASS_DCCP_SOCKET:
-		netif_perm = NETIF__DCCP_RECV;
-		node_perm = NODE__DCCP_RECV;
-		recv_perm = DCCP_SOCKET__RECV_MSG;
-		break;
-	default:
-		netif_perm = NETIF__RAWIP_RECV;
-		node_perm = NODE__RAWIP_RECV;
-		recv_perm = 0;
-		break;
-	}
-
-	err = sel_netif_sid(skb->iif, &if_sid);
-	if (err)
-		return err;
-	err = avc_has_perm(sk_sid, if_sid, SECCLASS_NETIF, netif_perm, ad);
-	if (err)
-		return err;
-
-	err = sel_netnode_sid(addrp, family, &node_sid);
-	if (err)
-		return err;
-	err = avc_has_perm(sk_sid, node_sid, SECCLASS_NODE, node_perm, ad);
-	if (err)
-		return err;
-
-	if (!recv_perm)
-		return 0;
-	err = sel_netport_sid(sk->sk_protocol,
-			      ntohs(ad->u.net.sport), &port_sid);
-	if (unlikely(err)) {
-		printk(KERN_WARNING
-		       "SELinux: failure in"
-		       " selinux_sock_rcv_skb_iptables_compat(),"
-		       " network port label not found\n");
-		return err;
-	}
-	return avc_has_perm(sk_sid, port_sid, sk_class, recv_perm, ad);
-}
-
 static int selinux_sock_rcv_skb_compat(struct sock *sk, struct sk_buff *skb,
 				       u16 family)
 {
@@ -4203,14 +4136,12 @@ static int selinux_sock_rcv_skb_compat(struct sock *sk, struct sk_buff *skb,
 	if (err)
 		return err;
 
-	if (selinux_compat_net)
-		err = selinux_sock_rcv_skb_iptables_compat(sk, skb, &ad,
-							   family, addrp);
-	else if (selinux_secmark_enabled())
+	if (selinux_secmark_enabled()) {
 		err = avc_has_perm(sk_sid, skb->secmark, SECCLASS_PACKET,
 				   PACKET__RECV, &ad);
-	if (err)
-		return err;
+		if (err)
+			return err;
+	}
 
 	if (selinux_policycap_netpeer) {
 		err = selinux_skb_peerlbl_sid(skb, family, &peer_sid);
@@ -4252,7 +4183,7 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 	 * to the selinux_sock_rcv_skb_compat() function to deal with the
 	 * special handling.  We do this in an attempt to keep this function
 	 * as fast and as clean as possible. */
-	if (selinux_compat_net || !selinux_policycap_netpeer)
+	if (!selinux_policycap_netpeer)
 		return selinux_sock_rcv_skb_compat(sk, skb, family);
 
 	secmark_active = selinux_secmark_enabled();
@@ -4620,71 +4551,6 @@ static unsigned int selinux_ipv4_output(unsigned int hooknum,
 	return selinux_ip_output(skb, PF_INET);
 }
 
-static int selinux_ip_postroute_iptables_compat(struct sock *sk,
-						int ifindex,
-						struct avc_audit_data *ad,
-						u16 family, char *addrp)
-{
-	int err;
-	struct sk_security_struct *sksec = sk->sk_security;
-	u16 sk_class;
-	u32 netif_perm, node_perm, send_perm;
-	u32 port_sid, node_sid, if_sid, sk_sid;
-
-	sk_sid = sksec->sid;
-	sk_class = sksec->sclass;
-
-	switch (sk_class) {
-	case SECCLASS_UDP_SOCKET:
-		netif_perm = NETIF__UDP_SEND;
-		node_perm = NODE__UDP_SEND;
-		send_perm = UDP_SOCKET__SEND_MSG;
-		break;
-	case SECCLASS_TCP_SOCKET:
-		netif_perm = NETIF__TCP_SEND;
-		node_perm = NODE__TCP_SEND;
-		send_perm = TCP_SOCKET__SEND_MSG;
-		break;
-	case SECCLASS_DCCP_SOCKET:
-		netif_perm = NETIF__DCCP_SEND;
-		node_perm = NODE__DCCP_SEND;
-		send_perm = DCCP_SOCKET__SEND_MSG;
-		break;
-	default:
-		netif_perm = NETIF__RAWIP_SEND;
-		node_perm = NODE__RAWIP_SEND;
-		send_perm = 0;
-		break;
-	}
-
-	err = sel_netif_sid(ifindex, &if_sid);
-	if (err)
-		return err;
-	err = avc_has_perm(sk_sid, if_sid, SECCLASS_NETIF, netif_perm, ad);
-		return err;
-
-	err = sel_netnode_sid(addrp, family, &node_sid);
-	if (err)
-		return err;
-	err = avc_has_perm(sk_sid, node_sid, SECCLASS_NODE, node_perm, ad);
-	if (err)
-		return err;
-
-	if (send_perm != 0)
-		return 0;
-
-	err = sel_netport_sid(sk->sk_protocol,
-			      ntohs(ad->u.net.dport), &port_sid);
-	if (unlikely(err)) {
-		printk(KERN_WARNING
-		       "SELinux: failure in"
-		       " selinux_ip_postroute_iptables_compat(),"
-		       " network port label not found\n");
-		return err;
-	}
-	return avc_has_perm(sk_sid, port_sid, sk_class, send_perm, ad);
-}
-
 static unsigned int selinux_ip_postroute_compat(struct sk_buff *skb,
 						int ifindex,
 						u16 family)
@@ -4705,15 +4571,10 @@ static unsigned int selinux_ip_postroute_compat(struct sk_buff *skb,
 	if (selinux_parse_skb(skb, &ad, &addrp, 0, &proto))
 		return NF_DROP;
 
-	if (selinux_compat_net) {
-		if (selinux_ip_postroute_iptables_compat(skb->sk, ifindex,
-							 &ad, family, addrp))
-			return NF_DROP;
-	} else if (selinux_secmark_enabled()) {
+	if (selinux_secmark_enabled())
 		if (avc_has_perm(sksec->sid, skb->secmark,
 				 SECCLASS_PACKET, PACKET__SEND, &ad))
 			return NF_DROP;
-	}
 
 	if (selinux_policycap_netpeer)
 		if (selinux_xfrm_postroute_last(sksec->sid, skb, &ad, proto))
@@ -4737,7 +4598,7 @@ static unsigned int selinux_ip_postroute(struct sk_buff *skb, int ifindex,
 	 * to the selinux_ip_postroute_compat() function to deal with the
 	 * special handling.  We do this in an attempt to keep this function
 	 * as fast and as clean as possible. */
-	if (selinux_compat_net || !selinux_policycap_netpeer)
+	if (!selinux_policycap_netpeer)
 		return selinux_ip_postroute_compat(skb, ifindex, family);
 #ifdef CONFIG_XFRM
 	/* If skb->dst->xfrm is non-NULL then the packet is undergoing an IPsec
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 01ec6d2..214f53c 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -47,8 +47,6 @@ static char *policycap_names[] = {
 
 unsigned int selinux_checkreqprot = CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE;
 
-int selinux_compat_net = 0;
-
 static int __init checkreqprot_setup(char *str)
 {
 	unsigned long checkreqprot;
@@ -58,16 +56,6 @@ static int __init checkreqprot_setup(char *str)
 }
 __setup("checkreqprot=", checkreqprot_setup);
 
-static int __init selinux_compat_net_setup(char *str)
-{
-	unsigned long compat_net;
-	if (!strict_strtoul(str, 0, &compat_net))
-		selinux_compat_net = compat_net ? 1 : 0;
-	return 1;
-}
-__setup("selinux_compat_net=", selinux_compat_net_setup);
-
-
 static DEFINE_MUTEX(sel_mutex);
 
 /* global data for booleans */
@@ -450,61 +438,6 @@ static const struct file_operations sel_checkreqprot_ops = {
 	.write		= sel_write_checkreqprot,
 };
 
-static ssize_t sel_read_compat_net(struct file *filp, char __user *buf,
-				   size_t count, loff_t *ppos)
-{
-	char tmpbuf[TMPBUFLEN];
-	ssize_t length;
-
-	length = scnprintf(tmpbuf, TMPBUFLEN, "%d", selinux_compat_net);
-	return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
-}
-
-static ssize_t sel_write_compat_net(struct file *file, const char __user *buf,
-				    size_t count, loff_t *ppos)
-{
-	char *page;
-	ssize_t length;
-	int new_value;
-
-	length = task_has_security(current, SECURITY__LOAD_POLICY);
-	if (length)
-		return length;
-
-	if (count >= PAGE_SIZE)
-		return -ENOMEM;
-	if (*ppos != 0) {
-		/* No partial writes. */
-		return -EINVAL;
-	}
-	page = (char *)get_zeroed_page(GFP_KERNEL);
-	if (!page)
-		return -ENOMEM;
-	length = -EFAULT;
-	if (copy_from_user(page, buf, count))
-		goto out;
-
-	length = -EINVAL;
-	if (sscanf(page, "%d", &new_value) != 1)
-		goto out;
-
-	if (new_value) {
-		printk(KERN_NOTICE
-		       "SELinux: compat_net is deprecated, please use secmark"
-		       " instead\n");
-		selinux_compat_net = 1;
-	} else
-		selinux_compat_net = 0;
-	length = count;
-out:
-	free_page((unsigned long) page);
-	return length;
-}
-static const struct file_operations sel_compat_net_ops = {
-	.read		= sel_read_compat_net,
-	.write		= sel_write_compat_net,
-};
-
 /*
  * Remaining nodes use transaction based IO methods like nfsd/nfsctl.c
  */
@@ -1665,7 +1598,6 @@ static int sel_fill_super(struct super_block *sb, void *data, int silent)
 		[SEL_DISABLE] = {"disable", &sel_disable_ops, S_IWUSR},
 		[SEL_MEMBER] = {"member", &transaction_ops, S_IRUGO|S_IWUGO},
 		[SEL_CHECKREQPROT] = {"checkreqprot", &sel_checkreqprot_ops, S_IRUGO|S_IWUSR},
-		[SEL_COMPAT_NET] = {"compat_net", &sel_compat_net_ops, S_IRUGO|S_IWUSR},
 		[SEL_REJECT_UNKNOWN] = {"reject_unknown", &sel_handle_unknown_ops, S_IRUGO},
 		[SEL_DENY_UNKNOWN] = {"deny_unknown", &sel_handle_unknown_ops, S_IRUGO},
 		/* last one */ {""}


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
