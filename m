Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA20391
	for <selinux@tycho.nsa.gov>; Fri, 14 Dec 2001 09:31:10 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA26807
	for <selinux@tycho.nsa.gov>; Fri, 14 Dec 2001 14:30:58 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100] (may be forged))
	by jazzswing.ncsc.mil  with ESMTP id OAA26803
	for <selinux@tycho.nsa.gov>; Fri, 14 Dec 2001 14:30:57 GMT
Date: Fri, 14 Dec 2001 09:30:45 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Shaun Savage <savages@pcez.com>
cc: <selinux@tycho.nsa.gov>, <courier-users@lists.sourceforge.net>
Subject: Re: thanks, and new issue
In-Reply-To: <3C1911B6.5000607@pcez.com>
Message-ID: <Pine.GSO.4.33.0112140903310.24054-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 13 Dec 2001, Shaun Savage wrote:

> I am trying to add/make a new security policy for the courier mail
> server.  Sendmail is easy compared with qmail or courier.  This will
> also be a good learning experiance for me (and others) to go through the
> thinking behind creating a security policy.    I am not a courier
> expert,   but I think selinux and courier would be good togther.

I am not familiar with courier, but I'll try to provide some general
guidance below.  Also, just FYI, please note that the sendmail domain
is just a starting point for sendmail; a more complete solution for
sendmail is being developed by some folks at MITRE.

> The problem is how fine grained a security policy I should make?
> Should every processes have a seperate policy or should the whole
> package be one security?
> Should the certs be protected more than other parts?
> Courier writes to the users Maildir in their home dir, only
> courier_local writes to users dir.  ????

This depends on the permissions required by each courier-related process
and your security goals.  If several processes require essentially the
same permissions, then you can place them in the same domain.  Likewise,
if several directories/files should be accessible in the same way by the
same processes, you can place them in the same type.  If you aren't sure
what permissions are required, you can initially define separate domains
for each process, run the system in permissive mode to collect audit
messages, and then evaluate the resulting messages to see whether some of
the domains should be coalesced.  The script posted by Justin Smith may be
helpful to you in automatically converting the audit messages to allow
rules, but you still need to carefully analyze these rules to see if they
meet your security goals.

You should be cautious about using separate types for individual files
within a single directory, although this is possible.  The problem with
using separate types for individual files within a single directory is
ensuring that the type is preserved if the file is subsequently updated.
If the existing file is merely modified in place, then the type will be
preserved.  However, if the update to the file involves creation of a new
file, then you must take steps to ensure that the type of the new file is
the same as the type of the original.  One approach for doing so is to put
programs that update the file into a separate domain and defining a
file_type_auto_trans rule for that domain so that files created by the
domain in the directory will inherit the desired type rather than the type
of the parent directory by default.  However, if the program creates
multiple files in the same directory that must have different types, this
approach will not work, so you will have to either modify the program or
wrap it with another program that sets the file types properly.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
