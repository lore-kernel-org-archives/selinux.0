Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA07907
	for <selinux@tycho.nsa.gov>; Mon, 12 Feb 2001 14:14:30 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id TAA09276
	for <selinux@tycho.nsa.gov>; Mon, 12 Feb 2001 19:14:20 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id TAA09272
	for <selinux@tycho.nsa.gov>; Mon, 12 Feb 2001 19:14:19 GMT
Date: Mon, 12 Feb 2001 14:13:09 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: "Westerman, Mark" <Mark.Westerman@csoconline.com>
cc: selinux@tycho.nsa.gov
Subject: Re: SeLinux Question
In-Reply-To: <72222DC86846D411ABD300A0C9EB08A10152407B@csoc-mail-box.csoconline.com>
Message-ID: <Pine.SOL.3.95.1010212140414.24816U-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>


You need to add the hwclock_t type to the definition of the
system_r role in policy/rbac. 

By the way, we are currently preparing an updated release 
based on the 2.4.1 kernel.  The old 2.2 patch will also be
updated in the new release for 2.2.18.

--
Stephen D. Smalley, NAI Labs
sds@tislabs.com


On Mon, 12 Feb 2001, Westerman, Mark wrote:

> To all,
> 
> I have been try to get selinux running on a Redhat 7 box. I have the
> kernel running in debug mode and i am try to get rid of the denied messages
> 
> I am work on the /sbin/hwclock program.
> 
> Thanks
> Mark Westerman
> mark.westerman@csoconline.com
> 
> 
> 
> Here are the rules
> 
> 
> file:   domains/system/hwclock.te
> #################################
> #
> # Rules for the hwclock_t domain.
> #
> type hwclock_t, domain, privlog;
> type hwclock_exec_t, file_type, sysadmfile, exec_type;
> 
> # Use capabilities.
> allow hwclock_t self:capability { sys_admin };
> 
> # Inherit and use descriptors from init.
> #allow hwclock_t init_t:fd inherit_fd_perms;
> 
> # Use a pipe created by initrc_t.
> #allow hwclock_t initrc_t:pipe rw_file_perms;
> 
> # Read and write ttys.
> allow hwclock_t tty_device_t:chr_file rw_file_perms;
> 
> 
> file: domains/system/initrc.te
> 
> domain_auto_trans(initrc_t, hwclock_exec_t, hwclock_t)
> 
> 
> file:  file_context
> /sbin/hwclock                   system_u:object_r:hwclock_exec_t
> 
> 
> ls --scontext /sbin/hwclock
> 
> system_u:object_r:hwclock_exec_t /sbin/hwclock
> 
> 
> file: /var/log/messages
> 
> security_compute_sid:  invalid context system_u:system_r:hwclock_t 
>         for scontext=system_u:system_r:initrc_t 
>               tcontext=system_u:object_r:hwclock_exec_t tclass=process
> 
> 
> --
> You have received this message because you are subscribed to the selinux list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
