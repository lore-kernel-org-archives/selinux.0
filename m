Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA07265
	for <selinux@tycho.nsa.gov>; Mon, 22 Oct 2001 13:10:18 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id RAA19036
	for <selinux@tycho.nsa.gov>; Mon, 22 Oct 2001 17:09:45 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzband.ncsc.mil  with ESMTP id RAA19032
	for <selinux@tycho.nsa.gov>; Mon, 22 Oct 2001 17:09:45 GMT
Date: Mon, 22 Oct 2001 13:09:20 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: James Bishop <james.bishop@jrc.it>
cc: <selinux@tycho.nsa.gov>
Subject: Re: Patched SuSE 7.2 openssh-2.9p1 / Policy for SuSE 7.2?
In-Reply-To: <3BD447C4.1050107@jrc.it>
Message-ID: <Pine.GSO.4.33.0110221257050.11349-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 22 Oct 2001, James Bishop wrote:

> As far as I can see from the flask.pdf and policy-200109261436.pdf
> documents, I should define a domain for blogd. Domain definitions (e.g.
> for syslogd & klogd, which appear to be related to blogd - my
> assumption) reside in the policy/domains/system/*te files, but in
> general, how should I determine what privileges / capabilities should be
> assigned to a new  executable?

The easiest approach is to simply create a stub domain for the program and
try running the program in that domain while in permissive mode.  You can
then examine the avc audit messages to determine what permissions are
being requested by the process, and can incrementally refine your .te
file based on this information.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
