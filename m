Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t4LEJmF2013293
 for <selinux@tycho.nsa.gov>; Thu, 21 May 2015 10:19:48 -0400
Received: by oige141 with SMTP id e141so1667344oig.1
 for <selinux@tycho.nsa.gov>; Thu, 21 May 2015 07:19:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <555DE8A4.2050000@quarksecurity.com>
References: <1428616130-14570-1-git-send-email-jeffv@google.com>
 <1684020.b5Ioztp7mc@sifl>
 <CAFftDdqfcMGht2JWHzPcBUauD-7RTXio=aTHHNMUKcJPPNLeRg@mail.gmail.com>
 <555D3E20.7050907@quarksecurity.com>
 <CABXk95CESxmfTbmpTyx0_jkj3TXs6EEYeZwo_Jpri0nAVtUCDg@mail.gmail.com>
 <CAHC9VhQDg6S9UObCqCLQgg=V6_5Lj7BSQ-LYfRLGGLMZOoaoGQ@mail.gmail.com>
 <555DDF2C.3010606@quarksecurity.com>
 <CAHC9VhSeZA_qKK_7L94C24LsctATj5etRK7bayO2W6TfmimwOg@mail.gmail.com>
 <555DE8A4.2050000@quarksecurity.com>
Date: Thu, 21 May 2015 10:19:46 -0400
Message-ID: <CAHC9VhSpbMSu2HYMkvt=GsYtara1v+DSbaSHZfa2bWbFAUSYwQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] selinux: add targeted whitelisting of ioctl commands.
From: Paul Moore <paul@paul-moore.com>
To: Joshua Brindle <brindle@quarksecurity.com>
Content-Type: text/plain; charset=UTF-8
Cc: James Morris <james.l.morris@oracle.com>,
 linux-security-module@vger.kernel.org,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, May 21, 2015 at 10:16 AM, Joshua Brindle
<brindle@quarksecurity.com> wrote:
> Paul Moore wrote:
>> On Thu, May 21, 2015 at 9:35 AM, Joshua Brindle
>> <brindle@quarksecurity.com>  wrote:
>>> Paul Moore wrote:
>>>> On Thu, May 21, 2015 at 12:17 AM, Jeffrey Vander Stoep wrote:
>>>>>
>>>>> Thanks for all the feedback and suggestions. Agreed that raw numerical
>>>>> values are confusing. I will fix up the commit message to set a better
>>>>> precedent for intended use. I included them more to illustrate what is
>>>>> happening under the hood. I like the idea of a qualifier for clarity.
>>>>> The qualifier seems necessary for the suggested non-ioctl-specific
>>>>> approach.
>>>>
>>>> Great, thank you.
>>>>
>>>>> Individual ioctl labels are only marginally better than raw numbers.
>>>>> E.g. { TCSETSF TIOCGWINSZ TCGETA TCSETA TCSETAW TCSETAF TCSBRK TCXONC
>>>>> TIOCMBIS }. More helpful...but not much.
>>>>>
>>>>> My plan was to group commonly used ioctl sets into macros.
>>>>>
>>>>> e.g. common_socket_ioc, priv_socket_ioc, tty_ioc, gpu_ioc, etc
>>>>>
>>>>> After monitoring ioctl use across five different devices I think this
>>>>> is a good approach as just 10-20 macros would be adequate for a
>>>>> targeted policy and would provide a clearer explanation of the
>>>>> permissions given.
>>>>
>>>> Agreed.  We can use m4 to provide both the ioctl names and sets if
>>>> needed.
>>>
>>> m4 is never the answer....
>>
>>
>> Except for the policy interfaces, permission sets, etc. ;)
>>
>> See Stephen's comments on this, specifically the idea that ioctls are
>> not objects.  Further, the existing permission set shorthand is a very
>> good precedence for this approach towards ioctl number handling; I see
>> no reason *not* to use m4.
>>
>
> The reason *not* to use m4 is because we want some sort of meaningful
> identifiers preserved in the kernel policy for analysis. I know that isn't
> your use case but it is some of ours.

You've got the ioctl numbers in the binary policy, which are the same
numbers used in the policy representation, which are also the same
numbers used by applications actually making use of the ioctl()
syscall.  Other than the fact that these things are numbers and not a
more conventional label string, I don't understand the problem.

-- 
paul moore
www.paul-moore.com
