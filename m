Subject: Re: run_init and interactive scripts
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Manoj Srivastava <manoj.srivastava@stdc.com>
Cc: selinux@tycho.nsa.gov, Russell Coker <russell@coker.com.au>
In-Reply-To: <87acr4u57h.fsf@glaurung.internal.golden-gryphon.com>
References: <87acr4u57h.fsf@glaurung.internal.golden-gryphon.com>
Content-Type: text/plain
Message-Id: <1106247919.26753.207.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 20 Jan 2005 14:05:19 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-01-19 at 22:53, Manoj Srivastava wrote:
> 	open_init_pty then sets up the psuedo terminal properly based
>  on the physical terminal attributes of the initial pty (temporarily
>  setting the user's pty to RAW mode, taking care to reset it on exit),
>  forks a child process that binds to the pseudo terminal. It then sits
>  around and connects the physical terminal it was invoked upon with
>  the pseudo terminal, passing keyboard input into to the child
>  process, and passing the output of the child process to the physical
>  terminal (using select).

Prior to your patch:
# /usr/sbin/run_init /etc/init.d/sshd restart
Authenticating root.
Password:
Stopping sshd:                                             [  OK  ]
Starting sshd:                                             [  OK  ]

After your patch:
# /usr/sbin/run_init /etc/init.d/sshd restart
Authenticating root.
Password:
Stopping sshd:                                             [  OK  ]
Starting sshd:#

Need to flush stderr in open_init_pty?

BTW, Red Hat / Fedora is not presently using run_init at all, although I
still think it is a good idea if you can get users to use it.  The
policy allows direct transitions for init script and daemon execution
unless you disable the direct_sysadm_daemon tunable.  It would help if
we could enforce its usage in policy when that tunable is disabled, i.e.
prevent direct execution of sshd entirely by sysadm_t so that it doesn't
get left in sysadm_t by accident.

________________________________________________________________________
-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
