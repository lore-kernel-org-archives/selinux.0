Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i43AiGRb004021
	for <selinux@tycho.nsa.gov>; Mon, 3 May 2004 06:44:16 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i43AiFYW019169
	for <selinux@tycho.nsa.gov>; Mon, 3 May 2004 10:44:15 GMT
Received: from smtp.sws.net.au ([61.95.69.6])
        by jazzband.ncsc.mil  with ESMTP id i43AiCBf019111 for <selinux@tycho.nsa.gov>; Mon, 3 May 2004 10:44:14 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Milan P. Stanic" <mps@rns-nis.co.yu>
Subject: Re: Tinydns Policy Files
Date: Mon, 3 May 2004 20:42:48 +1000
Cc: selinux@tycho.nsa.gov
References: <1083518249.543.9.camel@ares> <1083547353.543.18.camel@ares> <20040503085142.GB3143@rns-nis.co.yu>
In-Reply-To: <20040503085142.GB3143@rns-nis.co.yu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200405032042.48931.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 3 May 2004 18:51, "Milan P. Stanic" <mps@rns-nis.co.yu> wrote:
> On Sun, May 02, 2004 at 09:22:33PM -0400, Matthew J. Fanto wrote:
> > On Sun, 2004-05-02 at 19:19, Russell Coker wrote:
> > > Is it possible to configure this and the other DJB tools in a sane
> > > manner? For starters entry point executables should not be under /etc.
>
> What do you mean by "entry point executables"?

something_exec_t, a type that's used as the second parameter in a 
domain_auto_trans() rule.

Having them for cron jobs under /etc/cron.something is bad enough.

> > This is djb's recomended way of doing it. It's also the default for
> > Debians packages. It might require a decent amount of work to do it
> > differently.
>
> Binaries are in /package/admin/{package-name}. Only run scripts and
> config files are under /etc

Breaking with all Unix conventions.  It's supposed to be /sbin and /usr/sbin 
for daemons.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
