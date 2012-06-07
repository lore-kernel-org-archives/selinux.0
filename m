Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q57I4rhZ006987
	for <selinux@tycho.nsa.gov>; Thu, 7 Jun 2012 14:04:55 -0400
Received: by ggnv5 with SMTP id v5so674890ggn.12
        for <selinux@tycho.nsa.gov>; Thu, 07 Jun 2012 11:04:53 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: Re: [PATCH 3/3] SELinux: Fix sel_netnode_insert suspicious rcu dereference
Date: Thu, 07 Jun 2012 14:04:49 -0400
Message-ID: <19411409.4uMR1dC79a@sifl>
In-Reply-To: <20120606155344.32443.93187.stgit@paris.rdu.redhat.com>
References: <20120606155333.32443.15937.stgit@paris.rdu.redhat.com> <20120606155344.32443.93187.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday, June 06, 2012 11:53:44 AM Eric Paris wrote:
> I reported this a year ago (https://lkml.org/lkml/2011/4/20/308).
> It's still a problem apparently ...

I sent a patch to fix this back on May 16th ... ?
 
> ===============================
> [ INFO: suspicious RCU usage. ]
> 3.5.0-rc1+ #63 Not tainted
> -------------------------------
> security/selinux/netnode.c:178 suspicious rcu_dereference_check() usage!
> 
> other info that might help us debug this:
> 
> 
> rcu_scheduler_active = 1, debug_locks = 0
> 1 lock held by trinity-child1/8750:
>  #0:  (sel_netnode_lock){+.....}, at: [<ffffffff812d8f8a>]
> sel_netnode_sid+0x16a/0x3e0
> 
> stack backtrace:
> Pid: 8750, comm: trinity-child1 Not tainted 3.5.0-rc1+ #63
> Call Trace:
>  [<ffffffff810cec2d>] lockdep_rcu_suspicious+0xfd/0x130
>  [<ffffffff812d91d1>] sel_netnode_sid+0x3b1/0x3e0
>  [<ffffffff812d8e20>] ? sel_netnode_find+0x1a0/0x1a0
>  [<ffffffff812d24a6>] selinux_socket_bind+0xf6/0x2c0
>  [<ffffffff810cd1dd>] ? trace_hardirqs_off+0xd/0x10
>  [<ffffffff810cdb55>] ? lock_release_holdtime.part.9+0x15/0x1a0
>  [<ffffffff81093841>] ? lock_hrtimer_base+0x31/0x60
>  [<ffffffff812c9536>] security_socket_bind+0x16/0x20
>  [<ffffffff815550ca>] sys_bind+0x7a/0x100
>  [<ffffffff816c03d5>] ? sysret_check+0x22/0x5d
>  [<ffffffff810d392d>] ? trace_hardirqs_on_caller+0x10d/0x1a0
>  [<ffffffff8133b09e>] ? trace_hardirqs_on_thunk+0x3a/0x3f
>  [<ffffffff816c03a9>] system_call_fastpath+0x16/0x1b
> 
> This patch below does what Paul McKenney suggested in the previous thread.
> 
> Signed-off-by: Dave Jones <davej@redhat.com>
> Signed-off-by: Eric Paris <eparis@redhat.com>
> ---
>  security/selinux/netnode.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/security/selinux/netnode.c b/security/selinux/netnode.c
> index e984d6f..3b66d89 100644
> --- a/security/selinux/netnode.c
> +++ b/security/selinux/netnode.c
> @@ -174,7 +174,8 @@ static void sel_netnode_insert(struct sel_netnode *node)
> if (sel_netnode_hash[idx].size == SEL_NETNODE_HASH_BKT_LIMIT) {
>  		struct sel_netnode *tail;
>  		tail = list_entry(
> -			rcu_dereference(sel_netnode_hash[idx].list.prev),
> +			rcu_dereference_protected(sel_netnode_hash[idx].list.prev,
> +						  lockdep_is_held(&sel_netnode_lock)),
>  			struct sel_netnode, list);
>  		list_del_rcu(&tail->list);
>  		kfree_rcu(tail, rcu);
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with the words "unsubscribe selinux" without quotes as the message.
-- 
paul moore
www.paul-moore.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
