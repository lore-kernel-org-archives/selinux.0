Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i83JlYrT010379
	for <selinux@tycho.nsa.gov>; Fri, 3 Sep 2004 15:47:34 -0400 (EDT)
Received: from legolas.drinsama.de (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i83JlWUQ000333
	for <selinux@tycho.nsa.gov>; Fri, 3 Sep 2004 19:47:33 GMT
Subject: Re: [idea] file contexts "alternate" keyword
From: Erich Schubert <erich@debian.org>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20040903165723.GA31857@lkcl.net>
References: <20040903165723.GA31857@lkcl.net>
Content-Type: text/plain
Date: Fri, 03 Sep 2004 21:47:21 +0200
Message-Id: <1094240841.29689.6.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

> # this line ONLY gets activated if the mozilla helper program specifies
> # the keyword to use it.
> HOME_DIR/downloads/.+      ROLE_home_t mozillahelperdownloadpasswordwasvalid

How do you find out later on if this was the case (for example on
relabel?)

Also i don't see your point at all. What can you do you cannot do using
an appropriate type for the "download helper" and rules?

(As i understood it you want the files downloaded with mozilla being
labeled differently?)

Greetings,
Erich Schubert
-- 
     erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C     (o_
 A man doesn't know what he knows until he knows what he doesn't know. //\
              Es lohnt sich nicht, die Augen aufzumachen,              V_/_
                     wenn der Kopf im Sand steckt.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
