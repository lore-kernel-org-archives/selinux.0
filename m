Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1IBPTRb021071
	for <selinux@tycho.nsa.gov>; Wed, 18 Feb 2004 06:25:29 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i1IBNslK027541
	for <selinux@tycho.nsa.gov>; Wed, 18 Feb 2004 11:23:54 GMT
Received: from mail.gmx.net (imap.gmx.net [213.165.64.20])
	by jazzswing.ncsc.mil  with SMTP id i1IBNrOX027538
	for <selinux@tycho.nsa.gov>; Wed, 18 Feb 2004 11:23:53 GMT
From: Carsten Grohmann <carstengrohmann@gmx.de>
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Subject: Re: Anybody working on SuSE 9.0 support?
Date: Wed, 18 Feb 2004 12:16:04 +0100
References: <20040217202654.GB605@rom.cip.informatik.uni-muenchen.de>
In-Reply-To: <20040217202654.GB605@rom.cip.informatik.uni-muenchen.de>
Cc: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200402181216.04318.carstengrohmann@gmx.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Dienstag, 17. Februar 2004 21:26, Thomas Bleher wrote:
> Hi all!
>
> Is there anyone currently working on SuSE 9.0 support for
> SELinux? I will begin to work on this shortly but would like to
> avoid duplicate work if possible.
> I am aware that Carsten Grohmann and Paul Dwerryhouse have made
> RPMs for SuSE in the past and will look at these.

At present I don't working on SELinux packages for SuSE 9.0

> I'd be very interested in hearing about any gotchas, things to
> watch out for when packaging SELinux userland as I don't have
> very much experience with RPM or the changes made by SuSE to the
> respective packages.

Building SuSE rpms with SELinux support is an expensive work. You 
can use some fedora srpms like libselinux, policy and 
policycoreutils direct. For other packages you can add the patch in 
the spec file. And it could by that you  have to rewrite the patch 
(add the pieces of the source code manually) on some less packages.
It's a lot of work for all packages.

Thru this I use Fedora if I need SELinux support.

Greetings

Carsten



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
