Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t9KEgma2009984
 for <selinux@tycho.nsa.gov>; Tue, 20 Oct 2015 10:42:49 -0400
Date: Tue, 20 Oct 2015 14:39:58 +0000 (UTC)
From: Richard Haines <richard_c_haines@btinternet.com>
Reply-To: Richard Haines <richard_c_haines@btinternet.com>
To: William Roberts <bill.c.roberts@gmail.com>,
 Stephen Smalley <sds@tycho.nsa.gov>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Message-ID: <1526618308.525900.1445351998505.JavaMail.yahoo@mail.yahoo.com>
In-Reply-To: <CAFftDdratpqGkyLp0m48YWo1iOw58sECd+NhQe1o4TqZQOSwcw@mail.gmail.com>
References: <CAFftDdratpqGkyLp0m48YWo1iOw58sECd+NhQe1o4TqZQOSwcw@mail.gmail.com>
Subject: Re: did libselinux grow a new build dependency? (openssl-devel:
 openssl.h)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


On Tuesday, 20 October 2015, 15:00, William Roberts <bill.c.roberts@gmail.com> wrote:

>
>
>
>On Oct 20, 2015 7:46 AM, "Stephen Smalley" <sds@tycho.nsa.gov> wrote:
>>
>> On 10/20/2015 08:27 AM, Richard Haines wrote:
>>>
>>>
>>>
>>>
>>>
>>>> On Monday, 19 October 2015, 19:10, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>>>>
>>>>> On 10/18/2015 11:00 AM, Richard Haines wrote:
>>>>>
>>>>>
>>>>>>   On Sunday, 18 October 2015, 15:07, Dominick Grift
>>>>
>>>> <dac.override@gmail.com> wrote:
>>>>>
>>>>>
>>>>>>>   -----BEGIN PGP SIGNED MESSAGE-----
>>>>>>
>>>>>>   Hash: SHA512
>>>>>>
>>>>>>   On Sun, Oct 18, 2015 at 12:48:12PM +0000, Richard Haines wrote:
>>>>>>>
>>>>>>>     I added openssl to libselinux to support the new
>>>>
>>>> selabel_digest(3)
>>>>>>>
>>>>>>>     function.
>>>>>>>
>>>>>>>     I'm not aware of any issues between openssl and gnutls,
>>>>
>>>> however as
>>>>>>>
>>>>>>>
>>>>>>>     selabel_digest was only added last week I guess not much testing.
>>>>>>>     Well apart from myself as I'm currently adding the
>>>>
>>>> selinux_restorecon
>>>>>>>
>>>>>>>     feature that makes use of it.
>>>>>>>
>>>>>>
>>>>>>   Thanks for clarifying, I am not hitting any issues with it just
>>>>>>   wondering if instead of openssl, gnutls could be used for this and if
>>>>>
>>>>>
>>>>>>   so, if this should be somehow supported or not.
>>>>>
>>>>>
>>>>>   I tried using gnutls after I read your initial email, however I
>>>>>   could not find a way to generate the same digest as openssl
>>>>>   (I changed the SHA1 function to gnutls_hmac_fast(3) with various
>>>>>   algorithms and used the selabel_digest util to compare digests).
>>>>>   It could be that I should use some other function but I could
>>>>>
>>>>>   not find any useful info on this (including web searches).
>>>>>   If anyone knows how to resolve this please let me know.
>>>>>
>>>>>   I guess what is supported (openssl or gnutls) would be down to
>>>>>   the maintainers.
>>>>
>>>>
>>>> Wondering if dependency on openssl might be a license issue for Debian
>>>> or others.  Apparently openssl license is considered GPL-incompatible
>>>> [1] [2], and obviously libselinux is linked by a variety of GPL-licensed
>>>> programs.  Fedora seems to view this as falling under the system library
>>>> exception [3] but not clear that other distributions would view it that
>>>> way.  On the other hand, using gnutls would be subject to the reverse
>>>> problem; it would make libselinux depend on a LGPL library, and that
>>>> could create issues for non-GPL programs that statically link
>>>> libselinux.  We might need to revert this change and revisit how to
>>>
>>>
>>>> solve this in a manner that avoids such issues.
>>>
>>>
>>>
>>> Would building with the Android mincrypt SHA functions help regarding the
>>> licensing issues ??? I've attached a quick patch that seems to work okay
>>> using Android system/core/libmincrypt/sha.c
>>
>>
>> That looks BSD-licensed and thus broadly compatible.  We would need to amend libselinux/LICENSE to add that license information and we would need to hide those functions from being exposed outside of the library.  Other alternative would be to look for a public domain SHA implementation and use that.

>>

I've found a simple implementation at
www.ghostscript.com/doc/jbig2dec/sha1.c

I'll try that first and if fails CryptLib will be next.




>> 
>Will CryptLib work:

>http://unlicense.org/


>
>
>>
>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov
>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov
>.
>
>
>
