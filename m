Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA27372
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 11:38:30 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA20984
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 15:37:03 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id PAA20980 for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 15:37:02 GMT
Date: Thu, 27 Jun 2002 11:37:49 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Michael Nyika <nyix@yahoo.com>
cc: <selinux@tycho.nsa.gov>
Subject: RE: System.te ?
In-Reply-To: <20020627152451.37794.qmail@web40208.mail.yahoo.com>
Message-ID: <Pine.GSO.4.33.0206271129420.11979-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 27 Jun 2002, Michael Nyika wrote:

> true: but what about "new" system processes, or
> rather, those that do NOT appear in
> /policy/domains/programs ? I'm thinking that if there
> is an undefined process, it should take on default
> behaviour found in a file i mentioned earlier?

See step 18 of the README.  System processes will end up in initrc_t
if you do not define a domain and assign the executable type to the
corresponding program.  As noted in the README, you should either define a
domain for all such processes, or you should disable them.

Setting up a default behavior as you describe is problematic.  A daemon
that doesn't have a specific executable type assigned to it will typically
be labeled with sbin_t, the default type for programs in /sbin.  But
utility programs in /sbin are also labeled with this type, and we do not
want the rc scripts to transition to a special domain for those utilities.
Hence, we cannot define a default transition to some safe domain for
unrecognized system processes.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
