Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0CIl7Ii017916
	for <selinux@tycho.nsa.gov>; Wed, 12 Jan 2005 13:47:07 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0CIl9gF000087
	for <selinux@tycho.nsa.gov>; Wed, 12 Jan 2005 18:47:09 GMT
Subject: Re: [patch] logrotate
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Greg Norris <haphazard@kc.rr.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <20050104030117.GB5321@yggdrasil.localdomain>
References: <20050104030117.GB5321@yggdrasil.localdomain>
Content-Type: text/plain
Message-Id: <1105555754.11834.30.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 12 Jan 2005 13:49:15 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged with your latest logrotate.fc diff.

On Mon, 2005-01-03 at 22:01, Greg Norris wrote:
> Here are a handful of patches for logrotate, which I've found to be 
> necessary for my Debian SELinux box... all are against current CVS.  
> Please apply.
> 
>    logrotate.fc.diff
> 
> Debian creates the logrotate state file as "/var/lib/logrotate/status",
> rather than "/var/lib/logrotate.status".  The updated pattern will match
> both cases.
> 
>    logrotate.te.1.diff
> 
> Logrotate 3.7 tries to do open(".", O_RDONLY) during startup (so it can
> fchdir() back later), and aborts if unsuccessful.  When run from cron it
> has a CWD of "/root", which is unreadable under the current policy.  
> I've added read access for "staff_home_dir_t" and "sysadm_home_dir_t".
> 
> I'm not completely happy with this approach (perhaps logrotate and/or
> the crontab entries should be modified?), but it sees like it should be
> safe.
> 
>    logrotate.te.2.diff
> 
> Logcheck (which is also handled by the logrotate policy) fails without 
> the ability to relabel it's tempfiles.  I've given it "relabelfrom" and 
> "relabelto" on "logrotate_tmp_t:file".
> 
> 
> As always, let me know if additional information is desired.  Thanx!
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
