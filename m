Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t4LEvJ97016245
 for <selinux@tycho.nsa.gov>; Thu, 21 May 2015 10:57:19 -0400
Received: by qkgx75 with SMTP id x75so56578412qkg.1
 for <selinux@tycho.nsa.gov>; Thu, 21 May 2015 07:57:18 -0700 (PDT)
Message-ID: <555DF24E.1060000@quarksecurity.com>
Date: Thu, 21 May 2015 10:57:18 -0400
From: Joshua Brindle <brindle@quarksecurity.com>
MIME-Version: 1.0
To: William Roberts <bill.c.roberts@gmail.com>
Subject: Re: [PATCH 0/2] selinux: add targeted whitelisting of ioctl commands.
References: <1428616130-14570-1-git-send-email-jeffv@google.com>
 <1684020.b5Ioztp7mc@sifl>
 <CAFftDdqfcMGht2JWHzPcBUauD-7RTXio=aTHHNMUKcJPPNLeRg@mail.gmail.com>
 <555D3E20.7050907@quarksecurity.com>
 <CABXk95CESxmfTbmpTyx0_jkj3TXs6EEYeZwo_Jpri0nAVtUCDg@mail.gmail.com>
 <CAFftDdpuSc6qyAo8Zd8At+LodwUbNmdi2LGT7HurAfG68rEruQ@mail.gmail.com>
 <555DF171.10805@quarksecurity.com>
 <CAFftDdpayX=GqssXHxpfq8UTycJSfamGQdzqMWe9wYDfwwegvg@mail.gmail.com>
In-Reply-To: <CAFftDdpayX=GqssXHxpfq8UTycJSfamGQdzqMWe9wYDfwwegvg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linux-security-module@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
 James Morris <james.l.morris@oracle.com>, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

William Roberts wrote:
> On May 21, 2015 7:53 AM, "Joshua Brindle"<brindle@quarksecurity.com>  wrote:
>> William Roberts wrote:
>>> On Wed, May 20, 2015 at 9:17 PM, Jeffrey Vander Stoep<jeffv@google.com>
>>> wrote:
>>>
>>>> Thanks for all the feedback and suggestions. Agreed that raw numerical
>>>> values are confusing. I will fix up the commit message to set a better
>>>> precedent for intended use. I included them more to illustrate what is
>>>> happening under the hood. I like the idea of a qualifier for clarity.
>>>> The qualifier seems necessary for the suggested non-ioctl-specific
>>>> approach.
>>>>
>>>> Individual ioctl labels are only marginally better than raw numbers.
>>>> E.g. { TCSETSF TIOCGWINSZ TCGETA TCSETA TCSETAW TCSETAF TCSBRK TCXONC
>>>> TIOCMBIS }. More helpful...but not much.
>>>>
>>>> My plan was to group commonly used ioctl sets into macros.
>>>>
>>>> e.g. common_socket_ioc, priv_socket_ioc, tty_ioc, gpu_ioc, etc
>>>>
>>> This is exactly what I had in mind, just use m4
>>>
>> Even outside of my analysis use case I think this is not a good idea.
>>
>> Consider the Android base policy defined gpu_op as a set of ioctls, and
> there were related rules for gpu users defined there. Then a device variant
> policy has additional gpu_op ioctl's. How does it add them? Does it have to
> re-add all of the related rules with the new ioctls?
>
> I could define a new macro my_device_GPU_ioctls and include the base macro
> in its expansion.

And repeat every related rule (and keep them in sync as the base policy 
develops). How much easier is it just to add your ioctl to an ioctl 
attribute and be done?

>
>> In the ioctl-attibute case the variant policy would just add its specific
> ioctls to gpu_op and everything would be taken care of.
>> Then we just need to preserve the symbols for looking at policies and
> we'll all be happy, right?
>>
>>>> After monitoring ioctl use across five different devices I think this
>>>> is a good approach as just 10-20 macros would be adequate for a
>>>> targeted policy and would provide a clearer explanation of the
>>>> permissions given.
>>>>
>>>
>>>
>
