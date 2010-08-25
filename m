Message-ID: <4C751D71.9000200@gmail.com>
Date: Wed, 25 Aug 2010 06:41:05 -0700
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: imsand@puzzle.ch
CC: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: Enable selinux in SLES 11
References: <28077.193.5.216.100.1282569834.squirrel@mail.puzzle.ch>    <4C72A7CB.1020105@gmail.com>    <34832.193.5.216.100.1282634053.squirrel@mail.puzzle.ch>    <4C73C991.8020100@gmail.com>    <18511.193.5.216.100.1282658950.squirrel@mail.puzzle.ch>    <4C73DAB1.7080501@gmail.com> <56831.193.5.216.100.1282722811.squirrel@mail.puzzle.ch>
In-Reply-To: <56831.193.5.216.100.1282722811.squirrel@mail.puzzle.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 08/25/2010 12:53 AM, imsand@puzzle.ch wrote:
>> On 08/24/2010 07:09 AM, imsand@puzzle.ch wrote:
>>>> On 08/24/2010 12:14 AM, imsand@puzzle.ch wrote:
>>>>>> On 08/23/2010 06:23 AM, imsand@puzzle.ch wrote:
>>>>>>> Hello Everybody
>>>>>>>
>>>>>>> For quite a while I've been trying to enable selinux in SLES11, but
>>>>>>> sestatus always show DISABLED.
>>>>>>>
>>>>>>> The following steps I've already done:
>>>>>>>       * installed all *selinux* packages from yast2
>>>>>>>       * add the following boot parameters to the kernel:
>>>>>>> security=selinux
>>>>>>> selinux=1 enforcing=0
>>>>>>>       * created /etc/selinux/config file with the that content:
>>>>>>>         SELINUX=enforcing
>>>>>>>         SELINUXTYPE=targeted
>>>>>>>
>>>>>>> What I've noticed is, that /selinux doesn't exit. I can't create
>>>>>>> that
>>>>>>> mountpoint manually because selinuxfs filesystem doesn't exist.
>>>>>>>
>>>>>>> Does anybody knows if that could be the reason? and if so, how do i
>>>>>>> get
>>>>>>> selinux work on SLES 11.
>>>>>>> (As far as I know SLES 11 should be prepared to use selinux as
>>>>>>> technical
>>>>>>> preview).
>>>>>>>
>>>>>>> Thanks in advance
>>>>>>> Matthias
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> --
>>>>>>> This message was distributed to subscribers of the selinux mailing
>>>>>>> list.
>>>>>>> If you no longer wish to subscribe, send mail to
>>>>>>> majordomo@tycho.nsa.gov
>>>>>>> with
>>>>>>> the words "unsubscribe selinux" without quotes as the message.
>>>>>>>
>>>>>>
>>>>>>
>>>>>> should be working(at-least for opensuse 12),you need to mkdir
>>>>>> /selinux
>>>>>> then reboot(SELinux will mount it's file-system there(but cant if the
>>>>>> mount-point doesn't exist)).
>>>>>>
>>>>>> Justin P. Mattock
>>>>>>
>>>>>> --
>>>>>> This message was distributed to subscribers of the selinux mailing
>>>>>> list.
>>>>>> If you no longer wish to subscribe, send mail to
>>>>>> majordomo@tycho.nsa.gov
>>>>>> with
>>>>>> the words "unsubscribe selinux" without quotes as the message.
>>>>>>
>>>>>
>>>>> OpenSuse12? Do you mean opensuse 11.2?
>>>>> Any other suggestions?
>>>>>
>>>>>
>>>>
>>>>
>>>> yeah open suse 11.2 Oops... as for any other advice, what Stephan had
>>>> posted for you is probably the right info to go through.. just dont be
>>>> afraid to ask questions..
>>>>
>>>> Justin P. Mattock
>>>>
>>>> Justin P. Mattock
>>>>
>>> Unfortunately it doesn't work. I've done all steps described in here:
>>> http://thetoms-random-thoughts.blogspot.com/2008/12/selinux-on-opensuse-111.html
>>> but this doesn't seems to work for sles 11.
>>> Anybody out there, who was able to run selinux on sles 11?
>>> I've got some other questions?
>>>     * what happens if the policy is not found? what would sestatus
>>> report?
>>>     * are there some good debug options for selinux? logs? any other
>>> hints?
>>> (dmesg shows nothing related to selinux)
>>>
>>> best regards
>>> Imsand
>>>
>>>
>
> Thank you for your answer.
> Now I'm one step further :)
> SELinux will now be loaded during startup. YEAH!!!
> But now it has a problem with the installed policy. I get this error:

hey alright!!!

> -----
> SELinux: Could not open policy file<=
> /etc/selinux/refpolicy-standard/policy/policy.23: No such file or
> directory
> Unable to load SELinux Policy. Machine is in enforcing mode. halting now.

theres a policy version you can give to the policy in the 
policy(build.conf)and in the kernel you can disable this in the kernel
then rebuild refpolicy to not use this(or set the kernel at 23/23 etc.. 
and set it in the policy.

> -----
>
> It is looking for a version 23 policy. but the installed one is
> /etc/selinux/refpolicy-standard/policy/policy.24.
>
> Simply renaming policy.24 to policy.23 doesn't work.
> ----
> SELinux: policydb version 24 does not match my version range 15-23
> SELinux: Could not load policy file
> /etc/selinux/refpolicy-standard/policy/policy.23: Invalid argument.
> ----
>
> Based on this error I have some questions:
> 1) It seems that SELinux is looking for a binary policy. Are there only
> monolithic policies allowed? Or how can I use the newer modular policies?
>

either or.. binary is easier to deal with(I think)

> 2) Is there a possibility to converting version 24 policies to version 23?
> Or do I have to search a version 23 policy for sles 11?

