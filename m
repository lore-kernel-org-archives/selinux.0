Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA09308
	for <selinux@tycho.nsa.gov>; Fri, 18 Oct 2002 14:22:40 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id SAA09259
	for <selinux@tycho.nsa.gov>; Fri, 18 Oct 2002 18:20:54 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id SAA09255
	for <selinux@tycho.nsa.gov>; Fri, 18 Oct 2002 18:20:53 GMT
Date: Fri, 18 Oct 2002 14:21:41 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Giorgio Zanin <giorgio.zanin@inwind.it>
cc: SELinux mailing list <selinux@tycho.nsa.gov>
Subject: Re: a silly question
In-Reply-To: <3DB04B4F.10709@inwind.it>
Message-ID: <Pine.GSO.4.33.0210181418420.9847-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 18 Oct 2002, Giorgio Zanin wrote:

> technical informations. For example it's not clear to me whether a
> process with a type A, changing its type (due to a domain migration, for
> example, or to any other possible way - which are there?) to B, leaves
> permissions granted in A and get just those in B or get those in A and
> those in B (if I'm not wrong the former is the behaviour in canonical TE
> and so it is supposed to be the right one).

The former is the behavior in SELinux.  And the domain (type) of a process
can only change upon an execve (based on type transition rules in the
policy) or execve_secure (explicit request by an application).  That
permits control over the inheritance of state and the initialization of
the process in the new domain.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
