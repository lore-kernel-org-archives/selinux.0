Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3UI9nI4005997
	for <selinux@tycho.nsa.gov>; Wed, 30 Apr 2003 14:09:49 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h3UI9dVf029677
	for <selinux@tycho.nsa.gov>; Wed, 30 Apr 2003 18:09:39 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h3UI9a4D029673
	for <selinux@tycho.nsa.gov>; Wed, 30 Apr 2003 18:09:37 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: SUDO package
Date: Thu, 1 May 2003 04:09:07 +1000
References: <00d801c303f1$9fef2f00$398314d1@windowpane.com> <1051199603.20300.33.camel@moss-huskers.epoch.ncsc.mil> <3EAFEECA.1090107@redhat.com>
In-Reply-To: <3EAFEECA.1090107@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200305010409.07766.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 1 May 2003 01:42, Daniel J Walsh wrote:
> >>I have changed this to
> >>allow sudo_t file_type:dir search
> >>It looks like sudo checks to see if the program exists before it
> >>exec's it.
> >
> >I would prefer that this rule be refined down to a specific list of
> >directory types, or that a new attribute be defined and added to all
> >desired directory types for this purpose.  Again, you want to allow
> >other policy writers to be able to define directory types that cannot be
> >searched by sudo in order to meet their policy goals.
>
> I have a hard time with the previous two.  Just seems to me SELinux
> needs some sort
> of dontallow functionality to handle these situation.  Otherwise every
> time I add a policy
> that has a somewhat global effect on files/dir, I need to change the all
> the file/directory attributes
> in the policy.  Has this been discussed previously?

In this particular case you can always use "sh -c" to run the program in 
question and therefore sudo only needs to be able to execute the shell.

The continual growth of domains and types does require some work to manage.  
But it's been working out OK so far.

> >If you don't relabel the terminal, then another process operating in the
> >old domain (say user_t) can still access the terminal while the program
> >in the new domain (say sysadm_t) is running.  Hence, a malicious user or
> >program can interfere with a more privileged process being run via sudo.
>
> This is a problem since with Sudo you are sharing the same terminal
> between the process that rand sudo
> and the sudo process.  So if you change the privs of the terminal one
> process or the other could have
> more privs.  I would prefer to leave the terminal with the current privs
> (Usually lower) and make the
> application run by sudo change the terminal privs if it has to.
>  (probably seldom).  Any other ideas?

If you have two processes in different security contexts sharing a terminal 
then you are going to have problems.

If you do what newrole does and have exactly one security context with 
permission to write to the terminal then most of the problems disappear.

Incidentally it just occurred to me that we should probably have newrole 
display a message when it exits of the form "ending session of sysadm_r, 
controlling process is now rjc:user_r:user_t" so that the user can recognise 
that it has changed back.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
