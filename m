Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA15303
	for <selinux@tycho.nsa.gov>; Thu, 20 Jun 2002 10:58:01 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA12938
	for <selinux@tycho.nsa.gov>; Thu, 20 Jun 2002 14:56:36 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id OAA12930 for <selinux@tycho.nsa.gov>; Thu, 20 Jun 2002 14:56:34 GMT
Date: Thu, 20 Jun 2002 10:57:34 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Debian User <rogelio@evoworks.evoserve.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: uclibc and selinux
In-Reply-To: <3D098B97.7030903@evoworks.evoserve.com>
Message-ID: <Pine.GSO.4.33.0206201054200.16259-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 14 Jun 2002, Debian User wrote:

> How about incremental policy updates? So the policy does not have to
> contain all possible policies needed in a system?

Do you mean a reduced form of the security_load_policy call to permit
loading new domains into an existing policy rather than performing a
complete reload of the policy?  Or something else?  You can certainly
reload the policy to add new domains as necessary.

> Also whats the best way to isolate users from each other when the passwd
> file contains only "root" and "user" accounts?

You can't isolate users from each other using the SELinux policy without
maintaining separate user identities and roles in the policy.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
