Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t9KDvRRq005405
 for <selinux@tycho.nsa.gov>; Tue, 20 Oct 2015 09:57:28 -0400
Received: by qkfm62 with SMTP id m62so7679995qkf.1
 for <selinux@tycho.nsa.gov>; Tue, 20 Oct 2015 06:56:58 -0700 (PDT)
Message-ID: <56264829.5040609@quarksecurity.com>
Date: Tue, 20 Oct 2015 09:56:57 -0400
From: Joshua Brindle <brindle@quarksecurity.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Richard Haines <richard_c_haines@btinternet.com>,
 Dominick Grift <dac.override@gmail.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: did libselinux grow a new build dependency? (openssl-devel:
 openssl.h)
References: <20151018140730.GB19335@x250>
 <1360366462.3121760.1445180447166.JavaMail.yahoo@mail.yahoo.com>
 <562531F6.8010609@tycho.nsa.gov> <562644AE.3080001@quarksecurity.com>
 <5626452C.6010806@tycho.nsa.gov>
In-Reply-To: <5626452C.6010806@tycho.nsa.gov>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Stephen Smalley wrote:
> On 10/20/2015 09:42 AM, Joshua Brindle wrote:
>> Stephen Smalley wrote:
>> <snip>
>>>
>>> Wondering if dependency on openssl might be a license issue for Debian
>>> or others. Apparently openssl license is considered GPL-incompatible [1]
>>> [2], and obviously libselinux is linked by a variety of GPL-licensed
>>> programs. Fedora seems to view this as falling under the system library
>>> exception [3] but not clear that other distributions would view it that
>>> way. On the other hand, using gnutls would be subject to the reverse
>>> problem; it would make libselinux depend on a LGPL library, and that
>>> could create issues for non-GPL programs that statically link
>>> libselinux. We might need to revert this change and revisit how to solve
>>> this in a manner that avoids such issues.
>>
>> LGPL explicitly allows non-GPL programs to link against an LGPL licensed
>> library without tainting the non-GPL program, which is the whole point
>> of the LGPL. Is there some other issue with static linking or something?
>
> Yes, that's the concern.

So, not static linking but a fully static binary that would pull gnutls 
into the binary?

What static binaries exist like that? It is not a great idea to carry 
around system level libraries statically.
