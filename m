Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA08166
	for <selinux@tycho.nsa.gov>; Mon, 12 Feb 2001 14:42:25 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id TAA05657
	for <selinux@tycho.nsa.gov>; Mon, 12 Feb 2001 19:42:21 GMT
Received: from smtpproxy1.mitre.org (mb-20-100.mitre.org [129.83.20.100])
	by jazzband.ncsc.mil  with ESMTP id TAA05647
	for <selinux@tycho.nsa.gov>; Mon, 12 Feb 2001 19:42:15 GMT
Received: from avsrv1.mitre.org (avsrv1.mitre.org [129.83.20.58])
	by smtpproxy1.mitre.org (8.9.3/8.9.3) with ESMTP id OAA17570
	for <selinux@tycho.nsa.gov>; Mon, 12 Feb 2001 14:42:15 -0500 (EST)
Received: from mailsrv1.mitre.org (mailsrv1.mitre.org [129.83.20.6])
	by smtpsrv1.mitre.org (8.9.3/8.9.3) with ESMTP id OAA13928
	for <selinux@tycho.nsa.gov>; Mon, 12 Feb 2001 14:42:14 -0500 (EST)
Message-ID: <3A87F5F2.918C36BF@mitre.org>
Date: Mon, 12 Feb 2001 14:40:50 +0000
From: Jen Salois <jsalois@mitre.org>
MIME-Version: 1.0
To: "Westerman Mark" <Mark.Westerman@csoconline.com>
CC: selinux@tycho.nsa.gov
Subject: Re: SeLinux Question
References: <72222DC86846D411ABD300A0C9EB08A10152407B@csoc-mail-box.csoconline.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

Mark,

	I am assuming that hwclock is getting started from an init script,
since I see the transition of initrc_t to the hwclock_t.  Well when the
hwclock is started by an init script it is also inheriting the role from
initrc.  The role this operates under is system_r.  Also the error
message is saying there is no hwclock_t associated with the system_r
role.  What you need to do is have a role transition in the policy also. 

You do a role transition in the rbac file.  It is in the form of 

role_transition current_role program_type new_role;

Hope that helps.

Thanks

Jen


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
> Here are the rules
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
> file: domains/system/initrc.te
> 
> domain_auto_trans(initrc_t, hwclock_exec_t, hwclock_t)
> 
> file:  file_context
> /sbin/hwclock                   system_u:object_r:hwclock_exec_t
> 
> ls --scontext /sbin/hwclock
> 
> system_u:object_r:hwclock_exec_t /sbin/hwclock
> 
> file: /var/log/messages
> 
> security_compute_sid:  invalid context system_u:system_r:hwclock_t
>         for scontext=system_u:system_r:initrc_t
>               tcontext=system_u:object_r:hwclock_exec_t tclass=process
> 
> --
> You have received this message because you are subscribed to the selinux list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
