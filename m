Subject: Re: rbacsep: collapsing xserver
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Cc: Joe Nall <joe@nall.com>, Xavier Toth <txtoth@gmail.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <48408967.7060104@tycho.nsa.gov>
References: <1211985533.5008.116.camel@gorn.columbia.tresys.com>
	 <ddbc00640805280816i24c06b68u65a7e4d7b68bf213@mail.gmail.com>
	 <1211990530.5008.127.camel@gorn.columbia.tresys.com>
	 <ddbc00640805280942n4ca2619h6185e89dc7d3c108@mail.gmail.com>
	 <1211998598.5008.138.camel@gorn.columbia.tresys.com>
	 <ddbc00640805281127ld1e848bs54c9f2dc53eaf8b8@mail.gmail.com>
	 <483DA6AF.1070807@redhat.com>
	 <cadfc0e40805300619l5feb8dddj7efb9f9797e3e9c3@mail.gmail.com>
	 <1212155223.31546.42.camel@gorn>
	 <ddbc00640805300801y65fb769u510cea3b1fe3c815@mail.gmail.com>
	 <48408967.7060104@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Jun 2008 14:38:56 -0400
Message-Id: <1212431936.31546.93.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2008-05-30 at 19:10 -0400, Eamon Walsh wrote:
> Joe Nall wrote:
> > On Fri, May 30, 2008 at 8:47 AM, Christopher J. PeBenito
> > <cpebenito@tresys.com> wrote:
> >   
> >> On Fri, 2008-05-30 at 08:19 -0500, Xavier Toth wrote:
> >>     
> >>> On Wed, May 28, 2008 at 1:38 PM, Daniel J Walsh <dwalsh@redhat.com> wrote:
> >>>       
> >>>> The current XAce software is far to complex to do anything usefull in my
> >>>> opinion.  We have way too many types and transitions.  We need to
> >>>> simplify down to a lot less types.
> >>>>         
> >>> Going back to Dan's concern about the complexity of the X SELinux
> >>> extension and the number of types and transitions I'd like to see some
> >>> discussion/resolution. Eamon what's your position on this topic?
> >>>       
> >> I don't want to speak for Eamon, but I suspect that he would defend the
> >> current setup since he's the one that wrote the policy.  I just
> >> restructured it to fit nicer in refpolicy and actually removed a few
> >> types :)
> >>
> >> My position is that its fine as is.  Simplifying it unconditionally
> >> starts to make it less usable for people that actually want fine grained
> >> controls on the desktop.  Making things simpler tends to be easy, since
> >> it tends to be merging types or using attributes for blanket access,
> >> like unconfined does.  The black magic voodoo that happens in the
> >> xserver, that only a select few have previously known about, has only
> >> recently been exposed via the SELinux controls.  I feel that it may be
> >> premature to simplify the policy, since side effects probably aren't
> >> well understood yet.  At least they aren't understood well by me yet.
> >>     
> 
> I never signed up to write "the SELinux policy" for X.

﻿I never claimed you did.  However, most of the rules on X objects in
refpolicy right now are a refinement of what you wrote.  Thats all that
I meant.  I know its up to me and other policy writers/contributors to
get this going.

> It is my responsibility to document my work so that others can write
> such policies, and I will do so.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
