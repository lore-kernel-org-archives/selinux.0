Message-ID: <48F69C5D.8050504@redhat.com>
Date: Thu, 16 Oct 2008 11:43:57 +1000
From: Murray McAllister <mmcallis@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE Linux <selinux@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>,
        Eric Paris <eparis@parisplace.org>, Daniel Walsh <dwalsh@redhat.com>
Subject: Re: user guide drafts: "Mounting File Systems"
References: <48EF03BA.90901@redhat.com> <1223645441.25569.50.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1223645441.25569.50.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Fri, 2008-10-10 at 17:26 +1000, Murray McAllister wrote:
>> Hi,
>>
>> The following is a rough draft for the "Mounting File Systems" sections. 
>> Any comments and corrections are appreciated.
> 
> I'd have to say that this entire section is confusing - it is written in
> terms of low level mechanism and corner cases and not in terms of how
> users actually interact with SELinux and their common experience.
> 
> For example, file_t is something users should never see in practice.  As
> setroubleshoot says, it indicates that they should relabel their
> filesystems - they likely have been running with SELinux disabled at
> some prior point in time and have re-enabled it without relabeling.
> 
> Likewise, default_t is the unusual case where a file falls completely
> outside of the file tree specifications in file_contexts.
> 
> It also doesn't describe context mounts in terms of why and how they are
> used.  See for example the original explanation of mountpoint labeling
> (i.e. context mounts) in:
> http://www.linuxjournal.com/article/7426
I have tried to remove the more technical details and include feedback:

Mounting File Systems

Use the mount -o context command to override existing extended 
attributes. This is useful if you do not trust a file system to supply 
the correct attributes, for example, removable media used in multiple 
systems. The mount -o context command can also be used to support 
labeling for file systems that do not support extended attributes, such 
as File Allocation Table (FAT) file systems. The context specified with 
mount -o context is not written to disk: the original contexts are 
preserved, and are seen when mounting without a context option.

Temporary Mount Context Changes

As the Linux root user, use the mount -o 
context=SELinux_user:role:type:level command to mount file systems with 
the specified context, overriding existing contexts if they exist. 
Context changes are not written to disk. In the following example, when 
/dev/sda1 is mounted, all files on that file system are labeled with the 
system_u:object_r:httpd_sys_content_t:s0 context. This example can be 
used to share FAT file systems (or other file systems) via the Apache 
HTTP server:

# mount -o context="system_u:object_r:httpd_sys_content_t:s0" /dev/sda1 
/mount/point

Newly-created files and directories on this file system appear to have 
the SELinux context specified with -o context; however, since context 
changes are not written to disk for these situations, context changes 
are lost when the file system is unmounted. If such a file system is not 
labeled, or does support extended attributes, it stays in that state 
after being unmounted.

Type Enforcement is the main permission control used in SELinux targeted 
policy. For the most part, SELinux users and roles can be ignored, so, 
when overriding the SELinux context with -o context, use the SELinux 
system_u user and object_r role, and concentrate on the type. If you are 
not using the MLS policy or multi-category security, use the s0 level.

<note>
When a file system is mounted with a context option, context changes (by 
users and processes) are prohibited. For example, running chcon on a 
file system mounted with a context option results in a Operation not 
supported error.
</note>

Changing the Default Context

As the Linux root user, use the mount -o 
defcontext=SELinux_user:role:type:level command to change "the default 
security context for unlabeled files"[1]. The defcontext option requires 
a file system that supports extended attributes, since context context 
changes for newly-created files that would otherwise be labeled with the 
file_t type are written to disk. The file_t type is used for files 
(stored on a file system that supports extended attributes) that do not 
have an SELinux context. This type should not exist on correctly-labeled 
file systems.

The following example changes the default context to 
system_u:object_r:httpd_sys_content_t:s0:

# mount -o defcontext="system_u:object_r:httpd_sys_content_t:s0" 
/dev/sda1 /mount/point

In this example, if the file system on /dev/sda1 isn't labeled 
correctly, or isn't labeled at all, newly-created files are labeled with 
httpd_sys_content_t type, rather than the file_t type. If a file that 
would otherwise be labeled with the file_t type is created on this file 
system, it keeps the httpd_sys_content_t type, even when the file system 
is mounted without a context option.

[1] Morris, James. "Filesystem Labeling in SELinux". Published 1 October 
2004. Accessed 14 October 2008: http://www.linuxjournal.com/article/7426.

Multiple NFS Mounts from the same Export

To mount a single NFS export multiple times using a different SELinux 
context for each mount, use the mount -o nosharecache,context options. 
The context specified with with context option is not written to disk:

# mount hostname:/export /local/mount/web -o 
nosharecache,context="system_u:object_r:httpd_sys_content_t:s0"
# mount hostname:/export /local/mount/database -o 
nosharecache,context="system_u:object_r:mysqld_db_t:s0"

In this example, the hostname:/export NFS export is mounted to two 
different directories, /local/mount/web and /local/mount/database. Files 
mounted on /local/mount/web are labeled with the httpd_sys_content_t 
type. Files mounted on /local/mount/database are labeled with the 
mysqld_db_t type.

