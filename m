Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i43EVgRb005531
	for <selinux@tycho.nsa.gov>; Mon, 3 May 2004 10:31:42 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i43EVdYW005990
	for <selinux@tycho.nsa.gov>; Mon, 3 May 2004 14:31:40 GMT
Received: from dl.oss.co.yu (mps.rns-nis.co.yu [194.247.213.6])
        by jazzband.ncsc.mil  with ESMTP id i43EVaBf005978 for <selinux@tycho.nsa.gov>; Mon, 3 May 2004 14:31:37 GMT
Date: Mon, 3 May 2004 16:30:48 +0200
From: "Milan P. Stanic" <mps@rns-nis.co.yu>
To: selinux@tycho.nsa.gov
Subject: Re: Tinydns Policy Files
Message-ID: <20040503143048.GC2163@rns-nis.co.yu>
References: <20040503085142.GB3143@rns-nis.co.yu> <200405032042.48931.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200405032042.48931.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, May 03, 2004 at 08:42:48PM +1000, Russell Coker wrote:
> On Mon, 3 May 2004 18:51, "Milan P. Stanic" <mps@rns-nis.co.yu> wrote:
> > What do you mean by "entry point executables"?
> 
> something_exec_t, a type that's used as the second parameter in a 
> domain_auto_trans() rule.

Thanks for explanation.
 
> > Binaries are in /package/admin/{package-name}. Only run scripts and
> > config files are under /etc
> 
> Breaking with all Unix conventions.  It's supposed to be /sbin and /usr/sbin 
> for daemons.

Actually, debian packages for djbdns and ucspi-tcp puts binaries under
/usr/bin (not /usr/sbin ???). Only daemontools binaries are under
/package/admin

Regarding conventions: for sake of progress we have to break them
from time to time :-)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
