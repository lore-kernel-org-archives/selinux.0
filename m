Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA12874
	for <selinux@tycho.nsa.gov>; Mon, 8 Oct 2001 12:16:02 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA14174
	for <selinux@tycho.nsa.gov>; Mon, 8 Oct 2001 16:15:31 GMT
Received: from mozart.fwsystems.com (mozart.fwsystems.com [63.101.67.2])
	by jazzband.ncsc.mil  with ESMTP id QAA14170
	for <selinux@tycho.nsa.gov>; Mon, 8 Oct 2001 16:15:31 GMT
Received: from w2 (IDENT:fw@w2.fwsystems.com [63.101.67.15])
	by mozart.fwsystems.com (8.11.6/8.11.6) with SMTP id f98GG0S30828
	for <selinux@tycho.nsa.gov>; Mon, 8 Oct 2001 12:16:00 -0400
Date: Mon, 8 Oct 2001 12:16:00 -0400
From: forrest whitcher <fw@fwsystems.com>
To: selinux@tycho.nsa.gov
Subject: SE-Linux versions, features, stability?
Message-Id: <20011008121600.071caa6e.fw@fwsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Several questions directed to the SE Linux principles

Stephen, in your talk this spring at Usenix you noted that 
you had a server running SE Linux in production for a period
of months.

Can you advise what SE Linux version(s) are so used and what is 
the operational environment (Internet-exposed? services running
in secured contexts?)

I expect that since the stable 2.2.19 kernel-patched version, 
through the 2.4 kernel-patched and into the currently recommended
LSM-based version that you have added features and killed bugs.

The NSA download site recommends that people use the most recent 
(LSM) code, which makes sense in development, as I doubt that
the new versions maintain backward-compatibilty.

Is this also the best (general) recommendation for trying to deliver 
an operational, secured system.

Within the caveat that I don't think NSA can (or should) take 
repsponsibility recommend SE Linux as a production system, are
there any differences between the 3 major extant versions
(2.2.19, 2.4, LSM) as regards deploying operational servers?

Thanks,

forrest

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
