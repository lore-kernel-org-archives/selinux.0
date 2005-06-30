Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5U0aRgA018107
	for <selinux@tycho.nsa.gov>; Wed, 29 Jun 2005 20:36:27 -0400 (EDT)
Received: from free.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5U0ZV79011126
	for <selinux@tycho.nsa.gov>; Thu, 30 Jun 2005 00:35:31 GMT
Date: Thu, 30 Jun 2005 01:37:00 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Ivan Gyurdiev <gyurdiev@redhat.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: wish-list item for selinux policy analyss
Message-ID: <20050630003700.GB8415@lkcl.net>
References: <20050629021349.GA10219@lkcl.net> <1120058832.17121.38.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1120058832.17121.38.camel@celtics.boston.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Jun 29, 2005 at 11:27:12AM -0400, Ivan Gyurdiev wrote:
> >  reason for this is to be able to fire up a system, run
> > it for a while (live) say oh a few months, and then determine
> > which bits of the selinux policy.conf have never ever actually
> > been used.
> 
> I see several problems with this idea:
> 
> 1) Usage frequency does not necessarily correlate to
> whether the rule is valid or not - you'd have to test
> every code path to establish whether the rule is needed or not.

 yes.

 this i would deem to be acceptable.

 after say six months of running a system live, i believe
 it reasonable for an admin to conclude that after such a period of time
 (they may choose a more or less acceptable period of time) that any
 rules not in use by then ain't gonna be needed.

 for that PARTICULAR config / usage pattern.

 of course, if the box requires additional packages / changes in
 requirements, the criteria changes / usage patterns change.


> I find this to be better accomplished with comments in policy
> before every group of rules (and _not_ using audit2allow).
> 
> 2) It's not clear that policy source should fit as well as possible to
> program usage patterns. Those patterns can change, and I think
> it's a good idea to leave some room for such changes - policy usually
> permits the program to do more than it actually does, and I think
> that's okay, as long as nothing dangerous is allowed. 

 i am a little fried right now to explain why i believe that is
 not a good argument, but i believe that if you look carefully
 at what you have said, you are saying "i think allowing more
 than is necessary is okay, therefore i don't think we should
 tools to people who _might_ want to go a little further / make
 a more restrictive policy because we want it to be _difficult_
 for them to disagree with us and diverge from policy source
 as controlled by us."

 if i have mistaken the intent of your statement, please
 accept my apologies for the above interpretation of what you
 have said.
 
 l.

 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
