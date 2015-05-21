Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t4LEDXws012608
 for <selinux@tycho.nsa.gov>; Thu, 21 May 2015 10:13:33 -0400
Received: by obcus9 with SMTP id us9so61106519obc.2
 for <selinux@tycho.nsa.gov>; Thu, 21 May 2015 07:13:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <555DE73C.3010807@tycho.nsa.gov>
References: <1428616130-14570-1-git-send-email-jeffv@google.com>
 <1684020.b5Ioztp7mc@sifl>
 <CAFftDdqfcMGht2JWHzPcBUauD-7RTXio=aTHHNMUKcJPPNLeRg@mail.gmail.com>
 <555DD0CF.8070000@tycho.nsa.gov> <555DE0EF.3010402@tycho.nsa.gov>
 <555DE298.9020207@tycho.nsa.gov> <555DE3A2.1070509@tycho.nsa.gov>
 <CAHC9VhTyjGexBXkCPaxnfcXdzSUbi8cSLmVjT7ncD7DHq1qQAQ@mail.gmail.com>
 <555DE73C.3010807@tycho.nsa.gov>
Date: Thu, 21 May 2015 10:13:14 -0400
Message-ID: <CAHC9VhSdFzNMbYTny0v2kBus2Jf4Hgx44Pn8N12cv7ZgvvWJKw@mail.gmail.com>
Subject: Re: [PATCH 0/2] selinux: add targeted whitelisting of ioctl commands.
From: Paul Moore <paul@paul-moore.com>
To: James Carter <jwcart2@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, May 21, 2015 at 10:10 AM, James Carter <jwcart2@tycho.nsa.gov> wrote:
> On 05/21/2015 10:04 AM, Paul Moore wrote:
>> On Thu, May 21, 2015 at 9:54 AM, Stephen Smalley <sds@tycho.nsa.gov>
>> wrote:
>>> On 05/21/2015 09:50 AM, Stephen Smalley wrote:
>>>> On 05/21/2015 09:43 AM, James Carter wrote:
>>>>>
>>>>> Do you have something else in mind that might use the operation
>>>>> structures?
>>>>>
>>>>> In CIL we will probably make the syntax something like this:
>>>>>
>>>>> ((allowop <source> <target> <class> <ioctl expression>)
>>>>>
>>>>> So the above rule might look like:
>>>>>
>>>>> (allowop <source> <target> <class> ((range 0x8910 0x8926) 0x892A))
>>>>
>>>>
>>>> Paul asked to generalize it so it can be reused for other purposes.  One
>>>> example would be netlink message types.  Today, there is a hardcoded
>>>> table in SELinux (security/selinux/nlmsgtab.c) that maps specific
>>>> netlink message type values to nlmsg_read (i.e. reads public kernel
>>>> state), nlmsg_readpriv (i.e. reads potentially sensitive kernel state),
>>>> nlmsg_write (i.e. modifies kernel state), and a few other audit-specific
>>>> values so we can distinguish e.g. who can read vs write routing table
>>>> entries or audit configuration, as the normal socket read/write checks
>>>> merely control the ability to send/recv on the socket, which is always
>>>> required for any user of it.  That has limited flexibility and isn't
>>>> generally well maintained for newer netlink protocols.
>>>
>>>
>>> So the proposal would be to just add an additional field specifying how
>>> to interpret/apply the operation list, e.g.
>>> (allowop <source> <target> <class> <ioctl|netlink|...> ((range 0x8910
>>> 0x8926) 0x892A))
>>
>>
>> Looks to me like a good solution for CIL.
>>
>
> I agree.
>
> So why not have a syntax like the following for checkpolicy?
>
> allowop <source> <target> <class> <ioctl|netlink|...> { 0x8910-0x8926 0x892A
> };
>
> Woudln't that be clearer?

I have no strong preference here, I'll leave that to the folks working
on the policy toolchain.

-- 
paul moore
www.paul-moore.com
