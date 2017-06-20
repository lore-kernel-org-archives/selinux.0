Subject: Re: ANN: SELinux userspace 2.7-rc2 release
From: Petr Lautrbach <plautrba@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
References: <1497028696.26846.9.camel@tycho.nsa.gov>
 <1497632109.7898.5.camel@tycho.nsa.gov>
 <20170618073233.GA24080@meriadoc.perfinion.com>
 <20170618074655.GA9590@meriadoc.perfinion.com>
 <6388c501-4700-ac73-fc1f-4b5a641cefba@redhat.com>
 <1497960868.12069.1.camel@tycho.nsa.gov>
 <8e1d184d-244f-0116-0d83-51de99bc97dc@redhat.com>
Message-ID: <181fde2e-31cc-8f8a-0839-ee7943d6785a@redhat.com>
Date: Tue, 20 Jun 2017 15:31:22 +0200
MIME-Version: 1.0
In-Reply-To: <8e1d184d-244f-0116-0d83-51de99bc97dc@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/20/2017 03:28 PM, Petr Lautrbach wrote:
> On 06/20/2017 02:14 PM, Stephen Smalley wrote:
>> On Tue, 2017-06-20 at 12:54 +0200, Petr Lautrbach wrote:
>>> On 06/18/2017 09:46 AM, Jason Zaman wrote:
>>>> On Sun, Jun 18, 2017 at 03:32:33PM +0800, Jason Zaman wrote:
>>>>> There is a bug that needs to be fixed before the final release:
>>>>> https://bugs.gentoo.org/show_bug.cgi?id=621762
>>>>>
>>>>> I think the fix is just add override in utils/Makefile to the
>>>>> LDLIBS and
>>>>> LDFLAGS bits. I'm not sure I'll have time to get around to
>>>>> testing
>>>>> it so just wanted to let you know before the final release.
>>>>
>>>> Yep, thats the fix, I sent a patch.
>>>> https://gitweb.gentoo.org/repo/gentoo.git/tree/sys-libs/libselinux/
>>>> libselinux-9999.ebuild#n58
>>>> The gentoo ebuild overrides LDFLAGS on the commandline which is why
>>>> the
>>>> override was required. When i first tried to repro manually i just
>>>> exported LDFLAGS and couldnt repro. once i read the docs on
>>>> override it
>>>> was pretty obvious.
>>>
>>> A similar patch is needed almost for every other part when you try
>>> to
>>> build everything from git first and then install it.
>>>
>>> In order to that I need to apply a patch [1] and do the following
>>> steps:
> ...
>>>
>>> [1]
>>> https://gitlab.com/bachradsusi/selinux-rpm/blob/master/0001-Fix-build
>>> -without-install.patch
>>>
>>> Using this I preserve rpath problems pointing to DESTDIR and rpm can
>>> simply use everything from DESTDIR for /
>>
>> That seems very onerous for packagers.
>> So, are you advocating for reverting
>> fcb5d5cc721187b3e3a19b44155d5b824d7be7e6, or are you proposing the
>> patch cited above for upstream instead?
>>
> 
> Actually it seems that fcb5d5cc7 didn't break this use case.

I mean it was broken even before this change according to my testing.

cc -O2 -g -pipe -Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 
-fexceptions -fstack-protector-strong --param=ssp-buffer-size=4 
-grecord-gcc-switches -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 
-m64 -mtune=generic -I../include -I/usr/include -D_GNU_SOURCE 
-DNO_ANDROID_BACKEND   -c -o load_policy.o load_policy.c
load_policy.c:15:10: fatal error: sepol/sepol.h: No such file or directory
  #include <sepol/sepol.h>
           ^~~~~~~~~~~~~~~


> 
> At the moment, we still build SELinux tools and libraries from tar balls 
> in Fedora so it's not affected. But since some of directories were split 
> I decided to build snapshot SELinux rpms [2] from one selinux src rpm 
> which uses the whole git snapshot.
> 
> For my use case, I'd rather see the [1] patch upstream if it's 
> acceptable solution. I'll rebase it against latest HEAD and sent it for 
> review.
> 
> [2] https://gitlab.com/bachradsusi/selinux-rpm
> 
> Petr
