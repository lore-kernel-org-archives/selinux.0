Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m3PJ3sBq019281
	for <selinux@tycho.nsa.gov>; Fri, 25 Apr 2008 15:03:55 -0400
Received: from QMTA02.westchester.pa.mail.comcast.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m3PJ38HT021752
	for <selinux@tycho.nsa.gov>; Fri, 25 Apr 2008 19:03:54 GMT
From: Paul Moore <paul.moore@hp.com>
Subject: [PATCH 2/2] SELinux: Fix a RCU free problem with the netport cache
To: selinux@tycho.nsa.gov
Date: Fri, 25 Apr 2008 15:03:39 -0400
Message-ID: <20080425190339.18002.77675.stgit@flek.lan>
In-Reply-To: <20080425185928.18002.88176.stgit@flek.lan>
References: <20080425185928.18002.88176.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The netport cache doesn't free resources in a manner which is safe or orderly.
This patch fixes this by adding in a missing call to rcu_dereference() in
sel_netport_insert() as well as some general cleanup throughout the file.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---

 security/selinux/netport.c |   40 ++++++++++++++++++----------------------
 1 files changed, 18 insertions(+), 22 deletions(-)

diff --git a/security/selinux/netport.c b/security/selinux/netport.c
index 68ede3c..90b4cff 100644
--- a/security/selinux/netport.c
+++ b/security/selinux/netport.c
@@ -114,8 +114,7 @@ static struct sel_netport *sel_netport_find(u8 protocol, u16 pnum)
 
 	idx = sel_netport_hashfn(pnum);
 	list_for_each_entry_rcu(port, &sel_netport_hash[idx].list, list)
-		if (port->psec.port == pnum &&
-		    port->psec.protocol == protocol)
+		if (port->psec.port == pnum && port->psec.protocol == protocol)
 			return port;
 
 	return NULL;
@@ -126,11 +125,10 @@ static struct sel_netport *sel_netport_find(u8 protocol, u16 pnum)
  * @port: the new port record
  *
  * Description:
- * Add a new port record to the network address hash table.  Returns zero on
- * success, negative values on failure.
+ * Add a new port record to the network address hash table.
  *
  */
-static int sel_netport_insert(struct sel_netport *port)
+static void sel_netport_insert(struct sel_netport *port)
 {
 	unsigned int idx;
 
@@ -140,13 +138,13 @@ static int sel_netport_insert(struct sel_netport *port)
 	list_add_rcu(&port->list, &sel_netport_hash[idx].list);
 	if (sel_netport_hash[idx].size == SEL_NETPORT_HASH_BKT_LIMIT) {
 		struct sel_netport *tail;
-		tail = list_entry(port->list.prev, struct sel_netport, list);
-		list_del_rcu(port->list.prev);
+		tail = list_entry(
+			rcu_dereference(sel_netport_hash[idx].list.prev),
+			struct sel_netport, list);
+		list_del_rcu(&tail->list);
 		call_rcu(&tail->rcu, sel_netport_free);
 	} else
 		sel_netport_hash[idx].size++;
-
-	return 0;
 }
 
 /**
@@ -163,7 +161,7 @@ static int sel_netport_insert(struct sel_netport *port)
  */
 static int sel_netport_sid_slow(u8 protocol, u16 pnum, u32 *sid)
 {
-	int ret;
+	int ret = -ENOMEM;
 	struct sel_netport *port;
 	struct sel_netport *new = NULL;
 
@@ -171,23 +169,20 @@ static int sel_netport_sid_slow(u8 protocol, u16 pnum, u32 *sid)
 	port = sel_netport_find(protocol, pnum);
 	if (port != NULL) {
 		*sid = port->psec.sid;
-		ret = 0;
-		goto out;
+		spin_unlock_bh(&sel_netport_lock);
+		return 0;
 	}
 	new = kzalloc(sizeof(*new), GFP_ATOMIC);
-	if (new == NULL) {
-		ret = -ENOMEM;
+	if (new == NULL)
 		goto out;
-	}
-	ret = security_port_sid(protocol, pnum, &new->psec.sid);
+	ret = security_port_sid(protocol, pnum, sid);
 	if (ret != 0)
 		goto out;
+
 	new->psec.port = pnum;
 	new->psec.protocol = protocol;
-	ret = sel_netport_insert(new);
-	if (ret != 0)
-		goto out;
-	*sid = new->psec.sid;
+	new->psec.sid = *sid;
+	sel_netport_insert(new);
 
 out:
 	spin_unlock_bh(&sel_netport_lock);
@@ -239,11 +234,12 @@ int sel_netport_sid(u8 protocol, u16 pnum, u32 *sid)
 static void sel_netport_flush(void)
 {
 	unsigned int idx;
-	struct sel_netport *port;
+	struct sel_netport *port, *port_tmp;
 
 	spin_lock_bh(&sel_netport_lock);
 	for (idx = 0; idx < SEL_NETPORT_HASH_SIZE; idx++) {
-		list_for_each_entry(port, &sel_netport_hash[idx].list, list) {
+		list_for_each_entry_safe(port, port_tmp,
+					 &sel_netport_hash[idx].list, list) {
 			list_del_rcu(&port->list);
 			call_rcu(&port->rcu, sel_netport_free);
 		}


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
