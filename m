Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA25822
	for <selinux@tycho.nsa.gov>; Wed, 21 Feb 2001 11:55:55 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA21575
	for <selinux@tycho.nsa.gov>; Wed, 21 Feb 2001 16:55:38 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id QAA21571
	for <selinux@tycho.nsa.gov>; Wed, 21 Feb 2001 16:55:37 GMT
Date: Wed, 21 Feb 2001 11:54:58 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: "Westerman, Mark" <Mark.Westerman@csoconline.com>
cc: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: Re: compute sid
In-Reply-To: <72222DC86846D411ABD300A0C9EB08A1015240A2@csoc-mail-box.csoconline.com>
Message-ID: <Pine.SOL.3.95.1010221114918.11524A-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>


>                   kernel: security_compute_sid:
>                  invalid context system_u:system_r:user_t for
>                  scontext=system_u:system_r:gdm_t
>                  tcontext=system_u:object_r:shell_exec_t tclass=process

This message means that there is an automatic domain
transition from gdm_t to user_t upon executing shell_exec_t,
but user_t is not a legitimate domain for the system_r role.
The policy/rbac file does not allow the system_r role to
enter the user_t domain.  In order for gdm to transition
to user_t, it must also transition to an appropriate
user identity and to the user_r role.  That requires
an explicit transition via one of the exec*_secure calls
rather than just using a default transition.

--
Stephen D. Smalley, NAI Labs
sds@tislabs.com



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
