Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA17854
	for <selinux@tycho.nsa.gov>; Thu, 20 Dec 2001 09:05:46 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA19574
	for <selinux@tycho.nsa.gov>; Thu, 20 Dec 2001 14:05:31 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100] (may be forged))
	by jazzswing.ncsc.mil  with ESMTP id OAA19570
	for <selinux@tycho.nsa.gov>; Thu, 20 Dec 2001 14:05:30 GMT
Date: Thu, 20 Dec 2001 09:04:48 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: =?ISO-2022-JP?B?GyRCQX1FRBsoQiAbJEJFLzwhGyhC?= <tmasuda@chi.it.teu.ac.jp>
cc: <selinux@tycho.nsa.gov>
Subject: Re: Japanese Document
In-Reply-To: <20011220024019.831CE122F@xenon.chi.it.teu.ac.jp>
Message-ID: <Pine.GSO.4.33.0112200851210.16420-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 20 Dec 2001, [ISO-2022-JP] 増田 哲次 wrote:

> My name is Tetsuji Masuda , I`m university student in Japan.
>
> I installed SELinux(2.4.9) in RH7.1. However I can`t use `kon` command in console window. When I pushed returen button after I typed `kon`, the window was, somehow, freezed. What's the problem about that?

First, you should upgrade to the latest SELinux release and apply all
patches that have been posted on the mailing list since that release.  The
2.4.9-based SELinux is quite old (August) and there have been many fixes
and improvements since it was released.  Download the latest release
(based on 2.4.16) from http://www.nsa.gov/selinux/download2.html and then
apply the following patches:
http://marc.theaimsgroup.com/?l=selinux&m=100808452800605&w=2
http://marc.theaimsgroup.com/?l=selinux&m=100808453300620&w=2
http://marc.theaimsgroup.com/?l=selinux&m=100861319315772&w=2

> This is log of kon in /var/log/messages.
> ==========================================================================================
> Dec 17 14:20:27 pc07 kernel:
> Dec 17 14:20:27 pc07 kernel: avc:  denied  { read write } for  pid=12513 exe=/usr/bin/kon path=/dev/mem dev=03:06 ino=198216
> Dec 17 14:20:27 pc07 kernel:    scontext=root:sysadm_r:sysadm_t
> Dec 17 14:20:27 pc07 kernel:    tcontext=system_u:object_r:memory_device_t
> Dec 17 14:20:27 pc07 kernel:    tclass=chr_file

I'm not familiar with the 'kon' command, but it appears that it tries to
access the /dev/mem device.  That has obvious security implications.  If
you really want to permit it to access this device, you'll need to put it
into a domain with the corresponding permissions and put the "privmem"
type attribute on the domain so that the assertion won't fail.

> Dec 17 14:20:27 pc07 kernel: Unable to handle kernel paging request at virtual address 66207369
> Dec 17 14:20:27 pc07 kernel:  printing eip:
> Dec 17 14:20:27 pc07 kernel: c018f303
> Dec 17 14:20:27 pc07 kernel: *pde = 00000000
> Dec 17 14:20:27 pc07 kernel: Oops: 0000
> Dec 17 14:20:27 pc07 kernel: CPU:    0
> Dec 17 14:20:28 pc07 kernel: EIP:    0010:[ipc_precondition+19/96]
> Dec 17 14:20:28 pc07 kernel: EIP:    0010:[<c018f303>]
> Dec 17 14:20:28 pc07 kernel: EFLAGS: 00010206
> Dec 17 14:20:28 pc07 kernel: eax: 66207369   ebx: c3286420   ecx: c764f3e0   edx: c02bb098
> Dec 17 14:20:28 pc07 kernel: esi: 0000001c   edi: c3286420   ebp: c75fc000   esp: c75fdedc
> Dec 17 14:20:28 pc07 kernel: ds: 0018   es: 0018   ss: 0018
> Dec 17 14:20:28 pc07 kernel: Process kon (pid: 12513, stackpage=c75fd000)
> Dec 17 14:20:28 pc07 kernel: Stack: c3286420 c764f3e0 c75fc000 c019095f c3286420 0000001c 00000000 00000000
> Dec 17 14:20:28 pc07 kernel:        c7f9c720 c02a3a18 bffff980 c1894460 00000004 00000000 00000000 00000000
> Dec 17 14:20:28 pc07 kernel:        00000000 00000000 00000000 000342c3 0000001c c764f3e0 00000124 c764f3e0
> Dec 17 14:20:28 pc07 kernel: Call Trace: [selinux_shm_associate+47/560] [selinux_ipc_permission+77/96] [ipcperms+143/160] [sys_shmget+273/336] [sys_ipc+564/624]
> Dec 17 14:20:28 pc07 kernel: Call Trace: [<c019095f>] [<c019111d>] [<c017d05f>] [<c0180761>] [<c010c314>]
> Dec 17 14:20:28 pc07 kernel:    [system_call+51/56]
> Dec 17 14:20:28 pc07 kernel:    [<c0106edb>]
> Dec 17 14:20:28 pc07 kernel:
> Dec 17 14:20:28 pc07 kernel: Code: 81 38 8c ff 7c f9 75 07 b8 01 00 00 00 eb 2b bb 00 e0 ff ff

Hmmm...This is a bug.  I was initially assuming that it was something that
we had already fixed since the 2.4.9 release, but in looking at the code,
I see that this bug is still present in the current code.  We'll get a
patch out later today for the current (2.4.16) release.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
