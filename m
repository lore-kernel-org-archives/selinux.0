Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8SLOiN4009387
 for <selinux@tycho.nsa.gov>; Wed, 28 Sep 2016 17:24:52 -0400
Received: by mail-qt0-f170.google.com with SMTP id 30so3290048qth.2
 for <selinux@tycho.nsa.gov>; Wed, 28 Sep 2016 14:24:43 -0700 (PDT)
Message-ID: <57EC3517.3020804@quarksecurity.com>
Date: Wed, 28 Sep 2016 17:24:39 -0400
From: Joshua Brindle <brindle@quarksecurity.com>
MIME-Version: 1.0
To: William Roberts <bill.c.roberts@gmail.com>
CC: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>,
 seandroid-list@tycho.nsa.gov
Subject: Re: [RFC] Build ANDROID_HOST=y on mac
References: <CAFftDdqOWmwCihg4ujOz0qm3xWhRiTTT8dnD2dTPd-a903Ntkw@mail.gmail.com>
 <57EC2A2F.5030908@quarksecurity.com> <57EC2E10.4030207@quarksecurity.com>
 <CAFftDdo04U_xFSDwLvU_A1jW2C0F7Awdhsn=jMfqtXUMmz0uqg@mail.gmail.com>
 <57EC3122.5040802@quarksecurity.com>
 <CAFftDdpTRkNWpTF3dmNb=tkZ+izMjPL9s8ZHc2YhRCPW4z3sEg@mail.gmail.com>
In-Reply-To: <CAFftDdpTRkNWpTF3dmNb=tkZ+izMjPL9s8ZHc2YhRCPW4z3sEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

William Roberts wrote:
> On Sep 28, 2016 17:07, "Joshua Brindle"<brindle@quarksecurity.com>  wrote:
>> William Roberts wrote:
>>> On Sep 28, 2016 16:54, "Joshua Brindle"<brindle@quarksecurity.com>
> wrote:
>>>> Joshua Brindle wrote:
>>>>> William Roberts wrote:
>>>>>>    From commit 35d702 on
>>>>>> https://github.com/williamcroberts/selinux/tree/fix-mac
>>>>>>
>>>>>> I have a branch that is building on my elcapitan mac, requesting any
>>>>>> comments anyone
>>>>>> wishes to make, before I send them out.
>>>>>>
>>>>>> If you wish to test, this is the procedure
>>>>>>
>>>>>> 1. Build libsepol (assumes at root of tree)
>>>>>> a, cd libsepol
>>>>>> b. make
>>>>>> 2. Build libselinux
>>>>>> a. cd libselinux (assumes at root of tree)
>>>>>> b. make ANDROID_HOST=y
>>>>>>
>>>>> This works for me.
>>>>
>>>> make install DESTDIR=/tmp/someidr mostly works, Mac ln does not support
>>> --relative so that fails. ANDROID_HOST also needs to be set in the top
>>> level makefile so that it propagates down:
>>>> ANDROID_HOST ?= n
>>>
>>> Yeah install doesn't work on Mac, that's why for Darwin we just set the
>>> path to the libsepol location for sefcontext_compile.
>>>
>>> As for ANDROID_HOST, why does it need to go higher? It's only used in
>>> libselinux and is declared and used just like DISABLE_SETRANS...I'm not
>>> following you?
>>>
>> Because I was building from the top, basically seeing if I could get a
> usable toolchain out of it, but that looks like it would require a bit more
> work.
>
> Ahh yeah, that won't work yet, but that would be nice.

I got checkpolicy and checkmodule out. No cilc stuff and dispol/dismod 
needs byteswap.h and endian.h.

>
>>
>>>>>> This essentially gets us to where a build server/maintainer
>>>>>> can test patches quickly on mac, with some assurance
>>>>>> it's not busted without downloading all of Android.
>>>>>>
>>>>>> It's still wise to check in an Android tree if possible IMHO.
>>>>>>
>
