Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9664RrT002369
	for <selinux@tycho.nsa.gov>; Wed, 6 Oct 2004 02:04:28 -0400 (EDT)
Message-ID: <058301c4ab69$ea86b8f0$f97d220a@linux.bs1.fc.nec.co.jp>
From: "Kaigai Kohei" <kaigai@ak.jp.nec.com>
To: "James Morris" <jmorris@redhat.com>,
   "Stephen Smalley" <sds@epoch.ncsc.mil>
Cc: "SELinux-ML(Eng)" <selinux@tycho.nsa.gov>
Subject: [PATCH] security/selinux/netif.c has a serious problem
Date: Wed, 6 Oct 2004 15:01:26 +0900
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0580_01C4ABB5.5A590430"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_0580_01C4ABB5.5A590430
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit

Hello

I noticed security/selinux/netif.c has a serious problem.
It causes kernel-panic when loading the security-policy and
networking related programs are executed concurrently.
The attached patch (against to 2.6.9-rc3-mm2) fixes the problem.

[Detail]
Pay attention to sel_netif_lookup() and sel_netif_put() in
security/selinux/netif.c.
sel_netif_lookup() searches on the sel_netif_hash table,
and grabs the target 'netif' object. Then, the reference
counter of the grabbed object is incremented.
sel_netif_put() decrements the reference counter of 'netif'
object, then destroys 'netif' object if the reference counter
equals zero.

But we can sometimes destroy the same object twice or more,
because grabbing the object and incrementing the reference
counter are not atomic.

