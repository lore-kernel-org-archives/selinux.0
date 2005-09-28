Message-Id: <200509281521.j8SFL6Ys010130@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Stephen Smalley'" <sds@tycho.nsa.gov>,
   "'Ivan Gyurdiev'" <ivg2@cornell.edu>
Cc: <selinux@tycho.nsa.gov>, "'Joshua Brindle'" <jbrindle@tresys.com>
Subject: RE: [PATCH] semanage-functionality 4/17
Date: Wed, 28 Sep 2005 11:21:06 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1127851738.21671.147.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> Sent: Tuesday, September 27, 2005 4:09 PM
> To: Ivan Gyurdiev
> Cc: Karl MacMillan; selinux@tycho.nsa.gov; 'Joshua Brindle'
> Subject: Re: [PATCH] semanage-functionality 4/17
> 
> On Tue, 2005-09-27 at 12:54 -0400, Ivan Gyurdiev wrote:
> > Why is it that you have to keep re-adding the components that I'm
> > currently working on. Please leave those out of the semanage.h header
> > for now. If you don't approve of my APIs, then you should submit patches
> > on top of them, instead of introducing duplicate work. Anything that
> > says semanage_mls_* semanage_user_*, semanage_boolean_*, and
> > semanage_homedir_* should be left out for now.
> 
> Ack, I'll prune these prior to merging.
> 
> > P.S. Your semanage header should likely draw in my user/port/record
> > headers, but please don't do this yet, as those interfaces are in flux.
> > Also, I think the handle stuff and the module stuff should go into
> > separate headers, and you should include those into semanage.h.
> 
> This also makes sense to me.
> 
> A consistency nitpick:  we have decidedly mixed usage of typedefs in
> libsemanage and libsepol, with some typedefs being pointers to structs
> and others being aliases for structs.  Possibly we just need to
> aggressively prune typedefs throughout.  They seem to offer little real
> benefit for the struct types, and are more likely to just cause
> confusion in maintaining the code.
> 

I agree that making the specifics of the type clear at the point in the code
that it is used is best. Too bad we didn't strip the typedefs way back when
they were stripped from the kernel code . . .

Karl

------
Karl MacMillan
Tresys Technology
http://www.tresys.com

> --
> Stephen Smalley
> National Security Agency



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
