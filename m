Date: Mon, 17 Dec 2001 14:54:46 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: forrest whitcher <fw@fwsystems.com>
cc: SELinux Mailing <SELinux@tycho.nsa.gov>
Subject: Re: Inode persistence generally - was: Re: persistent labelling on
 afs, jfs, xfs?
In-Reply-To: <20011217113903.77f0d383.fw@fwsystems.com>
Message-ID: <Pine.GSO.4.33.0112171427260.10304-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 17 Dec 2001, forrest whitcher wrote:

> fw> When a repacker is implemented, can your project allow persistent inode
> fw> numbers be kept as a configure - option?

Ultimately, if reiserfs supports extended attributes, then we can retarget
SELinux to use that support for binding security contexts to files rather
than the persistent label mapping when using reiserfs.  So at that point,
we would no longer care whether it keeps persistent inode numbers.

> The SELinux builds for kernel versions 2.4.12, 2.4.16 respectively
> maintain PSID's for:
>
> .12   (ext2, ufs, sysv, v7, reiserfs)
> .16   (ext2, ext3, reiserfs)
>
> I think all of the above as well as (jfs, xfs) are probably 'safe'
> (why were (ufs, sysv, v7) removed from the code (hooks.c) between
> these two versions?)

We hadn't actually tested with those filesystem types, so I removed them
to be safe.  I left reiserfs since I knew that there was specific
interest in it, even though we have only tested ext2 and ext3 ourselves.
Also, if I recall correctly, excluding experimental options, the kernel
only provides read-only access for ufs, sysv, and v7, so you can't really
maintain a persistent label mapping anyway for those types.

> The journalling filesystems must have added calls for manipulating
> the logs at the very least. Could these functions be mis-used?

Possibly.  However, if the filesystem uses the existing capable() and/or
permission() functions to perform access control for new operations, then
there will be a corresponding SELinux permission check, since LSM inserts
hooks into these functions.  But it may be desirable to define new SELinux
permissions that are more specific to these operations.

> Can we depend on the log check & replay functions and the fs-specific
> backup/restore to maintain inode:file persistence?

Probably not.  As far as backup/restore goes, there are two options:
1) You can always run setfiles on the file_contexts configuration after
restoring a filesystem to reset the file security contexts to a known
state.  But this requires you to periodically update file_contexts, and
doesn't capture dynamic changes to file labels.  You could use the
modified find program to periodically snapshot your file security contexts
and regenerate a file_contexts file based on it if you are concerned about
such dynamic changes.

2) You can use the modified tar program to save and restore file security
contexts with the corresponding files.  This doesn't depend on the inode
number at all.  It would be nice to have similar modified versions of
other typical backup/restore programs.

Long term, if support for extended attributes becomes mainstream, SELinux
could be retargeted to use it.  At that point, the modified utilities for
extended attributes could be used for this purpose.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
