From: kuangjiou <kuangjiou@huawei.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: =?gb2312?B?tPC4tDogZ290IHNvbWUgcHJvYmxlbXMgd2l0aCB0aGUgc2VsaW51eCBwb2xp?=
 =?gb2312?Q?cy?=
Date: Wed, 15 Apr 2015 02:11:29 +0000
Message-ID: <60ABE64B4BE4AC45964F1A967BA76CB20156A519@szxeml522-mbx.china.huawei.com>
References: <60ABE64B4BE4AC45964F1A967BA76CB20156A477@szxeml522-mbx.china.huawei.com>
 <552D0F7C.3080206@tycho.nsa.gov>
In-Reply-To: <552D0F7C.3080206@tycho.nsa.gov>
Content-Type: text/plain; charset="gb2312"
MIME-Version: 1.0
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I use the refpolicy(20080702) in my linux , the system can start successful , so I think there must be something wrong with my own policy.

I use my own policy and I got this messages during the system start time 

/proc on /proc type proc (rw)
Mount: /proc dose not contain SELinux labels.
	You just mounted an file system that supports labels which does not contain labels, onto SElinux box. It is likely that confined applications will generate AVC messages and not allowed access to this file system. For more details see restorecon and mount
Sysfs on /sys type sysfs (rw)
Mount: /sys dose not contain SELinux labels.
	You just mounted an file system that supports labels which does not contain labels, onto SElinux box. It is likely that confined applications will generate AVC messages and not allowed access to this file system. For more details see restorecon and mount
Debugfs on /sys/kernel/debug type debugfs (rw)
Mount: /sys/kernel/debug dose not contain SELinux labels.
	You just mounted an file system that supports labels which does not contain labels, onto SElinux box. It is likely that confined applications will generate AVC messages and not allowed access to this file system. For more details see restorecon and mount
Mount: translated rootcontext='system_u:object_r:unconfined_t' to 'system_u:object_r:unconfined_t'
Udev on /dev type tmpfs (rw,rw,)
Mount: /dev dose not contain SELinux labels.
	You just mounted an file system that supports labels which does not contain labels, onto SElinux box. It is likely that confined applications will generate AVC messages and not allowed access to this file system. For more details see restorecon and mount
Aborted

-----邮件原件-----
发件人: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
发送时间: 2015年4月14日 21:01
收件人: kuangjiou; selinux@tycho.nsa.gov
主题: Re: got some problems with the selinux policy

On 04/13/2015 11:29 PM, kuangjiou wrote:
> Hello,everyone!
> 
>  
> 
> I am trying to setup selinux in my linux (SLES 11 sp3 with kernel 
> 3.0.76-0.11-default, the /selinux/policyvers is 26), and I got some 
> problem when reboot the OS after i install my own selinux policy. I 
> would be very grateful if anyone can help me to solve this problem
> 
> Here are some description of my problem
> 
>  
> 
>  
> 
> 1.when I compile my policy to a non-mls policy (version 24),and add 
> the boot parameters (security=selinux selinux=1),The system will stuck 
> in the start page.
> 
> 2 when I set the boot parameters to selinux=0,the system will start 
> successful
> 
> 3 when I set the boot parameter to (security=selinux selinux=1), and 
> delete the /etc/selinux/config so that the os will not load the 
> selinux policy during the start time. After the OS is started, I 
> rebuild the /etc/selinux/config file and use the load_policy command 
> to load the selinux policy, It can loaded successful.
> 
>  
> 
>  
> 
> 4 when I compile my policy to a mls policy (version 24).and set the 
> boot parameters (security=selinux selinux=1),The system will start 
> successful
> 
>  
> 
> 5 when I try the actions all above than compile the policy to version 
> 26, the results are the same.
> 
>  
> 
> 6 when I try the actions all above in my other linux (SLES 11 sp1 with 
> 2.6.32.12-0.7-default,the /selinux/policyvers is 26 ) the system will 
> start successful
> 
>  
> 
> and you can see my policy.conf in the attachment.

Difficult to diagnose without the actual kernel output from the failed boots - can you boot non-graphically and capture that?  Sounds like a kernel bug in your 3.0.76-0.11-default kernel not handling non-MLS policies correctly.  That's not a well tested path anymore, as all Fedora and Red Hat policies have MLS enabled (even targeted policy has it enabled for MCS) and likewise Android has MLS enabled in its policy.

Normally you would just use whatever policy version is supported by your libsepol/checkpolicy; libselinux will automatically downgrade the policy file to whatever version is supported by your kernel at load time (if using upstream SELinux userspace, not true in Android).

Any particular reason you can't just enable MLS in your policy?  It is enabled for TYPE=mls or TYPE=mcs in refpolicy build.conf; they are both using the MLS engine.
