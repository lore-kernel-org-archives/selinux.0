Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA04155
	for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 08:48:32 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id MAA09044
	for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 12:47:22 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id MAA09040 for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 12:47:21 GMT
Date: Thu, 18 Apr 2002 08:47:41 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: init and sigchld
In-Reply-To: <20020418110311.CD31A93B@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0204180845300.26541-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 18 Apr 2002, Russell Coker wrote:

> What is the benefit in denying sigchld access to init?
>
> How can a process do harm by sending sigchld to the init process?
>
> I am thinking of doing the following:
>
> allow domain init_t:signal sigchld;

This rule used to exist in every.te, and was then moved into
general_domain_access() in global_macros.te.  I suppose we could
revive every.te and put a few rules like this one into it.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
