Subject: Re: ANN: SELinux userspace 2.7-rc2 release
To: Jason Zaman <jason@perfinion.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
References: <1497028696.26846.9.camel@tycho.nsa.gov>
 <1497632109.7898.5.camel@tycho.nsa.gov>
 <20170618073233.GA24080@meriadoc.perfinion.com>
 <20170618074655.GA9590@meriadoc.perfinion.com>
 <6388c501-4700-ac73-fc1f-4b5a641cefba@redhat.com>
 <1497960868.12069.1.camel@tycho.nsa.gov>
 <8e1d184d-244f-0116-0d83-51de99bc97dc@redhat.com>
 <20170620142202.GA30989@meriadoc.perfinion.com>
From: Petr Lautrbach <plautrba@redhat.com>
Message-ID: <2b158c75-443c-05a5-dfcf-dca72c5952f8@redhat.com>
Date: Wed, 21 Jun 2017 19:58:59 +0200
MIME-Version: 1.0
In-Reply-To: <20170620142202.GA30989@meriadoc.perfinion.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/20/2017 04:22 PM, Jason Zaman wrote:
> On Tue, Jun 20, 2017 at 03:28:44PM +0200, Petr Lautrbach wrote:
>> On 06/20/2017 02:14 PM, Stephen Smalley wrote:
>>> On Tue, 2017-06-20 at 12:54 +0200, Petr Lautrbach wrote:
>>>> On 06/18/2017 09:46 AM, Jason Zaman wrote:
>>>>> On Sun, Jun 18, 2017 at 03:32:33PM +0800, Jason Zaman wrote:
>>>>>> There is a bug that needs to be fixed before the final release:
>>>>>> https://bugs.gentoo.org/show_bug.cgi?id=621762
>>>>>>
>>>>>> I think the fix is just add override in utils/Makefile to the
>>>>>> LDLIBS and
>>>>>> LDFLAGS bits. I'm not sure I'll have time to get around to
>>>>>> testing
>>>>>> it so just wanted to let you know before the final release.
>>>>>
>>>>> Yep, thats the fix, I sent a patch.
>>>>> https://gitweb.gentoo.org/repo/gentoo.git/tree/sys-libs/libselinux/
>>>>> libselinux-9999.ebuild#n58
>>>>> The gentoo ebuild overrides LDFLAGS on the commandline which is why
>>>>> the
>>>>> override was required. When i first tried to repro manually i just
>>>>> exported LDFLAGS and couldnt repro. once i read the docs on
>>>>> override it
>>>>> was pretty obvious.
>>>>
>>>> A similar patch is needed almost for every other part when you try
>>>> to
>>>> build everything from git first and then install it.
>>>>
>>>> In order to that I need to apply a patch [1] and do the following
>>>> steps:
>> ...
>>>>
>>>> [1]
>>>> https://gitlab.com/bachradsusi/selinux-rpm/blob/master/0001-Fix-build
>>>> -without-install.patch
>>>>
>>>> Using this I preserve rpath problems pointing to DESTDIR and rpm can
>>>> simply use everything from DESTDIR for /
>>>
>>> That seems very onerous for packagers.
>>> So, are you advocating for reverting
>>> fcb5d5cc721187b3e3a19b44155d5b824d7be7e6, or are you proposing the
>>> patch cited above for upstream instead?
>>>
>>
>> Actually it seems that fcb5d5cc7 didn't break this use case.
>>
>> At the moment, we still build SELinux tools and libraries from tar balls
>> in Fedora so it's not affected. But since some of directories were split
>> I decided to build snapshot SELinux rpms [2] from one selinux src rpm
>> which uses the whole git snapshot.
> 
> Ooohh.. okay i was about to ask i thought fedora packaged everything
> separately. and didnt get why things were refering to libsepol and
> libselinux in the same build script.
> 
> In gentoo they're all separate no matter if its git or a release, the
> only thing we change is if we have to cd into a subdir with version
> number or without.
> 
> the repo doesnt build very well unless you've installed the earlier deps
> before building the later ones. you'll probably have a better time if
> the builds are split out again or if you build and install each one
> separately

It seems to be only working solution right now. But it's the most 
complicated in regards of Fedora build systems koji and COPR. Packages 
are built using mock and non-root user - a build process can't install 
files to /. So one need to build libsepol package first, push it to the 
buildroot so that it's installed during build of other packages, build 
libselinux, push it to the buildroot, ... This quite a long and 
complicated process even in COPR.


> There are a bunch of issues with the patch tho, it moves -L around to
> the wrong places. -L should be before the objects and -l after
> 
> Also, https://gitlab.com/bachradsusi/selinux-rpm/blob/master/0001-Fix-build-without-install.patch#L288
> that check echos out a y above, so replacing it there will always be
> false which is probably wrong.  I changed it because in gentoo we dont
> do automagic dependencies so it needs a good way to en/disable manually
> but the default was unchanged to check if the system has the header.

Thanks for the comment. I'll take a look at it.

> 
> But the bits in the patch with override are probably right. I'll check
> through all the Makefiles and see where needs overriding and send a
> patch tmrr.
> 
> -- Jason
> 
>> For my use case, I'd rather see the [1] patch upstream if it's
>> acceptable solution. I'll rebase it against latest HEAD and sent it for
>> review.
>>
>> [2] https://gitlab.com/bachradsusi/selinux-rpm
>>
>> Petr
