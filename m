Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id rA2LIoEC000535
	for <selinux@tycho.nsa.gov>; Sat, 2 Nov 2013 17:18:52 -0400
Received: by mail-qc0-f182.google.com with SMTP id n7so3142254qcx.41
        for <selinux@tycho.nsa.gov>; Sat, 02 Nov 2013 14:18:49 -0700 (PDT)
Message-ID: <52756C2D.1030408@quarksecurity.com>
Date: Sat, 02 Nov 2013 17:18:37 -0400
From: Joshua Brindle <brindle@quarksecurity.com>
MIME-Version: 1.0
To: Casey Schaufler <casey@schaufler-ca.com>
CC: Sven Vermeulen <sven.vermeulen@siphos.be>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: Been looking at further shrinkage of the SELinux footprint on
 Linux.
References: <52715E75.5000005@redhat.com>	<527168B1.4040905@tycho.nsa.gov>	<52716DE6.8040401@redhat.com> <CAPzO=NyM2K5zb3DemGOxCFVU3dwuFDjo23AgtxS=oSwxrFdDxA@mail.gmail.com> <52753FEA.2020800@schaufler-ca.com>
In-Reply-To: <52753FEA.2020800@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Casey Schaufler wrote:
> On 11/2/2013 9:42 AM, Sven Vermeulen wrote:
>> On Wed, Oct 30, 2013 at 9:36 PM, Daniel J Walsh<dwalsh@redhat.com>  wrote:
>> [...]
>>>> On 10/30/2013 03:31 PM, Daniel J Walsh wrote:
>>>>> We are trying to shrink out cloud image as small as possible.  One idea
>>>>> was to shrink SELinux Policy footprint by adding compression to it.
>> [...]
>>>> Personally, I'd much rather see work done on shrinking the actual policy
>>>> size in Fedora rather than just compressing it.  Both by reducing the
>>>> overall size of refpolicy through coalescing similar domains/types and by
>>>> making better use of the work that has already been done to support putting
>>>> policy modules into rpms and only installing what actually get used.
>> [...]
>>> Well we have done some work on combining like domains, see antivirus and
>>> spamassassin, but this is a lot of work which no one has time for.
>>>
>>> I would love to see the mailserver and mailclients domains combined.
>>>
>>> If people want to suggest or more importantly submit patches to combine other
>>> domains, I am all for it.
>>>
>>> Problems with shipping policy within rpm still exists. although we (Red Hat)
>>> are at least moving toward layered products shipping their own policy.
>>> openstack-selinux, openshift-selinux, gluster-selinux.  This is more for them
>>> updating quicker then RHEL.
>> In Gentoo, we try to only install the SELinux policies related to the
>> package that is installed. So if a system does not have a web server,
>> no httpd policies are loaded. This works pretty well. My workstation
>> (which is where I do all my SELinux policy development on) has 100
>> policy modules loaded; my servers usually have around 50 to 60 modules
>> loaded. That makes running things like "semodule -B" rather smooth.
>> Not really fast, but one doesn't need to switch to another thing to do
>> while waiting (4 seconds on a VM I'm currently playing with).
>
> A lot of work is being done to improve the start-up time
> of consumer (e.g. phones) devices and "disposable" VMs. We're
> talking about people getting their knickers in a twist over
> security adding 20 milliseconds to the boot process. Your
> 4 second semodule run is not going to fly.

semodule has nothing to do with the boot process. It is used to rebuild 
policies when something changes, e.g., a module is added or removed from 
the policy.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
