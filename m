Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vATHYcIj010926
 for <selinux@tycho.nsa.gov>; Wed, 29 Nov 2017 12:34:38 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC05.oob.disa.mil (Postfix) with SMTP id 3yn72K2RCkzrKkT
 for <selinux@tycho.nsa.gov>; Wed, 29 Nov 2017 17:34:33 +0000 (UTC)
Received: from UPDC3CPA05.eemsg.mil (unknown [192.168.18.12])
 by UPDCF3IC05.oob.disa.mil (Postfix) with ESMTP id 3yn72K1dyGzrKkP
 for <selinux@tycho.nsa.gov>; Wed, 29 Nov 2017 17:34:33 +0000 (UTC)
Received: by mail-wm0-f54.google.com with SMTP id r78so7946844wme.5
 for <selinux@tycho.nsa.gov>; Wed, 29 Nov 2017 09:34:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1511976706.10464.19.camel@tycho.nsa.gov>
References: <alpine.LFD.2.20.1711292113350.7808@localhost>
 <1511976706.10464.19.camel@tycho.nsa.gov>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 29 Nov 2017 09:34:30 -0800
Message-ID: <CANn89iJc=tZkN41WoCm5Zy9nPfs1tfZf9nuSXYS9EB_aem+y4g@mail.gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: James Morris <james.l.morris@oracle.com>, Paul Moore <paul@paul-moore.com>,
 netdev <netdev@vger.kernel.org>, selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [BUG] kernel stack corruption during/after Netlabel
 error
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Nov 29, 2017 at 9:31 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Wed, 2017-11-29 at 21:26 +1100, James Morris wrote:
>> I'm seeing a kernel stack corruption bug (detected via gcc) when
>> running
>> the SELinux testsuite on a 4.15-rc1 kernel, in the 2nd inet_socket
>> test:
>>
>> https://github.com/SELinuxProject/selinux-testsuite/blob/master/tests
>> /inet_socket/test
>>
>>   # Verify that unauthorized client cannot communicate with the
>> server.
>>   $result = system
>>   "runcon -t test_inet_bad_client_t -- $basedir/client stream
>> 127.0.0.1 65535 2>&1";
>>
>> This correctlly causes an access control error in the Netlabel code,
>> and
>> the bug seems to be triggered during the ICMP send:
>>
>> [  339.806024] SELinux: failure in selinux_parse_skb(), unable to
>> parse packet
>> [  339.822505] Kernel panic - not syncing: stack-protector: Kernel
>> stack is corrupted in: ffffffff81745af5
>> [  339.822505]
>> [  339.852250] CPU: 4 PID: 3642 Comm: client Not tainted 4.15.0-rc1-
>> test #15
>> [  339.868498] Hardware name: LENOVO 10FGS0VA1L/30BC, BIOS
>> FWKT68A   01/19/2017
>> [  339.885060] Call Trace:
>> [  339.896875]  <IRQ>
>> [  339.908103]  dump_stack+0x63/0x87
>> [  339.920645]  panic+0xe8/0x248
>> [  339.932668]  ? ip_push_pending_frames+0x33/0x40
>> [  339.946328]  ? icmp_send+0x525/0x530
>> [  339.958861]  ? kfree_skbmem+0x60/0x70
>> [  339.971431]  __stack_chk_fail+0x1b/0x20
>> [  339.984049]  icmp_send+0x525/0x530
>> [  339.996205]  ? netlbl_skbuff_err+0x36/0x40
>> [  340.008997]  ? selinux_netlbl_err+0x11/0x20
>> [  340.021816]  ? selinux_socket_sock_rcv_skb+0x211/0x230
>> [  340.035529]  ? security_sock_rcv_skb+0x3b/0x50
>> [  340.048471]  ? sk_filter_trim_cap+0x44/0x1c0
>> [  340.061246]  ? tcp_v4_inbound_md5_hash+0x69/0x1b0
>> [  340.074562]  ? tcp_filter+0x2c/0x40
>> [  340.086400]  ? tcp_v4_rcv+0x820/0xa20
>> [  340.098329]  ? ip_local_deliver_finish+0x71/0x1a0
>> [  340.111279]  ? ip_local_deliver+0x6f/0xe0
>> [  340.123535]  ? ip_rcv_finish+0x3a0/0x3a0
>> [  340.135523]  ? ip_rcv_finish+0xdb/0x3a0
>> [  340.147442]  ? ip_rcv+0x27c/0x3c0
>> [  340.158668]  ? inet_del_offload+0x40/0x40
>> [  340.170580]  ? __netif_receive_skb_core+0x4ac/0x900
>> [  340.183285]  ? rcu_accelerate_cbs+0x5b/0x80
>> [  340.195282]  ? __netif_receive_skb+0x18/0x60
>> [  340.207288]  ? process_backlog+0x95/0x140
>> [  340.218948]  ? net_rx_action+0x26c/0x3b0
>> [  340.230416]  ? __do_softirq+0xc9/0x26a
>> [  340.241625]  ? do_softirq_own_stack+0x2a/0x40
>> [  340.253368]  </IRQ>
>> [  340.262673]  ? do_softirq+0x50/0x60
>> [  340.273450]  ? __local_bh_enable_ip+0x57/0x60
>> [  340.285045]  ? ip_finish_output2+0x175/0x350
>> [  340.296403]  ? ip_finish_output+0x127/0x1d0
>> [  340.307665]  ? nf_hook_slow+0x3c/0xb0
>> [  340.318230]  ? ip_output+0x72/0xe0
>> [  340.328524]  ? ip_fragment.constprop.54+0x80/0x80
>> [  340.340070]  ? ip_local_out+0x35/0x40
>> [  340.350497]  ? ip_queue_xmit+0x15c/0x3f0
>> [  340.361060]  ? __kmalloc_reserve.isra.40+0x31/0x90
>> [  340.372484]  ? __skb_clone+0x2e/0x130
>> [  340.382633]  ? tcp_transmit_skb+0x558/0xa10
>> [  340.393262]  ? tcp_connect+0x938/0xad0
>> [  340.403370]  ? ktime_get_with_offset+0x4c/0xb0
>> [  340.414206]  ? tcp_v4_connect+0x457/0x4e0
>> [  340.424471]  ? __inet_stream_connect+0xb3/0x300
>> [  340.435195]  ? inet_stream_connect+0x3b/0x60
>> [  340.445607]  ? SYSC_connect+0xd9/0x110
>> [  340.455455]  ? __audit_syscall_entry+0xaf/0x100
>> [  340.466112]  ? syscall_trace_enter+0x1d0/0x2b0
>> [  340.476636]  ? __audit_syscall_exit+0x209/0x290
>> [  340.487151]  ? SyS_connect+0xe/0x10
>> [  340.496453]  ? do_syscall_64+0x67/0x1b0
>> [  340.506078]  ? entry_SYSCALL64_slow_path+0x25/0x25
>> [  340.516693] Kernel Offset: disabled
>> [  340.526393] Rebooting in 11 seconds..
>>
>> This is mostly reliable, and I'm only seeing it on bare metal (not in
>> a
>> virtualbox vm).
>>
>> The SELinux skb parse error at the start only sometimes appears, and
>> looking at the code, I suspect some kind of memory corruption being
>> the
>> cause at that point (basic packet header checks).
>>
>> I bisected the bug down to the following change:
>>
>> commit bffa72cf7f9df842f0016ba03586039296b4caaf
>> Author: Eric Dumazet <edumazet@google.com>
>> Date:   Tue Sep 19 05:14:24 2017 -0700
>>
>>     net: sk_buff rbnode reorg
>>     ...
>>
>>
>> Anyone else able to reproduce this, or have any ideas on what's
>> happening?
>
> So far I haven't been able to reproduce with 4.15-rc1 or -linus.
>

You might try adding KASAN in the picture ? ( CONFIG_KASAN=y )

Thanks.
