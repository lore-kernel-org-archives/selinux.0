Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA05000
	for <selinux@tycho.nsa.gov>; Wed, 24 Apr 2002 10:10:24 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA00655
	for <selinux@tycho.nsa.gov>; Wed, 24 Apr 2002 14:09:13 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id OAA00651 for <selinux@tycho.nsa.gov>; Wed, 24 Apr 2002 14:09:13 GMT
Date: Wed, 24 Apr 2002 10:09:39 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Tom <tom@lemuria.org>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: split admins
In-Reply-To: <20020424154523.B14453@lemuria.org>
Message-ID: <Pine.GSO.4.33.0204241007550.17117-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 24 Apr 2002, Tom wrote:

> one problem I encountered was that newrole -r secadm_r didn't work,
> kicking me out with:
> arkham:~# newrole -r secadm_r
> Couldn't get default type.

By the way, if you specify a type explicitly to newrole (via the -t
option), it won't bother with /etc/security/default_type.  Naturally,
if the type isn't authorized for the role, it will fail.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
