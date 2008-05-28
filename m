Subject: Re: rbacsep: collapsing xserver
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Joe Nall <joe@nall.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>,
        Eamon Walsh <ewalsh@tycho.nsa.gov>
In-Reply-To: <ddbc00640805280816i24c06b68u65a7e4d7b68bf213@mail.gmail.com>
References: <1211985533.5008.116.camel@gorn.columbia.tresys.com>
	 <ddbc00640805280816i24c06b68u65a7e4d7b68bf213@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Date: Wed, 28 May 2008 12:02:10 -0400
Message-Id: <1211990530.5008.127.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2008-05-28 at 10:16 -0500, Joe Nall wrote:
> On Wed, May 28, 2008 at 9:38 AM, Christopher J. PeBenito
> <cpebenito@tresys.com> wrote:
> > I've got to the point where I am collapsing the derived types in the
> > xserver module.  It would be nice to collapse all of the X server
> > domains into xserver_t, but we have xdm_xserver_t which has permissions
> > greater than user_xserver_t, staff_server_t, etc.  However, just about
> > everyone runs their xserver in xdm_xserver_t due to logging in via xdm.
> > Thoughts on collapsing all of the xservers anyway?
> 
> Why is the way the xserver gets launched important once it is running?

If you log into the console and run startx, your xserver is
user_xserver_t, staff_xserver_t, etc.  ﻿If you log in via a display
manager, your xserver is xdm_xserver_t, since the server is started by
xdm before a user logs in.  So you lose separation if you log in via
xdm.

There have been suggestions about either restarting the xserver or
dyntransitioning it to the correct context after logging in, but nothing
materialized on that.

> Does that change when X is an object manager?

No.

> On a related topic, what is the type enforcement strategy for window managers?

They currently run in the user's context.  The basic templates in the
policy should still allow for separations.  The policy for X objects is
still immature, so I'm definitely open to suggestions.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
