Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA25814
	for <selinux@tycho.nsa.gov>; Tue, 15 Jan 2002 17:00:26 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id VAA27340
	for <selinux@tycho.nsa.gov>; Tue, 15 Jan 2002 21:59:36 GMT
Received: from sendmail (savages.net [208.170.193.18] (may be forged))
	by jazzband.ncsc.mil  with ESMTP id VAA27336
	for <selinux@tycho.nsa.gov>; Tue, 15 Jan 2002 21:59:35 GMT
Message-ID: <3C44A536.8010000@pcez.com>
Date: Tue, 15 Jan 2002 13:55:02 -0800
From: Shaun Savage <savages@pcez.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Charles Levert <lmcleve@ericsson.ca>
Subject: Re: /etc/security/default_context vs. /etc/security/default_contexts
References: <Pine.GSO.4.33.0201071055070.17155-100000@raven>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

HI
I have been playing with > get_user_sids from the libsecure test dir.

I tried
 > ./get_user_sids  system_u:system_r:local_login_t  root

it returns

SID 277 -> Scontext root:sysadm_r:sysadm_t
SID 275 -> Scontext root:user_r:user_t

OK the different values are returned, but how in the are may users 
defined genericly in the policy file?

example:  zot is added thur kerberos or nis+, how is the user zot found 
in the policy ?
 > ./get_user_sids  system_u:system_r:local_login_t  zot

return NULL

Shaun






>
>The latter configuration file (and its associated library functions) is
>intended to replace the former configuration file (and its associated
>library functions) at some point in the future.  At present, none of the
>modified programs are using the latter set of library functions or their
>configuration file.  The latter set of functions use the
>security_get_user_sids interface to obtain a list of legal SIDs for the
>user that can be reached from the current process (login, sshd, crond) and
>then uses the /etc/security/default_contexts and the optional
>~user/.default_contexts files to prioritize these lists for presentation
>to the user in a menu or for selecting a default.  The
>/etc/security/default_contexts configuration file specifies a
>prioritization based on the current process context, e.g. you can specify
>different prioritizations depending on whether you are logging in via
>login or via sshd.  It does not require a separate entry for each user,
>unlike the current /etc/security/default_context and cron_context files.
>
>If you hate maintaining the per-user entries in default_context and
>cron_context and would like to help review, possibly refine, and
>test these functions and also work on changing the login, sshd, and
>crond programs to use these functions insted of the old functions, let us
>know.  This work was supposed to be done by the person who developed both
>the old and the new functions, but that person hasn't been able to work on
>SELinux for a while.  I can send you a patch to login by the original
>developer that shows how they are intended to be used.
>


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
