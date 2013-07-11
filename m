Message-ID: <51DF09A2.60706@tycho.nsa.gov>
Date: Thu, 11 Jul 2013 15:38:10 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Andy Ruch <adruch2002@yahoo.com>
CC: SELinux ML <selinux@tycho.nsa.gov>
Subject: Re: AVC for unlabeled_t on cgroup
References: <1373567937.10428.YahooMailNeo@web163406.mail.gq1.yahoo.com> <51DF023A.3020101@tycho.nsa.gov> <1373570675.68774.YahooMailNeo@web163401.mail.gq1.yahoo.com>
In-Reply-To: <1373570675.68774.YahooMailNeo@web163401.mail.gq1.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 07/11/2013 03:24 PM, Andy Ruch wrote:
>
>> ________________________________
>> From: Stephen Smalley <sds@tycho.nsa.gov>
>> To: Andy Ruch <adruch2002@yahoo.com>
>> Cc: SELinux ML <selinux@tycho.nsa.gov>
>> Sent: Thursday, July 11, 2013 1:06 PM
>> Subject: Re: AVC for unlabeled_t on cgroup
>>
>>
>> On 07/11/2013 02:38 PM, Andy Ruch wrote:
>>> Hello,
>>>
>>> I'm implementing a restrictive policy for RHEL 6.3 based on CLIP. I've enabled the cgroup module but I'm still seeing the AVC below. This is just one of a dozen similar AVC's for different inodes. When I look at the /cgroup after the system boots, everything has a cgroup_t label. Where would the unlabeled_t be coming from?
>>>
>>>
>>>
>>> type=SYSCALL msg=audit(07/11/2013 17:25:38.885:7) : arch=x86_64 syscall=mount success=yes exit=0 a0=7f57846ac4c1 a1=7f57848b03c0 a2=7f57846ac4c1 a3=0 items=0 ppid=1177 pid=1178 auid=unset uid=root gid=root euid=root suid=root fsuid=root egid=root sgid=root fsgid=root tty=(none) ses=unset comm=cgconfigparser exe=/sbin/cgconfigparser subj=system_u:system_r:cgconfig_t:s0 key=(null)
>>>
>>> type=AVC msg=audit(07/11/2013 17:25:38.885:7) : avc:  denied  { search } for  pid=1178 comm=cgconfigparser name=/ dev=cgroup ino=12518 scontext=system_u:system_r:kernel_t:s0 tcontext=system_u:object_r:unlabeled_t:s0 tclass=dir
>>
>> That's likely a kernel-internal lookup during creation of a cgroup
>> inode.  cgroup has some code to switch to the kernel credential when
>> performing such lookups to avoid permission denials IIRC, which presumes
>> then that you allow this in your policy. Doesn't show up in typical
>> policies as they allow kernel_t all access since it can do anything it
>> wants anyway.
>>
>>
>>
>
>
> Since this is beyond my expertise, any recommendations for handling it? Do I ignore it? Allowing kernel_t all access doesn't seem like a good option for a secure system. We're not really using cgroups, but it's required for libvirt.

I would allow it.  The kernel can do anything it wants regardless, so 
you don't gain any security by denying it, and denying it will likely 
break cgroup usage.  The only thing to make sure of is that nothing is 
running in kernel_t other than kernel threads, e.g.
$ ps -elZ | grep kernel_t | awk '$6 != 2 {print}'
system_u:system_r:kernel_t:s0   1 S     0     2     0  0  80   0 -    0 
kthrea ?        00:00:00 kthreadd



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
