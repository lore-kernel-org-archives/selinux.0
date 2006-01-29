Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0TIeCXf025831
	for <selinux@tycho.nsa.gov>; Sun, 29 Jan 2006 13:40:13 -0500 (EST)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0TIe80a005275
	for <selinux@tycho.nsa.gov>; Sun, 29 Jan 2006 18:40:09 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Steve G <linux_4ever@yahoo.com>
Subject: Re: labeling of compilers etc
Date: Mon, 30 Jan 2006 05:39:58 +1100
Cc: SELinux List <selinux@tycho.nsa.gov>
References: <20060129133318.64917.qmail@web51510.mail.yahoo.com>
In-Reply-To: <20060129133318.64917.qmail@web51510.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200601300540.07044.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 30 January 2006 00:33, Steve G <linux_4ever@yahoo.com> wrote:
> >If it's considered worth-while then I'm willing to write a policy patch
> > for the first one and a bash patch for the second one.
>
> A setuid shell script is an extremely bad idea.

My message did not reference setuid shell scripts.

> I think bash refuses to run them.

bash will execute a shell script that is setuid, but no setuid type results 
take place.  To have a setuid script actually give a setuid result you would 
need a setuid shell interpreter that does special stuff.  The perl-suidperl 
package in Fedora has an example of how to do this.  It would be easy to 
write a similar program to allow setuid bash scripts, of course there would 
be the same security issues as setuid perl (which I believe has a bad 
security history).

One thing to note is that domain_auto_trans() rules apply to shell scripts.  
The SE Linux equivalent of setuid shell scripts is quite possible (with all 
the sym-link race conditions that involves - suidperl has special code to fix 
such race conditions that we need in bash to do such things safely).

If we are going to permit a domain_auto_trans($1, $2, $3) with a shell script 
having the type $2 then we could make it a requirement to also have the rule 
domain_trans($1, shell_exec_t, $3) and have this enforced by the shell.

> Is it really necessary to add a SE Linux patch to bash when it 
> already refuses to do this?

If we want to provide the SE Linux specific functionality (which was requested 
by many people and which is conceptually similar to some kernel security 
modules in some of the BSD Unix systems) as described in my previous message 
then we need a patch as described in my previous message.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
