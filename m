Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5BGE73b028826
	for <selinux@tycho.nsa.gov>; Wed, 11 Jun 2008 12:14:07 -0400
Subject: Re: [RFC] Context ordering based on MLS dominance.
From: Dave Quigley <dpquigl@tycho.nsa.gov>
To: casey@schaufler-ca.com
Cc: selinux@tycho.nsa.gov, Joshua Brindle <method@manicmethod.com>,
        bwhalen@tresys.com
In-Reply-To: <484FF517.4030400@schaufler-ca.com>
References: <1213194852.16897.60.camel@moss-terrapins.epoch.ncsc.mil>
	 <484FF517.4030400@schaufler-ca.com>
Content-Type: text/plain
Date: Wed, 11 Jun 2008 12:05:30 -0400
Message-Id: <1213200330.16897.83.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2008-06-11 at 08:53 -0700, Casey Schaufler wrote:
> Dave Quigley wrote:
> > This patch set was original made to help in providing unioned polyinstantiated
> > directories for MLS. The method used Unionfs to order the branches from the
> > highest to lowest levels so when a process at a certain level listed the
> > directory contents it would see all of the polyinstantiated directories as one
> > with duplicates exposing the document at the highest level found.
> >
> >   
> 
> How do you address TS/A and TS/B objects with the same name in
> the presence of a TS/A,B subject? In B&L neither is "higher"
> than the other, they are incomparable, and the subject should
> be able to read both. I suppose you could chose and document
> secondary criteria, but I shouldn't think that very satisfactory.
> 

This work was done as a prototype when I initially interned here. There
were still many concerns left unaddressed this being one of them. One of
the ideas we had was to modify unionfs such that instead of removing
duplicates you modified the name to reflect its security level. This
would mean you would see TS/A and TS/B in the directory. The problem
with this is that you run into the names getting too long and possibly
going over the max component length for a name (this is a similar
problem to the .wh. prefix that is added to the names for whiteout
support). Another option would be to modify the readdir code such that
it would give back the name and all of the levels/categories it existed
at. Then you could have a way of opening the file at a particular
level/category 

Regardless this is just a userspace interface to expose the SELinux
computation that the kernel already has. Looking at it the current
interface doesn't seem to handle incomparable properly but we are
waiting on Josh to decide if this can be done in libsepol instead. He
seems to want to be able to sort a large number of contexts at once and
as Steve said before having the kernel sort an array of contexts of
arbitrary length isn't a good idea.

> 
> > Others have expressed a need for this functionality so the patches have been
> > revived. The question is should this be done as a kernel interface or should
> > it be done on the on disk policy file using libsepol?
> >
> > The kernel patch is based off of Linus' current git tree as of 6/10 while the
> > libselinux patch is based off of the current svn tree from sourceforge as of
> > the same date. The patches went through testing initially when I was working
> > on polyinstantiated directories but I haven't tested the new version so give
> > them a try and see if they meet your needs.
> >
> >   
> 
> Whichever way you would do it, I don't think you've
> got a general solution to the problem.

I'm not sure how much more general it can be since all it is doing is
reflecting what is in the kernel policy. We need to send non-comparable
back up from the kernel in the case you mentioned above but we will see
which direction it goes in.

> 
> > Dave
> >
> >
> > --
> > This message was distributed to subscribers of the selinux mailing list.
> > If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> > the words "unsubscribe selinux" without quotes as the message.
> >
> >
> >   
> 
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
