Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA22320
	for <selinux@tycho.nsa.gov>; Fri, 21 Jun 2002 11:05:43 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA08538
	for <selinux@tycho.nsa.gov>; Fri, 21 Jun 2002 15:05:20 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id PAA08534
	for <selinux@tycho.nsa.gov>; Fri, 21 Jun 2002 15:05:19 GMT
Date: Fri, 21 Jun 2002 11:05:28 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: error
In-Reply-To: <20020621145254.A716019B5@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0206211057290.12888-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 21 Jun 2002, Russell Coker wrote:

> It seems that I didn't update initial_sid_contexts.

Yes, try applying the selinux.patch to your selinux directory.

> Hmm, maybe initial_sid_contexts should be in /usr/lib/selinux instead?  As it
> doesn't seem to make any sense to have it where users can mess with it...

A policy writer may choose to map the initial SIDs to completely different
security contexts.  That is a policy configuration issue.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
