Subject: Re: infelicity in context_user_set; new syscalls: setfileconat,
	etc.?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Jim Meyering <jim@meyering.net>
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>, SELinux@tycho.nsa.gov
In-Reply-To: <87vepdkhqt.fsf@rho.meyering.net>
References: <87zmeslb2v.fsf@rho.meyering.net>
	 <1154352403.26550.24.camel@localhost.localdomain>
	 <87vepdkhqt.fsf@rho.meyering.net>
Content-Type: text/plain
Date: Mon, 31 Jul 2006 10:01:30 -0400
Message-Id: <1154354490.1447.29.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-07-31 at 15:48 +0200, Jim Meyering wrote:
> I'm new to selinux, but will be happy to take a shot.
> What's the recipe for checking out the preferred libselinux sources?
> Are there any patch submission guidelines?

svn co https://svn.sourceforge.net/svnroot/selinux/trunk/libselinux

kernel coding style preferred.

> I'm not holding my breath.
> Besides, I was never really convinced it was worthwhile.

Perhaps, but it would seem to be consistent with having fstatat() and
fchmodat(), and setxattr/getxattr are more general than just SELinux, so
it would benefit ACLs and other xattr users.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
