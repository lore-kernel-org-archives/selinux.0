Subject: Re: [PATCH 1/7] fs: Add user namesapace member to struct super_block
To: Seth Forshee <seth.forshee@canonical.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>
References: <1436989569-69582-1-git-send-email-seth.forshee@canonical.com>
 <1436989569-69582-2-git-send-email-seth.forshee@canonical.com>
 <87a8uw95u8.fsf@x220.int.ebiederm.org> <20150805210355.GA10680@ubuntu-hedt>
 <87614tph6g.fsf@x220.int.ebiederm.org> <20150806142029.GB63559@ubuntu-hedt>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <55C37464.50401@tycho.nsa.gov>
Date: Thu, 6 Aug 2015 10:51:16 -0400
MIME-Version: 1.0
In-Reply-To: <20150806142029.GB63559@ubuntu-hedt>
Content-Type: text/plain; charset=windows-1252
Cc: Serge Hallyn <serge.hallyn@canonical.com>, linux-kernel@vger.kernel.org,
 Andy Lutomirski <luto@amacapital.net>,
 "J. Bruce Fields" <bfields@fieldses.org>, linux-fsdevel@vger.kernel.org,
 linux-security-module@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>, selinux@tycho.nsa.gov,
 Jeff Layton <jlayton@poochiereds.net>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 08/06/2015 10:20 AM, Seth Forshee wrote:
> On Wed, Aug 05, 2015 at 04:19:03PM -0500, Eric W. Biederman wrote:
>> Seth Forshee <seth.forshee@canonical.com> writes:
>>
>>> On Wed, Jul 15, 2015 at 09:47:11PM -0500, Eric W. Biederman wrote:
>>>> Seth Forshee <seth.forshee@canonical.com> writes:
>>>>
>>>>> Initially this will be used to eliminate the implicit MNT_NODEV
>>>>> flag for mounts from user namespaces. In the future it will also
>>>>> be used for translating ids and checking capabilities for
>>>>> filesystems mounted from user namespaces.
>>>>>
>>>>> s_user_ns is initialized in alloc_super() and is generally set to
>>>>> current_user_ns(). To avoid security and corruption issues, two
>>>>> additional mount checks are also added:
>>>>>
>>>>>  - do_new_mount() gains a check that the user has CAP_SYS_ADMIN
>>>>>    in current_user_ns().
>>>>>
>>>>>  - sget() will fail with EBUSY when the filesystem it's looking
>>>>>    for is already mounted from another user namespace.
>>>>>
>>>>> proc needs some special handling here. The user namespace of
>>>>> current isn't appropriate when forking as a result of clone (2)
>>>>> with CLONE_NEWPID|CLONE_NEWUSER, as it will make proc unmountable
>>>>> from within the new user namespace. Instead, the user namespace
>>>>> which owns the new pid namespace should be used. sget_userns() is
>>>>> added to allow passing of a user namespace other than that of
>>>>> current, and this is used by proc_mount(). sget() becomes a
>>>>> wrapper around sget_userns() which passes current_user_ns().
>>>>
>>>> From bits of the previous conversation.
>>>>
>>>> We need sget_userns(..., &init_user_ns) for sysfs.  The sysfs
>>>> xattrs can travel from one mount of sysfs to another via the sysfs
>>>> backing store.
>>>>
>>>> For tmpfs and any other filesystems we support mounting without
>>>> privilige that support xattrs.  We need to identify them and
>>>> see if userspace is taking advantage of the ability to set
>>>> xattrs and file caps (unlikely).  If they are we need to call
>>>> sget_userns(..., &init_user_ns) on those filesystems as well.
>>>>
>>>> Possibly/Probably we should just do that for all of the interesting
>>>> filesystems to start with and then change back to an ordinary old sget
>>>> after we have done the testing and confirmed we will not be introducing
>>>> userspace regressions.
>>>
>>> I was reviewing everything in preparation for sending v2 patches, and I
>>> realized that doing this has an undesirable side effect. In patch 2 the
>>> implicit nodev is removed for unprivileged mounts, and instead s_user_ns
>>> is used to block opening devices in these mounts. When we set s_user_ns
>>> to &init_user_ns, it becomes possible to open device nodes from
>>> unprivileged mounts of these filesystems.
>>>
>>> This doesn't pose a real problem today. The only filesystems it will
>>> affect is sysfs, tmpfs, and ramfs (no others need s_user_ns =
>>> &init_user_ns for user namespace mounts), and all of these aren't
>>> problems. sysfs is okay because kernfs doesn't (currently?) allow device
>>> nodes, and a user would require CAP_MKNOD to create any device nodes in
>>> a tmpfs or ramfs mount.
>>>
>>> But for sysfs in particular it does mean that we will need to make sure
>>> that there's no way that device nodes could start appearing in an
>>> unprivileged mount.
>>
>> Good point about nodev.  
>>
>> For tmpfs and ramfs and security labels the smack policy of allowing but
>> filtering security labels mean smack once it has those bits will not
>> care which user namespace ramfs and tmpfs live in.  The labels should
>> pretty much stay the same in any case.
> 
> Smack does care which namespace ramfs and tmpfs are in. With the patch
> I've got right now, if s_user_ns != &init_user_ns and the label of an
> inode does not match that of the root inode then
> security_inode_permission() will return EACCES.
> 
> So if something with CAP_MAC_ADMIN is changing security labels in such a
> mount, suddenly those inodes might become inaccessible. And while it may
> be unlikely that anyone is doing this it's impossible for me to prove
> that's the case.
> 
>> If the same class of handling will also apply to selinux and those are
>> the only two security modules that apply labels than we can leave tmpfs
>> and ramfs with the security labels of whomever mounted them.
> 
> For SELinux I now have a patch which applies mountpoint labeling to
> mounts for which s_user_ns != &init_user_ns. I'm less sure then with
> Smack how this behavior will differ from what happens today, but my
> understanding is that this means that the label of the mountpoint is
> used for all objects from that superblock. Afaik it does not have the
> Smack behavior of denying access to filesystem objects which have a
> different label in the backing store.
> 
>> For sysfs things get a little more interesting.  Assuming tmpfs and
>> ramfs don't need s_user_ns == &init_user_ns, sysfs may be fine operating
>> with possibly invalid securitly labels set on a different mount of
>> selinux.  (I am wondering now how all of these labels work in the
>> context of nfs).
> 
> If someone was using Smack to label sysfs then a mount with s_user_ns !=
> &init_user_ns is going to leave inaccessible anything without the same
> label as the process which performed the mount.
> 
> Again with SELinux I'm less certain, but I think you could end up with a
> sysfs superblock that has mountpoint labeling, and thus any labels set
> in the mount in the init namespace would be ignored.

