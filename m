Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r8QL5D2S013260
	for <selinux@tycho.nsa.gov>; Thu, 26 Sep 2013 17:05:13 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r8QL5BIc031129
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 26 Sep 2013 17:05:11 -0400
Received: from sifl.localnet (vpn-55-43.rdu2.redhat.com [10.10.55.43])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id r8QL5A5n017239
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <selinux@tycho.nsa.gov>; Thu, 26 Sep 2013 17:05:10 -0400
From: Paul Moore <pmoore@redhat.com>
To: selinux@tycho.nsa.gov
Subject: Re: [PATCH] selinux: correct locking in selinux_netlbl_socket_connect)
Date: Thu, 26 Sep 2013 17:05:09 -0400
Message-ID: <20604616.rVRv7FPIn9@sifl>
In-Reply-To: <20130802180807.19794.24371.stgit@localhost>
References: <20130802180807.19794.24371.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday, August 02, 2013 02:08:07 PM Paul Moore wrote:
> The SELinux/NetLabel glue code has a locking bug that affects systems
> with NetLabel enabled, see the kernel error message below.  This patch
> corrects this problem by converting the bottom half socket lock to a
> more conventional, and correct for this call-path, lock_sock() call.
> 
>  ===============================
>  [ INFO: suspicious RCU usage. ]
>  3.11.0-rc3+ #19 Not tainted
>  -------------------------------
>  net/ipv4/cipso_ipv4.c:1928 suspicious rcu_dereference_protected() usage!
> 
>  other info that might help us debug this:
> 
>  rcu_scheduler_active = 1, debug_locks = 0
>  2 locks held by ping/731:
>   #0:  (slock-AF_INET/1){+.-...}, at: [...] selinux_netlbl_socket_connect
>   #1:  (rcu_read_lock){.+.+..}, at: [<...>] netlbl_conn_setattr
> 
>  stack backtrace:
>  CPU: 1 PID: 731 Comm: ping Not tainted 3.11.0-rc3+ #19
>  Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
>   0000000000000001 ffff88006f659d28 ffffffff81726b6a ffff88003732c500
>   ffff88006f659d58 ffffffff810e4457 ffff88006b845a00 0000000000000000
>   000000000000000c ffff880075aa2f50 ffff88006f659d90 ffffffff8169bec7
>  Call Trace:
>   [<ffffffff81726b6a>] dump_stack+0x54/0x74
>   [<ffffffff810e4457>] lockdep_rcu_suspicious+0xe7/0x120
>   [<ffffffff8169bec7>] cipso_v4_sock_setattr+0x187/0x1a0
>   [<ffffffff8170f317>] netlbl_conn_setattr+0x187/0x190
>   [<ffffffff8170f195>] ? netlbl_conn_setattr+0x5/0x190
>   [<ffffffff8131ac9e>] selinux_netlbl_socket_connect+0xae/0xc0
>   [<ffffffff81303025>] selinux_socket_connect+0x135/0x170
>   [<ffffffff8119d127>] ? might_fault+0x57/0xb0
>   [<ffffffff812fb146>] security_socket_connect+0x16/0x20
>   [<ffffffff815d3ad3>] SYSC_connect+0x73/0x130
>   [<ffffffff81739a85>] ? sysret_check+0x22/0x5d
>   [<ffffffff810e5e2d>] ? trace_hardirqs_on_caller+0xfd/0x1c0
>   [<ffffffff81373d4e>] ? trace_hardirqs_on_thunk+0x3a/0x3f
>   [<ffffffff815d52be>] SyS_connect+0xe/0x10
>   [<ffffffff81739a59>] system_call_fastpath+0x16/0x1b
> 
> Signed-off-by: Paul Moore <pmoore@redhat.com>
> ---
>  security/selinux/netlabel.c |    6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

FYI: I've gueued this up for 3.13.

 * git://git.infradead.org/users/pcmoore/selinux

> diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
> index da4b8b2..6235d05 100644
> --- a/security/selinux/netlabel.c
> +++ b/security/selinux/netlabel.c
> @@ -442,8 +442,7 @@ int selinux_netlbl_socket_connect(struct sock *sk,
> struct sockaddr *addr) sksec->nlbl_state != NLBL_CONNLABELED)
>  		return 0;
> 
> -	local_bh_disable();
> -	bh_lock_sock_nested(sk);
> +	lock_sock(sk);
> 
>  	/* connected sockets are allowed to disconnect when the address family
>  	 * is set to AF_UNSPEC, if that is what is happening we want to reset
> @@ -464,7 +463,6 @@ int selinux_netlbl_socket_connect(struct sock *sk,
> struct sockaddr *addr) sksec->nlbl_state = NLBL_CONNLABELED;
> 
>  socket_connect_return:
> -	bh_unlock_sock(sk);
> -	local_bh_enable();
> +	release_sock(sk);
>  	return rc;
>  }
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with the words "unsubscribe selinux" without quotes as the message.

-- 
paul moore
security and virtualization @ redhat


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
