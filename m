Message-Id: <200507072013.j67KDjQ4012679@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: <gyurdiev@redhat.com>
Cc: "'Daniel J Walsh'" <dwalsh@redhat.com>, <sds@tycho.nsa.gov>,
   <selinux@tycho.nsa.gov>
Subject: RE: Useradd patchset - seeking comments..
Date: Thu, 7 Jul 2005 16:13:45 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <1120760600.2997.6.camel@celtics.boston.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Ivan Gyurdiev [mailto:gyurdiev@redhat.com]
> Sent: Thursday, July 07, 2005 2:23 PM
> To: Karl MacMillan
> Cc: 'Daniel J Walsh'; sds@tycho.nsa.gov; selinux@tycho.nsa.gov
> Subject: RE: Useradd patchset - seeking comments..
> 
> 
> > I'll try to look at these - are they against the latest CVS with the module
> > infrastructure?
> 
> No... I need to resync against that.
> 
> They're against the patched (rpm -bp):
> 
> libsepol-1.6-1
> policycoreutils-1.24-1
> checkpolicy-1.23.4-1
> libselinux-1.24-1
> shadow-utils-4.0.7-9
> 
> In other words you can't really test them out - just look at code.
> There's also some evil bugs which I just fixed today
> (I got usermod working, and fixed userdel), but I haven't
> updated patches - most of it should stay the same though.
> 
> >  Quick comment is that I don't think that the extern patch is
> > useful and worth the trouble. Things in headers are, by definition,
> exported.
> > Extern has no effect and does not add clarity IMHO.
> > http://www.eskimo.com/~scs/C-faq/q1.11.html
> 
> Noted, but I don't see why you're complaining, since
> your patch is already merged, isn't it? - shouldn't create
> problems for you.

Long term maintenance is everyone's concern and that will not be the last piece
of code that we contribute. Also, I don't like the style - I think that people
start worrying about the keyword even though it is useless. Verbosity is only
useful if it communicates something not already stated.

Karl

---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
