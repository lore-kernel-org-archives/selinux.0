Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6F6K4Ha016270
	for <selinux@tycho.nsa.gov>; Tue, 15 Jul 2003 02:20:05 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h6F6K3H5009555
	for <selinux@tycho.nsa.gov>; Tue, 15 Jul 2003 06:20:03 GMT
Received: from monk.verbum.org (monk.debian.net [216.226.142.128])
        by jazzband.ncsc.mil  with ESMTP id h6F6K3RX009550 for <selinux@tycho.nsa.gov>; Tue, 15 Jul 2003 06:20:03 GMT
Received: from columbia (dhcp024-208-189-249.columbus.rr.com [24.208.189.249])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "columbia.verbum.org", Issuer "verbum.org CA" (verified OK))
	by monk.verbum.org (Postfix (Debian/GNU)) with ESMTP id 15A5932A6BB
	for <selinux@tycho.nsa.gov>; Tue, 15 Jul 2003 14:24:50 -0400 (EDT)
Subject: crash with 2.5.74 while loading policy
From: Colin Walters <walters@verbum.org>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Message-Id: <1058249829.24843.13.camel@columbia>
Mime-Version: 1.0
Date: 15 Jul 2003 02:17:10 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

Linux oopsed while loading a policy today on my SELinux 2.5.74 machine. 
It doesn't offhand look directly related to SELinux, but I was curious
if anyone here had seen it before.

Here's the oops output:

Jul 15 01:53:42 meta kernel: security:  3 users, 5 roles, 392 types
Jul 15 01:53:42 meta kernel: security:  30 classes, 29820 rules
Jul 15 01:53:44 meta kernel: Bad page state at free_hot_cold_page
Jul 15 01:53:44 meta kernel: flags:0x01000014 mapping:00000000 mapped:1 count:0
Jul 15 01:53:44 meta kernel: Backtrace:
Jul 15 01:53:44 meta kernel: Call Trace: [bad_page+93/144]  [free_hot_cold_page+112/304]  [__pagevec_free+28/48]  [release_pages+357/416]  [__pte_chain_free+129/144]  [free_pages_and_swap_cache+106/160]  [zap_pte_range+466/560]  [zap_pmd_range+75/112]  [unmap_page_range+75/128]  [unmap_vmas+254/752]  [exit_mmap+236/576]  [mmput+111/208]  [do_exit+326/1152]  [do_group_exit+66/224]  [syscall_call+7/11]
Jul 15 01:53:44 meta kernel: Trying to fix it up, but a reboot is needed
Jul 15 01:54:34 meta kernel:
Jul 15 01:54:34 meta kernel: avc:  denied  { use } for  pid=3864 exe=/usr/bin/apt-get path=/dev/pts/0 dev= ino=2 scontext=system_u:system_r:apt_t tcontext=root:staff_r:newrole_t tclass=fd
Jul 15 01:54:39 meta kernel: Bad page state at prep_new_page
Jul 15 01:54:39 meta kernel: flags:0x01000004 mapping:00000000 mapped:1 count:0
Jul 15 01:54:39 meta kernel: Backtrace:
Jul 15 01:54:39 meta kernel: Call Trace: [bad_page+93/144]  [prep_new_page+64/96]  [buffered_rmqueue+238/416]  [__alloc_pages+145/784]  [do_anonymous_page+135/752]  [handle_mm_fault+262/432]  [do_page_fault+604/1145]  [do_brk+313/544]  [sys_brk+222/272]  [do_page_fault+0/1145]  [error_code+45/56]
Jul 15 01:54:39 meta kernel: Trying to fix it up, but a reboot is needed
Jul 15 01:54:39 meta kernel: Unable to handle kernel paging request at virtual address 00010004
Jul 15 01:54:39 meta kernel:  printing eip:
Jul 15 01:54:39 meta kernel: c014d58d
Jul 15 01:54:39 meta kernel: *pde = 00000000
Jul 15 01:54:39 meta kernel: Oops: 0000 [#1]
Jul 15 01:54:39 meta kernel: CPU:    0
Jul 15 01:54:39 meta kernel: EIP:    0060:[page_add_rmap+125/320]    Not tainted
Jul 15 01:54:39 meta kernel: EFLAGS: 00010246
Jul 15 01:54:39 meta kernel: eax: 01008004   ebx: c10ca288   ecx: 00010000   edx: c1000000
Jul 15 01:54:39 meta kernel: esi: c5def8c0   edi: c5ea2e14   ebp: c10ca288   esp: c51edeb4
Jul 15 01:54:39 meta kernel: ds: 007b   es: 007b   ss: 0068
Jul 15 01:54:39 meta kernel: Process dpkg (pid: 3879, threadinfo=c51ec000 task=c4ff1920)
Jul 15 01:54:39 meta kernel: Stack: c5ea2e14 00000000 050dd067 c0148b45 00000020 c5def8c0 00000207 cd8a9084
Jul 15 01:54:39 meta kernel:        ceb6f9c0 08785274 c01491f6 ceb6f9c0 cb4976e0 c5ea2e14 cd8a9084 00000001
Jul 15 01:54:39 meta kernel:        00000e14 00000286 ceb6f9c0 ceb6f9e0 cb4976e0 c4ff1920 c011aaec ceb6f9c0
Jul 15 01:54:39 meta kernel: Call Trace: [do_anonymous_page+501/752]  [handle_mm_fault+262/432]  [do_page_fault+604/1145]
 [do_brk+313/544]  [sys_brk+222/272]  [do_page_fault+0/1145]  [error_code+45/56]
Jul 15 01:54:39 meta kernel: Code: 8b 41 04 85 c0 75 53 8b 01 89 c2 83 e2 07 89 3c 91 48 89 01
Jul 15 01:54:39 meta kernel:  <6>note: dpkg[3879] exited with preempt_count 2


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
