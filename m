Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA03441
	for <selinux@tycho.nsa.gov>; Tue, 28 May 2002 11:46:46 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA02557
	for <selinux@tycho.nsa.gov>; Tue, 28 May 2002 15:45:26 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id PAA02553 for <selinux@tycho.nsa.gov>; Tue, 28 May 2002 15:45:25 GMT
Date: Tue, 28 May 2002 11:45:56 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: =?iso-8859-1?q?vishwakarma=20singh?= <vsingh014@yahoo.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: setuid problem
In-Reply-To: <20020528024109.20530.qmail@web14304.mail.yahoo.com>
Message-ID: <Pine.GSO.4.33.0205281138510.1315-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 28 May 2002, [iso-8859-1] vishwakarma singh wrote:

>  If i am not wrong than setuid does not work in
> selinux if they donot comply to the rules of policy
> configuration . but since many programs and utilities
> in normal linux uses setuid , i want to reenable it .
> have anybody any idea , how to reenable it ?please
> give details.
> thanx

SElinux doesn't disable setuid.  It does perform a parallel check to the
existing CAP_SETUID capability checks, but setuid program execution only
requires CAP_SETUID under special conditions (process tracing, shared
state via clone).  If you are encountering a setuid capability denial from
SELinux, you can grant that permission to the appropriate domain (or
define a new domain, as appropriate).

The SELinux access controls are orthogonal to the Linux access controls,
and do not depend on the Linux identity attributes.  Please read the
Configuring the SELinux Policy report, particularly the security model
section.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
