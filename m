Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9HC47Wt008585
	for <selinux@tycho.nsa.gov>; Fri, 17 Oct 2003 08:04:07 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9HC46mR011188
	for <selinux@tycho.nsa.gov>; Fri, 17 Oct 2003 12:04:06 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h9HC45jp011185 for <selinux@tycho.nsa.gov>; Fri, 17 Oct 2003 12:04:05 GMT
Subject: Re: process context
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Carlos Anisio Monteiro <monteiro@ipen.br>
Cc: selinux@tycho.nsa.gov, Russell Coker <russell@coker.com.au>
In-Reply-To: <3F8EEA16.8090908@ipen.br>
References: <3F8EEA16.8090908@ipen.br>
Content-Type: text/plain
Message-Id: <1066392235.31764.6.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 17 Oct 2003 08:03:55 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2003-10-16 at 14:57, Carlos Anisio Monteiro wrote:
> Hi.
> 
> The system have many process running in the following context:
> system_u:system_r:kernel_t (see example below).
<snip>
> 
> This is happen in the time of boot.
> 
> Is this correct? Any process, p.ex. init, syslogd, klogd, shouldn't
> they running in the proper context?
> P.ex.: 
> init - system_u:system_r:init_t
> klogd - system_u:system_r:klogd_t
> cron - system_u:system_r:cron_t
> 
> If yes. How I resolve ???

The possible scenarios are:
1) You never labeled /sbin/init with system_u:object_r:init_exec_t.
Based on your prior email, you have labeled /sbin/init, so this is not
the cause.

2) You labeled /sbin/init initially, but you are running prelink on your
system and do not have the patched prelink program, so prelink is
cheerfully unlinking it and re-creating it with the default type,
causing it to fall back into sbin_t.  You can check for this by doing a
'ls --context /sbin/init' again.  Dan Walsh has a patched prelink
program that preserves security contexts available from his site,
ftp://people.redhat.com/dwalsh/SELinux.  prelink is enabled by default
in Fedora Core.

3) /sbin/init is labeled correctly, but the policy is not loaded prior
to starting it, so the domain transition rule isn't defined when the
execution occurs.  This would happen if you failed to load the policy
from an initrd prior to execution of /sbin/init, or if you are trying to
perform the initial policy load via /sbin/init itself without
re-exec'ing it after performing the load.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
