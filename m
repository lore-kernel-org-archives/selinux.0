Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i52BI9rT003350
	for <selinux@tycho.nsa.gov>; Wed, 2 Jun 2004 07:18:09 -0400 (EDT)
Received: from mail.enyo.de (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i52JCdbn014440
	for <selinux@tycho.nsa.gov>; Wed, 2 Jun 2004 15:12:40 -0400 (EDT)
To: debian-devel@lists.debian.org
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: Debian / SE/Linux - libselinux1 needs to be set priority
 "important" or "required"
References: <20040530092059.GP2851@lkcl.net>
From: Florian Weimer <fw@deneb.enyo.de>
Date: Sun, 30 May 2004 13:06:18 +0200
In-Reply-To: <20040530092059.GP2851@lkcl.net> (Luke Kenneth Casson
 Leighton's message of "Sun, 30 May 2004 09:20:59 +0000")
Message-ID: <874qpy18et.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

* Luke Kenneth Casson Leighton:

> a number of SE/Linux-based upstream patches to packages (coreutils,
> logrotate, sysvinit), are being held up because libselinux1 is at
> present incorrectly set to priority "optional".

Isn't full SELinux integration a bit risky in the light of Secure
Computing's patents?

How do other distributors deal with this issue?  Do they ignore it
entirely?

-- 
Current mail filters: many dial-up/DSL/cable modem hosts, and the
following domains: bigpond.com, di-ve.com, fuorissimo.com, hotmail.com,
jumpy.it, libero.it, netscape.net, postino.it, simplesnet.pt, spymac.com,
tiscali.co.uk, tiscali.cz, tiscali.it, voila.fr, yahoo.com.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
