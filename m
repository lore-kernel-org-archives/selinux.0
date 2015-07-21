Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6LHbOiC011256
 for <selinux@tycho.nsa.gov>; Tue, 21 Jul 2015 13:37:24 -0400
Date: Tue, 21 Jul 2015 13:37:21 -0400
To: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 0/7] Initial support for user namespace owned mounts
Message-ID: <20150721173721.GE11050@fieldses.org>
References: <1436989569-69582-1-git-send-email-seth.forshee@canonical.com>
 <55A6C448.5050902@schaufler-ca.com>
 <87vbdlf7vo.fsf@x220.int.ebiederm.org>
 <55A6E107.3070200@schaufler-ca.com>
 <CALCETrVCNQPVr-hg_pqd2J_LeWtRJs3LRsbbE+fifo4sat+FQQ@mail.gmail.com>
 <55A71CE3.4050708@schaufler-ca.com>
 <87fv4owvxv.fsf@x220.int.ebiederm.org>
 <20150717000914.GO7943@dastard>
 <87380nobs4.fsf@x220.int.ebiederm.org>
 <20150717024735.GW3902@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150717024735.GW3902@dastard>
From: bfields@fieldses.org (J. Bruce Fields)
Cc: Serge Hallyn <serge.hallyn@canonical.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Andy Lutomirski <luto@amacapital.net>,
 Seth Forshee <seth.forshee@canonical.com>,
 LSM List <linux-security-module@vger.kernel.org>,
 SELinux-NSA <selinux@tycho.nsa.gov>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Jul 17, 2015 at 12:47:35PM +1000, Dave Chinner wrote:
