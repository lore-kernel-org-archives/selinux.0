Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA09031
	for <selinux@tycho.nsa.gov>; Wed, 29 May 2002 08:33:19 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id MAA23159
	for <selinux@tycho.nsa.gov>; Wed, 29 May 2002 12:31:59 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id MAA23155 for <selinux@tycho.nsa.gov>; Wed, 29 May 2002 12:31:59 GMT
Date: Wed, 29 May 2002 08:32:13 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: deficiency in logging in enforcing mode
In-Reply-To: <20020529074504.42F59746@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0205290828170.4237-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 29 May 2002, Russell Coker wrote:

> It seems that messages such as the following are not logged in enforcing
> mode, only in permissive mode.  So if I can't execute a program because it's
> got a domain_auto_trans rule specifying that it should transition to a domain
> that is not permitted for the role I'm in then it just doesn't get executed
> with no reason being logged!
>
> This makes it difficult to determine why something is not working if you make
> a mistake in the role definitions, and limits the use of roles.  Can this be
> fixed in the next version?
>
> security_compute_sid:  invalid context rjc:sysadm_r:apmd_t for
> scontext=rjc:sysadm_r:sysadm_t tcontext=system_u:object_r:apmd_exec_t
> tclass=process

The only reason to log such a message is to help people in debugging
policies, and permissive mode is suitable for that purpose.  In contrast,
the AVC auditing is useful both in debugging policies and in providing an
audit log.  The disabling of the security_compute_sid logging when in
enforcing mode is intentional.

If we were to enable security_compute_sid logging in enforcing mode, we
would also need to apply a rate limit mechanism, as with the AVC auditing,
in order to guard against flooding.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
