Subject: Re: Unlabeled files
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: "Matthew R. Singer" <msinger@itac.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <8A61167D13CED411B3E500B0D079784703AAF1@mailserver.itac.reston>
References: <8A61167D13CED411B3E500B0D079784703AAF1@mailserver.itac.reston>
Content-Type: text/plain
Date: 08 Apr 2003 16:30:05 -0400
Message-Id: <1049833806.1231.29.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2003-04-08 at 15:32, Matthew R. Singer wrote:
> Can anyone tell me what selinux thinks is unlabeled below?
> 
> Thanks
> 
> Apr  8 14:07:11 localhost kernel: avc:  denied  { transition } for
> pid=902 exe=/usr/bin/kdm path=/etc/X11/xdm/Xsession dev=08:02 ino=314289
> scontext=root:sysadm_r:sysadm_t tcontext=system_u:object_r:unlabeled_t
> tclass=process
> Apr  8 14:07:11 localhost kernel: 
> Apr  8 14:07:11 localhost kernel: avc:  denied  { transition } for
> pid=902 exe=/usr/bin/kdm path=/bin/bash dev=08:02 ino=49420
> scontext=root:sysadm_r:sysadm_t tcontext=system_u:object_r:unlabeled_t
> tclass=process

This suggests that kdm is calling execve_secure with either the
unlabeled SID or a SID that has been invalidated by a policy reload
(e.g. the user, role, or type was removed from the policy).  Note that
the tclass is process; you are dealing with an attempt to create an
unlabeled process, not a file.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
