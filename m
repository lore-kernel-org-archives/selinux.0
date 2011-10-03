Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p93LWTKs018956
	for <selinux@tycho.nsa.gov>; Mon, 3 Oct 2011 17:32:29 -0400
Received: from mail-wy0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p93LWSAY015804
	for <selinux@tycho.nsa.gov>; Mon, 3 Oct 2011 21:32:28 GMT
Received: by wyf19 with SMTP id 19so4046261wyf.12
        for <selinux@tycho.nsa.gov>; Mon, 03 Oct 2011 14:32:28 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: David Howells <dhowells@redhat.com>
Cc: selinux@tycho.nsa.gov, netdev@vger.kernel.org
Subject: Re: [PATCH] SELinux: Fix RCU deref check warning in sel_netport_insert()
Date: Mon, 03 Oct 2011 17:30:41 -0400
Message-ID: <2230709.7n5noARWFd@sifl>
In-Reply-To: <20111003135824.15303.10147.stgit@warthog.procyon.org.uk>
References: <20111003135824.15303.10147.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday, October 03, 2011 02:58:24 PM David Howells wrote:
> Fix the following bug in sel_netport_insert() where rcu_dereference() should
> be rcu_dereference_protected() as sel_netport_lock is held.
> 
> ===================================================
> [ INFO: suspicious rcu_dereference_check() usage. ]
> ---------------------------------------------------
> security/selinux/netport.c:127 invoked rcu_dereference_check() without
> protection!
> 
> other info that might help us debug this:
> 
> 
> rcu_scheduler_active = 1, debug_locks = 0
> 1 lock held by ossec-rootcheck/3323:
>  #0:  (sel_netport_lock){+.....}, at: [<ffffffff8117d775>]
> sel_netport_sid+0xbb/0x226
> 
> stack backtrace:
> Pid: 3323, comm: ossec-rootcheck Not tainted 3.1.0-rc8-fsdevel+ #1095
> Call Trace:
>  [<ffffffff8105cfb7>] lockdep_rcu_dereference+0xa7/0xb0
>  [<ffffffff8117d871>] sel_netport_sid+0x1b7/0x226
>  [<ffffffff8117d6ba>] ? sel_netport_avc_callback+0xbc/0xbc
>  [<ffffffff8117556c>] selinux_socket_bind+0x115/0x230
>  [<ffffffff810a5388>] ? might_fault+0x4e/0x9e
>  [<ffffffff810a53d1>] ? might_fault+0x97/0x9e
>  [<ffffffff81171cf4>] security_socket_bind+0x11/0x13
>  [<ffffffff812ba967>] sys_bind+0x56/0x95
>  [<ffffffff81380dac>] ? sysret_check+0x27/0x62
>  [<ffffffff8105b767>] ? trace_hardirqs_on_caller+0x11e/0x155
>  [<ffffffff81076fcd>] ? audit_syscall_entry+0x17b/0x1ae
>  [<ffffffff811b5eae>] ? trace_hardirqs_on_thunk+0x3a/0x3f
>  [<ffffffff81380d7b>] system_call_fastpath+0x16/0x1b
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
> 
>  security/selinux/netport.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)

We should probably do the same for the security/selinux/netif.c as it uses the 
same logic; David is this something you want to tackle?

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/security/selinux/netport.c b/security/selinux/netport.c
> index 0b62bd1..39e2138 100644
> --- a/security/selinux/netport.c
> +++ b/security/selinux/netport.c
> @@ -123,7 +123,9 @@ static void sel_netport_insert(struct sel_netport *port)
> if (sel_netport_hash[idx].size == SEL_NETPORT_HASH_BKT_LIMIT) {
>  		struct sel_netport *tail;
>  		tail = list_entry(
> -			rcu_dereference(sel_netport_hash[idx].list.prev),
> +			rcu_dereference_protected(
> +				sel_netport_hash[idx].list.prev,
> +				spin_is_locked(&sel_netport_lock)),
>  			struct sel_netport, list);
>  		list_del_rcu(&tail->list);
>  		kfree_rcu(tail, rcu);
> 
> --
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
paul moore
www.paul-moore.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
