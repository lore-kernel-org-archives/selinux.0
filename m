Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h67AEtHa011962
	for <selinux@tycho.nsa.gov>; Mon, 7 Jul 2003 06:14:55 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h67ADxnJ016665
	for <selinux@tycho.nsa.gov>; Mon, 7 Jul 2003 10:13:59 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h67ADvhr016662
	for <selinux@tycho.nsa.gov>; Mon, 7 Jul 2003 10:13:58 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Colin Walters <walters@verbum.org>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: rssh.{te,fc}
Date: Mon, 7 Jul 2003 20:14:38 +1000
References: <1057551740.1241.10.camel@columbia>
In-Reply-To: <1057551740.1241.10.camel@columbia>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200307072014.38841.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 7 Jul 2003 14:22, Colin Walters wrote:
> I've written a quick rssh.te; this is for the rssh program:
> http://pizzashack.org/rssh/
>
> Basically rssh is a restricted shell that just allows people to execute
> scp.
>
> This is my first from-scratch .te file, so I'd appreciate if people
> could give it a sanity check.  To set this all up, I added another user
> (in this case named haskelluser), then added:
>
> user haskelluser roles { rssh_r };
>
> to /etc/selinux/users.  Make sense?

The policy itself looks OK, but I'm not sure about the concept.

Maybe it would be better to have full_user_role(rssh) and then change the 
sshd.te to have something like the following:
dnl domain_trans($1, shell_exec_t, unpriv_userdomain)
domain_trans($1, shell_exec_t, { user_t staff_t })
domain_trans($1, rssh_exec_t, rssh_t)

Of course this relies on the rssh program to prevent the user from getting an 
interactive shell.

Another possibility is to implement the functionality of rssh in SE Linux 
policy alone.  We could have separate macros for the different areas of 
functionality provided by full_user_role() and make it easy to create a role 
with a sub-set of that functionality (user.te is a mess anyway and really 
needs to be sorted out).

Just some ideas to consider.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
