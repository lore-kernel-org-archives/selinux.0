Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i84BZZrT013670
	for <selinux@tycho.nsa.gov>; Sat, 4 Sep 2004 07:35:35 -0400 (EDT)
Received: from legolas.drinsama.de (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i84BZYp9013388
	for <selinux@tycho.nsa.gov>; Sat, 4 Sep 2004 11:35:34 GMT
Subject: Re: Guide to replace root as sysadm for machine
From: Erich Schubert <erich@debian.org>
To: Stephen torri <storri@torri.org>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1094265263.8562.24.camel@base.torri.org>
References: <1094265263.8562.24.camel@base.torri.org>
Content-Type: text/plain
Date: Sat, 04 Sep 2004 13:35:30 +0200
Message-Id: <1094297730.6427.2.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
try using things like fakeroot. Just like Debian does for building
packages: you build the package as user but using fakeroot (so the
software thinks it is root, and chmod calls are logged. and since the
package is being tarred while still in the fakeroot env the permissions
are stored as set in the fakeroot)
Then you obtain real "root" access to install it in on you system.
Avoids lots of trouble this approach.

Greetings,
Erich Schubert
-- 
    erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C   (o_
   There was never a good war or a bad peace. - Benjamin Franklin   //\
    Der Anfang aller Erkenntnis ist das Staunen. --- Aristoteles    V_/_


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
