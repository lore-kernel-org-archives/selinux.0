Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q6VLcE6G023822
	for <selinux@tycho.nsa.gov>; Tue, 31 Jul 2012 17:38:14 -0400
Received: by ghbz13 with SMTP id z13so6746864ghb.12
        for <selinux@tycho.nsa.gov>; Tue, 31 Jul 2012 14:38:12 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Sam Gandhi <samgandhi9@gmail.com>
Cc: linux-security-module <linux-security-module@vger.kernel.org>,
        selinux@tycho.nsa.gov
Subject: Re: Consistent crash in selinux_ipv4_postroute?
Date: Tue, 31 Jul 2012 17:38:09 -0400
Message-ID: <1462896.os7DYYHbcz@sifl>
In-Reply-To: <CAOdLEaqaTsS8bFwytn5h-86J1=qoMzAyKr85PBqS1eS2KV=7Dw@mail.gmail.com>
References: <CAOdLEaqaTsS8bFwytn5h-86J1=qoMzAyKr85PBqS1eS2KV=7Dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday, July 31, 2012 01:44:12 PM Sam Gandhi wrote:
> I am running latest linux kernel (top of Linus's tree and I am getting
> following crash consistently.
> 
> I am wondering if anybody else is seen this crash with latest linux kernel?

NOTE: I've CC'd the SELinux list as this is tied to SELinux and not the LSM in 
general.

I haven't tried Linus' latest, my bleeding-edge system is suffering other 
problems at the moment, but I can take a look.  Is there any particular trick 
you use to reproduce the problem?  Also, what distribution and what SELinux 
policy are you using?  Since you are hitting postroute_compat() that means you 
don't have the netpeer policy capability enabled ...

Also, this looks like an ARM system, yes?  Have you been able to reproduce it 
on a x86[_64] based system?

Finally, it looks like the kernel has been tainted.  What non-standard modules 
are you loading and what were the previous kernel warnings?

> [   38.830000] Unable to handle kernel NULL pointer dereference at
> virtual address 00000000
> [   38.830000] pgd = c30d8000
> [   38.840000] [00000000] *pgd=43b21831, *pte=00000000, *ppte=00000000
> [   38.840000] Internal error: Oops: 17 [#1] ARM
> [   38.840000] Modules linked in:
> [   38.840000] CPU: 0    Tainted: G        W     (3.5.0-07610-gf206aa6-dirty
> #1) [   38.840000] PC is at selinux_ip_postroute_compat.clone.37+0xe4/0x128
> [   38.840000] LR is at selinux_ip_postroute_compat.clone.37+0x9c/0x128 [  
> 38.840000] pc : [<c01b308c>]    lr : [<c01b3044>]    psr: 60000013 [  
> 38.840000] sp : c30aba10  ip : 00000000  fp : c05229a4
> [   38.840000] r10: c031e0d8  r9 : c30abb4c  r8 : 00000000
> [   38.840000] r7 : 00000002  r6 : c3bf5540  r5 : c0522028  r4 : 00000000
> [   38.840000] r3 : c30aba44  r2 : 0000af02  r1 : c058789c  r0 : 00000000
> [   38.840000] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment
> user [   38.840000] Control: 0005317f  Table: 430d8000  DAC: 00000015
> [   38.840000] Process cat (pid: 1036, stack limit = 0xc30aa270)
> [   38.840000] Stack: (0xc30aba10 to 0xc30ac000)
> [   38.840000] ba00:                                     c30aba33
> 000005a8 000005a8 c02d9e02
> [   38.840000] ba20: c30aba34 c0330c8c c061e45c c30aba44 060ababc
> 00000002 00000000 01080002
> [   38.840000] ba40: 0000af02 fe89a8c0 0189a8c0 00000000 00000000
> 00000000 00000000 00000000
> [   38.840000] ba60: 00000000 9c3f6b2e c0522028 c3bf5540 00000002
> 00000000 c394f800 c01b3254
> [   38.840000] ba80: 00000001 f80c921d 00000014 00000003 06a2c000
> c3a346c0 00000000 00000001
> [   38.840000] baa0: c394f800 c061d83c 00000003 00000000 00000000
> 00000000 00000000 00000000
> [   38.840000] bac0: 00000000 00000000 00000000 00000000 00000000
> 00000000 00000000 9c3f6b2e
> [   38.840000] bae0: c053bc70 00000004 c3bf5540 00000000 c394f800
> c30abb4c c031e0d8 c03052d8
> [   38.840000] bb00: c031e0d8 c031d10c c052299c 00000014 00000004
> c3bf5540 00000000 c394f800
> [   38.840000] bb20: c30abb4c c031e0d8 00000002 c0305354 c394f800
> c30abb4c c031e0d8 80000000
> [   38.840000] bb40: c05229a4 c30abb5c c031d10c c053bc70 c052299c
> 00002d95 00000000 c3bf5540
> [   38.840000] bb60: c394f800 c0522028 0000af02 c05501cc c054e250
> c031f740 c394f800 c031e0d8
> [   38.840000] bb80: 80000000 c031eeec c394f800 c3bf5540 00000000
> c30abc88 00000000 c031ef24
> [   38.840000] bba0: c0550100 c0320064 0000af02 c05501cc c054e250
> c0550100 00000000 c032038c
> [   38.840000] bbc0: c031d184 c30abca4 00000014 00000000 00000040
> c035a714 00000000 00000108
> [   38.840000] bbe0: 00000002 00000001 00000000 00060000 00000000
> 0189a8c0 fe89a8c0 af020108
> [   38.840000] bc00: fe89a8c0 c0528348 00000000 00000100 00000000
> c03a0d1c c3a27448 00000000
> [   38.840000] bc20: 00000000 00000000 00000000 c03a0cd4 c3a2743c
> c002a750 c3bf56c0 a0000013
> [   38.840000] bc40: c3a273c0 c3bf56c0 c30aa008 c3a27404 c3bf56c0
> 9c3f6b2e 00000000 c054e250
> [   38.840000] bc60: c30abc88 c3bf56c0 00000000 c30abca4 0189a8c0
> 00000002 000002af c0338e04
> [   38.840000] bc80: c30abc88 00000014 c30abca4 00000014 00000000
> 00136b81 00000008 00000002
> [   38.840000] bca0: 00000000 0108af02 286629e9 00000000 00000450
> 00000000 c3bf56c0 c054e250
> [   38.840000] bcc0: c30cc524 00000000 c30cc510 c033bd40 00000002
> 000002af 00000002 c052298c
> [   38.840000] bce0: c3bf56c0 c3bf56c0 c03cbe50 00000000 c054e250
> c0523ab0 c3bf56c0 c0522450
> [   38.840000] bd00: c031a47c c031a1a0 c30cc510 c30abd5c c3bf56c0
> c052245c c394f800 c0319ed4
> [   38.840000] bd20: c394f800 000200da c052243c c30abd5c 00000008
> c052245c c394f800 c02e71d0
> [   38.840000] bd40: c30abd7c c01f023c c394f800 c30cc4e0 c30cc4e0
> c3bf56c0 000001a0 c052245c
> [   38.840000] bd60: c30cc000 c05541e0 c0554180 00000000 00000000
> 00000001 00200200 c0554194
> [   38.840000] bd80: 00100100 c02e74f4 c394fbe0 c3bf56c0 00000002
> c02e7464 c05541e0 00000040
> [   38.840000] bda0: 0000012c c0554180 c0554188 c0528348 ffff99fd
> c02e7878 00000001 c0554180
> [   38.840000] bdc0: 00000065 00000001 c057dc2c c30aa000 00000100
> c057dc20 c0529480 c057dc00
> [   38.840000] bde0: 0000000a c002521c c30abe6c b6f9af59 c30c2360
> 00000003 becccaa8 c30aa000
> [   38.840000] be00: 00000065 00000000 c30abe6c b6f9af59 c30c2360
> b6e34000 becccaa8 c0025648
> [   38.840000] be20: c053d144 c000fef0 c0016948 40000013 f5000000
> c000ec94 b6f9af59 00000000
> [   38.840000] be40: 00000028 40000013 00000017 c3a37380 c30aa000
> c30abfb0 b6f9af59 c30c2360
> [   38.840000] be60: b6e34000 becccaa8 beccca84 c30abe80 c00085f4
> c0016948 40000013 ffffffff
> [   38.840000] be80: c30cc370 c30abed4 c3bf5840 c052245c c394f800
> 00000028 00000000 00000000
> [   38.840000] bea0: c052243c c30abed4 00000008 c052245c c394f800
> c02e71d0 430d8000 c3a37380
> [   38.840000] bec0: c394f800 c30cc340 c30cc340 c3bf5840 000001a0
> c052245c c30cc000 c05541e0
> [   38.840000] bee0: c0554180 00000000 00000000 00000017 b6f9af59
> c30abfb0 00000007 c0526714
> [   38.840000] bf00: 00000000 b6e34000 becccaa8 c00085f4 09da3100
> c3a37380 c30abfac c039fbc8
> [   38.840000] bf20: ffff99fa c002a238 ffff99fb c02e7878 c30abf30
> c30c3440 00000065 00000001
> [   38.840000] bf40: c057dc24 c30aa000 00000100 c057dc20 c0529480
> c057dc00 00000001 c0025234
> [   38.840000] bf60: 0000002d 00021000 b6e35250 00000010 00000010
> c30aa000 00000065 00000000
> [   38.840000] bf80: 0000002d 60000093 60000093 b6dbf11c 00000010
> f5000000 b6f7f4e8 60000010
> [   38.840000] bfa0: ffffffff b6fa8e48 0000003c c000eddc beccc664
> 00000000 beccca84 00000000
> [   38.840000] bfc0: 0004a534 b6f9af59 becccc88 b6fa8e48 0000003c
> 00000000 b6e34000 becccaa8
> [   38.840000] bfe0: beccca84 beccc638 b6f7f4e8 b6f7f4e8 60000010
> ffffffff 00000000 00000000
> [   38.840000] [<c01b308c>]
> (selinux_ip_postroute_compat.clone.37+0xe4/0x128) from [<c01b3254>]
> (selinux_ipv4_postroute+0x184/0x24)
> [   38.840000] [<c01b3254>] (selinux_ipv4_postroute+0x184/0x248) from
> [<c03052d8>] (nf_iterate+0x8c/0xb4)
> [   38.840000] [<c03052d8>] (nf_iterate+0x8c/0xb4) from [<c0305354>]
> (nf_hook_slow+0x54/0xfc)
> [   38.840000] [<c0305354>] (nf_hook_slow+0x54/0xfc) from [<c031f740>]
> (ip_output+0xa0/0xcc)
> [   38.840000] [<c031f740>] (ip_output+0xa0/0xcc) from [<c031ef24>]
> (ip_local_out+0x28/0x2c)
> [   38.840000] [<c031ef24>] (ip_local_out+0x28/0x2c) from [<c0320064>]
> (ip_send_skb+0xc/0x64)
> [   38.840000] [<c0320064>] (ip_send_skb+0xc/0x64) from [<c032038c>]
> (ip_send_unicast_reply+0x1d8/0x22c)
> [   38.840000] [<c032038c>] (ip_send_unicast_reply+0x1d8/0x22c) from
> [<c0338e04>] (tcp_v4_send_reset+0x124/0x1c8)
> [   38.840000] [<c0338e04>] (tcp_v4_send_reset+0x124/0x1c8) from
> [<c033bd40>] (tcp_v4_rcv+0x23c/0x890)
> [   38.840000] [<c033bd40>] (tcp_v4_rcv+0x23c/0x890) from [<c031a1a0>]
> (ip_local_deliver_finish+0xf4/0x21c)
> [   38.840000] [<c031a1a0>] (ip_local_deliver_finish+0xf4/0x21c) from
> [<c0319ed4>] (ip_rcv_finish+0xe4/0x2bc)
> [   38.840000] [<c0319ed4>] (ip_rcv_finish+0xe4/0x2bc) from
> [<c02e71d0>] (__netif_receive_skb+0x250/0x4e4)
> [   38.840000] [<c02e71d0>] (__netif_receive_skb+0x250/0x4e4) from
> [<c02e74f4>] (process_backlog+0x90/0x158)
> [   38.840000] [<c02e74f4>] (process_backlog+0x90/0x158) from
> [<c02e7878>] (net_rx_action+0xb0/0x188)
> [   38.840000] [<c02e7878>] (net_rx_action+0xb0/0x188) from
> [<c002521c>] (__do_softirq+0x90/0x120)
> [   38.840000] [<c002521c>] (__do_softirq+0x90/0x120) from
> [<c0025648>] (irq_exit+0x7c/0x84)
> [   38.840000] [<c0025648>] (irq_exit+0x7c/0x84) from [<c000fef0>]
> (handle_IRQ+0x34/0x84)
> [   38.840000] [<c000fef0>] (handle_IRQ+0x34/0x84) from [<c000ec94>]
> (__irq_svc+0x34/0x60)
> [   38.840000] [<c000ec94>] (__irq_svc+0x34/0x60) from [<c0016948>]
> (do_page_fault+0x54/0x384)
> [   38.840000] [<c0016948>] (do_page_fault+0x54/0x384) from
> [<c00085f4>] (do_DataAbort+0x30/0x9c)
> [   38.840000] [<c00085f4>] (do_DataAbort+0x30/0x9c) from [<c000eddc>]
> (__dabt_usr+0x3c/0x40)
> [   38.840000] Exception stack(0xc30abfb0 to 0xc30abff8)
> [   38.840000] bfa0:                                     beccc664
> 00000000 beccca84 00000000
> [   38.840000] bfc0: 0004a534 b6f9af59 becccc88 b6fa8e48 0000003c
> 00000000 b6e34000 becccaa8
> [   38.840000] bfe0: beccca84 beccc638 b6f7f4e8 b6f7f4e8 60000010 ffffffff
> [   38.840000] Code: ebffe434 e1500004 13a0086f 1a000007 (e5980000)
> [   39.540000] ---[ end trace 95db0a9297cfee82 ]---
> [   39.540000] Kernel panic - not syncing: Fatal exception in interrupt
> --
> To unsubscribe from this list: send the line "unsubscribe
> linux-security-module" in the body of a message to
> majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
paul moore
www.paul-moore.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
