Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6S9qErT008618
	for <selinux@tycho.nsa.gov>; Wed, 28 Jul 2004 05:52:14 -0400 (EDT)
Received: from sq.rns-nis.co.yu (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6S9pdAN028795
	for <selinux@tycho.nsa.gov>; Wed, 28 Jul 2004 09:51:44 GMT
Received: from localhost (localhost [127.0.0.1])
	by sq.rns-nis.co.yu (Postfix) with ESMTP id 106966BBEB
	for <selinux@tycho.nsa.gov>; Wed, 28 Jul 2004 11:48:54 +0200 (CEST)
Received: from sq.rns-nis.co.yu ([127.0.0.1])
	by localhost (sq [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 31249-06 for <selinux@tycho.nsa.gov>;
	Wed, 28 Jul 2004 11:48:49 +0200 (CEST)
Received: from dl.oss.co.yu (mps.rns-nis.co.yu [194.247.213.6])
	by sq.rns-nis.co.yu (Postfix) with ESMTP id A9A166BA59
	for <selinux@tycho.nsa.gov>; Wed, 28 Jul 2004 11:48:48 +0200 (CEST)
Date: Wed, 28 Jul 2004 11:46:31 +0200
From: "Milan P. Stanic" <mps@rns-nis.co.yu>
To: selinux@tycho.nsa.gov
Subject: Re: New or Old SELinux
Message-ID: <20040728094631.GA2977@rns-nis.co.yu>
References: <1090955044.1886.49.camel@allhosts>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1090955044.1886.49.camel@allhosts>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Jul 27, 2004 at 04:04:05PM -0300, Martin Sarsale wrote:
> I would like to stay in stable but I couldn't find any of the New
> SELinux (coreutils, procps, etc) enabled packages for deb stable, so I
> guess I'll have to stick with the old SELinux (on kernels 2.4.x).

Which kernel version you have on stable, 2.4 or 2.6?

I have backport (it is far from perfect, but it works) for woody with
2.6 kernels at http://www.rns-nis.co.yu/~mps/
It is few months old, though.

Backporting SE Linux utilities and libraries isn't hard at all,
thanks to the excellent work of the Debian maintainer.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
