Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7HMAYrT016826
	for <selinux@tycho.nsa.gov>; Tue, 17 Aug 2004 18:10:34 -0400 (EDT)
Received: from legolas.drinsama.de (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7HMAWKV003089
	for <selinux@tycho.nsa.gov>; Tue, 17 Aug 2004 22:10:32 GMT
Subject: Re: mozilla 0.9.3-2 crashing with tunables read and write homedir
	OFF
From: Erich Schubert <erich@debian.org>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20040817193823.GU18321@lkcl.net>
References: <20040817193823.GU18321@lkcl.net>
Content-Type: text/plain; charset=ISO-8859-15
Date: Wed, 18 Aug 2004 00:10:20 +0200
Message-Id: <1092780620.6531.3.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

> just in case anyone's curious about using mozilla with no read or write
> access to user-home: at present (policy 1.12-3 or 4 and mozilla 0.9.2-3)
> it don't work.
> 
> debian bugreport raised.

Waste of time. I guess that any mozilla developer will tell you they do
need write access to their profile directory.
Furthermore using an ancient version of mozilla doesn't help either.
Even Debian "woody" (aka "stable") has mozilla 1.0.0 because of security
issues... If you want to have a secure system you should at least
upgrade to the most recent security update.

And don't expect applications to behave differently than what they were designed for.
Mozilla was designed to have a writeable profile directory for its cache, configuration data etc.
I bet the developers will just drop your bug report and tell you to write your own browser using the gecko engine...

Greetings,
Erich Schubert
-- 
    erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
           There are only 10 types of people in the world:           //\
           Those who understand binary and those who don't           V_/_
  Gute Freunde sind wie Sterne in der Nacht. Auch wenn sie manchmal
       hinter den Wolken sind, weißt Du, sie sind für dich da.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
