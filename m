Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i53LErrT015342
	for <selinux@tycho.nsa.gov>; Thu, 3 Jun 2004 17:14:53 -0400 (EDT)
Received: from smtp800.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i54LEZls000799
	for <selinux@tycho.nsa.gov>; Fri, 4 Jun 2004 17:14:36 -0400 (EDT)
Date: Thu, 3 Jun 2004 21:12:15 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: tridge@samba.org
Cc: SE-Linux <selinux@tycho.nsa.gov>, tng-technical@lists.samba-tng.org,
   samba-technical@samba.org
Subject: Re: se-samba
Message-ID: <20040603211215.GK3856@lkcl.net>
References: <200405312249.11522.rcoker@redhat.com> <16571.47722.750708.219840@samba.org> <20040531232931.GE8312@lkcl.net> <1086081794.3268.39.camel@localhost.localdomain> <20040601110924.GE8312@lkcl.net> <1086096477.3268.63.camel@localhost.localdomain> <20040601133547.GU8312@lkcl.net> <E1BV9Yp-0002wU-00@intern.SerNet.DE> <16573.1058.707078.949935@samba.org> <20040602124523.GA3708@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040602124523.GA3708@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

btw if anyone is concerned about the speed of a multi-processed
arrangement (one daemon per service, where services equals
double-digits as in samba-tng) then of course all you need
to do to fix the fork() issue is to use the same approach as
apache(1&2): have a pool of pre-forked processes on tap.

in fact i am surprised that 1) smbd has not had such code added
to it already 2) that serious consideration has not been given
to using the new apache2 framework: careful analysis of libapr
shows significant code duplication and similarity in key areas.

l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
