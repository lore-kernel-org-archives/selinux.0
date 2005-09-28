Message-Id: <200509281518.j8SFInYs010087@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Stephen Smalley'" <sds@tycho.nsa.gov>,
   "'Ivan Gyurdiev'" <ivg2@cornell.edu>
Cc: <selinux@tycho.nsa.gov>, "'Joshua Brindle'" <jbrindle@tresys.com>
Subject: RE: [PATCH] semanage-functionality 11/17
Date: Wed, 28 Sep 2005 11:18:49 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1127848726.21671.114.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> Sent: Tuesday, September 27, 2005 3:19 PM
> To: Ivan Gyurdiev
> Cc: Karl MacMillan; selinux@tycho.nsa.gov; 'Joshua Brindle'
> Subject: Re: [PATCH] semanage-functionality 11/17
> 
> On Tue, 2005-09-27 at 13:00 -0400, Ivan Gyurdiev wrote:
> > Karl MacMillan wrote:
> >
> > >Makefile changes to build a shared libsemanage library.
> > >
> > >
> > I am not clear on how exporting symbols is done, but it would be better
> > if the things I'm currently working on are _not_ exported, because they
> > are in flux. What changes (if any) should I make to disable this
> > functionality?
> 
> You can mark your symbols "hidden", as libselinux does for non-static
> symbols that it doesn't want exported (e.g. see libselinux/src/trans.c).
> Or we can change libsemanage to use an explicit map like libsepol.
> 
> A good paper to read is
> http://people.redhat.com/drepper/dsohowto.pdf
> In particular, section 2.2.
> 
> We should likely be using symbol versioning as well, as discussed in
> section 3.
> 

We will move an explicit map, remove the hidden markings, and look into
symbol versioning.

Karl

> --
> Stephen Smalley
> National Security Agency



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
