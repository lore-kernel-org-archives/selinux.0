Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1GDnUL9015642
	for <selinux@tycho.nsa.gov>; Wed, 16 Feb 2005 08:49:30 -0500 (EST)
Subject: Re: sshd transition points
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20050216135108.GN31121@lkcl.net>
References: <20050215155323.GC23765@lkcl.net>
	 <1108491293.17854.153.camel@moss-spartans.epoch.ncsc.mil>
	 <20050215191640.GA26294@lkcl.net>
	 <1108495342.17854.200.camel@moss-spartans.epoch.ncsc.mil>
	 <20050215200355.GB26294@lkcl.net> <20050215205728.GC26294@lkcl.net>
	 <1108558973.19756.45.camel@moss-spartans.epoch.ncsc.mil>
	 <20050216135108.GN31121@lkcl.net>
Content-Type: text/plain
Message-Id: <1108561272.19756.89.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 16 Feb 2005 08:41:12 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-02-16 at 08:51, Luke Kenneth Casson Leighton wrote:
>  ah, but because the unprivileged child process in this instance manages
>  the networking, and because i wish to restrict users on a per-IP basis
>  from being able to log in, i _do_ want to associate a user-specific
>  domain with the unprivileged child process.

I'm not sure that this makes sense; isn't the monitor process and the
unprivileged child process created _before_ authenticating the user?  It
isn't until you create the user privileged child process that you have
an authenticated user identity.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
