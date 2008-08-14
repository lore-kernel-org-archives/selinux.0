Message-ID: <48A485B4.4060403@kutulu.org>
Date: Thu, 14 Aug 2008 15:21:24 -0400
From: Mike Edenfield <kutulu@kutulu.org>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Paul Moore <paul.moore@hp.com>,
        SELinux Mailing List <selinux@tycho.nsa.gov>
Subject: Re: Help: SELinux causing(?) boot failures...
References: <489C6A4F.3020704@kutulu.org>	 <200808081251.45453.paul.moore@hp.com>  <489C801E.9040306@kutulu.org> <1218733093.29535.46.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1218733093.29535.46.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

> Hmmm...do you have CONFIG_SECURITY_SELINUX_DEVELOP=y in your
> kernel .config file?  If not, your kernel won't support permissive mode
> at all and will always be in enforcing mode.

Yes, I have both that and the boot option enabled in the kernel.

>> (transcribed by hand since neither syslog nor auditd are starting)
>>
>> avc: denied { execute_no_trans } for pid=1 comm="init" path="/sbin/init" 
>> dev=sda3 ino=920038 scontext=system_u:system_r:kernel_t 
>> tcontext=system_u:object_r:file_t tclass=file

> So your filesystem is not labeled at all.

This is what I thought, but when I boot with "selinux=0" I am able to 
run setfiles on all the file systems and it claims it's doing the 
labelling properly, so I'm not sure what else to do.

> Are you sure you followed the steps in the Hardened Gentoo SELinux
> guide?  And have you sent any email to the gentoo-hardened list about
> this, as you'll get Gentoo-specific help there?

I wasn't sure it was a Gentoo-specific problem, but I'm rebuilding the 
system from scratch again to make sure I didn't miss anything, then I'll 
  move to the Gentoo list from there.

Thanks,

--Mike

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
