Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i568FCrT028534
	for <selinux@tycho.nsa.gov>; Sun, 6 Jun 2004 04:15:12 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i568F022007901
	for <selinux@tycho.nsa.gov>; Sun, 6 Jun 2004 04:15:07 -0400 (EDT)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: [patch]
Date: Sun, 6 Jun 2004 18:14:50 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20040605161213.GA5998@lkcl.net>
In-Reply-To: <20040605161213.GA5998@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200406061814.50731.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 6 Jun 2004 02:12, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> patch to exim4 to get it to change its name when it execve's on:
>
> - transport (-MC)
> - smtp in
> - alias (-bi)
> - initial daemon startup

>From a quick inspection it appears that you missed some calls to 
child_exec_exim(), for example the "exim -q" operation when starting exim.

> i don't know if it's possible to create domain auto transitions
> on a symlink, but if it _was_ then the policy files could,
> i imagine, have file_contexts for exim4_mc_exec_t etc just on
> the symlinks.

No, domain_auto_trans() rules only apply to the executables and to script 
files (but generally don't do transitions on scripts).

For SE Linux we need small executables that will exec exim4 with the same 
parameters to give the domain transition.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
