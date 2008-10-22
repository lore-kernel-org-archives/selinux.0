Message-ID: <48FF7E28.5030406@redhat.com>
Date: Wed, 22 Oct 2008 15:25:28 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Murray McAllister <mmcallis@redhat.com>, SE Linux <selinux@tycho.nsa.gov>,
        Eric Paris <eparis@redhat.com>
Subject: Re: user guide drafts: "Mounting File Systems"
References: <48EF03BA.90901@redhat.com>	 <1223645441.25569.50.camel@moss-spartans.epoch.ncsc.mil>	 <48F69C5D.8050504@redhat.com>	 <1224166050.9247.48.camel@moss-spartans.epoch.ncsc.mil>	 <48FBCBC3.2070507@redhat.com>	 <1224509852.7428.43.camel@moss-spartans.epoch.ncsc.mil>	 <48FEB8D4.8040401@redhat.com> <1224688024.29917.42.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1224688024.29917.42.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Wed, 2008-10-22 at 15:23 +1000, Murray McAllister wrote:
>> I have tried to make this clearer. How about:
>>
>> Changing the Default Context
>>
>> The file_t type is the default type used for files (stored on file 
>> systems that support extended attributes) that do not have an SELinux 
>> context.
> 
> Generalize:  When a file that lacks a SELinux extended attribute on disk
> is accessed, the kernel treats it internally as if it had a default
> context value defined by the policy.  In common policies, this default
> context value has the file_t type, and this should be the only use of
> this type so that such files can be distinguished in policy and
> generally kept inaccessible to confined domains.
> 
>>  This type should not exist on correctly-labeled file systems.
> 
> because all files in such filesystems should have a SELinux extended
> attribute set on disk, and the file_t type is never used in the
> file_contexts configuration.  Instead, a default_t type is set on files
> that do not match any other pattern in the file_contexts configuration
> in order to distinguish them from files that have no security context on
> disk.
> 
>> If a new file system is created and not labeled before use, files and 
>> directories created on it may be labled with the file_t type. If it is 
>> desirable that this default type for unlabeled files be changed, use the 
>> the defcontext option when mounting the file system.
>>
>> The following example mounts a newly-created file system (on /dev/sda2) 
>> to the newly-created /test/ directory. It assumes that there are no 
>> rules in /etc/selinux/targeted/contexts/files/ that define a context for 
>> the /test/ directory:
>>
>> # mount /dev/sda2 /test/ -o defcontext="system_u:object_r:samba_share_t:s0"
>>
>> In this example:
>>
>> * the defcontext option defines that system_u:object_r:samba_share_t:s0 
>> is "the default security context for unlabeled files"[1].
>>
>> * when mounted, the root directory (/test/) of the file system is 
>> labeled
> 
> s/labeled/treated as if it were labeled/
> (the label is not set on disk)
> 
>>  with the context specified by defcontext (this label is not 
>> stored on disk). This affects the labelling for files created under 
>> /test/: new files inherit the samba_share_t type, and these labels are 
>> stored on disk.
>>
>> * the context specified with defcontext is lost when the file system is 
>> unmounted: the /test/ directory returns to being labeled with the file_t 
>> type.
> 
> Not "lost", but not stored on disk.  It will be preserved on each mount
> if it is added as a mount option to /etc/fstab or automounter maps.  It
> doesn't change to file_t at unmount; it will be treated as file_t (or
> more generally, the default context value defined by policy) if it is
> later mounted without the defcontext= option.
> 
>> Different subdirectories is the example Eric gave me, but I messed it 
>> up. How about:
>>
>> Mounting an NFS File System
>>
>> By default, NFS mounts on the client side are labeled with the nfs_t 
>> type.
> 
> Generalize:  "labeled with a default context defined by policy for NFS
> filesystems.  In common policies, this default context has the nfs_t
> type.
> 
>>  Depending on policy configuration, services, such as Apache HTTP 
>> Server and MySQL, may not be able to read files labeled with the nfs_t 
>> type. This prevents an NFS file system being mounted and then read or 
>> exported by another service.
> 
> Might be booleans that control this area as well; I don't know offhand.
> 
/usr/sbin/getsebool -a shows the following booleans available to use
nfs,   "use_nfs_home_dirs"  allows all domains that need access to
homedirs, access to nfs_t.  (cifs_t samba filesystems) have similar
booleans.
allow_ftpd_use_nfs --> off
httpd_use_nfs --> off
qemu_use_nfs --> on
samba_share_nfs --> off
use_nfs_home_dirs --> on
virt_use_nfs --> off
xen_use_nfs --> off

>> If you would like to mount an NFS file system and read or export that 
>> file system with another service, use the context option when mounting 
>> to override the nfs_t type. Use the following context option to mount 
>> NFS file systems so that they can be shared via the Apache HTTP Server:
>>
>> mount localhost:/export /local/mount/point -o\
>> context="system_u:object_r:httpd_sys_content_t:s0"
> 
> The options really ought to go into their fstab or automounter maps so
> that they are preserved on each mount.
> 
> You should also note the types defined to allow multiple services to
> access the same content.  Ask Dan.
> 

public_content_t
public_content_rw_t

>> Since context changes are not written to disk for these situations, 
>> context changes are lost when the file system is unmounted.
> 
> Not "lost"; just not stored on disk.  Whether or not it keeps that label
> on the next mount depends on whether you mount it with the context
> option consistently.  Best way to do that is to put it in your fstab or
> automounter configs.
> 
>>  If such a 
>> file system is not labeled, or does support extended attributes, it 
>> stays in that state after being unmounted.
>>
>> Multiple NFS Mounts
>>
>> When mounting multiple mounts from the same NFS export, attempting to 
>> override the SELinux context of each mount with a different context, 
>> results in subsequent mount commands failing. In the following example, 
>> the NFS server has a single export, /export, which has two 
>> subdirectories, web/ and database/. The following commands attempt two 
>> mounts from the single NFS export, and try to override the context for 
>> each one:
>>
>> # mount localhost:/export/web /local/web -o\
>> context="system_u:object_r:httpd_sys_content_t:s0"
>>
>> # mount localhost:/export/database /local/database -o\
>> context="system_u:object_r:mysqld_db_t:s0"
>>
>> The second mount command fails, and the following is logged to 
>> /var/log/messages:
>>
>> kernel: SELinux: mount invalid.  Same superblock, different security 
>> settings for (dev 0:15, type nfs)
>>
>> To mount multiple mounts from a single NFS export, with each mount 
>> having a different context, use the -o nosharecache,context options. The 
>> following example mounts multiple mounts from a single NFS export, with 
>> a different context for each mount (allowing different services access):
>>
>> # mount localhost:/export/web /local/web -o\
>> nosharecache,context="system_u:object_r:httpd_sys_content_t:s0"
>>
>> # mount localhost:/export/database /local/database -o\
>> nosharecache,context="system_u:object_r:mysqld_db_t:s0"
>>
>> In this example, localhost:/export/web is mounted locally to 
>> /local/web/, with all files being labeled with the httpd_sys_content_t 
>> type, allowing Apache HTTP Server access. localhost:/export/database is 
>> mounted locally to /local/database, with all files being labeled with 
>> the mysqld_db_t type, allowing MySQL access. These type changes are not 
>> written to disk.
>>
>> <important note>
>> The nosharecache options allows you to mount the same subdirectory of an 
>> export multiple times with different contexts (for example, mounting 
>> /export/web multiple times). Do not mount the same subdirectory from an 
>> export multiple times with different contexts, as this creates an 
>> overlapping mount, where files are accessible under two different contexts.
>> </important note>
>>
>> Thanks for your help.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
