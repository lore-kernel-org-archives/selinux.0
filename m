Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA09982
	for <selinux@tycho.nsa.gov>; Tue, 7 May 2002 10:22:46 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA26891
	for <selinux@tycho.nsa.gov>; Tue, 7 May 2002 14:20:51 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id OAA26887
	for <selinux@tycho.nsa.gov>; Tue, 7 May 2002 14:20:50 GMT
Date: Tue, 7 May 2002 10:22:22 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: ppp
In-Reply-To: <20020506233551.8198F312B@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0205071007430.22871-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 7 May 2002, Russell Coker wrote:

> It is common to install pppd in such a fashion that it can be run as
> "pppd call server" by a regular user.
>
> The problem is that it often starts daemons from it's ip-up script once it
> connects, and such daemons aren't allowed to be in user_r!
>
> I am thinking of writing a pppd wrapper program which runs it as
> "system_u:system_r:pppd_t", what do you think?

I suppose that the question is whether we obtain any real security benefit
from having such a wrapper vs. directly authorizing user_r for the
necessary domains and directly authorizing user_t to transition via
pppd_exec_t to pppd_t.  The domain transitions would still be limited
based on the entrypoint program.  Can you clarify exactly what other
daemons might be started in this manner?

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
