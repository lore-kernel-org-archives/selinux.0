Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m39N2Big022200
	for <selinux@tycho.nsa.gov>; Wed, 9 Apr 2008 19:02:11 -0400
Received: from QMTA03.westchester.pa.mail.comcast.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m39N2A2t009731
	for <selinux@tycho.nsa.gov>; Wed, 9 Apr 2008 23:02:10 GMT
From: Paul Moore <paul.moore@hp.com>
Subject: [PATCH v2 2/2] SELinux: Add network port SID cache
To: selinux@tycho.nsa.gov
Date: Wed, 09 Apr 2008 18:57:42 -0400
Message-ID: <20080409225741.18745.89990.stgit@flek.lan>
In-Reply-To: <20080409225618.18745.56458.stgit@flek.lan>
References: <20080409225618.18745.56458.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Much like we added a network node cache, this patch adds a network port cache.
The design is taken almost completely from the network node cache which in
turn was taken from the network interface cache.  The basic idea is to cache
entries in a hash table based on protocol/port information.  The hash
function only takes the port number into account since the number of different
protocols in use at any one time is expected to be relatively small.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---

 security/selinux/Makefile           |    1 
 security/selinux/hooks.c            |   20 +-
 security/selinux/include/netport.h  |   31 ++++
 security/selinux/include/objsec.h   |    6 +
 security/selinux/include/security.h |    3 
 security/selinux/netport.c          |  286 +++++++++++++++++++++++++++++++++++
 security/selinux/ss/services.c      |    8 -
 7 files changed, 334 insertions(+), 21 deletions(-)

diff --git a/security/selinux/Makefile b/security/selinux/Makefile
index 00afd85..d47fc5e 100644
--- a/security/selinux/Makefile
+++ b/security/selinux/Makefile
@@ -11,6 +11,7 @@ selinux-y := avc.o \
 	     nlmsgtab.o \
 	     netif.o \
 	     netnode.o \
+	     netport.o \
 	     exports.o
 
 selinux-$(CONFIG_SECURITY_NETWORK_XFRM) += xfrm.o
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 820d07a..415269f 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -80,6 +80,7 @@
 #include "objsec.h"
 #include "netif.h"
 #include "netnode.h"
+#include "netport.h"
 #include "xfrm.h"
 #include "netlabel.h"
 
