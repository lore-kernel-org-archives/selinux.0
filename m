Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6ML3hgA009935
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 17:03:43 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6MKwrYP001090
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 20:58:54 GMT
Subject: Re: Iptables discussion
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Karl MacMillan <kmacmillan@tresys.com>,
   "'Daniel J Walsh'" <dwalsh@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <1122063513.30783.47.camel@celtics.boston.redhat.com>
References: <200507221246.j6MCkqvx015455@gotham.columbia.tresys.com>
	 <1122039886.24847.6.camel@celtics.boston.redhat.com>
	 <42E10804.5030401@tresys.com>
	 <1122046798.25951.27.camel@celtics.boston.redhat.com>
	 <42E146D3.60809@tresys.com>
	 <1122061488.30783.14.camel@celtics.boston.redhat.com>
	 <42E14F60.7090104@tresys.com>
	 <1122063513.30783.47.camel@celtics.boston.redhat.com>
Content-Type: text/plain
Date: Fri, 22 Jul 2005 16:56:25 -0400
Message-Id: <1122065786.31672.9.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> > I mean that it works conceptually, ie: the API provides everything you 
> > need. Compiling and testing is very irrelavent right now since we are 
> > trying to design a very abstract management API for SELinux, something 
> > that needs to be carefully designed.
> 
> Ok, so let's carefully design it.. and then
> add an implementation.

To expand on that:

I'll try changing my code to all those new names and functions next 
week, but off the top of my head, I can tell you that this api doesn't
work without query function, because you have a single modify function
that doesn't provide for ways to explain *how* to modify the record.
That means two things - (1) the caller needs to do the modify,
which means that query is absolutely necessary, because you
shouldn't assume the modifying application can recreate the record, 
and (2) two iterations will be required, instead of one in the flat file
case for every modify (one for the query, and one for the modify).

The second issue I have is that the homedirs thing just isn't finalized
- please respond to some of my questions about potential implementation
(see my response to Karl). My current implementation of this
is ugly, and I want to replace it, and I'm not sure how - it's a
difficult issue to deal with.

The answer to how the file_contexts issue will be handled may also
determine whether or not libsemanage needs access to the user map,
and add more arguments against/for placing map handling in libsemanage.

Let's continue this discussion next week.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
