Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p1P4H3fE006023
	for <selinux@tycho.nsa.gov>; Thu, 24 Feb 2011 23:17:03 -0500
Received: from mail-iw0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p1P4H2bV005093
	for <selinux@tycho.nsa.gov>; Fri, 25 Feb 2011 04:17:03 GMT
Received: by iwn2 with SMTP id 2so843592iwn.12
        for <selinux@tycho.nsa.gov>; Thu, 24 Feb 2011 20:17:02 -0800 (PST)
Cc: SE-Linux <selinux@tycho.nsa.gov>
Message-Id: <6B9F1A84-0F3A-471B-AA76-A9165EED82C1@gmail.com>
From: Justin Mattock <justinmattock@gmail.com>
To: "cto@itechfrontiers.com" <cto@itechfrontiers.com>
In-Reply-To: <4D66E0F0.4050207@itechfrontiers.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: RIP: 0010:[<ffffffff811bdec1>] [<ffffffff811bdec1>] avc_audit_post_callback+0xc6/0xfe
Date: Thu, 24 Feb 2011 20:16:59 -0800
References: <AANLkTi=UYvBV9piRpUapcf+6gFyJpOg8yAxt0NG9J_Re@mail.gmail.com> <4D66E0F0.4050207@itechfrontiers.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Feb 24, 2011, at 2:51 PM, cto@itechfrontiers.com wrote:

> Justin,
>
> What Linux Distro have you installed on your MacBookPro2?
>
> it seems, you are not using your standard kernel shipped with your  
> Linux distribution; if you customized it, what have you added/ 
> modified?
>
>
> Patrick K.

it's a custom clfs system..nothing was modified to the policy and/or  
kernel.. as for the packages
everything is compiled/built to the instructions as much as  
possible(no tweeks)

