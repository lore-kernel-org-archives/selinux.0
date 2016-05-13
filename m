Subject: Re: [PATCH v2] libselinux: Mount procfs before checking
 /proc/filesystems
To: Laurent Bigonville <bigon@debian.org>, Ben Shelton <ben.shelton@ni.com>
References: <1429131417-8986-1-git-send-email-ben.shelton@ni.com>
 <552FA2F8.9040906@tycho.nsa.gov>
 <550830de-1388-49a4-a2ac-8b3a12299db1@debian.org>
Cc: selinux@tycho.nsa.gov, 823184-forwarded@bugs.debian.org
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <69371edf-a5fe-d8ee-409f-a1d320eeaa76@tycho.nsa.gov>
Date: Fri, 13 May 2016 11:19:29 -0400
MIME-Version: 1.0
In-Reply-To: <550830de-1388-49a4-a2ac-8b3a12299db1@debian.org>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/13/2016 10:07 AM, Laurent Bigonville wrote:
> Hey,
> 
> Le 16/04/15 à 13:54, Stephen Smalley a écrit :
>> On 04/15/2015 04:56 PM, Ben Shelton wrote:
>>> In the case where the SELinux security module is not loaded in the
>>> kernel and it's early enough in the boot process that /proc has not yet
>>> been mounted, selinuxfs_exists() will incorrectly return 1, and
>>> selinux_init_load_policy() will print a message like this to the
>>> console:
>>>
>>> Mount failed for selinuxfs on /sys/fs/selinux:  No such file or
>>> directory
>>>
>>> To fix this, mount the procfs before attempting to open
>>> /proc/filesystems, and unmount it when done if it was initially not
>>> mounted.  This is the same thing that selinux_init_load_policy() does
>>> when reading /proc/cmdline.
>>>
>>> Signed-off-by: Ben Shelton <ben.shelton@ni.com>
>> Thanks, applied.
> 
> In debian, I've a user complaining about the fact that libselinux is
> mounting /proc by itself and that it might racy.
> 
> What do you think?
> 
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=823184

Do you have this one?

commit 5a8d8c499b2ef80eaa7b5abe2ec68d7101e613bf
Author: Stephen Smalley <sds@tycho.nsa.gov>
Date:   Mon Feb 29 10:10:55 2016 -0500

    libselinux: only mount /proc if necessary

    Commit 9df498884665d ("libselinux: Mount procfs before checking
    /proc/filesystems") changed selinuxfs_exists() to always try
    mounting /proc before reading /proc/filesystems.  However, this is
    unnecessary if /proc is already mounted and can produce avc denials
    if the process is not allowed to perform the mount.  Check first
    to see if /proc is already present and only try the mount if it is not.

    Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>

Alternatively, I could see fixing this in selinux_init_load_policy()
[just retain the /proc mount across the selinuxfs_exists call] and
dropping the mount/umount entirely from selinuxfs_exists.
