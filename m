Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id WAA10619
	for <selinux@tycho.nsa.gov>; Sat, 20 Jul 2002 22:26:31 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id CAA17094
	for <selinux@tycho.nsa.gov>; Sun, 21 Jul 2002 02:25:48 GMT
Received: from mail.simplyaquatics.com (66-0-92-223.deltacom.net [66.0.92.223])
	by jazzswing.ncsc.mil  with ESMTP id CAA17090
	for <selinux@tycho.nsa.gov>; Sun, 21 Jul 2002 02:25:47 GMT
Received: from ed (ed1 [192.168.1.10])
	by mail.simplyaquatics.com (Postfix) with ESMTP id 288B484404A
	for <selinux@tycho.nsa.gov>; Sat, 20 Jul 2002 22:26:24 -0400 (EDT)
Reply-To: <blacknet@simplyaquatics.com>
From: "Ed Street" <blacknet@simplyaquatics.com>
To: "'Selinux'" <selinux@tycho.nsa.gov>
Subject: segmentation fault in /tmp
Date: Sat, 20 Jul 2002 22:26:24 -0400
Message-ID: <001601c2305e$023741b0$0a01a8c0@ed>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

This is a base install woody 3.0 with a promise controller card
(hardware mirror).  I have /var and /tmp broken off into separate
partitions, 10 gigs each. (40g barracuda drives)  

When /tmp is umounted at any time it produces a Segmentation fault.
(umount /tmp from either console or shutdown/poweroff/halt/reboot
scripts)  Under a non-selinux kernel this behavior is not displayed.

I have avc_enforcing set to permissive using the default policy.  This
is on a clean install after the lsm deb's and the kernel went on, also
Make -C  realabel was ran before reboot.  

This is the message that I get, so far I have been unable to produce any
core files from this.

Unable to handle kernel NULL pointer dereference at virtual address
00000098 printing eip:
*pde = 00000000
Oops: 0000
CPU: 0
EIP: 0010:[<c016017f>] Not tainted
EFLAGS: 00010212
Eax: cf5c0420	ebx: cefad970	ecx: ce71befc	edx: 00000000
Esi: cebad970	edi: c0000000	ebp: ceb8a380	esp: ce71becc
Ds: 0018	es: 0018	ss: 0018
Process umount (pid: 249, stackpage=ce71b000)

Stack: 
ce71a000 c01ae769 cebad970 ce71defc 00000004 ce71bef4 cebadc00 ceb8a380
Cebadc00 c0439f20 0001fd10 00000000 00000000 c01b5584 ceb9a380 ce71a000
Ceb8a380 c014e882 ceb8a280 cf5c0420 ceb8a380 cebad800 cfff8da0 c014b79d

Call Trace: [<c01ae769>} {<c01b5584>] [<c014e882>] [<c014b79d>]
[<c01ad882>]
[<c01ae49d>] [<c01b4010>] [<c0150b82>] [<c0150cae>] [<c0127562>]
[<c0150cd4>]

[<c0107023>]

Code: 8b 82 98 00 00 00 f6 40 2b 10 75 0f f6 82 0c 01 00 00 01 75
 Segmentation fault

Ed


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
