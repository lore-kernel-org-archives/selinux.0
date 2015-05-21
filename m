Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t4LDdXDP009158
 for <selinux@tycho.nsa.gov>; Thu, 21 May 2015 09:39:34 -0400
Received: by qkx62 with SMTP id 62so7210358qkx.3
 for <selinux@tycho.nsa.gov>; Thu, 21 May 2015 06:35:40 -0700 (PDT)
Message-ID: <555DDF2C.3010606@quarksecurity.com>
Date: Thu, 21 May 2015 09:35:40 -0400
From: Joshua Brindle <brindle@quarksecurity.com>
MIME-Version: 1.0
To: Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH 0/2] selinux: add targeted whitelisting of ioctl commands.
References: <1428616130-14570-1-git-send-email-jeffv@google.com>
 <1684020.b5Ioztp7mc@sifl>
 <CAFftDdqfcMGht2JWHzPcBUauD-7RTXio=aTHHNMUKcJPPNLeRg@mail.gmail.com>
 <555D3E20.7050907@quarksecurity.com>
 <CABXk95CESxmfTbmpTyx0_jkj3TXs6EEYeZwo_Jpri0nAVtUCDg@mail.gmail.com>
 <CAHC9VhQDg6S9UObCqCLQgg=V6_5Lj7BSQ-LYfRLGGLMZOoaoGQ@mail.gmail.com>
In-Reply-To: <CAHC9VhQDg6S9UObCqCLQgg=V6_5Lj7BSQ-LYfRLGGLMZOoaoGQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: James Morris <james.l.morris@oracle.com>,
 linux-security-module@vger.kernel.org,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Paul Moore wrote:
> On Thu, May 21, 2015 at 12:17 AM, Jeffrey Vander Stoep<jeffv@google.com>  wrote:
>> Thanks for all the feedback and suggestions. Agreed that raw numerical
>> values are confusing. I will fix up the commit message to set a better
>> precedent for intended use. I included them more to illustrate what is
>> happening under the hood. I like the idea of a qualifier for clarity.
>> The qualifier seems necessary for the suggested non-ioctl-specific
>> approach.
>
> Great, thank you.
>
>> Individual ioctl labels are only marginally better than raw numbers.
>> E.g. { TCSETSF TIOCGWINSZ TCGETA TCSETA TCSETAW TCSETAF TCSBRK TCXONC
>> TIOCMBIS }. More helpful...but not much.
>>
>> My plan was to group commonly used ioctl sets into macros.
>>
>> e.g. common_socket_ioc, priv_socket_ioc, tty_ioc, gpu_ioc, etc
>>
>> After monitoring ioctl use across five different devices I think this
>> is a good approach as just 10-20 macros would be adequate for a
>> targeted policy and would provide a clearer explanation of the
>> permissions given.
>
> Agreed.  We can use m4 to provide both the ioctl names and sets if needed.

m4 is never the answer....

An attribute-like symbol that is maintained in the binary would make 
these visible in the loaded policy and therefore more 
understandable/analyzable.

It would also allow you to easily add them in specific devices in a more 
readable way. For example, if the Android base policy allowed gpu_ioc to 
surfaceflinger all a device specific variant would need to do is add its 
ioctls to the attribute.
