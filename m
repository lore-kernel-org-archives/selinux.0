Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n8AKdb5X030534
	for <selinux@tycho.nsa.gov>; Thu, 10 Sep 2009 16:39:37 -0400
Received: from mail.seekline.net (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n8AKcuB2000611
	for <selinux@tycho.nsa.gov>; Thu, 10 Sep 2009 20:38:57 GMT
Subject: Re: [refpolicy] new policy for dkim-filter
From: Stefan Schulze Frielinghaus <stefan@seekline.net>
To: Paul Howarth <paul@city-fan.org>
Cc: selinux@tycho.nsa.gov, "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <20090910210421.150ff80f@metropolis.intra.city-fan.org>
References: <1252611656.2486.44.camel@vogon.seekline.net>
	 <20090910210421.150ff80f@metropolis.intra.city-fan.org>
Content-Type: text/plain
Date: Thu, 10 Sep 2009 22:39:27 +0200
Message-Id: <1252615167.22997.1.camel@vogon.seekline.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2009-09-10 at 21:04 +0100, Paul Howarth wrote:
> On Thu, 10 Sep 2009 21:40:56 +0200
> Stefan Schulze Frielinghaus <stefan@seekline.net> wrote:
> 
> > Attached is a new policy for the dkim-filter application.
> > 
> > Chris, is the policy OK/ready for merge?
> 
> I think it would be better to merge it with the milter policy. That
> would then need no changes to the sendmail policy and the milter should
> work with postfix too.

Oh sure, milter_template() is far better for this. I wasn't aware of
such a template. I will have a look at it and send a corrected version.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
