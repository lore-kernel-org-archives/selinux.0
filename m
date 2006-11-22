Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAMEpn9f010324
	for <selinux@tycho.nsa.gov>; Wed, 22 Nov 2006 09:51:49 -0500
Received: from atlrel6.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kAMEo8Z5028556
	for <selinux@tycho.nsa.gov>; Wed, 22 Nov 2006 14:50:09 GMT
Message-ID: <456463FC.803@hp.com>
Date: Wed, 22 Nov 2006 09:51:40 -0500
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: Michael C Thompson <thompsmc@us.ibm.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: do SELinux write/read permission checks exist?
References: <4564557F.7030009@us.ibm.com>
In-Reply-To: <4564557F.7030009@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Michael C Thompson wrote:
> So, I've managed to loose track of this in my mind, but does SELinux do 
> permission checks for sys_read and sys_write?

Take a look at vfs_write() and vfs_read() and you will see that they both call
the LSM security_file_permission() hook which under SELinux is defined by the
selinux_file_permission in security/selinux/hooks.c.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
