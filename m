Message-ID: <4B842560.4080708@gmail.com>
Date: Tue, 23 Feb 2010 10:58:40 -0800
From: "Justin P. mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Alan Rouse <alan.rouse@ericsson.com>, Dominick Grift <domg472@gmail.com>,
        "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: SELinux Policy in OpenSUSE 11.2
References: <5A5E55DF96F73844AF7DFB0F48721F0F529A558532@EUSAACMS0703.eamcs.ericsson.se>	 <1266614711.32011.107.camel@moss-pluto.epoch.ncsc.mil>	 <4B7F06F1.4070305@gmail.com>	 <1266847250.15933.23.camel@moss-pluto.epoch.ncsc.mil>	 <dd18b0c31002221127j4c22e9d1v94c037e86e7bb74e@mail.gmail.com>	 <dd18b0c31002221129s4be9b56cha13b7be39c2cba36@mail.gmail.com>	 <4B82E190.5060306@gmail.com>	 <1266870268.15933.132.camel@moss-pluto.epoch.ncsc.mil>	 <dd18b0c31002221325ie418a7ep589e9ac0fe98f1f5@mail.gmail.com>	 <4B8300B8.7060501@gmail.com>	 <dd18b0c31002221435s39a27b0fvf4f9dfa4699360ae@mail.gmail.com>	 <4B8372FB.4040605@gmail.com>	 <1266932425.871.13.camel@moss-pluto.epoch.ncsc.mil>	 <5A5E55DF96F73844AF7DFB0F48721F0F52E41FFA04@EUSAACMS0703.eamcs.ericsson.se>	 <1266941425.871.18.camel@moss-pluto.epoch.ncsc.mil>	 <4B84135E.8010402@gmail.com>	 <1266948097.871.27.camel@moss-pluto.epoch.ncsc.mil>	 <4B841EA8.6040908@gmail.com> <1266950573.871.61.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1266950573.871.61.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 02/23/2010 10:42 AM, Stephen Smalley wrote:
> On Tue, 2010-02-23 at 10:30 -0800, Justin P. mattock wrote:
>> On 02/23/2010 10:01 AM, Stephen Smalley wrote:
>>> On Tue, 2010-02-23 at 09:41 -0800, Justin P. mattock wrote:
>>>> On 02/23/2010 08:10 AM, Stephen Smalley wrote:
>>>>> On Tue, 2010-02-23 at 10:56 -0500, Alan Rouse wrote:
>>>>>> Would the proper solution be to add a transition to put that script in the right context when run from a shell?
>>>>>
>>>>> No.  I think we just need to drop the transition to sysadm_t altogether
>>>>> (at least in the ifdef suse case) and have userspace explicitly arrange
>>>>> the transition for single-user mode (ala sulogin).
>>>>
>>>> out of curiosity during booting up I'm seeing
>>>> a mess load of *.sh files being called
>>>> before the policy is loaded.
>>>>
>>>> looking into this I'm seeing them in /lib/mkinitrd/scripts
>>>> before I go and mess around with initrd
>>>> what are the thoughts on this area?
>>>
>>> That's ok - I wouldn't worry about that.
>>>
>>> As I said, I think the solution here is just to disable the transition
>>> to sysadm_t, at least if DISTRO=suse.
>>>
>>
>>
>> alright.. in regards to sysadm_t
>> a quick google found something
>> similar to what might be happening:
>>
>> http://www.engardelinux.org/modules/index/list_archives.cgi?list=selinux&page=1000.html&month=2008-03
>
> That was the original discussion that led to the logic you see in
> init.te today.  In any event, I've taken this up as a separate issue on
> refpolicy list.
>


alright..
I'll look to file some bugs at suse
for pam.d, the config file with the
permissions being that cause libselinux to default
to targeted. and any other that I can think of.

Justin P. mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
