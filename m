Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA24625
	for <selinux@tycho.nsa.gov>; Tue, 26 Dec 2000 16:32:59 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id VAA01342
	for <selinux@tycho.nsa.gov>; Tue, 26 Dec 2000 21:32:28 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id VAA01338
	for <selinux@tycho.nsa.gov>; Tue, 26 Dec 2000 21:32:27 GMT
Received: from localhost by clipper.gw.tislabs.com (8.9.3/8.9.1) with SMTP id QAA04833
	for <selinux@tycho.nsa.gov>; Tue, 26 Dec 2000 16:31:43 -0500 (EST)
Date: Tue, 26 Dec 2000 16:31:43 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: selinux@tycho.nsa.gov
Subject: Re: questions
In-Reply-To: <Pine.SOL.3.95.1001226150034.29240R-100000@clipper.gw.tislabs.com>
Message-ID: <Pine.SOL.3.95.1001226162803.29240T-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
Reply-To: selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>


> > - On policy_parse.y yacc always choked on line 228. There were two consecutive
> > lines containing a single ';'. I guess it is due to some syntax error in my
> > /etc/security/*, or the m4 tricks.

I found the two consecutive semicolon lines at line 288.  I 
guess that "228" was just a typo.  You can simply remove
the extraneous semicolon.

--
Stephen D. Smalley, NAI Labs
sds@tislabs.com



You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
