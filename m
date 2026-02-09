Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CAB37756C;
	Mon,  9 Feb 2026 14:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770647201; cv=none; b=c+UiNp9N+GvswqXA86dt2e753hywC63QXcGN0Xse+4P5Nff1E50z9cXaElmb4RZNfDoR0Yii5LEfxIvc5elPkhSu/TRWV90CsMH28kCIPPchZyAOAW0blS20YBF9tA2vFUHOFEwt3gbI7HXiEjnl5QwVyaIUorp4UfF7//izZDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770647201; c=relaxed/simple;
	bh=w0KGseemj0KZDUokCz9rANKBh2ORIZDBQ+Fzgd9PC2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XxeESWw4BKRZM+1Y57wznaNS3lqjS8rIdvVZA7VheotNlhRgFAqY1s8AcPSADCt1SHIZ36APgcgg5GxeBRQGMhXYRAmVde34VWnSVu1Rql7Ceq6sHoXHsa5PyprEKiomrM2NNWjEqfUPy2HT1cIC9ru0W427eli0GnrUhmHSUXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 619EQEQr061626;
	Mon, 9 Feb 2026 23:26:14 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 619EQE1i061622
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 9 Feb 2026 23:26:14 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <7c17884d-dbf1-4c2c-9813-0c5369cfdcc9@I-love.SAKURA.ne.jp>
Date: Mon, 9 Feb 2026 23:26:14 +0900
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xfrm: kill xfrm_dev_{state,policy}_flush_secctx_check()
To: Steffen Klassert <steffen.klassert@secunet.com>,
        Paul Moore <paul@paul-moore.com>, SELinux <selinux@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Network Development <netdev@vger.kernel.org>
References: <1bb453af-3ef2-4ab6-a909-0705bd07c136@I-love.SAKURA.ne.jp>
 <CAHC9VhQEKfxXzFgYShojESpQn10LES5zL6Ua0YV9b8seEKFqyA@mail.gmail.com>
 <93d291db-4175-48c4-830c-e83bab373ae2@I-love.SAKURA.ne.jp>
 <CAHC9VhQPKU5DqG-ryZsiCV2vZeGGf_a-JStR_LVVCCn03C4usQ@mail.gmail.com>
 <f9b88268-03dc-4356-8b31-0bab73cc9b1e@I-love.SAKURA.ne.jp>
 <CAHC9VhRzRAR+hhn4TFADnHWpzjOxjmh0S_Hg_HktkPkKQ35ycg@mail.gmail.com>
 <74a70504-8ff8-4d97-b35f-774364779889@I-love.SAKURA.ne.jp>
 <7ef21dab-3805-4eae-80d7-9779aeff3f58@I-love.SAKURA.ne.jp>
 <aYmoDwO-YXrc4W1c@secunet.com>
 <85546d35-c7bd-49bf-b0c3-9677bde25859@I-love.SAKURA.ne.jp>
 <aYnDWbxo-jAzR4ca@secunet.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <aYnDWbxo-jAzR4ca@secunet.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav204.rs.sakura.ne.jp

On 2026/02/09 20:22, Steffen Klassert wrote:
> On Mon, Feb 09, 2026 at 07:02:47PM +0900, Tetsuo Handa wrote:
>> On 2026/02/09 18:25, Steffen Klassert wrote:
>>> The problem is that, with adding IPsec offloads to netdevices, security
>>> critical resources came into the netdevices. Someone who has no
>>> capabilities to delete xfrm states or xfrm policies should not be able
>>> to unregister the netdevice if xfrm states or xfrm policies are
>>> offloaded. Unfortunately, unregistering can't be canceled at this stage
>>> anymore. So I think we need some netdevice unregistration hook for
>>> the LSM subsystem so it can check for xfrm states or xfrm policies
>>> and refuse the unregistration before we actually start to remove
>>> the device.
>>
>> Unfortunately, unregistering is not always triggered by a user's request. ;-)
> 
> As far as I remember, a security context is not always tied to a
> user request. It can also be attached to system tasks or objects.

That is not what I wanted to say. There are at least three routes (listed below)
that can trigger xfrm_dev_unregister() path. You could insert LSM hooks into the
netlink_sendmsg() route and the del_device_store() route, but the cleanup_net()
route is a result of tear-down action which is too late to insert LSM hooks.

The NETDEV_UNREGISTER path can be triggered by just doing "unshare -n ip addr show"
(i.e. implicit cleanup of a network namespace due to termination of init process in
that namespace). We are not allowed to reject the cleanup_net() route.

