Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6SDAtrT009563
	for <selinux@tycho.nsa.gov>; Wed, 28 Jul 2004 09:10:55 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6SDAPAN006435
	for <selinux@tycho.nsa.gov>; Wed, 28 Jul 2004 13:10:25 GMT
Subject: Re: Problem: myscript, crontab and policy rules for this
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Tanel Kokk <tanel.kokk@eyp.ee>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <41077AFE.3050306@eyp.ee>
References: <41077AFE.3050306@eyp.ee>
Content-Type: text/plain
Message-Id: <1091020020.6886.26.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 28 Jul 2004 09:07:01 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-07-28 at 06:07, Tanel Kokk wrote:
> I have Fedora Core 2 with SElinux. I added a script into the crontab 
> /etc/cron.d/myscript (it includes a line:
> 0 * * * *		/usr/local/bin/myscript > /dev/null 2>&1)
> 
> selinux logs following audit message:
> avc:  denied  { transition } for  pid=17845 exe=/usr/sbin/crond 
> path=/bin/bash dev=dm-0 ino=2850852 scontext=root:system_r:crond_t 
> tcontext=user_u:sysadm_r:sysadm_t tclass=process
> 
> I use program audit2allow to generate correct rule to policy:
> allow crond_t sysadm_t:process { transition };
> 
> I put it into the file domains/misc/local.te and 'make load'
> 
> Unfortunately it won't help because same audit log message will appear, 
> when cron will try execute myscript.
> 
> What I have to do? Why audit2allow won't generate correct rules?

First, the transition is wrong, so you don't want to allow it.  It
should be transitioning to system_r:system_crond_t for system cron
jobs.  Try restarting crond via run_init, i.e. run_init
/etc/init.d/crond restart.  That should place it into the proper
starting security context (system_u:system_r:crond_t); yours was running
in root:system_r:crond_t, presumably due to a manual restart without
using run_init.  In FC3 devel, we have also amended the
policy/constraints to allow proper transitioning from
root:system_r:crond_t, so that manual restarts will work without
run_init.

Second, a denial may occur due to a component of the policy other than
the TE rules, as noted in the selinux-doc README and the Configuring the
SELinux Policy report, due to the RBAC configuration or a constraint. 
This is particularly true when changing the SELinux user identity or
role in some manner.  audit2allow just generates TE allow rules from the
audit message; it doesn't try to infer other causes.
  
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
