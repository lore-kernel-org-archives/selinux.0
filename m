Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0CInGIi017951
	for <selinux@tycho.nsa.gov>; Wed, 12 Jan 2005 13:49:16 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0CInIgF000193
	for <selinux@tycho.nsa.gov>; Wed, 12 Jan 2005 18:49:18 GMT
Subject: Re: [patch] screen_macros.te
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Greg Norris <haphazard@kc.rr.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <20050104233401.GA11885@yggdrasil.localdomain>
References: <20050104230149.GA10317@yggdrasil.localdomain>
	 <20050104233401.GA11885@yggdrasil.localdomain>
Content-Type: text/plain
Message-Id: <1105555883.11834.35.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 12 Jan 2005 13:51:23 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.

On Tue, 2005-01-04 at 18:34, Greg Norris wrote:
> On Tue, Jan 04, 2005 at 05:01:49PM -0600, Greg Norris wrote:
> > One of the entries had the parameters backward, which prevented screen
> > from HUPing it's parent.  This was causing "power detach" to fail.
> 
> After further testing, it seems that screen actually requires both 
> variations.  Here's an updated patch... please disregard my original 
> version.
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
