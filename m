Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h98JoLWt021940
	for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2003 15:50:21 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h98JoJ6g013179
	for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2003 19:50:19 GMT
Received: from Woody.fw.matav.hu (matav-1.matav.hu [145.236.241.98])
        by jazzband.ncsc.mil  with ESMTP id h98JoIdq013169 for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2003 19:50:19 GMT
Date: Wed, 8 Oct 2003 19:41:34 +0000
To: "Artur M. Piwko" <pipen@pu.kielce.pl>
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: [selinux] SElinux and chroot
Message-ID: <20031008194133.GC8789@bunuel.tii.matav.hu>
References: <20031008091650.GA19270@sabat.tu.kielce.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
In-Reply-To: <20031008091650.GA19270@sabat.tu.kielce.pl>
From: mag@bunuel.tii.matav.hu (Magosányi Árpád)
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi!

It is a bit hard to parse your question, so I try to give
a hard to parse answer;)
There is no direct relationship between chroot and SELinux.

It is another question that chrooted environments have some other
benefits than selinux. Those benefits today are mostly to do with ease
of system administration, but you can also implement a very coarsely grained
MACish policy based on chroot as a domain separation method. See bsd jail
for an example, and some papers on relationship on lattice-based policies,
Mr. Clark and Mr. Wilson for details:)

My favourite mania nowadays is to build a system with multiple chrooted
sandboxen and SELinux, with a dip of Bell&LaPadula. The very thinkpad
I write this email on is built this way but with rsbac.

A levelezõm azt hiszi, hogy Artur M. Piwko a következõeket írta:
> Do I have to install selinux base into chrooted environment in addition
> to the system part out of it?

-- 
GNU GPL: csak tiszta forrásból


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
