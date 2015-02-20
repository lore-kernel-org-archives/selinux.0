Message-ID: <54E7B1CB.2070202@redhat.com>
Date: Fri, 20 Feb 2015 17:14:35 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, Mark Lee <markleee50@gmail.com>,
 selinux@tycho.nsa.gov
Subject: Re: Odd occurrence of /sbin/setfiles running
References: <CAMPpu2Up6bvquf2fXZbFd+jW1KcSSPJZhQEhmgRysgigNDnU7A@mail.gmail.com>
 <54E7342B.6040405@tycho.nsa.gov>
In-Reply-To: <54E7342B.6040405@tycho.nsa.gov>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


On 02/20/2015 08:18 AM, Stephen Smalley wrote:
> On 02/19/2015 12:53 PM, Mark Lee wrote:
>> Hello List,
>>
>> I'm dealing with some strange occurrences in my audit log and was
>> wondering if anyone could shed some light.
>>
>> First off "/sbin/setfiles" ran, for no apparent reason,  I didn't run
>> the command, wasn't applying any new selinux policies or in any way
>> interacting with the system.  I looked back through the logs and there
>> was no other occurrences of this happening other then twice yesterday.
>> Example:
>>
>> linux-audit type=SYSCALL msg=audit(1424298673.524:35003): arch=c000003e
>> syscall=59 success=yes exit=0 a0=23fcc10 a1=2892c10 a2=7fffbfbdac58
>> a3=7473616d5f6e6f69 items=0 ppid=728 pid=757 auid=0 uid=0 gid=0 euid=0
>> suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=3490
>> comm="restorecon" exe="/sbin/setfiles"
>> subj=unconfined_u:system_r:setfiles_t:s0 key=(null)
>>
>>
>> Secondly, I have a bunch of selinux denied messages, such as:
>>
>>
>> linux-audit type=AVC msg=audit(1424298673.524:35003): avc:  denied  {
>> read write } for  pid=757 comm="restorecon" path="[eventfd]"
>> dev=anon_inodefs ino=3791 scontext=unconfined_u:system_r:setfiles_t:s0
>> tcontext=system_u:object_r:anon_inodefs_t:s0 tclass=file
>>
>> The inodes for these selinux denied events trace back to:
>>
>> /sys/devices/virtual/block/ram10/trace/end_lba
>> /sys/devices/virtual/block/ram10/queue/max_segments
>>
>> I am completely stumped and would appreciate any help.
> Is there anything else in the logs around the same time that would help
> indicate what is running the restorecon?
>
> You didn't say anything about your distribution.
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>
>
Did you do a yum update?