@@ -3626,10 +3627,8 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
 			inet_get_local_port_range(&low, &high);
 
 			if (snum < max(PROT_SOCK, low) || snum > high) {
-				err = security_port_sid(sk->sk_family,
-							sk->sk_type,
-							sk->sk_protocol, snum,
-							&sid);
+				err = sel_netport_sid(sk->sk_protocol,
+						      snum, &sid);
 				if (err)
 					goto out;
 				AVC_AUDIT_DATA_INIT(&ad,NET);
@@ -3717,8 +3716,7 @@ static int selinux_socket_connect(struct socket *sock, struct sockaddr *address,
 			snum = ntohs(addr6->sin6_port);
 		}
 
-		err = security_port_sid(sk->sk_family, sk->sk_type,
-					sk->sk_protocol, snum, &sid);
+		err = sel_netport_sid(sk->sk_protocol, snum, &sid);
 		if (err)
 			goto out;
 
@@ -3949,9 +3947,8 @@ static int selinux_sock_rcv_skb_iptables_compat(struct sock *sk,
 
 	if (!recv_perm)
 		return 0;
-	err = security_port_sid(sk->sk_family, sk->sk_type,
-				sk->sk_protocol, ntohs(ad->u.net.sport),
-				&port_sid);
+	err = sel_netport_sid(sk->sk_protocol,
+			      ntohs(ad->u.net.sport), &port_sid);
 	if (unlikely(err)) {
 		printk(KERN_WARNING
 		       "SELinux: failure in"
@@ -4372,9 +4369,8 @@ static int selinux_ip_postroute_iptables_compat(struct sock *sk,
 	if (send_perm != 0)
 		return 0;
 
-	err = security_port_sid(sk->sk_family, sk->sk_type,
-				sk->sk_protocol, ntohs(ad->u.net.dport),
-				&port_sid);
+	err = sel_netport_sid(sk->sk_protocol,
+			      ntohs(ad->u.net.dport), &port_sid);
 	if (unlikely(err)) {
 		printk(KERN_WARNING
 		       "SELinux: failure in"
diff --git a/security/selinux/include/netport.h b/security/selinux/include/netport.h
new file mode 100644
index 0000000..8991752
--- /dev/null
+++ b/security/selinux/include/netport.h
@@ -0,0 +1,31 @@
+/*
+ * Network port table
+ *
+ * SELinux must keep a mapping of network ports to labels/SIDs.  This
+ * mapping is maintained as part of the normal policy but a fast cache is
+ * needed to reduce the lookup overhead.
+ *
+ * Author: Paul Moore <paul.moore@hp.com>
+ *
+ */
+
+/*
+ * (c) Copyright Hewlett-Packard Development Company, L.P., 2008
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#ifndef _SELINUX_NETPORT_H
+#define _SELINUX_NETPORT_H
+
+int sel_netport_sid(u8 protocol, u16 pnum, u32 *sid);
+
+#endif
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index c6c2bb4..04dfdfe 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -109,6 +109,12 @@ struct netnode_security_struct {
 	u16 family;			/* address family */
 };
 
+struct netport_security_struct {
+	u32 sid;			/* SID for this node */
+	u16 port;			/* port number */
+	u8 protocol;			/* transport protocol */
+};
+
 struct sk_security_struct {
 	struct sock *sk;		/* back pointer to sk object */
 	u32 sid;			/* SID of this object */
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index f7d2f03..9901d9d 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -91,8 +91,7 @@ int security_context_to_sid_default(char *scontext, u32 scontext_len, u32 *out_s
 int security_get_user_sids(u32 callsid, char *username,
 			   u32 **sids, u32 *nel);
 
-int security_port_sid(u16 domain, u16 type, u8 protocol, u16 port,
-	u32 *out_sid);
+int security_port_sid(u8 protocol, u16 port, u32 *out_sid);
 
 int security_netif_sid(char *name, u32 *if_sid);
 
diff --git a/security/selinux/netport.c b/security/selinux/netport.c
new file mode 100644
index 0000000..85da809
--- /dev/null
+++ b/security/selinux/netport.c
@@ -0,0 +1,286 @@
+/*
+ * Network port table
+ *
+ * SELinux must keep a mapping of network ports to labels/SIDs.  This
+ * mapping is maintained as part of the normal policy but a fast cache is
+ * needed to reduce the lookup overhead.
+ *
+ * Author: Paul Moore <paul.moore@hp.com>
+ *
+ * This code is heavily based on the "netif" concept originally developed by
+ * James Morris <jmorris@redhat.com>
+ *   (see security/selinux/netif.c for more information)
+ *
+ */
+
+/*
+ * (c) Copyright Hewlett-Packard Development Company, L.P., 2008
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/types.h>
+#include <linux/rcupdate.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <linux/in.h>
+#include <linux/in6.h>
+#include <linux/ip.h>
+#include <linux/ipv6.h>
+#include <net/ip.h>
+#include <net/ipv6.h>
+#include <asm/bug.h>
+
+#include "netport.h"
+#include "objsec.h"
+
+#define SEL_NETPORT_HASH_SIZE       256
+#define SEL_NETPORT_HASH_BKT_LIMIT   16
+
+struct sel_netport_bkt {
+	int size;
+	struct list_head list;
+};
+
+struct sel_netport {
+	struct netport_security_struct psec;
+
+	struct list_head list;
+	struct rcu_head rcu;
+};
+
+/* NOTE: we are using a combined hash table for both IPv4 and IPv6, the reason
+ * for this is that I suspect most users will not make heavy use of both
+ * address families at the same time so one table will usually end up wasted,
+ * if this becomes a problem we can always add a hash table for each address
+ * family later */
+
+static LIST_HEAD(sel_netport_list);
+static DEFINE_SPINLOCK(sel_netport_lock);
+static struct sel_netport_bkt sel_netport_hash[SEL_NETPORT_HASH_SIZE];
+
+/**
+ * sel_netport_free - Frees a port entry
+ * @p: the entry's RCU field
+ *
+ * Description:
+ * This function is designed to be used as a callback to the call_rcu()
+ * function so that memory allocated to a hash table port entry can be
+ * released safely.
+ *
+ */
+static void sel_netport_free(struct rcu_head *p)
+{
+	struct sel_netport *port = container_of(p, struct sel_netport, rcu);
+	kfree(port);
+}
+
+/**
+ * sel_netport_hashfn - Hashing function for the port table
+ * @pnum: port number
+ *
+ * Description:
+ * This is the hashing function for the port table, it returns the bucket
+ * number for the given port.
+ *
+ */
+static unsigned int sel_netport_hashfn(u16 pnum)
+{
+	return (pnum & (SEL_NETPORT_HASH_SIZE - 1));
+}
+
+/**
+ * sel_netport_find - Search for a port record
+ * @protocol: protocol
+ * @port: pnum
+ *
+ * Description:
+ * Search the network port table and return the matching record.  If an entry
+ * can not be found in the table return NULL.
+ *
+ */
+static struct sel_netport *sel_netport_find(u8 protocol, u16 pnum)
+{
+	unsigned int idx;
+	struct sel_netport *port;
+
+	idx = sel_netport_hashfn(pnum);
+	list_for_each_entry_rcu(port, &sel_netport_hash[idx].list, list)
+		if (port->psec.port == pnum &&
+		    port->psec.protocol == protocol)
+			return port;
+
+	return NULL;
+}
+
+/**
+ * sel_netport_insert - Insert a new port into the table
+ * @port: the new port record
+ *
+ * Description:
+ * Add a new port record to the network address hash table.  Returns zero on
+ * success, negative values on failure.
+ *
+ */
+static int sel_netport_insert(struct sel_netport *port)
+{
+	unsigned int idx;
+
+	/* we need to impose a limit on the growth of the hash table so check
+	 * this bucket to make sure it is within the specified bounds */
+	idx = sel_netport_hashfn(port->psec.port);
+	list_add_rcu(&port->list, &sel_netport_hash[idx].list);
+	if (sel_netport_hash[idx].size == SEL_NETPORT_HASH_BKT_LIMIT) {
+		struct sel_netport *tail;
+		tail = list_entry(port->list.prev, struct sel_netport, list);
+		__list_del(port->list.prev, port->list.next);
+		call_rcu(&tail->rcu, sel_netport_free);
+	} else
+		sel_netport_hash[idx].size++;
+
+	return 0;
+}
+
+/**
+ * sel_netport_sid_slow - Lookup the SID of a network address using the policy
+ * @protocol: protocol
+ * @pnum: port
+ * @sid: port SID
+ *
+ * Description:
+ * This function determines the SID of a network port by quering the security
+ * policy.  The result is added to the network port table to speedup future
+ * queries.  Returns zero on success, negative values on failure.
+ *
+ */
+static int sel_netport_sid_slow(u8 protocol, u16 pnum, u32 *sid)
+{
+	int ret;
+	struct sel_netport *port;
+	struct sel_netport *new = NULL;
+
+	spin_lock_bh(&sel_netport_lock);
+	port = sel_netport_find(protocol, pnum);
+	if (port != NULL) {
+		*sid = port->psec.sid;
+		ret = 0;
+		goto out;
+	}
+	new = kzalloc(sizeof(*new), GFP_ATOMIC);
+	if (new == NULL) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	ret = security_port_sid(protocol, pnum, &new->psec.sid);
+	if (ret != 0)
+		goto out;
+	new->psec.port = pnum;
+	new->psec.protocol = protocol;
+	ret = sel_netport_insert(new);
+	if (ret != 0)
+		goto out;
+	*sid = new->psec.sid;
+
+out:
+	spin_unlock_bh(&sel_netport_lock);
+	if (unlikely(ret)) {
+		printk(KERN_WARNING
+		       "SELinux: failure in sel_netport_sid_slow(),"
+		       " unable to determine network port label\n");
+		kfree(new);
+	}
+	return ret;
+}
+
+/**
+ * sel_netport_sid - Lookup the SID of a network port
+ * @protocol: protocol
+ * @pnum: port
+ * @sid: port SID
+ *
+ * Description:
+ * This function determines the SID of a network port using the fastest method
+ * possible.  First the port table is queried, but if an entry can't be found
+ * then the policy is queried and the result is added to the table to speedup
+ * future queries.  Returns zero on success, negative values on failure.
+ *
+ */
+int sel_netport_sid(u8 protocol, u16 pnum, u32 *sid)
+{
+	struct sel_netport *port;
+
+	rcu_read_lock();
+	port = sel_netport_find(protocol, pnum);
+	if (port != NULL) {
+		*sid = port->psec.sid;
+		rcu_read_unlock();
+		return 0;
+	}
+	rcu_read_unlock();
+
+	return sel_netport_sid_slow(protocol, pnum, sid);
+}
+
+/**
+ * sel_netport_flush - Flush the entire network port table
+ *
+ * Description:
+ * Remove all entries from the network address table.
+ *
+ */
+static void sel_netport_flush(void)
+{
+	unsigned int idx;
+	struct sel_netport *port;
+
+	spin_lock_bh(&sel_netport_lock);
+	for (idx = 0; idx < SEL_NETPORT_HASH_SIZE; idx++) {
+		list_for_each_entry(port, &sel_netport_hash[idx].list, list) {
+			list_del_rcu(&port->list);
+			call_rcu(&port->rcu, sel_netport_free);
+		}
+		sel_netport_hash[idx].size = 0;
+	}
+	spin_unlock_bh(&sel_netport_lock);
+}
+
+static int sel_netport_avc_callback(u32 event, u32 ssid, u32 tsid,
+				    u16 class, u32 perms, u32 *retained)
+{
+	if (event == AVC_CALLBACK_RESET) {
+		sel_netport_flush();
+		synchronize_net();
+	}
+	return 0;
+}
+
+static __init int sel_netport_init(void)
+{
+	int iter;
+	int ret;
+
+	if (!selinux_enabled)
+		return 0;
+
+	for (iter = 0; iter < SEL_NETPORT_HASH_SIZE; iter++) {
+		INIT_LIST_HEAD(&sel_netport_hash[iter].list);
+		sel_netport_hash[iter].size = 0;
+	}
+
+	ret = avc_add_callback(sel_netport_avc_callback, AVC_CALLBACK_RESET,
+	                       SECSID_NULL, SECSID_NULL, SECCLASS_NULL, 0);
+	if (ret != 0)
+		panic("avc_add_callback() failed, error %d\n", ret);
+
+	return ret;
+}
+
+__initcall(sel_netport_init);
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index f374186..5e499f9 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1441,17 +1441,11 @@ err:
 
 /**
  * security_port_sid - Obtain the SID for a port.
- * @domain: communication domain aka address family
- * @type: socket type
  * @protocol: protocol number
  * @port: port number
  * @out_sid: security identifier
  */
-int security_port_sid(u16 domain,
-		      u16 type,
-		      u8 protocol,
-		      u16 port,
-		      u32 *out_sid)
+int security_port_sid(u8 protocol, u16 port, u32 *out_sid)
 {
 	struct ocontext *c;
 	int rc = 0;


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
