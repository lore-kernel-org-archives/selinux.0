Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n8BCkwup007417
	for <selinux@tycho.nsa.gov>; Fri, 11 Sep 2009 08:46:58 -0400
Received: from mail.seekline.net (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n8BCkG4H000506
	for <selinux@tycho.nsa.gov>; Fri, 11 Sep 2009 12:46:17 GMT
Subject: Re: [refpolicy] new policy for dkim-filter
From: Stefan Schulze Frielinghaus <stefan@seekline.net>
To: Chris PeBenito <pebenito@gentoo.org>
Cc: Paul Howarth <paul@city-fan.org>, selinux@tycho.nsa.gov
In-Reply-To: <1252672214.2937.8.camel@defiant.pebenito.net>
References: <1252611656.2486.44.camel@vogon.seekline.net>
	 <20090910210421.150ff80f@metropolis.intra.city-fan.org>
	 <1252615167.22997.1.camel@vogon.seekline.net>
	 <1252619448.22997.12.camel@vogon.seekline.net>
	 <20090910232714.2ae22bf2@metropolis.intra.city-fan.org>
	 <1252655581.2491.12.camel@vogon.seekline.net>
	 <1252657231.2491.18.camel@vogon.seekline.net>
	 <1252672214.2937.8.camel@defiant.pebenito.net>
Content-Type: text/plain
Date: Fri, 11 Sep 2009 14:46:40 +0200
Message-Id: <1252673200.2491.42.camel@vogon.seekline.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2009-09-11 at 08:30 -0400, Chris PeBenito wrote:
> On Fri, 2009-09-11 at 10:20 +0200, Stefan Schulze Frielinghaus wrote:
> > > > > > > On Thu, 10 Sep 2009 21:40:56 +0200
> > > > > > > Stefan Schulze Frielinghaus <stefan@seekline.net> wrote:
> > > > > > > 
> > > > > > > > Attached is a new policy for the dkim-filter application.
> > > > > > > > 
> > > > > > > > Chris, is the policy OK/ready for merge?
> 
> > Tested attached policy again on CentOS 5.3 with strict policy.
> 
> It looks ok.  However I'm starting to get concerned about the milter
> module getting big.  If you want, say the spamassassin milter, you add
> the milter module... but then you get rules for a several other milters
> too.

Yeah thought about that too. A quick fix would be to surround the milter
modules with booleans but I don't really like this idea. Another
solution would be to split the milter.te into several sub modules.
Any other thoughts?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
