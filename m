Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i98DdGrT021488
	for <selinux@tycho.nsa.gov>; Fri, 8 Oct 2004 09:39:16 -0400 (EDT)
Received: from legolas.drinsama.de (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i98Dc6Bk028018
	for <selinux@tycho.nsa.gov>; Fri, 8 Oct 2004 13:38:07 GMT
Subject: Re: .fonts-cache being created as user_home_dir_t
From: Erich Schubert <erich@debian.org>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Russell Coker <russell@coker.com.au>, SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20041008100458.GC5089@lkcl.net>
References: <20041005091026.GB25251@lkcl.net>
	 <200410071250.14304.russell@coker.com.au>  <20041008100458.GC5089@lkcl.net>
Content-Type: text/plain
Date: Fri, 08 Oct 2004 15:38:56 +0200
Message-Id: <1097242736.14591.5.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

>  i couldn't entirely say: let me see if i can find out...
>  a search through all kdebase *.cpp,h only shows up
>  something in kcontrol kio handler.  so that didn't work.

.fonts-cache is probably created by the fontconfig libraries, so any app
that does link this library could be "causing" this.
I guess the cleanes SELinux approach would be to split this out of the
fontconfig libraries into an own application... ;-)

Greetings,
Erich Schubert
-- 
   erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
     Which is worse: ignorance or apathy? Who knows? Who cares?     //\
            Es lohnt sich nicht, die Augen aufzumachen,             V_/_
                   wenn der Kopf im Sand steckt.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
