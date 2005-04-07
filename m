Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j37IR0ue028899
	for <selinux@tycho.nsa.gov>; Thu, 7 Apr 2005 14:27:00 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j37ILbsH012563
	for <selinux@tycho.nsa.gov>; Thu, 7 Apr 2005 18:21:39 GMT
Date: Thu, 7 Apr 2005 19:33:07 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: I am attempting to add a secadm_r
Message-ID: <20050407183307.GA19784@lkcl.net>
References: <425553ED.1040703@redhat.com> <20050407164645.GX19784@lkcl.net> <1112893253.27110.62.camel@moss-spartans.epoch.ncsc.mil> <20050407174544.GY19784@lkcl.net> <1112895576.27110.86.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1112895576.27110.86.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Apr 07, 2005 at 01:39:36PM -0400, Stephen Smalley wrote:

> >  if secadm could be drastically restricted to pretty much only be
> >  able to run policy / labelling selinux command tools - even better.
> 
> Problematic at present, given that policy is modified in source form,
> unless you want to require all policy modifications to be done off-line
> and then only allow updated binary policy to be installed by the secadm.

 the arrangement that i have is complicated by the fact that
 when a new user is added, some additions to about three
 policy source files are also required, which defines some new
 domains under which the user is exclusively allowed access to
 a subdirectory of the transfer area and to that area _alone_.

 i am therefore giving serious consideration to writing this as a
 script, which the day-to-day operator will be allowed to run (yes,
 there could end up being hundreds of new users, each with their own
 separate and exclusively accessible transfer area)

 and setting up a domain under which this script can be run, and
 allowing the operator to run it.

 that is the _only_ way that i would normally like policy to
 be modifiable on this system - except possibly by sysadm_r.

 i could then give serious consideration to allowing staff_r the right
 to run this magic script.


 ... i get the impression that it might be better to have
 a sysadm_r role (as it presently is) which is allowed
 "EVVERRYTHING", and a second-tier role which is allowed
 "everything-sysadm-can-presently-do-except-policy-related-stuff".

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