If you're using the logic I suggested for SELinux, then SELinux will
only use mountpoint labeling if SELinux would otherwise fetch the
extended attribute value from the filesystem via ->getxattr (this is the
SECURITY_FS_USE_XATTR test in the code).  As this is not the case for
purely in-memory filesystems like tmpfs, ramfs, or sysfs, SELinux will
still label those filesystems in the usual manner, i.e. it initially
computes a default label for new inodes, and if userspace later performs
a setxattr(), then it updates its internal state at that time from the
relevant hooks (inode_post_setxattr or inode_setsecurity).
So nothing should change for SELinux wrt labeling of tmpfs, ramfs, or
sysfs in userns mounts aside from not allowing the use of the additional
mount options (e.g. context=).

Also, a superblock can only have a single labeling behavior, so you
can't have different mounts of sysfs, one using mountpoint labeling and
one not.  An inode can only have one label, no matter how you reach it.

>> The worst case for sysfs is that we come up with a cousin of
>> SB_I_NO_EXEC say SB_I_NO_DEV.
> 
> That idea occurred to me. Or else something that indicated to the
> security module that the filesystem has no user-controlled backing store
> which could be used to inject security labels, thus allowing us to set
> s_user_ns to a non-init namespace while still allowing standard MAC
> labeling behavior.
> 
>> But at the moment I am hoping that limited label storage in a user
>> namespace as you and Casey have been talking about winds up being the
>> norm and then we can follow the standard rules for setting s_user_ns and
>> still preserve the current label setting behavior.
> 
> Unfortunately I'm afraid that's not going to work out.
> 
> Seth
> 
