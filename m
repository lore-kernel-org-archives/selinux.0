Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA11799
	for <selinux@tycho.nsa.gov>; Mon, 7 Jan 2002 09:08:22 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA14031
	for <selinux@tycho.nsa.gov>; Mon, 7 Jan 2002 14:07:35 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzband.ncsc.mil  with ESMTP id OAA14027
	for <selinux@tycho.nsa.gov>; Mon, 7 Jan 2002 14:07:35 GMT
Date: Mon, 7 Jan 2002 09:07:26 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Shaun Savage <savages@pcez.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: change login.c
In-Reply-To: <3C37B8C3.8090307@pcez.com>
Message-ID: <Pine.GSO.4.33.0201070844520.17155-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sat, 5 Jan 2002, Shaun Savage wrote:

> during login with selinux, the question "do you want to change context"
> is asked.  My feeling is that this creates  complexity problem.  I have
> changed get_user_sid() to get_default_user_sid().  This does not confuse
> "the user" also, if someone does get root this adds one more fence.

It seems like you are moving in the wrong direction here.  Even if a user
specifies a security context to login, he is still limited by the kernel
to the set of authorized roles and domains that are legal for the user
(policy/users and policy/rbac) and that are reachable from the login
process (i.e. there must be a domain_auto_trans rule or a domain_trans
rule in login.te).  So there is no real risk in permitting the user to
specify a security context at login time.

Even if you remove this support, a user can still change roles later
via newrole.  I doubt that you want to remove that program and domain.

With regard to root, keep in mind a couple of points:

1) The SELinux user identity is separate from the Linux uids and can only
be set by certain trusted domains/programs.  The limitations on the
SELinux role and domain are based on the SELinux user identity, not the
Linux uids, so simply becoming the Unix superuser (e.g. by penetrating
a superuser daemon or by exploiting a flaw in a setuid program) does not
change your set of authorized roles or domains.  You have to actually
authenticate yourself as root to one of the trusted domains/programs.

2) You don't necessarily have to grant the "root" user access to the
sysadm_r role.  You can limit root to user_r in policy/users and only
grant sysadm_r to particular users.  That's up to you.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
