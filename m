Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6VEf7aO005638
 for <selinux@tycho.nsa.gov>; Fri, 31 Jul 2015 10:41:07 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Amir Goldstein <amir@cellrox.com>
References: <CAOQ4uxiWO_Tkd2QrfLsBmq3aVAfBsDGmXYRZgMMzk+UU35dPdg@mail.gmail.com>
Date: Fri, 31 Jul 2015 09:34:25 -0500
In-Reply-To: <CAOQ4uxiWO_Tkd2QrfLsBmq3aVAfBsDGmXYRZgMMzk+UU35dPdg@mail.gmail.com>
 (Amir Goldstein's message of "Fri, 31 Jul 2015 11:36:07 +0300")
Message-ID: <87fv44iefi.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH 1/7] fs: Add user namesapace member to struct super_block
Cc: Serge Hallyn <serge.hallyn@canonical.com>, Theodore Ts'o <tytso@mit.edu>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Andy Lutomirski <luto@amacapital.net>,
 "J. Bruce Fields" <bfields@fieldses.org>,
 Seth Forshee <seth.forshee@canonical.com>,
 LSM List <linux-security-module@vger.kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, SELinux-NSA <selinux@tycho.nsa.gov>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Jeff Layton <jlayton@poochiereds.net>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Amir Goldstein <amir@cellrox.com> writes:

> On Thu, Jul 16, 2015 at 5:47 AM, Eric W. Biederman
> <ebiederm@xmission.com> wrote:
>> Seth Forshee <seth.forshee@canonical.com> writes:
>>
>>> Initially this will be used to eliminate the implicit MNT_NODEV
>>> flag for mounts from user namespaces. In the future it will also
>>> be used for translating ids and checking capabilities for
>>> filesystems mounted from user namespaces.
>>>
>>> s_user_ns is initialized in alloc_super() and is generally set to
>>> current_user_ns(). To avoid security and corruption issues, two
>>> additional mount checks are also added:
>>>
>>>  - do_new_mount() gains a check that the user has CAP_SYS_ADMIN
>>>    in current_user_ns().
>>>
>>>  - sget() will fail with EBUSY when the filesystem it's looking
>>>    for is already mounted from another user namespace.
>>>
>>> proc needs some special handling here. The user namespace of
>>> current isn't appropriate when forking as a result of clone (2)
>>> with CLONE_NEWPID|CLONE_NEWUSER, as it will make proc unmountable
>>> from within the new user namespace. Instead, the user namespace
>>> which owns the new pid namespace should be used. sget_userns() is
>>> added to allow passing of a user namespace other than that of
>>> current, and this is used by proc_mount(). sget() becomes a
>>> wrapper around sget_userns() which passes current_user_ns().
>>
>> From bits of the previous conversation.
>>
>> We need sget_userns(..., &init_user_ns) for sysfs.  The sysfs
>> xattrs can travel from one mount of sysfs to another via the sysfs
>> backing store.
>>
>> For tmpfs and any other filesystems we support mounting without
>> privilige that support xattrs.  We need to identify them and
>> see if userspace is taking advantage of the ability to set
>> xattrs and file caps (unlikely).  If they are we need to call
>> sget_userns(..., &init_user_ns) on those filesystems as well.
>>
>> Possibly/Probably we should just do that for all of the interesting
>> filesystems to start with and then change back to an ordinary old sget
>> after we have done the testing and confirmed we will not be introducing
>> userspace regressions.
>
> Eric,
>
> Perhaps it is too soon to discuss here, but how do you envision
> handling of file system private mount options in user ns.
>
> For example, suppose that we get to a point where we can trust
> an ext4 loopback mount to be non vulnerable to exploits.
> That loopback mounted fs could very well have errors and so
> error=panic option would be very much undesired from unprivileged user mount.
>
> Do you think this would require extra flags/callbacks from VFS to
> file system code or would s_user_ns be sufficient?

This case is easy.  In mount or remount we just need to check
capable(CAP_SYS_ADMIN) if someone sets error=panic, and if the capable
call fails don't allow the mount or the remount.

But this corner case is another good reminder that we have to be very
deliberate and very careful before we enable mounting a filesystem this
way.

Eric
