Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h67HeNHa014447
	for <selinux@tycho.nsa.gov>; Mon, 7 Jul 2003 13:40:24 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h67HeHH5025581
	for <selinux@tycho.nsa.gov>; Mon, 7 Jul 2003 17:40:17 GMT
Received: from monk.verbum.org (monk.debian.net [216.226.142.128])
        by jazzband.ncsc.mil  with ESMTP id h67HeERX025577 for <selinux@tycho.nsa.gov>; Mon, 7 Jul 2003 17:40:16 GMT
Subject: Re: rssh.{te,fc}
From: Colin Walters <walters@verbum.org>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200307072014.38841.russell@coker.com.au>
References: <1057551740.1241.10.camel@columbia>
	 <200307072014.38841.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1057599574.20306.6.camel@columbia>
Mime-Version: 1.0
Date: 07 Jul 2003 13:39:35 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-07-07 at 06:14, Russell Coker wrote:

> The policy itself looks OK, but I'm not sure about the concept.
> 
> Maybe it would be better to have full_user_role(rssh) and then change the 
> sshd.te to have something like the following:
> dnl domain_trans($1, shell_exec_t, unpriv_userdomain)
> domain_trans($1, shell_exec_t, { user_t staff_t })
> domain_trans($1, rssh_exec_t, rssh_t)

That's exactly what I don't want!

> Of course this relies on the rssh program to prevent the user from getting an 
> interactive shell.

Yeah, and I just don't really trust rssh that much; similar programs
like rbash have had a fairly bad security history as I understand it,
although rssh tries to do less than rbash does.

With rssh.te, even if they manage to crack rssh, they can basically only
still manipulate files with type rssh_archive_t; they can't create
network sockets or do other things.

> Another possibility is to implement the functionality of rssh in SE Linux 
> policy alone.  We could have separate macros for the different areas of 
> functionality provided by full_user_role() and make it easy to create a role 
> with a sub-set of that functionality (user.te is a mess anyway and really 
> needs to be sorted out).

That would definitely be useful.  I have some things I want to do before
working on it though.  You know, I'm thinking we need some sort of TODO
list somewhere...


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
