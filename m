Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6SDdIrT009767
	for <selinux@tycho.nsa.gov>; Wed, 28 Jul 2004 09:39:18 -0400 (EDT)
Received: from mx2.eyp.ee (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6SDceAN008512
	for <selinux@tycho.nsa.gov>; Wed, 28 Jul 2004 13:38:45 GMT
Received: from internal by mx2.eyp.ee;
	for <selinux@tycho.nsa.gov>; Wed, 28 Jul 2004 16:39:10 +0300
Message-ID: <4107AC7D.50906@eyp.ee>
Date: Wed, 28 Jul 2004 16:39:09 +0300
From: Tanel Kokk <tanel.kokk@eyp.ee>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: selinux@tycho.nsa.gov
Subject: Re: Problem: myscript, crontab and policy rules for this
References: <41077AFE.3050306@eyp.ee> <1091020020.6886.26.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1091020020.6886.26.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

> First, the transition is wrong, so you don't want to allow it.  It
> should be transitioning to system_r:system_crond_t for system cron
> jobs.  Try restarting crond via run_init, i.e. run_init
> /etc/init.d/crond restart.  That should place it into the proper
> starting security context (system_u:system_r:crond_t); yours was running
> in root:system_r:crond_t, presumably due to a manual restart without
> using run_init.  In FC3 devel, we have also amended the
> policy/constraints to allow proper transitioning from
> root:system_r:crond_t, so that manual restarts will work without
> run_init.

Thanks a lot! Everything is OK now after restarting crond with run_init.

> Second, a denial may occur due to a component of the policy other than
> the TE rules, as noted in the selinux-doc README and the Configuring the
> SELinux Policy report, due to the RBAC configuration or a constraint. 
> This is particularly true when changing the SELinux user identity or
> role in some manner.  audit2allow just generates TE allow rules from the
> audit message; it doesn't try to infer other causes.
>   
Understood.

Tanel


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
