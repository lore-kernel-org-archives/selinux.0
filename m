Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA27946
	for <selinux@tycho.nsa.gov>; Tue, 23 Apr 2002 13:04:25 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA10515
	for <selinux@tycho.nsa.gov>; Tue, 23 Apr 2002 17:02:39 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id RAA10511
	for <selinux@tycho.nsa.gov>; Tue, 23 Apr 2002 17:02:39 GMT
Date: Tue, 23 Apr 2002 13:03:41 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: Tom <tom@lemuria.org>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: boot loader
In-Reply-To: <20020423165027.470E93A16E@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0204231303010.3983-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 23 Apr 2002, Russell Coker wrote:

> Actually there's many things that are currently in different types which
> don't need it IMHO.  Such as resolv.conf.  Probably most daemon config files
> could be etc_t except where the daemon re-writes it's own config.

resolv.conf has a separate type to support the dhcpc and pump domains.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
