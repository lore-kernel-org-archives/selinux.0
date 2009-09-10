Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n8AMRSGD008096
	for <selinux@tycho.nsa.gov>; Thu, 10 Sep 2009 18:27:28 -0400
Received: from goalkeeper.city-fan.org (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n8AMSluO029625
	for <selinux@tycho.nsa.gov>; Thu, 10 Sep 2009 22:28:48 GMT
Date: Thu, 10 Sep 2009 23:27:14 +0100
From: Paul Howarth <paul@city-fan.org>
To: Stefan Schulze Frielinghaus <stefan@seekline.net>
Cc: selinux@tycho.nsa.gov, "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: [refpolicy] new policy for dkim-filter
Message-ID: <20090910232714.2ae22bf2@metropolis.intra.city-fan.org>
In-Reply-To: <1252619448.22997.12.camel@vogon.seekline.net>
References: <1252611656.2486.44.camel@vogon.seekline.net>
	<20090910210421.150ff80f@metropolis.intra.city-fan.org>
	<1252615167.22997.1.camel@vogon.seekline.net>
	<1252619448.22997.12.camel@vogon.seekline.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 10 Sep 2009 23:50:48 +0200
Stefan Schulze Frielinghaus <stefan@seekline.net> wrote:

> On Thu, 2009-09-10 at 22:39 +0200, Stefan Schulze Frielinghaus wrote:
> > On Thu, 2009-09-10 at 21:04 +0100, Paul Howarth wrote:
> > > On Thu, 10 Sep 2009 21:40:56 +0200
> > > Stefan Schulze Frielinghaus <stefan@seekline.net> wrote:
> > > 
> > > > Attached is a new policy for the dkim-filter application.
> > > > 
> > > > Chris, is the policy OK/ready for merge?
> > > 
> > > I think it would be better to merge it with the milter policy.
> > > That would then need no changes to the sendmail policy and the
> > > milter should work with postfix too.
> > 
> > Oh sure, milter_template() is far better for this. I wasn't aware of
> > such a template. I will have a look at it and send a corrected
> > version.
> 
> And here we are. Since the milter_template() is pretty straight
> forward I guess we are done now. Thanks again for the tip.
> 
> DKIM-Filter runs fine for me with the new milter policy.

Given that the upstream project is called dkim-milter (albeit the
milter part is called dkimfilter), I think the dkimfilter_milter_*
types would be better named as just dkim_milter_*.

Otherwise looks sane to me.

Paul.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
