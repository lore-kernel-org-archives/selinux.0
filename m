Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA12785
	for <selinux@tycho.nsa.gov>; Mon, 7 Jan 2002 11:33:59 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA01673
	for <selinux@tycho.nsa.gov>; Mon, 7 Jan 2002 16:33:31 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id QAA01666
	for <selinux@tycho.nsa.gov>; Mon, 7 Jan 2002 16:33:30 GMT
Date: Mon, 7 Jan 2002 11:33:22 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Charles Levert <lmcleve@ericsson.ca>
cc: <selinux@tycho.nsa.gov>
Subject: Re: /etc/security/default_context vs. /etc/security/default_contexts
In-Reply-To: <20020107104705.A857@lmc.ericsson.se>
Message-ID: <Pine.GSO.4.33.0201071055070.17155-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 7 Jan 2002, Charles Levert wrote:

> In libsecure, what is the difference between the following two files
> (notice the final "s")?
>
> 	/etc/security/default_context
> 		as used by get_default_user_sid() and get_user_sid()
>
> 	/etc/security/default_contexts (and ~user/.default_contexts)
> 		as used by get_config_priority()

The latter configuration file (and its associated library functions) is
intended to replace the former configuration file (and its associated
library functions) at some point in the future.  At present, none of the
modified programs are using the latter set of library functions or their
configuration file.  The latter set of functions use the
security_get_user_sids interface to obtain a list of legal SIDs for the
user that can be reached from the current process (login, sshd, crond) and
then uses the /etc/security/default_contexts and the optional
~user/.default_contexts files to prioritize these lists for presentation
to the user in a menu or for selecting a default.  The
/etc/security/default_contexts configuration file specifies a
prioritization based on the current process context, e.g. you can specify
different prioritizations depending on whether you are logging in via
login or via sshd.  It does not require a separate entry for each user,
unlike the current /etc/security/default_context and cron_context files.

If you hate maintaining the per-user entries in default_context and
cron_context and would like to help review, possibly refine, and
test these functions and also work on changing the login, sshd, and
crond programs to use these functions insted of the old functions, let us
know.  This work was supposed to be done by the person who developed both
the old and the new functions, but that person hasn't been able to work on
SELinux for a while.  I can send you a patch to login by the original
developer that shows how they are intended to be used.

> Also, what is the difference between get_default_user_sid() and
> get_user_sid() ?

get_default_user_sid simply returns the default security context for the
user.  It isn't interactive.  get_user_sid is interactive and permits
the user to either accept the default security context or specify a
different one.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
