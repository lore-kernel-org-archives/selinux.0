Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA08610
	for <selinux@tycho.nsa.gov>; Tue, 5 Nov 2002 15:48:29 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id UAA21969
	for <selinux@tycho.nsa.gov>; Tue, 5 Nov 2002 20:46:32 GMT
Received: from web40003.mail.yahoo.com (web40003.mail.yahoo.com [66.218.78.21])
        by jazzband.ncsc.mil  with SMTP id UAA21965 for <selinux@tycho.nsa.gov>; Tue, 5 Nov 2002 20:46:31 GMT
Message-ID: <20021105204827.56361.qmail@web40003.mail.yahoo.com>
Date: Tue, 5 Nov 2002 12:48:27 -0800 (PST)
From: Brad Chapman <jabiru_croc@yahoo.com>
Subject: Re: Selinux on RH8
To: azeredo@qmc.ufsc.br
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1036528113.3dc829f18bb9c@qmc.ufsc.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- azeredo@qmc.ufsc.br wrote:
> 
> 
>  Thank you guys for the help. But i still got some problems. I did
> 
> make relabel after adding the Wasterman lines for the postfix policy and
> reboot
> and got the following messages:
> 
> Activating swap partitions
> /etc/rc.d/rc.sysinit: line 318 /etc/mtab: Read-only file system
> /etc/rc.d/rc.sysinit: line 324 Segmentation fault mount -f
> touch: creating '/var/lock/subsys/network/ ' Read-only file system

Your rc.sysinit script broke somewhere, and your / filesystem is ro instead
of rw. Nothing to do with SELinux.

Brad

> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.


__________________________________________________
Do you Yahoo!?
HotJobs - Search new jobs daily now
http://hotjobs.yahoo.com/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
