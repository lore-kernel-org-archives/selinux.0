Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9GFkUxP002089
	for <selinux@tycho.nsa.gov>; Thu, 16 Oct 2008 11:46:30 -0400
Received: from mho-02-bos.mailhop.org (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m9GFjBlp008296
	for <selinux@tycho.nsa.gov>; Thu, 16 Oct 2008 15:45:11 GMT
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
Message-Id: <492D4AE3-13AE-45E9-B840-BBED2C9BD4EE@nall.com>
From: Joe Nall <joe@nall.com>
To: Joshua Brindle <method@manicmethod.com>
In-Reply-To: <48F754B5.8020302@manicmethod.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: Use of optional_policy in templates (compiler bug or feature?)
Date: Thu, 16 Oct 2008 10:46:23 -0500
References: <CDFE55B0-379E-4CC5-AA3F-03FC6B622DF1@nall.com> <1224096411.21012.46.camel@gorn.columbia.tresys.com> <842B0735-FCD6-4BAF-B8D3-A462B1D5C9E4@nall.com> <1224161367.21012.57.camel@gorn.columbia.tresys.com> <B644A871-625C-477E-A9EA-6FF003227C8B@nall.com> <48F754B5.8020302@manicmethod.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Oct 16, 2008, at 9:50 AM, Joshua Brindle wrote:

> Joe Nall wrote:
>>
>> On Oct 16, 2008, at 7:49 AM, Christopher J. PeBenito wrote:
>>
>>> On Wed, 2008-10-15 at 14:59 -0500, Joe Nall wrote:
>>>> On Oct 15, 2008, at 1:46 PM, Christopher J. PeBenito wrote:
>>>>
>>>>> On Wed, 2008-10-15 at 11:02 -0500, Joe Nall wrote:
>>>>>> Is it legitimate to define a type within an optional_policy  
>>>>>> within a
>>>>>> template?
>>>>>
>>>>> Yes.
>>>>>
>>>>>> I ask because there are a number of compile issues with policy  
>>>>>> that
>>>>>> look like:
>>>>>>
>>>>>> template(`wm_domain_template',`
>>>>>> ...
>>>>>>       optional_policy(`
>>>>>>               dbus_system_bus_client_template($1_wm,$1_wm_t)
>>>>>> # does not compile
>>>>>> #               dbus_user_bus_client_template($1,$1_wm,$1_wm_t)
>>>>>>       ')
>>>>>> ...
>>>>>> ')
>>>>>
>>>>> I can't reproduce this by just adding it to a random module;  
>>>>> there are
>>>>> likely more factors that just the above template calls.
>>>>
>>>> Using stock Fedora targeted policy:
>>>>
>>>> policy_module(swo,1.0.0)
>>>>
>>>> userdom_unpriv_user_template(swo)
>>>> dbus_chat_user_bus(swo,swo_t)
>>>
>>> Well this is a weird case, because you have this situation:
>>>
>>> optional {
>>>    # optionally declare the type
>>>    # from userdom_unpriv_user_template(swo)
>>>    type swo_dbusd_t;
>>> }
>>>
>>> # unconditionally require the type for this module
>>> # from dbus_chat_user_bus(swo,swo_t)
>>> require {
>>>    type swo_dbusd_t;
>>> }
>>>
>>>
>>> but even if you make the second interface call optional too, you'll
>>> still get the compile error.
>>
>> Weird wrong or weird corner case that ought to work?
>>
>
> Weird unsupported. It was thought non-trivial to deterministically  
> enable optionals in cases like this.

So all optional policy in templates using a given derived type have to  
be in the same optional block?

Dan took the per role expansion out of the core policy in fedora and  
put the per role templates in an optional blocks in role based .te  
files. This tickles this 'Weird unsupported' corner of the compiler  
repeatedly. The weird thing to me is that it mostly works. The big  
exceptions are in the X and dbus policies which have all sorts of  
nested optional interactions (just like the code).

joe



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
