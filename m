Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5TGw6gA013957
	for <selinux@tycho.nsa.gov>; Wed, 29 Jun 2005 12:58:06 -0400 (EDT)
Received: from web31609.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id j5TGuadE009408
	for <selinux@tycho.nsa.gov>; Wed, 29 Jun 2005 16:56:36 GMT
Message-ID: <20050629165658.82487.qmail@web31609.mail.mud.yahoo.com>
Date: Wed, 29 Jun 2005 09:56:58 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: wish-list item for selinux policy analyss
To: gyurdiev@redhat.com, Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1120058832.17121.38.camel@celtics.boston.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



--- Ivan Gyurdiev <gyurdiev@redhat.com> wrote:

> >  reason for this is to be able to fire up a
> system, run
> > it for a while (live) say oh a few months, and
> then determine
> > which bits of the selinux policy.conf have never
> ever actually
> > been used.
> 
> I see several problems with this idea:

I say amen to points 1-3. I add ...

4) A derived policy set will only tell you
what the programs do, not what they are
intended to do. Should I leave doors
unlocked because burglers attempt
to use them? If no burgler tries my
door for a year does that mean having
a lock on my door is unnecessary?




Casey Schaufler
casey@schaufler-ca.com

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
