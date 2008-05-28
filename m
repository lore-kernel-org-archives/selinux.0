Subject: Re: rbacsep: collapsing xserver
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Joe Nall <joe@nall.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>,
        Eamon Walsh <ewalsh@tycho.nsa.gov>
In-Reply-To: <ddbc00640805280942n4ca2619h6185e89dc7d3c108@mail.gmail.com>
References: <1211985533.5008.116.camel@gorn.columbia.tresys.com>
	 <ddbc00640805280816i24c06b68u65a7e4d7b68bf213@mail.gmail.com>
	 <1211990530.5008.127.camel@gorn.columbia.tresys.com>
	 <ddbc00640805280942n4ca2619h6185e89dc7d3c108@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Date: Wed, 28 May 2008 14:16:38 -0400
Message-Id: <1211998598.5008.138.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2008-05-28 at 11:42 -0500, Joe Nall wrote:
> On Wed, May 28, 2008 at 11:02 AM, Christopher J. PeBenito
> <cpebenito@tresys.com> wrote:
> > On Wed, 2008-05-28 at 10:16 -0500, Joe Nall wrote:
> >> On Wed, May 28, 2008 at 9:38 AM, Christopher J. PeBenito
> >> <cpebenito@tresys.com> wrote:
> >> > I've got to the point where I am collapsing the derived types in the
> >> > xserver module.  It would be nice to collapse all of the X server
> >> > domains into xserver_t, but we have xdm_xserver_t which has permissions
> >> > greater than user_xserver_t, staff_server_t, etc.  However, just about
> >> > everyone runs their xserver in xdm_xserver_t due to logging in via xdm.
> >> > Thoughts on collapsing all of the xservers anyway?
> >>
> >> Why is the way the xserver gets launched important once it is running?
> >
> > If you log into the console and run startx, your xserver is
> > user_xserver_t, staff_xserver_t, etc.  ﻿If you log in via a display
> > manager, your xserver is xdm_xserver_t, since the server is started by
> > xdm before a user logs in.  So you lose separation if you log in via
> > xdm.
> 
> Understood.
> 
> > There have been suggestions about either restarting the xserver or
> > dyntransitioning it to the correct context after logging in, but nothing
> > materialized on that.
> >
> >> Does that change when X is an object manager?
> >
> > No.
> 
> Poorly worded question. _Should_ that change when X is a object manager?

We would certainly prefer that each role always has their derived type
xserver (or role is set on xserver, if rbacsep succeeds), regardless if
its an object manager or not.

> What is the driver for the derived types? User preference files in
> their home directory?
> 
> >
> >> On a related topic, what is the type enforcement strategy for window managers?
> >
> > They currently run in the user's context.  The basic templates in the
> > policy should still allow for separations.  The policy for X objects is
> > still immature, so I'm definitely open to suggestions.
> 
> I did some brief experiments with the X server in MLS enforcing mode a
> while back and it looked like a separate type would be required to
> avoid giving the user silly levels of privilege. I'll try to get back
> to those experiments next week.
>
> Any opinions on spitting the display manager (gdm/xdm) policy out of
> the xserver policy? The current xserver policy is quite a bit bigger
> than apache and several times the average policy size (te + if).

You can blame me for that.  The xdm policy used to be separate before
refpolicy, but it was so intertwined with the xserver policy that there
wasn't a sane way to write the policies separately and still keep the
refpolicy encapsulation.  If we collapse all xservers into xserver_t, it
may be possible to separate xdm again.  If not, xdm will be put into a
tunable when we get real tunable support in the compiler.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
