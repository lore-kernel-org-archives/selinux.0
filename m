Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4JBsCI4002568
	for <selinux@tycho.nsa.gov>; Mon, 19 May 2003 07:54:12 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h4JBroQj024473
	for <selinux@tycho.nsa.gov>; Mon, 19 May 2003 11:53:50 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h4JBrnxS024470
	for <selinux@tycho.nsa.gov>; Mon, 19 May 2003 11:53:50 GMT
Subject: Re: Thinking about an extension to the cron patch
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Torsten Knodt <tk-selinux@datas-world.de>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200305181707.00953.tk-selinux@datas-world.de>
References: <200305181707.00953.tk-selinux@datas-world.de>
Content-Type: text/plain
Message-Id: <1053345240.4729.931.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 19 May 2003 07:54:05 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2003-05-18 at 11:07, Torsten Knodt wrote:
> I'm currently trying to get the SE Linux patches from Russell's homepage into 
> upstream via the Debian BTS.
> 
> I already had a mail conversation with the cron maintainer about some changes 
> to the patch. The patch is now a little smaller, because we don't need the 
> *system* hack any more.
> But we are also thinking about another change. In the system
> crontab's, there are the users. We could split them with a delimiter like :
> and allow to set the SE Linux user for this line. As long this isn't used,
> the jobs run under system_u. With this change, we could clean up the crond
> policy. I don't feel very good allowing all system cronjobs all this. Also it 
> would allow to get these policy parts back into the package policies owning 
> these jobs.

Rather than specifying different SELinux users, why not just specify the
domain for the system cron job?  If the cron job is started in a given
domain, then you can control the set of domains to which it can
transition based purely on the TE configuration.  You don't need to
place them into separate user identities or roles.

Also, please note that the SELinux API is undergoing significant changes
as part of integration into mainline 2.5, so the patches for the daemons
and utilities are also being reworked.  You can get a reasonably current
snapshot of the ongoing 2.5 work from http://www.nsa.gov/selinux/lk; in
particular, see the API being exported by libselinux from
selinux-2.5.tgz.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
