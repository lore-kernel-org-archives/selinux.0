Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q4GKJ1ac011486
	for <selinux@tycho.nsa.gov>; Wed, 16 May 2012 16:19:01 -0400
Received: from /spool/local
	by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <selinux@tycho.nsa.gov> from <paulmck@linux.vnet.ibm.com>;
	Wed, 16 May 2012 14:19:02 -0600
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id C803C19D8058
	for <selinux@tycho.nsa.gov>; Wed, 16 May 2012 14:18:46 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q4GKIuTK116260
	for <selinux@tycho.nsa.gov>; Wed, 16 May 2012 14:18:58 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q4GKIsnc030015
	for <selinux@tycho.nsa.gov>; Wed, 16 May 2012 14:18:54 -0600
Date: Wed, 16 May 2012 13:18:53 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Paul Moore <pmoore@redhat.com>
Cc: selinux@tycho.nsa.gov, davej@redhat.com
Subject: Re: [RFC PATCH] selinux: fix a RCU dereference in
 sel_netnode_insert()
Message-ID: <20120516201852.GM2441@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <20120516201039.15853.97673.stgit@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120516201039.15853.97673.stgit@sifl>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, May 16, 2012 at 04:10:40PM -0400, Paul Moore wrote:
> This patch changes the rcu_dereference() call in sel_netnode_insert()
> to a rcu_dereference_protected() call to solve the problem shown
> below.
> 
>  ===============================
>  [ INFO: suspicious RCU usage. ]
>  3.4.0-rc7+ #93 Not tainted
>  -------------------------------
>  security/selinux/netnode.c:178 suspicious rcu_dereference_check() usage!
>  other info that might help us debug this:
>  rcu_scheduler_active = 1, debug_locks = 0
>  1 lock held by trinity/25132:
>   #0:  (sel_netnode_lock){+.....}, at:
>        [<ffffffff812db738>] sel_netnode_sid+0x148/0x3c0
>  stack backtrace:
>  Pid: 25132, comm: trinity Not tainted 3.4.0-rc7+ #93
>  Call Trace:
>   [<ffffffff810cc7cd>] lockdep_rcu_suspicious+0xfd/0x130
>   [<ffffffff812db981>] sel_netnode_sid+0x391/0x3c0
>   [<ffffffff812db5f0>] ? sel_netnode_find+0x1a0/0x1a0
>   [<ffffffff812d4a84>] selinux_socket_bind+0x104/0x350
>   [<ffffffff810a6648>] ? sched_clock_cpu+0xb8/0x130
>   [<ffffffff816a47b9>] ? sub_preempt_count+0xa9/0xe0
>   [<ffffffff812cb3e6>] security_socket_bind+0x16/0x20
>   [<ffffffff815468aa>] sys_bind+0x7a/0x100
>   [<ffffffff816a8795>] ? sysret_check+0x22/0x5d
>   [<ffffffff810d149d>] ? trace_hardirqs_on_caller+0x10d/0x1a0
>   [<ffffffff810fc18c>] ? __audit_syscall_entry+0xcc/0x310
>   [<ffffffff8133839e>] ? trace_hardirqs_on_thunk+0x3a/0x3f
>   [<ffffffff816a8769>] system_call_fastpath+0x16/0x1b
> 
> Reported-by: Dave Jones <davej@redhat.com>
> Signed-off-by: Paul Moore <pmoore@redhat.com>

Looks good to me!

Acked-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

> --
> 
> I've compiled tested this patch but due to some technical difficulties
> today I haven't been able to build a full kernel to make sure nothing
> horrible happens at boot; however, sending this out anyway in case
> others are having problems and *need* something.
> ---
>  security/selinux/netnode.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/security/selinux/netnode.c b/security/selinux/netnode.c
> index 8636585..bb24c5d 100644
> --- a/security/selinux/netnode.c
> +++ b/security/selinux/netnode.c
> @@ -174,7 +174,9 @@ static void sel_netnode_insert(struct sel_netnode *node)
>  	if (sel_netnode_hash[idx].size == SEL_NETNODE_HASH_BKT_LIMIT) {
>  		struct sel_netnode *tail;
>  		tail = list_entry(
> -			rcu_dereference(sel_netnode_hash[idx].list.prev),
> +			rcu_dereference_protected(
> +				sel_netnode_hash[idx].list.prev,
> +				lockdep_is_held(&sel_netnode_lock)),
>  			struct sel_netnode, list);
>  		list_del_rcu(&tail->list);
>  		kfree_rcu(tail, rcu);
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
