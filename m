Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8JL4orT013753
	for <selinux@tycho.nsa.gov>; Sun, 19 Sep 2004 17:04:50 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8JL4mNX011142
	for <selinux@tycho.nsa.gov>; Sun, 19 Sep 2004 21:04:49 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Chris PeBenito <pebenito@gentoo.org>
Subject: Re: [PATCH] Gentoo-specific initrc
Date: Mon, 20 Sep 2004 07:04:46 +1000
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
References: <1095381586.735.30.camel@gorn.pebenito.net> <200409191801.05094.russell@coker.com.au> <1095599331.735.62.camel@gorn.pebenito.net>
In-Reply-To: <1095599331.735.62.camel@gorn.pebenito.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200409200704.46291.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 19 Sep 2004 23:08, Chris PeBenito <pebenito@gentoo.org> wrote:
> > +allow initrc_t etc_runtime_t:dir read;
> >
> > Your patch doesn't include any .fc entries to label a directory as
> > etc_runtime_t.
>
> This is going to appear in my types.fc patch.  The directory I'm
> referring to is not specific to initrc.

What is the purpose of a etc_runtime_t directory?  Currently any process that 
can create files as etc_runtime_t can write to a directory labelled as etc_t.  
Are you planning to change that?

> > +domain_auto_trans(sysadm_t,initrc_exec_t,run_init_t)
> >
> > This isn't something I expected, I'm not sure if it's desirable to do it
> > like that but I can't think of any better way.  Steve, what do you think
> > about this?
>
> Since run_init is integrated into our init script interpreter, there is
> afaik no other way to get into run_init_t since the scripts are run as
> usual (/etc/init.d/foo start).

Yes.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
