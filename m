Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA18954
	for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 16:05:46 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id UAA00871
	for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 20:04:17 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id UAA00867 for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 20:04:16 GMT
Date: Thu, 11 Jul 2002 16:05:35 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Timothy Wood <timothy@hallcomp.com>
cc: Ed Street <blacknet@simplyaquatics.com>,
        "'SE Linux'" <selinux@tycho.nsa.gov>
Subject: RE: sysadm_tty_device_t
In-Reply-To: <1026417306.1659.18.camel@phobos>
Message-ID: <Pine.GSO.4.33.0207111559010.21775-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On 11 Jul 2002, Timothy Wood wrote:

> So no matter what the file context is login and newrole relabel them
> when they take control of the tty, correct?  If so, then it is really up
> to the controlling program (or program that needs control in this case)
> and so syslog needs premissions to relabel and/or control the tty,
> yes/no?

The modified login and newrole programs (and sshd program, but it only
deals with ptys) relabel the terminal device based on the user's context
and the original context on the device.  The proper SID is obtained via
the security_change_sid call, which computes a SID based on the
type_change rules in the policy configuration.

This is only necessary when you have a dynamic situation where the proper
context for the device needs to be adjusted for the current "owner" of the
device, and is parallel to the existing Linux handling of setting the uid
on such devices.

If you are dedicating a terminal for syslogd output, then you can
statically label it with a type, grant syslogd permission to append to
that type, and be done with it.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com






--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
