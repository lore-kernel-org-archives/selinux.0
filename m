Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4MDVvI4021213
	for <selinux@tycho.nsa.gov>; Thu, 22 May 2003 09:31:59 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h4MDVutV012634
	for <selinux@tycho.nsa.gov>; Thu, 22 May 2003 13:31:56 GMT
Received: from nox.lemuria.org (nox.lemuria.org [213.191.86.30])
        by jazzband.ncsc.mil  with ESMTP id h4MDVsal012631 for <selinux@tycho.nsa.gov>; Thu, 22 May 2003 13:31:55 GMT
Date: Thu, 22 May 2003 15:32:58 +0200
From: Tom <tom@lemuria.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: run_init woes
Message-ID: <20030522153250.A6588@lemuria.org>
References: <20030522112833.A2615@lemuria.org> <1053605415.4729.1349.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1053605415.4729.1349.camel@moss-huskers.epoch.ncsc.mil>; from sds@epoch.ncsc.mil on Thu, May 22, 2003 at 08:10:20AM -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, May 22, 2003 at 08:10:20AM -0400, Stephen Smalley wrote:
> What happens if you do the following (in permissive mode, of course):
> 	runas system_u:system_r:initrc_t /etc/init.d/pxe start

It starts up and runs in the correct domain. (pxe_t)


> Are you using the extension to run_init created by Russell Coker to
> create a separate pty for the daemon, or just the normal run_init
> program?  

I'm using Russells run_init from his current debian packages. I assume
that it comes with his extensions.



> What happens if you use the upstream run_init without his
> modification?   

I've just downloaded and compiled it, and it works fine.

Russell - I've also made a few other experiments, since I was so sure I
had seen this before. rsync (as a daemon) also has the same problem,
but it throws an error message into the logfile:

May 22 15:27:38 setest rsyncd[681]: rsync error: received SIGUSR1 or SIGINT (code 20) at rsync.c(229)


It also works fine with the upstream run_init. Of course, there are
these messages which were the initial cause for the modification:

May 22 15:28:13 setest kernel: avc:  denied  { read write } for  pid=688 exe=/usr/bin/rsync path=/0 dev=00:07 ino=2 scontext=system_u:system_r:rsyncd_t tcontext=root:object_r:user_devpts_t tclass=chr_file


-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
