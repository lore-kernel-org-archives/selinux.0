Date: Fri, 12 Apr 2002 11:11:16 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Tom <tom@lemuria.org>
cc: <SELinux@tycho.nsa.gov>
Subject: Re: db conflict ?
In-Reply-To: <20020412170130.A30042@lemuria.org>
Message-ID: <Pine.GSO.4.33.0204121108290.21729-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 12 Apr 2002, Tom wrote:

> Analysis: Logging in via ssh as root works, as a user not. i.e. "ssh
> -l tom testmachine" fails, "ssh -l root testmachine" works.
>
> The error message in /var/log/auth.log is:
>
> fatal: Could not obtain SID for user tom
>
>
> The piece of code that triggers this appears to be:
>
> if (!get_default_user_sid(pw->pw_name,
> 			  strlen(pw->pw_name),
> 			  &scontext,
> 			  &sid)) {
> 	fprintf(stderr, "Could not obtain SID for user %s\n",
> 		pw->pw_name);
> 	exit(1);
> }
>
> so I wonder why this fails, because my /etc/selinux/users says:
>
> user user_u roles user_r;
> user root roles { user_r sysadm_r };
> user tom roles { user_r sysadm_r };
>
> so tom should be more than covered. or am I just being dumb again?

You also need an entry for tom in /etc/security/default_context.  This
configuration file will be obsoleted in the future, but we're still
waiting on a developer at NSA to finish the support necessary to eliminate
it.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
