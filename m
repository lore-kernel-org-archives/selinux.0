Subject: Re: user guide drafts: "Mounting File Systems"
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Murray McAllister <mmcallis@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>,
        Eric Paris <eparis@parisplace.org>, Daniel Walsh <dwalsh@redhat.com>
In-Reply-To: <48F69C5D.8050504@redhat.com>
References: <48EF03BA.90901@redhat.com>
	 <1223645441.25569.50.camel@moss-spartans.epoch.ncsc.mil>
	 <48F69C5D.8050504@redhat.com>
Content-Type: text/plain; charset=utf-8
Date: Thu, 16 Oct 2008 10:07:30 -0400
Message-Id: <1224166050.9247.48.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2008-10-16 at 11:43 +1000, Murray McAllister wrote:
> Mounting File Systems

I'd start first by describing the common behavior, e.g.:

By default, when a filesystem that supports extended attributes is
mounted, the security context for each file is obtained from the
"security.selinux" extended attribute of the file.  Files in filesystems
that do not support extended attributes are assigned a single default
security context from the policy configuration based on filesystem type.

Then you can continue with:

> Use the mount -o context command to override existing extended 
> attributes.

or to specify a different default security context for filesystems that
do not support extended attributes.

>  This is useful if you do not trust a file system to supply 
> the correct attributes, for example, removable media used in multiple 
> systems. The mount -o context command can also be used to support 
> labeling for file systems that do not support extended attributes, such 
> as File Allocation Table (FAT) file systems.

Or NFS filesystems.

>  The context specified with 
> mount -o context is not written to disk: the original contexts are 
> preserved, and are seen when mounting without a context option.

if there were any extended attributes on the disk in the first place.
Which typically won't be the case when using context mounts.

> Temporary Mount Context Changes

I wouldn't call them "temporary".  We have called it mountpoint labeling
or context mounts in the past, and they can be "persistent" in the sense
of putting it in your fstab and having it always applied on every mount.
They just aren't stored on the media.

> As the Linux root user, use the mount -o 
> context=SELinux_user:role:type:level command to mount file systems with 
> the specified context, overriding existing contexts if they exist. 
> Context changes are not written to disk. In the following example, when 
> /dev/sda1 is mounted, all files on that file system are labeled with the 
> system_u:object_r:httpd_sys_content_t:s0 context. This example can be 
> used to share FAT file systems (or other file systems) via the Apache 
> HTTP server:
> 
> # mount -o context="system_u:object_r:httpd_sys_content_t:s0" /dev/sda1 
> /mount/point

I'd tend to give example of mounting removable devices (floppies,
CD/DVDs, USB drives) or NFS filesystems, as that is generally when one
would use a context mount.

> Newly-created files and directories on this file system appear to have 
> the SELinux context specified with -o context; however, since context 
> changes are not written to disk for these situations, context changes 
> are lost when the file system is unmounted. If such a file system is not 
> labeled, or does support extended attributes, it stays in that state 
> after being unmounted.
> 
> Type Enforcement is the main permission control used in SELinux targeted 
> policy. For the most part, SELinux users and roles can be ignored, so, 
> when overriding the SELinux context with -o context, use the SELinux 
> system_u user and object_r role, and concentrate on the type. If you are 
> not using the MLS policy or multi-category security, use the s0 level.
> 
> <note>
> When a file system is mounted with a context option, context changes (by 
> users and processes) are prohibited. For example, running chcon on a 
> file system mounted with a context option results in a Operation not 
> supported error.
> </note>
> 
> Changing the Default Context
> 
> As the Linux root user, use the mount -o 
> defcontext=SELinux_user:role:type:level command to change "the default 
> security context for unlabeled files"[1]. The defcontext option requires 
> a file system that supports extended attributes, since context context

double word

> changes for newly-created files that would otherwise be labeled with the 
> file_t type are written to disk.

What?  The point is that defcontext= is meaningless if the filesystem
doesn't support extended attributes because it means "treat files that
lack an extended attribute as if they had this context".  But the
defcontext itself is not stored on disk.

>  The file_t type is used for files 
> (stored on a file system that supports extended attributes) that do not 
> have an SELinux context. This type should not exist on correctly-labeled 
> file systems.
> 
> The following example changes the default context to 
> system_u:object_r:httpd_sys_content_t:s0:
> 
> # mount -o defcontext="system_u:object_r:httpd_sys_content_t:s0" 
> /dev/sda1 /mount/point

Again, I would tend to use an example that is more realistic, like a
removable device or NFS filesystem.

> In this example, if the file system on /dev/sda1 isn't labeled 
> correctly, or isn't labeled at all, newly-created files are labeled with 
> httpd_sys_content_t type, rather than the file_t type. If a file that 
> would otherwise be labeled with the file_t type is created on this file 
> system, it keeps the httpd_sys_content_t type, even when the file system 
> is mounted without a context option.
> 
> [1] Morris, James. "Filesystem Labeling in SELinux". Published 1 October 
> 2004. Accessed 14 October 2008: http://www.linuxjournal.com/article/7426.
> 
> Multiple NFS Mounts from the same Export
> 
> To mount a single NFS export multiple times using a different SELinux 
> context for each mount, use the mount -o nosharecache,context options. 
> The context specified with with context option is not written to disk:
> 
> # mount hostname:/export /local/mount/web -o 
> nosharecache,context="system_u:object_r:httpd_sys_content_t:s0"
> # mount hostname:/export /local/mount/database -o 
> nosharecache,context="system_u:object_r:mysqld_db_t:s0"

Caveat:  Do not ever do this for overlapping mounts or you'll create a
situation where the same file is accessible under two different security
contexts.

> In this example, the hostname:/export NFS export is mounted to two 
> different directories, /local/mount/web and /local/mount/database. Files 
> mounted on /local/mount/web are labeled with the httpd_sys_content_t 
> type. Files mounted on /local/mount/database are labeled with the 
> mysqld_db_t type.
> 
> If a single system runs a MySQL® server as well as an Apache HTTP 
> Server, and data files for both of those services are on a single NFS 
> export, this example can be used to allow both the MySQL server and the 
> Apache HTTP Server access to the required files, without exposing the 
> files to other local services.
> 
> # This is probably incorrect. I do not know a proper use cases for this.
> 
> Note: if you attempt to mount a single NFS export multiple times with 
> different contexts, but do not use the nosharecache option, mount fails 
> with a mount.nfs: an incorrect mount option was specified error, and the 
> following is logged to /var/log/messages:
> 
> kernel: SELinux: mount invalid.  Same superblock, different security 
> settings for (dev 0:14, type nfs)
> 
> Further Information
> 
> For further information about file system labeling, refer to James 
> Morris's "Filesystem Labeling in SELinux" article: 
> http://www.linuxjournal.com/article/7426.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
