Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id VAA16225
	for <selinux@tycho.nsa.gov>; Wed, 19 Dec 2001 21:40:23 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id CAA28382
	for <selinux@tycho.nsa.gov>; Thu, 20 Dec 2001 02:40:08 GMT
Received: from xenon.chi.it.teu.ac.jp (xenon.chi.it.teu.ac.jp [163.215.10.66])
	by jazzswing.ncsc.mil  with ESMTP id CAA28378
	for <selinux@tycho.nsa.gov>; Thu, 20 Dec 2001 02:40:06 GMT
Received: from kalium (kalium.chi.it.teu.ac.jp [163.215.10.83])
	by xenon.chi.it.teu.ac.jp (Postfix) with SMTP id 831CE122F
	for <selinux@tycho.nsa.gov>; Thu, 20 Dec 2001 11:40:19 +0900 (JST)
Date: Thu, 20 Dec 2001 11:41:01 +0900
From: =?ISO-2022-JP?B?GyRCQX1FRBsoQiAbJEJFLzwhGyhC?= <tmasuda@chi.it.teu.ac.jp>
To: selinux@tycho.nsa.gov
Subject: Japanese Document
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Message-Id: <20011220024019.831CE122F@xenon.chi.it.teu.ac.jp>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello!

My name is Tetsuji Masuda , I`m university student in Japan.

I installed SELinux(2.4.9) in RH7.1. However I can`t use `kon` command in console window. When I pushed returen button after I typed `kon`, the window was, somehow, freezed. What's the problem about that? 

This is log of kon in /var/log/messages.
==========================================================================================
Dec 17 14:20:27 pc07 kernel: 
Dec 17 14:20:27 pc07 kernel: avc:  denied  { read write } for  pid=12513 exe=/usr/bin/kon path=/dev/mem dev=03:06 ino=198216
Dec 17 14:20:27 pc07 kernel:    scontext=root:sysadm_r:sysadm_t
Dec 17 14:20:27 pc07 kernel:    tcontext=system_u:object_r:memory_device_t
Dec 17 14:20:27 pc07 kernel:    tclass=chr_file
Dec 17 14:20:27 pc07 kernel: 
Dec 17 14:20:27 pc07 kernel: avc:  denied  { read write } for  pid=12513 exe=/usr/bin/kon path=/dev/ptyp0 dev=03:06 ino=198701
Dec 17 14:20:27 pc07 kernel:    scontext=root:sysadm_r:sysadm_t
Dec 17 14:20:27 pc07 kernel:    tcontext=system_u:object_r:device_t
Dec 17 14:20:27 pc07 kernel:    tclass=chr_file
Dec 17 14:20:27 pc07 kernel: 
Dec 17 14:20:27 pc07 kernel: avc:  denied  { ioctl } for  pid=12513 exe=/usr/bin/kon path=/dev/ptyp0 dev=03:06 ino=198701
Dec 17 14:20:27 pc07 kernel:    scontext=root:sysadm_r:sysadm_t
Dec 17 14:20:27 pc07 kernel:    tcontext=system_u:object_r:device_t
Dec 17 14:20:27 pc07 kernel:    tclass=chr_file
Dec 17 14:20:27 pc07 kernel: Unable to handle kernel paging request at virtual address 66207369
Dec 17 14:20:27 pc07 kernel:  printing eip:
Dec 17 14:20:27 pc07 kernel: c018f303
Dec 17 14:20:27 pc07 kernel: *pde = 00000000
Dec 17 14:20:27 pc07 kernel: Oops: 0000
Dec 17 14:20:27 pc07 kernel: CPU:    0
Dec 17 14:20:28 pc07 kernel: EIP:    0010:[ipc_precondition+19/96]
Dec 17 14:20:28 pc07 kernel: EIP:    0010:[<c018f303>]
Dec 17 14:20:28 pc07 kernel: EFLAGS: 00010206
Dec 17 14:20:28 pc07 kernel: eax: 66207369   ebx: c3286420   ecx: c764f3e0   edx: c02bb098
Dec 17 14:20:28 pc07 kernel: esi: 0000001c   edi: c3286420   ebp: c75fc000   esp: c75fdedc
Dec 17 14:20:28 pc07 kernel: ds: 0018   es: 0018   ss: 0018
Dec 17 14:20:28 pc07 kernel: Process kon (pid: 12513, stackpage=c75fd000)
Dec 17 14:20:28 pc07 kernel: Stack: c3286420 c764f3e0 c75fc000 c019095f c3286420 0000001c 00000000 00000000 
Dec 17 14:20:28 pc07 kernel:        c7f9c720 c02a3a18 bffff980 c1894460 00000004 00000000 00000000 00000000 
Dec 17 14:20:28 pc07 kernel:        00000000 00000000 00000000 000342c3 0000001c c764f3e0 00000124 c764f3e0 
Dec 17 14:20:28 pc07 kernel: Call Trace: [selinux_shm_associate+47/560] [selinux_ipc_permission+77/96] [ipcperms+143/160] [sys_shmget+273/336] [sys_ipc+564/624] 
Dec 17 14:20:28 pc07 kernel: Call Trace: [<c019095f>] [<c019111d>] [<c017d05f>] [<c0180761>] [<c010c314>] 
Dec 17 14:20:28 pc07 kernel:    [system_call+51/56] 
Dec 17 14:20:28 pc07 kernel:    [<c0106edb>] 
Dec 17 14:20:28 pc07 kernel: 
Dec 17 14:20:28 pc07 kernel: Code: 81 38 8c ff 7c f9 75 07 b8 01 00 00 00 eb 2b bb 00 e0 ff ff 

==========================================================================================

I translated the policy document with Japanese as research. I'm not sure it was correct or not. However I want to use it for report of it. If you agreed of it or disagreed, please let me know. And If you have a good idea instend of it, it's also tell me the detale of it. 

--
増田 哲次 /Tetsuji Masuda
東京工科大学工学部情報工学科4年 /Tokyo University of Technology
千種研究室 /Chigusa Laboratory
MAIL:tmasuda@chi.it.teu.ac.jp

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
