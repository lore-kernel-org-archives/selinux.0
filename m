Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA00179
	for <selinux@tycho.nsa.gov>; Tue, 4 Dec 2001 09:25:43 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA15295
	for <selinux@tycho.nsa.gov>; Tue, 4 Dec 2001 14:25:38 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id OAA15289
	for <selinux@tycho.nsa.gov>; Tue, 4 Dec 2001 14:25:37 GMT
Date: Tue, 4 Dec 2001 09:24:40 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Justin Smith <jsmith@mcs.drexel.edu>
cc: <selinux@tycho.nsa.gov>
Subject: Re: simple Perl script to converse messages to access rules
In-Reply-To: <1007474267.2028.0.camel@jsmith.org>
Message-ID: <Pine.GSO.4.33.0112040913380.28408-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On 4 Dec 2001, Justin Smith wrote:

> This will convert a sequence of access denied messages into
> allow-commands.
>
> One problem: even in permissive move, SELinux doesn't generate all
> possible denied messages. After one enables access and reruns an
> offending program, one gets more denied messages. It's as if the program
> didn't completely run the previous time (although it should, in
> permissive mode).

Thanks for the script.  The problem that you describe above should be
fixed in the next release.  The AVC has a ratelimit to prevent flooding
the system with AVC audit messages (copied from the existing net_ratelimit
for network log messages).  Currently, the ratelimit is applied regardless
of whether the system is in permissive mode or not, but I've changed this
behavior for future releases so that it is only applied in enforcing mode.
Also, in response to a request from a user on the list, I've changed the
AVC auditing code to put each audit message on a single line, so that will
likely require changes to your script.

While this script should be helpful in customizing the policy
configuration, you should carefully examine its output to ensure that the
resulting rules do not violate your security objectives.  Frequently,
rather than granting the permission between the existing domain and type,
you will want to define a new domain for the process and/or a new type for
the file and only grant the permission for the new domain and/or type.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
