Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i725pnrT010104
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2004 01:51:49 -0400 (EDT)
Received: from legolas.drinsama.de (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i725pGXV006499
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2004 05:51:16 GMT
Subject: Re: hotplug 0.030 not setting selinux permissions on /dev/tty*
From: Erich Schubert <erich@debian.org>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: linux-hotplug-devel@lists.sourceforge.net,
   SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20040801164440.GD15949@lkcl.net>
References: <20040801160019.GC15949@lkcl.net>
	 <20040801164440.GD15949@lkcl.net>
Content-Type: text/plain; charset=UTF-8
Date: Sun, 01 Aug 2004 21:32:39 +0200
Message-Id: <1091388759.7861.9.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

> i suppose i could move the entire /usr/share/selinux/current/* into
> /etc/selinux!!!

putting configuration files into /etc is a sane choice anyway...

Greetings,
Erich Schubert
-- 
   erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
          There are only 10 types of people in the world:           //\
          Those who understand binary and those who don't           V_/_
    Zwei Freunde müssen sich im Herzen ähneln, in allem anderen
       können sie grundverschieden sein. --- Sully Prudhomme



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
