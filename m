Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i54BWkrT018778
	for <selinux@tycho.nsa.gov>; Fri, 4 Jun 2004 07:32:46 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i54JRE8m025994
	for <selinux@tycho.nsa.gov>; Fri, 4 Jun 2004 15:27:15 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id AD51961C62
	for <selinux@tycho.nsa.gov>; Fri,  4 Jun 2004 21:32:42 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 29100-07 for <selinux@tycho.nsa.gov>;
	Fri, 4 Jun 2004 21:32:42 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 1F5C761BD6
	for <selinux@tycho.nsa.gov>; Fri,  4 Jun 2004 21:32:42 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 9DF55B586F
	for <selinux@tycho.nsa.gov>; Fri,  4 Jun 2004 21:32:40 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: issue with SE/Linux - sshd not giving access to /dev/pts/[n]
Date: Fri, 4 Jun 2004 21:32:40 +1000
References: <20040601090345.GM8312@lkcl.net> <1086266468.17657.19.camel@moss-spartans.epoch.ncsc.mil> <1086268467.17657.53.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1086268467.17657.53.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200406042132.40136.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 3 Jun 2004 23:14, Stephen Smalley <sds@epoch.ncsc.mil> wrote:
> > The implication is that pam_selinux cannot perform tty relabeling for
> > openssh 3.8.  Thus, we must revert to using a direct patch.  Someone
> > want to port the old 3.6 patch?
>
> BTW, note that the patch is very simple; you just want to extend the

It seems to me that pam_selinux is not going to do what we want.

We have to split the module into two parts to get the desired behaviour.  It 
doesn't work with sshd, and some xdm's.  Now it only works with /bin/login 
and one xdm variant (AFAIK).

I think that we are taking the wrong approach to this and we should give up 
and just patch the applications?


Dan, as inventor of the pam_selinux module, what do you think?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
