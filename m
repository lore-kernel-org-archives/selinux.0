Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5G2r3rT029997
	for <selinux@tycho.nsa.gov>; Tue, 15 Jun 2004 22:53:03 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5G2qnRK021166
	for <selinux@tycho.nsa.gov>; Wed, 16 Jun 2004 02:52:54 GMT
Date: Tue, 15 Jun 2004 22:52:55 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
To: Andrew Morton <akpm@osdl.org>
cc: "David S. Miller" <davem@redhat.com>, Stephen Smalley <sds@epoch.ncsc.mil>,
   Chris Wright <chrisw@osdl.org>, <linux-kernel@vger.kernel.org>,
   <selinux@tycho.nsa.gov>
Subject: [SELINUX][PATCH 3/4] Fine-grained Netlink support - add sk to
 netlink_send hook
In-Reply-To: <Xine.LNX.4.44.0406152228190.30562@thoron.boston.redhat.com>
Message-ID: <Xine.LNX.4.44.0406152231400.30562-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Modifies the LSM netlink_send() hook so that it takes a struct sock
parameter.  SELinux will use this parameter to lookup the class of socket,
which was assigned during socket security initialization.

Please apply.

Signed-off-by: James Morris <jmorris@redhat.com>

 include/linux/security.h |   19 +++++++++++--------
 net/netlink/af_netlink.c |    2 +-
 security/dummy.c         |    2 +-
 security/selinux/hooks.c |    2 +-
 4 files changed, 14 insertions(+), 11 deletions(-)

diff -purN -X dontdiff linux-2.6.7-rc3.p/include/linux/security.h linux-2.6.7-rc3.w/include/linux/security.h
--- linux-2.6.7-rc3.p/include/linux/security.h	2004-05-09 22:32:54.000000000 -0400
+++ linux-2.6.7-rc3.w/include/linux/security.h	2004-06-09 11:14:38.963550072 -0400
@@ -53,7 +53,7 @@ extern void cap_task_reparent_to_init (s
 extern int cap_syslog (int type);
 extern int cap_vm_enough_memory (long pages);
 
-static inline int cap_netlink_send (struct sk_buff *skb)
+static inline int cap_netlink_send (struct sock *sk, struct sk_buff *skb)
 {
 	NETLINK_CB (skb).eff_cap = current->cap_effective;
 	return 0;
@@ -639,9 +639,12 @@ struct swap_info_struct;
  *	Save security information for a netlink message so that permission
  *	checking can be performed when the message is processed.  The security
  *	information can be saved using the eff_cap field of the
- *      netlink_skb_parms structure.
+ *      netlink_skb_parms structure.  Also may be used to provide fine
+ *	grained control over message transmission.
+ *	@sk associated sock of task sending the message.,
  *	@skb contains the sk_buff structure for the netlink message.
- *	Return 0 if the information was successfully saved.
+ *	Return 0 if the information was successfully saved and message
+ *	is allowed to be transmitted.
  * @netlink_recv:
  *	Check permission before processing the received netlink message in
  *	@skb.
@@ -1181,7 +1184,7 @@ struct security_operations {
 	int (*sem_semop) (struct sem_array * sma, 
 			  struct sembuf * sops, unsigned nsops, int alter);
 
-	int (*netlink_send) (struct sk_buff * skb);
+	int (*netlink_send) (struct sock * sk, struct sk_buff * skb);
 	int (*netlink_recv) (struct sk_buff * skb);
 
 	/* allow module stacking */
@@ -1873,9 +1876,9 @@ static inline int security_setprocattr(s
 	return security_ops->setprocattr(p, name, value, size);
 }
 
-static inline int security_netlink_send(struct sk_buff * skb)
+static inline int security_netlink_send(struct sock *sk, struct sk_buff * skb)
 {
-	return security_ops->netlink_send(skb);
+	return security_ops->netlink_send(sk, skb);
 }
 
 static inline int security_netlink_recv(struct sk_buff * skb)
@@ -2501,9 +2504,9 @@ static inline int security_setprocattr(s
  * (rather than hooking into the capability module) to reduce overhead
  * in the networking code.
  */
-static inline int security_netlink_send (struct sk_buff *skb)
+static inline int security_netlink_send (struct sock *sk, struct sk_buff *skb)
 {
-	return cap_netlink_send (skb);
+	return cap_netlink_send (sk, skb);
 }
 
 static inline int security_netlink_recv (struct sk_buff *skb)
diff -purN -X dontdiff linux-2.6.7-rc3.p/net/netlink/af_netlink.c linux-2.6.7-rc3.w/net/netlink/af_netlink.c
--- linux-2.6.7-rc3.p/net/netlink/af_netlink.c	2004-06-09 11:13:02.929149520 -0400
+++ linux-2.6.7-rc3.w/net/netlink/af_netlink.c	2004-06-09 11:15:12.260488168 -0400
@@ -734,7 +734,7 @@ static int netlink_sendmsg(struct kiocb 
 		goto out;
 	}
 
-	err = security_netlink_send(skb);
+	err = security_netlink_send(sk, skb);
 	if (err) {
 		kfree_skb(skb);
 		goto out;
diff -purN -X dontdiff linux-2.6.7-rc3.p/security/dummy.c linux-2.6.7-rc3.w/security/dummy.c
--- linux-2.6.7-rc3.p/security/dummy.c	2004-06-07 18:54:14.000000000 -0400
+++ linux-2.6.7-rc3.w/security/dummy.c	2004-06-09 11:14:38.964549920 -0400
@@ -720,7 +720,7 @@ static int dummy_sem_semop (struct sem_a
 	return 0;
 }
 
-static int dummy_netlink_send (struct sk_buff *skb)
+static int dummy_netlink_send (struct sock *sk, struct sk_buff *skb)
 {
 	if (current->euid == 0)
 		cap_raise (NETLINK_CB (skb).eff_cap, CAP_NET_ADMIN);
diff -purN -X dontdiff linux-2.6.7-rc3.p/security/selinux/hooks.c linux-2.6.7-rc3.w/security/selinux/hooks.c
--- linux-2.6.7-rc3.p/security/selinux/hooks.c	2004-06-07 18:54:14.000000000 -0400
+++ linux-2.6.7-rc3.w/security/selinux/hooks.c	2004-06-09 11:17:44.970272752 -0400
@@ -1567,7 +1567,7 @@ static int selinux_vm_enough_memory(long
 	return -ENOMEM;
 }
 
-static int selinux_netlink_send(struct sk_buff *skb)
+static int selinux_netlink_send(struct sock *sk, struct sk_buff *skb)
 {
 	if (capable(CAP_NET_ADMIN))
 		cap_raise (NETLINK_CB (skb).eff_cap, CAP_NET_ADMIN);




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
