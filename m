Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0JDHdcX014975
	for <selinux@tycho.nsa.gov>; Fri, 19 Jan 2007 08:17:39 -0500
Received: from ccerelrim04.cce.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l0JDIYTB024864
	for <selinux@tycho.nsa.gov>; Fri, 19 Jan 2007 13:18:34 GMT
From: Paul Moore <paul.moore@hp.com>
To: Antoine Martin <antoine@nagafix.co.uk>
Subject: Re: 2.6.19.2 Oops
Date: Fri, 19 Jan 2007 08:18:27 -0500
Cc: selinux@tycho.nsa.gov
References: <45B09CFA.5070805@nagafix.co.uk>
In-Reply-To: <45B09CFA.5070805@nagafix.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200701190818.27289.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 19 January 2007 5:27 am, Antoine Martin wrote:
> I tried to upgrade a system which had been running very smoothly for
> quite some time (enforcing=1), but it just Oopsed with 2.6.19.2, even in
> non-enforcing mode, I had to use selinux=0 to get anywhere (otherwise
> the Oops below just scrolled on the console)

This looks to be related to NetLabel as the Oops is happening in 
mls_export_cat().  Could you do the following in gdb and report the results 
so that we can get a better idea of what instruction is causing the NULL 
dereference:

 (gdb) list *mls_export_cat+0x33

Also, can you tell us what distribution and SELinux policy you are using?

Thanks for reporting this.

> [   80.782761] Adding 3911736k swap on /dev/md1.  Priority:-1 extents:1
> across:3911736k
> [   86.188350] BUG: unable to handle kernel NULL pointer dereference at
> virtual address 00000000
> [   86.188359]  printing eip:
> [   86.188361] c114e1f3
> [   86.188362] *pde = 00000000
> [   86.188367] Oops: 0002 [#1]
> [   86.221736] CPU:    0
> [   86.221737] EIP:    0060:[<c114e1f3>]    Not tainted VLI
> [   86.221738] EFLAGS: 00010246   (2.6.19.2-skas3-v8.2 #3)
> [   86.375023] EIP is at mls_export_cat+0x33/0xf0
> [   86.428188] eax: 00000000   ebx: c1e78f1c   ecx: c1e78f20   edx:
> c1e78f1c [   86.509404] esi: c1e78f20   edi: 00000000   ebp: f79ffe24  
> esp: c1e78ef0 [   86.590617] ds: 007b   es: 007b   ss: 0068
> [   86.639632] Process ip (pid: 1543, ti=c1e78000 task=c1f0a030
> task.ti=c1e78000)
> [   86.723962] Stack: fffffffe c1e78f10 f79ffe24 f793cd20 c114ac67
> 00000000 00000000 f7c9ac00
> [   86.825204]        f78d1fc0 00000000 00000001 00000000 00000000
> 00000000 c14b0c20 00000002
> [   86.926564]        00000001 00000000 c12f9598 00000000 00000000
> f793cd20 c1e78f70 0000000c
> [   87.027820] Call Trace:
> [   87.059298]  [<c114ac67>] selinux_netlbl_socket_setsid+0xb7/0x120
> [   87.132410]  [<c12f9598>] __sock_create+0xd8/0x160
> [   87.189944]  [<c12f9658>] sock_create+0x18/0x20
> [   87.244361]  [<c12f998c>] sys_socket+0x1c/0x50
> [   87.297741]  [<c12fa63a>] sys_socketcall+0x9a/0x2b0
> [   87.356315]  [<c1002e35>] sysenter_past_esp+0x56/0x79
> [   87.416966]  =======================
> [   87.459754] Code: c5 a1 04 e0 59 c1 89 1c 24 89 74 24 04 89 d3 89 7c
> 24 08 89 ce 85 c0 75 37 c7 02 00 00 00 00 c7 01 00 00 00 00 31 ff 8b 44
> 24 14 <c7> 00 00 00 00 00 8b 54 24 18 c7 02 00 00 00 00 89 f8 8b 1c 24
> [   87.692380] EIP: [<c114e1f3>] mls_export_cat+0x33/0xf0 SS:ESP
> 0068:c1e78ef0
> [   87.776087]  <1>BUG: unable to handle kernel NULL pointer dereference
> at virtual address 00000000

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
