Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id TAA05163
	for <selinux@tycho.nsa.gov>; Wed, 24 Jul 2002 19:50:30 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id XAA14637
	for <selinux@tycho.nsa.gov>; Wed, 24 Jul 2002 23:48:57 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
        by jazzband.ncsc.mil  with ESMTP id XAA14633 for <selinux@tycho.nsa.gov>; Wed, 24 Jul 2002 23:48:55 GMT
Date: Thu, 25 Jul 2002 09:49:27 +1000
From: Brian May <bam@snoopy.apana.org.au>
To: Stephen Smalley <sds@tislabs.com>
Cc: Russell Coker <russell@coker.com.au>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Fwd: Bug#153238: newrole: should be able to run any command, not just shell
Message-ID: <20020724234927.GC1127@snoopy.apana.org.au>
References: <20020723222506.3521A7D72@lyta.coker.com.au> <Pine.GSO.4.33.0207240718510.13378-100000@raven>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.GSO.4.33.0207240718510.13378-100000@raven>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Jul 24, 2002 at 07:30:45AM -0400, Stephen Smalley wrote:
> I'm not sure that this is any different than what 'su' does, except for
> the need to prevent interpretation of the -c by newrole via the --.  We
> could have newrole recognize the -c and pass it along to the shell, as
> with su, but that doesn't really change the processing flow.  You don't
> want newrole to directly execute the command, as that would ignore domain
> transitions for the command (i.e. newrole explicitly transitions to
> bam:sysadm_r:sysadm_t and then a domain transition occurs when the shell
> runs su) and it would be denied by the policy (since the su program is not
> an entrypoint for the domain).  Not to mention the fact that the command
> may not be a program at all, but may be a shell-interpreted command.
> 
> I have no objections to a patch that makes newrole recognize -c and pass
> it along to the shell, as with su, but newrole will still execute the
> shell first (as with su).

I take your point about domain transition.

However, forcing you to run commands via the shell, means that arguments
are parsed twice, which could potentially introduce/allow security holes.

[512] [scrooge:bam] ~ >newrole -r sysadm_r -- -c "ls file with spaces in it"
Authenticating bam.
Password: 
ls: file: No such file or directory
ls: with: No such file or directory
ls: spaces: No such file or directory
ls: in: No such file or directory

I suggest another solution, which should fix this problem and
the domain problem.

Create a small program that simply calls execv on its
parameters. Use this small program instead of the shell.

That way you can do

newrole -r sysadm_r -- ls "file with spaces in it"

and it will properly pass the 2nd parameter as just one parameter,
and not try to split it up again.

I think this will mean domain transition will also occur
correctly.

For a simple program that appears to do this:

#include <unistd.h>
#include <stdio.h>

int main (int ARGC, char *ARGV[])
{
	if (ARGC <= 1) {
		fprintf(stderr,"Need program to execute.\n");
		return(255);
	}
	execv(ARGV[1],&ARGV[1]);
	perror("execv failed");
	return(255);
}


[528] [scrooge:bam] ~/tmp >./simple /bin/ls "file with spaces in it"
/bin/ls: file with spaces in it: No such file or directory

Now this works:

>./utils/newrole/newrole -r sysadm_r -- /bin/ls "file with spaces in it"
Authenticating bam.
Password: 
/bin/ls: file with spaces in it: No such file or directory

and domain transition appears to be correct.
-- 
Brian May <bam@snoopy.apana.org.au>

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
