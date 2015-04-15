MIME-Version: 1.0
In-Reply-To: <60ABE64B4BE4AC45964F1A967BA76CB20156A519@szxeml522-mbx.china.huawei.com>
References: <60ABE64B4BE4AC45964F1A967BA76CB20156A477@szxeml522-mbx.china.huawei.com>
 <552D0F7C.3080206@tycho.nsa.gov>
 <60ABE64B4BE4AC45964F1A967BA76CB20156A519@szxeml522-mbx.china.huawei.com>
Date: Wed, 15 Apr 2015 10:39:09 -0400
Message-ID: <CAB9W1A2hBRR5t+WtB-EO7ULykHCVBw07J43dYNrpqNA8fT+3cQ@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=E7=AD=94=E5=A4=8D=3A_got_some_problems_with_the_selinux_polic?=
 =?UTF-8?Q?y?=
From: Stephen Smalley <stephen.smalley@gmail.com>
To: kuangjiou <kuangjiou@huawei.com>, Daniel J Walsh <dwalsh@redhat.com>
Content-Type: text/plain; charset=UTF-8
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I had never seen those errors before, so I downloaded the util-linux
source code to see what they mean.  It seems that mount is checking
whether the context fetched from the filesystem matches the default
for a file with no extended attribute set, and if so, complaining.  It
is however only a warning message, not an error, and I suspect in your
case it is because your policy does not define a different context for
these filesystems than the one used for the file initial SID.  Also,
the messages from mount about rootcontext= are odd; you should not be
assigning unconfined_t to the root directory of those mounts.  It
looks like your policy is breaking assumptions made by userspace.  in
one of your logs, it also showed denials that suggested that your /dev
tree is not being correctly labeled.  Not sure whether SUSE does any
testing of SELinux as it is not their default.

On Tue, Apr 14, 2015 at 10:11 PM, kuangjiou <kuangjiou@huawei.com> wrote:
> I use the refpolicy(20080702) in my linux , the system can start successful , so I think there must be something wrong with my own policy.
>
> I use my own policy and I got this messages during the system start time
>
> /proc on /proc type proc (rw)
> Mount: /proc dose not contain SELinux labels.
>         You just mounted an file system that supports labels which does not contain labels, onto SElinux box. It is likely that confined applications will generate AVC messages and not allowed access to this file system. For more details see restorecon and mount
> Sysfs on /sys type sysfs (rw)
> Mount: /sys dose not contain SELinux labels.
>         You just mounted an file system that supports labels which does not contain labels, onto SElinux box. It is likely that confined applications will generate AVC messages and not allowed access to this file system. For more details see restorecon and mount
> Debugfs on /sys/kernel/debug type debugfs (rw)
> Mount: /sys/kernel/debug dose not contain SELinux labels.
>         You just mounted an file system that supports labels which does not contain labels, onto SElinux box. It is likely that confined applications will generate AVC messages and not allowed access to this file system. For more details see restorecon and mount
> Mount: translated rootcontext='system_u:object_r:unconfined_t' to 'system_u:object_r:unconfined_t'
> Udev on /dev type tmpfs (rw,rw,)
> Mount: /dev dose not contain SELinux labels.
>         You just mounted an file system that supports labels which does not contain labels, onto SElinux box. It is likely that confined applications will generate AVC messages and not allowed access to this file system. For more details see restorecon and mount
> Aborted
>
> -----邮件原件-----
> 发件人: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> 发送时间: 2015年4月14日 21:01
> 收件人: kuangjiou; selinux@tycho.nsa.gov
> 主题: Re: got some problems with the selinux policy
>
> On 04/13/2015 11:29 PM, kuangjiou wrote:
>> Hello,everyone!
>>
>>
>>
>> I am trying to setup selinux in my linux (SLES 11 sp3 with kernel
>> 3.0.76-0.11-default, the /selinux/policyvers is 26), and I got some
>> problem when reboot the OS after i install my own selinux policy. I
>> would be very grateful if anyone can help me to solve this problem
>>
>> Here are some description of my problem
>>
>>
>>
>>
>>
>> 1.when I compile my policy to a non-mls policy (version 24),and add
>> the boot parameters (security=selinux selinux=1),The system will stuck
>> in the start page.
>>
>> 2 when I set the boot parameters to selinux=0,the system will start
>> successful
>>
>> 3 when I set the boot parameter to (security=selinux selinux=1), and
>> delete the /etc/selinux/config so that the os will not load the
>> selinux policy during the start time. After the OS is started, I
>> rebuild the /etc/selinux/config file and use the load_policy command
>> to load the selinux policy, It can loaded successful.
>>
>>
>>
>>
>>
>> 4 when I compile my policy to a mls policy (version 24).and set the
>> boot parameters (security=selinux selinux=1),The system will start
>> successful
>>
>>
>>
>> 5 when I try the actions all above than compile the policy to version
>> 26, the results are the same.
>>
>>
>>
>> 6 when I try the actions all above in my other linux (SLES 11 sp1 with
>> 2.6.32.12-0.7-default,the /selinux/policyvers is 26 ) the system will
>> start successful
>>
>>
>>
>> and you can see my policy.conf in the attachment.
>
> Difficult to diagnose without the actual kernel output from the failed boots - can you boot non-graphically and capture that?  Sounds like a kernel bug in your 3.0.76-0.11-default kernel not handling non-MLS policies correctly.  That's not a well tested path anymore, as all Fedora and Red Hat policies have MLS enabled (even targeted policy has it enabled for MCS) and likewise Android has MLS enabled in its policy.
>
> Normally you would just use whatever policy version is supported by your libsepol/checkpolicy; libselinux will automatically downgrade the policy file to whatever version is supported by your kernel at load time (if using upstream SELinux userspace, not true in Android).
>
> Any particular reason you can't just enable MLS in your policy?  It is enabled for TYPE=mls or TYPE=mcs in refpolicy build.conf; they are both using the MLS engine.
>
>
>
>
>
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
