Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8UEhmwT021056
 for <selinux@tycho.nsa.gov>; Sun, 30 Sep 2018 10:43:50 -0400
Received: by mail-qk1-f173.google.com with SMTP id g184-v6so6600845qkc.11
 for <selinux@tycho.nsa.gov>; Sun, 30 Sep 2018 07:43:44 -0700 (PDT)
To: Stephen Smalley <sds@tycho.nsa.gov>, Joe Nall <joe@nall.com>
Cc: SELinux <selinux@tycho.nsa.gov>
References: <CAFPpqQEgS9mqEZcMCn=3AGYer_5WBQmQdqjsMC=OJqtgwp96cQ@mail.gmail.com>
 <41fbbd99-00ef-3953-1049-acf975ae6ffa@tycho.nsa.gov>
 <CAFPpqQHXmvCNLwkW3xmYX9PWFwwmfc7wD2kOz-KKEVip-BFLyA@mail.gmail.com>
 <CAFPpqQGyUWsXwmfAybHKWhuQ6jytaNn_ZO-BfeqxNTQZDb+uvg@mail.gmail.com>
 <4e7d4090-e271-b904-c5bb-24f69304625d@tycho.nsa.gov>
 <85bb9bec-2bda-34fa-1f7d-256470c4f38c@tycho.nsa.gov>
 <2E8FB4B5-598A-4741-9AC6-70C9995A48F9@nall.com>
 <052415f8-589e-909f-ac00-8e67c5c23e0d@tycho.nsa.gov>
From: Chris PeBenito <pebenito@ieee.org>
Message-ID: <62b6ac25-6528-79d4-a38d-7f75fe870a47@ieee.org>
Date: Sun, 30 Sep 2018 10:43:41 -0400
MIME-Version: 1.0
In-Reply-To: <052415f8-589e-909f-ac00-8e67c5c23e0d@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: MLS dominance check behavior on el7
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/11/2018 04:20 PM, Stephen Smalley wrote:
> On 09/11/2018 03:04 PM, Joe Nall wrote:
>>
>>
>>> On Sep 11, 2018, at 1:29 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>>
>>> On 09/11/2018 10:41 AM, Stephen Smalley wrote:
>>>> On 09/10/2018 06:30 PM, Ted Toth wrote:
>>>>> mcstrans mcscolor.c also uses the same logic I'd been using to 
>>>>> check dominance so this too will no longer function as expected on 
>>>>> el7. Do you any suggestions for doing a 'generic' (one not tied to 
>>>>> a specific resource class) dominance check in lieu of context 
>>>>> contains?
>>>> You should probably define your own permission with its own 
>>>> constraint to avoid depending on the base policy's particular 
>>>> constraint definitions.  Certainly for your own code.  For mcstrans, 
>>>> mcscolor probably ought to be switched to using at least a separate 
>>>> permission in the context class if not its own class to avoid 
>>>> overloading the meaning with pam_selinux's usage (or vice versa, but 
>>>> likely harder to change pam_selinux at this point).
>>>> It is possible to define an entirely new class, its permissions, and 
>>>> its mls constraints via a CIL module IIUC, without needing to change 
>>>> the base policy.
>>>> I don't think you can add a permission to an existing class via a 
>>>> CIL module currently, unfortunately, so you can't just extend the 
>>>> context class without modifying the base policy.  So it may be 
>>>> easier to define an entirely new class.
>>>> The class and permission ought to be specific to the usage.  For 
>>>> example, mcstrans could have its own class (mcstrans) with its own 
>>>> permissions (e.g. color_match or color_use or ...) that abstract 
>>>> away the logical check being performed.  Dominance checks performed 
>>>> for different reasons ought to use different permissions so that one 
>>>> can distinguish what TE pairs are allowed them.
>>>> Your code could likewise define and use its own class and permission.
>>>> Does that make sense?
>>>
>>> BTW, I noticed there is another permission ("translate") defined in 
>>> the context class and its constraint is ((h1 dom h2) or (t1 == 
>>> mlstranslate)).  I would have guessed that it was intended as a 
>>> front-end service check over what processes could request context 
>>> translations from mcstrans or what contexts they could translate, but 
>>> I don't see it being used in mcstrans anywhere.  Is this a legacy 
>>> thing from early setransd/mcstransd days?  There is a TODO comment in 
>>> mcstrans process_request() that suggests there was an intent to 
>>> perform a dominance check between the requester context and the 
>>> specified context, but that's not implemented.  Appears to be allowed 
>>> in current policy for all domains to the setrans_t domain itself.
>>
>> I think 'translate' predates my mcstransd work and dates from the 
>> original TCS implementation. There is an argument to implement that 
>> constraint, but we've been operating without it for so long it does 
>> not seem worthwhile.
> 
> Well, I guess we ought to either implement it or delete the permission 
> definition from refpolicy.

I'm fine removing it.  It's just the translate permission that is 
unused, not the whole class, correct?

-- 
Chris PeBenito
