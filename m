Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA28295
	for <selinux@tycho.nsa.gov>; Mon, 29 Jul 2002 08:35:16 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA27437
	for <selinux@tycho.nsa.gov>; Mon, 29 Jul 2002 12:34:27 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id MAA27433
	for <selinux@tycho.nsa.gov>; Mon, 29 Jul 2002 12:34:26 GMT
Date: Mon, 29 Jul 2002 08:34:16 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Brian May <bam@snoopy.apana.org.au>
cc: Russell Coker <russell@coker.com.au>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Fwd: Bug#153238: newrole: should be able to run any command,
 not just shell
In-Reply-To: <20020724234927.GC1127@snoopy.apana.org.au>
Message-ID: <Pine.GSO.4.33.0207290828350.10600-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 25 Jul 2002, Brian May wrote:

> However, forcing you to run commands via the shell, means that arguments
> are parsed twice, which could potentially introduce/allow security holes.
<snip>
> I suggest another solution, which should fix this problem and
> the domain problem.
>
> Create a small program that simply calls execv on its
> parameters. Use this small program instead of the shell.
<snip>

I'm still not convinced that this is the desired general behavior for
newrole.  Additionally, notice that you would then need to either label
this small program with shell_exec_t or add entrypoint permission to
whatever type you use for this small program.

If you really want this feature, I'd suggest creating a patch to newrole
for a '-s' or '--shell' option, like the corresponding su options.  You
could then run newrole with your small program specified as the shell (if
permitted by the policy).

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
