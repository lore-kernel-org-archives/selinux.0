Subject: Re: did libselinux grow a new build dependency? (openssl-devel:
 openssl.h)
To: Joshua Brindle <brindle@quarksecurity.com>
References: <20151018140730.GB19335@x250>
 <1360366462.3121760.1445180447166.JavaMail.yahoo@mail.yahoo.com>
 <562531F6.8010609@tycho.nsa.gov> <562644AE.3080001@quarksecurity.com>
Cc: Richard Haines <richard_c_haines@btinternet.com>,
 Dominick Grift <dac.override@gmail.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <5626452C.6010806@tycho.nsa.gov>
Date: Tue, 20 Oct 2015 09:44:12 -0400
MIME-Version: 1.0
In-Reply-To: <562644AE.3080001@quarksecurity.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/20/2015 09:42 AM, Joshua Brindle wrote:
> Stephen Smalley wrote:
> <snip>
>>
>> Wondering if dependency on openssl might be a license issue for Debian
>> or others. Apparently openssl license is considered GPL-incompatible [1]
>> [2], and obviously libselinux is linked by a variety of GPL-licensed
>> programs. Fedora seems to view this as falling under the system library
>> exception [3] but not clear that other distributions would view it that
>> way. On the other hand, using gnutls would be subject to the reverse
>> problem; it would make libselinux depend on a LGPL library, and that
>> could create issues for non-GPL programs that statically link
>> libselinux. We might need to revert this change and revisit how to solve
>> this in a manner that avoids such issues.
>
> LGPL explicitly allows non-GPL programs to link against an LGPL licensed
> library without tainting the non-GPL program, which is the whole point
> of the LGPL. Is there some other issue with static linking or something?

Yes, that's the concern.
