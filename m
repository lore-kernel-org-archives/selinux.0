Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA09841
	for <selinux@tycho.nsa.gov>; Tue, 7 May 2002 10:05:39 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA27017
	for <selinux@tycho.nsa.gov>; Tue, 7 May 2002 14:04:25 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id OAA27013 for <selinux@tycho.nsa.gov>; Tue, 7 May 2002 14:04:24 GMT
Date: Tue, 7 May 2002 10:04:33 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: run_init and chdir()
In-Reply-To: <20020507121156.390C36C13@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0205070959510.22871-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 7 May 2002, Russell Coker wrote:

> Would it make sense to have run_init do "chdir /" before executing it's
> program?

Probably.  We could have it call daemon(0,1) prior to the execvp_secure
call.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
