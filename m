Date: Wed, 6 Feb 2002 10:04:41 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Timothy Wood <timothy@hallcomp.com>
cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: xfs
In-Reply-To: <1013005000.30726.3.camel@phobos>
Message-ID: <Pine.GSO.4.33.0202060936040.27827-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On 6 Feb 2002, Timothy Wood wrote:

> I noticed from the archives that SELinux does not work with the XFS
> filesystem.  Has this changed or does anyone know if anyone is working
> on it?

There are a few issues to be resolved if you want to use XFS:
1) Since LSM/SELinux tracks the mainstream Linux kernel and the mainstream
Linux kernel doesn't yet include XFS, there is no XFS filesystem support
in the LSM kernel that is provided on the NSA site.  So you would need to
either merge the XFS patches into the LSM kernel or merge the LSM kernel
patch into a kernel of your choosing that already has XFS included.

2) You will need to choose an approach for maintaining persistent labeling
on your XFS filesystems.  The SELinux persistent label mapping is now
relatively filesystem-independent, as long as the filesystem provides
unique and persistent inode numbers.  So assuming that this is true for
XFS, the simplest approach would be to patch the superblock_precondition
function in lsm/security/selinux/hooks.c to add "xfs" to the current set
of filesystem types that use persistent label mappings (ext2, ext3,
reiserfs).  Longer term, the SELinux security module could be retargeted
to use XFS extended attributes rather than the persistent label mapping
for XFS filesystems, but that would require more changes.

3) XFS will have some of its own operations, and these operations won't be
controlled by SELinux unless the operation calls an already hooked
function, e.g. capable or permission.  Even in that case, the SELinux
control may be too coarse-grained to be useful.  So you would need to
assess any new operations and potentially add new hooks and controls.
Since the *xattr operations have been merged into 2.5.3, LSM has added
new hooks for these operations, and we will be defining new controls for
them, but if you are using the 2.4-based kernel, you will need to transfer
these changes to your kernel.  Also, there may be other XFS-specific
operations that need control.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com






--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
