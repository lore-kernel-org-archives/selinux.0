Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA12072
	for <selinux@tycho.nsa.gov>; Fri, 19 Apr 2002 13:54:31 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA04541
	for <selinux@tycho.nsa.gov>; Fri, 19 Apr 2002 17:52:49 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id RAA04537
	for <selinux@tycho.nsa.gov>; Fri, 19 Apr 2002 17:52:48 GMT
Date: Fri, 19 Apr 2002 13:53:40 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: init and sigchld
In-Reply-To: <20020418141926.325FE28605@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0204191353170.18117-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 18 Apr 2002, Russell Coker wrote:

> OK.  I've created an every.te file in my tree with this rule, and removed
> every instance of
> allow ... init_t:process sigchld;

Actually, I suppose that we could just place this rule into init.te.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
