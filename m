Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i85HcXrT018255
	for <selinux@tycho.nsa.gov>; Sun, 5 Sep 2004 13:38:33 -0400 (EDT)
Received: from legolas.drinsama.de (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i85HcWt0002643
	for <selinux@tycho.nsa.gov>; Sun, 5 Sep 2004 17:38:32 GMT
Subject: Re: Additional rule files
From: Erich Schubert <erich@debian.org>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: russell@coker.com.au, selinux@tycho.nsa.gov
In-Reply-To: <20040905173452.GH4084@lkcl.net>
References: <1094260356.29689.44.camel@wintermute.xmldesign.de>
	 <200409052031.05813.russell@coker.com.au>
	 <1094392498.22073.19.camel@wintermute.xmldesign.de>
	 <20040905173452.GH4084@lkcl.net>
Content-Type: text/plain; charset=ISO-8859-15
Date: Sun, 05 Sep 2004 19:38:27 +0200
Message-Id: <1094405907.22073.34.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
>  apache is modular: i assume that at some point the apache policy
>  would reflect this modularity [with tunables/apache_modules.te?]

With linkable modules, yes. Apart from apache2 modules having like one
security issue a month currently (ok, maybe a bit exxagerated) the
apache process still is one big process. Having one role/domain.
(Using fastcgi and such you can of course separate this a bit into
different roles, granted)

With SELinux it is advisable to split different parts into different
applications - such as the unix_verify application for pam.

Greetings,
Erich Schubert
-- 
     erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C     (o_
 A man doesn't know what he knows until he knows what he doesn't know. //\
  Man kann sich auch in Gesellschaft anderer einsam fühlen. Weizsäcker V_/_



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
