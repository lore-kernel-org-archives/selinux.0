Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i43CawRb004601
	for <selinux@tycho.nsa.gov>; Mon, 3 May 2004 08:36:58 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i43CauYW025432
	for <selinux@tycho.nsa.gov>; Mon, 3 May 2004 12:36:56 GMT
Received: from mxlx1.surveysavvy.com (mxlx1.surveysavvy.com [63.108.92.46])
        by jazzband.ncsc.mil  with SMTP id i43CatBf025429 for <selinux@tycho.nsa.gov>; Mon, 3 May 2004 12:36:55 GMT
Message-ID: <4549.68.6.187.64.1083587612.squirrel@mxlx1.surveysavvy.com>
In-Reply-To: <200405032042.48931.russell@coker.com.au>
References: <1083518249.543.9.camel@ares> <1083547353.543.18.camel@ares>
    <20040503085142.GB3143@rns-nis.co.yu>
    <200405032042.48931.russell@coker.com.au>
Date: Mon, 3 May 2004 05:33:32 -0700 (PDT)
Subject: Re: Tinydns Policy Files
From: "Chris Babcock" <cbabcock@luthresearch.com>
To: russell@coker.com.au
Cc: "Milan P. Stanic" <mps@rns-nis.co.yu>, selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> On Mon, 3 May 2004 18:51, "Milan P. Stanic" <mps@rns-nis.co.yu> wrote:
>> On Sun, May 02, 2004 at 09:22:33PM -0400, Matthew J. Fanto wrote:
>> > On Sun, 2004-05-02 at 19:19, Russell Coker wrote:
>> > > Is it possible to configure this and the other DJB tools in a sane
>> > > manner? For starters entry point executables should not be under
>> /etc.
>>
>> What do you mean by "entry point executables"?
>
> something_exec_t, a type that's used as the second parameter in a
> domain_auto_trans() rule.
>
> Having them for cron jobs under /etc/cron.something is bad enough.
>
>> > This is djb's recomended way of doing it. It's also the default for
>> > Debians packages. It might require a decent amount of work to do it
>> > differently.
>>
>> Binaries are in /package/admin/{package-name}. Only run scripts and
>> config files are under /etc
>
> Breaking with all Unix conventions.  It's supposed to be /sbin and
> /usr/sbin
> for daemons.
>
The binaries for djb stuff installs somewhere under /usr/local by default
for everything except qmail and daemontools.

Dan recommends that daemontools be installed into "/package".  After some
dissection this appears to mostly be because the daemontools service
manager is launched from the inittab, and some pain can be caused by not
having the binaries for it on the root filesystem.  I have at times
installed daemontools in other places.  Other locations work fine, however
filesystem repair tends to be annoying. <I can provide details if anybody
cares...>

The stuff that ends up in etc is generally control files w/named pipes,
config files w/empty chroot directories, and default minimal logs (limited
to 1MB or so by default, if I remember right).

Strictly speaking, the service directories can be placed anywhere.  Dan's
examples all put them in /etc, but there is no technical reason they need
to be in /etc.  All that is really required is that a sym link exists
between a  "/service/<service-instance-name>" and the real service
directory that was created, and whatever users the processes run under
generally need to be able to read some subsection of the real service
directory.

Anybody have any ideas about where these service directories should go in
a se system?  My instinct tells me that they should probably go somewhere
in /var on an se system, but it is a tough call since many sysadmins have
their own ideas about where service directories should go.

For sanity in policy distribution, it is probably going to be necessary to
"strongly recommend" service directories be in a specific location.

> --
> http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
> http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
> http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
> http://www.coker.com.au/~russell/  My home page
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the message.
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
