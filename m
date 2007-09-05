Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l85HMpsP013383
	for <selinux@tycho.nsa.gov>; Wed, 5 Sep 2007 13:22:51 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l85HMnMO016258
	for <selinux@tycho.nsa.gov>; Wed, 5 Sep 2007 17:22:49 GMT
Subject: Re: tunable and if-else conditional
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stefan Schulze Frielinghaus <stefan@sf-net.com>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <6E78FE11-FAA3-4C3B-A87E-FA60ABB71863@sf-net.com>
References: <6E78FE11-FAA3-4C3B-A87E-FA60ABB71863@sf-net.com>
Content-Type: text/plain
Date: Wed, 05 Sep 2007 17:21:27 +0000
Message-Id: <1189012887.30065.31.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-09-05 at 17:35 +0200, Stefan Schulze Frielinghaus wrote:
> reading an older poste (http://www.nsa.gov/selinux/list-archive/0610/ 
> thread_body16.cfm) I wonder about the difference between tunable and  
> an if-else conditional.
> 
> <quote>
> Tunable_policy are blocks that will be replaced by a similar language  
> feature when it becomes available. Tunables will be similar to  
> conditionals, except they will be selected during the policy module  
> linking instead of being selectable at runtime.
> </quote>
> 
> Using the latest stable refpolicy (20070629) the feature has already  
> changed? I would guess so because I can change the booleans via  
> setsebool at runtime.

No, true tunables require support in the toolchain.  That won't happen
until after the new policy representation is completed.

> Looking at the file "loadable_module.spt" the tunable seems to me  
> exact the same like a if-else conditional. But I'm not a M4 guy and  
> wanted to make sure. Is this right that a tunable and a if-else  
> conditional is the same now?

Tunables are implemented as conditional policy right now.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