----------
xfrm_dev_state_flush_secctx_check: LSM policy is rejecting this operation.
CPU: 0 UID: 0 PID: 16195 Comm: syz.3.3878 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/24/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 xfrm_dev_state_flush_secctx_check net/xfrm/xfrm_state.c:900 [inline]
 xfrm_dev_state_flush+0x5fa/0x740 net/xfrm/xfrm_state.c:971
 xfrm_dev_unregister net/xfrm/xfrm_device.c:549 [inline]
 xfrm_dev_event+0x1bc/0x3f0 net/xfrm/xfrm_device.c:570
 notifier_call_chain+0x1be/0x400 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2281 [inline]
 call_netdevice_notifiers net/core/dev.c:2295 [inline]
 netdev_wait_allrefs_any net/core/dev.c:11589 [inline]
 netdev_run_todo+0x778/0x1130 net/core/dev.c:11710
 nsim_destroy+0x3ae/0x680 drivers/net/netdevsim/netdev.c:1190
 __nsim_dev_port_del+0x14d/0x1b0 drivers/net/netdevsim/dev.c:1529
 nsim_dev_port_del_all drivers/net/netdevsim/dev.c:1541 [inline]
 nsim_dev_reload_destroy+0x288/0x490 drivers/net/netdevsim/dev.c:1765
 nsim_dev_reload_down+0x8a/0xc0 drivers/net/netdevsim/dev.c:1039
 devlink_reload+0x1d1/0x8e0 net/devlink/dev.c:461
 devlink_nl_reload_doit+0xaaa/0xc80 net/devlink/dev.c:584
 genl_family_rcv_msg_doit+0x22a/0x330 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x61c/0x7a0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x232/0x4b0 net/netlink/af_netlink.c:2550
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
 netlink_unicast+0x80f/0x9b0 net/netlink/af_netlink.c:1344
 netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1894
 sock_sendmsg_nosec+0x18f/0x1d0 net/socket.c:737
 __sock_sendmsg net/socket.c:752 [inline]
 ____sys_sendmsg+0x589/0x8c0 net/socket.c:2610
 ___sys_sendmsg+0x2a5/0x360 net/socket.c:2664
 __sys_sendmsg net/socket.c:2696 [inline]
 __do_sys_sendmsg net/socket.c:2701 [inline]
 __se_sys_sendmsg net/socket.c:2699 [inline]
 __x64_sys_sendmsg+0x1bd/0x2a0 net/socket.c:2699
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7feb10f9aeb9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007feb11efc028 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007feb11215fa0 RCX: 00007feb10f9aeb9
RDX: 0000000006048800 RSI: 0000200000000080 RDI: 0000000000000005
RBP: 00007feb11008c1f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007feb11216038 R14: 00007feb11215fa0 R15: 00007ffdd0b07b18
 </TASK>
----------

----------
xfrm_dev_state_flush_secctx_check: LSM policy is rejecting this operation.
CPU: 1 UID: 0 PID: 11340 Comm: kworker/u8:17 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/24/2026
Workqueue: netns cleanup_net
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 xfrm_dev_state_flush_secctx_check net/xfrm/xfrm_state.c:900 [inline]
 xfrm_dev_state_flush+0x5fa/0x740 net/xfrm/xfrm_state.c:971
 xfrm_dev_unregister net/xfrm/xfrm_device.c:549 [inline]
 xfrm_dev_event+0x1bc/0x3f0 net/xfrm/xfrm_device.c:570
 notifier_call_chain+0x1be/0x400 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2281 [inline]
 call_netdevice_notifiers net/core/dev.c:2295 [inline]
 netdev_wait_allrefs_any net/core/dev.c:11589 [inline]
 netdev_run_todo+0x778/0x1130 net/core/dev.c:11710
 nsim_destroy+0x3ae/0x680 drivers/net/netdevsim/netdev.c:1190
 __nsim_dev_port_del+0x14d/0x1b0 drivers/net/netdevsim/dev.c:1529
 nsim_dev_port_del_all drivers/net/netdevsim/dev.c:1541 [inline]
 nsim_dev_reload_destroy+0x288/0x490 drivers/net/netdevsim/dev.c:1765
 nsim_dev_reload_down+0x8a/0xc0 drivers/net/netdevsim/dev.c:1039
 devlink_reload+0x1d1/0x8e0 net/devlink/dev.c:461
 devlink_pernet_pre_exit+0x1e6/0x3f0 net/devlink/core.c:509
 ops_pre_exit_list net/core/net_namespace.c:161 [inline]
 ops_undo_list+0x187/0x940 net/core/net_namespace.c:234
 cleanup_net+0x4df/0x7b0 net/core/net_namespace.c:696
 process_one_work+0x949/0x1650 kernel/workqueue.c:3279
 process_scheduled_works kernel/workqueue.c:3362 [inline]
 worker_thread+0xb46/0x1140 kernel/workqueue.c:3443
 kthread+0x388/0x470 kernel/kthread.c:467
 ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
----------

