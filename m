Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA06219
	for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2001 18:54:25 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id XAA25233
	for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2001 23:53:49 GMT
Received: from Woody.fw.matav.hu (matav-1.matav.hu [145.236.241.98])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id XAA25229
	for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2001 23:53:46 GMT
Date: Thu, 11 Jan 2001 00:53:55 +0100
From: =?iso-8859-2?Q?Magos=E1nyi_=C1rp=E1d?= <mag@bunuel.tii.matav.hu>
To: Andi Kleen <ak@suse.de>
Cc: selinux@tycho.nsa.gov
Subject: Re: [selinux] Re: SELinux and covert channels
Message-ID: <20010111005355.A20214@bunuel.tii.matav.hu>
References: <A0669F3E0A6B3448A962DC6141E6C7A614415C@mis1> <20010110192931.A3665@gruyere.muc.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
In-Reply-To: <20010110192931.A3665@gruyere.muc.suse.de>; from ak@suse.de on Wed, Jan 10, 2001 at 07:29:31PM +0100
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

A levelezõm azt hiszi, hogy Andi Kleen a következõeket írta:
> On Wed, Jan 10, 2001 at 11:44:37AM -0500, Belmonte, Christopher wrote:
> > Has anyone considered analyzing SELinux for covert channels?
> 
> Linux is full of covert channels between processes and I doubt selinux helps for most
> of them.

When a process
-cannot see the existence of an other process (policy enforced on /proc)
-cannot ipc with another process (policy enforced on sysv ipc mechanisms and sockets)
-cannot use the same files as the other (policy enforced on files)
and cannot send signals to another process (policy enforced on kill)
how do the two processes create a covert channel?

BTW which of the above is not implemented yet?

> If you want no or at least better controllable covert channels use vmware or simply
> two different PCs. 

One goal of mandatory access control schemes is that you can put more different functionalities
to the same machine. (And anyway where will you get the M component from if you are
use two different PCs?)

-- 
GNU GPL: csak tiszta forrásból

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
