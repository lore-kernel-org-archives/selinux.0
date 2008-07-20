Date: Mon, 21 Jul 2008 00:46:52 +0300 (EEST)
From: Vesa-Matti J Kari <vmkari@cc.helsinki.fi>
To: Eric Paris <eparis@parisplace.org>
cc: Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
        selinux@tycho.nsa.gov
Subject: [patch] SELinux: trivial, unify iterator variable naming
Message-ID: <Pine.LNX.4.64L.0807210043160.7451@ruuvi.it.helsinki.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Hello,

Renamed iterators "idx" and "iter" to "i", to be in harmony
with the old unwritten C convention, and with the rest of the code.

Signed-off-by: Vesa-Matti Kari <vmkari@cc.helsinki.fi>

---

Renamed iterators "idx" and "iter" to "i", to be in harmony
with the old unwritten C convention, and with the rest of the code.

 security/selinux/netnode.c   |   38 +++++++++++++++++++-------------------
 security/selinux/netport.c   |   34 +++++++++++++++++-----------------
 security/selinux/selinuxfs.c |   10 +++++-----
 3 files changed, 41 insertions(+), 41 deletions(-)



--- security-testing-2.6/security/selinux/netnode.c	2008-07-20 18:29:22.000000000 +0300
+++ security-testing-2.6-vmk/security/selinux/netnode.c	2008-07-21 00:06:25.000000000 +0300
@@ -128,21 +128,21 @@
  */
 static struct sel_netnode *sel_netnode_find(const void *addr, u16 family)
 {
-	unsigned int idx;
+	unsigned int i;
 	struct sel_netnode *node;

 	switch (family) {
 	case PF_INET:
-		idx = sel_netnode_hashfn_ipv4(*(__be32 *)addr);
+		i = sel_netnode_hashfn_ipv4(*(__be32 *)addr);
 		break;
 	case PF_INET6:
-		idx = sel_netnode_hashfn_ipv6(addr);
+		i = sel_netnode_hashfn_ipv6(addr);
 		break;
 	default:
 		BUG();
 	}

-	list_for_each_entry_rcu(node, &sel_netnode_hash[idx].list, list)
+	list_for_each_entry_rcu(node, &sel_netnode_hash[i].list, list)
 		if (node->nsec.family == family)
 			switch (family) {
 			case PF_INET:
@@ -169,14 +169,14 @@
  */
 static void sel_netnode_insert(struct sel_netnode *node)
 {
-	unsigned int idx;
+	unsigned int i;

 	switch (node->nsec.family) {
 	case PF_INET:
-		idx = sel_netnode_hashfn_ipv4(node->nsec.addr.ipv4);
+		i = sel_netnode_hashfn_ipv4(node->nsec.addr.ipv4);
 		break;
 	case PF_INET6:
-		idx = sel_netnode_hashfn_ipv6(&node->nsec.addr.ipv6);
+		i = sel_netnode_hashfn_ipv6(&node->nsec.addr.ipv6);
 		break;
 	default:
 		BUG();
@@ -186,16 +186,16 @@

 	/* we need to impose a limit on the growth of the hash table so check
 	 * this bucket to make sure it is within the specified bounds */
-	list_add_rcu(&node->list, &sel_netnode_hash[idx].list);
-	if (sel_netnode_hash[idx].size == SEL_NETNODE_HASH_BKT_LIMIT) {
+	list_add_rcu(&node->list, &sel_netnode_hash[i].list);
+	if (sel_netnode_hash[i].size == SEL_NETNODE_HASH_BKT_LIMIT) {
 		struct sel_netnode *tail;
 		tail = list_entry(
-			rcu_dereference(sel_netnode_hash[idx].list.prev),
+			rcu_dereference(sel_netnode_hash[i].list.prev),
 			struct sel_netnode, list);
 		list_del_rcu(&tail->list);
 		call_rcu(&tail->rcu, sel_netnode_free);
 	} else
-		sel_netnode_hash[idx].size++;
+		sel_netnode_hash[i].size++;
 }

 /**
@@ -298,17 +298,17 @@
  */
 static void sel_netnode_flush(void)
 {
-	unsigned int idx;
+	unsigned int i;
 	struct sel_netnode *node, *node_tmp;

 	spin_lock_bh(&sel_netnode_lock);
-	for (idx = 0; idx < SEL_NETNODE_HASH_SIZE; idx++) {
+	for (i = 0; i < SEL_NETNODE_HASH_SIZE; i++) {
 		list_for_each_entry_safe(node, node_tmp,
-					 &sel_netnode_hash[idx].list, list) {
+					 &sel_netnode_hash[i].list, list) {
 				list_del_rcu(&node->list);
 				call_rcu(&node->rcu, sel_netnode_free);
 		}
-		sel_netnode_hash[idx].size = 0;
+		sel_netnode_hash[i].size = 0;
 	}
 	spin_unlock_bh(&sel_netnode_lock);
 }
@@ -325,15 +325,15 @@

 static __init int sel_netnode_init(void)
 {
-	int iter;
+	int i;
 	int ret;

 	if (!selinux_enabled)
 		return 0;

-	for (iter = 0; iter < SEL_NETNODE_HASH_SIZE; iter++) {
-		INIT_LIST_HEAD(&sel_netnode_hash[iter].list);
-		sel_netnode_hash[iter].size = 0;
+	for (i = 0; i < SEL_NETNODE_HASH_SIZE; i++) {
+		INIT_LIST_HEAD(&sel_netnode_hash[i].list);
+		sel_netnode_hash[i].size = 0;
 	}

 	ret = avc_add_callback(sel_netnode_avc_callback, AVC_CALLBACK_RESET,
--- security-testing-2.6/security/selinux/netport.c	2008-07-20 18:29:22.000000000 +0300
+++ security-testing-2.6-vmk/security/selinux/netport.c	2008-07-21 00:09:46.000000000 +0300
@@ -108,11 +108,11 @@
  */
 static struct sel_netport *sel_netport_find(u8 protocol, u16 pnum)
 {
-	unsigned int idx;
+	unsigned int i;
 	struct sel_netport *port;

-	idx = sel_netport_hashfn(pnum);
-	list_for_each_entry_rcu(port, &sel_netport_hash[idx].list, list)
+	i = sel_netport_hashfn(pnum);
+	list_for_each_entry_rcu(port, &sel_netport_hash[i].list, list)
 		if (port->psec.port == pnum && port->psec.protocol == protocol)
 			return port;

@@ -129,21 +129,21 @@
  */
 static void sel_netport_insert(struct sel_netport *port)
 {
-	unsigned int idx;
+	unsigned int i;

 	/* we need to impose a limit on the growth of the hash table so check
 	 * this bucket to make sure it is within the specified bounds */
-	idx = sel_netport_hashfn(port->psec.port);
-	list_add_rcu(&port->list, &sel_netport_hash[idx].list);
-	if (sel_netport_hash[idx].size == SEL_NETPORT_HASH_BKT_LIMIT) {
+	i = sel_netport_hashfn(port->psec.port);
+	list_add_rcu(&port->list, &sel_netport_hash[i].list);
+	if (sel_netport_hash[i].size == SEL_NETPORT_HASH_BKT_LIMIT) {
 		struct sel_netport *tail;
 		tail = list_entry(
-			rcu_dereference(sel_netport_hash[idx].list.prev),
+			rcu_dereference(sel_netport_hash[i].list.prev),
 			struct sel_netport, list);
 		list_del_rcu(&tail->list);
 		call_rcu(&tail->rcu, sel_netport_free);
 	} else
-		sel_netport_hash[idx].size++;
+		sel_netport_hash[i].size++;
 }

 /**
@@ -232,17 +232,17 @@
  */
 static void sel_netport_flush(void)
 {
-	unsigned int idx;
+	unsigned int i;
 	struct sel_netport *port, *port_tmp;

 	spin_lock_bh(&sel_netport_lock);
-	for (idx = 0; idx < SEL_NETPORT_HASH_SIZE; idx++) {
+	for (i = 0; i < SEL_NETPORT_HASH_SIZE; i++) {
 		list_for_each_entry_safe(port, port_tmp,
-					 &sel_netport_hash[idx].list, list) {
+					 &sel_netport_hash[i].list, list) {
 			list_del_rcu(&port->list);
 			call_rcu(&port->rcu, sel_netport_free);
 		}
-		sel_netport_hash[idx].size = 0;
+		sel_netport_hash[i].size = 0;
 	}
 	spin_unlock_bh(&sel_netport_lock);
 }
@@ -259,15 +259,15 @@

 static __init int sel_netport_init(void)
 {
-	int iter;
+	int i;
 	int ret;

 	if (!selinux_enabled)
 		return 0;

-	for (iter = 0; iter < SEL_NETPORT_HASH_SIZE; iter++) {
-		INIT_LIST_HEAD(&sel_netport_hash[iter].list);
-		sel_netport_hash[iter].size = 0;
+	for (i = 0; i < SEL_NETPORT_HASH_SIZE; i++) {
+		INIT_LIST_HEAD(&sel_netport_hash[i].list);
+		sel_netport_hash[i].size = 0;
 	}

 	ret = avc_add_callback(sel_netport_avc_callback, AVC_CALLBACK_RESET,
--- security-testing-2.6/security/selinux/selinuxfs.c	2008-07-20 18:29:22.000000000 +0300
+++ security-testing-2.6-vmk/security/selinux/selinuxfs.c	2008-07-21 00:11:52.000000000 +0300
@@ -1590,16 +1590,16 @@

 static int sel_make_policycap(void)
 {
-	unsigned int iter;
+	unsigned int i;
 	struct dentry *dentry = NULL;
 	struct inode *inode = NULL;

 	sel_remove_entries(policycap_dir);

-	for (iter = 0; iter <= POLICYDB_CAPABILITY_MAX; iter++) {
-		if (iter < ARRAY_SIZE(policycap_names))
+	for (i = 0; i <= POLICYDB_CAPABILITY_MAX; i++) {
+		if (i < ARRAY_SIZE(policycap_names))
 			dentry = d_alloc_name(policycap_dir,
-					      policycap_names[iter]);
+					      policycap_names[i]);
 		else
 			dentry = d_alloc_name(policycap_dir, "unknown");

@@ -1611,7 +1611,7 @@
 			return -ENOMEM;

 		inode->i_fop = &sel_policycap_ops;
-		inode->i_ino = iter | SEL_POLICYCAP_INO_OFFSET;
+		inode->i_ino = i | SEL_POLICYCAP_INO_OFFSET;
 		d_add(dentry, inode);
 	}


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
