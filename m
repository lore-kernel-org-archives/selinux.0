Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5UBdrgA021002
	for <selinux@tycho.nsa.gov>; Thu, 30 Jun 2005 07:39:53 -0400 (EDT)
Received: from free.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5UBcqfl025122
	for <selinux@tycho.nsa.gov>; Thu, 30 Jun 2005 11:38:52 GMT
Date: Thu, 30 Jun 2005 12:47:49 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: gyurdiev@redhat.com, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: wish-list item for selinux policy analyss
Message-ID: <20050630114749.GH8415@lkcl.net>
References: <20050630010838.GF8415@lkcl.net> <20050630011009.79646.qmail@web31609.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050630011009.79646.qmail@web31609.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Jun 29, 2005 at 06:10:09PM -0700, Casey Schaufler wrote:
> >  wrong way round, casey.
> > 
> >  intent of wish-list item is to be able to say "this
> > door
> >  hasn't been used for a year, let's brick it up".

> I get it now. My brain was still in the
> context of reducing the size of the
> policy, 

 this could help - albeit not as much as ... okay,
 separate-message-to-list-time, i have an idea.

> and I may have made a
> connection that wasn't really there.

> If the goal is to reduce the policy
> size you might use this method
> to find rules you can remove, 

 yes.

> and
> that could be denial rules, which
> would be what I objected too.

 ah :)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
