Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA29105
	for <selinux@tycho.nsa.gov>; Wed, 24 Jul 2002 07:31:42 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id LAA09739
	for <selinux@tycho.nsa.gov>; Wed, 24 Jul 2002 11:30:46 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id LAA09735
	for <selinux@tycho.nsa.gov>; Wed, 24 Jul 2002 11:30:45 GMT
Date: Wed, 24 Jul 2002 07:30:45 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Fwd: Bug#153238: newrole: should be able to run any command,
 not just shell
In-Reply-To: <20020723222506.3521A7D72@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0207240718510.13378-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 24 Jul 2002, Russell Coker wrote:

> The following seems like a reasonable request.  I was thinking of having the
> args be interpreted as before, but with a "-c command" before the "--" to
> specify the name of an alternate shell (or other program) which is to be run.
>
> Of course if you try and run a program that's not permitted as an entry-point
> then it won't do much good (which is part of the reason for only allowing the
> shell to be run I guess).
>
> Date: Wed, 17 Jul 2002 11:44:08 +1000
> From: Brian May <bam@snoopy.apana.org.au>
> To: Debian Bug Tracking System <submit@bugs.debian.org>
>
> Package: selinux
> Version: 2002070313-2
> Severity: wishlist
>
> It should be possible to say something like
>
> newrole -r sysadm_r -- su -
>
> Yes, you can do this instead:
>
> newrole -r sysadm_r -- -c su -
>
> but that introduces the complexity of running a new
> shell that isn't even really required.

I'm not sure that this is any different than what 'su' does, except for
the need to prevent interpretation of the -c by newrole via the --.  We
could have newrole recognize the -c and pass it along to the shell, as
with su, but that doesn't really change the processing flow.  You don't
want newrole to directly execute the command, as that would ignore domain
transitions for the command (i.e. newrole explicitly transitions to
bam:sysadm_r:sysadm_t and then a domain transition occurs when the shell
runs su) and it would be denied by the policy (since the su program is not
an entrypoint for the domain).  Not to mention the fact that the command
may not be a program at all, but may be a shell-interpreted command.

I have no objections to a patch that makes newrole recognize -c and pass
it along to the shell, as with su, but newrole will still execute the
shell first (as with su).

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
