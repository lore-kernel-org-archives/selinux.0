Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6UDFKrT026955
	for <selinux@tycho.nsa.gov>; Fri, 30 Jul 2004 09:15:20 -0400 (EDT)
Received: from legolas.drinsama.de (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6UDEmTf022178
	for <selinux@tycho.nsa.gov>; Fri, 30 Jul 2004 13:14:49 GMT
Date: Fri, 30 Jul 2004 15:15:10 +0200
From: Erich Schubert <erich@debian.org>
To: Wolfgang Pfeiffer <roto@gmx.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: Building SE-ssh. Result: fakeroot: Permission denied
Message-ID: <20040730131510.GB7025@legolas.drinsama.de>
References: <1091187766.18595.153.camel@debby> <1091188128.18595.158.camel@debby>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1091188128.18595.158.camel@debby>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

> > /usr/bin/fakeroot: line 146: debian/rules: Permission denied

Try "chmod +x debian/rules"

This file is usually created by a patch, which does not contain file
attributes - therefore you need to make it executeable.

Greetings,
Erich
-- 
    erich@(mucl.de|debian.org)      --      GPG Key ID: 4B3A135C    (o_
     Go away or i'll replace you with a very small shell script.    //\
               Für jedes Problem gibt es eine Lösung,               V_/_
                  die einfach, klar und falsch ist.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
