Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p1G38s1x005835
	for <selinux@tycho.nsa.gov>; Tue, 15 Feb 2011 22:08:54 -0500
Received: from mail-iy0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p1G38sVl018260
	for <selinux@tycho.nsa.gov>; Wed, 16 Feb 2011 03:08:54 GMT
Received: by iyj8 with SMTP id 8so762625iyj.12
        for <selinux@tycho.nsa.gov>; Tue, 15 Feb 2011 19:08:53 -0800 (PST)
Cc: SE-Linux <selinux@tycho.nsa.gov>
Message-Id: <A08A9A70-AFC8-465D-B710-6C0F5D8E45A3@gmail.com>
From: Justin Mattock <justinmattock@gmail.com>
To: Eric Paris <eparis@parisplace.org>
In-Reply-To: <AANLkTikW=92LoA5sD4cc_hUReHur-Le3ymR-SZ9cECGn@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: [12744.575074] SELinux: Invalid class 3588
Date: Tue, 15 Feb 2011 19:08:50 -0800
References: <AANLkTinVgJrLsW-tTKFG66y0X5Eb0t9U5ayWBXW8zBP_@mail.gmail.com> <AANLkTikW=92LoA5sD4cc_hUReHur-Le3ymR-SZ9cECGn@mail.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Feb 15, 2011, at 6:51 PM, Eric Paris wrote:

> On Tue, Feb 15, 2011 at 1:38 PM, Justin Mattock <justinmattock@gmail.com 
> > wrote:
>> this just poped up with  2.6.37-rc6.. not sure if its fixed with  
>> the current
>>
>> [12744.575074] SELinux:  Invalid class 3588
>
> I've never seen anything like it before....  We only have tclasses up
> to 49.  My best guess is just random unrelated corruption.  Have you
> seen other seemingly completely unrelated issues with this setup?
>
> -Eric

