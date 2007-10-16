Subject: Re: kernel flask headers
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1192548290.32627.25.camel@gorn>
References: <1192547487.8702.90.camel@moss-spartans.epoch.ncsc.mil>
	 <1192548290.32627.25.camel@gorn>
Content-Type: text/plain
Date: Tue, 16 Oct 2007 11:51:29 -0400
Message-Id: <1192549889.32627.27.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-10-16 at 11:24 -0400, Christopher J. PeBenito wrote:
> On Tue, 2007-10-16 at 11:11 -0400, Stephen Smalley wrote:
> > On the refpolicy trunk, if you run make in refpolicy/policy/flask and
> > try to use the resulting kernel headers, the kernel won't build.
> > 
> > Looks like flask.py is inserting S_(0, 0, 0) lines into av_inherit.h,
> > which isn't valid in the kernel's definition of S_() there.  Should just
> > omit the line altogether I would expect.
> 
> Odd, since the script hasn't changed since March, and I though we
> verified it was putting out correct headers.

Oh I see, its the userspace classes inheriting a userspace common.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