----------
xfrm_dev_state_flush_secctx_check: LSM policy is rejecting this operation.
CPU: 0 UID: 0 PID: 18368 Comm: syz-executor Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/24/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 xfrm_dev_state_flush_secctx_check net/xfrm/xfrm_state.c:900 [inline]
 xfrm_dev_state_flush+0x5fa/0x740 net/xfrm/xfrm_state.c:971
 xfrm_dev_unregister net/xfrm/xfrm_device.c:549 [inline]
 xfrm_dev_event+0x1bc/0x3f0 net/xfrm/xfrm_device.c:570
 notifier_call_chain+0x1be/0x400 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2281 [inline]
 call_netdevice_notifiers net/core/dev.c:2295 [inline]
 netdev_wait_allrefs_any net/core/dev.c:11589 [inline]
 netdev_run_todo+0x778/0x1130 net/core/dev.c:11710
 nsim_destroy+0x3ae/0x680 drivers/net/netdevsim/netdev.c:1190
 __nsim_dev_port_del+0x14d/0x1b0 drivers/net/netdevsim/dev.c:1529
 nsim_dev_port_del_all drivers/net/netdevsim/dev.c:1541 [inline]
 nsim_dev_reload_destroy+0x288/0x490 drivers/net/netdevsim/dev.c:1765
 nsim_drv_remove+0x58/0x170 drivers/net/netdevsim/dev.c:1780
 device_remove drivers/base/dd.c:571 [inline]
 __device_release_driver drivers/base/dd.c:1284 [inline]
 device_release_driver_internal+0x46f/0x860 drivers/base/dd.c:1307
 bus_remove_device+0x34d/0x440 drivers/base/bus.c:616
 device_del+0x527/0x8f0 drivers/base/core.c:3878
 device_unregister+0x21/0xf0 drivers/base/core.c:3919
 nsim_bus_dev_del drivers/net/netdevsim/bus.c:491 [inline]
 del_device_store+0x2b0/0x370 drivers/net/netdevsim/bus.c:244
 kernfs_fop_write_iter+0x3af/0x540 fs/kernfs/file.c:352
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x61d/0xb90 fs/read_write.c:688
 ksys_write+0x150/0x270 fs/read_write.c:740
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd13375b78e
Code: 08 0f 85 a5 a8 ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3> 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 80 00 00 00 00 48 83 ec 08
RSP: 002b:00007ffc52b936a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000555567157500 RCX: 00007fd13375b78e
RDX: 0000000000000001 RSI: 00007ffc52b93730 RDI: 0000000000000005
RBP: 00007fd133808a88 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffc52b93730 R14: 00007fd134544620 R15: 0000000000000003
 </TASK>
----------



> 
>> For example, we don't check permission for unmount when a mount is deleted
>> due to teardown of a mount namespace. I wonder why you want to check permission
>> for unregistering a net_device when triggered by a teardown path.
> 
> I just try to find out what's the right thing to do here.
> If a policy goes away, packets that match this policy will
> find another path through the network stack. As best, they
> are dropped somewhere, but they can also leave on some other
> device without encryption. A LSM that implements xfrm hooks
> must be able to check the permission to delete the xfrm policy
> or state.

Do you mean that calling xfrm_dev_down()/xfrm_dev_unregister() might
result in network traffic to be sent in cleartext ?

If yes, we need to consider updating the other patch at
https://lkml.kernel.org/r/20260202123655.GK34749@unreal to replace
the NETDEV_UNREGISTER net_device with the blackhole_netdev. (That is,
xfrm_dev_{state,policy}_flush() does not actually delete a state/policy
but instead updates that state/policy to behave as a blackhole. Then,
we won't need to call LSM hooks because we no longer delete).

Also, we need to consider changing xfrm_dev_down() to no-op, for just doing
e.g. "ip link set ens160 down; ip link set ens160 up" (which triggers
NETDEV_DOWN event and NETDEV_UP event) might result in network traffic
to be sent in cleartext because currently xfrm_dev_down() can delete a
state/policy. Such behavior might not what the administrator is expecting.



> 
>>
>>>
>>> The same happened btw. when xfrm was made per network namespace.
>>> Here we just leak the xfrm states and xfrm policies if some
>>> LSM refuses to remove them.
>>>
>>> I guess we need a solution for both cases.
>>
>> Is replacing the NETDEV_UNREGISTER net_device with the blackhole_netdev applicable
>> ( https://elixir.bootlin.com/linux/v6.19-rc5/source/net/xfrm/xfrm_policy.c#L3948 ) ?
>> If no, there is no choice but break SELinux's expectation.
> 
> That could be an option to not accidentally send out
> unencrypted packets. But finding the right place for
> these checks would be preferable IMO.

Can we have such giant lock if you found the right place for these checks
( https://lkml.kernel.org/r/f9b88268-03dc-4356-8b31-0bab73cc9b1e@I-love.SAKURA.ne.jp ) ?

