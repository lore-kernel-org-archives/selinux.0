Subject: Re: infelicity in context_user_set; new syscalls: setfileconat,
	etc.?
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Jim Meyering <jim@meyering.net>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <87vepdkhqt.fsf@rho.meyering.net>
References: <87zmeslb2v.fsf@rho.meyering.net>
	 <1154352403.26550.24.camel@localhost.localdomain>
	 <87vepdkhqt.fsf@rho.meyering.net>
Content-Type: text/plain
Date: Mon, 31 Jul 2006 10:02:27 -0400
Message-Id: <1154354547.26550.47.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-07-31 at 15:48 +0200, Jim Meyering wrote:
> Karl MacMillan <kmacmillan@mentalrootkit.com> wrote:
> > Looks like a documentation error to me - there is no attempt to set
> > errno in the code. In fact, most of libselinux looks like errno will
> > only get set as a result of a call to a lower level library function
> > (e.g., open or getxattr).
> >
> > Can you create a patch to correct the documentation?
> 
> I'm new to selinux, but will be happy to take a shot.
> What's the recipe for checking out the preferred libselinux sources?
> Are there any patch submission guidelines?
> 

The source is at http://selinux.sourceforge.net/ - specifically at
http://sourceforge.net/svn/?group_id=21266.

Just post a patch to the list.

> >> Has anyone considered adding these system calls?
> >>   getfileconat
> >>   lgetfileconat
> >>   setfileconat
> >>   lsetfileconat
> >>
> >> They'd be useful for the same reasons openat, lstatat, etc.
> >> are useful (and are now in the Linux kernel).
> >
> > Seems much simpler to use fgetfilecon, etc. that take a fd instead of a
> > path. They can be used in conjunction with openat and do not require a
> > new system call.
> 
> It would be simpler, indeed.
> Unfortunately, that approach fails for any file that cannot be opened,
> while the *fileconat approach imposes no extra restrictions.
> 

Got it - Steve has the better solution in his mail (as usual).

Karl



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
