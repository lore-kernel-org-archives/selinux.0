Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vATKNslV016181
 for <selinux@tycho.nsa.gov>; Wed, 29 Nov 2017 15:23:59 -0500
Received: by mail-wm0-f50.google.com with SMTP id f140so8402848wmd.2
 for <selinux@tycho.nsa.gov>; Wed, 29 Nov 2017 12:23:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1511985547.10464.22.camel@tycho.nsa.gov>
References: <alpine.LFD.2.20.1711292113350.7808@localhost>
 <1511976706.10464.19.camel@tycho.nsa.gov>
 <CANn89iJc=tZkN41WoCm5Zy9nPfs1tfZf9nuSXYS9EB_aem+y4g@mail.gmail.com>
 <1511985547.10464.22.camel@tycho.nsa.gov>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 29 Nov 2017 12:23:48 -0800
Message-ID: <CANn89iK23gDN_ma3MyybzgDkBr_A7R-MPfAG3dS_f7ehpiJtJQ@mail.gmail.com>
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

On Wed, Nov 29, 2017 at 11:59 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Wed, 2017-11-29 at 09:34 -0800, Eric Dumazet wrote:
>> On Wed, Nov 29, 2017 at 9:31 AM, Stephen Smalley <sds@tycho.nsa.gov>
>> wrote:
>> > On Wed, 2017-11-29 at 21:26 +1100, James Morris wrote:
>> > > I'm seeing a kernel stack corruption bug (detected via gcc) when
>> > > running
>> > > the SELinux testsuite on a 4.15-rc1 kernel, in the 2nd
>> > > inet_socket
>> > > test:
>> > >
>> > > https://github.com/SELinuxProject/selinux-testsuite/blob/master/t
>> > > ests
>> > > /inet_socket/test
>> > >
>> > >   # Verify that unauthorized client cannot communicate with the
>> > > server.
>> > >   $result = system
>> > >   "runcon -t test_inet_bad_client_t -- $basedir/client stream
>> > > 127.0.0.1 65535 2>&1";
>> > >
>> > > This correctlly causes an access control error in the Netlabel
>> > > code,
>> > > and
>> > > the bug seems to be triggered during the ICMP send:
>> > >
>> > > [  339.806024] SELinux: failure in selinux_parse_skb(), unable to
>> > > parse packet
>> > > [  339.822505] Kernel panic - not syncing: stack-protector:
>> > > Kernel
>> > > stack is corrupted in: ffffffff81745af5
>> > > [  339.822505]
>> > > [  339.852250] CPU: 4 PID: 3642 Comm: client Not tainted 4.15.0-
>> > > rc1-
>> > > test #15
>> > > [  339.868498] Hardware name: LENOVO 10FGS0VA1L/30BC, BIOS
>> > > FWKT68A   01/19/2017
>> > > [  339.885060] Call Trace:
>> > > [  339.896875]  <IRQ>
>> > > [  339.908103]  dump_stack+0x63/0x87
>> > > [  339.920645]  panic+0xe8/0x248
>> > > [  339.932668]  ? ip_push_pending_frames+0x33/0x40
>> > > [  339.946328]  ? icmp_send+0x525/0x530
>> > > [  339.958861]  ? kfree_skbmem+0x60/0x70
>> > > [  339.971431]  __stack_chk_fail+0x1b/0x20
>> > > [  339.984049]  icmp_send+0x525/0x530
>> > > [  339.996205]  ? netlbl_skbuff_err+0x36/0x40
>> > > [  340.008997]  ? selinux_netlbl_err+0x11/0x20
>> > > [  340.021816]  ? selinux_socket_sock_rcv_skb+0x211/0x230
>> > > [  340.035529]  ? security_sock_rcv_skb+0x3b/0x50
>> > > [  340.048471]  ? sk_filter_trim_cap+0x44/0x1c0
>> > > [  340.061246]  ? tcp_v4_inbound_md5_hash+0x69/0x1b0
>> > > [  340.074562]  ? tcp_filter+0x2c/0x40
>> > > [  340.086400]  ? tcp_v4_rcv+0x820/0xa20
>> > > [  340.098329]  ? ip_local_deliver_finish+0x71/0x1a0
>> > > [  340.111279]  ? ip_local_deliver+0x6f/0xe0
>> > > [  340.123535]  ? ip_rcv_finish+0x3a0/0x3a0
>> > > [  340.135523]  ? ip_rcv_finish+0xdb/0x3a0
>> > > [  340.147442]  ? ip_rcv+0x27c/0x3c0
>> > > [  340.158668]  ? inet_del_offload+0x40/0x40
>> > > [  340.170580]  ? __netif_receive_skb_core+0x4ac/0x900
>> > > [  340.183285]  ? rcu_accelerate_cbs+0x5b/0x80
>> > > [  340.195282]  ? __netif_receive_skb+0x18/0x60
>> > > [  340.207288]  ? process_backlog+0x95/0x140
>> > > [  340.218948]  ? net_rx_action+0x26c/0x3b0
>> > > [  340.230416]  ? __do_softirq+0xc9/0x26a
>> > > [  340.241625]  ? do_softirq_own_stack+0x2a/0x40
>> > > [  340.253368]  </IRQ>
>> > > [  340.262673]  ? do_softirq+0x50/0x60
>> > > [  340.273450]  ? __local_bh_enable_ip+0x57/0x60
>> > > [  340.285045]  ? ip_finish_output2+0x175/0x350
>> > > [  340.296403]  ? ip_finish_output+0x127/0x1d0
>> > > [  340.307665]  ? nf_hook_slow+0x3c/0xb0
>> > > [  340.318230]  ? ip_output+0x72/0xe0
>> > > [  340.328524]  ? ip_fragment.constprop.54+0x80/0x80
>> > > [  340.340070]  ? ip_local_out+0x35/0x40
>> > > [  340.350497]  ? ip_queue_xmit+0x15c/0x3f0
>> > > [  340.361060]  ? __kmalloc_reserve.isra.40+0x31/0x90
>> > > [  340.372484]  ? __skb_clone+0x2e/0x130
>> > > [  340.382633]  ? tcp_transmit_skb+0x558/0xa10
>> > > [  340.393262]  ? tcp_connect+0x938/0xad0
>> > > [  340.403370]  ? ktime_get_with_offset+0x4c/0xb0
>> > > [  340.414206]  ? tcp_v4_connect+0x457/0x4e0
>> > > [  340.424471]  ? __inet_stream_connect+0xb3/0x300
>> > > [  340.435195]  ? inet_stream_connect+0x3b/0x60
>> > > [  340.445607]  ? SYSC_connect+0xd9/0x110
>> > > [  340.455455]  ? __audit_syscall_entry+0xaf/0x100
>> > > [  340.466112]  ? syscall_trace_enter+0x1d0/0x2b0
>> > > [  340.476636]  ? __audit_syscall_exit+0x209/0x290
>> > > [  340.487151]  ? SyS_connect+0xe/0x10
>> > > [  340.496453]  ? do_syscall_64+0x67/0x1b0
>> > > [  340.506078]  ? entry_SYSCALL64_slow_path+0x25/0x25
>> > > [  340.516693] Kernel Offset: disabled
>> > > [  340.526393] Rebooting in 11 seconds..
>> > >
>> > > This is mostly reliable, and I'm only seeing it on bare metal
>> > > (not in
>> > > a
>> > > virtualbox vm).
>> > >
>> > > The SELinux skb parse error at the start only sometimes appears,
>> > > and
>> > > looking at the code, I suspect some kind of memory corruption
>> > > being
>> > > the
>> > > cause at that point (basic packet header checks).
>> > >
>> > > I bisected the bug down to the following change:
>> > >
>> > > commit bffa72cf7f9df842f0016ba03586039296b4caaf
>> > > Author: Eric Dumazet <edumazet@google.com>
>> > > Date:   Tue Sep 19 05:14:24 2017 -0700
>> > >
>> > >     net: sk_buff rbnode reorg
>> > >     ...
>> > >
>> > >
>> > > Anyone else able to reproduce this, or have any ideas on what's
>> > > happening?
>> >
>> > So far I haven't been able to reproduce with 4.15-rc1 or -linus.
>> >
>>
>> You might try adding KASAN in the picture ? ( CONFIG_KASAN=y )
>
> Good idea:
>
> ==================================================================
>  BUG:
> KASAN: stack-out-of-bounds in __ip_options_echo+0x430/0x5e0
>  Write of
> size 44 at addr ffff8803bc1c7560 by task ksoftirqd/1/16
>
>  CPU: 1 PID: 16
> Comm: ksoftirqd/1 Not tainted 4.15.0-rc1 #27
>  Hardware name: Dell Inc.
> Latitude E7470/0VNKRJ, BIOS 1.16.4 06/02/2017
>  Call Trace:
>
> dump_stack+0x5c/0x7c
>   print_address_description+0x6a/0x280
>
> kasan_report+0x254/0x370
>   ? __ip_options_echo+0x430/0x5e0
>
> memcpy+0x34/0x50
>   __ip_options_echo+0x430/0x5e0
>   icmp_send+0x48d/0x7a0
>
> ? icmpv4_global_allow+0x50/0x50
>   ?
> selinux_netlbl_sk_security_reset+0x20/0x20
>   ? avc_has_perm+0x238/0x260
>
> ? avc_has_perm_noaudit+0x1d0/0x1d0
>   ? selinux_peerlbl_enabled+0x50/0x50
>   ? deref_stack_reg+0xd0/0xd0
>   ? __save_stack_trace+0x82/0x100
>
> selinux_socket_sock_rcv_skb+0x341/0x350
>   ?
> selinux_sock_rcv_skb_compat+0x200/0x200
>   ? depot_save_stack+0x12f/0x460
>   ? pskb_expand_head+0x9d/0x4d0
>   ? save_stack+0x92/0xa0
>   ?
> kasan_kmalloc+0xa0/0xd0
>   ? __kmalloc_node_track_caller+0xf5/0x290
>   ?
> skb_copy_and_csum_dev+0x142/0x180
>   ? ip_rcv_finish+0x323/0x690
>   ?
> __netif_receive_skb_core+0xe16/0x13d0
>   ? process_backlog+0x10a/0x280
>   ?
> net_rx_action+0x3ec/0x5a0
>   ? __do_softirq+0x13f/0x36d
>   ?
> __wake_up_common_lock+0xd7/0x130
>   ? tcp_md5_do_lookup+0x27/0x240
>
> security_sock_rcv_skb+0x47/0x60
>   sk_filter_trim_cap+0x45/0x4b0
>   ?
> tcp4_proc_exit+0x11/0x11
>   tcp_filter+0x5b/0x90
>
> tcp_v4_rcv+0x108a/0x1360
>   ip_local_deliver_finish+0xf7/0x300
>
> ip_local_deliver+0xf2/0x1a0
>   ? ip_call_ra_chain+0x220/0x220
>   ?
> ip_rcv_finish+0x690/0x690
>   ? ip_rcv_finish+0x1b9/0x690
>
> ip_rcv+0x4a6/0x660
>   ? ip_local_deliver+0x1a0/0x1a0
>   ?
> inet_del_offload+0x40/0x40
>   ? cpumask_next_and+0x4e/0x70
>   ?
> ip_local_deliver+0x1a0/0x1a0
>   __netif_receive_skb_core+0xe16/0x13d0
>   ?
> netdev_info+0x100/0x100
>   ? __accumulate_pelt_segments+0x47/0xd0
>   ?
> find_busiest_group+0x1100/0x1100
>   ?
> __update_load_avg_se.isra.31+0x34e/0x360
>   ?
> __update_load_avg_se.isra.31+0x201/0x360
>   ?
> __accumulate_pelt_segments+0x47/0xd0
>   ? process_backlog+0x10a/0x280
>
> process_backlog+0x10a/0x280
>   net_rx_action+0x3ec/0x5a0
>   ?
> napi_complete_done+0x180/0x180
>   ? __schedule+0x4e0/0xd50
>   ?
> sched_clock_cpu+0x14/0xe0
>   __do_softirq+0x13f/0x36d
>   ?
> takeover_tasklets+0x2b0/0x2b0
>   run_ksoftirqd+0x25/0x40
>
> smpboot_thread_fn+0x212/0x2b0
>   ? sort_range+0x20/0x20
>   ?
> schedule+0x50/0xc0
>   kthread+0x174/0x1c0
>   ? sort_range+0x20/0x20
>   ?
> kthread_create_worker_on_cpu+0xc0/0xc0
>   ret_from_fork+0x1f/0x30
>
>  The
> buggy address belongs to the page:
>  page:ffffea000ef071c0 count:0
> mapcount:0 mapping:          (null) index:0x0
>  flags: 0x17ffffc0000000()
>  raw: 0017ffffc0000000 0000000000000000 0000000000000000
> 00000000ffffffff
>  raw: ffffea000ef071e0 ffffea000ef071e0
> 0000000000000000 0000000000000000
>  page dumped because: kasan: bad
> access detected
>
>  Memory state around the buggy address:
>
> ffff8803bc1c7480: 00 00 00 f2 f2 f2 f2 00 00 00 00 00 00 00 f4 f2
>
> ffff8803bc1c7500: f2 f2 f2 00 00 00 00 00 00 00 00 00 00 00 00 00
>
>>ffff8803bc1c7580: 00 f4 f4 00 00 00 00 00 00 00 00 00 00 00 00 00
>
>                  ^
>   ffff8803bc1c7600: 00 00 f1 f1 f1 f1 04 f4 f4 f4 f2
> f2 f2 f2 00 f4
>   ffff8803bc1c7680: f4 f4 f2 f2 f2 f2 00 00 00 00 f2 f2
> f2 f2 00 00
>
> ==================================================================
>
> Disabling lock debugging due to kernel taint
>  SELinux: failure in
> selinux_parse_skb(), unable to parse packet

I suspect this exposes an ancient bug, caused by fact that TCP moves
IP[6]CB in skb->cb[]

Basically the 2nd tcp_filter() added in commit
8fac365f63c866a00015fa13932d8ffc584518b8
("tcp: Add a tcp_filter hook before handle ack packet") was not
expecting selinux code being called a 2nd time,
while skb->cb[] has been mangled [1]

[1]
memmove(&TCP_SKB_CB(skb)->header.h4, IPCB(skb),
    sizeof(struct inet_skb_parm));
