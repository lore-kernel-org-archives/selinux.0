Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA07766
	for <selinux@tycho.nsa.gov>; Mon, 11 Feb 2002 09:32:18 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA01225
	for <selinux@tycho.nsa.gov>; Mon, 11 Feb 2002 14:31:24 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id OAA01219
	for <selinux@tycho.nsa.gov>; Mon, 11 Feb 2002 14:31:23 GMT
Date: Mon, 11 Feb 2002 09:31:30 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: insmod needs to write to /proc/sys/kernel/tainted
In-Reply-To: <20020211053602.6A3D0167DD@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0202110928580.5822-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 11 Feb 2002, Russell Coker wrote:

> In the current default policy the insmod_t domain is explicitely prohibited
> from writing to sysctl_kernel_t objects.
>
> What is the best way of resolving this?  Should I change the type of
> /proc/sys/kernel/tainted?

Given the privileged nature of the insmod_t domain, it is probably fine to
directly grant it permission to sysctl_kernel_t and adjust the
corresponding TE assertion to accept this.  We could define a new type for
the tainted flag, but I'm not sure it is worthwhile.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
