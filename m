Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4BIk10i010318
	for <selinux@tycho.nsa.gov>; Fri, 11 May 2007 14:46:01 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4BIk0Dl008278
	for <selinux@tycho.nsa.gov>; Fri, 11 May 2007 18:46:00 GMT
Subject: Re: [PATCH] Basic policy representation
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Joshua Brindle <method@manicmethod.com>
Cc: Brian Pomerantz <bapper@piratehaven.org>, selinux@tycho.nsa.gov
In-Reply-To: <46448B61.9080808@manicmethod.com>
References: <bd4ee6e00a634ac9157f.1178575607@localhost.localdomain>
	 <46408CF6.1050409@manicmethod.com>
	 <1178636917.25354.28.camel@localhost.localdomain>
	 <46409BB6.7040500@manicmethod.com>
	 <1178640671.25354.49.camel@localhost.localdomain>
	 <20070508164741.GA29479@skull.piratehaven.org>
	 <1178653280.3155.6.camel@localhost.localdomain>
	 <1178719410.2379.32.camel@localhost.localdomain>
	 <46448B61.9080808@manicmethod.com>
Content-Type: text/plain
Date: Fri, 11 May 2007 14:45:58 -0400
Message-Id: <1178909158.11064.24.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-05-11 at 11:27 -0400, Joshua Brindle wrote:
> Karl MacMillan wrote:
> > On Tue, 2007-05-08 at 15:41 -0400, Karl MacMillan wrote:
> >   
> >> I actually prefer returning char instead - to me that is a common way to
> >> indicate that the returned value has a limited range of values (2 in
> >> this case). But maybe that is just the code bases I've worked on. I
> >> don't care either way - this seems like a bike shed discussion . . .
> >>
> >>     
> >
> > On the other hand, the existing code (for things like sepol_bool) uses
> > int for boolean values. So I'll change to using int everywhere.
> > Ahh . . . the bike shed looks much nicer painted blue rather than green.
> >   
> Not to drag this mostly irrelevant discussion out longer but the setools 
> guys have decided to move to using stdbool.h and proper bool types for 
> all their boolean functions, is there a reason we can't do that? I was 
> surprised to find out that setting a bool value to anything other than 0 
> would cause it to be 1, so it really behaves like a boolean (strange.. 
> I'm not use to C doing things the way you'd expect them to :P )
> 

I'm fine with that - actually I'm fine with any C99 usage in libsepol as
long as Steve agrees. Will you send a patch?

> Also the bikeshed should be red.
> 

Sure :)

Karl



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
