Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8RI3rsJ006460
	for <selinux@tycho.nsa.gov>; Sat, 27 Sep 2003 14:03:53 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8RI27Zt006304
	for <selinux@tycho.nsa.gov>; Sat, 27 Sep 2003 18:02:07 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h8RI27M3006301
	for <selinux@tycho.nsa.gov>; Sat, 27 Sep 2003 18:02:07 GMT
Subject: Re: selinux and 64 bit hardware
From: Howard Holm <hdholm@epoch.ncsc.mil>
To: Joerg Hoh <joerg@devone.org>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20030927173909.GB3936@hydra.joerghoh.de>
References: <20030927173909.GB3936@hydra.joerghoh.de>
Content-Type: text/plain
Message-Id: <1064685830.16303.35.camel@moss-huskies>
Mime-Version: 1.0
Date: 27 Sep 2003 14:03:50 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2003-09-27 at 13:39, Joerg Hoh wrote:
> I have an alpha machine (64bit) right next to me running linux 2.6.0test5. 
> I'd like to do some tests with selinux on this machine, but selinux doesn't 
> work correctly. 
> 
> I've done some research at the code and detected that, some parts are _not_
> portable (conversions from pointer to int, which only works on 32 bit
> architectures, and so on).
> 
> Is this intentional? Are some parts based on assumptions, which are only
> true on 32bit architectures? Are patches welcome to achieve a better 64 bit
> compatibility?

SELinux was developed on 32 bit machines and the development team here
uses ia32 machines.  I don't believe anything was done that
intentionally fails on 64 bit architectures, but I'm not surprised
either.  We welcome patches for other architectures, but merging them
may not be a priority for anyone here.  (Which is to say if they're
simple patches we'll probably take them; the more complex they get the
less likely it is that we'll have anyone here with time to really look
closely at them.)

Small patches can be sent to the list.  Large patches should be posted
to a web site and/or sent directly to selinux-team@epoch.ncsc.mil.  I
know a significant percentage of people on the selinux list have small
mailboxes or slow connections and wouldn't appreciate large patches sent
to everyone.

-- 
Howard Holm <hdholm@epoch.ncsc.mil>
Office of Defensive Computing Research
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
