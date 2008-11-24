Cc: Eamon Walsh <ewalsh@tycho.nsa.gov>,
        Joshua Brindle <method@manicmethod.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Message-Id: <F4059BE7-756E-4A07-88C5-DC378A02E7DD@nall.com>
From: Joe Nall <joe@nall.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
In-Reply-To: <1224685922.29917.22.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: Use of optional_policy in templates (compiler bug or feature?)
Date: Sun, 23 Nov 2008 21:35:10 -0600
References: <CDFE55B0-379E-4CC5-AA3F-03FC6B622DF1@nall.com> <1224096411.21012.46.camel@gorn.columbia.tresys.com> <842B0735-FCD6-4BAF-B8D3-A462B1D5C9E4@nall.com> <1224161367.21012.57.camel@gorn.columbia.tresys.com> <B644A871-625C-477E-A9EA-6FF003227C8B@nall.com> <48F754B5.8020302@manicmethod.com> <48FCCBB1.1010004@redhat.com> <9E8A5545-7705-4CD3-9015-30AD17FA0AFE@nall.com> <48FD19BB.1090503@tycho.nsa.gov> <1224684070.29917.13.camel@moss-spartans.epoch.ncsc.mil> <A69BC137-D93E-495F-80B2-8D636620195A@nall.com> <1224685723.29917.20.camel@moss-spartans.epoch.ncsc.mil> <1224685922.29917.22.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Oct 22, 2008, at 9:32 AM, Stephen Smalley wrote:

> On Wed, 2008-10-22 at 10:28 -0400, Stephen Smalley wrote:
>> On Wed, 2008-10-22 at 09:26 -0500, Joe Nall wrote:
>>> On Oct 22, 2008, at 9:01 AM, Stephen Smalley wrote:
>>>
>>>>  I did notice however that I could also get it to build w/o
>>>> changing checkmodule by reversing the order of the interface calls
>>>> there
>>>> - not sure if that workaround is usable in the original case that
>>>> triggered this bug report.
>>>
>>>
>>> Arranging modules in the proper order becomes increasingly difficult
>>> as module interaction grows. I finally de-optioned the X policy in
>>> fedora since it is in base so get our additions to compile. Patch
>>> included for reference.
>>>
>>> Making the compiler gracefully deal with options would really be
>>> appreciated. I could see the issue in the compiler code, but the  
>>> right
>>> fix wasn't obvious.
>>
>> Does the patch I posted fix your problem?
>
> And by fix, I mean not only does it allow you to build the policy but
> does it yield the expected final kernel policy (i.e. look at the
> policy.N file via apol and check that you are getting the expected  
> types
> and rules in the final policy).

I added your patch and Eamon's patch (not sure I needed Eamons's patch).
I can definitely build the policy now.
The types appear to be correct in apol and seinfo. It works as  
expected in enforcing.

joe

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
