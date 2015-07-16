Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6G2recA022477
 for <selinux@tycho.nsa.gov>; Wed, 15 Jul 2015 22:53:40 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Seth Forshee <seth.forshee@canonical.com>
References: <1436989569-69582-1-git-send-email-seth.forshee@canonical.com>
 <1436989569-69582-2-git-send-email-seth.forshee@canonical.com>
Date: Wed, 15 Jul 2015 21:47:11 -0500
In-Reply-To: <1436989569-69582-2-git-send-email-seth.forshee@canonical.com>
 (Seth Forshee's message of "Wed, 15 Jul 2015 14:46:02 -0500")
Message-ID: <87a8uw95u8.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH 1/7] fs: Add user namesapace member to struct super_block
Cc: Serge Hallyn <serge.hallyn@canonical.com>, linux-kernel@vger.kernel.org,
 Andy Lutomirski <luto@amacapital.net>,
 "J. Bruce Fields" <bfields@fieldses.org>,
 linux-security-module@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>, selinux@tycho.nsa.gov,
 linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@poochiereds.net>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Seth Forshee <seth.forshee@canonical.com> writes:

> Initially this will be used to eliminate the implicit MNT_NODEV
> flag for mounts from user namespaces. In the future it will also
> be used for translating ids and checking capabilities for
> filesystems mounted from user namespaces.
>
> s_user_ns is initialized in alloc_super() and is generally set to
> current_user_ns(). To avoid security and corruption issues, two
> additional mount checks are also added:
>
>  - do_new_mount() gains a check that the user has CAP_SYS_ADMIN
>    in current_user_ns().
>
>  - sget() will fail with EBUSY when the filesystem it's looking
>    for is already mounted from another user namespace.
>
> proc needs some special handling here. The user namespace of
> current isn't appropriate when forking as a result of clone (2)
> with CLONE_NEWPID|CLONE_NEWUSER, as it will make proc unmountable
> from within the new user namespace. Instead, the user namespace
> which owns the new pid namespace should be used. sget_userns() is
> added to allow passing of a user namespace other than that of
> current, and this is used by proc_mount(). sget() becomes a
> wrapper around sget_userns() which passes current_user_ns().

>From bits of the previous conversation.

We need sget_userns(..., &init_user_ns) for sysfs.  The sysfs
xattrs can travel from one mount of sysfs to another via the sysfs
backing store.

For tmpfs and any other filesystems we support mounting without
privilige that support xattrs.  We need to identify them and
see if userspace is taking advantage of the ability to set
xattrs and file caps (unlikely).  If they are we need to call
sget_userns(..., &init_user_ns) on those filesystems as well.

Possibly/Probably we should just do that for all of the interesting
filesystems to start with and then change back to an ordinary old sget
after we have done the testing and confirmed we will not be introducing
userspace regressions.

Eric
