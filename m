Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s67FNTjI031279
 for <selinux@tycho.nsa.gov>; Mon, 7 Jul 2014 11:23:30 -0400
Message-ID: <53BABB6E.4060207@redhat.com>
Date: Mon, 07 Jul 2014 11:23:26 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: dE <de.techno@gmail.com>, selinux@tycho.nsa.gov
Subject: Re: Listing restrictions on roles.
References: <53B39378.1090003@gmail.com> <53B524B5.3000109@redhat.com>
 <53B82AB0.3070302@gmail.com>
In-Reply-To: <53B82AB0.3070302@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


On 07/05/2014 12:41 PM, dE wrote:
> On 07/03/14 15:09, Daniel J Walsh wrote:
>> On 07/02/2014 01:07 AM, dE wrote:
>>> There seem to exist additional non-transition restrictions on roles
>>> which define when will a process be able to execute as a certain role.
>>>
>>> For e.g. a process which runs from a login shell cannot have system_r
>>> role. How do I list such rules?
>>>
>>> Looking at role transition rules, a transition to system_r should be
>>> allowed --
>>>
>>> sesearch --role_allow | grep system_r\;
>>> ...
>>> allow unconfined_r system_r;
>>> ...
>>>
>>> And the sudo process runs as unconfined_r --
>>>
>>> ps auxZ | grep sudo
>>> system_u:unconfined_r:unconfined_t:s0 root 669  0.0  0.4 206860 3356
>>> pts/1    S+   10:28   0:00 sudo -r unconfined_r nano
>>>
>>> But sudo -r system_r nano fails.
>>> _______________________________________________
>>> Selinux mailing list
>>> Selinux@tycho.nsa.gov
>>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>>> To get help, send an email containing "help" to
>>> Selinux-request@tycho.nsa.gov.
>> The type has to be available to the role.  In the case of sudo -r
>> system_r nano, if the type to be run is unconfined_t, then SELinux would
>> end up with a label like
>>
>> sytem_u:system_r:unconfined_t:s0
>>
>> But I don't believe unconfined_t can run in the system_r role.
>>
>> seinfo -rsystem_r -x | grep unconfined_t
>>
>> To make your sudo command run, you would also need to select the type.
>>
>> sudo -r sysadm_r -t nano_t nano ...
>>
>> Or something like that where nano_t is available to the system_r role.
>
> Actually it is allowed
>
> seinfo -rsystem_r -x | grep unconfined_t
>          virt_qemu_ga_unconfined_t
>          certmonger_unconfined_t
>          pegasus_openlmi_unconfined_t
>          xdm_unconfined_t
>          unconfined_t
>
> I'm running Fedora 19.
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
Ok, I have the unoconfined.pp module disabled.
