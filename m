Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA28555
	for <selinux@tycho.nsa.gov>; Wed, 16 Jan 2002 09:37:59 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA05379
	for <selinux@tycho.nsa.gov>; Wed, 16 Jan 2002 14:37:24 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id OAA05375
	for <selinux@tycho.nsa.gov>; Wed, 16 Jan 2002 14:37:23 GMT
Date: Wed, 16 Jan 2002 09:37:03 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Shaun Savage <savages@pcez.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: /etc/security/default_context vs. /etc/security/default_contexts
In-Reply-To: <3C44A536.8010000@pcez.com>
Message-ID: <Pine.GSO.4.33.0201160934050.7787-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 15 Jan 2002, Shaun Savage wrote:

> OK the different values are returned, but how in the are may users
> defined genericly in the policy file?

The new libsecure functions and the /etc/security/default_contexts file
doesn't address the issue of a generic user.  It merely eliminates the
need to maintain per-user entries in default_context and cron_context.
There is still the problem of maintaining policy/users.  As Mark Westerman
suggested (and I agreed), this can be addressed through the definition of
a generic user and some minor modifications to the libsecure functions to
use this as the default, as long as you do not need to distinguish among
such users in the policy.  If you want to maintain distinct role sets for
these users, then you will need to update policy/users in some manner.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
