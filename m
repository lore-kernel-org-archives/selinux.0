Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l48Glhrg028604
	for <selinux@tycho.nsa.gov>; Tue, 8 May 2007 12:47:43 -0400
Received: from piratehaven.org (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l48Glgg7021562
	for <selinux@tycho.nsa.gov>; Tue, 8 May 2007 16:47:42 GMT
Date: Tue, 8 May 2007 09:47:41 -0700
From: Brian Pomerantz <bapper@piratehaven.org>
To: selinux@tycho.nsa.gov
Subject: Re: [PATCH] Basic policy representation
Message-ID: <20070508164741.GA29479@skull.piratehaven.org>
References: <bd4ee6e00a634ac9157f.1178575607@localhost.localdomain> <46408CF6.1050409@manicmethod.com> <1178636917.25354.28.camel@localhost.localdomain> <46409BB6.7040500@manicmethod.com> <1178640671.25354.49.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1178640671.25354.49.camel@localhost.localdomain>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, May 08, 2007 at 12:11:11PM -0400, Karl MacMillan wrote:
> On Tue, 2007-05-08 at 11:48 -0400, Joshua Brindle wrote:
> > Karl MacMillan wrote:
> > > On Tue, 2007-05-08 at 10:45 -0400, Joshua Brindle wrote:
> > >   
> > >> Karl MacMillan wrote:
<snip>
> > >> is it really necessary to use a char here? granted its smaller but it 
> > >> also doesn't really convey to someone new to the code what is going on. 
> > >> Perhaps a bool typemap? or short int?
> > >>
> > >>     
> > >
> > > Char isn't necessary, though I think it is a common idiom to use char as
> > > boolean in C programs. What do you mean by typemap (typedef?). I don't
> > > really think that short int is any better.
> > >
> > >   
> > 
> > oops, I meant typedef.
> > 
> 
> I've worked on codebases with and without boolean typedefs and
> personally prefer to not have a typedef. Any other opinions?
> 

Using the standard *nix form of returning int is always safe and
consistent.


BAPper

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
