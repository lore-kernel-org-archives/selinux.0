Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBGKjLRb027680
	for <selinux@tycho.nsa.gov>; Tue, 16 Dec 2003 15:45:21 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hBGKjKpn001941
	for <selinux@tycho.nsa.gov>; Tue, 16 Dec 2003 20:45:20 GMT
Received: from smtp-bedford.mitre.org (smtp-bedford-x.mitre.org [192.160.51.76])
        by jazzband.ncsc.mil  with ESMTP id hBGKjKab001938 for <selinux@tycho.nsa.gov>; Tue, 16 Dec 2003 20:45:20 GMT
Received: from smtp-bedford.mitre.org (localhost.localdomain [127.0.0.1])
	by smtp-bedford.mitre.org (8.11.6/8.11.6) with ESMTP id hBGKjJU11034
	for <selinux@tycho.nsa.gov>; Tue, 16 Dec 2003 15:45:19 -0500
To: Carsten Grohmann <carstengrohmann@gmx.de>
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: slat makefiles
References: <200312161952.29595.carstengrohmann@gmx.de>
From: ramsdell@mitre.org (John D. Ramsdell)
Date: 16 Dec 2003 15:45:19 -0500
In-Reply-To: <200312161952.29595.carstengrohmann@gmx.de>
Message-ID: <ogthe007aqo.fsf@divan.mitre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Carsten Grohmann <carstengrohmann@gmx.de> writes:

> today I've problems to build a slat rpm with your spec file. The 
> attached patch adds $DESTDIR

I figured out what you are getting at.  You wanted to install into
$(DESTDIR)$(bindir) and $(DESTDIR)$(pgkdatadir), but you wrote
$(DESTDIR)/$(bindir) and $(DESTDIR)/$(pgkdatadir), which confused me.
I have made the changes you requested and placed them into the
repository.

John

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
