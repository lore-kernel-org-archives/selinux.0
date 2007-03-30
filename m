Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2UIOoex029777
	for <selinux@tycho.nsa.gov>; Fri, 30 Mar 2007 14:24:50 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2UIOmnf019188
	for <selinux@tycho.nsa.gov>; Fri, 30 Mar 2007 18:24:49 GMT
Subject: Re: SELinux for upstream coreutils, finally (RFC: does mkdir need
	-Z?)
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Jim Meyering <jim@meyering.net>
Cc: russell@coker.com.au, bug-coreutils@gnu.org, selinux@tycho.nsa.gov
In-Reply-To: <87ps6qwrbe.fsf@rho.meyering.net>
References: <87tzw3x9mo.fsf@rho.meyering.net>
	 <200703302237.35950.russell@coker.com.au> <87odmayiw0.fsf@rho.meyering.net>
	 <200703310016.13634.russell@coker.com.au> <871wj6yc4q.fsf@rho.meyering.net>
	 <1175275002.3129.10.camel@localhost.localdomain>
	 <87ps6qwrbe.fsf@rho.meyering.net>
Content-Type: text/plain
Date: Fri, 30 Mar 2007 14:22:26 -0400
Message-Id: <1175278946.3602.7.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-03-30 at 19:53 +0200, Jim Meyering wrote:
> Karl MacMillan <kmacmillan@mentalrootkit.com> wrote:
> ...
> >> However, your example raises a good point: with mode-setting, we *do*
> >> have the option of selecting a default mode via the "umask" command.
> >> Currently, there is no analog to set the default SELinux file system
> >> context, and that is part of why I'm arguing for the ability to write
> >> "fscon".
> >
> > The policy can set a default that is roughly analogous to umask - but
> > appropriate to SELinux - via type transition rules with a fallback to
> > inheritance from the creating process / containing directory.
> > Matchpathcon also has some overlap here.
> 
> Do you mean we *can* implement fscon already?
> I don't think I could have misunderstood things that badly.
> 

No, I mean that type transition rules can specify types for new files
based on application / directory type pairs. This largely eliminates the
need for a umask like mechanism.

> What I meant is that because of the fscreate-context-clearing
> that happens (I think it was) at exec time, currently we can't
> write a program to implement fscon semantics.
> 

Correct. I was responding to what I thought was a suggestion that a
umask like command was generally useful by saying that there were other
mechanism already in place to largely eliminate that need.

> >> > Adding an option to utilities is by far the easiest option.
> >>
> >> In some sense (especially in the short term), it does look easier simply
> >> to add the option to each program that needs it.  And I wouldn't have to
> >> write so much, explaining my position :-)  However, as upstream maintainer,
> >> I have to try to find the right (long term) solution.  I'm reluctant
> >> to lock coreutils in to the short-term-easy solution if with a little
> >> perseverance and patience we can get to a better one.
> >
> > I think it is far from clear that fscon is a better solution, either
> > from a usage or security perspective. It also shifts complexity from
> > userspace to the kernel, which is seldom desirable.
> 
> Actually, last summer, I was actually hoping for a quick negative,
> along the lines "no, with SELinux it is not reasonable to make the
> changes required to support fscon".  But I never got that.  On the
> contrary, I got the message that it was doable, but not trivial.
> Stephen Smalley's replies gave me this impression.  Please be specific,
> if you think I misinterpreted something.
> 

It is definitely possible to implement this mechanism - it is not clear
to me that the potential benefits outweigh the potential problems.

The main concern is that a less privileged application could fool a more
privileged application into creating files with the wrong context by
allowing fscreate to be inherited across exec. With the mechanism needed
by fscon applications will need to specifically protect against this
threat (requiring code) and / or new permissions will need to be created
to allow policy to control the inheritance.

> >> As I understood the outcome of our discussions on the selinux list back in
> >> July, it would be feasible to make fscon work, but not trivial.  The main
> >> objection appeared to be that fscon would not be easy for regular users
> >> to find/understand/use, and that's why I ended up posting to fedora-list:
> >> trying to get feedback from people not already up to their elbows in
> >> the guts of SELinux.
> >
> > That wasn't what I got out of that discussion. The usability concerns
> > are important, but the proposed kernel mechanism has some serious
> > semantic issues that I don't think have been resolved. Again, I don't
> > think that we are actually searching for a better solution, but rather
> > shifting where the complexity resides. The '-Z' option, while requiring
> > changing a lot of software, is conceptually clear and doesn't require
> > much code. That makes it the better option in my opinion.
> 
> Perhaps if I knew more about SELinux, I would understand why it seems
> better to add a new option to so many tools (there are far more than just
> these four in coreutils) than to provide a single tool that could also
> be applied to programs that we don't have the luxury of adding options to.
> 
> If the people responsible for SELinux development can tell me they are
> confident that my pursuing this is not worthwhile, (i.e., fscon won't
> be implementable any time soon), I'll have no choice but to let this
> thread die.  That's what I wanted months ago -- it sure would have saved
> some debating.

Well - I'm not a kernel maintainer for SELinux so I can't really say no
to this. However, I think that pursuing it is not worthwhile.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
