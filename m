Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0KJRoIi007443
	for <selinux@tycho.nsa.gov>; Thu, 20 Jan 2005 14:27:51 -0500 (EST)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0KJRrCf026499
	for <selinux@tycho.nsa.gov>; Thu, 20 Jan 2005 19:27:53 GMT
Subject: Re: run_init and interactive scripts
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Manoj Srivastava <manoj.srivastava@stdc.com>
Cc: selinux@tycho.nsa.gov, Russell Coker <russell@coker.com.au>
In-Reply-To: <87acr4u57h.fsf@glaurung.internal.golden-gryphon.com>
References: <87acr4u57h.fsf@glaurung.internal.golden-gryphon.com>
Content-Type: text/plain
Message-Id: <1106246926.26753.196.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 20 Jan 2005 13:48:46 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-01-19 at 22:53, Manoj Srivastava wrote:
> 	The following patch makes run_init execute
>  /usr/sbin/open_init_pty (after using setexeccon to set the context
>  appropriately). So, run_init does not execvp the command directly,
>  Instead, it transitions the process into the initrc_t domain, execs
>  open_init_tty. open_init_pty then spawns a new process, that gets a
>  pty with context initrc_devpts_t (just execvp or using a exec(1) does
>  not open a new pty; the process inherits the original controlling
>  tty).
> 
> 	open_init_pty then sets up the psuedo terminal properly based
>  on the physical terminal attributes of the initial pty (temporarily
>  setting the user's pty to RAW mode, taking care to reset it on exit),
>  forks a child process that binds to the pseudo terminal. It then sits
>  around and connects the physical terminal it was invoked upon with
>  the pseudo terminal, passing keyboard input into to the child
>  process, and passing the output of the child process to the physical
>  terminal (using select).

It seems like this functionality (or something similar) could be useful
in other situations, e.g. for su(1) and sudo(8).
> 
> ______________________________________________________________________
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
