Date: Mon, 17 Dec 2001 11:39:03 -0500
From: forrest whitcher <fw@fwsystems.com>
To: Stephen Smalley <sds@tislabs.com>, SELinux Mailing <SELinux@tycho.nsa.gov>
Cc: Hans Reiser <reiser@namesys.com>
Subject: Inode persistence generally - was: Re: persistent labelling on afs, jfs, xfs?
Message-Id: <20011217113903.77f0d383.fw@fwsystems.com>
In-Reply-To: <Pine.GSO.4.33.0112170709420.10438-100000@raven>
References: <3C1B64C5.4000207@namesys.com>
	<Pine.GSO.4.33.0112170709420.10438-100000@raven>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


<reiser@namesys.com> Hans Reiser did inscribe thusly:

>>We currently have unique and persistent inode numbers (at least until we 
>>someday write a repacker that will optimize key assignments for better 
>>layout), but you can't use them for finding files that are not in the 
>>cache.  To find such files requires a key.
>>
>>Hans
>>

Off-list I inqured:
fw>
fw> When a repacker is implemented, can your project allow persistent inode 
fw> numbers be kept as a configure - option?
fw>

And recieved in reply

Hans> Probably a good idea.  Ok, will do.

I will check in with the JFS list and inquire about maintaining
persistence of Inodes in future versions

What about XFS? I believe xfs Inodes are persistent, does anyone here have 
certain knowlege either way?

On Mon, 17 Dec 2001 07:29:44 -0500 (EST)
Stephen Smalley <sds@tislabs.com> Stephen Smalley did inscribe thusly:

> SELinux uses the inode number as an identifier for the file in the
> persistent label mapping in each filesystem.   So it doesn't find files
> based on the inode number, but it needs each file in a filesystem to have
> a unique and persistent inode number.  It sounds like reiserfs does
> currently provide this property.
> 

And (separate email):

> that are known to have persistent inodes.  See the superblock_precondition
> function in the hooks.c file.  You can patch it to recognize additional
> filesystem types if you wish.  However, note that for networked
> or distributed filesystems, this isn't safe, since there is no mechanism
> for coordinating updates to the mapping among the clients.
> 

I patched to try jfs, simple enough, seems to work.

The SELinux builds for kernel versions 2.4.12, 2.4.16 respectively 
maintain PSID's for:

.12   (ext2, ufs, sysv, v7, reiserfs)
.16   (ext2, ext3, reiserfs)

I think all of the above as well as (jfs, xfs) are probably 'safe'
(why were (ufs, sysv, v7) removed from the code (hooks.c) between
these two versions?)

However, pondering this brought me to wonder: do these various 
filesystems provide alternate ways of changing the Inode# - file
mapping in ways that could circumvent the AVC, or the LSM hooks
generally?

I looked through my LSM mail and didn't find that this has been
discussed there (tho I've far less time to apply to staying current
with LSM generally)

I assume that the interface is 

<kernel> -> <vfs> -> <(ext[23], rieserfs, xfs, jfs ...)>

The journalling filesystems must have added calls for manipulating
the logs at the very least. Could these functions be mis-used?

A more prosaic concern: 

Can we depend on the log check & replay functions and the fs-specific 
backup/restore to maintain inode:file persistence?


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
