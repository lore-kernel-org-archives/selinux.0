Subject: Re: user guide drafts: "Mounting File Systems"
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Murray McAllister <mmcallis@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>
In-Reply-To: <48EF03BA.90901@redhat.com>
References: <48EF03BA.90901@redhat.com>
Content-Type: text/plain
Date: Fri, 10 Oct 2008 09:11:40 -0400
Message-Id: <1223644300.25569.41.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2008-10-10 at 17:26 +1000, Murray McAllister wrote:
> Hi,
> 
> The following is a rough draft for the "Mounting File Systems" sections. 
> Any comments and corrections are appreciated.
> 
> Thanks!
> 
> Mounting File Systems
> 
> By default, when a third extended file system (ext3) is mounted, the 

You should generalize this to "a filesystem that supports extended
attributes, such as ext[234], jfs, xfs, or jffs2".

> files and directories on the file system are labeled with the file_t 
> type.

Not exactly.  The correct statement is that a file that does not have a
security context set on disk (due to being created on a non-selinux
kernel) on a filesystem that supports extended attributes will be
treated as having the file_t type (or more precisely, the security
context associated with the file initial SID).  On a properly labeled
filesystem, there should be no files with file_t.

>  The mount command can override SELinux contexts when mounting file 
> systems. SELinux context changes with the mount command can be 
> per-session only (until the file system is unmounted), or persistent 
> (context changes are written to disk).

This doesn't sound right either.  The context= mount option can be used
to treat all files on a given filesystem as having the specified
security context.  That context is never stored in the filesystem
itself, although obviously you can put context= mount options into your
fstab in order to make them happen whenever the filesystem is mounted.
The purpose of the context= mount option is twofold:
- to support coarse-grained labeling of filesystems that do not support
extended attributes, and
- to support overriding/ignoring the extended attributes on a filesystem
when you do not want to trust it to supply them (similar to the nosuid
option, useful for e.g. removable media).

> # what are default_t and file_t?

default_t is a type specified in file_contexts as the default type for
any file that does not match any other pattern in the file_contexts
configuration.  So for example if you have a /foobar on your disk, it
will likely end up getting labeled with default_t.  default_t files may
exist on a properly labeled filesystem but should generally be
inaccessible to confined domains - they indicate that you need to update
your file_contexts configuration to include patterns for that part of
the file tree.

file_t is the type used in the context associated with the initial file
SID that gets assigned to files by the kernel when there is no extended
attribute for the security context on the file yet the filesystem type
supports such attributes.  file_t files should not exist on a properly
labeled filesystem; they indicate that files were created while running
a non-selinux kernel.

> Temporary Mount Context Changes
> 
> As the Linux root user, use the mount -o 
> context=SELinux_user:role:type:level option to temporarily override 
> existing SELinux contexts. The -o context option requires a Linux 2.6 
> kernel. When a file system is mounted with the -o context option:
> 
> # does -o context only work with a 2.6 kernels?
> 
> * SELinux context changes only occur in kernel memory, and as such, 
> context changes are not written to disk. Any context changes made while 
> such a file system is mounted are lost when the file system is unmounted.

There shouldn't be any context changes when you use a context mount; it
prohibits setting of the context by applications.

> * If a file system is already labeled, and the contexts are overridden 
> with the -o context option, the original contexts return when the file 
> system is un-mounted.

The extended attributes are not modified, but they will only be visible
if you mount without the context option.

> Persistent Mount Context Changes
> 
> As the Linux root user, use the mount -o 
> defcontext=SELinux_user:role:type:level option to persistently change 
> the default SELinux context for a file system.

No.  This just changes the default context used by the kernel for files
that lack an extended attribute on disk, from the context associated
with the initial file SID to the specified context.  IOW, this just
changes from using file_t to using some other label.

>  The -o defcontext option 
> requires a file system that supports extended attributes, since changes 
> are written to disk. When a file system is mounted with the -o 
> defcontext option:
> 
> * Existing files keep their current contexts.
> 
> * Context changes are written to disk, and are not lost if the file 
> system is unmounted. Newly-created files and files copied to such a file 
> system inherit the SELinux context specified with the -o defcontext 
> option. For example, if a file system is mounted with the -o 
> defcontext="system_u:object_r:httpd_sys_content_t:s0" option, and a new 
> file is created on the mounted file system, that file is labeled with 
> the httpd_sys_content_t type. If the file system is unmounted and then 
> mounted without a context option, that file is still labeled with the 
> httpd_sys_content_t type.
> 
> The following example changes the default SELinux context for the file 
> system to be mounted to system_u:object_r:httpd_sys_content_t:s0:
> 
> # mount -t ext3 -o defcontext="system_u:object_r:httpd_sys_content_t:s0" 
> /dev/sdax /mount/point
> 
> [fill in similar to the previous section]
> 
> # I do not understand the fscontext option. Should that be included?

I'm pretty sure that James and/or Eric have written description of all
of the context mount options before.
fscontext= sets the filesystem security context, a context that is
applied for certain permission checks on the entire filesystem like
mounting as well as used to control what file security contexts can
exist within the filesystem.

rootcontext= sets the security context for the root directory of the
filesystem, useful for e.g. tmpfs mounts where you want the root to take
on a specific context but allow other files within it to have individual
contexts.

> # Is there any common use cases that should have examples here, such as 
> mounting a cd and sharing it via http or nfs?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
