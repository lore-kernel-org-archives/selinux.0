Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8SL7o8D007505
 for <selinux@tycho.nsa.gov>; Wed, 28 Sep 2016 17:07:51 -0400
Received: by mail-qk0-f172.google.com with SMTP id z190so59884287qkc.3
 for <selinux@tycho.nsa.gov>; Wed, 28 Sep 2016 14:07:49 -0700 (PDT)
Message-ID: <57EC3122.5040802@quarksecurity.com>
Date: Wed, 28 Sep 2016 17:07:46 -0400
From: Joshua Brindle <brindle@quarksecurity.com>
MIME-Version: 1.0
To: William Roberts <bill.c.roberts@gmail.com>
CC: seandroid-list@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: [RFC] Build ANDROID_HOST=y on mac
References: <CAFftDdqOWmwCihg4ujOz0qm3xWhRiTTT8dnD2dTPd-a903Ntkw@mail.gmail.com>
 <57EC2A2F.5030908@quarksecurity.com> <57EC2E10.4030207@quarksecurity.com>
 <CAFftDdo04U_xFSDwLvU_A1jW2C0F7Awdhsn=jMfqtXUMmz0uqg@mail.gmail.com>
In-Reply-To: <CAFftDdo04U_xFSDwLvU_A1jW2C0F7Awdhsn=jMfqtXUMmz0uqg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

William Roberts wrote:
> On Sep 28, 2016 16:54, "Joshua Brindle"<brindle@quarksecurity.com>  wrote:
>> Joshua Brindle wrote:
>>> William Roberts wrote:
>>>>  From commit 35d702 on
>>>> https://github.com/williamcroberts/selinux/tree/fix-mac
>>>>
>>>> I have a branch that is building on my elcapitan mac, requesting any
>>>> comments anyone
>>>> wishes to make, before I send them out.
>>>>
>>>> If you wish to test, this is the procedure
>>>>
>>>> 1. Build libsepol (assumes at root of tree)
>>>> a, cd libsepol
>>>> b. make
>>>> 2. Build libselinux
>>>> a. cd libselinux (assumes at root of tree)
>>>> b. make ANDROID_HOST=y
>>>>
>>> This works for me.
>>
>> make install DESTDIR=/tmp/someidr mostly works, Mac ln does not support
> --relative so that fails. ANDROID_HOST also needs to be set in the top
> level makefile so that it propagates down:
>> ANDROID_HOST ?= n
>
> Yeah install doesn't work on Mac, that's why for Darwin we just set the
> path to the libsepol location for sefcontext_compile.
>
> As for ANDROID_HOST, why does it need to go higher? It's only used in
> libselinux and is declared and used just like DISABLE_SETRANS...I'm not
> following you?
>

Because I was building from the top, basically seeing if I could get a 
usable toolchain out of it, but that looks like it would require a bit 
more work.

>>
>>>
>>>> This essentially gets us to where a build server/maintainer
>>>> can test patches quickly on mac, with some assurance
>>>> it's not busted without downloading all of Android.
>>>>
>>>> It's still wise to check in an Android tree if possible IMHO.
>>>>
>
