Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA05241
	for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 11:23:05 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA24568
	for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 15:21:24 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id PAA24564
	for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 15:21:23 GMT
Date: Thu, 18 Apr 2002 11:22:27 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Tom <tom@lemuria.org>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: policy question
In-Reply-To: <20020418112238.A1788@lemuria.org>
Message-ID: <Pine.GSO.4.33.0204181120330.5560-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 18 Apr 2002, Tom wrote:

> Scenario: Webhosting with PHP, multiple users (possibly many)
> Danger: PHP runs as a module, i.e. with apache's user and permissions.
> that means it is trivial for every user to acess other user's files,
> including .php files that may include things like database passwords.

The example apache policy (by MITRE) provides separate domains for system
CGI scripts and user CGI scripts, and limits each to a particular set of
permissions.  MITRE also created a simple patch to suexec to transition to
a per-user security context in that case, using a revised apache policy
that allows for such transitions.  We haven't mainstreamed the modified
suexec or revised apache policy in the upstream distribution.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
