Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA29575
	for <selinux@tycho.nsa.gov>; Fri, 8 Feb 2002 12:00:55 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id RAA28255
	for <selinux@tycho.nsa.gov>; Fri, 8 Feb 2002 17:00:01 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id RAA28251 for <selinux@tycho.nsa.gov>; Fri, 8 Feb 2002 17:00:01 GMT
Date: Fri, 8 Feb 2002 12:00:01 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: runas.c line 131
In-Reply-To: <20020207222600.C73133A2671@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0202081153220.22738-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 8 Feb 2002, Russell Coker wrote:

> The context_new() call on line 131 of runas.c doesn't include a check for a
> return of NULL if the context is invalid.  Shortly afterwards the pointer is
> dereferenced giving a SEGV.

Thanks for the catch.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
