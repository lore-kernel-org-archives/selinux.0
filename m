Subject: RE: [PATCH] libsemanage: free policydb before fork
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Todd Miller <Tmiller@tresys.com>
Cc: Joshua Brindle <method@manicmethod.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B015880181EED5@exchange.columbia.tresys.com>
References: <47A5311F.2020703@manicmethod.com>
	 <6FE441CD9F0C0C479F2D88F959B015880181EED5@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Mon, 04 Feb 2008 10:24:17 -0500
Message-Id: <1202138657.3070.61.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2008-02-04 at 10:14 -0500, Todd Miller wrote:
> Joshua Brindle wrote:
> > While testing the recent memory-related patches on a low memory
> > machine (512m total) I found that semodule still failed. It turns out
> > that fork() requires enough free ram for the amount of private dirty
> > memory in the parent process to succeed (even if it is never written
> > to in the child process).
> 
> I would suggest trying to use vfork() instead of fork() in
> semanage_exec_prog().
> This should result in less of the parent's memory being copied into the
> child.
> You would also have to change the exit() following execve() failure to
> _exit()
> but that should be it.

Might be interesting to see the results of that change, but just to
note, from the man page for vfork in Linux:

BUGS
       It is rather unfortunate that Linux revived this specter from the past.
       The  BSD  man  page  states:  "This system call will be eliminated when
       proper system sharing mechanisms are  implemented.   Users  should  not
       depend  on  the memory sharing semantics of vfork() as it will, in that
       case, be made synonymous to fork(2)."

       Details of the signal handling are obscure and differ between  systems.
       The  BSD man page states: "To avoid a possible deadlock situation, pro-
       cesses that are children in the middle of  a  vfork()  are  never  sent
       SIGTTOU  or  SIGTTIN  signals; rather, output or ioctls are allowed and
       input attempts result in an end-of-file indication."

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
