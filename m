Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA16041
	for <selinux@tycho.nsa.gov>; Wed, 1 May 2002 13:15:35 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA20271
	for <selinux@tycho.nsa.gov>; Wed, 1 May 2002 17:13:44 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id RAA20267
	for <selinux@tycho.nsa.gov>; Wed, 1 May 2002 17:13:43 GMT
Date: Wed, 1 May 2002 13:15:12 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Debian User <rogelio@evoworks.evoserve.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: successfull avc_toggle
In-Reply-To: <20020501005734.B6485812E3@coffeesaur2.evoserve.com>
Message-ID: <Pine.GSO.4.33.0205011306460.1601-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 1 May 2002, Debian User wrote:

> I can go into enforcing mode mode now without being logged out. The
> policy is too restrictive though and i added some allow lines to the
> policy.

> domains/admin.te:
> allow sysadm_t getty_t:fd { use };

Make sure that your login program is labeled correctly (the program should
be labeled login_exec_t and the process should run in local_login_t).  It
is possible that your login process is being left in getty_t if it isn't
labeled correctly.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
