Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5U10cgA018287
	for <selinux@tycho.nsa.gov>; Wed, 29 Jun 2005 21:00:38 -0400 (EDT)
Received: from free.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5U0x5dE015229
	for <selinux@tycho.nsa.gov>; Thu, 30 Jun 2005 00:59:05 GMT
Date: Thu, 30 Jun 2005 02:08:38 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: gyurdiev@redhat.com, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: wish-list item for selinux policy analyss
Message-ID: <20050630010838.GF8415@lkcl.net>
References: <1120058832.17121.38.camel@celtics.boston.redhat.com> <20050629165658.82487.qmail@web31609.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050629165658.82487.qmail@web31609.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Jun 29, 2005 at 09:56:58AM -0700, Casey Schaufler wrote:
> 
> 
> --- Ivan Gyurdiev <gyurdiev@redhat.com> wrote:
> 
> > >  reason for this is to be able to fire up a
> > system, run
> > > it for a while (live) say oh a few months, and
> > then determine
> > > which bits of the selinux policy.conf have never
> > ever actually
> > > been used.
> > 
> > I see several problems with this idea:
> 
> I say amen to points 1-3. I add ...
> 
> 4) A derived policy set will only tell you
> what the programs do, not what they are
> intended to do. Should I leave doors
> unlocked because burglers attempt
> to use them? If no burgler tries my
> door for a year does that mean having
> a lock on my door is unnecessary?
 
 wrong way round, casey.

 intent of wish-list item is to be able to say "this door
 hasn't been used for a year, let's brick it up".

 not, as you imply, "this door hasn't been tried at all in a year, let's
 now leave it wide open".

 l.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
