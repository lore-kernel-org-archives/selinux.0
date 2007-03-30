Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2UHJ7rT026525
	for <selinux@tycho.nsa.gov>; Fri, 30 Mar 2007 13:19:07 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2UHJ5nf007497
	for <selinux@tycho.nsa.gov>; Fri, 30 Mar 2007 17:19:06 GMT
Subject: Re: SELinux for upstream coreutils, finally (RFC: does mkdir need
	-Z?)
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Jim Meyering <jim@meyering.net>
Cc: russell@coker.com.au, bug-coreutils@gnu.org, selinux@tycho.nsa.gov
In-Reply-To: <871wj6yc4q.fsf@rho.meyering.net>
References: <87tzw3x9mo.fsf@rho.meyering.net>
	 <200703302237.35950.russell@coker.com.au> <87odmayiw0.fsf@rho.meyering.net>
	 <200703310016.13634.russell@coker.com.au> <871wj6yc4q.fsf@rho.meyering.net>
Content-Type: text/plain
Date: Fri, 30 Mar 2007 13:16:42 -0400
Message-Id: <1175275002.3129.10.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-03-30 at 17:39 +0200, Jim Meyering wrote:
> Russell Coker <russell@coker.com.au> wrote:
> > On Friday 30 March 2007 23:13, Jim Meyering <jim@meyering.net> wrote:
> >> What did you think of the proposal (in the link above) for
> >>
> >>     fscon CTX mkdir /new/directory
> >>
> >> IMHO, it's not so much less "user friendly" than this equivalent:
> >>
> >>     mkdir -C CTX /new/directory
> >
> > How about:
> > umask whatever ; mkdir /new/directory
> >
> > Instead of mkdir -m whatever /new/directory?
> 
> I agree that having to use umask like that would be a pain,
> but largely because you generally want to use it in a sub-shell
> so it doesn't affect other commands.  But fscon wouldn't have
> that problem.
> 

Well - as Russell points out it does have a similar problem with
privileged commands.

> However, your example raises a good point: with mode-setting, we *do*
> have the option of selecting a default mode via the "umask" command.
> Currently, there is no analog to set the default SELinux file system
> context, and that is part of why I'm arguing for the ability to write
> "fscon".
> 

The policy can set a default that is roughly analogous to umask - but
appropriate to SELinux - via type transition rules with a fallback to
inheritance from the creating process / containing directory.
Matchpathcon also has some overlap here.

<snip>

> 
> > Adding an option to utilities is by far the easiest option.
> 
> In some sense (especially in the short term), it does look easier simply
> to add the option to each program that needs it.  And I wouldn't have to
> write so much, explaining my position :-)  However, as upstream maintainer,
> I have to try to find the right (long term) solution.  I'm reluctant
> to lock coreutils in to the short-term-easy solution if with a little
> perseverance and patience we can get to a better one.
> 

I think it is far from clear that fscon is a better solution, either
from a usage or security perspective. It also shifts complexity from
userspace to the kernel, which is seldom desirable.

> As I understood the outcome of our discussions on the selinux list back in
> July, it would be feasible to make fscon work, but not trivial.  The main
> objection appeared to be that fscon would not be easy for regular users
> to find/understand/use, and that's why I ended up posting to fedora-list:
> trying to get feedback from people not already up to their elbows in
> the guts of SELinux.
> 

That wasn't what I got out of that discussion. The usability concerns
are important, but the proposed kernel mechanism has some serious
semantic issues that I don't think have been resolved. Again, I don't
think that we are actually searching for a better solution, but rather
shifting where the complexity resides. The '-Z' option, while requiring
changing a lot of software, is conceptually clear and doesn't require
much code. That makes it the better option in my opinion.

Another important point to me: will distros just carry patches to add
'-Z' for forever? Russell seemed to indicate that Debian will and I
assume that Fedora and RHEL will. What about others - Josh/Chris, will
you continue to carry patches if necessary in Gentoo?

Karl



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
