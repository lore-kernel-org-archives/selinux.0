Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA13382
	for <selinux@tycho.nsa.gov>; Sat, 24 Nov 2001 12:32:24 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id RAA27106
	for <selinux@tycho.nsa.gov>; Sat, 24 Nov 2001 17:31:44 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100] (may be forged))
	by jazzband.ncsc.mil  with ESMTP id RAA27101
	for <selinux@tycho.nsa.gov>; Sat, 24 Nov 2001 17:31:43 GMT
Date: Sat, 24 Nov 2001 12:31:35 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Giovanni Mugnai <giovanni@unirel.it>
cc: <selinux@tycho.nsa.gov>
Subject: Re: Security policies change prevention!
In-Reply-To: <200111231010.fANAAHL25950@unirel.unirel.it>
Message-ID: <Pine.GSO.4.33.0111241229420.26405-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 23 Nov 2001, Giovanni Mugnai wrote:

> I have begun reading about selinux lately, i have read the security policy
> configuration could be changed at runtime by the security_load_policy call.
> I would like to know if it's possible to prevent from security policy
> configuration runtime changes, e.g. by a suitable kernel configuration, and
> where i could read something about.

This call is controlled by the load_policy permission.  In the example
policy configuration, this permission is only granted to the sysadm_t
domain for administrators.  If you remove this permission from
policy/domains/admin/sysadm.te, then runtime policy changes will no longer
be permitted.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
