Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5E3e2rT015748
	for <selinux@tycho.nsa.gov>; Sun, 13 Jun 2004 23:40:02 -0400 (EDT)
Received: from ms-smtp-03.rdc-kc.rr.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5E3dtP2024230
	for <selinux@tycho.nsa.gov>; Sun, 13 Jun 2004 23:39:56 -0400 (EDT)
Received: from sasami.localdomain (CPE-24-31-241-155.kc.rr.com [24.31.241.155])
	by ms-smtp-03.rdc-kc.rr.com (8.12.10/8.12.7) with ESMTP id i5E3dujE023001
	for <selinux@tycho.nsa.gov>; Sun, 13 Jun 2004 22:39:58 -0500 (CDT)
Received: from yggdrasil.localdomain ([192.168.0.2])
	by sasami.localdomain with esmtp (Exim 4.34)
	id 1BZiKC-00030I-0B
	for selinux@tycho.nsa.gov; Sun, 13 Jun 2004 22:39:56 -0500
Received: from adric by yggdrasil.localdomain with local (Exim 4.34)
	id 1BZiKB-0003k5-VH
	for selinux@tycho.nsa.gov; Sun, 13 Jun 2004 22:39:55 -0500
Date: Sun, 13 Jun 2004 22:39:55 -0500
From: Greg Norris <haphazard@kc.rr.com>
To: selinux@tycho.nsa.gov
Subject: Re: SELinux on Debian (Sid)
Message-ID: <20040614033955.GA14338@yggdrasil.localdomain>
References: <20040609144404.GJ5477@philips.com> <200406121819.57709.russell@coker.com.au> <20040612143714.GA28996@yggdrasil.localdomain> <200406131029.35825.russell@coker.com.au> <20040613012852.GA4210@yggdrasil.localdomain> <20040613075427.GZ2861@lkcl.net> <20040613154033.GA10171@yggdrasil.localdomain> <20040613160310.GA10763@yggdrasil.localdomain> <20040613232622.GA13617@yggdrasil.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040613232622.GA13617@yggdrasil.localdomain>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Jun 13, 2004 at 06:26:22PM -0500, Greg Norris wrote:
> I case anyone else encounters this issue, I've submitted a bugreport
> to the Debian bug-tracking system.  You can view it at
> "http://bugs.debian.org/254219".

Ok, I've finally managed to get the package to install... it turns out
that I needed to include chkpwd.te and inetd.se in my policy
selections.  I'm not actually using the corresponding software for
either, but they apparently include some definitions which are needed
by other policies.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
