Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1FJUZL9010580
	for <selinux@tycho.nsa.gov>; Tue, 15 Feb 2005 14:30:35 -0500 (EST)
Subject: Re: sshd transition points
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20050215191640.GA26294@lkcl.net>
References: <20050215155323.GC23765@lkcl.net>
	 <1108491293.17854.153.camel@moss-spartans.epoch.ncsc.mil>
	 <20050215191640.GA26294@lkcl.net>
Content-Type: text/plain
Message-Id: <1108495342.17854.200.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 15 Feb 2005 14:22:22 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-02-15 at 14:16, Luke Kenneth Casson Leighton wrote:
>  and then that shell does a further execve of the sftp-server?

I think that sshd runs the subsystem via a shell, e.g. $SHELL -c
sftp-server.  Hence, sshd will set the exec context prior to invoking
the shell based on the default context for the user, so that the shell
will run in the user's domain, and then there may or may not be another
transition (subject to policy) upon execution of sftp-server by the
shell.

>   what the _heck_ is that sshd doing still running as root, or
>   more specifically, what's it doing still running under sshd_t?

Isn't this the normal privilege separation support in sshd, with the
parent being the privileged monitor and the child as the user
unprivileged process?  See
http://www.citi.umich.edu/u/provos/ssh/privsep.html

>  unfortunately, then, as things stand, it's not possible to
>  associate a security context with the "initial" fork - the
>  one that holds the TCP connection.
> 
>  ... and what you are saying is that now that dynamic transitions
>  are possible, it might be doable?

As previously discussed, SELinux used to only support exec-based context
transitions, as that is the point where we can control inheritance of
state and initialization of the process in the new context.  It has
never supported context transitions upon fork.  Recently (again, as
discussed on the list), support for dynamic context transitions via the
new setcon(3) libselinux function was added, which would allow sshd to
explicitly transition domains for the different processes without
performing an exec.  But it would be better to restructure it instead to
use exec-based transitions for better security...

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
