Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i92GLCrT008984
	for <selinux@tycho.nsa.gov>; Sat, 2 Oct 2004 12:21:12 -0400 (EDT)
Received: from legolas.drinsama.de (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i92GLAlM002723
	for <selinux@tycho.nsa.gov>; Sat, 2 Oct 2004 16:21:11 GMT
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id 91505C4C088
	for <selinux@tycho.nsa.gov>; Sat,  2 Oct 2004 18:21:06 +0200 (CEST)
Received: from legolas.drinsama.de ([127.0.0.1])
	by localhost (legolas [127.0.0.1]) (amavisd-new, port 10024)
	with SMTP id 11331-03 for <selinux@tycho.nsa.gov>;
	Sat, 2 Oct 2004 18:21:06 +0200 (CEST)
Received: from wintermute.xmldesign.de (pD9E4F72F.dip.t-dialin.net [217.228.247.47])
	by legolas.drinsama.de (Postfix) with ESMTP id 7A21FC4C084
	for <selinux@tycho.nsa.gov>; Sat,  2 Oct 2004 18:21:05 +0200 (CEST)
Received: from wintermute.xmldesign.de (wintermute.xmldesign.de [127.0.0.1])
	by wintermute.xmldesign.de (Postfix) with ESMTP id EEFEE234095
	for <selinux@tycho.nsa.gov>; Sat,  2 Oct 2004 18:21:02 +0200 (CEST)
Subject: RE: bash_profile: Permission denied
From: Erich Schubert <erich@debian.org>
To: selinux@tycho.nsa.gov
In-Reply-To: <BJENLMGHDPAAAGKKPOFOAEFACFAA.richard.simpson@wgint.com>
References: <BJENLMGHDPAAAGKKPOFOAEFACFAA.richard.simpson@wgint.com>
Content-Type: text/plain
Date: Sat, 02 Oct 2004 18:21:02 +0200
Message-Id: <1096734062.4672.7.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

> You can give staff_r enhanced privileges, including reading root files, by
> setting appropriate tunables in tunable.te. You can see what the tunables do
> in staff.te.

Thanks to all who replied.
I had thought that maybe there is a solution for only allowing staff_r
read access to certain files such as the shell profile files. But i'm
happy with the current solution.

Greetings,
Erich Schubert
-- 
   erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
          There are only 10 types of people in the world:           //\
          Those who understand binary and those who don't           V_/_
              Denken ist oft schwerer, als man denkt.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