If a single system runs a MySQL® server as well as an Apache HTTP 
Server, and data files for both of those services are on a single NFS 
export, this example can be used to allow both the MySQL server and the 
Apache HTTP Server access to the required files, without exposing the 
files to other local services.

# This is probably incorrect. I do not know a proper use cases for this.

Note: if you attempt to mount a single NFS export multiple times with 
different contexts, but do not use the nosharecache option, mount fails 
with a mount.nfs: an incorrect mount option was specified error, and the 
following is logged to /var/log/messages:

kernel: SELinux: mount invalid.  Same superblock, different security 
settings for (dev 0:14, type nfs)

Further Information

For further information about file system labeling, refer to James 
Morris's "Filesystem Labeling in SELinux" article: 
http://www.linuxjournal.com/article/7426.
> 
>> Thanks!
>>
>> Mounting File Systems
>>
>> By default, when a third extended file system (ext3) is mounted, the 
>> files and directories on the file system are labeled with the file_t 
>> type. The mount command can override SELinux contexts when mounting file 
>> systems. SELinux context changes with the mount command can be 
>> per-session only (until the file system is unmounted), or persistent 
>> (context changes are written to disk).
>>
>> # what are default_t and file_t?
>>
>> Temporary Mount Context Changes
>>
>> As the Linux root user, use the mount -o 
>> context=SELinux_user:role:type:level option to temporarily override 
>> existing SELinux contexts. The -o context option requires a Linux 2.6 
>> kernel. When a file system is mounted with the -o context option:
>>
>> # does -o context only work with a 2.6 kernels?
>>
>> * SELinux context changes only occur in kernel memory, and as such, 
>> context changes are not written to disk. Any context changes made while 
>> such a file system is mounted are lost when the file system is unmounted.
>>
>> * If a file system is already labeled, and the contexts are overridden 
>> with the -o context option, the original contexts return when the file 
>> system is un-mounted.
>>
>> * Newly-created files and directories appear to have the SELinux context 
>> specified with -o context; however, since context changes are not 
>> written to disk for these situations, context changes are lost when the 
>> file system is un-mounted.
>>
>> * The -o context option works even if the file system to be mounted does 
>> not support extended attributes, although, any context changes made to 
>> such a file system are lost when the file system is unmounted.
>>
>> The following example labels all files on the file system to be mounted 
>> with the httpd_sys_content_t type:
>>
>> # mount -t ext3 -o context="system_u:object_r:httpd_sys_content_t:s0" 
>> /dev/sdax /mount/point
>>
>> -t ext3: The -t ext3 option specifies that an ext3 file system is to be 
>> mounted. Use the -t option to specify the correct file system. Refer to 
>> the mount(8) manual page for a list of file systems.
>>
>> -o context="system_u:object_r:httpd_sys_content_t:s0": The -o 
>> context="system_u:object_r:httpd_sys_content_t:s0" option specifies the 
>> SELinux context for all files on the file system to be mounted, as well 
>> as the mount point. This option overrides existing contexts.
>>
>> Type Enforcement is the main permission control used in SELinux targeted 
>> policy. For the most part, SELinux users and roles can be ignored, so, 
>> when overriding the SELinux context with mount, use the SELinux system_u 
>> user and object_r role, and concentrate on the type. In this example, 
>> all files on the /dev/sdax file system will be labeled with the 
>> httpd_sys_content_t type.
>>
>> /dev/sdax /mount/point: Specifies that the /dev/sdax device will be 
>> mounted to the /mount/point/ directory.
>>
>> <note>
>> When a file system is mounted with the -o context option, it is not 
>> possible to use the chcon command to change the SELinux context. Using 
>> chcon on such a file system results in a Operation not supported error.
>> </note>
>>
>> Persistent Mount Context Changes
>>
>> As the Linux root user, use the mount -o 
>> defcontext=SELinux_user:role:type:level option to persistently change 
>> the default SELinux context for a file system. The -o defcontext option 
>> requires a file system that supports extended attributes, since changes 
>> are written to disk. When a file system is mounted with the -o 
>> defcontext option:
>>
>> * Existing files keep their current contexts.
>>
>> * Context changes are written to disk, and are not lost if the file 
>> system is unmounted. Newly-created files and files copied to such a file 
>> system inherit the SELinux context specified with the -o defcontext 
>> option. For example, if a file system is mounted with the -o 
>> defcontext="system_u:object_r:httpd_sys_content_t:s0" option, and a new 
>> file is created on the mounted file system, that file is labeled with 
>> the httpd_sys_content_t type. If the file system is unmounted and then 
>> mounted without a context option, that file is still labeled with the 
>> httpd_sys_content_t type.
>>
>> The following example changes the default SELinux context for the file 
>> system to be mounted to system_u:object_r:httpd_sys_content_t:s0:
>>
>> # mount -t ext3 -o defcontext="system_u:object_r:httpd_sys_content_t:s0" 
>> /dev/sdax /mount/point
>>
>> [fill in similar to the previous section]
>>
>> # I do not understand the fscontext option. Should that be included?
>>
>> # Is there any common use cases that should have examples here, such as 
>> mounting a cd and sharing it via http or nfs?
>>
>> Apologies for any typos :(
>>
>> --
>> This message was distributed to subscribers of the selinux mailing list.
>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
