Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA03102
	for <selinux@tycho.nsa.gov>; Tue, 28 May 2002 11:19:26 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA01114
	for <selinux@tycho.nsa.gov>; Tue, 28 May 2002 15:18:06 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id PAA01110 for <selinux@tycho.nsa.gov>; Tue, 28 May 2002 15:18:06 GMT
Date: Tue, 28 May 2002 11:19:18 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Frank Mayer <mayerf@tresys.com>
cc: NSA Selinux Mailinglist <selinux@tycho.nsa.gov>
Subject: Re: Proposal: install policy.conf
In-Reply-To: <ACEHIKGIGFEDAIKEMMMIIENMKDAA.mayerf@tresys.com>
Message-ID: <Pine.GSO.4.33.0205281109490.1315-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 24 May 2002, Frank Mayer wrote:

> What we'd like to see is /etc/security/policy.conf treated as the definitive
> policy for a system, allowing all sorts of tools to change, create, or
> otherwise manage all or portions of the installed policy.

Do we want to include something in the compiled policy (currently
installed into /etc/security/selinux/policy.VERSION) that helps to
associate it with a particular policy.conf?  For example, we could compute
a message digest of the policy.conf file and include it in the compiled
policy header.

With regard to the issue of using policy.conf as the basis for tools that
are used to create or change the policy, I'm somewhat concerned by the
loss in modularity provided by the separation of .te files and the loss in
higher level abstraction provided by the macros.  I suppose that we could
extend the base language itself to provide direct constructs for "modules"
and for some of the higher level abstractions currently expressed via
macros.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com







--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