if sles built the kernel with 23 then just rebuilt the policy with 23
(depending on the policy, it's located at /usr/share/selinux/*

>
> 3) How can I upgrade sles 11 so that is accepts version 24 policies? Which
> parts or library are responsible for the version-check?
>
> 4) The policies from tresys seems to have an other format than the one
> from
> http://download.opensuse.org/repositories/security:/SELinux/openSUSE_Factory
> that I've installed. (It is not simply a binary file?!?)
>
> Here are some more information based on your guidance:
>> hmm.. well if they have the SELinux packages from sles then thats a good
>> indication that theres support..
>>
>> some things need to be checked though:
>>
>> 1) if sles already has the SELinux packages then you already have
>> libselinux.so, libsepol, etc... if not, then download the SELinux
>> userspace package and install it(gives you all the tools and libraries
>> needed to use SELinux)
> installed by standard repository. This is okey!

main thing is making sure you build the arch i.e. opensuse x86_64 uses 
"multilib" x86_32 libs(-m32) and x86_64(-m64) libs /lib /lib64 so 
getting that you need to tweak a bit. if standard i686 everything just 
goes into /lib /usr/lib

>>
>> 2) is SELinux enabled in the kernel?(if not either build a vanilla and
>> check "y" under security options for SELinux, or grab an already built
>> rpm)
> yes it is.
> CONFIG_SECURITY_SELINUX=y
> CONFIG_SECURITY_SELINUX_BOOTPARAM=y
> CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE=0
> CONFIG_SECURITY_SELINUX_DISABLE=y
> CONFIG_SECURITY_SELINUX_DEVELOP=y
> CONFIG_SECURITY_SELINUX_AVC_STATS=y
> CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1
> CONFIG_SECURITY_SELINUX_ENABLE_SECMARK_DEFAULT=y
> # CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX is not set
>

CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX
so they didnt set this to a policy version, but they built the policy 
with 23

>> 2) sysvinit needs to have the init_load_policy() patch added to it in
>> order for the policy to be loaded at boot.(if using upstart theres a
>> patch as well, or proceedured to load_policy)
> seems to be.
>

if it's loading early, then yeah they patched sysvinit

>> 3) grab the latest refpolicy from tresys and install it.
>> (or use the rpm that sles has(if it has one)
>>
> used this:
> http://download.opensuse.org/repositories/security:/SELinux/openSUSE_Factory/noarch/selinux-policy-refpolicy-standard-2.20081210-13.1.noarch.rpm
> This installs a /etc/selinux/config which points to refpolicy-standard
> which was created in /etc/selinux/refpolicy-standard/policy.24
>

theres a bug with opensuse to where /etc/selinux/config had the wrong 
permissions (check and make sure: chmod 644 /etc/selinux/config
also add SETLOCALDEFS=0) heres the bug report for pam.d so you can have 
the right context:
https://bugzilla.novell.com/show_bug.cgi?id=582366
(simple fix)

also /etc/initscript messes things up so set the boolean
init_upstart to on(/usr/sbin/setesebool -P init_upstart on
or vim /etc/selinux/policytype/booleans*)


keep in mind these where things with opensuse so things might be 
different with sles


cool glad your working this!!

Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
