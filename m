Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6LNXCrT001178
	for <selinux@tycho.nsa.gov>; Wed, 21 Jul 2004 19:33:12 -0400 (EDT)
Received: from legolas.drinsama.de (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6LNX9vO028898
	for <selinux@tycho.nsa.gov>; Wed, 21 Jul 2004 23:33:10 GMT
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id 79826C4C090
	for <selinux@tycho.nsa.gov>; Thu, 22 Jul 2004 01:33:02 +0200 (CEST)
Received: from legolas.drinsama.de ([127.0.0.1])
	by localhost (legolas [127.0.0.1]) (amavisd-new, port 10024)
	with SMTP id 07912-03 for <selinux@tycho.nsa.gov>;
	Thu, 22 Jul 2004 01:33:01 +0200 (CEST)
Received: from wintermute.xmldesign.de (pD958F795.dip.t-dialin.net [217.88.247.149])
	by legolas.drinsama.de (Postfix) with ESMTP id 49575C4C08E
	for <selinux@tycho.nsa.gov>; Thu, 22 Jul 2004 01:33:01 +0200 (CEST)
Date: Thu, 22 Jul 2004 01:33:12 +0200
From: Erich Schubert <erich@debian.org>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: Skype (for Linux)
Message-ID: <20040721233312.GD9916@wintermute.xmldesign.de>
References: <20040721170652.GC12344@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20040721170652.GC12344@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> has anyone written an selinux policy for skype at all?

I for myself wouldn't touch such a proprietary closed-protocol
application. Especially not if it is hyped that way ("by the makers of
kazaa" - there i nothing to gain by using filesharing technologies
unless you want to broadcast your voice)
Being a firewall-buster also is not a good but a bad thing.
Firewalls were installed to prevent access. Applications busting through
firewalls are written by authors *fighting* against their network
admins, not working together with them.

I prefer using standard protocols such has H.323 and SIP.
The biggest problem with these protocols is that the windows clients
suck (i.e. netmeeting not supporting gatekeepers properly), but i don't
care about that.

Gruﬂ,
Erich Schubert
-- 
     erich@(mucl.de|debian.org)      --      GPG Key ID: 4B3A135C    (o_
   To understand recursion you first need to understand recursion.   //\
        Es gibt kein idiotensicheres Programm, weil Idioten so       V_/_
                      genial sind. -- E. Murphy


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
