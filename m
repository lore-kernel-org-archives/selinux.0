Cc: Chad Sellers <csellers@tresys.com>, Joshua Brindle <jbrindle@tresys.com>,
        jwcart2@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
        Paul Howarth <paul@city-fan.org>, SE Linux <selinux@tycho.nsa.gov>,
        Stephen Lawrence <slawrence@tresys.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eamon Walsh <ewalsh@tycho.nsa.gov>
Message-Id: <789CDC33-514C-4816-AF43-BBD629075BA5@nall.com>
From: Joe Nall <joe@nall.com>
To: Joshua Brindle <method@manicmethod.com>
In-Reply-To: <4A5B7180.8080909@manicmethod.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [RFC] Install SELinux policies from rpm package header
Date: Mon, 13 Jul 2009 13:39:57 -0500
References: <C680D5CD.A8AD7%csellers@tresys.com> <9DB3FF14-CCB5-445C-BE63-1EBE84125E6A@nall.com> <4A5B7180.8080909@manicmethod.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Jul 13, 2009, at 12:40 PM, Joshua Brindle wrote:

> Joe Nall wrote:
>>
>> On Jul 13, 2009, at 11:15 AM, Chad Sellers wrote:
>>
>>> On 7/10/09 4:26 PM, "Joshua Brindle" <jbrindle@tresys.com> wrote:
>>>
>>>>> From: James Carter [mailto:jwcart2@tycho.nsa.gov]
>>>>>
>>>>>> Its alot worse than that. What about files on backup
>>>>> drives? Offline drives?
>>>>>> transient files that will get relabeled to something  
>>>>>> inappropriate?
>>>>>> I'm not confortable relabeling databases with potentially  
>>>>>> sensitive
>>>>>> data to var_lib_t because mysql was uninstalled.
>>>>>>
>>>>>
>>>>> The argument seems to be for removing the ability to remove  
>>>>> modules.
>>>>> It would be the roach motel style of policy management.
>>>>>
>>>>
>>>> I like it, policies check in but don't check out. I haven't heard  
>>>> an
>>>> argument about 1) how I'm crazy and wrong or 2) how to keep systems
>>>> running as expected otherwise though.
>>>
>>> There's certainly a case for leaving all policy installed. Policy is
>>> configuration data, which RPM also leaves installed when removing
>>> packages.
>>> We could easily treat policy the same.
>>
>> Our app has 140 rpms that install policy. They install in the %post  
>> and
>> do a restorecon of the relevant installed files and
>> /etc/selinux/mls/modules. Daemons are stopped in the %preun. Policy  
>> is
>> removed in the %postun and more restorecon occurs. The biggest  
>> annoyance
>> with this approach is the 140 individual transactions are ssllooww.
>>
>
> Yes, if you want to test out the patch sent to the rpm list and  
> report results with lots of policy packages that would be awesome :)
>
>> I would really like to see policy batched up and installed early in  
>> the
>> transaction. I think blindly leaving the policy behind on uninstall  
>> is
>> configuration management insanity. When an rpm is removed, all of the
>> unmodified installation should be removed with it. Files should be
>> relabeled to match the post installation policy. That way a  
>> subsequent
>> install behaves the way you would intuitively expect.
>>
>
> I see the claim but I don't see the argument. A subsequent install  
> will either replace the old module or do nothing (if its the same)  
> and all the old files will already be labeled properly, in fact this  
> is the main reason I want to leave old policies around. Note that  
> users will always be able to remove policies themselves, I just  
> don't think we can make rpm smart enough to know the users  
> intentions (perhaps if it was written in python we could just import  
> psychic :) )

We are going to have to disagree on what is proper. Based on our  
experience with multiple policies, I think you are going to get into  
trouble with policy upgrades when type declarations move or multiple  
rpms declare the same type in policy. You have to think about how  
policies and rpms evolve over time.

joe

>> If the app developer is concerned about the post-uninstall type
>> enforcement on application created files, a separate policy rpm  
>> solves
>> the problem.
>>
>
> This isn't practical. Sure some app developer may write an uninstall  
> module but those aren't going to exist for all the policies in  
> refpolicy.
>
> A kind-of-like-this idea I came up with was to have an "uninstall  
> template" that would take the old module, find the file types and  
> fill in the uninstall template policy with that, that way files  
> would keep their types and the uninstall template could give admins/ 
> backup apps/etc continuing access. I feel like this would be far too  
> fragile and easy to mess up though.
>
> --
> This message was distributed to subscribers of the selinux mailing  
> list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov 
>  with
> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
