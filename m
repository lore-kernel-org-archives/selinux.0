From: Jim Meyering <jim@meyering.net>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>, SELinux@tycho.nsa.gov
Subject: Re: infelicity in context_user_set; new syscalls: setfileconat, etc.?
In-Reply-To: <1154354490.1447.29.camel@moss-spartans.epoch.ncsc.mil> (Stephen
	Smalley's message of "Mon, 31 Jul 2006 10:01:30 -0400")
References: <87zmeslb2v.fsf@rho.meyering.net>
	<1154352403.26550.24.camel@localhost.localdomain>
	<87vepdkhqt.fsf@rho.meyering.net>
	<1154354490.1447.29.camel@moss-spartans.epoch.ncsc.mil>
Date: Mon, 31 Jul 2006 16:21:49 +0200
Message-ID: <87psflkg76.fsf@rho.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Mon, 2006-07-31 at 15:48 +0200, Jim Meyering wrote:
>> I'm new to selinux, but will be happy to take a shot.
>> What's the recipe for checking out the preferred libselinux sources?
>> Are there any patch submission guidelines?
>
> svn co https://svn.sourceforge.net/svnroot/selinux/trunk/libselinux
>
> kernel coding style preferred.

Thanks.

>> I'm not holding my breath.
>> Besides, I was never really convinced it was worthwhile.
>
> Perhaps, but it would seem to be consistent with having fstatat() and
> fchmodat(), and setxattr/getxattr are more general than just SELinux, so
> it would benefit ACLs and other xattr users.

That makes sense.
Adding lsetfileconat et al as syscalls didn't feel right.
Now that I've actually seen the implementations (and that
they're based on setxattr/getxattr), adding getxattrat/setxattrat
syscalls seems much more palatable.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
