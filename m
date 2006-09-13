Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8DGs8x1002153
	for <selinux@tycho.nsa.gov>; Wed, 13 Sep 2006 12:54:08 -0400
Received: from legolas.drinsama.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8DGrHNu004919
	for <selinux@tycho.nsa.gov>; Wed, 13 Sep 2006 16:53:17 GMT
Subject: Re: Moving xconsole from xserver to logging policy
From: Erich Schubert <erich@debian.org>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <1158164561.26420.72.camel@sgc.columbia.tresys.com>
References: <1158162208.1594.37.camel@wintermute.xmldesign.de>
	 <1158164561.26420.72.camel@sgc.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-15
Date: Wed, 13 Sep 2006 18:54:03 +0200
Message-Id: <1158166443.1594.51.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello Christopher,
> I don't agree with this; I believe it is a Debian thing that syslog
> writes to this.  Even neglecting that, it still makes more sense to me
> that it stays in xserver.

Please enlighten me then what /dev/xconsole is good for.
The xconsole manpage just says "The xconsole program displays messages
which are usually sent to /dev/console" and "monitor system console
messages with X"

The only app I know that writes to /dev/xconsole is syslog. Do you know
any others?

best regards,
Erich Schubert
-- 
    erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C     (o_
 The early bird gets the worm, but the second mouse gets the cheese.  //\
 Jemanden zu lieben heißt glücklich zu sein, ihn glücklich zu sehen.  V_/_



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
