Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA14752
	for <selinux@tycho.nsa.gov>; Mon, 2 Dec 2002 09:58:42 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA11724
	for <selinux@tycho.nsa.gov>; Mon, 2 Dec 2002 14:56:26 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id OAA11720
	for <selinux@tycho.nsa.gov>; Mon, 2 Dec 2002 14:56:24 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Jesse Pollard <pollard@admin.navo.hpc.mil>, selinux@tycho.nsa.gov
Subject: Re: expect
Date: Mon, 2 Dec 2002 15:58:27 +0100
References: <200211292002.PAA23890@moss-shockers.ncsc.mil> <200212011308.58878.russell@coker.com.au> <200212020809.20563.pollard@admin.navo.hpc.mil>
In-Reply-To: <200212020809.20563.pollard@admin.navo.hpc.mil>
MIME-Version: 1.0
Message-Id: <200212021558.27661.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've had a new idea while writing this message and put it at the top.  If 
someone in .gov/.mil can make sure this gets to Steve I'd appreciate it (his 
server doesn't seem to like my server).

Allowing daemons the tty access could probably be addressed in another way.  
If we had a separate role and domain for starting daemons that could be 
entered with newrole (which then removes the need for run_init as the role 
would not have permission to do anything other than restarting daemons) we 
could then allow all daemons read/write/ioctl access to the terminal for it.  
Then if we deny the daemons read access to /dev (wherever possible) and 
/dev/pts (always) then after you exit the shell that newrole ran (relabelling 
your tty) the daemon won't be able to access your tty or open other ttys.

This would also mean that if you have several daemons to restart (EG an LDAP 
error forces me to restart everything that uses LDAP - POP, mail server, 
nscd, etc) you could just type the commands in instead of having to enter 
your password many times.

I believe that this isn't as good as my solution with expect, and it isn't 
something that can be done in a hurry either.

On Mon, 2 Dec 2002 15:09, Jesse Pollard wrote:
> > I have made my Debian packages depend on the appropriate version of
> > expect so you can just install the packages and be sure that the right
> > things are automatically installed.
>
> IMHO not the best solution, since the existance of "expect" depends
> entirely on local policy. At our site, it is not to be installed without a
> LOT of justification first, and only with policy wavers on an individual
> basis.

Expect is in the main section of Debian.  It's a fully supported program, not 
something that has to be separately installed.

Not using expect requires another solution to the problem of daemons wanting 
to write startup messages to terminals.  The CVS policy has no solution to 
this problem, thus in a default install the administrator is UNABLE to 
restart many popular daemons without rebooting the server!!!

The situation in the CVS might be suitable for your use, but it is not 
suitable for the majority of Debian users.  SE Linux is currently not getting 
significant use in Debian because the ratio of effort to result is not 
percieved as being good enough.  Removing expect significantly increases the 
effort and thus makes the situation worse.

In my judgement the solution I have adopted is the best for my use, my 
clients, and every Debian administrator I know.

If you have a better solution then I'd like to hear of it!

Currently IMHO there are two options, what I have done with expect, and 
allowing all daemons read/write access to the administrator tty.

> Making it mandatory for the system to function would mean that the Debian
> distribution will not be permitted. This isn't a major problem for us, at
> least, since we have standardized on RH.

Which means of course there's no reason for me to change on your account.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
