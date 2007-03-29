Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2TDXpM8029139
	for <selinux@tycho.nsa.gov>; Thu, 29 Mar 2007 09:33:51 -0400
Received: from web86909.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l2TDXmHY008079
	for <selinux@tycho.nsa.gov>; Thu, 29 Mar 2007 13:33:49 GMT
Date: Thu, 29 Mar 2007 14:33:45 +0100 (BST)
From: JanuGerman <doublemalam@yahoo.co.uk>
Subject: Re: SELinux cache.
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <1174999097.3864.271.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <25193.15470.qm@web86909.mail.ukl.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Stephen,


> $ cat test.te
> policy_module(test, 1.0)
> 
> require {
>         attribute domain;
>         attribute file_type;
> }
> 
> auditallow domain file_type:dir_file_class_set *;
> $ make -f /usr/share/selinux/devel/Makefile
> $ su -
> # semodule -i test.pp
> # tail -f /var/log/audit/audit.log
> 
> But be warned that this will generate a lot of
> audit.
> To remove, use:
> # semodule -r test
> 

I am having some problems now with this module. I
added this module, after restart, there were alot of
messages, saying "audit ... maximum size=256 size
exceeded". The messages were not stopping so, I
rebooted the system with selinux disabled and tried to
remove this module.

But now, when i reboot, the system hangs at starting
"udev" service MAKEDEV: mkdir: FILE exists ...saying
an error occured during file system check, dropping
you to shell, ... give root password for maintaine....

My system have e compiled kernels, but non of them is
rebooting with SElinux.

Can i recover the SELinux again while rebooted without
SElinux? or this means, the system is not usable any
more.

Thanks,
JG


		
___________________________________________________________ 
The all-new Yahoo! Mail goes wherever you go - free your email address from your Internet provider. http://uk.docs.yahoo.com/nowyoucan.html

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