>
> On 2/24/2011 3:57 PM, Justin Mattock wrote:
>> this just popped up..:
>>
>>
>> [29804.908327] SELinux:  Invalid class 3588
>> [29804.908438] ------------[ cut here ]------------
>> [29804.908443] kernel BUG at security/selinux/avc.c:162!
>> [29804.908447] invalid opcode: 0000 [#1] SMP
>> [29804.908451] last sysfs file: /sys/devices/platform/applesmc.768/ 
>> light
>> [29804.908455] CPU 0
>> [29804.908457] Modules linked in: hidp xfrm4_mode_transport xcbc
>> rmd160 sha512_generic rfcomm sco bnep l2cap ipt_REJECT xt_tcpudp
>> ipt_LOG iptable_nat nf_nat xt_state nf_conntrack_ftp  
>> nf_conntrack_ipv4
>> nf_conntrack nf_defrag_ipv4 iptable_filter ip_tables x_tables btusb
>> bluetooth evdev psmouse thermal fan container button ac battery video
>> ath9k ath9k_common ath9k_hw ath ttm drm aes_x86_64 lzo zlib ipcomp
>> xfrm_ipcomp crypto_null sha256_generic cbc des_generic cast5 blowfish
>> serpent camellia twofish_generic twofish_x86_64 twofish_common ctr  
>> ah4
>> esp4 authenc firewire_ohci firewire_core uhci_hcd ehci_hcd coretemp
>> acpi_cpufreq processor mperf appletouch applesmc
>> [29804.908540]
>> [29804.908544] Pid: 5404, comm: git Not tainted
>> 2.6.38-rc5-00101-gebad2c2 #2 Apple Computer, Inc.
>> MacBookPro2,2/Mac-F42187C8
>> [29804.908553] RIP: 0010:[<ffffffff811bdec1>]  [<ffffffff811bdec1>]
>> avc_audit_post_callback+0xc6/0xfe
>> [29804.908565] RSP: 0018:ffff880022e01b48  EFLAGS: 00010202
>> [29804.908569] RAX: 40000000000000c1 RBX: ffff88003d56d330 RCX:  
>> ffff880000000018
>> [29804.908573] RDX: 00000000001e0018 RSI: ffff8800236d4480 RDI:  
>> 0000000000000286
>> [29804.908577] RBP: ffff880022e01b78 R08: ffff88003d402700 R09:  
>> ffff8800236d4440
>> [29804.908581] R10: ffffea0000000008 R11: ffffea00007bfe60 R12:  
>> 0000000000000e04
>> [29804.908585] R13: 00000000be0e08bf R14: 0000000000000109 R15:  
>> ffff880022e01db8
>> [29804.908590] FS:  00007fb829a25700(0000) GS:ffff88003ee00000(0000)
>> knlGS:0000000000000000
>> [29804.908594] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
>> [29804.908598] CR2: 000000000046aca0 CR3: 0000000036d9f000 CR4:  
>> 00000000000006f0
>> [29804.908602] DR0: 0000000000000000 DR1: 0000000000000000 DR2:  
>> 0000000000000000
>> [29804.908606] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7:  
>> 0000000000000400
>> [29804.908610] Process git (pid: 5404, threadinfo ffff880022e00000,
>> task ffff88000c686f90)
>> [29804.908613] Stack:
>> [29804.908616]  ffff8800236d4440 0000002181099d5e ffff88003d56d330
>> ffff880022e01db8
>> [29804.908623]  ffff8800008d4588 0000000000000e04 ffff880022e01bd8
>> ffffffff811d3f77
>> [29804.908630]  ffff880022e01cb8 00000000000001b5 0000000000000e04
>> 0000000000000109
>> [29804.908637] Call Trace:
>> [29804.908644]  [<ffffffff811d3f77>] common_lsm_audit+0x62b/0x642
>> [29804.908649]  [<ffffffff811bdcf1>] avc_audit+0xa3/0xad
>> [29804.908654]  [<ffffffff811be182>] ? avc_has_perm_noaudit+0x21f/ 
>> 0x3a1
>> [29804.908659]  [<ffffffff811be35b>] avc_has_perm+0x57/0x6c
>> [29804.908665]  [<ffffffff811051cc>] ? getname+0x9f/0x1be
>> [29804.908671]  [<ffffffff811bf96f>] inode_has_perm+0x65/0x67
>> [29804.908677]  [<ffffffff810f60a8>] ? __slab_free+0x130/0x145
>> [29804.908682]  [<ffffffff81105124>] ? putname+0x2d/0x36
>> [29804.908687]  [<ffffffff811bfdd1>] selinux_inode_getattr+0x57/0x59
>> [29804.908692]  [<ffffffff811bdcfb>] ? avc_audit_pre_callback 
>> +0x0/0x100
>> [29804.908697]  [<ffffffff811bddfb>] ? avc_audit_post_callback 
>> +0x0/0xfe
>> [29804.908702]  [<ffffffff810fdf02>] ? cp_new_stat+0x105/0x11b
>> [29804.908708]  [<ffffffff811bca2d>] security_inode_getattr+0x1d/0x1f
>> [29804.908712]  [<ffffffff810fe05c>] vfs_getattr+0x20/0x5e
>> [29804.908717]  [<ffffffff810fe0ea>] vfs_fstatat+0x50/0x67
>> [29804.908722]  [<ffffffff810fe152>] vfs_lstat+0x19/0x1b
>> [29804.908726]  [<ffffffff810fe16e>] sys_newlstat+0x1a/0x38
>> [29804.908732]  [<ffffffff810a022a>] ? audit_syscall_entry 
>> +0x178/0x1a4
>> [29804.908739]  [<ffffffff8102d252>] system_call_fastpath+0x16/0x1b
>> [29804.908742] Code: 46 bb ed ff eb 1e 48 89 df 48 8b 55 d0 48 c7 c6
>> 28 10 5e 81 31 c0 e8 2f bb ed ff 48 8b 7d d0 e8 95 8c f3 ff 66 41 83
>> fc 31 76 04<0f>  0b eb fe 48 89 df 45 0f b7 e4 48 c7 c6 f0 34 5e 81  
>> 49
>> ff cc
>> [29804.908800] RIP  [<ffffffff811bdec1>] avc_audit_post_callback 
>> +0xc6/0xfe
>> [29804.908806]  RSP<ffff880022e01b48>
>> [29804.908810] ---[ end trace e632c740e8d5733d ]---
>>
>>
>> full dmesg is here:
>>
>> http://fpaste.org/VJsZ/
>>
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
