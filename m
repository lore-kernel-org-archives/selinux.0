Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i91MborT005549
	for <selinux@tycho.nsa.gov>; Fri, 1 Oct 2004 18:37:51 -0400 (EDT)
Received: from legolas.drinsama.de (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i91MbmEZ017422
	for <selinux@tycho.nsa.gov>; Fri, 1 Oct 2004 22:37:49 GMT
Subject: Re: bash_profile: Permission denied
From: Erich Schubert <erich@debian.org>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: "James R. Marcus" <jmarcus@mvalent.net>, selinux@tycho.nsa.gov
In-Reply-To: <41530866.4020306@redhat.com>
References: <E6E16A6D4277CD459BBDE6713766033CB71F3E@exchange.mvalent.local>
	 <41530866.4020306@redhat.com>
Content-Type: text/plain
Date: Sat, 02 Oct 2004 00:37:40 +0200
Message-Id: <1096670260.4161.18.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

> The problem is probably that you are logging as staff_r and the 
> directory is sysadm_r.

What is the preferred way for having login being done as staff_r, but
still having some profile files for root/staff_r?
(staff_r doesn't necessarily need to write them, but i'd like him to be
able to read them. So i can at least have a macro for "newrole -r
sysadm_r" or a bash history entry...)

Greetings,
Erich Schubert
-- 
   erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
          There are only 10 types of people in the world:           //\
          Those who understand binary and those who don't           V_/_
          Liebe ist eine schwere Geisteskrankheit (Platon)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