> On Thu, Jul 16, 2015 at 07:42:03PM -0500, Eric W. Biederman wrote:
> > Dave Chinner <david@fromorbit.com> writes:
> > 
> > > On Wed, Jul 15, 2015 at 11:47:08PM -0500, Eric W. Biederman wrote:
> > >> Casey Schaufler <casey@schaufler-ca.com> writes:
> > >> > On 7/15/2015 6:08 PM, Andy Lutomirski wrote:
> > >> >> If I mount an unprivileged filesystem, then either the contents were
> > >> >> put there *by me*, in which case letting me access them are fine, or
> > >> >> (with Seth's patches and then some) I control the backing store, in
> > >> >> which case I can do whatever I want regardless of what LSM thinks.
> > >> >>
> > >> >> So I don't see the problem.  Why would Smack or any other LSM care at
> > >> >> all, unless it wants to prevent me from mounting the fs in the first
> > >> >> place?
> > >> >
> > >> > First off, I don't cotton to the notion that you should be able
> > >> > to mount filesystems without privilege. But it seems I'm being
> > >> > outvoted on that. I suspect that there are cases where it might
> > >> > be safe, but I can't think of one off the top of my head.
> > >> 
> > >> There are two fundamental issues mounting filesystems without privielge,
> > >> by which I actually mean mounting filesystems as the root user in a user
> > >> namespace.
> > >> 
> > >> - Are the semantics safe.
> > >> - Is the extra attack surface a problem.
> > >
> > > I think the attack surface this exposes is the biggest problem
> > > facing this proposal.
> > 
> > I completely agree.
> > 
> > >> Figuring out how to make semantics safe is what we are talking about.
> > >> 
> > >> Once we sort out the semantics we can look at the handful of filesystems
> > >> like fuse where the extra attack surface is not a concern.
> > >> 
> > >> With that said desktop environments have for a long time been
> > >> automatically mounting whichever filesystem you place in your computer,
> > >> so in practice what this is really about is trying to align the kernel
> > >> with how people use filesystems.
> > >
> > > The key difference is that desktops only do this when you physically
> > > plug in a device. With unprivileged mounts, a hostile attacker
> > > doesn't need physical access to the machine to exploit lurking
> > > kernel filesystem bugs. i.e. they can just use loopback mounts, and
> > > they can keep mounting corrupted images until they find something
> > > that works.
> > 
> > Yep.  That magnifies the problem quite a bit.
> > 
> > > User namespaces are supposed to provide trust separation.  The
> > > kernel filesystems simply aren't hardened against unprivileged
> > > attacks from below - there is a trust relationship between root and
> > > the filesystem in that they are the only things that can write to
> > > the disk. Mounts from within a userns destroys this relationship as
> > > the userns root, by definition, is not a trusted actor.
> > 
> > I talked to Ted Tso a while back and ext4 is at least in principle
> > already hardened against that kind of attack.  I am not certain I
> > believe it, but if it is true I think it is fantastic.
> 
> No, it's not. No filesystem is, because to harden against such
> attacks requires complete verification of all metadata when it is
> read from disk, before it is used, or some method or ensuring the
> block was not tampered with. CRCs are not sufficient, because they
> can be tampered with, too.
> 
> The only way a filesystem would be able to trust what it reads from
> disk has not been tampered with in a system with untrusted mounts is
> if it has some kind of cryptographically secure signature in the
> metadata and the attacker is unable to access the key for that
> signature.

Preventing tampering is a little different from protecting the kernel
from attack, isn't it?  I thought the latter was what people were asking
about.

So, for example, a screwed up on-disk directory structure shouldn't
result in creating a cycle in the dcache and then deadlocking.

--b.

> No filesystem we have has that capability and AFAIA there
> are no plans for any filesystem to implement such tamper detection.
> And no, ext4 encryption does not provide this because it only stores
> the values and data in encrypted format and does not protect
> metadata from tampering when it is not mounted.
> 
> If we don't have crypto signatures in metadata, then XFS is probably
> the most robust against tampering as it does a lot more checking of
> the on-disk metadata before it is used than any other filesystem
> (i.e. see the verifier infrastructure that does corruption checks
> after read (in io completion) and before write (in io submission)
> to catch bad metadata before it is used by the kernel, or before it
> is written to disk by the kernel.
> 
> However, these checks are far from comprehensive. we can only check
> internal consistency of the metadata objects in the block, and even
> then we really only can check for values within range rather than
> absolute correctness. e.g. we can check a dirent has a valid name,
> length, ftype and inode number, but we can't validate that the inode
> is actually allocated or not because that requires a lookup in the
> allocated inode btree. We *trust* that inode number to be
> allocated and valid because it is in metadata the filesystem wrote.
> 
> For inode numbers that come from untrusted sources (NFS,
> open-by-handle, etc) we have a flag that does inode number
> validation on lookup (XFS_IGET_UNTRUSTED) to check against trusted
> metadata (i.e. the allocated inode btrees), but that is expensive
> and so not done on inodes that we pull directly from metadata that
> has come from disk. Indeed, we still trust on-disk metadata to be
> correct to validate that other metadata canbe trusted, so if one
> structure can be tampered with, so can others.
> 
> IOWs, if we cannot trust one part of the filesystem metadata to be
> correct, then we cannot trust that filesystem *at all*, *for
> anything*. And even running fsck doesn't restore trust - all it does
> is tell us that any modification that was made is not a detectable
> inconsistency that needs fixing.
> 
> > At this point any setting of the FS_USER_MOUNT flag I figure needs to go
> > through the filesystem maintainers tree and they need to be aware of and
> > agree to deal with the attack from below issue.
> > 
> > The one filesystem I truly expect we can make work is fuse.  fuse has
> > been designed to deal with some variation of the attack from below issue
> > since day one.  We looked at what the patches to fuse would look like
> > with the current state of the vfs and it was not pretty.
> > 
> > We very much need to sort through as much as possible at the vfs layer,
> > and in generic code.  Allow everyone to see what is going on and how
> > it works before preceeding forward with enabling any filesystems.
> 
> The VFS protects us from attacks from above the filesystem, not
> below. The VFS plays no part in validating the on-disk structure of
> a filesystem which is what attacks from below will be attempting to
> exploit.
> 
> > I truly hope we can find a small set of block device filesystems that we
> > can harden from attack below.   That would allow linux to have serious
> > defenses against evil usb stick attacks.  I think that is going to take
> > a lot of careful coding, testing and validation and advancing the state
> > of the art to get there.
> 
> Somehow, I just can't see that happening.
> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
