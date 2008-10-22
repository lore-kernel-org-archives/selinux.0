Message-ID: <48FEB8D4.8040401@redhat.com>
Date: Wed, 22 Oct 2008 15:23:32 +1000
From: Murray McAllister <mmcallis@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE Linux <selinux@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>,
        Daniel Walsh <dwalsh@redhat.com>
Subject: Re: user guide drafts: "Mounting File Systems"
References: <48EF03BA.90901@redhat.com>	 <1223645441.25569.50.camel@moss-spartans.epoch.ncsc.mil>	 <48F69C5D.8050504@redhat.com>	 <1224166050.9247.48.camel@moss-spartans.epoch.ncsc.mil>	 <48FBCBC3.2070507@redhat.com> <1224509852.7428.43.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1224509852.7428.43.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Mon, 2008-10-20 at 10:07 +1000, Murray McAllister wrote:
>> Stephen Smalley wrote:
>>> On Thu, 2008-10-16 at 11:43 +1000, Murray McAllister wrote:
>>>> Changing the Default Context
>>>>
>>>> As the Linux root user, use the mount -o 
>>>> defcontext=SELinux_user:role:type:level command to change "the default 
>>>> security context for unlabeled files"[1]. The defcontext option requires 
>>>> a file system that supports extended attributes, since context context
>>> double word
>>>
>>>> changes for newly-created files that would otherwise be labeled with the 
>>>> file_t type are written to disk.
>>> What?  The point is that defcontext= is meaningless if the filesystem
>>> doesn't support extended attributes because it means "treat files that
>>> lack an extended attribute as if they had this context".  But the
>>> defcontext itself is not stored on disk.
>> I was trying to explain (tested on Fedora Rawhide):
>>
>> 1. create a logical volume. mkfs.ext3 [new logical volume].
>> 3. create a /test/ directory. mount the logical volume to /test/
>> 5. create /test/file. This file uses the file_t type.
>> 6. unmount.
>> 7. mount with defcontext option. create /test/file2. File2 uses type 
>> specified with defcontext. "file" is still labeled with the file_t type.
>> 9. remount with no context option. file2 still has the type specified 
>> with previous defcontext option.
>>
>> Is this the expected behavior?
> 
> Yes, but not because the defcontext= is being stored on disk.  The
> defcontext= option tells the kernel how to internally label files that
> lack an extended attribute on disk.  When you create a new file, the
> kernel computes a security context for the new file as previously
> described based on a combination of the process context and the parent
> directory context and optionally a type transition rule if one applies
> and stores the computed security context as an extended attribute of the
> file.  In your sequence of commands above, what is happening is that the
> root directory of the filesystem is internally being labeled by the
> kernel with the defcontext value (without ever being stored), and this
> is affecting how new files are being labeled since they inherit their
> type from the parent directory by default, and those new file labels are
> being stored.  But the defcontext= value itself is NOT being stored on
> disk.
I have tried to make this clearer. How about:

Changing the Default Context

The file_t type is the default type used for files (stored on file 
systems that support extended attributes) that do not have an SELinux 
context. This type should not exist on correctly-labeled file systems. 
If a new file system is created and not labeled before use, files and 
directories created on it may be labled with the file_t type. If it is 
desirable that this default type for unlabeled files be changed, use the 
the defcontext option when mounting the file system.

The following example mounts a newly-created file system (on /dev/sda2) 
to the newly-created /test/ directory. It assumes that there are no 
rules in /etc/selinux/targeted/contexts/files/ that define a context for 
the /test/ directory:

# mount /dev/sda2 /test/ -o defcontext="system_u:object_r:samba_share_t:s0"

In this example:

* the defcontext option defines that system_u:object_r:samba_share_t:s0 
is "the default security context for unlabeled files"[1].

* when mounted, the root directory (/test/) of the file system is 
labeled with the context specified by defcontext (this label is not 
stored on disk). This affects the labelling for files created under 
/test/: new files inherit the samba_share_t type, and these labels are 
stored on disk.

* the context specified with defcontext is lost when the file system is 
unmounted: the /test/ directory returns to being labeled with the file_t 
type. Files created under /test/ while the file system was mounted with 
a defcontext option retain their labels.

