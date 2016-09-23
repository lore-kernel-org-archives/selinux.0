MIME-Version: 1.0
In-Reply-To: <e3a88368-d61f-a7ea-fa54-964183a5cbbd@tycho.nsa.gov>
References: <CAFftDdqDxr6jqC7t1imRrQ7dMJEsZh--L0CrWOCzgYUfwNeZyA@mail.gmail.com>
 <CAFftDdoXEo9Q7bRrr-AeHFX7eauKGeWzqRW-m_Z=hfXUT_JFUA@mail.gmail.com>
 <CABXk95BAor2Y7nvOZkkwEsc=8xgoa63x89WQtCbXDvzu_Pch_A@mail.gmail.com>
 <CAFftDdqr_DXtkaTkUApdsp7Nq5bm3FrUEq2xRDkc6b7Omx5RxQ@mail.gmail.com>
 <57E534DE.9070500@quarksecurity.com>
 <CAFftDdqs21PprRVRYfMjHXH2Qe7x3eYz8cR2M-bLbTso9HdnoQ@mail.gmail.com>
 <57E58A06.90103@quarksecurity.com>
 <e3a88368-d61f-a7ea-fa54-964183a5cbbd@tycho.nsa.gov>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Fri, 23 Sep 2016 13:44:29 -0700
Message-ID: <CAFftDdpBZDv4qXFtjvwVzH7VBD4k8ZrKSr7LDhHn_xjSx=OP1g@mail.gmail.com>
Subject: Re: Killing The Android libselinux Fork (available)
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Joshua Brindle <brindle@quarksecurity.com>,
 Jeff Vander Stoep <jeffv@google.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 Daniel Cashman <dcashman@android.com>,
 "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Sep 23, 2016 at 1:24 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 09/23/2016 04:01 PM, Joshua Brindle wrote:
>> William Roberts wrote:
>>> On Fri, Sep 23, 2016 at 6:57 AM, Joshua Brindle
>>> <brindle@quarksecurity.com>  wrote:
>>>> William Roberts wrote:
>>>>> On Sep 22, 2016 9:18 PM, "Jeffrey Vander Stoep"<jeffv@google.com>
>>>>> wrote:
>>>>>> Remember to test on the Mac build. About a year ago I moved the
>>>>>> host side
>>>>> tools over to upstream libselinux, but had to revert because it
>>>>> broke the
>>>>> Mac build in multiple places. Since then Richard Haines has done a
>>>>> lot of
>>>>> work to reduce the diff between upstream and the Android fork.
>>>>> Hopefully
>>>>> that will reduce your effort.
>>>>>
>>>>> Yeah I'm quite concerned about the Mac build, does anyone on here have
>>>>> access to a Mac for testing?
>>>>
>>>> I do, let me know when you have a branch you need looked at and I'll
>>>> try to
>>>> get to it.
>>>
>>> Feel free to test the fork-kill branch from my github, you should find
>>> the details
>>> below from a previous message in the thread.
>>>
>>
>> Sure,
>>
>> Mac uses llvm which seems to catch much more than gcc, I have to get rid
>> of Werror to even get partially through a build. First issues:
>>
>> genbools.c:71:9: warning: unused variable 'size' [-Wunused-variable]
>>         size_t size = 0;
>>                ^
>> 1 warning generated.
>> cc -Wall -W -Wundef -Wshadow -Wmissing-format-attribute -O2 -I.
>> -I../include -D_GNU_SOURCE -I../cil/include -fPIC -c -o genusers.o
>> genusers.c
>> genusers.c:39:9: warning: unused variable 'len' [-Wunused-variable]
>>         size_t len = 0;
>>                ^
>> genusers.c:63:14: warning: variable 'nread' is uninitialized when used
>> here [-Wuninitialized]
>>                 if (buffer[nread - 1] == '\n')
>>                            ^~~~~
>> genusers.c:40:15: note: initialize the variable 'nread' to silence this
>> warning
>>         ssize_t nread;
>>                      ^
>>                       = 0
>>
>> but the .symver actually kills it altogether (I get a lot of these):
>>
>> <inline asm>:10:1: error: unknown directive
>> .symver cil_filecons_to_string_nopdb, cil_filecons_to_string@@LIBSEPOL_1.1
>> ^
>
> Are you building this in the context of Android?  We disable the symver
> stuff automatically if ANDROID is defined.  We only need to ensure that
> the portion of selinux userspace that is compiled for Android builds on
> MacOS X; it will never fully build there.
>

All those files belong to libsepol, which I am pretty sure is building on Mac.
However, size is unused on __APPLE__ path, so I will prep patches for those
unused and uninitialized variables.

I am mostly concerned about libselinux, which on Android we only use a subset
of the files. It would be possible to have a Makefile setup with the
files and defines
but it would only build the build host version and not the target. The
target would
be trickier as it links and builds against bionic.

-- 
Respectfully,

William C Roberts
