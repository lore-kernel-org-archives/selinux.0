Message-Id: <04BE01E3-B511-4CDF-8FDE-253048E6D94A@gmail.com>
From: Sebastian Pfaff <sebastian.pfaff@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
In-Reply-To: <1246554192.13464.350.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: request for review of, and collaboration on SELinux models wiki entry
Date: Thu, 2 Jul 2009 20:12:45 +0200
References: <1246542053.26320.15.camel@notebook2.grift.internal> <1246544997.13464.314.camel@moss-pluto.epoch.ncsc.mil> <7DB3E8B4-9FFF-4FE1-873D-1A99C6EEF0AA@gmail.com> <1246549788.26320.42.camel@notebook2.grift.internal> <1246554192.13464.350.camel@moss-pluto.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> On Thu, 2009-07-02 at 17:49 +0200, Dominick Grift wrote:
>> On Thu, 2009-07-02 at 17:25 +0200, Sebastian Pfaff wrote:
>>> hello,
>>>
>>> from http://selinuxproject.org/page/SELinux_models (Multi Category
>>> Security):
>>>
>>> [...] Multi Category Security and Multi Level Security are mutually
>>> exclusive.
>>>
>>>> - MCS and MLS are just particular configurations of constraints for
>>>> the
>>>> MLS engine and thus share the same field and engine logic.  MCS  
>>>> was an
>>>> attempt to make the MLS field and engine useful for general  
>>>> users, and
>>>> is being leveraged by sandbox and by svirt for separating multiple
>>>> instances of sandboxes or guest VMs.
>>>
>>> In other words: MCS and MLS are not mutally exclusiv?! Not in  
>>> SELinux
>>> and not in gernal? For me, MCS in SELinux is an "extra",  which  you
>>> can use with MLS (or MLS engine) at the same time. Please correct  
>>> me,
>>> if i'm wrong.
>>>
>>> Imho, MCS uses "compartments" or categories to realize the need to
>>> know principle and MLS uses vertical levels to achieve (at least in
>>> SELinux) confidentiality (BLP model). Imo compartments and levels  
>>> are
>>> not mutally exclusive.
>>
>> MCS and MLS are SELinux models (MCS and MLS are just particular
>> configurations of constraints for the MLS engine and thus share the  
>> same
>> field and engine logic.)
>>
>> The MCS configuration of constraints conflict with the MLS  
>> configuration
>> of constraints.
>>
>> In MCS the usage of assigned compartments is to the discretion of the
>> user
>>
>> In MLS the usage of assigned compartments is mandatory.
>>
>> As far as i know MCS and MLS are mutually exclusive.
>
> Correct.
>
> -- 
> Stephen Smalley
> National Security Agency
>


I think this implies that i'm wrong :/

If MLS and MCS are mutally exclusive, why is it possible to use  
categories _and_ levels with MLS policy? Isn't this a conflict?

Is MCS something similar which is generally referred to as  
Multilateral-Security?

Look here (excerpt from book Information Security - Priciples and  
Practice):

http://books.google.com/books?id=Bh45pU0_E_4C&lpg=PP1&dq=Information%20security%20principles&pg=PA185

So far i find the term MCS only or mainly in the context with SELinux,  
so i think it is (maybe) something SELinux specific which does  
neccessarily has something to do with Multilateral-Security.

I would be appreciate, if someone could give me some hints on what is  
wrong with my point of view.

--
Sebastian Pfaff


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
