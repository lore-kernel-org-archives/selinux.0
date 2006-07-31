From: Jim Meyering <jim@meyering.net>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: SELinux@tycho.nsa.gov
Subject: Re: infelicity in context_user_set; new syscalls: setfileconat, etc.?
In-Reply-To: <1154352403.26550.24.camel@localhost.localdomain> (Karl
	MacMillan's message of "Mon, 31 Jul 2006 09:26:43 -0400")
References: <87zmeslb2v.fsf@rho.meyering.net>
	<1154352403.26550.24.camel@localhost.localdomain>
Date: Mon, 31 Jul 2006 15:48:26 +0200
Message-ID: <87vepdkhqt.fsf@rho.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karl MacMillan <kmacmillan@mentalrootkit.com> wrote:
> Looks like a documentation error to me - there is no attempt to set
> errno in the code. In fact, most of libselinux looks like errno will
> only get set as a result of a call to a lower level library function
> (e.g., open or getxattr).
>
> Can you create a patch to correct the documentation?

I'm new to selinux, but will be happy to take a shot.
What's the recipe for checking out the preferred libselinux sources?
Are there any patch submission guidelines?

>> Has anyone considered adding these system calls?
>>   getfileconat
>>   lgetfileconat
>>   setfileconat
>>   lsetfileconat
>>
>> They'd be useful for the same reasons openat, lstatat, etc.
>> are useful (and are now in the Linux kernel).
>
> Seems much simpler to use fgetfilecon, etc. that take a fd instead of a
> path. They can be used in conjunction with openat and do not require a
> new system call.

It would be simpler, indeed.
Unfortunately, that approach fails for any file that cannot be opened,
while the *fileconat approach imposes no extra restrictions.

> Currently there are no system calls for SELinux and I doubt that there
> would be much enthusiasm for them upstream.

I'm not holding my breath.
Besides, I was never really convinced it was worthwhile.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
