Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o7OEhF6i019638
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2010 10:43:15 -0400
Received: from mail-pw0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o7OEh5xN011999
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2010 14:43:05 GMT
Received: by pwi5 with SMTP id 5so2863453pwi.12
        for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2010 07:43:13 -0700 (PDT)
Message-ID: <4C73DAB1.7080501@gmail.com>
Date: Tue, 24 Aug 2010 07:44:01 -0700
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: imsand@puzzle.ch
CC: selinux@tycho.nsa.gov
Subject: Re: Enable selinux in SLES 11
References: <28077.193.5.216.100.1282569834.squirrel@mail.puzzle.ch>    <4C72A7CB.1020105@gmail.com>    <34832.193.5.216.100.1282634053.squirrel@mail.puzzle.ch>    <4C73C991.8020100@gmail.com> <18511.193.5.216.100.1282658950.squirrel@mail.puzzle.ch>
In-Reply-To: <18511.193.5.216.100.1282658950.squirrel@mail.puzzle.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 08/24/2010 07:09 AM, imsand@puzzle.ch wrote:
>> On 08/24/2010 12:14 AM, imsand@puzzle.ch wrote:
>>>> On 08/23/2010 06:23 AM, imsand@puzzle.ch wrote:
>>>>> Hello Everybody
>>>>>
>>>>> For quite a while I've been trying to enable selinux in SLES11, but
>>>>> sestatus always show DISABLED.
>>>>>
>>>>> The following steps I've already done:
>>>>>      * installed all *selinux* packages from yast2
>>>>>      * add the following boot parameters to the kernel:
>>>>> security=selinux
>>>>> selinux=1 enforcing=0
>>>>>      * created /etc/selinux/config file with the that content:
>>>>>        SELINUX=enforcing
>>>>>        SELINUXTYPE=targeted
>>>>>
>>>>> What I've noticed is, that /selinux doesn't exit. I can't create that
>>>>> mountpoint manually because selinuxfs filesystem doesn't exist.
>>>>>
>>>>> Does anybody knows if that could be the reason? and if so, how do i
>>>>> get
>>>>> selinux work on SLES 11.
>>>>> (As far as I know SLES 11 should be prepared to use selinux as
>>>>> technical
>>>>> preview).
>>>>>
>>>>> Thanks in advance
>>>>> Matthias
>>>>>
>>>>>
>>>>>
>>>>> --
>>>>> This message was distributed to subscribers of the selinux mailing
>>>>> list.
>>>>> If you no longer wish to subscribe, send mail to
>>>>> majordomo@tycho.nsa.gov
>>>>> with
>>>>> the words "unsubscribe selinux" without quotes as the message.
>>>>>
>>>>
>>>>
>>>> should be working(at-least for opensuse 12),you need to mkdir /selinux
>>>> then reboot(SELinux will mount it's file-system there(but cant if the
>>>> mount-point doesn't exist)).
>>>>
>>>> Justin P. Mattock
>>>>
>>>> --
>>>> This message was distributed to subscribers of the selinux mailing
>>>> list.
>>>> If you no longer wish to subscribe, send mail to
>>>> majordomo@tycho.nsa.gov
>>>> with
>>>> the words "unsubscribe selinux" without quotes as the message.
>>>>
>>>
>>> OpenSuse12? Do you mean opensuse 11.2?
>>> Any other suggestions?
>>>
>>>
>>
>>
>> yeah open suse 11.2 Oops... as for any other advice, what Stephan had
>> posted for you is probably the right info to go through.. just dont be
>> afraid to ask questions..
>>
>> Justin P. Mattock
>>
>> Justin P. Mattock
>>
> Unfortunately it doesn't work. I've done all steps described in here:
> http://thetoms-random-thoughts.blogspot.com/2008/12/selinux-on-opensuse-111.html
> but this doesn't seems to work for sles 11.
> Anybody out there, who was able to run selinux on sles 11?
> I've got some other questions?
>    * what happens if the policy is not found? what would sestatus report?
>    * are there some good debug options for selinux? logs? any other hints?
> (dmesg shows nothing related to selinux)
>
> best regards
> Imsand
>
>

hmm.. well if they have the SELinux packages from sles then thats a good 
indication that theres support..

some things need to be checked though:

1) if sles already has the SELinux packages then you already have 
libselinux.so, libsepol, etc... if not, then download the SELinux 
userspace package and install it(gives you all the tools and libraries 
needed to use SELinux)

2) is SELinux enabled in the kernel?(if not either build a vanilla and 
check "y" under security options for SELinux, or grab an already built rpm)

2) sysvinit needs to have the init_load_policy() patch added to it in 
order for the policy to be loaded at boot.(if using upstart theres a 
patch as well, or proceedured to load_policy)

3) grab the latest refpolicy from tresys and install it.
(or use the rpm that sles has(if it has one)

4) once the policy is loading at boot then create your login info so 
SELinux starts in the right context.(semanage login -a -s staff_u name)

5) use audit2allow to add allow rules for the apps you want to use.
(audit2allow -dM amodulenameforyourallowrules)

6) sit back with a beer(in enforcement mode) and enjoy SELinux!!

remember theres plenty of people here to get you up and running...

Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
