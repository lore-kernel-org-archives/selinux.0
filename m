Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8SKstEj005679
 for <selinux@tycho.nsa.gov>; Wed, 28 Sep 2016 16:54:55 -0400
Received: by mail-qt0-f179.google.com with SMTP id 11so28354779qtc.0
 for <selinux@tycho.nsa.gov>; Wed, 28 Sep 2016 13:54:43 -0700 (PDT)
Message-ID: <57EC2E10.4030207@quarksecurity.com>
Date: Wed, 28 Sep 2016 16:54:40 -0400
From: Joshua Brindle <brindle@quarksecurity.com>
MIME-Version: 1.0
To: William Roberts <bill.c.roberts@gmail.com>
CC: "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [RFC] Build ANDROID_HOST=y on mac
References: <CAFftDdqOWmwCihg4ujOz0qm3xWhRiTTT8dnD2dTPd-a903Ntkw@mail.gmail.com>
 <57EC2A2F.5030908@quarksecurity.com>
In-Reply-To: <57EC2A2F.5030908@quarksecurity.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Joshua Brindle wrote:
> William Roberts wrote:
>> From commit 35d702 on
>> https://github.com/williamcroberts/selinux/tree/fix-mac
>>
>> I have a branch that is building on my elcapitan mac, requesting any
>> comments anyone
>> wishes to make, before I send them out.
>>
>> If you wish to test, this is the procedure
>>
>> 1. Build libsepol (assumes at root of tree)
>> a, cd libsepol
>> b. make
>> 2. Build libselinux
>> a. cd libselinux (assumes at root of tree)
>> b. make ANDROID_HOST=y
>>
>
> This works for me.

make install DESTDIR=/tmp/someidr mostly works, Mac ln does not support 
--relative so that fails. ANDROID_HOST also needs to be set in the top 
level makefile so that it propagates down:

ANDROID_HOST ?= n

>
>
>> This essentially gets us to where a build server/maintainer
>> can test patches quickly on mac, with some assurance
>> it's not busted without downloading all of Android.
>>
>> It's still wise to check in an Android tree if possible IMHO.
>>
>
