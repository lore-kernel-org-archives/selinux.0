Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t4LEEXNc012707
 for <selinux@tycho.nsa.gov>; Thu, 21 May 2015 10:14:34 -0400
Received: by qkx62 with SMTP id 62so8391217qkx.3
 for <selinux@tycho.nsa.gov>; Thu, 21 May 2015 07:14:32 -0700 (PDT)
Message-ID: <555DE840.70106@quarksecurity.com>
Date: Thu, 21 May 2015 10:14:24 -0400
From: Joshua Brindle <brindle@quarksecurity.com>
MIME-Version: 1.0
To: Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH 0/2] selinux: add targeted whitelisting of ioctl commands.
References: <1428616130-14570-1-git-send-email-jeffv@google.com>
 <1684020.b5Ioztp7mc@sifl>
 <CAFftDdqfcMGht2JWHzPcBUauD-7RTXio=aTHHNMUKcJPPNLeRg@mail.gmail.com>
 <555DD0CF.8070000@tycho.nsa.gov> <555DE0EF.3010402@tycho.nsa.gov>
 <555DE298.9020207@tycho.nsa.gov> <555DE3A2.1070509@tycho.nsa.gov>
 <CAHC9VhTyjGexBXkCPaxnfcXdzSUbi8cSLmVjT7ncD7DHq1qQAQ@mail.gmail.com>
In-Reply-To: <CAHC9VhTyjGexBXkCPaxnfcXdzSUbi8cSLmVjT7ncD7DHq1qQAQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Paul Moore wrote:
> On Thu, May 21, 2015 at 9:54 AM, Stephen Smalley<sds@tycho.nsa.gov>  wrote:
>> On 05/21/2015 09:50 AM, Stephen Smalley wrote:
>>> On 05/21/2015 09:43 AM, James Carter wrote:
>>>> Do you have something else in mind that might use the operation structures?
>>>>
>>>> In CIL we will probably make the syntax something like this:
>>>>
>>>> ((allowop<source>  <target>  <class>  <ioctl expression>)
>>>>
>>>> So the above rule might look like:
>>>>
>>>> (allowop<source>  <target>  <class>  ((range 0x8910 0x8926) 0x892A))
>>> Paul asked to generalize it so it can be reused for other purposes.  One
>>> example would be netlink message types.  Today, there is a hardcoded
>>> table in SELinux (security/selinux/nlmsgtab.c) that maps specific
>>> netlink message type values to nlmsg_read (i.e. reads public kernel
>>> state), nlmsg_readpriv (i.e. reads potentially sensitive kernel state),
>>> nlmsg_write (i.e. modifies kernel state), and a few other audit-specific
>>> values so we can distinguish e.g. who can read vs write routing table
>>> entries or audit configuration, as the normal socket read/write checks
>>> merely control the ability to send/recv on the socket, which is always
>>> required for any user of it.  That has limited flexibility and isn't
>>> generally well maintained for newer netlink protocols.
>> So the proposal would be to just add an additional field specifying how
>> to interpret/apply the operation list, e.g.
>> (allowop<source>  <target>  <class>  <ioctl|netlink|...>  ((range 0x8910
>> 0x8926) 0x892A))
>
> Looks to me like a good solution for CIL.
>

Something that ends up in the kernel binary would be very helpful for 
policy analysis.

Something like:

ioctl foo_op { 0x8910-0x8926 0x892A };

allow domain device : chr_file foo_op;

or ioctl(foo_op), in case there are conflicting symbol names.
