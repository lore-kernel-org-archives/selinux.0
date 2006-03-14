Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k2EK5uHY009310
	for <selinux@tycho.nsa.gov>; Tue, 14 Mar 2006 15:06:02 -0500
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k2EK3nDI009602
	for <selinux@tycho.nsa.gov>; Tue, 14 Mar 2006 20:03:51 GMT
Subject: Re: policy support for SSP
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Petre Rodan <kaiowas@gentoo.org>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <20060312211907.GA6359@peter.sunspire.org>
References: <20060312211907.GA6359@peter.sunspire.org>
Content-Type: text/plain
Date: Tue, 14 Mar 2006 14:09:59 -0500
Message-Id: <1142363399.20739.2.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2006-03-12 at 23:19 +0200, Petre Rodan wrote:
> the Hardened Gentoo [1] and FC5? [2] projects use stack smash protection [3] in their systems.
> this means that every binary compiled with a hardened toolchain will need access to /dev/urandom.
> 
> here is a small patch that has a tunable for allowing any domain access to urandom_device_t.
> since now this was a gentoo-only tunable, but since others might need it, a distro_gentoo should not be wrapped around it.

Merged.  I moved the rule to the domain module.  I also changed the
tunable name to global_ssp, to make it more clear that it is applied to
all domains.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
