Message-ID: <48F547BE.7070201@redhat.com>
Date: Wed, 15 Oct 2008 11:30:38 +1000
From: Murray McAllister <mmcallis@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: "Clarkson, Mike R (US SSA)" <mike.clarkson@baesystems.com>,
        Glenn Faden <Glenn.Faden@sun.com>, Daniel J Walsh <dwalsh@redhat.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: user guide drafts: Maintaining SELinux Labels
References: <737og9$5vh3i@dmzms99902.na.baesystems.com>	 <48ED4FBC.4020303@redhat.com>	 <1223643319.25569.23.camel@moss-spartans.epoch.ncsc.mil>	 <48F02876.3020203@redhat.com> <1223993726.5193.41.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1223993726.5193.41.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Sat, 2008-10-11 at 14:15 +1000, Murray McAllister wrote:
>> Thanks. How about:
>>
>> When files and directories are copied, the SELinux context of the new 
>> file or directory depends on the context of the creating process, and 
>> the context of the target, parent directory: the type is inherited from 
>> the target, parent directory (unless a type transition rule exists[1]); 
>> the SELinux user identity and level are inherited from the creating 
>> process; and the role is always object_r, which is a generic role for 
>> files. This helps ensure files and directories are labeled with the 
>> correct SELinux context after being copied.
> 
> It still seems a bit confusing to read.  Part of the issue is that you
> are confusing two things above:
> - file copying,
> - new file creation
> 
> The default labeling rules apply whenever a new file is created at
> runtime.  File copying is a particular case where a new file is created,
> and there are two situations for it:
> - (default) New file is created in accordance with the usual default
> labeling rules, thereby _not_ necessarily preserving the context of the
> original file but rather reflecting the runtime properties of the new
> file.  Example:  When a top secret process copies an unclassified file,
> the new file is necessarily top secret, not unclassified.
> - (when using options to preserve context of the original file) New file
> is created with the context of the original file, thereby preserving the
> context of the original and _not_ reflecting the runtime properties of
> the new file.  The ability to do this is limited by policy and may fail
> for a variety of reasons, e.g.:
> 1) the process may not be authorized to create files with the original
> file label (e.g. top secret process may not create unclassified file,
> user_t process may not create an etc_t file),
> 2) the file security context may not be allowed to exist within the
> target file system (e.g. top secret file may not be created within a
> filesystem capped at secret, passwd_exec_t file may not be created on
> removable media).
Is that because of the file systems on most removable media, or 
something else?

I made an ext3 file system on an USB drive, and "cp --preserve=context 
/usr/bin/passwd /removable/media" preserved the passwd_exect_t type. I 
tested this on Red Hat Enterprise Linux 5.2 and Fedora Rawhide.

I started the section again. Hopefully it is almost right now :(

Copying Files and Directories

When a file or directory is copied, a new file or directory is created 
if it does not exist. That new file or directory's context is based on 
default-labeling rules, not the original file or directory's context 
(unless options were used to preserve the original context). For 
example, files created in user home directories are labeled with the 
user_home_t type:

$ touch file1
$ ls -Z file1
-rw-rw-r--  user1 group1 unconfined_u:object_r:user_home_t:s0 file1

If such a file is copied to another directory, such as /etc/, the new 
file is created in accordance to default-labeling rules for the /etc/ 
directory. Copying a file (without additional options) may not preserve 
the original context:

$ ls -Z file1
-rw-rw-r--  user1 group1 unconfined_u:object_r:user_home_t:s0 file1
# cp file1 /etc/
$ ls -Z /etc/file1
-rw-r--r--  root root unconfined_u:object_r:etc_t:s0   /etc/file1

When file1 is copied to /etc/, if /etc/file1 does not exist, /etc/file1 
is created as a new file. As shown in the example above, /etc/file1 is 
labeled with the etc_t type, in accordance to default-labeling rules.

When a file is copied over an existing file, the existing file's context 
is preserved, unless the user specified cp options to preserve the 
context of the original file, such as --preserve=context. SELinux policy 
may prevent contexts from being preserved during copies.
> 
>> Also, when a file is copied over an existing file, the existing file's 
>> context is maintained, unless the user specified cp options to preserve 
>> the context of the original file, such as --preserve=context.
>>
>> #Is the following required, or is it covered by the above:
>>
>> On systems running the MLS policy, when files and directories are 
>> copied, they inherit the type from the parent directory they are being 
>> copied to, and the level from the process that copied them.
>>
>> [1] By default, the type is copied from the parent directory. This 
>> behavior can be overridden by using type_transition statements in custom 
>> SELinux policies. Type transition rules are for a creating process 
>> domain, parent directory type, and file object class triple. For 
>> example, when a process creates a file in /tmp/, a type transition rule 
>> is usually defined so that each domain gets its own private, temporary 
>> file type.
>>>>  On systems running the MLS policy, when 
>>>> files are copied, they inherit the type from the parent directory they 
>>>> are being copied to, and the level from the process that copied them.
>>>>
>>>> Is the last sentence, is "the level from the process that copied them" 
>>>> correct? Should it be "from the process or user that..."?
>>>>
>>>> [1] By default, the type is copied from the parent directory. This 
>>>> behavior can be overridden by using type_transition statements in custom 
>>>> SELinux policies.
>>>>
>>>> I've included an example at the end of the section to show copying a 
>>>> file over an existing one.
>>>>
>>>> Thanks for your feedback.
>>>>
>>>> --
>>>> This message was distributed to subscribers of the selinux mailing list.
>>>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>>>> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
