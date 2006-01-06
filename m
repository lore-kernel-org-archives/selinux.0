Message-ID: <43BED662.5040501@tresys.com>
Date: Fri, 06 Jan 2006 15:43:14 -0500
From: Chad Sellers <csellers@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux-dev@tresys.com, SELinux@tycho.nsa.gov
Subject: Re: [Fwd: Re: [RFC] SELinux file_ioctl hook permission checks	changes]
References: <1136387222.27632.243.camel@moss-spartans.epoch.ncsc.mil> <43BD92BA.6020101@tresys.com> <1136550231.27632.523.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1136550231.27632.523.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
>>>>A patch based upon Chris' comments was developed ([3]). It basically
>>>>performs a check for distinction
>>>>of a read/write ioctl command and constructs an access vector with
>>>>the getattr/setattr permissions.
>>>>Although, this approach has a potential concern. setattr permission
>>>>also covers chown/chmod and other
>>>>cases. This is the desired behavior for certain ioctl commands (ie.
>>>>EXT3_IOC_SETFLAGS) but other
>>>>ones that perform data write (write permission) may not be suitable
>>>>for setattr permission
>>>>(set attributes). One example of conflict is ssh performing an ioctl
>>>>on /dev/ptmx to allocate the
>>>>pty, triggering a setattr denial since it gets _IOC_WRITE back from
>>>>the _IOC_DIR checks in
>>>>selinux_file_ioctl hook.
>>
>>> Right, so if we stay with getattr/setattr as the ioctl permission
>>> checks, then we may need to allow setattr permission more widely
>>> than
>>> presently, which would also permit use of chown/chmod on the file.
>>> sshd
>>> has a legitimate need to write to ptmx; it doesn't need to
>>> chown/chmod
>>> it.
> On Thu, 2006-01-05 at 16:42 -0500, Chad Sellers wrote:
> 
>>We would definitely not want to add these permissions to current
>>read/write or setattr/chattr. As stated above, this would result in
>>granting extra privileges that we don't want to see. So, perhaps
>>splitting ioctl into ioctl_read, ioctl_write, ioctl_none, and ioctl_rw
>>would solve this problem.
> 
> 
> Discussion should really be on the list, where the RFC was originally
> posted.  But anyway, what you suggest would be much harder to do in any
> kind of compatible way - we need these permissions to work for all file
> classes and all socket classes (as ioctl can be applied to all file
> types), and we can't easily extend the common definition without
> perturbing the access vectors for the inheriting classes.  I'm inclined
> to just map to read/write, as I view setattr as more sensitive.
>   
Sorry for accidentally taking this off list. I re-added some context
above to clear up any confusion.

I see your point about the difficulty of my suggestion. I think mapping
ioctl to read/write might be useful, but the repercussions worry me. Not
only will this have the problems previously mentioned (requiring full
write or read for programs with previously limited access), but this
also may mean that both read and write are required for some utilities.
_IOWR is used in many drivers (sometimes legitimately, sometimes not),
which may make full read & write required for programs that only require
small control channels.

Additionally, relying on all driver writers to label the ioctl commands
properly seems precarious. At least with the separate ioctl permission,
we lumped the them all together, separate from the better defined read
and write.

So, despite my desire to map ioctls to directionality, I'm a little
worried about this approach. If we want to go that route, then I think
we at least have to do a good bit of testing to see what additional
policy will be necessary and to ensure that key drivers label their
ioctl directions properly.

Chad


-- 

----------------------
Chad Sellers
Tresys Technology, LLC
csellers@tresys.com
http://www.tresys.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
