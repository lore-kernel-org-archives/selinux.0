Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i438pPRb003698
	for <selinux@tycho.nsa.gov>; Mon, 3 May 2004 04:51:26 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i438pOYW016386
	for <selinux@tycho.nsa.gov>; Mon, 3 May 2004 08:51:24 GMT
Received: from dl.oss.co.yu (mps.rns-nis.co.yu [194.247.213.6])
        by jazzband.ncsc.mil  with ESMTP id i438pIBf016368 for <selinux@tycho.nsa.gov>; Mon, 3 May 2004 08:51:23 GMT
Date: Mon, 3 May 2004 10:51:42 +0200
From: "Milan P. Stanic" <mps@rns-nis.co.yu>
To: selinux@tycho.nsa.gov
Subject: Re: Tinydns Policy Files
Message-ID: <20040503085142.GB3143@rns-nis.co.yu>
References: <1083518249.543.9.camel@ares> <200405030919.34619.russell@coker.com.au> <1083547353.543.18.camel@ares>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1083547353.543.18.camel@ares>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, May 02, 2004 at 09:22:33PM -0400, Matthew J. Fanto wrote:
> On Sun, 2004-05-02 at 19:19, Russell Coker wrote:
> > Is it possible to configure this and the other DJB tools in a sane manner?  
> > For starters entry point executables should not be under /etc.

What do you mean by "entry point executables"?

> This is djb's recomended way of doing it. It's also the default for
> Debians packages. It might require a decent amount of work to do it
> differently. 

Binaries are in /package/admin/{package-name}. Only run scripts and
config files are under /etc

[ I may be wrong, but I'm using DJB tools a long ago under LIDS, and
  I always install them that way ]


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
