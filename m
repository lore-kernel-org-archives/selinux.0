Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA14675
	for <selinux@tycho.nsa.gov>; Thu, 20 Jun 2002 09:57:33 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id NAA08901
	for <selinux@tycho.nsa.gov>; Thu, 20 Jun 2002 13:56:09 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id NAA08897 for <selinux@tycho.nsa.gov>; Thu, 20 Jun 2002 13:56:08 GMT
Date: Thu, 20 Jun 2002 09:56:53 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: fd use rules
In-Reply-To: <20020616143845.7480513F4@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0206200955130.16259-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sun, 16 Jun 2002, Russell Coker wrote:

> For many programs (including most daemons) we need to have access to the fds
> coming from the parent process (opened by sshd, newrole, or run_init).
>
> Would it make sense to do the following?
>
> allow myprog_t privrole:fd use;

Yes, this seems reasonable.  At present, these rules are individually
specified in general_domain_access() for login, sshd, and newrole.  Using
'privrole' would also pick up crond, run_init, and xdm.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
