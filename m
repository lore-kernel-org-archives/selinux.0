Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA05693
	for <selinux@tycho.nsa.gov>; Tue, 4 Dec 2001 14:59:31 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id TAA11453
	for <selinux@tycho.nsa.gov>; Tue, 4 Dec 2001 19:48:25 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100] (may be forged))
	by jazzband.ncsc.mil  with ESMTP id TAA11449
	for <selinux@tycho.nsa.gov>; Tue, 4 Dec 2001 19:48:25 GMT
Date: Tue, 4 Dec 2001 14:48:52 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Justin Smith <jsmith@mcs.drexel.edu>
cc: <selinux@tycho.nsa.gov>
Subject: Re: Message
In-Reply-To: <1007491528.3571.4.camel@jsmith.org>
Message-ID: <Pine.GSO.4.33.0112041444520.28408-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On 4 Dec 2001, Justin Smith wrote:

> security:  context system_u:system_r:postgres_t is invalid
> security:  context system_u:system_r:ipchains_t is invalid

You need to authorize new domains for the appropriate roles via
a role statement.  You can either insert these domains into the central
system_r role definition in policy/rbac, or you can add each domain to
the role in its own .te file, e.g. adding a 'role system_r types {
postgres_t };' rule to the postgres.te file.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
