Subject: Re: SELinux and SMP
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: "George C. Wilson" <ltcgcw@us.ibm.com>
Cc: SELinux <SELinux@tycho.nsa.gov>, James Morris <jmorris@redhat.com>
In-Reply-To: <20040510170636.GA3856@us.ibm.com>
References: <20040510170636.GA3856@us.ibm.com>
Content-Type: multipart/mixed; boundary="=-JfSpPczIpwcBAUNWI85x"
Message-Id: <1084211702.23757.263.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 10 May 2004 13:55:02 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-JfSpPczIpwcBAUNWI85x
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2004-05-10 at 13:06, George C. Wilson wrote:
> I have been playing with an SELinux setup for a couple of months and have
> been following this list.  I haven't seen much talk lately about how well
> SELinux works on SMP machines.  How SMP safe is SELinux?  Has anybody
> made SMP performance measurements lately?

There is one known safety issue with SMP; a race in the sock_rcv_skb
hook, apparently between closing a socket and packet receipt on the
socket.  The attached patch against 2.6.6 should fix, but is still
undergoing testing.  Otherwise, I don't know of any other SMP safety
issues.

With regard to scalability, Hubertus Franke and Rajan Ravindran of IBM
did some preliminary work on SELinux back in 2001 (e.g. see
http://marc.theaimsgroup.com/?l=selinux&m=99229517500418&w=2) but didn't
follow up for some reason.  I did request and get a patch from Rajan
later in 2001, but it was still rather experimental (6 different
approaches with 6 different config options), and turned out to be
unsafe, and there was no further follow up.  Last summer, James Morris
of RedHat performed some benchmarking of SELinux and did some
experimentation to try to improve scalability and performance, but
didn't find a good solution at the time and had to defer further
investigation until later.

The AVC spinlock is the chief stumbling block, and note that it protects
more than just the cache itself; it also protects the AVC entry
references embedded in the kernel object security structures.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

--=-JfSpPczIpwcBAUNWI85x
Content-Disposition: attachment; filename=sockrcvskb.patch
Content-Type: text/x-patch; name=sockrcvskb.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: linux-2.6/security/selinux/hooks.c
diff -u linux-2.6/security/selinux/hooks.c:1.1.1.11 linux-2.6/security/selinux/hooks.c:1.110
--- linux-2.6/security/selinux/hooks.c:1.1.1.11	Mon May 10 08:36:57 2004
+++ linux-2.6/security/selinux/hooks.c	Mon May 10 09:10:09 2004
@@ -3094,12 +3173,12 @@
 	char *addrp;
 	int len, err = 0;
 	u32 netif_perm, node_perm, node_sid, recv_perm = 0;
+	u32 sock_sid = 0;
+	u16 sock_class = 0;
 	struct socket *sock;
-	struct inode *inode;
 	struct net_device *dev;
 	struct sel_netif *netif;
 	struct netif_security_struct *nsec;
-	struct inode_security_struct *isec;
 	struct avc_audit_data ad;
 
 	family = sk->sk_family;
@@ -3110,15 +3189,21 @@
 	if (family == PF_INET6 && skb->protocol == ntohs(ETH_P_IP))
 		family = PF_INET;
 
-	sock = sk->sk_socket;
-	
-	/* TCP control messages don't always have a socket. */
-	if (!sock)
-		goto out;
-
-	inode = SOCK_INODE(sock);
-	if (!inode)
-		goto out;
+ 	read_lock_bh(&sk->sk_callback_lock);
+ 	sock = sk->sk_socket;
+ 	if (sock) {
+ 		struct inode *inode;
+ 		inode = SOCK_INODE(sock);
+ 		if (inode) {
+ 			struct inode_security_struct *isec;
+ 			isec = inode->i_security;
+ 			sock_sid = isec->sid;
+ 			sock_class = isec->sclass;
+ 		}
+ 	}
+ 	read_unlock_bh(&sk->sk_callback_lock);
+ 	if (!sock_sid)
+  		goto out;
 
 	dev = skb->dev;
 	if (!dev)
@@ -3131,9 +3216,8 @@
 	}
 	
 	nsec = &netif->nsec;
-	isec = inode->i_security;
 
-	switch (isec->sclass) {
+	switch (sock_class) {
 	case SECCLASS_UDP_SOCKET:
 		netif_perm = NETIF__UDP_RECV;
 		node_perm = NODE__UDP_RECV;
@@ -3162,7 +3246,7 @@
 		goto out;
 	}
 
-	err = avc_has_perm(isec->sid, nsec->if_sid, SECCLASS_NETIF,
+	err = avc_has_perm(sock_sid, nsec->if_sid, SECCLASS_NETIF,
 	                   netif_perm, &nsec->avcr, &ad);
 	sel_netif_put(netif);
 	if (err)
@@ -3173,7 +3257,7 @@
 	if (err)
 		goto out;
 	
-	err = avc_has_perm(isec->sid, node_sid, SECCLASS_NODE, node_perm, NULL, &ad);
+	err = avc_has_perm(sock_sid, node_sid, SECCLASS_NODE, node_perm, NULL, &ad);
 	if (err)
 		goto out;
 
@@ -3187,7 +3271,7 @@
 		if (err)
 			goto out;
 
-		err = avc_has_perm(isec->sid, port_sid, isec->sclass,
+		err = avc_has_perm(sock_sid, port_sid, sock_class,
 		                   recv_perm, NULL, &ad);
 	}
 out:	

--=-JfSpPczIpwcBAUNWI85x--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
