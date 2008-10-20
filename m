Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9KIJQVf021688
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2008 14:19:27 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m9KIJQYs004785
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2008 18:19:26 GMT
Message-ID: <48FCCBB1.1010004@redhat.com>
Date: Mon, 20 Oct 2008 14:19:29 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Joshua Brindle <method@manicmethod.com>
CC: Joe Nall <joe@nall.com>, "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Use of optional_policy in templates (compiler bug or feature?)
References: <CDFE55B0-379E-4CC5-AA3F-03FC6B622DF1@nall.com> <1224096411.21012.46.camel@gorn.columbia.tresys.com> <842B0735-FCD6-4BAF-B8D3-A462B1D5C9E4@nall.com> <1224161367.21012.57.camel@gorn.columbia.tresys.com> <B644A871-625C-477E-A9EA-6FF003227C8B@nall.com> <48F754B5.8020302@manicmethod.com>
In-Reply-To: <48F754B5.8020302@manicmethod.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> Joe Nall wrote:
>>
>> On Oct 16, 2008, at 7:49 AM, Christopher J. PeBenito wrote:
>>
>>> On Wed, 2008-10-15 at 14:59 -0500, Joe Nall wrote:
>>>> On Oct 15, 2008, at 1:46 PM, Christopher J. PeBenito wrote:
>>>>
>>>>> On Wed, 2008-10-15 at 11:02 -0500, Joe Nall wrote:
>>>>>> Is it legitimate to define a type within an optional_policy within a
>>>>>> template?
>>>>>
>>>>> Yes.
>>>>>
>>>>>> I ask because there are a number of compile issues with policy that
>>>>>> look like:
>>>>>>
>>>>>> template(`wm_domain_template',`
>>>>>> ...
>>>>>>        optional_policy(`
>>>>>>                dbus_system_bus_client_template($1_wm,$1_wm_t)
>>>>>> # does not compile
>>>>>> #               dbus_user_bus_client_template($1,$1_wm,$1_wm_t)
>>>>>>        ')
>>>>>> ...
>>>>>> ')
>>>>>
>>>>> I can't reproduce this by just adding it to a random module; there are
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
>>>     # optionally declare the type
>>>     # from userdom_unpriv_user_template(swo)
>>>     type swo_dbusd_t;
>>> }
>>>
>>> # unconditionally require the type for this module
>>> # from dbus_chat_user_bus(swo,swo_t)
>>> require {
>>>     type swo_dbusd_t;
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
> 
> 
> -- 
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the message.
These cases happen to me all the time, and I end up having to code
around them in weird ways.  As the policy gets more complicated and
interactions become more complex, we are going to see the compiler blow up.

dbus, xserver, confined users, are all causing interesting failure modes.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
