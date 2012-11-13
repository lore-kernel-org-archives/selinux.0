Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qADEgmiq032502
	for <selinux@tycho.nsa.gov>; Tue, 13 Nov 2012 09:42:48 -0500
Received: by mail-vc0-f181.google.com with SMTP id n11so8544138vch.12
        for <selinux@tycho.nsa.gov>; Tue, 13 Nov 2012 06:42:17 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: Eric Paris <eparis@parisplace.org>
Cc: Tommi Rantala <tt.rantala@gmail.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        James Morris <james.l.morris@oracle.com>,
        linux-security-module@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Eric Dumazet <eric.dumazet@gmail.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] SELinux: Fix RCU deref check warning in sel_netnode_insert()
Date: Tue, 13 Nov 2012 09:42:13 -0500
Message-ID: <1718634.SNujPArVHZ@sifl>
In-Reply-To: <1352814760-24451-1-git-send-email-tt.rantala@gmail.com>
References: <1352814760-24451-1-git-send-email-tt.rantala@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday, November 13, 2012 03:52:40 PM Tommi Rantala wrote:
> The following RCU message sometimes can be seen while running the
> Trinity syscall fuzzer. Apply the same fix as in commit 50345f1e
> ("SELinux: Fix RCU deref check warning in sel_netport_insert()").
> 
> [  167.304447] ===============================
> [  167.304454] [ INFO: suspicious RCU usage. ]
> [  167.304464] 3.7.0-rc5+ #12 Not tainted
> [  167.304472] -------------------------------
> [  167.304483] security/selinux/netnode.c:178 suspicious
> rcu_dereference_check() usage! [  167.304492]
> [  167.304492] other info that might help us debug this:
> [  167.304492]
> [  167.304505]
> [  167.304505] rcu_scheduler_active = 1, debug_locks = 1
> [  167.304516] 1 lock held by trinity-child1/1894:
> [  167.304523]  #0:  (sel_netnode_lock){+.....}, at: [<ffffffff812ca151>]
> sel_netnode_sid_slow+0x31/0x180 [  167.304565]
> [  167.304565] stack backtrace:
> [  167.304577] Pid: 1894, comm: trinity-child1 Not tainted 3.7.0-rc5+ #12
> [  167.304585] Call Trace:
> [  167.304605]  [<ffffffff810eee67>] lockdep_rcu_suspicious+0xe7/0x130
> [  167.304620]  [<ffffffff812c9f7a>] sel_netnode_insert+0xea/0x110
> [  167.304634]  [<ffffffff812ca27d>] sel_netnode_sid_slow+0x15d/0x180
> [  167.304651]  [<ffffffff812ca3bd>] sel_netnode_sid+0x11d/0x1a0
> [  167.304668]  [<ffffffff812ca2a0>] ? sel_netnode_sid_slow+0x180/0x180
> [  167.304688]  [<ffffffff812c41ca>] selinux_socket_bind+0xea/0x2a0
> [  167.304708]  [<ffffffff81173001>] ? print_vma_addr+0x71/0x120
> [  167.304724]  [<ffffffff81173135>] ? might_fault+0x85/0x90
> [  167.304740]  [<ffffffff812bb9f1>] security_socket_bind+0x11/0x20
> [  167.304755]  [<ffffffff8168e98e>] sys_bind+0x5e/0xc0
> [  167.304769]  [<ffffffff810ed0cd>] ? trace_hardirqs_on_caller+0x10d/0x1a0
> [  167.304785]  [<ffffffff813166de>] ? trace_hardirqs_on_thunk+0x3a/0x3f
> [  167.304802]  [<ffffffff81891669>] system_call_fastpath+0x16/0x1b
> 
> Signed-off-by: Tommi Rantala <tt.rantala@gmail.com>
> ---
>  security/selinux/netnode.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/security/selinux/netnode.c b/security/selinux/netnode.c
> index 28f911c..6dffd27 100644
> --- a/security/selinux/netnode.c
> +++ b/security/selinux/netnode.c
> @@ -174,7 +174,9 @@ static void sel_netnode_insert(struct sel_netnode *node)
> if (sel_netnode_hash[idx].size == SEL_NETNODE_HASH_BKT_LIMIT) {
>  		struct sel_netnode *tail;
>  		tail = list_entry(
> -			rcu_dereference(sel_netnode_hash[idx].list.prev),
> +			rcu_dereference_protected(
> +				sel_netnode_hash[idx].list.prev,
> +				lockdep_is_held(&sel_netnode_lock)),
>  			struct sel_netnode, list);
>  		list_del_rcu(&tail->list);
>  		kfree_rcu(tail, rcu);

Hey Eric, 27th times the charm, eh?  I'm not sure why this hasn't been merged 
yet, but we need this patch (or one of the many others posted before this 
one).

Acked-by: Paul Moore <paul@paul-moore.com>

-- 
paul moore
www.paul-moore.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
