Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n1GEIrQn029540
	for <selinux@tycho.nsa.gov>; Mon, 16 Feb 2009 09:18:53 -0500
Received: from wf-out-1314.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n1GEIppM008332
	for <selinux@tycho.nsa.gov>; Mon, 16 Feb 2009 14:18:51 GMT
Received: by wf-out-1314.google.com with SMTP id 25so11517246wfa.30
        for <selinux@tycho.nsa.gov>; Mon, 16 Feb 2009 06:18:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <dd18b0c30902152208r46e439e5r6bcabfc299bc2ac8@mail.gmail.com>
References: <dd18b0c30902142013u323f4853v34270dd2c5e21132@mail.gmail.com>
	 <200902161339.14054.russell@coker.com.au>
	 <dd18b0c30902152208r46e439e5r6bcabfc299bc2ac8@mail.gmail.com>
Date: Mon, 16 Feb 2009 06:18:49 -0800
Message-ID: <dd18b0c30902160618p5501ecdaie3ffefd96b66188a@mail.gmail.com>
Subject: Re: sysvinit doesnt see libselinux/libsepol (LFS system);
From: Justin Mattock <justinmattock@gmail.com>
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Feb 15, 2009 at 10:08 PM, Justin Mattock
<justinmattock@gmail.com> wrote:
> On Sun, Feb 15, 2009 at 6:39 PM, Russell Coker <russell@coker.com.au> wrote:
>> On Sun, 15 Feb 2009, Justin Mattock <justinmattock@gmail.com> wrote:
>>> I'm in the process of creating a linux from scratch system.
>>> when looking at:
>>> ldd /sbin/init
>>> I dont see any info on
>>> libselinux or libsepol.
>> [...]
>>> Is there a clean patch for sysvinit_2.86.ds1.orig.tar.gz
>>> (I just grabbed any sysvinit from either deb/or ubuntu);
>>> or even better, a sysvinit(version) that has a built-in command like
>>> xserver does(--enable-selinux);
>>> appreciate the time.
>>
>> # ldd /sbin/init |grep selin
>>        libselinux.so.1 => /lib/libselinux.so.1 (0xb7f3f000)
>>
>
> this is what I always check for in any installation I do.
> this time I get nothing.
>
>
>> The above is from a stock Debian/Lenny system.  The patch (.diff.gz file) for
>> that will have the SE Linux code you need.
>>
>
> yeah it looks like there is no code with the package that I have
>  to make the policy load.
> (need to patch the package);
>
>> Incidentally the Debian patch in question is version 61.  I suspect that some
>> of those 61 releases have other code that you might desire.  So I suggest
>> that even disregarding the fact that the SE Linux code you require is in the
>> diff, it's something you would want anyway.
>>
>
> I'm not sure(brain is fried from unpackaging/compilling packages all-day);
>
>> Also let's keep the issues of the X server and init entirely separate.  The
>> part of your message which referenced X confused me.  When you do tackle the
>> X issue (after you have solved your init problem) please make sure to include
>> the relevant part of the "ps axZ" output.
>
> I will as soon as I get things configured.
> As for the X server I just was using that as an example for a config
> option that it has for selinux for sysv
>
>>
>>> but results in an unable to sync error when there is no
>>> policy present
>>
>> That sounds like you have SELINUX=enforcing in /etc/selinux/config.  Try
>> SELINUX=permissive until you have things working reasonably well.
>>
>
> I think that's what happened..
> I'll try it again,and see if this was the mistake.
>
>> --
>> russell@coker.com.au
>> http://etbe.coker.com.au/          My Main Blog
>> http://doc.coker.com.au/           My Documents Blog
>>
>
> Thanks for the info.
> I have a look at my init to make sure things
> are in order. Then Ill post ps auxZ for you.
>
> regards;
>
> --
> Justin P. Mattock
>

Alright;
to make things less confusing, here's some urls that I found
to load the policy with sysvinit:

http://repos.archlinux.org/viewvc.cgi/community/system/selinux-sysvinit/sysvinit-init.c.diff?view=log&root=community&pathrev=CURRENT

http://www.mail-archive.com/pkg-sysvinit-devel@lists.alioth.debian.org/msg00663.html

The issue I have is using dpkg/or apt-get already has the right
patch applied and init already compiled in, in accordance to the distro.
doing a (LFS) tutorial, under the documentation
has me building everything from the source.
(a lot of work, but worth the learning experience);

I just need to find a right suitable patch for sysvinit to load the policy
during boot so I can get refpolicy compiled in accordance to
to the system.
under /etc/*
(LFS) looks similar to redhat  i.g.
/etc/rc.d/init.d/(lfs-bootscripts);
but not sure if this matters or not.

In any case, I suppose I can just copy /sbin/init from an existing
debian system but, then I might have issues with the
arch being different.

-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
