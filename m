Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i96BeorT003506
	for <selinux@tycho.nsa.gov>; Wed, 6 Oct 2004 07:40:50 -0400 (EDT)
Received: from legolas.drinsama.de (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i96BemKB005311
	for <selinux@tycho.nsa.gov>; Wed, 6 Oct 2004 11:40:49 GMT
Subject: Re: policy patches
From: Erich Schubert <erich@debian.org>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: James Carter <jwcart2@epoch.ncsc.mil>, Daniel J Walsh <dwalsh@redhat.com>,
   Russell Coker <russell@coker.com.au>, SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <20041006101046.GA5790@lkcl.net>
References: <200409292354.15227.russell@coker.com.au>
	 <200409300620.41527.russell@coker.com.au>
	 <1096648965.13366.35.camel@moss-lions.epoch.ncsc.mil>
	 <200410020344.04225.russell@coker.com.au>
	 <1096920735.3235.17.camel@moss-lions.epoch.ncsc.mil>
	 <4162C0C6.9090704@redhat.com>
	 <1097003202.30738.35.camel@moss-lions.epoch.ncsc.mil>
	 <20041006101046.GA5790@lkcl.net>
Content-Type: text/plain; charset=ISO-8859-15
Date: Wed, 06 Oct 2004 13:40:02 +0200
Message-Id: <1097062802.4167.9.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

> james, i didn't see a reply to your question about whether
> it was mozilla that defined the "~/My Downloads" directory:
> did i miss something?

> ... but does it _have_ to be in ~/My windows style downloads???

In the default configuration Epiphany saves to ~/Desktop/Downloads i
think. IMHO Distributions should configure Mozilla to use this
directory, too, by default.
When i first saw this i was a bit annoyed, that it didn't ask me where
to save the downloads. But when i had my file managers open, i found it
even easier to just move the downloaded files to their destinations than
having the file selector pop up.

Greetings,
Erich Schubert
-- 
   erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
       The best things in life are free: Friendship and Love.       //\
               Für jedes Problem gibt es eine Lösung,               V_/_
                 die einfach, klar und falsch ist.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
