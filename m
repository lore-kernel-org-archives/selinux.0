Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q7EHLeBi000414
	for <selinux@tycho.nsa.gov>; Tue, 14 Aug 2012 13:21:40 -0400
Received: by obbup19 with SMTP id up19so860901obb.12
        for <selinux@tycho.nsa.gov>; Tue, 14 Aug 2012 10:21:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1344962917.5588.61.camel@moss-pluto.epoch.ncsc.mil>
References: <1344454290.25533.12.camel@localhost>
	<50293B11.9010105@redhat.com>
	<1344880524.16306.15.camel@lenny>
	<201208142118.42167.russell@coker.com.au>
	<CACLa4pss-g6qhtwmEv+pOq-jQG7smPxSEt0RU76UnL7=QPh6Hw@mail.gmail.com>
	<CACLa4ptRM3FcqanoagF=xUsvFZ1Ct9kEZW2uyiB7ECGK+zL0fg@mail.gmail.com>
	<1344962917.5588.61.camel@moss-pluto.epoch.ncsc.mil>
Date: Tue, 14 Aug 2012 13:21:39 -0400
Message-ID: <CACLa4puSX4=N73UPevAnw3aHtTAEQ2mknDNnZ+adri+FhDikgw@mail.gmail.com>
Subject: Re: A filename to label translation daemon
From: Eric Paris <eparis@parisplace.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: russell@coker.com.au, Colin Walters <walters@verbum.org>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Lennart Poettering <lennart@poettering.net>,
        Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Testing is FAR FAR FAR from complete.  PCRE was able to find 2 invalid
specifications that the posix API didn't complain about.  Dan has
fixed those.  I will verify any changes with a complete relabel before
submitting.

-Eric

On Tue, Aug 14, 2012 at 12:48 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Tue, 2012-08-14 at 10:01 -0400, Eric Paris wrote:
>> Initial really really rough testing using pcre:
>>
>> Load and free DB 100 times using GLIBC:
>>  8.370 seconds used by the processor.
>>
>> Load and free DB 100 times using pcre:
>>  1.800 seconds used by the processor.
>>
>> This is just using PCRE to load and compile the DB. Not using an
>> mmap'd precompiled version.  That's next on the testing list.  But
>> switching to pcre is already a huge time win it seems....
>
> Do you need to convert any of the regexes in file_contexts to address
> the differences between PCRE and POSIX regexes?
>
> You should check that setfiles using glibc regex followed by setfiles
> using PCRE does not change anything on the filesystem, i.e. run the
> existing setfiles on all filesystems, then run the setfiles using PCRE
> with -nv to report any changes that would be made without applying them.
>
> --
> Stephen Smalley
> National Security Agency
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
