Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l49E4gae024671
	for <selinux@tycho.nsa.gov>; Wed, 9 May 2007 10:04:43 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l49E4aAb029534
	for <selinux@tycho.nsa.gov>; Wed, 9 May 2007 14:04:37 GMT
Subject: Re: [PATCH] Basic policy representation
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Brian Pomerantz <bapper@piratehaven.org>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1178653280.3155.6.camel@localhost.localdomain>
References: <bd4ee6e00a634ac9157f.1178575607@localhost.localdomain>
	 <46408CF6.1050409@manicmethod.com>
	 <1178636917.25354.28.camel@localhost.localdomain>
	 <46409BB6.7040500@manicmethod.com>
	 <1178640671.25354.49.camel@localhost.localdomain>
	 <20070508164741.GA29479@skull.piratehaven.org>
	 <1178653280.3155.6.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 09 May 2007 10:03:30 -0400
Message-Id: <1178719410.2379.32.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-05-08 at 15:41 -0400, Karl MacMillan wrote:
> On Tue, 2007-05-08 at 09:47 -0700, Brian Pomerantz wrote:
> > On Tue, May 08, 2007 at 12:11:11PM -0400, Karl MacMillan wrote:
> > > On Tue, 2007-05-08 at 11:48 -0400, Joshua Brindle wrote:
> > > > Karl MacMillan wrote:
> > > > > On Tue, 2007-05-08 at 10:45 -0400, Joshua Brindle wrote:
> > > > >   
> > > > >> Karl MacMillan wrote:
> > <snip>
> > > > >> is it really necessary to use a char here? granted its smaller but it 
> > > > >> also doesn't really convey to someone new to the code what is going on. 
> > > > >> Perhaps a bool typemap? or short int?
> > > > >>
> > > > >>     
> > > > >
> > > > > Char isn't necessary, though I think it is a common idiom to use char as
> > > > > boolean in C programs. What do you mean by typemap (typedef?). I don't
> > > > > really think that short int is any better.
> > > > >
> > > > >   
> > > > 
> > > > oops, I meant typedef.
> > > > 
> > > 
> > > I've worked on codebases with and without boolean typedefs and
> > > personally prefer to not have a typedef. Any other opinions?
> > > 
> > 
> > Using the standard *nix form of returning int is always safe and
> > consistent.
> > 
> 
> I actually prefer returning char instead - to me that is a common way to
> indicate that the returned value has a limited range of values (2 in
> this case). But maybe that is just the code bases I've worked on. I
> don't care either way - this seems like a bike shed discussion . . .
> 

On the other hand, the existing code (for things like sepol_bool) uses
int for boolean values. So I'll change to using int everywhere.
Ahh . . . the bike shed looks much nicer painted blue rather than green.

Karl




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
