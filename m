Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBKLfiIi017939
	for <selinux@tycho.nsa.gov>; Mon, 20 Dec 2004 16:41:45 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBKLfleP000052
	for <selinux@tycho.nsa.gov>; Mon, 20 Dec 2004 21:41:47 GMT
Subject: Re: Latest patch
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux ML <selinux@tycho.nsa.gov>
In-Reply-To: <41C1BCEF.7090508@redhat.com>
References: <20041209174633.GA8179@jmh.mhn.de>
	 <1103143388.31218.33.camel@moss-lions.epoch.ncsc.mil>
	 <41C1BCEF.7090508@redhat.com>
Content-Type: text/plain
Message-Id: <1103579038.3220.19.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 20 Dec 2004 16:43:58 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged, except for the removal of the user_can_mount tunable.

Others are still using that tunable, and since it is a tunable it won't
effect those that don't want to use it.

On Thu, 2004-12-16 at 11:50, Daniel J Walsh wrote:
> Add winbind policy
> 
> Add transitionbool attribute. to indicate whether a domain should have a 
> disable_trans boolean created for that domain.
> (Mozilla and games in strict policy,  All network domains in targeted)
> 
> Added can_secsecparam
> 
> Fix httpd_sys_script_t to allow access to mysql sock file.
> 
> Began adding user configuration changes, to allow adding users in 
> different roles without policy sources installed.
> 
> Remove user_can_mount tunable.
> 

-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
