Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA07031
	for <selinux@tycho.nsa.gov>; Thu, 25 Jul 2002 07:17:12 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id LAA08174
	for <selinux@tycho.nsa.gov>; Thu, 25 Jul 2002 11:15:39 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id LAA08170 for <selinux@tycho.nsa.gov>; Thu, 25 Jul 2002 11:15:39 GMT
Date: Thu, 25 Jul 2002 07:16:52 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: default_context
In-Reply-To: <20020725111044.5D5B923A@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0207250714010.10347-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 25 Jul 2002, Russell Coker wrote:

> I think that it would be good to have default_context differ per login
> program.
>
> EG When you login via ssh you don't want to have a default role of sysadm_r
> because the policy for sshd prohibits it.  But when logging in as root at the
> console you want it to default to sysadm_r to save time in emergencies.
>
> What do you think?

Yes, this is reasonable.  The new libsecure functions and default_contexts
configuration support this type of functionality, because you can specify
different prioritizations for different initial contexts (e.g.
system_u:system_r:local_login_t vs. system_u:system_r:sshd_t).  I'm still
waiting for the responsible party to finish this work and integrate it
with login, sshd, and crond.  However, this has been pending for a long
time.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
