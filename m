Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA00021
	for <selinux@tycho.nsa.gov>; Thu, 21 Mar 2002 10:17:51 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA26710
	for <selinux@tycho.nsa.gov>; Thu, 21 Mar 2002 15:16:47 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id PAA26695 for <selinux@tycho.nsa.gov>; Thu, 21 Mar 2002 15:16:47 GMT
Date: Thu, 21 Mar 2002 10:16:54 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Dale Amon <amon@vnl.com>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Getdate error
In-Reply-To: <20020321121121.GJ10482@vnl.com>
Message-ID: <Pine.GSO.4.33.0203211009170.19336-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 21 Mar 2002, Dale Amon wrote:

> This is probably one for the upstream guy, but here are
> some build errors showing on the latest selinux utils:
>
> 	getdate.y: In function `yyparse':
> 	getdate.y:381: parse error before `}'
> 	getdate.y:387: parse error before `}'
> 	getdate.y:393: parse error before `}'

The semicolons are missing in the upstream sources, but this doesn't
appear to create a build problem for us.  bison appears to insert
an extra semicolon automatically anyway.  We're using bison version 1.28,
the standard one on RH7.1 and RH7.2.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
