Message-ID: <1344962917.5588.61.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: A filename to label translation daemon
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@parisplace.org>
Cc: russell@coker.com.au, Colin Walters <walters@verbum.org>,
        Daniel J Walsh
 <dwalsh@redhat.com>,
        Lennart Poettering <lennart@poettering.net>,
        Eric
 Paris <eparis@redhat.com>, selinux@tycho.nsa.gov
Date: Tue, 14 Aug 2012 12:48:37 -0400
In-Reply-To: <CACLa4ptRM3FcqanoagF=xUsvFZ1Ct9kEZW2uyiB7ECGK+zL0fg@mail.gmail.com>
References: <1344454290.25533.12.camel@localhost>
	 <50293B11.9010105@redhat.com> <1344880524.16306.15.camel@lenny>
	 <201208142118.42167.russell@coker.com.au>
	 <CACLa4pss-g6qhtwmEv+pOq-jQG7smPxSEt0RU76UnL7=QPh6Hw@mail.gmail.com>
	 <CACLa4ptRM3FcqanoagF=xUsvFZ1Ct9kEZW2uyiB7ECGK+zL0fg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2012-08-14 at 10:01 -0400, Eric Paris wrote:
> Initial really really rough testing using pcre:
> 
> Load and free DB 100 times using GLIBC:
>  8.370 seconds used by the processor.
> 
> Load and free DB 100 times using pcre:
>  1.800 seconds used by the processor.
> 
> This is just using PCRE to load and compile the DB. Not using an
> mmap'd precompiled version.  That's next on the testing list.  But
> switching to pcre is already a huge time win it seems....

Do you need to convert any of the regexes in file_contexts to address
the differences between PCRE and POSIX regexes?

You should check that setfiles using glibc regex followed by setfiles
using PCRE does not change anything on the filesystem, i.e. run the
existing setfiles on all filesystems, then run the setfiles using PCRE
with -nv to report any changes that would be made without applying them.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
