Subject: Re: Failed write to /selinux/context in
	selinux_trans_to_raw_contex()
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ryan Bradetich <rbradetich@gmail.com>
Cc: selinux@tycho.nsa.gov, "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <e739902b0703011324y561503a0v49ded6db4b700b8c@mail.gmail.com>
References: <e739902b0702282357i2f5645bbmab4c04a0bdb1d3f3@mail.gmail.com>
	 <1172751150.19041.536.camel@moss-spartans.epoch.ncsc.mil>
	 <e739902b0703010810g64146e59h184dfe13365e16ce@mail.gmail.com>
	 <1172765760.19041.578.camel@moss-spartans.epoch.ncsc.mil>
	 <e739902b0703011324y561503a0v49ded6db4b700b8c@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 02 Mar 2007 07:14:46 -0500
Message-Id: <1172837686.19041.622.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-03-01 at 13:24 -0800, Ryan Bradetich wrote:
> Ah ha.  The last piece was the piece I was missing.  The base-only
> policy has the roles defined and authorized for the specific
> domain/type.  I also have the domain/type defined, but I do not have
> any transitions into it.  I will test this out later tonight by adding
> the appropriate transition.

Why re-invent the wheel?  Just use userdomain, and gradually pare it
down, testing along the way.

> Excellent.  I will look into this as well.  Is the login app required
> to run in a specific context?  Or just a context that has the
> appropriate permissions to transfer to the domain the user is in?

There isn't any requirement for a fixed context, just that the proper
type transitions and allow rules are defined.  But it should be easier
to re-use the existing login domain (locallogin) and user domain
(userdomain) definitions as a starting point and pare them down than
re-inventing them.

> > It didn't fail to write, but the write reported invalid argument, i.e.
> > the context written was not valid per policy.  That's the point of
> > writing it to /selinux/context - to check its validity against policy.
> 
> Make sense.  This is something I will probably dig into later ...
> sounds interesting and I am curious to understand exactly how it works
> :)

/selinux has a pseudo filesystem (selinuxfs) mounted on it, which is
actually an interface for interacting with the kernel's security
server / policy engine as well as setting certain parameters.  Similar
to other pseudo filesystems used for control functions.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
