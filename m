Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA05321
	for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 11:32:18 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA18223
	for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 15:31:06 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id PAA18211 for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 15:31:05 GMT
Date: Thu, 18 Apr 2002 11:32:07 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Tom <tom@lemuria.org>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: policy question
In-Reply-To: <20020418171532.B6551@lemuria.org>
Message-ID: <Pine.GSO.4.33.0204181124100.5560-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 18 Apr 2002, Tom wrote:

> The sole problem being that the scripts aren't executed in the
> unix-sense of execution, but by being loaded and interpreted by the
> apache process.

Immunix's SubDomain provides a mechanism for confining "subprocesses" for
web servers.  Read their paper for the details.

IMHO, if you truly want to confine these "scripts" differently than the
main apache process, they should run in separate processes.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com






--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
