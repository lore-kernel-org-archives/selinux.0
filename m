Message-ID: <51B214EF.5090609@tycho.nsa.gov>
Date: Fri, 07 Jun 2013 13:14:23 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: mthode@mthode.org, selinux@tycho.nsa.gov
Subject: Re: selinux on zfs(onlinux)
References: <51B125CE.5020801@mthode.org> <51B2136F.10900@tycho.nsa.gov>
In-Reply-To: <51B2136F.10900@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 06/07/2013 01:07 PM, Stephen Smalley wrote:
> On 06/06/2013 08:14 PM, Matthew Thode wrote:
>> zfs is very close to usable as a root file-system with selinux, but is
>> just missing one thing, it doesn't know what to set the root context to
>> on mount.
>>
>> I am going to petition for this to be added as a property, but should it
>> be called rootcontext (want to make sure it's valid).
>>
>> system_u:object_r:fs_t is what I used just to get my system working
>> (including stuff like /usr, but meh).
>>
>>
>> here is the upstream bug if curious
>> https://github.com/zfsonlinux/zfs/issues/1504
>
> The mount options interpreted by SELinux are:
> 1. context= (treat all inodes in the filesystem as if they had the
> specified security context regardless of any on-disk extended attribute
> value),
>
> 2. fscontext= (treat the filesystem/superblock as if it had the
> specified security context, used in certain permission checks affecting
> filesystem operations like mount and umount),
>
> 3. rootcontext= (treat the root inode in the filesystem as if it had the
> specified security context but the normal behavior for the rest, useful
> for assigning an initial context to a root directory of e.g. a tmpfs
> mount), and
>
> 4. defcontext= (treat any file that lacks an extended attribute as if it
> had the specified security context).
>
> The context you specified is a fscontext (fs_t), not one normally used
> for inodes.  But I'm not sure which one you meant to use or whether you
> ultimately ought to support them all.

Possibly a simpler method would be to just pass through any mount 
options unknown to zfs to the kernel to allow interpretation and use by 
the vfs and/or security modules.  That would also allow use with other 
security modules.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
