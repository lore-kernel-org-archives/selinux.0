Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n1G68i5e031827
	for <selinux@tycho.nsa.gov>; Mon, 16 Feb 2009 01:08:44 -0500
Received: from wf-out-1314.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n1G65OZu006420
	for <selinux@tycho.nsa.gov>; Mon, 16 Feb 2009 06:05:24 GMT
Received: by wf-out-1314.google.com with SMTP id 25so11253781wfa.30
        for <selinux@tycho.nsa.gov>; Sun, 15 Feb 2009 22:08:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <200902161339.14054.russell@coker.com.au>
References: <dd18b0c30902142013u323f4853v34270dd2c5e21132@mail.gmail.com>
	 <200902161339.14054.russell@coker.com.au>
Date: Sun, 15 Feb 2009 22:08:42 -0800
Message-ID: <dd18b0c30902152208r46e439e5r6bcabfc299bc2ac8@mail.gmail.com>
Subject: Re: sysvinit doesnt see libselinux/libsepol (LFS system);
From: Justin Mattock <justinmattock@gmail.com>
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Feb 15, 2009 at 6:39 PM, Russell Coker <russell@coker.com.au> wrote:
> On Sun, 15 Feb 2009, Justin Mattock <justinmattock@gmail.com> wrote:
>> I'm in the process of creating a linux from scratch system.
>> when looking at:
>> ldd /sbin/init
>> I dont see any info on
>> libselinux or libsepol.
> [...]
>> Is there a clean patch for sysvinit_2.86.ds1.orig.tar.gz
>> (I just grabbed any sysvinit from either deb/or ubuntu);
>> or even better, a sysvinit(version) that has a built-in command like
>> xserver does(--enable-selinux);
>> appreciate the time.
>
> # ldd /sbin/init |grep selin
>        libselinux.so.1 => /lib/libselinux.so.1 (0xb7f3f000)
>

this is what I always check for in any installation I do.
this time I get nothing.


> The above is from a stock Debian/Lenny system.  The patch (.diff.gz file) for
> that will have the SE Linux code you need.
>

yeah it looks like there is no code with the package that I have
 to make the policy load.
(need to patch the package);

> Incidentally the Debian patch in question is version 61.  I suspect that some
> of those 61 releases have other code that you might desire.  So I suggest
> that even disregarding the fact that the SE Linux code you require is in the
> diff, it's something you would want anyway.
>

I'm not sure(brain is fried from unpackaging/compilling packages all-day);

> Also let's keep the issues of the X server and init entirely separate.  The
> part of your message which referenced X confused me.  When you do tackle the
> X issue (after you have solved your init problem) please make sure to include
> the relevant part of the "ps axZ" output.

I will as soon as I get things configured.
As for the X server I just was using that as an example for a config
option that it has for selinux for sysv

>
>> but results in an unable to sync error when there is no
>> policy present
>
> That sounds like you have SELINUX=enforcing in /etc/selinux/config.  Try
> SELINUX=permissive until you have things working reasonably well.
>

I think that's what happened..
I'll try it again,and see if this was the mistake.

> --
> russell@coker.com.au
> http://etbe.coker.com.au/          My Main Blog
> http://doc.coker.com.au/           My Documents Blog
>

Thanks for the info.
I have a look at my init to make sure things
are in order. Then Ill post ps auxZ for you.

regards;

-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
