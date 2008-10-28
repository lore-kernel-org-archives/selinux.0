Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9S3AsvW028076
	for <selinux@tycho.nsa.gov>; Mon, 27 Oct 2008 23:10:54 -0400
Received: from etbe.coker.com.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m9S39KL9007979
	for <selinux@tycho.nsa.gov>; Tue, 28 Oct 2008 03:09:23 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: 2.6.26 Debian kernel panic
Date: Tue, 28 Oct 2008 14:10:43 +1100
Cc: Paul Menzel <paul.menzel@web.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200810281410.45041.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Below are the syslog messages from a kernel panic when running 2.6.26.  To 
trigger it I ran "semodule -i sendmail.pp" on a machine with the exim policy 
loaded (not something that you expect people to do - but not something you 
expect to cause a problem either) and load_policy went into an infinite loop 
(100% CPU use - strace reported no syscalls being made).  At that 
stage "kill -9" seemed like the right solution, killing load_policy gave the 
following result.

I've tried to reproduce it but have been unsuccessful.  The machine in 
question is a Xen DomU, I believe that the hardware has ECC RAM and is of 
generally good quality.

Message from syslogd@redcape at Tue Oct 28 03:04:31 2008 ...
redcape kernel: [399681.381737] Eeek! page_mapcount(page) went negative! (-1)

Message from syslogd@redcape at Tue Oct 28 03:04:31 2008 ...
redcape kernel: [399681.381755]   page pfn = 3

Message from syslogd@redcape at Tue Oct 28 03:04:31 2008 ...
redcape kernel: [399681.381760]   page->flags = 400

Message from syslogd@redcape at Tue Oct 28 03:04:31 2008 ...
redcape kernel: [399681.381766]   page->count = 1

Message from syslogd@redcape at Tue Oct 28 03:04:31 2008 ...
redcape kernel: [399681.381770]   page->mapping = 0000000000000000

Message from syslogd@redcape at Tue Oct 28 03:04:31 2008 ...
redcape kernel: [399681.381780]   vma->vm_ops = 0x0

Message from syslogd@redcape at Tue Oct 28 03:04:31 2008 ...
redcape kernel: [399681.381799] ------------[ cut here ]------------

Message from syslogd@redcape at Tue Oct 28 03:04:31 2008 ...
redcape kernel: [399681.381811] invalid opcode: 0000 [1] SMP

Message from syslogd@redcape at Tue Oct 28 03:04:31 2008 ...
redcape kernel: [399681.381828] Code: 80 e8 3c 0c fd ff 48 8b 85 90 00 00 00 
48                                                                                                                                                     
85 c0 74 19 48 8b 40 20 48 85 c0 74 10 48 8b 70 58 48 c7 c7 66 52 4b 80 e8 17 
0c                                                                                                                                                     
fd ff <0f> 0b eb fe 8b 77 18 41 58 5b 5d 83 e6 01 f7 de 83 c6 04 e9 6c

-- 
Russell Coker <russell@coker.com.au>
http://etbe.coker.com.au/          My Blog
http://etbe.coker.com.au/category/security/  My Security blog posts
http://www.coker.com.au/selinux/play.html  My Play Machine, root PW "SELINUX"

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
