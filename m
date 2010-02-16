Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o1G3YCOu021545
	for <selinux@tycho.nsa.gov>; Mon, 15 Feb 2010 22:34:12 -0500
Received: from mail-yw0-f190.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o1G3YOog018223
	for <selinux@tycho.nsa.gov>; Tue, 16 Feb 2010 03:34:24 GMT
Received: by ywh28 with SMTP id 28so4780393ywh.30
        for <selinux@tycho.nsa.gov>; Mon, 15 Feb 2010 19:34:11 -0800 (PST)
Message-ID: <4B7A1233.6010806@gmail.com>
Date: Mon, 15 Feb 2010 19:34:11 -0800
From: "Justin P. mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: SE-Linux <selinux@tycho.nsa.gov>
CC: libc-help@sourceware.org, refpolicy@oss1.tresys.com
Subject: Re: label_file.c:434: error: implicit declaration of function 'fstat'
References: <dd18b0c31002151419v1445e151j761c06e3cf39f5c0@mail.gmail.com>
In-Reply-To: <dd18b0c31002151419v1445e151j761c06e3cf39f5c0@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 02/15/2010 02:19 PM, Justin Mattock wrote:
> this is new:
>
>
> make[2]: Leaving directory `/home/kernel/selinux/libselinux/include'
> make -C src install
> make[2]: Entering directory `/home/kernel/selinux/libselinux/src'
> cc -Werror -Wall -W -Wundef -Wshadow -Wmissing-noreturn
> -Wmissing-format-attribute -I../include -I/usr/include -D_GNU_SOURCE
> -D_FILE_OFFSET_BITS=64   -c -o label_file.o label_file.c
> cc1: warnings being treated as errors
> label_file.c: In function 'init':
> label_file.c:434: error: implicit declaration of function 'fstat'
> label_file.c:436: error: implicit declaration of function 'S_ISREG'
> make[2]: *** [label_file.o] Error 1
> make[2]: Leaving directory `/home/kernel/selinux/libselinux/src'
> make[1]: *** [install] Error 2
> make[1]: Leaving directory `/home/kernel/selinux/libselinux'
> make: *** [install] Error 1
>
> three areas where this could of been created
> update glibc
> updated kernel
> update userspace(altohugh there was not vary many commits in the pull).
>
>
>

looking more into this error by selinux userspace tools(libselinux),
seems there was a change in libc which breaks libselinux.

I've started the bisect with libc but could not go any further because
libc fails to build. The positive side is I'm only about 15 or so 
commits from the last good commit I had, which gets libselinux to build.

heres the last bad commit and last good commit with libc(I'm trying to 
narrow this down, but libc breaks).

last bad commit: 7b4715c5362319e1ff2f9555d17133146e16081a
(bisect is broken by this point).

last good commit: d5ea695b42aecd48a329756a8e93228d64714d17

I added some CC's to hopefully the appropriate
people.

As a workaround I can compile libselinux with the last good commit,
then update libc, but know that's not the right way.

Justin P. Mattock


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
