Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i85IdNrT018392
	for <selinux@tycho.nsa.gov>; Sun, 5 Sep 2004 14:39:23 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i85IdMt0003202
	for <selinux@tycho.nsa.gov>; Sun, 5 Sep 2004 18:39:23 GMT
Date: Sun, 5 Sep 2004 19:50:34 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Erich Schubert <erich@debian.org>
Cc: russell@coker.com.au, selinux@tycho.nsa.gov
Subject: Re: Additional rule files
Message-ID: <20040905185034.GI4084@lkcl.net>
References: <1094260356.29689.44.camel@wintermute.xmldesign.de> <200409052031.05813.russell@coker.com.au> <1094392498.22073.19.camel@wintermute.xmldesign.de> <20040905173452.GH4084@lkcl.net> <1094405907.22073.34.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1094405907.22073.34.camel@wintermute.xmldesign.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Sep 05, 2004 at 07:38:27PM +0200, Erich Schubert wrote:
> Hi,
> >  apache is modular: i assume that at some point the apache policy
> >  would reflect this modularity [with tunables/apache_modules.te?]
> 
> With linkable modules, yes. Apart from apache2 modules having like one
> security issue a month currently (ok, maybe a bit exxagerated) the
> apache process still is one big process. Having one role/domain.

 i was thinking more along the lines of having functionality
 in the single apache domain being optional.

 then, one of the simpler web server applications could consider
 using the apache policy - starting with all the options switched off.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
