Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA27010
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 11:21:09 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA19783
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 15:19:42 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id PAA19779 for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 15:19:41 GMT
Date: Thu, 27 Jun 2002 11:20:43 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Michael Nyika <nyix@yahoo.com>
cc: "Westerman, Mark" <Mark.Westerman@csoconline.com>, <selinux@tycho.nsa.gov>
Subject: RE: System.te ?
In-Reply-To: <20020627150927.32672.qmail@web40205.mail.yahoo.com>
Message-ID: <Pine.GSO.4.33.0206271116090.11979-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 27 Jun 2002, Michael Nyika wrote:

> If Sysadm_t and user_t are domains whose definitions
> exist in admin.te and user.te in policy/domain, then
> why isnt there ( i presume) a file called system.te to
> define default behaviour for the system_t domain for
> system processes, in the same directory (or other
> dir)?

There are a number of domains defined for system processes, each limited
to the appropriate set of permissions.  These domains can be found under
policy/domains/program.  There used to be a separate policy/domains/system
subdirectory, but it was folded with the program directory because the
distinction wasn't helpful.  Many programs are run both as system
processes and as administrator commands, so there was ambiguity as to
where many domains belonged.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
