Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i43EVeRb005526
	for <selinux@tycho.nsa.gov>; Mon, 3 May 2004 10:31:40 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i43ETQZx014902
	for <selinux@tycho.nsa.gov>; Mon, 3 May 2004 14:29:26 GMT
Received: from dl.oss.co.yu (mps.rns-nis.co.yu [194.247.213.6])
	by jazzswing.ncsc.mil  with ESMTP id i43ETOJv014894
	for <selinux@tycho.nsa.gov>; Mon, 3 May 2004 14:29:25 GMT
Date: Mon, 3 May 2004 16:30:23 +0200
From: "Milan P. Stanic" <mps@rns-nis.co.yu>
To: selinux@tycho.nsa.gov
Subject: Re: Tinydns Policy Files
Message-ID: <20040503143023.GB2163@rns-nis.co.yu>
References: <200405032042.48931.russell@coker.com.au> <4549.68.6.187.64.1083587612.squirrel@mxlx1.surveysavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4549.68.6.187.64.1083587612.squirrel@mxlx1.surveysavvy.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, May 03, 2004 at 05:33:32AM -0700, Chris Babcock wrote:
> The binaries for djb stuff installs somewhere under /usr/local by default
> for everything except qmail and daemontools.

Right. I made mistake in previous mail.
 
> Dan recommends that daemontools be installed into "/package".  After some
> dissection this appears to mostly be because the daemontools service
> manager is launched from the inittab, and some pain can be caused by not
> having the binaries for it on the root filesystem.  I have at times
> installed daemontools in other places.  Other locations work fine, however
> filesystem repair tends to be annoying. <I can provide details if anybody
> cares...>

I'd like hear why repair "tends to be annoying"?
 
> The stuff that ends up in etc is generally control files w/named pipes,
> config files w/empty chroot directories, and default minimal logs (limited
> to 1MB or so by default, if I remember right).

Logs can be easily put under /var/log . I did that always.
 
[...]
> Anybody have any ideas about where these service directories should go in
> a se system?  My instinct tells me that they should probably go somewhere
> in /var on an se system, but it is a tough call since many sysadmins have
> their own ideas about where service directories should go.

I have them under /var/svc (I'm lazy man, hate to type too much :-) )
on some of my servers, but I'm moving them back to /etc . Log dirs are
under /var/log and supervise dirs are symlinks to
/var/run/{service-name}

Under runit package (daemontools replacement) for debian symlinks are
under /var/service (I'll have to type more :-) ) but the run files are
under /etc/runit

For systems without security policies (SELinux, GRSec, LIDS) this mess
isn't problem, but for system with SELinux it should be standardized.
I thought about that but I don't have sane idea how.

> For sanity in policy distribution, it is probably going to be necessary to
> "strongly recommend" service directories be in a specific location.

I agree.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
