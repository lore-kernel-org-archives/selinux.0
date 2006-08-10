Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7AG1Fw5008293
	for <selinux@tycho.nsa.gov>; Thu, 10 Aug 2006 12:01:15 -0400
Received: from localhost.localdomain (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k7AG0vuR007529
	for <selinux@tycho.nsa.gov>; Thu, 10 Aug 2006 16:00:58 GMT
Subject: Re: does mv need a --context=CTX (-Z) option, too?
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Jim Meyering <jim@meyering.net>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <87y7twk4fb.fsf@rho.meyering.net>
References: <87hd0kc308.fsf@rho.meyering.net>
	 <Pine.LNX.4.64.0608100843530.4511@tachyon.snu.edu>
	 <87y7twk4fb.fsf@rho.meyering.net>
Content-Type: text/plain
Date: Thu, 10 Aug 2006 12:01:10 -0400
Message-Id: <1155225670.8018.12.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-08-10 at 17:15 +0200, Jim Meyering wrote:
> kmacmillan@mentalrootkit.com wrote:
> > On Thu, 10 Aug 2006, Jim Meyering wrote:
> >
> >> It might make sense to add a --context=CTX (-Z) option to mv.  Currently,
> >> cp, install, mkdir, mknod, mkfifo all have that option, but not mv.
> >> Most of the time, mv would have no need, since it simply calls rename.
> >> But when that fails, it reverts to using the very same copying code
> >> (copy.c) that cp uses.  It is trivial to add this option to mv, with the
> >> understanding that it'd take effect solely for e.g., cross-device moves.
> >> I.e., if you want to simulate a cross device move, you'd have to use
> >> cp -pr and rm -rf, so if it makes sense for cp to have the --context=CTX
> >> (-Z) option, then it follows that mv must accept it as well.
> >>
> >
> > I think that mv should have that option. Actually, I think that the more
> > pressing option is --preserve so that users can simulate the rename case
> > across devices.
> 
> Why would mv need a new --preserve option?
> mv already tries to preserve as much as possible when
> performing any cross-device copy.
> 

I had the impression that mv did not preserve contexts across devices,
but I guess I was mistaken.

> Admittedly, mv doesn't fail if it cannot preserve some attribute,
> but that's a POSIX requirement (cp -p *does*).  Maybe you'd like
> --preserve to change that?  I added a comment suggesting
> just such a change years ago.  From coreutils/src/mv.c:
>   x->require_preserve = false;  /* FIXME: maybe make this an option */
> but no one has been motivated to do that.
> SELinux might be the necessary prod.

That might be nice, but I don't know that it is required.

> A related option I've contemplated adding to mv is one that'd make it
> perform the move operation only if rename succeeds.  I.e., don't fall
> back on copy/remove.
> 

<snip>

> >
> > As Steve explained, this option is not safe. Trivial example: with this
> > mechanism I could potentially cause passwd to create /etc/shadow with any
> > context (well, passwd explicitly requests that context so that wouldn't
> > work, but I think you get the idea). SELinux goes to great lengths to
> > make execve safe for gaining privileges - this would go against that
> > goal.
> 
> I realize that many programs do depend on the current semantics
> (where, upon exec, the fscreate is guaranteed to be the default),
> so obviously any change that simply removes that guarantee would
> break things.  A change like I'm hinting at would require more
> than that.  Perhaps a policy as simple as allowing a new, non-default
> fscreate context IFF some other measure (exec context?) remains the
> same.  So, for a program like passwd that gets elevated privilege,
> setting the apply-on-exec fscreate context would have no effect.

Yeah - if there is no change in context that would be safe. Other
comments in the thread seem to be suggesting that the behavior that is
really needed for most of coreutils is just the preservation contexts,
so the need for this change doesn't seem as pressing (touch being the
exception - it probably needs --context).

Karl

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
