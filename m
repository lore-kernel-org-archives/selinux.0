Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA17644
	for <selinux@tycho.nsa.gov>; Sat, 10 Nov 2001 12:36:23 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA20075
	for <selinux@tycho.nsa.gov>; Sat, 10 Nov 2001 17:36:13 GMT
Received: from hotmail.com (f95.law10.hotmail.com [64.4.15.95])
	by jazzswing.ncsc.mil  with ESMTP id RAA20071
	for <selinux@tycho.nsa.gov>; Sat, 10 Nov 2001 17:36:13 GMT
From: "Femitha Majeed" <m_femitha@hotmail.com>
To: selinux@tycho.nsa.gov
Subject: Kernel Module
Date: Sat, 10 Nov 2001 17:22:18 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F95EhUztNbKhFvz6udw00023f34@hotmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Hi,


I am trying to write a kernel module, but I get the follwing error when I do 
"insmod filename.o"

Unable to handle kernel NULL pointer dereference at virtual address ...

I am using kmalloc to allocate memory. I have also used filp_open to open a 
directory and sys_getdents to read directory. Does any of these calls cause 
the above problem?

I am very new to writing kernel modules. I would be grateful if you would 
reply to this.

Thanks,
Femitha.


_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com/intl.asp


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