[1] Morris, James. "Filesystem Labeling in SELinux". Published 1 October 
2004. Accessed 14 October 2008: http://www.linuxjournal.com/article/7426.

> 
>>>> Multiple NFS Mounts from the same Export
>>>>
>>>> To mount a single NFS export multiple times using a different SELinux 
>>>> context for each mount, use the mount -o nosharecache,context options. 
>>>> The context specified with with context option is not written to disk:
>>>>
>>>> # mount hostname:/export /local/mount/web -o 
>>>> nosharecache,context="system_u:object_r:httpd_sys_content_t:s0"
>>>> # mount hostname:/export /local/mount/database -o 
>>>> nosharecache,context="system_u:object_r:mysqld_db_t:s0"
>>> Caveat:  Do not ever do this for overlapping mounts or you'll create a
>>> situation where the same file is accessible under two different security
>>> contexts.
>> Is overlapping what I have done above, or do you mean manually mounting 
>> an NFS export to the same directory that mounts the NFS export via 
>> autofs?
> 
> It is what you did above - mounting the same subdirectory (/export) from
> the same server (hostname) with two different security contexts.  Then
> the same files are accessible under two different security contexts.  If
> you instead mounted different subdirectories, e.g. /export/web
> and /export/db, then it would be ok.
> 
Different subdirectories is the example Eric gave me, but I messed it 
up. How about:

Mounting an NFS File System

By default, NFS mounts on the client side are labeled with the nfs_t 
type. Depending on policy configuration, services, such as Apache HTTP 
Server and MySQL, may not be able to read files labeled with the nfs_t 
type. This prevents an NFS file system being mounted and then read or 
exported by another service.

If you would like to mount an NFS file system and read or export that 
file system with another service, use the context option when mounting 
to override the nfs_t type. Use the following context option to mount 
NFS file systems so that they can be shared via the Apache HTTP Server:

mount localhost:/export /local/mount/point -o\
context="system_u:object_r:httpd_sys_content_t:s0"

Since context changes are not written to disk for these situations, 
context changes are lost when the file system is unmounted. If such a 
file system is not labeled, or does support extended attributes, it 
stays in that state after being unmounted.

Multiple NFS Mounts

When mounting multiple mounts from the same NFS export, attempting to 
override the SELinux context of each mount with a different context, 
results in subsequent mount commands failing. In the following example, 
the NFS server has a single export, /export, which has two 
subdirectories, web/ and database/. The following commands attempt two 
mounts from the single NFS export, and try to override the context for 
each one:

# mount localhost:/export/web /local/web -o\
context="system_u:object_r:httpd_sys_content_t:s0"

# mount localhost:/export/database /local/database -o\
context="system_u:object_r:mysqld_db_t:s0"

The second mount command fails, and the following is logged to 
/var/log/messages:

kernel: SELinux: mount invalid.  Same superblock, different security 
settings for (dev 0:15, type nfs)

To mount multiple mounts from a single NFS export, with each mount 
having a different context, use the -o nosharecache,context options. The 
following example mounts multiple mounts from a single NFS export, with 
a different context for each mount (allowing different services access):

# mount localhost:/export/web /local/web -o\
nosharecache,context="system_u:object_r:httpd_sys_content_t:s0"

# mount localhost:/export/database /local/database -o\
nosharecache,context="system_u:object_r:mysqld_db_t:s0"

In this example, localhost:/export/web is mounted locally to 
/local/web/, with all files being labeled with the httpd_sys_content_t 
type, allowing Apache HTTP Server access. localhost:/export/database is 
mounted locally to /local/database, with all files being labeled with 
the mysqld_db_t type, allowing MySQL access. These type changes are not 
written to disk.

<important note>
The nosharecache options allows you to mount the same subdirectory of an 
export multiple times with different contexts (for example, mounting 
/export/web multiple times). Do not mount the same subdirectory from an 
export multiple times with different contexts, as this creates an 
overlapping mount, where files are accessible under two different contexts.
</important note>

Thanks for your help.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
