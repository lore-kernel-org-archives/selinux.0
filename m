Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA15020
	for <selinux@tycho.nsa.gov>; Tue, 14 May 2002 12:29:19 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA25327
	for <selinux@tycho.nsa.gov>; Tue, 14 May 2002 16:28:02 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id QAA25315 for <selinux@tycho.nsa.gov>; Tue, 14 May 2002 16:27:57 GMT
Date: Tue, 14 May 2002 12:28:53 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Carsten Grohmann <carsten.grohmann@dr-baldeweg.de>
cc: NSA Selinux Mailinglist <selinux@tycho.nsa.gov>
Subject: Re: avtab: out of memory
In-Reply-To: <3CE134C4.68A5B77A@dr-baldeweg.de>
Message-ID: <Pine.GSO.4.33.0205141211560.25712-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 14 May 2002, Carsten Grohmann wrote:

> May 14 17:27:43 cvs kernel: ss:  loading policy configuration from
> /etc/security/selinux/policy.9
> May 14 17:27:43 cvs kernel: security: avtab: out of memory
> ....
> May 14 17:37:47 cvs kernel: security:  5 users, 8 roles, 542 types
> May 14 17:37:47 cvs kernel: security:  29 classes, 65787 rules
>
> The load faild without the rules of cups und courier too.
> Now my policy file has only a size of 1.6 mb. I added only a few rules
> for cvs and amanda and I think its not to great.
> MS-like: After the reboot it works fine without problems.
>
> I don't know whats my misstake. Could anyone help me?

The security server uses atomic allocation, so it will fail if the
allocation would sleep.  We could permit blocking allocation in the case
of a policy reload by a userspace process, which might help.  Was your
machine under heavy load?

I've loaded policies twice that size via make load without any problem,
and switched back and forth repeatedly.  If you can reproduce the problem
reliably and you're willing to send me the policy that triggers the
behavior, I can also try it here.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