For example:
---- CPU-A ----             ---- CPU-B ----
sel_netif_lookup(){         
    :                       
netif = sel_netif_find()    
(netif->users=1)            sel_netif_flush(){
    :                            :
    :                       sel_netif_put(netif)
    :                         atomic_dec_and_test(&netif->users)
    :                           (netif->users=0)
    :                            +--> sel_netif_destroy(netif)
    :                                 (release the netif)
atomic_inc(&netif->users);
(netif->users=1)
return netif
}
    :
sel_netif_put(netif)
  atomic_dec_and_test(&netif->users)
    (netif->users=0)
     +--> sel_netif_destroy(netif)
          (release the same netif twice!)

[The attached patch]
This patch fixes the problem.
- It does not depend on the reference counter. RCU-mechanism determines
  the timing of release.
- If sel_netif_lookup() return success, the context is under rcu_read_lock().
  sel_netif_put() is defined as an alias of rcu_read_unlock().
  The presence of 'netif' object looked up is guaranteed between those
  period only.
- Updating the sel_netif_hash table is protected by spinlock_irqsave().
  This method is same as my RCU-patch.

Thanks

# And, I wondered if 'sel_netif_total' is really necessary.
--------
Kai Gai <kaigai@ak.jp.nec.com>

------=_NextPart_000_0580_01C4ABB5.5A590430
Content-Type: application/octet-stream;
	name="selinux.safe-2.6.9-rc3-mm2.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="selinux.safe-2.6.9-rc3-mm2.patch"

--- linux-2.6.9-rc3-mm2/security/selinux/netif.c	2004-09-30 =
12:04:47.000000000 +0900=0A=
+++ linux-2.6.9-rc3-mm2.safe/security/selinux/netif.c	2004-10-08 =
00:08:34.597447562 +0900=0A=
@@ -36,11 +36,10 @@=0A=
 #define DEBUGP(format, args...)=0A=
 #endif=0A=
 =0A=
 static u32 sel_netif_total;=0A=
-static LIST_HEAD(sel_netif_list);=0A=
-static spinlock_t sel_netif_lock =3D SPIN_LOCK_UNLOCKED;=0A=
-static struct sel_netif sel_netif_hash[SEL_NETIF_HASH_SIZE];=0A=
+static spinlock_t sel_netif_lock[SEL_NETIF_HASH_SIZE];=0A=
+static struct list_head sel_netif_hash[SEL_NETIF_HASH_SIZE];=0A=
 =0A=
 static inline u32 sel_netif_hasfn(struct net_device *dev)=0A=
 {=0A=
 	return (dev->ifindex & (SEL_NETIF_HASH_SIZE - 1));=0A=
@@ -48,53 +47,39 @@=0A=
 =0A=
 /*=0A=
  * All of the devices should normally fit in the hash, so we optimize=0A=
  * for that case.=0A=
+ * This function must be called under rcu_read_lock().=0A=
  */=0A=
 static struct sel_netif *sel_netif_find(struct net_device *dev)=0A=
 {=0A=
-	struct list_head *pos;=0A=
+	struct sel_netif *netif;=0A=
 	int idx =3D sel_netif_hasfn(dev);=0A=
 =0A=
-	__list_for_each_rcu(pos, &sel_netif_hash[idx].list) {=0A=
-		struct sel_netif *netif =3D list_entry(pos,=0A=
-		                                     struct sel_netif, list);=0A=
+	list_for_each_entry_rcu(netif, &sel_netif_hash[idx], list) {=0A=
 		if (likely(netif->nsec.dev =3D=3D dev))=0A=
 			return netif;=0A=
 	}=0A=
-	return NULL;=0A=
-}=0A=
 =0A=
-static int sel_netif_insert(struct sel_netif *netif)=0A=
-{=0A=
-	int idx, ret =3D 0;=0A=
-	=0A=
-	if (sel_netif_total >=3D SEL_NETIF_HASH_MAX) {=0A=
-		ret =3D -ENOSPC;=0A=
-		goto out;=0A=
-	}=0A=
-	=0A=
-	idx =3D sel_netif_hasfn(netif->nsec.dev);=0A=
-	list_add_rcu(&netif->list, &sel_netif_hash[idx].list);=0A=
-	atomic_set(&netif->users, 1);=0A=
-	sel_netif_total++;=0A=
-out:=0A=
-	return ret;=0A=
+	return NULL;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * If sel_netif_lookup() succeed, current is under the rcu_read_lock().=0A=
+ * rcu_read_unlock() is called by sel_netif_put().=0A=
+ */=0A=
 struct sel_netif *sel_netif_lookup(struct net_device *dev)=0A=
 {=0A=
-	int ret;=0A=
+	int ret, idx;=0A=
+	unsigned long flags;=0A=
 	struct sel_netif *netif, *new;=0A=
 	struct netif_security_struct *nsec;=0A=
 =0A=
 	rcu_read_lock();=0A=
 	netif =3D sel_netif_find(dev);=0A=
-	rcu_read_unlock();=0A=
-	=0A=
 	if (likely(netif !=3D NULL))=0A=
-		goto out_hold;=0A=
-	=0A=
+		return netif;=0A=
+=0A=
 	new =3D kmalloc(sizeof(*new), GFP_ATOMIC);=0A=
 	if (!new) {=0A=
 		netif =3D ERR_PTR(-ENOMEM);=0A=
 		goto out;=0A=
@@ -110,28 +95,35 @@=0A=
 		goto out;=0A=
 	}=0A=
 =0A=
 	nsec->dev =3D dev;=0A=
-	=0A=
-	spin_lock_bh(&sel_netif_lock);=0A=
-	=0A=
-	netif =3D sel_netif_find(dev);=0A=
-	if (netif) {=0A=
-		spin_unlock_bh(&sel_netif_lock);=0A=
+=0A=
+	/* insert new entry */=0A=
+	idx =3D sel_netif_hasfn(nsec->dev);=0A=
+	spin_lock_irqsave(&sel_netif_lock[idx], flags);=0A=
+	list_for_each_entry_rcu(netif, &sel_netif_hash[idx], list) {=0A=
+		if (likely(netif->nsec.dev =3D=3D dev)) {=0A=
+			kfree(new);=0A=
+			goto out_unlock;=0A=
+		}=0A=
+	}=0A=
+=0A=
+	if (sel_netif_total >=3D SEL_NETIF_HASH_MAX) {=0A=
 		kfree(new);=0A=
-		goto out_hold;=0A=
+		netif =3D ERR_PTR(-ENOSPC);=0A=
+		goto out_unlock;=0A=
 	}=0A=
-	=0A=
-	sel_netif_insert(new);=0A=
-	spin_unlock_bh(&sel_netif_lock);=0A=
-	=0A=
 	netif =3D new;=0A=
-	=0A=
+	list_add_rcu(&netif->list, &sel_netif_hash[idx]);=0A=
+	sel_netif_total++;=0A=
+=0A=
+out_unlock:=0A=
+	spin_unlock_irqrestore(&sel_netif_lock[idx], flags);=0A=
+=0A=
 	DEBUGP("new: ifindex=3D%u name=3D%s if_sid=3D%u msg_sid=3D%u\n", =
dev->ifindex, dev->name,=0A=
 	        nsec->if_sid, nsec->msg_sid);=0A=
-out_hold:=0A=
-	atomic_inc(&netif->users);=0A=
 out:=0A=
+	rcu_read_unlock();=0A=
 	return netif;=0A=
 }=0A=
 =0A=
 static void sel_netif_free(struct rcu_head *p)=0A=
@@ -141,53 +133,39 @@=0A=
 	DEBUGP("%s: %s\n", __FUNCTION__, netif->nsec.dev->name);=0A=
 	kfree(netif);=0A=
 }=0A=
 =0A=
-static void sel_netif_destroy(struct sel_netif *netif)=0A=
-{=0A=
-	DEBUGP("%s: %s\n", __FUNCTION__, netif->nsec.dev->name);=0A=
-	=0A=
-	spin_lock_bh(&sel_netif_lock);=0A=
-	list_del_rcu(&netif->list);=0A=
-	sel_netif_total--;=0A=
-	spin_unlock_bh(&sel_netif_lock);=0A=
-=0A=
-	call_rcu(&netif->rcu_head, sel_netif_free);=0A=
-}=0A=
-=0A=
-void sel_netif_put(struct sel_netif *netif)=0A=
-{=0A=
-	if (atomic_dec_and_test(&netif->users))=0A=
-		sel_netif_destroy(netif);=0A=
-}=0A=
-=0A=
 static void sel_netif_kill(struct net_device *dev)=0A=
 {=0A=
 	struct sel_netif *netif;=0A=
-	=0A=
-	rcu_read_lock();=0A=
-	netif =3D sel_netif_find(dev);=0A=
-	rcu_read_unlock();=0A=
+	unsigned long flags;=0A=
+	int idx =3D sel_netif_hasfn(dev);=0A=
 =0A=
-	/* Drop internal reference */=0A=
-	if (netif)=0A=
-		sel_netif_put(netif);=0A=
+	spin_lock_irqsave(&sel_netif_lock[idx], flags);=0A=
+	netif =3D sel_netif_find(dev);=0A=
+	if (netif) {=0A=
+		list_del_rcu(&netif->list);=0A=
+		call_rcu(&netif->rcu_head, sel_netif_free);=0A=
+		sel_netif_total--;=0A=
+	}=0A=
+	spin_unlock_irqrestore(&sel_netif_lock[idx], flags);=0A=
 }=0A=
 =0A=
 static void sel_netif_flush(void)=0A=
 {=0A=
+	unsigned long flags;=0A=
 	int idx;=0A=
 =0A=
 	for (idx =3D 0; idx < SEL_NETIF_HASH_SIZE; idx++) {=0A=
-		struct list_head *pos;=0A=
-		=0A=
-		list_for_each_rcu(pos, &sel_netif_hash[idx].list) {=0A=
-			struct sel_netif *netif;=0A=
-			=0A=
-			netif =3D list_entry(pos, struct sel_netif, list);=0A=
-			if (netif)=0A=
-				sel_netif_put(netif);=0A=
+		struct sel_netif *netif;=0A=
+=0A=
+		spin_lock_irqsave(&sel_netif_lock[idx], flags);=0A=
+		list_for_each_entry_rcu(netif, &sel_netif_hash[idx], list) {=0A=
+			list_del_rcu(&netif->list);=0A=
+			call_rcu(&netif->rcu_head, sel_netif_free);=0A=
+			sel_netif_total--;=0A=
 		}=0A=
+		spin_unlock_irqrestore(&sel_netif_lock[idx], flags);=0A=
 	}=0A=
 }=0A=
 =0A=
 static int sel_netif_avc_callback(u32 event, u32 ssid, u32 tsid,=0A=
@@ -221,10 +199,13 @@=0A=
 	=0A=
 	if (!selinux_enabled)=0A=
 		goto out;=0A=
 =0A=
-	for (i =3D 0; i < SEL_NETIF_HASH_SIZE; i++)=0A=
-		INIT_LIST_HEAD(&sel_netif_hash[i].list);=0A=
+	sel_netif_total =3D 0;=0A=
+	for (i =3D 0; i < SEL_NETIF_HASH_SIZE; i++){=0A=
+		INIT_LIST_HEAD(&sel_netif_hash[i]);=0A=
+		spin_lock_init(&sel_netif_lock[i]);=0A=
+	}=0A=
 =0A=
 	register_netdevice_notifier(&sel_netif_netdev_notifier);=0A=
 	=0A=
 	err =3D avc_add_callback(sel_netif_avc_callback, AVC_CALLBACK_RESET,=0A=
--- linux-2.6.9-rc3-mm2/security/selinux/include/netif.h	2004-09-30 =
12:04:46.000000000 +0900=0A=
+++ linux-2.6.9-rc3-mm2.safe/security/selinux/include/netif.h	2004-10-08 =
02:07:59.930367600 +0900=0A=
@@ -17,14 +17,13 @@=0A=
 =0A=
 struct sel_netif=0A=
 {=0A=
 	struct list_head list;=0A=
-	atomic_t users;=0A=
 	struct netif_security_struct nsec;=0A=
 	struct rcu_head rcu_head;=0A=
 };=0A=
 =0A=
 struct sel_netif *sel_netif_lookup(struct net_device *dev);=0A=
-void sel_netif_put(struct sel_netif *netif);=0A=
+#define sel_netif_put(x)	rcu_read_unlock()=0A=
 =0A=
 #endif	/* _SELINUX_NETIF_H_ */=0A=
 =0A=

------=_NextPart_000_0580_01C4ABB5.5A590430--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
