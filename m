Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t77EGMrs012015
 for <selinux@tycho.nsa.gov>; Fri, 7 Aug 2015 10:16:23 -0400
Received: by iodb91 with SMTP id b91so52915120iod.1
 for <selinux@tycho.nsa.gov>; Fri, 07 Aug 2015 07:16:20 -0700 (PDT)
Date: Fri, 7 Aug 2015 09:16:12 -0500
From: Seth Forshee <seth.forshee@canonical.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH 1/7] fs: Add user namesapace member to struct super_block
Message-ID: <20150807141612.GA112663@ubuntu-hedt>
References: <1436989569-69582-1-git-send-email-seth.forshee@canonical.com>
 <1436989569-69582-2-git-send-email-seth.forshee@canonical.com>
 <87a8uw95u8.fsf@x220.int.ebiederm.org>
 <20150805210355.GA10680@ubuntu-hedt>
 <87614tph6g.fsf@x220.int.ebiederm.org>
 <20150806142029.GB63559@ubuntu-hedt> <55C37464.50401@tycho.nsa.gov>
 <20150806154445.GC63559@ubuntu-hedt> <55C38749.90302@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55C38749.90302@tycho.nsa.gov>
Cc: Serge Hallyn <serge.hallyn@canonical.com>, linux-kernel@vger.kernel.org,
 Andy Lutomirski <luto@amacapital.net>,
 "J. Bruce Fields" <bfields@fieldses.org>, linux-fsdevel@vger.kernel.org,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 Jeff Layton <jlayton@poochiereds.net>,
 Alexander Viro <viro@zeniv.linux.org.uk>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Aug 06, 2015 at 12:11:53PM -0400, Stephen Smalley wrote:
