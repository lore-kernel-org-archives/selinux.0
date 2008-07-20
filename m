Date: Mon, 21 Jul 2008 02:24:19 +0300 (EEST)
From: Vesa-Matti J Kari <vmkari@cc.helsinki.fi>
To: Eric Paris <eparis@parisplace.org>
cc: Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
        paul.moore@hp.com, selinux@tycho.nsa.gov
Subject: [patch] SELinux: trivial, unify iterator variable naming, part 3
Message-ID: <Pine.LNX.4.64L.0807210220280.8567@ruuvi.it.helsinki.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

Once again, renamed iterators "idx" to "i", to be in harmony
with the old unwritten C convention, and with the rest of the code.

Signed-off-by: Vesa-Matti Kari <vmkari@cc.helsinki.fi>

---

 security/selinux/netif.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)



--- security-testing-2.6/security/selinux/netif.c	2008-07-20 18:29:22.000000000 +0300
+++ security-testing-2.6-vmk2/security/selinux/netif.c	2008-07-21 02:17:42.000000000 +0300
@@ -67,10 +67,10 @@ static inline u32 sel_netif_hashfn(int i
  */
 static inline struct sel_netif *sel_netif_find(int ifindex)
 {
-	int idx = sel_netif_hashfn(ifindex);
+	int i = sel_netif_hashfn(ifindex);
 	struct sel_netif *netif;

-	list_for_each_entry_rcu(netif, &sel_netif_hash[idx], list)
+	list_for_each_entry_rcu(netif, &sel_netif_hash[i], list)
 		/* all of the devices should normally fit in the hash, so we
 		 * optimize for that case */
 		if (likely(netif->nsec.ifindex == ifindex))
@@ -90,13 +90,13 @@ static inline struct sel_netif *sel_neti
  */
 static int sel_netif_insert(struct sel_netif *netif)
 {
-	int idx;
+	int i;

 	if (sel_netif_total >= SEL_NETIF_HASH_MAX)
 		return -ENOSPC;

-	idx = sel_netif_hashfn(netif->nsec.ifindex);
-	list_add_rcu(&netif->list, &sel_netif_hash[idx]);
+	i = sel_netif_hashfn(netif->nsec.ifindex);
+	list_add_rcu(&netif->list, &sel_netif_hash[i]);
 	sel_netif_total++;

 	return 0;
@@ -257,12 +257,12 @@ static void sel_netif_kill(int ifindex)
  */
 static void sel_netif_flush(void)
 {
-	int idx;
+	int i;
 	struct sel_netif *netif;

 	spin_lock_bh(&sel_netif_lock);
-	for (idx = 0; idx < SEL_NETIF_HASH_SIZE; idx++)
-		list_for_each_entry(netif, &sel_netif_hash[idx], list)
+	for (i = 0; i < SEL_NETIF_HASH_SIZE; i++)
+		list_for_each_entry(netif, &sel_netif_hash[i], list)
 			sel_netif_destroy(netif);
 	spin_unlock_bh(&sel_netif_lock);
 }

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
