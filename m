Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id XAA03929
	for <selinux@tycho.nsa.gov>; Mon, 29 Jul 2002 23:49:15 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id DAA13518
	for <selinux@tycho.nsa.gov>; Tue, 30 Jul 2002 03:47:39 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
        by jazzband.ncsc.mil  with ESMTP id DAA13514 for <selinux@tycho.nsa.gov>; Tue, 30 Jul 2002 03:47:35 GMT
Date: Tue, 30 Jul 2002 13:48:49 +1000
From: Brian May <bam@snoopy.apana.org.au>
To: Stephen Smalley <sds@tislabs.com>
Cc: Russell Coker <russell@coker.com.au>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Fwd: Bug#153238: newrole: should be able to run any command, not just shell
Message-ID: <20020730034849.GA14722@snoopy.apana.org.au>
References: <20020724234927.GC1127@snoopy.apana.org.au> <Pine.GSO.4.33.0207290828350.10600-100000@raven>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.GSO.4.33.0207290828350.10600-100000@raven>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Jul 29, 2002 at 08:34:16AM -0400, Stephen Smalley wrote:
> I'm still not convinced that this is the desired general behavior for
> newrole.  Additionally, notice that you would then need to either label
> this small program with shell_exec_t or add entrypoint permission to
> whatever type you use for this small program.

I am a bit puzzled as to why you think it is OK for newrole to start a
complicated shell, which good have numerous security flaws, but not OK
for it to run a simple program that just calls exec().

I think it would be OK to give it the shell_exec_t, because after it,
it is like a shell, only it doesn't support interactive use.

> If you really want this feature, I'd suggest creating a patch to newrole
> for a '-s' or '--shell' option, like the corresponding su options.  You

Adding the -s or --shell option to newrole would be satisfactory for my
requirements (I am assuming that newrole can only execute shell_exec_t
files here), and I don't think it would have the same problems su does
(as below).

This would mean that the default behaviour can go unchanged, but the
user can use a different shell if desired.

> could then run newrole with your small program specified as the shell (if
> permitted by the policy).

I have never been happy with su, its syntax is clumsy, and makes it hard
to use it scripts. For instance, the user name needs to go between the
command to run and its parameters. It also has a similar problem, it
wont let you run a command except via the shell, and this really makes
passing parameters awkward (you have to quote and then requote them).

For these reasons, I prefer sudo to su when not running an interative
shell.
-- 
Brian May <bam@snoopy.apana.org.au>

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
