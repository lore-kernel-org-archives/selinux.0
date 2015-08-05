Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t75LPoqZ025193
 for <selinux@tycho.nsa.gov>; Wed, 5 Aug 2015 17:25:50 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Seth Forshee <seth.forshee@canonical.com>
References: <1436989569-69582-1-git-send-email-seth.forshee@canonical.com>
 <1436989569-69582-2-git-send-email-seth.forshee@canonical.com>
 <87a8uw95u8.fsf@x220.int.ebiederm.org>
 <20150805210355.GA10680@ubuntu-hedt>
Date: Wed, 05 Aug 2015 16:19:03 -0500
In-Reply-To: <20150805210355.GA10680@ubuntu-hedt> (Seth Forshee's message of
 "Wed, 5 Aug 2015 16:03:55 -0500")
Message-ID: <87614tph6g.fsf@x220.int.ebiederm.org>
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

> On Wed, Jul 15, 2015 at 09:47:11PM -0500, Eric W. Biederman wrote:
>> Seth Forshee <seth.forshee@canonical.com> writes:
>> 
>> > Initially this will be used to eliminate the implicit MNT_NODEV
>> > flag for mounts from user namespaces. In the future it will also
>> > be used for translating ids and checking capabilities for
>> > filesystems mounted from user namespaces.
>> >
>> > s_user_ns is initialized in alloc_super() and is generally set to
>> > current_user_ns(). To avoid security and corruption issues, two
>> > additional mount checks are also added:
>> >
>> >  - do_new_mount() gains a check that the user has CAP_SYS_ADMIN
>> >    in current_user_ns().
>> >
>> >  - sget() will fail with EBUSY when the filesystem it's looking
>> >    for is already mounted from another user namespace.
>> >
>> > proc needs some special handling here. The user namespace of
>> > current isn't appropriate when forking as a result of clone (2)
>> > with CLONE_NEWPID|CLONE_NEWUSER, as it will make proc unmountable
>> > from within the new user namespace. Instead, the user namespace
>> > which owns the new pid namespace should be used. sget_userns() is
>> > added to allow passing of a user namespace other than that of
>> > current, and this is used by proc_mount(). sget() becomes a
>> > wrapper around sget_userns() which passes current_user_ns().
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
> I was reviewing everything in preparation for sending v2 patches, and I
> realized that doing this has an undesirable side effect. In patch 2 the
> implicit nodev is removed for unprivileged mounts, and instead s_user_ns
> is used to block opening devices in these mounts. When we set s_user_ns
> to &init_user_ns, it becomes possible to open device nodes from
> unprivileged mounts of these filesystems.
>
> This doesn't pose a real problem today. The only filesystems it will
> affect is sysfs, tmpfs, and ramfs (no others need s_user_ns =
> &init_user_ns for user namespace mounts), and all of these aren't
> problems. sysfs is okay because kernfs doesn't (currently?) allow device
> nodes, and a user would require CAP_MKNOD to create any device nodes in
> a tmpfs or ramfs mount.
>
> But for sysfs in particular it does mean that we will need to make sure
> that there's no way that device nodes could start appearing in an
> unprivileged mount.

Good point about nodev.  

For tmpfs and ramfs and security labels the smack policy of allowing but
filtering security labels mean smack once it has those bits will not
care which user namespace ramfs and tmpfs live in.  The labels should
pretty much stay the same in any case.

If the same class of handling will also apply to selinux and those are
the only two security modules that apply labels than we can leave tmpfs
and ramfs with the security labels of whomever mounted them.

For sysfs things get a little more interesting.  Assuming tmpfs and
ramfs don't need s_user_ns == &init_user_ns, sysfs may be fine operating
with possibly invalid securitly labels set on a different mount of
selinux.  (I am wondering now how all of these labels work in the
context of nfs).

The worst case for sysfs is that we come up with a cousin of
SB_I_NO_EXEC say SB_I_NO_DEV.

But at the moment I am hoping that limited label storage in a user
namespace as you and Casey have been talking about winds up being the
norm and then we can follow the standard rules for setting s_user_ns and
still preserve the current label setting behavior.

Eric
