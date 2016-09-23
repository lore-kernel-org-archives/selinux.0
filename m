MIME-Version: 1.0
In-Reply-To: <57E534DE.9070500@quarksecurity.com>
References: <CAFftDdqDxr6jqC7t1imRrQ7dMJEsZh--L0CrWOCzgYUfwNeZyA@mail.gmail.com>
 <CAFftDdoXEo9Q7bRrr-AeHFX7eauKGeWzqRW-m_Z=hfXUT_JFUA@mail.gmail.com>
 <CABXk95BAor2Y7nvOZkkwEsc=8xgoa63x89WQtCbXDvzu_Pch_A@mail.gmail.com>
 <CAFftDdqr_DXtkaTkUApdsp7Nq5bm3FrUEq2xRDkc6b7Omx5RxQ@mail.gmail.com>
 <57E534DE.9070500@quarksecurity.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Fri, 23 Sep 2016 08:42:05 -0700
Message-ID: <CAFftDdqs21PprRVRYfMjHXH2Qe7x3eYz8cR2M-bLbTso9HdnoQ@mail.gmail.com>
Subject: Re: Killing The Android libselinux Fork (available)
To: Joshua Brindle <brindle@quarksecurity.com>
Cc: Jeff Vander Stoep <jeffv@google.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 Daniel Cashman <dcashman@android.com>,
 "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>,
 Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Sep 23, 2016 at 6:57 AM, Joshua Brindle
<brindle@quarksecurity.com> wrote:
> William Roberts wrote:
>>
>> On Sep 22, 2016 9:18 PM, "Jeffrey Vander Stoep"<jeffv@google.com>  wrote:
>>>
>>> Remember to test on the Mac build. About a year ago I moved the host side
>>
>> tools over to upstream libselinux, but had to revert because it broke the
>> Mac build in multiple places. Since then Richard Haines has done a lot of
>> work to reduce the diff between upstream and the Android fork. Hopefully
>> that will reduce your effort.
>>
>> Yeah I'm quite concerned about the Mac build, does anyone on here have
>> access to a Mac for testing?
>
>
> I do, let me know when you have a branch you need looked at and I'll try to
> get to it.

Feel free to test the fork-kill branch from my github, you should find
the details
below from a previous message in the thread.

<snip>

>>>>> The work is available here:
>>>>> https://github.com/williamcroberts/selinux/tree/fork-kill
>>>>>
>>>>> Currently to Build:
>>>>> 1. remove external/libselinux
>>>>> 2. apply this patch to bionic if not present:
>>>>> https://android-review.googlesource.com/#/c/276918
>>>>> 3. either set external/selinux to my fork-kill branch or merge selinux
>>>>> upstream master into external/selinux and apply the two patches listed
>>>>> below:
>>>>>
>>>>> Patches that matter ( I don't know how to make pretty little git
>>
>> summaries):
>>>>>
>>>>> commit e017f48acd2791a6aa62b4ed0c0b44256b26651f
>>>>> Author: William Roberts<william.c.roberts@intel.com>
>>>>> Date:   Wed Sep 21 16:06:37 2016 -0700
>>>>> libselinux: add The Android fork files
>>>>>
>>>>> commit f40d7facbcaf1337f37b5630b98806fd25b1dbf9
>>>>> Author: William Roberts<william.c.roberts@intel.com>
>>>>> Date:   Wed Sep 21 16:00:34 2016 -0700
>>>>> libselinux: rectify the Android fork
>>>>>
>>>>> The goal would be to upstream commit f40d7facb and leave
>>>>> commit e017f48ac on the Android tree.
>>>>>
>>>>> I am going to do some further testing tomorrow, and plan on submitting
>>>>> the upstream patch f40d7facbc on Monday. If anyone wants to leave
>>>>> preliminary feedback, or has a specific thing they want tested, let me
>>

<snip>
