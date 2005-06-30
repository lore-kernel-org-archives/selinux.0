Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5U1B5gA018441
	for <selinux@tycho.nsa.gov>; Wed, 29 Jun 2005 21:11:05 -0400 (EDT)
Received: from web31609.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id j5U1A879012400
	for <selinux@tycho.nsa.gov>; Thu, 30 Jun 2005 01:10:08 GMT
Message-ID: <20050630011009.79646.qmail@web31609.mail.mud.yahoo.com>
Date: Wed, 29 Jun 2005 18:10:09 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: wish-list item for selinux policy analyss
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: gyurdiev@redhat.com, SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20050630010838.GF8415@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



--- Luke Kenneth Casson Leighton <lkcl@lkcl.net>
wrote:

> On Wed, Jun 29, 2005 at 09:56:58AM -0700, Casey
> Schaufler wrote:
> > 
> > 
> > --- Ivan Gyurdiev <gyurdiev@redhat.com> wrote:
> > 
> > > >  reason for this is to be able to fire up a
> > > system, run
> > > > it for a while (live) say oh a few months, and
> > > then determine
> > > > which bits of the selinux policy.conf have
> never
> > > ever actually
> > > > been used.
> > > 
> > > I see several problems with this idea:
> > 
> > I say amen to points 1-3. I add ...
> > 
> > 4) A derived policy set will only tell you
> > what the programs do, not what they are
> > intended to do. Should I leave doors
> > unlocked because burglers attempt
> > to use them? If no burgler tries my
> > door for a year does that mean having
> > a lock on my door is unnecessary?
>  
>  wrong way round, casey.
> 
>  intent of wish-list item is to be able to say "this
> door
>  hasn't been used for a year, let's brick it up".
> 
>  not, as you imply, "this door hasn't been tried at
> all in a year, let's
>  now leave it wide open".

I get it now. My brain was still in the
context of reducing the size of the
policy, and I may have made a
connection that wasn't really there.
If the goal is to reduce the policy
size you might use this method
to find rules you can remove, and
that could be denial rules, which
would be what I objected too.

Never mind.



Casey Schaufler
casey@schaufler-ca.com


		
____________________________________________________ 
Yahoo! Sports 
Rekindle the Rivalries. Sign up for Fantasy Football 
http://football.fantasysports.yahoo.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
