Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i43LbkRb008795
	for <selinux@tycho.nsa.gov>; Mon, 3 May 2004 17:37:46 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i43LZWZx013644
	for <selinux@tycho.nsa.gov>; Mon, 3 May 2004 21:35:32 GMT
Received: from smtp.sws.net.au ([61.95.69.6])
	by jazzswing.ncsc.mil  with ESMTP id i43LZUJv013552
	for <selinux@tycho.nsa.gov>; Mon, 3 May 2004 21:35:31 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Chris Babcock" <cbabcock@luthresearch.com>
Subject: Re: Tinydns Policy Files
Date: Tue, 4 May 2004 07:36:21 +1000
Cc: selinux@tycho.nsa.gov
References: <1083518249.543.9.camel@ares> <200405032042.48931.russell@coker.com.au> <4549.68.6.187.64.1083587612.squirrel@mxlx1.surveysavvy.com>
In-Reply-To: <4549.68.6.187.64.1083587612.squirrel@mxlx1.surveysavvy.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200405040736.21637.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 3 May 2004 22:33, "Chris Babcock" <cbabcock@luthresearch.com> wrote:
> > Breaking with all Unix conventions.  It's supposed to be /sbin and
> > /usr/sbin
> > for daemons.
>
> The binaries for djb stuff installs somewhere under /usr/local by default
> for everything except qmail and daemontools.

For any distribution with a packaging system (any RPM or dpkg based 
distribution) such things should not be installed in /usr/local.

> Dan recommends that daemontools be installed into "/package".  After some
> dissection this appears to mostly be because the daemontools service
> manager is launched from the inittab, and some pain can be caused by not

Launching from inittab means that the binaries should go in /sbin, /bin if 
they are used in some other way than as init scripts, and that any shared 
objects that they need should go in /lib.  Everyone else's software has been 
working well like this for decades.

> The stuff that ends up in etc is generally control files w/named pipes,

Named pipes in /etc, Solaris used to do that, it's really annoying.  Some 
early Linux distributions copied that mistake, but it's been corrected now.

> config files w/empty chroot directories, and default minimal logs (limited
> to 1MB or so by default, if I remember right).

Logs belong in /var/log.

> Anybody have any ideas about where these service directories should go in
> a se system?  My instinct tells me that they should probably go somewhere
> in /var on an se system, but it is a tough call since many sysadmins have
> their own ideas about where service directories should go.

The FHS should contain all the information you need.  It's not easy to read 
though so copying the practises of distributions such as Debian and Fedora is 
a much easier way of getting the same result.

> For sanity in policy distribution, it is probably going to be necessary to
> "strongly recommend" service directories be in a specific location.

Yes.  For the Qmail policy I put in both good file locations (as once used by 
Debian packages) and DJB's locations.  But it seems that those other programs 
are even messier, so I'm not sure it's a good idea to put the non-FHS 
locations in too.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