> On 08/06/2015 11:44 AM, Seth Forshee wrote:
> > On Thu, Aug 06, 2015 at 10:51:16AM -0400, Stephen Smalley wrote:
> >> On 08/06/2015 10:20 AM, Seth Forshee wrote:
> >>> On Wed, Aug 05, 2015 at 04:19:03PM -0500, Eric W. Biederman wrote:
> >>>> Seth Forshee <seth.forshee@canonical.com> writes:
> >>>>
> >>>>> On Wed, Jul 15, 2015 at 09:47:11PM -0500, Eric W. Biederman wrote:
> >>>>>> Seth Forshee <seth.forshee@canonical.com> writes:
> >>>>>>
> >>>>>>> Initially this will be used to eliminate the implicit MNT_NODEV
> >>>>>>> flag for mounts from user namespaces. In the future it will also
> >>>>>>> be used for translating ids and checking capabilities for
> >>>>>>> filesystems mounted from user namespaces.
> >>>>>>>
> >>>>>>> s_user_ns is initialized in alloc_super() and is generally set to
> >>>>>>> current_user_ns(). To avoid security and corruption issues, two
> >>>>>>> additional mount checks are also added:
> >>>>>>>
> >>>>>>>  - do_new_mount() gains a check that the user has CAP_SYS_ADMIN
> >>>>>>>    in current_user_ns().
> >>>>>>>
> >>>>>>>  - sget() will fail with EBUSY when the filesystem it's looking
> >>>>>>>    for is already mounted from another user namespace.
> >>>>>>>
> >>>>>>> proc needs some special handling here. The user namespace of
> >>>>>>> current isn't appropriate when forking as a result of clone (2)
> >>>>>>> with CLONE_NEWPID|CLONE_NEWUSER, as it will make proc unmountable
> >>>>>>> from within the new user namespace. Instead, the user namespace
> >>>>>>> which owns the new pid namespace should be used. sget_userns() is
> >>>>>>> added to allow passing of a user namespace other than that of
> >>>>>>> current, and this is used by proc_mount(). sget() becomes a
> >>>>>>> wrapper around sget_userns() which passes current_user_ns().
> >>>>>>
> >>>>>> From bits of the previous conversation.
> >>>>>>
> >>>>>> We need sget_userns(..., &init_user_ns) for sysfs.  The sysfs
> >>>>>> xattrs can travel from one mount of sysfs to another via the sysfs
> >>>>>> backing store.
> >>>>>>
> >>>>>> For tmpfs and any other filesystems we support mounting without
> >>>>>> privilige that support xattrs.  We need to identify them and
> >>>>>> see if userspace is taking advantage of the ability to set
> >>>>>> xattrs and file caps (unlikely).  If they are we need to call
> >>>>>> sget_userns(..., &init_user_ns) on those filesystems as well.
> >>>>>>
> >>>>>> Possibly/Probably we should just do that for all of the interesting
> >>>>>> filesystems to start with and then change back to an ordinary old sget
> >>>>>> after we have done the testing and confirmed we will not be introducing
> >>>>>> userspace regressions.
> >>>>>
> >>>>> I was reviewing everything in preparation for sending v2 patches, and I
> >>>>> realized that doing this has an undesirable side effect. In patch 2 the
> >>>>> implicit nodev is removed for unprivileged mounts, and instead s_user_ns
> >>>>> is used to block opening devices in these mounts. When we set s_user_ns
> >>>>> to &init_user_ns, it becomes possible to open device nodes from
> >>>>> unprivileged mounts of these filesystems.
> >>>>>
> >>>>> This doesn't pose a real problem today. The only filesystems it will
> >>>>> affect is sysfs, tmpfs, and ramfs (no others need s_user_ns =
> >>>>> &init_user_ns for user namespace mounts), and all of these aren't
> >>>>> problems. sysfs is okay because kernfs doesn't (currently?) allow device
> >>>>> nodes, and a user would require CAP_MKNOD to create any device nodes in
> >>>>> a tmpfs or ramfs mount.
> >>>>>
> >>>>> But for sysfs in particular it does mean that we will need to make sure
> >>>>> that there's no way that device nodes could start appearing in an
> >>>>> unprivileged mount.
> >>>>
> >>>> Good point about nodev.  
> >>>>
> >>>> For tmpfs and ramfs and security labels the smack policy of allowing but
> >>>> filtering security labels mean smack once it has those bits will not
> >>>> care which user namespace ramfs and tmpfs live in.  The labels should
> >>>> pretty much stay the same in any case.
> >>>
> >>> Smack does care which namespace ramfs and tmpfs are in. With the patch
> >>> I've got right now, if s_user_ns != &init_user_ns and the label of an
> >>> inode does not match that of the root inode then
> >>> security_inode_permission() will return EACCES.
> >>>
> >>> So if something with CAP_MAC_ADMIN is changing security labels in such a
> >>> mount, suddenly those inodes might become inaccessible. And while it may
> >>> be unlikely that anyone is doing this it's impossible for me to prove
> >>> that's the case.
> >>>
> >>>> If the same class of handling will also apply to selinux and those are
> >>>> the only two security modules that apply labels than we can leave tmpfs
> >>>> and ramfs with the security labels of whomever mounted them.
> >>>
> >>> For SELinux I now have a patch which applies mountpoint labeling to
> >>> mounts for which s_user_ns != &init_user_ns. I'm less sure then with
> >>> Smack how this behavior will differ from what happens today, but my
> >>> understanding is that this means that the label of the mountpoint is
> >>> used for all objects from that superblock. Afaik it does not have the
> >>> Smack behavior of denying access to filesystem objects which have a
> >>> different label in the backing store.
> >>>
> >>>> For sysfs things get a little more interesting.  Assuming tmpfs and
> >>>> ramfs don't need s_user_ns == &init_user_ns, sysfs may be fine operating
> >>>> with possibly invalid securitly labels set on a different mount of
> >>>> selinux.  (I am wondering now how all of these labels work in the
> >>>> context of nfs).
> >>>
> >>> If someone was using Smack to label sysfs then a mount with s_user_ns !=
> >>> &init_user_ns is going to leave inaccessible anything without the same
> >>> label as the process which performed the mount.
> >>>
> >>> Again with SELinux I'm less certain, but I think you could end up with a
> >>> sysfs superblock that has mountpoint labeling, and thus any labels set
> >>> in the mount in the init namespace would be ignored.
> >>
> >> If you're using the logic I suggested for SELinux, then SELinux will
> >> only use mountpoint labeling if SELinux would otherwise fetch the
> >> extended attribute value from the filesystem via ->getxattr (this is the
> >> SECURITY_FS_USE_XATTR test in the code).  As this is not the case for
> >> purely in-memory filesystems like tmpfs, ramfs, or sysfs, SELinux will
> >> still label those filesystems in the usual manner, i.e. it initially
> >> computes a default label for new inodes, and if userspace later performs
> >> a setxattr(), then it updates its internal state at that time from the
> >> relevant hooks (inode_post_setxattr or inode_setsecurity).
> >> So nothing should change for SELinux wrt labeling of tmpfs, ramfs, or
> >> sysfs in userns mounts aside from not allowing the use of the additional
> >> mount options (e.g. context=).
> > 
> > This is the patch I have currently:
> > 
> > http://kernel.ubuntu.com/git/sforshee/linux.git/commit/?h=userns-mounts&id=080e5f5ee58143a56cfc57b4e51dff58b7a3cb1a
> > 
> > I haven't been able to figure out which labeling behavior sysfs would
> > end up with normally from just inspecting the code. kernfs does support
> > xattrs, but now that I look at the implementation it handles security
> > xattrs differently and calls security_inode_setsecurity whenever one is
> > written. I'm not sure how all of that is going to work out in practice
> > with SELinux.
> 
> sysfs would have a labeling behavior of SECURITY_FS_USE_GENFS
> (policy-driven).  It wouldn't make sense to configure sysfs with
> SECURITY_FS_USE_XATTR, because that would cause SELinux to ask the
> filesystem via ->getxattr for the initial value for the label when the
> inode is first instantiated, and sysfs would have no answer there.  So,
> in practice, sysfs will still get labeled exactly as before, and there
> would be no change in behavior.  Similarly for tmpfs
> (SECURITY_FS_USE_TRANS) or ramfs.  The only filesystem types that get
> SECURITY_FS_USE_XATTR are the ones that actually support storing SELinux
> attributes persistently and therefore could provide an initial value
> from backing store.
> 
> >> Also, a superblock can only have a single labeling behavior, so you
> >> can't have different mounts of sysfs, one using mountpoint labeling and
> >> one not.  An inode can only have one label, no matter how you reach it.
> > 
> > There are multiple sysfs superblocks though, see sysfs_mount(). It calls
> > kernfs_mount_ns(), passing a kobject for the current net ns.
> > kernfs_test_super() only matches if the net ns matches an existing
> > superblock, so you end up with a different superblock per net ns.
> > 
> > For kobjects which aren't namespaced, the same path within two different
> > sysfs superblocks will be backed by the same kernfs node. kernfs stashes
> > the security context inside the kernfs node, so inodes in different
> > superblocks backed by the same kernfs node will have the same security
> > context.
> > 
> > So, with sysfs you can have different superblocks with (partially) the
> > same backing store, and it would be possible for those superblocks to
> > end up with different labeling behavior. I think we want to avoid having
> > security labels applied to sysfs files in the init namespace and have
> > those get lost in a mount from another namespace.
> 
> As long as we prohibit context= mounts on the userns mounts (which your
> patch does), then this shouldn't be possible.  Maybe we should just do
> that for sysfs always.

Great. Thanks for your help.

Seth
