Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8J72Zg2001437
	for <selinux@tycho.nsa.gov>; Tue, 19 Sep 2006 03:02:35 -0400
Received: from mx.meyering.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8J725g8028059
	for <selinux@tycho.nsa.gov>; Tue, 19 Sep 2006 07:02:06 GMT
From: Jim Meyering <jim@meyering.net>
To: Chris PeBenito <pebenito@gentoo.org>
Cc: James Antill <jantill@redhat.com>,
        SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: coreutils status
In-Reply-To: <1158623120.31135.2.camel@gorn.pebenito.net> (Chris PeBenito's
	message of "Mon, 18 Sep 2006 19:45:20 -0400")
References: <1158623120.31135.2.camel@gorn.pebenito.net>
Date: Tue, 19 Sep 2006 09:02:02 +0200
Message-ID: <87venkibkl.fsf@rho.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Chris PeBenito <pebenito@gentoo.org> wrote:
> What is the status of the selinux patches for coreutils going upstream?

The code changes are mostly done, but I need more tests
and some documentation.

The changes are disruptive enough that they won't go in
until after the upcoming stable release.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
