Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5DFeirT013954
	for <selinux@tycho.nsa.gov>; Sun, 13 Jun 2004 11:40:45 -0400 (EDT)
Received: from ms-smtp-01.rdc-kc.rr.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5DFefkj026189
	for <selinux@tycho.nsa.gov>; Sun, 13 Jun 2004 11:40:41 -0400 (EDT)
Received: from sasami.localdomain (CPE-24-31-241-155.kc.rr.com [24.31.241.155])
	by ms-smtp-01.rdc-kc.rr.com (8.12.10/8.12.7) with ESMTP id i5DFecBm000302
	for <selinux@tycho.nsa.gov>; Sun, 13 Jun 2004 10:40:40 -0500 (CDT)
Received: from yggdrasil.localdomain ([192.168.0.2])
	by sasami.localdomain with esmtp (Exim 4.34)
	id 1BZX61-0001RF-4r
	for selinux@tycho.nsa.gov; Sun, 13 Jun 2004 10:40:33 -0500
Received: from adric by yggdrasil.localdomain with local (Exim 4.34)
	id 1BZX61-0002mP-40
	for selinux@tycho.nsa.gov; Sun, 13 Jun 2004 10:40:33 -0500
Date: Sun, 13 Jun 2004 10:40:33 -0500
From: Greg Norris <haphazard@kc.rr.com>
To: selinux@tycho.nsa.gov
Subject: Re: SELinux on Debian (Sid)
Message-ID: <20040613154033.GA10171@yggdrasil.localdomain>
References: <20040609144404.GJ5477@philips.com> <200406121819.57709.russell@coker.com.au> <20040612143714.GA28996@yggdrasil.localdomain> <200406131029.35825.russell@coker.com.au> <20040613012852.GA4210@yggdrasil.localdomain> <20040613075427.GZ2861@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040613075427.GZ2861@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Jun 13, 2004 at 07:54:27AM +0000, Luke Kenneth Casson Leighton wrote:
> if i was you i would, as i said, delete the original install and
> use russell's 1.12-3 policy.

That's the exact version I'm using already... this was a new
installation, and 1.12-3 had already hit the archive by the time I
first attempted it.

I did try purging and re-installing last night, but that didn't seem to
change anything.  I'll go ahead and give it another shot, in case I
overlooked some cleanup.  Do you know if anything other than
/etc/selinux and /usr/share/selinux/policy needs to be removed
manually?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
