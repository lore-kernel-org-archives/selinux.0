Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0GGeUZq013579
	for <selinux@tycho.nsa.gov>; Tue, 16 Jan 2007 11:40:30 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l0GGfN1E009760
	for <selinux@tycho.nsa.gov>; Tue, 16 Jan 2007 16:41:24 GMT
Subject: Re: [PATCH] add selpolgen
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <45ACFC09.5000002@tresys.com>
References: <45ACEE9E.7000709@mentalrootkit.com>
	 <45ACFC09.5000002@tresys.com>
Content-Type: text/plain
Date: Tue, 16 Jan 2007 11:40:49 -0500
Message-Id: <1168965649.10069.11.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-01-16 at 11:23 -0500, Joshua Brindle wrote:
> Karl MacMillan wrote:
> > This is a patch (available for download because of size - see url 
> > below) to add a python library named selpolgen and a new version of 
> > audit2allow that uses this library. This is a minimally changed 
> > version of what I have been calling madison.
> >
> > I am submitting this for inclusion as part of the main selinux 
> > distribution. I believe that inclusion here will help make good policy 
> > generation tools develop sooner and give a common base for creating 
> > new tools.
> >
> > Questions:
> > * I have the library at the top-level of the project - like the C 
> > libraries. Is this the best location? What about the name?
> This doesn't seem like a good place, and the upstream selinux repo 
> doesn't seem like a good dumping ground for all-things-selinux either, I 
> don't know of a better way to spur community support though.
> 

This is certainly not dumping a random selinux-related project into the
upstream repo. If you look at the code there is:

1) A replacement for audit2allow - obviously this was deemed relevant at
some point so I don't see why an improved version would not still be
relevant.

2) A well-structured python library that includes many useful features
(parsing audit messages, creating / compiling modules, generating
selinux policy, etc.) with very little overlap to the other libraries
(the main overlap is parsing - which I am actively working on merging
with libsepol / checkpolicy).

I believe that what is added in 2 is truly generally useful for selinux
related applications. Additionally, by including this code I don't that
that upstream is automatically obligated to accept any new applications
based on this.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
