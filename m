Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i96IwIrT007674
	for <selinux@tycho.nsa.gov>; Wed, 6 Oct 2004 14:58:18 -0400 (EDT)
Date: Wed, 6 Oct 2004 14:58:15 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
cc: Kaigai Kohei <kaigai@ak.jp.nec.com>,
   "SELinux-ML(Eng)" <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] security/selinux/netif.c has a serious problem
In-Reply-To: <1097084297.11370.42.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Xine.LNX.4.44.0410061453220.1041-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 6 Oct 2004, Stephen Smalley wrote:

> > Hold on, you want to hold the lock while the user has the netif?
> 
> Yes, that is necessary to avoid having it freed while it is still being
> used.  Lock is released by the put method; looks sane to me.

It's bad form for a function to maybe take a lock and keep it (in this 
case disable preemption, although that could possibly change).

Below is a simpler patch which only allows the netif to be destroyed once.

Please review.


- James
-- 
James Morris
<jmorris@redhat.com>


diff -purN -X dontdiff linux-2.6.9-rc3-mm2.o/security/selinux/include/netif.h linux-2.6.9-rc3-mm2.w/security/selinux/include/netif.h
--- linux-2.6.9-rc3-mm2.o/security/selinux/include/netif.h	2004-09-29 23:04:46.000000000 -0400
+++ linux-2.6.9-rc3-mm2.w/security/selinux/include/netif.h	2004-10-06 12:22:51.000000000 -0400
@@ -19,6 +19,7 @@ struct sel_netif
 {
 	struct list_head list;
 	atomic_t users;
+	atomic_t alive;
 	struct netif_security_struct nsec;
 	struct rcu_head rcu_head;
 };
diff -purN -X dontdiff linux-2.6.9-rc3-mm2.o/security/selinux/netif.c linux-2.6.9-rc3-mm2.w/security/selinux/netif.c
--- linux-2.6.9-rc3-mm2.o/security/selinux/netif.c	2004-09-29 23:04:47.000000000 -0400
+++ linux-2.6.9-rc3-mm2.w/security/selinux/netif.c	2004-10-06 14:48:40.081338584 -0400
@@ -76,6 +76,7 @@ static int sel_netif_insert(struct sel_n
 	idx = sel_netif_hasfn(netif->nsec.dev);
 	list_add_rcu(&netif->list, &sel_netif_hash[idx].list);
 	atomic_set(&netif->users, 1);
+	atomic_set(&netif->alive, 1);
 	sel_netif_total++;
 out:
 	return ret;
@@ -144,14 +145,16 @@ static void sel_netif_free(struct rcu_he
 
 static void sel_netif_destroy(struct sel_netif *netif)
 {
-	DEBUGP("%s: %s\n", __FUNCTION__, netif->nsec.dev->name);
-	
-	spin_lock_bh(&sel_netif_lock);
-	list_del_rcu(&netif->list);
-	sel_netif_total--;
-	spin_unlock_bh(&sel_netif_lock);
+	DEBUGP("%s: %s alive=%d\n", __FUNCTION__, netif->nsec.dev->name,
+				    atomic_read(&netif->alive));
 
-	call_rcu(&netif->rcu_head, sel_netif_free);
+	if (atomic_dec_and_test(&netif->alive)) {
+		spin_lock_bh(&sel_netif_lock);
+		list_del_rcu(&netif->list);
+		sel_netif_total--;
+		spin_unlock_bh(&sel_netif_lock);
+		call_rcu(&netif->rcu_head, sel_netif_free);
+	}
 }
 
 void sel_netif_put(struct sel_netif *netif)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
