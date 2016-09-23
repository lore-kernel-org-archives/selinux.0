Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8NDvsaZ022848
 for <selinux@tycho.nsa.gov>; Fri, 23 Sep 2016 09:57:54 -0400
Received: by mail-qk0-f181.google.com with SMTP id n185so106293342qke.1
 for <selinux@tycho.nsa.gov>; Fri, 23 Sep 2016 06:57:51 -0700 (PDT)
Message-ID: <57E534DE.9070500@quarksecurity.com>
Date: Fri, 23 Sep 2016 09:57:50 -0400
From: Joshua Brindle <brindle@quarksecurity.com>
MIME-Version: 1.0
To: William Roberts <bill.c.roberts@gmail.com>
CC: Jeff Vander Stoep <jeffv@google.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 Daniel Cashman <dcashman@android.com>,
 "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>,
 Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: Killing The Android libselinux Fork (available)
References: <CAFftDdqDxr6jqC7t1imRrQ7dMJEsZh--L0CrWOCzgYUfwNeZyA@mail.gmail.com>
 <CAFftDdoXEo9Q7bRrr-AeHFX7eauKGeWzqRW-m_Z=hfXUT_JFUA@mail.gmail.com>
 <CABXk95BAor2Y7nvOZkkwEsc=8xgoa63x89WQtCbXDvzu_Pch_A@mail.gmail.com>
 <CAFftDdqr_DXtkaTkUApdsp7Nq5bm3FrUEq2xRDkc6b7Omx5RxQ@mail.gmail.com>
In-Reply-To: <CAFftDdqr_DXtkaTkUApdsp7Nq5bm3FrUEq2xRDkc6b7Omx5RxQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

William Roberts wrote:
> On Sep 22, 2016 9:18 PM, "Jeffrey Vander Stoep"<jeffv@google.com>  wrote:
>> Remember to test on the Mac build. About a year ago I moved the host side
> tools over to upstream libselinux, but had to revert because it broke the
> Mac build in multiple places. Since then Richard Haines has done a lot of
> work to reduce the diff between upstream and the Android fork. Hopefully
> that will reduce your effort.
>
> Yeah I'm quite concerned about the Mac build, does anyone on here have
> access to a Mac for testing?

I do, let me know when you have a branch you need looked at and I'll try 
to get to it.


>
>> On Thu, Sep 22, 2016 at 6:39 PM William Roberts<bill.c.roberts@gmail.com>
> wrote:
>>> On Thu, Sep 22, 2016 at 6:34 PM, William Roberts
>>> <bill.c.roberts@gmail.com>  wrote:
>>>> So I have been working the last couple of days to understand what it
>>>> would take to kill external/libselinux (the Android Fork) and fixup
>>>> upstream so most of the delta is in. The only thing we would keep on
>>>> the Android side, is android.c and .h. Since those files are self
>>>> contained, we should just be able to merge upstream without concerns
>>>> of conflict. If we really wanted to, we could spin off a separate
>>>> libselinux-android that builds those two files and links to
>>>> libselinux, but that seems overkill IMHO.
>>>>
>>>> The work is available here:
>>>> https://github.com/williamcroberts/selinux/tree/fork-kill
>>>>
>>>> Currently to Build:
>>>> 1. remove external/libselinux
>>>> 2. apply this patch to bionic if not present:
>>>> https://android-review.googlesource.com/#/c/276918
>>>> 3. either set external/selinux to my fork-kill branch or merge selinux
>>>> upstream master into external/selinux and apply the two patches listed
>>>> below:
>>>>
>>>> Patches that matter ( I don't know how to make pretty little git
> summaries):
>>>> commit e017f48acd2791a6aa62b4ed0c0b44256b26651f
>>>> Author: William Roberts<william.c.roberts@intel.com>
>>>> Date:   Wed Sep 21 16:06:37 2016 -0700
>>>> libselinux: add The Android fork files
>>>>
>>>> commit f40d7facbcaf1337f37b5630b98806fd25b1dbf9
>>>> Author: William Roberts<william.c.roberts@intel.com>
>>>> Date:   Wed Sep 21 16:00:34 2016 -0700
>>>> libselinux: rectify the Android fork
>>>>
>>>> The goal would be to upstream commit f40d7facb and leave
>>>> commit e017f48ac on the Android tree.
>>>>
>>>> I am going to do some further testing tomorrow, and plan on submitting
>>>> the upstream patch f40d7facbc on Monday. If anyone wants to leave
>>>> preliminary feedback, or has a specific thing they want tested, let me
> know.
>>>> Currently tested on the emulator and checked that the digest mechanism
> for
>>>> last restorecon value is working.
>>>>
>>>> --
>>>> Respectfully,
>>>>
>>>> William C Roberts
>>> FYI I may rebase that branch at anytime... you have been warned :-P
>
> _______________________________________________
> Seandroid-list mailing list
> Seandroid-list@tycho.nsa.gov
> To unsubscribe, send email to Seandroid-list-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Seandroid-list-request@tycho.nsa.gov.
