Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA20120
	for <selinux@tycho.nsa.gov>; Tue, 2 Apr 2002 08:43:59 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA11126
	for <selinux@tycho.nsa.gov>; Tue, 2 Apr 2002 13:42:29 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id NAA11122
	for <selinux@tycho.nsa.gov>; Tue, 2 Apr 2002 13:42:29 GMT
Date: Tue, 2 Apr 2002 08:43:35 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: <belef24@ift.ulaval.ca>
cc: <selinux@tycho.nsa.gov>
Subject: Re: Problem with newrole && || login.c
In-Reply-To: <1017688984.3ca8b39827d25@courriel.ift.ulaval.ca>
Message-ID: <Pine.GSO.4.33.0204020839410.2967-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 1 Apr 2002 belef24@ift.ulaval.ca wrote:

> --- newrole problem ---
> hi, when i try to change my role, i got this ( in debug mode ) :
> bash-2.05# newrole -r user_r
> Your type will be user_t.
> Your old SID was 157
> Your old context was system_u:system_r:sysadm_t
> system_u
> cannot find your entry in the passwd file.
> the system_u line is what context_user_get(context) return.
> So, i dont have any system_u in my passwd ( my passwd is normal like any other
> unix system ) maybe im wrong here??

The problem is that you aren't using a modified login program, so the
security context is not being initialized at login time with the
appropriate user identity and role.

> --- login problem ----
> ok my login problem is that i dont use PAM so i change it in MCONFIG to no and
> no login.c are compiled...i dont understand why and i suppose i must have a
> new login to work with my shadow. ( i use slack its why i dont use pam :) )
> Someone can help me please or got any idea? thx.

We only use RedHat 7.1 and 7.2 as our base platform, so I can't help you
with Slackware-specific problems.  Try porting the login modifications to
the login used by your distribution.  Other people have reported
successfully getting SELinux to work with other distributions, including
Slackware, so you might want to look through the mailing list archives.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
