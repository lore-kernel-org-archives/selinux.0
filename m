Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAJJnEIi023391
	for <selinux@tycho.nsa.gov>; Fri, 19 Nov 2004 14:49:14 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAJJlk3F027775
	for <selinux@tycho.nsa.gov>; Fri, 19 Nov 2004 19:47:47 GMT
Subject: Re: gentoo policy for dante
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: petre rodan <kaiowas@gentoo.org>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <419D1ABD.4020901@gentoo.org>
References: <4198E94B.8070008@gentoo.org>
	 <1100808438.26930.28.camel@moss-lions.epoch.ncsc.mil>
	 <419D1ABD.4020901@gentoo.org>
Content-Type: text/plain
Message-Id: <1100893919.31793.32.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 19 Nov 2004 14:51:59 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged the dante.te and dante.fc files after removing the
initrc_var_run_t rule.


On Thu, 2004-11-18 at 16:57, petre rodan wrote:
> Hi James,
> 
> James Carter wrote:
> > allow dante_t initrc_var_run_t:file { getattr write };
> > 
> > Why does dante need this?
> 
> The current gentoo init scripts create the pid file for the daemon. This will be fixed soon.
> Please drop that particular rule from the policy.
> 
> thanks,
> peter
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
