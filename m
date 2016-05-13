Subject: Re: [PATCH v2] libselinux: Mount procfs before checking
 /proc/filesystems
To: Stephen Smalley <sds@tycho.nsa.gov>, Ben Shelton <ben.shelton@ni.com>
References: <1429131417-8986-1-git-send-email-ben.shelton@ni.com>
 <552FA2F8.9040906@tycho.nsa.gov>
From: Laurent Bigonville <bigon@debian.org>
Cc: selinux@tycho.nsa.gov, 823184-forwarded@bugs.debian.org
Message-ID: <550830de-1388-49a4-a2ac-8b3a12299db1@debian.org>
Date: Fri, 13 May 2016 16:07:24 +0200
MIME-Version: 1.0
In-Reply-To: <552FA2F8.9040906@tycho.nsa.gov>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hey,

Le 16/04/15 à 13:54, Stephen Smalley a écrit :
> On 04/15/2015 04:56 PM, Ben Shelton wrote:
>> In the case where the SELinux security module is not loaded in the
>> kernel and it's early enough in the boot process that /proc has not yet
>> been mounted, selinuxfs_exists() will incorrectly return 1, and
>> selinux_init_load_policy() will print a message like this to the
>> console:
>>
>> Mount failed for selinuxfs on /sys/fs/selinux:  No such file or directory
>>
>> To fix this, mount the procfs before attempting to open
>> /proc/filesystems, and unmount it when done if it was initially not
>> mounted.  This is the same thing that selinux_init_load_policy() does
>> when reading /proc/cmdline.
>>
>> Signed-off-by: Ben Shelton <ben.shelton@ni.com>
> Thanks, applied.

In debian, I've a user complaining about the fact that libselinux is 
mounting /proc by itself and that it might racy.

What do you think?

https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=823184

Cheers,

Laurent Bigonville
