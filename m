Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i44BiXRb011440
	for <selinux@tycho.nsa.gov>; Tue, 4 May 2004 07:44:33 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i44BiLYW005124
	for <selinux@tycho.nsa.gov>; Tue, 4 May 2004 11:44:21 GMT
Received: from mxlx1.surveysavvy.com (mxlx1.surveysavvy.com [63.108.92.46])
        by jazzband.ncsc.mil  with SMTP id i44BiKBf005121 for <selinux@tycho.nsa.gov>; Tue, 4 May 2004 11:44:21 GMT
Message-ID: <1997.68.6.187.64.1083670847.squirrel@mxlx1.surveysavvy.com>
In-Reply-To: <200405040736.21637.russell@coker.com.au>
References: <1083518249.543.9.camel@ares>
    <200405032042.48931.russell@coker.com.au>
    <4549.68.6.187.64.1083587612.squirrel@mxlx1.surveysavvy.com>
    <200405040736.21637.russell@coker.com.au>
Date: Tue, 4 May 2004 04:40:47 -0700 (PDT)
Subject: Re: Tinydns Policy Files
From: "Chris Babcock" <cbabcock@luthresearch.com>
To: russell@coker.com.au
Cc: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> On Mon, 3 May 2004 22:33, "Chris Babcock" <cbabcock@luthresearch.com>
> wrote:
>> > Breaking with all Unix conventions.  It's supposed to be /sbin and
>> > /usr/sbin
>> > for daemons.
>>
>> The binaries for djb stuff installs somewhere under /usr/local by
>> default
>> for everything except qmail and daemontools.
>
> For any distribution with a packaging system (any RPM or dpkg based
> distribution) such things should not be installed in /usr/local.
>
Last I checked, Dan still didn't permit distribution of binary packages
that  were modified in any way from the default as distributed in source. 
This includes changing default paths, etc.

This has pretty much been a roadblock, preventing non-source based
distributions from integrating any of the djb tools, and it has meant that
working with the djb tools always means working with source in some form.

It would be nice to have some documented guidelines and recommendations
for how to make the djb stuff work with an se system, but how necessary is
it to try to enforce distribution standards on a set of tools that can't
be integrated into a non-source distribution anyway?

I suspect that anybody using the djb tools who can't adapt a "default" djb
tools policy for their setup of the djb stuff on their system is probably
dead meat anyway.  Because even if the policy doesn't kill you, the sharp
edges on the djb tools load and install will.

Likewise any source based distro vendor is going to relocate the built
package components to where ever they want it anyway, and modify their se
policy to fit how they have broken down the package.

>> Dan recommends that daemontools be installed into "/package".  After
>> some
>> dissection this appears to mostly be because the daemontools service
>> manager is launched from the inittab, and some pain can be caused by not
>
> Launching from inittab means that the binaries should go in /sbin, /bin if
> they are used in some other way than as init scripts, and that any shared
> objects that they need should go in /lib.  Everyone else's software has
> been
> working well like this for decades.
>
I have put daemontools in dozens of different places over the years.  I
would have no trouble putting it in /sbin.  It can be done.  I typically
don't because I don't like to mix my source built tools with vendor
supplied binaries.

Same comment as above on standardization.

>> The stuff that ends up in etc is generally control files w/named pipes,
>
> Named pipes in /etc, Solaris used to do that, it's really annoying.  Some
> early Linux distributions copied that mistake, but it's been corrected
> now.
>
>> config files w/empty chroot directories, and default minimal logs
>> (limited
>> to 1MB or so by default, if I remember right).
>
> Logs belong in /var/log.
>
In general, yes.

>> Anybody have any ideas about where these service directories should go
>> in
>> a se system?  My instinct tells me that they should probably go
>> somewhere
>> in /var on an se system, but it is a tough call since many sysadmins
>> have
>> their own ideas about where service directories should go.
>
> The FHS should contain all the information you need.  It's not easy to
> read
> though so copying the practises of distributions such as Debian and Fedora
> is
> a much easier way of getting the same result.
>
>> For sanity in policy distribution, it is probably going to be necessary
>> to
>> "strongly recommend" service directories be in a specific location.
>
> Yes.  For the Qmail policy I put in both good file locations (as once used
> by
> Debian packages) and DJB's locations.  But it seems that those other
> programs
> are even messier, so I'm not sure it's a good idea to put the non-FHS
> locations in too.
>
For djbdns one way to make this work is to make a replacement version of
the dnscache-conf, tinydns-conf, and axfrdns-conf tools that also builds a
policy with the appropriate locations as specified when the user runs the
*-conf tool, possibly relocating some files to more se friendly locations.

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
