Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA28041
	for <selinux@tycho.nsa.gov>; Wed, 3 Apr 2002 15:55:36 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id UAA04727
	for <selinux@tycho.nsa.gov>; Wed, 3 Apr 2002 20:54:05 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id UAA04723
	for <selinux@tycho.nsa.gov>; Wed, 3 Apr 2002 20:54:04 GMT
Date: Wed, 3 Apr 2002 15:55:03 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: more man page stuff
In-Reply-To: <20020329235527.0C8A44226E@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0204031554080.12189-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sat, 30 Mar 2002, Russell Coker wrote:

> Shouldn't runas and run_init be in section 8 not section 1?

run_init, yes.  runas, not necessarily.  runas, like newrole, might be
used by ordinary users, depending on the policy.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
