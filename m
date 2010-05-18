Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o4IJwkes020526
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2010 15:58:46 -0400
Received: from moss-lions.epoch.ncsc.mil (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o4IJw5WE029278
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2010 19:58:05 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.14.3/8.14.3) with ESMTP id o4IK0Y0x007279
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2010 16:00:34 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.14.3/8.14.3/Submit) id o4IK0Yco007277
	for selinux@tycho.nsa.gov; Tue, 18 May 2010 16:00:34 -0400
Date: Tue, 18 May 2010 12:11:25 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: sds@tycho.nsa.gov, jmorris@namei.org, eparis@parisplace.org
Cc: mingo@elte.hu, akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        selinux@tycho.nsa.gov, mathieu.desnoyers@efficios.com
Subject: [PATCH] selinux: remove all rcu head initializations
Message-ID: <20100518191125.GA7014@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello!

Would you guys like to carry this patch, or should I push it up
-tip?  If I don't hear otherwise from you, I will push it up -tip.
The INIT_RCU_HEAD() primitive is going away in favor of debugobjects.

							Thanx, Paul

------------------------------------------------------------------------

selinux: remove all rcu head initializations

Remove all rcu head inits. We don't care about the RCU head state before passing
it to call_rcu() anyway. Only leave the "on_stack" variants so debugobjects can
keep track of objects on stack.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Reviewed-by: James Morris <jmorris@namei.org>
Cc: Eric Paris <eparis@parisplace.org>

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 989fef8..bf4e3bc 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -288,7 +288,6 @@ static struct avc_node *avc_alloc_node(void)
 	if (!node)
 		goto out;
 
-	INIT_RCU_HEAD(&node->rhead);
 	INIT_HLIST_NODE(&node->list);
 	avc_cache_stats_incr(allocations);
 
diff --git a/security/selinux/netnode.c b/security/selinux/netnode.c
index dc92792..65ebfe9 100644
--- a/security/selinux/netnode.c
+++ b/security/selinux/netnode.c
@@ -183,8 +183,6 @@ static void sel_netnode_insert(struct sel_netnode *node)
 		BUG();
 	}
 
-	INIT_RCU_HEAD(&node->rcu);
-
 	/* we need to impose a limit on the growth of the hash table so check
 	 * this bucket to make sure it is within the specified bounds */
 	list_add_rcu(&node->list, &sel_netnode_hash[idx].list);


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