there was something similar I reported to lkml a few months ago, but  
when it came to
reproduction to bisect was vary difficult..
from what I remember the below I was reseting the kernel to get a good  
starting point to bisect
another issue that im seeing(so probably random unrelated corruption.. 
(but will keep an eye out!!))
>
>> [12744.575115] general protection fault: 0000 [#1] SMP
>> [12744.575121] last sysfs file: /sys/devices/platform/applesmc.768/ 
>> light
>> [12744.575124] CPU 0
>> [12744.575125] Modules linked in: hidp rfcomm sco bnep l2cap  
>> xt_tcpudp
>> ipt_LOG iptable_nat nf_nat xt_state nf_conntrack_ftp  
>> nf_conntrack_ipv4
>> nf_conntrack nf_defrag_ipv4 iptable_filter ip_tables x_tabl   btusb
>> bluetooth evdev psmouse thermal fan container button ac battery video
>> ath9k ath9k_common ath9k_hw ath ttm drm aes_x86_64 lzo zlib ipcomp
>> xfrm_ipcomp crypto_null sha256_generic cbc des_generic ca  5 blowfish
>> serpent camellia twofish_generic twofish_x86_64 twofish_common ctr  
>> ah4
>> esp4 authenc firewire_ohci firewire_core uhci_hcd ehci_hcd coretemp
>> acpi_cpufreq processor mperf appletouch applesmc
>> [12744.575183]
>> [12744.575186] Pid: 4607, comm: conf Not tainted 2.6.37-rc6 #2
>> Mac-F42187C8/MacBookPro2,2
>> [12744.575189] RIP: 0010:[<ffffffff811f7901>]  [<ffffffff811f7901>]
>> strnlen+0x14/0x1e
>> [12744.575199] RSP: 0018:ffff88000e775878  EFLAGS: 00010282
>> [12744.575202] RAX: 3a372e64313a3030 RBX: ffff88003599530a RCX:  
>> ffffffffff0a0004
>> [12744.575204] RDX: 3a372e64313a3030 RSI: fffffffffffffffe RDI:  
>> 3a372e64313a3030
>> [12744.575207] RBP: ffff88000e775878 R08: 0000000000000002 R09:  
>> 000000000000000a
>> [12744.575209] R10: 0000000000000001 R11: 0000000000000000 R12:  
>> ffff880035995710
>> [12744.575212] R13: 3a372e64313a3030 R14: ffffffffffffffff R15:  
>> 0000000000000000
>> [12744.575215] FS:  00002ab060cccb20(0000) GS:ffff88003ee00000(0000)
>> knlGS:0000000000000000
>> [12744.575218] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [12744.575220] CR2: 00007f5f5712b000 CR3: 0000000015867000 CR4:  
>> 00000000000006f0
>> [12744.575223] DR0: 0000000000000000 DR1: 0000000000000000 DR2:  
>> 0000000000000000
>> [12744.575225] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7:  
>> 0000000000000400
>> [12744.575228] Process conf (pid: 4607, threadinfo ffff88000e774000,
>> task ffff880015908000)
>> [12744.575230] Stack:
>> [12744.575232]  ffff88000e7758b8 ffffffff811f8f3c ffff88000e7758f8
>> ffff88000e775998
>> [12744.575237]  ffff88003599530a ffff880035995710 ffff880035995309
>> ffffffff815bd686
>> [12744.575242]  ffff88000e775918 ffffffff811f9c21 ffffffff815bd684
>> 0000000000000407
>> [12744.575246] Call Trace:
>> [12744.575252]  [<ffffffff811f8f3c>] string+0x4c/0xaf
>> [12744.575256]  [<ffffffff811f9c21>] vsnprintf+0x1cd/0x42a
>> [12744.575262]  [<ffffffff810985f1>] audit_log_vformat+0xb6/0x177
>> [12744.575266]  [<ffffffff810986ef>] audit_log_format+0x3d/0x3f
>> [12744.575272]  [<ffffffff810f5c73>] ? T.913+0x226/0x29c
>> [12744.575278]  [<ffffffff811bd478>] avc_audit_pre_callback+0xa0/0xff
>> [12744.575283]  [<ffffffff811bd0e1>] ? avc_alloc_node+0x22/0x19b
>> [12744.575288]  [<ffffffff811d3b0a>] common_lsm_audit+0x5a/0x648
>> [12744.575292]  [<ffffffff811bd3ce>] avc_audit+0xa3/0xad
>> [12744.575296]  [<ffffffff811bd85e>] ? avc_has_perm_noaudit+0x21f/ 
>> 0x3a1
>> [12744.575303]  [<ffffffff8111cdc1>] ? __getblk+0x3a/0x2f9
>> [12744.575307]  [<ffffffff811bda37>] avc_has_perm+0x57/0x6c
>> [12744.575310]  [<ffffffff8111d987>] ? unlock_buffer+0x12/0x14
>> [12744.575314]  [<ffffffff811bf247>] inode_has_perm+0x68/0x6a
>> [12744.575318]  [<ffffffff8110ca28>] ? ifind_fast+0x67/0xc6
>> [12744.575323]  [<ffffffff8144c462>] ? _raw_spin_unlock+0x9/0xb
>> [12744.575326]  [<ffffffff811bf97b>] selinux_inode_permission 
>> +0xd2/0xd4
>> [12744.575330]  [<ffffffff811bd3d8>] ? avc_audit_pre_callback 
>> +0x0/0xff
>> [12744.575334]  [<ffffffff811bd4d7>] ? avc_audit_post_callback 
>> +0x0/0xfe
>> [12744.575339]  [<ffffffff811bc0c4>] security_inode_permission+0x1c/ 
>> 0x1e
>> [12744.575343]  [<ffffffff81101cd2>] inode_permission+0x87/0x93
>> [12744.575347]  [<ffffffff811030a6>] may_open+0x9e/0x11e
>> [12744.575350]  [<ffffffff8110395e>] do_last+0x542/0x6fa
>> [12744.575354]  [<ffffffff8110590c>] do_filp_open+0x1f3/0x646
>> [12744.575358]  [<ffffffff810f4356>] ? check_object+0x13b/0x1eb
>> [12744.575361]  [<ffffffff81103b78>] ? getname+0x2c/0x1be
>> [12744.575365]  [<ffffffff8110edbc>] ? alloc_fd+0x111/0x123
>> [12744.575369]  [<ffffffff810f7bb8>] do_sys_open+0x5b/0xf8
>> [12744.575372]  [<ffffffff810f7c7e>] sys_open+0x1b/0x1d
>> [12744.575377]  [<ffffffff8102b4d2>] system_call_fastpath+0x16/0x1b
>> [12744.575380] Code: c3 55 48 89 f8 48 89 e5 eb 03 48 ff c0 80 38 00
>> 75 f8 48 29 f8 c9 c3 55 48 89 f8 48 89 e5 eb 03 48 ff c0 48 85 f6 74
>> 08 48 ff ce <80> 38 00 75 f0 48 29 f8 c9 c3 55 31 c0 48 89 e5 e  15  
>> 44
>> 38 c1
>> [12744.575418] RIP  [<ffffffff811f7901>] strnlen+0x14/0x1e
>> [12744.575421]  RSP <ffff88000e775878>
>> [12744.575425] ---[ end trace c6d106b9a6eb5737 ]---
>>
>>
>>
>> --
>> Justin P. Mattock
>>
>> --
>> This message was distributed to subscribers of the selinux mailing  
>> list.
>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov 
>>  with
>> the words "unsubscribe selinux" without quotes as the message.
>>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
