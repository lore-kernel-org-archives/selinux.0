Received: from jazzdrum.ncsc.mil ([144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j03CrRIi016569
	for <selinux@tycho.nsa.gov>; Mon, 3 Jan 2005 07:53:27 -0500 (EST)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j03CrQl1025553
	for <selinux@tycho.nsa.gov>; Mon, 3 Jan 2005 12:53:28 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: Updated SELinux Release
Date: Mon, 3 Jan 2005 23:53:08 +1100
Cc: Colin Walters <walters@verbum.org>,
   Manoj Srivastava <manoj.srivastava@stdc.com>, selinux@tycho.nsa.gov,
   debian-devel@lists.debian.org
References: <1099496380.1213.111.camel@moss-spartans.epoch.ncsc.mil> <1099667461.25416.27.camel@nexus.verbum.private> <20041105155752.GC5565@lkcl.net>
In-Reply-To: <20041105155752.GC5565@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200501032353.12543.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 06 November 2004 02:57, Luke Kenneth Casson Leighton 
<lkcl@lkcl.net> wrote:
>  debian doesn't GIVE users that choice [remember the adamantix
>  bun-fight, anyone?] and instead settles for about the lowest possible
>  common denominator - no consideration to modern security AT ALL!

Doing the things that Adamantix does takes some work.  The Adamantix people 
are doing their own distribution and are not contributing to Debian.  There 
are many Debian developers who want to see the same stuff included in Debian 
(including me), but no-one with the right combination of interest, time, and 
skills.

If someone is looking for things to work on then it would be a good place to 
start.

>  maybe it's just me with my weird setup [very likely], but
>  running mozilla under KDE 3.3.0 with selinux 2.6.8.1-selinux1
>  on a 256mb system P4 2.4Ghz) is a 10-11 second startup,
>  whereas if i set selinux=0 i've seen as fast as a THREE second
>  startup time.

That sounds bizarre.  What does "enforcing=0" give?  What if you kill klogd 
before starting it?

>  i've put KDE_IS_PRELINKED=1, KDE_FORK_SLAVES=1 into the
>  /usr/bin/startkde

/usr/bin/startkde in Debian sources *.sh from directories 
~/.kde/env, /usr/local/env, and /usr/env.  I think that
"kde-config --path exe" is not giving the most desirable results in this 
regard, and maybe we should have some other way of determining the path.

Something like /etc/kde/env would be a good directory for such things.  Then 
one of the SE Linux packages could drop a little script in that exports those 
variables.

Luke, could you please file appropriate bug reports about this

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
